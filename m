Return-Path: <jdmason@kudzu.us>
Received: from mail-vk0-x242.google.com (mail-vk0-x242.google.com. [2607:f8b0:400c:c05::242])
        by gmr-mx.google.com with ESMTPS id v71si827257vkd.3.2016.03.27.08.23.22
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Mar 2016 08:23:22 -0700 (PDT)
Received: by mail-vk0-x242.google.com with SMTP id e6so12378288vkh.1
        for <linux-ntb@googlegroups.com>; Sun, 27 Mar 2016 08:23:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160322003117.GA15424@google.com>
References: <1458321080-42873-1-git-send-email-computersforpeace@gmail.com>
	<20160321235237.GA17910@kudzu.us>
	<20160322003117.GA15424@google.com>
Date: Sun, 27 Mar 2016 11:23:22 -0400
Message-ID: <CAPoiz9xq1_JcO23iu3KOe3ZH6+ygQJmEVdVBEHHMey2JVg_9ow@mail.gmail.com>
Subject: Re: [PATCH] ntb: test: fix pointer size warning
From: Jon Mason <jdmason@kudzu.us>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Brian Norris <computersforpeace@gmail.com>
Cc: Allen Hubbe <Allen.Hubbe@emc.com>, Dave Jiang <dave.jiang@intel.com>, linux-ntb@googlegroups.com, linux-kernel <linux-kernel@vger.kernel.org>
List-ID: <linux-ntb.googlegroups.com>

On Mon, Mar 21, 2016 at 8:31 PM, Brian Norris
<computersforpeace@gmail.com> wrote:
> On Mon, Mar 21, 2016 at 07:52:38PM -0400, Jon Mason wrote:
>> On Fri, Mar 18, 2016 at 10:11:20AM -0700, Brian Norris wrote:
>> > drivers/ntb/test/ntb_perf.c: In function =E2=80=98perf_copy=E2=80=99:
>> > drivers/ntb/test/ntb_perf.c:213:10: warning: cast from pointer to inte=
ger of different size [-Wpointer-to-int-cast]
>> > drivers/ntb/test/ntb_perf.c:214:14: warning: cast from pointer to inte=
ger of different size [-Wpointer-to-int-cast]
>> >
>> > On 32-bit systems, we are casting a 32-bit pointer to a 64-bit value.
>> > This shouldn't cause functional problems, but we might as well fix the
>> > warning and allow 32-bit arithmetic for 32-bit systems.
>>
>> This was already addressed by a patch from Arnd Bergmann, which is
>> queued in the ntb git tree.
>
> Great!
>
> Is your ntb tree in linux-next.git?

No, it is not.

> Regards,
> Brian
