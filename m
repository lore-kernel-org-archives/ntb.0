Return-Path: <arndbergmann@gmail.com>
Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com. [209.85.160.194])
        by gmr-mx.google.com with ESMTPS id d10si71391pgc.2.2019.01.17.07.53.43
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 07:53:43 -0800 (PST)
Received: by mail-qt1-f194.google.com with SMTP id t33so11794311qtt.4
        for <linux-ntb@googlegroups.com>; Thu, 17 Jan 2019 07:53:43 -0800 (PST)
MIME-Version: 1.0
References: <20190116163253.23780-1-vincent.whitchurch@axis.com>
 <CAK8P3a2ifu9X+SXgoDPSFMYwnKr=Yex8_tD4qRimcOQAhuEa8Q@mail.gmail.com>
 <20190117105441.eqediwlekofp2srg@axis.com> <CAK8P3a2HtSJCLVdLcs=f0b5wv-k-6E_Z4Pt3Yp_kazUZh-Ek9A@mail.gmail.com>
 <20190117151906.odvozs6kz3uvx32y@axis.com>
In-Reply-To: <20190117151906.odvozs6kz3uvx32y@axis.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 17 Jan 2019 16:53:25 +0100
Message-ID: <CAK8P3a17cw3LrbGOf=TxyfK70CHDy-bjbYkvrsvaQ9OM8nPeFQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] Virtio-over-PCIe on non-MIC
Content-Type: text/plain; charset="UTF-8"
To: Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc: sudeep.dutt@intel.com, ashutosh.dixit@intel.com, gregkh <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-pci <linux-pci@vger.kernel.org>, linux-ntb@googlegroups.com, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

On Thu, Jan 17, 2019 at 4:19 PM Vincent Whitchurch
<vincent.whitchurch@axis.com> wrote:
>
> On Thu, Jan 17, 2019 at 01:39:27PM +0100, Arnd Bergmann wrote:
> > Correct, and again we have to see if this is a good interface. The NTB
> > and PCIe-endpoint interfaces have a number of differences and a
> > number of similarities. In particular they should both be usable with
> > virtio-style drivers, but the underlying hardware differs mainly in how
> > it is probed by the system: an NTB is seen as a PCI device attached
> > to two host bridges, while and endpoint is typically a platform_device
> > on one side, but a pci_dev on the other side.
> >
> > Can you describe how you expect a VOP device over NTB or
> > PCIe-endpoint would get created, configured and used?
>
> Assuming PCIe-endpoint:
>
> On the RC, a vop-host-backend driver (PCI driver) sets up some shared
> memory area which the RC and the endpoint can use to communicate the
> location of the MIC device descriptors and other information such as the
> MSI address.  It implements vop callbacks to allow the vop framework to
> obtain the address of the MIC descriptors and send/receive interrupts
> to/from the guest.
>
> On the endpoint, the PCIe endpoint driver sets up (hardcoded) BARs and
> memory regions as required to allow the endpoint and the root complex to
> access each other's memory.
>
> On the endpoint, the vop-guest-backend, via the shared memory set up by
> the vop-host-backend, obtains the address of the MIC device page and the
> MSI address, and a method to receive vop interrupts from the host.  This
> information is used to implement the vop callbacks allowing the vop
> framework to access to the MIC device page and send/receive interrupts
> from/to the host.

Ok, this seems fine so far. So the vop-host-backend is a regular PCI
driver that implements the VOP protocol from the host side, and it
can talk to either a MIC, or another guest-backend written for the PCI-EP
framework to implement the same protocol, right?

> vop (despite its name) doesn't care about PCIe.  The vop-guest-backend
> doesn't actually need to talk to the PCIe endpoint driver.  The
> vop-guest-backend can be probed via any means, such as via a device tree
> on the endpoint.
>
> On the RC, userspace opens the vop device and adds the virtio devices,
> which end up in the MIC device page set up by the vop-host-backend.
>
> On the endpoint, when the vop framework (via the vop-guest-backend) sees
> these devices, it registers devices on the virtio bus and the virtio
> drivers are probed.

Ah, so the direction is fixed, and it's the opposite of what Christoph
and I were expecting. This is probably something we need to discuss
a bit. From what I understand, there is no technical requirement why
it has to be this direction, right?

What I mean is that the same vop framework could work with
a PCI-EP driver implementing the vop-host-backend and
a PCI driver implementing the vop-guest-backend? In order
to do this, the PCI-EP configuration would need to pick whether
it wants the EP to be the vop host or guest, but having more
flexibility in it (letting each side add virtio devices) would be
harder to do.

> On the RC, userspace implements the device end of the virtio
> communication in userspace, using the MIC_VIRTIO_COPY_DESC ioctl.  I
> also have patches to support vhost.

This is a part I don't understand yet. Does this mean that the
normal operation is between a user space process on the vop-host
talking to the kernel on the vop-guest?

I'm a bit worried about the ioctl interface here, as this combines the
configuration side with the actual data transfer, and that seems
a bit inflexible.

> > Is there always one master side that is responsible for creating
> > virtio devices on it, with the slave side automatically attaching to
> > them, or can either side create virtio devices?
>
> Only the master can create virtio devices.  The virtio drivers run on
> the slave.

Ok.

> > Is there any limit on
> > the number of virtio devices or queues within a VOP device?
>
> The virtio device information (mic_device_desc) is put into the MIC
> device page whose size is limited by the ABI header in
> include/uapi/linux/mic_ioctl.h (MIC_DP_SIZE, 4096 bytes).  So the number
> of devices is limited by the limit of the number of device descriptors
> that can fit in that size.  There is also a per-device limit on the
> number of vrings (MIC_VRING_ENTRIES) and vring entries
> (MIC_VRING_ENTRIES) in the ABI header.

Ok, so you can have multiple virtio devices (e.g. a virtio-net and
virtio-console) but not an arbitrary number? I suppose we can always
extend it later if that becomes a problem.

       Arnd
