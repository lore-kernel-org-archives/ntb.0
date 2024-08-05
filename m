Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC829158A10
	for <ntb@lists.linux.dev>; Mon,  5 Aug 2024 08:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722844950; cv=none; b=KIDXJ2ig4yiPfdjmA3L+Xqw3ZLFCfNJ/bpBCxWG3E9EChdtYJV5rFCmApCPfBlA5tAn1AgnE4uLLNvBjWNcsU3UhonDmjBnRPjOAXuYSX853mj7j8fo3pHsg6DQgEcLIvTDBMc+siVf3vlOppJOeHu7lOGoh/DFumZKKP4S6Uxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722844950; c=relaxed/simple;
	bh=Yo+Ns2b3URhNU5TB+CvEDymuFVQ4WXMZyjfGA5NqkhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GFqvlWf8UTtD2s1ngcZmxY6KOVKZP0N9KPcfFaiPuOMG1QQKqAYuaz9Tagq+zi2VEZ9n1PAUirIIjyS6PQExPXfp9avmRsNkrQGQWqj/BbR53qKU1aBKR+i3++vvpq2GCKdmodxUBSPYG/u/xMkVK5xG9QUpl7041VZEMQ+uNYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fd+M5Xp6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fd+M5Xp6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722844947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o1zjbMHqB0PmusT+nYJ2VtJ9oVjApsikg9aShs5wyaI=;
	b=fd+M5Xp62ComOBT5pAdrqg8enuuGioJPwVtUFN89WYPaJHSsHVfS8RW0cLSsDY3PDmfZtP
	Zlp5KNIYKAhZoeQf9hxZbXipRLZy3eE2rIhN6U3TjKQ1l7mCoJszxYcGCUwcZuNH6aHvIo
	Ust3Tro0sFpRz+rXWRqDvjw4r0VCSMY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-_O9PpP5EM--lbvWIzI-9MA-1; Mon, 05 Aug 2024 04:02:16 -0400
X-MC-Unique: _O9PpP5EM--lbvWIzI-9MA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a77e377501cso105865066b.0
        for <ntb@lists.linux.dev>; Mon, 05 Aug 2024 01:02:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722844935; x=1723449735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o1zjbMHqB0PmusT+nYJ2VtJ9oVjApsikg9aShs5wyaI=;
        b=WpBalYPVYlXUtGHlVHUfK0DnxIomdHvx0Hz+cPl9pvgfIT+HP6eG2fc06V+mwKDMaD
         ZjVZXthaz1Q21B5/hIP6CEaXjGddNWAusqG2XI/HCz3CT1UUoncXacyWfxmvWDXVbZcf
         lTiNOu11PPKSxALrFR6FVHI+/2ixjh/GXRxy1djdCl++o0ReQcLVRZnL7wnOMYqDYilr
         teN8mx9gxa2vS1lj5rHoQjJQ7z4ixel1ZUJZrx1hfAIw6O/zkaGop0bbB5vqlmkvaZG9
         swgLgYUZ5fX79K6kD4DjD/S4kbyvtFpKYgQn7ZQqjeOQDxYzTVJFpTqbRSx9qHLZlH5F
         CQ8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVMqGn+2E+PYVMSQeJSfJi7C2rfFBgGug3MZPnZQwjwL1Ad1rnq7uVUBaPdRKxjN/vkffY=@lists.linux.dev
X-Gm-Message-State: AOJu0YwjgxAnsOeH0rF4uKFAnJ257hgkzWtBUTUFkIOrqrwXAnwG1XS7
	eV0hxdFvwpsLBcrbwTBDDyUTH2zT3FAS5zNmJENLdN+xtc71sBW61BR3/Tba97tYwwxkv3xea5m
	PMg6qkS0yaSoFzJMH8ekX6R0skJvOPcF6tBWDil6guLc51jbjkg==
X-Received: by 2002:a17:906:f583:b0:a7a:81bb:ceeb with SMTP id a640c23a62f3a-a7dc4ae7defmr473037666b.0.1722844935144;
        Mon, 05 Aug 2024 01:02:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKuHik2ajcs17LmubcaIaCUkrAqH7M1NRkgMmBZVBefF6pfGv29aIhP8ECYMtriJwflIFmgg==
X-Received: by 2002:a17:906:f583:b0:a7a:81bb:ceeb with SMTP id a640c23a62f3a-a7dc4ae7defmr473031766b.0.1722844934632;
        Mon, 05 Aug 2024 01:02:14 -0700 (PDT)
Received: from eisenberg.fritz.box (200116b82df07e000a5f4891a3b0b190.dip.versatel-1u1.de. [2001:16b8:2df0:7e00:a5f:4891:a3b0:b190])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7de8d0868bsm277958966b.143.2024.08.05.01.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 01:02:14 -0700 (PDT)
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
Subject: [PATCH v2 06/10] wifi: iwlwifi: replace deprecated PCI functions
Date: Mon,  5 Aug 2024 10:01:33 +0200
Message-ID: <20240805080150.9739-8-pstanner@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240805080150.9739-2-pstanner@redhat.com>
References: <20240805080150.9739-2-pstanner@redhat.com>
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

