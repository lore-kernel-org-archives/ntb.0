Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id u12si594964pfd.3.2017.01.26.12.00.55
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jan 2017 12:00:55 -0800 (PST)
References: <1484094819-16084-1-git-send-email-logang@deltatee.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <5ed3be6c-c94e-1ade-e4cd-a8e8293296cd@deltatee.com>
Date: Thu, 26 Jan 2017 13:00:52 -0700
MIME-Version: 1.0
In-Reply-To: <1484094819-16084-1-git-send-email-logang@deltatee.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 0/4] Style fixes: open code obfuscating macros
To: Xiangliang Yu <Xiangliang.Yu@amd.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>, Joe Perches <joe@perches.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

Hi,

It's been a couple weeks... Any thoughts on this?

Thanks,

Logan

On 10/01/17 05:33 PM, Logan Gunthorpe wrote:
> Hi,
> 
> Here's an updated version of the style fixes patchset. The differences
> from v1 are:
> 
> 1) Rebased onto Jon Mason's current NTB branch
> 
> 2) Added two more patches to convert the print lines to use the ntb
> device and not the pci one. This seems more sane, shortens a bunch
> of lines and removes the need for temporaries.
> 
> Note with (2): I've tried my best to ensure that statements that print
> before the ntb device is registered still use the PCI device. However,
> someone should probably review and test this as I don't have access
> to all types of hardware to do that.
> 
> Thanks,
> 
> Logan
> 
> 
> 
> Logan Gunthorpe (4):
>   ntb_hw_amd: Style fixes: open code macros that just obfuscate code
>   ntb_hw_intel: Style fixes: open code macros that just obfuscate code
>   ntb_hw_amd: Print kernel messages with the ntb device not the pci one
>   ntb_hw_intel: Print kernel messages with the ntb device not the pci
>     one
> 
>  drivers/ntb/hw/amd/ntb_hw_amd.c     |  60 +++++------
>  drivers/ntb/hw/amd/ntb_hw_amd.h     |   3 -
>  drivers/ntb/hw/intel/ntb_hw_intel.c | 192 +++++++++++++++++-------------------
>  drivers/ntb/hw/intel/ntb_hw_intel.h |   3 -
>  4 files changed, 124 insertions(+), 134 deletions(-)
> 
> --
> 2.1.4
> 
