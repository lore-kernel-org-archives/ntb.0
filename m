Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org. [103.22.144.67])
        by gmr-mx.google.com with ESMTPS id 193si1060162pfa.13.2017.07.18.22.57.17
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Jul 2017 22:57:17 -0700 (PDT)
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v4 1/5] powerpc: io.h: move iomap.h include so that it can use readq/writeq defs
In-Reply-To: <20170718165528.7383-2-logang@deltatee.com>
References: <20170718165528.7383-1-logang@deltatee.com> <20170718165528.7383-2-logang@deltatee.com>
Date: Wed, 19 Jul 2017 15:57:11 +1000
Message-ID: <87iniphsug.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
To: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-ntb@googlegroups.com, linux-crypto@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>, Stephen Bates <sbates@raithlin.com>, Logan Gunthorpe <logang@deltatee.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Nicholas Piggin <npiggin@gmail.com>, Suresh Warrier <warrier@linux.vnet.ibm.com>, Oliver O'Halloran <oohall@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

Logan Gunthorpe <logang@deltatee.com> writes:

> Subsequent patches in this series makes use of the readq and writeq
> defines in iomap.h. However, as is, they get missed on the powerpc
> platform seeing the include comes before the define. This patch
> moves the include down to fix this.
>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Suresh Warrier <warrier@linux.vnet.ibm.com>
> Cc: "Oliver O'Halloran" <oohall@gmail.com>
> ---
>  arch/powerpc/include/asm/io.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Seems fair enough, have you tested it at all?

cheers
