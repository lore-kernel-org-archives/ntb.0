Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DD11DDC0
	for <ntb@lists.linux.dev>; Tue, 22 Aug 2023 16:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692720518; x=1724256518;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mmz8h3cabOSgVD51nZTksru0jkFye8nvxzzxxxu12oQ=;
  b=L6C2Eugols3qJ35nE9LJBvUQCsX9DOEgnc7+7xcr9kas+XYqGqYluMob
   3yvyx6Z4Ak50kf6hm1yNTUpL5q4RJaUtCJTklUGBgtH4Yr+jNuoKSxEW0
   Y7VbguCiXJLloXUPwQ1gBM9dBL5f8+cOVBTihVY2MTr3ukqaShivfnR3u
   pt3Ke6lxRp/sVPOT9OIMyhxr1NHOIJYpTOIhTmERuxlF0ufLDHMVBbIhF
   Rj+Y4pAjeSyqULo6wsJEgMmMxMJh279v1oS2KmSlnSKyGYAVLUZ4BIPiL
   cXq5nrOTp8EqIQMLM/KEut5SHfMSJnHj4FMUEVd9NWPAK9SS1VFCb04G9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="358909962"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="358909962"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 09:04:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="850681181"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="850681181"
Received: from jpjenkin-mobl.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.85.240])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 09:04:57 -0700
Subject: [PATCH v2 3/4] ntb: Fix calculation ntb_transport_tx_free_entry()
From: Dave Jiang <dave.jiang@intel.com>
To: jdmason@kudzu.us, allenbh@gmail.com
Cc: Logan Gunthorpe <logang@deltatee.com>, renlonglong <ren.longlong@h3c.com>,
 ntb@lists.linux.dev
Date: Tue, 22 Aug 2023 09:04:57 -0700
Message-ID: <169272029701.9948.1497651147307835645.stgit@djiang5-mobl3>
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

ntb_transport_tx_free_entry() never returns 0 with the current
calculation. If head == tail, then it would return qp->tx_max_entry.
Change compare to tail >= head and when they are equal, a 0 would be
returned.

Fixes: e74bfeedad08 ("NTB: Add flow control to the ntb_netdev")
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: renlonglong <ren.longlong@h3c.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/ntb/ntb_transport.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 48d48b30f908..92241791eb6c 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -2429,7 +2429,7 @@ unsigned int ntb_transport_tx_free_entry(struct ntb_transport_qp *qp)
 	unsigned int head = qp->tx_index;
 	unsigned int tail = qp->remote_rx_info->entry;
 
-	return tail > head ? tail - head : qp->tx_max_entry + tail - head;
+	return tail >= head ? tail - head : qp->tx_max_entry + tail - head;
 }
 EXPORT_SYMBOL_GPL(ntb_transport_tx_free_entry);
 


