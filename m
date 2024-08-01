Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616481BD50A
	for <ntb@lists.linux.dev>; Thu,  1 Aug 2024 17:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722534404; cv=none; b=eIOifDGPwPCmokvf8sf4Eh9hqg1Y8hLMFFdj0UooXhu1ZPxXU27Yvy1La/N1+c+i0xxQgeZJUaqid5Anfj/AKHp7xtKaw15uJ5IYkyzohZp6BwnZiHlhPTby0jffT46lzwOX7Foj+y7+AZaD0LeqU9+uCmY2rBPhmTuH1kL5moU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722534404; c=relaxed/simple;
	bh=Yo+Ns2b3URhNU5TB+CvEDymuFVQ4WXMZyjfGA5NqkhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=juGEX5Yse1IGSK3jOeAK+MoUThJMCgv9qbA1JDoHjkjFaRpSRpdnLGaYj5lUfNsZeT5yjHlSwpMQHoffF8Rd1JwESWGLWyNJRzueqaxtByNs9aCYtAnQNGQTYqwk4n+hx+qyT6MXo9vNTNyEQXhx69fAaui3+PrGKNoZ6TP7iVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LxteI0jM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LxteI0jM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722534401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o1zjbMHqB0PmusT+nYJ2VtJ9oVjApsikg9aShs5wyaI=;
	b=LxteI0jM+uuLRi00CAoNg3koEq9gtPQbWsWqQwlCNTsmcenYIs/aq8f24N8RwIBNjYixmO
	Ef3yW7KMdLvBVjB98SjbnqWK8zSHdp4UGC3TjfmAskvnI2CM6q3pcK5s2gkCO5Vveycf+E
	6G5hFIlE/6Ywj3ajInJe56bjWIO65T4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-0BeDZqNuMPiaFjM8jNApSA-1; Thu, 01 Aug 2024 13:46:40 -0400
X-MC-Unique: 0BeDZqNuMPiaFjM8jNApSA-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5af1a5a36feso826524a12.0
        for <ntb@lists.linux.dev>; Thu, 01 Aug 2024 10:46:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722534399; x=1723139199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o1zjbMHqB0PmusT+nYJ2VtJ9oVjApsikg9aShs5wyaI=;
        b=eAru2sQV4RqSaOSnvM/JD9cyT5f4cwVYaz8wgDItC210ftZuWsA8pxawbaQ+scBEVu
         dg9y0J6NU6QF98rmG2VF6OjBv3qyaJbhggwzXMrC555JdYSc/SM+8Oe/D1PoL78K5BjF
         Oit+pNKTekYH9YqVIOp6K0jMilYvcKLsJNKnAhoYXeimuqcp8zH/fv4Kd+c7/DA0VwpN
         kehIHgzGW2fDtbEfNiitbys/8BWKkcYuNPs+rSKw6VeD6SJ6h/qZQ32SRL4/jS+4DxcP
         pE8oUnvFLVjtotZ6u5YaZXXx+034bt64mJXHyz7hco7iYC8oVYeFacTCUDO18yfY26ub
         OeCA==
X-Forwarded-Encrypted: i=1; AJvYcCWIwa62BPr3dyJz0HP6s2NzwL7W7Hbx9PngSVZWXn3n7j6GnqXe6SRzmBcyCfWDZcYBB44=@lists.linux.dev
X-Gm-Message-State: AOJu0YzX3GUtM2HqHeY0x04aqjn/oI0nCoasZrszpO+7ygsju876mpAv
	V3RhDGsImqThy5At552cEeHuO6vh3qfGtHKAYqxdw5ZtY//pFk1RrO6Hwy+LS82+AwRk0C4FYC9
	xDNRbwjX/elfEYlf/m18P680UuetfHgVzVzwnldWkIJGcb7+mvw==
X-Received: by 2002:a17:906:6a0f:b0:a7a:aa35:409c with SMTP id a640c23a62f3a-a7dc512cdc8mr42359166b.9.1722534398849;
        Thu, 01 Aug 2024 10:46:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2sgeoJAH08bIv5eqrzG1JRTqpxFnJOnIuiO4lxHc4kHOgcS9yd5RBKc96AOogw2uLapJ10g==
X-Received: by 2002:a17:906:6a0f:b0:a7a:aa35:409c with SMTP id a640c23a62f3a-a7dc512cdc8mr42353766b.9.1722534398332;
        Thu, 01 Aug 2024 10:46:38 -0700 (PDT)
Received: from eisenberg.fritz.box ([2001:16b8:3d4b:3000:1a1d:18ca:1d82:9859])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9e83848sm5339066b.177.2024.08.01.10.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 10:46:36 -0700 (PDT)
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
Subject: [PATCH 06/10] wifi: iwlwifi: replace deprecated PCI functions
Date: Thu,  1 Aug 2024 19:46:04 +0200
Message-ID: <20240801174608.50592-7-pstanner@redhat.com>
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

pcim_iomap_table() and pcim_iomap_regions_request_all() have been
deprecated by the PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
pcim_iomap_table(), pcim_iomap_regions_request_all()").

Replace these functions with their successors, pcim_iomap() and
pcim_request_all_regions()

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 719ddc4b72c5..6b282276e7b5 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -3534,7 +3534,6 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
 	struct iwl_trans_pcie *trans_pcie, **priv;
 	struct iwl_trans *trans;
 	int ret, addr_size;
-	void __iomem * const *table;
 	u32 bar0;
 
 	/* reassign our BAR 0 if invalid due to possible runtime PM races */
@@ -3657,22 +3656,15 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
 		}
 	}
 
-	ret = pcim_iomap_regions_request_all(pdev, BIT(0), DRV_NAME);
+	ret = pcim_request_all_regions(pdev, DRV_NAME);
 	if (ret) {
-		dev_err(&pdev->dev, "pcim_iomap_regions_request_all failed\n");
+		dev_err(&pdev->dev, "pcim_request_all_regions failed\n");
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
+		dev_err(&pdev->dev, "pcim_iomap failed\n");
 		ret = -ENODEV;
 		goto out_no_pci;
 	}
-- 
2.45.2

