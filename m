Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id l65-v6si852083itb.1.2018.05.02.08.42.43
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 May 2018 08:42:43 -0700 (PDT)
References: <8A1F3ACA2F40C04FBF91985D6F491D7C017448F2@MX302CL01.corp.emc.com>
 <ab9e8b5c-3494-34f5-2112-3d69ad67ff1c@deltatee.com>
 <8A1F3ACA2F40C04FBF91985D6F491D7C01744B4B@MX302CL01.corp.emc.com>
 <e97625c6-657c-e635-ade8-b1501b09d141@deltatee.com>
 <8A1F3ACA2F40C04FBF91985D6F491D7C01744B65@MX302CL01.corp.emc.com>
 <b8ce2095-98d4-81ff-ebfa-00d69deee8eb@deltatee.com>
 <8A1F3ACA2F40C04FBF91985D6F491D7C01744DA0@MX302CL01.corp.emc.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <4f05cc88-5ad6-e8f0-070c-0cc62d30d878@deltatee.com>
Date: Wed, 2 May 2018 09:42:41 -0600
MIME-Version: 1.0
In-Reply-To: <8A1F3ACA2F40C04FBF91985D6F491D7C01744DA0@MX302CL01.corp.emc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: memcpy over NTB
To: "Glimcher, Boris" <Boris.Glimcher@dell.com>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

On 5/2/2018 2:06 AM, Glimcher, Boris wrote:
> The synchronization is not an issue, I believe, as I'm looking just to mirror large memory area from one side to another

What happens if one side is reading while the other side is changing the 
memory? They'd read some of the data before the change and some of the 
data after the change resulting in inconsistent data. "just mirroring" 
doesn't solve those issues.

Logan

