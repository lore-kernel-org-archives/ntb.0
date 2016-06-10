Return-Path: <gunthorp@cgy1-donard.priv.deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id 62si1013750pfx.1.2016.06.10.15.55.28
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Jun 2016 15:55:28 -0700 (PDT)
From: Logan Gunthorpe <logang@deltatee.com>
Date: Fri, 10 Jun 2016 16:54:03 -0600
Message-Id: <cover.1465598632.git.logang@deltatee.com>
Subject: [PATCH 0/8] NTB Selftest Script
To: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>
Cc: Shuah Khan <shuahkh@osg.samsung.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, linux-kselftest@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>
List-ID: <linux-ntb.googlegroups.com>

Hi,

I've written a ntb_test.sh script that would probably be useful if it
were included in the kernel. This series ends with that script and
includes some useful interface improvements and fixes to the existing ntb
test modules. Please see each individual commit for more information.
They are mostly independent.

The series is based off of v4.6 plus the patches I've submitted that
have been accepted into ntb-next. They've been run through checkpatch
with --strict this time.

As always, I'm happy to incorporate any feedback.

Thanks,

Logan


Logan Gunthorpe (8):
  ntb_perf: Schedule based on time not on performance
  ntb_perf: Improve thread handling to increase robustness
  ntb_perf: Return results by reading the run file
  ntb_perf: Wait for link before running test
  ntb_tool: BUG: Ensure the buffer size is large enough to return all
    spads
  ntb_tool: Add link status file to debugfs
  ntb_pingpong: Add a debugfs file to get the ping count
  ntb_test: Add a selftest script for the NTB subsystem

 MAINTAINERS                             |   1 +
 drivers/ntb/test/ntb_perf.c             | 196 +++++++++++-----
 drivers/ntb/test/ntb_pingpong.c         |  68 +++++-
 drivers/ntb/test/ntb_tool.c             |  50 ++++-
 tools/testing/selftests/ntb/ntb_test.sh | 386 ++++++++++++++++++++++++++++++++
 5 files changed, 638 insertions(+), 63 deletions(-)
 create mode 100755 tools/testing/selftests/ntb/ntb_test.sh

--
2.1.4
