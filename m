Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCA219BA1
	for <ntb@lists.linux.dev>; Fri, 18 Aug 2023 17:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692380279; x=1723916279;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VIpZHxR/kSM8M4FtvvqGFFV14yI+7xWukTxq3YPIWRM=;
  b=Oreg3rX2ZKd6kvMRoHUMimpWDl5/aYnmRTb4VD+meCkJlu3t4snRdokY
   jONYA+cO4gzxEb7PjaZzcro1r5PnXA51c0bHkol2iSZ+55wFkQYcd1iDa
   mDQdPH0JoTeMW3hmOHMOKUWWW6G3uU34u+jDFczFWNDH82HRvz0h4PcMh
   AXvmN0yProqvW0z4RemhBvzsQ/QOtnvMrZsDLas8zLkvciH5MHSSAeKoX
   zkirvPaGF77qHfXNGP5Zu5AT7DnscKajK0AirszDD0awu1+AiAmC5mRQC
   j9DLp1k8pUFRUtJ7r0eHI3iGJ4rLp770Ug7MVIGdyzXC+qv7unW3O5rvX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="363317894"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="363317894"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 10:37:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="770202756"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="770202756"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.12.146])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 10:37:58 -0700
Subject: [PATCH 1/4] ntb: Clean up tx tail index on link down
From: Dave Jiang <dave.jiang@intel.com>
To: jdmason@kudzu.us, allenbh@gmail.com
Cc: Yuan Y Lu <yuan.y.lu@intel.com>, Yuan Y Lu <yuan.y.lu@intel.com>,
 ntb@lists.linux.dev
Date: Fri, 18 Aug 2023 10:37:58 -0700
Message-ID: <169238027835.3961033.9479025119957048373.stgit@djiang5-mobl3>
In-Reply-To: <169238013566.3961033.4879718723608456809.stgit@djiang5-mobl3>
References: <169238013566.3961033.4879718723608456809.stgit@djiang5-mobl3>
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
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/ntb/ntb_transport.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index a9b97ebc71ac..fbd3beb4c3e2 100644
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
@@ -932,6 +932,12 @@ static void ntb_qp_link_down_reset(struct ntb_transport_qp *qp)
 	qp->tx_async = 0;
 }
 
+static void ntb_qp_link_down_reset(struct ntb_transport_qp *qp)
+{
+	ntb_qp_link_context_reset(qp);
+	qp->remote_rx_info->entry = qp->rx_max_entry - 1;
+}
+
 static void ntb_qp_link_cleanup(struct ntb_transport_qp *qp)
 {
 	struct ntb_transport_ctx *nt = qp->transport;
@@ -1174,7 +1180,7 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
 	qp->ndev = nt->ndev;
 	qp->client_ready = false;
 	qp->event_handler = NULL;
-	ntb_qp_link_down_reset(qp);
+	ntb_qp_link_context_reset(qp);
 
 	if (mw_num < qp_count % mw_count)
 		num_qps_mw = qp_count / mw_count + 1;


