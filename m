Return-Path: <jdmason@kudzu.us>
Received: from mail-yw1-xc2d.google.com (mail-yw1-xc2d.google.com. [2607:f8b0:4864:20::c2d])
        by gmr-mx.google.com with ESMTPS id h7si137994uap.0.2019.03.15.13.26.12
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 13:26:12 -0700 (PDT)
Received: by mail-yw1-xc2d.google.com with SMTP id m207so8294950ywd.5
        for <linux-ntb@googlegroups.com>; Fri, 15 Mar 2019 13:26:12 -0700 (PDT)
Return-Path: <jdmason@kudzu.us>
From: Jon Mason <jdmason@kudzu.us>
Date: Fri, 15 Mar 2019 16:26:09 -0400
Subject: [GIT PULL] NTB bug fixes for v5.1
Message-ID: <20190315202609.GA30826@graymalkin.kudzu.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

Hello Linus,
Here are a few NTB fixes for v5.1.  While the tag is new, the patches
have been in my tree (and thus linux-next) for weeks now.  Please
consider pulling them.

Thanks,
Jon



The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://github.com/jonmason/ntb tags/ntb-5.1

for you to fetch changes up to ebb09b33c60c46fd4f7ffa0af9e693eebe765d1b:

  NTB: add new parameter to peer_db_addr() db_bit and db_data (2019-02-13 11:03:18 -0500)

----------------------------------------------------------------
Fixes for switchtec debugability and mapping table entries, NTB
transport improvements, and a reworking of the peer_db_addr to all for
better abstraction

----------------------------------------------------------------
Joey Zhang (1):
      NTB: ntb_transport: Free MWs in ntb_transport_link_cleanup()

Leonid Ravich (1):
      NTB: add new parameter to peer_db_addr() db_bit and db_data

Logan Gunthorpe (1):
      NTB: ntb_transport: Ensure the destination buffer is mapped for TX DMA

Paul Selles (2):
      ntb_hw_switchtec: debug print 64bit aligned crosslink BAR Numbers
      ntb_hw_switchtec: Added support of >=4G memory windows

Wesley Sheng (1):
      ntb_hw_switchtec: NT req id mapping table register entry number should be 512

 drivers/ntb/hw/intel/ntb_hw_gen1.c     | 25 +++++++++++++++++++------
 drivers/ntb/hw/intel/ntb_hw_gen1.h     |  5 +++--
 drivers/ntb/hw/intel/ntb_hw_gen3.c     | 33 ++++++++++++++++++++++++++++++++-
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 20 ++++++++++++++++----
 drivers/ntb/ntb_transport.c            | 31 +++++++++++++++++++++++++++++--
 include/linux/ntb.h                    | 10 +++++++---
 include/linux/switchtec.h              | 10 +++++++---
 7 files changed, 113 insertions(+), 21 deletions(-)
