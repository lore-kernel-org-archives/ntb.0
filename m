Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B416726C383
	for <ntb@lists.linux.dev>; Mon,  5 May 2025 17:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746466930; cv=none; b=RfgGmvPfYVKmTtClKf+OAC4/71U6dF0x7P+OmlMEwpNxdhmek4saa2D4JLxrPXmZCOXS6zDNShMoQCOICkbCTzKv3vy9Fb0uFAT+y+6WdPhn9VuhpRbWLcabp4zHih+TKTjYAg3WJ9lCLEpgGE3GBcrGzga7h3GCk+u+p7e5n9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746466930; c=relaxed/simple;
	bh=qyM1aZTG9d6MOwjR/qspKtycZJprSidmxi28fR4mEFg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nR56rzJOym2U9kGZfycxdI37Igwz2ncLm5FKXomJRqFL6oJwuCFGoH96VjoVVVEYy5rEF4x2EmVvhSueslaeRdCZXzj1BP25MJPSbic/gyh34kwAMcmvu0FoByg5glBEAOOsI9gORUaSVmEPuA+PVRjAm7vG8SZK+lxtkDOjzOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OYV+skdg; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OYV+skdg"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-39149bccb69so3640796f8f.2
        for <ntb@lists.linux.dev>; Mon, 05 May 2025 10:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746466927; x=1747071727; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J3LBY8kEk9gi4o8XX/rUOgzd9iIiBOazH7vpEqQ3lP0=;
        b=OYV+skdgAYY2Dke/rxfXbmWBS2FfSTIz4K3XGnDAR2JGu8QO8llVO3MI10AGIIISdm
         l/s/C4pVH7wPB/yu/UtjjzGFJfUJz0w6GUiQDG99GQ7Wd8CmyvOHkCGZ5MBszKNww5Qc
         RtLntErXcmuZ4EoBCgUhR/ov9ufpTVa9eHcFi0LW2XStCUh9L6g284rBAv7N4GSfPvr2
         a/dknklaDftrCtb3P449uuAtZVrxbaaQuaBIz8mPYmhQAw5/k9fwNEC8H7GGWQFlhYFK
         AIg+30cqLFv56WOw8TioE+j90Bo2/eGiOrs7KR7ZBFR3Hoa3c0oMS+++I0MQO+NGA0t9
         uhAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746466927; x=1747071727;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J3LBY8kEk9gi4o8XX/rUOgzd9iIiBOazH7vpEqQ3lP0=;
        b=V15s6bnRIbGLNI3kvvgRSdYkrYICdoHP8Zg4403Ga6rssbAdNXvZe+2A8jFkkxzwXY
         bHPCV/SMKpsMkTpht0raYoy5VoDWMhUgmMwlg5j59C6qzEALLiK8eurI5SsSJ5Q//EW8
         favi0nWS+vq8PjKZkLpw3yRBwnaPA3DguOaEuPjSPlCHOBjppPvIg5M1zprAooy5zCu3
         lPTGsO9T8nEU+92BrptM7x48362GNQo+giiyljQRanyQ1AQfiHmHy0bhiMZDF/ekfY/q
         KvtBMJpDMXWvLUTtRSuUdym99wmNbrr0KruxKkban38Z2IezsFbKgXRSIweww/RUV15s
         jnfg==
X-Gm-Message-State: AOJu0YyimcTchTKSuBkO2rwnx21Q1bL2JGKgYcfU1MbBgji5SIPO+blA
	MY+WHI09Lg5wFoOanXhHVyCBVXuBWbFUvvj2gUuAWj9pIChN/AlVdQKKdiJBDqg=
X-Gm-Gg: ASbGncvNm78ZTrbbPvsY2A/gznCxRkkoHi26G0n6j0DfRgWMTRFBn2fEWUWl1+NXv/E
	ywf6uxBuQH7yUtBDUj2bHMG829vsl/7zUixEOlIvnIiJv0sdmMaUVlnj5pO+5qOdTEXJLNFQxLl
	nPLD/B81czfDJuEIRGMA6RKVGWgiuNpJqGGAvMwyA2EGs++tKTCBxHbcxk8V28OpiTTM684204w
	kb4f/kMG9tLxY4iZFNrWBN5iNKTu20wKBJW7yVIClZtm4JeeC8IEBZpramaWdSNR1j7N1xaxjyO
	3U9Q+PM0yFkha2DxX0AYpcmwkNVQIdP4AEuGIx5EKKXMmZWqPx6qUw==
X-Google-Smtp-Source: AGHT+IF3UDYv5RkphgGj8Lc6CvGE7Xu3M0hl7sTbGqxmHG0EE/jkSjD3603rUOunex+bJISfmCMesA==
X-Received: by 2002:a5d:64cd:0:b0:3a0:8331:3380 with SMTP id ffacd0b85a97d-3a09cea693dmr6651442f8f.8.1746466926987;
        Mon, 05 May 2025 10:42:06 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:dc81:e7a:3a49:7a3b])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a099b0efbfsm11345829f8f.69.2025.05.05.10.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 10:42:06 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Mon, 05 May 2025 19:41:48 +0200
Subject: [PATCH 2/4] PCI: endpoint: pci-epf-vntb: align mw naming with
 config names
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-pci-vntb-bar-mapping-v1-2-0e0d12b2fa71@baylibre.com>
References: <20250505-pci-vntb-bar-mapping-v1-0-0e0d12b2fa71@baylibre.com>
In-Reply-To: <20250505-pci-vntb-bar-mapping-v1-0-0e0d12b2fa71@baylibre.com>
To: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
 Allen Hubbe <allenbh@gmail.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2573; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=qyM1aZTG9d6MOwjR/qspKtycZJprSidmxi28fR4mEFg=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBoGPhp/L+P2VULngOx5WQ0FytTBC13S2IpX/kyf
 rhqp5Vhb1mJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCaBj4aQAKCRDm/A8cN/La
 hZDaEACyUbFbc9jDGPkGRgRbI2ANesSAAiw/c8EgwKetMd3ukPITJo3PCzD2oL0aGM3bHF29jZ0
 f8JyjmtHRCg9YB/Qmf7EcDSsLQTIH18xFTnFbRfJoeamxOFwya1ZXWw0fEO+lxj4aaF3g1Y66ao
 BeVLV4NzCBb2zsq/jgxV6DBIsqnwLLtbBZQXtCZO3b6cYv69TsvtreFZfccbbS/zuQmwKK+FVGf
 jchYdxCz00h8j8UBDC5xDmMWOW2cVaaQbvn4TlHXd2bbqv638knmpa34SK8NskDcRRn4SynD5md
 4FQga18Wbq62NXuhQ8GeEjHecprS/M9DvX1Oyzfde47I+kYXTKYJiVACKvVuIem1hOCMabRYC7+
 iJDSfG6DLS75ecJdKyJyrJ/EqVtRiudQPXFCQCWXaZVmISU2BjNcb3httVvOGeW7JfvWE2PUzDW
 Op51YiDHwtNMjIBsBeJwd7+qqy3fdEAkMjh7XrOD3+IYYdmDQqO+FdFIVg3nZsNgBEtlyqguYiG
 1YYWYf8lqp+kIi4HwFQTJOkjZLw+vppXpuNFHx2LX+WGEkY1wnPMFNOzkJNPNmbNi8az8BbbO1k
 Zp8Xqjw424aoIl//71+AxbA1EYWBMlNjL2oOCSLrXHfOwCTd9fkwQw/DHewRqxhM4aaXIGs3FzZ
 nCBEtVJzoQXIV2A==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

The config file related to the memory windows start the numbering of
the MW from 1. The other NTB function does the same, yet the enumeration
defining the BARs of the vNTB function starts numbering the MW from 0.

Both numbering are fine I suppose but mixing the two is a bit confusing.
The configfs file being the interface with userspace, lets keep that stable
and consistently start the numbering of the MW from 1.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 35fa0a21fc91100a5539bff775e7ebc25e1fb9c1..f9f4a8bb65f364962dbf1e9011ab0e4479c61034 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -70,9 +70,10 @@ static struct workqueue_struct *kpcintb_workqueue;
 enum epf_ntb_bar {
 	BAR_CONFIG,
 	BAR_DB,
-	BAR_MW0,
 	BAR_MW1,
 	BAR_MW2,
+	BAR_MW3,
+	BAR_MW4,
 };
 
 /*
@@ -576,7 +577,7 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
 
 	for (i = 0; i < ntb->num_mws; i++) {
 		size = ntb->mws_size[i];
-		barno = ntb->epf_ntb_bar[BAR_MW0 + i];
+		barno = ntb->epf_ntb_bar[BAR_MW1 + i];
 
 		ntb->epf->bar[barno].barno = barno;
 		ntb->epf->bar[barno].size = size;
@@ -629,7 +630,7 @@ static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb, int num_mws)
 	int i;
 
 	for (i = 0; i < num_mws; i++) {
-		barno = ntb->epf_ntb_bar[BAR_MW0 + i];
+		barno = ntb->epf_ntb_bar[BAR_MW1 + i];
 		pci_epc_clear_bar(ntb->epf->epc,
 				  ntb->epf->func_no,
 				  ntb->epf->vfunc_no,
@@ -676,7 +677,7 @@ static int epf_ntb_init_epc_bar(struct epf_ntb *ntb)
 	epc_features = pci_epc_get_features(ntb->epf->epc, ntb->epf->func_no, ntb->epf->vfunc_no);
 
 	/* These are required BARs which are mandatory for NTB functionality */
-	for (bar = BAR_CONFIG; bar <= BAR_MW0; bar++, barno++) {
+	for (bar = BAR_CONFIG; bar <= BAR_MW1; bar++, barno++) {
 		barno = pci_epc_get_next_free_bar(epc_features, barno);
 		if (barno < 0) {
 			dev_err(dev, "Fail to get NTB function BAR\n");
@@ -1048,7 +1049,7 @@ static int vntb_epf_mw_set_trans(struct ntb_dev *ndev, int pidx, int idx,
 	struct device *dev;
 
 	dev = &ntb->ntb.dev;
-	barno = ntb->epf_ntb_bar[BAR_MW0 + idx];
+	barno = ntb->epf_ntb_bar[BAR_MW1 + idx];
 	epf_bar = &ntb->epf->bar[barno];
 	epf_bar->phys_addr = addr;
 	epf_bar->barno = barno;

-- 
2.47.2

