Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id o81-v6si354408ita.0.2018.05.01.08.41.02
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 May 2018 08:41:02 -0700 (PDT)
References: <8A1F3ACA2F40C04FBF91985D6F491D7C017448F2@MX302CL01.corp.emc.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <ab9e8b5c-3494-34f5-2112-3d69ad67ff1c@deltatee.com>
Date: Tue, 1 May 2018 09:41:00 -0600
MIME-Version: 1.0
In-Reply-To: <8A1F3ACA2F40C04FBF91985D6F491D7C017448F2@MX302CL01.corp.emc.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: memcpy over NTB
To: "Glimcher, Boris" <Boris.Glimcher@dell.com>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

On 5/1/2018 6:09 AM, Glimcher, Boris wrote:
> I’d like to move to user space now and for starters I would like to do a 
> simple MEMCPY over NTB to the peer’s memory.

This isn't supported by the kernel at all. It also introduces 
significant security concerns. I'm afraid you're on your own if you want 
to do something like that.

I'd suggest developing a custom in-kernel NTB client to suit your needs 
instead.

Logan
