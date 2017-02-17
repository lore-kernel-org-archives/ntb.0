Return-Path: <jdmason@kudzu.us>
Received: from mail-qk0-x234.google.com (mail-qk0-x234.google.com. [2607:f8b0:400d:c09::234])
        by gmr-mx.google.com with ESMTPS id y63si1218336ywe.5.2017.02.16.20.24.30
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Feb 2017 20:24:30 -0800 (PST)
Received: by mail-qk0-x234.google.com with SMTP id s186so35004405qkb.1
        for <linux-ntb@googlegroups.com>; Thu, 16 Feb 2017 20:24:30 -0800 (PST)
Return-Path: <jdmason@kudzu.us>
From: Jon Mason <jdmason@kudzu.us>
Date: Thu, 16 Feb 2017 23:24:22 -0500
Subject: [GIT PULL] NTB bug fixes for vv4.10
Message-ID: <20170217042422.GA10511@graymalkin.kudzu.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

Hello Linus,
Here are a few last minute NTB bug fixes for v4.10.  They are fairly
critical, and would appreicate them getting pulled in (though I
understand this is extremely late in the cycle).

Thanks,
Jon



The following changes since commit 7089db84e356562f8ba737c29e472cc42d530dbc:

  Linux 4.10-rc8 (2017-02-12 13:03:20 -0800)

are available in the git repository at:

  git://github.com/jonmason/ntb tags/ntb-4.10-bugfixes

for you to fetch changes up to 939ada5fb587840ae4db47846087be4162477b13:

  ntb: ntb_hw_intel: link_poll isn't clearing the pending status properly (2017-02-16 23:11:26 -0500)

----------------------------------------------------------------
NTB bug fixes to address a crash when unloading the ntb module, a DMA
engine unmap leak, allowing the proper queue choice, and clearing the
SKX irq bit.

----------------------------------------------------------------
Allen Hubbe (1):
      NTB: ntb_transport: fix debugfs_remove_recursive

Dave Jiang (2):
      ntb: ntb_perf missing dmaengine_unmap_put
      ntb: ntb_hw_intel: link_poll isn't clearing the pending status properly

Thomas VanSelus (1):
      ntb_transport: Pick an unused queue

 drivers/ntb/hw/intel/ntb_hw_intel.c | 24 +++++++++++++++++++++++-
 drivers/ntb/ntb_transport.c         |  5 ++---
 drivers/ntb/test/ntb_perf.c         |  2 ++
 3 files changed, 27 insertions(+), 4 deletions(-)
