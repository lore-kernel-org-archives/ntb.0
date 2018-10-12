Return-Path: <asierra@xes-inc.com>
Received: from mail.xes-mad.com (xes-mad.com. [162.248.234.2])
        by gmr-mx.google.com with ESMTP id a84-v6si109584oii.1.2018.10.12.13.20.18
        for <linux-ntb@googlegroups.com>;
        Fri, 12 Oct 2018 13:20:18 -0700 (PDT)
From: Aaron Sierra <asierra@xes-inc.com>
Subject: [PATCH 0/2] NTB: Stash private data in transport client device
Date: Fri, 12 Oct 2018 15:20:16 -0500
Message-Id: <1539375618-6782-1-git-send-email-asierra@xes-inc.com>
To: linux-ntb@googlegroups.com
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, "David S. Miller" <davem@davemloft.net>
List-ID: <linux-ntb.googlegroups.com>

Support NTB transport client device drivers stashing a reference to
their private device representation within the transport client device
for trivial lookup.

Use the new stashing mechanism to simplify ntb_netdev device probe
and remove. This optimization will also benefit any out-of-tree
drivers that care to use it.

Aaron Sierra (2):
  NTB: transport: Support client device private data
  ntb_netdev: Simplify remove with client private data

 drivers/net/ntb_netdev.c      | 28 +++-------------------------
 drivers/ntb/ntb_transport.c   | 19 +++++++++++++++++++
 include/linux/ntb_transport.h |  2 ++
 3 files changed, 24 insertions(+), 25 deletions(-)

-- 
2.7.4

