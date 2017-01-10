Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0121.hostedemail.com. [216.40.44.121])
        by gmr-mx.google.com with ESMTPS id c195si317412itb.0.2017.01.10.15.06.55
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jan 2017 15:06:55 -0800 (PST)
Message-ID: <1484089612.12006.11.camel@perches.com>
Subject: Re: [PATCH 0/2] Style fixes: open code obfuscating macros
From: Joe Perches <joe@perches.com>
Date: Tue, 10 Jan 2017 15:06:52 -0800
In-Reply-To: <CAPoiz9wZq1m-7=CsyUKK07+vCm3Lyhf+z77TooUmff4-v_mh_Q@mail.gmail.com>
References: <1483407036-20697-1-git-send-email-logang@deltatee.com>
	 <20170110215527.GD13381@kudzu.us>
	 <CAPoiz9wZq1m-7=CsyUKK07+vCm3Lyhf+z77TooUmff4-v_mh_Q@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: Jon Mason <jdmason@kudzu.us>, Logan Gunthorpe <logang@deltatee.com>
Cc: Xiangliang Yu <Xiangliang.Yu@amd.com>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-ntb@googlegroups.com, linux-kernel <linux-kernel@vger.kernel.org>
List-ID: <linux-ntb.googlegroups.com>

On Tue, 2017-01-10 at 16:59 -0500, Jon Mason wrote:
> On Tue, Jan 10, 2017 at 4:55 PM, Jon Mason <jdmason@kudzu.us> wrote:
> > On Mon, Jan 02, 2017 at 06:30:34PM -0700, Logan Gunthorpe wrote:
> > > Hi,
> > > 
> > > I had copied some poor code style from the NTB drivers into an unrelated
> > > driver. Upon review of my new code, I learned it was not a good idea
> > > to sweep dirty things under the rug^W macro. See [1], where Gregg k-h
> > > suggested I fix the problem at the source.
> > > 
> > > Thus, please merge the following two patches to improve the style of
> > > the NTB drivers.
> > > 
> > > Thanks,
> > > 
> > > Logan
> > 
> > Applying the series, thanks
> 
> Gaaa, these don't apply cleanly.  Can you rebase on my
> https://github.com/jonmason/ntb (branch ntb) and resubmit?

It might also be better to add and use YA
logging macro like ndev_dbg

#define ndev_dvg(ndev, fmt, ...)	\
	dev_dbg(&(ndev)->ntb.pdev->dev, fmt, ##__VA_ARGS__)

so that the new temporaries that are used just
for debugging are not required.
