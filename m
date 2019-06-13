Return-Path: <jdmason@kudzu.us>
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com. [2607:f8b0:4864:20::b44])
        by gmr-mx.google.com with ESMTPS id s128si62247pfs.5.2019.06.13.06.26.42
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 06:26:42 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id g62so7817562ybg.7
        for <linux-ntb@googlegroups.com>; Thu, 13 Jun 2019 06:26:42 -0700 (PDT)
Return-Path: <jdmason@kudzu.us>
Date: Thu, 13 Jun 2019 09:26:39 -0400
From: Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH] NTB: amd: Silence shift wrapping warning in
 amd_ntb_db_vector_mask()
Message-ID: <20190613132638.GD1572@kudzu.us>
References: <20190325092326.GE16023@kadam>
 <af8b8b48-ad5e-75c2-d3fe-674b14a0b9af@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af8b8b48-ad5e-75c2-d3fe-674b14a0b9af@amd.com>
To: "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
List-ID: <linux-ntb.googlegroups.com>

On Tue, Mar 26, 2019 at 05:46:44AM +0000, S-k, Shyam-sundar wrote:
> On 3/25/2019 2:53 PM, Dan Carpenter wrote:
> > This code triggers a Smatch warning:
> >
> >     drivers/ntb/hw/amd/ntb_hw_amd.c:336 amd_ntb_db_vector_mask()
> >     warn: should '(1 << db_vector)' be a 64 bit type?
> >
> > I don't think "db_vector" can be higher than 16 so this doesn't affect
> > runtime, but it's nice to silence the static checker warning and we
> > might increase "ndev->db_count" in the future.
> >
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> Acked-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>

Sorry for the delay.  The patch is now in the ntb branch.  We've
missed window for 5.2, but it will be in the 5.3 pull request.

Thanks,
Jon
