Return-Path: <dave.jiang@intel.com>
Received: from mga07.intel.com (mga07.intel.com. [134.134.136.100])
        by gmr-mx.google.com with ESMTPS id g23si389310otk.0.2019.01.31.15.48.11
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 15:48:11 -0800 (PST)
Subject: Re: [PATCH 0/9] Support using MSI interrupts in ntb_transport
References: <20190131185656.17972-1-logang@deltatee.com>
 <345197a6-89e6-c0de-5f7b-a646b5f396c9@intel.com>
 <bafe9db4-6d5b-0453-d7e7-e49e9293dd01@deltatee.com>
 <ea7b7c3c-8ed5-51ec-022a-7d28a5afce82@intel.com>
 <29f7e3fe-5354-6156-1243-7248ffb2249f@deltatee.com>
 <7e3eed52-8e3a-c472-392a-5dc5689290ae@intel.com>
 <5f8b1616-a005-7658-978f-16466fcc3886@deltatee.com>
From: Dave Jiang <dave.jiang@intel.com>
Message-ID: <d46ce09c-d493-3d63-a854-b68a09345a75@intel.com>
Date: Thu, 31 Jan 2019 16:48:09 -0700
MIME-Version: 1.0
In-Reply-To: <5f8b1616-a005-7658-978f-16466fcc3886@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
To: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, Jon Mason <jdmason@kudzu.us>, Bjorn Helgaas <bhelgaas@google.com>, Joerg Roedel <joro@8bytes.org>
Cc: Allen Hubbe <allenbh@gmail.com>, Serge Semin <fancer.lancer@gmail.com>, Eric Pilmore <epilmore@gigaio.com>
List-ID: <linux-ntb.googlegroups.com>


On 1/31/2019 4:41 PM, Logan Gunthorpe wrote:
>
> On 2019-01-31 3:46 p.m., Dave Jiang wrote:
>> I believe irqbalance writes to the file /proc/irq/N/smp_affinity. So
>> maybe take a look at the code that starts from there and see if it would
>> have any impact on your stuff.
> Ok, well on my system I can write to the smp_affinity all day and the
> MSI interrupts still work fine.

Maybe your code is ok then. If the stats show up in /proc/interrupts 
then you can see it moving to different cores.

> The MSI code is a bit difficult to trace and audit with all the
> different chips and the parent chips which I don't have a good
> understanding of. But I can definitely see that it could be possible for
> some chips to change the address as smp_affinitiy will eventually
> sometimes call msi_domain_set_affinity() which does seem to recompose
> the message and write it back to the chip.
>
> So, I could relatively easily add a callback to msi_desc to catch this
> and resend the MSI address/data. However, I'm not sure how this is ever
> done atomically. It seems like there would be a race while the device
> updates its address where old interrupts could be triggered. This race
> would be much longer for us when sending this information over the NTB
> link. Though, I guess if the only change is that it encodes CPU
> information in the address then that would not be an issue. However, I'm
> not sure I can say that for certain without a comprehensive
> understanding of all the IRQ chips.
>
> Any thoughts on this?

Yeah I'm not sure what to do about it either as I'm not super familiar 
with that area either. Just making note of what I encountered. And you 
are right, the updated info has to go over NTB for the other side to 
write to the updated place. So there's a lot of latency involved.



>
> Logan
