Return-Path: <jdmason@kudzu.us>
Received: from mail-yb0-x242.google.com (mail-yb0-x242.google.com. [2607:f8b0:4002:c09::242])
        by gmr-mx.google.com with ESMTPS id q185si1735175ywh.4.2016.11.13.14.21.52
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Nov 2016 14:21:52 -0800 (PST)
Received: by mail-yb0-x242.google.com with SMTP id d128so2055994ybh.3
        for <linux-ntb@googlegroups.com>; Sun, 13 Nov 2016 14:21:52 -0800 (PST)
Return-Path: <jdmason@kudzu.us>
From: Jon Mason <jdmason@kudzu.us>
Date: Sun, 13 Nov 2016 17:21:49 -0500
Subject: [GIT PULL] NTB bug fixes for v4.9
Message-ID: <20161113222148.GA28184@arkham.kudzu.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

Hello Linus,
Here are a few NTB bug fixes for 4.9.  Please consider pulling them.

Thanks,
Jon



The following changes since commit a25f0944ba9b1d8a6813fd6f1a86f1bd59ac25a6:

  Linux 4.9-rc5 (2016-11-13 10:32:32 -0800)

are available in the git repository at:

  git://github.com/jonmason/ntb tags/ntb-4.9

for you to fetch changes up to 819baf885953b588b63bef28e5598daf9ed4ddf9:

  ntb_perf: potential info leak in debugfs (2016-11-13 16:48:30 -0500)

----------------------------------------------------------------
NTB bug fixes for ntb_hw_intel, ntb_perf, and ntb_pingpong.  Also, a
fixup to use jiffies in schedule_timeout_* call instead of a constant.

----------------------------------------------------------------
Dan Carpenter (1):
      ntb_perf: potential info leak in debugfs

Dave Jiang (1):
      ntb: ntb_hw_intel: init peer_addr in struct intel_ntb_dev

Nicholas Mc Guire (2):
      ntb_transport: make DMA_OUT_RESOURCE_TO HZ independent
      ntb: make DMA_OUT_RESOURCE_TO HZ independent

Wei Yongjun (2):
      ntb_pingpong: Fix db_init parameter description
      NTB: ntb_hw_intel: Fix typo in module parameter descriptions

 drivers/ntb/hw/intel/ntb_hw_intel.c | 15 +++++++++------
 drivers/ntb/ntb_transport.c         |  2 +-
 drivers/ntb/test/ntb_perf.c         |  8 ++++----
 drivers/ntb/test/ntb_pingpong.c     |  2 +-
 4 files changed, 15 insertions(+), 12 deletions(-)
