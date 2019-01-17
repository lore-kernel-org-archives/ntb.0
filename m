Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id 140si153271pga.0.2019.01.17.14.17.50
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 14:17:50 -0800 (PST)
References: <20190116163253.23780-1-vincent.whitchurch@axis.com>
 <CAK8P3a2ifu9X+SXgoDPSFMYwnKr=Yex8_tD4qRimcOQAhuEa8Q@mail.gmail.com>
 <20190117105441.eqediwlekofp2srg@axis.com>
 <CAK8P3a2HtSJCLVdLcs=f0b5wv-k-6E_Z4Pt3Yp_kazUZh-Ek9A@mail.gmail.com>
 <20190117151906.odvozs6kz3uvx32y@axis.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <62e5f3e7-e2e3-c6ce-b8f6-99a5342c1494@deltatee.com>
Date: Thu, 17 Jan 2019 15:17:41 -0700
MIME-Version: 1.0
In-Reply-To: <20190117151906.odvozs6kz3uvx32y@axis.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 0/8] Virtio-over-PCIe on non-MIC
To: Vincent Whitchurch <vincent.whitchurch@axis.com>, Arnd Bergmann <arnd@arndb.de>
Cc: sudeep.dutt@intel.com, ashutosh.dixit@intel.com, gregkh <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-pci <linux-pci@vger.kernel.org>, linux-ntb@googlegroups.com, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>
List-ID: <linux-ntb.googlegroups.com>



On 2019-01-17 8:19 a.m., Vincent Whitchurch wrote:
> On the endpoint, the PCIe endpoint driver sets up (hardcoded) BARs and
> memory regions as required to allow the endpoint and the root complex to
> access each other's memory.

This statement describes NTB hardware pretty well. In essence that's
what an NTB device is: a BAR that maps to a window in other hosts memory.

Right now the entire NTB upstream software stack (ntb_transport and
ntb_netdev) is specific to that ecosystem and only exposes a network
device so the hosts can communicate. This code works but has some issues
and was never able to perform at full PCIe line speeds (which everyone
expects). So it's not clear to me if anyone is doing anything real with
it. The companies that are working on NTB, that I'm aware of, have
mostly done their own out-of-tree stuff.

It would be interesting to unify ntb_transport with the virtio stack
because I suspect they do very similar things right now and there's a
lot more devices above virtio than just a network device. However, the
main problem people working on NTB face (besides performance) is trying
to get multi-host working in a general and sensible way given that the
hardware typically has limited BAR resources (among other limitations).

Logan
