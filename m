Return-Path: <vincent.whitchurch@axis.com>
Received: from bastet.se.axis.com (bastet.se.axis.com. [195.60.68.11])
        by gmr-mx.google.com with ESMTPS id h28si788085edh.4.2019.01.17.02.54.44
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 02:54:44 -0800 (PST)
Date: Thu, 17 Jan 2019 11:54:41 +0100
From: Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: Re: [PATCH 0/8] Virtio-over-PCIe on non-MIC
Message-ID: <20190117105441.eqediwlekofp2srg@axis.com>
References: <20190116163253.23780-1-vincent.whitchurch@axis.com>
 <CAK8P3a2ifu9X+SXgoDPSFMYwnKr=Yex8_tD4qRimcOQAhuEa8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2ifu9X+SXgoDPSFMYwnKr=Yex8_tD4qRimcOQAhuEa8Q@mail.gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: sudeep.dutt@intel.com, ashutosh.dixit@intel.com, gregkh <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-pci <linux-pci@vger.kernel.org>, linux-ntb@googlegroups.com, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

On Wed, Jan 16, 2019 at 06:07:53PM +0100, Arnd Bergmann wrote:
> On Wed, Jan 16, 2019 at 5:33 PM Vincent Whitchurch <vincent.whitchurch@axis.com> wrote:
> > The Virtio-over-PCIe framework living under drivers/misc/mic/vop implements a
> > generic framework to use virtio between two Linux systems, given shared memory
> > and a couple of interrupts.  It does not actually require the Intel MIC
> > hardware, x86-64, or even PCIe for that matter.  This patch series makes it
> > buildable on more systems and adds a loopback driver to test it without special
> > hardware.
> >
> > Note that I don't have access to Intel MIC hardware so some testing of the
> > patchset (especially the patch "vop: Use consistent DMA") on that platform
> > would be appreciated, to ensure that the series does not break anything there.
> 
> I think we need to take a step back though and discuss what combinations
> we actually do want to support. I have not actually read the whole mic/vop
> driver, so I don't know if this would be a good fit as a generic interface --
> it may or may not be, and any other input would be helpful.

The MIC driver as a whole is uninteresting as a generic interface since
it is quite tied to the Intel hardware.  The VOP parts though are
logically separated and have no relation to that hardware, even if the
ioctls are called MIC_VIRTIO_*.

The samples/mic/mpssd/mpssd.c code handles both the boot of the MIC
(sysfs) and the VOP parts (ioctls).

> Aside from that, I should note that we have two related subsystems
> in the kernel: the PCIe endpoint subsystem maintained by Kishon and
> Lorenzo, and the NTB subsystem maintained by Jon, Dave and Allen.
> 
> In order to properly support virtio over PCIe, I would hope we can come
> up with a user space interface that looks the same way for configuring
> virtio drivers in mic, pcie-endpoint and ntb, if at all possible. Have
> you looked at those two subsystems?

pcie-endpoint is a generic framework that allows Linux to act as an
endpoint and set up the BARs, etc.  mic appears to have Intel
MIC-specific code for this (pre-dating pcie-endpoint) but this is
separate from the vop code.  pcie-endpoint and vop do not have
overlapping functionality and can be used together.

I'm not familiar with NTB, but from a quick look it seems to be tied to
special hardware, and I don't see any virtio-related code there.  A vop
backend for NTB-backend would presumably work to allow virtio
functionality there.
