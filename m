Return-Path: <Sanju.Mehta@amd.com>
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (mail-eopbgr790041.outbound.protection.outlook.com. [40.107.79.41])
        by gmr-mx.google.com with ESMTPS id j21si675436pfe.5.2019.09.15.10.08.37
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Sep 2019 10:08:37 -0700 (PDT)
From: "Mehta, Sanju" <Sanju.Mehta@amd.com>
Subject: [PATCH 2/2] ntb_hw_amd: Add memory window support for new AMD
 hardware
Date: Sun, 15 Sep 2019 17:08:35 +0000
Message-ID: <1568567293-26894-1-git-send-email-Sanju.Mehta@amd.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
To: "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>, "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>, "jdmason@kudzu.us" <jdmason@kudzu.us>, "dave.jiang@intel.com" <dave.jiang@intel.com>, "allenbh@gmail.com" <allenbh@gmail.com>
Cc: "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Mehta, Sanju" <Sanju.Mehta@amd.com>
List-ID: <linux-ntb.googlegroups.com>

From: Sanjay R Mehta <sanju.mehta@amd.com>

The AMD new hardware uses BAR23 and BAR45 as memory windows
as compared to previos where BAR1, BAR23 and BAR45 is used
for memory windows.

This patch add support for both AMD hardwares.

Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
---
 drivers/ntb/hw/amd/ntb_hw_amd.c | 23 ++++++++++++++++++-----
 drivers/ntb/hw/amd/ntb_hw_amd.h |  7 ++++++-
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_am=
d.c
index e9286cf..156c2a1 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -78,7 +78,7 @@ static int ndev_mw_to_bar(struct amd_ntb_dev *ndev, int i=
dx)
 	if (idx < 0 || idx > ndev->mw_count)
 		return -EINVAL;
=20
-	return 1 << idx;
+	return ndev->dev_data->mw_idx << idx;
 }
=20
 static int amd_ntb_mw_count(struct ntb_dev *ntb, int pidx)
@@ -909,7 +909,7 @@ static int amd_init_ntb(struct amd_ntb_dev *ndev)
 {
 	void __iomem *mmio =3D ndev->self_mmio;
=20
-	ndev->mw_count =3D AMD_MW_CNT;
+	ndev->mw_count =3D ndev->dev_data->mw_count;
 	ndev->spad_count =3D AMD_SPADS_CNT;
 	ndev->db_count =3D AMD_DB_CNT;
=20
@@ -1069,6 +1069,8 @@ static int amd_ntb_pci_probe(struct pci_dev *pdev,
 		goto err_ndev;
 	}
=20
+	ndev->dev_data =3D (struct ntb_dev_data *)id->driver_data;
+
 	ndev_init_struct(ndev, pdev);
=20
 	rc =3D amd_ntb_init_pci(ndev, pdev);
@@ -1123,10 +1125,21 @@ static const struct file_operations amd_ntb_debugfs=
_info =3D {
 	.read =3D ndev_debugfs_read,
 };
=20
+static const struct ntb_dev_data dev_data[] =3D {
+	{ /* for device 145b */
+		.mw_count =3D 3,
+		.mw_idx =3D 1,
+	},
+	{ /* for device 148b */
+		.mw_count =3D 2,
+		.mw_idx =3D 2,
+	},
+};
+
 static const struct pci_device_id amd_ntb_pci_tbl[] =3D {
-	{PCI_VDEVICE(AMD, 0x145b)},
-	{PCI_VDEVICE(AMD, 0x148b)},
-	{0}
+	{ PCI_VDEVICE(AMD, 0x145b), (kernel_ulong_t)&dev_data[0] },
+	{ PCI_VDEVICE(AMD, 0x148b), (kernel_ulong_t)&dev_data[1] },
+	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, amd_ntb_pci_tbl);
=20
diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.h b/drivers/ntb/hw/amd/ntb_hw_am=
d.h
index 3aac994..139a307 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.h
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.h
@@ -92,7 +92,6 @@ static inline void _write64(u64 val, void __iomem *mmio)
=20
 enum {
 	/* AMD NTB Capability */
-	AMD_MW_CNT		=3D 3,
 	AMD_DB_CNT		=3D 16,
 	AMD_MSIX_VECTOR_CNT	=3D 24,
 	AMD_SPADS_CNT		=3D 16,
@@ -169,6 +168,11 @@ enum {
 	AMD_PEER_OFFSET		=3D 0x400,
 };
=20
+struct ntb_dev_data {
+	const unsigned char mw_count;
+	const unsigned int mw_idx;
+};
+
 struct amd_ntb_dev;
=20
 struct amd_ntb_vec {
@@ -184,6 +188,7 @@ struct amd_ntb_dev {
 	u32 cntl_sta;
 	u32 peer_sta;
=20
+	struct ntb_dev_data *dev_data;
 	unsigned char mw_count;
 	unsigned char spad_count;
 	unsigned char db_count;
--=20
2.7.4

