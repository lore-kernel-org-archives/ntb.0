Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18B518C19
	for <ntb@lists.linux.dev>; Fri, 18 Aug 2023 17:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692380293; x=1723916293;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LhXYKwdOPaIBNJVeK6m285VnhnVXRjlO17CSeGvbmr0=;
  b=MBjlUzifvD2CpSsOhMQei2LcM/oh/U6YTc8entXLtIO5tv3rknJeNd7b
   tb/0vLD7Dmr/Iyn/xqkzERejlPbdfO5amPFdRwMBAxDgzOhIFMXswGqxS
   vBtRAll8kGGZCCI/xv11cejK8lfaRN4lLtqMRVtZJBN/ggve0jJlwZsXk
   wxGItHtdatGhw2KDSg9XFbe0wmB5n39JKyR5GhUhOIkPw7uxRastLrZcw
   PcBuEhHnzgwZzTCdZDu3fYt8mV8WHhPbE7pehH+ttTz0ZOFkES2JCwdZc
   Rq5JJVm86XTYR6qoUZ8Z2378yf6c1zo/vSBVeU9SSZRT8FwoFAxFcLpZd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="363317940"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="363317940"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 10:38:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="770202795"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="770202795"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.12.146])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 10:38:05 -0700
Subject: [PATCH 2/4] ntb: Drop packets when qp link is down
From: Dave Jiang <dave.jiang@intel.com>
To: jdmason@kudzu.us, allenbh@gmail.com
Cc: Yuan Y Lu <yuan.y.lu@intel.com>, Yuan Y Lu <yuan.y.lu@intel.com>,
 ntb@lists.linux.dev
Date: Fri, 18 Aug 2023 10:38:04 -0700
Message-ID: <169238028453.3961033.10733818127894760322.stgit@djiang5-mobl3>
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

Currently when the transport receive packets after netdev has closed the
transport returns error and triggers tx errors to be incremented and
carrier to be stopped. There is no reason to return error if the device is
already closed. Drop the packet and return 0.

Fixes: e26a5843f7f5 ("NTB: Split ntb_hw_intel and ntb_transport drivers")
Reported-by: Yuan Y Lu <yuan.y.lu@intel.com>
Tested-by: Yuan Y Lu <yuan.y.lu@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/ntb/ntb_transport.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index fbd3beb4c3e2..dd2aa3cf5c2e 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -2282,9 +2282,13 @@ int ntb_transport_tx_enqueue(struct ntb_transport_qp *qp, void *cb, void *data,
 	struct ntb_queue_entry *entry;
 	int rc;
 
-	if (!qp || !qp->link_is_up || !len)
+	if (!qp || !len)
 		return -EINVAL;
 
+	/* If the qp link is down already, just ignore. */
+	if (!qp->link_is_up)
+		return 0;
+
 	entry = ntb_list_rm(&qp->ntb_tx_free_q_lock, &qp->tx_free_q);
 	if (!entry) {
 		qp->tx_err_no_buf++;


