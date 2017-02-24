Return-Path: <Allen.Hubbe@dell.com>
Received: from esa1.dell-outbound.iphmx.com (esa1.dell-outbound.iphmx.com. [68.232.153.90])
        by gmr-mx.google.com with ESMTPS id y63si849354ywe.5.2017.02.24.08.01.21
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Feb 2017 08:01:21 -0800 (PST)
From: "Allen Hubbe" <Allen.Hubbe@dell.com>
References: <1487626394-16469-1-git-send-email-fancer.lancer@gmail.com> <1487933348-32403-1-git-send-email-fancer.lancer@gmail.com>
In-Reply-To: <1487933348-32403-1-git-send-email-fancer.lancer@gmail.com>
Subject: RE: [PATCH v3] NTB: Add IDT 89HPESxNTx PCIe-switches support
Date: Fri, 24 Feb 2017 11:01:00 -0500
Message-ID: <000001d28eb7$3307bc30$99173490$@dell.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
To: 'Serge Semin' <fancer.lancer@gmail.com>, jdmason@kudzu.us, dave.jiang@intel.com, Xiangliang.Yu@amd.com
Cc: Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

From: Serge Semin 
> IDT 89HPESxNTx device series is PCIe-switches, which support
...
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

Acked-by: Allen Hubbe <Allen.Hubbe@dell.com>

With minor comments.  Please include my Ack if you send v4.


> +static u32 idt_nt_read(struct idt_ntb_dev *ndev, const unsigned int reg)
> +{
> +	/*
> +	 * It's obvious bug to request a register exceeding the maximum possible
> +	 * value as well as to have it unaligned.
> +	 */
> +	WARN_ON(reg > IDT_REG_PCI_MAX || !IS_ALIGNED(reg, IDT_REG_ALIGN));

if (WARN) return ~0?


> +/*
> + * idt_sw_write() - Global registers read method

Doc does not match fn:

> +static u32 idt_sw_read(struct idt_ntb_dev *ndev, const unsigned int reg)
> +{
> +	unsigned long irqflags;
> +	u32 data;
> +
> +	/*
> +	 * It's obvious bug to request a register exceeding the maximum possible
> +	 * value as well as to have it unaligned.
> +	 */
> +	WARN_ON(reg > IDT_REG_SW_MAX || !IS_ALIGNED(reg, IDT_REG_ALIGN));

if (WARN) return ~0?

> +
> +	/* Lock GASA registers operations */
> +	spin_lock_irqsave(&ndev->gasa_lock, irqflags);
> +	/* Set the global register address */
> +	writel((u32)reg, ndev->cfgspc + (ptrdiff_t)IDT_NT_GASAADDR);

I wonder how that HW will behave if we instruct it to do the general-purpose read out-of-bounds.  Better not.

> +	/* Get the data of the register */
> +	data = readl(ndev->cfgspc + (ptrdiff_t)IDT_NT_GASADATA);
> +	/* Unlock GASA registers operations */
> +	spin_unlock_irqrestore(&ndev->gasa_lock, irqflags);
> +
> +	return data;
> +}


> +static inline int idt_reg_clear_bits(struct idt_ntb_dev *ndev,
> +				     unsigned int reg, spinlock_t *reg_lock,
> +				     u64 valid_mask, u64 clear_bits)
> +{
> +	unsigned long irqflags;
> +	u32 data;
> +
> +	if (clear_bits & ~(u64)valid_mask)
> +		return -EINVAL;

This check also exists in the Intel driver (blame me).

I've wondered: what if we just pretend any non-valid bits are always "cleared."  If they are cleared again, just silently allow it (they stay cleared).  Only have this check against attempting to "set" invalid bits.

In Logan's ntb self-test with ntb_tool, it is convenient at the start of the test to "clear all the bits" of the doorbell registers.  This would be more simple if the script would just say "clear the bits ~0" instead of "tell me the valid bits and clear those."  Currently ntb_tool doesn't report the valid bits, so the valid bitset is a runtime parameter passed to the script (yuck).

Set the bits: are they valid?  ok.
Clear the bits: ok!


> +	/* It's useless to have this driver loaded if there is no any peer */
> +	if (ndev->peer_cnt == 0) {
> +		dev_err_pci(ndev, "No active peer found\n");
> +		return -EINVAL;
> +	}

Maybe it would be useful for development or debugging purposes?


> +static bool idt_ntb_local_link_is_up(struct idt_ntb_dev *ndev)
> +{
...
> +	if (!(data & IDT_NTMTBLDATA_VALID))
> +		return false;
> +
> +	/* Local NTB link is enabled if got here */
> +	return true;

Unnecessary branching logic.  Just:

return !!(data & IDT_NTMTBLDATA_VALID);

> +static bool idt_ntb_peer_link_is_up(struct idt_ntb_dev *ndev, int pidx)
> +{
...
> +	if (!(data & IDT_NTMTBLDATA_VALID))
> +		return false;
> +
> +	/* Peer NTB link is enabled if got here */
> +	return true;

return !!(data & IDT_NTMTBLDATA_VALID);


