Return-Path: <jdmason@kudzu.us>
Received: from mail-yk0-x22a.google.com (mail-yk0-x22a.google.com. [2607:f8b0:4002:c07::22a])
        by gmr-mx.google.com with ESMTPS id c68si586769ywf.3.2015.11.08.13.42.59
        for <linux-ntb@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Nov 2015 13:42:59 -0800 (PST)
Received: by mail-yk0-x22a.google.com with SMTP id k133so236488583yke.2
        for <linux-ntb@googlegroups.com>; Sun, 08 Nov 2015 13:42:59 -0800 (PST)
Return-Path: <jdmason@kudzu.us>
From: Jon Mason <jdmason@kudzu.us>
Date: Sun, 8 Nov 2015 16:42:56 -0500
Subject: [GIT PULL] NTB bug fixes for v4.4
Message-ID: <20151108214256.GA17230@arkham.kudzu.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

Hello Linus,
Here are a few NTB bug fixes for 4.4.  Please consider pulling them.

Thanks,
Jon



The following changes since commit 6a13feb9c82803e2b815eca72fa7a9f5561d7861:

  Linux 4.3 (2015-11-01 16:05:25 -0800)

are available in the git repository at:

  git://github.com/jonmason/ntb tags/ntb-4.4

for you to fetch changes up to fdcb4b2e78220bde95ce4ba3213088e3a1f1cec6:

  NTB: fix 32-bit compiler warning (2015-11-08 16:24:43 -0500)

----------------------------------------------------------------
NTB Bug fixes for potential NULL pointer accesses, accesses of a freed
pointer, invalid buffer pointer, and a compiler warning.  Also,
unification of upstream/downstream addresses.

----------------------------------------------------------------
Arnd Bergmann (1):
      NTB: fix 32-bit compiler warning

Dave Jiang (2):
      NTB: Fix issue where we may be accessing NULL ptr
      NTB: unify translation addresses

Jon Mason (1):
      NTB: invalid buf pointer in multi-MW setups

Sudip Mukherjee (2):
      NTB: fix access of free-ed pointer
      NTB: remove unused variable

 drivers/ntb/hw/intel/ntb_hw_intel.c | 16 +++++++-------
 drivers/ntb/hw/intel/ntb_hw_intel.h | 15 +++++--------
 drivers/ntb/ntb_transport.c         | 44 +++++++++++++++++--------------------
 3 files changed, 33 insertions(+), 42 deletions(-)
