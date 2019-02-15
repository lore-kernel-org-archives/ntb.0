Return-Path: <Sanju.Mehta@amd.com>
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-eopbgr770058.outbound.protection.outlook.com. [40.107.77.58])
        by gmr-mx.google.com with ESMTPS id a26si163141lff.2.2019.02.15.01.21.49
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 15 Feb 2019 01:21:49 -0800 (PST)
From: "Mehta, Sanju" <Sanju.Mehta@amd.com>
Subject: [PATCH 4/4] NTB: ntb_hw_amd: set peer limit register
Date: Fri, 15 Feb 2019 09:21:46 +0000
Message-ID: <1550222486-30144-1-git-send-email-Sanju.Mehta@amd.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
To: "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>, "jdmason@kudzu.us" <jdmason@kudzu.us>, "dave.jiang@intel.com" <dave.jiang@intel.com>, "allenbh@gmail.com" <allenbh@gmail.com>
Cc: "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Mehta, Sanju" <Sanju.Mehta@amd.com>
List-ID: <linux-ntb.googlegroups.com>

From: Sanjay R Mehta <sanju.mehta@amd.com>

As per amd ntb spec it says that peer limit register
must be programmed

Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
---
 drivers/ntb/hw/amd/ntb_hw_amd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_am=
d.c
index efb214f..cd463e1 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -160,8 +160,8 @@ static int amd_ntb_mw_set_trans(struct ntb_dev *ntb, in=
t pidx, int idx,
 		}
=20
 		/* set and verify setting the limit */
-		write64(limit, mmio + limit_reg);
-		reg_val =3D read64(mmio + limit_reg);
+		write64(limit, peer_mmio + limit_reg);
+		reg_val =3D read64(peer_mmio + limit_reg);
 		if (reg_val !=3D limit) {
 			write64(base_addr, mmio + limit_reg);
 			write64(0, peer_mmio + xlat_reg);
@@ -183,8 +183,8 @@ static int amd_ntb_mw_set_trans(struct ntb_dev *ntb, in=
t pidx, int idx,
 		}
=20
 		/* set and verify setting the limit */
-		writel(limit, mmio + limit_reg);
-		reg_val =3D readl(mmio + limit_reg);
+		writel(limit, peer_mmio + limit_reg);
+		reg_val =3D readl(peer_mmio + limit_reg);
 		if (reg_val !=3D limit) {
 			writel(base_addr, mmio + limit_reg);
 			writel(0, peer_mmio + xlat_reg);
--=20
2.7.4

