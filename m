Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [204.191.154.188])
        by gmr-mx.google.com with ESMTPS id bs32si121633qkb.7.2021.12.01.10.46.39
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 10:46:39 -0800 (PST)
References: <6ba084d6-2b26-7c86-4526-8fcd3d921dfd@deltatee.com>
 <87ilwacwp8.ffs@tglx> <d6f13729-1b83-fa7d-3f0d-98d4e3f7a2aa@deltatee.com>
 <87v909bf2k.ffs@tglx> <20211130202800.GE4670@nvidia.com>
 <87o861banv.ffs@tglx> <20211201001748.GF4670@nvidia.com>
 <87mtlkaauo.ffs@tglx> <20211201130023.GH4670@nvidia.com>
 <87y2548byw.ffs@tglx> <20211201181406.GM4670@nvidia.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <c4d4550a-022e-4574-3937-248518dae763@deltatee.com>
Date: Wed, 1 Dec 2021 11:46:27 -0700
MIME-Version: 1.0
In-Reply-To: <20211201181406.GM4670@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
To: Jason Gunthorpe <jgg@nvidia.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Kevin Tian <kevin.tian@intel.com>, Megha Dey <megha.dey@intel.com>, Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, x86@kernel.org, Joerg Roedel <jroedel@suse.de>, iommu@lists.linux-foundation.org
List-ID: <linux-ntb.googlegroups.com>



On 2021-12-01 11:14 a.m., 'Jason Gunthorpe' via linux-ntb wrote:
> On Wed, Dec 01, 2021 at 06:35:35PM +0100, Thomas Gleixner wrote:
>> On Wed, Dec 01 2021 at 09:00, Jason Gunthorpe wrote:
>>> On Wed, Dec 01, 2021 at 11:16:47AM +0100, Thomas Gleixner wrote:
>>>> Looking at the device slices as subdevices with their own struct device
>>>> makes a lot of sense from the conceptual level.
>>>
>>> Except IMS is not just for subdevices, it should be usable for any
>>> driver in any case as a general interrupt mechiansm, as you alluded to
>>> below about ethernet queues. ntb seems to be the current example of
>>> this need..
>>
>> But NTB is operating through an abstraction layer and is not a direct
>> PCIe device driver.
> 
> I'm not sure exactly how NTB seems to be split between switchtec and
> the ntb code, but since the ntbd code seems to be doing MMIO touches,
> it feels like part of a PCIe driver?

Eh, sort of. NTB has lots of layers. At the top you'll find ntb_netdev
which is an network interface. Below that is ntb_transport() which is a
generic queue pair. Below that is the hardware driver itself (ie
switchtec) through the abstraction layer. The switchtec driver is split
in two: the main driver which just allows for information and
administration of the switch itself and switchtec_ntb which is the
module that provides the NTB abstractions to twiddle its registers.

ntb_transport() doesn't directly do MMIO touches (as it doesn't know
what the underlying hardware registers are). Except for the memory
windows which are usually setup to be a specific BAR (or parts of a
BAR). ntb_transport will do MMIO writes to those specific BAR address
which correspond to writing into buffers on the peer.

Logan
