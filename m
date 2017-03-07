Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf0-x241.google.com (mail-lf0-x241.google.com. [2a00:1450:4010:c07::241])
        by gmr-mx.google.com with ESMTPS id t131si46631wmf.1.2017.03.07.07.09.00
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Mar 2017 07:09:00 -0800 (PST)
Received: by mail-lf0-x241.google.com with SMTP id g70so367479lfh.3
        for <linux-ntb@googlegroups.com>; Tue, 07 Mar 2017 07:09:00 -0800 (PST)
Return-Path: <fancer.lancer@gmail.com>
Date: Tue, 7 Mar 2017 18:09:26 +0300
From: Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH v4] NTB: Add IDT 89HPESxNTx PCIe-switches support
Message-ID: <20170307150926.GA7149@mobilestation>
References: <1487933348-32403-1-git-send-email-fancer.lancer@gmail.com>
 <1488187351-12624-1-git-send-email-fancer.lancer@gmail.com>
 <c293fffa-d714-49d3-b0a5-4a1183b5229a@googlegroups.com>
 <20170307015755.GA14511@mobilestation.tp-local.ru>
 <26e320d1-392c-ee60-440c-e293d7dc86bc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26e320d1-392c-ee60-440c-e293d7dc86bc@gmail.com>
To: Logan Gunthorpe <lsgunthorpe@gmail.com>
Cc: linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

On Mon, Mar 06, 2017 at 08:27:49PM -0700, Logan Gunthorpe <lsgunthorpe@gmail.com> wrote:
> 
> 
> On 06/03/17 06:57 PM, Serge Semin wrote:
> > Agreed. Replaced with traditional dev_*() methods.
> 
> You should also be printing using the ntb's device and not the parent
> device. ie use:
> 
> ndev->ntb.dev
> 
> instead of
> 
> ndev->ntb.pdev->dev
> 

No I shouldn't. The thing is, that NTB API has two levels of drivers: client
and hardware drivers. IDT NTB driver you are reviewing is hardware driver, it
refers to the actual PCIe-device and is responsible for communications with it.
The client drivers use NTB API abstraction and common facilities it exposes to
implement some user-available functionality. They communicate with NTB devices
registered by the hardware drivers. So to speak the client drivers work with
ndev->ntb.dev, but the hardware drivers - with ndev->ntb.pdev->dev. That's why
it is necessary to separate the logs of these two levels.

> 
> > It's obvious, to prevent a race condition of access to the Mapping table, which
> > is implemented by Address and Data registers set.
> > For the same reason the driver have spin lock to protect an access to the
> > Global Switch registers using GASA-ADDR and GASA-DATA.
> 
> Ah, I see. Perhaps these should be in their own function in the same way
> as the gasa functions? It would probably be a bit clearer.
> 

I would rather leave it as is. It's just two lines of code, which are present
just at one place of the driver. 

> > Kind of funny. You've sent some comments about devres methods usage, but
> > suspected a memory leak at the moment where it's actually used. So take a look
> > at the place of "ndev" structure allocation, and you'll find an answer.
> 
> Ah sorry, I missed that. Usually I expect to see the structure free'd by
> the release function on the device. But NTB is a little odd in that regard.
> 

It's not NTB, but in general devres isn't that wide spread in the kernel drivers,
since the technology is pretty new. Most of drivers developers are just used to
do allocations/enables and deallocations/disables/releases manually in the code.
Although it's really handy to get being familiar with devres methods.

> Also, per section 8 of the Linux style guide[1], IMO this code is pretty
> over commented.
> 
> Logan
> 
> 
> [1] https://static.lwn.net/kerneldoc/process/coding-style.html#commenting

-Sergey

