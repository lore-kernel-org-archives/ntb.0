Return-Path: <tglx@linutronix.de>
Received: from galois.linutronix.de (Galois.linutronix.de. [193.142.43.55])
        by gmr-mx.google.com with ESMTPS id na11si1266093pjb.2.2021.12.01.12.25.55
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 12:25:55 -0800 (PST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
In-Reply-To: <df00b87e-00dc-d998-8b64-46b16dba46eb@intel.com>
References: <20211126230957.239391799@linutronix.de>
 <20211126232735.547996838@linutronix.de>
 <7daba0e2-73a3-4980-c3a5-a71f6b597b22@deltatee.com> <874k7ueldt.ffs@tglx>
 <6ba084d6-2b26-7c86-4526-8fcd3d921dfd@deltatee.com> <87ilwacwp8.ffs@tglx>
 <d6f13729-1b83-fa7d-3f0d-98d4e3f7a2aa@deltatee.com> <87v909bf2k.ffs@tglx>
 <20211130202800.GE4670@nvidia.com> <87o861banv.ffs@tglx>
 <20211201001748.GF4670@nvidia.com> <87mtlkaauo.ffs@tglx>
 <8c2262ba-173e-0007-bc4c-94ec54b2847d@intel.com> <87pmqg88xq.ffs@tglx>
 <df00b87e-00dc-d998-8b64-46b16dba46eb@intel.com>
Date: Wed, 01 Dec 2021 21:25:53 +0100
Message-ID: <87k0go8432.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
To: Dave Jiang <dave.jiang@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Logan Gunthorpe <logang@deltatee.com>, LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Kevin Tian <kevin.tian@intel.com>, Megha Dey <megha.dey@intel.com>, Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, x86@kernel.org, Joerg Roedel <jroedel@suse.de>, iommu@lists.linux-foundation.org
List-ID: <linux-ntb.googlegroups.com>

On Wed, Dec 01 2021 at 11:47, Dave Jiang wrote:
> On 12/1/2021 11:41 AM, Thomas Gleixner wrote:
>>> Hi Thomas. This is actually the IDXD usage for a mediated device passed
>>> to a guest kernel when we plumb the pass through of IMS to the guest
>>> rather than doing previous implementation of having a MSIX vector on
>>> guest backed by IMS.
>> Which makes a lot of sense.
>>
>>> The control block for the mediated device is emulated and therefore an
>>> emulated MSIX vector will be surfaced as vector 0. However the queues
>>> will backed by IMS vectors. So we end up needing MSIX and IMS coexist
>>> running on the guest kernel for the same device.
>> Why? What's wrong with using straight MSI-X for all of them?
>
> The hardware implementation does not have enough MSIX vectors for 
> guests. There are only 9 MSIX vectors total (8 for queues) and 2048 IMS 
> vectors. So if we are to do MSI-X for all of them, then we need to do 
> the IMS backed MSIX scheme rather than passthrough IMS to guests.

Confused. Are you talking about passing a full IDXD device to the guest
or about passing a carved out subdevice, aka. queue?

Thanks,

        tglx
