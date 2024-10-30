Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3361E503D
	for <ntb@lists.linux.dev>; Wed, 30 Oct 2024 11:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730287710; cv=none; b=oVLxCaVlASnLQrKanAO3xegZmPvfDRHrbW2DlUfaufL2wQx4bQQios5sxXsGED4VgiPk1QnIBwif/LE6efegRtpRSVecLS4QFbi0srPZmPYTVbrMKuY3nuGRafY09Vp5rfqZItySmIwmoGYxaEw3/9npOWXF65rZxlpeTqm/OrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730287710; c=relaxed/simple;
	bh=QqrTki7e9vRgulG4RoLLB4/C1pX/5pt58FH2V8wlJVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eJYscNrdAovIdYQfhME+cSIOmx1VyRLnBm8j0G+kliDrQ8Ps4ihuh54NU+p0uY+j3BYFoMnaKm4xT+A7pS/eX90cxPEqCgqdykcrw8x8jnbxVoY0ePzvwK3QLAkrOzhbpUDdqngcqgiDD8ozh8orVijn0t2gCHaOD1fVsZQYSTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MX6zy25P; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MX6zy25P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730287707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A2mjAvsnCtejFog6952WPlUz5OJHFOOlk35n7fKqpM4=;
	b=MX6zy25Pxu7fg2/g4p2tUkvEFVqb+CKLXk1u2ayh/2lcYneJ1NtDRY13KeDHbrP3JW4aNu
	aHqY/UDyWg3PFN8ss3mWkw6oZgcBOBuhLgNsh5H367gCyvySAHnoGsNpXwT5WailrZHdbU
	R6JnqPAZ3eWObH0vMe+MaZo9Q380yTE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-xWMVWCZ-Odu_pEcICPlANA-1; Wed, 30 Oct 2024 07:28:26 -0400
X-MC-Unique: xWMVWCZ-Odu_pEcICPlANA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a9a0d8baa2cso78091266b.0
        for <ntb@lists.linux.dev>; Wed, 30 Oct 2024 04:28:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730287705; x=1730892505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A2mjAvsnCtejFog6952WPlUz5OJHFOOlk35n7fKqpM4=;
        b=qySF/3NozdkbQBTrCmEQMPjZ754ktTqw0wqWo/7cKqSjXjSyH0+TfWqZT9LZaHCkBU
         RB66iIObib11EGWb3Asl3fSl/uTryMRkirOm8l2O4ZZq0aJUk0PiQ3xmZL52KVZPAHfi
         SgKpRMvGex/6Kkw1MfAGuzDv/8VKmdY+/MKyTwsUt2UhR8QuPPahr0vLSG/y+/1FO8ul
         jhqXPwUb7ueZDojEAcC9h+cmXQZpGbxWM/0eZAtMD0Dd3sWOugxxf8Hub7oVm5FjQ5pK
         K0/FIb/grOLMXyha2QXvxF0Lzy6YWKgfEqPhPqDTL29H1+0dHnwesc0FoWLB3m/AmP5I
         XtcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbfETUWkoKrz8KpgLMpVaNiYtHUft4XK4dK+lXdh4SGa00c8BHHVG9Geim4TsL6VfTek0=@lists.linux.dev
X-Gm-Message-State: AOJu0YzljLUYLTewzCkLLsGS+zKEn6sZwsYxeP8uDh4Uoz3Wg47UkckF
	xjHAyHHC5KlugVknYunORzXqfbqrCKAg5gtkN9qoskVfqmDX/9HOaXi814/fI8DVu2rfCkbjlJI
	w0DTXY3aYWebYKPNuAzA10zFqQS5m8rDENKIj6N3GJWOsg9E2xQ==
X-Received: by 2002:a17:907:9628:b0:a9a:4101:597b with SMTP id a640c23a62f3a-a9e2b38c911mr465277366b.9.1730287704841;
        Wed, 30 Oct 2024 04:28:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4ON6XbTaySPnV3R7K/gjgoiYFn4kvGUkKymLGG4I2FjjIR+75rc4iLvNfjp7Xook5FqfydQ==
X-Received: by 2002:a17:907:9628:b0:a9a:4101:597b with SMTP id a640c23a62f3a-a9e2b38c911mr465271166b.9.1730287704397;
        Wed, 30 Oct 2024 04:28:24 -0700 (PDT)
Received: from eisenberg.fritz.box ([2001:16b8:3db7:f800:98bb:372a:45f9:41e4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b30f58991sm557324566b.159.2024.10.30.04.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 04:28:23 -0700 (PDT)
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
	linux-sound@vger.kernel.org
Subject: [PATCH v6 06/10] wifi: iwlwifi: replace deprecated PCI functions
Date: Wed, 30 Oct 2024 12:27:39 +0100
Message-ID: <20241030112743.104395-7-pstanner@redhat.com>
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
Acked-by: Kalle Valo <kvalo@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 3b9943eb6934..4839dcb199c4 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -3533,7 +3533,6 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
 	struct iwl_trans_pcie *trans_pcie, **priv;
 	struct iwl_trans *trans;
 	int ret, addr_size;
-	void __iomem * const *table;
 	u32 bar0;
 
 	/* reassign our BAR 0 if invalid due to possible runtime PM races */
@@ -3659,22 +3658,15 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
 		}
 	}
 
-	ret = pcim_iomap_regions_request_all(pdev, BIT(0), DRV_NAME);
+	ret = pcim_request_all_regions(pdev, DRV_NAME);
 	if (ret) {
-		dev_err(&pdev->dev, "pcim_iomap_regions_request_all failed\n");
+		dev_err(&pdev->dev, "Requesting all PCI BARs failed.\n");
 		goto out_no_pci;
 	}
 
-	table = pcim_iomap_table(pdev);
-	if (!table) {
-		dev_err(&pdev->dev, "pcim_iomap_table failed\n");
-		ret = -ENOMEM;
-		goto out_no_pci;
-	}
-
-	trans_pcie->hw_base = table[0];
+	trans_pcie->hw_base = pcim_iomap(pdev, 0, 0);
 	if (!trans_pcie->hw_base) {
-		dev_err(&pdev->dev, "couldn't find IO mem in first BAR\n");
+		dev_err(&pdev->dev, "Could not ioremap PCI BAR 0.\n");
 		ret = -ENODEV;
 		goto out_no_pci;
 	}
-- 
2.47.0

