Return-Path: <arndbergmann@gmail.com>
Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com. [209.85.222.193])
        by gmr-mx.google.com with ESMTPS id b25si4328533qtq.2.2019.01.17.08.18.19
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 08:18:19 -0800 (PST)
Received: by mail-qk1-f193.google.com with SMTP id a1so6320997qkc.5
        for <linux-ntb@googlegroups.com>; Thu, 17 Jan 2019 08:18:19 -0800 (PST)
MIME-Version: 1.0
References: <20190116163253.23780-1-vincent.whitchurch@axis.com>
 <CAK8P3a2ifu9X+SXgoDPSFMYwnKr=Yex8_tD4qRimcOQAhuEa8Q@mail.gmail.com>
 <20190117105441.eqediwlekofp2srg@axis.com> <CAK8P3a2HtSJCLVdLcs=f0b5wv-k-6E_Z4Pt3Yp_kazUZh-Ek9A@mail.gmail.com>
 <20190117151906.odvozs6kz3uvx32y@axis.com> <20190117152142.GB20359@infradead.org>
 <20190117153206.2flxqb26tbdrwp4z@axis.com> <20190117154612.GA6262@infradead.org>
In-Reply-To: <20190117154612.GA6262@infradead.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 17 Jan 2019 17:18:02 +0100
Message-ID: <CAK8P3a14oW-615mT-iW+C_TNmEpST7V0L4XVic3LSnvCzXh4pA@mail.gmail.com>
Subject: Re: [PATCH 0/8] Virtio-over-PCIe on non-MIC
Content-Type: text/plain; charset="UTF-8"
To: Christoph Hellwig <hch@infradead.org>
Cc: Vincent Whitchurch <vincent.whitchurch@axis.com>, sudeep.dutt@intel.com, ashutosh.dixit@intel.com, gregkh <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-pci <linux-pci@vger.kernel.org>, linux-ntb@googlegroups.com, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

On Thu, Jan 17, 2019 at 4:46 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Thu, Jan 17, 2019 at 04:32:06PM +0100, Vincent Whitchurch wrote:
> > If I understand you correctly, I think you're talking about the RC
> > running the virtio drivers and the endpoint implementing the virtio
> > device?  This vop stuff is used for the other way around: the virtio
> > device is implement on the RC and the endpoint runs the virtio drivers.
>
> Oh.  That is really weird and not that way I'd implement it..

It does make sense to me for the very special requirements of the MIC
device, which has a regular PC-style server that provides the environment
for a special embedded device inside of a PCIe card, so the PCI-EP
stuff is just used as a transport here going one way, and then the
configuration of the devices implemented through it goes the other
way, providing network connectivity and file system to the embedded
machine on the PCI-EP.

This is actually very similar to a setup that I considered implementing
over USB, where one might have an embedded machine (or a bunch
of them on a USB hub) connected to a USB host port, and then
use it in the opposite way of a regular gadget driver, by providing
a virtfs over USB to the gadget with files residing on a disk on the
USB host.

Apparently Vincent has the same use case that both the Intel
MIC folks and I had here, so doing it like this is clearly useful.
On the other hand, I agree that there are lots of other use cases
that need the opposite, so we should try to come up with a
design that can cover both.
An example of this might be a PCIe-endpoint device providing
network connectivity to the host using a vhost-net device, which
ideally just shows up as a device on the host as a virtio-net
without requiring any configuration.

So for configuring this, I think it'd like to see a way to have
either the PCI-EP or the PCI-host side be the one that can
create virtio devices that show up on the other end. This
configuration is currently done using an ioctl interface, which
was probably the easiest to do for the MIC case, but for
consistency with the PCI-EP framework, using configfs
is probably better.

A different matter is the question of what a virtio device
talks to. A lot of virtio devices are fundamentally
asymmetric (9pfs, rng, block, ...), so you'd have to
have the virtio device on one side, and a user space
or vhost driver on the other. The VOP driver seems to assume
that it's always the slave that uses virtio, while the
master side (which could be on the PCI EP or PCI
host for the sake of this argument) implements it in user
space or otherwise. Is this a safe assumption, or can
we imagine cases where this would be reversed as well?

        Arnd
