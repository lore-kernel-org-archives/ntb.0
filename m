Return-Path: <gunthorp@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id q23-v6si1503108iog.3.2018.06.08.17.08.27
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Jun 2018 17:08:27 -0700 (PDT)
From: Logan Gunthorpe <logang@deltatee.com>
Date: Fri,  8 Jun 2018 18:08:10 -0600
Message-Id: <20180609000819.13883-1-logang@deltatee.com>
Subject: [PATCH 0/8] Fix breakage caused by the NTB multi-port patchset
To: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Serge Semin <fancer.lancer@gmail.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Shuah Khan <shuah@kernel.org>, Logan Gunthorpe <logang@deltatee.com>
List-ID: <linux-ntb.googlegroups.com>

Hey,

Here are all the fixes required to get ntb_test on switchtec working
again after the multi-port test patches were merged.

I'd appreciate it if future changes can be a) more careful about
not breaking things, b) communicated more clearly so that better
review can be done, and c) not merged until sufficient review actually
is done.

Note, I sent the first patch in this series earlier; please disregard
the earlier one.

Thanks,

Logan

Logan Gunthorpe (8):
  NTB: ntb_tool: reading the link file should not end in a NULL byte
  NTB: Setup the DMA mask globally for all drivers
  NTB: Fix the default port and peer numbers for legacy drivers
  NTB: ntb_pingpong: Choose doorbells based on port number
  NTB: perf: Don't require one more memory window than number of peers
  NTB: perf: Fix support for hardware that doesn't have port numbers
  NTB: perf: Fix race condition when run with ntb_test
  NTB: ntb_test: Fix bug when counting remote files

 drivers/ntb/hw/amd/ntb_hw_amd.c         |  4 ----
 drivers/ntb/hw/idt/ntb_hw_idt.c         |  6 ------
 drivers/ntb/hw/intel/ntb_hw_intel.c     |  4 ----
 drivers/ntb/ntb.c                       | 22 ++++++++++++++--------
 drivers/ntb/test/ntb_perf.c             | 22 +++++++++++++++++++---
 drivers/ntb/test/ntb_pingpong.c         | 14 ++++++--------
 drivers/ntb/test/ntb_tool.c             |  3 +--
 tools/testing/selftests/ntb/ntb_test.sh |  2 +-
 8 files changed, 41 insertions(+), 36 deletions(-)

--
2.11.0
