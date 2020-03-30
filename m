Return-Path: <Arindam.Nath@amd.com>
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2089.outbound.protection.outlook.com. [40.107.237.89])
        by gmr-mx.google.com with ESMTPS id 198si856798qkh.7.2020.03.30.11.43.47
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Mar 2020 11:43:47 -0700 (PDT)
From: "Nath, Arindam" <Arindam.Nath@amd.com>
Subject: RE: [PATCH 00/15] AMD ntb driver fixes and improvements
Date: Mon, 30 Mar 2020 18:43:46 +0000
Message-ID: 
 <MN2PR12MB3232D38E30341A7D7408BED79CCB0@MN2PR12MB3232.namprd12.prod.outlook.com>
References: <cover.1580914232.git.arindam.nath@amd.com>
 <a8e98fe8-25da-3ea7-a204-2fee07c6061a@amd.com>
 <20200313002524.GB13046@kudzu.us>
In-Reply-To: <20200313002524.GB13046@kudzu.us>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
To: Jon Mason <jdmason@kudzu.us>, "Mehta, Sanju" <Sanju.Mehta@amd.com>
Cc: "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Jiasen Lin <linjiasen@hygon.cn>, "Mehta, Sanju" <Sanju.Mehta@amd.com>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-ID: <linux-ntb.googlegroups.com>

> -----Original Message-----
> From: Jon Mason <jdmason@kudzu.us>
> Sent: Friday, March 13, 2020 05:55
> To: Mehta, Sanju <Sanju.Mehta@amd.com>
> Cc: Nath, Arindam <Arindam.Nath@amd.com>; S-k, Shyam-sundar <Shyam-
> sundar.S-k@amd.com>; Dave Jiang <dave.jiang@intel.com>; Allen Hubbe
> <allenbh@gmail.com>; Jiasen Lin <linjiasen@hygon.cn>; Mehta, Sanju
> <Sanju.Mehta@amd.com>; linux-ntb@googlegroups.com; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH 00/15] AMD ntb driver fixes and improvements
>=20
> On Fri, Feb 07, 2020 at 04:28:53PM +0530, Sanjay R Mehta wrote:
> >
> >
> > On 2/5/2020 9:24 PM, Arindam Nath wrote:
> > > [CAUTION: External Email]
> > >
> > > This patch series fixes some bugs in the existing
> > > AMD NTB driver, cleans-up code, and modifies the
> > > code to handle NTB link-up/down events. The series
> > > is based on Linus' tree,
> > >
> > > git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > >
> > > Arindam Nath (15):
> > >   NTB: Fix access to link status and control register
> > >   NTB: clear interrupt status register
> > >   NTB: Enable link up and down event notification
> > >   NTB: define a new function to get link status
> > >   NTB: return the side info status from amd_poll_link
> > >   NTB: set peer_sta within event handler itself
> > >   NTB: remove handling of peer_sta from amd_link_is_up
> > >   NTB: handle link down event correctly
> > >   NTB: handle link up, D0 and D3 events correctly
> > >   NTB: move ntb_ctrl handling to init and deinit
> > >   NTB: add helper functions to set and clear sideinfo
> > >   NTB: return link up status correctly for PRI and SEC
> > >   NTB: remove redundant setting of DB valid mask
> > >   NTB: send DB event when driver is loaded or un-loaded
> > >   NTB: add pci shutdown handler for AMD NTB
> >
> > The patch series looks good to me. Thanks for the changes.
> >
> > For all the ntb_hw_amd changes:
> >
> > Reviewed-by: Sanjay R Mehta <sanju.mehta@amd.com>
>=20
> I had to rework the first patch, since Jiasen's patch was already in
> my tree for a couple months.  The rest applied fine and will be in my
> git trees on github in a couple of hours (sanity build pending).
>=20

Hi Jon,

Just wanted to know whether the changes are in your tree now?

Thanks,
Arindam

> Thanks,
> Jon
>=20
> >
> >
> > >
> > >  drivers/ntb/hw/amd/ntb_hw_amd.c | 290
> ++++++++++++++++++++++++++------
> > >  drivers/ntb/hw/amd/ntb_hw_amd.h |   8 +-
> > >  2 files changed, 247 insertions(+), 51 deletions(-)
> > >
> > > --
> > > 2.17.1
> > >
