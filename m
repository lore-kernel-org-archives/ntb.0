Return-Path: <jdmason@kudzu.us>
Received: from mail-qt0-x243.google.com (mail-qt0-x243.google.com. [2607:f8b0:400d:c0d::243])
        by gmr-mx.google.com with ESMTPS id p68si723043ywg.9.2017.06.19.12.14.31
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Jun 2017 12:14:31 -0700 (PDT)
Received: by mail-qt0-x243.google.com with SMTP id x58so20558646qtc.2
        for <linux-ntb@googlegroups.com>; Mon, 19 Jun 2017 12:14:31 -0700 (PDT)
Return-Path: <jdmason@kudzu.us>
Date: Mon, 19 Jun 2017 15:14:28 -0400
From: Jon Mason <jdmason@kudzu.us>
Subject: Re: [RFC PATCH 00/13] Switchtec NTB Support
Message-ID: <20170619191426.GA20511@kudzu.us>
References: <20170615203729.9009-1-logang@deltatee.com>
 <000001d2e6a7$dfc719a0$9f554ce0$@dell.com>
 <daa95888-a786-b6d4-5e56-b9ac5b38a181@deltatee.com>
 <20170616163324.GA15472@mobilestation>
 <883bdb76-972c-7de9-0208-2d0933f192d4@deltatee.com>
 <20170616183824.GA5175@mobilestation.tp-local.ru>
 <33b6c321-c0af-7340-8e8e-e929a00005c7@deltatee.com>
 <20170616202100.GA24969@mobilestation.tp-local.ru>
 <20170617050959.GC6040@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170617050959.GC6040@kroah.com>
To: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Cc: Serge Semin <fancer.lancer@gmail.com>, Logan Gunthorpe <logang@deltatee.com>, Allen Hubbe <Allen.Hubbe@dell.com>, linux-ntb@googlegroups.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 'Dave Jiang' <dave.jiang@intel.com>, 'Bjorn Helgaas' <bhelgaas@google.com>, 'Kurt Schwemmer' <kurt.schwemmer@microsemi.com>, 'Stephen Bates' <sbates@raithlin.com>, Sergey.Semin@t-platforms.ru
List-ID: <linux-ntb.googlegroups.com>

On Sat, Jun 17, 2017 at 07:09:59AM +0200, 'Greg Kroah-Hartman' wrote:
> On Fri, Jun 16, 2017 at 11:21:00PM +0300, Serge Semin wrote:
> > On Fri, Jun 16, 2017 at 01:34:59PM -0600, Logan Gunthorpe <logang@deltatee.com> wrote:
> > > Now, if you'd like to actually review the code I'd be happy to address
> > > any concerns you find. I won't be responding to any more philosophical
> > > arguments or bike-shedding over the format of the patch.
> > > 
> > 
> > I don't want to review a patchset, which isn't properly formated.
> 
> Ah, but the patchset does seem to properly formatted.  At least it's
> easy for me to review as-published, while a much smaller number of
> patches, making much larger individual patches, would be much much
> harder to review.
> 
> But what do I know...
> 
> Oh wait, I review more kernel patches than anyone else :)
> 
> Logan, given that you need to rebase these on the "new" ntb api (and why
> the hell is that tree on github? We can't take kernel git pulls from
> github), is it worth reviewing this patch series as-is, or do you want

Well, Linus has been taking my pull request from it since v3.12.  He did
call me out initially for requesting it initially, but was amenible
after I GPG signed all of my pull requests (and had a sufficient number
of people he "knew" in my ring).  But all of that has been sorted out
now.

The reason it is on Github is for the Wiki of NTB HW and it's usage
https://github.com/jonmason/ntb/wiki
It's gotten a bit stale, but was very useful back in the v3.12 days :)
(Also, I am using this as a call to update the Wiki!)

Thanks,
Jon

> us to wait?
> 
> thanks,
> 
> greg k-h
