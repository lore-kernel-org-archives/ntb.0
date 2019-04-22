Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id m20si793786qtq.0.2019.04.22.10.14.53
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Apr 2019 10:14:54 -0700 (PDT)
References: <CAOQPn8sX2G-Db-ZiFpP2SMKbkQnPyk63UZijAY0we+DoZsmDtQ@mail.gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <a5a2d312-f6af-f20f-0594-98a7f80c7a9d@deltatee.com>
Date: Mon, 22 Apr 2019 11:14:50 -0600
MIME-Version: 1.0
In-Reply-To: <CAOQPn8sX2G-Db-ZiFpP2SMKbkQnPyk63UZijAY0we+DoZsmDtQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Subject: Re: AMD IO_PAGE_FAULT w/NTB on Write ops?
To: Eric Pilmore <epilmore@gigaio.com>, linux-ntb <linux-ntb@googlegroups.com>, linux-pci@vger.kernel.org
Cc: S Taylor <staylor@gigaio.com>, D Meyer <dmeyer@gigaio.com>
List-ID: <linux-ntb.googlegroups.com>



On 2019-04-20 3:06 a.m., Eric Pilmore wrote:
> What we have found is that the Xeon based host can successfully ioread
> to this mapped shared buffer, but whenever it attempts an iowrite to
> this region, it results in an IO_PAGE_FAULT on the AMD based host:
> 
> AMD-Vi: Event logged [IO_PAGE_FAULT device=23:01.2 domain=0x0000
> address=0x00000000fde1c18c flags=0x0070]
> 
> Going in the opposite direction there are no issues, i.e. the AMD
> based host can successfully ioread/iowrite to the mapped in buffer
> exported by the Xeon host.  Or if both hosts are Xeon's, then
> everything works fine also.
> 
> I have looked high and low, and have not been able to interpret what
> the "flags=0x0070" represent. I assume they are indicating some write
> permission error, but was wondering if anybody here might know?

See the AMD IOMMU spec[1]. Figure 51. 0x0070 indicates the PE, RW and PR
bits are set which means a Write request to a present page was denied
because the peripheral did not have permission.

> More importantly, does anybody know why the AMD IOMMU might seemingly
> default to not allow Write operations to the exported memory? Is there
> some additional BIOS or kernel boot parameter setting that needs to be
> set?

Yeah, I don't think the IOMMU defaults to allow write operations to
exported memory. That would be extremely broken....

> lspci on the AMD hosts of the external PCI-e switch:
>    23:00.0 PCI bridge: PMC-Sierra Inc. Device 8536
>    23:00.1 Bridge: PMC-Sierra Inc. Device 8536
> 
> The 23:00.1 BDF is the NTB bridge. The BDF (23:01.2) in the error
> message represents the "NTB translated" BDF of the request that came
> from the peer, i.e. the 01.2 is the proxy-id. Is there a chance that
> this proxy-id is causing some confusion for the AMD IOMMU?

I suspect the proxy IDs are the problem. On Intel hardware, we had to
add support so that it allowed requests for all proxy IDs for a given
device. We probably have to do something similar to the AMD IOMMU driver.

My guess is that the reason writes work and not reads is because the
write TLPs are posted and thus the switch doesn't apply the Proxy ID
seeing it doesn't expect a completion. Thus the IOMMU sees the TLPs as
coming from a permitted peripheral and doesn't complain.

Logan

[1] https://www.amd.com/system/files/TechDocs/48882_IOMMU.pdf
