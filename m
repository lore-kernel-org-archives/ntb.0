Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6219B1B32D9
	for <ntb@lists.linux.dev>; Thu,  1 Aug 2024 17:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722534395; cv=none; b=BFT9gDcBsIpGmTw/21yD6CEjExHyWvpxUJs2t7UObJkPHrMMUk5xAX3whMAFzXv9MVV6EYWoMeRbsbso8C3FRZtViDiVf4FdgDtdmzexmLuP6qcY/+RhnTgENltSvTe9ECPjhJlK0f3oxTeu47ikoFHZ4et7nTPE8Kf1rFV6Nbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722534395; c=relaxed/simple;
	bh=cvZkQ2qgcPVEhY7uG5u9oCildj/5ABgxLmro9w+ciu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j97nOzkUGlI/BxxwBybHdDKuA/5Amjq2HZYl0uzbedY2ieegbkHDRBHiW+Oe4jC6pKKgfWgm+tNdSBWfFx/nXj/mzV/ktDGMCyRVHBbgrdBDg2sYhMDpcqgoscn0pS2DNSKQFm9k2kapmeLnmaw0sdOH+Edp4O0G0FYrr1WS5HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cz/5xhpl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cz/5xhpl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722534392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6WrcubhpDE+K1LZOYWy4Pg3YuYsECxnI/4rdk9yULNw=;
	b=Cz/5xhpluy3hrvE3m8v1aRuSQ/kuvx33aKEoTzG1eIRA1ag7AeXQL51KrDoFTc5fW96maR
	+si3LNa853QLtKrDKUPqiZLibiJTsB/E/cBdBGf+GGbYMY+usB7kuITuP6t3ca+DRN5OEr
	mBgyiSZsS2PTVkOaLlnCSeT4P7/i+p4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-TevLLDtRO_ioMrjRB9r65A-1; Thu, 01 Aug 2024 13:46:31 -0400
X-MC-Unique: TevLLDtRO_ioMrjRB9r65A-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5a1ab480f90so1271200a12.0
        for <ntb@lists.linux.dev>; Thu, 01 Aug 2024 10:46:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722534390; x=1723139190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6WrcubhpDE+K1LZOYWy4Pg3YuYsECxnI/4rdk9yULNw=;
        b=N/RkV/TLrxE01YCQdkHyDWkDnEdBcJXwbVtjBIGBIpGNpqaXQFtFLwQ7mJJnEsLFk0
         E2+sFgNmTOqeuckUabLE3+3IPmEqa2NK6bCv8GDHyGbKqix4R90evzy7YN0pWMnRWM4s
         ydiRt0MOThsyd+zk0uVKHZqRpDKSldfNfIbi5b4e9/sK6YPhoC4s/ooqQwK0QZZ0dKz6
         jzAYzCTY7nrXKA4zuA62l0EBM5fRdBvdXIgDOqjY7OfkCYyrm8hNU/CedFMHGbiqZAhv
         muGDFHo9/H65LdUqKt6K2/KRdBX+cQK6W07/CDJCEmG3lDNFW3D4VuQsQqoLem8JiQb9
         gjcg==
X-Forwarded-Encrypted: i=1; AJvYcCWFfHSa4vxz8mAE8Xp7+Se6o3pxSvo8x+l7cD5jEqBOSKxHu3BQNAXdWooFOHfhzT48n8w01k59kuoxoQnmIc4ZmTKk
X-Gm-Message-State: AOJu0Ywr/7RiyWqhRtzK0BdTcijNWGzMqH6TFDXaRxgnCaEJyWV2sChW
	+JuyICKo79DDzGIBc18t6Lv866xnz1bQf62teS3jVn/h4W5Bby8WTnMLVLPjfhizKurPz6/pJ8O
	TvC1Pa2AP1YCyW2Jloa964rmJu2pGZBuamqbcT1FrclJSXw8mtw==
X-Received: by 2002:a17:906:d551:b0:a7a:acae:341b with SMTP id a640c23a62f3a-a7dc511b140mr44546866b.9.1722534389749;
        Thu, 01 Aug 2024 10:46:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCCzZ5dXYZH3j2oFHnfDRvpX7K8jxtwUgAxGoBnV6WkOFIYg3M5/pUlm1BFFzaZy+v9hgOQQ==
X-Received: by 2002:a17:906:d551:b0:a7a:acae:341b with SMTP id a640c23a62f3a-a7dc511b140mr44545066b.9.1722534389355;
        Thu, 01 Aug 2024 10:46:29 -0700 (PDT)
Received: from eisenberg.fritz.box ([2001:16b8:3d4b:3000:1a1d:18ca:1d82:9859])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9e83848sm5339066b.177.2024.08.01.10.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 10:46:29 -0700 (PDT)
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
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Jie Wang <jie.wang@intel.com>,
	Adam Guerin <adam.guerin@intel.com>,
	Shashank Gupta <shashank.gupta@intel.com>,
	Damian Muszynski <damian.muszynski@intel.com>,
	Nithin Dabilpuram <ndabilpuram@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Yedidya Benshimol <yedidya.ben.shimol@intel.com>,
	Breno Leitao <leitao@debian.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	John Ogness <john.ogness@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>
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
Subject: [PATCH 02/10] ata: ahci: Replace deprecated PCI functions
Date: Thu,  1 Aug 2024 19:46:00 +0200
Message-ID: <20240801174608.50592-3-pstanner@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240801174608.50592-1-pstanner@redhat.com>
References: <20240801174608.50592-1-pstanner@redhat.com>
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

pcim_iomap_regions_request_all() and pcim_iomap_table() have been
deprecated by the PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
pcim_iomap_table(), pcim_iomap_regions_request_all()").

Replace these functions with their successors, pcim_iomap() and
pcim_request_all_regions()

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/ata/acard-ahci.c | 6 ++++--
 drivers/ata/ahci.c       | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/acard-ahci.c b/drivers/ata/acard-ahci.c
index 547f56341705..3999305b5356 100644
--- a/drivers/ata/acard-ahci.c
+++ b/drivers/ata/acard-ahci.c
@@ -370,7 +370,7 @@ static int acard_ahci_init_one(struct pci_dev *pdev, const struct pci_device_id
 	/* AHCI controllers often implement SFF compatible interface.
 	 * Grab all PCI BARs just in case.
 	 */
-	rc = pcim_iomap_regions_request_all(pdev, 1 << AHCI_PCI_BAR, DRV_NAME);
+	rc = pcim_request_all_regions(pdev, DRV_NAME);
 	if (rc == -EBUSY)
 		pcim_pin_device(pdev);
 	if (rc)
@@ -386,7 +386,9 @@ static int acard_ahci_init_one(struct pci_dev *pdev, const struct pci_device_id
 	if (!(hpriv->flags & AHCI_HFLAG_NO_MSI))
 		pci_enable_msi(pdev);
 
-	hpriv->mmio = pcim_iomap_table(pdev)[AHCI_PCI_BAR];
+	hpriv->mmio = pcim_iomap(pdev, AHCI_PCI_BAR, 0);
+	if (!hpriv->mmio)
+		return -ENOMEM;
 
 	/* save initial config */
 	ahci_save_initial_config(&pdev->dev, hpriv);
diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index a05c17249448..905af6b68d80 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1869,7 +1869,7 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* AHCI controllers often implement SFF compatible interface.
 	 * Grab all PCI BARs just in case.
 	 */
-	rc = pcim_iomap_regions_request_all(pdev, 1 << ahci_pci_bar, DRV_NAME);
+	rc = pcim_request_all_regions(pdev, DRV_NAME);
 	if (rc == -EBUSY)
 		pcim_pin_device(pdev);
 	if (rc)
@@ -1893,7 +1893,9 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (ahci_sb600_enable_64bit(pdev))
 		hpriv->flags &= ~AHCI_HFLAG_32BIT_ONLY;
 
-	hpriv->mmio = pcim_iomap_table(pdev)[ahci_pci_bar];
+	hpriv->mmio = pcim_iomap(pdev, ahci_pci_bar, 0);
+	if (!hpriv->mmio)
+		return -ENOMEM;
 
 	/* detect remapped nvme devices */
 	ahci_remap_check(pdev, ahci_pci_bar, hpriv);
-- 
2.45.2

