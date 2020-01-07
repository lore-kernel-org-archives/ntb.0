Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de. [217.72.192.73])
        by gmr-mx.google.com with ESMTPS id 68si9784lfi.3.2020.01.07.09.10.26
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Jan 2020 09:10:26 -0800 (PST)
Received: from mail-vs1-f49.google.com ([209.85.217.49]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MZkxd-1jAcOk3RwN-00Wlsd for <linux-ntb@googlegroups.com>; Tue, 07 Jan
 2020 18:10:26 +0100
Received: by mail-vs1-f49.google.com with SMTP id t12so34332864vso.13
        for <linux-ntb@googlegroups.com>; Tue, 07 Jan 2020 09:10:25 -0800 (PST)
MIME-Version: 1.0
References: <1578415992-24054-1-git-send-email-krzk@kernel.org> <1578415992-24054-9-git-send-email-krzk@kernel.org>
In-Reply-To: <1578415992-24054-9-git-send-email-krzk@kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 7 Jan 2020 18:10:07 +0100
Message-ID: <CAK8P3a1RibnRU6SiVjrOy-q+ZDdKacQgD9mrft_aHMgA9hm3PA@mail.gmail.com>
Subject: Re: [RFT 06/13] arc: Constify ioreadX() iomem argument (as in generic implementation)
Content-Type: text/plain; charset="UTF-8"
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Alexey Brodkin <abrodkin@synopsys.com>, Vineet Gupta <vgupta@synopsys.com>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Dave Airlie <airlied@redhat.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Ben Skeggs <bskeggs@redhat.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Jiri Slaby <jirislaby@gmail.com>, Nick Kossifidis <mickflemm@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>, Kalle Valo <kvalo@codeaurora.org>, "David S. Miller" <davem@davemloft.net>, Dave Jiang <dave.jiang@intel.com>, Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Geert Uytterhoeven <geert@linux-m68k.org>, alpha <linux-alpha@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:SYNOPSYS ARC ARCHITECTURE" <linux-snps-arc@lists.infradead.org>, Parisc List <linux-parisc@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Linux-sh list <linux-sh@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, ML nouveau <nouveau@lists.freedesktop.org>, Linux Media Mailing List <linux-media@vger.kernel.org>, linux-wireless <linux-wireless@vger.kernel.org>, Networking <netdev@vger.kernel.org>, linux-ntb@googlegroups.com, virtualization@lists.linux-foundation.org, linux-arch <linux-arch@vger.kernel.org>
List-ID: <linux-ntb.googlegroups.com>

On Tue, Jan 7, 2020 at 5:54 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> The ioreadX() helpers have inconsistent interface.  On some architectures
> void *__iomem address argument is a pointer to const, on some not.
>
> Implementations of ioreadX() do not modify the memory under the
> address so they can be converted to a "const" version for const-safety
> and consistency among architectures.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

The patch looks correct, but I would not bother here, as it has no
effect on the compiler or its output.

      Arnd
