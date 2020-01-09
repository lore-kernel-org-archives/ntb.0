Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-oi1-f193.google.com (mail-oi1-f193.google.com. [209.85.167.193])
        by gmr-mx.google.com with ESMTPS id i53si302696qte.2.2020.01.09.04.00.52
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2020 04:00:52 -0800 (PST)
Received: by mail-oi1-f193.google.com with SMTP id i1so5597281oie.8
        for <linux-ntb@googlegroups.com>; Thu, 09 Jan 2020 04:00:52 -0800 (PST)
MIME-Version: 1.0
References: <20200108200528.4614-1-krzk@kernel.org> <20200108200528.4614-2-krzk@kernel.org>
In-Reply-To: <20200108200528.4614-2-krzk@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 9 Jan 2020 13:00:40 +0100
Message-ID: <CAMuHMdV8NYiq0744EGw2zit7DZc5=rOpL7en_NeCx2GTD3F3ZQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] iomap: Constify ioreadX() iomem argument (as in
 generic implementation)
Content-Type: text/plain; charset="UTF-8"
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Alexey Brodkin <abrodkin@synopsys.com>, Vineet Gupta <vgupta@synopsys.com>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Dave Airlie <airlied@redhat.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Ben Skeggs <bskeggs@redhat.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Jiri Slaby <jirislaby@gmail.com>, Nick Kossifidis <mickflemm@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>, Kalle Valo <kvalo@codeaurora.org>, "David S. Miller" <davem@davemloft.net>, Dave Jiang <dave.jiang@intel.com>, Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert+renesas@glider.be>, Thomas Gleixner <tglx@linutronix.de>, alpha <linux-alpha@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, arcml <linux-snps-arc@lists.infradead.org>, Parisc List <linux-parisc@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Linux-sh list <linux-sh@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, nouveau@lists.freedesktop.org, Linux Media Mailing List <linux-media@vger.kernel.org>, linux-wireless <linux-wireless@vger.kernel.org>, netdev <netdev@vger.kernel.org>, linux-ntb@googlegroups.com, virtualization@lists.linux-foundation.org, Linux-Arch <linux-arch@vger.kernel.org>
List-ID: <linux-ntb.googlegroups.com>

On Wed, Jan 8, 2020 at 9:05 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> The ioreadX() and ioreadX_rep() helpers have inconsistent interface.  On
> some architectures void *__iomem address argument is a pointer to const,
> on some not.
>
> Implementations of ioreadX() do not modify the memory under the address
> so they can be converted to a "const" version for const-safety and
> consistency among architectures.
>
> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
