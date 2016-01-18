Return-Path: <jdmason@kudzu.us>
Received: from mail-yk0-x242.google.com (mail-yk0-x242.google.com. [2607:f8b0:4002:c07::242])
        by gmr-mx.google.com with ESMTPS id i204si1666280ywc.3.2016.01.17.20.10.51
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jan 2016 20:10:51 -0800 (PST)
Received: by mail-yk0-x242.google.com with SMTP id y10so36001938ykf.0
        for <linux-ntb@googlegroups.com>; Sun, 17 Jan 2016 20:10:51 -0800 (PST)
Return-Path: <jdmason@kudzu.us>
Date: Sun, 17 Jan 2016 23:09:35 -0500
From: Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH V3 0/2] AMD NTB V3 changes
Message-ID: <20160118040933.GD11303@kudzu.us>
References: <1452771830-16907-1-git-send-email-Xiangliang.Yu@amd.com>
 <000001d14ee3$ffd532c0$ff7f9840$@emc.com>
 <BLUPR12MB0420E27CC06AF3C4046F68DAEBCD0@BLUPR12MB0420.namprd12.prod.outlook.com>
 <000001d14fb7$e7981bd0$b6c85370$@emc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000001d14fb7$e7981bd0$b6c85370$@emc.com>
To: Allen Hubbe <Allen.Hubbe@emc.com>
Cc: "'Yu, Xiangliang'" <Xiangliang.Yu@amd.com>, dave.jiang@intel.com, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, 'SPG_Linux_Kernel' <SPG_Linux_Kernel@amd.com>
List-ID: <linux-ntb.googlegroups.com>

On Fri, Jan 15, 2016 at 12:12:24PM -0500, Allen Hubbe wrote:
> > From: Yu, Xiangliang <Xiangliang.Yu@amd.com>
> 
> > I want to add flush function into ntb_transport.c, but I can't verify
> > the implementation
> 
> Ok.  That's a good reason to hold back the flush mechanism: it's not been tested.
> 
> Nak (for now): [PATCH V3 2/2] NTB: Add support for flush request interface
> 
> Don't give up.  Please keep working on this, and the power management patch, to get them reviewed and accepted.  It's your choice whether or not to submit the patches, and when.  I'd encourage you to do it early, rather than delay.

I'd like to echo Allen's comment above.  Do not give up.  This code is
very close to being accepted (once the issues that Allen and I pointed
out are addressed).  If you can get us another version on/before
Wednesday, it should make the 4.5 release (assuming it is acceptable
and the wdinow is not closed prematurely).

Thanks for all of your hard work (and many thanks to Allen for his
reviews of the code as well).
- Jon


> 
> Allen
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/000001d14fb7%24e7981bd0%24b6c85370%24%40emc.com.
> For more options, visit https://groups.google.com/d/optout.
