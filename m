Return-Path: <gunthorp@cgy1-donard.priv.deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id f69si889856pfc.1.2016.06.03.13.53.21
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Jun 2016 13:53:22 -0700 (PDT)
From: Logan Gunthorpe <logang@deltatee.com>
Date: Fri,  3 Jun 2016 14:50:32 -0600
Message-Id: <efa91cd782ad223cc30eeeda8d2341cc11a8646d.1464986161.git.logang@deltatee.com>
In-Reply-To: <cover.1464986161.git.logang@deltatee.com>
References: <cover.1464986161.git.logang@deltatee.com>
In-Reply-To: <cover.1464986161.git.logang@deltatee.com>
References: <cover.1464986161.git.logang@deltatee.com>
Subject: [PATCH 2/3] ntb_transport: Check the number of spads the hardware supports
To: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>, John Kading <john.kading@gd-ms.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>
List-ID: <linux-ntb.googlegroups.com>

I'm working on hardware that currently has a limited number of
scratchpad registers and ntb_ndev fails with no clue as to why. I
feel it is better to fail early and provide a reasonable error message
then to fail later on..

The same is done to ntb_perf, but it doesn't currently require enough
spads to actually fail.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/ntb/ntb_transport.c | 9 +++++++--
 drivers/ntb/test/ntb_perf.c | 8 ++++++--
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 2ef9d913..34e7a7a 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -1037,6 +1037,13 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
 	int node;
 	int rc, i;
 
+	mw_count = ntb_mw_count(ndev);
+	if (ntb_spad_count(ndev) < (NUM_MWS + 1 + mw_count*2)) {
+		dev_err(&ndev->dev, "Not enough scratch pad registers for %s",
+			NTB_TRANSPORT_NAME);
+		return -EIO;
+	}
+
 	if (ntb_db_is_unsafe(ndev))
 		dev_dbg(&ndev->dev,
 			"doorbell is unsafe, proceed anyway...\n");
@@ -1052,8 +1059,6 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
 
 	nt->ndev = ndev;
 
-	mw_count = ntb_mw_count(ndev);
-
 	nt->mw_count = mw_count;
 
 	nt->mw_vec = kzalloc_node(mw_count * sizeof(*nt->mw_vec),
diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index 30635c8..1815592 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -143,8 +143,6 @@ enum {
 	VERSION = 0,
 	MW_SZ_HIGH,
 	MW_SZ_LOW,
-	SPAD_MSG,
-	SPAD_ACK,
 	MAX_SPAD
 };
 
@@ -698,6 +696,12 @@ static int perf_probe(struct ntb_client *client, struct ntb_dev *ntb)
 
 	node = dev_to_node(&pdev->dev);
 
+	if (ntb_spad_count(ntb) < MAX_SPAD) {
+		dev_err(&ntb->dev, "Not enough scratch pad registers for %s",
+			DRIVER_NAME);
+		return -EIO;
+	}
+
 	perf = kzalloc_node(sizeof(*perf), GFP_KERNEL, node);
 	if (!perf) {
 		rc = -ENOMEM;
-- 
2.1.4

