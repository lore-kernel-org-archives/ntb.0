Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id c11si2287817pfc.2.2016.06.15.09.20.55
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jun 2016 09:20:56 -0700 (PDT)
References: <cover.1465919682.git.logang@deltatee.com>
 <cad111de08474152044d0b02aa0ee303d8a68150.1465919683.git.logang@deltatee.com>
 <000401d1c673$9705bf50$c5113df0$@emc.com> <576070AE.10500@deltatee.com>
 <000501d1c686$3571c1e0$a05545a0$@emc.com> <57608116.8070003@deltatee.com>
 <000101d1c71f$53461330$f9d23990$@emc.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <57618056.3000008@deltatee.com>
Date: Wed, 15 Jun 2016 10:20:38 -0600
MIME-Version: 1.0
In-Reply-To: <000101d1c71f$53461330$f9d23990$@emc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 6/8] ntb_tool: Add link status and files to debugfs
To: Allen Hubbe <Allen.Hubbe@emc.com>, 'Jon Mason' <jdmason@kudzu.us>, 'Dave Jiang' <dave.jiang@intel.com>
Cc: 'Shuah Khan' <shuahkh@osg.samsung.com>, 'Sudip Mukherjee' <sudipm.mukherjee@gmail.com>, 'Arnd Bergmann' <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, linux-kselftest@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>



On 15/06/16 10:02 AM, Allen Hubbe wrote:
>> My understanding is that ntb_tool is really just a test client to verify
>> the API and the hardware. I personally would not recommend it for any
>> real applications. As such, I don't think this philosophical argument
>> really matches that goal.
> 
> The purpose is to "verify the API and the hardware", not to support "real applications."
> 
> The link status reported by the tool should be the link status reported by "the API and the hardware," and not something else that might be convenient for "my ntb_test script" or "anyone else trying to script with ntb_tool."  The primary purpose of ntb_tool is api-level debugging of hardware and drivers, not scripting.
> 
> The problem with races in ntb_tool is due to auto-configuration of memory windows in ntb_tool.  Instead of having ntb_tool setup the memory windows automatically, maybe instead it should provide a file to control the memory windows via debugfs.  Reading the file can format what is returned by ntb_mw_get_range(), and writing the file can allocate a buffer and call ntb_mw_set_trans(), or ntb_mw_clear_trans() and free the buffer.  Then, the test script can wait for link up, then setup the memory windows, and then finally proceed with the rest of the tests, and there would be no race.  There would be no confusion about what "link up" means, and ntb_tool would more closely resemble the ntb.h api for memory windows.

Ok, well this is a good deal more complicated than it is now but I can
live with it. I'll work something up shortly.


> That's interesting about the hardware.  Maybe the driver for that particular hardware should make sure that any translation register programming happens before reporting link up to its clients.  Otherwise, ntb_transport will be broken on that hardware.  The ntb_transport driver configures memory windows the first time the link comes up, and only ever again if a different memory window size is negotiated (unlikely).
> 
> There are two reasons for doing the configuration after link up in ntb_transport.  First, it avoids consuming memory resources if the link never comes up.  Second, ntb_transport negotiates with its peer how much of the memory window will actually be used.  The ntb_perf tool is similar.

Hmm, yes I didn't notice that in ntb_transport. We'll have to make some
considerations for that in our driver.

Logan
