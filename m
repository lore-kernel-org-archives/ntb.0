Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id 21si58376itj.0.2017.06.26.14.26.04
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Jun 2017 14:26:04 -0700 (PDT)
References: <20170622164817.25515-1-logang@deltatee.com>
 <20170622164817.25515-3-logang@deltatee.com>
 <CAK8P3a1Uh=PQbGi540KGLpkoEVH+KUW18mzqN3aiijroXwEMWQ@mail.gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <0746dbb0-9fc1-d24c-89c0-b079a3cd0c7b@deltatee.com>
Date: Mon, 26 Jun 2017 15:25:41 -0600
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1Uh=PQbGi540KGLpkoEVH+KUW18mzqN3aiijroXwEMWQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/7] iomap: implement ioread64 and iowrite64
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-ntb@googlegroups.com, linux-alpha@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-crypto@vger.kernel.org, dri-devel <dri-devel@lists.freedesktop.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stephen Bates <sbates@raithlin.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Suresh Warrier <warrier@linux.vnet.ibm.com>, Nicholas Piggin <npiggin@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

On 6/26/2017 2:43 PM, Arnd Bergmann wrote:
> This hardcodes the behavior of include/linux/io-64-nonatomic-hi-lo.h, which
> I find rather confusing, as only about one in five drivers wants this
> behavior.
>
> I'd suggest you don't add it in lib/iomap.c at all for 32-bit architectures,
> but rather use the same logic that we have for readq/writeq in
> io-64-nonatomic-hi-lo.h and io-64-nonatomic-lo-hi.h, adding
> {lo_hi,hi_lo}_{ioread,iowrite}{,be} to the same files, and provide
> the {ioread,iowrite}{,be} macros only if they have not been defined
> at that point.

Thanks Arnd. Yes, I'm already reworking this patchset to do exactly that.

Logan

