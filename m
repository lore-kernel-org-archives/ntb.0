Return-Path: <dave.jiang@intel.com>
Received: from mga09.intel.com (mga09.intel.com. [134.134.136.24])
        by gmr-mx.google.com with ESMTPS id f13si733257iog.3.2021.05.21.08.22.17
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 May 2021 08:22:17 -0700 (PDT)
Subject: Re: [RFC] ntb/plx: Add support for PLX hardware
References: <20210520222323.104901-1-jkirsher@ixsystems.com>
 <ebfdfe78-67f2-2096-5e89-bd1b65fa819c@deltatee.com>
 <feeea59f0612d257591cd14953d31c5f1482c012.camel@ixsystems.com>
 <533937f2-7d41-7bfc-9323-e67c8d4878c9@deltatee.com>
From: Dave Jiang <dave.jiang@intel.com>
Message-ID: <2275dc4e-fea1-dafd-c256-0f6f32f9e3fc@intel.com>
Date: Fri, 21 May 2021 08:22:14 -0700
MIME-Version: 1.0
In-Reply-To: <533937f2-7d41-7bfc-9323-e67c8d4878c9@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
To: Logan Gunthorpe <logang@deltatee.com>, Jeff Kirsher <jkirsher@ixsystems.com>, jdmason@kudzu.us, allenbh@gmail.com
Cc: linux-ntb@googlegroups.com, Alexander Motin <mav@ixsystems.com>
List-ID: <linux-ntb.googlegroups.com>


On 5/20/2021 6:13 PM, Logan Gunthorpe wrote:
>
>
> On 2021-05-20 6:17 p.m., Jeff Kirsher wrote:
>> Is this something new that all NTB drivers are expected to adopt?  Just
>> asking because I used the Intel and AMD drivers as examples and they
>> are still using pci_iomap(), etc...
> I can't speak to expectations, I'm not the gatekeeper, only a previewer
> passing by.
>
> I believe they are newer than the AMD and Intel drivers and there are
> new ones added here and there. I think generally, kernel wide, they're a
> better choice. You'll find your code will be a lot cleaner, smaller and
> easier to understand if you adopt them.

The Intel driver is pre devm allocators. Maybe one of these days when I 
have time I'll clean that up and covert it. But I agree with Logan that 
things will be cleaner and smaller with devm_ calls.


> Logan
