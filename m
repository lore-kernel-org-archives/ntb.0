Return-Path: <dave.jiang@intel.com>
Received: from mga05.intel.com (mga05.intel.com. [192.55.52.43])
        by gmr-mx.google.com with ESMTPS id e2si339793uah.0.2019.01.31.12.58.21
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 12:58:21 -0800 (PST)
Subject: Re: [PATCH 0/9] Support using MSI interrupts in ntb_transport
References: <20190131185656.17972-1-logang@deltatee.com>
 <345197a6-89e6-c0de-5f7b-a646b5f396c9@intel.com>
 <bafe9db4-6d5b-0453-d7e7-e49e9293dd01@deltatee.com>
From: Dave Jiang <dave.jiang@intel.com>
Message-ID: <ea7b7c3c-8ed5-51ec-022a-7d28a5afce82@intel.com>
Date: Thu, 31 Jan 2019 13:58:18 -0700
MIME-Version: 1.0
In-Reply-To: <bafe9db4-6d5b-0453-d7e7-e49e9293dd01@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
To: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, Jon Mason <jdmason@kudzu.us>, Bjorn Helgaas <bhelgaas@google.com>, Joerg Roedel <joro@8bytes.org>
Cc: Allen Hubbe <allenbh@gmail.com>, Serge Semin <fancer.lancer@gmail.com>, Eric Pilmore <epilmore@gigaio.com>
List-ID: <linux-ntb.googlegroups.com>


On 1/31/2019 1:48 PM, Logan Gunthorpe wrote:
>
> On 2019-01-31 1:20 p.m., Dave Jiang wrote:
>> Does this work when the system moves the MSI vector either via software
>> (irqbalance) or BIOS APIC programming (some modes cause round robin
>> behavior)?
>
> I don't know how irqbalance works, and I'm not sure what you are
> referring to by BIOS APIC programming, however I would expect these
> things would not be a problem.
>
> The MSI code I'm presenting here doesn't do anything crazy with the
> interrupts, it allocates and uses them just as any PCI driver would. The
> only real difference here is that instead of a piece of hardware sending
> the IRQ TLP, it will be sent through the memory window (which, from the
> OS's perspective, is just coming from an NTB hardware proxy alias).
>
> Logan
Right. I did that as a hack a while back for some silicon errata 
workaround. When the vector moves, the address for the LAPIC changes. So 
unless it gets updated, you end up writing to the old location and lose 
all the new interrupts. irqbalance is a user daemon that rotates the 
system interrupts around to ensure that not all interrupts are pinned on 
a single core. I think it's enabled by default on several distros. 
Although MSIX has nothing to do with the IOAPIC, the mode that the APIC 
is programmed can have an influence on how the interrupts are delivered. 
There are certain Intel platforms (I don't know if AMD does anything 
like that) puts the IOAPIC in a certain configuration that causes the 
interrupts to be moved in a round robin fashion. I think it's physical 
flat mode? I don't quite recall. Normally on the low end Xeons. It's 
probably worth doing a test run with the irqbalance daemon running and 
make sure you traffic stream doesn't all of sudden stop.
>
