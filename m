Return-Path: <gunthorp@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id 13si126621ios.3.2017.11.29.09.55.53
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Nov 2017 09:55:53 -0800 (PST)
From: Logan Gunthorpe <logang@deltatee.com>
Date: Wed, 29 Nov 2017 10:55:23 -0700
Message-Id: <20171129175530.31032-1-logang@deltatee.com>
Subject: [PATCH 0/7] Switchtec NTB Crosslink Support
To: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>, Kelvin Cao <kelvin.cao@microsemi.com>, Logan Gunthorpe <logang@deltatee.com>
List-ID: <linux-ntb.googlegroups.com>

Hi,

This patch series adds support for the Switchtec Crosslink feature.
Crosslink is similar to B2B in that it allows two switches to be
connected back to back.

Two switches can already be connected between two hosts, however with this
setup, there would be no symmetry as one switch would handle NTB and the
other would just need to be a single partition switch. Our customers are
looking for a completely symmetric solution such that a host or switch
can be easily replaced without needing to worry about which half was
replaced.

Crosslink solves this problem by having each of the switches configured
with two partitions. This results in a special host-less partition in
the middle of the connection which can be managed in such a way as
to forward all the traffic and still provide all the same NTB
functionality. In this way, both hosts and switches can be identical.

Please see Patch 6 for a bit more detailed description of how Crosslink
works.

Thanks,

Logan

Kelvin Cao (1):
  ntb_hw_switchtec: Allow using Switchtec NTB in multi-partition setups

Logan Gunthorpe (6):
  ntb_hw_switchtec: Keep track of the number of LUT windows used by the
    driver
  ntb_hw_switchtec: Create helper function to setup reserved LUT MWs
  ntb_hw_switchtec: Make switchtec_ntb_init_req_id_table() more general
  ntb_hw_switchtec: Expand PFF CSR registers
  ntb_hw_switchtec: Add initialization code for crosslink
  ntb_hw_switchtec: Crosslink doorbells and messages

 drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 494 +++++++++++++++++++++++++++------
 include/linux/ntb.h                    |  15 +-
 include/linux/switchtec.h              |  23 +-
 3 files changed, 435 insertions(+), 97 deletions(-)

--
2.11.0
