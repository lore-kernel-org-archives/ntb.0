Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf0-x230.google.com (mail-lf0-x230.google.com. [2a00:1450:4010:c07::230])
        by gmr-mx.google.com with ESMTPS id y16si175643lje.2.2017.11.30.14.12.57
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Nov 2017 14:12:57 -0800 (PST)
Received: by mail-lf0-x230.google.com with SMTP id e137so9625846lfg.5
        for <linux-ntb@googlegroups.com>; Thu, 30 Nov 2017 14:12:57 -0800 (PST)
Return-Path: <fancer.lancer@gmail.com>
Date: Fri, 1 Dec 2017 01:12:58 +0300
From: Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH 01/08] NTB: ntb_test: Safely use paths with whitespace
Message-ID: <20171130221258.GA20562@mobilestation>
References: <20171130214300.21298-1-fancer.lancer@gmail.com>
 <923625e8-f071-c9f6-a3e2-c16480d4aea6@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <923625e8-f071-c9f6-a3e2-c16480d4aea6@deltatee.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com, Shyam-sundar.S-k@amd.com, Xiangliang.Yu@amd.com, Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

On Thu, Nov 30, 2017 at 03:04:29PM -0700, Logan Gunthorpe <logang@deltatee.com> wrote:

Hello

> Hey,
> 
> I took a cursory look at this series and it largely looks good to me. Nice
> work. If I have time in the next couple days I'll do a more thorough review.
> However, does the series not depend on changes to ntb_tool? It would have
> been good to include a cover letter describing the intention/plan.
> 

In general the intention of the patchset was to update the ntb_test.sh script
so one would be compatible with new NTB test drivers I've also sent. It was
asked of me by the NTB core maintainers. Sorry for not mentioning it in the
cover letter.

-Sergey

> 
> On 30/11/17 02:42 PM, Serge Semin wrote:
> >If some of variables like LOC/REM or LOCAL_*/REMOTE_* got
> >whitespaces, the script may fail with syntax error.
> >
> >Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> 
> Seeing this is a bug fix I Ack Patch 1 and suggest it get merged ahead of
> the series.
> 
> Acked-by: Logan Gunthorpe <logang@deltatee.com>
> Fixes: a9c59ef77458 ("ntb_test: Add a selftest script for the NTB
> subsystem")
> 
> Thanks for the fix.
> 
> Logan
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/923625e8-f071-c9f6-a3e2-c16480d4aea6%40deltatee.com.
> For more options, visit https://groups.google.com/d/optout.
