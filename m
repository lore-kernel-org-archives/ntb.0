Return-Path: <jic23@kernel.org>
Received: from mail.kernel.org (mail.kernel.org. [198.145.29.99])
        by gmr-mx.google.com with ESMTPS id j10si757986qko.0.2020.07.04.09.08.13
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Jul 2020 09:08:13 -0700 (PDT)
Date: Sat, 4 Jul 2020 17:08:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 06/17] Documentation/driver-api: generic-counter: drop
 doubled word
Message-ID: <20200704170805.18b07f1a@archlinux>
In-Reply-To: <20200704123041.GA5194@shinobu>
References: <20200704034502.17199-1-rdunlap@infradead.org>
	<20200704034502.17199-7-rdunlap@infradead.org>
	<20200704123041.GA5194@shinobu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, linux-nvdimm@lists.01.org, linux-usb@vger.kernel.org, Eli Billauer <eli.billauer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

On Sat, 4 Jul 2020 08:30:41 -0400
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> On Fri, Jul 03, 2020 at 08:44:51PM -0700, Randy Dunlap wrote:
> > Drop the doubled word "the".
> > 
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: linux-doc@vger.kernel.org
> > Cc: William Breathitt Gray <vilhelm.gray@gmail.com>
> > Cc: linux-iio@vger.kernel.org
> > ---
> >  Documentation/driver-api/generic-counter.rst |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > --- linux-next-20200701.orig/Documentation/driver-api/generic-counter.rst
> > +++ linux-next-20200701/Documentation/driver-api/generic-counter.rst
> > @@ -262,7 +262,7 @@ the system.
> >  Counter Counts may be allocated via counter_count structures, and
> >  respective Counter Signal associations (Synapses) made via
> >  counter_synapse structures. Associated counter_synapse structures are
> > -stored as an array and set to the the synapses array member of the
> > +stored as an array and set to the synapses array member of the
> >  respective counter_count structure. These counter_count structures are
> >  set to the counts array member of an allocated counter_device structure
> >  before the Counter is registered to the system.  
> 
> Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>

Applied to the togreg branch of iio.git

Thanks,

Jonathan
