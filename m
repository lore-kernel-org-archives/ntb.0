Return-Path: <jdmason@kudzu.us>
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com. [2607:f8b0:4864:20::f34])
        by gmr-mx.google.com with ESMTPS id 8926c6da1cb9f-301a18e3cadsi663211173.4.2022.01.16.07.23.00
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jan 2022 07:23:00 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id kl12so15545831qvb.5
        for <linux-ntb@googlegroups.com>; Sun, 16 Jan 2022 07:23:00 -0800 (PST)
Return-Path: <jdmason@kudzu.us>
From: Jon Mason <jdmason@kudzu.us>
Date: Sun, 16 Jan 2022 10:22:59 -0500
Subject: [GIT PULL] NTB bug fixes for vv5.17
Message-ID: <YeQ4Uz9mNkff+ypm@n00b.kudzu.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

Hello Linus,
Here are a few NTB bug fixes for v5.17.  Please consider pulling them.

Thanks,
Jon



The following changes since commit df0cc57e057f18e44dac8e6c18aba47ab53202f9:

  Linux 5.16 (2022-01-09 14:55:34 -0800)

are available in the Git repository at:

  git://github.com/jonmason/ntb tags/ntb-5.17

for you to fetch changes up to 8cd778650ae223cd306588042b55d0290ef81037:

  ntb_hw_switchtec: Fix a minor issue in config_req_id_table() (2022-01-11 15:38:59 -0500)

----------------------------------------------------------------
New AMD PCI ID for NTB, and a number of bug fixes for ntb_hw_switchtec
for Linux v5.17

----------------------------------------------------------------
Jeremy Pallotta (2):
      ntb_hw_switchtec: Fix pff ioread to read into mmio_part_cfg_all
      ntb_hw_switchtec: AND with the part_map for a valid tpart_vec

Kelvin Cao (3):
      ntb_hw_switchtec: Update the way of getting VEP instance ID
      ntb_hw_switchtec: Remove code for disabling ID protection
      ntb_hw_switchtec: Fix a minor issue in config_req_id_table()

Randy Dunlap (1):
      ntb_hw_switchtec: fix the spelling of "its"

Sanjay R Mehta (1):
      ntb_hw_amd: Add NTB PCI ID for new gen CPU

Wesley Sheng (1):
      ntb_hw_switchtec: Fix bug with more than 32 partitions

Yang Li (1):
      NTB/msi: Fix ntbm_msi_request_threaded_irq() kernel-doc comment

 drivers/ntb/hw/amd/ntb_hw_amd.c        |  2 ++
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 26 ++++++++++++--------------
 drivers/ntb/msi.c                      |  3 ++-
 include/linux/switchtec.h              |  2 --
 4 files changed, 16 insertions(+), 17 deletions(-)
