Return-Path: <kchow@gigaio.com>
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com. [2607:f8b0:4864:20::232])
        by gmr-mx.google.com with ESMTPS id w72si457424pfd.2.2019.09.06.16.48.37
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2019 16:48:37 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 7so6441097oip.5
        for <linux-ntb@googlegroups.com>; Fri, 06 Sep 2019 16:48:37 -0700 (PDT)
Return-Path: <kchow@gigaio.com>
Subject: Re: AMD Epyc iperf perfomance issues over NTB
References: <CAOQPn8sX2G-Db-ZiFpP2SMKbkQnPyk63UZijAY0we+DoZsmDtQ@mail.gmail.com>
 <a5a2d312-f6af-f20f-0594-98a7f80c7a9d@deltatee.com>
 <bce9a1d6-1c37-b9f8-a613-2ba68211fee1@deltatee.com>
From: Kit Chow <kchow@gigaio.com>
Message-ID: <d719f986-f9ce-a0c3-f9a1-1fe06a3cc0cc@gigaio.com>
Date: Fri, 6 Sep 2019 16:48:32 -0700
MIME-Version: 1.0
In-Reply-To: <bce9a1d6-1c37-b9f8-a613-2ba68211fee1@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: linux-ntb <linux-ntb@googlegroups.com>, linux-pci@vger.kernel.org
Cc: Logan Gunthorpe <logang@deltatee.com>, "Eric Pilmore (GigaIO)" <epilmore@gigaio.com>
List-ID: <linux-ntb.googlegroups.com>

This is a follow-up of the initial problems encountered trying to get 
the AMD Epyc 7401server to do host to host communication through NTB. 
(please see thread for background info).

The IO_PAGE_FAULT flags=0x0070 seen on write ops was in fact related to 
proxy ID setup as Logan had suggested. The AMD iommu code only processed 
the 'last' proxy ID/dma alias; the last proxy ID was associated with 
Reads and this allowed Read ops to succeed and Write ops to fail. Adding 
support to process all of the proxy IDs in the AMD iommu code (plus 
adding dma_map_resource support), the AMD Epyc server can now be 
configured in a 4 host NTB setup and communicate over NTB (tcp/ip over 
ntb_netdev) to the other 3 hosts.

The problem that we are now experiencing, for which I can use some help, 
with the AMD Epyc 7401 server is very poor iperf performance over 
NTB/ntb_netdev.

The iperf numbers over NTB start off initially at around 800 Mbits/s and 
quickly degrades down to the 20 Mbits/s range. Running 'top' during 
iperf, I see many instances (up to 25+) of ksoftirqd running which 
suggests that interrupts are overwhelming the interrupt processing.

/proc/interrupts show lots of 'ccp-5' dma interrupt activity as well as 
ntb_netdev interrupt activity. After eliminating netdev interrupts by 
configuring netdev to 'use_poll' and leaving ccp, the poor iperf 
performance persists.

As a comparison, I can replace the ccp dma with the plx dma (found on 
the host adapter card) on the AMD server and get a steady 9.4 Gbits/s 
with iperf over NTB.

I've optmimized for numa via numactl in all test runs.

So it appears that the iperf NTB performance issues on the AMD Epyc 
server are related to the ccp dma and its interrupt processing.


Does anyone have any experience with the ccp dma that might be able to help?

Any help or suggestions on how to proceed would be very much appreciated.

Thanks
Kit

kchow@gigaio.com
