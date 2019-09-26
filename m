Return-Path: <jdmason@kudzu.us>
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com. [2607:f8b0:4864:20::743])
        by gmr-mx.google.com with ESMTPS id h184si197395vka.3.2019.09.26.10.35.25
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2019 10:35:25 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id f16so2470183qkl.9
        for <linux-ntb@googlegroups.com>; Thu, 26 Sep 2019 10:35:25 -0700 (PDT)
Return-Path: <jdmason@kudzu.us>
From: Jon Mason <jdmason@kudzu.us>
Date: Thu, 26 Sep 2019 13:35:22 -0400
Subject: [GIT PULL] NTB changes for v5.4
Message-ID: <20190926173522.GA15861@graymalkin>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

Hello Linus,
Here are a few NTB bug fixes and a new AMD device support for v5.4.  Please=
 consider pulling them.

Thanks,
Jon



The following changes since commit 4d856f72c10ecb060868ed10ff1b1453943fc6c8:

  Linux 5.3 (2019-09-15 14:19:32 -0700)

are available in the Git repository at:

  git://github.com/jonmason/ntb tags/ntb-5.4

for you to fetch changes up to 4720101fab62d0453babb0287b58a9c5bf78fb80:

  NTB: fix IDT Kconfig typos/spellos (2019-09-23 17:20:40 -0400)

----------------------------------------------------------------
A few bug=EF=BF=BDfixes and support for new AMD NTB Hardware

----------------------------------------------------------------
Alexander Fomichev (1):
      ntb_hw_switchtec: make ntb_mw_set_trans() work when addr =3D=3D 0

Colin Ian King (1):
      NTB: ntb_transport: remove redundant assignment to rc

Randy Dunlap (1):
      NTB: fix IDT Kconfig typos/spellos

Sanjay R Mehta (3):
      ntb: point to right memory window index
      ntb_hw_amd: Add a new NTB PCI device ID
      ntb_hw_amd: Add memory window support for new AMD hardware

 drivers/ntb/hw/amd/ntb_hw_amd.c        | 22 ++++++++++++++++++----
 drivers/ntb/hw/amd/ntb_hw_amd.h        |  8 ++++++--
 drivers/ntb/hw/idt/Kconfig             |  6 +++---
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c |  2 +-
 drivers/ntb/ntb_transport.c            |  2 +-
 drivers/ntb/test/ntb_perf.c            |  2 +-
 6 files changed, 30 insertions(+), 12 deletions(-)
