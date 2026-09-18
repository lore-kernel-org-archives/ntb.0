Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED184E4300
	for <ntb@lists.linux.dev>; Fri, 18 Sep 2026 14:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789742610; cv=none; b=tLchp+BMOOYvXyf5sjZLlcFS2gjoHVg5uu6+0aXZowVoU/ssLXjEVCiSd2OlwuZtAz3sNFwQe0xFDpmTqduLDvGOSPpD/hMq4c/neskFkiCKtu4nVL9xapWIJW8gHx6pGG0/R7tiyXSbeBknw0JZ7odf6t7to5TUJrT5fx+/YRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789742610; c=relaxed/simple;
	bh=qWivAt5AoOtagOLqIxO8pAOyiQ4DAkIBdYhIytKZ80w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TM/JIBwAX1heVedYl2apyIwIZhV2bh33bHlCpclcPbg9CQuYmPCVlS4tpLI1BAakFqq4Vp2toK5nOOtm1wIj+7ZkU5QG+OeAAwNtpr+DH2JXK/U4gKkM4oXsvRnR93JhWIhNwQC96UPdrBxIfJYCimiQ9HvXux1CgJU/glfnppo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lu12+JM1; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lu12+JM1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789742609; x=1821278609;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qWivAt5AoOtagOLqIxO8pAOyiQ4DAkIBdYhIytKZ80w=;
  b=lu12+JM1esdic6N+Iu0w/00/oNewY+Hag8z3dgQ4U2gOOW5FqO/O2vun
   MXRnc1KxNyYFUa0F9y8FHGQAxc1PuKhhdSkLq2p7uJeFZaxtAgDdueEyM
   wm65TDGl6czS7AU9WmLnPZ5UXT/FNEaLEn8AL4WOIa8iaKw+6m4fvEGJW
   g1zEU519hxxu1iR6PjtoUDgkNxXSfYGQeauDp7DpiheGneUGm7ajs3udn
   l2cu6ToxfXibJs2UwupuYZOlW6r2oCHWjfBxPk6qeqR/7A4jWCRAEEMLC
   6mIBvy8rN/p836YW6lhRzX6caG0BvtH9W3BJk+JmaK9iFBiix9XbQvTyM
   g==;
X-CSE-ConnectionGUID: NS4JJkg2SsqmZmSdeyKIZw==
X-CSE-MsgGUID: 8LMhFFsgS9irbo9JTsVHmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="107757527"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="107757527"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 07:43:28 -0700
X-CSE-ConnectionGUID: /W++crubRcahKq1GUM5TbQ==
X-CSE-MsgGUID: 5bCMYtaSTG6dHpyUs/ZAxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="271110803"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.109.117]) ([10.125.109.117])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 07:43:27 -0700
Message-ID: <a135b068-e7ee-40f9-8ae7-ca5c44db2dac@intel.com>
Date: Fri, 18 Sep 2026 07:43:26 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/14] NTB: ntb_transport: Avoid losing QP link-up
 requests
To: Koichiro Den <den@valinux.co.jp>, Frank Li <Frank.li@oss.nxp.com>
Cc: Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>,
 Frank Li <Frank.Li@kernel.org>, Logan Gunthorpe <logang@deltatee.com>,
 fuyuanli <fuyuanli0722@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nicholas Bellinger <nab@linux-iscsi.org>,
 Joey Zhang <joey.zhang@microchip.com>, ntb@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260910040836.3792333-1-den@valinux.co.jp>
 <20260910040836.3792333-6-den@valinux.co.jp> <aqQyEbLbABhhvFTO@SMW015318>
 <ciucjqvb7qbendlxqdya2wigyivgj4bvqbxtc4cidulr4knq6j@xbwucjdsiayy>
 <l5xf2iuwxgfa4xmtm2l3wn6nce5onfjxxkzfsj627k5xp3snmp@er6fkwlb3sgs>
 <aqTFAi8uo4LwzSj0@SMW015318>
 <i3b4kyeuwyjssav2kne5uhxmltwl2bmug2weyfaujxtrwlkuox@ms6ozb55tmz5>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <i3b4kyeuwyjssav2kne5uhxmltwl2bmug2weyfaujxtrwlkuox@ms6ozb55tmz5>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/12/26 7:52 AM, Koichiro Den wrote:
> On Fri, Sep 11, 2026 at 10:20:34PM -0500, Frank Li wrote:
>> On Sat, Sep 12, 2026 at 03:21:08AM +0900, Koichiro Den wrote:
>>> On Sat, Sep 12, 2026 at 03:04:21AM +0900, Koichiro Den wrote:
>>>> On Fri, Sep 11, 2026 at 11:53:37AM -0500, Frank Li wrote:
>>>>> On Thu, Sep 10, 2026 at 01:08:27PM +0900, Koichiro Den wrote:
>>>>>> ntb_netdev_open() can call ntb_transport_link_up() while the transport
>>>>>> worker is completing setup on another CPU. Concurrent transport setup
>>>>>> and a client link-up request can both read the other's flag as false and
>>>>>> leave QP link work unqueued. The QP then stays down until another link
>>>>>> event or client link-up request.
>>>>>>
>>>>>> This is the store-buffering pattern described in
>>>>>> tools/memory-model/Documentation/recipes.txt ("Store buffering").
>>>>>>
>>>>>> Add a full barrier between the store and load on each side, and
>>>>>> mark the client_ready accesses with READ_ONCE()/WRITE_ONCE().
>>>>>>
>>>>>> Fixes: fce8a7bb5b4b ("PCI-Express Non-Transparent Bridge Support")
>>>>>> Cc: stable@vger.kernel.org
>>>>>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>>>>>> Link: https://lore.kernel.org/r/20260907144701.702E41F00A3A@smtp.kernel.org/
>>>>>> Signed-off-by: Koichiro Den <den@valinux.co.jp>
>>>>>> ---
>>>>>> Changes in v2:
>>>>>>   - New patch (Sashiko)
>>>>>>
>>>>>>  drivers/ntb/ntb_transport.c | 13 +++++++++++--
>>>>>>  1 file changed, 11 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
>>>>>> index 75d4a2e021f4..1332d53bcfe7 100644
>>>>>> --- a/drivers/ntb/ntb_transport.c
>>>>>> +++ b/drivers/ntb/ntb_transport.c
>>>>>> @@ -1104,10 +1104,16 @@ static void ntb_transport_link_work(struct work_struct *work)
>>>>>>  	/* Publish the link only after every QP has been set up. */
>>>>>>  	smp_store_release(&nt->link_is_up, true);
>>>>>>
>>>>>> +	/*
>>>>>> +	 * Prevent both sides from missing each other's flag. Pairs with
>>>>>> +	 * the barrier in ntb_transport_link_up().
>>>>>> +	 */
>>>>>> +	smp_mb();
>>>>>> +
>>>>>>  	for (i = 0; i < nt->qp_count; i++) {
>>>>>>  		struct ntb_transport_qp *qp = &nt->qp_vec[i];
>>>>>>
>>>>>> -		if (qp->client_ready)
>>>>>> +		if (READ_ONCE(qp->client_ready))
>>>>>
>>>>> I think it'd better change to use atomic variable for client_ready to avoid
>>>>> manual handle smp sync.
>>>>
>>>> AFAICT converting client_ready to atomic_t and using atomic_set()/atomic_read()
>>>> instead of WRITE_ONCE()/READ_ONCE() would not free us from the smp sync, as
>>>> those operations are unordered.
>>
>> there are acquire version for atomic
>>
>> atomic_set_release()
>>
>> atomic_read_acquire()
>>
>> My key point is use existing higher level sync APIs to avoid consider
>> barrier problem, which need more brain cell to think it.
>>
>> this is just sync state, which don't impact performance.
> 
> I agree with the idea of changing both flags to atomic_t for cleaner code, but
> I'm not sure if it frees us from "the smp sync" or the "barrier problem". We'd
> still need both smp_mb()s and still have to think about *_release/*_acquire when
> revisiting the code and maybe scratching our heads, right?
> 
> BTW, I once wondered whether it might be worth consolidating
> link_work/link_cleanup into a single state machine worker per transport or QP.
> That could simplify synchronization between setup and cleanup, which aren't
> really performance-critical, as you say. However, that would possibly require a
> larger rework, so for now I've put together this fix series as a small step. I
> would be interested to hear what NTB maintainers think about the possibility of
> such a rework.

I'm fine with it if it doesn't break any existing code and reduces complexity with simpler code.

DJ


> 
> Best regards,
> Koichiro
> 
>>
>> Frank
>>
>>>> So to illustrate this in litmus test like form:
>>>>
>>>>    # L = nt->link_is_up
>>>>    # R = qp->client_ready
>>>>    # Both initially false
>>>>
>>>>    Transport setup                  Client link-up
>>>>    ---------------                  --------------
>>>>     smp_store_release(&L, true);     WRITE_ONCE(R, true);
>>>>     smp_mb(); /* added */            smp_mb(); /* added */
>>>>     r0 = READ_ONCE(R);               r1 = smp_load_acquire(&L);
>>>>
>>>>    Both reads return false?
>>>>     Before: allowed
>>>>     After:  forbidden
>>>>
>>>> I might be misunderstanding your suggestion though. If you have something
>>>> different in mind, please let me know.
>>>
>>> Just for the record, smp_store_release/smp_load_acquire depicted above, instead
>>> of WRITE_ONCE()/READ_ONCE(), is intentional. They are for MP ordering to publish
>>> the QP setup, which is needed by an earlier patch:
>>> https://lore.kernel.org/r/20260910040836.3792333-5-den@valinux.co.jp/
>>>
>>> Best regards,
>>> Koichiro
>>>
>>>>
>>>> Thanks for the review.
>>>> Koichiro
>>>>
>>>>>
>>>>> Frank
>>>>>
>>>>>>  			ntb_transport_schedule_qp_link(qp, 0);
>>>>>>  	}
>>>>>>
>>>>>> @@ -2401,7 +2407,10 @@ void ntb_transport_link_up(struct ntb_transport_qp *qp)
>>>>>>  	if (!qp)
>>>>>>  		return;
>>>>>>
>>>>>> -	qp->client_ready = true;
>>>>>> +	WRITE_ONCE(qp->client_ready, true);
>>>>>> +
>>>>>> +	/* Pairs with the barrier in ntb_transport_link_work(). */
>>>>>> +	smp_mb();
>>>>>>
>>>>>>  	ntb_transport_schedule_qp_link(qp, 0);
>>>>>>  }
>>>>>> --
>>>>>> 2.51.0
>>>>>>

