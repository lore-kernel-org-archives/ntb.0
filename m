Return-Path: <anath.amd@gmail.com>
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com. [2607:f8b0:4864:20::544])
        by gmr-mx.google.com with ESMTPS id c13si684pfi.3.2020.02.05.07.55.18
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2020 07:55:18 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id a33so1163007pgm.5
        for <linux-ntb@googlegroups.com>; Wed, 05 Feb 2020 07:55:18 -0800 (PST)
Return-Path: <anath.amd@gmail.com>
Sender: Arindam Nath <anath.amd@gmail.com>
From: Arindam Nath <arindam.nath@amd.com>
Subject: [PATCH 10/15] NTB: move ntb_ctrl handling to init and deinit
Date: Wed,  5 Feb 2020 21:24:27 +0530
Message-Id: <62c2d386903e1ec4a6a1b6a097ec7f5faade72e6.1580914232.git.arindam.nath@amd.com>
In-Reply-To: <cover.1580914232.git.arindam.nath@amd.com>
References: <cover.1580914232.git.arindam.nath@amd.com>
In-Reply-To: <cover.1580914232.git.arindam.nath@amd.com>
References: <cover.1580914232.git.arindam.nath@amd.com>
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Jiasen Lin <linjiasen@hygon.cn>, Sanjay R Mehta <sanju.mehta@amd.com>
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Arindam Nath <arindam.nath@amd.com>
List-ID: <linux-ntb.googlegroups.com>

It does not really make sense to enable or disable
the bits of NTB_CTRL register only during enable
and disable link callbacks. They should be done
independent of these callbacks. The correct placement
for that is during the amd_init_side_info() and
amd_deinit_side_info() functions, which are invoked
during probe and remove respectively.

Signed-off-by: Arindam Nath <arindam.nath@amd.com>
---
 drivers/ntb/hw/amd/ntb_hw_amd.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index a1c4a21c58c3..621a69a0cff2 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -290,7 +290,6 @@ static int amd_ntb_link_enable(struct ntb_dev *ntb,
 {
 	struct amd_ntb_dev *ndev = ntb_ndev(ntb);
 	void __iomem *mmio = ndev->self_mmio;
-	u32 ntb_ctl;
 
 	/* Enable event interrupt */
 	ndev->int_mask &= ~AMD_EVENT_INTMASK;
@@ -300,10 +299,6 @@ static int amd_ntb_link_enable(struct ntb_dev *ntb,
 		return -EINVAL;
 	dev_dbg(&ntb->pdev->dev, "Enabling Link.\n");
 
-	ntb_ctl = readl(mmio + AMD_CNTL_OFFSET);
-	ntb_ctl |= (PMM_REG_CTL | SMM_REG_CTL);
-	writel(ntb_ctl, mmio + AMD_CNTL_OFFSET);
-
 	return 0;
 }
 
@@ -311,7 +306,6 @@ static int amd_ntb_link_disable(struct ntb_dev *ntb)
 {
 	struct amd_ntb_dev *ndev = ntb_ndev(ntb);
 	void __iomem *mmio = ndev->self_mmio;
-	u32 ntb_ctl;
 
 	/* Disable event interrupt */
 	ndev->int_mask |= AMD_EVENT_INTMASK;
@@ -321,10 +315,6 @@ static int amd_ntb_link_disable(struct ntb_dev *ntb)
 		return -EINVAL;
 	dev_dbg(&ntb->pdev->dev, "Enabling Link.\n");
 
-	ntb_ctl = readl(mmio + AMD_CNTL_OFFSET);
-	ntb_ctl &= ~(PMM_REG_CTL | SMM_REG_CTL);
-	writel(ntb_ctl, mmio + AMD_CNTL_OFFSET);
-
 	return 0;
 }
 
@@ -927,18 +917,24 @@ static void amd_init_side_info(struct amd_ntb_dev *ndev)
 {
 	void __iomem *mmio = ndev->self_mmio;
 	unsigned int reg;
+	u32 ntb_ctl;
 
 	reg = readl(mmio + AMD_SIDEINFO_OFFSET);
 	if (!(reg & AMD_SIDE_READY)) {
 		reg |= AMD_SIDE_READY;
 		writel(reg, mmio + AMD_SIDEINFO_OFFSET);
 	}
+
+	ntb_ctl = readl(mmio + AMD_CNTL_OFFSET);
+	ntb_ctl |= (PMM_REG_CTL | SMM_REG_CTL);
+	writel(ntb_ctl, mmio + AMD_CNTL_OFFSET);
 }
 
 static void amd_deinit_side_info(struct amd_ntb_dev *ndev)
 {
 	void __iomem *mmio = ndev->self_mmio;
 	unsigned int reg;
+	u32 ntb_ctl;
 
 	reg = readl(mmio + AMD_SIDEINFO_OFFSET);
 	if (reg & AMD_SIDE_READY) {
@@ -946,6 +942,10 @@ static void amd_deinit_side_info(struct amd_ntb_dev *ndev)
 		writel(reg, mmio + AMD_SIDEINFO_OFFSET);
 		readl(mmio + AMD_SIDEINFO_OFFSET);
 	}
+
+	ntb_ctl = readl(mmio + AMD_CNTL_OFFSET);
+	ntb_ctl &= ~(PMM_REG_CTL | SMM_REG_CTL);
+	writel(ntb_ctl, mmio + AMD_CNTL_OFFSET);
 }
 
 static int amd_init_ntb(struct amd_ntb_dev *ndev)
-- 
2.17.1

