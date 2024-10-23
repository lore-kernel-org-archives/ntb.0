Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD141B85C5
	for <ntb@lists.linux.dev>; Wed, 23 Oct 2024 13:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729691418; cv=none; b=NvFtG7tYS27rXw3hR2xMIWxo5NT17Q4mkSG7rXrcAEUXFIuOdQ6R2da70s4oQr1kTA+XHuhOr7c3Bori4qMKqXWyUvaX5J9HC+KpaXzVewmeUBIo9PraPfTH4pyQMgsgN3dclS0dSugPntsTyo7TlBz7sqqXVfrjjI3D/PUnjbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729691418; c=relaxed/simple;
	bh=0/+dEQYx4WTT1/4z8YC1ihy31/3sJwq8UjrD+U04yBQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jGx0pIFWoqeS+0u8h0XywpzsireSB1E6jhobkjvkWjff9f5XqsS2kNImmsMqrC1lB1s+6q+011al0xfAW8XYoGUQGgVWWlPc3N5LMpHWwlKkKqyf5qftpkKGka8TB0C52E1a/sSK7CbJDPFIjvMv48Np/EwA2DUA7qqHG9kdyfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BxNpZC+i; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BxNpZC+i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729691414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0/+dEQYx4WTT1/4z8YC1ihy31/3sJwq8UjrD+U04yBQ=;
	b=BxNpZC+i1qhVk7CJGRSmVOZ1jCbOBc9YBwxjx3AsWrWbX2ShgRSO/TATXT5xSri0JnJILk
	GsWqhI63cytLpc8aBmf2s01wTN8CdYXTph0BnxhmMGMb94ot/zeDZ8Fwx5cQqF0OShSCa7
	DwAliEJ9gZ6O0xOA2f2YVGdvWKI0X4w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-1odN70nFN8Oc-wFxRtf4EQ-1; Wed, 23 Oct 2024 09:50:13 -0400
X-MC-Unique: 1odN70nFN8Oc-wFxRtf4EQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4315e8e9b1cso5513015e9.1
        for <ntb@lists.linux.dev>; Wed, 23 Oct 2024 06:50:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729691412; x=1730296212;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oO7/c3KxFQ4pCLrpHRIQyFFVX9SeNU/L27HBNV7OVps=;
        b=WvrOF6EX/p+mjyz+Cr/h2KyWdgP5UHv8poL48qedGPOf5uthF80no8tOhXTNTPRR1F
         ZfUCUEenb33MM0m5C/1PrQ9PaODjYOxMa7BBpkMni99Yez7fgSYdyEPV8zEtyqlLT7P4
         lr4rU9FFe5PUzQ2s3SISxA7KY1h+qVos/bc4j9D1NrZ4Bsg6D40/2KQ9fCbRphuKrnPy
         SVIOf+ZgOswZXptVbouran4ywq1Rk2lP0SALRu+c5hiKsIB8HeqdGaY7ufQBZZ8ElOO1
         ASxkdQqecR1fHkf2vidjMYOwgJUQcDbeUMwKZ0fY7WGF6cNjP24flspZJGvf4PVmBAXz
         JYFQ==
X-Forwarded-Encrypted: i=1; AJvYcCX80CAnuKgI4onifeToAjcbWhXjK9R8T3MkbuvPtHlzBUwXFnuAHRpYZW2QWdq4dvR/0s8=@lists.linux.dev
X-Gm-Message-State: AOJu0YyIlBUoZ+cB2JiA+1wGEU3ztYomKTNvptOkrsfrCo7v2dD0NLQJ
	Go4JLxO6fVuOFP3bAOdgoVgz3bq5ShNmwozJIa8NflYvmNHKD2PBTrEUHx2ViKrWbe5EY6Pp485
	le7l4IfqyIDGT+4bJPHge5KiP6z+aB1aZPDdKaM+TDrm0ka4Veg==
X-Received: by 2002:a05:600c:4f43:b0:42f:84ec:3e0 with SMTP id 5b1f17b1804b1-4317bd88469mr48316625e9.9.1729691412224;
        Wed, 23 Oct 2024 06:50:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVbS2v+nb51IE57ofZXQEpzrUukFuey0NWkF8DOXs6/K2mGsAvF2UpvyCTTgP3Onw94z3R5g==
X-Received: by 2002:a05:600c:4f43:b0:42f:84ec:3e0 with SMTP id 5b1f17b1804b1-4317bd88469mr48316115e9.9.1729691411741;
        Wed, 23 Oct 2024 06:50:11 -0700 (PDT)
Received: from eisenberg.fritz.box ([2001:16b8:3dac:2f00:8834:dd3a:39b8:e43b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186be7605sm16955265e9.19.2024.10.23.06.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 06:50:11 -0700 (PDT)
Message-ID: <6f3db65fe9a5dcd1a7a8d9bd5352ecb248ef57b1.camel@redhat.com>
Subject: Re: [PATCH 02/13] ALSA: hda_intel: Use always-managed version of
 pcim_intx()
From: Philipp Stanner <pstanner@redhat.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
 Sergey Shtylyov <s.shtylyov@omp.ru>, Basavaraj Natikar
 <basavaraj.natikar@amd.com>, Jiri Kosina <jikos@kernel.org>,  Benjamin
 Tissoires <bentiss@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Alex Dubov <oakad@yahoo.com>,
 Sudarsana Kalluru <skalluru@marvell.com>, Manish Chopra
 <manishc@marvell.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Rasesh Mody <rmody@marvell.com>,
 GR-Linux-NIC-Dev@marvell.com, Igor Mitsyanko <imitsyanko@quantenna.com>,
 Sergey Matyukevich <geomatsi@gmail.com>, Kalle Valo <kvalo@kernel.org>,
 Sanjay R Mehta <sanju.mehta@amd.com>, Shyam Sundar S K
 <Shyam-sundar.S-k@amd.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang
 <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Alex Williamson <alex.williamson@redhat.com>,
 Juergen Gross <jgross@suse.com>, Stefano Stabellini
 <sstabellini@kernel.org>, Oleksandr Tyshchenko
 <oleksandr_tyshchenko@epam.com>, Jaroslav Kysela <perex@perex.cz>, Takashi
 Iwai <tiwai@suse.com>, Chen Ni <nichen@iscas.ac.cn>, Mario Limonciello
 <mario.limonciello@amd.com>, Ricky Wu <ricky_wu@realtek.com>, Al Viro
 <viro@zeniv.linux.org.uk>, Breno Leitao <leitao@debian.org>, Kevin Tian
 <kevin.tian@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ilpo
 =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, Mostafa Saleh
 <smostafa@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, Yi Liu
 <yi.l.liu@intel.com>,  Christian Brauner <brauner@kernel.org>, Ankit
 Agrawal <ankita@nvidia.com>, Eric Auger <eric.auger@redhat.com>, Reinette
 Chatre <reinette.chatre@intel.com>, Ye Bin <yebin10@huawei.com>, Marek
 =?ISO-8859-1?Q?Marczykowski-G=F3recki?= <marmarek@invisiblethingslab.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, Peter Ujfalusi
 <peter.ujfalusi@linux.intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Kai Vehmanen
 <kai.vehmanen@linux.intel.com>,  Rui Salvaterra <rsalvaterra@gmail.com>,
 linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, netdev@vger.kernel.org, 
 linux-wireless@vger.kernel.org, ntb@lists.linux.dev,
 linux-pci@vger.kernel.org,  kvm@vger.kernel.org,
 xen-devel@lists.xenproject.org, linux-sound@vger.kernel.org
Date: Wed, 23 Oct 2024 15:50:09 +0200
In-Reply-To: <87v7xk2ps5.wl-tiwai@suse.de>
References: <20241015185124.64726-1-pstanner@redhat.com>
	 <20241015185124.64726-3-pstanner@redhat.com> <87v7xk2ps5.wl-tiwai@suse.de>
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40)
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

On Tue, 2024-10-22 at 16:08 +0200, Takashi Iwai wrote:
> On Tue, 15 Oct 2024 20:51:12 +0200,
> Philipp Stanner wrote:
> >=20
> > pci_intx() is a hybrid function which can sometimes be managed
> > through
> > devres. To remove this hybrid nature from pci_intx(), it is
> > necessary to
> > port users to either an always-managed or a never-managed version.
> >=20
> > hda_intel enables its PCI-Device with pcim_enable_device(). Thus,
> > it needs
> > the always-managed version.
> >=20
> > Replace pci_intx() with pcim_intx().
> >=20
> > Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> > ---
> > =C2=A0sound/pci/hda/hda_intel.c | 2 +-
> > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> > index b4540c5cd2a6..b44ca7b6e54f 100644
> > --- a/sound/pci/hda/hda_intel.c
> > +++ b/sound/pci/hda/hda_intel.c
> > @@ -786,7 +786,7 @@ static int azx_acquire_irq(struct azx *chip,
> > int do_disconnect)
> > =C2=A0=09}
> > =C2=A0=09bus->irq =3D chip->pci->irq;
> > =C2=A0=09chip->card->sync_irq =3D bus->irq;
> > -=09pci_intx(chip->pci, !chip->msi);
> > +=09pcim_intx(chip->pci, !chip->msi);
> > =C2=A0=09return 0;
> > =C2=A0}
> > =C2=A0
>=20
> Hm, it's OK-ish to do this as it's practically same as what
> pci_intx()
> currently does.=C2=A0 But, the current code can be a bit inconsistent
> about
> the original intx value.=C2=A0 pcim_intx() always stores !enable to
> res->orig_intx unconditionally, and it means that the orig_intx value
> gets overridden at each time pcim_intx() gets called.

Yes.

>=20
> Meanwhile, HD-audio driver does release and re-acquire the interrupt
> after disabling MSI when something goes wrong, and pci_intx() call
> above is a part of that procedure.=C2=A0 So, it can rewrite the
> res->orig_intx to another value by retry without MSI.=C2=A0 And after the
> driver removal, it'll lead to another state.

I'm not sure that I understand this paragraph completely. Still, could
a solution for the driver on the long-term just be to use pci_intx()?

>=20
> In anyway, as it doesn't change the current behavior, feel free to
> take my ack for now:
>=20
> Acked-by: Takashi Iwai <tiwai@suse.de>

Thank you,
P.

>=20
>=20
> thanks,
>=20
> Takashi
>=20

