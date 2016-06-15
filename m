Return-Path: <Allen.Hubbe@emc.com>
Received: from mailuogwdur.emc.com (mailuogwdur.emc.com. [128.221.224.79])
        by gmr-mx.google.com with ESMTPS id x68si1964576ywd.6.2016.06.15.09.02.56
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jun 2016 09:02:56 -0700 (PDT)
From: "Allen Hubbe" <Allen.Hubbe@emc.com>
References: <cover.1465919682.git.logang@deltatee.com> <cad111de08474152044d0b02aa0ee303d8a68150.1465919683.git.logang@deltatee.com> <000401d1c673$9705bf50$c5113df0$@emc.com> <576070AE.10500@deltatee.com> <000501d1c686$3571c1e0$a05545a0$@emc.com> <57608116.8070003@deltatee.com>
In-Reply-To: <57608116.8070003@deltatee.com>
Subject: RE: [PATCH v2 6/8] ntb_tool: Add link status and files to debugfs
Date: Wed, 15 Jun 2016 12:02:29 -0400
Message-ID: <000101d1c71f$53461330$f9d23990$@emc.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
To: 'Logan Gunthorpe' <logang@deltatee.com>, 'Jon Mason' <jdmason@kudzu.us>, 'Dave Jiang' <dave.jiang@intel.com>
Cc: 'Shuah Khan' <shuahkh@osg.samsung.com>, 'Sudip Mukherjee' <sudipm.mukherjee@gmail.com>, 'Arnd Bergmann' <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, linux-kselftest@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

From: Logan Gunthorpe
> On 14/06/16 03:46 PM, Allen Hubbe wrote:
> > The ntb_tool is intended to be a simple low level access to the ntb.h api.  As much as
> possible, I think ntb_tool should directly expose the ntb.h api through debugfs, and not
> invent higher level concepts.
> 
> I really think practical concerns should override this. If we do it that
> way then my ntb_test script wouldn't necessarily work reliably and we'd
> just be asking for race conditions. (Especially if I moved the memory
> window tests earlier.) Anyone else trying to script with ntb_tool would
> run into the same problem.
> 
> Additionally, the link is up _and_ the hardware is configured/usable
> isn't really that high level a concept or anything a user wouldn't
> expect already.

If the user is debugging some issue in their hardware or driver, they may care to know that the link is reported up by the driver, even if some other configuration didn't work as expected.  Debugging the api-level behaviors of hardware and hardware drivers is the primary purpose of ntb_tool.  As you note below, ntb_tool is not intended to support real applications.

> 
> My understanding is that ntb_tool is really just a test client to verify
> the API and the hardware. I personally would not recommend it for any
> real applications. As such, I don't think this philosophical argument
> really matches that goal.

The purpose is to "verify the API and the hardware", not to support "real applications."

The link status reported by the tool should be the link status reported by "the API and the hardware," and not something else that might be convenient for "my ntb_test script" or "anyone else trying to script with ntb_tool."  The primary purpose of ntb_tool is api-level debugging of hardware and drivers, not scripting.

The problem with races in ntb_tool is due to auto-configuration of memory windows in ntb_tool.  Instead of having ntb_tool setup the memory windows automatically, maybe instead it should provide a file to control the memory windows via debugfs.  Reading the file can format what is returned by ntb_mw_get_range(), and writing the file can allocate a buffer and call ntb_mw_set_trans(), or ntb_mw_clear_trans() and free the buffer.  Then, the test script can wait for link up, then setup the memory windows, and then finally proceed with the rest of the tests, and there would be no race.  There would be no confusion about what "link up" means, and ntb_tool would more closely resemble the ntb.h api for memory windows.

> 
> 
> >>> If this was never set false anywhere in the patch that added memory windows, I wonder
> if
> >> there is a bug.
> >>
> >> Yup, this looks like an oversight on my part. However, I don't think it
> >> resulted in any noticeable bug seeing, at the time, the only way to
> >> bring the link back down was to remove the module or the device. It is
> >> only strictly necessary now that we have the 'link' file which can
> >> control the link.
> >
> > Even without a file to control the link, any one side could be unloaded and reloaded.
> That also affects the link state on the side that stays loaded.  The side that stays
> loaded still needs to be sane when the link comes back up.
> 
> Yup, you're correct. If the other side of link goes down then
> tc->link_is_up would be incorrect. So, yes, there may be a corner case
> bug there. Though, seeing tc-link_is_up was only previously used to
> cancel potentially queued delayed work it's probably pretty minor.
> 
> This was copied from ntb_perf which looks like it has the same issue.
> I'll make a patch for that in v3.
> 
> >>> I think tc->link_is_up should instead be ntb_link_is_up(tc->ntb).
> >>
> >> I disagree. Bad things will happen if the user waits on the event and
> >> then immediately uses the memory windows. It will just be buggy and
> >> racy. I can't see a situation where the user would want to wait for the
> >> link to come up and not have everything in ntb_tool ready and usable.
> >
> > The memory windows can be configured prior to link up.  They can be configured when
> probing the device instead of waiting for link up.  Doing memory window configuration in
> probe would simplify the driver, and there would be no race.
> 
> I'm not sure this is true, especially considering all possible hardware.
> It's certainly not true with the hardware I'm working with and I'd
> assume that all the existing NTB clients configured their memory windows
> on link up and not in probe for a good reason.

That's interesting about the hardware.  Maybe the driver for that particular hardware should make sure that any translation register programming happens before reporting link up to its clients.  Otherwise, ntb_transport will be broken on that hardware.  The ntb_transport driver configures memory windows the first time the link comes up, and only ever again if a different memory window size is negotiated (unlikely).

There are two reasons for doing the configuration after link up in ntb_transport.  First, it avoids consuming memory resources if the link never comes up.  Second, ntb_transport negotiates with its peer how much of the memory window will actually be used.  The ntb_perf tool is similar.

> 
> 
> Logan

