Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC7B4C0402;
	Tue, 15 Sep 2026 18:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789497174; cv=none; b=Y/ZtkS80y+ElaweVVK5mKsn24DYh4OdJKTEmlKwQTzK+sNsXwGo0ak0MoOsu/SnqBn5ify8DosYnS9BlCe2aOcZ3x+3TnuVD/Wyt9QpAUjdL7jJSuccL9OMjB9WCRfiEwGXEnEp1UeofnTOR0OHd8j5lNlwDV1EOrrX4THpQK4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789497174; c=relaxed/simple;
	bh=EgzBLKCUnkweSJWDVgEv1PxAAoqnBZcApwNT3Easxwo=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=D8QXtCJmJOObdDtslyWE1/OshSOXf0IbVMqDf0hp6zRnlkq7+iUTKCIXM3xnKbsKoPFWWjcSYOmkkO3Oi7nZhMI3AaOqOEzfvxasRk0Jr3AMtbe+3VLH8KZbXw1RhhQkL9Uwvq8ChYsbE/FOvVX9U9+ojb/4oGXtYc+Or4TvcC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=HgmkCbv3; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="HgmkCbv3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=uOCSyC4CL237JyqkTpgbyJrO76YuQ0cImA4KOJ296Nk=; b=HgmkCbv3o9fsBkCowDzjEAERx6
	V4swtiPuHsa3yCPo+YuW9BVeqVfzbuWoQoJ+spdu8V0qbKuQFBybxjGCEZGtiUo6eygcwrwt/Z1zU
	JXpgOSdqenx7KtwBNpyQEbxikDAUE8l7/RqamJvDZdxCr6nw9cGJYcSELxgY+51ca6slwuc7PyPAI
	USFTDDl+UxT4KJQ3/GdWQF7LZQ0vZqPiz6vLOwD6y/V1u6GDB9TEcyyc//qRJ9i33oiBKiVJzPfTY
	gRQijuy/84lZRDiOyKsrGtxoTk/7zrb5VhhIh+54hPYjOWM499bQaToYhIl2ShF+4cxvMIyku8SHe
	Sugxx6tA==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1x6XxT-0000000AYbN-2IkP;
	Tue, 15 Sep 2026 12:32:44 -0600
Message-ID: <81897a7e-ae6d-4f19-a949-f70a0e27d417@deltatee.com>
Date: Tue, 15 Sep 2026 12:32:38 -0600
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
 <20260910040836.3792333-5-den@valinux.co.jp>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260910040836.3792333-5-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: den@valinux.co.jp, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, Frank.Li@kernel.org, fuyuanli0722@gmail.com, gregkh@linuxfoundation.org, nab@linux-iscsi.org, joey.zhang@microchip.com, ntb@lists.linux.dev, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH v2 04/14] NTB: ntb_transport: Publish link state after QP
 setup
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-09-09 22:08, Koichiro Den wrote:
> ntb_transport_link_work() marks the transport link up before setting
> up the QPs' MW and peer MSI state. A concurrent ntb_transport_link_up()
> can then queue QP link work, which may enable RX and notify the client
> before setup finishes.
> 
> Publish link_is_up with a release store after setting up all QPs,
> and use acquire loads before queuing QP link work.
> 
> Fixes: fce8a7bb5b4b ("PCI-Express Non-Transparent Bridge Support")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/r/anyKbq3mpLG4y7rb@SMW015318
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
