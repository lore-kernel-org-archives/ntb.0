Return-Path: <jdmason@kudzu.us>
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com. [2607:f8b0:4864:20::830])
        by gmr-mx.google.com with ESMTPS id v64si781021ywa.4.2019.12.07.13.42.44
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Dec 2019 13:42:44 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id g17so5200860qtp.11
        for <linux-ntb@googlegroups.com>; Sat, 07 Dec 2019 13:42:44 -0800 (PST)
Return-Path: <jdmason@kudzu.us>
From: Jon Mason <jdmason@kudzu.us>
Date: Sat, 7 Dec 2019 16:42:42 -0500
Subject: [GIT PULL] NTB patches for v5.5
Message-ID: <20191207214242.GA22441@graymalkin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

Hello Linus,
Here is the NTB pull request for v5.5.  It only contains a simple patch to add a new NTB Device ID.  Please consider pulling it.

Thanks,
Jon



The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the Git repository at:

  git://github.com/jonmason/ntb tags/ntb-5.5

for you to fetch changes up to 9b5b99a89f641555d9d00452afb0a8aea4471eba:

  NTB: Add Hygon Device ID (2019-12-07 16:29:44 -0500)

----------------------------------------------------------------
Add Hygon Device ID to the AMD NTB device driver

----------------------------------------------------------------
Jiasen Lin (1):
      NTB: Add Hygon Device ID

 drivers/ntb/hw/amd/ntb_hw_amd.c | 1 +
 1 file changed, 1 insertion(+)
