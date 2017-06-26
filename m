Return-Path: <gunthorp@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id z4si32126ita.5.2017.06.26.12.50.54
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Jun 2017 12:50:54 -0700 (PDT)
From: Logan Gunthorpe <logang@deltatee.com>
Date: Mon, 26 Jun 2017 13:50:41 -0600
Message-Id: <20170626195041.6190-1-logang@deltatee.com>
Subject: [PATCH] ntb: use correct mw_count function in ntb_tool and ntb_transport
To: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
Cc: Logan Gunthorpe <logang@deltatee.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>, Serge Semin <fancer.lancer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

After converting to the new API, both ntb_tool and ntb_transport are
using ntb_mw_count to iterate through ntb_peer_get_addr when they
should be using ntb_peer_mw_count.

This probably isn't an issue with the Intel and AMD drivers but
this will matter for any future driver with asymetric memory window
counts.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Jon Mason <jdmason@kudzu.us>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Allen Hubbe <Allen.Hubbe@emc.com>
Cc: Serge Semin <fancer.lancer@gmail.com>
---

Hi Guys,

I caught this issue while finishing up the switchtec rebase. (Which is
now working again and I'll send the updated series after doing a bit more
testing.)

However, seeing this is a bug in the new api patches I feel it should
be applied to ntb-next tree before it's merged upstream.

Thanks,

Logan

 drivers/ntb/ntb_transport.c | 2 +-
 drivers/ntb/test/ntb_tool.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 9a03c5871efe..b29558ddfe95 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -1059,7 +1059,7 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
 	int node;
 	int rc, i;

-	mw_count = ntb_mw_count(ndev, PIDX);
+	mw_count = ntb_peer_mw_count(ndev);

 	if (!ndev->ops->mw_set_trans) {
 		dev_err(&ndev->dev, "Inbound MW based NTB API is required\n");
diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c
index f002bf48a08d..a69815c45ce6 100644
--- a/drivers/ntb/test/ntb_tool.c
+++ b/drivers/ntb/test/ntb_tool.c
@@ -959,7 +959,7 @@ static int tool_probe(struct ntb_client *self, struct ntb_dev *ntb)
 	tc->ntb = ntb;
 	init_waitqueue_head(&tc->link_wq);

-	tc->mw_count = min(ntb_mw_count(tc->ntb, PIDX), MAX_MWS);
+	tc->mw_count = min(ntb_peer_mw_count(tc->ntb), MAX_MWS);
 	for (i = 0; i < tc->mw_count; i++) {
 		rc = tool_init_mw(tc, i);
 		if (rc)
--
2.11.0
