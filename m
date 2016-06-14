Return-Path: <gunthorp@cgy1-donard.priv.deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id tp10si3644326pac.2.2016.06.14.10.02.38
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jun 2016 10:02:38 -0700 (PDT)
From: Logan Gunthorpe <logang@deltatee.com>
Date: Tue, 14 Jun 2016 11:02:20 -0600
Message-Id: <cover.1465919682.git.logang@deltatee.com>
Subject: [PATCH v2 0/8] NTB Selftest Script
To: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>
Cc: Shuah Khan <shuahkh@osg.samsung.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, linux-kselftest@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>
List-ID: <linux-ntb.googlegroups.com>

Changes since v1:

1) Add a comment to explain the *15 in the buf size calculation,
as per Allen's feedback.

2) Clean up the changes to the pingpong client as there were some
sloppy copying mistakes.

3) Rework the 'link' file in ntb_tool as per Allen's suggestions.
I've added a 'link_event' file the works essentially how he's asked.
Though, I found no need to use a completion as suggested and the flow
is maybe slightly simpler than he's suggested. Just write a boolean
to the event file then read to wait for the link to be either up or
down. There's still some discussion on the best interface and it's
not much work to make additional minor functional changes.

4) Update the selftest script to use the new 'link_event' file.

5) Minor change to the way the selftest script lists devices thanks to
Allen's observation.

---

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

---

Logan Gunthorpe (8):
  ntb_perf: Schedule based on time not on performance
  ntb_perf: Improve thread handling to increase robustness
  ntb_perf: Return results by reading the run file
  ntb_perf: Wait for link before running test
  ntb_tool: BUG: Ensure the buffer size is large enough to return all
    spads
  ntb_tool: Add link status and files to debugfs
  ntb_pingpong: Add a debugfs file to get the ping count
  ntb_test: Add a selftest script for the NTB subsystem

 MAINTAINERS                             |   1 +
 drivers/ntb/test/ntb_perf.c             | 196 +++++++++++-----
 drivers/ntb/test/ntb_pingpong.c         |  62 +++++-
 drivers/ntb/test/ntb_tool.c             | 121 +++++++++-
 tools/testing/selftests/ntb/ntb_test.sh | 384 ++++++++++++++++++++++++++++++++
 5 files changed, 700 insertions(+), 64 deletions(-)
 create mode 100755 tools/testing/selftests/ntb/ntb_test.sh

--
2.1.4
