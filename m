Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C70B1EE7BD
	for <ntb@lists.linux.dev>; Mon,  3 Mar 2025 08:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740989548; cv=none; b=mD6fyhV9LIXVi9ojG8NHOHM7BgNL91ivZaZ37kMq+bMehv1LfEJIfihUlM4pxi9Ch0vPdSYYbl2lW7KaHXBfBg8Nf3qGZh8g6p0S5CojLi3/TUU13a48afPwxwINcpjqOA3n+T3jjvRAn54jK1kqhHX9dGFgjsebQtW9S0WyRRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740989548; c=relaxed/simple;
	bh=utsIiQdOJJDP22E5o7iDxgdMdHpa+WRBtmWN3u2c4r4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i/qOk1gDeNDCiv1zKeRgg3tfnIT0ZH7cyeY/nM8yPFFRO+AkhA7dmLw3No0nlnjmU0hU4iwJIVYKsNmPfwCtC4s9WfjKXHixIa5wP6oHUI3UASRxmzJHwu3JzvvolZiuDwtE/YsSdzsO+SumH1fHc6sk8cxP/5m9c6RvIAKJYnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=RNbMjx05; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f4gEZxhd; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="RNbMjx05";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f4gEZxhd"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 166D0254019E;
	Mon,  3 Mar 2025 03:12:24 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 03 Mar 2025 03:12:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740989543;
	 x=1741075943; bh=UWMQhsvv7vaswlhvcqrNGr/tcCrEOs4DRZkM/bLoGkk=; b=
	RNbMjx05oT5sTObudoDkPn7iD2XLBQAVFYMNTthpRbax2wicfg1amLJftLPeYJm1
	UcdxaUUMYE2SXIsa/O5aeeLh4rngq1UIWPkfRTrnM4uJ5InwU/Kdvxlke0fNKVEJ
	a1Hd3CVLbuS7KlzPg+7Sg/c82qaQcokjNzUbkPFZWzrGyxHefui6xkreuTWG8jRk
	/96QuvGNO5z4XSOT/h9LME9fyUDNONzOGBs401csjMa6Xw3YKtvQm75tdLP/YsqY
	9/w6A1IrUb+Aa+HN4Z6GG9i9+klkbnl1vf/Jo5NjCdj/CC1O4UPE6D30V8c6j2e7
	Z2mVUyD4tLgUMFTvXIbQRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740989543; x=
	1741075943; bh=UWMQhsvv7vaswlhvcqrNGr/tcCrEOs4DRZkM/bLoGkk=; b=f
	4gEZxhdvn/0pGIQzlbPs0NBalu/JTl65LPzbj1OYWd6tnwVyAplfoF3KFeHxuAfI
	4qzq5qAybx0dWWaO3Y4D9NtnSyaQY6z8+qN6ns+uXlFi1PmvZAsRghll+iyWjKr+
	7Tz41p8AY29qZYxtuHK1UWDL6tDg9btfhfMa+mO9mE80frvleCf/d0B2dMzO/lM+
	CDz3TtzMez3qsr2SL4FGOid8MdwoDG8lNhylPH+pmoujWPtGKQ+CVYcssy2r0Qzj
	fdP3HN/ixT8pYlY+BTYNnojYKuusupuOjUZvRrSZbEpG9gYHSPGtUmXc9X9W2vSQ
	cF36zHevbtLnE/8E3+rAA==
X-ME-Sender: <xms:Z2TFZ9KcDxjQM2Ung1ikyOn6QEEG_LV_wcSvgM9KGgN9cBg_VjMikg>
    <xme:Z2TFZ5KNGDs0PPP2FCa8KaRQPnA06hETxvqSOW88AQAFUKugKRttnYE9Nqxl1kP5R
    tmAgKJegD2LbA>
X-ME-Received: <xmr:Z2TFZ1vLnU7HXgw3xlnMXFxtDSbELuaAKy_slq8qk64cDqS7S_2WxauwQ9rETPTZokoKrxXaX8gpoevRTxKY9pHl10w3dRoOBIQrog>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelkeeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    udenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecugg
    ftrfgrthhtvghrnhepleehheduudeugeegjefgheeuudffheevueekgfekueefledtjeet
    ieeutdekkeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepghhrvghgsehkrhhorghhrdgtohhmpdhnsggprhgtphhtthhopedutddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepsggvnhesuggvtggruggvnhhtrdhorhhgrdhukh
    dprhgtphhtthhopegurghvvgdrjhhirghnghesihhnthgvlhdrtghomhdprhgtphhtthho
    pehruhgrnhhjihhnjhhivgeshhhurgifvghirdgtohhmpdhrtghpthhtoheptghvvgeskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepnhhtsgeslhhishhtshdrlhhinhhugidruggv
    vh
X-ME-Proxy: <xmx:Z2TFZ-bDquQxkmKfwfFZPb3TFzmRsOzy-w82h-h8Q9mE41qENo8cnA>
    <xmx:Z2TFZ0bRARHPLOs_a6OBoShxtDaTQ_Tayctl1YMqNrqy9SFSTvY8Kg>
    <xmx:Z2TFZyCbOQFTUrLFkw81PpIA9rmVv8NI0uqfbutIfEYbxeJj0AdQkA>
    <xmx:Z2TFZyZeA3syEwltJoZcNkexmte3bjY5SLPObYUapqiNHzzxt--jFA>
    <xmx:Z2TFZxRBN_k84w_k_ZFkuQe0sX-8spSNbRf4BGbHGsOgx5Sl3lZ2RmYb>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 03:12:22 -0500 (EST)
Date: Mon, 3 Mar 2025 09:11:09 +0100
From: Greg KH <greg@kroah.com>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: Dave Jiang <dave.jiang@intel.com>, Jinjie Ruan <ruanjinjie@huawei.com>,
	cve@kernel.org, ntb@lists.linux.dev
Subject: Re: CVE-2023-52917: ntb: intel: Fix the NULL vs IS_ERR() bug for
 debugfs_create_dir()
Message-ID: <2025030302-schematic-deepness-6259@gregkh>
References: <2a7a7b63272bb7e316560937c2398cff9d046ab7.camel@decadent.org.uk>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2a7a7b63272bb7e316560937c2398cff9d046ab7.camel@decadent.org.uk>

On Sun, Mar 02, 2025 at 06:18:21PM +0100, Ben Hutchings wrote:
> Hi all,
> 
> CVE-2023-52917 is supposed to be fixed by commit e229897d373a "ntb:
> intel: Fix the NULL vs IS_ERR() bug for debugfs_create_dir()", but I
> think this assignment should be rejected.
> 
> While it's usually a bug to use an error-pointer as a function argument,
> and such bugs may be exploitable for denial-of-service, the debugfs file
> creation functions are specifically intended to accept an error-pointer
> as a parent pointer and they do nothing in that case.  Therefore there
> was no security flaw to be fixed.

Now rejected, thanks.

greg k-h
