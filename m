Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF5F1B0F00
	for <ntb@lists.linux.dev>; Thu, 24 Oct 2024 08:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729757001; cv=none; b=VevYP58KFnn+wOJ/dTm0aPTosSOY2G6bLoXVVcfEQCtBTrxTZQMgGJssAXnEvZjtj+kTbFTTOCZiTa+C520an71B8AlMhMm0gVHLpugDOihYT5pRVH1mZ2x5XB2KL9V6h0vo5s4N+eAVmhpyzM40gp9xtAmGW9GfmYlpM4ZfiRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729757001; c=relaxed/simple;
	bh=OTycrCncHkEXGfL2p1SBTSSa5aZhWjbXFaDOrvd1RvI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JgczOUUrmWFDS0/9No6cnGkoP3nENf2R0J630/DhwAOztoQ54IpehR6Nr2AcNbCrcuj7ulkhAJjZOG9Zk+aKbMFzmK2EvrAK4BCV3HJYEQi831c2KyIXJKjYh4G2R0olyjQgelbi7WSXRa8pYMToOEatT4Cyhe0HgSVydnkMkNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GW24Bzup; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GW24Bzup"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729756994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OTycrCncHkEXGfL2p1SBTSSa5aZhWjbXFaDOrvd1RvI=;
	b=GW24Bzup2zTYiYh2uzT1WpKIWp2nZR/DFnz7EGrjrj9QpIIpmpztVkdrEngw0zl+88cqnB
	MYkHFOl+kqKAPRdKYCNImh5K/8QYn0hLe/DsZx7ReV/2FXTkacb6Rufr20/9PC2cfheIIX
	9e5q75IKcNWFBSzIzNyzKfD32UIyLsI=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-ZjAbXB5zMtSlHJZOG9-y6A-1; Thu, 24 Oct 2024 04:03:10 -0400
X-MC-Unique: ZjAbXB5zMtSlHJZOG9-y6A-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-718107b2091so604522a34.3
        for <ntb@lists.linux.dev>; Thu, 24 Oct 2024 01:03:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729756989; x=1730361789;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eCHAxEtiIjB9/eMXdwm4L84xFlQFaCf3ZNV6cwdqU9g=;
        b=dAPRxjD2AONkOXjuNBJvPiFTwXUHfO8DJ6lbQSQaPk547dVlN5HOZ7xoOfDBDqfLFh
         +kFua9M/TpCRB48GVqdmt7w/Lb/d+fupNjBYw6hyQNpY+bVpPUNuVXNhD3wbe6jnK7pv
         6jSE55nwdACB6M3LvG2yQt7wDkXoKztEe6Y+lxTtfLqaQ1qnvlq+/wxhThzO7a9Ceyzd
         ERgI1T0m88bY/IHohB49HEQhSvrxVQ/HhM/2qyVe1Ps9PS/BseKkteF61nJdxBE0gCzA
         WocpUGKrcuLFdVMFdCSUy4cfQxxORpAOsFe5dX61za2TyEJfzRFRl7U8I9yGtF38yTo7
         sj4w==
X-Forwarded-Encrypted: i=1; AJvYcCVTBgKJ44Gv92+QL1pMV1BxtMI463wW6pCN8hHOMw1dej8EAKghf0V7gOuhrPfpHNZFgM4=@lists.linux.dev
X-Gm-Message-State: AOJu0YxO7PaAXrNmFjcJVjBtRIpUyDfJTKeuNkBGspkevHbK4/AeZW5P
	bVmOwpBqlYlZMkYpcwAPQyQRUt41Hk4/J5qnt2xcArL9GIPe2iViPkKI9Utqrb5Ne6gThh97A8z
	HfeEGlIgxj/pAVLGIYSQUGfXbXNGPLXjQUf7uHPwJ0sI4WWQrQQ==
X-Received: by 2002:a05:6830:6dc7:b0:718:c0d:6bdb with SMTP id 46e09a7af769-718598599b9mr736393a34.20.1729756989588;
        Thu, 24 Oct 2024 01:03:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVwKg5C+Tp+G04yjB73N1UyaDqsdgqmmyDICp7Nqm80mYC6tnNIzWvedx2PALg7dJ9abA7Jw==
X-Received: by 2002:a05:6830:6dc7:b0:718:c0d:6bdb with SMTP id 46e09a7af769-718598599b9mr736305a34.20.1729756989132;
        Thu, 24 Oct 2024 01:03:09 -0700 (PDT)
Received: from dhcp-64-16.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ce0099a79fsm47100376d6.90.2024.10.24.01.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 01:03:08 -0700 (PDT)
Message-ID: <aec23bb79b9ff7dd7f13eb67460e0605eac22912.camel@redhat.com>
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
Date: Thu, 24 Oct 2024 10:02:59 +0200
In-Reply-To: <87ttd2276j.wl-tiwai@suse.de>
References: <20241015185124.64726-1-pstanner@redhat.com>
	 <20241015185124.64726-3-pstanner@redhat.com> <87v7xk2ps5.wl-tiwai@suse.de>
	 <6f3db65fe9a5dcd1a7a8d9bd5352ecb248ef57b1.camel@redhat.com>
	 <87ttd2276j.wl-tiwai@suse.de>
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

On Wed, 2024-10-23 at 17:03 +0200, Takashi Iwai wrote:
> On Wed, 23 Oct 2024 15:50:09 +0200,
> Philipp Stanner wrote:
> >=20
> > On Tue, 2024-10-22 at 16:08 +0200, Takashi Iwai wrote:
> > > On Tue, 15 Oct 2024 20:51:12 +0200,
> > > Philipp Stanner wrote:
> > > >=20
> > > > pci_intx() is a hybrid function which can sometimes be managed
> > > > through
> > > > devres. To remove this hybrid nature from pci_intx(), it is
> > > > necessary to
> > > > port users to either an always-managed or a never-managed
> > > > version.
> > > >=20
> > > > hda_intel enables its PCI-Device with pcim_enable_device().
> > > > Thus,
> > > > it needs
> > > > the always-managed version.
> > > >=20
> > > > Replace pci_intx() with pcim_intx().
> > > >=20
> > > > Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> > > > ---
> > > > =C2=A0sound/pci/hda/hda_intel.c | 2 +-
> > > > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/sound/pci/hda/hda_intel.c
> > > > b/sound/pci/hda/hda_intel.c
> > > > index b4540c5cd2a6..b44ca7b6e54f 100644
> > > > --- a/sound/pci/hda/hda_intel.c
> > > > +++ b/sound/pci/hda/hda_intel.c
> > > > @@ -786,7 +786,7 @@ static int azx_acquire_irq(struct azx
> > > > *chip,
> > > > int do_disconnect)
> > > > =C2=A0=09}
> > > > =C2=A0=09bus->irq =3D chip->pci->irq;
> > > > =C2=A0=09chip->card->sync_irq =3D bus->irq;
> > > > -=09pci_intx(chip->pci, !chip->msi);
> > > > +=09pcim_intx(chip->pci, !chip->msi);
> > > > =C2=A0=09return 0;
> > > > =C2=A0}
> > > > =C2=A0
> > >=20
> > > Hm, it's OK-ish to do this as it's practically same as what
> > > pci_intx()
> > > currently does.=C2=A0 But, the current code can be a bit inconsistent
> > > about
> > > the original intx value.=C2=A0 pcim_intx() always stores !enable to
> > > res->orig_intx unconditionally, and it means that the orig_intx
> > > value
> > > gets overridden at each time pcim_intx() gets called.
> >=20
> > Yes.
> >=20
> > >=20
> > > Meanwhile, HD-audio driver does release and re-acquire the
> > > interrupt
> > > after disabling MSI when something goes wrong, and pci_intx()
> > > call
> > > above is a part of that procedure.=C2=A0 So, it can rewrite the
> > > res->orig_intx to another value by retry without MSI.=C2=A0 And after
> > > the
> > > driver removal, it'll lead to another state.
> >=20
> > I'm not sure that I understand this paragraph completely. Still,
> > could
> > a solution for the driver on the long-term just be to use
> > pci_intx()?
>=20
> pci_intx() misses the restore of the original value, so it's no
> long-term solution, either.

Sure that is missing =E2=80=93 I was basically asking whether the driver co=
uld
live without that feature.

Consider that point obsolete, see below

>=20
> What I meant is that pcim_intx() blindly assumes the negative of the
> passed argument as the original state, which isn't always true.=C2=A0 e.g=
.
> when the driver calls it twice with different values, a wrong value
> may be remembered.

Ah, I see =E2=80=93 thoguh the issue is when it's called several times with=
 the
*same* value, isn't it?

E.g.

pcim_intx(pdev, 1); // 0 is remembered as the old value
pcim_intx(pdev, 1); // 0 is falsely remembered as the old value

Also, it would seem that calling the function for the first time like
that:

pcim_intx(pdev, 0); // old value: 1

is at least incorrect, because INTx should be 0 per default, shouldn't
it? Could then even be a 1st class bug, because INTx would end up being
enabled despite having been disabled all the time.

>=20
> That said, I thought of something like below.

At first glance that looks like a good idea to me, thanks for working
this out!

IMO you can submit that as a patch so we can discuss it separately.

Greetings,
Philipp

>=20
>=20
> thanks,
>=20
> Takashi
>=20
> -- 8< --
> --- a/drivers/pci/devres.c
> +++ b/drivers/pci/devres.c
> @@ -438,8 +438,17 @@ static void pcim_intx_restore(struct device
> *dev, void *data)
> =C2=A0=09__pcim_intx(pdev, res->orig_intx);
> =C2=A0}
> =C2=A0
> -static struct pcim_intx_devres *get_or_create_intx_devres(struct
> device *dev)
> +static void save_orig_intx(struct pci_dev *pdev)
> =C2=A0{
> +=09u16 pci_command;
> +
> +=09pci_read_config_word(pdev, PCI_COMMAND, &pci_command);
> +=09res->orig_intx =3D !(pci_command & PCI_COMMAND_INTX_DISABLE);
> +}
> +
> +static struct pcim_intx_devres *get_or_create_intx_devres(struct
> pci_dev *pdev)
> +{
> +=09struct device *dev =3D &pdev->dev;
> =C2=A0=09struct pcim_intx_devres *res;
> =C2=A0
> =C2=A0=09res =3D devres_find(dev, pcim_intx_restore, NULL, NULL);
> @@ -447,8 +456,10 @@ static struct pcim_intx_devres
> *get_or_create_intx_devres(struct device *dev)
> =C2=A0=09=09return res;
> =C2=A0
> =C2=A0=09res =3D devres_alloc(pcim_intx_restore, sizeof(*res),
> GFP_KERNEL);
> -=09if (res)
> +=09if (res) {
> +=09=09save_orig_intx(pdev);
> =C2=A0=09=09devres_add(dev, res);
> +=09}
> =C2=A0
> =C2=A0=09return res;
> =C2=A0}
> @@ -467,11 +478,10 @@ int pcim_intx(struct pci_dev *pdev, int enable)
> =C2=A0{
> =C2=A0=09struct pcim_intx_devres *res;
> =C2=A0
> -=09res =3D get_or_create_intx_devres(&pdev->dev);
> +=09res =3D get_or_create_intx_devres(pdev);
> =C2=A0=09if (!res)
> =C2=A0=09=09return -ENOMEM;
> =C2=A0
> -=09res->orig_intx =3D !enable;
> =C2=A0=09__pcim_intx(pdev, enable);
> =C2=A0
> =C2=A0=09return 0;
>=20

