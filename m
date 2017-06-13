Return-Path: <jdmason@kudzu.us>
Received: from mail-ua0-x233.google.com (mail-ua0-x233.google.com. [2607:f8b0:400c:c08::233])
        by gmr-mx.google.com with ESMTPS id 200si1097690vkk.10.2017.06.13.07.19.37
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Jun 2017 07:19:37 -0700 (PDT)
Received: by mail-ua0-x233.google.com with SMTP id m31so76207076uam.1
        for <linux-ntb@googlegroups.com>; Tue, 13 Jun 2017 07:19:37 -0700 (PDT)
MIME-Version: 1.0
From: Jon Mason <jdmason@kudzu.us>
Date: Tue, 13 Jun 2017 10:19:36 -0400
Message-ID: <CAPoiz9wgXa7K-H10w3XrnbDKrw_ku_neY0SwCnOYvJkDEATaRg@mail.gmail.com>
Subject: Bug fix pull request coming soon
Content-Type: text/plain; charset="UTF-8"
To: linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

Below is roughly the pull request for bug fixes going to Linus today.
If you have time, please test.

FYI, I missed the merge window for the features a few weeks ago by a
few hours.  I still have those patches queued, and I rebased them on
top of these patches.  So, those will not be going until 4.13, but
they are ready when that merge window opens.  Sorry for the delay.

Thanks,
Jon

---

The following changes since commit 32c1431eea4881a6b17bd7c639315010aeefa452:

  Linux 4.12-rc5 (2017-06-11 16:48:20 -0700)

are available in the git repository at:

  git://github.com/jonmason/ntb

for you to fetch changes up to 88ff6f155eb14e7538b8f4bceef242ad6ac127b7:

  ntb: no sleep in ntb_async_tx_submit (2017-06-13 09:57:01 -0400)

----------------------------------------------------------------
Allen Hubbe (1):
      ntb: no sleep in ntb_async_tx_submit

Dave Jiang (1):
      ntb: ntb_hw_intel: Skylake doorbells should be 32bits, not 64bits

Gary R Hook (1):
      ntb: Correct modinfo usage statement for ntb_perf

Logan Gunthorpe (3):
      NTB: ntb_test: fix bug printing ntb_perf results
      ntb_transport: fix qp count bug
      ntb_transport: fix bug calculating num_qps_mw

 drivers/ntb/hw/intel/ntb_hw_intel.c     |  2 +-
 drivers/ntb/ntb_transport.c             | 58
+++++++++++-----------------------------------------------
 drivers/ntb/test/ntb_perf.c             |  4 ++--
 tools/testing/selftests/ntb/ntb_test.sh |  2 +-
 4 files changed, 15 insertions(+), 51 deletions(-)
