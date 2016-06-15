Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id c11si2499862pfc.2.2016.06.15.16.11.46
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jun 2016 16:11:46 -0700 (PDT)
References: <cover.1466025130.git.logang@deltatee.com>
 <b1aa9e9977b992621452812f744ff7827ca4f28c.1466025130.git.logang@deltatee.com>
 <1466026416.16234.262.camel@intel.com> <5761D4C5.8090208@deltatee.com>
 <1466029459.16234.263.camel@intel.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <5761E0A0.4060505@deltatee.com>
Date: Wed, 15 Jun 2016 17:11:28 -0600
MIME-Version: 1.0
In-Reply-To: <1466029459.16234.263.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 10/10] ntb_perf: clear link_is_up flag when the link
 goes down.
To: "Jiang, Dave" <dave.jiang@intel.com>, "Allen.Hubbe@emc.com" <Allen.Hubbe@emc.com>, "jdmason@kudzu.us" <jdmason@kudzu.us>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "shuahkh@osg.samsung.com" <shuahkh@osg.samsung.com>, "sudipm.mukherjee@gmail.com" <sudipm.mukherjee@gmail.com>, "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

Hey,

On 15/06/16 04:24 PM, Jiang, Dave wrote:
> On Wed, 2016-06-15 at 16:20 -0600, Logan Gunthorpe wrote:
>> Hey,
>>
>> Actually, I have to retract this patch. After some more thorough
>> testing
>> I'm finding an issue:
>>
>> When you remove and re-install the ntb_perf module very quickly,
>> ntb_perf will occasionally miss the link up event. This is because
>> the
>> link_cleanup work gets delayed long enough that it gets scheduled
>> after
>> the link up event gets sent. It then cancels the link work that
>> should
>> have occurred. Without this patch, it never happens because
>> link_is_up
>> never returns to false.
>>
>> I think the correct solution is to just remove the link_cleanup work
>> and
>> do those actions immediately on receipt of the event. If there's
>> agreement on this I can re-spin it again.
> 
> I'm ok with that. This is not an issue with ntb_transport?

Looks like I can get something similar to happen in ntb_transport.
However, it's much rarer and takes significantly more tries to get it to
occur. It does appear to correctly set its link_is_up to false when the
link goes down.

I'm not sure I'm quite clear on the flow in ntb_transport and don't have
time right now to study it so I'll have to let that be someone else's
(fairly minor) issue.

Logan
