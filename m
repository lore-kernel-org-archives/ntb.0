Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193732141C6
	for <ntb@lists.linux.dev>; Fri, 11 Oct 2024 12:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728648228; cv=none; b=Omz6wKFmRWL+OQAZC8dMqsD6GWfAGL5zH0mB/Y/j0sgerGa8SXZdy57IFjoYm3eOJ/zu8BPASZv44xMTHWIj/3XgAogmzZcoZ+LTx5ZfTXJZNSo3PGZx5lwoVv2tj4iHwmBfaPjbiyuHOJUGmeYa6q8heYJcQymDDq0y32HgfWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728648228; c=relaxed/simple;
	bh=Hm1o99Wl0wYT15lGSFJLg7EgiqA98EURXKjTmwFk1nY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TkJzUEITXOfZV7w4Qr7SWfnx+lzsvyNti8fcoFnyv6fDurvP78xThMnJNXeTc6yfQv4Dy06770C+y6nHBJ9hlIQtFCDZQI9wI8sYcFWL5aW+R5JKfLe0Qi9XK7zpwQkAWMLt9svDiW6xH9yS8Lwr5lcbYVkCUL7+LZF4Ubl0yTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iir/9/WQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iir/9/WQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728648225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hm1o99Wl0wYT15lGSFJLg7EgiqA98EURXKjTmwFk1nY=;
	b=iir/9/WQZC46zu3L4qYOZtMcGsd1Tx/cUB2QkwKCYODg8PYNgtZXdbmE247Ii2vJexkLTP
	1dFri39P2sxUrIdYxPyo2LCZEBPCHNW1bGkxl4AxMLWdI3QQrL0L8XO/N6+EtlCtvrixNR
	D/rbTJ0pWuMGOkFBFuZAXuyI6q9WhNQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-yhgOHw8oOfKBm5_UTGfhJw-1; Fri, 11 Oct 2024 08:03:44 -0400
X-MC-Unique: yhgOHw8oOfKBm5_UTGfhJw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42ac185e26cso11745905e9.3
        for <ntb@lists.linux.dev>; Fri, 11 Oct 2024 05:03:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728648223; x=1729253023;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3I5lHL6mHTQWMds6pJC4dZUawdNZoxrsfeR6hWpkDqM=;
        b=eE4b1TdQR0M85+rbJqAQcKi1azEMm+kYS8POPnADsOYEYRNOizdf0Nvf06smqecVry
         yTkt3ku5UDUbiDjcKgTd8Bso2QAlRShVFsF4t+NgL5XNgxIvEo3rU5S+01erxCYg4N47
         YBjMLEEf4nsi+l4nspVcL0v6YFz1uMoVx4sX5D0BaKBmaYLBxXVyTlhyWU8Kh9h0NH+u
         GdLyZZyiJ08OPV2KTQxgq1XWREYBetwJcjHfRBiokF0aOnJCtWrwUMhDgkVnB7KxRJ4T
         sEcObY4mXcLnjv72VllFWunzD34G/s3hcMWh6LLE5zJjs9pkXyHgurfo/eal6BWUAcsL
         NC8A==
X-Forwarded-Encrypted: i=1; AJvYcCUn+3+gCgxL4+bvBwia78GT4HofWjyrPuOdCNbqI8M4/QQ0gX/ryJqgUoOIuoRfr1FP2Zg=@lists.linux.dev
X-Gm-Message-State: AOJu0YygMMsIjr6pbEf9nFpQKoMYq2oOJsI+X7xzbwsF4qelGtv3BP32
	IVkC35d50ME/TVk4HMy3Y4nHPnjVBbx7HbeViGmvBlSfYGsU+BDJoBf9iQe0Ys01MZZYDbKLhtB
	FxRxzRh6X1p3gzpNvwemw7GSSm4tqeoBP/eYsVXiayJYeYfRE9w==
X-Received: by 2002:a05:600c:1d1c:b0:42c:c003:edd1 with SMTP id 5b1f17b1804b1-4311decaa48mr19191755e9.10.1728648222785;
        Fri, 11 Oct 2024 05:03:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExbuVJr4JGcXjTZsUgf0Q1cJGFJf/2hMvz1Z5drCky7hS/DrFylID4EQn0lZzCFTWpUUq6Zw==
X-Received: by 2002:a05:600c:1d1c:b0:42c:c003:edd1 with SMTP id 5b1f17b1804b1-4311decaa48mr19191405e9.10.1728648222253;
        Fri, 11 Oct 2024 05:03:42 -0700 (PDT)
Received: from eisenberg.fritz.box ([2001:16b8:3d05:4700:3e59:7d70:cabd:144b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430ccf51770sm73523925e9.22.2024.10.11.05.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 05:03:41 -0700 (PDT)
Message-ID: <914de38f0b6b3d2ddf98c16e427085732bebfd4a.camel@redhat.com>
Subject: Re: [RFC PATCH 01/13] PCI: Prepare removing devres from pci_intx()
From: Philipp Stanner <pstanner@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
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
 <bhelgaas@google.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini
 <sstabellini@kernel.org>, Oleksandr Tyshchenko
 <oleksandr_tyshchenko@epam.com>,  Jaroslav Kysela <perex@perex.cz>, Takashi
 Iwai <tiwai@suse.com>, Mario Limonciello <mario.limonciello@amd.com>, Chen
 Ni <nichen@iscas.ac.cn>, Ricky Wu <ricky_wu@realtek.com>, Al Viro
 <viro@zeniv.linux.org.uk>, Breno Leitao <leitao@debian.org>, Kevin Tian
 <kevin.tian@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ilpo
 =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, Mostafa Saleh
 <smostafa@google.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hannes Reinecke <hare@suse.de>, John Garry <john.g.garry@oracle.com>,
 Soumya Negi <soumya.negi97@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>, Yi
 Liu <yi.l.liu@intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
 Christian Brauner <brauner@kernel.org>, Ankit Agrawal <ankita@nvidia.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Eric Auger
 <eric.auger@redhat.com>, Ye Bin <yebin10@huawei.com>, Marek
 =?ISO-8859-1?Q?Marczykowski-G=F3recki?= <marmarek@invisiblethingslab.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Kai Vehmanen
 <kai.vehmanen@linux.intel.com>,  Peter Ujfalusi
 <peter.ujfalusi@linux.intel.com>, Rui Salvaterra <rsalvaterra@gmail.com>,
 Marc Zyngier <maz@kernel.org>, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-input@vger.kernel.org,
 netdev@vger.kernel.org,  linux-wireless@vger.kernel.org,
 ntb@lists.linux.dev, linux-pci@vger.kernel.org, 
 linux-staging@lists.linux.dev, kvm@vger.kernel.org, 
 xen-devel@lists.xenproject.org, linux-sound@vger.kernel.org
Date: Fri, 11 Oct 2024 14:03:39 +0200
In-Reply-To: <20241010114304.064f5d3d.alex.williamson@redhat.com>
References: <20241009083519.10088-1-pstanner@redhat.com>
	 <20241009083519.10088-2-pstanner@redhat.com>
	 <20241010114304.064f5d3d.alex.williamson@redhat.com>
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

On Thu, 2024-10-10 at 11:43 -0600, Alex Williamson wrote:
> On Wed,=C2=A0 9 Oct 2024 10:35:07 +0200
> Philipp Stanner <pstanner@redhat.com> wrote:
>=20
> > pci_intx() is a hybrid function which sometimes performs devres
> > operations, depending on whether pcim_enable_device() has been used
> > to
> > enable the pci_dev. This sometimes-managed nature of the function
> > is
> > problematic. Notably, it causes the function to allocate under some
> > circumstances which makes it unusable from interrupt context.
> >=20
> > To, ultimately, remove the hybrid nature from pci_intx(), it is
> > first
> > necessary to provide an always-managed and a never-managed version
> > of that function. Then, all callers of pci_intx() can be ported to
> > the
> > version they need, depending whether they use pci_enable_device()
> > or
> > pcim_enable_device().
> >=20
> > An always-managed function exists, namely pcim_intx(), for which
> > __pcim_intx(), a never-managed version of pci_intx() had been
> > implemented.
> >=20
> > Make __pcim_intx() a public function under the name
> > pci_intx_unmanaged(). Make pcim_intx() a public function.
> >=20
> > Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> > ---
> > =C2=A0drivers/pci/devres.c | 24 +++---------------------
> > =C2=A0drivers/pci/pci.c=C2=A0=C2=A0=C2=A0 | 26 ++++++++++++++++++++++++=
++
> > =C2=A0include/linux/pci.h=C2=A0 |=C2=A0 2 ++
> > =C2=A03 files changed, 31 insertions(+), 21 deletions(-)
> >=20
> > diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
> > index b133967faef8..475a3ae5c33f 100644
> > --- a/drivers/pci/devres.c
> > +++ b/drivers/pci/devres.c
> > @@ -411,31 +411,12 @@ static inline bool mask_contains_bar(int
> > mask, int bar)
> > =C2=A0=09return mask & BIT(bar);
> > =C2=A0}
> > =C2=A0
> > -/*
> > - * This is a copy of pci_intx() used to bypass the problem of
> > recursive
> > - * function calls due to the hybrid nature of pci_intx().
> > - */
> > -static void __pcim_intx(struct pci_dev *pdev, int enable)
> > -{
> > -=09u16 pci_command, new;
> > -
> > -=09pci_read_config_word(pdev, PCI_COMMAND, &pci_command);
> > -
> > -=09if (enable)
> > -=09=09new =3D pci_command & ~PCI_COMMAND_INTX_DISABLE;
> > -=09else
> > -=09=09new =3D pci_command | PCI_COMMAND_INTX_DISABLE;
> > -
> > -=09if (new !=3D pci_command)
> > -=09=09pci_write_config_word(pdev, PCI_COMMAND, new);
> > -}
> > -
> > =C2=A0static void pcim_intx_restore(struct device *dev, void *data)
> > =C2=A0{
> > =C2=A0=09struct pci_dev *pdev =3D to_pci_dev(dev);
> > =C2=A0=09struct pcim_intx_devres *res =3D data;
> > =C2=A0
> > -=09__pcim_intx(pdev, res->orig_intx);
> > +=09pci_intx_unmanaged(pdev, res->orig_intx);
> > =C2=A0}
> > =C2=A0
> > =C2=A0static struct pcim_intx_devres *get_or_create_intx_devres(struct
> > device *dev)
> > @@ -472,10 +453,11 @@ int pcim_intx(struct pci_dev *pdev, int
> > enable)
> > =C2=A0=09=09return -ENOMEM;
> > =C2=A0
> > =C2=A0=09res->orig_intx =3D !enable;
> > -=09__pcim_intx(pdev, enable);
> > +=09pci_intx_unmanaged(pdev, enable);
> > =C2=A0
> > =C2=A0=09return 0;
> > =C2=A0}
> > +EXPORT_SYMBOL(pcim_intx);
>=20
> What precludes this from _GPL?=C2=A0 Also note that this is now calling a
> GPL symbol, so by default I'd assume it should also be GPL.=C2=A0 Thanks,

Ah right, I overlooked that pci_intx() also has the _GPL version.
Will make consistent.

Thx,
P.

>=20
> Alex
>=20
> > =C2=A0
> > =C2=A0static void pcim_disable_device(void *pdev_raw)
> > =C2=A0{
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 7d85c04fbba2..318cfb5b5e15 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -4476,6 +4476,32 @@ void pci_disable_parity(struct pci_dev *dev)
> > =C2=A0=09}
> > =C2=A0}
> > =C2=A0
> > +/**
> > + * pci_intx - enables/disables PCI INTx for device dev, unmanaged
> > version
> > + * @pdev: the PCI device to operate on
> > + * @enable: boolean: whether to enable or disable PCI INTx
> > + *
> > + * Enables/disables PCI INTx for device @pdev
> > + *
> > + * This function behavios identically to pci_intx(), but is never
> > managed with
> > + * devres.
> > + */
> > +void pci_intx_unmanaged(struct pci_dev *pdev, int enable)
> > +{
> > +=09u16 pci_command, new;
> > +
> > +=09pci_read_config_word(pdev, PCI_COMMAND, &pci_command);
> > +
> > +=09if (enable)
> > +=09=09new =3D pci_command & ~PCI_COMMAND_INTX_DISABLE;
> > +=09else
> > +=09=09new =3D pci_command | PCI_COMMAND_INTX_DISABLE;
> > +
> > +=09if (new !=3D pci_command)
> > +=09=09pci_write_config_word(pdev, PCI_COMMAND, new);
> > +}
> > +EXPORT_SYMBOL_GPL(pci_intx_unmanaged);
> > +
> > =C2=A0/**
> > =C2=A0 * pci_intx - enables/disables PCI INTx for device dev
> > =C2=A0 * @pdev: the PCI device to operate on
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index 573b4c4c2be6..6b8cde76d564 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -1353,6 +1353,7 @@ int __must_check pcim_set_mwi(struct pci_dev
> > *dev);
> > =C2=A0int pci_try_set_mwi(struct pci_dev *dev);
> > =C2=A0void pci_clear_mwi(struct pci_dev *dev);
> > =C2=A0void pci_disable_parity(struct pci_dev *dev);
> > +void pci_intx_unmanaged(struct pci_dev *pdev, int enable);
> > =C2=A0void pci_intx(struct pci_dev *dev, int enable);
> > =C2=A0bool pci_check_and_mask_intx(struct pci_dev *dev);
> > =C2=A0bool pci_check_and_unmask_intx(struct pci_dev *dev);
> > @@ -2293,6 +2294,7 @@ static inline void pci_fixup_device(enum
> > pci_fixup_pass pass,
> > =C2=A0=09=09=09=09=C2=A0=C2=A0=C2=A0 struct pci_dev *dev) { }
> > =C2=A0#endif
> > =C2=A0
> > +int pcim_intx(struct pci_dev *pdev, int enabled);
> > =C2=A0void __iomem *pcim_iomap(struct pci_dev *pdev, int bar, unsigned
> > long maxlen);
> > =C2=A0void __iomem *pcim_iomap_region(struct pci_dev *pdev, int bar,
> > =C2=A0=09=09=09=09const char *name);
>=20

