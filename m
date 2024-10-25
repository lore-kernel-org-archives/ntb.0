Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712A21632F7
	for <ntb@lists.linux.dev>; Fri, 25 Oct 2024 15:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729870850; cv=none; b=eCATO7F8Oqvu9Ol8Qj4kqZFlXZEOM2VvDFuwFSi4TCOmSp0Yp6OpfMPCvwdc5+YZqzuRqhaGuxRdFOuJcxDdBK2Y2MDSIWbFa9gphYoZoBnFVEP39HIGOfR8MfHVQ042GQ/r0aJ0J4mOumFrer0MJU9HrP9c0WzH2zK3enlbuiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729870850; c=relaxed/simple;
	bh=9+5aXPFgLW0QK6xl/2u7H0F2/bcqoggsIe1DxfUqXcA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ObwXrcvNwBp7T9At7GrmHiyfXUQa7PYV6ZdwEr/0FZUzi1jFzQF+aXidrxJDQiARGCirxjZ6QouDSCRFd6UdnKUX9m+QazT9r4XCWwiny9evpievkeF0KFuFEaIuyvJ6DNFUrJBmnuLGVm9/QNI/PWZyc1/lA+GoXgT4hgEkenA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f8AaKIsL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f8AaKIsL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729870846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9+5aXPFgLW0QK6xl/2u7H0F2/bcqoggsIe1DxfUqXcA=;
	b=f8AaKIsLoFHVrho40sHqCmU+c2EBr1FXJJZ0NXMPh2fEzg5kohQlLFcak2f3KkSLMJnPal
	g2UM56gTkX39L75WQpY4fPDI7GJK62zDRcqRNdpns3kXH1Bhl0hVSEOEZKD5gj/XbJPWfi
	ad+wJ+QdEn2vzrSLEpdRpYQz1McxGkg=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-_sF77qBHN_WR03JKvTOaLw-1; Fri, 25 Oct 2024 11:40:45 -0400
X-MC-Unique: _sF77qBHN_WR03JKvTOaLw-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5c88bde66bdso1349488a12.2
        for <ntb@lists.linux.dev>; Fri, 25 Oct 2024 08:40:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729870844; x=1730475644;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XzoMdLAmboBYe/1IRrBdZaOPlgpz2yyMsskVNx8zBnM=;
        b=uqzUVL3Mtz2R9EqqTPrLPc8yEja2d3oXrEGJZqVA+TLHBq8DGKjUnLNcdcTGaFdSrB
         +yD0Eb7KBPTP/Rq83jZKNPEmvvdZuEEfWm0GGeJ2FcSfmOphc+w5lzD2bAjmJmJzpMYK
         Cw7GDe3pWQimui7++iggyrAZWV5rv0YCnKS0KTYYIJVPHaKnKQFzYj3g3c4nnAkfTdN8
         NKGX6DoQGoTioXNombL+eSyPiFx+yZFrVri2McmTQzytGuTiHNDMNiacXSFKv4XOLo4D
         /ENfpjrbLjjQflAmlLQRysm/wqxU7H6LYRVVa3awT+n9hIgSfVpdqYw1G9/XY/5oalhL
         NurQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/Yz5F9Bw0webopWFAlj47IWOUgxYnyGQ/OAMHPMoJSOj01uLmOnjBNWPyH8Q0tpqf8DA=@lists.linux.dev
X-Gm-Message-State: AOJu0Yzg12g5CjCJXmFahxVoD6YZfNCxvV6woRnE5mFP9x2fSZBPz+N6
	AN80chAVRqra+ZCJaolpD1SnfJ2EdVCdcKwcr6QgCrkPJcjbjiL0U3OTOB3WkDM9gvNwYtOu7FP
	TMbb+mMsakiUwQ9YbGUvy/AK8zgNyDyO1vaPL4iSBn8x3vtMZGw==
X-Received: by 2002:a05:6402:2708:b0:5cb:6718:660a with SMTP id 4fb4d7f45d1cf-5cba242fd48mr4898143a12.9.1729870843868;
        Fri, 25 Oct 2024 08:40:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/Zcv+ZRlluNXU1aQ1MGYzlRmBIYaLWcpFVZkMbyXea+x6Kqw2wJYkAxS4CN0OGWslX2I1RQ==
X-Received: by 2002:a05:6402:2708:b0:5cb:6718:660a with SMTP id 4fb4d7f45d1cf-5cba242fd48mr4898108a12.9.1729870843339;
        Fri, 25 Oct 2024 08:40:43 -0700 (PDT)
Received: from eisenberg.fritz.box (200116b82de5ba00738ac8dadaac7543.dip.versatel-1u1.de. [2001:16b8:2de5:ba00:738a:c8da:daac:7543])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cbb613c3e9sm747217a12.0.2024.10.25.08.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 08:40:42 -0700 (PDT)
Message-ID: <415402ba495b402b67ae9ece0ca96ab3ea5ee823.camel@redhat.com>
Subject: Re: [PATCH 06/10] wifi: iwlwifi: replace deprecated PCI functions
From: Philipp Stanner <pstanner@redhat.com>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Damien Le Moal <dlemoal@kernel.org>, 
 Niklas Cassel <cassel@kernel.org>, Giovanni Cabiddu
 <giovanni.cabiddu@intel.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>,  Boris Brezillon
 <bbrezillon@kernel.org>, Arnaud Ebalard <arno@natisbad.org>, Srujana Challa
 <schalla@marvell.com>,  Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Miri Korenblit
 <miriam.rachel.korenblit@intel.com>, Kalle Valo <kvalo@kernel.org>, Serge
 Semin <fancer.lancer@gmail.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang
 <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Kevin Cernekee <cernekee@gmail.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
 <tiwai@suse.com>,  Mark Brown <broonie@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
 <u.kleine-koenig@pengutronix.de>, Jie Wang <jie.wang@intel.com>, Tero
 Kristo <tero.kristo@linux.intel.com>, Adam Guerin <adam.guerin@intel.com>,
 Shashank Gupta <shashank.gupta@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Bharat Bhushan <bbhushan2@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>, Johannes Berg
 <johannes.berg@intel.com>, Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
  Gregory Greenman <gregory.greenman@intel.com>, Benjamin Berg
 <benjamin.berg@intel.com>, Yedidya Benshimol
 <yedidya.ben.shimol@intel.com>, Breno Leitao <leitao@debian.org>, Florian
 Fainelli <florian.fainelli@broadcom.com>, linux-doc@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org,
 qat-linux@intel.com,  linux-crypto@vger.kernel.org,
 linux-wireless@vger.kernel.org,  ntb@lists.linux.dev,
 linux-pci@vger.kernel.org, linux-serial <linux-serial@vger.kernel.org>,
 linux-sound@vger.kernel.org
Date: Fri, 25 Oct 2024 17:40:39 +0200
In-Reply-To: <ea7b805a-6c8e-8060-1c6b-4d62c69f78ae@linux.intel.com>
References: <20241025145959.185373-1-pstanner@redhat.com>
	 <20241025145959.185373-7-pstanner@redhat.com>
	 <ea7b805a-6c8e-8060-1c6b-4d62c69f78ae@linux.intel.com>
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

On Fri, 2024-10-25 at 18:31 +0300, Ilpo J=C3=A4rvinen wrote:
> On Fri, 25 Oct 2024, Philipp Stanner wrote:
>=20
> > pcim_iomap_table() and pcim_iomap_regions_request_all() have been
> > deprecated by the PCI subsystem in commit e354bb84a4c1 ("PCI:
> > Deprecate
> > pcim_iomap_table(), pcim_iomap_regions_request_all()").
> >=20
> > Replace these functions with their successors, pcim_iomap() and
> > pcim_request_all_regions().
> >=20
> > Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> > Acked-by: Kalle Valo <kvalo@kernel.org>
> > ---
> > =C2=A0drivers/net/wireless/intel/iwlwifi/pcie/trans.c | 16 ++++--------=
-
> > ---
> > =C2=A01 file changed, 4 insertions(+), 12 deletions(-)
> >=20
> > diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
> > b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
> > index 3b9943eb6934..4b41613ad89d 100644
> > --- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
> > +++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
> > @@ -3533,7 +3533,6 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct
> > pci_dev *pdev,
> > =C2=A0=09struct iwl_trans_pcie *trans_pcie, **priv;
> > =C2=A0=09struct iwl_trans *trans;
> > =C2=A0=09int ret, addr_size;
> > -=09void __iomem * const *table;
> > =C2=A0=09u32 bar0;
> > =C2=A0
> > =C2=A0=09/* reassign our BAR 0 if invalid due to possible runtime
> > PM races */
> > @@ -3659,22 +3658,15 @@ struct iwl_trans
> > *iwl_trans_pcie_alloc(struct pci_dev *pdev,
> > =C2=A0=09=09}
> > =C2=A0=09}
> > =C2=A0
> > -=09ret =3D pcim_iomap_regions_request_all(pdev, BIT(0),
> > DRV_NAME);
> > +=09ret =3D pcim_request_all_regions(pdev, DRV_NAME);
> > =C2=A0=09if (ret) {
> > -=09=09dev_err(&pdev->dev,
> > "pcim_iomap_regions_request_all failed\n");
> > +=09=09dev_err(&pdev->dev, "pcim_request_all_regions
> > failed\n");
> > =C2=A0=09=09goto out_no_pci;
> > =C2=A0=09}
> > =C2=A0
> > -=09table =3D pcim_iomap_table(pdev);
> > -=09if (!table) {
> > -=09=09dev_err(&pdev->dev, "pcim_iomap_table failed\n");
> > -=09=09ret =3D -ENOMEM;
> > -=09=09goto out_no_pci;
> > -=09}
> > -
> > -=09trans_pcie->hw_base =3D table[0];
> > +=09trans_pcie->hw_base =3D pcim_iomap(pdev, 0, 0);
> > =C2=A0=09if (!trans_pcie->hw_base) {
> > -=09=09dev_err(&pdev->dev, "couldn't find IO mem in first
> > BAR\n");
> > +=09=09dev_err(&pdev->dev, "pcim_iomap failed\n");
>=20
> This seems a step backwards as a human readable English error message
> was=20
> replaced with a reference to a function name.

I think it's still an improvement because "couldn't find IO mem in
first BAR" is a nonsensical statement. What the author probably meant
was: "Couldn't find first BAR's IO mem in magic pci_iomap_table" ;)

The reason I just wrote "pcim_iomap failed\n" is that this seems to be
this driver's style for those messages. See the dev_err() above, there
they also just state that this or that function failed.

I am indifferent about the message, though. Whatever the maintainer
prefers is fine.

P.

