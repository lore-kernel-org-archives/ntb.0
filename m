Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A8B20F5CE
	for <ntb@lists.linux.dev>; Wed, 16 Oct 2024 12:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729082521; cv=none; b=j1eqtbwFnpd9BJ18DhTSiuFN3TQ7r36P9NRbJmfD+t1HsI/KckrNAS/F3oImUmyBY86VTHLHHqDNj9MXQnbf8KSxrwIulWjn8sdsqruCCkxPF2kQtkeiBC9Or7wt3Uq/B8qHmq7BpG0TATA998DDucAvsb8Z8eIDSXZ4jj041NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729082521; c=relaxed/simple;
	bh=KRhL2deOZRHNfuo7/CizyodCPj2p+YqlhuhaNJFSYuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hui2HJZZDotlGp0tzZrLVLfTjHxLuIKquVvniHQCUZdph5sYUGwUdD7hXqTwnVKjcq3KDtdcn1zWGAoIgTCuUWUoyuz/YGVwO6UuHG3PPJlYz2PjGs216fQgSlMzbU68o+jBEZIAF5tHh6/mv+5ASFcFr92ZbrPzH44Coc9y42Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dSAaofN3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dSAaofN3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729082518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oH83zA24aoDnwtpuZ+wclLhu+n7qeaaZUv7+D6hfs+0=;
	b=dSAaofN3gTAsghdXGLb0CK2qlLGpTSdcXh4jMx2S2MKf0S7CBDJru6GlMq1IXpG/NbwGEo
	j5ezpfYflhM6qFqODMcz6NlwAr/lmEJTGA5P2PqqDMToFnCzLLe8aTq4Fx0w1HBRa8UFEV
	ElxKHE4H2X3ALpqdj+8q7aMAJOZ5aEM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-cR5B1GhHMLeUY7a_vAW7OA-1; Wed, 16 Oct 2024 08:41:57 -0400
X-MC-Unique: cR5B1GhHMLeUY7a_vAW7OA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37d4a211177so3305752f8f.0
        for <ntb@lists.linux.dev>; Wed, 16 Oct 2024 05:41:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729082516; x=1729687316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oH83zA24aoDnwtpuZ+wclLhu+n7qeaaZUv7+D6hfs+0=;
        b=df3GwYnafsBB7E82SqpQu3BrVcq6Dg5twWZcCe1WoPM30WxwqwapXprbZYpn79D4a0
         iH8bka0T+7jAC3zZbExdqN4gv+M5YtnwjlYEYa1GlU4JMlb1FY763zsKQUwe9fm0JjqB
         z3dQjPiYzFMDVMJH9tH1CYRlaV4YO24tN8uK42ijWXcXlcqObBbUA2s8WDA8se9mZLTw
         TLqw8KZRwlzeR3tzv3PcGgLcV87j1PL+VGP4BQ1EGTdsBQkhwveOXJ7T3QJCEx2MhUa0
         GfO89cdl60QjOTgR8Ag+FXL/31QMTlk6VP+4ik4nIczvRrF3Mc8hPVjIAb4P7mxxnybS
         Nnbg==
X-Forwarded-Encrypted: i=1; AJvYcCVGFhop3VpVaqKQFJTuiMl6APZL/q2eIBC7gIHl+010yV9dgTkAht0G7IeuIWHnobYYb0Y=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz1Q46qBhENPmapTsm2NGsu+VNBhIw/kLbTuBCg5NdnsBUTrSdF
	Tm0X1rlg58mnbRq42iwietotYaxvFWJ6p1msY0ASNGeX1dUft3IcxqRkQ5kp8H8y3lFCijE5hEN
	PpZ/w415U2Ljz0ZsISwwKlUC62STrS55uxrYth5sdZUiwFSPiOg==
X-Received: by 2002:a05:6000:e51:b0:37d:452b:478f with SMTP id ffacd0b85a97d-37d86bb6b99mr2654876f8f.4.1729082515861;
        Wed, 16 Oct 2024 05:41:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFK2H8/hCpU0cwTi4SjNpk9gLTo3Rp+q9K7qNZEaDsuWbxh1ss7QKO67/oTjHSIwVlBMGEQyg==
X-Received: by 2002:a05:6000:e51:b0:37d:452b:478f with SMTP id ffacd0b85a97d-37d86bb6b99mr2654843f8f.4.1729082515414;
        Wed, 16 Oct 2024 05:41:55 -0700 (PDT)
Received: from eisenberg.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa8ffd6sm4246879f8f.50.2024.10.16.05.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 05:41:55 -0700 (PDT)
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
Subject: [PATCH v4 07/10] ntb: idt: Replace deprecated PCI functions
Date: Wed, 16 Oct 2024 14:41:29 +0200
Message-ID: <20241016124136.41540-8-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241016124136.41540-1-pstanner@redhat.com>
References: <20241016124136.41540-1-pstanner@redhat.com>
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
Acked-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/ntb/hw/idt/ntb_hw_idt.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
index 6fc9dfe82474..544d8a4d2af5 100644
--- a/drivers/ntb/hw/idt/ntb_hw_idt.c
+++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
@@ -2671,15 +2671,20 @@ static int idt_init_pci(struct idt_ntb_dev *ndev)
 	 */
 	pci_set_master(pdev);
 
-	/* Request all BARs resources and map BAR0 only */
-	ret = pcim_iomap_regions_request_all(pdev, 1, NTB_NAME);
+	/* Request all BARs resources */
+	ret = pcim_request_all_regions(pdev, NTB_NAME);
 	if (ret != 0) {
 		dev_err(&pdev->dev, "Failed to request resources\n");
 		goto err_clear_master;
 	}
 
-	/* Retrieve virtual address of BAR0 - PCI configuration space */
-	ndev->cfgspc = pcim_iomap_table(pdev)[0];
+	/* ioremap BAR0 - PCI configuration space */
+	ndev->cfgspc = pcim_iomap(pdev, 0, 0);
+	if (!ndev->cfgspc) {
+		dev_err(&pdev->dev, "Failed to ioremap BAR 0\n");
+		ret = -ENOMEM;
+		goto err_clear_master;
+	}
 
 	/* Put the IDT driver data pointer to the PCI-device private pointer */
 	pci_set_drvdata(pdev, ndev);
-- 
2.47.0

