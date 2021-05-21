Return-Path: <jkirsher@ixsystems.com>
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com. [2607:f8b0:4864:20::429])
        by gmr-mx.google.com with ESMTPS id y24si579658qtm.0.2021.05.20.18.15.06
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 May 2021 18:15:06 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d78so12834431pfd.10
        for <linux-ntb@googlegroups.com>; Thu, 20 May 2021 18:15:06 -0700 (PDT)
Return-Path: <jkirsher@ixsystems.com>
Message-ID: <be97b20f0c376a2e6647a7222ee3a5937e47dbf7.camel@ixsystems.com>
Subject: Re: [RFC] ntb/plx: Add support for PLX hardware
From: Jeff Kirsher <jkirsher@ixsystems.com>
Date: Thu, 20 May 2021 18:15:04 -0700
In-Reply-To: <533937f2-7d41-7bfc-9323-e67c8d4878c9@deltatee.com>
References: <20210520222323.104901-1-jkirsher@ixsystems.com>
	 <ebfdfe78-67f2-2096-5e89-bd1b65fa819c@deltatee.com>
	 <feeea59f0612d257591cd14953d31c5f1482c012.camel@ixsystems.com>
	 <533937f2-7d41-7bfc-9323-e67c8d4878c9@deltatee.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Logan Gunthorpe <logang@deltatee.com>, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com
Cc: linux-ntb@googlegroups.com, Alexander Motin <mav@ixsystems.com>
List-ID: <linux-ntb.googlegroups.com>

On Thu, 2021-05-20 at 19:13 -0600, Logan Gunthorpe wrote:
> 
> 
> 
> On 2021-05-20 6:17 p.m., Jeff Kirsher wrote:
> > 
> > Is this something new that all NTB drivers are expected to adopt? 
> > Just
> > asking because I used the Intel and AMD drivers as examples and
> > they
> > are still using pci_iomap(), etc...
> 
> I can't speak to expectations, I'm not the gatekeeper, only a
> previewer
> passing by.
> 
> I believe they are newer than the AMD and Intel drivers and there are
> new ones added here and there. I think generally, kernel wide,
> they're a
> better choice. You'll find your code will be a lot cleaner, smaller
> and
> easier to understand if you adopt them.
> 
> Logan

Thanks, I can make those changes.

