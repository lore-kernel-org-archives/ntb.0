Return-Path: <k.kozlowski.k@gmail.com>
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com. [209.85.208.66])
        by gmr-mx.google.com with ESMTPS id z20si770932ejx.1.2020.02.24.06.44.19
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2020 06:44:19 -0800 (PST)
Received: by mail-ed1-f66.google.com with SMTP id r21so12182458edq.0
        for <linux-ntb@googlegroups.com>; Mon, 24 Feb 2020 06:44:19 -0800 (PST)
Return-Path: <k.kozlowski.k@gmail.com>
Date: Mon, 24 Feb 2020 15:44:13 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [RESEND PATCH v2 9/9] ath5k: Constify ioreadX() iomem argument
 (as in generic implementation)
Message-ID: <20200224144413.GA2054@pi3>
References: <20200219175007.13627-1-krzk@kernel.org>
 <20200219175007.13627-10-krzk@kernel.org>
 <518a9023-f802-17b3-fca5-582400bc34ae@gmail.com>
 <20200224124744.GA1949@pi3>
 <CAMuHMdVev0PLF=8bD3nHrhcU9UgM-DAgdQpXi09PgvAxdbt24A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAMuHMdVev0PLF=8bD3nHrhcU9UgM-DAgdQpXi09PgvAxdbt24A@mail.gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jiri Slaby <jirislaby@gmail.com>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Alexey Brodkin <abrodkin@synopsys.com>, Vineet Gupta <vgupta@synopsys.com>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Dave Airlie <airlied@redhat.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Ben Skeggs <bskeggs@redhat.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Nick Kossifidis <mickflemm@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>, Kalle Valo <kvalo@codeaurora.org>, "David S. Miller" <davem@davemloft.net>, Dave Jiang <dave.jiang@intel.com>, Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert+renesas@glider.be>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, alpha <linux-alpha@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, arcml <linux-snps-arc@lists.infradead.org>, Parisc List <linux-parisc@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Linux-sh list <linux-sh@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, nouveau@lists.freedesktop.org, Linux Media Mailing List <linux-media@vger.kernel.org>, linux-wireless <linux-wireless@vger.kernel.org>, netdev <netdev@vger.kernel.org>, linux-ntb@googlegroups.com, virtualization@lists.linux-foundation.org, Linux-Arch <linux-arch@vger.kernel.org>
List-ID: <linux-ntb.googlegroups.com>

On Mon, Feb 24, 2020 at 01:54:00PM +0100, Geert Uytterhoeven wrote:
> Hi Krzysztof,
>=20
> On Mon, Feb 24, 2020 at 1:47 PM Krzysztof Kozlowski <krzk@kernel.org> wro=
te:
> > On Thu, Feb 20, 2020 at 10:48:33AM +0100, Jiri Slaby wrote:
> > > On 19. 02. 20, 18:50, Krzysztof Kozlowski wrote:
> > > > The ioreadX() helpers have inconsistent interface.  On some archite=
ctures
> > > > void *__iomem address argument is a pointer to const, on some not.
> > > >
> > > > Implementations of ioreadX() do not modify the memory under the add=
ress
> > > > so they can be converted to a "const" version for const-safety and
> > > > consistency among architectures.
> > > >
> > > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > > > Acked-by: Kalle Valo <kvalo@codeaurora.org>
> > > > ---
> > > >  drivers/net/wireless/ath/ath5k/ahb.c | 10 +++++-----
> > > >  1 file changed, 5 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/drivers/net/wireless/ath/ath5k/ahb.c b/drivers/net/wir=
eless/ath/ath5k/ahb.c
> > > > index 2c9cec8b53d9..8bd01df369fb 100644
> > > > --- a/drivers/net/wireless/ath/ath5k/ahb.c
> > > > +++ b/drivers/net/wireless/ath/ath5k/ahb.c
> > > > @@ -138,18 +138,18 @@ static int ath_ahb_probe(struct platform_devi=
ce *pdev)
> > > >
> > > >     if (bcfg->devid >=3D AR5K_SREV_AR2315_R6) {
> > > >             /* Enable WMAC AHB arbitration */
> > > > -           reg =3D ioread32((void __iomem *) AR5K_AR2315_AHB_ARB_C=
TL);
> > > > +           reg =3D ioread32((const void __iomem *) AR5K_AR2315_AHB=
_ARB_CTL);
> > >
> > > While I understand why the parameter of ioread32 should be const, I
> > > don't see a reason for these casts on the users' side. What does it
> > > bring except longer code to read?
> >
> > Because the argument is an int:
> >
> > drivers/net/wireless/ath/ath5k/ahb.c: In function =E2=80=98ath_ahb_prob=
e=E2=80=99:
> > drivers/net/wireless/ath/ath5k/ahb.c:141:18: warning: passing argument =
1 of =E2=80=98ioread32=E2=80=99 makes pointer from integer without a cast [=
-Wint-conversion]
> >    reg =3D ioread32(AR5K_AR2315_AHB_ARB_CTL);
>=20
> That's an argument for keeping the cast to "void __iomem *", not for
> adding the "const", right?

Yes, correct. Maybe I misunderstood the question... The const on the
other hand does not have to be in the cast. It is merely for making it
consistent with interface. It is not required. I also mentioned it in
the cover letter:
"PAtches 5-9 are optional cleanup, without actual impact"

Feel free to ignore this one if it is not worth the effort.

Best regards,
Krzysztof

