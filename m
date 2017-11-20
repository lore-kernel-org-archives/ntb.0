Return-Path: <dave.jiang@intel.com>
Received: from mga05.intel.com (mga05.intel.com. [192.55.52.43])
        by gmr-mx.google.com with ESMTPS id m11si650716qth.0.2017.11.20.14.40.16
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Nov 2017 14:40:17 -0800 (PST)
Subject: Re: [GIT PULL] NTB bug fixes for v4.15
References: <20171119152536.GA17838@graymalkin.kudzu.us>
 <CA+55aFwOJziwpmsi1TN-CA2i7jrWQE_GC9DjPg9-8x3mwz3uHQ@mail.gmail.com>
 <e1e178fa-9da4-13bb-f070-0fa9094a74c7@deltatee.com>
 <CA+55aFwmGk=279M9D2XzpuVoMuB_MPw+2n4vb47ZYh72GM6gaw@mail.gmail.com>
 <338c8f27-369b-11c4-f764-b8f726038f35@deltatee.com>
 <20171121093719.211f8194@canb.auug.org.au>
From: Dave Jiang <dave.jiang@intel.com>
Message-ID: <bd9c3b5f-966c-d026-7f3f-6d5bc64a01b9@intel.com>
Date: Mon, 20 Nov 2017 15:40:13 -0700
MIME-Version: 1.0
In-Reply-To: <20171121093719.211f8194@canb.auug.org.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Stephen Rothwell <sfr@canb.auug.org.au>, Logan Gunthorpe <logang@deltatee.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jon Mason <jdmason@kudzu.us>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>



On 11/20/2017 03:37 PM, Stephen Rothwell wrote:
> Hi Logan,
> 
> On Sun, 19 Nov 2017 23:51:48 -0700 Logan Gunthorpe <logang@deltatee.com> wrote:
>>
>>> I do want to protest the timing and the lack of linux-next coverage.
>>> If it has really been ready for months, why hasn't it been in
>>> linux-next at all?  
>>
>> Understood. I can't speak for Jon, but in the future if I have patches
>> in the queue, I will definitely remind him to send it to Stephen for the
>> linux-next tree. And I'll make sure it gets there ahead of the merge window.
> 
> OK, all I need is the (git) URL for a tree/branch (or tag) and a
> contact (or more than one) to whom I can report conflicts and build
> problems.  I then fetch it every day (so all you have to do it add stuff
> to that branch when it is ready).
> 
> I noticed that one of the current set of commits removed Jon as a
> MAINTAINER, so I am not sure what part he would play.
> 

He is still the NTB subsystem maintainer with more hardware drivers
continue being added. I just removed him from the Intel hardware driver
so he's not getting bothered with questions that should be coming to me.
