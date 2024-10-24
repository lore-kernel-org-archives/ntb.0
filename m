Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349FE1F893B
	for <ntb@lists.linux.dev>; Thu, 24 Oct 2024 16:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729789125; cv=none; b=G7eoKLrPB5OZ49o5kAVNv19bnmUwyh+vT6It3cJYAj/xQVEDT4oij6sPlQYI6lBvMhBrL2NDpHaH6c2k/ezIMzlFK+vGvt4PFYEUZSvE5rttB+jRYsfxH4OqS67FUylo6XPKTbu7M6NreW8EtFrxYtYLIhIaCWkYlAsIrZj6pjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729789125; c=relaxed/simple;
	bh=LQUqq41rKKi2DZ6ziCnRzGqwgHnRtqlW6CGDMmHRRV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KGQrBwInP+7O6ZC04BeGBenD9agI/00MRmAD/858NYwn1Hw6qefFKkwusvioK745UQTx0fmpW5jjHJd4PIkx1W8WXFfilymkgzcZNXohV+SnXQ25Kmp1brADGXlsRCBZ3DT4Tim+iieHtM4u2qyZ8zG5vfb9vzWgqEYuhVr6bHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gAd9DCre; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAd9DCre"
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-71e67d12d04so875942b3a.1
        for <ntb@lists.linux.dev>; Thu, 24 Oct 2024 09:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729789122; x=1730393922; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xfJ8p+8q2+xxwuBNnMevVX62Z8jej5Rz7JLXYkmoeTk=;
        b=gAd9DCrelwxgbhLP5LgZfqqfklmwNptk4AKUk3l5nvpzNhsrVReiDDgNImnfNkb8q5
         z07/kUN7aSyr3EyMpXt/pc+fsG1R6Ul9iWk8QURKnrkRvfqeptcJ9D3/IVwbrP6mobVl
         66LMERKYOGHkOQUi1nifxv4YoIX1HjFc8hgySyaE7IHHg/9wGKIw/RaweME/0/N3ZEXT
         lFXhu4VmbcbEWK0wGEhDrefkFsbHpsF7nL7sZRV7cYY4lwYWj7hKc9VC0VS6f8CgqN5j
         CVoozLsXPhq+kQot1PC0RIz3MwnBBoKw6tQQUSAI/2/idHe5M5gLTouamiSMBz8zjBb8
         APtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729789122; x=1730393922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xfJ8p+8q2+xxwuBNnMevVX62Z8jej5Rz7JLXYkmoeTk=;
        b=Wtcn/iajvcB2S2fVNFTU1jRoSP4DJ4CgVejzy1xLSlFxqR/H/Gy3znJcGd/0IhGzZN
         dP+62it+HdQyvL3Hc3tooc0rMV1cfKV75+y6Fdi1PoFp21PUKCTpv1vN1crxnDFDcR98
         ugDEGIuyd5HQCl8/XEgjS+Zy/skh1wnOZYC3XNkSpPgJ1SZuorez+5j/I+5i1WXo2ea/
         wusJMcY8iepD53Xeic5WTN3XT8h2SOySdVtw7F6Ox0+BQjl/H+G3oFD7EZfs+VWYo+4C
         +HtG9BmBEyus72+OcJjs9FFq7sGYDvMVN6eyULyNwafXXAAIgYJF2cVHrYEOkLitg0Tl
         J9fQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMDCxLDIzBbpnuOed4TSK38cCYtVBwcdoadyTAbv/B6nfM7WEq6ofzQgonpy+1etPHEGY=@lists.linux.dev
X-Gm-Message-State: AOJu0YxGHOPcw+0953/ODlPia8ZUhDoNF5G28R4ZGMp3NQGM7hRNA/HZ
	6nJHCmoUYCGrst3KQWW8Tz0be98eX3+vbzR3Wj/ofQcF2TX7bnVc
X-Google-Smtp-Source: AGHT+IHkRrL+646WJX5jMNiRVOq7St1d5iL/wDNXUA9UQNOX6Gcj9xqgJzmbGWgDaCdtnMTv+h1KbQ==
X-Received: by 2002:a05:6a21:4a4c:b0:1d9:175a:c2ba with SMTP id adf61e73a8af0-1d978b0245fmr8971311637.20.1729789122186;
        Thu, 24 Oct 2024 09:58:42 -0700 (PDT)
Received: from localhost.localdomain ([240b:4001:20c:6000::1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec132ffdcsm8203615b3a.46.2024.10.24.09.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 09:58:41 -0700 (PDT)
From: Hantong Chen <cxwdyx620@gmail.com>
To: james.bottomley@hansenpartnership.com
Cc: ajhalaney@gmail.com,
	allenbh@gmail.com,
	andrew@lunn.ch,
	andriy.shevchenko@linux.intel.com,
	andy@kernel.org,
	arnd@arndb.de,
	bhelgaas@google.com,
	bp@alien8.de,
	broonie@kernel.org,
	cai.huoqing@linux.dev,
	dave.jiang@intel.com,
	davem@davemloft.net,
	dlemoal@kernel.org,
	dmaengine@vger.kernel.org,
	dushistov@mail.ru,
	fancer.lancer@gmail.com,
	geert@linux-m68k.org,
	gregkh@linuxfoundation.org,
	ink@jurassic.park.msu.ru,
	jdmason@kudzu.us,
	jiaxun.yang@flygoat.com,
	keguang.zhang@gmail.com,
	kory.maincent@bootlin.com,
	krzk@kernel.org,
	kuba@kernel.org,
	linux-edac@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux@armlinux.org.uk,
	linux@roeck-us.net,
	manivannan.sadhasivam@linaro.org,
	netdev@vger.kernel.org,
	nikita.shubin@maquefel.me,
	nikita@trvn.ru,
	ntb@lists.linux.dev,
	olteanv@gmail.com,
	pabeni@redhat.com,
	paulburton@kernel.org,
	robh@kernel.org,
	s.shtylyov@omp.ru,
	sergio.paracuellos@gmail.com,
	shc_work@mail.ru,
	siyanteng@loongson.cn,
	tsbogend@alpha.franken.de,
	xeb@mail.ru,
	yoshihiro.shimoda.uh@renesas.com
Subject: Re: linux: Goodbye from a Linux community volunteer
Date: Thu, 24 Oct 2024 16:56:50 +0000
Message-ID: <20241024165650.174-1-cxwdyx620@gmail.com>
X-Mailer: git-send-email 2.47.0.windows.1
In-Reply-To: <e7d548a7fc835f9f3c9cb2e5ed97dfdfa164813f.camel@HansenPartnership.com>
References: <e7d548a7fc835f9f3c9cb2e5ed97dfdfa164813f.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> If you haven't heard of Russian sanctions yet, you should try to read=0D
> the news some day.  And by "news", I don't mean Russian=0D
> state-sponsored spam.=0D
=0D
> As to sending me a revert patch - please use whatever mush you call=0D
> brains. I'm Finnish. Did you think I'd be *supporting* Russian=0D
> aggression? Apparently it's not just lack of real news, it's lack of=0D
> history knowledge too.=0D
=0D
Hi James,=0D
=0D
Here's what Linus has said, and it's more than just "sanction."=0D
=0D
Moreover, we have to remove any maintainers who come from the following cou=
ntries or regions, as they are listed in *Countries of Particular Concern* =
and are subject to impending sanctions:=0D
=0D
- Burma, People=E2=80=99s Republic of China, Cuba, Eritrea, Iran, the Democ=
ratic People=E2=80=99s Republic of Korea, Nicaragua, Pakistan, Russia, Saud=
i Arabia, Tajikistan, and Turkmenistan.=0D
- Algeria, Azerbaijan, the Central African Republic, Comoros, and Vietnam.=
=0D
=0D
For People=E2=80=99s Republic of China, there are about 500 entities that a=
re on the U.S. OFAC SDN / non-SDN lists, especially HUAWEI, which is one of=
 the most active employers from versions 5.16 through 6.1, according to sta=
tistics. This is unacceptable, and we must take immediate action to address=
 it, with the **same** reason.=0D
=0D
On 10/24/24 10:50 AM, James Bottomley wrote:=0D
> On Thu, 2024-10-24 at 07:27 +0300, Serge Semin wrote:=0D
>> Hello Linux-kernel community,=0D
>>=0D
>> I am sure you have already heard the news caused by the recent Greg'=0D
>> commit 6e90b675cf942e ("MAINTAINERS: Remove some entries due to=0D
>> various compliance requirements."). As you may have noticed the=0D
>> change concerned some of the Ru-related developers removal from the=0D
>> list of the official kernel maintainers, including me.=0D
>>=0D
>> The community members rightly noted that the _quite_ short commit log=0D
>> contained very vague terms with no explicit change justification. No=0D
>> matter how hard I tried to get more details about the reason, alas=0D
>> the senior maintainer I was discussing the matter with haven't given=0D
>> an explanation to what compliance requirements that was.=0D
> =0D
> Please accept all of our apologies for the way this was handled.  A=0D
> summary of the legal advice the kernel is operating under is=0D
> =0D
>     If your company is on the U.S. OFAC SDN lists, subject to an OFAC=0D
>     sanctions program, or owned/controlled by a company on the list, our=
=0D
>     ability to collaborate with you will be subject to restrictions, and=
=0D
>     you cannot be in the MAINTAINERS file.=0D
> =0D
> Anyone who wishes to can query the list here:=0D
> =0D
> https://sanctionssearch.ofac.treas.gov/=0D
> =0D
> In your specific case, the problem is your employer is on that list.=0D
> If there's been a mistake and your employer isn't on the list, that's=0D
> the documentation Greg is looking for.=0D
> =0D
> I would also like to thank you for all your past contributions and if=0D
> you (or anyone else) would like an entry in the credit file, I'm happy=0D
> to shepherd it for you if you send me what you'd like.=0D
> =0D
> Again, we're really sorry it's come to this, but all of the Linux=0D
> infrastructure and a lot of its maintainers are in the US and we can't=0D
> ignore the requirements of US law.  We are hoping that this action=0D
> alone will be sufficient to satisfy the US Treasury department in=0D
> charge of sanctions and we won't also have to remove any existing=0D
> patches.=0D
> =0D
> Regards,=0D
> =0D
> James Bottomley=0D
> =0D
