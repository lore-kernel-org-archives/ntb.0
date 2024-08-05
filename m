Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04196158869
	for <ntb@lists.linux.dev>; Mon,  5 Aug 2024 08:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722844949; cv=none; b=Yeo9TsdHcIvbTxeVED/WyzS0jl052L/BTSlvot6zdBkNLFZWsKdqc6xKux56hzCk9j9kBGvm4hcDiShGmI6P8kTDdt+/SocPeVyK47+VutfBff7iqF6FYWwdlGTHW6bLmS07nfmBN8EOvaD4UJrPR03PO7MdkAKKdU6pIC/T54k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722844949; c=relaxed/simple;
	bh=+Vm9OnIcejlQrHC+fUOsuOHdlE3r5QhdQyIHmCJJHiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SegrWlXkU9zkAiWv9+nRAbrKaOzb4L6iWyPoqOVNkuRWQYBFQyCzHYPv5VvUBRckkFhcARw+NXHacezAzCpuKrCYUDT67P1lW6B/j3rYbdD4hx6q/SurmhtQYv6AtbJQQrjAHMUhuzMLkyVBTNEKpge+9r4IitiNydcrEghLzpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GSWffwn8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GSWffwn8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722844947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vfEZOSpUlm3iGBljRVh5bMCTZxfFQAshsGvE6Xk1c3w=;
	b=GSWffwn82vr9spxI5BbiurN5S48qVlUhVWdkdFfI915uKxehtujGykdsXAIMBezzB1xQzO
	7Y5GaewZov3aPdPXCAGNhMZn+7jAvTFcaDwpBuVp0WSQmy/so3PHGxS5g9vHedGj5ad9VU
	l8o1Fqq1JQwDhUCn6JJXvoSxdjbwm2g=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-iZ_6MPyyPHyqMvfkqZal0w-1; Mon, 05 Aug 2024 04:02:25 -0400
X-MC-Unique: iZ_6MPyyPHyqMvfkqZal0w-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-52efa5d94cdso1415265e87.0
        for <ntb@lists.linux.dev>; Mon, 05 Aug 2024 01:02:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722844944; x=1723449744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vfEZOSpUlm3iGBljRVh5bMCTZxfFQAshsGvE6Xk1c3w=;
        b=QhRegrWVd8PZ6eEvOLi0PSEs9Oumq4rZ04P9dqla0v1hNjyPpl4lcbM8ksWAdKWE+i
         kiOKzYJTEpodkKnPHnKSJJ5fXmbeBKyagiUO5dM2V5/TmCrCW1ZTX5o72k+EqMpKZw/o
         p05bj96hg1Zl66qu0tmvzf8WhjZaB7uINWNYRLPL2MldBgx/NL8BKYHB3TWosxP3xnJa
         JEFyvaP8vHgWN1IWOw9TdJDBl9DVH7T9LWxrsHs5HnImloPJk19Sob1nDAQChf+4eSRq
         APjoCb5nODU/YzPSMMKq20qSZlgyd5ELIxr41hCeb1t80HQ7h9tdSj0qyAnzD38cUyNd
         JtkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoSYomKEO58hATeWJ0etoUYI7iZRjEsXrs2G/h9naAx0H3zre5ZMp6vagciqBBDRcVLhI=@lists.linux.dev
X-Gm-Message-State: AOJu0YwXHrlEoUh126jKnujwpKdZzDJNdEaY5m7ZMV6DjKLh0Rf/M0ZF
	pcPRP8nK33nPi7EflUrg9Y8ZgnclNfmMu8bjlfzyLWHU01qBCOidNeC9tXdciDLeADghSXBCxDI
	RjEWjF0Xq2OyMve46dp4qnAFGJWdgqyL9LAp8nCR5IQWr19HiCA==
X-Received: by 2002:a05:6512:3a6:b0:530:bc24:bfc4 with SMTP id 2adb3069b0e04-530bc24c039mr3271856e87.2.1722844943094;
        Mon, 05 Aug 2024 01:02:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLrQUH6nLB0tosEaFXlZobSC/44isugq3n0Zf5l544zGhgNP/6Ntw7hCPDneElIUaU4eFGBw==
X-Received: by 2002:a05:6512:3a6:b0:530:bc24:bfc4 with SMTP id 2adb3069b0e04-530bc24c039mr3271816e87.2.1722844942669;
        Mon, 05 Aug 2024 01:02:22 -0700 (PDT)
Received: from eisenberg.fritz.box (200116b82df07e000a5f4891a3b0b190.dip.versatel-1u1.de. [2001:16b8:2df0:7e00:a5f:4891:a3b0:b190])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7de8d0868bsm277958966b.143.2024.08.05.01.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 01:02:22 -0700 (PDT)
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
Subject: [PATCH v2 10/10] PCI: Remove pcim_iomap_regions_request_all()
Date: Mon,  5 Aug 2024 10:01:37 +0200
Message-ID: <20240805080150.9739-12-pstanner@redhat.com>
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

pcim_iomap_regions_request_all() had been deprecated in
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
index ac9ee7441887..895eef433e07 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -394,7 +394,6 @@ PCI
   pcim_enable_device()		: after success, all PCI ops become managed
   pcim_iomap()			: do iomap() on a single BAR
   pcim_iomap_regions()		: do request_region() and iomap() on multiple BARs
-  pcim_iomap_regions_request_all() : do request_region() on all and iomap() on multiple BARs
   pcim_iomap_table()		: array of mapped addresses indexed by BAR
   pcim_iounmap()		: do iounmap() on a single BAR
   pcim_iounmap_regions()	: do iounmap() and release_region() on multiple BARs
diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index 0ec2b23e6cac..eef3ffbd5b74 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -952,62 +952,6 @@ int pcim_request_all_regions(struct pci_dev *pdev, const char *name)
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
index 5b5856ba63e1..8fe5d03cdac4 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2294,8 +2294,6 @@ void __iomem *pcim_iomap(struct pci_dev *pdev, int bar, unsigned long maxlen);
 void pcim_iounmap(struct pci_dev *pdev, void __iomem *addr);
 void __iomem * const *pcim_iomap_table(struct pci_dev *pdev);
 int pcim_iomap_regions(struct pci_dev *pdev, int mask, const char *name);
-int pcim_iomap_regions_request_all(struct pci_dev *pdev, int mask,
-				   const char *name);
 void pcim_iounmap_regions(struct pci_dev *pdev, int mask);
 void __iomem *pcim_iomap_range(struct pci_dev *pdev, int bar,
 				unsigned long offset, unsigned long len);
-- 
2.45.2

