Return-Path: <rth7680@gmail.com>
Received: from mail-qk0-x241.google.com (mail-qk0-x241.google.com. [2607:f8b0:400d:c09::241])
        by gmr-mx.google.com with ESMTPS id p68si155497ywg.9.2017.06.22.14.20.51
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Jun 2017 14:20:51 -0700 (PDT)
Received: by mail-qk0-x241.google.com with SMTP id r62so3884318qkf.3
        for <linux-ntb@googlegroups.com>; Thu, 22 Jun 2017 14:20:51 -0700 (PDT)
Return-Path: <rth7680@gmail.com>
Sender: Richard Henderson <rth7680@gmail.com>
Subject: Re: [PATCH 4/7] alpha: provide ioread64 and iowrite64 implementations
References: <20170622164817.25515-1-logang@deltatee.com>
 <20170622164817.25515-5-logang@deltatee.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <a854aa15-3ec7-1605-aeef-e41948996d21@twiddle.net>
Date: Thu, 22 Jun 2017 14:20:43 -0700
MIME-Version: 1.0
In-Reply-To: <20170622164817.25515-5-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-ntb@googlegroups.com, linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stephen Bates <sbates@raithlin.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

On 06/22/2017 09:48 AM, Logan Gunthorpe wrote:
> Alpha implements its own io operation and doesn't use the
> common library. Thus to make ioread64 and iowrite64 globally
> available we need to add implementations for alpha.
> 
> For this, we simply use calls that chain two 32-bit operations.
> (mostly because I don't really understand the alpha architecture.)

It's not difficult to provide this interface[*].  I believe the only reason I 
didn't do so from the beginning is that it wasn't used.



r~


* At least for systems other than Jensen, which cannot generate 64-bit I/O.  On 
the other hand, Jensen doesn't have PCI (EISA only), and so won't have any 
devices that care.
