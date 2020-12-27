Return-Path: <jdmason@kudzu.us>
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com. [2607:f8b0:4864:20::72d])
        by gmr-mx.google.com with ESMTPS id h11si691956pjv.3.2020.12.27.06.16.39
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Dec 2020 06:16:39 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id p14so7045654qke.6
        for <linux-ntb@googlegroups.com>; Sun, 27 Dec 2020 06:16:39 -0800 (PST)
Return-Path: <jdmason@kudzu.us>
From: Jon Mason <jdmason@kudzu.us>
Date: Sun, 27 Dec 2020 09:16:38 -0500
Subject: [GIT PULL] NTB bug fixes for v5.11
Message-ID: <20201227141638.GA11393@athena.kudzu.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

Hello Linus,
Here are a few NTB bug fixes for v5.11.  Please consider pulling them.

Thanks,
Jon

The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  git://github.com/jonmason/ntb tags/ntb-5.11

for you to fetch changes up to 75b6f6487cedd0e4c8e07d68b68b8f85cd352bfe:

  ntb: intel: add Intel NTB LTR vendor support for gen4 NTB (2020-12-06 18:18:03 -0500)

----------------------------------------------------------------
Big fix for IDT NTB and Intel NTB LTR management support

----------------------------------------------------------------
Dave Jiang (1):
      ntb: intel: add Intel NTB LTR vendor support for gen4 NTB

Wang Qing (1):
      ntb: idt: fix error check in ntb_hw_idt.c

 drivers/ntb/hw/idt/ntb_hw_idt.c    |  4 ++--
 drivers/ntb/hw/intel/ntb_hw_gen1.h |  1 +
 drivers/ntb/hw/intel/ntb_hw_gen4.c | 27 ++++++++++++++++++++++++++-
 drivers/ntb/hw/intel/ntb_hw_gen4.h | 15 +++++++++++++++
 4 files changed, 44 insertions(+), 3 deletions(-)
