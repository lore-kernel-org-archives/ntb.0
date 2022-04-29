Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C281851
	for <ntb@lists.linux.dev>; Fri, 29 Apr 2022 17:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651252517; x=1682788517;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kpSwpORxejTSne3rhCZ0/dYrLcJ8PW2c9ucw7lEQJJ4=;
  b=V3TCKqj+qsu5SL3HW1Uv/kliVI76tpQgVggllDlxBJBnHwEvMC5j1h7p
   QLSEbqpgre5bQ12pjWctdRtOWLZj6PTnHTWN9iKAzOEP68L7sLCWwbcyB
   jVlC/aRZTJavf7Q19L/pbGZa1U8xmCdpg3wucTmY1vxmy2UziGp+l0eSI
   jiSJGpyoW9R96vRSuBSt4B6znSrYpkToMCi3+ebWO5L0M2P5WH9qsyKPR
   akDwFZ+BkpF2LDXyrCvJFUUsBZ+GmodCeK7VV8uLU6pR9riScPwBaxtJF
   j7HWoL5hXFfGoa53NxS9IpU8r22//SCZvdOT1i9MdGA4HTnrtTM4kPJ0Z
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10332"; a="291878915"
X-IronPort-AV: E=Sophos;i="5.91,185,1647327600"; 
   d="scan'208";a="291878915"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 10:15:17 -0700
X-IronPort-AV: E=Sophos;i="5.91,185,1647327600"; 
   d="scan'208";a="662440499"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.212.28.100]) ([10.212.28.100])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 10:15:16 -0700
Message-ID: <c3a03256-185e-bdbf-03f7-52bed925ab8f@intel.com>
Date: Fri, 29 Apr 2022 10:15:16 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 2/3] ntb_perf: extend with poll latency measurement
Content-Language: en-US
To: Alexander Fomichev <fomichev.ru@gmail.com>
Cc: ntb@lists.linux.dev, linux@yadro.com, Jon Mason <jdmason@kudzu.us>,
 Allen Hubbe <allenbh@gmail.com>, Guo Zhengkui <guozhengkui@vivo.com>,
 Alexander Fomichev <a.fomichev@yadro.com>
References: <20220422113703.48820-1-fomichev.ru@gmail.com>
 <20220422113703.48820-2-fomichev.ru@gmail.com>
 <384e2fc0-27be-00f9-974d-70a4acdee1c5@intel.com>
 <20220429085333.is4wky7gslqjtbin@yadro.com>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20220429085333.is4wky7gslqjtbin@yadro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 4/29/2022 1:53 AM, Alexander Fomichev wrote:
> Hi Dave,
>
> On Mon, Apr 25, 2022 at 09:49:43AM -0700, Dave Jiang wrote:
>> On 4/22/2022 4:37 AM, Alexander Fomichev wrote:
>>> From: Alexander Fomichev <a.fomichev@yadro.com>
>>>
>>> The proposed change extends ntb_perf with 2nd of 3 new metrics. The resulting
>>> test is fully backward compatible.
>>>
>>> 2. Poll latency. It's a delay between start to send 1 byte to the
>>> remote system and receiving the confirmation. The remote system needs to
>>> be run in server mode beforehand. Then the server polls the input buffer
>>> and on receiving data immediately sends the confirmation back.
>> This is a general comment. Please make the commit logs as they are
>> individual standalone patches and not refer to each other.
> OK.
>
>>> Signed-off-by: Alexander Fomichev <a.fomichev@yadro.com>
>>> ---
>>>    drivers/ntb/test/ntb_perf.c | 365 +++++++++++++++++++++++++++++++++++-
>>>    1 file changed, 364 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
>>> index 79faa4a7fe94..d4664410e543 100644
>>> --- a/drivers/ntb/test/ntb_perf.c
>>> +++ b/drivers/ntb/test/ntb_perf.c
>>> @@ -85,7 +85,7 @@
>>>    #include <linux/ntb.h>
>>>    #define DRIVER_NAME		"ntb_perf"
>>> -#define DRIVER_VERSION		"2.0"
>>> +#define DRIVER_VERSION		"2.1"
>> Oddly random version change in the middle patch.
>>
> I will re-number every feature as minor version change, accumulating your
> comment to the 3rd patch.
>
>>>    MODULE_LICENSE("Dual BSD/GPL");
>>>    MODULE_VERSION(DRIVER_VERSION);
>>> @@ -133,6 +133,10 @@ static unsigned long lat_time_ms = 1000; /* default 1s */
>>>    module_param(lat_time_ms, ulong, 0644);
>>>    MODULE_PARM_DESC(lat_time_ms, "Time (in ms) to test latency");
>>> +static unsigned long lat_timeout_us = 500;
>>> +module_param(lat_timeout_us, ulong, 0644);
>>> +MODULE_PARM_DESC(lat_timeout_us, "Timeout (in us) to wait for server reply");
>> I would refrain from using the word "timeout" for variable and description
>> as that's typically used for when a set time expires. Maybe "Roundtrip
>> Latency" would be the better description?
>>
> In this case it's a real timemout. The client polls the buffer waiting
> for the server reply. If that amount of time expired and no reply word
> encountered, then an error reported.
Ok
>
>
