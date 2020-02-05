Return-Path: <anath.amd@gmail.com>
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com. [2607:f8b0:4864:20::1044])
        by gmr-mx.google.com with ESMTPS id h6si3804vkc.3.2020.02.05.07.55.34
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2020 07:55:34 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id ep11so1150031pjb.2
        for <linux-ntb@googlegroups.com>; Wed, 05 Feb 2020 07:55:33 -0800 (PST)
Return-Path: <anath.amd@gmail.com>
Sender: Arindam Nath <anath.amd@gmail.com>
From: Arindam Nath <arindam.nath@amd.com>
Subject: [PATCH 15/15] NTB: add pci shutdown handler for AMD NTB
Date: Wed,  5 Feb 2020 21:24:32 +0530
Message-Id: <6c943711a14cd79bd6f3b392787f09da2cfb3711.1580914232.git.arindam.nath@amd.com>
In-Reply-To: <cover.1580914232.git.arindam.nath@amd.com>
References: <cover.1580914232.git.arindam.nath@amd.com>
In-Reply-To: <cover.1580914232.git.arindam.nath@amd.com>
References: <cover.1580914232.git.arindam.nath@amd.com>
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Jiasen Lin <linjiasen@hygon.cn>, Sanjay R Mehta <sanju.mehta@amd.com>
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Arindam Nath <arindam.nath@amd.com>
List-ID: <linux-ntb.googlegroups.com>

The PCI shutdown handler is invoked in response
to system reboot or shutdown. A data transfer
might still be in flight when this happens. So
the very first action we take here is to send
a link down notification, so that any pending
data transfer is terminated. Rest of the actions
are same as that of PCI remove handler.

Signed-off-by: Arindam Nath <arindam.nath@amd.com>
---
 drivers/ntb/hw/amd/ntb_hw_amd.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index c6cea0005553..9e310e1ad4d0 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -1296,6 +1296,22 @@ static void amd_ntb_pci_remove(struct pci_dev *pdev)
 	kfree(ndev);
 }
 
+static void amd_ntb_pci_shutdown(struct pci_dev *pdev)
+{
+	struct amd_ntb_dev *ndev = pci_get_drvdata(pdev);
+
+	/* Send link down notification */
+	ntb_link_event(&ndev->ntb);
+
+	amd_deinit_side_info(ndev);
+	ntb_peer_db_set(&ndev->ntb, BIT_ULL(ndev->db_last_bit));
+	ntb_unregister_device(&ndev->ntb);
+	ndev_deinit_debugfs(ndev);
+	amd_deinit_dev(ndev);
+	amd_ntb_deinit_pci(ndev);
+	kfree(ndev);
+}
+
 static const struct file_operations amd_ntb_debugfs_info = {
 	.owner = THIS_MODULE,
 	.open = simple_open,
@@ -1326,6 +1342,7 @@ static struct pci_driver amd_ntb_pci_driver = {
 	.id_table	= amd_ntb_pci_tbl,
 	.probe		= amd_ntb_pci_probe,
 	.remove		= amd_ntb_pci_remove,
+	.shutdown	= amd_ntb_pci_shutdown,
 };
 
 static int __init amd_ntb_pci_driver_init(void)
-- 
2.17.1

