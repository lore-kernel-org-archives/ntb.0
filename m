Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DDB1CA1F
	for <ntb@lists.linux.dev>; Tue, 22 Aug 2023 16:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692720494; x=1724256494;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=b6c6R9Y7VLkGHBNgKyhp7c+OEEh8gC7EXAvfaGp2Trk=;
  b=Tfvr+N56GuT65nRcb0cY1Jw6Mp/o1ARKZKnp2vMBzbKVZahALfYINXAd
   mL/BcA/YVKDBojjLrxqfRB21RgtuSadn/59x13iOpi/5AYdCBcMNG5HI5
   8idxOor01QfVycdlTObHxk2gmvZilK7B2Mr/rmoBgQLs613tvD9eJ3asM
   DIX1Tkd0CG/HADdqa6mkz4+m3ROrjnCpZ2UqprrOyyxlGfmJ+lobD6As0
   S0d5baQxxE1kggELEFXbSEY1HQuU4+DvjsEHhQvT6LEN237lUU+JiVSd4
   ZdlD4dYHqCrDD6UATn1JDvXbIPzGzIAu68o0PLD/+rO1g/5Mj90SnM4en
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="358909768"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="358909768"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 09:04:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="850681111"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="850681111"
Received: from jpjenkin-mobl.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.85.240])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 09:04:40 -0700
Subject: [PATCH v2 0/4] ntb: Clean up tx tail index on link down
From: Dave Jiang <dave.jiang@intel.com>
To: jdmason@kudzu.us, allenbh@gmail.com
Cc: Yuan Y Lu <yuan.y.lu@intel.com>, Logan Gunthorpe <logang@deltatee.com>,
 renlonglong <ren.longlong@h3c.com>, ntb@lists.linux.dev
Date: Tue, 22 Aug 2023 09:04:39 -0700
Message-ID: <169272009288.9948.16284771919634911796.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

v2:
- Add Logan's review tag
- Add check to qp->remote_rx_info before reset entry (1/4) since it could be NULL. (longlong)

Several ntb_transport fixes after doing long term continous netdev up/down
testing.

---

Dave Jiang (4):
      ntb: Clean up tx tail index on link down
      ntb: Drop packets when qp link is down
      ntb: Fix calculation ntb_transport_tx_free_entry()
      ntb: Check tx descriptors outstanding instead of head/tail for tx queue


 drivers/ntb/ntb_transport.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

--

