Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAD91DDC0
	for <ntb@lists.linux.dev>; Tue, 22 Aug 2023 16:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692720512; x=1724256512;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c1aaV6aVavVtvLfg47I3KSt04uJ2/ZBX3zsL24OTUks=;
  b=Njn66+4pjdW4+6D98aB1daM0waGKatZQsGabQQuG+UWnWKvKmKULF4Nv
   nYqahcDzyGpjPKgWgoZF2zNxsKTOriiAicuRdV6OoZauVt6fvMNpqZK6U
   rGoYI9K2cOEvNUyYs1e9Uo8TyXa7bV06S7Sjk4PL2/OuM1FD1ZnQNXDCs
   xITE8UlzvTXqfv7ufUf2N+UiPI7Q/3yq4STDaIBHz08rueSTTmLqRkQx7
   mBqXcb1uy6Ol1c3o1yFpV9LQtVrzZEIldLBp2kUkitb7w9I2+p8ZC9lJw
   MRG1uewUMql8U3TXwH4la8X6lbC7PKhuEDtg0TwztHgkEyMkuGKQFYghD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="358909909"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="358909909"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 09:04:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="850681147"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="850681147"
Received: from jpjenkin-mobl.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.85.240])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 09:04:51 -0700
Subject: [PATCH v2 2/4] ntb: Drop packets when qp link is down
From: Dave Jiang <dave.jiang@intel.com>
To: jdmason@kudzu.us, allenbh@gmail.com
Cc: Yuan Y Lu <yuan.y.lu@intel.com>, Yuan Y Lu <yuan.y.lu@intel.com>,
 Logan Gunthorpe <logang@deltatee.com>, ntb@lists.linux.dev
Date: Tue, 22 Aug 2023 09:04:51 -0700
Message-ID: <169272029118.9948.14480168231697667690.stgit@djiang5-mobl3>
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

Currently when the transport receive packets after netdev has closed the
transport returns error and triggers tx errors to be incremented and
carrier to be stopped. There is no reason to return error if the device is
already closed. Drop the packet and return 0.

Fixes: e26a5843f7f5 ("NTB: Split ntb_hw_intel and ntb_transport drivers")
Reported-by: Yuan Y Lu <yuan.y.lu@intel.com>
Tested-by: Yuan Y Lu <yuan.y.lu@intel.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/ntb/ntb_transport.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 28cd6c814343..48d48b30f908 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -2283,9 +2283,13 @@ int ntb_transport_tx_enqueue(struct ntb_transport_qp *qp, void *cb, void *data,
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


