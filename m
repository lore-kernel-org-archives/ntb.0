Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795794558;
	b=oARbm+jusisRD/SbMLy+aelIwhdXh1Hu/UCvZHdVyqcpB9JMytPZD5VL1pNJkwsC6FNz
	 BBW/hmIEARHU1UCRnyMM/8gOVAlNPUlOzC865lmt4nG68zEKVkpfXakli8O/myFLiBHq0
	 SBD+SSK4fS92FIsYNpyYlYloRfpfTLX25r6ILve+UFWhFUGKIf4PiZolCf//tEqSdQvt2
	 pD94ySZJJ0EI5XWmdILDlJdLeMrfKYM7SdwgaKpvo08+1cbLMVMBGiK6PoH/Qr5GLvr77
	 2OD+83ymZPB+YwNQz4ilddKExPh8bkFYDeWalXagTTEmppmFh7kn2SyNeSXJLDRy0PQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795794558;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=pm/8tep73L9V4TMW2Ch55CTSshK2JxETa/tNsbYXksY=;
	b=DfXXYyH+ZzXqUt5R+mRfJgEFkDSn8orjQ18txTUsXevcSnsSXeN3gOlxVBQXQW0gUQaE
	 /DITC6ufui7HaUzaLg/ONuSPDEvyc/lBVf6W/qinHtLK5HPzo8JhEkC4lQQfMTjdXHPfa
	 8hdNBTbKBSs3+0MO2WWmEhQWeYZV2yUD4nBanzMgAE5MGIkigwwqlRkCinErwol1ktyW2
	 wP0EjldR7KuQnYoJVWB8BB7lZMu3C0SJ1clkoydr7u5AO/M9fRvTk6cyxfwYSqqewGxff
	 E7XidyVL8Nj5BxxssyQF8ezhyAvLjeyQyugd5suxaaJm8hna5TSBnKCgKtUeOf8s0Eg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E9UhvXUS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.173
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698F5606A321
	for <ntb@lists.linux.dev>; Fri, 27 Nov 2026 15:49:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 698F5606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E9UhvXUS
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-536c8f958d7so62285791cf.1
        for <ntb@lists.linux.dev>; Fri, 27 Nov 2026 07:49:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795794557; cv=none;
        d=google.com; s=arc-20260327;
        b=H+4LydIoRKeu4sRBDx6BcgUh4jY2Ejooh81BmqNCvEvmGE8FdQFbU5sa8TiVijKzsX
         AlqhmUsNsZqLtaY3cCOSDX6LIhFEMLPyFLrYenkDUay51c8XSB//1e26knTVstdejsrG
         InezdNecjnErqo669Yix05bJ6a4KqznkCArXB6sVGQ/kRj+UD0OCYjAi4fmSi/pGNV8l
         pz36k5XMcebUEaCGRCq6/B4DWJ2TdTvIenNydQK7Upf0ud26Pc1oeUSJhoIT/yUKvcky
         HC4O7Q3Ngjk51VzG9dXwBix9JgSy5queIk1XMrd53ljBhrwl6iBk24+5uBQVrMkD8DVA
         ybvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pm/8tep73L9V4TMW2Ch55CTSshK2JxETa/tNsbYXksY=;
        fh=mVHtmtWzVMLlQ5Rj8LtKNljLSSFuyN3J0hIxPiG05fw=;
        b=PGWf6Y8qaRDttuawNq5QyTaPuMl2aaOIRAuU8szmINgeN+zibBsmwsH0a+piHApFw2
         5asxamFYThPvWA1pB4qSo+sVVqK0ZsrTVrVw6od0BxWUZ81gAxyi8diP1qysjwhge3qb
         EElY7ltRfx6Los0TSlHkClQRQyuzmLyCzHQviMmL+qnlfcEh9jprSeSyKI38nFgl954T
         CVZMLL6GO9DKj3yeEXiZWU1enn/VyE/Ej3QLl4u7R0qoMinnVSsNBGK93/vxcpMVMqE8
         yGwMmOkP5MmHUDNA+hkxDIl0cY+IxpzlAaLMbhO+h89pE1bf0X6lZdf+Hz7n1L+yFo9N
         4Ghw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795794557; x=1796399357; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pm/8tep73L9V4TMW2Ch55CTSshK2JxETa/tNsbYXksY=;
        b=E9UhvXUS+uvLG4YB50GFMium22LZANKyb7ApIvEs0hmIFfIo6+AxAYCC8nMZlr3tjH
         QZtMRPKpzfW+pfIK0XMlzm7x2zLqOMUAqsFIQU0uTJd+r2Vaoi0nNwoQaPTnurmvPMaF
         vNWCfkeX/lsurGxqOU+KUx688LZvO8gogKdRe0HLYW99N/GAKM0W0KZtZc9gCA1uPUgg
         4DuPFOOabAlzsVYKvXOcfTkHBtyDGxZ0XdywYGPNeZUfy4a4KE9+riC9yj0o5wPhusJU
         DRLZemz8AvSrwtV8HXIxsJF1QPyF7LRwldvLwQqN1bpEUYfY1orPM/URWdSDNEyjSDbx
         /W3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795794557; x=1796399357;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pm/8tep73L9V4TMW2Ch55CTSshK2JxETa/tNsbYXksY=;
        b=XBxjutvG/Wpad88L0BxbxQtylBhxEWdgwiEOlayj3hMeo8lzedzlaYreM31RhRidqx
         RTUrQ17zCSq4oZCkS6+MsMPpnGn8OvT7ukbf6E5ZY6FEd2FL7jp+Aj2uPpNAqgd0t/Hn
         DiCJuWkPIvW/KSpls+CP+1u5+GSy1J3CxSAtdr8J+CHT/umyrlhXktXWk3Qr8nP4bJ52
         qphm6jsXUah/51JelPRfmKfCj7g0gjoIc4ahEJ0BFCG+8T3P/kmaEkanOKl7w5PUd8l7
         RgS75COEaTy8apvPZ4PP6vnDPZJxq3QHfVZfOG0ztW9IAJHyS8RqX62BUUJOPPIktUpr
         kmTA==
X-Forwarded-Encrypted: i=1; AL+hErGezb+ddoJIdSUOWA5Hs9wgTXhSVTUpCqhDUn3onygJAGFKTWTeAq5db7RXlzpDuqsp7S4=@lists.linux.dev
X-Gm-Message-State: APuU4Z+jGabwQUZTX1Bk+2wbVgu/ht8viC08cNovF3scnPXqO/lL1I7x
	7aNp4B+b4LOdB76z90P1i+kTSJgvKM8k6fJmQmd9HiOFiGS68EIGJA8+oFr9hEHh8Iwmdq0L69T
	qwosuh6pClIFRdQTsMHD7pDzrKGkhk7w=
X-Gm-Gg: AZFdTZdns3x1SAfxnsFRsH6VdTWiBwy6uB9nGxa5Sib9aegQrnf3pO9o+ZIBQKSqHG8
	2Nx0AJfS3l6uXpAgHaNB13sRDgFIy6A6C0TaV75RneAgOaZ2OGoS85qxk93I4IqJv1poNXUbJcc
	ImPtnamAC7f8+y3rHwypne0Auyjds5Rv7A/PJGMoEttB3OEm0Cg4dGkvdDD2x1QbOy/biBCMjSF
	Lxvpmd8ZxxAzcI1i9HfS5coyT0sW7/JZ22FuFK0YxSxxHvmxD2mACq6UCAywsJ1i3yELswauJWf
	rBbJwZETKDy3wtXAIhlzQhgXxUnzS0sN7seMeuj/F0QbzvVz9heeyR9TfZwHnr4fUdiOM1DOI/8
	7HyE0V6ekpkGwUShbreZiS6gM1WefTvKvEacThDtPVe8/iaqqqzpai9CpQ+0uqWmYvMzzz/UEYf
	7yce2dW75vHHhEVO8Adl3x9J2lkjZotphfwpFSVKH53Xnn2p3xSGCyd+LETwRyCvgzsINRggG6I
	n2xKDUzIefBWNVizs0KeORy7kr5L1Cc2A==
X-Received: by 2002:ac8:5754:0:b0:535:a5fa:edff with SMTP id
 d75a77b69052e-55d76a59807mr476389711cf.63.1795794557235; Fri, 27 Nov 2026
 07:49:17 -0800 (PST)
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Post: <mailto:ntb@lists.linux.dev>
List-Help: <mailto:ntb+help@lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
List-Owner: <mailto:ntb+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261126031506.165973-1-kaynak.oguzhan0@gmail.com> <awkzEjrVEz2jB1Ma@z790sl>
In-Reply-To: <awkzEjrVEz2jB1Ma@z790sl>
From: =?UTF-8?Q?O=C4=9Fuzhan_Kaynak?= <kaynak.oguzhan0@gmail.com>
Date: Fri, 27 Nov 2026 18:49:05 +0300
X-Gm-Features: Aa3M54oG8qNSkma9SYEe5bEWuLV762AYfcjKVO9GWl8LUMyf097tEckGvgVUriY
Message-ID: <CAAKAQ7KpM5hT-Q0mdJr-0VnHy1DeFBoODjYM-FCoXiS+5DW+cA@mail.gmail.com>
Subject: Re: [PATCH] ntb: ntb_tool: accept hexadecimal addresses in
 peer_mw_trans again
To: Koichiro Den <den@valinux.co.jp>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, ntb@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, regressions@lists.linux.dev, 
	yangqixiao <yangqixiao@inspur.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Koichiro Den <den@valinux.co.jp>, 27 Kas 2026 Cum, 11:01 tarihinde =C5=9Fun=
u yazd=C4=B1:
>
> On Thu, Nov 26, 2026 at 06:15:06AM +0300, Oguzhan KAYNAK wrote:
> > -     n =3D sscanf(buf, "%llu:%zu", &addr, &wsize);
> > +     n =3D sscanf(buf, "%lli:%zu", &addr, &wsize);
>
> Just to clarify, do we have any rule about negative values for the addres=
s part,
> like in "-1:4096"? 21fbdc4d0b1e mentions "-1" as a possible input for the=
 size
> part, but doesn't mention it for the address part. (For either part, "-1"=
 is
> really odd, but that's not the point.) As you mention, your patch starts
> accepting it for the address part again. Perhaps we should keep rejecting=
 it
> there?
>
> If so, to cover the cases broguht up so far, perhaps it would be an optio=
n to
> split the input at ":" with strsep() and use kstrtou64() with base 0 for =
the
> address?

Good point, thanks. A negative address was rejected before my patch,
so it should stay that way. v2 does what you suggested: strsep() at ':'
and kstrtou64() with base 0 for the address. I did not carry your
Reviewed-by over, since the code changed.

v2: https://lore.kernel.org/all/20261127154157.3541-1-kaynak.oguzhan0@gmail=
.com/

Oguzhan
