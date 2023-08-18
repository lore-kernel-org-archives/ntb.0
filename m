Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A26618C19
	for <ntb@lists.linux.dev>; Fri, 18 Aug 2023 17:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692380297; x=1723916297;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZZwp9aaCym0lNR1/rHJVaCj+p8lkKvP/zFqPOg3X8Yw=;
  b=Ybo1AV302mVFO9fSbtbWTm/Fk+4rcBoCHvmcQGJvpYPTmEfpEravmOA4
   WFRId0INTznNyjzPVa99PH8b2ShiY6aXPufufhCqlNJxdT5yANZqLoUsS
   N7vjTrfJZaaPIPcd/1q9RfHYh5soQC24zz/rG42brBb85pVhIqRoNrP/f
   Fo50ulP+eI38YOp7ru5lOKxZi+di4uDTnIohlZiVdKCVTFSvhX6LY0jDn
   Y/FTKMPsXW2LjVTpwnFWQUVJh+bCu0EcniAN67OnZA+OGgXkj0NAimUzk
   hoKSWpS1lIa4ij1iHZi9cxR3lji9HOh361kx0+VQJnPoOeZ+17sD9ciK3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="363317951"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="363317951"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 10:38:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="770202824"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="770202824"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.12.146])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 10:38:16 -0700
Subject: [PATCH 3/4] ntb: Fix calculation ntb_transport_tx_free_entry()
From: Dave Jiang <dave.jiang@intel.com>
To: jdmason@kudzu.us, allenbh@gmail.com
Cc: renlonglong <ren.longlong@h3c.com>, ntb@lists.linux.dev
Date: Fri, 18 Aug 2023 10:38:15 -0700
Message-ID: <169238029582.3961033.7469539963376957559.stgit@djiang5-mobl3>
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

ntb_transport_tx_free_entry() never returns 0 with the current
calculation. If head == tail, then it would return qp->tx_max_entry.
Change compare to tail >= head and when they are equal, a 0 would be
returned.

Fixes: e74bfeedad08 ("NTB: Add flow control to the ntb_netdev")
Signed-off-by: renlonglong <ren.longlong@h3c.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/ntb/ntb_transport.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index dd2aa3cf5c2e..ec6f706ff856 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -2428,7 +2428,7 @@ unsigned int ntb_transport_tx_free_entry(struct ntb_transport_qp *qp)
 	unsigned int head = qp->tx_index;
 	unsigned int tail = qp->remote_rx_info->entry;
 
-	return tail > head ? tail - head : qp->tx_max_entry + tail - head;
+	return tail >= head ? tail - head : qp->tx_max_entry + tail - head;
 }
 EXPORT_SYMBOL_GPL(ntb_transport_tx_free_entry);
 


