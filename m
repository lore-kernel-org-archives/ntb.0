Return-Path: <jdmason@kudzu.us>
Received: from mail-yw0-x241.google.com (mail-yw0-x241.google.com. [2607:f8b0:4002:c05::241])
        by gmr-mx.google.com with ESMTPS id h18si1850439ywc.2.2016.12.24.07.55.09
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Dec 2016 07:55:09 -0800 (PST)
Received: by mail-yw0-x241.google.com with SMTP id r204so18532527ywb.3
        for <linux-ntb@googlegroups.com>; Sat, 24 Dec 2016 07:55:09 -0800 (PST)
Return-Path: <jdmason@kudzu.us>
From: Jon Mason <jdmason@kudzu.us>
Date: Sat, 24 Dec 2016 10:55:02 -0500
Subject: [GIT PULL] NTB bug fixes for v4.10
Message-ID: <20161224155502.GA13401@arkham.kudzu.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

Hello Linus,
Here are a few NTB bug fixes, new HE support, and updates to AMD NTB for
4.10.  Please consider pulling them.

Thanks,
Jon



The following changes since commit 69973b830859bc6529a7a0468ba0d80ee5117826:

  Linux 4.9 (2016-12-11 11:17:54 -0800)

are available in the git repository at:

  git://github.com/jonmason/ntb tags/ntb-4.10

for you to fetch changes up to dfb7d24c5ad5c986f2417f52784738b67cfedd4d:

  ntb_transport: Remove unnecessary call to ntb_peer_spad_read (2016-12-23 16:11:07 -0500)

----------------------------------------------------------------
NTB bug fixes for removing an unnecessary call to ntb_peer_spad_read,
and correcting a free_irq inconsistency.  It adds Intel SKX support.
Finally, it changes the AMD NTB maintainer, and fixes some bugs present
there.

----------------------------------------------------------------
Christophe JAILLET (1):
      NTB: Fix 'request_irq()' and 'free_irq()' inconsistancy

Dave Jiang (2):
      ntb: Adding Skylake Xeon NTB support
      ntb: fix SKX NTB config space size register offsets

Shyam Sundar S K (3):
      NTB: Register and offset values fix for memory window
      ntb_transport: Limit memory windows based on available, scratchpads
      MAINTAINERS: Change in maintainer for AMD NTB

Steve Wahl (1):
      ntb_transport: Remove unnecessary call to ntb_peer_spad_read

Steven Wahl (1):
      NTB: correct ntb_peer_spad_read for case when callback is not supplied.

Xiangliang Yu (1):
      NTB: add support for hotplug feature

 MAINTAINERS                         |   2 +-
 drivers/ntb/hw/amd/ntb_hw_amd.c     |  25 +-
 drivers/ntb/hw/amd/ntb_hw_amd.h     |   5 +-
 drivers/ntb/hw/intel/ntb_hw_intel.c | 662 +++++++++++++++++++++++++++++++++++-
 drivers/ntb/hw/intel/ntb_hw_intel.h |  48 +++
 drivers/ntb/ntb_transport.c         |  29 +-
 include/linux/ntb.h                 |   3 +
 7 files changed, 741 insertions(+), 33 deletions(-)
