Return-Path: <Sanju.Mehta@amd.com>
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (mail-eopbgr790051.outbound.protection.outlook.com. [40.107.79.51])
        by gmr-mx.google.com with ESMTPS id o6si334839pjt.1.2019.09.15.10.07.45
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Sep 2019 10:07:46 -0700 (PDT)
From: "Mehta, Sanju" <Sanju.Mehta@amd.com>
Subject: [PATCH 1/2] ntb_hw_amd: Add a new NTB PCI device ID
Date: Sun, 15 Sep 2019 17:07:43 +0000
Message-ID: <1568567222-26810-1-git-send-email-Sanju.Mehta@amd.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
To: "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>, "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>, "jdmason@kudzu.us" <jdmason@kudzu.us>, "dave.jiang@intel.com" <dave.jiang@intel.com>, "allenbh@gmail.com" <allenbh@gmail.com>
Cc: "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Mehta, Sanju" <Sanju.Mehta@amd.com>
List-ID: <linux-ntb.googlegroups.com>

From: Sanjay R Mehta <sanju.mehta@amd.com>

Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
---
 drivers/ntb/hw/amd/ntb_hw_amd.c | 3 ++-
 drivers/ntb/hw/amd/ntb_hw_amd.h | 1 -
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_am=
d.c
index 2859cc9..e9286cf 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -1124,7 +1124,8 @@ static const struct file_operations amd_ntb_debugfs_i=
nfo =3D {
 };
=20
 static const struct pci_device_id amd_ntb_pci_tbl[] =3D {
-	{PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_NTB)},
+	{PCI_VDEVICE(AMD, 0x145b)},
+	{PCI_VDEVICE(AMD, 0x148b)},
 	{0}
 };
 MODULE_DEVICE_TABLE(pci, amd_ntb_pci_tbl);
diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.h b/drivers/ntb/hw/amd/ntb_hw_am=
d.h
index 8f3617a..3aac994 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.h
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.h
@@ -52,7 +52,6 @@
 #include <linux/ntb.h>
 #include <linux/pci.h>
=20
-#define PCI_DEVICE_ID_AMD_NTB	0x145B
 #define AMD_LINK_HB_TIMEOUT	msecs_to_jiffies(1000)
 #define AMD_LINK_STATUS_OFFSET	0x68
 #define NTB_LIN_STA_ACTIVE_BIT	0x00000002
--=20
2.7.4

