Return-Path: <anath.amd@gmail.com>
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com. [2607:f8b0:4864:20::542])
        by gmr-mx.google.com with ESMTPS id h4si10766ilf.3.2020.02.05.07.55.21
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2020 07:55:21 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id g3so1149929pgs.11
        for <linux-ntb@googlegroups.com>; Wed, 05 Feb 2020 07:55:21 -0800 (PST)
Return-Path: <anath.amd@gmail.com>
Sender: Arindam Nath <anath.amd@gmail.com>
From: Arindam Nath <arindam.nath@amd.com>
Subject: [PATCH 11/15] NTB: add helper functions to set and clear sideinfo
Date: Wed,  5 Feb 2020 21:24:28 +0530
Message-Id: <08593511a6c9c4a4ce937e2c92c08638c051c70f.1580914232.git.arindam.nath@amd.com>
In-Reply-To: <cover.1580914232.git.arindam.nath@amd.com>
References: <cover.1580914232.git.arindam.nath@amd.com>
In-Reply-To: <cover.1580914232.git.arindam.nath@amd.com>
References: <cover.1580914232.git.arindam.nath@amd.com>
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Jiasen Lin <linjiasen@hygon.cn>, Sanjay R Mehta <sanju.mehta@amd.com>
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Arindam Nath <arindam.nath@amd.com>
List-ID: <linux-ntb.googlegroups.com>

We define two new helper functions to set and clear
sideinfo registers respectively. These functions
take an additional boolean parameter which signifies
whether we want to set/clear the sideinfo register
of the peer(true) or local host(false).

Signed-off-by: Arindam Nath <arindam.nath@amd.com>
---
 drivers/ntb/hw/amd/ntb_hw_amd.c | 44 +++++++++++++++++++++++++--------
 drivers/ntb/hw/amd/ntb_hw_amd.h |  3 +++
 2 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index 621a69a0cff2..d4029d531466 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -913,28 +913,32 @@ static int amd_init_isr(struct amd_ntb_dev *ndev)
 	return ndev_init_isr(ndev, AMD_DB_CNT, AMD_MSIX_VECTOR_CNT);
 }
 
-static void amd_init_side_info(struct amd_ntb_dev *ndev)
+static void amd_set_side_info_reg(struct amd_ntb_dev *ndev, bool peer)
 {
-	void __iomem *mmio = ndev->self_mmio;
+	void __iomem *mmio = NULL;
 	unsigned int reg;
-	u32 ntb_ctl;
+
+	if (peer)
+		mmio = ndev->peer_mmio;
+	else
+		mmio = ndev->self_mmio;
 
 	reg = readl(mmio + AMD_SIDEINFO_OFFSET);
 	if (!(reg & AMD_SIDE_READY)) {
 		reg |= AMD_SIDE_READY;
 		writel(reg, mmio + AMD_SIDEINFO_OFFSET);
 	}
-
-	ntb_ctl = readl(mmio + AMD_CNTL_OFFSET);
-	ntb_ctl |= (PMM_REG_CTL | SMM_REG_CTL);
-	writel(ntb_ctl, mmio + AMD_CNTL_OFFSET);
 }
 
-static void amd_deinit_side_info(struct amd_ntb_dev *ndev)
+static void amd_clear_side_info_reg(struct amd_ntb_dev *ndev, bool peer)
 {
-	void __iomem *mmio = ndev->self_mmio;
+	void __iomem *mmio = NULL;
 	unsigned int reg;
-	u32 ntb_ctl;
+
+	if (peer)
+		mmio = ndev->peer_mmio;
+	else
+		mmio = ndev->self_mmio;
 
 	reg = readl(mmio + AMD_SIDEINFO_OFFSET);
 	if (reg & AMD_SIDE_READY) {
@@ -942,6 +946,26 @@ static void amd_deinit_side_info(struct amd_ntb_dev *ndev)
 		writel(reg, mmio + AMD_SIDEINFO_OFFSET);
 		readl(mmio + AMD_SIDEINFO_OFFSET);
 	}
+}
+
+static void amd_init_side_info(struct amd_ntb_dev *ndev)
+{
+	void __iomem *mmio = ndev->self_mmio;
+	u32 ntb_ctl;
+
+	amd_set_side_info_reg(ndev, false);
+
+	ntb_ctl = readl(mmio + AMD_CNTL_OFFSET);
+	ntb_ctl |= (PMM_REG_CTL | SMM_REG_CTL);
+	writel(ntb_ctl, mmio + AMD_CNTL_OFFSET);
+}
+
+static void amd_deinit_side_info(struct amd_ntb_dev *ndev)
+{
+	void __iomem *mmio = ndev->self_mmio;
+	u32 ntb_ctl;
+
+	amd_clear_side_info_reg(ndev, false);
 
 	ntb_ctl = readl(mmio + AMD_CNTL_OFFSET);
 	ntb_ctl &= ~(PMM_REG_CTL | SMM_REG_CTL);
diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.h b/drivers/ntb/hw/amd/ntb_hw_amd.h
index 156a4a92b803..62ffdf35b683 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.h
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.h
@@ -215,4 +215,7 @@ struct amd_ntb_dev {
 #define ntb_ndev(__ntb) container_of(__ntb, struct amd_ntb_dev, ntb)
 #define hb_ndev(__work) container_of(__work, struct amd_ntb_dev, hb_timer.work)
 
+static void amd_set_side_info_reg(struct amd_ntb_dev *ndev, bool peer);
+static void amd_clear_side_info_reg(struct amd_ntb_dev *ndev, bool peer);
+
 #endif
-- 
2.17.1

