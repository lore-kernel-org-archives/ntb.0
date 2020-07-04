Return-Path: <jic23@kernel.org>
Received: from mail.kernel.org (mail.kernel.org. [198.145.29.99])
        by gmr-mx.google.com with ESMTPS id v16si1029454ybe.2.2020.07.04.09.09.12
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Jul 2020 09:09:12 -0700 (PDT)
Date: Sat, 4 Jul 2020 17:09:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 07/17] Documentation/driver-api: iio/buffers: drop
 doubled word
Message-ID: <20200704170905.7e596707@archlinux>
In-Reply-To: <20200704034502.17199-8-rdunlap@infradead.org>
References: <20200704034502.17199-1-rdunlap@infradead.org>
	<20200704034502.17199-8-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, William Breathitt Gray <vilhelm.gray@gmail.com>, linux-iio@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, linux-nvdimm@lists.01.org, linux-usb@vger.kernel.org, Eli Billauer <eli.billauer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

On Fri,  3 Jul 2020 20:44:52 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> Drop the doubled word "struct".
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: William Breathitt Gray <vilhelm.gray@gmail.com>
> Cc: linux-iio@vger.kernel.org
Applied to the togreg branch of iio.git.

Thanks,

Jonathan

> ---
>  Documentation/driver-api/iio/buffers.rst |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-next-20200701.orig/Documentation/driver-api/iio/buffers.rst
> +++ linux-next-20200701/Documentation/driver-api/iio/buffers.rst
> @@ -88,7 +88,7 @@ fields in iio_chan_spec definition::
>  The driver implementing the accelerometer described above will have the
>  following channel definition::
>  
> -   struct struct iio_chan_spec accel_channels[] = {
> +   struct iio_chan_spec accel_channels[] = {
>             {
>                     .type = IIO_ACCEL,
>  		   .modified = 1,

