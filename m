Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FBF1E5016
	for <ntb@lists.linux.dev>; Wed, 30 Oct 2024 11:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730287701; cv=none; b=QxmDvwdR89Y7BrazkpWmRfBR4iKFNHO/PthTEmgwr8eDiiF8zQCcaaNa0uJR0z6h/TRgaE1BpkVzLnUerPF5E24qiOIW6+BfYG9/BR3HgmlKWcKcpq4r721Ids3j3iEMrHxpO6Qme+K4R6Y5hFO2fD61aHTsmwf+DFX3EPst5Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730287701; c=relaxed/simple;
	bh=q3TYZ53foBadD/cMlyNi2anAEGoKt2ZxGv1qO1diPeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lWzGMVnL8/QvZqFWmApOeNCjE/EuHOoEsTpsRFJI1Qd3gqwqQI9ZGlUON98C0WE808kjEV/jEt1sor/4LLBYDXXLLjVdPhQil8eRSkfTVzj31Nm6zttHl3hmIr8FsfJjTa22prUhIADDoLW7Z6bbEKI1XOO/HzbWH11CpTFkQLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GTTRGePb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GTTRGePb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730287697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nmhs99F0aBbo/KjdAhIjGloV5ZKJmf6z3p3cVimWjlk=;
	b=GTTRGePbPl3PDUVuWGwdUTaKu9cWWev1SbaVxz/Bye0mWnjBaWxnSucraZRIeoJT0KH7vi
	Cbknc49doWeH2n3WGwk5W053UkVxaB74LVNKTqopodPmdJ1mqAqx7jkYIM9Q0iVzP5xQut
	A1MYZtP4x5tU9Od3HGCSxx+ZyFmi6WE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-MOCLjkiuND6hBjT6lBV6TQ-1; Wed, 30 Oct 2024 07:28:15 -0400
X-MC-Unique: MOCLjkiuND6hBjT6lBV6TQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a9a0ac0e554so79618466b.1
        for <ntb@lists.linux.dev>; Wed, 30 Oct 2024 04:28:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730287694; x=1730892494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nmhs99F0aBbo/KjdAhIjGloV5ZKJmf6z3p3cVimWjlk=;
        b=l/iNWim5mo8omo7mzGwvhnzsTOU9J8jASC1VmKKF29hea5YlW2EiX68xtBNNlOIhVe
         yhTHi+hbmAaCam1/2WaH6qaLmiNr8SuK+de2Tbc2qLz8KVmzfRgaQ4qWhpXBCql/jSw0
         n5nQID8/KR6G3UHoAStn14xdSha5f2QRwOx2LnF9LQ7pi9ELVWNCVQ47NDu44eMwbJey
         DGpSMA8flyRKQgXAM0bilN5U5ZG5aLvpgZlS8vf5XF8sgpKWfZ8vfN8tHqeO0zP5GZcV
         CyU1T5a1nQwYiYS2rRf+kV0xQ7x5XRXIG8hddxBrPDfJnJyfX5gn4U6qUsgzZ21bGBNd
         MHwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNeqBCn6zpk/GE3JDnLSb8XXOJNL+B2j5KNA1uNpC7IC7t0x2eulgI4N+Q3q7vACfzEIk=@lists.linux.dev
X-Gm-Message-State: AOJu0Yzk8IuVeFsgUyWF5SoKekq9JxsvbjHflU1yueQQz9Nj8EY2SUJD
	phfCPNmqw2l+PjyAOHNFadA831QKo5jXyEK4X0ILuIN5xzQiqbLuSsr17YbUeZLDSScmxNKlg1o
	xpTyL46vpzvdp5KN1bwRCfhjghzJ2y4NFEV/6yza5rlUI8C3DYA==
X-Received: by 2002:a17:906:7955:b0:a99:ffa9:a27 with SMTP id a640c23a62f3a-a9e40fd6b13mr170561466b.26.1730287694538;
        Wed, 30 Oct 2024 04:28:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1NLu5M2018jLIxJX+Z/i21emZn/jQBhcI0nUHdCEwPkxlqgV1lXWB25R+uQkV5ZaptpnaqA==
X-Received: by 2002:a17:906:7955:b0:a99:ffa9:a27 with SMTP id a640c23a62f3a-a9e40fd6b13mr170558666b.26.1730287694067;
        Wed, 30 Oct 2024 04:28:14 -0700 (PDT)
Received: from eisenberg.fritz.box ([2001:16b8:3db7:f800:98bb:372a:45f9:41e4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b30f58991sm557324566b.159.2024.10.30.04.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 04:28:13 -0700 (PDT)
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
Subject: [PATCH v6 01/10] PCI: Make pcim_request_all_regions() a public function
Date: Wed, 30 Oct 2024 12:27:34 +0100
Message-ID: <20241030112743.104395-2-pstanner@redhat.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In order to remove the deprecated function
pcim_iomap_regions_request_all(), a few drivers need an interface to
request all BARs a PCI device offers.

Make pcim_request_all_regions() a public interface.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/devres.c | 3 ++-
 include/linux/pci.h  | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index b133967faef8..2a64da5c91fb 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -939,7 +939,7 @@ static void pcim_release_all_regions(struct pci_dev *pdev)
  * desired, release individual regions with pcim_release_region() or all of
  * them at once with pcim_release_all_regions().
  */
-static int pcim_request_all_regions(struct pci_dev *pdev, const char *name)
+int pcim_request_all_regions(struct pci_dev *pdev, const char *name)
 {
 	int ret;
 	int bar;
@@ -957,6 +957,7 @@ static int pcim_request_all_regions(struct pci_dev *pdev, const char *name)
 
 	return ret;
 }
+EXPORT_SYMBOL(pcim_request_all_regions);
 
 /**
  * pcim_iomap_regions_request_all - Request all BARs and iomap specified ones
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 573b4c4c2be6..3b151c8331e5 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2293,6 +2293,7 @@ static inline void pci_fixup_device(enum pci_fixup_pass pass,
 				    struct pci_dev *dev) { }
 #endif
 
+int pcim_request_all_regions(struct pci_dev *pdev, const char *name);
 void __iomem *pcim_iomap(struct pci_dev *pdev, int bar, unsigned long maxlen);
 void __iomem *pcim_iomap_region(struct pci_dev *pdev, int bar,
 				const char *name);
-- 
2.47.0

