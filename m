Return-Path: <vincent.whitchurch@axis.com>
Received: from bastet.se.axis.com (bastet.se.axis.com. [195.60.68.11])
        by gmr-mx.google.com with ESMTPS id f6si1060258wmj.0.2019.01.17.07.32.09
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 07:32:09 -0800 (PST)
Date: Thu, 17 Jan 2019 16:32:06 +0100
From: Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: Re: [PATCH 0/8] Virtio-over-PCIe on non-MIC
Message-ID: <20190117153206.2flxqb26tbdrwp4z@axis.com>
References: <20190116163253.23780-1-vincent.whitchurch@axis.com>
 <CAK8P3a2ifu9X+SXgoDPSFMYwnKr=Yex8_tD4qRimcOQAhuEa8Q@mail.gmail.com>
 <20190117105441.eqediwlekofp2srg@axis.com>
 <CAK8P3a2HtSJCLVdLcs=f0b5wv-k-6E_Z4Pt3Yp_kazUZh-Ek9A@mail.gmail.com>
 <20190117151906.odvozs6kz3uvx32y@axis.com>
 <20190117152142.GB20359@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117152142.GB20359@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>, sudeep.dutt@intel.com, ashutosh.dixit@intel.com, gregkh <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-pci <linux-pci@vger.kernel.org>, linux-ntb@googlegroups.com, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

On Thu, Jan 17, 2019 at 07:21:42AM -0800, Christoph Hellwig wrote:
> On Thu, Jan 17, 2019 at 04:19:06PM +0100, Vincent Whitchurch wrote:
> > On the RC, a vop-host-backend driver (PCI driver) sets up some shared
> > memory area which the RC and the endpoint can use to communicate the
> > location of the MIC device descriptors and other information such as the
> > MSI address.  It implements vop callbacks to allow the vop framework to
> > obtain the address of the MIC descriptors and send/receive interrupts
> > to/from the guest.
> 
> Why would we require any work on the RC / host side?  A properly
> setup software controlled virtio device should just show up as a
> normal PCIe device, and the virtio-pci device should bind to it.

If I understand you correctly, I think you're talking about the RC
running the virtio drivers and the endpoint implementing the virtio
device?  This vop stuff is used for the other way around: the virtio
device is implement on the RC and the endpoint runs the virtio drivers.
