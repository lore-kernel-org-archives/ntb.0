Return-Path: <jkirsher@ixsystems.com>
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com. [2607:f8b0:4864:20::532])
        by gmr-mx.google.com with ESMTPS id y24si1044348qtm.0.2021.05.21.11.33.22
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 May 2021 11:33:22 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id i5so14943298pgm.0
        for <linux-ntb@googlegroups.com>; Fri, 21 May 2021 11:33:22 -0700 (PDT)
Return-Path: <jkirsher@ixsystems.com>
Message-ID: <9d0665ec171dc0dffeb8a54c7ef809fa0796ec79.camel@ixsystems.com>
Subject: Re: [RFC] ntb/plx: Add support for PLX hardware
From: Jeff Kirsher <jkirsher@ixsystems.com>
Date: Fri, 21 May 2021 11:33:20 -0700
In-Reply-To: <ebfdfe78-67f2-2096-5e89-bd1b65fa819c@deltatee.com>
References: <20210520222323.104901-1-jkirsher@ixsystems.com>
	 <ebfdfe78-67f2-2096-5e89-bd1b65fa819c@deltatee.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
To: Logan Gunthorpe <logang@deltatee.com>, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com
Cc: linux-ntb@googlegroups.com, Alexander Motin <mav@ixsystems.com>
List-ID: <linux-ntb.googlegroups.com>

On Thu, 2021-05-20 at 17:48 -0600, Logan Gunthorpe wrote:
> > +module_exit(plx_ntb_pci_driver_exit);
> > diff --git a/drivers/ntb/hw/plx/ntb_hw_plx.h
> > b/drivers/ntb/hw/plx/ntb_hw_plx.h
> > new file mode 100644
> > index 000000000000..4f118432e718
> > --- /dev/null
> > +++ b/drivers/ntb/hw/plx/ntb_hw_plx.h
> 
> We generally do not add header files unless they are shared by
> multiple
> C files. All this code can and should be placed at the top of the C
> file.
> > +#define ntb_ndev(__ntb) container_of(__ntb, struct plx_ntb_dev,
> > ntb)
> 
> Although you see this a lot (and I've added my fair share) many
> kernel
> devs prefer these to be open coded. It's much clearer. Also, though,
> why
> the double underscore on ntb?

I realize I did not answer your question, I did the double underscore
to align with how other NTB drivers defined their own versions of the
same macro.

