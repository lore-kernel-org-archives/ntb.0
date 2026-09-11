Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC0D3C4555
	for <ntb@lists.linux.dev>; Fri, 11 Sep 2026 09:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789120079; cv=none; b=o6yZ/sbI5sJS2YEsoGvzKpcm8ulVjMPgoMafUKSuEQyPymdfKf0LKJuLnl1r4ljMLic5IwQv0wk7zGUTo/jGqY8PlKivwGyHyl8EjZBVI4Je06SrZzEOdInpiuLXMnjrAtfAzxMzfUi9mcbHURKDDcbTggXJtI7s8xueeuXtCzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789120079; c=relaxed/simple;
	bh=EFFfHYsrmwIYMEV6RQH7YCLFN9Vsj9EpQRZAIMPblLA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pRx7YDO3XozQe71f23CwRYleXLSNjeSV9lHgPasukc8g9Mi5W/QVf2vEBPY1SYgJhYz100n31OOD/R8UuVWTZRTmnvhye7H6suHtPZQRic8lGN7fWy10pfDEtTCCXjHG42mOu/US6Hl32OYCKlYmwKntXlkzySYrwpzAsa9PPQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ren2KgEx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ren2KgEx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789120076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=45A6Zdox+gTv7MNeziUH9YCoinVqVVTAj3654cxY4Zc=;
	b=Ren2KgExQ6wWGupqCBahqlII4Vui3vpmhtw3HW4A33fJItBAUMle6jedrjEJzzcRn2aptn
	lgHjsz6GQIb/NqhBoCNy3KgVwkSa3iCjEq9JgcQGV2dx4ICA/W9EPj139WEfbHfU+PlNnc
	TFnO+7Moy/00I5eA3CSFHkmozjEPfPw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-5vE-uFe7MQa28anhqmmWRA-1; Fri, 11 Sep 2026 05:47:55 -0400
X-MC-Unique: 5vE-uFe7MQa28anhqmmWRA-1
X-Mimecast-MFC-AGG-ID: 5vE-uFe7MQa28anhqmmWRA_1789120074
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49564d4b849so2312335e9.3
        for <ntb@lists.linux.dev>; Fri, 11 Sep 2026 02:47:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789120074; x=1789724874;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=45A6Zdox+gTv7MNeziUH9YCoinVqVVTAj3654cxY4Zc=;
        b=Qcc8AJKbETA6kOccTV9s5p9BG56eJNBWajsUwngejEl8iAxmTIxb8rAe+PZ1pwGjqO
         491Hu1F5ssTUpBY4RF581JA/7eHYFI+cOrwPw6wp80gezG9DIxa4Rl6cUBIUwMnVZ/mZ
         3/keYAjRYemW4oazAnjPlyOotIhuUWtLpXA9xsd1RlwfAETgkvA94DrqtqqtJgw3pyqG
         7fjmQHZXOF30MJ0zQL0QyRHCPz4nNAppYxgUurU2UWLuykIfGd3MGr6xoKQbMhfEuQUm
         Hb8uDO2fQFEMjWp70Y921xj21jl00DVvRz8yEYE61ioTUnqAkzqTsUuJwusIZGVatC8j
         0zUw==
X-Forwarded-Encrypted: i=1; AKwUvBz0WcuLZkG6dhQAUzaW9aEYtY+/9hr2gK4WzrE/4lQKtXgU2j3txhejh5XfQ2RQFZIDUWs=@lists.linux.dev
X-Gm-Message-State: AFuF++kLClIlCotBGm+lj3MK17fwA8mKE/VmnqpZje/JoW6sm4UJyr6t
	SZ2KEFIV+0Z+ilNcAajSczu5RrE3vis+yC/fNQJ8eNaiHmQtCZkasuZqd3lTzDG+c0rN+6jd9A5
	idkLNCJPCvNIx2yozLMRtLliEQeFHAt3Hjp+KxpCk/SVx2jjP/dVusQ==
X-Gm-Gg: AYBFou3mHs6XszsUe7s0FP3A/BhO75/nOGr1PzfON8/6LxIPsefYMcgWlziR/SZc/cE
	2SRy/JbsldOHwFhGz3GJliqVt8743nyjL1KFRofcPUCZMNjrBx9nnHN2iQUq0Rh9x6Jo5URFavt
	iOA5+8XkSqpXLTnlyKSEX0pO99xrMKbtxWF26A4rxY4hANA9vMuVsCkFDZLoQvWwfvjbyL5g2oR
	laQowRDB+rROOnsCY0OsWQ4tSBKu+j6vgC1hC6IFgZVs8IpQT+ROLhoJfu4u+2xIABqlYGRHiJW
	e1DAbTibeVCtRITewLQZ7k/kKC2RNlQSm9ejPDjjdQkde/iIBXZ3R4XC3ZPl3/D3pi3P/LdVAD5
	dZkMzHIsb7A/McOCMOZCNf5BQcw0VwfuFlHCbF9zO7ZhIIGHZwOcKvpz6jCkN/Quxw8eC9f1gJw
	==
X-Received: by 2002:a05:600c:6296:b0:49d:191b:88be with SMTP id 5b1f17b1804b1-49e6164a26dmr36765765e9.0.1789120074360;
        Fri, 11 Sep 2026 02:47:54 -0700 (PDT)
X-Received: by 2002:a05:600c:6296:b0:49d:191b:88be with SMTP id 5b1f17b1804b1-49e6164a26dmr36765335e9.0.1789120073956;
        Fri, 11 Sep 2026 02:47:53 -0700 (PDT)
Received: from [192.168.188.218] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb32e6f1sm4703455f8f.6.2026.09.11.02.47.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2026 02:47:53 -0700 (PDT)
Message-ID: <9ba2c3d5-825d-4494-a0c6-d5c0ac699189@redhat.com>
Date: Fri, 11 Sep 2026 11:47:52 +0200
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 4/4] net: ntb_netdev: Preserve
 CHECKSUM_PARTIAL across NTB
To: Jakub Kicinski <kuba@kernel.org>, Koichiro Den <den@valinux.co.jp>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
 Allen Hubbe <allenbh@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 ntb@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260904052134.2970111-1-den@valinux.co.jp>
 <20260904052134.2970111-5-den@valinux.co.jp>
 <20260910172047.167225eb@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260910172047.167225eb@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EbWp9RdDpZ1ci0fjqV1OrBzwyRjuer1s77s-noq9t2g_1789120074
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/11/26 2:20 AM, Jakub Kicinski wrote:
> On Fri,  4 Sep 2026 14:21:34 +0900 Koichiro Den wrote:
>> Calculating L4 checksums can limit ntb_netdev throughput especially on
>> embedded systems, where CPU resources are often limited. A trusted PCIe
>> fabric can avoid that work.
> 
> Would it make more sense to prepend something like a virtio_net_hdr
> to the data so you can cheaply express more offloads?

FTR, I think it makes sense to consolidate similar code, with one possible
caveat: virtio_net is not spectacularly flexible in term of supporting
"new" stuff: if this use-case would need some special behavior, it could
be problematic.

AFAICS the intended usage is quite basic, so no big surprise expected, and
also I guess that only a serious attempt could tell...

/P

