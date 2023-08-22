Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFF41DA5F
	for <ntb@lists.linux.dev>; Tue, 22 Aug 2023 16:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692720502; x=1724256502;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S9pRr7+AG973jv7kvLb/a4/v5hA7c9ckHZnN2TGLULg=;
  b=YQucLTJ1nZcvnmnAFwYKQ4046HAsyqExCzlPiAlQe5IFr8g/NwJBHvZn
   XMFOIQb0SPZ2da/tJB5hoTtraB25ON0zBflPxJBLxDp93Y6YdUcKZrqwX
   RtvqukphAggZQZVOaST9Gv0H2QdUzoWumjEWPbi6rAUpEB1gecYCW3UMz
   xSva3S2LwqChlKbaXTJDC0qeMas+553wXy0m457UeHnzXYw2Qy+RDs0p6
   2r2WPeTyX/ICSmAa5Xd9ZMc1EvIXOUlRo00HWU9fFuO4KIaPIUjL1FPxu
   9kMbWUfum4vyIIM/rybWHVdn6twpnMi+LeOUjCNmTkUQUWHekdTinLpWy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="358909845"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="358909845"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 09:04:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="850681133"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="850681133"
Received: from jpjenkin-mobl.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.85.240])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 09:04:45 -0700
Subject: [PATCH v2 1/4] ntb: Clean up tx tail index on link down
From: Dave Jiang <dave.jiang@intel.com>
To: jdmason@kudzu.us, allenbh@gmail.com
Cc: Yuan Y Lu <yuan.y.lu@intel.com>, Yuan Y Lu <yuan.y.lu@intel.com>,
 Logan Gunthorpe <logang@deltatee.com>, ntb@lists.linux.dev
Date: Tue, 22 Aug 2023 09:04:45 -0700
Message-ID: <169272028553.9948.55840718475802072.stgit@djiang5-mobl3>
In-Reply-To: <169272009288.9948.16284771919634911796.stgit@djiang5-mobl3>
References: <169272009288.9948.16284771919634911796.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The tx tail index is not reset when the link goes down. This causes the
tail index to go out of sync when the link goes down and comes back up.
Refactor the ntb_qp_link_down_reset() and reset the tail index as well.

Fixes: 2849b5d70641 ("NTB: Reset transport QP link stats on down")
Reported-by: Yuan Y Lu <yuan.y.lu@intel.com>
Tested-by: Yuan Y Lu <yuan.y.lu@intel.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/ntb/ntb_transport.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index a9b97ebc71ac..28cd6c814343 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -909,7 +909,7 @@ static int ntb_set_mw(struct ntb_transport_ctx *nt, int num_mw,
 	return 0;
 }
 
-static void ntb_qp_link_down_reset(struct ntb_transport_qp *qp)
+static void ntb_qp_link_context_reset(struct ntb_transport_qp *qp)
 {
 	qp->link_is_up = false;
 	qp->active = false;
@@ -932,6 +932,13 @@ static void ntb_qp_link_down_reset(struct ntb_transport_qp *qp)
 	qp->tx_async = 0;
 }
 
+static void ntb_qp_link_down_reset(struct ntb_transport_qp *qp)
+{
+	ntb_qp_link_context_reset(qp);
+	if (qp->remote_rx_info)
+		qp->remote_rx_info->entry = qp->rx_max_entry - 1;
+}
+
 static void ntb_qp_link_cleanup(struct ntb_transport_qp *qp)
 {
 	struct ntb_transport_ctx *nt = qp->transport;
@@ -1174,7 +1181,7 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
 	qp->ndev = nt->ndev;
 	qp->client_ready = false;
 	qp->event_handler = NULL;
-	ntb_qp_link_down_reset(qp);
+	ntb_qp_link_context_reset(qp);
 
 	if (mw_num < qp_count % mw_count)
 		num_qps_mw = qp_count / mw_count + 1;


