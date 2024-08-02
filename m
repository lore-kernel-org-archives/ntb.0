Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3501BE87D
	for <ntb@lists.linux.dev>; Fri,  2 Aug 2024 07:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722584361; cv=none; b=SZvEd8LpGFH7tb1ZTiIU5r5wummGLmnVwqWJf0EHSU2Bj2eTB0g0YJbKP2nIWeGm3p/1qBbB+H262Oa981LW9STA5JFz8FriWls6XSNeRgZwz51+yAeKsrcuHLSXr3AXoStRwNdByzoUxiQStk1PjqBSCmpS7GktcUzuVOIY+Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722584361; c=relaxed/simple;
	bh=XyoAsjYXR6vlNnAFOtS7SDp80nop+IcyYDiUz8xV5lU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pBpFDLVc1ILrq65gsLRXOgUe43EQYl+D4daLCwkMNaWPEfPg3IHB/EN0tcftIQQpJVcV8/xOD9J7pO6VuP/sVV8O0SLqN1X1VMESFfmdzZRRWHDE3oqUcofTlAx22it4iEHt/wSaeAMIipG0qEihMJJ+7XV9SqMHI5nFWxOcYcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aMnosPJl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aMnosPJl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722584359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XyoAsjYXR6vlNnAFOtS7SDp80nop+IcyYDiUz8xV5lU=;
	b=aMnosPJlpxngKKk8sNkc92hB9XZDtes/mN6qn4l9eTU7zYeJaSUaH2EgoTluu7UxarD/Ok
	i5MJGksClZELHKZj1MiS7t9h4LUBFDyUiPs96TTiDHLqB4jXvHvevhqc5QbkdQ2vR4kHEF
	gfeaqb2iZRegY4GyZ2ZBNY0hpN/44ok=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-zpOSuYfdOyyx00ev4V6RGA-1; Fri, 02 Aug 2024 03:39:15 -0400
X-MC-Unique: zpOSuYfdOyyx00ev4V6RGA-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5a0e93ebc78so1137039a12.3
        for <ntb@lists.linux.dev>; Fri, 02 Aug 2024 00:39:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722584354; x=1723189154;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XyoAsjYXR6vlNnAFOtS7SDp80nop+IcyYDiUz8xV5lU=;
        b=U4Ha1mycZ/rhsCZfUKqqjNpgLvly/lDSWkA+ebBFS3pq5i/GLD2IbQJlkuok/nUlP6
         IQX2xTZit7c6W08jdCis20d79oZm7ntRk1xPAbch4aVyDp59b+4hWmXS95/iRCUPwWQu
         W3qGoFNRfehVLeXZJgrQ+Squ/yEb8MSfRu7xq4kvGbSjVLJe0Pjoar2iP1EuKVK7zdOZ
         xPeyWDqL8U6sgtN9CfJWrG6UR4Ugq2e75CUJ5RFRqOwOyG5fiVIX0WcG9vUaHVfGZfAW
         qo3lgHmoPHwUqnnzO9HW3YAOp1R9o8p7nV88Yrzhos3ST9UovG0j1Av/lIl/tLw8bGJ3
         J/Fg==
X-Forwarded-Encrypted: i=1; AJvYcCUj66PodVy9LyzJon2SGfjgaEfvZ3asHxcH9PDD11+KHNuWvZcIP3HJUUBTLtBXEzPvw4Ie6s8ZbDZmdeapPM4mQWkv
X-Gm-Message-State: AOJu0Yz3Pf1KvK49upLEgifOeD46+i3ogqgd9JYOVnsycIEH5zZFnSXA
	PocTWGO3HVM8b7lSH15zz8DjhsXhTDwqynZKkvQA131BtgWJpAUCpHGRZ8E1XWOuOWwNj9EvlKZ
	AqwZeutNMxaHbCcysQF5+qNtOOzUsp0nxj7911QACYkl0a1US2g==
X-Received: by 2002:a17:907:d8e:b0:a7a:a4be:2f8f with SMTP id a640c23a62f3a-a7dc4b2ed0fmr130668266b.0.1722584354314;
        Fri, 02 Aug 2024 00:39:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFONH/seRIPn55nxoXB3Ih6iDe58gzFUv6VfG3nc8IISoWvXI/jL74Kj1p+wvKOnC3k+pqpQ==
X-Received: by 2002:a17:907:d8e:b0:a7a:a4be:2f8f with SMTP id a640c23a62f3a-a7dc4b2ed0fmr130665366b.0.1722584353684;
        Fri, 02 Aug 2024 00:39:13 -0700 (PDT)
Received: from eisenberg.fritz.box ([2001:16b8:3d6c:8e00:43f3:8884:76fa:d218])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9e80eb6sm66892066b.174.2024.08.02.00.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 00:39:13 -0700 (PDT)
Message-ID: <6eb427a501499273b39439dd6514fef399c3b55f.camel@redhat.com>
Subject: Re: [PATCH 08/10] serial: rp2: Remove deprecated PCI functions
From: Philipp Stanner <pstanner@redhat.com>
To: Jiri Slaby <jirislaby@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Herbert Xu
 <herbert@gondor.apana.org.au>,  "David S. Miller" <davem@davemloft.net>,
 Boris Brezillon <bbrezillon@kernel.org>, Arnaud Ebalard
 <arno@natisbad.org>,  Srujana Challa <schalla@marvell.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Miri Korenblit
 <miriam.rachel.korenblit@intel.com>, Kalle Valo <kvalo@kernel.org>, Serge
 Semin <fancer.lancer@gmail.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang
 <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Kevin Cernekee <cernekee@gmail.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Jaroslav Kysela
 <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Mark Brown
 <broonie@kernel.org>, David Lechner <dlechner@baylibre.com>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Jonathan
 Cameron <Jonathan.Cameron@huawei.com>,  Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Jie Wang <jie.wang@intel.com>, Adam
 Guerin <adam.guerin@intel.com>, Shashank Gupta <shashank.gupta@intel.com>,
 Damian Muszynski <damian.muszynski@intel.com>, Nithin Dabilpuram
 <ndabilpuram@marvell.com>, Bharat Bhushan <bbhushan2@marvell.com>, Johannes
 Berg <johannes.berg@intel.com>, Gregory Greenman
 <gregory.greenman@intel.com>, Emmanuel Grumbach
 <emmanuel.grumbach@intel.com>, Yedidya Benshimol
 <yedidya.ben.shimol@intel.com>, Breno Leitao <leitao@debian.org>, Ilpo
 =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, John Ogness
 <john.ogness@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-ide@vger.kernel.org, qat-linux@intel.com,
 linux-crypto@vger.kernel.org,  linux-wireless@vger.kernel.org,
 ntb@lists.linux.dev, linux-pci@vger.kernel.org, 
 linux-serial@vger.kernel.org, linux-sound@vger.kernel.org
Date: Fri, 02 Aug 2024 09:39:11 +0200
In-Reply-To: <8d2e03ac-2a08-4a25-9929-dad375afb738@kernel.org>
References: <20240801174608.50592-1-pstanner@redhat.com>
	 <20240801174608.50592-9-pstanner@redhat.com>
	 <8d2e03ac-2a08-4a25-9929-dad375afb738@kernel.org>
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2024-08-02 at 07:18 +0200, Jiri Slaby wrote:
> On 01. 08. 24, 19:46, Philipp Stanner wrote:
> > pcim_iomap_table() and pcim_iomap_regions_request_all() have been
> > deprecated by the PCI subsystem in commit e354bb84a4c1 ("PCI:
> > Deprecate
> > pcim_iomap_table(), pcim_iomap_regions_request_all()").
> >=20
> > Replace these functions with their successors, pcim_iomap() and
> > pcim_request_all_regions()
>=20
> Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

Thank you for the review.

I have to provide a v2 for a small bug in one of the other patches.
While I'm at it, I would rename the title of this patch =E2=84=968 here so =
that
it's "Replace" instead of "Remove", making it consistent with the other
ones.

I'd assume that keeping your RB then would be alright. Please tell me
if not.

Cheers,
P.

>=20
> > Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> > ---
> > =C2=A0 drivers/tty/serial/rp2.c | 12 +++++++-----
> > =C2=A0 1 file changed, 7 insertions(+), 5 deletions(-)
>=20
> thanks,

