Return-Path: <gunthorp@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id r8si872283pfa.5.2017.01.10.16.33.45
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jan 2017 16:33:45 -0800 (PST)
From: Logan Gunthorpe <logang@deltatee.com>
Date: Tue, 10 Jan 2017 17:33:35 -0700
Message-Id: <1484094819-16084-1-git-send-email-logang@deltatee.com>
Subject: [PATCH v2 0/4] Style fixes: open code obfuscating macros
To: Xiangliang Yu <Xiangliang.Yu@amd.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>, Joe Perches <joe@perches.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>
List-ID: <linux-ntb.googlegroups.com>

Hi,

Here's an updated version of the style fixes patchset. The differences
from v1 are:

1) Rebased onto Jon Mason's current NTB branch

2) Added two more patches to convert the print lines to use the ntb
device and not the pci one. This seems more sane, shortens a bunch
of lines and removes the need for temporaries.

Note with (2): I've tried my best to ensure that statements that print
before the ntb device is registered still use the PCI device. However,
someone should probably review and test this as I don't have access
to all types of hardware to do that.

Thanks,

Logan



Logan Gunthorpe (4):
  ntb_hw_amd: Style fixes: open code macros that just obfuscate code
  ntb_hw_intel: Style fixes: open code macros that just obfuscate code
  ntb_hw_amd: Print kernel messages with the ntb device not the pci one
  ntb_hw_intel: Print kernel messages with the ntb device not the pci
    one

 drivers/ntb/hw/amd/ntb_hw_amd.c     |  60 +++++------
 drivers/ntb/hw/amd/ntb_hw_amd.h     |   3 -
 drivers/ntb/hw/intel/ntb_hw_intel.c | 192 +++++++++++++++++-------------------
 drivers/ntb/hw/intel/ntb_hw_intel.h |   3 -
 4 files changed, 124 insertions(+), 134 deletions(-)

--
2.1.4
