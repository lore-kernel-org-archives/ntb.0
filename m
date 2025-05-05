Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEAE26B0A9
	for <ntb@lists.linux.dev>; Mon,  5 May 2025 17:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746466930; cv=none; b=IqtiQ8BM/mcx9T1JXLs9e9PIRfUgWpr+vhdnI8j9U/XXpo20qiyFoOFOhQm3mtFH0DcfWbdTm78EXwJtcbirSQx/E9aQgOoejqq5FNklHOlfFLaENa9fDmssWAPAuYZC4GIyCiPeQ10XqzISe0cxl5tfNdSlTaR/qDfnoeIzBYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746466930; c=relaxed/simple;
	bh=fAH11pHsRrYKcysroQjLM8Q9UwAmjfM3znAZKnmfIi8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f5kGi0hFUUa54ukVZ6CcIQzEUdhQcNsyfVeQi4KR6J0E5QgdfhiK/HkmRMzrAGxS3n+ZbO5lsYQMO6UTijkdvanct1DSJ4SnJG5SIBbKx8xxsQQlRBZGcUvUpK8Djekgj1IF3MZdT/BUjQcrHlpgPqJJRuDkpVzmXxtaA8/ReVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=JL8aPbAN; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JL8aPbAN"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a07a7b4ac7so2040302f8f.2
        for <ntb@lists.linux.dev>; Mon, 05 May 2025 10:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746466926; x=1747071726; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+RjSK5+oOhqZKQ0oK0twEFsYWTKP2YoDTHH/eJYqDLQ=;
        b=JL8aPbANxBq5+TCEJmdPddlgjc+p1xqixvLScWnm9zR9mX4umigxl17AT0Jqlc4M7e
         zyrolVzwgLqP65KBDGA23r5DwQo8BNjwta4Ay+Kqjo8+HsaF4YGB9EZpU2jDYLzeDCd4
         P//tzXHVGMCz5VJ72PsLAKEiq/ZScovgoHZv2Fq9NWARvZnvf+hHoKfFltdHw9eaOPzR
         83OR6zgdsphJ4QxXkPXQXj/fw3nt0hqjhVjgVSnrBoV+S3i0JOy/AVhSVQ2HOFzqZCBT
         PDBA6RFimqIIeCj2d/oL0DaO6PjR/4xChc2dY7Jjhcfqzju+hsZoW+bdP86YiPS/MMFx
         6uIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746466926; x=1747071726;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+RjSK5+oOhqZKQ0oK0twEFsYWTKP2YoDTHH/eJYqDLQ=;
        b=Z0ZIXLg+wEMpSh6fEui489GXry8tAH4BR0GXAZGLAPn8OGVrutB387rHK84UEZkeyd
         juwnXFB6jGNvaY1wQlJ6CCw2tIosvGR9TqK1KnpGExhd5JlvZQZbUPnepdET0WQRhVr6
         XWz2XhHKupVLelYWLunqxfnLg0c5cFgtKBGN3ET7FNKQ9FrOrtaV6z5X9wiFZ3ipJLdU
         fuaVWnVt9nN7Lw26aON68YdsPoMwg0JgGHawZtu5aarYDaO0+W2WsuzLgPwJ5RPGk3cA
         Qr0bl8Y8fycl+IT3cBmPwWuCTQ+L2Fq2tlUkRG3wPk9kkjUZR/k4iXku0ubHFyydL0n8
         QC5g==
X-Gm-Message-State: AOJu0YzROi21sJDfNK6/PM3+mD6k7EzxSbXjrUq+yzrvTG6HSqz4IZgV
	kdEH2jK7LyP4PzUbgs08Mhoopsuj7lzamgvIfyYGAd53JHKg/4kf+JsnvB5KXB0=
X-Gm-Gg: ASbGncvs9uIL4vt+1X0mTNDrdwY+EdK/txPOe6rcPCeNGIbsLhg9zHpbkrHMaO8hoSO
	ekNYoxIQmS6mR5v/KQ7GmzoghJVOpmqErNHpSx0E8Bif3kXSCGLU5/FgBqB89WfJvvReLLILry/
	L/qALNC1YcUivpfKXXFCrZmswM/ISbF+q2bdeF3FwJc7rTYVxJuBTVhgYe1AQueE+W+VSeZi1P1
	1BnwLFGn/BITQQceVvqiQqJPykYYQZPnaUg0SG1NiCSDMB76stdDSnF5tipjfdpECIrTS1vNNL7
	LXff3pN34IpBTgj0Nh7JsnBLS268Dj8ycAAoAjMp92uqDLiIjOv1mg==
X-Google-Smtp-Source: AGHT+IGAYa+if0CukQnbgX4pEVrN5Xsiai21uC7+G5ERCrGhLg5b+LFY/FpMStNNjBLuuOjsvZ9R8Q==
X-Received: by 2002:a05:6000:420e:b0:38f:2678:d790 with SMTP id ffacd0b85a97d-3a09fd7c855mr6686785f8f.33.1746466926206;
        Mon, 05 May 2025 10:42:06 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:dc81:e7a:3a49:7a3b])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a099b0efbfsm11345829f8f.69.2025.05.05.10.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 10:42:05 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Mon, 05 May 2025 19:41:47 +0200
Subject: [PATCH 1/4] PCI: endpoint: pci-epf-vntb: return an error code on
 bar init
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-pci-vntb-bar-mapping-v1-1-0e0d12b2fa71@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1058; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=fAH11pHsRrYKcysroQjLM8Q9UwAmjfM3znAZKnmfIi8=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBoGPhoKlIvsdmRmR9d6/kM75+1NA+V25FqgfZ4A
 LjBSUdeufeJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCaBj4aAAKCRDm/A8cN/La
 hWvCEACJQ3glDx7dWhKRBd+uiK+/HZdut2ULVasmSE/3OzCr5HaDdpm5oFp1p/SPpmW/13cgqIR
 ju1V858zABuU9lVRidP/F6No+RTJfhh2lRQRLAFJ7y796sHXI96Wnky6L+g3nloKQQ557hwSITC
 nIfr8pW2RffnHuorPF4sr0W7gzKLAIEOJaxeGn2EAYFThw0vJmjLnHcAzpKlu2gNqRUsV6UokrB
 QMWj+UrP9UNAQ9fryuVyxCOW+JtIbjmTNno/1bjwWPEs3tG+MswgbT7UCFBl5KBNtmD3QWUyt4x
 XEniJy1KhdE/8AvcBfctFTMM8dZpY6P1cTQAukOThQbd3Pxrd9eq/jG5t1tP2vMxF3BFETc5mt1
 PA349TzY8INQGg2vQJvRE7nfneZSM/++WL/z5Hf9oa6fLO1ztBIvuJghyfNjYXKYJDD+VMMPc20
 nwan4o5n+1O7DR+qMMwaaI5JDLFOnUQ/NegzCtUR6t0kgXd4xOiI+kBScwwMmeulsE+pX7jVxMN
 s1a4kUeYqC3unYWS5WdD9Otwqw2abNqWYhiAS0o9s+O0MT2mPLJ1ndYYuOv/Ytjz05t+5EEi84T
 0ZnPAcYq11sHoEg1ECjqdj4ayc4axe8FqKUyKI3eUSH2r65VOleE2GX3Tij5tF7j3ANz1GUtLL6
 VfwZygZfa1KIWNg==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

According the function documentation of epf_ntb_init_epc_bar(),
the function should return an error code on error. However, it
returns -1 when no BAR is available.

Return -EINVAL instead.

Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index e4da3fdb000723e3adad01f0ddf230ecc0e572a7..35fa0a21fc91100a5539bff775e7ebc25e1fb9c1 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -680,7 +680,7 @@ static int epf_ntb_init_epc_bar(struct epf_ntb *ntb)
 		barno = pci_epc_get_next_free_bar(epc_features, barno);
 		if (barno < 0) {
 			dev_err(dev, "Fail to get NTB function BAR\n");
-			return barno;
+			return -EINVAL;
 		}
 		ntb->epf_ntb_bar[bar] = barno;
 	}

-- 
2.47.2

