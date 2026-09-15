Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85BA43F8AC;
	Tue, 15 Sep 2026 18:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789496379; cv=none; b=YibVebyNfj0WHQApJadQK2CqJbe6Sel0adiUsOmHye2RW20h1/egac41uv8dqszW1zIiO2b4wfjv/YoBonFHMeZ6Vu1U7nHYgpAANlv1a5TZO1tXqB3/RYdrhNFZsvXaSfP/NWrLwJXWOniVtEGu6QZBiGnQjrsXFhUUUtk/q04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789496379; c=relaxed/simple;
	bh=R6Fj285BPwEpkycAqqCAY/fwy4FEvtptls2KuxpCxDc=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=CkfSMpwZ5+GhYnD3xLC8QsdJwiSArZD31Bzf61GkSWlmYieEH6MFkOikr8E2cVfN//JGc8Gk/xJ8KqLKVqmyqOqUUySvniaTmQ1JqLoyFkg0jGXlZ+oo0qlSHUBdDPF2gn6vispDuxqrrQf60nAsCS2Ip8kNZFZr0tclqusT+v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=ACjQyWhk; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="ACjQyWhk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=Uvc/MBahUmLWVUdCbl2g+qqo7UKmHw35CTl1g/UjwGA=; b=ACjQyWhkmxErXwgtiSYqnZllJj
	/gpuFBfX+LwX2ZhsPwNfG6gi75z+GP8SYmBNdJUg+YjFC/Ze/Zp/OkJxVBsBhrA0eiOKMJA96FGRr
	Rd+jKQi88DXsXPNlLmaWYN3Hxi+E1YDdUZgAra3k2DzXp9PvnZjV7J09LM1z5zTnStXn3N2MY99ze
	oghYPal7zG8e4eAf8tSFSl3JW2G8VD/gvyHl2JdQoYfV+p2M3/fWRujZyI0aCJyrD6ABhkOcOijgS
	FqcF7jwAssEiaHWjyuf2mJ1hvIE6MLQlifNSeK8y98cTvcS3JA1aXl2gN5TK+n16H/tc3m5OC828I
	ZOz+F2/A==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1x6Xkk-0000000AYVm-3xgE;
	Tue, 15 Sep 2026 12:19:35 -0600
Message-ID: <5abf1b4d-c8d8-4d54-8ed6-43b15d5f2c3d@deltatee.com>
Date: Tue, 15 Sep 2026 12:19:34 -0600
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Koichiro Den <den@valinux.co.jp>, Jon Mason <jdmason@kudzu.us>,
 Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>
Cc: Frank Li <Frank.Li@kernel.org>, fuyuanli <fuyuanli0722@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nicholas Bellinger <nab@linux-iscsi.org>,
 Joey Zhang <joey.zhang@microchip.com>, ntb@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260910040836.3792333-1-den@valinux.co.jp>
 <20260910040836.3792333-4-den@valinux.co.jp>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260910040836.3792333-4-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: den@valinux.co.jp, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, Frank.Li@kernel.org, fuyuanli0722@gmail.com, gregkh@linuxfoundation.org, nab@linux-iscsi.org, joey.zhang@microchip.com, ntb@lists.linux.dev, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH v2 03/14] NTB: ntb_transport: Avoid deadlock when
 cancelling link work
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-09-09 22:08, Koichiro Den wrote:
> During initial link setup, ntb_transport_link_work() can retry with
> nt->link_is_up still false. A retry can block on link_event_lock
> while cleanup holds it and waits in cancel_delayed_work_sync(),
> leading to deadlock.
> 
> Move the conditional cancellation outside link_event_lock, before
> QP cleanup. Keep QP cleanup and MW release under the lock so link
> work cannot restart QPs between them. Put the locking in
> ntb_transport_link_cleanup() to cover both worker and remove paths.
> 
> Fixes: 3db835dd8f9a ("ntb: Add mutex to make link_event_callback executed linearly.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
Even with the ordering issue discussed, I think this is an improvement
worth doing:

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
