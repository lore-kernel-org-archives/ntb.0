Return-Path: <mika.penttila@nextfour.com>
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2083.outbound.protection.outlook.com. [40.107.20.83])
        by gmr-mx.google.com with ESMTPS id y8si357740lfj.0.2021.12.11.22.44.53
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 Dec 2021 22:44:53 -0800 (PST)
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
References: <8c2262ba-173e-0007-bc4c-94ec54b2847d@intel.com>
 <87pmqg88xq.ffs@tglx> <df00b87e-00dc-d998-8b64-46b16dba46eb@intel.com>
 <87k0go8432.ffs@tglx> <f4cc305b-a329-6d27-9fca-b74ebc9fa0c1@intel.com>
 <878rx480fk.ffs@tglx>
 <BN9PR11MB52765F2EF8420C60FD5945D18C709@BN9PR11MB5276.namprd11.prod.outlook.com>
 <87sfv2yy19.ffs@tglx> <20211209162129.GS6385@nvidia.com>
 <878rwtzfh1.ffs@tglx> <20211209205835.GZ6385@nvidia.com>
 <BN9PR11MB5276599F467AD5EAC935A79E8C719@BN9PR11MB5276.namprd11.prod.outlook.com>
From: =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>
Message-ID: <3f6d4bd7-8b60-1976-73a4-f5ef7f3dbf27@nextfour.com>
Date: Sun, 12 Dec 2021 08:44:46 +0200
In-Reply-To: <BN9PR11MB5276599F467AD5EAC935A79E8C719@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Return-Path: mika.penttila@nextfour.com
MIME-Version: 1.0
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: "Jiang, Dave" <dave.jiang@intel.com>, Logan Gunthorpe <logang@deltatee.com>, LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, "Dey, Megha" <megha.dey@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "x86@kernel.org" <x86@kernel.org>, Joerg Roedel <jroedel@suse.de>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
List-ID: <linux-ntb.googlegroups.com>



On 10.12.2021 9.36, Tian, Kevin wrote:
>> From: Jason Gunthorpe <jgg@nvidia.com>
>> Sent: Friday, December 10, 2021 4:59 AM
>>
>> On Thu, Dec 09, 2021 at 09:32:42PM +0100, Thomas Gleixner wrote:
>>> On Thu, Dec 09 2021 at 12:21, Jason Gunthorpe wrote:
>>>> On Thu, Dec 09, 2021 at 09:37:06AM +0100, Thomas Gleixner wrote:
>>>> If we keep the MSI emulation in the hypervisor then MSI != IMS.  The
>>>> MSI code needs to write a addr/data pair compatible with the emulation
>>>> and the IMS code needs to write an addr/data pair from the
>>>> hypercall. Seems like this scenario is best avoided!
>>>>
>>>>  From this perspective I haven't connected how virtual interrupt
>>>> remapping helps in the guest? Is this a way to provide the hypercall
>>>> I'm imagining above?
>>> That was my thought to avoid having different mechanisms.
>>>
>>> The address/data pair is computed in two places:
>>>
>>>    1) Activation of an interrupt
>>>    2) Affinity setting on an interrupt
>>>
>>> Both configure the IRTE when interrupt remapping is in place.
>>>
>>> In both cases a vector is allocated in the vector domain and based on
>>> the resulting target APIC / vector number pair the IRTE is
>>> (re)configured.
>>>
>>> So putting the hypercall into the vIRTE update is the obvious
>>> place. Both activation and affinity setting can fail and propagate an
>>> error code down to the originating caller.
>>>
>>> Hmm?
>> Okay, I think I get it. Would be nice to have someone from intel
>> familiar with the vIOMMU protocols and qemu code remark what the
>> hypervisor side can look like.
>>
>> There is a bit more work here, we'd have to change VFIO to somehow
>> entirely disconnect the kernel IRQ logic from the MSI table and
>> directly pass control of it to the guest after the hypervisor IOMMU IR
>> secures it. ie directly mmap the msi-x table into the guest
>>
> It's supported already:
>
> /*
>   * The MSIX mappable capability informs that MSIX data of a BAR can be mmapped
>   * which allows direct access to non-MSIX registers which happened to be within
>   * the same system page.
>   *
>   * Even though the userspace gets direct access to the MSIX data, the existing
>   * VFIO_DEVICE_SET_IRQS interface must still be used for MSIX configuration.
>   */
> #define VFIO_REGION_INFO_CAP_MSIX_MAPPABLE      3
>
> IIRC this was introduced for PPC when a device has MSI-X in the same BAR as
> other MMIO registers. Trapping MSI-X leads to performance downgrade on
> accesses to adjacent registers. MSI-X can be mapped by userspace because
> PPC already uses a hypercall mechanism for interrupt. Though unclear about
> the detail it sounds a similar usage as proposed here.
>
> Thanks
> Kevin

I see  VFIO_REGION_INFO_CAP_MSIX_MAPPABLE is always set so if msix table 
is in its own bar, qemu never traps/emulates the access. On the other 
hand, qemu is said to depend on emulating masking. So how is this 
supposed to work, in case the table is not in the config bar?

Thanks,
Mika


