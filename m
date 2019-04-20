Return-Path: <epilmore@gigaio.com>
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com. [2a00:1450:4864:20::432])
        by gmr-mx.google.com with ESMTPS id t137si329876wmt.0.2019.04.20.02.06.44
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Apr 2019 02:06:44 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id g3so9541267wrx.9
        for <linux-ntb@googlegroups.com>; Sat, 20 Apr 2019 02:06:44 -0700 (PDT)
MIME-Version: 1.0
From: Eric Pilmore <epilmore@gigaio.com>
Date: Sat, 20 Apr 2019 02:06:33 -0700
Message-ID: <CAOQPn8sX2G-Db-ZiFpP2SMKbkQnPyk63UZijAY0we+DoZsmDtQ@mail.gmail.com>
Subject: AMD IO_PAGE_FAULT w/NTB on Write ops?
Content-Type: text/plain; charset="UTF-8"
To: linux-ntb <linux-ntb@googlegroups.com>, linux-pci@vger.kernel.org
Cc: S Taylor <staylor@gigaio.com>, D Meyer <dmeyer@gigaio.com>
List-ID: <linux-ntb.googlegroups.com>

Hi Folks,

Before I ask my questions, here is a little background on the
environment I have:
- 2 hosts: 1 Xeon based (Intel(R) Xeon(R) Gold 5115 CPU @ 2.40GHz),
                1 AMD based (AMD EPYC 7401 24-Core Processor)
- Each host is interconnected via an external PCI-e (switchtec) switch.
- The two hosts are exporting memory to each other via NTB.
- IOMMU is enabled in both hosts. The Xeon platform requires some BIOS
settings and a kernel parameter (intel_iommu=on), however as far as I
have been able to determine, the AMD only requires the IOMMU BIOS
setting to be enabled and no special kernel boot parameters. Does that
sound right for AMD?
- Region of memory exported to each host is acquired/mapped via
dma_alloc_coherent() using the "device" of the respective external
PCI-e switch.
- The dma_addr returned from the dma_alloc_coherent is relayed to the
peer host who then adds that value (i.e. IOVA offset) to it's local
PCI BAR representing the switch, and then ioremap()'s that resulting
address to get a CPU virtual address to which it can now perform
ioread/iowrite operations.

What we have found is that the Xeon based host can successfully ioread
to this mapped shared buffer, but whenever it attempts an iowrite to
this region, it results in an IO_PAGE_FAULT on the AMD based host:

AMD-Vi: Event logged [IO_PAGE_FAULT device=23:01.2 domain=0x0000
address=0x00000000fde1c18c flags=0x0070]

Going in the opposite direction there are no issues, i.e. the AMD
based host can successfully ioread/iowrite to the mapped in buffer
exported by the Xeon host.  Or if both hosts are Xeon's, then
everything works fine also.

I have looked high and low, and have not been able to interpret what
the "flags=0x0070" represent. I assume they are indicating some write
permission error, but was wondering if anybody here might know?

More importantly, does anybody know why the AMD IOMMU might seemingly
default to not allow Write operations to the exported memory? Is there
some additional BIOS or kernel boot parameter setting that needs to be
set?

lspci on the AMD hosts of the external PCI-e switch:
   23:00.0 PCI bridge: PMC-Sierra Inc. Device 8536
   23:00.1 Bridge: PMC-Sierra Inc. Device 8536

The 23:00.1 BDF is the NTB bridge. The BDF (23:01.2) in the error
message represents the "NTB translated" BDF of the request that came
from the peer, i.e. the 01.2 is the proxy-id. Is there a chance that
this proxy-id is causing some confusion for the AMD IOMMU?

Would greatly appreciate any assistance!

Thanks!

-- 
Eric Pilmore
epilmore@gigaio.com
http://gigaio.com
Phone: (858) 775 2514

This e-mail message is intended only for the individual(s) to whom it
is addressed and
may contain information that is privileged, confidential, proprietary,
or otherwise exempt
from disclosure under applicable law. If you believe you have received
this message in
error, please advise the sender by return e-mail and delete it from
your mailbox.
Thank you.
