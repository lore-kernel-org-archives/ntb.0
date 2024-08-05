Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EEA145FE2
	for <ntb@lists.linux.dev>; Mon,  5 Aug 2024 08:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722844929; cv=none; b=ChD8ySHeysVR8Pg+qzY8KI88fBWQRhJYf5uSqiCteHkzjYWcxHkfXqUIZWskQfy0KaT9P3rLOcaHV4J9mzLdh7qPWlBBikLf6/3jIFSHlz+2p5UUWZ5PkNXBzdNo2hsfcQ++HcEfWdUlrKF8EU2dbuoKqWI9FAGC7MOhx4DFpt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722844929; c=relaxed/simple;
	bh=3SzrIAjNMfo/xyaY6qD0WMNLA83hhVRZkGTby43i1Yw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i0NhYp0dOasSeDiKcsIfY1bb2oLJy8y4RaU4HZknKUkpj7V1HHhU5KnlJ+fsbIo4yCn4PMY8COlU0pTyyE8/VsQ6aezbdCVLM0/LZjEArmImJ+j7E8d22ukwQmc9eHOlwqPJ06qrKUFRuGLKbNcvxkUqqVk/rsFk9wDIxJpMHH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H+OZgpti; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H+OZgpti"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722844926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FOOMdJZrThW/VVTNtW/8cjfUGb38v95FiRlM9skachc=;
	b=H+OZgptio28nPEyhAu9+AAqD3kBcxWDc+wrnZb4eujOKTlYwagy3IG12zgtdFcPm2sgnQF
	OCAVX6JeuluI69vmtm9oDaOcvUcJkwvlrwZErbZcTqV9c8V6MQVoq+de0WHHytSQbuNLpn
	evRP1OP+wXFQ4pNijBfYE8+Vyc2NnB4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-c85hvMgPNGuRDrjXmrLT-w-1; Mon, 05 Aug 2024 04:02:04 -0400
X-MC-Unique: c85hvMgPNGuRDrjXmrLT-w-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a77e377501cso105859466b.0
        for <ntb@lists.linux.dev>; Mon, 05 Aug 2024 01:02:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722844923; x=1723449723;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FOOMdJZrThW/VVTNtW/8cjfUGb38v95FiRlM9skachc=;
        b=Ya/dto7th2euqUGtoRlxrnLbdhPYhsiNr5CDmnQiHJBWlMcs2BDH6f4t+p+frjr76y
         NFkowuyv8U9WkKeJ309YAOvwHiMHGPYkRQUqVL02LSqzlMjrn/CasdE28Ajb+MTmjO6S
         h4Us1TpzMFQTxcQ1YZSRfFspqf9wCWREJHv3OW7QWIGQsk5tJoeHUHGY2B9LMqMcjah5
         22mtf9OJJok2ekCoQI2aG9AVlKA+DVul8dOKmKfN/EB2TTW54mXxVUZ3JJFY8MwkZMKN
         vjE2N+V2Mzh8AnyDyOz3Op7RoZANe0PdF5WZjLT+z4zeLP83bUQYtg/Z1cA/swtFtcBm
         LQIA==
X-Forwarded-Encrypted: i=1; AJvYcCWWujU5dBaWqjBQl/ewczd28FyGW1uAi7EOsJXqYWifc3kkDzC9ZLp8R5fjD3jXSUFMoR4=@lists.linux.dev
X-Gm-Message-State: AOJu0YzfaFrqGJ/4FjnMY44StDeiIa5xhV76BaqeuzGw0AYTO66Rv3Tq
	+D6Jd+FbKEFdadPa/Dz9mn9zBcR9AjqYf32qhqqWNM+XB4bk/ZZFqCgTgKGHbIn4BiZldLSceu8
	usAIAvRlKE9e9rxixtPjbfDawGC1futt0clmP0mqpHWCtmgJNyQ==
X-Received: by 2002:a17:906:6a0f:b0:a7a:aa35:409c with SMTP id a640c23a62f3a-a7dc512cdc8mr479716766b.9.1722844923330;
        Mon, 05 Aug 2024 01:02:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTS/SS1ApAhdkVa3Kv54fKJw0UKK+zRKzrvkYAaC1yWAeQnQdQA8voDIcJKUGPudzDl20u8A==
X-Received: by 2002:a17:906:6a0f:b0:a7a:aa35:409c with SMTP id a640c23a62f3a-a7dc512cdc8mr479712266b.9.1722844922775;
        Mon, 05 Aug 2024 01:02:02 -0700 (PDT)
Received: from eisenberg.fritz.box (200116b82df07e000a5f4891a3b0b190.dip.versatel-1u1.de. [2001:16b8:2df0:7e00:a5f:4891:a3b0:b190])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7de8d0868bsm277958966b.143.2024.08.05.01.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 01:02:02 -0700 (PDT)
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
Subject: [PATCH v2 00/10] Remove pcim_iomap_regions_request_all()
Date: Mon,  5 Aug 2024 10:01:27 +0200
Message-ID: <20240805080150.9739-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changes in v2:
  - Fix a bug in patch №4 ("crypto: marvell ...") where an error code
    was not set before printing it. (Me)
  - Apply Damien's Reviewed- / Acked-by to patches 1, 2 and 10. (Damien)
  - Apply Serge's Acked-by to patch №7. (Serge)
  - Apply Jiri's Reviewed-by to patch №8. (Jiri)
  - Apply Takashi Iwai's Reviewed-by to patch №9. (Takashi)


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
  serial: rp2: Replace deprecated PCI functions
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

