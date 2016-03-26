Return-Path: <jdmason@kudzu.us>
Received: from mail-qk0-x229.google.com (mail-qk0-x229.google.com. [2607:f8b0:400d:c09::229])
        by gmr-mx.google.com with ESMTPS id w69si1255687ywa.3.2016.03.26.09.16.59
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Mar 2016 09:16:59 -0700 (PDT)
Received: by mail-qk0-x229.google.com with SMTP id i4so21522244qkc.3
        for <linux-ntb@googlegroups.com>; Sat, 26 Mar 2016 09:16:59 -0700 (PDT)
Return-Path: <jdmason@kudzu.us>
From: Jon Mason <jdmason@kudzu.us>
Date: Sat, 26 Mar 2016 12:15:08 -0400
Subject: [GIT PULL] NTB bug fixes for v4.6
Message-ID: <20160326161508.GA4550@arkham.kudzu.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

Hello Linus,
Here are a few NTB bug fixes for 4.6.  Please consider pulling them.

Thanks,
Jon



The following changes since commit b562e44f507e863c6792946e4e1b1449fbbac85d:

  Linux 4.5 (2016-03-13 21:28:54 -0700)

are available in the git repository at:

  git://github.com/jonmason/ntb tags/ntb-4.6

for you to fetch changes up to 4f1b50c3e3082b31c94cee2b897bd9f5d0f3e7c8:

  NTB: Remove _addr functions from ntb_hw_amd (2016-03-26 11:44:33 -0400)

----------------------------------------------------------------
NTB bug fixes for tasklet from spinning forever, link errors,
translation window setup, NULL ptr dereference, and ntb-perf errors.
Also, a modification to the driver API that makes _addr functions
optional.

----------------------------------------------------------------
Allen Hubbe (2):
      NTB: Make _addr functions optional in the API
      NTB: Remove _addr functions from ntb_hw_amd

Arnd Bergmann (1):
      ntb: perf test: fix address space confusion

Dave Jiang (5):
      ntb: stop tasklet from spinning forever during shutdown.
      ntb: stop link work when we do not have memory
      ntb: add missing setup of translation window
      NTB: Fix incorrect return check in ntb_perf
      NTB: Fix incorrect clean up routine in ntb_perf

Sudip Mukherjee (1):
      ntb: fix possible NULL dereference

 drivers/ntb/hw/amd/ntb_hw_amd.c | 30 ----------------
 drivers/ntb/ntb_transport.c     | 31 ++++++++++++----
 drivers/ntb/test/ntb_perf.c     | 78 +++++++++++++++++++++++++----------------
 include/linux/ntb.h             | 10 ++++--
 4 files changed, 79 insertions(+), 70 deletions(-)
