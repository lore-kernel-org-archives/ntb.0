Return-Path: <jdmason@kudzu.us>
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com. [2607:f8b0:4864:20::d42])
        by gmr-mx.google.com with ESMTPS id a3si1506240iog.2.2020.03.30.14.09.19
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2020 14:09:19 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id n10so5361004iom.3
        for <linux-ntb@googlegroups.com>; Mon, 30 Mar 2020 14:09:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1580914232.git.arindam.nath@amd.com> <a8e98fe8-25da-3ea7-a204-2fee07c6061a@amd.com>
 <20200313002524.GB13046@kudzu.us> <MN2PR12MB3232D38E30341A7D7408BED79CCB0@MN2PR12MB3232.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB3232D38E30341A7D7408BED79CCB0@MN2PR12MB3232.namprd12.prod.outlook.com>
From: Jon Mason <jdmason@kudzu.us>
Date: Mon, 30 Mar 2020 17:09:08 -0400
Message-ID: <CAPoiz9zBxB28nfCudr0xXYi4Lg7XRJXshTLvTM5W5uMcvw=2FQ@mail.gmail.com>
Subject: Re: [PATCH 00/15] AMD ntb driver fixes and improvements
Content-Type: text/plain; charset="UTF-8"
To: "Nath, Arindam" <Arindam.Nath@amd.com>
Cc: "Mehta, Sanju" <Sanju.Mehta@amd.com>, "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Jiasen Lin <linjiasen@hygon.cn>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-ID: <linux-ntb.googlegroups.com>

On Mon, Mar 30, 2020 at 2:43 PM Nath, Arindam <Arindam.Nath@amd.com> wrote:
>
> > -----Original Message-----
> > From: Jon Mason <jdmason@kudzu.us>
> > Sent: Friday, March 13, 2020 05:55
> > To: Mehta, Sanju <Sanju.Mehta@amd.com>
> > Cc: Nath, Arindam <Arindam.Nath@amd.com>; S-k, Shyam-sundar <Shyam-
> > sundar.S-k@amd.com>; Dave Jiang <dave.jiang@intel.com>; Allen Hubbe
> > <allenbh@gmail.com>; Jiasen Lin <linjiasen@hygon.cn>; Mehta, Sanju
> > <Sanju.Mehta@amd.com>; linux-ntb@googlegroups.com; linux-
> > kernel@vger.kernel.org
> > Subject: Re: [PATCH 00/15] AMD ntb driver fixes and improvements
> >
> > On Fri, Feb 07, 2020 at 04:28:53PM +0530, Sanjay R Mehta wrote:
> > >
> > >
> > > On 2/5/2020 9:24 PM, Arindam Nath wrote:
> > > > [CAUTION: External Email]
> > > >
> > > > This patch series fixes some bugs in the existing
> > > > AMD NTB driver, cleans-up code, and modifies the
> > > > code to handle NTB link-up/down events. The series
> > > > is based on Linus' tree,
> > > >
> > > > git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > > >
> > > > Arindam Nath (15):
> > > >   NTB: Fix access to link status and control register
> > > >   NTB: clear interrupt status register
> > > >   NTB: Enable link up and down event notification
> > > >   NTB: define a new function to get link status
> > > >   NTB: return the side info status from amd_poll_link
> > > >   NTB: set peer_sta within event handler itself
> > > >   NTB: remove handling of peer_sta from amd_link_is_up
> > > >   NTB: handle link down event correctly
> > > >   NTB: handle link up, D0 and D3 events correctly
> > > >   NTB: move ntb_ctrl handling to init and deinit
> > > >   NTB: add helper functions to set and clear sideinfo
> > > >   NTB: return link up status correctly for PRI and SEC
> > > >   NTB: remove redundant setting of DB valid mask
> > > >   NTB: send DB event when driver is loaded or un-loaded
> > > >   NTB: add pci shutdown handler for AMD NTB
> > >
> > > The patch series looks good to me. Thanks for the changes.
> > >
> > > For all the ntb_hw_amd changes:
> > >
> > > Reviewed-by: Sanjay R Mehta <sanju.mehta@amd.com>
> >
> > I had to rework the first patch, since Jiasen's patch was already in
> > my tree for a couple months.  The rest applied fine and will be in my
> > git trees on github in a couple of hours (sanity build pending).
> >
>
> Hi Jon,
>
> Just wanted to know whether the changes are in your tree now?

You should see them in my ntb branch and I'll be sending out a pull req


>
> Thanks,
> Arindam
>
> > Thanks,
> > Jon
> >
> > >
> > >
> > > >
> > > >  drivers/ntb/hw/amd/ntb_hw_amd.c | 290
> > ++++++++++++++++++++++++++------
> > > >  drivers/ntb/hw/amd/ntb_hw_amd.h |   8 +-
> > > >  2 files changed, 247 insertions(+), 51 deletions(-)
> > > >
> > > > --
> > > > 2.17.1
> > > >
