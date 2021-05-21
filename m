Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [204.191.154.188])
        by gmr-mx.google.com with ESMTPS id h7si477253uad.1.2021.05.20.18.13.11
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 18:13:11 -0700 (PDT)
References: <20210520222323.104901-1-jkirsher@ixsystems.com>
 <ebfdfe78-67f2-2096-5e89-bd1b65fa819c@deltatee.com>
 <feeea59f0612d257591cd14953d31c5f1482c012.camel@ixsystems.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <533937f2-7d41-7bfc-9323-e67c8d4878c9@deltatee.com>
Date: Thu, 20 May 2021 19:13:07 -0600
MIME-Version: 1.0
In-Reply-To: <feeea59f0612d257591cd14953d31c5f1482c012.camel@ixsystems.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Subject: Re: [RFC] ntb/plx: Add support for PLX hardware
To: Jeff Kirsher <jkirsher@ixsystems.com>, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com
Cc: linux-ntb@googlegroups.com, Alexander Motin <mav@ixsystems.com>
List-ID: <linux-ntb.googlegroups.com>




On 2021-05-20 6:17 p.m., Jeff Kirsher wrote:
> 
> Is this something new that all NTB drivers are expected to adopt?  Just
> asking because I used the Intel and AMD drivers as examples and they
> are still using pci_iomap(), etc...

I can't speak to expectations, I'm not the gatekeeper, only a previewer
passing by.

I believe they are newer than the AMD and Intel drivers and there are
new ones added here and there. I think generally, kernel wide, they're a
better choice. You'll find your code will be a lot cleaner, smaller and
easier to understand if you adopt them.

Logan
