Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id tp10si3803107pac.2.2016.06.14.15.11.51
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jun 2016 15:11:51 -0700 (PDT)
References: <cover.1465919682.git.logang@deltatee.com>
 <cad111de08474152044d0b02aa0ee303d8a68150.1465919683.git.logang@deltatee.com>
 <000401d1c673$9705bf50$c5113df0$@emc.com> <576070AE.10500@deltatee.com>
 <000501d1c686$3571c1e0$a05545a0$@emc.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <57608116.8070003@deltatee.com>
Date: Tue, 14 Jun 2016 16:11:34 -0600
MIME-Version: 1.0
In-Reply-To: <000501d1c686$3571c1e0$a05545a0$@emc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 6/8] ntb_tool: Add link status and files to debugfs
To: Allen Hubbe <Allen.Hubbe@emc.com>, 'Jon Mason' <jdmason@kudzu.us>, 'Dave Jiang' <dave.jiang@intel.com>
Cc: 'Shuah Khan' <shuahkh@osg.samsung.com>, 'Sudip Mukherjee' <sudipm.mukherjee@gmail.com>, 'Arnd Bergmann' <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, linux-kselftest@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>



On 14/06/16 03:46 PM, Allen Hubbe wrote:
> The ntb_tool is intended to be a simple low level access to the ntb.h api.  As much as possible, I think ntb_tool should directly expose the ntb.h api through debugfs, and not invent higher level concepts.

I really think practical concerns should override this. If we do it that
way then my ntb_test script wouldn't necessarily work reliably and we'd
just be asking for race conditions. (Especially if I moved the memory
window tests earlier.) Anyone else trying to script with ntb_tool would
run into the same problem.

Additionally, the link is up _and_ the hardware is configured/usable
isn't really that high level a concept or anything a user wouldn't
expect already.

My understanding is that ntb_tool is really just a test client to verify
the API and the hardware. I personally would not recommend it for any
real applications. As such, I don't think this philosophical argument
really matches that goal.


>>> If this was never set false anywhere in the patch that added memory windows, I wonder if
>> there is a bug.
>>
>> Yup, this looks like an oversight on my part. However, I don't think it
>> resulted in any noticeable bug seeing, at the time, the only way to
>> bring the link back down was to remove the module or the device. It is
>> only strictly necessary now that we have the 'link' file which can
>> control the link.
> 
> Even without a file to control the link, any one side could be unloaded and reloaded.  That also affects the link state on the side that stays loaded.  The side that stays loaded still needs to be sane when the link comes back up.

Yup, you're correct. If the other side of link goes down then
tc->link_is_up would be incorrect. So, yes, there may be a corner case
bug there. Though, seeing tc-link_is_up was only previously used to
cancel potentially queued delayed work it's probably pretty minor.

This was copied from ntb_perf which looks like it has the same issue.
I'll make a patch for that in v3.

>>> I think tc->link_is_up should instead be ntb_link_is_up(tc->ntb).
>>
>> I disagree. Bad things will happen if the user waits on the event and
>> then immediately uses the memory windows. It will just be buggy and
>> racy. I can't see a situation where the user would want to wait for the
>> link to come up and not have everything in ntb_tool ready and usable.
> 
> The memory windows can be configured prior to link up.  They can be configured when probing the device instead of waiting for link up.  Doing memory window configuration in probe would simplify the driver, and there would be no race.

I'm not sure this is true, especially considering all possible hardware.
It's certainly not true with the hardware I'm working with and I'd
assume that all the existing NTB clients configured their memory windows
on link up and not in probe for a good reason.


Logan
