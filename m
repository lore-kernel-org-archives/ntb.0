Return-Path: <dave.jiang@intel.com>
Received: from mga02.intel.com (mga02.intel.com. [134.134.136.20])
        by gmr-mx.google.com with ESMTPS id k73si2412921pfh.2.2017.08.21.16.46.46
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Aug 2017 16:46:46 -0700 (PDT)
Subject: Re: Translation registers
References: <8f9eda70-cd72-b5b0-aa6b-30022cc96e7a@amd.com>
 <f3b3a715-15d9-1ea6-eb4f-5bf367d2dd54@intel.com>
 <2ae1abbd-1b7d-f9eb-3a97-c71daf486ac2@amd.com>
From: Dave Jiang <dave.jiang@intel.com>
Message-ID: <3936c215-10b4-b1a0-3847-dc3fea104506@intel.com>
Date: Mon, 21 Aug 2017 16:46:42 -0700
MIME-Version: 1.0
In-Reply-To: <2ae1abbd-1b7d-f9eb-3a97-c71daf486ac2@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Gary R Hook <gary.hook@amd.com>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On 08/21/2017 04:32 PM, Gary R Hook wrote:
> On 08/21/2017 05:36 PM, Dave Jiang wrote:
>>
>>
>> On 08/21/2017 02:59 PM, Gary R Hook wrote:
>>> Stupid question time.
>>>
>>> What is the purpose of the call to dma_alloc_coherent() in ntb_perf and
>>> ntb_tool? Is is supposed to acquire a chunk of DMA memory that is mapped
>>> into the device bar? A call to ntb_mw_set_trans() ensues, but I'm not
>>> seeing what is supposed to happen in that, either. The translation
>>> registers are accessed, yes, but why?
>>>
>>> I'm seeing the memory window this way: On my primary I get the MW
>>> address through the BAR, it's a certain size, and I can write into it.
>>> The data should appear in the corresponding memory window of the
>>> secondary. An application could be notified via a doorbell event to go
>>> read the data.
>>>
>>> Or am I just completely confused?
>>>
>>> What I'm trying to get down to is how, during initialization of the
>>> device driver and tool module, I get a virtual address that I can use
>>> for memcpy operations. The physical address (for DMA ops) is easy; I've
>>> got that. What's not clear is how (on Intel hardware) is how
>>> ioremap_wc()/et. al. are used to get a virtual reference to a physical
>>> address.
>>>
>>> Searching has as yet revealed nothing specific on this detail. Of
>>> course, I could be making this more complex than it needs to be...
>>>
>>>
>>> In summary: how is the Intel NTB device getting mapped into the virtual
>>> address space, via dma_alloc_coherent, ioremap_wc, and ntb_mw_set_trans?
>>>
>>> Much thanks to anyone that has illuminating comments.
>>>
>> So in the case of ntb_transport or ntb_perf, the dma_alloc_coherent()
>> provides a chunk of DMAable memory to back the NTB BAR that the other
>> node will be accessing.
>> So let's use the terminology of node A and node B in a B2B (back to
>> back) configuration. On node B, your NTB memory window BAR has the
>> address location of 0x383fffe00000, which is set by BIOS. You allocate
>> via dma_alloc_coherent() on node A and get the physical address of
>> 0x87f000000 for the memory. You would write this bus address into the
>> SBARXLAT (secondary BAR translate) register. The virtual address for
>> that piece of memory is provided to you as the return value when you
>> called dma_alloc_coherent(), lets use 0x20000000 for simplicity sake.
>>
>> On node B, ioremap_*() is called in order to obtain a virtual address so
>> you can access the NTB memory window BAR via CPU. This is basically
>> standard PCI BAR mapping. You would get a virtual address returned that
>> maps to 0x383fffe00000. Lets for simplicity sake call it 0x10000000 for
>> that virtual address. So when you attempt to write to the virtual
>> address of 0x10001000, it would be 0x383fffe01000 accessed on the PCI
>> BAR on node B. It goes through NTB translations and would end up in the
>> memory address of 0x20001000 virtually and 0x383fffe01000 physical wise
>> on node A.
>>
>> I hope that helps?
> 
> This is very nice, thank you. A and B are simpler; we just refer to them
> as the primary and secondary.

Yes. And now the new specs from Intel are referring them as external and
internal end points.

> 
> In order to avoid embarrassing myself with a possible display of ignorance,
> I'm going to have to study this in detail. But I will say that what you
> describe above is not what is happening in my 4.12 kernel.

Not sure I understand. Is the AMD hardware not doing that in 4.12? I'm
not familiar with the AMD hardware so it may behave differently.

> 
>> The doorbells are completely separate from the memory window access. The
>> software can choose to ring the doorbell after it has written the data.
>> The writing of the data does not trigger the doorbell.
> 
> That was only intended as a usage strawman for a simple illustration. No
> conflation there.
> 
> Thank you for your time. Greatly appreciated.
> 
