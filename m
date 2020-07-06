Return-Path: <vkoul@kernel.org>
Received: from mail.kernel.org (mail.kernel.org. [198.145.29.99])
        by gmr-mx.google.com with ESMTPS id y197si774114pfc.4.2020.07.05.21.48.30
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Jul 2020 21:48:30 -0700 (PDT)
Date: Mon, 6 Jul 2020 10:18:24 +0530
From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH 01/17] Documentation/driver-api: dmaengine/provider: drop
 doubled word
Message-ID: <20200706044824.GB633187@vkoul-mobl>
References: <20200704034502.17199-1-rdunlap@infradead.org>
 <20200704034502.17199-2-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200704034502.17199-2-rdunlap@infradead.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, dmaengine@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, William Breathitt Gray <vilhelm.gray@gmail.com>, linux-iio@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, linux-nvdimm@lists.01.org, linux-usb@vger.kernel.org, Eli Billauer <eli.billauer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

On 03-07-20, 20:44, Randy Dunlap wrote:
> Drop the doubled word "has".

Applied, thanks

> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: dmaengine@vger.kernel.org
> ---
>  Documentation/driver-api/dmaengine/provider.rst |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-next-20200701.orig/Documentation/driver-api/dmaengine/provider.rst
> +++ linux-next-20200701/Documentation/driver-api/dmaengine/provider.rst
> @@ -507,7 +507,7 @@ dma_cookie_t
>  DMA_CTRL_ACK
>  
>  - If clear, the descriptor cannot be reused by provider until the
> -  client acknowledges receipt, i.e. has has a chance to establish any
> +  client acknowledges receipt, i.e. has a chance to establish any
>    dependency chains
>  
>  - This can be acked by invoking async_tx_ack()

-- 
~Vinod
