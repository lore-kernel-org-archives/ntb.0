Return-Path: <araut@codeaurora.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org. [198.145.29.96])
        by gmr-mx.google.com with ESMTPS id a2-v6si82008plp.4.2018.05.06.12.20.29
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 May 2018 12:20:29 -0700 (PDT)
From: Atul Raut <araut@codeaurora.org>
Subject: [PATCH v2 0/4] NTB : Introduce message library
Date: Sun,  6 May 2018 12:20:16 -0700
Message-Id: <1525634420-19370-1-git-send-email-araut@codeaurora.org>
To: linux-ntb@googlegroups.com
Cc: Atul Raut <araut@codeaurora.org>
List-ID: <linux-ntb.googlegroups.com>

Hi All,

This is v2 of cleanup series, where have enabled support to ntb_transport layer
for message register based devices. Refactor ntb_perf module to get library
out of it, so that the other client module can make use of it.

This cleanup addresses some of comments by Allen and Dave.

Thanks & Regards,
Atul Raut

Atul Raut (4):
  NTB : Introduce message library
  NTB :  Add message library NTB API
  NTB : Modification to ntb_perf module
  NTB : Add support to message registers based devices

 drivers/ntb/ntb.c           | 222 +++++++++++++++++++++++++++
 drivers/ntb/ntb_transport.c | 357 ++++++++++++++++++++++++++++++++------------
 drivers/ntb/test/ntb_perf.c | 347 +++++-------------------------------------
 include/linux/ntb.h         | 163 ++++++++++++++++++++
 4 files changed, 685 insertions(+), 404 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

