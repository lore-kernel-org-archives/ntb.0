Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id l22si233705ita.2.2017.11.19.22.25.35
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 19 Nov 2017 22:25:35 -0800 (PST)
From: Logan Gunthorpe <logang@deltatee.com>
References: <20171119152536.GA17838@graymalkin.kudzu.us>
 <CA+55aFwOJziwpmsi1TN-CA2i7jrWQE_GC9DjPg9-8x3mwz3uHQ@mail.gmail.com>
Message-ID: <e1e178fa-9da4-13bb-f070-0fa9094a74c7@deltatee.com>
Date: Sun, 19 Nov 2017 23:25:29 -0700
MIME-Version: 1.0
In-Reply-To: <CA+55aFwOJziwpmsi1TN-CA2i7jrWQE_GC9DjPg9-8x3mwz3uHQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Subject: Re: [GIT PULL] NTB bug fixes for v4.15
To: Linus Torvalds <torvalds@linux-foundation.org>, Jon Mason <jdmason@kudzu.us>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>



On 19/11/17 11:12 AM, Linus Torvalds wrote:
> I am now traveling, and am not inclined to pull stuff that hasn't been
> in linux-next unless it's just obviously bug-fixes.

Sigh. This work has been held up for two cycles due to issues with the
process.

If it's of any consideration, my Switchtec NTB patches were in one of my
repos which is subscribed to the kbuild test robot. I did receive a
build success notification email on it a few months ago. It's also an
isolated driver which shouldn't have any effect on any other systems.

I've also been postponing a couple of other minor patches to the
original Switchtec driver because they will have merge conflicts with
the NTB work.

Thanks,

Logan


> Date: Fri, 04 Aug 2017 03:55:34 +0800
> From: kbuild test robot <fengguang.wu@intel.com>
> Subject: [p2pmem:switchtec_ntb_v4] BUILD SUCCESS
>  253e1151b5dbb16cd21aee8cb125fd618d6846e0
> Message-ID: <59837fb6.PD30U+EhLwDZh5Rw%fengguang.wu@intel.com>
> 
> https://github.com/sbates130272/linux-p2pmem.git  switchtec_ntb_v4
> 253e1151b5dbb16cd21aee8cb125fd618d6846e0  NTB: switchtec_ntb: Update switchtec documentation with notes for NTB
> 
> elapsed time: 180m
> 
> configs tested: 159
>
> The following configs have been built successfully.
> More configs may be tested in the coming days.>
> <snip>

