Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B95E525F
	for <ntb@lists.linux.dev>; Fri, 18 Aug 2023 17:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692380303; x=1723916303;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ayJgRx1nhgmO2hHePfjGGbGouLUUfdPcGLsl7xet244=;
  b=JxTfSOVrmgc4Zw00OAEoc44/4wiE8pAWirJYQyJpIzx41zrGeNXyhrGN
   i0ByhoiEsKnDlGvVQY4staen28A/CleRBHUfKwoni4je5C/UM3+d/KaDU
   OnCDBQFEyDH1Q/FRPPIZ25fT0UJfZSuIk8bUgrMOfCqkPjjg4BJ8XZhlV
   u3RzClPDda+c/4A0M+sAaXFEVgbH4AfTIZ3H3xSowQmS3XKtAxNuCNrRU
   T399qj1pQyv8xOEB61mRHbqkusQLNikenNzlfFuLc6a9WltTmP3FOd+8Y
   G74mAz8m67iDF8QHs8c2R4L4SXlxG43bEqW7UQPdW7LKLv9N/pVCLpVkw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="363317986"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="363317986"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 10:38:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="770202840"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="770202840"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.12.146])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 10:38:22 -0700
Subject: [PATCH 4/4] ntb: check tx descriptors outstanding instead of
 head/tail for tx queue
From: Dave Jiang <dave.jiang@intel.com>
To: jdmason@kudzu.us, allenbh@gmail.com
Cc: ntb@lists.linux.dev
Date: Fri, 18 Aug 2023 10:38:21 -0700
Message-ID: <169238030197.3961033.970355005303992287.stgit@djiang5-mobl3>
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

Use existing function ntb_transport_tx_free_entry() instead of open coding
the check to see if there are outstanding tx descriptors.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/ntb/ntb_transport.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index ec6f706ff856..e65640107180 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -1900,7 +1900,7 @@ static void ntb_async_tx(struct ntb_transport_qp *qp,
 static int ntb_process_tx(struct ntb_transport_qp *qp,
 			  struct ntb_queue_entry *entry)
 {
-	if (qp->tx_index == qp->remote_rx_info->entry) {
+	if (!ntb_transport_tx_free_entry(qp)) {
 		qp->tx_ring_full++;
 		return -EAGAIN;
 	}


