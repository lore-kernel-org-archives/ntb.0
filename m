Return-Path: <baijiaju1990@163.com>
Received: from m12-11.163.com (m12-11.163.com. [220.181.12.11])
        by gmr-mx.google.com with ESMTP id m6si1454698pfa.12.2017.06.01.02.15.47
        for <linux-ntb@googlegroups.com>;
        Thu, 01 Jun 2017 02:15:47 -0700 (PDT)
Message-ID: <592FDBC4.9000406@163.com>
Date: Thu, 01 Jun 2017 17:17:56 +0800
From: Jia-Ju Bai <baijiaju1990@163.com>
MIME-Version: 1.0
Subject: [BUG] ntb: Sleep in interrupt handling
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com
Cc: linux-ntb@googlegroups.com, LKML <linux-kernel@vger.kernel.org>
List-ID: <linux-ntb.googlegroups.com>

According to ntb_transport.c, the driver may sleep in interrupt handling.
The function call path is:
ntb_transport_rxc_db (tasklet_init indicates it handles interrupt)
   ntb_process_rxc
     ntb_async_rx
       ntb_async_rx_submit
         schedule_timeout --> may sleep

This bug is found by my static analysis tool and my code review.
I hope to fix it, but I do not have a good solution.

Thanks,
Jia-Ju Bai

