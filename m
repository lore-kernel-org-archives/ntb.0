Return-Path: <k.kozlowski.k@gmail.com>
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com. [209.85.208.65])
        by gmr-mx.google.com with ESMTPS id y185si50856wmd.2.2020.01.08.01.15.54
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2020 01:15:54 -0800 (PST)
Received: by mail-ed1-f65.google.com with SMTP id l8so1994132edw.1
        for <linux-ntb@googlegroups.com>; Wed, 08 Jan 2020 01:15:54 -0800 (PST)
Return-Path: <k.kozlowski.k@gmail.com>
Date: Wed, 8 Jan 2020 10:15:49 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [RFT 00/13] iomap: Constify ioreadX() iomem argument
Message-ID: <20200108091549.GB10145@pi3>
References: <1578415992-24054-1-git-send-email-krzk@kernel.org>
 <CAMuHMdW4ek0OYQDrrbcpZjNUTTP04nSbwkmiZvBmKcU=PQM9qA@mail.gmail.com>
 <CAMuHMdUBmYtJKtSYzS_5u67hVZOqcKSgFY1rDGme6gLNRBJ_gA@mail.gmail.com>
 <CAJKOXPfq9vS4kSyx1jOPHBvi9_HjviRv0LU2A8ZwdmqgUuebHQ@mail.gmail.com>
 <2355489c-a207-1927-54cf-85c04b62f18f@c-s.fr>
 <CAK8P3a21yPrmp4ik3Ei1BZfeqZNf0wL5NZNF3uXqb4FLRDyUPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAK8P3a21yPrmp4ik3Ei1BZfeqZNf0wL5NZNF3uXqb4FLRDyUPw@mail.gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>, Geert Uytterhoeven <geert@linux-m68k.org>, Rich Felker <dalias@libc.org>, Jiri Slaby <jirislaby@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, David Airlie <airlied@linux.ie>, Jason Wang <jasowang@redhat.com>, DRI Development <dri-devel@lists.freedesktop.org>, virtualization@lists.linux-foundation.org, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, netdev <netdev@vger.kernel.org>, Paul Mackerras <paulus@samba.org>, Linux-Arch <linux-arch@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Helge Deller <deller@gmx.de>, Linux-sh list <linux-sh@vger.kernel.org>, Alexey Brodkin <abrodkin@synopsys.com>, Ben Skeggs <bskeggs@redhat.com>, ML nouveau <nouveau@lists.freedesktop.org>, Dave Airlie <airlied@redhat.com>, Matt Turner <mattst88@gmail.com>, arcml <linux-snps-arc@lists.infradead.org>, Nick Kossifidis <mickflemm@gmail.com>, Allen Hubbe <allenbh@gmail.com>, alpha <linux-alpha@vger.kernel.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Thomas Gleixner <tglx@linutronix.de>, Mauro Carvalho Chehab <mchehab@kernel.org>, Kalle Valo <kvalo@codeaurora.org>, Richard Henderson <rth@twiddle.net>, Parisc List <linux-parisc@vger.kernel.org>, Vineet Gupta <vgupta@synopsys.com>, linux-wireless <linux-wireless@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Daniel Vetter <daniel@ffwll.ch>, Jon Mason <jdmason@kudzu.us>, linux-ntb@googlegroups.com, Andrew Morton <akpm@linux-foundation.org>, Linux Media Mailing List <linux-media@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, "David S. Miller" <davem@davemloft.net>
List-ID: <linux-ntb.googlegroups.com>

On Wed, Jan 08, 2020 at 09:44:36AM +0100, Arnd Bergmann wrote:
> On Wed, Jan 8, 2020 at 9:36 AM Christophe Leroy <christophe.leroy@c-s.fr>=
 wrote:
> > Le 08/01/2020 =C3=A0 09:18, Krzysztof Kozlowski a =C3=A9crit :
> > > On Wed, 8 Jan 2020 at 09:13, Geert Uytterhoeven <geert@linux-m68k.org=
> wrote:
> > > I'll add to this one also changes to ioreadX_rep() and add another
> > > patch for volatile for reads and writes. I guess your review will be
> > > appreciated once more because of ioreadX_rep()
> > >
> >
> > volatile should really only be used where deemed necessary:
> >
> > https://www.kernel.org/doc/html/latest/process/volatile-considered-harm=
ful.html
> >
> > It is said: " ...  accessor functions might use volatile on
> > architectures where direct I/O memory access does work. Essentially,
> > each accessor call becomes a little critical section on its own and
> > ensures that the access happens as expected by the programmer."
>=20
> The I/O accessors are one of the few places in which 'volatile' generally
> makes sense, at least for the implementations that do a plain pointer
> dereference (probably none of the ones in question here).
>=20
> In case of readl/writel, this is what we do in asm-generic:
>=20
> static inline u32 __raw_readl(const volatile void __iomem *addr)
> {
>         return *(const volatile u32 __force *)addr;
> }

SuperH is another example:
1. ioread8_rep(void __iomem *addr, void *dst, unsigned long count)
   calls mmio_insb()

2. static inline void mmio_insb(void __iomem *addr, u8 *dst, int count)
   calls __raw_readb()

3. #define __raw_readb(a)          (__chk_io_ptr(a), *(volatile u8  __force=
 *)(a))

Even if interface was not marked as volatile, in fact its implementation
was casting to volatile.

> The __force-cast that removes the __iomem here also means that
> the 'volatile' keyword could be dropped from the argument list,
> as it has no real effect any more, but then there are a few drivers
> that mark their iomem pointers as either 'volatile void __iomem*' or
> (worse) 'volatile void *', so we keep it in the argument list to not
> add warnings for those drivers.
>=20
> It may be time to change these drivers to not use volatile for __iomem
> pointers, but that seems out of scope for what Krzysztof is trying
> to do. Ideally we would be consistent here though, either using volatile
> all the time or never.

Indeed. I guess there are no objections around const so let me send v2
for const only.

Best regards,
Krzysztof

