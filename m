Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id r1si835706pfg.4.2017.01.10.16.34.14
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jan 2017 16:34:14 -0800 (PST)
References: <1484094731-15965-1-git-send-email-logang@deltatee.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <2f7c2161-5e5b-13b7-4970-4c9c25f0e0c9@deltatee.com>
Date: Tue, 10 Jan 2017 17:34:13 -0700
MIME-Version: 1.0
In-Reply-To: <1484094731-15965-1-git-send-email-logang@deltatee.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 0/2] Style fixes: open code obfuscating macros
To: Xiangliang Yu <Xiangliang.Yu@amd.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>, Joe Perches <joe@perches.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

Sorry, sorry. I resent the wrong set :(

Logan

On 10/01/17 05:32 PM, Logan Gunthorpe wrote:
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
> 
