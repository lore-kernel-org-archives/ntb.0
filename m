Return-Path: <jdmason@kudzu.us>
Received: from mail-qk0-x244.google.com (mail-qk0-x244.google.com. [2607:f8b0:400d:c09::244])
        by gmr-mx.google.com with ESMTPS id f206si1379420ywb.6.2016.08.05.13.26.25
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Aug 2016 13:26:25 -0700 (PDT)
Received: by mail-qk0-x244.google.com with SMTP id x67so6348446qke.1
        for <linux-ntb@googlegroups.com>; Fri, 05 Aug 2016 13:26:25 -0700 (PDT)
Return-Path: <jdmason@kudzu.us>
From: Jon Mason <jdmason@kudzu.us>
Date: Fri, 5 Aug 2016 16:26:21 -0400
Subject: [GIT PULL] NTB bug fixes for v4.8
Message-ID: <20160805202621.GA4159@arkham.kudzu.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

Hello Linus,
Here are a few NTB improvements and bug fixes for 4.8.  Please consider
pulling them.

Thanks,
Jon



The following changes since commit 523d939ef98fd712632d93a5a2b588e477a7565e:

  Linux 4.7 (2016-07-24 12:23:50 -0700)

are available in the git repository at:

  git://github.com/jonmason/ntb tags/ntb-4.8

for you to fetch changes up to 95f1464f695055c72de6044d7c8a2a7a1e0c7ea2:

  NTB: ntb_hw_intel: use local variable pdev (2016-08-05 10:34:13 -0400)

----------------------------------------------------------------
NTB bug fixes for the ntb_tool and ntb_perf, and improvements to the
ntb_perf and ntb_pingpong for increased debugability.  Also,
modification to the ntb_transport layer to increase/decrease the number
of transport entries depending on the ring size.

----------------------------------------------------------------
Allen Hubbe (2):
      NTB: ntb_hw_intel: show BAR size in debugfs info
      NTB: ntb_hw_intel: use local variable pdev

Dave Jiang (1):
      NTB: allocate number transport entries depending on size of ring size

Logan Gunthorpe (14):
      ntb_tool: Fix infinite loop bug when writing spad/peer_spad file
      ntb_tool: BUG: Ensure the buffer size is large enough to return all spads
      ntb_perf: Allow limiting the size of the memory windows
      ntb_tool: Add memory window debug support
      ntb_transport: Check the number of spads the hardware supports
      ntb_perf: Schedule based on time not on performance
      ntb_perf: Improve thread handling to increase robustness
      ntb_perf: Return results by reading the run file
      ntb_perf: Wait for link before running test
      ntb_tool: Postpone memory window initialization for the user
      ntb_tool: Add link status and files to debugfs
      ntb_pingpong: Add a debugfs file to get the ping count
      ntb_perf: clear link_is_up flag when the link goes down.
      ntb_test: Add a selftest script for the NTB subsystem

 MAINTAINERS                             |   1 +
 drivers/ntb/hw/intel/ntb_hw_intel.c     |  49 +++-
 drivers/ntb/ntb_transport.c             |  38 ++-
 drivers/ntb/test/ntb_perf.c             | 240 +++++++++++------
 drivers/ntb/test/ntb_pingpong.c         |  62 ++++-
 drivers/ntb/test/ntb_tool.c             | 459 +++++++++++++++++++++++++++++++-
 tools/testing/selftests/ntb/ntb_test.sh | 422 +++++++++++++++++++++++++++++
 7 files changed, 1172 insertions(+), 99 deletions(-)
 create mode 100755 tools/testing/selftests/ntb/ntb_test.sh
