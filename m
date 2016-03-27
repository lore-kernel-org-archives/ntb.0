Return-Path: <jdmason@kudzu.us>
Received: from mail-vk0-x242.google.com (mail-vk0-x242.google.com. [2607:f8b0:400c:c05::242])
        by gmr-mx.google.com with ESMTPS id v193si816499vkv.2.2016.03.27.08.22.50
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Mar 2016 08:22:50 -0700 (PDT)
Received: by mail-vk0-x242.google.com with SMTP id e185so12364754vkb.2
        for <linux-ntb@googlegroups.com>; Sun, 27 Mar 2016 08:22:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <BLUPR12MB04209CFCD26713F47FD286C3EB820@BLUPR12MB0420.namprd12.prod.outlook.com>
References: <17b414e0af3e8caf31b3b3aa5dddb842ef397c1a.1458550127.git.Allen.Hubbe@emc.com>
	<6a2984f3c623f41aae210f08f23813b680a19d56.1458550127.git.Allen.Hubbe@emc.com>
	<BLUPR12MB04207A01BAAA208E33D1E745EB800@BLUPR12MB0420.namprd12.prod.outlook.com>
	<000001d18443$3bb6dc50$b32494f0$@emc.com>
	<BLUPR12MB0420FA1F9309F7B47825EDA6EB810@BLUPR12MB0420.namprd12.prod.outlook.com>
	<000001d1850c$734ad1c0$59e07540$@emc.com>
	<BLUPR12MB04209CFCD26713F47FD286C3EB820@BLUPR12MB0420.namprd12.prod.outlook.com>
Date: Sun, 27 Mar 2016 11:22:50 -0400
Message-ID: <CAPoiz9yii0MvDqwmDeQ=SK5kAvVxzJYGLMJqFAgi7JE9icW7Bg@mail.gmail.com>
Subject: Re: [PATCH 2/2] NTB: Remove _addr functions from ntb_hw_amd
From: Jon Mason <jdmason@kudzu.us>
Content-Type: text/plain; charset=UTF-8
To: "Yu, Xiangliang" <Xiangliang.Yu@amd.com>
Cc: Allen Hubbe <Allen.Hubbe@emc.com>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>, Dave Jiang <dave.jiang@intel.com>
List-ID: <linux-ntb.googlegroups.com>

On Thu, Mar 24, 2016 at 2:46 AM, Yu, Xiangliang <Xiangliang.Yu@amd.com> wrote:
>> -----Original Message-----
>> From: Allen Hubbe [mailto:Allen.Hubbe@emc.com]
>> Sent: Wednesday, March 23, 2016 10:01 PM
>> To: Yu, Xiangliang; linux-ntb@googlegroups.com
>> Cc: 'Jon Mason'; 'Dave Jiang'
>> Subject: RE: [PATCH 2/2] NTB: Remove _addr functions from ntb_hw_amd
>>
>> > From: Yu, Xiangliang
>> > > From: Allen Hubbe
>> > > > From: Yu, Xiangliang
>> > > > > From: Allen Hubbe
>> > > > > Kernel zero day testing warned about address space confusion.  A
>> > > > > virtual iomem address was used where a physical address is expected.
>> > > > > The offending functions implement an optional part of the api,
>> > > > > so they are removed.  They can be added later, after testing.
>> > > >
>> > > > Ntb_dev_ops_is_valid will check the related implement and AMD ntb
>> > > > driver can't Register ntb device if you remove the two functions.
>> > >
>> > > See [PATCH 1/2].
>> >
>> > I haven't received the mail of [PATCH 1/2].
>>
>> I resent it just to you.  Are you not subscribed to the linux-ntb mailing list?
>
> Yes, I have seen it.
>
>> Note: this patch 2/2 just takes the _addr functions out of the driver, which is
>> the only change I am comfortable to make without testing.  Since I cannot
>> test the driver, I cannot provide any real fix for the functions.  Since you have
>> the ability to test, if you provide a fix for these functions, I expect your patch
>> would be accepted instead of this one.  If you provide a fix, it would be best
>> to provide that fix assuming that my patch has not been applied, so that your
>> changes for the fix are clear in the patch.
>
> Ok, let's apply it firstly because I also can't test it now.
>
> Acked-by: Xiangliang Yu <Xiangliang.Yu@amd.com>
>

 Applied
