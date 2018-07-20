Return-Path: <gunthorp@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id s15-v6si94079iog.0.2018.07.20.11.00.41
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 11:00:41 -0700 (PDT)
From: Logan Gunthorpe <logang@deltatee.com>
Date: Fri, 20 Jul 2018 12:00:26 -0600
Message-Id: <20180720180034.3964-1-logang@deltatee.com>
Subject: [PATCH v2 0/8] Fix breakage caused by the NTB multi-port patchset
To: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, Jon Mason <jdmason@kudzu.us>
Cc: Allen Hubbe <allenbh@gmail.com>, Serge Semin <fancer.lancer@gmail.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Shuah Khan <shuah@kernel.org>, Doug Meyer <dmeyer@gigaio.com>, Logan Gunthorpe <logang@deltatee.com>
List-ID: <linux-ntb.googlegroups.com>

Hey,

This is mostly a resend.

To reiterate the main points on the feedback: the switchtec driver,
in the cross link mode, will not be able to implement the port number
function callbacks and will have to always return 0. It's a physical
impossibility due to the symmetry. Therefore, in order fix this feature
(which worked when merged), the clients must be changed to support not
knowing the port number in the way they worked previously (ie. a legacy
mode where there will only be two ports and you know there will be two
sets of doorbells, one for each peer). The majority of this patch set
fixes these issues.

The other point of controversy is the dma mask. I still strongly
disagree with doing it in the driver as the code is clearly common
to all and not at all driver specific. Moreover, I think as written,
it is extra dangerous seeing all impleminting drivers are operating on
the new struct device before it's initialized in ntb_register().
Patch 2 in this series also fixes that.

Logan

--

Changes since v1:
- Rebased onto ntb-next (there was a minor conflict in a recent change
  to the intel driver)
- Collected Dave's ack.

--

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
 drivers/ntb/hw/intel/ntb_hw_gen1.c      |  4 ----
 drivers/ntb/ntb.c                       | 22 ++++++++++++++--------
 drivers/ntb/test/ntb_perf.c             | 22 +++++++++++++++++++---
 drivers/ntb/test/ntb_pingpong.c         | 14 ++++++--------
 drivers/ntb/test/ntb_tool.c             |  3 +--
 tools/testing/selftests/ntb/ntb_test.sh |  2 +-
 8 files changed, 41 insertions(+), 36 deletions(-)

--
2.11.0
