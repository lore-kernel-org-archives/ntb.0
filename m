Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A461238C0D
	for <ntb@lists.linux.dev>; Wed,  3 Sep 2025 15:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756913192; cv=none; b=mEA63zTMN7nFn3Wo+nrXxbu8BfiWgyMtsLORmsLBJIlci83S5am7xRxDzxJFwOU1w3G8Pzkh7x/EdvXu1ODVJqFZ+PI33KwO2yeh+PTvZgWHlee9O735zT1fIUfmn38aCJ5cYgy6HyCvnoFVh0Gtb7N/DOztMKjEpYMiZUgcF6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756913192; c=relaxed/simple;
	bh=b5KF24PioFT9bG43Xm15ktTrj3yZUBBhV9mrwRN+cnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TzVN4XjHv78PztOL0okNbtmjxkOcv2ec7ERBvFIu40wbudrYQ/12EW+21R7mXLb8V/jwHXS02ibjfCkdgYl0J8WlnmdOhSn3kwhY1n+tpERfZlPPk3oR1lJpnxUEgdSyrtDRVmkwL7c71gkitbtRSH9Tmvb/Jm5tARIln3pRaR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q+DkxYys; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q+DkxYys"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756913190; x=1788449190;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=b5KF24PioFT9bG43Xm15ktTrj3yZUBBhV9mrwRN+cnQ=;
  b=Q+DkxYysdTvrj16aJvR/bBolD3CpLH4Saiu645uP4JCvhvwLmKHv7HNn
   DDFeJEXCRsm3DS/VNYjvyffcIksl4YGIRAPvumVXdVF3TZXYSZ+TfXzaO
   Su578AQGRmZke1t5QXKFF25Ne5NfZ/AeuFWv+prgnuwZrIriS9vfR36z/
   QbXQIDQTMMbiGtGU4h4J199wq8fIjL8zxEH57jGfY4NDK0mX8oj/J4iA1
   oYMuZ4KaJCj9aIBPhXr362EJo+1ZtXURFS7sLu1vRQYLrey7ybwHsPRJJ
   bKGkZ/jw0Tqb4cEP2+kmpUMKc2cQcWIDeT6TCzTqJQXxzzfDg77o44e8a
   Q==;
X-CSE-ConnectionGUID: D+0XFyw+QM+U0tWWFRbfKg==
X-CSE-MsgGUID: 2Xrjn8tAR96GyPgUHyU6Xw==
X-IronPort-AV: E=McAfee;i="6800,10657,11542"; a="46805014"
X-IronPort-AV: E=Sophos;i="6.18,236,1751266800"; 
   d="scan'208";a="46805014"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 08:26:30 -0700
X-CSE-ConnectionGUID: pZw52fH8QumqUcG7EMa9pg==
X-CSE-MsgGUID: 5azvJawbTme5+kT/ZE9A9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,236,1751266800"; 
   d="scan'208";a="171561645"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO [10.247.118.90]) ([10.247.118.90])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 08:26:27 -0700
Message-ID: <f755b775-b87a-4a3f-b7b9-f37cdadf21e3@intel.com>
Date: Wed, 3 Sep 2025 08:26:21 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ntb: Add mutex to make link_event_callback executed
 linearly.
To: yuanli fu <fuyuanli0722@gmail.com>
Cc: jdmason@kudzu.us, allenbh@gmail.com, ntb@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <aKwpnFtdtBlDv69O@didi-ThinkCentre-M930t-N000>
 <483cc0f8-6caa-4124-a724-433ff0d798fa@intel.com>
 <CABbqxmc+jkpgiHrWb5UH2FRZtaNpe4754qis=cPKtidW6+Vj6Q@mail.gmail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <CABbqxmc+jkpgiHrWb5UH2FRZtaNpe4754qis=cPKtidW6+Vj6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/2/25 7:20 PM, yuanli fu wrote:
> Dave Jiang <dave.jiang@intel.com> 于2025年8月25日周一 23:06写道：
>>
>>
>>
>> On 8/25/25 2:15 AM, fuyuanli wrote:
>>> Since the CPU selected by schedule_work is uncertain, multiple link_event
>>> callbacks may be executed at same time. For example, after peer's link is
>>> up, it is down quickly before local link_work completed. If link_cleanup
>>> is added to the workqueue of another CPU, then link_work and link_cleanup
>>> may be executed at the same time. So add a mutex to prevent them from being
>>> executed concurrently.
>>>
>>> Signed-off-by: fuyuanli <fuyuanli@didiglobal.com>
>>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
> Hi Dave,
> 
> Hope you are doing well.
> 
> Just wanted to gently follow up on this patch which you had acked
> before. Is there
> anything else I can do to help get this merged? Perhaps it needs a rebase on a
> different tree?

Jon will merge it when he has a chance.

> 
> Thanks for your time and all your work!
> 
> Best regards,
> Yuanli Fu
> 
> 
>>
>>> ---
>>> v2:
>>> 1) use guard() instead of lock & unlock functions.
>>>
>>> v1:
>>> Link: https://lore.kernel.org/all/aKiBi4ZDlbgzed%2Fz@didi-ThinkCentre-M930t-N000/
>>> ---
>>>  drivers/ntb/ntb_transport.c | 7 +++++++
>>>  1 file changed, 7 insertions(+)
>>>
>>> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
>>> index 4f775c3e218f..eb875e3db2e3 100644
>>> --- a/drivers/ntb/ntb_transport.c
>>> +++ b/drivers/ntb/ntb_transport.c
>>> @@ -59,6 +59,7 @@
>>>  #include <linux/slab.h>
>>>  #include <linux/types.h>
>>>  #include <linux/uaccess.h>
>>> +#include <linux/mutex.h>
>>>  #include "linux/ntb.h"
>>>  #include "linux/ntb_transport.h"
>>>
>>> @@ -241,6 +242,9 @@ struct ntb_transport_ctx {
>>>       struct work_struct link_cleanup;
>>>
>>>       struct dentry *debugfs_node_dir;
>>> +
>>> +     /* Make sure workq of link event be executed serially */
>>> +     struct mutex link_event_lock;
>>>  };
>>>
>>>  enum {
>>> @@ -1024,6 +1028,7 @@ static void ntb_transport_link_cleanup_work(struct work_struct *work)
>>>       struct ntb_transport_ctx *nt =
>>>               container_of(work, struct ntb_transport_ctx, link_cleanup);
>>>
>>> +     guard(mutex)(&nt->link_event_lock);
>>>       ntb_transport_link_cleanup(nt);
>>>  }
>>>
>>> @@ -1047,6 +1052,8 @@ static void ntb_transport_link_work(struct work_struct *work)
>>>       u32 val;
>>>       int rc = 0, i, spad;
>>>
>>> +     guard(mutex)(&nt->link_event_lock);
>>> +
>>>       /* send the local info, in the opposite order of the way we read it */
>>>
>>>       if (nt->use_msi) {
>>

