Return-Path: <Allen.Hubbe@emc.com>
Received: from mailuogwdur.emc.com (mailuogwdur.emc.com. [128.221.224.79])
        by gmr-mx.google.com with ESMTPS id i138si562946ywe.2.2016.01.14.07.57.03
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jan 2016 07:57:04 -0800 (PST)
From: "Allen Hubbe" <Allen.Hubbe@emc.com>
References: <1452771847-16949-1-git-send-email-Xiangliang.Yu@amd.com>
In-Reply-To: <1452771847-16949-1-git-send-email-Xiangliang.Yu@amd.com>
Subject: RE: [PATCH V3 1/2] NTB: Add AMD PCI-Express NTB driver
Date: Thu, 14 Jan 2016 10:56:36 -0500
Message-ID: <000101d14ee4$25f72940$71e57bc0$@emc.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-us
To: 'Xiangliang Yu' <Xiangliang.Yu@amd.com>, jdmason@kudzu.us, dave.jiang@intel.com, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
Cc: SPG_Linux_Kernel@amd.com
List-ID: <linux-ntb.googlegroups.com>

> From: Xiangliang Yu <Xiangliang.Yu@amd.com>
>=20
> AMD NTB support following main features:
> (1) Three memory windows;
> (2) Sixteen 32-bit scratch pad;
> (3) Two 16-bit doorbell interrupt;

This is interesting.  Let's submit your doorbell implementation as is, =
but I wonder if "multiple doorbell registers" is something we should =
expose in the ntb.h api.  I wonder how we should reconcile that with =
"vectors", unless they are equivalent.  If we see a device with more =
than 64 doorbell bits total, the ntb.h api will be inadequate.

> (4) Five event interrupts;
> (5) One system can wake up opposite system of NTB;

You could say: power management support will be added in a following =
patch.

> (6) Flush previous request to the opposite system;

...in a following patch.

> (7) There are reset and PME_TO mechanisms between two systems;

How is this different from (5 or 6)?  What is PME_TO?

>=20
> Signed-off-by: Xiangliang Yu <Xiangliang.Yu@amd.com>


Overall, this driver is looking much better.  Thanks for your efforts!

With the -rc1 window likely closing this weekend, let's see what others =
have to say about this patch v3, or getting a v4 this week.

There are a few minor requests below.  They are nothing critical.

> +static void amd_ack_SMU(struct amd_ntb_dev *ndev, u32 bit)
> +{
> +	void __iomem *mmio =3D ndev->self_mmio;
> +	int reg;
> +
> +	reg =3D readl(mmio + AMD_SMUACK_OFFSET);
> +	reg |=3D bit;
> +	writel(reg, mmio + AMD_SMUACK_OFFSET);
> +
> +	ndev->peer_sta |=3D bit;
> +}

What is SMU?

Does this have to do with power management, or flush?  Can you say why =
it should be in this patch, and not one of the other ones?

Speculation: Is it something like, if the peer driver has the flush =
patch, and this side is not patched, this side driver still needs to =
respond (ack) for the peer flush to complete?  In other words, the flush =
is not fully implemented in hw?  I'm just guessing, so I would like to =
hear your explanation.

> +static void amd_handle_event(struct amd_ntb_dev *ndev, int vec)
> +{
> +	void __iomem *mmio =3D ndev->self_mmio;
> +	u32 status;
> +
> +	status =3D readl(mmio + AMD_INTSTAT_OFFSET);
> +	if (!(status & AMD_EVENT_INTMASK))
> +		return;
> +
> +	dev_dbg(ndev_dev(ndev), "status =3D 0x%x and vec =3D %d\n", status,
> vec);
> +
> +	status &=3D AMD_EVENT_INTMASK;
> +	switch (status) {
> +	case AMD_PEER_FLUSH_EVENT:
> +		dev_info(ndev_dev(ndev), "Flush is done.\n");
> +		break;
> +	case AMD_PEER_RESET_EVENT:
> +		amd_ack_SMU(ndev, AMD_PEER_RESET_EVENT);
> +
> +		/* link down first */
> +		ntb_link_event(&ndev->ntb);
> +		/* polling peer status */
> +		schedule_delayed_work(&ndev->hb_timer, AMD_LINK_HB_TIMEOUT);
> +
> +		break;
> +	case AMD_PEER_D3_EVENT:
> +	case AMD_PEER_PMETO_EVENT:
> +		amd_ack_SMU(ndev, status);

Here is ack SMU called.

> +
> +		/* link down */
> +		ntb_link_event(&ndev->ntb);
> +
> +		break;
> +	case AMD_PEER_D0_EVENT:
> +		mmio =3D ndev->peer_mmio;
> +		status =3D readl(mmio + AMD_PMESTAT_OFFSET);
> +		/* check if this is WAKEUP event */
> +		if (status & 0x1)
> +			dev_info(ndev_dev(ndev), "Wakeup is done.\n");
> +
> +		amd_ack_SMU(ndev, AMD_PEER_D0_EVENT);
> +
> +		if (amd_link_is_up(ndev))
> +			ntb_link_event(&ndev->ntb);
> +		else
> +			schedule_delayed_work(&ndev->hb_timer,
> +						AMD_LINK_HB_TIMEOUT);
> +		break;
> +	default:
> +		dev_info(ndev_dev(ndev), "event status =3D 0x%x.\n", status);
> +		break;
> +	}
> +}

> +enum {

I would prefer to see #define, but this works... There are good =
arguments to be made for compiler constants vs the preprocessor.  My =
preference just comes from what I've observed about how other drivers =
are written, and #define for this stuff seems to be the convention.

> +	/* AMD NTB Capability */
> +	AMD_MW_CNT		=3D 3,
> +	AMD_DB_CNT		=3D 16,
> +	AMD_MSIX_VECTOR_CNT	=3D 24,
> +	AMD_SPADS_CNT		=3D 16,
> +
> +	/*  AMD NTB register offset */
> +	AMD_CNTL_OFFSET		=3D 0x200,
> +
> +	/* NTB control register bits */
> +	PMM_REG_CTL		=3D BIT(21),
> +	SMM_REG_CTL		=3D BIT(20),
> +	SMM_REG_ACC_PATH	=3D BIT(18),
> +	PMM_REG_ACC_PATH	=3D BIT(17),
> +	NTB_CLK_EN		=3D BIT(16),
> +
> +	AMD_STA_OFFSET		=3D 0x204,
> +	AMD_PGSLV_OFFSET	=3D 0x208,
> +	AMD_SPAD_MUX_OFFSET	=3D 0x20C,
> +	AMD_SPAD_OFFSET		=3D 0x210,
> +	AMD_RSMU_HCID		=3D 0x250,
> +	AMD_RSMU_SIID		=3D 0x254,
> +	AMD_PSION_OFFSET	=3D 0x300,
> +	AMD_SSION_OFFSET	=3D 0x330,
> +	AMD_MMINDEX_OFFSET	=3D 0x400,
> +	AMD_MMDATA_OFFSET	=3D 0x404,
> +	AMD_SIDEINFO_OFFSET	=3D 0x408,
> +
> +	AMD_SIDE_MASK		=3D BIT(0),
> +
> +	/* limit register */
> +	AMD_ROMBARLMT_OFFSET	=3D 0x410,
> +	AMD_BAR1LMT_OFFSET	=3D 0x414,
> +	AMD_BAR23LMT_OFFSET	=3D 0x418,
> +	AMD_BAR45LMT_OFFSET	=3D 0x420,
> +	/* xlat address */
> +	AMD_POMBARXLAT_OFFSET	=3D 0x428,
> +	AMD_BAR1XLAT_OFFSET	=3D 0x430,
> +	AMD_BAR23XLAT_OFFSET	=3D 0x438,
> +	AMD_BAR45XLAT_OFFSET	=3D 0x440,
> +	/* doorbell and interrupt */
> +	AMD_DBFM_OFFSET		=3D 0x450,
> +	AMD_DBREQ_OFFSET	=3D 0x454,
> +	AMD_MIRRDBSTAT_OFFSET	=3D 0x458,
> +	AMD_DBMASK_OFFSET	=3D 0x45C,
> +	AMD_DBSTAT_OFFSET	=3D 0x460,
> +	AMD_INTMASK_OFFSET	=3D 0x470,
> +	AMD_INTSTAT_OFFSET	=3D 0x474,
> +
> +	/* event type */
> +	AMD_PEER_FLUSH_EVENT	=3D BIT(0),
> +	AMD_PEER_RESET_EVENT	=3D BIT(1),
> +	AMD_PEER_D3_EVENT	=3D BIT(2),
> +	AMD_PEER_PMETO_EVENT	=3D BIT(3),
> +	AMD_PEER_D0_EVENT	=3D BIT(4),
> +	AMD_EVENT_INTMASK	=3D (AMD_PEER_FLUSH_EVENT |
> +				AMD_PEER_RESET_EVENT | AMD_PEER_D3_EVENT |
> +				AMD_PEER_PMETO_EVENT | AMD_PEER_D0_EVENT),
> +
> +	AMD_PMESTAT_OFFSET	=3D 0x480,
> +	AMD_PMSGTRIG_OFFSET	=3D 0x490,
> +	AMD_LTRLATENCY_OFFSET	=3D 0x494,
> +	AMD_FLUSHTRIG_OFFSET	=3D 0x498,
> +
> +	/* SMU register*/
> +	AMD_SMUACK_OFFSET	=3D 0x4A0,
> +	AMD_SINRST_OFFSET	=3D 0x4A4,
> +	AMD_RSPNUM_OFFSET	=3D 0x4A8,
> +	AMD_SMU_SPADMUTEX	=3D 0x4B0,
> +	AMD_SMU_SPADOFFSET	=3D 0x4B4,
> +
> +	AMD_PEER_OFFSET		=3D 0x400,
> +};

> +struct amd_ntb_dev {
...
> +};
> +
> +#define ndev_pdev(ndev) ((ndev)->ntb.pdev)
> +#define ndev_name(ndev) pci_name(ndev_pdev(ndev))
> +#define ndev_dev(ndev) (&ndev_pdev(ndev)->dev)
> +#define ntb_ndev(__ntb) container_of(__ntb, struct amd_ntb_dev, ntb)
> +#define hb_ndev(__work) container_of(__work, struct amd_ntb_dev,
> hb_timer.work)

Jon: I think these macros are good, and I like that they are here next =
to the struct amd_ntb_dev.

> +static int amd_ntb_mw_count(struct ntb_dev *ntb);
> +static int amd_ntb_mw_get_range(struct ntb_dev *ntb, int idx,
> +			phys_addr_t *base, resource_size_t *size,
> +			resource_size_t *align, resource_size_t *algin_size);
> +static int amd_ntb_mw_set_trans(struct ntb_dev *ndev, int idx,
> +				dma_addr_t addr, resource_size_t size);
> +static int amd_ntb_link_is_up(struct ntb_dev *ntb,
> +				enum ntb_speed *speed,
> +				enum ntb_width *width);
> +static int amd_ntb_link_enable(struct ntb_dev *ntb,
> +				enum ntb_speed speed,
> +				enum ntb_width width);
> +static int amd_ntb_link_disable(struct ntb_dev *ntb);
> +static u64 amd_ntb_db_valid_mask(struct ntb_dev *ntb);
> +static int amd_ntb_db_vector_count(struct ntb_dev *ntb);
> +static u64 amd_ntb_db_vector_mask(struct ntb_dev *ntb, int =
db_vector);
> +static u64 amd_ntb_db_read(struct ntb_dev *ntb);
> +static int amd_ntb_db_clear(struct ntb_dev *ntb, u64 db_bits);
> +static int amd_ntb_db_set_mask(struct ntb_dev *ntb, u64 db_bits);
> +static int amd_ntb_db_clear_mask(struct ntb_dev *ntb, u64 db_bits);
> +static int amd_ntb_peer_db_addr(struct ntb_dev *ntb,
> +				phys_addr_t *db_addr,
> +				resource_size_t *db_size);
> +static int amd_ntb_peer_db_set(struct ntb_dev *ntb, u64 db_bits);
> +static int amd_ntb_spad_count(struct ntb_dev *ntb);
> +static u32 amd_ntb_spad_read(struct ntb_dev *ntb, int idx);
> +static int amd_ntb_spad_write(struct ntb_dev *ntb, int idx, u32 val);
> +static int amd_ntb_peer_spad_addr(struct ntb_dev *ntb, int idx,
> +					phys_addr_t *spad_addr);
> +static u32 amd_ntb_peer_spad_read(struct ntb_dev *ntb, int idx);
> +static int amd_ntb_peer_spad_write(struct ntb_dev *ntb, int idx, u32
> val);

It's unusual, sometimes dangerous, to use the static keyword in a .h =
file (unless static inline, or things that you really intend to be =
static in multiple compilation unit).  This .h is only included by a =
single .c file (effectively, this file is part of ntb_hw_amd.c), and =
these are only declarations, not function definitions, but it makes me =
nervous.  Do you /need/ these functions forward declared?  Could you =
rearrange your .c file so you don't need these forward declared?  If you =
need them, could you put the declarations in the .c file?

Allen

