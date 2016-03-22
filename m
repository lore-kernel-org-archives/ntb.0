Return-Path: <computersforpeace@gmail.com>
Received: from mail-pf0-x22b.google.com (mail-pf0-x22b.google.com. [2607:f8b0:400e:c00::22b])
        by gmr-mx.google.com with ESMTPS id y20si4324541pfa.2.2016.03.21.17.31.20
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Mar 2016 17:31:20 -0700 (PDT)
Received: by mail-pf0-x22b.google.com with SMTP id u190so285791965pfb.3
        for <linux-ntb@googlegroups.com>; Mon, 21 Mar 2016 17:31:20 -0700 (PDT)
Return-Path: <computersforpeace@gmail.com>
Date: Mon, 21 Mar 2016 17:31:17 -0700
From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH] ntb: test: fix pointer size warning
Message-ID: <20160322003117.GA15424@google.com>
References: <1458321080-42873-1-git-send-email-computersforpeace@gmail.com>
 <20160321235237.GA17910@kudzu.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20160321235237.GA17910@kudzu.us>
To: Jon Mason <jdmason@kudzu.us>
Cc: Allen Hubbe <Allen.Hubbe@emc.com>, Dave Jiang <dave.jiang@intel.com>, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

On Mon, Mar 21, 2016 at 07:52:38PM -0400, Jon Mason wrote:
> On Fri, Mar 18, 2016 at 10:11:20AM -0700, Brian Norris wrote:
> > drivers/ntb/test/ntb_perf.c: In function ‘perf_copy’:
> > drivers/ntb/test/ntb_perf.c:213:10: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
> > drivers/ntb/test/ntb_perf.c:214:14: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
> > 
> > On 32-bit systems, we are casting a 32-bit pointer to a 64-bit value.
> > This shouldn't cause functional problems, but we might as well fix the
> > warning and allow 32-bit arithmetic for 32-bit systems.
> 
> This was already addressed by a patch from Arnd Bergmann, which is
> queued in the ntb git tree.

Great!

Is your ntb tree in linux-next.git?

Regards,
Brian
