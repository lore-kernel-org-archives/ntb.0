Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006A618787C
	for <ntb@lists.linux.dev>; Fri, 25 Oct 2024 16:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729873533; cv=none; b=BPuDB9nh6AuCc6PcjYSodyHu8TtfrXOuCdsTNeTPzIzmP2wfeMRqoirgk5j9vIVw6IOEerKlMyESFgenzvOqEDJWrmrmU2JM4lXcEihPiAdGhUqfkteliAWLrTRE9n/NRc9e11pNPtM3zLbRhpOsua3kwPI1sBFVdTZ3EOpy/ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729873533; c=relaxed/simple;
	bh=RX8TnspcZTDA4mkKY1KNYXujg76aca4rgDntN8hNN9c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KSh9X2ynN1HR5FIMF2JsALEb3mVwJ5taQjzXrDEdMDU7GtQPrNZ+X58og+jLaA8DwLMpNf9YYFqdoicaBxTuO9qmXHusbk+fEnIpjF23ebMV+Mys2BSY8XRBNo8xzO4m2aXnykHH8o4qEU+9giJv3wuD+/bwTAh6omiwu1ra/bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RLDJOocp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RLDJOocp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729873529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RX8TnspcZTDA4mkKY1KNYXujg76aca4rgDntN8hNN9c=;
	b=RLDJOocpjnLKKw2ZN0Wol+04qgaoRVGB6uSOxrzMMuCL3QJtsm4YEQ5vS0UTxvB92btGOI
	wdfn/K0mIG5kzuTWjX4wvUSQSLlloKYlEgbAlj7cjDvujzs7/ehPv8EOkRSnaeQ4jVLdof
	br0aTqHDtlsoT4qtuk92no2KLtrAdrU=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-TXBDL8wuOnWcmYnOepd14Q-1; Fri, 25 Oct 2024 12:25:28 -0400
X-MC-Unique: TXBDL8wuOnWcmYnOepd14Q-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-539e13b8143so2044777e87.0
        for <ntb@lists.linux.dev>; Fri, 25 Oct 2024 09:25:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729873527; x=1730478327;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FXKBVRfqpqNYlcZq3IctC1VfdYCiTtVmRZFO4m6wOiI=;
        b=L/zSRdoG+m+FozuycNicVcVS4R02iFapgNje/Wc6ov7B/kWP9xZmX7U39BSuA+U95v
         k0n7xgD4vtuxSo2Z/CPOanB5NhsR8NzB39axwvclAjvl9JeTLZ5C9OT9Saij0yHdcGVp
         lNSWaLqZOMCddgb31DKyoks+VvOLN4rI2rFyGphFD5nDxr2KPxQ57o3aPJdhvaMMwMvZ
         cjLxet7w3wbFr6NKfZcqqRoiHnP1YxoEWxMpMoTG6poUM6/w0rne6l0cZ0myC+6vJCvv
         DsUxLoTXtrHVb/HmLJ/9Zs3ZXHnbPqlUPI1yx7QxtzuKdpq4mt+daI3THBLkN1Jwarf8
         ejuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsFKvkcUMMIKIglXjp8biBs6kxPt5olUPgwtPVZjY+02dqA5VaoVMkIuTmFqv/nWzUV04=@lists.linux.dev
X-Gm-Message-State: AOJu0Ywj1EX4vjfIdPfSRLM+nMBXu3u7WrA++6+zJ+EE1qSV96jgW1Ce
	vV+ZekUbKsbkDXg1f7llyTE+46G24D9vgf/Db+la7QYX8K/qlp92vIIzi5/8sUopk5Mb9iqyDPV
	wPmGJoCWJxx6QKgFAoxqdsjXUqoth1PXxMFZfP7h50ELCjZolnA==
X-Received: by 2002:a05:6512:ad5:b0:539:e2cc:d380 with SMTP id 2adb3069b0e04-53b1a341cb6mr5563362e87.27.1729873527049;
        Fri, 25 Oct 2024 09:25:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvcz2ftuWzZl9pExVs36p45/rF+DcGN9KaPbit+tdC2ctJlDRbjLwxBhAN9fei+TzzB/5ozg==
X-Received: by 2002:a05:6512:ad5:b0:539:e2cc:d380 with SMTP id 2adb3069b0e04-53b1a341cb6mr5563310e87.27.1729873526521;
        Fri, 25 Oct 2024 09:25:26 -0700 (PDT)
Received: from eisenberg.fritz.box (200116b82de5ba00738ac8dadaac7543.dip.versatel-1u1.de. [2001:16b8:2de5:ba00:738a:c8da:daac:7543])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b3a08b478sm86191966b.223.2024.10.25.09.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 09:25:26 -0700 (PDT)
Message-ID: <18fa3bec44aaee473f9d0955891fc63300400de7.camel@redhat.com>
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
Date: Fri, 25 Oct 2024 18:25:24 +0200
In-Reply-To: <a3e6808f-195c-7174-64f9-a4392d7a02f0@linux.intel.com>
References: <20241025145959.185373-1-pstanner@redhat.com>
	  <20241025145959.185373-7-pstanner@redhat.com>
	  <ea7b805a-6c8e-8060-1c6b-4d62c69f78ae@linux.intel.com>
	 <415402ba495b402b67ae9ece0ca96ab3ea5ee823.camel@redhat.com>
	 <a3e6808f-195c-7174-64f9-a4392d7a02f0@linux.intel.com>
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

On Fri, 2024-10-25 at 19:11 +0300, Ilpo J=C3=A4rvinen wrote:
> On Fri, 25 Oct 2024, Philipp Stanner wrote:
>=20
> > On Fri, 2024-10-25 at 18:31 +0300, Ilpo J=C3=A4rvinen wrote:
> > > On Fri, 25 Oct 2024, Philipp Stanner wrote:
> > >=20
> > > > pcim_iomap_table() and pcim_iomap_regions_request_all() have
> > > > been
> > > > deprecated by the PCI subsystem in commit e354bb84a4c1 ("PCI:
> > > > Deprecate
> > > > pcim_iomap_table(), pcim_iomap_regions_request_all()").
> > > >=20
> > > > Replace these functions with their successors, pcim_iomap() and
> > > > pcim_request_all_regions().
> > > >=20
> > > > Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> > > > Acked-by: Kalle Valo <kvalo@kernel.org>
> > > > ---
> > > > =C2=A0drivers/net/wireless/intel/iwlwifi/pcie/trans.c | 16 ++++----=
-
> > > > ----
> > > > ---
> > > > =C2=A01 file changed, 4 insertions(+), 12 deletions(-)
> > > >=20
> > > > diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
> > > > b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
> > > > index 3b9943eb6934..4b41613ad89d 100644
> > > > --- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
> > > > +++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
> > > > @@ -3533,7 +3533,6 @@ struct iwl_trans
> > > > *iwl_trans_pcie_alloc(struct
> > > > pci_dev *pdev,
> > > > =C2=A0=09struct iwl_trans_pcie *trans_pcie, **priv;
> > > > =C2=A0=09struct iwl_trans *trans;
> > > > =C2=A0=09int ret, addr_size;
> > > > -=09void __iomem * const *table;
> > > > =C2=A0=09u32 bar0;
> > > > =C2=A0
> > > > =C2=A0=09/* reassign our BAR 0 if invalid due to possible
> > > > runtime
> > > > PM races */
> > > > @@ -3659,22 +3658,15 @@ struct iwl_trans
> > > > *iwl_trans_pcie_alloc(struct pci_dev *pdev,
> > > > =C2=A0=09=09}
> > > > =C2=A0=09}
> > > > =C2=A0
> > > > -=09ret =3D pcim_iomap_regions_request_all(pdev, BIT(0),
> > > > DRV_NAME);
> > > > +=09ret =3D pcim_request_all_regions(pdev, DRV_NAME);
> > > > =C2=A0=09if (ret) {
> > > > -=09=09dev_err(&pdev->dev,
> > > > "pcim_iomap_regions_request_all failed\n");
> > > > +=09=09dev_err(&pdev->dev, "pcim_request_all_regions
> > > > failed\n");
> > > > =C2=A0=09=09goto out_no_pci;
> > > > =C2=A0=09}
> > > > =C2=A0
> > > > -=09table =3D pcim_iomap_table(pdev);
> > > > -=09if (!table) {
> > > > -=09=09dev_err(&pdev->dev, "pcim_iomap_table
> > > > failed\n");
> > > > -=09=09ret =3D -ENOMEM;
> > > > -=09=09goto out_no_pci;
> > > > -=09}
> > > > -
> > > > -=09trans_pcie->hw_base =3D table[0];
> > > > +=09trans_pcie->hw_base =3D pcim_iomap(pdev, 0, 0);
> > > > =C2=A0=09if (!trans_pcie->hw_base) {
> > > > -=09=09dev_err(&pdev->dev, "couldn't find IO mem in
> > > > first
> > > > BAR\n");
> > > > +=09=09dev_err(&pdev->dev, "pcim_iomap failed\n");
> > >=20
> > > This seems a step backwards as a human readable English error
> > > message
> > > was=20
> > > replaced with a reference to a function name.
> >=20
> > I think it's still an improvement because "couldn't find IO mem in
> > first BAR" is a nonsensical statement. What the author probably
> > meant
> > was: "Couldn't find first BAR's IO mem in magic pci_iomap_table" ;)
>=20
> Well, that's just spelling things on a too low level too. It's
> irrelevant
> detail to the _user_ that kernel used some "magic table". Similarly,
> it's=20
> irrelevant to the user that function called pcim_iomap failed.
>=20
> > The reason I just wrote "pcim_iomap failed\n" is that this seems to
> > be
> > this driver's style for those messages. See the dev_err() above,
> > there
> > they also just state that this or that function failed.
>=20
> The problem in using function names is they have obvious meaning for=20
> developers/coders but dev_err() is presented to user with varying
> level
> of knowledge about kernel internals/code.
>=20
> While users might be able to derive some information from the
> function=20
> name, it would be simply better to explain on higher level what
> failed=20
> which is what I think the original message tried to do even if it was
> a bit clumsy. There is zero need to know about kernel internals to=20
> interpret that message (arguably one needs to know some PCI to
> understand=20
> BAR, though).
>=20
> (Developers can find the internals by looking up the error message
> from
> the code so it doesn't take away something from developers.)

Feel free to make a suggestion for a better error message.

sth like "could not ioremap PCI BAR 0.\n" could satisfy your criteria.

(I just now noticed that so far it called BAR 0 the "first bar", which
is also not gold standard)

P.


>=20

