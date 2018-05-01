Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id i10-v6si1142760otk.2.2018.05.01.09.26.02
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 May 2018 09:26:02 -0700 (PDT)
References: <8A1F3ACA2F40C04FBF91985D6F491D7C017448F2@MX302CL01.corp.emc.com>
 <ab9e8b5c-3494-34f5-2112-3d69ad67ff1c@deltatee.com>
 <8A1F3ACA2F40C04FBF91985D6F491D7C01744B4B@MX302CL01.corp.emc.com>
 <e97625c6-657c-e635-ade8-b1501b09d141@deltatee.com>
 <8A1F3ACA2F40C04FBF91985D6F491D7C01744B65@MX302CL01.corp.emc.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <b8ce2095-98d4-81ff-ebfa-00d69deee8eb@deltatee.com>
Date: Tue, 1 May 2018 10:25:59 -0600
MIME-Version: 1.0
In-Reply-To: <8A1F3ACA2F40C04FBF91985D6F491D7C01744B65@MX302CL01.corp.emc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: memcpy over NTB
To: "Glimcher, Boris" <Boris.Glimcher@dell.com>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

On 5/1/2018 10:20 AM, Glimcher, Boris wrote:
> Is it also possible with this in-kernel NTB client with a char device to MMAP somehow MW to user?

Yes, this is possible but generally discouraged for drivers.

If you are attempting to optimize for performance then it's much better 
to submit large buffers to a DMA engine.

If you are trying to have random access to the MW you'll have to be very 
careful about synchronization with the opposite side.

Logan
