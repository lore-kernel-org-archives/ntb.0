Return-Path: <kchow@gigaio.com>
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com. [2607:f8b0:4864:20::236])
        by gmr-mx.google.com with ESMTPS id j125si231967pfb.1.2019.09.06.16.17.09
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2019 16:17:09 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id w6so6373456oie.11
        for <linux-ntb@googlegroups.com>; Fri, 06 Sep 2019 16:17:08 -0700 (PDT)
Return-Path: <kchow@gigaio.com>
Subject: Re: AMD IO_PAGE_FAULT w/NTB on Write ops?
References: <CAOQPn8sX2G-Db-ZiFpP2SMKbkQnPyk63UZijAY0we+DoZsmDtQ@mail.gmail.com>
 <a5a2d312-f6af-f20f-0594-98a7f80c7a9d@deltatee.com>
From: Kit Chow <kchow@gigaio.com>
Message-ID: <f98f7970-455c-dddb-f60f-8a33f87f844c@gigaio.com>
Date: Fri, 6 Sep 2019 16:17:05 -0700
MIME-Version: 1.0
In-Reply-To: <a5a2d312-f6af-f20f-0594-98a7f80c7a9d@deltatee.com>
Content-Type: multipart/alternative;
 boundary="------------85F7104AC962DBA0A466644C"
Content-Language: en-US
To: linux-ntb <linux-ntb@googlegroups.com>, linux-pci@vger.kernel.org
Cc: Logan Gunthorpe <logang@deltatee.com>, Eric Pilmore <epilmore@gigaio.com>, S Taylor <staylor@gigaio.com>, D Meyer <dmeyer@gigaio.com>
List-ID: <linux-ntb.googlegroups.com>

This is a multi-part message in MIME format.
--------------85F7104AC962DBA0A466644C
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit

This is a follow-up of the initial problems encountered trying to get 
the AMD Epyc 7401
server to do host to host communication through NTB. (please see thread for
background info).

The IO_PAGE_FAULT flags=0x0070 seen on write ops was in fact related to 
proxy ID setup
as Logan had suggested. The AMD iommu code only processed the 'last' 
proxy ID/dma alias;
the last proxy ID was associated with Reads and this allowed Read ops to 
succeed and
Write ops to fail. Adding support to process all of the proxy IDs in the 
AMD iommu code
(plus adding dma_map_resource support), the AMD Epyc server can now be 
configured in a
4 host NTB setup and communicate over NTB (tcp/ip over ntb_netdev) to 
the other 3 hosts.

The problem that we are now experiencing, for which I can use some help, 
with the AMD
Epyc 7401 server is very poor iperf performance over NTB/ntb_netdev.

The iperf numbers over NTB start off initially at around 800 Mbits/s and 
quickly degrades
down to the 20 Mbits/s range. Running 'top' during iperf, I see many 
instances of ksoftirqd
running which suggests that interrupts are overwhelming the interrupt 
processing.


ID USER      PR  NI    VIRT    RES    SHR S %CPU %MEM     TIME+ COMMAND
13321 root      20   0       0      0      0 I  33.2  0.0 0:15.62 
kworker/58+
   528 root      20   0       0      0      0 S  31.6  0.0 0:02.80 
ksoftirqd/+
   139 root      20   0       0      0      0 S  30.9  0.0 0:02.86 
ksoftirqd/+
   536 root      20   0       0      0      0 S  29.9  0.0 0:02.60 
ksoftirqd/+
   147 root      20   0       0      0      0 S  28.9  0.0 0:02.69 
ksoftirqd/+
   131 root      20   0       0      0      0 S  28.3  0.0 0:02.74 
ksoftirqd/+
   520 root      20   0       0      0      0 S  28.0  0.0 0:02.63 
ksoftirqd/+
    82 root      20   0       0      0      0 S   3.0  0.0 0:00.35 
ksoftirqd/9
    90 root      20   0       0      0      0 S   3.0  0.0 0:00.31 
ksoftirqd/+
    98 root      20   0       0      0      0 S   3.0  0.0 0:00.37 
ksoftirqd/+
   472 root      20   0       0      0      0 S   3.0  0.0 0:00.35 
ksoftirqd/+
   488 root      20   0       0      0      0 S   3.0  0.0 0:00.37 
ksoftirqd/+
   416 root      20   0       0      0      0 S   2.6  0.0 0:00.17 
ksoftirqd/+
    25 root      20   0       0      0      0 S   2.3  0.0 0:00.17 
ksoftirqd/2
   400 root      20   0       0      0      0 R   2.3  0.0 0:00.16 
ksoftirqd/+
    17 root      20   0       0      0      0 R   2.0  0.0 0:00.17 
ksoftirqd/1
   408 root      20   0       0      0      0 S   2.0  0.0 0:00.16 
ksoftirqd/+
     8 root      20   0       0      0      0 R   1.6  0.0 0:00.16 
ksoftirqd/0
   480 root      20   0       0      0      0 S   1.6  0.0 0:00.21 
ksoftirqd/+
13434 user      20   0  246428  22248   2000 S   1.6  0.0 0:01.00 iperf
13516 user      20   0  163252   5792   3796 R   1.6  0.0 0:00.40 top
  7950 root      20   0       0      0      0 D   1.0  0.0 0:00.62 ccp-5-q2
  7951 root      20   0       0      0      0 S   1.0  0.0 0:00.67 ccp-5-q3
     9 root      20   0       0      0      0 I   0.3  0.0 0:00.31 rcu_sched
    57 root      20   0       0      0      0 S   0.3  0.0 0:00.01 
ksoftirqd/6
    66 root      20   0       0      0      0 S   0.3  0.0 0:00.01 
ksoftirqd/7
    74 root      20   0       0      0      0 S   0.3  0.0 0:00.01 
ksoftirqd/8
   106 root      20   0       0      0      0 S   0.3  0.0 0:00.03 
ksoftirqd/+
   115 root      20   0       0      0      0 S   0.3  0.0 0:00.02 
ksoftirqd/+
   123 root      20   0       0      0      0 S   0.3  0.0 0:00.02 
ksoftirqd/+


/proc/interrupts show lots of 'ccp-5' dma interrupt activity as well as 
ntb_netdev interrupt
activity. After eliminating netdev interrupts by configuring netdev to 
'use_poll' and
leaving ccp, the poor iperf performance persists.

As a comparison, I can replace the ccp dma with the plx dma (found on 
the host adapter card)
on the AMD server and get a steady 9.4 Gbits/s with iperf over NTB.

I've optmimized for numa via numactl in all test runs.

So it appears that the iperf NTB performance issues on the AMD Epyc 
server are related to the
ccp dma and its interrupt processing.

Does anyone have any experience with the ccp dma that might be able to help?

Any help or suggestions on how to proceed would be very much appreciated.

Thanks
Kit

kchow@gigaio.com

--------------85F7104AC962DBA0A466644C
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <tt>This is a follow-up of the initial problems encountered trying
      to get the AMD Epyc 7401<br>
      server to do host to host communication through NTB. (please see
      thread for<br>
      background info).<br>
      <br>
      The IO_PAGE_FAULT flags=0x0070 seen on write ops was in fact
      related to proxy ID setup<br>
      as Logan had suggested. The AMD iommu code only processed the
      'last' proxy ID/dma alias;<br>
      the last proxy ID was associated with Reads and this allowed Read
      ops to succeed and<br>
      Write ops to fail. Adding support to process all of the proxy IDs
      in the AMD iommu code<br>
      (plus adding dma_map_resource support), the AMD Epyc server can
      now be configured in a<br>
      4 host NTB setup and communicate over NTB (tcp/ip over ntb_netdev)
      to the other 3 hosts.<br>
      <br>
      The problem that we are now experiencing, for which I can use some
      help, with the AMD<br>
      Epyc 7401 server is very poor iperf performance over
      NTB/ntb_netdev. <br>
      <br>
      The iperf numbers over NTB start off initially at around 800
      Mbits/s and quickly degrades<br>
      down to the 20 Mbits/s range. Running 'top' during iperf, I see
      many instances of ksoftirqd<br>
      running which suggests that interrupts are overwhelming the
      interrupt processing. <br>
      <br>
    </tt><tt><tt><br>
      </tt><font size="-1">ID USER      PR  NI    VIRT    RES    SHR S 
        %CPU %MEM     TIME+ COMMAND<br>
        13321 root      20   0       0      0      0 I  33.2  0.0  
        0:15.62 kworker/58+<br>
          528 root      20   0       0      0      0 S  31.6  0.0  
        0:02.80 ksoftirqd/+<br>
          139 root      20   0       0      0      0 S  30.9  0.0  
        0:02.86 ksoftirqd/+<br>
          536 root      20   0       0      0      0 S  29.9  0.0  
        0:02.60 ksoftirqd/+<br>
          147 root      20   0       0      0      0 S  28.9  0.0  
        0:02.69 ksoftirqd/+<br>
          131 root      20   0       0      0      0 S  28.3  0.0  
        0:02.74 ksoftirqd/+<br>
          520 root      20   0       0      0      0 S  28.0  0.0  
        0:02.63 ksoftirqd/+<br>
           82 root      20   0       0      0      0 S   3.0  0.0  
        0:00.35 ksoftirqd/9<br>
           90 root      20   0       0      0      0 S   3.0  0.0  
        0:00.31 ksoftirqd/+<br>
           98 root      20   0       0      0      0 S   3.0  0.0  
        0:00.37 ksoftirqd/+<br>
          472 root      20   0       0      0      0 S   3.0  0.0  
        0:00.35 ksoftirqd/+<br>
          488 root      20   0       0      0      0 S   3.0  0.0  
        0:00.37 ksoftirqd/+<br>
          416 root      20   0       0      0      0 S   2.6  0.0  
        0:00.17 ksoftirqd/+<br>
           25 root      20   0       0      0      0 S   2.3  0.0  
        0:00.17 ksoftirqd/2<br>
          400 root      20   0       0      0      0 R   2.3  0.0  
        0:00.16 ksoftirqd/+<br>
           17 root      20   0       0      0      0 R   2.0  0.0  
        0:00.17 ksoftirqd/1<br>
          408 root      20   0       0      0      0 S   2.0  0.0  
        0:00.16 ksoftirqd/+<br>
            8 root      20   0       0      0      0 R   1.6  0.0  
        0:00.16 ksoftirqd/0<br>
          480 root      20   0       0      0      0 S   1.6  0.0  
        0:00.21 ksoftirqd/+<br>
        13434 user      20   0  246428  22248   2000 S   1.6  0.0  
        0:01.00 iperf<br>
        13516 user      20   0  163252   5792   3796 R   1.6  0.0  
        0:00.40 top<br>
         7950 root      20   0       0      0      0 D   1.0  0.0  
        0:00.62 ccp-5-q2<br>
         7951 root      20   0       0      0      0 S   1.0  0.0  
        0:00.67 ccp-5-q3<br>
            9 root      20   0       0      0      0 I   0.3  0.0  
        0:00.31 rcu_sched<br>
           57 root      20   0       0      0      0 S   0.3  0.0  
        0:00.01 ksoftirqd/6<br>
           66 root      20   0       0      0      0 S   0.3  0.0  
        0:00.01 ksoftirqd/7<br>
           74 root      20   0       0      0      0 S   0.3  0.0  
        0:00.01 ksoftirqd/8<br>
          106 root      20   0       0      0      0 S   0.3  0.0  
        0:00.03 ksoftirqd/+<br>
          115 root      20   0       0      0      0 S   0.3  0.0  
        0:00.02 ksoftirqd/+<br>
          123 root      20   0       0      0      0 S   0.3  0.0  
        0:00.02 ksoftirqd/+</font><br>
      <br>
    </tt><br>
    <tt><tt>/proc/interrupts show lots of 'ccp-5' dma interrupt activity
        as well as ntb_netdev interrupt<br>
        activity. After eliminating netdev interrupts by configuring
        netdev to 'use_poll' and <br>
        leaving ccp, the poor iperf performance persists.<br>
      </tt><tt><tt></tt></tt></tt><tt><tt><tt><tt><br>
            As a comparison, I can replace the ccp dma with the plx dma
            (found on the host adapter card) <br>
            on the AMD server and get a steady 9.4 Gbits/s with iperf
            over NTB.<br>
            <br>
            I've optmimized for numa via numactl in all test runs.</tt>
          <br>
          <br>
          So it appears that the iperf NTB performance issues on the AMD
          Epyc server are related to the<br>
          ccp dma and its interrupt processing.<br>
          <br>
          Does anyone have any experience with the ccp dma that might be
          able to help?<br>
          <br>
          Any help or suggestions on how to proceed would be very much
          appreciated.<br>
          <br>
          Thanks<br>
          Kit<br>
          <br>
          <a class="moz-txt-link-abbreviated" href="mailto:kchow@gigaio.com">kchow@gigaio.com</a> </tt></tt></tt><br>
  </body>
</html>

--------------85F7104AC962DBA0A466644C--
