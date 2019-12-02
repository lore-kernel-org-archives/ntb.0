Return-Path: <dave.jiang@intel.com>
Received: from mga12.intel.com (mga12.intel.com. [192.55.52.136])
        by gmr-mx.google.com with ESMTPS id t34si11563pjb.3.2019.12.02.08.50.22
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Dec 2019 08:50:22 -0800 (PST)
Subject: Re: Physical continues memory for NTB
References: <e71c7a5d-ad80-46c4-b76c-7a6fba4fe666@googlegroups.com>
From: Dave Jiang <dave.jiang@intel.com>
Message-ID: <35f6d119-f98d-3b4c-e005-da92f83e9f75@intel.com>
Date: Mon, 2 Dec 2019 09:50:09 -0700
MIME-Version: 1.0
In-Reply-To: <e71c7a5d-ad80-46c4-b76c-7a6fba4fe666@googlegroups.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
To: lravich@gmail.com, linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>



On 12/2/19 8:23 AM, lravich@gmail.com wrote:
> Hi guys ,
> 
> I would like to get your opinion regarding NTB memory windows usage in a 
> production ,
> most of my experience is on Intel Skylake NTB which is limited to 2 NTB 
> memory windows and has hard restrictions
> 
> the naive way to use NTB is to set translate windows to all the physical 
> memory rage, this way entire physical memory will be exposed to peer 
> node , call me a paranoid but I not feeling this is the way to go ,
> the other way is to expose only relevant part of memory  but such memory 
> should be physical continues memory  (trying to avoid going to IOMMU 
> direction) to get such physical continues memory I cant use
> kmalloc  or other slob friends because they are limited in max size and 
> anyway the chance to get such a big chunk after init is low, so the only 
> way I see is to reserve the memory on kernel init ,
> 
> currently known to me technics to go this way:
> 1) "out of kernel memory" (memmap boot parameter) , this is the easiest 
> way to go but we getting out of kernel memory , which has its 
> disadvantages ex: there is many flows in kernel based on pining memory 
> with get_user_pages which will fail with  "out of kernel memory"

I wonder if you can try it with memmap=NN!MM and map them as DAX device 
memory and manage it through that. It might work? Worth a try.

> 2)  CMA -  this feature support only generic memory region allocation 
> with boot parameters  which will be shared by all dma allocs in kernel 
> (at least for Intel) , anyway looks like overkill for my simple 
> requirements.
> 
> love to hear your opinion guys ,
> 
> Thanks
> Leonid
> 
> -- 
> You received this message because you are subscribed to the Google 
> Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send 
> an email to linux-ntb+unsubscribe@googlegroups.com 
> <mailto:linux-ntb+unsubscribe@googlegroups.com>.
> To view this discussion on the web visit 
> https://groups.google.com/d/msgid/linux-ntb/e71c7a5d-ad80-46c4-b76c-7a6fba4fe666%40googlegroups.com 
> <https://groups.google.com/d/msgid/linux-ntb/e71c7a5d-ad80-46c4-b76c-7a6fba4fe666%40googlegroups.com?utm_medium=email&utm_source=footer>.
