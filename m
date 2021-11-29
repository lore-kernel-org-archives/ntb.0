Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [204.191.154.188])
        by gmr-mx.google.com with ESMTPS id u7si1192095qki.5.2021.11.29.15.52.40
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 15:52:40 -0800 (PST)
References: <20211126230957.239391799@linutronix.de>
 <20211126232735.547996838@linutronix.de>
 <7daba0e2-73a3-4980-c3a5-a71f6b597b22@deltatee.com> <874k7ueldt.ffs@tglx>
 <6ba084d6-2b26-7c86-4526-8fcd3d921dfd@deltatee.com>
 <20211129233133.GA4670@nvidia.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <7c5626d2-ad80-24eb-0b89-402562156135@deltatee.com>
Date: Mon, 29 Nov 2021 16:52:35 -0700
MIME-Version: 1.0
In-Reply-To: <20211129233133.GA4670@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Kevin Tian <kevin.tian@intel.com>, Megha Dey <megha.dey@intel.com>, Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-ntb.googlegroups.com>



On 2021-11-29 4:31 p.m., Jason Gunthorpe wrote:
> On Mon, Nov 29, 2021 at 03:27:20PM -0700, Logan Gunthorpe wrote:
> 
>> In most cases, the NTB code needs more interrupts than the hardware
>> actually provides for in its MSI-X table. That's what PCI_IRQ_VIRTUAL is
>> for: it allows the driver to request more interrupts than the hardware
>> advertises (ie. pci_msix_vec_count()). These extra interrupts are
>> created, but get flagged with msi_attrib.is_virtual which ensures
>> functions that program the MSI-X table don't try to write past the end
>> of the hardware's table.
> 
> AFAICT what you've described is what Intel is calling IMS in other
> contexts.
> 
> IMS is fundamentally a way to control MSI interrupt descriptors that
> are not accessed through PCI SIG compliant means. In this case the NTB
> driver has to do its magic to relay the addr/data pairs to the real
> MSI storage in the hidden devices.

With current applications, it isn't that there is real "MSI storage"
anywhere; the device on the other side of the bridge is always another
Linux host which holds the address (or rather mw offset) and data in
memory to use when it needs to trigger the interrupt of the other
machine. There are many prototypes and proprietary messes that try to
have other PCI devices (ie NVMe, etc) behind the non-transparent bridge;
but the Linux subsystem has no support for this.

> PCI_IRQ_VIRTUAL should probably be fully replaced by the new dynamic
> APIs in the fullness of time..

Perhaps, I don't really know much about IMS or how close a match it is.

>> Existing NTB hardware does already have what's called a doorbell which
>> provides the same functionally as the above technique. However, existing
>> hardware implementations of doorbells have significant latency and thus
>> slow down performance substantially. Implementing the MSI interrupts as
>> described above increased the performance of ntb_transport by more than
>> three times[1].
> 
> Does the doorbell scheme allow as many interrupts?

No, but for current applications there are plenty of doorbells.

Switchtec hardware (and I think other hardware) typically have 64
doorbells for the entire network (they must be split among the number of
hosts in the network; a two host system could have 32 per host). The NTB
subsystem in Linux only currently supports 2 hosts, but switchtec
hardware supports up to 48 hosts, in which case you might only have 1
doorbell per host and that might be limiting depending on the application.

Logan
