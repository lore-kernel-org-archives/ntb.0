Return-Path: <jdmason@kudzu.us>
Received: from mail-yw0-x244.google.com (mail-yw0-x244.google.com. [2607:f8b0:4002:c05::244])
        by gmr-mx.google.com with ESMTPS id p22si4525830ywe.3.2016.11.29.11.58.41
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Nov 2016 11:58:41 -0800 (PST)
Received: by mail-yw0-x244.google.com with SMTP id s68so13092587ywg.0
        for <linux-ntb@googlegroups.com>; Tue, 29 Nov 2016 11:58:41 -0800 (PST)
Return-Path: <jdmason@kudzu.us>
Date: Tue, 29 Nov 2016 14:58:39 -0500
From: Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH v3] ntb: Adding Skylake Xeon NTB support
Message-ID: <20161129195838.GA18783@kudzu.us>
References: <147933021880.124938.13946656717891227718.stgit@djiang5-desk3.ch.intel.com>
 <000101d24051$3c287a20$b4796e60$@emc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000101d24051$3c287a20$b4796e60$@emc.com>
To: Allen Hubbe <Allen.Hubbe@dell.com>
Cc: 'Dave Jiang' <dave.jiang@intel.com>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On Wed, Nov 16, 2016 at 04:34:38PM -0500, Allen Hubbe wrote:
> From: Dave Jiang
> > Sent: Wednesday, November 16, 2016 4:04 PM
> > To: Hubbe, Allen; jdmason@kudzu.us
> > Cc: linux-ntb@googlegroups.com
> > Subject: [PATCH v3] ntb: Adding Skylake Xeon NTB support
> > 
> > The Skylake Xeon NTB hardware has made some changes to the register name,
> > offset, and the way doorbells work. Adding driver support for the new
> > hardware.
> > 
> > Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> Acked-by: Allen Hubbe <Allen.Hubbe@dell.com>

Pulled in to the ntb-next branch

> 
> > ---
> >  drivers/ntb/hw/intel/ntb_hw_intel.c |  660 +++++++++++++++++++++++++++++++++++
> >  drivers/ntb/hw/intel/ntb_hw_intel.h |   48 +++
> >  2 files changed, 703 insertions(+), 5 deletions(-)
> > 
> 
