Return-Path: <Xiangliang.Yu@amd.com>
Received: from na01-by2-obe.outbound.protection.outlook.com (mail-by2on0100.outbound.protection.outlook.com. [207.46.100.100])
        by gmr-mx.google.com with ESMTPS id lr9si835556igb.1.2016.01.18.01.42.57
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Jan 2016 01:42:57 -0800 (PST)
From: "Yu, Xiangliang" <Xiangliang.Yu@amd.com>
Subject: RE: [PATCH V3 1/2] NTB: Add AMD PCI-Express NTB driver
Date: Mon, 18 Jan 2016 09:42:53 +0000
Message-ID: <BLUPR12MB042019902E1A8B022651D7FFEBC00@BLUPR12MB0420.namprd12.prod.outlook.com>
References: <1452771847-16949-1-git-send-email-Xiangliang.Yu@amd.com>
 <20160118040409.GC11303@kudzu.us>
In-Reply-To: <20160118040409.GC11303@kudzu.us>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
To: Jon Mason <jdmason@kudzu.us>
Cc: "dave.jiang@intel.com" <dave.jiang@intel.com>, "Allen.Hubbe@emc.com" <Allen.Hubbe@emc.com>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, SPG_Linux_Kernel <SPG_Linux_Kernel@amd.com>
List-ID: <linux-ntb.googlegroups.com>

> On Thu, Jan 14, 2016 at 07:44:07PM +0800, Xiangliang Yu wrote:
> > AMD NTB support following main features:
> > (1) Three memory windows;
> > (2) Sixteen 32-bit scratch pad;
> > (3) Two 16-bit doorbell interrupt;
> > (4) Five event interrupts;
> > (5) One system can wake up opposite system of NTB;
> > (6) Flush previous request to the opposite system;
> > (7) There are reset and PME_TO mechanisms between two systems;
>=20
> Please create a much more verbose description of the patch.  This is not
> acceptable in it's current form, and I'm sure I could get flamed by Linus=
 if he
> saw it in my pull request.  Even writing this out as a paragaph instead o=
f a
> numbered list would be better.

Ok, I'll change it.

> >
> > Signed-off-by: Xiangliang Yu <Xiangliang.Yu@amd.com>
> > ---
> >  drivers/ntb/hw/Kconfig          |    1 +
> >  drivers/ntb/hw/Makefile         |    1 +
> >  drivers/ntb/hw/amd/Kconfig      |    7 +
> >  drivers/ntb/hw/amd/Makefile     |    1 +
> >  drivers/ntb/hw/amd/ntb_hw_amd.c | 1148
> > +++++++++++++++++++++++++++++++++++++++
> >  drivers/ntb/hw/amd/ntb_hw_amd.h |  246 +++++++++
> >  6 files changed, 1404 insertions(+)
> >  create mode 100644 drivers/ntb/hw/amd/Kconfig  create mode 100644
> > drivers/ntb/hw/amd/Makefile  create mode 100644
> > drivers/ntb/hw/amd/ntb_hw_amd.c  create mode 100644
> > drivers/ntb/hw/amd/ntb_hw_amd.h
> >
> > diff --git a/drivers/ntb/hw/Kconfig b/drivers/ntb/hw/Kconfig index
> > 4d5535c..0c5c2a6 100644
> > --- a/drivers/ntb/hw/Kconfig
> > +++ b/drivers/ntb/hw/Kconfig
> > @@ -1 +1,2 @@
> >  source "drivers/ntb/hw/intel/Kconfig"
> > +source "drivers/ntb/hw/amd/Kconfig"
>=20
> Being nit picky, but please make it alphabetical and put amd before intel=
.

Ok.

> > diff --git a/drivers/ntb/hw/Makefile b/drivers/ntb/hw/Makefile index
> > 175d7c9..636be7d 100644
> > --- a/drivers/ntb/hw/Makefile
> > +++ b/drivers/ntb/hw/Makefile
> > @@ -1 +1,2 @@
> >  obj-$(CONFIG_NTB_INTEL)	+=3D intel/
> > +obj-$(CONFIG_NTB_AMD)	+=3D amd/
>=20
> Same nit, make it alphabetical.

Ok.

> > diff --git a/drivers/ntb/hw/amd/Kconfig b/drivers/ntb/hw/amd/Kconfig
> > new file mode 100644 index 0000000..cfe903c
> > --- /dev/null
> > +++ b/drivers/ntb/hw/amd/Kconfig
> > @@ -0,0 +1,7 @@
> > +config NTB_AMD
> > +	tristate "AMD Non-Transparent Bridge support"
> > +	depends on X86_64
> > +	help
> > +	 This driver supports AMD NTB on capable Zeppelin hardware.
> > +
> > +	 If unsure, say N.
> > diff --git a/drivers/ntb/hw/amd/Makefile b/drivers/ntb/hw/amd/Makefile
> > new file mode 100644 index 0000000..ad54da9
> > --- /dev/null
> > +++ b/drivers/ntb/hw/amd/Makefile
> > @@ -0,0 +1 @@
> > +obj-$(CONFIG_NTB_AMD) +=3D ntb_hw_amd.o
> > diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c
> > b/drivers/ntb/hw/amd/ntb_hw_amd.c new file mode 100644 index
> > 0000000..8df6d7b
> > --- /dev/null
> > +++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
> > @@ -0,0 +1,1148 @@
> > +/*
> > + * This file is provided under a dual BSD/GPLv2 license.  When using o=
r
> > + *   redistributing this file, you may do so under either license.
> > + *
> > + *   GPL LICENSE SUMMARY
> > + *
> > + *   Copyright (C) 2016 Advanced Micro Devices, Inc. All Rights Reserv=
ed.
> > + *
> > + *   This program is free software; you can redistribute it and/or mod=
ify
> > + *   it under the terms of version 2 of the GNU General Public License=
 as
> > + *   published by the Free Software Foundation.
> > + *
> > + *   BSD LICENSE
> > + *
> > + *   Copyright (C) 2016 Advanced Micro Devices, Inc. All Rights Reserv=
ed.
> > + *
> > + *   Redistribution and use in source and binary forms, with or withou=
t
> > + *   modification, are permitted provided that the following condition=
s
> > + *   are met:
> > + *
> > + *     * Redistributions of source code must retain the above copyrigh=
t
> > + *       notice, this list of conditions and the following disclaimer.
> > + *     * Redistributions in binary form must reproduce the above copy
> > + *       notice, this list of conditions and the following disclaimer =
in
> > + *       the documentation and/or other materials provided with the
> > + *       distribution.
> > + *     * Neither the name of AMD Corporation nor the names of its
> > + *       contributors may be used to endorse or promote products deriv=
ed
> > + *       from this software without specific prior written permission.
> > + *
> > + *   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
> CONTRIBUTORS
> > + *   "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT
> NOT
> > + *   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
> FITNESS FOR
> > + *   A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
> COPYRIGHT
> > + *   OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
> INCIDENTAL,
> > + *   SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
> BUT NOT
> > + *   LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
> LOSS OF USE,
> > + *   DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED
> AND ON ANY
> > + *   THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
> TORT
> > + *   (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT
> OF THE USE
> > + *   OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
> DAMAGE.
> > + *
> > + * AMD PCIe NTB Linux driver
> > + *
> > + * Contact Information:
> > + * Xiangliang Yu<Xiangliang.Yu@amd.com>
>=20
> Nit, space needed between 'u' and '<'

Ok

> > + */
> > +
> > +#include <linux/debugfs.h>
> > +#include <linux/delay.h>
> > +#include <linux/init.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/module.h>
> > +#include <linux/acpi.h>
> > +#include <linux/pci.h>
> > +#include <linux/random.h>
> > +#include <linux/slab.h>
> > +#include <linux/ntb.h>
> > +
> > +#include "ntb_hw_amd.h"
> > +
> > +#define NTB_NAME	"ntb_hw_amd"
> > +#define NTB_DESC	"AMD(R) PCI-E Non-Transparent Bridge Driver"
> > +#define NTB_VER		"1.0"
> > +
> > +MODULE_DESCRIPTION(NTB_DESC);
> > +MODULE_VERSION(NTB_VER);
> > +MODULE_LICENSE("Dual BSD/GPL");
> > +MODULE_AUTHOR("AMD Inc.");
> > +
> > +static const struct file_operations amd_ntb_debugfs_info; static
> > +struct dentry *debugfs_dir;
> > +
> > +static const struct ntb_dev_ops amd_ntb_ops =3D {
> > +	.mw_count		=3D amd_ntb_mw_count,
> > +	.mw_get_range		=3D amd_ntb_mw_get_range,
> > +	.mw_set_trans		=3D amd_ntb_mw_set_trans,
> > +	.link_is_up		=3D amd_ntb_link_is_up,
> > +	.link_enable		=3D amd_ntb_link_enable,
> > +	.link_disable		=3D amd_ntb_link_disable,
> > +	.db_valid_mask		=3D amd_ntb_db_valid_mask,
> > +	.db_vector_count	=3D amd_ntb_db_vector_count,
> > +	.db_vector_mask		=3D amd_ntb_db_vector_mask,
> > +	.db_read		=3D amd_ntb_db_read,
> > +	.db_clear		=3D amd_ntb_db_clear,
> > +	.db_set_mask		=3D amd_ntb_db_set_mask,
> > +	.db_clear_mask		=3D amd_ntb_db_clear_mask,
> > +	.peer_db_addr		=3D amd_ntb_peer_db_addr,
> > +	.peer_db_set		=3D amd_ntb_peer_db_set,
> > +	.spad_count		=3D amd_ntb_spad_count,
> > +	.spad_read		=3D amd_ntb_spad_read,
> > +	.spad_write		=3D amd_ntb_spad_write,
> > +	.peer_spad_addr		=3D amd_ntb_peer_spad_addr,
> > +	.peer_spad_read		=3D amd_ntb_peer_spad_read,
> > +	.peer_spad_write	=3D amd_ntb_peer_spad_write,
> > +};
> > +
> > +static int ndev_mw_to_bar(struct amd_ntb_dev *ndev, int idx) {
> > +	if (idx < 0 || idx > ndev->mw_count)
> > +		return -EINVAL;
> > +
> > +	return 1 << idx;
> > +}
> > +
> > +static int amd_ntb_mw_count(struct ntb_dev *ntb) {
> > +	return ntb_ndev(ntb)->mw_count;
> > +}
> > +
> > +static int amd_ntb_mw_get_range(struct ntb_dev *ntb, int idx,
> > +				phys_addr_t *base,
> > +				resource_size_t *size,
> > +				resource_size_t *align,
> > +				resource_size_t *align_size)
> > +{
> > +	struct amd_ntb_dev *ndev =3D ntb_ndev(ntb);
> > +	int bar;
> > +
> > +	bar =3D ndev_mw_to_bar(ndev, idx);
> > +	if (bar < 0)
> > +		return bar;
> > +
> > +	if (base)
> > +		*base =3D pci_resource_start(ndev->ntb.pdev, bar);
> > +
> > +	if (size)
> > +		*size =3D pci_resource_len(ndev->ntb.pdev, bar);
> > +
> > +	if (align)
> > +		*align =3D 4096;
>=20
> Please use SZ_4K from sizes.h

Ok

> > +
> > +	if (align_size)
> > +		*align_size =3D 1;
> > +
> > +	return 0;
> > +}
> > +
> > +static int amd_ntb_mw_set_trans(struct ntb_dev *ntb, int idx,
> > +				dma_addr_t addr, resource_size_t size) {
> > +	struct amd_ntb_dev *ndev =3D ntb_ndev(ntb);
> > +	unsigned long xlat_reg, limit_reg =3D 0;
> > +	resource_size_t mw_size;
> > +	void __iomem *mmio, *peer_mmio;
> > +	u64 base_addr, limit, reg_val;
> > +	int bar;
> > +
> > +	bar =3D ndev_mw_to_bar(ndev, idx);
> > +	if (bar < 0)
> > +		return bar;
> > +
> > +	mw_size =3D pci_resource_len(ndev->ntb.pdev, bar);
> > +
> > +	/* make sure the range fits in the usable mw size */
> > +	if (size > mw_size)
> > +		return -EINVAL;
> > +
> > +	mmio =3D ndev->self_mmio;
> > +	peer_mmio =3D ndev->peer_mmio;
> > +
> > +	base_addr =3D pci_resource_start(ndev->ntb.pdev, bar);
> > +	if (bar =3D=3D 1) {
> > +		xlat_reg =3D AMD_BAR1XLAT_OFFSET;
> > +		limit_reg =3D AMD_BAR1LMT_OFFSET;
> > +	} else {
> > +		xlat_reg =3D AMD_BAR23XLAT_OFFSET + ((bar - 2) << 3);
> > +		limit_reg =3D AMD_BAR23LMT_OFFSET + ((bar - 2) << 3);
> > +	}
> > +
> > +	if (bar !=3D 1) {
> > +		/* Set the limit if supported */
> > +		limit =3D base_addr + size;
> > +
> > +		/* set and verify setting the translation address */
> > +		iowrite64(addr, peer_mmio + xlat_reg);
> > +		reg_val =3D ioread64(peer_mmio + xlat_reg);
> > +		if (reg_val !=3D addr) {
> > +			iowrite64(0, peer_mmio + xlat_reg);
> > +			return -EIO;
> > +		}
> > +
> > +		/* set and verify setting the limit */
> > +		iowrite64(limit, mmio + limit_reg);
> > +		reg_val =3D ioread64(mmio + limit_reg);
> > +		if (reg_val !=3D limit) {
> > +			iowrite64(base_addr, mmio + limit_reg);
> > +			iowrite64(0, peer_mmio + xlat_reg);
> > +			return -EIO;
> > +		}
> > +	} else {
> > +		/* split bar addr range must all be 32 bit */
> > +		if (addr & (~0ull << 32))
> > +			return -EINVAL;
> > +		if ((addr + size) & (~0ull << 32))
> > +			return -EINVAL;
> > +
> > +		/* Set the limit if supported */
> > +		limit =3D base_addr + size;
> > +
> > +		/* set and verify setting the translation address */
> > +		iowrite64(addr, peer_mmio + xlat_reg);
> > +		reg_val =3D ioread64(peer_mmio + xlat_reg);
> > +		if (reg_val !=3D addr) {
> > +			iowrite64(0, peer_mmio + xlat_reg);
> > +			return -EIO;
> > +		}
> > +
> > +		/* set and verify setting the limit */
> > +		writel(limit, mmio + limit_reg);
> > +		reg_val =3D readl(mmio + limit_reg);
> > +		if (reg_val !=3D limit) {
> > +			writel(base_addr, mmio + limit_reg);
> > +			writel(0, peer_mmio + xlat_reg);
> > +			return -EIO;
> > +		}
> > +	}
>=20
> Being nit picky here again, but why is it necessary to make 2 consecutive
> checks for the same 'bar' variable.  Please combine them.

Ok.

> > +
> > +	return 0;
> > +}
> > +
> > +static int amd_link_is_up(struct amd_ntb_dev *ndev) {
> > +	/* set link down and clear flag */
> > +	if (ndev->peer_sta & AMD_PEER_RESET_EVENT) {
> > +		ndev->peer_sta &=3D ~AMD_PEER_RESET_EVENT;
> > +		return 0;
> > +	} else if (ndev->peer_sta & (AMD_PEER_D3_EVENT |
> > +				     AMD_PEER_PMETO_EVENT)) {
> > +		return 0;
> > +	} else if (ndev->peer_sta & AMD_PEER_D0_EVENT) {
> > +		ndev->peer_sta =3D 0;
> > +		return 0;
> > +	} else
> > +		return NTB_LNK_STA_ACTIVE(ndev->cntl_sta);
> > +}
> > +
> > +static int amd_ntb_link_is_up(struct ntb_dev *ntb,
> > +			      enum ntb_speed *speed,
> > +			      enum ntb_width *width)
> > +{
> > +	struct amd_ntb_dev *ndev =3D ntb_ndev(ntb);
> > +	int ret =3D 0;
> > +
> > +	if (amd_link_is_up(ndev)) {
> > +		if (speed)
> > +			*speed =3D NTB_LNK_STA_SPEED(ndev->lnk_sta);
> > +		if (width)
> > +			*width =3D NTB_LNK_STA_WIDTH(ndev->lnk_sta);
> > +
> > +		dev_dbg(ndev_dev(ndev), "link is up.\n");
> > +
> > +		ret =3D 1;
> > +	} else {
> > +		if (speed)
> > +			*speed =3D NTB_SPEED_NONE;
> > +		if (width)
> > +			*width =3D NTB_WIDTH_NONE;
> > +
> > +		dev_dbg(ndev_dev(ndev), "link is down.\n");
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static int amd_ntb_link_enable(struct ntb_dev *ntb,
> > +			       enum ntb_speed max_speed,
> > +			       enum ntb_width max_width)
> > +{
> > +	struct amd_ntb_dev *ndev =3D ntb_ndev(ntb);
> > +	void __iomem *mmio =3D ndev->self_mmio;
> > +	u32 ntb_ctl;
> > +
> > +	/* Enable event interrupt */
> > +	ndev->int_mask &=3D ~AMD_EVENT_INTMASK;
> > +	writel(ndev->int_mask, mmio + AMD_INTMASK_OFFSET);
> > +
> > +	if (ndev->ntb.topo =3D=3D NTB_TOPO_SEC)
> > +		return -EINVAL;
> > +	dev_dbg(ndev_dev(ndev), "Enabling Link.\n");
> > +
> > +	ntb_ctl =3D readl(mmio + AMD_CNTL_OFFSET);
> > +	ntb_ctl |=3D (3 << 20);
>=20
> This "20" is a bit magical to me.  Please use a #define

Yes.=20

> > +	writel(ntb_ctl, mmio + AMD_CNTL_OFFSET);
> > +
> > +	return 0;
> > +}
> > +
> > +static int amd_ntb_link_disable(struct ntb_dev *ntb) {
> > +	struct amd_ntb_dev *ndev =3D ntb_ndev(ntb);
> > +	void __iomem *mmio =3D ndev->self_mmio;
> > +	u32 ntb_ctl;
> > +
> > +	/* Disable event interrupt */
> > +	ndev->int_mask |=3D AMD_EVENT_INTMASK;
> > +	writel(ndev->int_mask, mmio + AMD_INTMASK_OFFSET);
> > +
> > +	if (ndev->ntb.topo =3D=3D NTB_TOPO_SEC)
> > +		return -EINVAL;
> > +	dev_dbg(ndev_dev(ndev), "Enabling Link.\n");
> > +
> > +	ntb_ctl =3D readl(mmio + AMD_CNTL_OFFSET);
> > +	ntb_ctl &=3D ~(3 << 16);
>=20
> Should this be "20" or "16"?  Seems odd that you would use a different of=
fset
> to enable than disable.  Either way, a #define here would be nice too.

Got it.

> > +	writel(ntb_ctl, mmio + AMD_CNTL_OFFSET);
> > +
> > +	return 0;
> > +}
> > +
> > +static u64 amd_ntb_db_valid_mask(struct ntb_dev *ntb) {
> > +	return ntb_ndev(ntb)->db_valid_mask; }
> > +
> > +static int amd_ntb_db_vector_count(struct ntb_dev *ntb) {
> > +	return ntb_ndev(ntb)->db_count;
> > +}
> > +
> > +static u64 amd_ntb_db_vector_mask(struct ntb_dev *ntb, int db_vector)
> > +{
> > +	struct amd_ntb_dev *ndev =3D ntb_ndev(ntb);
> > +
> > +	if (db_vector < 0 || db_vector > ndev->db_count)
> > +		return 0;
> > +
> > +	return ntb_ndev(ntb)->db_valid_mask & (1 << db_vector); }
> > +
> > +static u64 amd_ntb_db_read(struct ntb_dev *ntb) {
> > +	struct amd_ntb_dev *ndev =3D ntb_ndev(ntb);
> > +	void __iomem *mmio =3D ndev->self_mmio;
> > +
> > +	return (u64)readw(mmio + AMD_DBSTAT_OFFSET);
>=20
> Is this cast necessary?

Just following Intel ntb driver, keep consistent in Intel code.

>=20
> > +}
> > +
> > +static int amd_ntb_db_clear(struct ntb_dev *ntb, u64 db_bits) {
> > +	struct amd_ntb_dev *ndev =3D ntb_ndev(ntb);
> > +	void __iomem *mmio =3D ndev->self_mmio;
> > +
> > +	writew((u16)db_bits, mmio + AMD_DBSTAT_OFFSET);
> > +
> > +	return 0;
> > +}
> > +
> > +static int amd_ntb_db_set_mask(struct ntb_dev *ntb, u64 db_bits) {
> > +	struct amd_ntb_dev *ndev =3D ntb_ndev(ntb);
> > +	void __iomem *mmio =3D ndev->self_mmio;
> > +	unsigned long flags;
> > +
> > +	if (db_bits & ~ndev->db_valid_mask)
> > +		return -EINVAL;
> > +
> > +	spin_lock_irqsave(&ndev->db_mask_lock, flags);
> > +	ndev->db_mask |=3D db_bits;
> > +	writew((u16)ndev->db_mask, mmio + AMD_DBMASK_OFFSET);
> > +	spin_unlock_irqrestore(&ndev->db_mask_lock, flags);
> > +
> > +	return 0;
> > +}
> > +
> > +static int amd_ntb_db_clear_mask(struct ntb_dev *ntb, u64 db_bits) {
> > +	struct amd_ntb_dev *ndev =3D ntb_ndev(ntb);
> > +	void __iomem *mmio =3D ndev->self_mmio;
> > +	unsigned long flags;
> > +
> > +	if (db_bits & ~ndev->db_valid_mask)
> > +		return -EINVAL;
> > +
> > +	spin_lock_irqsave(&ndev->db_mask_lock, flags);
> > +	ndev->db_mask &=3D ~db_bits;
> > +	writew((u16)ndev->db_mask, mmio + AMD_DBMASK_OFFSET);
> > +	spin_unlock_irqrestore(&ndev->db_mask_lock, flags);
> > +
> > +	return 0;
> > +}
> > +
> > +static int amd_ntb_peer_db_addr(struct ntb_dev *ntb,
> > +		phys_addr_t *db_addr,
> > +		resource_size_t *db_size)
>=20
> Nit, this doesn't seem like it would be aligned properly.

Got it.

> > +{
> > +	struct amd_ntb_dev *ndev =3D ntb_ndev(ntb);
> > +
> > +	if (db_addr)
> > +		*db_addr =3D (phys_addr_t)(ndev->peer_mmio +
> AMD_DBREQ_OFFSET);
> > +	if (db_size)
> > +		*db_size =3D sizeof(u32);
> > +
> > +	return 0;
> > +}
> > +
> > +static int amd_ntb_peer_db_set(struct ntb_dev *ntb, u64 db_bits) {
> > +	struct amd_ntb_dev *ndev =3D ntb_ndev(ntb);
> > +	void __iomem *mmio =3D ndev->self_mmio;
> > +
> > +	writew((u16)db_bits, mmio + AMD_DBREQ_OFFSET);
> > +
> > +	return 0;
> > +}
> > +
> > +static int amd_ntb_spad_count(struct ntb_dev *ntb) {
> > +	return ntb_ndev(ntb)->spad_count;
> > +}
> > +
> > +static u32 amd_ntb_spad_read(struct ntb_dev *ntb, int idx) {
> > +	struct amd_ntb_dev *ndev =3D ntb_ndev(ntb);
> > +	void __iomem *mmio =3D ndev->self_mmio;
> > +	u32 offset =3D 0;
>=20
> Unnecessary init of this variable

Ok.

> > +
> > +	if (idx < 0 || idx >=3D ndev->spad_count)
> > +		return 0;
> > +
> > +	offset =3D ndev->self_spad + (idx << 2);
> > +	return readl(mmio + AMD_SPAD_OFFSET + offset); }
> > +
> > +static int amd_ntb_spad_write(struct ntb_dev *ntb,
> > +				int idx, u32 val)
> > +{
> > +	struct amd_ntb_dev *ndev =3D ntb_ndev(ntb);
> > +	void __iomem *mmio =3D ndev->self_mmio;
> > +	u32 offset =3D 0;
>=20
> Unnecessary init of this variable

Ok.

> > +
> > +	if (idx < 0 || idx >=3D ndev->spad_count)
> > +		return -EINVAL;
> > +
> > +	offset =3D ndev->self_spad + (idx << 2);
> > +	writel(val, mmio + AMD_SPAD_OFFSET + offset);
> > +
> > +	return 0;
> > +}
> > +
> > +static int amd_ntb_peer_spad_addr(struct ntb_dev *ntb, int idx,
> > +				    phys_addr_t *spad_addr)
> > +{
> > +	struct amd_ntb_dev *ndev =3D ntb_ndev(ntb);
> > +
> > +	if (idx < 0 || idx >=3D ndev->spad_count)
> > +		return -EINVAL;
> > +
> > +	if (spad_addr)
> > +		*spad_addr =3D (phys_addr_t)(ndev->self_mmio +
> AMD_SPAD_OFFSET +
> > +				ndev->peer_spad + (idx << 2));
>=20
> This doesn't seem aligned properly either.

Ok

> > +	return 0;
> > +}
> > +
> > +static u32 amd_ntb_peer_spad_read(struct ntb_dev *ntb, int idx) {
> > +	struct amd_ntb_dev *ndev =3D ntb_ndev(ntb);
> > +	void __iomem *mmio =3D ndev->self_mmio;
> > +	u32 offset;
> > +
> > +	if (idx < 0 || idx >=3D ndev->spad_count)
> > +		return -EINVAL;
> > +
> > +	offset =3D ndev->peer_spad + (idx << 2);
> > +	return readl(mmio + AMD_SPAD_OFFSET + offset); }
> > +
> > +static int amd_ntb_peer_spad_write(struct ntb_dev *ntb,
> > +				     int idx, u32 val)
> > +{
> > +	struct amd_ntb_dev *ndev =3D ntb_ndev(ntb);
> > +	void __iomem *mmio =3D ndev->self_mmio;
> > +	u32 offset;
> > +
> > +	if (idx < 0 || idx >=3D ndev->spad_count)
> > +		return -EINVAL;
> > +
> > +	offset =3D ndev->peer_spad + (idx << 2);
> > +	writel(val, mmio + AMD_SPAD_OFFSET + offset);
> > +
> > +	return 0;
> > +}
> > +
> > +static void amd_ack_SMU(struct amd_ntb_dev *ndev, u32 bit)
>=20
> Nit, Please make this SMU lower case.  Also, it is a bit odd to see SMUAC=
K
> and ack_smu.  It is not a big deal, but since there has to be another ver=
sion to
> address Allen's comments (and mine), then this won't add to much addition=
al
> work to address.

Ok.

> > +{
> > +	void __iomem *mmio =3D ndev->self_mmio;
> > +	int reg;
> > +
> > +	reg =3D readl(mmio + AMD_SMUACK_OFFSET);
> > +	reg |=3D bit;
> > +	writel(reg, mmio + AMD_SMUACK_OFFSET);
> > +
> > +	ndev->peer_sta |=3D bit;
> > +}
> > +
> > +static void amd_handle_event(struct amd_ntb_dev *ndev, int vec) {
> > +	void __iomem *mmio =3D ndev->self_mmio;
> > +	u32 status;
> > +
> > +	status =3D readl(mmio + AMD_INTSTAT_OFFSET);
> > +	if (!(status & AMD_EVENT_INTMASK))
> > +		return;
> > +
> > +	dev_dbg(ndev_dev(ndev), "status =3D 0x%x and vec =3D %d\n", status,
> > +vec);
> > +
> > +	status &=3D AMD_EVENT_INTMASK;
> > +	switch (status) {
> > +	case AMD_PEER_FLUSH_EVENT:
> > +		dev_info(ndev_dev(ndev), "Flush is done.\n");
> > +		break;
> > +	case AMD_PEER_RESET_EVENT:
> > +		amd_ack_SMU(ndev, AMD_PEER_RESET_EVENT);
> > +
> > +		/* link down first */
> > +		ntb_link_event(&ndev->ntb);
> > +		/* polling peer status */
> > +		schedule_delayed_work(&ndev->hb_timer,
> AMD_LINK_HB_TIMEOUT);
> > +
> > +		break;
> > +	case AMD_PEER_D3_EVENT:
> > +	case AMD_PEER_PMETO_EVENT:
> > +		amd_ack_SMU(ndev, status);
> > +
> > +		/* link down */
> > +		ntb_link_event(&ndev->ntb);
> > +
> > +		break;
> > +	case AMD_PEER_D0_EVENT:
> > +		mmio =3D ndev->peer_mmio;
> > +		status =3D readl(mmio + AMD_PMESTAT_OFFSET);
> > +		/* check if this is WAKEUP event */
> > +		if (status & 0x1)
> > +			dev_info(ndev_dev(ndev), "Wakeup is done.\n");
> > +
> > +		amd_ack_SMU(ndev, AMD_PEER_D0_EVENT);
> > +
> > +		if (amd_link_is_up(ndev))
> > +			ntb_link_event(&ndev->ntb);
> > +		else
> > +			schedule_delayed_work(&ndev->hb_timer,
> > +						AMD_LINK_HB_TIMEOUT);
> > +		break;
> > +	default:
> > +		dev_info(ndev_dev(ndev), "event status =3D 0x%x.\n", status);
> > +		break;
> > +	}
> > +}
> > +
> > +static irqreturn_t ndev_interrupt(struct amd_ntb_dev *ndev, int vec)
> > +{
> > +	dev_dbg(ndev_dev(ndev), "vec %d\n", vec);
> > +
> > +	if (vec > (ndev->msix_vec_count - 1)) {
> > +		dev_err(ndev_dev(ndev), "Invalid interrupt.\n");
> > +		return IRQ_HANDLED;
> > +	}
>=20
> Unless this actually happens, you might not want the unnecessary branch i=
n
> your fast path.

Ok, I'll remove it.

> > +
> > +	if (vec > 15 || (ndev->msix_vec_count =3D=3D 1))
> > +		amd_handle_event(ndev, vec);
> > +
> > +	if (vec < 16)
>=20
> I'd prefer to see a #define here for 16

Ok.

>=20
> > +		ntb_db_event(&ndev->ntb, vec);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static irqreturn_t ndev_vec_isr(int irq, void *dev) {
> > +	struct amd_ntb_vec *nvec =3D dev;
> > +
> > +	return ndev_interrupt(nvec->ndev, nvec->num); }
> > +
> > +static irqreturn_t ndev_irq_isr(int irq, void *dev) {
> > +	struct amd_ntb_dev *ndev =3D dev;
> > +
> > +	return ndev_interrupt(ndev, irq - ndev_pdev(ndev)->irq); }
> > +
> > +static int ndev_init_isr(struct amd_ntb_dev *ndev,
> > +				int msix_min, int msix_max)
> > +{
> > +	struct pci_dev *pdev;
> > +	int rc, i, msix_count, node;
> > +
> > +	pdev =3D ndev_pdev(ndev);
> > +
> > +	node =3D dev_to_node(&pdev->dev);
> > +
> > +	ndev->db_mask =3D ndev->db_valid_mask;
> > +
> > +	/* Try to set up msix irq */
> > +	ndev->vec =3D kzalloc_node(msix_max * sizeof(*ndev->vec),
> > +				 GFP_KERNEL, node);
> > +	if (!ndev->vec)
> > +		goto err_msix_vec_alloc;
> > +
> > +	ndev->msix =3D kzalloc_node(msix_max * sizeof(*ndev->msix),
> > +				  GFP_KERNEL, node);
> > +	if (!ndev->msix)
> > +		goto err_msix_alloc;
> > +
> > +	for (i =3D 0; i < msix_max; ++i)
> > +		ndev->msix[i].entry =3D i;
> > +
> > +	msix_count =3D pci_enable_msix_range(pdev, ndev->msix,
> > +					   msix_min, msix_max);
> > +	if (msix_count < 0)
> > +		goto err_msix_enable;
> > +
> > +	/* Disable MSIX if msix count is less than 16 */
>=20
> Why?  Is there a HW errata or limitation (if so, write so in this comment=
)?  If
> not, MSIX has many benefits over legacy interrupts, and it doesn't make
> sense to walk away from that.

Yes, this is hardware limitation, i'll add "hardware limitation" into the c=
omment.

>=20
> > +	if (msix_count < msix_min) {
> > +		pci_disable_msix(pdev);
> > +		goto err_msix_enable;
> > +	}
> > +
> > +	for (i =3D 0; i < msix_count; ++i) {
> > +		ndev->vec[i].ndev =3D ndev;
> > +		ndev->vec[i].num =3D i;
> > +		rc =3D request_irq(ndev->msix[i].vector, ndev_vec_isr, 0,
> > +				 "ndev_vec_isr", &ndev->vec[i]);
> > +		if (rc)
> > +			goto err_msix_request;
> > +	}
> > +
> > +	dev_dbg(ndev_dev(ndev), "Using msix interrupts\n");
> > +	ndev->db_count =3D msix_min;
> > +	ndev->msix_vec_count =3D msix_max;
> > +	return 0;
> > +
> > +err_msix_request:
> > +	while (i-- > 0)
> > +		free_irq(ndev->msix[i].vector, ndev);
> > +	pci_disable_msix(pdev);
> > +err_msix_enable:
> > +	kfree(ndev->msix);
> > +err_msix_alloc:
> > +	kfree(ndev->vec);
> > +err_msix_vec_alloc:
> > +	ndev->msix =3D NULL;
> > +	ndev->vec =3D NULL;
> > +
> > +	/* Try to set up msi irq */
> > +	rc =3D pci_enable_msi(pdev);
> > +	if (rc)
> > +		goto err_msi_enable;
> > +
> > +	rc =3D request_irq(pdev->irq, ndev_irq_isr, 0,
> > +			 "ndev_irq_isr", ndev);
> > +	if (rc)
> > +		goto err_msi_request;
> > +
>=20
> I have problems with the msix/msi/intx selection being done this way, but=
 I
> see it being done in the Intel driver.  So....I'll fix it there first.

Ok, I'll change it according to your patch.

>=20
> > +	dev_dbg(ndev_dev(ndev), "Using msi interrupts\n");
> > +	ndev->db_count =3D 1;
> > +	ndev->msix_vec_count =3D 1;
> > +	return 0;
> > +
> > +err_msi_request:
> > +	pci_disable_msi(pdev);
> > +err_msi_enable:
> > +
> > +	/* Try to set up intx irq */
> > +	pci_intx(pdev, 1);
> > +
> > +	rc =3D request_irq(pdev->irq, ndev_irq_isr, IRQF_SHARED,
> > +			 "ndev_irq_isr", ndev);
> > +	if (rc)
> > +		goto err_intx_request;
> > +
> > +	dev_dbg(ndev_dev(ndev), "Using intx interrupts\n");
> > +	ndev->db_count =3D 1;
> > +	ndev->msix_vec_count =3D 1;
> > +	return 0;
> > +
> > +err_intx_request:
> > +	return rc;
> > +}
> > +
> > +static void ndev_deinit_isr(struct amd_ntb_dev *ndev) {
> > +	struct pci_dev *pdev;
> > +	void __iomem *mmio =3D ndev->self_mmio;
> > +	int i;
> > +
> > +	pdev =3D ndev_pdev(ndev);
> > +
> > +	/* Mask all doorbell interrupts */
> > +	ndev->db_mask =3D ndev->db_valid_mask;
> > +	writel(ndev->db_mask, mmio + AMD_DBMASK_OFFSET);
> > +
> > +	if (ndev->msix) {
> > +		i =3D ndev->msix_vec_count;
> > +		while (i--)
> > +			free_irq(ndev->msix[i].vector, &ndev->vec[i]);
> > +		pci_disable_msix(pdev);
> > +		kfree(ndev->msix);
> > +		kfree(ndev->vec);
> > +	} else {
> > +		free_irq(pdev->irq, ndev);
> > +		if (pci_dev_msi_enabled(pdev))
> > +			pci_disable_msi(pdev);
> > +		else
> > +			pci_intx(pdev, 0);
> > +	}
> > +}
> > +
> > +static ssize_t ndev_debugfs_read(struct file *filp, char __user *ubuf,
> > +				 size_t count, loff_t *offp)
> > +{
> > +	struct amd_ntb_dev *ndev;
> > +	void __iomem *mmio;
> > +	char *buf;
> > +	size_t buf_size;
> > +	ssize_t ret, off;
> > +	union { u64 v64; u32 v32; u16 v16; } u;
> > +
> > +	ndev =3D filp->private_data;
> > +	mmio =3D ndev->self_mmio;
> > +
> > +	buf_size =3D min(count, 0x800ul);
> > +
> > +	buf =3D kmalloc(buf_size, GFP_KERNEL);
> > +	if (!buf)
> > +		return -ENOMEM;
> > +
> > +	off =3D 0;
> > +
> > +	off +=3D scnprintf(buf + off, buf_size - off,
> > +			 "NTB Device Information:\n");
> > +
> > +	off +=3D scnprintf(buf + off, buf_size - off,
> > +			 "Connection Topology -\t%s\n",
> > +			 ntb_topo_string(ndev->ntb.topo));
> > +
> > +	off +=3D scnprintf(buf + off, buf_size - off,
> > +			 "LNK STA -\t\t%#06x\n", ndev->lnk_sta);
> > +
> > +	if (!amd_link_is_up(ndev)) {
> > +		off +=3D scnprintf(buf + off, buf_size - off,
> > +				 "Link Status -\t\tDown\n");
> > +	} else {
> > +		off +=3D scnprintf(buf + off, buf_size - off,
> > +				 "Link Status -\t\tUp\n");
> > +		off +=3D scnprintf(buf + off, buf_size - off,
> > +				 "Link Speed -\t\tPCI-E Gen %u\n",
> > +				 NTB_LNK_STA_SPEED(ndev->lnk_sta));
> > +		off +=3D scnprintf(buf + off, buf_size - off,
> > +				 "Link Width -\t\tx%u\n",
> > +				 NTB_LNK_STA_WIDTH(ndev->lnk_sta));
> > +	}
> > +
> > +	off +=3D scnprintf(buf + off, buf_size - off,
> > +			 "Memory Window Count -\t%u\n", ndev-
> >mw_count);
> > +	off +=3D scnprintf(buf + off, buf_size - off,
> > +			 "Scratchpad Count -\t%u\n", ndev->spad_count);
> > +	off +=3D scnprintf(buf + off, buf_size - off,
> > +			 "Doorbell Count -\t%u\n", ndev->db_count);
> > +	off +=3D scnprintf(buf + off, buf_size - off,
> > +			 "MSIX Vector Count -\t%u\n", ndev-
> >msix_vec_count);
> > +
> > +	off +=3D scnprintf(buf + off, buf_size - off,
> > +			 "Doorbell Valid Mask -\t%#llx\n", ndev-
> >db_valid_mask);
> > +
> > +	u.v32 =3D readl(ndev->self_mmio + AMD_DBMASK_OFFSET);
> > +	off +=3D scnprintf(buf + off, buf_size - off,
> > +			 "Doorbell Mask -\t\t\t%#06x\n", u.v32);
> > +
> > +	u.v32 =3D readl(mmio + AMD_DBSTAT_OFFSET);
> > +	off +=3D scnprintf(buf + off, buf_size - off,
> > +			 "Doorbell Bell -\t\t\t%#06x\n", u.v32);
> > +
> > +	off +=3D scnprintf(buf + off, buf_size - off,
> > +			 "\nNTB Incoming XLAT:\n");
> > +
> > +	u.v64 =3D ioread64(mmio + AMD_BAR1XLAT_OFFSET);
> > +	off +=3D scnprintf(buf + off, buf_size - off,
> > +			 "XLAT1 -\t\t%#018llx\n", u.v64);
> > +
> > +	u.v64 =3D ioread64(ndev->self_mmio + AMD_BAR23XLAT_OFFSET);
> > +	off +=3D scnprintf(buf + off, buf_size - off,
> > +				 "XLAT23 -\t\t%#018llx\n", u.v64);
> > +
> > +	u.v64 =3D ioread64(ndev->self_mmio + AMD_BAR45XLAT_OFFSET);
> > +	off +=3D scnprintf(buf + off, buf_size - off,
> > +				 "XLAT45 -\t\t%#018llx\n", u.v64);
> > +
> > +	u.v32 =3D readl(mmio + AMD_BAR1LMT_OFFSET);
> > +	off +=3D scnprintf(buf + off, buf_size - off,
> > +			 "LMT1 -\t\t\t%#06x\n", u.v32);
> > +
> > +	u.v64 =3D ioread64(ndev->self_mmio + AMD_BAR23LMT_OFFSET);
> > +	off +=3D scnprintf(buf + off, buf_size - off,
> > +				 "LMT23 -\t\t\t%#018llx\n", u.v64);
> > +
> > +	u.v64 =3D ioread64(ndev->self_mmio + AMD_BAR45LMT_OFFSET);
> > +	off +=3D scnprintf(buf + off, buf_size - off,
> > +				 "LMT45 -\t\t\t%#018llx\n", u.v64);
> > +
> > +	ret =3D simple_read_from_buffer(ubuf, count, offp, buf, off);
> > +	kfree(buf);
> > +	return ret;
> > +}
> > +
> > +static void ndev_init_debugfs(struct amd_ntb_dev *ndev) {
> > +	if (!debugfs_dir) {
> > +		ndev->debugfs_dir =3D NULL;
> > +		ndev->debugfs_info =3D NULL;
> > +	} else {
> > +		ndev->debugfs_dir =3D
> > +			debugfs_create_dir(ndev_name(ndev),
> debugfs_dir);
> > +		if (!ndev->debugfs_dir)
> > +			ndev->debugfs_info =3D NULL;
> > +		else
> > +			ndev->debugfs_info =3D
> > +				debugfs_create_file("info", S_IRUSR,
> > +						    ndev->debugfs_dir, ndev,
> > +						    &amd_ntb_debugfs_info);
> > +	}
> > +}
> > +
> > +static void ndev_deinit_debugfs(struct amd_ntb_dev *ndev) {
> > +	debugfs_remove_recursive(ndev->debugfs_dir);
> > +}
> > +
> > +static inline void ndev_init_struct(struct amd_ntb_dev *ndev,
> > +				    struct pci_dev *pdev)
> > +{
> > +	ndev->ntb.pdev =3D pdev;
> > +	ndev->ntb.topo =3D NTB_TOPO_NONE;
> > +	ndev->ntb.ops =3D &amd_ntb_ops;
> > +	ndev->int_mask =3D AMD_EVENT_INTMASK;
> > +	spin_lock_init(&ndev->db_mask_lock);
> > +}
> > +
> > +static int amd_poll_link(struct amd_ntb_dev *ndev) {
> > +	void __iomem *mmio =3D ndev->peer_mmio;
> > +	u32 reg, stat;
> > +	int rc;
> > +
> > +	reg =3D readl(mmio + AMD_SIDEINFO_OFFSET);
> > +	reg &=3D NTB_LIN_STA_ACTIVE_BIT;
> > +
> > +	dev_dbg(ndev_dev(ndev), "%s: reg_val =3D 0x%x.\n", __func__, reg);
> > +
> > +	if (reg =3D=3D ndev->cntl_sta)
> > +		return 0;
> > +
> > +	ndev->cntl_sta =3D reg;
> > +
> > +	rc =3D pci_read_config_dword(ndev->ntb.pdev,
> > +			AMD_LINK_STATUS_OFFSET, &stat);
> > +	if (rc)
> > +		return 0;
> > +	ndev->lnk_sta =3D stat;
> > +
> > +	return 1;
> > +}
> > +
> > +static void amd_link_hb(struct work_struct *work) {
> > +	struct amd_ntb_dev *ndev =3D hb_ndev(work);
> > +
> > +	if (amd_poll_link(ndev))
> > +		ntb_link_event(&ndev->ntb);
> > +
> > +	if (!amd_link_is_up(ndev))
> > +		schedule_delayed_work(&ndev->hb_timer,
> AMD_LINK_HB_TIMEOUT); }
> > +
> > +static int amd_init_isr(struct amd_ntb_dev *ndev) {
> > +	return ndev_init_isr(ndev, AMD_DB_CNT,
> AMD_MSIX_VECTOR_CNT); }
> > +
> > +static void amd_init_side_info(struct amd_ntb_dev *ndev) {
> > +	void __iomem *mmio =3D ndev->self_mmio;
> > +	unsigned int reg =3D 0;
>=20
> variable initialized unnecessarily

Ok.

> > +
> > +	reg =3D readl(mmio + AMD_SIDEINFO_OFFSET);
> > +	if (!(reg & 0x2)) {
> > +		reg |=3D 0x2;
>=20
> I'd like a #define for the "2" above, as you are using it multiple times.

Ok.

>=20
> > +		writel(reg, mmio + AMD_SIDEINFO_OFFSET);
> > +	}
> > +}
> > +
> > +static void amd_deinit_side_info(struct amd_ntb_dev *ndev) {
> > +	void __iomem *mmio =3D ndev->self_mmio;
> > +	unsigned int reg =3D 0;
>=20
> variable initialized unnecessarily

Ok.

> > +
> > +	reg =3D readl(mmio + AMD_SIDEINFO_OFFSET);
> > +	if (reg & 0x2) {
> > +		reg &=3D ~(0x2);
> > +		writel(reg, mmio + AMD_SIDEINFO_OFFSET);
> > +		readl(mmio + AMD_SIDEINFO_OFFSET);
> > +	}
> > +}
> > +
> > +static int amd_init_ntb(struct amd_ntb_dev *ndev) {
> > +	void __iomem *mmio =3D ndev->self_mmio;
> > +
> > +	ndev->mw_count =3D AMD_MW_CNT;
> > +	ndev->spad_count =3D AMD_SPADS_CNT;
> > +	ndev->db_count =3D AMD_DB_CNT;
> > +
> > +	switch (ndev->ntb.topo) {
> > +	case NTB_TOPO_PRI:
> > +	case NTB_TOPO_SEC:
> > +		ndev->spad_count >>=3D 1;
> > +		if (ndev->ntb.topo =3D=3D NTB_TOPO_PRI) {
> > +			ndev->self_spad =3D 0;
> > +			ndev->peer_spad =3D 0x20;
> > +		} else {
> > +			ndev->self_spad =3D 0x20;
> > +			ndev->peer_spad =3D 0;
> > +		}
> > +
> > +		INIT_DELAYED_WORK(&ndev->hb_timer, amd_link_hb);
> > +		schedule_delayed_work(&ndev->hb_timer,
> AMD_LINK_HB_TIMEOUT);
> > +
> > +		break;
> > +	default:
> > +		dev_err(ndev_dev(ndev), "AMD NTB does not support B2B
> mode.\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	ndev->db_valid_mask =3D BIT_ULL(ndev->db_count) - 1;
> > +
> > +	/* Mask event interrupts */
> > +	writel(ndev->int_mask, mmio + AMD_INTMASK_OFFSET);
> > +
> > +	return 0;
> > +}
> > +
> > +static inline enum ntb_topo amd_get_topo(struct amd_ntb_dev *ndev)
>=20
> It is usually better to let the compiler determine what to inline and wha=
t not
> to inline..

Do you mean removing the key word of inline?

> > +{
> > +	void __iomem *mmio =3D ndev->self_mmio;
> > +	u32 info;
> > +
> > +	info =3D readl(mmio + AMD_SIDEINFO_OFFSET);
> > +	if (info & AMD_SIDE_MASK)
> > +		return NTB_TOPO_SEC;
> > +	else
> > +		return NTB_TOPO_PRI;
> > +}
> > +
> > +static int amd_init_dev(struct amd_ntb_dev *ndev) {
> > +	struct pci_dev *pdev;
> > +	int rc =3D 0;
> > +
> > +	pdev =3D ndev_pdev(ndev);
> > +
> > +	ndev->ntb.topo =3D amd_get_topo(ndev);
> > +	dev_dbg(ndev_dev(ndev), "AMD NTB topo is %s\n",
> > +			ntb_topo_string(ndev->ntb.topo));
> > +
> > +	rc =3D amd_init_ntb(ndev);
> > +	if (rc)
> > +		return rc;
> > +
> > +	rc =3D amd_init_isr(ndev);
> > +	if (rc) {
> > +		dev_err(ndev_dev(ndev), "fail to init isr.\n");
> > +		return rc;
> > +	}
> > +
> > +	ndev->db_valid_mask =3D BIT_ULL(ndev->db_count) - 1;
> > +
> > +	return 0;
> > +}
> > +
> > +static void amd_deinit_dev(struct amd_ntb_dev *ndev) {
> > +	cancel_delayed_work_sync(&ndev->hb_timer);
> > +
> > +	ndev_deinit_isr(ndev);
> > +}
> > +
> > +static int amd_ntb_init_pci(struct amd_ntb_dev *ndev,
> > +			    struct pci_dev *pdev)
> > +{
> > +	int rc;
> > +
> > +	pci_set_drvdata(pdev, ndev);
> > +
> > +	rc =3D pci_enable_device(pdev);
> > +	if (rc)
> > +		goto err_pci_enable;
> > +
> > +	rc =3D pci_request_regions(pdev, NTB_NAME);
> > +	if (rc)
> > +		goto err_pci_regions;
> > +
> > +	pci_set_master(pdev);
> > +
> > +	rc =3D pci_set_dma_mask(pdev, DMA_BIT_MASK(64));
> > +	if (rc) {
> > +		rc =3D pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
> > +		if (rc)
> > +			goto err_dma_mask;
> > +		dev_warn(ndev_dev(ndev), "Cannot DMA highmem\n");
> > +	}
> > +
> > +	rc =3D pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64));
> > +	if (rc) {
> > +		rc =3D pci_set_consistent_dma_mask(pdev,
> DMA_BIT_MASK(32));
> > +		if (rc)
> > +			goto err_dma_mask;
> > +		dev_warn(ndev_dev(ndev), "Cannot DMA consistent
> highmem\n");
> > +	}
> > +
> > +	ndev->self_mmio =3D pci_iomap(pdev, 0, 0);
> > +	if (!ndev->self_mmio) {
> > +		rc =3D -EIO;
> > +		goto err_mmio;
> > +	}
> > +	ndev->peer_mmio =3D ndev->self_mmio + AMD_PEER_OFFSET;
> > +
> > +	return 0;
> > +
> > +err_mmio:
>=20
> seems like an unnecessary goto destination here

Will entry the goto destination if pci_iomap failed. The code is following
Intel NTB and I see many drivers in kernel will check the return value=20
of pci_iomap.

>=20
> > +err_dma_mask:
> > +	pci_clear_master(pdev);
> > +err_pci_regions:
> > +	pci_disable_device(pdev);
> > +err_pci_enable:
> > +	pci_set_drvdata(pdev, NULL);
> > +	return rc;
> > +}
> > +
> > +static void amd_ntb_deinit_pci(struct amd_ntb_dev *ndev) {
> > +	struct pci_dev *pdev =3D ndev_pdev(ndev);
> > +
> > +	pci_iounmap(pdev, ndev->self_mmio);
> > +
> > +	pci_clear_master(pdev);
> > +	pci_release_regions(pdev);
> > +	pci_disable_device(pdev);
> > +	pci_set_drvdata(pdev, NULL);
> > +}
> > +
> > +
> > +static int amd_ntb_pci_probe(struct pci_dev *pdev,
> > +			     const struct pci_device_id *id) {
> > +	struct amd_ntb_dev *ndev;
> > +	int rc, node;
> > +
> > +	node =3D dev_to_node(&pdev->dev);
> > +
> > +	ndev =3D kzalloc_node(sizeof(*ndev), GFP_KERNEL, node);
> > +	if (!ndev) {
> > +		rc =3D -ENOMEM;
> > +		goto err_ndev;
> > +	}
> > +
> > +	ndev_init_struct(ndev, pdev);
> > +
> > +	rc =3D amd_ntb_init_pci(ndev, pdev);
> > +	if (rc)
> > +		goto err_init_pci;
> > +
> > +	rc =3D amd_init_dev(ndev);
> > +	if (rc)
> > +		goto err_init_dev;
> > +
> > +	/* write side info */
> > +	amd_init_side_info(ndev);
> > +
> > +	amd_poll_link(ndev);
> > +
> > +	ndev_init_debugfs(ndev);
> > +
> > +	rc =3D ntb_register_device(&ndev->ntb);
> > +	if (rc)
> > +		goto err_register;
> > +
> > +	dev_info(&pdev->dev, "NTB device registered.\n");
> > +
> > +	return 0;
> > +
> > +err_register:
> > +	ndev_deinit_debugfs(ndev);
> > +	amd_deinit_dev(ndev);
> > +err_init_dev:
> > +	amd_ntb_deinit_pci(ndev);
> > +err_init_pci:
> > +	kfree(ndev);
> > +err_ndev:
> > +	return rc;
> > +}
> > +
> > +static void amd_ntb_pci_remove(struct pci_dev *pdev) {
> > +	struct amd_ntb_dev *ndev =3D pci_get_drvdata(pdev);
> > +
> > +	ntb_unregister_device(&ndev->ntb);
> > +	ndev_deinit_debugfs(ndev);
> > +	amd_deinit_side_info(ndev);
> > +	amd_deinit_dev(ndev);
> > +	amd_ntb_deinit_pci(ndev);
> > +	kfree(ndev);
> > +}
> > +
> > +static const struct file_operations amd_ntb_debugfs_info =3D {
> > +	.owner =3D THIS_MODULE,
> > +	.open =3D simple_open,
> > +	.read =3D ndev_debugfs_read,
> > +};
> > +
> > +static const struct pci_device_id amd_ntb_pci_tbl[] =3D {
> > +	{PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_NTB)},
> > +	{0}
> > +};
> > +MODULE_DEVICE_TABLE(pci, amd_ntb_pci_tbl);
> > +
> > +static struct pci_driver amd_ntb_pci_driver =3D {
> > +	.name		=3D KBUILD_MODNAME,
> > +	.id_table	=3D amd_ntb_pci_tbl,
> > +	.probe		=3D amd_ntb_pci_probe,
> > +	.remove		=3D amd_ntb_pci_remove,
> > +};
> > +
> > +static int __init amd_ntb_pci_driver_init(void) {
> > +	pr_info("%s %s\n", NTB_DESC, NTB_VER);
> > +
> > +	if (debugfs_initialized())
> > +		debugfs_dir =3D debugfs_create_dir(KBUILD_MODNAME,
> NULL);
> > +
> > +	return pci_register_driver(&amd_ntb_pci_driver);
> > +}
> > +module_init(amd_ntb_pci_driver_init);
> > +
> > +static void __exit amd_ntb_pci_driver_exit(void) {
> > +	pci_unregister_driver(&amd_ntb_pci_driver);
> > +	debugfs_remove_recursive(debugfs_dir);
> > +}
> > +module_exit(amd_ntb_pci_driver_exit);
> > diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.h
> > b/drivers/ntb/hw/amd/ntb_hw_amd.h new file mode 100644 index
> > 0000000..31021c0
> > --- /dev/null
> > +++ b/drivers/ntb/hw/amd/ntb_hw_amd.h
> > @@ -0,0 +1,246 @@
> > +/*
> > + * This file is provided under a dual BSD/GPLv2 license.  When using o=
r
> > + *   redistributing this file, you may do so under either license.
> > + *
> > + *   GPL LICENSE SUMMARY
> > + *
> > + *   Copyright (C) 2016 Advanced Micro Devices, Inc. All Rights Reserv=
ed.
> > + *
> > + *   This program is free software; you can redistribute it and/or mod=
ify
> > + *   it under the terms of version 2 of the GNU General Public License=
 as
> > + *   published by the Free Software Foundation.
> > + *
> > + *   BSD LICENSE
> > + *
> > + *   Copyright (C) 2016 Advanced Micro Devices, Inc. All Rights Reserv=
ed.
> > + *
> > + *   Redistribution and use in source and binary forms, with or withou=
t
> > + *   modification, are permitted provided that the following condition=
s
> > + *   are met:
> > + *
> > + *     * Redistributions of source code must retain the above copyrigh=
t
> > + *       notice, this list of conditions and the following disclaimer.
> > + *     * Redistributions in binary form must reproduce the above copy
> > + *       notice, this list of conditions and the following disclaimer =
in
> > + *       the documentation and/or other materials provided with the
> > + *       distribution.
> > + *     * Neither the name of AMD Corporation nor the names of its
> > + *       contributors may be used to endorse or promote products deriv=
ed
> > + *       from this software without specific prior written permission.
> > + *
> > + *   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
> CONTRIBUTORS
> > + *   "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT
> NOT
> > + *   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
> FITNESS FOR
> > + *   A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
> COPYRIGHT
> > + *   OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
> INCIDENTAL,
> > + *   SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
> BUT NOT
> > + *   LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
> LOSS OF USE,
> > + *   DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED
> AND ON ANY
> > + *   THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
> TORT
> > + *   (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT
> OF THE USE
> > + *   OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
> DAMAGE.
> > + *
> > + * AMD PCIe NTB Linux driver
> > + *
> > + * Contact Information:
> > + * Xiangliang Yu<Xiangliang.Yu@amd.com>
>=20
> Same comment as above about the space needed here.

Ok

> > + */
> > +
> > +#ifndef NTB_HW_AMD_H
> > +#define NTB_HW_AMD_H
> > +
> > +#include <linux/ntb.h>
> > +#include <linux/pci.h>
> > +
> > +#define PCI_DEVICE_ID_AMD_NTB	0x145B
> > +#define AMD_LINK_HB_TIMEOUT	msecs_to_jiffies(1000)
>=20
> Tab align the second half of these

I'll check it.

>=20
> > +#define AMD_LINK_STATUS_OFFSET	0x68
> > +#define NTB_LIN_STA_ACTIVE_BIT	0x00000002
> > +#define NTB_LNK_STA_SPEED_MASK	0x000F0000
> > +#define NTB_LNK_STA_WIDTH_MASK	0x03F00000
> > +#define NTB_LNK_STA_ACTIVE(x)	(!!((x) & NTB_LIN_STA_ACTIVE_BIT))
> > +#define NTB_LNK_STA_SPEED(x)	(((x) &
> NTB_LNK_STA_SPEED_MASK) >> 16)
> > +#define NTB_LNK_STA_WIDTH(x)	(((x) &
> NTB_LNK_STA_WIDTH_MASK) >> 20)
> > +
> > +#ifndef ioread64
> > +#ifdef readq
> > +#define ioread64 readq
> > +#else
> > +#define ioread64 _ioread64
> > +static inline u64 _ioread64(void __iomem *mmio) {
> > +	u64 low, high;
> > +
> > +	low =3D ioread32(mmio);
> > +	high =3D ioread32(mmio + sizeof(u32));
> > +	return low | (high << 32);
> > +}
> > +#endif
> > +#endif
> > +
> > +#ifndef iowrite64
> > +#ifdef writeq
> > +#define iowrite64 writeq
> > +#else
> > +#define iowrite64 _iowrite64
> > +static inline void _iowrite64(u64 val, void __iomem *mmio) {
> > +	iowrite32(val, mmio);
> > +	iowrite32(val >> 32, mmio + sizeof(u32)); } #endif #endif
> > +
> > +enum {
> > +	/* AMD NTB Capability */
> > +	AMD_MW_CNT		=3D 3,
> > +	AMD_DB_CNT		=3D 16,
> > +	AMD_MSIX_VECTOR_CNT	=3D 24,
> > +	AMD_SPADS_CNT		=3D 16,
> > +
> > +	/*  AMD NTB register offset */
> > +	AMD_CNTL_OFFSET		=3D 0x200,
> > +
> > +	/* NTB control register bits */
> > +	PMM_REG_CTL		=3D BIT(21),
> > +	SMM_REG_CTL		=3D BIT(20),
> > +	SMM_REG_ACC_PATH	=3D BIT(18),
> > +	PMM_REG_ACC_PATH	=3D BIT(17),
> > +	NTB_CLK_EN		=3D BIT(16),
> > +
> > +	AMD_STA_OFFSET		=3D 0x204,
> > +	AMD_PGSLV_OFFSET	=3D 0x208,
> > +	AMD_SPAD_MUX_OFFSET	=3D 0x20C,
> > +	AMD_SPAD_OFFSET		=3D 0x210,
> > +	AMD_RSMU_HCID		=3D 0x250,
> > +	AMD_RSMU_SIID		=3D 0x254,
> > +	AMD_PSION_OFFSET	=3D 0x300,
> > +	AMD_SSION_OFFSET	=3D 0x330,
> > +	AMD_MMINDEX_OFFSET	=3D 0x400,
> > +	AMD_MMDATA_OFFSET	=3D 0x404,
> > +	AMD_SIDEINFO_OFFSET	=3D 0x408,
> > +
> > +	AMD_SIDE_MASK		=3D BIT(0),
> > +
> > +	/* limit register */
> > +	AMD_ROMBARLMT_OFFSET	=3D 0x410,
> > +	AMD_BAR1LMT_OFFSET	=3D 0x414,
> > +	AMD_BAR23LMT_OFFSET	=3D 0x418,
> > +	AMD_BAR45LMT_OFFSET	=3D 0x420,
> > +	/* xlat address */
> > +	AMD_POMBARXLAT_OFFSET	=3D 0x428,
> > +	AMD_BAR1XLAT_OFFSET	=3D 0x430,
> > +	AMD_BAR23XLAT_OFFSET	=3D 0x438,
> > +	AMD_BAR45XLAT_OFFSET	=3D 0x440,
> > +	/* doorbell and interrupt */
> > +	AMD_DBFM_OFFSET		=3D 0x450,
> > +	AMD_DBREQ_OFFSET	=3D 0x454,
> > +	AMD_MIRRDBSTAT_OFFSET	=3D 0x458,
> > +	AMD_DBMASK_OFFSET	=3D 0x45C,
> > +	AMD_DBSTAT_OFFSET	=3D 0x460,
> > +	AMD_INTMASK_OFFSET	=3D 0x470,
> > +	AMD_INTSTAT_OFFSET	=3D 0x474,
> > +
> > +	/* event type */
> > +	AMD_PEER_FLUSH_EVENT	=3D BIT(0),
> > +	AMD_PEER_RESET_EVENT	=3D BIT(1),
> > +	AMD_PEER_D3_EVENT	=3D BIT(2),
> > +	AMD_PEER_PMETO_EVENT	=3D BIT(3),
> > +	AMD_PEER_D0_EVENT	=3D BIT(4),
> > +	AMD_EVENT_INTMASK	=3D (AMD_PEER_FLUSH_EVENT |
> > +				AMD_PEER_RESET_EVENT |
> AMD_PEER_D3_EVENT |
> > +				AMD_PEER_PMETO_EVENT |
> AMD_PEER_D0_EVENT),
> > +
> > +	AMD_PMESTAT_OFFSET	=3D 0x480,
> > +	AMD_PMSGTRIG_OFFSET	=3D 0x490,
> > +	AMD_LTRLATENCY_OFFSET	=3D 0x494,
> > +	AMD_FLUSHTRIG_OFFSET	=3D 0x498,
> > +
> > +	/* SMU register*/
> > +	AMD_SMUACK_OFFSET	=3D 0x4A0,
> > +	AMD_SINRST_OFFSET	=3D 0x4A4,
> > +	AMD_RSPNUM_OFFSET	=3D 0x4A8,
> > +	AMD_SMU_SPADMUTEX	=3D 0x4B0,
> > +	AMD_SMU_SPADOFFSET	=3D 0x4B4,
> > +
> > +	AMD_PEER_OFFSET		=3D 0x400,
> > +};
>=20
> It seems extremely odd to mix and match different kinds of things in the
> same enumerated type.  I'd prefer to have these as #defines or separated
> enum types.

The code following AHCI.h style, it put field definition of register close =
to register
Marco definition seems appropriate to me. Actually, I have seen lot of the =
style in kernel.

> > +
> > +struct amd_ntb_dev;
> > +
> > +struct amd_ntb_vec {
> > +	struct amd_ntb_dev	*ndev;
> > +	int			num;
> > +};
> > +
> > +struct amd_ntb_dev {
> > +	struct ntb_dev ntb;
> > +
> > +	u32 ntb_side;
> > +	u32 lnk_sta;
> > +	u32 cntl_sta;
> > +	u32 peer_sta;
> > +
> > +	unsigned char mw_count;
> > +	unsigned char spad_count;
> > +	unsigned char db_count;
> > +	unsigned char msix_vec_count;
> > +
> > +	u64 db_valid_mask;
> > +	u64 db_mask;
> > +	u32 int_mask;
> > +
> > +	struct msix_entry *msix;
> > +	struct amd_ntb_vec *vec;
> > +
> > +	spinlock_t db_mask_lock;
> > +
> > +	void __iomem *self_mmio;
> > +	void __iomem *peer_mmio;
> > +	unsigned int self_spad;
> > +	unsigned int peer_spad;
> > +
> > +	struct delayed_work hb_timer;
> > +
> > +	struct dentry *debugfs_dir;
> > +	struct dentry *debugfs_info;
> > +};
> > +
> > +#define ndev_pdev(ndev) ((ndev)->ntb.pdev) #define ndev_name(ndev)
> > +pci_name(ndev_pdev(ndev)) #define ndev_dev(ndev)
> > +(&ndev_pdev(ndev)->dev) #define ntb_ndev(__ntb)
> container_of(__ntb,
> > +struct amd_ntb_dev, ntb) #define hb_ndev(__work)
> container_of(__work,
> > +struct amd_ntb_dev, hb_timer.work)
> > +
>=20
> This should probably be moved into the device driver C file (as they are =
not
> called anywhere else).

I just following intel ntb driver, I'll also change it if you change intel =
driver.

>=20
> > +static int amd_ntb_mw_count(struct ntb_dev *ntb); static int
> > +amd_ntb_mw_get_range(struct ntb_dev *ntb, int idx,
> > +			phys_addr_t *base, resource_size_t *size,
> > +			resource_size_t *align, resource_size_t *algin_size);
> static int
> > +amd_ntb_mw_set_trans(struct ntb_dev *ndev, int idx,
> > +				dma_addr_t addr, resource_size_t size);
> static int
> > +amd_ntb_link_is_up(struct ntb_dev *ntb,
> > +				enum ntb_speed *speed,
> > +				enum ntb_width *width);
> > +static int amd_ntb_link_enable(struct ntb_dev *ntb,
> > +				enum ntb_speed speed,
> > +				enum ntb_width width);
> > +static int amd_ntb_link_disable(struct ntb_dev *ntb); static u64
> > +amd_ntb_db_valid_mask(struct ntb_dev *ntb); static int
> > +amd_ntb_db_vector_count(struct ntb_dev *ntb); static u64
> > +amd_ntb_db_vector_mask(struct ntb_dev *ntb, int db_vector); static
> > +u64 amd_ntb_db_read(struct ntb_dev *ntb); static int
> > +amd_ntb_db_clear(struct ntb_dev *ntb, u64 db_bits); static int
> > +amd_ntb_db_set_mask(struct ntb_dev *ntb, u64 db_bits); static int
> > +amd_ntb_db_clear_mask(struct ntb_dev *ntb, u64 db_bits); static int
> > +amd_ntb_peer_db_addr(struct ntb_dev *ntb,
> > +				phys_addr_t *db_addr,
> > +				resource_size_t *db_size);
> > +static int amd_ntb_peer_db_set(struct ntb_dev *ntb, u64 db_bits);
> > +static int amd_ntb_spad_count(struct ntb_dev *ntb); static u32
> > +amd_ntb_spad_read(struct ntb_dev *ntb, int idx); static int
> > +amd_ntb_spad_write(struct ntb_dev *ntb, int idx, u32 val); static int
> > +amd_ntb_peer_spad_addr(struct ntb_dev *ntb, int idx,
> > +					phys_addr_t *spad_addr);
> > +static u32 amd_ntb_peer_spad_read(struct ntb_dev *ntb, int idx);
> > +static int amd_ntb_peer_spad_write(struct ntb_dev *ntb, int idx, u32
> > +val);
>=20
> I believe all of these function declarations should be removed.
Ok.

And please see my comments, I'll submit v4 patch immediately when getting y=
our feedback.

