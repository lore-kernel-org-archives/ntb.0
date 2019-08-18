Return-Path: <colin.king@canonical.com>
Received: from youngberry.canonical.com (youngberry.canonical.com. [91.189.89.112])
        by gmr-mx.google.com with ESMTPS id g7si721617wmk.0.2019.08.18.11.53.51
        for <linux-ntb@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 18 Aug 2019 11:53:51 -0700 (PDT)
From: Colin King <colin.king@canonical.com>
Subject: [PATCH] NTB: ntb_transport: remove redundant assignment to rc
Date: Sun, 18 Aug 2019 19:53:49 +0100
Message-Id: <20190818185349.15275-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

From: Colin Ian King <colin.king@canonical.com>

Variable rc is initialized to a value that is never read and it
is re-assigned later. The initialization is redundant and can be
removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/ntb/ntb_transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 40c90ca10729..00a5d5764993 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -292,7 +292,7 @@ static int ntb_transport_bus_match(struct device *dev,
 static int ntb_transport_bus_probe(struct device *dev)
 {
 	const struct ntb_transport_client *client;
-	int rc = -EINVAL;
+	int rc;
 
 	get_device(dev);
 
-- 
2.20.1

