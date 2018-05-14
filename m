Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf0-x244.google.com (mail-lf0-x244.google.com. [2a00:1450:4010:c07::244])
        by gmr-mx.google.com with ESMTPS id u22-v6si302146lfi.1.2018.05.14.13.40.27
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 May 2018 13:40:27 -0700 (PDT)
Received: by mail-lf0-x244.google.com with SMTP id y72-v6so20008765lfd.2
        for <linux-ntb@googlegroups.com>; Mon, 14 May 2018 13:40:27 -0700 (PDT)
Return-Path: <fancer.lancer@gmail.com>
Date: Mon, 14 May 2018 23:40:36 +0300
From: Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH v2 0/4] NTB : Introduce message library
Message-ID: <20180514204036.GD24717@mobilestation>
References: <1525634420-19370-1-git-send-email-araut@codeaurora.org>
 <20180511223925.GB24717@mobilestation>
 <0f17dee9-9d68-642e-9fe0-6aaf31605cdf@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f17dee9-9d68-642e-9fe0-6aaf31605cdf@deltatee.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Atul Raut <araut@codeaurora.org>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On Fri, May 11, 2018 at 05:00:59PM -0600, Logan Gunthorpe <logang@deltatee.com> wrote:
> On 5/11/2018 4:39 PM, Serge Semin wrote:
> >Definitely I didn't tell you just to copy-and-paste the whole service functions
> >from ntb_perf. One of the ntb_perf driver purpose was to create an example of
> >possible cross-interface communication code, which turned to be the "service"
> >subsystem of the driver. My idea was to have it used as a proof of concept and
> >a stably working code for the future cross-iface library. The library is going
> >to be a part of the NTB API itself - a part of the generic interface for the
> >whole NTB subsystem, so I recommended to have the design discussed first, otherwise
> >you'd risk to face review requests which would cause a serious code refactoring.
> >As far as I can see, it turned out to be true.
> 
> IMO, and in my experience, when working on APIs that have multiple users in
> the kernel you should *expect* to refactor and rewrite the code a couple
> times before we land on something that is clean enough to merge. I have
> patch sets that have gone through many *significant* changes and they are
> still works in progress. This is normal and don't expect discussion ahead of
> time to converge on the right answer right away.

I've got the same experience. But one thing I also got from it. If I knew a
maintainers notion about a change, I would have developed a code in accordance
with it. At least I'd try to understand the maintainer ideas and after discussions
we'd come up to some agreement. So if I had a way to chat with subsystem support
team, I would have used it without a doubt. Of course this doesn't mean that a
patchset would be accepted right after a first submit, but you must admit it would
lead to a code closer to acceptance than if it was created without the consultation.

-Sergey

> >Even though this more like a "philosophic" part, but this time Logan's opinion
> >happens to agree with the design we discussed a while ago with the rest of the
> >NTB maintainers:
> 
> Glad we agree for a change ;)
> 
> Logan
> 
