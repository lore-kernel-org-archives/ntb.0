Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FC41C4A16
	for <ntb@lists.linux.dev>; Fri, 28 Mar 2025 14:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743173632; cv=none; b=Y1YznC1FGetZ52RprCuRZBzmi0Tghu8rX76J+jCJyYbRBMT6IQpAHdh3I85YUHJDWYsBz4a943f+K1oSaxil3X3ipiASt3N9xFDpkyJBgg2nD15zm+/4OmlGKtCz9l0E4xwmXWRbWJYgTmDTWx+RLKk0Wo+BBR8sx28alFvQbHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743173632; c=relaxed/simple;
	bh=h+SzrP+RZ8z9TwNW8IncYGnwYKmJ+Japqx/sQUvxAAk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SNK85MiS5gFOZb3khLt2fIKQvD81MsRKMEn2Tb7FL4OFbqsLVRl4MaWP0sR7gvbBBTA/2ewrChU4n+KAuQNnzr25T8b5Pl7HWqALXCLAf/XuDGBTvx3zRqxE4BOG7P9yQcw5O/QPiQZp7tbgJnIWzFENfW4Ue1fqwzHkUSHZ1eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=IhxUpEP1; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IhxUpEP1"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43d0618746bso15995775e9.2
        for <ntb@lists.linux.dev>; Fri, 28 Mar 2025 07:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743173628; x=1743778428; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MkLAt8PK2xSjKKwaEKAeZ6n8Ih4eyZAWH2VlHcJWcqY=;
        b=IhxUpEP12k3VkllWVq+RrwQV49JIlL0a7ixh7t9Wp5SMwcG160b4ZsB7gl4ijvp+gi
         HmlDPTs1lACjvC7EjBv9Z4ck6YFCo2nQzUjR2gxwvIJGBa4fJ60fDC0ilDidw5rBS47R
         6ojGEUU2XW/G/zcDZ/bWBAkx/XnORo0lyfJ7qvdHpcfG90Mr3qeOofeub6GcfW9qML8x
         QuaZbDonaArAdQiukvXrt+Rqy4BLwuRCISWao1sLyFXSuKflYrAtAUL158azyOvARbTN
         BuTxPkDbzex08MykP28DAlPCLgDeArkkzzPSf7mClsktvF59DxVqbu0JS/tQI6+851qh
         s+KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743173628; x=1743778428;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MkLAt8PK2xSjKKwaEKAeZ6n8Ih4eyZAWH2VlHcJWcqY=;
        b=WTbbybUm4s4Sd5PZRBRxI6ls/1huoQcyb5tyxJplzEr/CZpzu4HHY0LCnLNJbRN0pi
         ENFkeGzSU0Lp9oa9wYMVf6odLp0QgVssUgHHrOexLM8mXK/ftjQ5K2MK/AyVJNN7B6mk
         eO0Ad25vErM+rHxerBMOvmE94efikt5oh7VMQKBLLVpE63PFNhZcu4uJdvlGTyHLrXKC
         Vp67xyo6OfYKa22tQIjiXj+lTXvrd+QjPj5846672pSCF/F6fP/Bn8yHa8cB8CpURCZg
         YvUquz0jwleKIYQKI/FN/ou8uHSevANrHquwB1hlGhFrsERC3rfEOfVKRXAooCiSfRox
         cSHA==
X-Forwarded-Encrypted: i=1; AJvYcCXUezvk1WC4DVrTrlG7V90ftdWb6mH97L+ZgPgNT7N2iFrnBXn3GvajqWMw+4jPRWWnZuo=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw9U7AWldJOYERigloS7zUjgTSVNrZOybg12gNBSdMwWUKRkLGg
	VsQgpqebK9WKF7cY/1EaJkFYflHqcEmrf9w+deN1Xfy9XmphNx4lNe8dHo32IC0=
X-Gm-Gg: ASbGncsAQiwFROinqpj8Z2P3UYXcU4wUnJKNwppNeFcHJ9gZY0Pj3bUHp6Elsb24jvd
	zzqiscUJAsYd1OA0q47tIOxNtgnweIG4thzINtXI8glkOyyhw/zndLGkM3ImSANGfDN9VoDKAZC
	cIMmKCFMTxr+YIm/wbtqJcLIrZSVgkW8SXNGPagJh3Zz2ON3j2e6rWqUiT/WlNNlPMYrSP7RnJj
	aes2Hf8729KVRk6WyahJPpixqNH/bksjJGbNlpN+uskagdf2H/FFkdEZyxNspCaDkpepLgGvxWX
	aXmRpDScDk7EOqy2Ln6JEmL1fkZhwi8AedoIpwtw0qGN4GKi34E3bfPT4gg=
X-Google-Smtp-Source: AGHT+IGNCjgZ3Bl84aRncvmcRZ1fKqVabYX/8QK9ricPnQMRBg81uZzPmVzF9hh/OcpNiA/ptaZDaQ==
X-Received: by 2002:a05:600c:1e87:b0:43d:ea:51d2 with SMTP id 5b1f17b1804b1-43d850fd4c6mr101061575e9.14.1743173627741;
        Fri, 28 Mar 2025 07:53:47 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:70c0:edf6:6897:a3f8])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43d8314e110sm75219615e9.39.2025.03.28.07.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 07:53:47 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 0/2] PCI: endpoint: space allocation fixups
Date: Fri, 28 Mar 2025 15:53:41 +0100
Message-Id: <20250328-pci-ep-size-alignment-v1-0-ee5b78b15a9a@baylibre.com>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPW35mcC/x3MQQqAIBBA0avIrBswQ7CuEi00pxooE42IorsnL
 d/i/wcyJaYMnXgg0cmZ91BQVwLGxYaZkH0xKKm0bJTBODJSxMw3oV15DhuFA1tvtFPGGakllDY
 mmvj6v/3wvh/So2qPZwAAAA==
X-Change-ID: 20250328-pci-ep-size-alignment-9d85b28b8050
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1131; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=h+SzrP+RZ8z9TwNW8IncYGnwYKmJ+Japqx/sQUvxAAk=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBn5rf3xAEcVhRALQDeCJiKrmyvwItNhXGCxC0ay
 wRo6Wa/OkiJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCZ+a39wAKCRDm/A8cN/La
 hdF0EACTpRUMvCU/wOvjdf1cqHznSt44zlfO+tSUZuOgT+NJzi949cAUHB1spKGFqF481MJtTDI
 NvdIZkR4YrTWFXbCxiUa+55YL5Y9gWG91c+lYVwp4q7BTqvbYDE48Iwvag/Zkbj5Nc2l9N0n1Ja
 Eg2xvUArK9CGvEhUoo9lzUeuprfo5OSpogtLvoyG1F5WQMLDAH1nUf+T+LzOFzLTbbVTMJwxbZG
 dnxgteTNrwqANTbxorv+b51/5pRbak3YvUtgRhrNWMKg6KkRAoZhfslTe+M+nyEfDxEdsCjXb4D
 TiTMOxpiTWFm8C1Cj88NwRpGyQvuoSGKGLFUa/gjfKGV0gAGtSsgfmLBl9kJfXy9Nr2T5nten++
 u9GEwtgnDspcBFCXEJTQUgQtL6jNUVi2UHjHepwVVMwP21kQS6hn516xUG06zSCDYc1dJ+yHb/F
 i4U7KqMK2s4PGb1EEsUV5CnCuDzy3J8+SJbOmqkwBLMjf2gKrMBbSVCJBykRqlDVgZVfpAdSt++
 OPBDXz3JJRwh1QkEnNMUtNw36DFF/wdimHclAqRD1BUytA0wbwVTRLVeeApOHMEPUQssFzafiRv
 tBQV5ijsPDBeNNC/XP6me9S/9MGr5xyCcgYzOVhQhvNuTixGb9+e7AhrAfjv/fZmWbz6zzu5kqA
 iAHkXA2b74vDOrg==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

This patchset fixes problems while trying to allocate space for PCI
endpoint function.

The problems, and related fixups, have been found while trying to link two
renesas rcar-gen4 r8a779f0-spider devices with the vNTB endpoint
function. This platform has 2 configurable BAR0 and BAR2, with an alignment
of 1MB, and fairly small fixed BAR4 of 256B.

This was tested with
 * BAR0 (1MB):  CTRL+SPAD
 * BAR2 (1MB):  MW0
 * BAR4 (256B): Doorbell

This setup is currently not supported by the vNTB EP driver and requires a
small hack. I'm working on that too.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
Jerome Brunet (2):
      PCI: endpoint: strictly apply bar fixed size to allocate space
      PCI: endpoint: pci-epf-vntb: simplify ctrl/spad space allocation

 drivers/pci/endpoint/functions/pci-epf-vntb.c | 24 ++----------------------
 drivers/pci/endpoint/pci-epf-core.c           |  7 +++----
 2 files changed, 5 insertions(+), 26 deletions(-)
---
base-commit: dea140198b846f7432d78566b7b0b83979c72c2b
change-id: 20250328-pci-ep-size-alignment-9d85b28b8050

Best regards,
-- 
Jerome

