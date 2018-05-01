Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id t14-v6si557301itc.2.2018.05.01.09.15.08
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 May 2018 09:15:08 -0700 (PDT)
References: <8A1F3ACA2F40C04FBF91985D6F491D7C017448F2@MX302CL01.corp.emc.com>
 <ab9e8b5c-3494-34f5-2112-3d69ad67ff1c@deltatee.com>
 <8A1F3ACA2F40C04FBF91985D6F491D7C01744B4B@MX302CL01.corp.emc.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <e97625c6-657c-e635-ade8-b1501b09d141@deltatee.com>
Date: Tue, 1 May 2018 10:15:06 -0600
MIME-Version: 1.0
In-Reply-To: <8A1F3ACA2F40C04FBF91985D6F491D7C01744B4B@MX302CL01.corp.emc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: memcpy over NTB
To: "Glimcher, Boris" <Boris.Glimcher@dell.com>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

On 5/1/2018 10:09 AM, Glimcher, Boris wrote:
> So one approach could be to modify kernel driver and use ioctl from user space to submit buffers for transfer and kernel driver will copy or use dma to copy the buffer to the other side?
> What do you think? Valid?

Yes, I think that'd be a good choice. Create an in-kernel NTB client 
with a char device which has an IOCTL or read/write interface for 
submitting buffers. This keeps MW setup and DMA operations inside the 
kernel.

Logan
