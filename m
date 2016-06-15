Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id i135si272196pfe.0.2016.06.15.15.21.10
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jun 2016 15:21:10 -0700 (PDT)
References: <cover.1466025130.git.logang@deltatee.com>
 <b1aa9e9977b992621452812f744ff7827ca4f28c.1466025130.git.logang@deltatee.com>
 <1466026416.16234.262.camel@intel.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <5761D4C5.8090208@deltatee.com>
Date: Wed, 15 Jun 2016 16:20:53 -0600
MIME-Version: 1.0
In-Reply-To: <1466026416.16234.262.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 10/10] ntb_perf: clear link_is_up flag when the link
 goes down.
To: "Jiang, Dave" <dave.jiang@intel.com>, "Allen.Hubbe@emc.com" <Allen.Hubbe@emc.com>, "jdmason@kudzu.us" <jdmason@kudzu.us>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "shuahkh@osg.samsung.com" <shuahkh@osg.samsung.com>, "sudipm.mukherjee@gmail.com" <sudipm.mukherjee@gmail.com>, "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

Hey,

Actually, I have to retract this patch. After some more thorough testing
I'm finding an issue:

When you remove and re-install the ntb_perf module very quickly,
ntb_perf will occasionally miss the link up event. This is because the
link_cleanup work gets delayed long enough that it gets scheduled after
the link up event gets sent. It then cancels the link work that should
have occurred. Without this patch, it never happens because link_is_up
never returns to false.

I think the correct solution is to just remove the link_cleanup work and
do those actions immediately on receipt of the event. If there's
agreement on this I can re-spin it again.

Thanks,

Logan


On 15/06/16 03:33 PM, Jiang, Dave wrote:
> On Wed, 2016-06-15 at 15:26 -0600, Logan Gunthorpe wrote:
>> When the link goes down, the link_is_up flag did not return to
>> false. This could have caused some subtle corner case bugs
>> when the link goes up and down quickly.
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> 
> Acked-by: Dave Jiang <dave.jiang@intel.com>
> 
> And all the other ntb_perf patches since there were no additional
> changes. 
> 
>> ---
>>  drivers/ntb/test/ntb_perf.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/ntb/test/ntb_perf.c
>> b/drivers/ntb/test/ntb_perf.c
>> index f0784e5..ae9d1b2 100644
>> --- a/drivers/ntb/test/ntb_perf.c
>> +++ b/drivers/ntb/test/ntb_perf.c
>> @@ -557,6 +557,8 @@ static void perf_link_cleanup(struct work_struct
>> *work)
>>  
>>  	if (!perf->link_is_up)
>>  		cancel_delayed_work_sync(&perf->link_work);
>> +
>> +	perf->link_is_up = false;
>>  }
>>  
>>  static int perf_setup_mw(struct ntb_dev *ntb, struct perf_ctx *perf)
>> -- 
>> 2.1.4
