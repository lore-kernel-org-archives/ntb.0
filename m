Return-Path: <jdmason@kudzu.us>
Received: from mail-yw0-x241.google.com (mail-yw0-x241.google.com. [2607:f8b0:4002:c05::241])
        by gmr-mx.google.com with ESMTPS id b68-v6si1345818qkg.5.2018.06.11.20.11.21
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 20:11:21 -0700 (PDT)
Received: by mail-yw0-x241.google.com with SMTP id u124-v6so7039273ywg.0
        for <linux-ntb@googlegroups.com>; Mon, 11 Jun 2018 20:11:21 -0700 (PDT)
Return-Path: <jdmason@kudzu.us>
From: Jon Mason <jdmason@kudzu.us>
Date: Mon, 11 Jun 2018 23:11:18 -0400
Subject: [GIT PULL] NTB changes for v4.18
Message-ID: <20180612031118.GA11519@graymalkin.kudzu.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

Hello Linus,
Here are a few NTB changes for v4.18.  They were tested earlier today by
Dave Jiang, and have been in linux-next for some time.  Please consider
pulling them.

Thanks,
Jon



The following changes since commit 29dcea88779c856c7dc92040a0c01233263101d4:

  Linux 4.17 (2018-06-03 14:15:21 -0700)

are available in the Git repository at:

  git://github.com/jonmason/ntb tags/ntb-4.18

for you to fetch changes up to c9160b69258ef46ab62c27a09decb8fef311e700:

  ntb: ntb_transport: Replace GFP_ATOMIC with GFP_KERNEL in ntb_transport_create_queue (2018-06-11 15:20:59 -0400)

----------------------------------------------------------------
Reorg and clean-up of the Intel NTB driver, a trivial comment change,
and changes of GFP_ATOMIC to GFP_KERNEL where appropriate.

----------------------------------------------------------------
Dave Jiang (3):
      ntb: intel: header definitions refactor
      ntb: intel: split out the gen3 code
      ntb: intel: change references of skx to gen3

Jia-Ju Bai (2):
      ntb: ntb_transport: Replace GFP_ATOMIC with GFP_KERNEL in ntb_transport_setup_qp_mw
      ntb: ntb_transport: Replace GFP_ATOMIC with GFP_KERNEL in ntb_transport_create_queue

Wolfram Sang (1):
      NTB: ntb_hw_idt: fix typo 'can by' to 'can be'

 drivers/ntb/hw/idt/ntb_hw_idt.c                    |   2 +-
 drivers/ntb/hw/intel/Makefile                      |   1 +
 .../ntb/hw/intel/{ntb_hw_intel.c => ntb_hw_gen1.c} | 713 ++-------------------
 drivers/ntb/hw/intel/ntb_hw_gen1.h                 | 182 ++++++
 drivers/ntb/hw/intel/ntb_hw_gen3.c                 | 597 +++++++++++++++++
 drivers/ntb/hw/intel/ntb_hw_gen3.h                 | 110 ++++
 drivers/ntb/hw/intel/ntb_hw_intel.h                | 203 ++----
 drivers/ntb/ntb_transport.c                        |   6 +-
 8 files changed, 1001 insertions(+), 813 deletions(-)
 rename drivers/ntb/hw/intel/{ntb_hw_intel.c => ntb_hw_gen1.c} (74%)
 create mode 100644 drivers/ntb/hw/intel/ntb_hw_gen1.h
 create mode 100644 drivers/ntb/hw/intel/ntb_hw_gen3.c
 create mode 100644 drivers/ntb/hw/intel/ntb_hw_gen3.h
