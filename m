Return-Path: <jdmason@kudzu.us>
Received: from mail-qt0-x241.google.com (mail-qt0-x241.google.com. [2607:f8b0:400d:c0d::241])
        by gmr-mx.google.com with ESMTPS id v77si259268ywa.7.2017.01.10.13.55.30
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jan 2017 13:55:30 -0800 (PST)
Received: by mail-qt0-x241.google.com with SMTP id f4so16839656qte.2
        for <linux-ntb@googlegroups.com>; Tue, 10 Jan 2017 13:55:30 -0800 (PST)
Return-Path: <jdmason@kudzu.us>
Date: Tue, 10 Jan 2017 16:55:28 -0500
From: Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH 0/2] Style fixes: open code obfuscating macros
Message-ID: <20170110215527.GD13381@kudzu.us>
References: <1483407036-20697-1-git-send-email-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1483407036-20697-1-git-send-email-logang@deltatee.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Xiangliang Yu <Xiangliang.Yu@amd.com>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

On Mon, Jan 02, 2017 at 06:30:34PM -0700, Logan Gunthorpe wrote:
> Hi,
> 
> I had copied some poor code style from the NTB drivers into an unrelated
> driver. Upon review of my new code, I learned it was not a good idea
> to sweep dirty things under the rug^W macro. See [1], where Gregg k-h
> suggested I fix the problem at the source.
> 
> Thus, please merge the following two patches to improve the style of
> the NTB drivers.
> 
> Thanks,
> 
> Logan

Applying the series, thanks

> 
> [1] http://www.spinics.net/lists/linux-pci/msg56904.html
> 
> 
> Logan Gunthorpe (2):
>   ntb_hw_amd: Style fixes: open code macros that just obfuscate code
>   ntb_hw_intel: Style fixes: open code macros that just obfuscate code
> 
>  drivers/ntb/hw/amd/ntb_hw_amd.c     |  59 ++++++++-------
>  drivers/ntb/hw/amd/ntb_hw_amd.h     |   3 -
>  drivers/ntb/hw/intel/ntb_hw_intel.c | 145 ++++++++++++++++++------------------
>  drivers/ntb/hw/intel/ntb_hw_intel.h |   3 -
>  4 files changed, 104 insertions(+), 106 deletions(-)
> 
> --
> 2.1.4
