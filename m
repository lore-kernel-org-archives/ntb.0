Return-Path: <jdmason@kudzu.us>
Received: from mail-ua0-x243.google.com (mail-ua0-x243.google.com. [2607:f8b0:400c:c08::243])
        by gmr-mx.google.com with ESMTPS id m190si1491730vkf.5.2017.02.01.12.08.19
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Feb 2017 12:08:19 -0800 (PST)
Received: by mail-ua0-x243.google.com with SMTP id d5so36828893uag.0
        for <linux-ntb@googlegroups.com>; Wed, 01 Feb 2017 12:08:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5ed3be6c-c94e-1ade-e4cd-a8e8293296cd@deltatee.com>
References: <1484094819-16084-1-git-send-email-logang@deltatee.com> <5ed3be6c-c94e-1ade-e4cd-a8e8293296cd@deltatee.com>
From: Jon Mason <jdmason@kudzu.us>
Date: Wed, 1 Feb 2017 15:08:18 -0500
Message-ID: <CAPoiz9zyATQRw=5ydnSteAqrZkvQ3D24xwt7kR-1aASysquJkQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Style fixes: open code obfuscating macros
Content-Type: text/plain; charset=UTF-8
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Xiangliang Yu <Xiangliang.Yu@amd.com>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>, Joe Perches <joe@perches.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-ntb@googlegroups.com, linux-kernel <linux-kernel@vger.kernel.org>
List-ID: <linux-ntb.googlegroups.com>

On Thu, Jan 26, 2017 at 3:00 PM, Logan Gunthorpe <logang@deltatee.com> wrote:
> Hi,
>
> It's been a couple weeks... Any thoughts on this?

My apologies for not responding sooner.  A large rework of the core
NTB code was done prior to your patches (for IDT NTB support).
Unfortunately, after those changes this series does not apply cleanly.
I understand the changes being made, and will fix-up the patches to
make it apply cleanly on the updated code base.

Thanks,
Jon

>
> Thanks,
>
> Logan
>
> On 10/01/17 05:33 PM, Logan Gunthorpe wrote:
>> Hi,
>>
>> Here's an updated version of the style fixes patchset. The differences
>> from v1 are:
>>
>> 1) Rebased onto Jon Mason's current NTB branch
>>
>> 2) Added two more patches to convert the print lines to use the ntb
>> device and not the pci one. This seems more sane, shortens a bunch
>> of lines and removes the need for temporaries.
>>
>> Note with (2): I've tried my best to ensure that statements that print
>> before the ntb device is registered still use the PCI device. However,
>> someone should probably review and test this as I don't have access
>> to all types of hardware to do that.
>>
>> Thanks,
>>
>> Logan
>>
>>
>>
>> Logan Gunthorpe (4):
>>   ntb_hw_amd: Style fixes: open code macros that just obfuscate code
>>   ntb_hw_intel: Style fixes: open code macros that just obfuscate code
>>   ntb_hw_amd: Print kernel messages with the ntb device not the pci one
>>   ntb_hw_intel: Print kernel messages with the ntb device not the pci
>>     one
>>
>>  drivers/ntb/hw/amd/ntb_hw_amd.c     |  60 +++++------
>>  drivers/ntb/hw/amd/ntb_hw_amd.h     |   3 -
>>  drivers/ntb/hw/intel/ntb_hw_intel.c | 192 +++++++++++++++++-------------------
>>  drivers/ntb/hw/intel/ntb_hw_intel.h |   3 -
>>  4 files changed, 124 insertions(+), 134 deletions(-)
>>
>> --
>> 2.1.4
>>
>
> --
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/5ed3be6c-c94e-1ade-e4cd-a8e8293296cd%40deltatee.com.
> For more options, visit https://groups.google.com/d/optout.
