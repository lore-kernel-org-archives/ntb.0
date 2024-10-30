Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E533E1EBFF2
	for <ntb@lists.linux.dev>; Wed, 30 Oct 2024 11:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730287718; cv=none; b=BNlcMLlCndS5KRrObQyyt7E1bbLvJIUjqL+9j54GuujbG9ukswJwLlfhWQd8CA3Bf9sCAX0UoO3T8FbLArlOUEHQDjvCeJhX4V+6TRWWG+wFwsdUqnWI2f/CqwZfk1lqnlFHGszfM2JzzpbQusnruYy4rzDI5lXcCwq2x0s4C8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730287718; c=relaxed/simple;
	bh=x2AO4woPu9H2aNxl2TylFo7TB42POmIv8HM+dl0TTWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nrSlm8S/OMPmGCNHGlKMngshwlHcHIM9thi/xU6zp5riDdmyUeyVTwlJzHLgYUuWVf03MAQUd274UYwxbwmdZw+paYGxQJlnGtm92ZQSijkaFIkmTtHVchVzbCqCI9ieoygCsLKVg/cxNPu5WhNuPDsbZC/7G9vyCWq6Hbqsq4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cdTlqQ+r; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cdTlqQ+r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730287715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vZ55uYUf11n7K97VlTpkijb2Akz5QQrQmQxQWIeLt9U=;
	b=cdTlqQ+rITuEMTH/pP2ZZudifcqp4N2lvzLpSU0nCEkAv3b1PEvPHulimwxtQ5ZYkRv20Q
	9/saZfbpYVwfcvAQ7NjYmxUltsOVC0SVpbeO8ICuPAdB26OiweKW0CoEaXC0mPWGoXetv2
	SFc1B63TXqpjgqaL7mXFLpRjiUTBkdc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-vaqEVDgWMwisHjSIVgX4UQ-1; Wed, 30 Oct 2024 07:28:32 -0400
X-MC-Unique: vaqEVDgWMwisHjSIVgX4UQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a9a1be34c68so451484766b.1
        for <ntb@lists.linux.dev>; Wed, 30 Oct 2024 04:28:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730287711; x=1730892511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vZ55uYUf11n7K97VlTpkijb2Akz5QQrQmQxQWIeLt9U=;
        b=conJYwHLcZLt0N1lgf3CY0TIsG7fi3ubj2912bgvVqsmwLwkafV0MnQf4j/hfR2Rq1
         jUUWDAt/SthD8cNj8MSpu4PlVIFOByiI6C5nKWrhrlpiB8SBMzf96Ntwx2XXNVBT1sH4
         N3GAcVHnVrMIyZFBWeRT1hqTHTv0N/GcHV+79gZ8evGDcaD/wIUFXee1AecVGIVTdmpv
         XawY9LrUWm/OFFaWjkxOY97LCu/AnpuZeWuMeaPqWo2KWSK0B9b3U+Yc4yfNSzAYiyzi
         2vqgym3UQ8aTII4bD/QrT1mDO4kuXURlXbK99pby8SW8Eye9E0Ir6YCSTTEcntTlHadp
         fzNA==
X-Forwarded-Encrypted: i=1; AJvYcCWCKheR1iB1Cy84HSFUFn2XgQ8RknO+LqM29FP1tnvujVtjbO+sSYpbZwBN4+muPyknNLc=@lists.linux.dev
X-Gm-Message-State: AOJu0YxCT3a7NxMmmhbF/FbIOC2+iH4p0CplQR7FyiYXJ/LQvJIvhZwn
	0bNwnHP6lwyybM0fc+rIDyTE3rmnovktapVM2k5FkxvVb11GjyQa12+Cs7RDtt+MTG3zLMNEsuw
	mB3/2do1ZnU1BCH6AQdyy+f5aleEXHbYEWSsbeaOODgXzg6ON4w==
X-Received: by 2002:a17:907:74d:b0:a9a:1792:f05 with SMTP id a640c23a62f3a-a9e3a620de8mr312280766b.31.1730287710734;
        Wed, 30 Oct 2024 04:28:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEypW41JHp9s0QMpUNgIGz0rguEz+SlI+R6m1S08Xc0YathnVPUssPJwfq+JcR1+Av7QYJ0Ag==
X-Received: by 2002:a17:907:74d:b0:a9a:1792:f05 with SMTP id a640c23a62f3a-a9e3a620de8mr312277366b.31.1730287710210;
        Wed, 30 Oct 2024 04:28:30 -0700 (PDT)
Received: from eisenberg.fritz.box ([2001:16b8:3db7:f800:98bb:372a:45f9:41e4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b30f58991sm557324566b.159.2024.10.30.04.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 04:28:29 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Boris Brezillon <bbrezillon@kernel.org>,
	Arnaud Ebalard <arno@natisbad.org>,
	Srujana Challa <schalla@marvell.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Kalle Valo <kvalo@kernel.org>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kevin Cernekee <cernekee@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Mark Brown <broonie@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Philipp Stanner <pstanner@redhat.com>,
	Jie Wang <jie.wang@intel.com>,
	Michal Witwicki <michal.witwicki@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Adam Guerin <adam.guerin@intel.com>,
	Damian Muszynski <damian.muszynski@intel.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Nithin Dabilpuram <ndabilpuram@marvell.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	Breno Leitao <leitao@debian.org>,
	Yedidya Benshimol <yedidya.ben.shimol@intel.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	zhang jiao <zhangjiao2@cmss.chinamobile.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org,
	qat-linux@intel.com,
	linux-crypto@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-sound@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v6 09/10] ALSA: korg1212: Replace deprecated PCI functions
Date: Wed, 30 Oct 2024 12:27:42 +0100
Message-ID: <20241030112743.104395-10-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241030112743.104395-1-pstanner@redhat.com>
References: <20241030112743.104395-1-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

pcim_iomap_table() and pcim_iomap_regions_request_all() have been
deprecated by the PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
pcim_iomap_table(), pcim_iomap_regions_request_all()").

Replace these functions with their successors, pcim_iomap() and
pcim_request_all_regions().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Reviewed-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/korg1212/korg1212.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/pci/korg1212/korg1212.c b/sound/pci/korg1212/korg1212.c
index e62fb1ad6d77..49b71082c485 100644
--- a/sound/pci/korg1212/korg1212.c
+++ b/sound/pci/korg1212/korg1212.c
@@ -2108,7 +2108,7 @@ static int snd_korg1212_create(struct snd_card *card, struct pci_dev *pci)
         for (i=0; i<kAudioChannels; i++)
                 korg1212->volumePhase[i] = 0;
 
-	err = pcim_iomap_regions_request_all(pci, 1 << 0, "korg1212");
+	err = pcim_request_all_regions(pci, "korg1212");
 	if (err < 0)
 		return err;
 
@@ -2130,7 +2130,9 @@ static int snd_korg1212_create(struct snd_card *card, struct pci_dev *pci)
 		   korg1212->iomem2, iomem2_size,
 		   stateName[korg1212->cardState]);
 
-	korg1212->iobase = pcim_iomap_table(pci)[0];
+	korg1212->iobase = pcim_iomap(pci, 0, 0);
+	if (!korg1212->iobase)
+		return -ENOMEM;
 
 	err = devm_request_irq(&pci->dev, pci->irq, snd_korg1212_interrupt,
                           IRQF_SHARED,
-- 
2.47.0

