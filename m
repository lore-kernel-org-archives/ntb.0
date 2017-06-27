Return-Path: <gunthorp@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id j141si235767itb.6.2017.06.27.16.02.12
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Jun 2017 16:02:12 -0700 (PDT)
From: Logan Gunthorpe <logang@deltatee.com>
Date: Tue, 27 Jun 2017 17:02:01 -0600
Message-Id: <20170627230204.16410-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [PATCH v2 0/3] make io{read|write}64 more globally usable
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-ntb@googlegroups.com, linux-crypto@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jyri Sarha <jsarha@ti.com>, Stephen Bates <sbates@raithlin.com>, Logan Gunthorpe <logang@deltatee.com>
List-ID: <linux-ntb.googlegroups.com>

Hi,

This is my second attempt to cleanup the io{read|write}64 functions so
that I can use them in a new driver[1]. This time, per a suggestion from Arnd,
we simply add the io64 functions to the io-64-nonatomic headers and
cleanup the two obvious drivers. (Horia provided me with a corrected patch
for the crypto caam which I have included.)

I've droped the tilcdc patch as it does not appear to support
non-atomic accesses, so it's hack around iowrite64 will remain.

Thanks,

Logan

[1] https://marc.info/?l=linux-kernel&m=149774601910663&w=2

Horia Geantă (1):
  crypto: caam: cleanup CONFIG_64BIT ifdefs when using io{read|write}64

Logan Gunthorpe (2):
  io-64-nonatomic: add io{read|write}64[be] macros
  ntb: ntb_hw_intel: use io-64-nonatomic instead of in-driver hacks

 drivers/crypto/caam/regs.h            | 35 +++++------------------------------
 drivers/ntb/hw/intel/ntb_hw_intel.c   | 31 +------------------------------
 include/linux/io-64-nonatomic-hi-lo.h | 16 ++++++++++++++++
 include/linux/io-64-nonatomic-lo-hi.h | 16 ++++++++++++++++
 4 files changed, 38 insertions(+), 60 deletions(-)

--
2.11.0
