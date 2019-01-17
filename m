Return-Path: <vincent.whitchurch@axis.com>
Received: from bastet.se.axis.com (bastet.se.axis.com. [195.60.68.11])
        by gmr-mx.google.com with ESMTPS id d6si3817690wro.4.2019.01.17.07.19.08
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 07:19:08 -0800 (PST)
Date: Thu, 17 Jan 2019 16:19:06 +0100
From: Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: Re: [PATCH 0/8] Virtio-over-PCIe on non-MIC
Message-ID: <20190117151906.odvozs6kz3uvx32y@axis.com>
References: <20190116163253.23780-1-vincent.whitchurch@axis.com>
 <CAK8P3a2ifu9X+SXgoDPSFMYwnKr=Yex8_tD4qRimcOQAhuEa8Q@mail.gmail.com>
 <20190117105441.eqediwlekofp2srg@axis.com>
 <CAK8P3a2HtSJCLVdLcs=f0b5wv-k-6E_Z4Pt3Yp_kazUZh-Ek9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2HtSJCLVdLcs=f0b5wv-k-6E_Z4Pt3Yp_kazUZh-Ek9A@mail.gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: sudeep.dutt@intel.com, ashutosh.dixit@intel.com, gregkh <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-pci <linux-pci@vger.kernel.org>, linux-ntb@googlegroups.com, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

On Thu, Jan 17, 2019 at 01:39:27PM +0100, Arnd Bergmann wrote:
> Correct, and again we have to see if this is a good interface. The NTB
> and PCIe-endpoint interfaces have a number of differences and a
> number of similarities. In particular they should both be usable with
> virtio-style drivers, but the underlying hardware differs mainly in how
> it is probed by the system: an NTB is seen as a PCI device attached
> to two host bridges, while and endpoint is typically a platform_device
> on one side, but a pci_dev on the other side.
> 
> Can you describe how you expect a VOP device over NTB or
> PCIe-endpoint would get created, configured and used?

Assuming PCIe-endpoint:

On the RC, a vop-host-backend driver (PCI driver) sets up some shared
memory area which the RC and the endpoint can use to communicate the
location of the MIC device descriptors and other information such as the
MSI address.  It implements vop callbacks to allow the vop framework to
obtain the address of the MIC descriptors and send/receive interrupts
to/from the guest.

On the endpoint, the PCIe endpoint driver sets up (hardcoded) BARs and
memory regions as required to allow the endpoint and the root complex to
access each other's memory.

On the endpoint, the vop-guest-backend, via the shared memory set up by
the vop-host-backend, obtains the address of the MIC device page and the
MSI address, and a method to receive vop interrupts from the host.  This
information is used to implement the vop callbacks allowing the vop
framework to access to the MIC device page and send/receive interrupts
from/to the host.

vop (despite its name) doesn't care about PCIe.  The vop-guest-backend
doesn't actually need to talk to the PCIe endpoint driver.  The
vop-guest-backend can be probed via any means, such as via a device tree
on the endpoint.

On the RC, userspace opens the vop device and adds the virtio devices,
which end up in the MIC device page set up by the vop-host-backend.

On the endpoint, when the vop framework (via the vop-guest-backend) sees
these devices, it registers devices on the virtio bus and the virtio
drivers are probed.

On the RC, userspace implements the device end of the virtio
communication in userspace, using the MIC_VIRTIO_COPY_DESC ioctl.  I
also have patches to support vhost.

> Is there always one master side that is responsible for creating
> virtio devices on it, with the slave side automatically attaching to
> them, or can either side create virtio devices?

Only the master can create virtio devices.  The virtio drivers run on
the slave.

> Is there any limit on
> the number of virtio devices or queues within a VOP device?

The virtio device information (mic_device_desc) is put into the MIC
device page whose size is limited by the ABI header in
include/uapi/linux/mic_ioctl.h (MIC_DP_SIZE, 4096 bytes).  So the number
of devices is limited by the limit of the number of device descriptors
that can fit in that size.  There is also a per-device limit on the
number of vrings (MIC_VRING_ENTRIES) and vring entries
(MIC_VRING_ENTRIES) in the ABI header.
