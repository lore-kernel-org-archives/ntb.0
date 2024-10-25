Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7F9231CA2
	for <ntb@lists.linux.dev>; Fri, 25 Oct 2024 15:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729868464; cv=none; b=TLE/czbUVj6VIJHD/oDjirzlc8BlfSnpYwH3nol9qS/Pj5mVaru86YzexUnjC2J/vmu7zT4a1fe90d4VmI+aMHzcQxgbmTt7ggJGI1zx1CA/FOPdbNXyZvotBCFbSe1XVCpizh3LpePBhOdiij6UVuosjtX4ekn+mQFQdRrWNeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729868464; c=relaxed/simple;
	bh=RcTa7mPaWn9S/3FL+we6iyllf4n7RFykRGESqGJxd90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hEmfy98VNBxCx7PV7WoYpAtaoB7/hGX1o5yD4yrIh5MI9KwOvzLAuRMJguojl7qKM+yGlYtXx8R3P6ZCVBOu+SEZnGqXrIYqqV6WlO3OErtfP0J3/jAEKR4apN3pjPvOAKaE9/eidIo4d4TY+PM4VNn+07Q2SoND3G9dWcsKorE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fJwYOFQD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fJwYOFQD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729868457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AonUKd9JFeAmu2FkelnO1Z47g8svJdBoVMsQtMVmtG0=;
	b=fJwYOFQDQAmHXLgjSDZ4Ns/N04u4HnEn6zNKMe2RJpEsctyqEsxI5fpBWY1aCER4a2tsMC
	ShgQ4CYSK/Pjt1vf2BKN0AVNUYqzpte/uxp4USUkFqvkg54mNyX3059aroJYw7Nf5H4tla
	J6Swcs6cIgkvQnyJZiC2Sp+VFhwvXEE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-79sbmj8iNnihz6Bk5QbaCA-1; Fri, 25 Oct 2024 11:00:56 -0400
X-MC-Unique: 79sbmj8iNnihz6Bk5QbaCA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-37d5a3afa84so1213896f8f.3
        for <ntb@lists.linux.dev>; Fri, 25 Oct 2024 08:00:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729868455; x=1730473255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AonUKd9JFeAmu2FkelnO1Z47g8svJdBoVMsQtMVmtG0=;
        b=VUGvGBhQnAKbKfwQUFos+SA8XUiMuhihvpygAYSE+h4jmBcX0ecegEFBChiFOXi6KD
         OyG5L13i5qt5Avnm4kPRMZ1p4bqFRDR5ZK2voah/lAzm7s07vF6NA0dUfIWRiHymvTj9
         HwFz5iK2pk821X88+X1z/+KFYkk0b0jZetwA+UyB4f1GOilBciwTd5Ga0qY7COm7C9fw
         FZscPf7wczSx7dz3l+OZCjZn4PQf7Cusk6Z9u1ybfI9gErGvn2XA8lAA7sonc7gx6y90
         q6AKZvrnGw/1mG4o3PPXQKtij6Ll4iMNI5TTnlZomuQCHB7APbIPiQ3BT9A0YdP6xs0F
         HqVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGBOhpPJrqn0enGhl6qHjsnATRgkHvdJcubEzxwIUYFRNr7V5nuu0thN5SD1ENxGdhn6s=@lists.linux.dev
X-Gm-Message-State: AOJu0YwV8DO2O4BSbaShVrd5Wrtcbl9jKqMAMSzklfzWXfZhmg8cDDD7
	BRF+cGN3336JWEyK5kQwRi2QEdMG95EYn1eT5yH5bbGlcgPcA9RfwqWDiExIApARLBI1kW4ZKAz
	NwSnCogaiQFXqjfrsO8vS96SWfHpX8QkKOGGmQW7Ayi5fIC/V6Q==
X-Received: by 2002:a5d:434e:0:b0:37d:4d3f:51e9 with SMTP id ffacd0b85a97d-37efcf7665amr6749348f8f.40.1729868454498;
        Fri, 25 Oct 2024 08:00:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYS4KQfglA92Gzw16122qjYNkYIWyEgmDdpCu016/6uuxTInLXjVC7AfMuCfkKwlTQ2XYDlQ==
X-Received: by 2002:a5d:434e:0:b0:37d:4d3f:51e9 with SMTP id ffacd0b85a97d-37efcf7665amr6749277f8f.40.1729868453962;
        Fri, 25 Oct 2024 08:00:53 -0700 (PDT)
Received: from eisenberg.fritz.box (200116b82de5ba00738ac8dadaac7543.dip.versatel-1u1.de. [2001:16b8:2de5:ba00:738a:c8da:daac:7543])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b9216fsm1727189f8f.100.2024.10.25.08.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 08:00:53 -0700 (PDT)
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
	Serge Semin <fancer.lancer@gmail.com>,
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
	Philipp Stanner <pstanner@redhat.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Jie Wang <jie.wang@intel.com>,
	Tero Kristo <tero.kristo@linux.intel.com>,
	Adam Guerin <adam.guerin@intel.com>,
	Shashank Gupta <shashank.gupta@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Nithin Dabilpuram <ndabilpuram@marvell.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	Yedidya Benshimol <yedidya.ben.shimol@intel.com>,
	Breno Leitao <leitao@debian.org>,
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
	linux-sound@vger.kernel.org
Subject: [PATCH 10/10] PCI: Remove pcim_iomap_regions_request_all()
Date: Fri, 25 Oct 2024 16:59:53 +0200
Message-ID: <20241025145959.185373-11-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241025145959.185373-1-pstanner@redhat.com>
References: <20241025145959.185373-1-pstanner@redhat.com>
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

pcim_iomap_regions_request_all() have been deprecated in
commit e354bb84a4c1 ("PCI: Deprecate pcim_iomap_table(),
pcim_iomap_regions_request_all()").

All users of this function have been ported to other interfaces by now.

Remove pcim_iomap_regions_request_all().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
 .../driver-api/driver-model/devres.rst        |  1 -
 drivers/pci/devres.c                          | 56 -------------------
 include/linux/pci.h                           |  2 -
 3 files changed, 59 deletions(-)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index 5f2ee8d717b1..3a30cf4f6c0d 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -394,7 +394,6 @@ PCI
   pcim_enable_device()		: after success, some PCI ops become managed
   pcim_iomap()			: do iomap() on a single BAR
   pcim_iomap_regions()		: do request_region() and iomap() on multiple BARs
-  pcim_iomap_regions_request_all() : do request_region() on all and iomap() on multiple BARs
   pcim_iomap_table()		: array of mapped addresses indexed by BAR
   pcim_iounmap()		: do iounmap() on a single BAR
   pcim_iounmap_regions()	: do iounmap() and release_region() on multiple BARs
diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index 2a64da5c91fb..319a477a2135 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -959,62 +959,6 @@ int pcim_request_all_regions(struct pci_dev *pdev, const char *name)
 }
 EXPORT_SYMBOL(pcim_request_all_regions);
 
-/**
- * pcim_iomap_regions_request_all - Request all BARs and iomap specified ones
- *			(DEPRECATED)
- * @pdev: PCI device to map IO resources for
- * @mask: Mask of BARs to iomap
- * @name: Name associated with the requests
- *
- * Returns: 0 on success, negative error code on failure.
- *
- * Request all PCI BARs and iomap regions specified by @mask.
- *
- * To release these resources manually, call pcim_release_region() for the
- * regions and pcim_iounmap() for the mappings.
- *
- * This function is DEPRECATED. Don't use it in new code. Instead, use one
- * of the pcim_* region request functions in combination with a pcim_*
- * mapping function.
- */
-int pcim_iomap_regions_request_all(struct pci_dev *pdev, int mask,
-				   const char *name)
-{
-	int bar;
-	int ret;
-	void __iomem **legacy_iomap_table;
-
-	ret = pcim_request_all_regions(pdev, name);
-	if (ret != 0)
-		return ret;
-
-	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
-		if (!mask_contains_bar(mask, bar))
-			continue;
-		if (!pcim_iomap(pdev, bar, 0))
-			goto err;
-	}
-
-	return 0;
-
-err:
-	/*
-	 * If bar is larger than 0, then pcim_iomap() above has most likely
-	 * failed because of -EINVAL. If it is equal 0, most likely the table
-	 * couldn't be created, indicating -ENOMEM.
-	 */
-	ret = bar > 0 ? -EINVAL : -ENOMEM;
-	legacy_iomap_table = (void __iomem **)pcim_iomap_table(pdev);
-
-	while (--bar >= 0)
-		pcim_iounmap(pdev, legacy_iomap_table[bar]);
-
-	pcim_release_all_regions(pdev);
-
-	return ret;
-}
-EXPORT_SYMBOL(pcim_iomap_regions_request_all);
-
 /**
  * pcim_iounmap_regions - Unmap and release PCI BARs
  * @pdev: PCI device to map IO resources for
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 3b151c8331e5..b59197635c5c 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2301,8 +2301,6 @@ void pcim_iounmap(struct pci_dev *pdev, void __iomem *addr);
 void __iomem * const *pcim_iomap_table(struct pci_dev *pdev);
 int pcim_request_region(struct pci_dev *pdev, int bar, const char *name);
 int pcim_iomap_regions(struct pci_dev *pdev, int mask, const char *name);
-int pcim_iomap_regions_request_all(struct pci_dev *pdev, int mask,
-				   const char *name);
 void pcim_iounmap_regions(struct pci_dev *pdev, int mask);
 void __iomem *pcim_iomap_range(struct pci_dev *pdev, int bar,
 				unsigned long offset, unsigned long len);
-- 
2.47.0

