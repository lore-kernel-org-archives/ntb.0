Return-Path: <anath.amd@gmail.com>
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com. [2607:f8b0:4864:20::644])
        by gmr-mx.google.com with ESMTPS id v13si3978pga.4.2020.02.05.07.55.30
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2020 07:55:30 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id c23so1045279plz.4
        for <linux-ntb@googlegroups.com>; Wed, 05 Feb 2020 07:55:30 -0800 (PST)
Return-Path: <anath.amd@gmail.com>
Sender: Arindam Nath <anath.amd@gmail.com>
From: Arindam Nath <arindam.nath@amd.com>
Subject: [PATCH 14/15] NTB: send DB event when driver is loaded or un-loaded
Date: Wed,  5 Feb 2020 21:24:31 +0530
Message-Id: <e2f6de21a4faf6a44e18dd5f6429b6150913f324.1580914232.git.arindam.nath@amd.com>
In-Reply-To: <cover.1580914232.git.arindam.nath@amd.com>
References: <cover.1580914232.git.arindam.nath@amd.com>
In-Reply-To: <cover.1580914232.git.arindam.nath@amd.com>
References: <cover.1580914232.git.arindam.nath@amd.com>
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Jiasen Lin <linjiasen@hygon.cn>, Sanjay R Mehta <sanju.mehta@amd.com>
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Arindam Nath <arindam.nath@amd.com>
List-ID: <linux-ntb.googlegroups.com>

When the driver on the local side is loaded, it sets
SIDE_READY bit in SIDE_INFO register. Likewise, when
it is un-loaded, it clears the bit.

Also just after being loaded, the driver polls for
peer SIDE_READY bit to be set. Since that bit is set
when the peer side driver has loaded, the polling on
local side breaks as soon as this condition is met.

But the situation is different when the driver is
un-loaded. Since the polling has already been stopped
as mentioned before, if the peer side driver gets
un-loaded, the driver on the local side is not notified
implicitly.

So, we improvise using existing doorbell mechanism.
We reserve the highest order bit of the DB register to
send a notification to peer when the driver on local
side is un-loaded. This also means that now we are one
short of 16 DB events and that is taken care of in the
valid DB mask.

Signed-off-by: Arindam Nath <arindam.nath@amd.com>
---
 drivers/ntb/hw/amd/ntb_hw_amd.c | 57 +++++++++++++++++++++++++++++++--
 drivers/ntb/hw/amd/ntb_hw_amd.h |  1 +
 2 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index 04be1482037b..c6cea0005553 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -647,6 +647,36 @@ static void amd_handle_event(struct amd_ntb_dev *ndev, int vec)
 	writel(status, mmio + AMD_INTSTAT_OFFSET);
 }
 
+static void amd_handle_db_event(struct amd_ntb_dev *ndev, int vec)
+{
+	struct device *dev = &ndev->ntb.pdev->dev;
+	u64 status;
+
+	status = amd_ntb_db_read(&ndev->ntb);
+
+	dev_dbg(dev, "status = 0x%llx and vec = %d\n", status, vec);
+
+	/*
+	 * Since we had reserved highest order bit of DB for signaling peer of
+	 * a special event, this is the only status bit we should be concerned
+	 * here now.
+	 */
+	if (status & BIT(ndev->db_last_bit)) {
+		ntb_db_clear(&ndev->ntb, BIT(ndev->db_last_bit));
+		/* send link down event notification */
+		ntb_link_event(&ndev->ntb);
+
+		/*
+		 * If we are here, that means the peer has signalled a special
+		 * event which notifies that the peer driver has been
+		 * un-loaded for some reason. Since there is a chance that the
+		 * peer will load its driver again sometime, we schedule link
+		 * polling routine.
+		 */
+		schedule_delayed_work(&ndev->hb_timer, AMD_LINK_HB_TIMEOUT);
+	}
+}
+
 static irqreturn_t ndev_interrupt(struct amd_ntb_dev *ndev, int vec)
 {
 	dev_dbg(&ndev->ntb.pdev->dev, "vec %d\n", vec);
@@ -654,8 +684,10 @@ static irqreturn_t ndev_interrupt(struct amd_ntb_dev *ndev, int vec)
 	if (vec > (AMD_DB_CNT - 1) || (ndev->msix_vec_count == 1))
 		amd_handle_event(ndev, vec);
 
-	if (vec < AMD_DB_CNT)
+	if (vec < AMD_DB_CNT) {
+		amd_handle_db_event(ndev, vec);
 		ntb_db_event(&ndev->ntb, vec);
+	}
 
 	return IRQ_HANDLED;
 }
@@ -1096,6 +1128,21 @@ static int amd_init_dev(struct amd_ntb_dev *ndev)
 		return rc;
 	}
 
+	ndev->db_valid_mask = BIT_ULL(ndev->db_count) - 1;
+	/*
+	 * We reserve the highest order bit of the DB register which will
+	 * be used to notify peer when the driver on this side is being
+	 * un-loaded.
+	 */
+	ndev->db_last_bit =
+			find_last_bit((unsigned long *)&ndev->db_valid_mask,
+				      hweight64(ndev->db_valid_mask));
+	writew((u16)~BIT(ndev->db_last_bit), mmio + AMD_DBMASK_OFFSET);
+	/*
+	 * Since now there is one less bit to account for, the DB count
+	 * and DB mask should be adjusted accordingly.
+	 */
+	ndev->db_count -= 1;
 	ndev->db_valid_mask = BIT_ULL(ndev->db_count) - 1;
 
 	/* Enable Link-Up and Link-Down event interrupts */
@@ -1235,9 +1282,15 @@ static void amd_ntb_pci_remove(struct pci_dev *pdev)
 {
 	struct amd_ntb_dev *ndev = pci_get_drvdata(pdev);
 
+	/*
+	 * Clear the READY bit in SIDEINFO register before sending DB event
+	 * to the peer. This will make sure that when the peer handles the
+	 * DB event, it correctly reads this bit as being 0.
+	 */
+	amd_deinit_side_info(ndev);
+	ntb_peer_db_set(&ndev->ntb, BIT_ULL(ndev->db_last_bit));
 	ntb_unregister_device(&ndev->ntb);
 	ndev_deinit_debugfs(ndev);
-	amd_deinit_side_info(ndev);
 	amd_deinit_dev(ndev);
 	amd_ntb_deinit_pci(ndev);
 	kfree(ndev);
diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.h b/drivers/ntb/hw/amd/ntb_hw_amd.h
index 73959c0b9972..5f337b1572a0 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.h
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.h
@@ -193,6 +193,7 @@ struct amd_ntb_dev {
 
 	u64 db_valid_mask;
 	u64 db_mask;
+	u64 db_last_bit;
 	u32 int_mask;
 
 	struct msix_entry *msix;
-- 
2.17.1

