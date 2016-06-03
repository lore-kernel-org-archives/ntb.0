Return-Path: <gunthorp@cgy1-donard.priv.deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id f69si889843pfc.1.2016.06.03.13.53.20
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Jun 2016 13:53:20 -0700 (PDT)
From: Logan Gunthorpe <logang@deltatee.com>
Date: Fri,  3 Jun 2016 14:50:30 -0600
Message-Id: <cover.1464986161.git.logang@deltatee.com>
Subject: [PATCH 0/3] ntb: Fixes and enhancements to ntb tools
To: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>, John Kading <john.kading@gd-ms.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>
List-ID: <linux-ntb.googlegroups.com>

Hi,

I've been working on developing an experimental NTB driver for some
custom hardware and I've found the need to make some minor enhancements
to the NTB layer.

1) I've modified ntb_perf to take an option similar to ntb_transport
which limits the memory window size. This was useful seeing the mws
I'm dealing with are much larger than the available coherent memory I
can allocate.

2) I've added code to ntb_perf and ntb_transport to check that there
are enough scratchpad registers. (As I was hit by a problem where my
hardware did not have enough for ntb_transport, and I would have liked
better information on the cause of the issue.)

3) Added support to debug and test memory windows to ntb_tool. A
coherent buffer is added when the link comes up, and then a debugfs
file for each mw and peer mw is added which allows reading and writing
the buffer. This was useful for me to debug window alignment issues I
was having.

I'm happy to make any revisions to these patches if anyone finds any
issues.

Thanks,

Logan


Logan Gunthorpe (3):
  ntb_perf: Allow limiting the size of the memory windows
  ntb_transport: Check the number of spads the hardware supports
  ntb_tool: Add memory window debug support

 drivers/ntb/ntb_transport.c |   9 +-
 drivers/ntb/test/ntb_perf.c |  16 ++-
 drivers/ntb/test/ntb_tool.c | 258 +++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 278 insertions(+), 5 deletions(-)

--
2.1.4
