Return-Path: <jdmason@kudzu.us>
Received: from mail-yk0-x241.google.com (mail-yk0-x241.google.com. [2607:f8b0:4002:c07::241])
        by gmr-mx.google.com with ESMTPS id y199si1898250ywd.5.2016.01.17.19.19.36
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jan 2016 19:19:36 -0800 (PST)
Received: by mail-yk0-x241.google.com with SMTP id k129so44216437yke.3
        for <linux-ntb@googlegroups.com>; Sun, 17 Jan 2016 19:19:36 -0800 (PST)
Return-Path: <jdmason@kudzu.us>
Date: Sun, 17 Jan 2016 22:18:19 -0500
From: Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH v6] ntb: ntb perf tool
Message-ID: <20160118031818.GA11303@kudzu.us>
References: <000201d14ee4$93e3e0b0$bbaba210$@emc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000201d14ee4$93e3e0b0$bbaba210$@emc.com>
To: Allen Hubbe <Allen.Hubbe@emc.com>
Cc: 'Dave Jiang' <dave.jiang@intel.com>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On Thu, Jan 14, 2016 at 10:59:40AM -0500, Allen Hubbe wrote:
> > From: Dave Jiang <dave.jiang@intel.com>
> > Sent: Wednesday, January 13, 2016 3:30 PM
> > To: Hubbe, Allen; jdmason@kudzu.us
> > Cc: linux-ntb@googlegroups.com
> > Subject: [PATCH v6] ntb: ntb perf tool
> > 
> > Providing raw performance data via a tool that directly access data from
> > NTB w/o any software overhead. This allows measurement of the hardware
> > performance limit. In revision one we are only doing single direction
> > CPU and DMA writes. Eventually we will provide bi-directional writes.
> > 
> > The measurement using DMA engine for NTB performance measure does
> > not measure the raw performance of DMA engine over NTB due to software
> > overhead. But it should provide the peak performance through the Linux
> > DMA
> > driver.
> > 
> > Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> Tested-by: Allen Hubbe <Allen.Hubbe@emc.com>

Pulled in, thanks.

> 
> This driver seems to work as described.  My performance results were lower than expected, but I tested on a nonstandard ntb config.
> 
> Allen
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/000201d14ee4%2493e3e0b0%24bbaba210%24%40emc.com.
> For more options, visit https://groups.google.com/d/optout.
