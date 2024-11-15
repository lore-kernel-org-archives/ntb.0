Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7994E18A6C5
	for <ntb@lists.linux.dev>; Fri, 15 Nov 2024 08:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731659548; cv=none; b=jhF5EU9cf9SpGGFtPi6umXQoTCpVyhhBZyH/qEtxo+nzJcVQmiVLWm6XBXGiQD+8G8TkFh3V1+J3tzTyobJERTE1BKhdBxsaaFegNQsPfTMH1EuhIjZ/jFT1rL862ViQZlQTQEUdgOpkipT4DBMQuzXssV0l4tcCdGHI2yD9lw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731659548; c=relaxed/simple;
	bh=KwwtRZveGMe16US76kOe+Iauo+yTFHTCMml6hFlPRTY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cQzk9sJygOvd3XlPu1ut2dgXXNEOhos7mcIp0C8fX8VY8TRwusW8+00hv+QeALmC4/ioZr8n7wYb8hE8AHFuzHBSkI4UcN4jbb7hivGbT1RHUj9EtXCMwoLZ7ls7L6hMB2dE88HhvgI7N+j2JfNCKy25hN+LXp6CF4vk03iP4E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F9yXB9Fc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F9yXB9Fc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731659545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KwwtRZveGMe16US76kOe+Iauo+yTFHTCMml6hFlPRTY=;
	b=F9yXB9Fcs8d9Atd8qJYm3g9//B/Ic3dykofMrU8T6tMzFSjEx6x8XmQ4nS7AAnKzRnjSsl
	bJWMfdibezmwzJa7GVTc6yN5ka3cDMYSp3SxX3ZQcinqvMxHPgqS16JXN1PVfbE65g5Ikz
	IWAdhW8p9TEh5Dj9JtvU8Y1OeMaJ+x0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-XYpviF64M1S_VPuZ4B_Uxg-1; Fri, 15 Nov 2024 03:32:22 -0500
X-MC-Unique: XYpviF64M1S_VPuZ4B_Uxg-1
X-Mimecast-MFC-AGG-ID: XYpviF64M1S_VPuZ4B_Uxg
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3821c0ccdd0so337466f8f.3
        for <ntb@lists.linux.dev>; Fri, 15 Nov 2024 00:32:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731659540; x=1732264340;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KwwtRZveGMe16US76kOe+Iauo+yTFHTCMml6hFlPRTY=;
        b=fFbWWxkobxzZXOO15d/AQJ0X1Idd6ZMlyx3xgJzqrcNLk+PMaMrGZpYvc+3oRuTMdV
         aeq+bPmzYa0LrmYPymazee3keuBtK5aEPf0lawNH7boFEjw546KwEtN8oPOkcpKW27nh
         zoqIx6f6w3OvJwiRem2Tu8MGGfkG396tdNqYO4QlCINswjnY5prNo6x6CAAwaxzkZ0/k
         l36/oJ4LOik14nHIvFx81ZR1QieQEL7zMF9yU/u1WKlfYjtE41Ppw+keQLJuglsUnP1D
         VV6wP30NJ9xFVOIIFtK0l0IHAA6iqWcBdSbm+4teIL+mD5W3X/gYLXpkjPloTMDvjcJ5
         bNDA==
X-Forwarded-Encrypted: i=1; AJvYcCVpIOt+/sQmZfKNxORBIRygbnbOqsxHOtT4UT9KJbTDzxN0F7LWYlHHhs3PgczPC1E1Y5E=@lists.linux.dev
X-Gm-Message-State: AOJu0YxGoSuZzvFKzL8xdRXvTUIHGWq4yy32yb5dUt3bGBmrV6uGA8E1
	A4+X2eo6a2iRlNXWipkUl7QNulpewwVjs+ZzCGWnqGzs0u0tEzbuESziTXaDTVXuuoPws1O6Mv3
	R5JFZ/eePx0vnLxVC3fnvyL0BN0Cc2Pz/KJE4y4oBX1fAvGaNAw==
X-Received: by 2002:a5d:64c9:0:b0:37d:5173:7a54 with SMTP id ffacd0b85a97d-38225aafc0bmr1382368f8f.52.1731659540159;
        Fri, 15 Nov 2024 00:32:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdh/kmNlYkC/WQKFf2J1h1Btsr4ZUjp0WRHuv0DJX0wKMjNySBXwoM4GCHyqPFiIGeYI7IOw==
X-Received: by 2002:a5d:64c9:0:b0:37d:5173:7a54 with SMTP id ffacd0b85a97d-38225aafc0bmr1382314f8f.52.1731659539626;
        Fri, 15 Nov 2024 00:32:19 -0800 (PST)
Received: from [10.200.68.91] (nat-pool-muc-u.redhat.com. [149.14.88.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821ada2da2sm3716393f8f.15.2024.11.15.00.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 00:32:19 -0800 (PST)
Message-ID: <ff7f7358cec4bb03423879a2e4efd16d0a3e8ed7.camel@redhat.com>
Subject: Re: [PATCH v2 11/11] Remove devres from pci_intx()
From: Philipp Stanner <pstanner@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>, Damien Le Moal
 <dlemoal@kernel.org>,  Niklas Cassel <cassel@kernel.org>, Basavaraj Natikar
 <basavaraj.natikar@amd.com>, Jiri Kosina <jikos@kernel.org>,  Benjamin
 Tissoires <bentiss@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Alex Dubov <oakad@yahoo.com>,
 Sudarsana Kalluru <skalluru@marvell.com>, Manish Chopra
 <manishc@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rasesh Mody
 <rmody@marvell.com>,  GR-Linux-NIC-Dev@marvell.com, Igor Mitsyanko
 <imitsyanko@quantenna.com>,  Sergey Matyukevich <geomatsi@gmail.com>, Kalle
 Valo <kvalo@kernel.org>, Sanjay R Mehta <sanju.mehta@amd.com>, Shyam Sundar
 S K <Shyam-sundar.S-k@amd.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang
 <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Alex Williamson <alex.williamson@redhat.com>,
 Juergen Gross <jgross@suse.com>, Stefano Stabellini
 <sstabellini@kernel.org>, Oleksandr Tyshchenko
 <oleksandr_tyshchenko@epam.com>, Mario Limonciello
 <mario.limonciello@amd.com>, Chen Ni <nichen@iscas.ac.cn>, Ricky Wu
 <ricky_wu@realtek.com>,  Al Viro <viro@zeniv.linux.org.uk>, Breno Leitao
 <leitao@debian.org>, Kevin Tian <kevin.tian@intel.com>, Mostafa Saleh
 <smostafa@google.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Yi Liu <yi.l.liu@intel.com>, Kunwu Chan
 <chentao@kylinos.cn>, Ankit Agrawal <ankita@nvidia.com>, Christian Brauner
 <brauner@kernel.org>, Reinette Chatre <reinette.chatre@intel.com>, Eric
 Auger <eric.auger@redhat.com>, Ye Bin <yebin10@huawei.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, netdev@vger.kernel.org, 
 linux-wireless@vger.kernel.org, ntb@lists.linux.dev,
 linux-pci@vger.kernel.org,  kvm@vger.kernel.org,
 xen-devel@lists.xenproject.org
Date: Fri, 15 Nov 2024 09:32:16 +0100
In-Reply-To: <8734jtl3xm.ffs@tglx>
References: <20241113124158.22863-2-pstanner@redhat.com>
	 <20241113124158.22863-13-pstanner@redhat.com> <87msi3ksru.ffs@tglx>
	 <49bb6fc9ebff3cae844da0465ceadeef8d3217c7.camel@redhat.com>
	 <8734jtl3xm.ffs@tglx>
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EAyA5sv0V0afjEQm8DtLDDGtAbLoWnijWDiD8VeHDco_1731659540
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2024-11-15 at 01:46 +0100, Thomas Gleixner wrote:
> On Thu, Nov 14 2024 at 10:05, Philipp Stanner wrote:
> > On Wed, 2024-11-13 at 17:22 +0100, Thomas Gleixner wrote:
> > > On Wed, Nov 13 2024 at 13:41, Philipp Stanner wrote:
> > > > pci_intx() is a hybrid function which can sometimes be managed
> > > > through
> > > > devres. This hybrid nature is undesirable.
> > > >=20
> > > > Since all users of pci_intx() have by now been ported either to
> > > > always-managed pcim_intx() or never-managed
> > > > pci_intx_unmanaged(),
> > > > the
> > > > devres functionality can be removed from pci_intx().
> > > >=20
> > > > Consequently, pci_intx_unmanaged() is now redundant, because
> > > > pci_intx()
> > > > itself is now unmanaged.
> > > >=20
> > > > Remove the devres functionality from pci_intx(). Have all users
> > > > of
> > > > pci_intx_unmanaged() call pci_intx(). Remove
> > > > pci_intx_unmanaged().
> > > >=20
> > > > Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> > > > ---
> > > > =C2=A0drivers/misc/cardreader/rtsx_pcr.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> > > > =C2=A0drivers/misc/tifm_7xx1.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 6 +--
> > > > =C2=A0.../net/ethernet/broadcom/bnx2x/bnx2x_main.c=C2=A0 |=C2=A0 2 =
+-
> > > > =C2=A0drivers/net/ethernet/brocade/bna/bnad.c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> > > > =C2=A0drivers/ntb/hw/amd/ntb_hw_amd.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 +-
> > > > =C2=A0drivers/ntb/hw/intel/ntb_hw_gen1.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> > > > =C2=A0drivers/pci/devres.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 +-
> > > > =C2=A0drivers/pci/msi/api.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> > > > =C2=A0drivers/pci/msi/msi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> > > > =C2=A0drivers/pci/pci.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 43 +----------
> > > > ----
> > > > ----
> > > > =C2=A0drivers/vfio/pci/vfio_pci_core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> > > > =C2=A0drivers/vfio/pci/vfio_pci_intrs.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 10 ++---
> > > > =C2=A0drivers/xen/xen-pciback/conf_space_header.c=C2=A0=C2=A0 |=C2=
=A0 2 +-
> > > > =C2=A0include/linux/pci.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 -
> > > > =C2=A014 files changed, 22 insertions(+), 62 deletions(-)
> > >=20
> > > Now I'm utterly confused. This undoes the pci_intx_unmanaged()
> > > churn
> > > which you carefully split into several patches first.
> >=20
> > Have you read the email I have linked?
> >=20
> > There is also the cover-letter (does anyone in the community ever
> > read
> > those?) which explicitly states:
> >=20
> > "Patch "Remove devres from pci_intx()" obviously reverts the
> > previous
> > patches that made drivers use pci_intx_unmanaged(). But this way
> > it's
> > easier to review and approve. It also makes sure that each checked
> > out
> > commit should provide correct behavior, not just the entire series
> > as a
> > whole."
>=20
> I read it and I assume your intention was to force an eye on every
> use
> case of pci_intx() and not just on those which need to be converted
> to
> pcim_intx().
>=20
> I'm not convinced that this is needed, but fair enough.

Whether pcim_enable_device() is really not used could have been
overlooked, or the driver could move to "managed mode" in parallel for
v6.13 for example. Then a bug would be silently introduced into those
drivers.

Besides, me touching pci_intx() unfortunately caused a few explosions
in the past already, in

fc8c818e756991f5f50b8dfab07f970a18da2556 and
00f89ae4e759a7eef07e4188e1534af7dd2c7e9c

So this time I prefer to be rather safe than sorry.


BTW, if you can review the MSI patch and check whether removing devres
from there really is fine, that would be helpful.


Regards,
P.

