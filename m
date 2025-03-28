Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEE419995B
	for <ntb@lists.linux.dev>; Fri, 28 Mar 2025 14:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743173633; cv=none; b=SzRSrd7qgA747GQGRGyKr0mWFpzI0ol7vT5b3h/olO2yQgAr/kMhSr+8sn3wVjf4iHigm+7JVfFvc82hbvUCbJm4AC5Nm9K6jDlyDXpLto2j0aeWQvFQf6ruIGbQoRBPFssd3E8EUcl3YgUUqQFsTIJXzPnKlegL31aXk7spv9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743173633; c=relaxed/simple;
	bh=5oAHlbTAcauldOWi9cMUgYioWN6gScafeHZfYPLkyRw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JacecIgAL7dq7sN8hd7aFySbSpsUgz2yNphE4F2bI+nsS2NclG6ZIpI/PJSMhNht7bhxTf94hV1RVGMzerLGGijiA4ooFqhxsaQ6157PkaqSfOXZP/97Ho4iqRqrrECAO62mMvO9YzvGyb6mGiISD5ceuf5hSnI0c+X8T1o/5rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qp6yiWOK; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qp6yiWOK"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3913b539aabso1323763f8f.2
        for <ntb@lists.linux.dev>; Fri, 28 Mar 2025 07:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743173629; x=1743778429; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=om5WJnI/3Srzz6KnBz+MWEytyGjHkNFH1uylSroKmIg=;
        b=qp6yiWOKZNXcxlnlyTCAxVsMTRBOfsANq8m3QRV2yHas2jWTE/3NclKT/+GQ2IgF4S
         syec3t2zpXJv37ZuUijTO69yOxzWPaxLqstpZYYdWC5XKOYnjJM2YPlXfqfno0z4NKfE
         lMzbIgsFE5NzWLcdDAXiaKXNv4gjVr5evY172N9VUmQN6QVqK+UwKzWYIK/aHCvD1Wjh
         ZzRpzompt3PTEgZfsRm/YNBkPLoorBSUCBr9LnntLaPwEkLu4aiIToL7ElshCE9J+QcL
         tIfrBwfE0pAkJzRS+Nf8jeXZNit8viGIl+3Uz23av8yqKAck5IbqS0DHbsfdF6KSmXAg
         kZcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743173629; x=1743778429;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=om5WJnI/3Srzz6KnBz+MWEytyGjHkNFH1uylSroKmIg=;
        b=n3rUTjtTb1nw2SUSNyu+h0HEDijmWv/YlbsqD0Yj5fPYRF4O/cE6vr1y758cQN3am+
         MEUIyG4PvQ8M6RZ8HSXsNO/wF4s1qOp5ebmATBIBWaWaEwoUX3OR1zZUVDZa/FQvgcYl
         1Y+fFFuNsuJ+QtK1g1bL4PnlPov5LGA35KfKmxFRdW2lNJp62INV9Xlkw0p8kCdVHIlZ
         MsY9II1EsE1lINUtvQOev3PzyDJUw0IkTTSStFBsOeq5bHdK+8JAHcnB0cF3PwOt7ua3
         rMF6h8jYzyy6wMye0QRHDvRXKBqk8o4Q8HKEgpaoLuyqhSq0aPlzuRo1k0OVbLL8XNme
         0emw==
X-Forwarded-Encrypted: i=1; AJvYcCWvKUNPOSHJTJRNFXAQD3IrCoPDGcs0pfL/CMc17pbQo2sbASXVX3w/nqT8/tjoqF6BKJ4=@lists.linux.dev
X-Gm-Message-State: AOJu0Yzb/GvPtcFIfELlEfCJxEH7yMt5utJFaA+1mBrH3auDzXhK+lvQ
	zJA9vBDPP1Vb/LRybbnZwADfPs7EXJ4eHg40bM/LE5bfR4a9rKx1lBzodCBg0CY=
X-Gm-Gg: ASbGncvlg2Hg+nJa6YTAtKfDuSMRnCDbbXSyZDi6Zunrcr1o4uAdl6I7ba8aQ2W3+WW
	joyNR0EenCcd91l/JoPJ6w6Y61AJtcoPeBfPQFV6PRnCaN+Oq0Q0J2S+DF349yNM4QLQRVCqSaT
	dfV66fSvrtczA6MweswLPM/AbVypmLfatrJIPfjzwdL4hHFy/8rF/wDZWI6+d2B23OxRCU9FWoz
	QPQkQ0WHHnp+09qgujTVJQLIg+gprRb2isC2Eo+WNFCFur7tFK5ZlG/s1AkjtT2FGrUfaaXBcQJ
	I4AJESD58K6VuC/OLgCtuXpI9CxNutLEbjPxQqxRdhSx5RhzItqw/577Lgk=
X-Google-Smtp-Source: AGHT+IHxpmdIjzZ3NBy6ZKDeIo2oJ9uzZLQK6IFavRFuRv86Y+8cRv+dnKeq1VLQiY8bi9c3dCFsFQ==
X-Received: by 2002:a05:6000:22c7:b0:391:4889:503e with SMTP id ffacd0b85a97d-39ad17503e8mr8632876f8f.33.1743173629528;
        Fri, 28 Mar 2025 07:53:49 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:70c0:edf6:6897:a3f8])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43d8314e110sm75219615e9.39.2025.03.28.07.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 07:53:49 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Fri, 28 Mar 2025 15:53:43 +0100
Subject: [PATCH 2/2] PCI: endpoint: pci-epf-vntb: simplify ctrl/spad space
 allocation
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250328-pci-ep-size-alignment-v1-2-ee5b78b15a9a@baylibre.com>
References: <20250328-pci-ep-size-alignment-v1-0-ee5b78b15a9a@baylibre.com>
In-Reply-To: <20250328-pci-ep-size-alignment-v1-0-ee5b78b15a9a@baylibre.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Jon Mason <jdmason@kudzu.us>, 
 Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, ntb@lists.linux.dev, 
 Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2533; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=5oAHlbTAcauldOWi9cMUgYioWN6gScafeHZfYPLkyRw=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBn5rf5tteiMGeKSx358xJ2+154PVr7k7RAJ8OqE
 x2hmwLHlNeJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCZ+a3+QAKCRDm/A8cN/La
 hX1yD/sHaWYMETTJwDgxrGxRlNsQF+Rc9Q5oMX73ZbvDomTMBb5/EiuCjNA+WGqvLAaxZPnInYb
 gbgbOiq3WmzHn+nEp/DGRjxo8UlUCwJEE0w+E+D89smicnQpIelt4t7+C/M+ImfP/AUC7bxZfiJ
 aJqVUT1ya+PnF0xTs2X1txWYxCtLvr1ez3Zpq7tWgPbvlZzrQgQX1Gs5NkYGemnRj4CdKAwWwc/
 WdPQ6RD2QjKbsur4fqR5Mm5Ykd+yveBedPVUDb2otNDQSi+P+8ACxZ9wn2ZpFbQeSdWa/wrxgFS
 uaKxglM4i8uT7qLrWJWP5we/cAKLPVTI3n11V36Zs8g2ppjfZgAwIhZckxcPGaBFNStjI3em2DX
 y1oAkpi56w/B7itaLGgQ2OnANTCeZ74U/9RJe80a4dq7rHsZcbs8yeIxhhnIWjN/fRvO4nqpH09
 B/XqYI18bYdgYLJ4zPvixPbtVhvoAxCpY7xJPyOhrJR27m0njeWb/dugQjI+03LABwI5PstLYYl
 qtDWRm0pg2/TA/v5JTTzpqK2BbEG2ST+9Htlt/UeGLN54VADr9qtKB/C4PCkqs0HoHNRJpX6ufm
 2UoJI+sD12dRMYYnCviwxrBt7KSVPuWTN5lnUmnHqTOFDl6WfqoPgNvu3mAsPJfqPMpvduOzCNN
 hJsCtJfdABnSOEg==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

When allocating the shared ctrl/spad space, epf_ntb_config_spad_bar_alloc()
should not try to handle the size quirks for the underlying BAR, whether it
is fixed size or alignment. This is already handled by
pci_epf_alloc_space().

Also, when handling the alignment, this allocate more space than necessary.
For example, with a spad size of 1024B and a ctrl size of 308B, the space
necessary is 1332B. If the alignment is 1MB,
epf_ntb_config_spad_bar_alloc() tries to allocate 2MB where 1MB would have
been more than enough.

Just drop all the handling of the BAR size quirks and let
pci_epf_alloc_space() handle that.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 874cb097b093ae645bbc4bf3c9d28ca812d7689d..c20a60fcb99e6e16716dd78ab59ebf7cf074b2a6 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -408,11 +408,9 @@ static void epf_ntb_config_spad_bar_free(struct epf_ntb *ntb)
  */
 static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
 {
-	size_t align;
 	enum pci_barno barno;
 	struct epf_ntb_ctrl *ctrl;
 	u32 spad_size, ctrl_size;
-	u64 size;
 	struct pci_epf *epf = ntb->epf;
 	struct device *dev = &epf->dev;
 	u32 spad_count;
@@ -422,31 +420,13 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
 								epf->func_no,
 								epf->vfunc_no);
 	barno = ntb->epf_ntb_bar[BAR_CONFIG];
-	size = epc_features->bar[barno].fixed_size;
-	align = epc_features->align;
-
-	if ((!IS_ALIGNED(size, align)))
-		return -EINVAL;
-
 	spad_count = ntb->spad_count;
 
 	ctrl_size = sizeof(struct epf_ntb_ctrl);
 	spad_size = 2 * spad_count * sizeof(u32);
 
-	if (!align) {
-		ctrl_size = roundup_pow_of_two(ctrl_size);
-		spad_size = roundup_pow_of_two(spad_size);
-	} else {
-		ctrl_size = ALIGN(ctrl_size, align);
-		spad_size = ALIGN(spad_size, align);
-	}
-
-	if (!size)
-		size = ctrl_size + spad_size;
-	else if (size < ctrl_size + spad_size)
-		return -EINVAL;
-
-	base = pci_epf_alloc_space(epf, size, barno, epc_features, 0);
+	base = pci_epf_alloc_space(epf, ctrl_size + spad_size,
+				   barno, epc_features, 0);
 	if (!base) {
 		dev_err(dev, "Config/Status/SPAD alloc region fail\n");
 		return -ENOMEM;

-- 
2.47.2

