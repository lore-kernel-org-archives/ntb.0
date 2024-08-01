Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A121B8EA6
	for <ntb@lists.linux.dev>; Thu,  1 Aug 2024 17:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722534391; cv=none; b=jYJ21NXp1X70i86hbKF7tvuWg0+cqttXmfSJnbVIdEcqvM1/iPIS8Dfw0JslPItticYyMKv/XAYuEmEV4NzE/wNKY0ztNkN1sQ7A1TFy86FeTgsMR/OSw+5yZ8U9mn2+h8wpWcUhXpDVNcvr6mgEDL2d4vKGSmN103wpnSVhYbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722534391; c=relaxed/simple;
	bh=lqUBCglzn3f4G/USTNUZWIqwmTKyh9NTx5PNNci0oUk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Kwlus77ezNa5B4Z9oPSTCmnNWQb+bLGZN9T45ePD5xXqG04cqII7vun4jbR2kPR64vwOAkyoeAfs8WypNa6kSt3o1+3DU7ELGMeg+fh9Jsdw24cxz35G5i5p9/esND5vHXMlc1mYg1Cuh4/aY0LrLVInOP+B9cBdQVHe0Cf3PCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CSXu7boh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CSXu7boh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722534389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IdydxZIGJr3ghOK2fEzH68i3FlzUyX1ZkiOar1Iub4w=;
	b=CSXu7bohUAzbGM7wq83o5vu+CJ2A6OiDO65PAzAJVr8Ad77tY7cYrKOuaMtFaVdiMcvA7W
	Okral+yoxTKXJiYGxf75MLqV7F//ZHrNwBWFqPMh2TU84eR5JW4PFZKS+mgXmgFTeV8B4n
	p7WJ2YRQpaEJ/mvwCh04GKuxrR+pNU0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-tCZ2qR0vNhO53fss1cuSPQ-1; Thu, 01 Aug 2024 13:46:27 -0400
X-MC-Unique: tCZ2qR0vNhO53fss1cuSPQ-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5a11cd40426so1072199a12.1
        for <ntb@lists.linux.dev>; Thu, 01 Aug 2024 10:46:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722534386; x=1723139186;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IdydxZIGJr3ghOK2fEzH68i3FlzUyX1ZkiOar1Iub4w=;
        b=Lh4Q7R4Dda1kzpOl4Edrpq2xAtldM0fo3k8CFJfBQZT21VI5s0RzTp8ZnLJqF0GN3k
         wqe6qP3hBh85x6c0IIvsSaZC6HoxWKko5O02Fxgn7//CHDFwaa6eehz2YSr/mKzd5R6O
         CmEMaG9PCDBqriZn/mN+jLPNYHPa8Lf2OZ+VIEtNBFs1YftAU6ka9iO1zacN9LzzhCKT
         GLQ1M62FEFr/AiwVc3bc+PaeLRnYMHMWkVeCFFdghP/l+ieFLiKczsgNHIGbWWbLFTXk
         EL//PAGseitBkVeD4qvLB30nMJdVZQEsoPrkoIXMUDj0rnDfGqFBC6GC7CDzaW8z+Pzv
         4Bfw==
X-Forwarded-Encrypted: i=1; AJvYcCUMuoLKVc9/3PKBp47zhNo2K3P+avKWrJ5pPUwSnM5JRc7BaiYwA2R5LyMq0xVO8O0Yf0Y=@lists.linux.dev
X-Gm-Message-State: AOJu0YxOrIdVcnB1FDAqnulW/yeTe+Z9bs5F9OHOETQ3bb+Crqs2/YrS
	hZ5XsilklFd5UuXREisc63sthfWwOy9bRvOFdrnUae9fGiwfzROc6JR6pW1J98hGousrld2+zeF
	h8XvoI/TAX4u5yBQH7sOYa/wezzmBcYM40/62bvNqGS4l4JrRtA==
X-Received: by 2002:a17:907:3da7:b0:a7d:a4d2:a2a7 with SMTP id a640c23a62f3a-a7dc4e50c01mr44423466b.3.1722534386287;
        Thu, 01 Aug 2024 10:46:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5Km5jd9cOTYruluysPjH0y6sNbWlr0amJSpmaneqU1ki99pbWjXrxV2Pr+1gBC+OPuM4UGw==
X-Received: by 2002:a17:907:3da7:b0:a7d:a4d2:a2a7 with SMTP id a640c23a62f3a-a7dc4e50c01mr44419866b.3.1722534385669;
        Thu, 01 Aug 2024 10:46:25 -0700 (PDT)
Received: from eisenberg.fritz.box ([2001:16b8:3d4b:3000:1a1d:18ca:1d82:9859])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9e83848sm5339066b.177.2024.08.01.10.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 10:46:25 -0700 (PDT)
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
Subject: [PATCH 00/10] Remove pcim_iomap_regions_request_all()
Date: Thu,  1 Aug 2024 19:45:58 +0200
Message-ID: <20240801174608.50592-1-pstanner@redhat.com>
X-Mailer: git-send-email 2.45.2
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

Hi all,

the PCI subsystem is currently working on cleaning up its devres API. To
do so, a few functions will be replaced with better alternatives.

This series removes pcim_iomap_regions_request_all(), which has been
deprecated already, and accordingly replaces the calls to
pcim_iomap_table() (which were only necessary because of
pcim_iomap_regions_request_all() in the first place) with calls to
pcim_iomap().

Would be great if you can take a look whether this behaves as you
intended for your respective component.

Cheers,
Philipp

Philipp Stanner (10):
  PCI: Make pcim_request_all_regions() a public function
  ata: ahci: Replace deprecated PCI functions
  crypto: qat - replace deprecated PCI functions
  crypto: marvell - replace deprecated PCI functions
  intel_th: pci: Replace deprecated PCI functions
  wifi: iwlwifi: replace deprecated PCI functions
  ntb: idt: Replace deprecated PCI functions
  serial: rp2: Remove deprecated PCI functions
  ALSA: korg1212: Replace deprecated PCI functions
  PCI: Remove pcim_iomap_regions_request_all()

 .../driver-api/driver-model/devres.rst        |  1 -
 drivers/ata/acard-ahci.c                      |  6 +-
 drivers/ata/ahci.c                            |  6 +-
 drivers/crypto/intel/qat/qat_420xx/adf_drv.c  | 11 +++-
 drivers/crypto/intel/qat/qat_4xxx/adf_drv.c   | 11 +++-
 .../marvell/octeontx2/otx2_cptpf_main.c       | 14 +++--
 .../marvell/octeontx2/otx2_cptvf_main.c       | 13 ++--
 drivers/hwtracing/intel_th/pci.c              |  9 ++-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   | 16 ++---
 drivers/ntb/hw/idt/ntb_hw_idt.c               | 13 ++--
 drivers/pci/devres.c                          | 59 +------------------
 drivers/tty/serial/rp2.c                      | 12 ++--
 include/linux/pci.h                           |  3 +-
 sound/pci/korg1212/korg1212.c                 |  6 +-
 14 files changed, 76 insertions(+), 104 deletions(-)

-- 
2.45.2

