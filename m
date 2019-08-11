Return-Path: <jdmason@kudzu.us>
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com. [2607:f8b0:4864:20::b31])
        by gmr-mx.google.com with ESMTPS id f125si5077953pgc.4.2019.08.11.07.17.08
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2019 07:17:08 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id t5so4593014ybt.4
        for <linux-ntb@googlegroups.com>; Sun, 11 Aug 2019 07:17:08 -0700 (PDT)
Return-Path: <jdmason@kudzu.us>
From: Jon Mason <jdmason@kudzu.us>
Date: Sun, 11 Aug 2019 10:17:03 -0400
Subject: [GIT PULL] NTB bug fixes for v5.3
Message-ID: <20190811141703.GA12153@graymalkin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

Hello Linus,
Here is a trivial NTB bug fix for v5.3.  Please consider pulling it.

Thanks,
Jon



The following changes since commit e21a712a9685488f5ce80495b37b9fdbe96c230d:

  Linux 5.3-rc3 (2019-08-04 18:40:12 -0700)

are available in the Git repository at:

  git://github.com/jonmason/ntb tags/ntb-5.3-bugfixes

for you to fetch changes up to 49da065f7b1f27be625de65d6d55bdd22ac6b5c2:

  NTB/msi: remove incorrect MODULE defines (2019-08-05 15:42:27 -0400)

----------------------------------------------------------------
Bug fix for NTB MSI kernel compile warning

----------------------------------------------------------------
Logan Gunthorpe (1):
      NTB/msi: remove incorrect MODULE defines

 drivers/ntb/msi.c | 5 -----
 1 file changed, 5 deletions(-)
