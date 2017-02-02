Return-Path: <Allen.Hubbe@dell.com>
Received: from esa5.dell-outbound.iphmx.com (esa5.dell-outbound.iphmx.com. [68.232.153.95])
        by gmr-mx.google.com with ESMTPS id a202si2454581ywe.2.2017.02.02.10.10.25
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Feb 2017 10:10:25 -0800 (PST)
From: "Allen Hubbe" <Allen.Hubbe@dell.com>
References: <1485985051-29346-1-git-send-email-fancer.lancer@gmail.com>
In-Reply-To: <1485985051-29346-1-git-send-email-fancer.lancer@gmail.com>
Subject: RE: [PATCH] NTB: Add IDT 89HPESxNTx PCIe-switches support
Date: Thu, 2 Feb 2017 13:10:04 -0500
Message-ID: <000001d27d7f$967711b0$c3653510$@dell.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
To: 'Serge Semin' <fancer.lancer@gmail.com>, jdmason@kudzu.us, dave.jiang@intel.com, Xiangliang.Yu@amd.com
Cc: Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

From: Serge Semin
> +static void idt_nt_write(struct idt_ntb_dev *ndev,
> +			 const unsigned int reg, const u32 data)
> +{
> +	/*
> +	 * It's obvious bug to request a register exceeding the maximum possible
> +	 * value as well as to have it unaligned.
> +	 */
> +	BUG_ON(reg > IDT_REG_PCI_MAX || !IS_ALIGNED(reg, IDT_REG_ALIGN));

Avoid BUG_ON.  Just warn and do nothing (at least, do nothing destructive) instead of crashing the system.  Here, and throughout the driver.

> +#define to_dev_ndev(ndev) (&((ndev)->ntb.dev))
> +#define to_pci_ndev(ndev) ((ndev)->ntb.pdev)

See Logan's recent patches in "Style fixes: open code obfuscating macros."

