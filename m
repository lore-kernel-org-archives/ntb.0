Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4013451C6
	for <ntb@lists.linux.dev>; Wed, 10 Jun 2026 17:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781110954; cv=none; b=lOFmFOGbIwBcMixgOMB6KDpA4i9VfHvSy3NxXpKiNWa4k6Gk2jugcgsMs20wU413sVAKwQ5ek1/h35kxfEGJ3WNgJP/TIQiOYWXQf3EndODIGZBinxuAwn0JXceJlldFZvWb6z9ULPc+rl6oMO+Cxmpg7a6yV4RWQ63zW2nlZfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781110954; c=relaxed/simple;
	bh=MpKanxyD8Q34gT2P3ws5K1aQChI//2GIo3z4IZKKF+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZB2neBai7UmSo5/y50WZ/ki40ugdVQfw5Jz0/1YSoNT3Sl48LbC4MjFCKQvWNmUTC2MvFj/6KurpmhRXgQxcurNLMHkcRbOEQt1ciiHYpICr3u+Itc4//rcbuuuCOVRJO+wBmajMecXttYvwTl3n1v/udsNJUu5OtG5WUhfrmEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=l2ySQOjD; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="l2ySQOjD"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4905529b933so75285235e9.0
        for <ntb@lists.linux.dev>; Wed, 10 Jun 2026 10:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781110951; x=1781715751; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MpKanxyD8Q34gT2P3ws5K1aQChI//2GIo3z4IZKKF+M=;
        b=l2ySQOjDbdg7etu8YihaICKwSmhWeusmiBkXUj98mrev6OiIFXHEWw56OBoTkSQb0j
         PLLiV+mneGtPts9SKfzTigafUfem/o5axbwrEezH2XVnRlNbCjL7v5eJPF9zsWupCa9K
         MJWppYbec2JA7m0xeUFJJNkP+irSZ2CotpEmD273BBnVdchVYOgf41ZOR5XB0ruDG6UI
         nXirpcn3jp+8dKwXCYA/9K9nu6fRl9D6c/SWldS2diH+LXw1fuwaTHV7E6oJzpZ/jdas
         fKmlIbPCyy4F1jWbw4vgvzEAKQyaRk9unkH/y4r+hDBtGiXxiQ6jPHLxWb++iud7SSKR
         IznQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781110951; x=1781715751;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MpKanxyD8Q34gT2P3ws5K1aQChI//2GIo3z4IZKKF+M=;
        b=MgZqJsX+atsktCU0xoDokBLNK/iFzx9J4J4RQXV3dfMJUI9MS9lzPW4/bCkdVNc7Jb
         8iMOHwVU1MT0J6wAmzWkbw9bgHncRmcx8VorPF0FScptbaY9JC742CDhbjwuVOUadaSz
         H53c+RY+iQOJYctN01783tZ00KnseAd/JheyF5uH/Mt3IjSXFA1ow4pCpzPxE/RW9l4w
         6Go+ZG3dM3DNxQC5h7L06KbNwQw0kKvWHAhV1NrQaCYV0zFPmCEPDnFnb8BhXtKZIZ9j
         V4SuqtSs6U2+fQ23eg14CxVdW02M4y9H9ygzgg1BpOXySSC/mCWnQOvqP1lVVP7zmmwC
         uXpQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Gt6VJEFODhNh2NWq5fZlHXG8sVcK+wKMvPFncewin7cNmHX0aYfYS31iNi1222Fm6N3s=@lists.linux.dev
X-Gm-Message-State: AOJu0Ywf6hcKTF4ARqkRLVijFWteO/okX1jzdS1v0pDTqJm/tXaDzRkz
	oxFLXQ9gSiJSmx7kq7XpCJXfV42cylwP6RPuK6TktFNpl8zWxPwyj8dzAPtow+plPlo=
X-Gm-Gg: Acq92OHOmO/yHCtfHJmgq3oTgyVtqdltlYaPPO5X+PalSqpYgGoI8FLJvEJNmm5Rgqn
	LF4QItgkbLOGd94jXgrnPmTdCqwZIOVNKknfS1DXihtyZDdio3mVzN7DYbWZ89uQIDHnj5x91yp
	y6Vte6QNGmob8oOXC6n63RRnK2FJ1JRYvX2ySsCrACc424O2LuQNIqnoPxLTBX4y9BCpuCIJgoT
	R1lb227KKsiCrPDveixcrwfDPHd8UaFy3SyUovwDUZ/hLQl7LDNwlBjS+a4JArM0ddlNuDOh/ua
	g4Pt6dfsba21EtaDreo4T5segQtWcH7givFRZwlXkh/FZNL2KSkA0OKNv2yoU6S2JlcCweILSBL
	Bz1vYoTnupWDp27ks7gbI7fO3n20dTXnjaTlXKU2ZoB0GQWyrkdq3QNHxmZauZK5eibD0i99+5M
	SaJtj9No0NCcsDzFVZG+iUZoQuRKChqj9er5jYFuT5FJMQTP+SaF4eUYcO/iPc/BgvOpZuV742g
	u5fnjT4LKgIGJ1YFSYXB7TYSQ==
X-Received: by 2002:a05:600c:8b70:b0:490:ae94:a7e6 with SMTP id 5b1f17b1804b1-490c25c20e0mr404332485e9.24.1781110951270;
        Wed, 10 Jun 2026 10:02:31 -0700 (PDT)
Received: from localhost (p200300f65f47db046aec8c3a4b621e71.dip0.t-ipconnect.de. [2003:f6:5f47:db04:6aec:8c3a:4b62:1e71])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-490e2b2bbdbsm767905e9.14.2026.06.10.10.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 10:02:29 -0700 (PDT)
Date: Wed, 10 Jun 2026 19:02:27 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Basavaraj Natikar <Basavaraj.Natikar@amd.com>, 
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>, ntb@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ntb: amd: Use named initializer for
 pci_device_id::driver_data
Message-ID: <aimYgZgy5w5gwDMA@monoceros>
References: <20260507074102.2654314-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rp6lzteaac5z64by"
Content-Disposition: inline
In-Reply-To: <20260507074102.2654314-2-u.kleine-koenig@baylibre.com>


--rp6lzteaac5z64by
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] ntb: amd: Use named initializer for
 pci_device_id::driver_data
MIME-Version: 1.0

Hello,

On Thu, May 07, 2026 at 09:41:01AM +0200, Uwe Kleine-K=F6nig (The Capable H=
ub) wrote:
> The current list initialisation depends on the well hidden two zeros in
> the PCI_VDEVICE macro. Instead use a named initialisation that is more
> robust and easier to understand.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig (The Capable Hub) <u.kleine-koenig@bayl=
ibre.com>

who would be the one responsible to pick up this patch?

Best regards
Uwe

--rp6lzteaac5z64by
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmopmKAACgkQj4D7WH0S
/k6u5Qf+OeaoQwDHjJLLEkg1Bmx9hu+HR02NTnCIGcbDpHCZK19H/HpCmiOn9cqK
LoGt7at6xu5GchC/tjJLAQZPYS22Re8ZMYejcHVayAGmUKA3srqcqeOBrzXxdPB/
phZjbSkBf7VDatjzoJSp7GpMK/IOP89yZeFAIVssTYDZPtbiXRC99MHdbZ5rGpgt
i5GPfuGy3yySK7Ofr05yCuAZt7DvJ/ea/csz5WDznUwyxWzaNX1wKbU8Yji4c3iO
qDjcvm78bQzCStLsubXhVdDaNVGq95rKnveIbdfMtL7B+IDxJk4+rQ9FZ/xTX9/U
j0YqfXciOK9bwwRGKzmPnTVaaSxf0A==
=u20J
-----END PGP SIGNATURE-----

--rp6lzteaac5z64by--
