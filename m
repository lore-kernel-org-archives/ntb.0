Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B8A1509BD
	for <ntb@lists.linux.dev>; Mon,  5 Aug 2024 08:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722844933; cv=none; b=jdfLkH0O0U3ycmVxBbKA6yEg5tlPR9fd8nndiVz/MouqIyyWBN6knsClX8DgERb+eEyujZgywJQWsjwhQusR+/D0Hylyugfij/z6lWWhprLZlyQofObg4vflAVwB+wypOQdWgSyEIC2P4Figos89IED68Hf6GhDXO+l97wa5le0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722844933; c=relaxed/simple;
	bh=zFYt4YA/nxrpBwmvCREd85ce7Gyci93GVdK3Ep0M2pA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YACy9eKj3UYruvDFsJOpLRst7k/9ymwCeon4mO+H37+li9EAU+uzbaYWhLb8JlQOR+f6DmO9Q1qJk/NmSLLXlGLHyYuKp94QToMSN9Oc1z3V3W3DnOP4TUDL+GnsZDL8WqFgjLbKLYd/mMea+Z6iRnl98AcQ4ZAbv+jqD6Lrd9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xhi6z174; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xhi6z174"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722844931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=18fF+PB7j6Y1mDUBH32CYamjOEignK7RbqTPKzQv2/I=;
	b=Xhi6z174DkCccWaHjj6vL659JtfzWI44u1hgJYnJQnLCQPx9EFRtpNGuXStqguD1dztAJj
	j5d0zks59T4qmHVl5RX0Yk0LGCJWr77bd5Jq7VSmNjYldhS2zCIIx6CZkDePYxfoL75fT7
	6lTy4tBFWivYAK7d99BkymM8BFYjeaM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-AKJ9BNgqNR-EULjUveOcTw-1; Mon, 05 Aug 2024 04:02:09 -0400
X-MC-Unique: AKJ9BNgqNR-EULjUveOcTw-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-58b1fe1cd9eso1900591a12.3
        for <ntb@lists.linux.dev>; Mon, 05 Aug 2024 01:02:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722844928; x=1723449728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=18fF+PB7j6Y1mDUBH32CYamjOEignK7RbqTPKzQv2/I=;
        b=WpJ/61PKIshACEktBP5+XF7/iSvqoVw8I65FhlfLMxsL3Mo+W8a3yo5CmsDhi5HuKL
         80rm4IH1jbWZkUShfIZ0cnfTQFEuKrIRyr5FELIMHakY6Jc0PLB7GZu5O9IBYDMmp0Aa
         9dC497HjCtkCYQGw3E/jqB2lINViUeZeLBabo1Q9+AU3xkok/UE/8QJ0NBxeJ1nZw7Kq
         yxaQOPWtRCRq4Ou0hUozuBZL86lh05ymr4xThW8bVbQweZMLY5PrDLgAfUsyww6i7lCu
         kQrd5pHlMFEj9mwJwUYFQXQKka5zIGXM01xaVMGscdaHl5F5T4k0CD22sbRHK63t3R/p
         0hfg==
X-Forwarded-Encrypted: i=1; AJvYcCUO/Bplo840bqCKLtyGX/Nyxh81wfCI6jc65w0V4xPVmSC6lOjMxT65XDAXwQI4S/D8y/o=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw5HsbPlOCJNrT4XU70JoCOp23vLwbWaT026nIuVOr+7s5CUzh/
	+P9kaduRfeysRbd93ORhbFp82IXcuq8vwK63KTn62CckokbMk1OYbJ7MMkhtAD4QL01O4Id2Tp+
	MXnwfh+9pYEYYd21h0eLznC3vWWT+zHqKz/gwMQ5fcZvselTaOw==
X-Received: by 2002:a17:907:3da7:b0:a7d:a4d2:a2a7 with SMTP id a640c23a62f3a-a7dc4e50c01mr456319966b.3.1722844927331;
        Mon, 05 Aug 2024 01:02:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkXCT45DdZBHWQzoU0ORUWv+2ODBb2GUKjo+7GIEAxb39igJSvCRB2n7e9CZjTjRwueB8GGw==
X-Received: by 2002:a17:907:3da7:b0:a7d:a4d2:a2a7 with SMTP id a640c23a62f3a-a7dc4e50c01mr456317566b.3.1722844926788;
        Mon, 05 Aug 2024 01:02:06 -0700 (PDT)
Received: from eisenberg.fritz.box (200116b82df07e000a5f4891a3b0b190.dip.versatel-1u1.de. [2001:16b8:2df0:7e00:a5f:4891:a3b0:b190])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7de8d0868bsm277958966b.143.2024.08.05.01.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 01:02:06 -0700 (PDT)
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
Subject: [PATCH v2 02/10] ata: ahci: Replace deprecated PCI functions
Date: Mon,  5 Aug 2024 10:01:29 +0200
Message-ID: <20240805080150.9739-4-pstanner@redhat.com>
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

pcim_iomap_regions_request_all() and pcim_iomap_table() have been
deprecated by the PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
pcim_iomap_table(), pcim_iomap_regions_request_all()").

Replace these functions with their successors, pcim_iomap() and
pcim_request_all_regions()

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

