Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E9D1EE019
	for <ntb@lists.linux.dev>; Wed,  2 Jul 2025 16:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751474929; cv=none; b=qXO0vl7jM5sHR7Dvyf3txv9x3P+mgolV0g5xg5SW0SROzqJIkNoXvr8Ht+Sm1l0MaiCA99pzOtS0UJzd+PLpHDKo2ujl3Bj2vg1X7GK4MJeuLEW+4Ga766wmH63mZ/MoT9fLuGbRslHylhtul/5U5m7g5+70nusUNIO8tQJ40Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751474929; c=relaxed/simple;
	bh=0F00VHx0gtIe+9FxH9hZnjKBU1cK5Id/md6nN4vDe0E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hqalZFr8Mpuh3BGdpk0PUT4CdHlsZb0rNksesw3K6sMJNoSVb5MfDQBxm4qBrYU0UtLt3e8zSsR5AfVeu9/6V5DNu8XTk+IWtL60j+yOEgB9o7FKlJMDwBRY51+48XR6fnWiA6PNIMlwF9LXKCusjiXpkg2hKjjYg78i3nGDWMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mzmv27jF; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mzmv27jF"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a525eee2e3so4482307f8f.2
        for <ntb@lists.linux.dev>; Wed, 02 Jul 2025 09:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751474924; x=1752079724; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JKNN/g7lyNko2SGvqo2+0L7OSdhUtVAGunuTxapWjLQ=;
        b=mzmv27jFYz5WPaxf0FbvaZ2YEN+EQfN3C+znSO3OPr1X8WgHcYn63eG/sQx1871Vo5
         hlYj5dO2ckJbsUye2MDcgddELXSovMbvDxx5aqUClEcmG+tyH2ivwCvtemtGEDsKIKg+
         o/7oZhHJ2/KLx6RmD46yJ2rqFynaJzcV7DPKqMYBC/0++klwEUpw1xBfwvK/1ht6vwtz
         VKtPkqNT3gfgbd8XegJG+pIG/I0YHQku7MBF363S41vhkEzLspIFwcaRpTiRq7HqwrKx
         SyEnm3/Xj8kX3IPaQNaKuuYsB5JXOIiihqdhVwdNFv/yBYvFaq/w5MUPHEAKhshW8U6/
         /Zkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751474924; x=1752079724;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JKNN/g7lyNko2SGvqo2+0L7OSdhUtVAGunuTxapWjLQ=;
        b=u28ISgPhQzKQWKuv/u300+imnnBVz848WcaqjWo15ITmVBFBwdNxJvfSgLuk/XaVTH
         Mnr5DVBOSU5tdrjGFdlzj+VeaiD3jQ3Rzrc020anqY0P7Afjs1VivrN2CH+zTyFQ8RgT
         loDARAPMakwUjO432QIvDj9Rqu+6gEpyMU344GCpHcBajJLPDQeTRKtbnzTIVqw84yAU
         Qi/f8ETf61WJIxUDdDxKZhO2C7POJlNMtKm5BSyAKwP12iPc2QGLGHitcCtXJIbnXMJj
         ZTh7T9XUcMgSW8NKtsOcjJcSc4IdnCvg+/YAgZrUFQgxtdA8JzwH68XTSCR6v2cAi5s8
         7rcQ==
X-Gm-Message-State: AOJu0YxRE9fwgD/1KS10pzETgvlgo/lxfviI6NHU2O+xu+VOFvdhLq2d
	H5KOTrEV7w5rk+IwUktk32OhB4oSeE4SS+VpjO1JkeECm8d2itsVRF0Xj7oh7YC83nc=
X-Gm-Gg: ASbGncvm7bl5ZxG3QR/RHxz+165jOj546NyPhJzOfGOx5u/hMp6BirZXKffj4nZiqOq
	+XOlAhRKcxfH91nS9kk2nxHd1aMDcsvMsfyCff7kNSEwSSCHE1boceRjYC9xKK63J1zQBywU//L
	356JOl+lgfmenjABSzdOyP21Si7K7t7mcDkyzCrTx+wOdRzwp5f8Xkn0DKjPWpZV6imdFbjg+f7
	aIsq4PAHPNuqKUda5qndu4zrd9itgWk0wAlmodWW3R0YX3qNBvi9gOghH70zYMFNtiR83MxMIOj
	zLj6wYQ9mu1TF6ygYrx7GaVzq9FH61LZgv0ZPGKNt+hQcWq0SSxjhs9+DZ7sgoSvhuNMhhpiauX
	V
X-Google-Smtp-Source: AGHT+IH/RPcrCUoqyT36iJDXMXCe8KYqucH68yz5LEkiC2ozN1/+ng/lt8hJwM6jH5Jq4prulqE/NQ==
X-Received: by 2002:a05:6000:2a08:b0:3a5:7904:b959 with SMTP id ffacd0b85a97d-3b20110b59cmr2389550f8f.58.1751474924547;
        Wed, 02 Jul 2025 09:48:44 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:5542:4bad:e07b:9489])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-454a9bac51bsm2871155e9.39.2025.07.02.09.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 09:48:44 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH v3 0/2] NTB: epf: add vNTB support for Renesas rcar
 platform
Date: Wed, 02 Jul 2025 18:48:32 +0200
Message-Id: <20250702-ntb-rcar-support-v3-0-4268d9c85eb7@baylibre.com>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOBiZWgC/32NTQ6CMBBGr0Jm7Zim5UdceQ/DAoZBJlHaTJFIC
 He3cgCX7yXf+zaIrMIRrtkGyotE8VMCd8qAxnZ6MEqfGKyxhSltjtPcoVKrGN8heJ2RnauroSq
 pcBbSLCgP8jmS9ybxKHH2uh4Pi/3ZP7HFosELGS5oKGvK+1vXrk/plM/kX9Ds+/4FtW8oK7MAA
 AA=
X-Change-ID: 20250624-ntb-rcar-support-e3397f76c532
To: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
 Allen Hubbe <allenbh@gmail.com>
Cc: ntb@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.li@nxp.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1608; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=0F00VHx0gtIe+9FxH9hZnjKBU1cK5Id/md6nN4vDe0E=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBoZWLpAkOSSsR+/WyXvinYXJPGQAOm9+THxd+9n
 QTOUkD3IImJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCaGVi6QAKCRDm/A8cN/La
 hW8jD/9Esu3hcQiYXsNuDgVIHTDQlR1KXH+hpTe0RTNe2WbY0k6bwPz5BOJsC6k2mGNrD3EBE3D
 fjrrSSln1LRt9Fxz2sa3qWqFrO/4N+E6sLNlJKPjuJWm3kEucf2Xpw/kZfOBaqGGKPnvS6U+8d7
 ZK2PiRj80TzX3r/et7+h2TnIR/NGe0z9+4LtMXfU+duI+b/3FYoa0yPnpAYgU1V/JakbJRft16f
 lQQ3aBsuKtQaqLJI7GOhcSUyg1lrmhyF2qXwYArax4e+S17/hVRK2VjBDULm4NOvgLt5ZwHMKDS
 GSE/QJ7XM9fyxmOyw4/VzEeAhy/HHQFayuaZZoOOZh5c/xn5hF2Nsce5X9E66AKDOv+MfJ9QuXy
 Te3Hmhc+pKaoNmpAIdoo4UAfn1IeAYM87yxV9kpxTC1X1hGIstNzxMtjuhCpgQITk6qKBxyxzTl
 Gb8pTMoLwtRksWAjoT46p5vexQ0SaNHt3WXx/AXQoWhxMDSHLtU2RidMjtyy4Z/173ln9wwolTe
 8SiLPIVXgGxMRHXaJCY8HJW9wJffPlJpyaxglqEDo8F+HQWWgQovGYlrF2HXtaxTxhqK9p9kGQe
 1umNqjtt+skugwtNHZBXrGhaF1Hw4ZCiGwPRnoTajNnDlxhNepoFRg+DOFKLaABk2I0kmCd21bG
 qnMAXOaXtAXG/IQ==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

This patchset adds support create vNTB link between rcar platforms
This was tested on rcar gen4.

The changes here are for the RC side of things. The EP side was sent here
[2]. There is a runtime dependency to get a working vNTB link between the
two but no compile time dependency. It should be safe for 2 series to go
along in different trees, even during the same cycle.

It may seem like we are starting straight from v2, but a v1 of PATCH 1 has
been sent along the v1 of EP side series [1], for illustration. Starting
from v2 to avoid any confusion.

Changes in v3:
- Remove unrelated line moved as requested
- Link to v2: https://lore.kernel.org/r/20250624-ntb-rcar-support-v2-0-8c0e5cf69c4d@baylibre.com

Changes in v2:
- Rename barno to barno_map
- Drop unnecessary default values
- Actually add rcar support with an product id provided by Renesas
- Link to v1: https://lore.kernel.org/r/20250505-pci-vntb-bar-mapping-v1-4-0e0d12b2fa71@baylibre.com

[1]: https://lore.kernel.org/r/20250505-pci-vntb-bar-mapping-v1-0-0e0d12b2fa71@baylibre.com
[2]: https://lore.kernel.org/r/20250603-pci-vntb-bar-mapping-v2-0-fc685a22ad28@baylibre.com

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
Jerome Brunet (2):
      NTB: epf: Allow arbitrary BAR mapping
      NTB: epf: Add Renesas rcar support

 drivers/ntb/hw/epf/ntb_hw_epf.c | 118 +++++++++++++++++++++++-----------------
 1 file changed, 68 insertions(+), 50 deletions(-)
---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250624-ntb-rcar-support-e3397f76c532

Best regards,
-- 
Jerome

