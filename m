Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795662997;
	b=MaxXBGzaUOPxJ3+rVmEjtYp5psavHQOQuSG7ZyW+GM/7G/+sniPx5aD+sb0reEW52xoC
	 IoW6hVJQbgKEthZZaJNtdDoUOujbUMJlEwxHR51VY2VdIWYJcZdt6TwSE/ukeAWz0uFQN
	 8qKtgt9apy/c3DdPakWMy+SG+Ki6lf1y4kOcU3vSLZyJIv8zEzX7Yh5RAdd1Peb8fdluU
	 tmChx7OTgJMlE6TRT8HEmaj4cEq4hDL3Qvm0UE8N9uhwaVNaoLgalWhvdst7MyomubIQj
	 8m0TBKjSYX70LKOCGVk3zH8woh2kLQJevt4/Jj7Gz9ClBROuh3/jqSjYLZO28X2Oc+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795662997;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=tcooh5ifHPPkIJoD1PmC/XnuN3ZG+rWbfWXyKgveikk=;
	b=3147mYluskyxn0AvbIUS8vtgo2TG3LePp5QL1cd9pXfEbB4k9EHxqlW+RvowhCYCiqTn
	 jqU6UOeLrNVTGm1vnFBGkYcmBqvqeiYiIgbcmuSGUWxuNdwOZWj9/AVyZCy52LmgDZQ40
	 7vww3a8FbdQ0veqXQ5ET2FvOJE8K1exBDxflaAeWkYjvYIRrhah9Fk4dsfueN3kgaFs2W
	 sXPKW8ZN51NtyvIWAkESL8EUbFe/kdXQS5Z9bI/EWIlNVeFaaeWjXt1moaJWty2wOcLFZ
	 L/btShmALASQ/rZe8cJfTxGfJ89urQVS4wzQt0tbWakBhKxWWs7Q8t/wBqYgl3+GIpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0l5yU49S;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A265E606A321
	for <ntb@lists.linux.dev>; Thu, 26 Nov 2026 03:16:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A265E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0l5yU49S
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4ac109a8a12so3796003f8f.3
        for <ntb@lists.linux.dev>; Wed, 25 Nov 2026 19:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795662995; x=1796267795; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tcooh5ifHPPkIJoD1PmC/XnuN3ZG+rWbfWXyKgveikk=;
        b=0l5yU49SfX+c7cI+v3c0ang0X08ASWuEieq3tsqSfi3CASH6OVzm9EtssDA09M4l5u
         oT1J0kHd+zMqqoX1gmLoanFZGlcgEHAgV7bdZWTGNDM+HFEluH4nU+zzK2IgSzVXUol7
         Ll9GhcBV4ftC0m9ESXAfAVUEbPY1zcZ4uCrzdYnzM8NaGBubyIyDaPm0gRvfLw4L4U67
         LbSKNcnC6o+PEAm+2TlZVEr/O07sti7Iua5aunC3jIukIqHui8SpHNMWaBlWp5EKDpXU
         avlgYkWqTGvLt4Zong8hveGSp3W2Rdbz3FHnHTFg5EoX2g6ZvHI9Cod6dkDRWEHPut4Q
         9YdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795662995; x=1796267795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tcooh5ifHPPkIJoD1PmC/XnuN3ZG+rWbfWXyKgveikk=;
        b=OyfJPEHyg34Sck/rsXbkRlq6z19IFDxJ2tx/L1RYPdJG4BJUIDSAdmZcgtWQ47FSft
         sRy5YwrW5tE+lfVFSZy1l1UsqkvZHF5e92VQudsErWXBPl01denjbdyfe4Tabi2ggW/9
         8OVfcruAb43q195ZgpZZ3cGx5GJcSVnMwe4vD3SBno9lSZCAQIA1Vr84oqqYCXz1FMPK
         hT+Z2y51hD4zGgmv9YJkw4i+MRbCVAlH8CVTzgsFK/HagF+otJw7w528k/n7V8msuDd/
         w1aLIr9zDEeiPuHTJRAtuCWquy1XrRpNIZdGm7RKfNv4YzOlJ6Kbsrw2d9mQYvcsh8KX
         wpKQ==
X-Gm-Message-State: APuU4Z/YPChBHeuKo2pbowauKRWej6JeB0Cem9zhQh9T9w9JvsPmLYaV
	AGXlbY5kdFGZoKK2gDFCNI+3HVwZnmj1dHVjto4H8RuGBtuBifjqrGUm
X-Gm-Gg: AZFdTZelLcKdB2jjJLBvwY/tnECKNDyQwE1W/O5O8c9zNnlDhQiSJx/q0FKmiLyniDN
	iMxnuEKfucBt6VT9XLBEtdRujlX4i71YdJKdbrqGODPRT3dHf0QX6xcIfTwr8hc4u7uK/XhzaKm
	FrUyDD04pxd6xd/nfUvFrUrMY46QRHGS+lKbasnMTi99YC4GCJewnQPIlkf0Zb4CePH0sSH1+xS
	dWUs5SkXStS/BuJoEbWZlyURoXJ+C1hTgHzwbaSjI7PStgR5ZsdOOB5DpOR53VNUkw0XPi09Dje
	Eu3j7HE5FWNCI0gyuFa+k47XS2qgN5gUstbn3p9zGegYjx/gA9CxTo6n/8BWWPgFEZc+ZMl/shA
	MA31/yvpwYfA1uDA1qeYlomr5cTTgJ8GLmlIZ7XOwygOKQrNaqVtbq7QcxhQCnJkRQEX4mcmg3J
	bDDESff3SeXyZa3aS0rEQ8QOUxXeJXHI7Ej/TKW5bi6CwRm5RIog9XLYSBv92uhIkC2zJUtrfwz
	7lwIKLh8j2cvtdplbJAQeHWbn64DpsdOclDpHtSqd+0P+MWIpTkU0iLffTdnrrHPR9lPOnoyjFH
	51rb4lp13PRSVY+6Hce/9nuVl15pwC2GT749MmHb9Xl4P9QT3Jqp3fmF249AHnE5yKcn6Of9Mkf
	TfhTY7WhsLDdm+trOP3EEYSK0kVIPCuB9ofL9e0klGxz4BV567PXVp+tiFqaKzRr3FXKP4cFtrj
	shDhW8u3LmAe5a
X-Received: by 2002:a05:6000:26ca:b0:4a7:1fca:e52b with SMTP id ffacd0b85a97d-4abb0e469damr39967504f8f.19.1795662995002;
        Wed, 25 Nov 2026 19:16:35 -0800 (PST)
Received: from localhost.localdomain ([31.223.101.75])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c340df4sm43323619f8f.55.2026.11.25.19.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 19:16:34 -0800 (PST)
From: Oguzhan KAYNAK <kaynak.oguzhan0@gmail.com>
To: regressions@lists.linux.dev
Cc: ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>
Subject: Re: [PATCH] ntb: ntb_tool: accept hexadecimal addresses in peer_mw_trans again
Date: Thu, 26 Nov 2026 06:16:25 +0300
Message-Id: <20261126031625.166614-1-kaynak.oguzhan0@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261126031506.165973-1-kaynak.oguzhan0@gmail.com>
References: <20261126031506.165973-1-kaynak.oguzhan0@gmail.com>
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Post: <mailto:ntb@lists.linux.dev>
List-Help: <mailto:ntb+help@lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
List-Owner: <mailto:ntb+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#regzbot introduced: 21fbdc4d0b1e
