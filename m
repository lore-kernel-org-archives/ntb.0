Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id c67si79353itb.5.2017.06.22.10.30.56
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Jun 2017 10:30:57 -0700 (PDT)
References: <20170622164817.25515-1-logang@deltatee.com>
 <20170622164817.25515-5-logang@deltatee.com>
 <E70FB7EB-3A05-4A08-A85E-020F47751E3B@raithlin.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <0d2f1f7c-d014-5ddf-ad5c-64f13cb5a64a@deltatee.com>
Date: Thu, 22 Jun 2017 11:30:42 -0600
MIME-Version: 1.0
In-Reply-To: <E70FB7EB-3A05-4A08-A85E-020F47751E3B@raithlin.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 4/7] alpha: provide ioread64 and iowrite64 implementations
To: Stephen Bates <sbates@raithlin.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>, "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

On 6/22/2017 11:29 AM, Stephen  Bates wrote:
>> +#define iowrite64be(v,p) iowrite32(cpu_to_be64(v), (p))
>
> Logan, thanks for taking this cleanup on. I think this should be iowrite64 not iowrite32?

Yup, good catch. Thanks. I'll fix it in a v2 of this series.

Logan

