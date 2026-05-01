Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917EC3537EE;
	Fri,  1 May 2026 06:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777617326; cv=none; b=DgbFkKagfklmSCREUf3uRwGWi5zIdziKChKUsLwCZHKtwRE2vvD00oMk3ZXCKY3Iz088qBNy5DwOkw0KxRyeEtmCqVxWFjO517ypeSavo6aYFXp5d+uR7bviP1Zh6yEgW4hWDk3TdDNY0ALzlCzBw6GAGwhzKseciBMJbv+vEo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777617326; c=relaxed/simple;
	bh=pqUK270oHvN5x8gQnXfciH4CZm1kMpsnusKgtjCk3TM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NAs7KUEXb734dbWL/bHiHkQMoXTItXoZrQB0WJpcqHJI9b2ptsX8kkMA8rQxL6j7KEEWYsEl0fFjddaCdHSgUUrL+bdmBZ9Ljf7ta/Z6vljc5TyTbZ6D+t4uKw3HQ08T5+R2Srk89D9lujyJKkEFwba9UWd6AP0O0f7rC2NyOw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCYSVLOS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCYSVLOS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2234C2BCB7;
	Fri,  1 May 2026 06:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777617326;
	bh=pqUK270oHvN5x8gQnXfciH4CZm1kMpsnusKgtjCk3TM=;
	h=From:To:Cc:Subject:Date:From;
	b=kCYSVLOS/2wkQWv+pDn7uvBiBBHQmDSjUg13dErPMqv+lSlSV0DasqMgb1MEAPjP8
	 pTVz67HRNxeaZ2Loq69GSQgZj2Erof327T+xscFmePyhFGhwSq3mXo0QPhxb6/Z4a7
	 u2rExa+rdm8tJfo9ENr2s0HZOpNxE8jBMPigU6KLA8xqM5Zn3l+e3BHP0H/jTg1Tur
	 bd8IrlrMsHoO60I4/fhNdlYhS9rIQozI3BHsatFXZ9dDonFXsc/98IqUyp2WgOSTze
	 XQ2B3zqlgg4wCayvU4qGqfBTV0fIaKmWzGhVPKd6iI9hKeoixuhWj+xiISTL4eAEv4
	 p8v5550PGG+wQ==
From: Leon Romanovsky <leon@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH v2 0/6] Add DMA attributes tracking
Date: Fri,  1 May 2026 09:35:04 +0300
Message-ID: <20260501-dma-attrs-debug-v2-0-8dbac75cd501@nvidia.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260323-dma-attrs-debug-85e282d6f3bb
X-Mailer: b4 0.15-dev-18f8f
Content-Transfer-Encoding: 8bit

The DMA API expects that callers use the same attributes when mapping
and unmapping. Add tracking to verify this and catch mismatches.

Thanks

---
Changes in v2:
- Split original patch to be a series
- Added all unmap flows
- Skipped DMA attributes which exist only in map path
- Added ntb patch
- Link to v1: https://patch.msgid.link/20260323-dma-attrs-debug-v1-1-6275228ca300@nvidia.com

---
Leon Romanovsky (6):
      ntb: Store original DMA address for future release
      ntb: Use consistent DMA attributes when freeing DMA mappings
      dma-debug: Remove unused DMA attribute parameter
      dma-debug: Record DMA attributes in debug entry
      dma-debug: Feed DMA attribute for unmapping flows too
      dma-debug: Ensure mappings are created and released with matching attributes

 drivers/ntb/ntb_transport.c | 10 +++---
 kernel/dma/debug.c          | 87 +++++++++++++++++++++++++++++++--------------
 kernel/dma/debug.h          | 25 ++++++-------
 kernel/dma/mapping.c        | 10 +++---
 4 files changed, 85 insertions(+), 47 deletions(-)
---
base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
change-id: 20260323-dma-attrs-debug-85e282d6f3bb

Best regards,
--  
Leon Romanovsky <leonro@nvidia.com>

