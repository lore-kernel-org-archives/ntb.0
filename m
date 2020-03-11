Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id m18si138114qtn.5.2020.03.11.11.47.30
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 11:47:30 -0700 (PDT)
References: <1583873694-19151-1-git-send-email-sanju.mehta@amd.com>
 <1583873694-19151-3-git-send-email-sanju.mehta@amd.com>
 <3c350277-8fe6-04b2-673e-7d4c8fb6ce24@deltatee.com>
 <MN2PR12MB3232AD3D784F07645D7115609CFC0@MN2PR12MB3232.namprd12.prod.outlook.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <214f3ef3-853d-6b0d-0fed-5bb6c1f1de1f@deltatee.com>
Date: Wed, 11 Mar 2020 12:47:23 -0600
MIME-Version: 1.0
In-Reply-To: <MN2PR12MB3232AD3D784F07645D7115609CFC0@MN2PR12MB3232.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 2/5] ntb_perf: send command in response to EAGAIN
To: "Nath, Arindam" <Arindam.Nath@amd.com>, "Mehta, Sanju" <Sanju.Mehta@amd.com>, "jdmason@kudzu.us" <jdmason@kudzu.us>, "dave.jiang@intel.com" <dave.jiang@intel.com>, "allenbh@gmail.com" <allenbh@gmail.com>, "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>
Cc: "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-ID: <linux-ntb.googlegroups.com>



On 2020-03-11 12:11 p.m., Nath, Arindam wrote:
>> -----Original Message-----
>> From: Logan Gunthorpe <logang@deltatee.com>
>> Sent: Wednesday, March 11, 2020 03:01
>> To: Mehta, Sanju <Sanju.Mehta@amd.com>; jdmason@kudzu.us;
>> dave.jiang@intel.com; allenbh@gmail.com; Nath, Arindam
>> <Arindam.Nath@amd.com>; S-k, Shyam-sundar <Shyam-sundar.S-
>> k@amd.com>
>> Cc: linux-ntb@googlegroups.com; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH v2 2/5] ntb_perf: send command in response to EAGAIN
>>
>>
>>
>> On 2020-03-10 2:54 p.m., Sanjay R Mehta wrote:
>>> From: Arindam Nath <arindam.nath@amd.com>
>>>
>>> perf_spad_cmd_send() and perf_msg_cmd_send() return
>>> -EAGAIN after trying to send commands for a maximum
>>> of MSG_TRIES re-tries. But currently there is no
>>> handling for this error. These functions are invoked
>>> from perf_service_work() through function pointers,
>>> so rather than simply call these functions is not
>>> enough. We need to make sure to invoke them again in
>>> case of -EAGAIN. Since peer status bits were cleared
>>> before calling these functions, we set the same status
>>> bits before queueing the work again for later invocation.
>>> This way we simply won't go ahead and initialize the
>>> XLAT registers wrongfully in case sending the very first
>>> command itself fails.
>>
>> So what happens if there's an actual non-recoverable error that causes
>> perf_msg_cmd_send() to fail? Are you proposing it just requeues high
>> priority work forever?
> 
> The intent of the patch is to handle -EAGAIN, since the error code is
> an indication that we need to try again later. Currently there is a very
> small time frame during which ntb_perf should be loaded on both sides
> (primary and secondary) to have XLAT registers configured correctly.
> Failing that the code will still fall through without properly initializing the
> XLAT registers and there is no indication of that either until we have
> actually tried to perform 'echo 0 > /sys/kernel/debug/.../run'.
> 
> With the changes proposed in this patch, we do not have to depend
> on whether the drivers at both ends are loaded within a fixed time
> duration. So we can simply load the driver at one side, and at a later
> time load the driver on the other, and still the XLAT registers would
> be set up correctly.
> 
> Looking at perf_spad_cmd_send() and perf_msg_cmd_send(), if the
> concern is that ntb_peer_spad_read()/ntb_msg_read_sts() fail because
> of some non-recoverable error and we still schedule a high priority
> work, that is a valid concern. But isn't it still better than simply falling
> through and initializing XLAT register with incorrect values?

I don't think it's ever acceptable to get into an infinite loop.
Especially when you're running on the system's high priority work queue...

At the very least schedule a delayed work item to try again in some
number of seconds or something. Essentially just have more retires,
perhaps with longer delays in between.

Falling through and continuing with the wrong values is certainly wrong.
I didn't notice that. If an error occurs, it shouldn't continue, it
should print an error to dmesg and stop.

> 
>>
>> I never really reviewed this stuff properly but it looks like it has a
>> bunch of problems. Using the high priority work queue for some low
>> priority setup work seems wrong, at the very least. The spad and msg
>> send loops also look like they have a bunch of inter-host race condition
>> problems as well. Yikes.
> 
> I am not very sure what the design considerations were when having
> a high priority work queue, but perhaps we can all have a discussion
> on this.

I'd change it. Seems completely wrong to me.

Logan
