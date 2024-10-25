Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B200E17B428
	for <ntb@lists.linux.dev>; Fri, 25 Oct 2024 15:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729868448; cv=none; b=hrzz8tTuDJW2ZhRfwhh9ZtrdLurHdtgF77lAbBFl6GDdooON68Xaj6ZnXY7SIW1wHOcW34qhI1J0+ujF22Z2qBQhd7QP0lGCnFFKC8G5lvxATPfWp3q17GF72+rM7SQNZJ9VQcHVBs8G0HB7j3F+WR2hh8cHVS5kbL1W3rQRyOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729868448; c=relaxed/simple;
	bh=s6xBjYgC8JsEjVYTXZALRaY3DljRr0l2UeRg0HzxlUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T8I4MxwJeE+oRxtBulu3GqklGxSkNWThU0jEN/MgV+86HgazQeP3egTIDvlE55sAtzVyYJmeQCIVXXOOVxb6GnU3LzndQ1XLYuv4XiCWN+zineM/UqPARIxR6DFB3s94ruwFs5ltn08s9Xebt/i5QZCsgn/ank7wW58IIrB/Gs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZjyJBRB0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZjyJBRB0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729868443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ryss9fvWehXfEU+PDJn7zlGdxW8bFi37+f8Je+z7dQs=;
	b=ZjyJBRB0YFpluxHFt7i5Uf6oxhhCoJveNJLfw7/A/BHFCvEudpDaGi3Yt7VhoNqanLMYs6
	ItPC/XiFEK8ON1MqA1mNVO4R11SCcPstJ3HhbJsjRtCj38eRtlfv4RMZXjkIrm7tPxV9TB
	X4RXPJMWAX+AZMypL7NICqUq1nfx6+4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-kE03l8-3NKygVMR9Opswxg-1; Fri, 25 Oct 2024 11:00:42 -0400
X-MC-Unique: kE03l8-3NKygVMR9Opswxg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37d432f9f5eso1117832f8f.0
        for <ntb@lists.linux.dev>; Fri, 25 Oct 2024 08:00:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729868441; x=1730473241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ryss9fvWehXfEU+PDJn7zlGdxW8bFi37+f8Je+z7dQs=;
        b=QADdF/LcoUn2I2xtGfmm3Dx46i6sdB303zFc7oJ9DdoaZpOVfZvQK21gE+ei3vAfJA
         RynoHKRFs+6reuMUG6IhqaE+huBNAbC6ZiYmaaKaeSZ2zeodh9G6MWWMwGt1eEPF3lJv
         jgj9FRHV1pvnU3wbPyxObih6lIOHXVUgv//HN8WDn5KZPzhNNHxoIw4MvOsg5y1QEYzO
         fPYRpU4nXnXr8XeZ1h7dFZPG30zzhP4meNVDhj6vj9IR9v+ACMmTKdy+tmjSXaiUlxf1
         /ywsTgGb+gY+IoWyFnyiqoWhWxwI3147tF4Hf70n3ImA4Rec1Hnw6lr/XZ2Pr0TDDOxL
         v9gg==
X-Forwarded-Encrypted: i=1; AJvYcCV+dgtz5sX0bEQlGBj3GYYtoIpMc5MqTwpmBHlwOrRHy2ElWY3HxxtgdmlJpw+Uq6QhMPQ=@lists.linux.dev
X-Gm-Message-State: AOJu0YxIqJ1xLcGURkKpsL9ycBHFsHeoUFd9qPFBhiUMTHxGTRJPmYae
	ZtecipcABhSBAmEHhRh3+I22uAg/ZYcLcx/7ldp1B5vRAAX1dsgCt3FG9mzTZJfoZLEVuqZfREL
	ETSV7LujpMCGc7cq6lm2MB8wyihadFrA8K44W+pIi5sPSosR56A==
X-Received: by 2002:a5d:56c2:0:b0:374:c17a:55b5 with SMTP id ffacd0b85a97d-37efcf06dc1mr6436984f8f.14.1729868439455;
        Fri, 25 Oct 2024 08:00:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8ckOXkNlZIey2we3esP6YdjimmyCdm/ffeP6OkAIjJrVOU9m50FFPLlquaywIvtz5sXMgiw==
X-Received: by 2002:a5d:56c2:0:b0:374:c17a:55b5 with SMTP id ffacd0b85a97d-37efcf06dc1mr6436886f8f.14.1729868438713;
        Fri, 25 Oct 2024 08:00:38 -0700 (PDT)
Received: from eisenberg.fritz.box (200116b82de5ba00738ac8dadaac7543.dip.versatel-1u1.de. [2001:16b8:2de5:ba00:738a:c8da:daac:7543])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b9216fsm1727189f8f.100.2024.10.25.08.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 08:00:38 -0700 (PDT)
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
Subject: [PATCH 02/10] ata: ahci: Replace deprecated PCI functions
Date: Fri, 25 Oct 2024 16:59:45 +0200
Message-ID: <20241025145959.185373-3-pstanner@redhat.com>
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

pcim_iomap_regions_request_all() and pcim_iomap_table() have been
deprecated by the PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
pcim_iomap_table(), pcim_iomap_regions_request_all()").

Replace these functions with their successors, pcim_iomap() and
pcim_request_all_regions().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Acked-by: Damien Le Moal <dlemoal@kernel.org>
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
index 45f63b09828a..2043dfb52ae8 100644
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
2.47.0

