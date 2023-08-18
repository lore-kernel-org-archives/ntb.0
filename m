Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C11C19BA1
	for <ntb@lists.linux.dev>; Fri, 18 Aug 2023 17:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692380274; x=1723916274;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Dv2wrFMOEBkXhnfYKbygsEGZaN2e22G3IXEOY3mLeFE=;
  b=LMmXXcyuP1IznChK6A7ng7Ntg2dhS2ShXzuG3Sz20fT6/RK/HjjaFT2e
   c3dgiXsMCYpjYirxCSd0MJfyDkdYYIMejHcSGe5V3Sy8838zeu5LHCBSP
   r3BaGCBboPxjBf33Ar33CLrXIapKWIC8L3lSWJpYxd4Ys8DFClDUgF+pr
   RNwMD5YtUGOU1OPL6pTZPTXHppLRmHW5osZXJAHm1z3F6PHBM0eDsp3Cy
   IHN27oD9dzEhhG6hHET8DJVTklTGDs1jqjdZFn2UjiS3T4bIL2rZ18Qpm
   IS8a0ydXUQj8LaJC8Y/CijLIxstzcFDCv7FCjODPJhjsX0MlgYMKA+NJq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="363317859"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="363317859"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 10:37:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="770202727"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="770202727"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.12.146])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 10:37:52 -0700
Subject: [PATCH 0/4] ntb: ntb_transport fixes from link up/down testing
From: Dave Jiang <dave.jiang@intel.com>
To: jdmason@kudzu.us, allenbh@gmail.com
Cc: renlonglong <ren.longlong@h3c.com>, Yuan Y Lu <yuan.y.lu@intel.com>,
 ntb@lists.linux.dev
Date: Fri, 18 Aug 2023 10:37:52 -0700
Message-ID: <169238013566.3961033.4879718723608456809.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Several ntb_transport fixes after doing long term continous netdev up/down
testing.

---

Dave Jiang (4):
      ntb: Clean up tx tail index on link down
      ntb: Drop packets when qp link is down
      ntb: Fix calculation ntb_transport_tx_free_entry()
      ntb: Check tx descriptors outstanding instead of head/tail for tx queue


 drivers/ntb/ntb_transport.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

--

