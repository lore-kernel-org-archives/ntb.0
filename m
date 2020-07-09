Return-Path: <k.kozlowski.k@gmail.com>
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com. [209.85.208.68])
        by gmr-mx.google.com with ESMTPS id l4si101719wrm.3.2020.07.09.00.32.53
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 00:32:53 -0700 (PDT)
Received: by mail-ed1-f68.google.com with SMTP id e22so1017198edq.8
        for <linux-ntb@googlegroups.com>; Thu, 09 Jul 2020 00:32:53 -0700 (PDT)
Return-Path: <k.kozlowski.k@gmail.com>
Date: Thu, 9 Jul 2020 09:32:49 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v3 1/4] iomap: Constify ioreadX() iomem argument (as in
 generic implementation)
Message-ID: <20200709073249.GA6335@kozik-lap>
References: <20200709072837.5869-1-krzk@kernel.org>
 <20200709072837.5869-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200709072837.5869-2-krzk@kernel.org>
To: Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Kalle Valo <kvalo@codeaurora.org>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Dave Jiang <dave.jiang@intel.com>, Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert+renesas@glider.be>, Andrew Morton <akpm@linux-foundation.org>, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, linux-wireless@vger.kernel.org, netdev@vger.kernel.org, linux-ntb@googlegroups.com, virtualization@lists.linux-foundation.org, linux-arch@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

On Thu, Jul 09, 2020 at 09:28:34AM +0200, Krzysztof Kozlowski wrote:
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
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>

I forgot to put here one more Ack, for PowerPC:
Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

https://lore.kernel.org/lkml/87ftedj0zz.fsf@mpe.ellerman.id.au/

Best regards,
Krzysztof

