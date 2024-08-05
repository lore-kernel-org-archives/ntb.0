Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57C714A634
	for <ntb@lists.linux.dev>; Mon,  5 Aug 2024 08:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722844930; cv=none; b=UMpjr50gSHUYtA73MGWyYquymReMYIRaQSJgQsPG7az0mn+S6pIiHsAtsAo6MFvOjuBut5gE1W3tLDvgOfBSo+zk7aPQdbfs6+6HwjdKtpFfIc+IHJGuECMzADtBB7hmrpTWazkgLebiUaOYUjG2dNl3sITdmiPEtd4V8v7jyDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722844930; c=relaxed/simple;
	bh=PMvC17bGpWpI73UNcLQbu72jMyBfAq60m2YMRm7gpdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ykt5GIvEOc/v6Ooy1qQQeWLlwnQHoYwTBFx9di2Bmh7f3JoZ4MIvfzgKXj3pjeyrXSXtE83NKxWgLS+P5rGKe7C6cEcjJ8gzHnfrUuEmGxTP/dfax4cpOH+knRRffiVBzu/uT3dsV930oN88N86aTLd1Ez6EddS3OWXR6sYpAEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GQb9K3t8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GQb9K3t8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722844927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fCKgXS8g88Bg2YGymWSAuOupDyZ6pDfS4Oy1WWS2It4=;
	b=GQb9K3t8z5FuOxXOpG5M9Nv9FSuvnlV5hJnejW3aGtUontkTKcK1WcpvIc/bgxClirUyF9
	tttpbsjljr3XyO0IYsjFi/bkFie7FcpgySBfxiWzxq07EyDXgWqXDZ0hoIfYIBIn95ZXun
	VHNSCfXPYpkb4HcXxP9qHz/y+q96+T4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-adu4dZcLPcez2cAbrBzGsA-1; Mon, 05 Aug 2024 04:02:06 -0400
X-MC-Unique: adu4dZcLPcez2cAbrBzGsA-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5a2b8c44b48so2654768a12.0
        for <ntb@lists.linux.dev>; Mon, 05 Aug 2024 01:02:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722844925; x=1723449725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fCKgXS8g88Bg2YGymWSAuOupDyZ6pDfS4Oy1WWS2It4=;
        b=vYMbHP2LWWEyWIm0gVyHeTsVvtqjAwO4/zE2SZafQyj1p02/ZtcGsX2OK9jS3fyYJT
         AOrFuyGKjXnfPYn3FxuPRWCFDti1h9RgQw9OVFu8Yh6mKXt9x01rkhqzdsQbmv97cA5P
         VSfp/yaFTki2cyXYtMPTBMzovy3NzBY7vXu8KjkXVfPK1yR0u1CJRgpy0Q7GgjiPOAIO
         rne0jsfvFYqBZzKJJdX0cNGRN+m11MNlhGSQF1q5aa737aeprD1067yhn2igi+QestjO
         43zU9YS9+IBCwNKfniU69LzSC1dcEEOMn+mCGlzyLdWkgTRt3+6dDkbJoxHvcAYEfoME
         J/qw==
X-Forwarded-Encrypted: i=1; AJvYcCWV+NAAG8RxWGG5nDynevftVYQuSzhowT8Q5UpTIy57qMCw1FH7uKsLgH8ghhCGkdOeYk+T92MAvySymUwDuwVBn4l9
X-Gm-Message-State: AOJu0YwnOi6Q7dFnnl2yCqlx5yIAQckMMzN5QdllULylapqtBqyAe2N0
	HNis8mIF6GZI6UeKPpCBg/L8COhaSTtBLgwVVSyPJPigGVc9mB1dcKcqztA2s2R1y3W8WkoEDu3
	ioTar5uCFGFhkFUHmj3R0Lge/Ey8K8n51x9RJtHi+NaXXnyC+yA==
X-Received: by 2002:a17:906:cac7:b0:a7a:ab8a:38b with SMTP id a640c23a62f3a-a7dc50a036emr405427566b.7.1722844925252;
        Mon, 05 Aug 2024 01:02:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8B0uAdpCjmN8RXKqb6GrkT9cJblAYXyonWs0YpjO3v6slHT4MqkSoaoDsG7XIcg/iI+6TwA==
X-Received: by 2002:a17:906:cac7:b0:a7a:ab8a:38b with SMTP id a640c23a62f3a-a7dc50a036emr405424666b.7.1722844924726;
        Mon, 05 Aug 2024 01:02:04 -0700 (PDT)
Received: from eisenberg.fritz.box (200116b82df07e000a5f4891a3b0b190.dip.versatel-1u1.de. [2001:16b8:2df0:7e00:a5f:4891:a3b0:b190])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7de8d0868bsm277958966b.143.2024.08.05.01.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 01:02:04 -0700 (PDT)
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
Subject: [PATCH v2 01/10] PCI: Make pcim_request_all_regions() a public function
Date: Mon,  5 Aug 2024 10:01:28 +0200
Message-ID: <20240805080150.9739-3-pstanner@redhat.com>
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

In order to remove the deprecated function
pcim_iomap_regions_request_all(), a few drivers need an interface to
request all BARs a PCI-Device offers.

Make pcim_request_all_regions() a public interface.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/pci/devres.c | 3 ++-
 include/linux/pci.h  | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index 3780a9f9ec00..0ec2b23e6cac 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -932,7 +932,7 @@ static void pcim_release_all_regions(struct pci_dev *pdev)
  * desired, release individual regions with pcim_release_region() or all of
  * them at once with pcim_release_all_regions().
  */
-static int pcim_request_all_regions(struct pci_dev *pdev, const char *name)
+int pcim_request_all_regions(struct pci_dev *pdev, const char *name)
 {
 	int ret;
 	int bar;
@@ -950,6 +950,7 @@ static int pcim_request_all_regions(struct pci_dev *pdev, const char *name)
 
 	return ret;
 }
+EXPORT_SYMBOL(pcim_request_all_regions);
 
 /**
  * pcim_iomap_regions_request_all - Request all BARs and iomap specified ones
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 4cf89a4b4cbc..5b5856ba63e1 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2289,6 +2289,7 @@ static inline void pci_fixup_device(enum pci_fixup_pass pass,
 				    struct pci_dev *dev) { }
 #endif
 
+int pcim_request_all_regions(struct pci_dev *pdev, const char *name);
 void __iomem *pcim_iomap(struct pci_dev *pdev, int bar, unsigned long maxlen);
 void pcim_iounmap(struct pci_dev *pdev, void __iomem *addr);
 void __iomem * const *pcim_iomap_table(struct pci_dev *pdev);
-- 
2.45.2

