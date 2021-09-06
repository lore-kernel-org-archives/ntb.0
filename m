Return-Path: <jdmason@kudzu.us>
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com. [2607:f8b0:4864:20::f2b])
        by gmr-mx.google.com with ESMTPS id s30si108142oiw.1.2021.09.06.11.02.10
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Sep 2021 11:02:10 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 93so4362382qva.7
        for <linux-ntb@googlegroups.com>; Mon, 06 Sep 2021 11:02:10 -0700 (PDT)
Return-Path: <jdmason@kudzu.us>
From: Jon Mason <jdmason@kudzu.us>
Date: Mon, 6 Sep 2021 14:02:09 -0400
Subject: [GIT PULL] NTB bug fixes for v5.15
Message-ID: <20210906180209.GA14486@athena.kudzu.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

Hello Linus,
Here are a few NTB bug fixes for v5.15.  Please consider pulling them.

Thanks,
Jon



The following changes since commit 7d2a07b769330c34b4deabeed939325c77a7ec2f:

  Linux 5.14 (2021-08-29 15:04:50 -0700)

are available in the Git repository at:

  git://github.com/jonmason/ntb tags/ntb-5.15

for you to fetch changes up to 38de3afffb7257176978dfa9b3ab67d0c29af95c:

  NTB: switch from 'pci_' to 'dma_' API (2021-09-05 18:08:14 -0400)

----------------------------------------------------------------
Bug fixes and clean-ups for Linux v5.15

----------------------------------------------------------------
Christophe JAILLET (1):
      NTB: switch from 'pci_' to 'dma_' API

Colin Ian King (1):
      ntb: ntb_pingpong: remove redundant initialization of variables msg_data and spad_data

Dave Jiang (1):
      ntb: intel: remove invalid email address in header comment

Yang Li (2):
      NTB: Fix an error code in ntb_msit_probe()
      NTB: perf: Fix an error code in perf_setup_inbuf()

 drivers/ntb/hw/amd/ntb_hw_amd.c     | 12 ++----------
 drivers/ntb/hw/idt/ntb_hw_idt.c     | 15 ++-------------
 drivers/ntb/hw/intel/ntb_hw_gen1.c  | 12 ++----------
 drivers/ntb/hw/intel/ntb_hw_intel.h |  3 ---
 drivers/ntb/test/ntb_msi_test.c     |  4 +++-
 drivers/ntb/test/ntb_perf.c         |  1 +
 drivers/ntb/test/ntb_pingpong.c     |  2 +-
 7 files changed, 11 insertions(+), 38 deletions(-)
