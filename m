Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55F326CE13
	for <ntb@lists.linux.dev>; Tue, 24 Jun 2025 16:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750781189; cv=none; b=AaiS2Cc5JO2fG+EcaZoXPrmHTqFhbaIonrf0sTFjGwddLi5GXYbXrxrEYTBlYqAMgQbo8Gc0bn60CEYJ2queUCZaWd5K61lm5oGQCNldYzStrlXHlOyEhN2jd96XB4YQXAxY1S2790ci1KidWe44Vu9Aa6gdW8MXvUtOcGUlxPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750781189; c=relaxed/simple;
	bh=xlkLlcSf0h/ZKVboOWy/I0VnhwHvItq4orD9GOCGulY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VFiTdIlHejA5W9kiVYELZyfSwakIhqe9AVrmvSrqrNZuQOP9jw/R30FgcACuLNOXmjSfEQ225RzeWQHJ5DGfL9fYv0Gmwp9Y6gQ7krxjlH7GTd+ln9rdxreL403R1XnGYnRj+eeeLK3y6H8VMtOeW/a69QpDBn9RfmIhNScBVzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=wgCOgIQC; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="wgCOgIQC"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a4e742dc97so14497f8f.0
        for <ntb@lists.linux.dev>; Tue, 24 Jun 2025 09:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1750781184; x=1751385984; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1cid1BQIElBt/p0v4bYFzQjvCg76HYy8SFF6cbZxptU=;
        b=wgCOgIQCHk0MIVvw3K9Mb/kzu80ZS+rKw5szE9K8/+VUCPwDt/2VH3irYeA83dcUf7
         4ErHgRlHTUkTFPLg65dj23H2hwra9wASElS6cR+ueI+rBMkQOMULS8Io+q+GIHnMZ5bM
         qugvt21F6b2vn+wbPLZOaaC8DCJ+yRsCmO9PMkMmg7GQUzkZC8psYY5epWAYNazA0OE4
         kEw03MQhFSGTHGmgn+uatEGbgAAnGJj/0cnmv7s0WsGTB1PKyrMCnJxayoruMiCNQMPS
         C7TjxzRzzA4i60IIOeSui01uBCegLWY/o5YW2sV9UK4ANJKDsvopERW1Uep0IHEn+/Q9
         uryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750781184; x=1751385984;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1cid1BQIElBt/p0v4bYFzQjvCg76HYy8SFF6cbZxptU=;
        b=AZD64iZetYSMtJkx3mZf6XUIcxa2cK+0qlZJbH48qP3pWwSUPTjs/u8/oYvQBlYNas
         0iTI1zVJXTJ5rH519g/IDua3M+ofXVqhpbtNYzfBT3B4XTt0ULHaXuWoNir+H43i4C8K
         dy3GmzhDdjUSYeGaBblpAYsgz2Cji0/hrWWFzDIV9VsguJbucr+rwE17e8BzdUeUoDS1
         i9m+AIjQWPJFzIWA3w1M0kqNRco3gPF//KNYxi0UwT0lHiZlJFrGRn1lkx8SOcoPfKsn
         bCwjtgtZZ7GsSAeT4kPQJ6IA+NrUJ6+a8zIZdm4s698R6bqwGArP3SatwE8793VkjX+z
         TriA==
X-Gm-Message-State: AOJu0YxnivH3khJkhwqfyY39ilwyEKUjOiuxz+wOc/GwFVvhxeORImrc
	2MUUUBl1nYyRv2gSt9FJ+oazoQnEPYFrSDIggk8EFTkQ1+IVTlghcXU/p4BQnUsxCRA=
X-Gm-Gg: ASbGncvU+rzq1PBOGw0fcdwFevtoG81JZNJlzIYS6Au7G+BwQSIcDrckHjisyir0Zqy
	ze7VI95K/QLM5fO6OhHvDOC9HNoR3lxLda1Zt4aT1OZQzaF1YgxiJmSZI+GSwgcEA6TsStvgMgG
	lcFRbl9al4u/3aMv8Cp9UEDMlNG+coXyG69lQvSGX3gbyS/J/fKP0hdTP+vAcbcDXgP+Xo/XhqC
	1u+5DGpwZlBrcpErG6JM5Ui44UmIGpG/2ijea1jwRXta00KcF0m0ZCtGJ6NohkQlDn9S1b8dtZp
	tK4+zq3b5L2WPkNXyLhFk5uFSJA6sDyR+XKum0WdAjYlpR2jEAc2Jn1y+O4D2qgriweB2LfTBls
	i
X-Google-Smtp-Source: AGHT+IE7QrYdODMg+rQ3Qulq63j+JWzcWyuaiscjncp3n+omTYlc5+kTNiqEaBdrxSFrvdg+ETe++Q==
X-Received: by 2002:a05:6000:2913:b0:3a5:8934:4959 with SMTP id ffacd0b85a97d-3a6e720e285mr3568635f8f.27.1750781183884;
        Tue, 24 Jun 2025 09:06:23 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:9dad:c694:2b52:ea7d])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-453646cb64csm151933805e9.4.2025.06.24.09.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 09:06:23 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH v2 0/2] NTB: epf: add vNTB support for Renesas rcar
 platform
Date: Tue, 24 Jun 2025 18:06:15 +0200
Message-Id: <20250624-ntb-rcar-support-v2-0-8c0e5cf69c4d@baylibre.com>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPfMWmgC/x3MQQ5AMBBA0avIrE0iUypcRSyoKbOpZopIxN01l
 m/x/wOJVThBXzygfEmSPWRQWYDbprAyypINVFFTWaoxHDOqmxTTGeOuB7IxXetb6xpDkLOo7OX
 +l8P4vh+x54qEYgAAAA==
X-Change-ID: 20250624-ntb-rcar-support-e3397f76c532
To: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
 Allen Hubbe <allenbh@gmail.com>
Cc: ntb@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.li@nxp.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>, 
 Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1448; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=xlkLlcSf0h/ZKVboOWy/I0VnhwHvItq4orD9GOCGulY=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBoWsz8XitbW65TZA5BSG3j7AAxJ1XgMryQBWpCW
 JJZGFjrqiSJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCaFrM/AAKCRDm/A8cN/La
 hTuRD/4qu3puCsQNgW95NrBlI2j7ugbs47thV9vS7IwWYXIeU+7jkSUFYV1h5NwVSBQxc5y8O4a
 nF//2TP0H2gFfLPOnZnclShKUc3/87jGsoX5f3O23NtBKTVrQfLWDWw91bGJp+R+Q1G1h1ywh/k
 dPs+EPuTvcWiUn/eJaD2BdKAswPoXpyPAKu7wVOZpds0h+IVm6hJ25t8NW15EqyykUsGG3yZUbo
 oEvkOXRrtbQY/zFgBYQKkMuxJckauImcPO4+Trb7zakem1pozwOJKvnCQTdLPodLEe0JgmoT6Lm
 1pZTu9/dUwR08CFEvYgVgixi7uz8twJNAuIIiem7X9cp0DR3e6WWiDmlrSgcl66rbzLm1sTXLbF
 LYlndHEx+14Z8JEr2NnDRYzrfY9JPjYj6JJ09McQWpN99/ACkukjpyfSGSOEHOMnL4qrdSq5Jy+
 ECpm1oYOCLoHMDw96rv71iK4dSWtIetcRXdmrCkMoVwBv9IhqHdgOv3F7QkB0q6yC59n24l+5lg
 A0Q/hOBTzX18ETZvuop/MX9qE/Q8OtJ5bI7Ued21bAwuBpk512fVFp7K9VZNwZOYpyRvySEM0O2
 5xz7jN4SXKBUD5ADPkh9+JUpaQyfQgjx7zO6OB1xVupE6NSmrFor9FT0FlAkD0jFfgccPYO4rNS
 /u5FJ5NPjsoepUw==
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

 drivers/ntb/hw/epf/ntb_hw_epf.c | 120 +++++++++++++++++++++++-----------------
 1 file changed, 69 insertions(+), 51 deletions(-)
---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250624-ntb-rcar-support-e3397f76c532

Best regards,
-- 
Jerome

