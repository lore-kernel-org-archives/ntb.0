Return-Path: <jdmason@kudzu.us>
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com. [2607:f8b0:4864:20::743])
        by gmr-mx.google.com with ESMTPS id y5si390533qkl.6.2020.03.12.17.25.27
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 17:25:27 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id m2so9644456qka.7
        for <linux-ntb@googlegroups.com>; Thu, 12 Mar 2020 17:25:27 -0700 (PDT)
Return-Path: <jdmason@kudzu.us>
Date: Thu, 12 Mar 2020 20:25:25 -0400
From: Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH 00/15] AMD ntb driver fixes and improvements
Message-ID: <20200313002524.GB13046@kudzu.us>
References: <cover.1580914232.git.arindam.nath@amd.com>
 <a8e98fe8-25da-3ea7-a204-2fee07c6061a@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8e98fe8-25da-3ea7-a204-2fee07c6061a@amd.com>
To: Sanjay R Mehta <sanmehta@amd.com>
Cc: Arindam Nath <arindam.nath@amd.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Jiasen Lin <linjiasen@hygon.cn>, Sanjay R Mehta <sanju.mehta@amd.com>, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

On Fri, Feb 07, 2020 at 04:28:53PM +0530, Sanjay R Mehta wrote:
> 
> 
> On 2/5/2020 9:24 PM, Arindam Nath wrote:
> > [CAUTION: External Email]
> > 
> > This patch series fixes some bugs in the existing
> > AMD NTB driver, cleans-up code, and modifies the
> > code to handle NTB link-up/down events. The series
> > is based on Linus' tree,
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > 
> > Arindam Nath (15):
> >   NTB: Fix access to link status and control register
> >   NTB: clear interrupt status register
> >   NTB: Enable link up and down event notification
> >   NTB: define a new function to get link status
> >   NTB: return the side info status from amd_poll_link
> >   NTB: set peer_sta within event handler itself
> >   NTB: remove handling of peer_sta from amd_link_is_up
> >   NTB: handle link down event correctly
> >   NTB: handle link up, D0 and D3 events correctly
> >   NTB: move ntb_ctrl handling to init and deinit
> >   NTB: add helper functions to set and clear sideinfo
> >   NTB: return link up status correctly for PRI and SEC
> >   NTB: remove redundant setting of DB valid mask
> >   NTB: send DB event when driver is loaded or un-loaded
> >   NTB: add pci shutdown handler for AMD NTB
> 
> The patch series looks good to me. Thanks for the changes.
> 
> For all the ntb_hw_amd changes:
> 
> Reviewed-by: Sanjay R Mehta <sanju.mehta@amd.com>

I had to rework the first patch, since Jiasen's patch was already in
my tree for a couple months.  The rest applied fine and will be in my
git trees on github in a couple of hours (sanity build pending).

Thanks,
Jon

> 
> 
> > 
> >  drivers/ntb/hw/amd/ntb_hw_amd.c | 290 ++++++++++++++++++++++++++------
> >  drivers/ntb/hw/amd/ntb_hw_amd.h |   8 +-
> >  2 files changed, 247 insertions(+), 51 deletions(-)
> > 
> > --
> > 2.17.1
> > 
