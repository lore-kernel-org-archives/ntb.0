Return-Path: <jdmason@kudzu.us>
Received: from mail-yw0-x236.google.com (mail-yw0-x236.google.com. [2607:f8b0:4002:c05::236])
        by gmr-mx.google.com with ESMTPS id w69si2085056ywa.3.2016.03.21.16.58.19
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Mar 2016 16:58:19 -0700 (PDT)
Received: by mail-yw0-x236.google.com with SMTP id h129so234170002ywb.1
        for <linux-ntb@googlegroups.com>; Mon, 21 Mar 2016 16:58:19 -0700 (PDT)
Return-Path: <jdmason@kudzu.us>
Received: from kudzu.us ([98.122.145.248])
        by smtp.gmail.com with ESMTPSA id g21sm18966288ywb.15.2016.03.21.16.58.19
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Mar 2016 16:58:19 -0700 (PDT)
Date: Mon, 21 Mar 2016 19:56:29 -0400
From: Jon Mason <jdmason@kudzu.us>
Subject: NTB changes for v4.6
Message-ID: <20160321235629.GB17910@kudzu.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

I have the changes listed below queued for v4.6.  If possible, please
take a moment to test it.  Unless I hear otherwise, I'll be sending a
pull request to Linus on Wednesday.

Thanks,
Jon

---

The following changes since commit b562e44f507e863c6792946e4e1b1449fbbac85d:

  Linux 4.5 (2016-03-13 21:28:54 -0700)

are available in the git repository at:

  git://github.com/jonmason/ntb 

for you to fetch changes up to afc54992296a5e7f7d2e41456ed90789b01a4e7b:

  NTB: Make _addr functions optional in the API (2016-03-21 19:30:06 -0400)

----------------------------------------------------------------
Allen Hubbe (1):
      NTB: Make _addr functions optional in the API

Arnd Bergmann (1):
      ntb: perf test: fix address space confusion

Dave Jiang (5):
      ntb: stop tasklet from spinning forever during shutdown.
      ntb: stop link work when we do not have memory
      ntb: add missing setup of translation window
      NTB: Fix incorrect return check in ntb_perf
      NTB: Fix incorrect clean up routine in ntb_perf

Sudip Mukherjee (1):
      ntb: fix possible NULL dereference

 drivers/ntb/ntb_transport.c | 31 ++++++++++++++----
 drivers/ntb/test/ntb_perf.c | 78 +++++++++++++++++++++++++++------------------
 include/linux/ntb.h         | 10 ++++--
 3 files changed, 79 insertions(+), 40 deletions(-)
