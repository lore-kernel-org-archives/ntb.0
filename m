Return-Path: <gunthorp@cgy1-donard.priv.deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id 62si4842689pfx.1.2016.06.16.13.17.30
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Jun 2016 13:17:30 -0700 (PDT)
From: Logan Gunthorpe <logang@deltatee.com>
Date: Thu, 16 Jun 2016 14:17:03 -0600
Message-Id: <cover.1466098407.git.logang@deltatee.com>
Subject: [PATCH v4 00/10] NTB Selftest Script
To: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>
Cc: Shuah Khan <shuahkh@osg.samsung.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, linux-kselftest@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>
List-ID: <linux-ntb.googlegroups.com>

Hopefully this is the last revision of this set.

Changes since v3:

1) Check the error returned when setting the link in ntb_tool and pass
it back to the user.

2) If an error occurs when setting the link down during a link test in
ntb_test, just print unsupported and continue on. (For hardware that
does not support setting the link down.)

3) Fix a race condition problem introduced by clearing the link is
up flag in ntb_perf. We do this by getting rid of the link cleanup
work and doing the few actions in the link event handler.
Dave Jiang has already ok'd this approach.

---

Changes since v2:

1) As per Allan's suggestion, I've added a patch to postpone the
peer memory window setup until the user requests it with a 'peer_trans*'
file. This pushes the ntb_tool API closer to the kernel API and allows
the link status file to return the raw status of the NTB link.

2) Change the link status file to return the value of ntb_link_is_up
instead of the local 'memory window ready' value.

3) Change the link_event file to just block on write. As it was in v2,
if multiple users attempted to use the link_event file they could
corrupt the state another user had set. Reads to this file are no
longer permitted.

4) Updates to the ntb_test script to accommodate the above changes.

5) Added some link tests to the ntb_test script. It will bring the link
down and check that the other side agrees.

6) Added a minor bug fix (Patch #10) to ntb_perf. During discussions
with Allen it was noticed that the link_is_up flag is never cleared if
the link goes away.

---

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


Logan Gunthorpe (10):
  ntb_perf: Schedule based on time not on performance
  ntb_perf: Improve thread handling to increase robustness
  ntb_perf: Return results by reading the run file
  ntb_perf: Wait for link before running test
  ntb_tool: BUG: Ensure the buffer size is large enough to return all
    spads
  ntb_tool: Postpone memory window initialization for the user
  ntb_tool: Add link status and files to debugfs
  ntb_pingpong: Add a debugfs file to get the ping count
  ntb_test: Add a selftest script for the NTB subsystem
  ntb_perf: clear link_is_up flag when the link goes down.

 MAINTAINERS                             |   1 +
 drivers/ntb/test/ntb_perf.c             | 224 ++++++++++------
 drivers/ntb/test/ntb_pingpong.c         |  62 ++++-
 drivers/ntb/test/ntb_tool.c             | 458 ++++++++++++++++++++++----------
 tools/testing/selftests/ntb/ntb_test.sh | 422 +++++++++++++++++++++++++++++
 5 files changed, 947 insertions(+), 220 deletions(-)
 create mode 100755 tools/testing/selftests/ntb/ntb_test.sh

--
2.1.4
