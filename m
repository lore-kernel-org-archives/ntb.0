Return-Path: <jdmason@kudzu.us>
Received: from mail-qt0-x242.google.com (mail-qt0-x242.google.com. [2607:f8b0:400d:c0d::242])
        by gmr-mx.google.com with ESMTPS id f80si973817ybg.5.2018.01.24.20.13.57
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jan 2018 20:13:57 -0800 (PST)
Received: by mail-qt0-x242.google.com with SMTP id d8so16178502qtm.0
        for <linux-ntb@googlegroups.com>; Wed, 24 Jan 2018 20:13:57 -0800 (PST)
Return-Path: <jdmason@kudzu.us>
Date: Wed, 24 Jan 2018 23:13:54 -0500
From: Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH v2] NTB: ntb_perf: fix cast to restricted __le32
Message-ID: <20180125041353.GA9887@kudzu.us>
References: <20180119173044.8013-1-fancer.lancer@gmail.com>
 <20180124074845.32125-1-fancer.lancer@gmail.com>
 <CAK8P3a2vp1U1i9-b1vX_FEs-_DGvWx-ut+Z_5hk4R_CxUNiucg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2vp1U1i9-b1vX_FEs-_DGvWx-ut+Z_5hk4R_CxUNiucg@mail.gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Serge Semin <fancer.lancer@gmail.com>, Dave Jiang <dave.jiang@intel.com>, allenbh@gmail.com, "Hook, Gary" <gary.hook@amd.com>, Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-ntb.googlegroups.com>

On Wed, Jan 24, 2018 at 09:07:26AM +0100, Arnd Bergmann wrote:
> On Wed, Jan 24, 2018 at 8:48 AM, Serge Semin <fancer.lancer@gmail.com> wrote:
> > Sparse is whining about the u32 and __le32 mixed usage in the driver
> >
> > drivers/ntb/test/ntb_perf.c:288:21: warning: cast to restricted __le32
> > drivers/ntb/test/ntb_perf.c:295:37: warning: incorrect type in argument 4 (different base types)
> > drivers/ntb/test/ntb_perf.c:295:37:    expected unsigned int [unsigned] [usertype] val
> > drivers/ntb/test/ntb_perf.c:295:37:    got restricted __le32 [usertype] <noident>
> > ...
> >
> > NTB hardware drivers shall accept CPU-endian data and translate it to
> > the portable formate by internal means, so the explicit conversions
> > are not necessary before Scratchpad/Messages API usage anymore.
> >
> > Fixes: b83003b3fdc1 ("NTB: ntb_perf: Add full multi-port NTB API support")
> > Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> 
> Looks good to me,
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Applied to my ntb-next branch.  Thanks for all of the help on this.

Thanks,
Jon
