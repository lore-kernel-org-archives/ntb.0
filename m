Return-Path: <gunthorp@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id r8si872083pfa.5.2017.01.10.16.33.17
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jan 2017 16:33:17 -0800 (PST)
From: Logan Gunthorpe <logang@deltatee.com>
Date: Tue, 10 Jan 2017 17:32:09 -0700
Message-Id: <1484094731-15965-1-git-send-email-logang@deltatee.com>
Subject: [PATCH 0/2] Style fixes: open code obfuscating macros
To: Xiangliang Yu <Xiangliang.Yu@amd.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>, Joe Perches <joe@perches.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>
List-ID: <linux-ntb.googlegroups.com>

Hi,

I had copied some poor code style from the NTB drivers into an unrelated
driver. Upon review of my new code, I learned it was not a good idea
to sweep dirty things under the rug^W macro. See [1], where Gregg k-h
suggested I fix the problem at the source.

Thus, please merge the following two patches to improve the style of
the NTB drivers.

Thanks,

Logan

[1] http://www.spinics.net/lists/linux-pci/msg56904.html


Logan Gunthorpe (2):
  ntb_hw_amd: Style fixes: open code macros that just obfuscate code
  ntb_hw_intel: Style fixes: open code macros that just obfuscate code

 drivers/ntb/hw/amd/ntb_hw_amd.c     |  59 ++++++++-------
 drivers/ntb/hw/amd/ntb_hw_amd.h     |   3 -
 drivers/ntb/hw/intel/ntb_hw_intel.c | 145 ++++++++++++++++++------------------
 drivers/ntb/hw/intel/ntb_hw_intel.h |   3 -
 4 files changed, 104 insertions(+), 106 deletions(-)

--
2.1.4
