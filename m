Return-Path: <Allen.Hubbe@dell.com>
Received: from esa8.dell-outbound.iphmx.com (esa8.dell-outbound.iphmx.com. [68.232.149.218])
        by gmr-mx.google.com with ESMTPS id r6si826343ywb.6.2017.02.21.14.43.10
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Feb 2017 14:43:11 -0800 (PST)
From: "Allen Hubbe" <Allen.Hubbe@dell.com>
References: <1485985051-29346-1-git-send-email-fancer.lancer@gmail.com> <1487626394-16469-1-git-send-email-fancer.lancer@gmail.com>
In-Reply-To: <1487626394-16469-1-git-send-email-fancer.lancer@gmail.com>
Subject: RE: [PATCH v2] NTB: Add IDT 89HPESxNTx PCIe-switches support
Date: Tue, 21 Feb 2017 17:42:37 -0500
Message-ID: <000001d28c93$cea16310$6be42930$@dell.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
To: 'Serge Semin' <fancer.lancer@gmail.com>, jdmason@kudzu.us, dave.jiang@intel.com, Xiangliang.Yu@amd.com
Cc: Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

From: Serge Semin
> +/*
> + * idt_nt_write() - PCI configuration space registers write method
> + * @ndev:	IDT NTB hardware driver descriptor
> + * @reg:	Register to write data to
> + * @data:	Value to write to the register
> + *
> + * WARNING! IDT PCIe-switch registers are all Little endian. So corresponding
> + *	    writel operations must have embedded endiannes conversion. If local
> + *	    platform doesn't have it, the driver won't properly work.
> + */
> +static void idt_nt_write(struct idt_ntb_dev *ndev,
> +			 const unsigned int reg, const u32 data)
> +{
> +	/*
> +	 * It's obvious bug to request a register exceeding the maximum possible
> +	 * value as well as to have it unaligned.
> +	 */
> +	WARN_ON(reg > IDT_REG_PCI_MAX || !IS_ALIGNED(reg, IDT_REG_ALIGN));

If we perform the write anyway, I guess the effect of the write is unknown?

What about:
if (WARN_ON(stuff))
	return;


> +/*
> + * idt_reg_set_bits() - set bits of a passed register
> + * @ndev:	IDT NTB hardware driver descriptor
> + * @reg:	Register to change bits of
> + * @valid_mask:	Mask of valid bits
> + * @set_bits:	Bitmask to set
> + *
> + * Helper method to check whether a passed bitfield is valid and set
> + * corresponding bits of a register.
> + *
> + * Return: zero on success, negative error on invalid bitmask.
> + */
> +static inline int idt_reg_set_bits(struct idt_ntb_dev *ndev, unsigned int reg,
> +				   u64 valid_mask, u64 set_bits)
> +{
> +	u32 data;
> +
> +	if (set_bits & ~(u64)valid_mask)
> +		return -EINVAL;
> +
> +	data = idt_nt_read(ndev, reg) | (u32)set_bits;
> +	idt_nt_write(ndev, IDT_NT_INDBELLMSK, data);

Following this function call via itd_ntb_db_set_mask(), it does not appear that the register update is atomic here.  Two threads could read the same old register value and modify it differently, and the second write back to the register would clobber the first.

In the ntb_hw_intel driver there is a similar setting bits of the doorbell mask, and clearing bits.  Instead of reading the register, modifying it, and writing it back, the current value of the register is stored in memory.  With a spin lock held, the value is updated in memory and then written to the register.  That makes the update atomic, because the spin lock is held through the update and issuing the write, and it saves a trip to read the register.


> +/*
> + * idt_get_mw_type() - get memory window size

Doc doesn't match the function name.

> + * @mw_type:	Memory window type
> + *
> + * Return: number of memory windows corresponding to the type

This is more like a "count" than a "size".

> + */
> +static inline unsigned char idt_get_mw_size(enum idt_mw_type mw_type)
> +{


> +/*
> + * idt_ntb_db_set_mask() - set bits in the local doorbell mask
> + *			   (NTB API callback)
> + * @ntb:	NTB device context.
> + * @db_bits:	Doorbell mask bits to set.
> + *
> + * The inbound doorbell register mask value must be read, then OR'ed with
> + * passed field and only then set back.
> + *
> + * Return: zero on success, negative error if invalid argument passed.
> + */
> +static int idt_ntb_db_set_mask(struct ntb_dev *ntb, u64 db_bits)
> +{
> +	struct idt_ntb_dev *ndev = to_ndev_ntb(ntb);
> +
> +	return idt_reg_set_bits(ndev, IDT_NT_INDBELLMSK, IDT_DBELL_MASK,
> +				db_bits);

As noted above, this does not appear to be atomic.

