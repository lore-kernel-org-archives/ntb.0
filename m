Return-Path: <jdmason@kudzu.us>
Received: from mail-oi0-x242.google.com (mail-oi0-x242.google.com. [2607:f8b0:4003:c06::242])
        by gmr-mx.google.com with ESMTPS id c195si305606itb.0.2017.01.10.14.14.14
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jan 2017 14:14:14 -0800 (PST)
Received: by mail-oi0-x242.google.com with SMTP id u143so23419017oif.3
        for <linux-ntb@googlegroups.com>; Tue, 10 Jan 2017 14:14:14 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170110215527.GD13381@kudzu.us>
References: <1483407036-20697-1-git-send-email-logang@deltatee.com> <20170110215527.GD13381@kudzu.us>
From: Jon Mason <jdmason@kudzu.us>
Date: Tue, 10 Jan 2017 16:59:09 -0500
Message-ID: <CAPoiz9wZq1m-7=CsyUKK07+vCm3Lyhf+z77TooUmff4-v_mh_Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] Style fixes: open code obfuscating macros
Content-Type: text/plain; charset=UTF-8
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Xiangliang Yu <Xiangliang.Yu@amd.com>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-ntb@googlegroups.com, linux-kernel <linux-kernel@vger.kernel.org>
List-ID: <linux-ntb.googlegroups.com>

On Tue, Jan 10, 2017 at 4:55 PM, Jon Mason <jdmason@kudzu.us> wrote:
> On Mon, Jan 02, 2017 at 06:30:34PM -0700, Logan Gunthorpe wrote:
>> Hi,
>>
>> I had copied some poor code style from the NTB drivers into an unrelated
>> driver. Upon review of my new code, I learned it was not a good idea
>> to sweep dirty things under the rug^W macro. See [1], where Gregg k-h
>> suggested I fix the problem at the source.
>>
>> Thus, please merge the following two patches to improve the style of
>> the NTB drivers.
>>
>> Thanks,
>>
>> Logan
>
> Applying the series, thanks

Gaaa, these don't apply cleanly.  Can you rebase on my
https://github.com/jonmason/ntb (branch ntb) and resubmit?

Thanks,
Jon

>
>>
>> [1] http://www.spinics.net/lists/linux-pci/msg56904.html
>>
>>
>> Logan Gunthorpe (2):
>>   ntb_hw_amd: Style fixes: open code macros that just obfuscate code
>>   ntb_hw_intel: Style fixes: open code macros that just obfuscate code
>>
>>  drivers/ntb/hw/amd/ntb_hw_amd.c     |  59 ++++++++-------
>>  drivers/ntb/hw/amd/ntb_hw_amd.h     |   3 -
>>  drivers/ntb/hw/intel/ntb_hw_intel.c | 145 ++++++++++++++++++------------------
>>  drivers/ntb/hw/intel/ntb_hw_intel.h |   3 -
>>  4 files changed, 104 insertions(+), 106 deletions(-)
>>
>> --
>> 2.1.4
