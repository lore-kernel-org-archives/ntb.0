Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A611CA1F
	for <ntb@lists.linux.dev>; Tue, 22 Aug 2023 16:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692720372; x=1724256372;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SvVsQvWXnE9/vEH6AlmQwC/ugtAAwl/95QIuFAIjMw8=;
  b=Y4JdzQYJrvNdTgeivtge7gRpeq4fxQqeYvnSvXYzRXbRzUmBSYfzCRYf
   OfRSLE+XBMdZ8X0OxpE2ZvoeY4Sr2/aZinFmScmFMZIAbtDbMNE+JNBdu
   WklEkgC/UExfQSsD3/rO+oXEV5u1B1ZyFLR91LzDiDAjZmHF1b93EK08S
   B4Un7V4kTHl0+Dd7AOMzQcWUTpMq0Cp8SRQAjgCONFq+1ps9f+/XhWoyl
   bwpNUxyLmtTCOPH/gYRJXKOK8rPEKeoQ7yc9GnPFRCNOo5hD6f4ujfscL
   QNUV/rv94u55t7WcQ3dsZna4dFTdiNTzltfBFmEsfo8ceNTEnMUgF2+oD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="371341699"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="371341699"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 09:05:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="686095295"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="686095295"
Received: from jpjenkin-mobl.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.85.240])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 09:05:03 -0700
Subject: [PATCH v2 4/4] ntb: Check tx descriptors outstanding instead of
 head/tail for tx queue
From: Dave Jiang <dave.jiang@intel.com>
To: jdmason@kudzu.us, allenbh@gmail.com
Cc: Logan Gunthorpe <logang@deltatee.com>, ntb@lists.linux.dev
Date: Tue, 22 Aug 2023 09:05:02 -0700
Message-ID: <169272030266.9948.14732042190804144044.stgit@djiang5-mobl3>
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

Use existing function ntb_transport_tx_free_entry() instead of open coding
the check to see if there are outstanding tx descriptors.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/ntb/ntb_transport.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 92241791eb6c..0f09dc0a7efe 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -1901,7 +1901,7 @@ static void ntb_async_tx(struct ntb_transport_qp *qp,
 static int ntb_process_tx(struct ntb_transport_qp *qp,
 			  struct ntb_queue_entry *entry)
 {
-	if (qp->tx_index == qp->remote_rx_info->entry) {
+	if (!ntb_transport_tx_free_entry(qp)) {
 		qp->tx_ring_full++;
 		return -EAGAIN;
 	}


