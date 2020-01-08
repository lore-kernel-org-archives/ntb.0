Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-oi1-f193.google.com (mail-oi1-f193.google.com. [209.85.167.193])
        by gmr-mx.google.com with ESMTPS id e14si161676otr.1.2020.01.08.00.08.06
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2020 00:08:06 -0800 (PST)
Received: by mail-oi1-f193.google.com with SMTP id l136so1912335oig.1
        for <linux-ntb@googlegroups.com>; Wed, 08 Jan 2020 00:08:06 -0800 (PST)
MIME-Version: 1.0
References: <1578415992-24054-1-git-send-email-krzk@kernel.org>
In-Reply-To: <1578415992-24054-1-git-send-email-krzk@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 8 Jan 2020 09:07:54 +0100
Message-ID: <CAMuHMdW4ek0OYQDrrbcpZjNUTTP04nSbwkmiZvBmKcU=PQM9qA@mail.gmail.com>
Subject: Re: [RFT 00/13] iomap: Constify ioreadX() iomem argument
Content-Type: text/plain; charset="UTF-8"
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Alexey Brodkin <abrodkin@synopsys.com>, Vineet Gupta <vgupta@synopsys.com>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Dave Airlie <airlied@redhat.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Ben Skeggs <bskeggs@redhat.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Jiri Slaby <jirislaby@gmail.com>, Nick Kossifidis <mickflemm@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>, Kalle Valo <kvalo@codeaurora.org>, "David S. Miller" <davem@davemloft.net>, Dave Jiang <dave.jiang@intel.com>, Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, alpha <linux-alpha@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, arcml <linux-snps-arc@lists.infradead.org>, Parisc List <linux-parisc@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Linux-sh list <linux-sh@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, nouveau@lists.freedesktop.org, Linux Media Mailing List <linux-media@vger.kernel.org>, linux-wireless <linux-wireless@vger.kernel.org>, netdev <netdev@vger.kernel.org>, linux-ntb@googlegroups.com, virtualization@lists.linux-foundation.org, Linux-Arch <linux-arch@vger.kernel.org>
List-ID: <linux-ntb.googlegroups.com>

Hi Krzysztof,

On Tue, Jan 7, 2020 at 5:53 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> The ioread8/16/32() and others have inconsistent interface among the
> architectures: some taking address as const, some not.
>
> It seems there is nothing really stopping all of them to take
> pointer to const.

Shouldn't all of them take const volatile __iomem pointers?
It seems the "volatile" is missing from all but the implementations in
include/asm-generic/io.h.

> Patchset was really tested on all affected architectures.
> Build testing is in progress - I hope auto-builders will point any issues.
>
>
> Todo
> ====
> Convert also string versions (ioread16_rep() etc) if this aproach looks OK.
>
>
> Merging
> =======
> The first 5 patches - iomap, alpha, sh, parisc and powerpc - should probably go
> via one tree, or even squashed into one.

Yes, they should be squashed, cfr. Arnd's comment.
I also wouldn't bother doing the updates in patches 6-10.

The rest looks good to me.
Thanks a lot!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
