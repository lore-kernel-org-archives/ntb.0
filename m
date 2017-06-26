Return-Path: <jsarha@ti.com>
Received: from lelnx193.ext.ti.com (lelnx193.ext.ti.com. [198.47.27.77])
        by gmr-mx.google.com with ESMTPS id 81si808756ith.1.2017.06.26.01.55.19
        for <linux-ntb@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 26 Jun 2017 01:55:19 -0700 (PDT)
Subject: Re: [PATCH 6/7] drm/tilcdc: clean up ifdef hacks around iowrite64
References: <20170622164817.25515-1-logang@deltatee.com>
 <20170622164817.25515-7-logang@deltatee.com>
From: Jyri Sarha <jsarha@ti.com>
Message-ID: <504da99a-838c-48ec-c5b2-6b611d587a10@ti.com>
Date: Mon, 26 Jun 2017 11:55:03 +0300
MIME-Version: 1.0
In-Reply-To: <20170622164817.25515-7-logang@deltatee.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
To: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-ntb@googlegroups.com, linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stephen Bates <sbates@raithlin.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, David Airlie <airlied@linux.ie>
List-ID: <linux-ntb.googlegroups.com>

On 06/22/17 19:48, Logan Gunthorpe wrote:
> Now that we can expect iowrite64 to always exist the hack is no longer
> necessary so we just call iowrite64 directly.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Cc: Jyri Sarha <jsarha@ti.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: David Airlie <airlied@linux.ie>

Acked-by: Jyri Sarha <jsarha@ti.com>

And thanks!

> ---
>  drivers/gpu/drm/tilcdc/tilcdc_regs.h | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tilcdc/tilcdc_regs.h b/drivers/gpu/drm/tilcdc/tilcdc_regs.h
> index e9ce725698a9..0b901405f30a 100644
> --- a/drivers/gpu/drm/tilcdc/tilcdc_regs.h
> +++ b/drivers/gpu/drm/tilcdc/tilcdc_regs.h
> @@ -133,13 +133,7 @@ static inline void tilcdc_write64(struct drm_device *dev, u32 reg, u64 data)
>  	struct tilcdc_drm_private *priv = dev->dev_private;
>  	void __iomem *addr = priv->mmio + reg;
>  
> -#ifdef iowrite64
>  	iowrite64(data, addr);
> -#else
> -	__iowmb();
> -	/* This compiles to strd (=64-bit write) on ARM7 */
> -	*(u64 __force *)addr = __cpu_to_le64(data);
> -#endif
>  }
>  
>  static inline u32 tilcdc_read(struct drm_device *dev, u32 reg)
> 

