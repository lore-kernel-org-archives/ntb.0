Return-Path: <Allen.Hubbe@dell.com>
Received: from esa6.dell-outbound.iphmx.com (esa6.dell-outbound.iphmx.com. [68.232.149.229])
        by gmr-mx.google.com with ESMTPS id b135si551978vka.6.2017.06.01.06.01.12
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Jun 2017 06:01:12 -0700 (PDT)
From: "Allen Hubbe" <Allen.Hubbe@dell.com>
References: <592FDBC4.9000406@163.com>
In-Reply-To: <592FDBC4.9000406@163.com>
Subject: RE: [BUG] ntb: Sleep in interrupt handling
Date: Thu, 1 Jun 2017 09:00:32 -0400
Message-ID: <000001d2dad7$0e4eba30$2aec2e90$@dell.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
To: 'Jia-Ju Bai' <baijiaju1990@163.com>, jdmason@kudzu.us, dave.jiang@intel.com
Cc: linux-ntb@googlegroups.com, 'LKML' <linux-kernel@vger.kernel.org>
List-ID: <linux-ntb.googlegroups.com>

From: Jia-Ju Bai 
> According to ntb_transport.c, the driver may sleep in interrupt handling.
> The function call path is:
> ntb_transport_rxc_db (tasklet_init indicates it handles interrupt)
>    ntb_process_rxc
>      ntb_async_rx
>        ntb_async_rx_submit
>          schedule_timeout --> may sleep
> 
> This bug is found by my static analysis tool and my code review.
> I hope to fix it, but I do not have a good solution.

Thanks! There is a recovery path if ntb_async_tx_submit fails.  It will do the transmission with memcpy instead of dma.  So, rather than retry in ntb_async_tx_submit, just fail to the recovery path.  Basically, replace the whole for(retries) loop with just txd = prep();  Would you like to work on the patch?

> 
> Thanks,
> Jia-Ju Bai


