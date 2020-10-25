Return-Path: <jdmason@kudzu.us>
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com. [2607:f8b0:4864:20::842])
        by gmr-mx.google.com with ESMTPS id v8si436233pgj.1.2020.10.25.06.36.41
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Oct 2020 06:36:41 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id q26so4847335qtb.5
        for <linux-ntb@googlegroups.com>; Sun, 25 Oct 2020 06:36:41 -0700 (PDT)
Return-Path: <jdmason@kudzu.us>
From: Jon Mason <jdmason@kudzu.us>
Date: Sun, 25 Oct 2020 09:36:37 -0400
Subject: [GIT PULL] NTB bug fixes for v5.10
Message-ID: <20201025133637.GA7862@athena.kudzu.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

Hello Linus,
Here are a few NTB bug fixes for v5.10.  Please consider pulling them.

Thanks,
Jon

The following changes since commit d012a7190fc1fd72ed48911e77ca97ba4521bccd:

  Linux 5.9-rc2 (2020-08-23 14:08:43 -0700)

are available in the Git repository at:

  git://github.com/jonmason/ntb tags/ntb-5.10

for you to fetch changes up to b8e2c8bbdf7778c6e3c65db21ababb1dfa794282:

  NTB: Use struct_size() helper in devm_kzalloc() (2020-08-24 10:58:06 -0400)

----------------------------------------------------------------
Bug fixes for v5.10

----------------------------------------------------------------
Dinghao Liu (1):
      ntb: intel: Fix memleak in intel_ntb_pci_probe

Gustavo A. R. Silva (1):
      NTB: Use struct_size() helper in devm_kzalloc()

Kaige Li (1):
      NTB: hw: amd: fix an issue about leak system resources

 drivers/ntb/hw/amd/ntb_hw_amd.c    | 1 +
 drivers/ntb/hw/intel/ntb_hw_gen1.c | 2 +-
 drivers/ntb/test/ntb_msi_test.c    | 5 +----
 3 files changed, 3 insertions(+), 5 deletions(-)
