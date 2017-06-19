Return-Path: <jdmason@kudzu.us>
Received: from mail-qk0-x22e.google.com (mail-qk0-x22e.google.com. [2607:f8b0:400d:c09::22e])
        by gmr-mx.google.com with ESMTPS id p68si716009ywg.9.2017.06.19.11.42.53
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Jun 2017 11:42:53 -0700 (PDT)
Received: by mail-qk0-x22e.google.com with SMTP id g83so40401492qkb.3
        for <linux-ntb@googlegroups.com>; Mon, 19 Jun 2017 11:42:53 -0700 (PDT)
Return-Path: <jdmason@kudzu.us>
From: Jon Mason <jdmason@kudzu.us>
Date: Mon, 19 Jun 2017 14:42:45 -0400
Subject: [GIT PULL] NTB bug fixes for v4.12
Message-ID: <20170619184245.GA20187@graymalkin.kudzu.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

Hello Linus,
Here are a few NTB bug fixes for 4.12.  Please consider pulling them.

Thanks,
Jon



The following changes since commit 41f1830f5a7af77cf5c86359aba3cbd706687e52:

  Linux 4.12-rc6 (2017-06-19 22:19:37 +0800)

are available in the git repository at:

  git://github.com/jonmason/ntb tags/ntb-4.12-bugfixes

for you to fetch changes up to 88931ec3dc11e7dbceb3b0df455693873b508fbe:

  ntb: no sleep in ntb_async_tx_submit (2017-06-19 14:24:41 -0400)

----------------------------------------------------------------
NTB bug fixes to address the modinfo in ntb_perf, a couple of bugs in
the NTB transport QP calculations, skx doorbells,  and sleeping in
ntb_async_tx_submit.

----------------------------------------------------------------
Allen Hubbe (1):
      ntb: no sleep in ntb_async_tx_submit

Dave Jiang (1):
      ntb: ntb_hw_intel: Skylake doorbells should be 32bits, not 64bits

Gary R Hook (1):
      ntb: Correct modinfo usage statement for ntb_perf

Logan Gunthorpe (3):
      NTB: ntb_test: fix bug printing ntb_perf results
      ntb_transport: fix qp count bug
      ntb_transport: fix bug calculating num_qps_mw

 drivers/ntb/hw/intel/ntb_hw_intel.c     |  2 +-
 drivers/ntb/ntb_transport.c             | 58 +++++++--------------------------
 drivers/ntb/test/ntb_perf.c             |  4 +--
 tools/testing/selftests/ntb/ntb_test.sh |  2 +-
 4 files changed, 15 insertions(+), 51 deletions(-)
