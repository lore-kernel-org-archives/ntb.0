Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E2835E947;
	Fri,  1 May 2026 06:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777617354; cv=none; b=RoYkGO9EEG8Z+Xxpga20l/a36ORI9LOA9ASQhJpzCZHmGcJOhnqg0VQ7lhmlfMmvjojem/+y7t7Ywu/aGdGs5noEPRJGqbipM3G5+ijJ5RMQK0Uc7SZq0oLqet65Vw+JHQtJcy/uqhfNvV9ActuDqteKkVfiLNafWQGu9PIzcvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777617354; c=relaxed/simple;
	bh=S0yiXMvQJK/N6ps9wR2OP0iUguuljk4MVax88ktyVjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TKLfxoJuFyGI5KLT5OTDY2fVsYaIbd+HXbbF9ynnUTXgoHwWtqClu5rTE4V3A069IEbMDtCn7bWpFNgj2NZiWKeXgFHCnFs3NU/DGR4qLA3HDccFWfBxRz3k/FeTOXcNAfYA/5APau5yuyYdUnJFMKR/WjH9zkCGSNFjsT0Z36I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O5jyVPII; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5jyVPII"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C8C9C2BCB7;
	Fri,  1 May 2026 06:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777617353;
	bh=S0yiXMvQJK/N6ps9wR2OP0iUguuljk4MVax88ktyVjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O5jyVPIIt5PlIAM/78tnqB22z98xvekkMwe8yuScR41A7Yd+zL6j2Nr1KicsieWs2
	 Ur9B1cYgjCIlW63Sl19+mnq7ojcXK0i20tasaXl+T2y7ZKbvYrtCIrKUnmdcG3UkpL
	 hTJzqbO0CCsZKy+soGSn6r2FeUAlJ49m1tpF0Sku6JSj3qhusgm4moWD7BHQUCuj8q
	 PTS+QKrDlaUgxhYKNiE0I/eoGJ2PHWB6h1eRq/H/NIRPT8aCnDubrhF+VkwofEfhkq
	 9wy+g3vm3xe9AZNMMhBxNippgT+RgyEpTOWpSl2tNOgOXVfLC6fdQOjp5e1OWdzy2A
	 31cHM7JJQVmYQ==
From: Leon Romanovsky <leon@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH v2 6/6] dma-debug: Ensure mappings are created and released with matching attributes
Date: Fri,  1 May 2026 09:35:10 +0300
Message-ID: <20260501-dma-attrs-debug-v2-6-8dbac75cd501@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260501-dma-attrs-debug-v2-0-8dbac75cd501@nvidia.com>
References: <20260501-dma-attrs-debug-v2-0-8dbac75cd501@nvidia.com>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-18f8f
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

The DMA API expects that callers use the same attributes when mapping
and unmapping. Add tracking to verify this and catch mismatches.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 kernel/dma/debug.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 3dfed51c3d9aa..c38efc1ac8d6c 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -1074,6 +1074,29 @@ static void check_unmap(struct dma_debug_entry *ref)
 			   type2name[entry->type]);
 	}
 
+	/*
+	 * This may be no bug in reality - but DMA API still expects
+	 * that entry is unmapped with same attributes as it was mapped.
+	 *
+	 * DMA_ATTR_UNMAP_VALID lists the attributes that must be identical
+	 * between map and unmap. Any attribute outside this set (e.g.
+	 * DMA_ATTR_NO_WARN, DMA_ATTR_SKIP_CPU_SYNC) is allowed to differ.
+	 */
+#define DMA_ATTR_UNMAP_VALID                                               \
+	(DMA_ATTR_NO_KERNEL_MAPPING | DMA_ATTR_FORCE_CONTIGUOUS |          \
+	 DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT | DMA_ATTR_PRIVILEGED | \
+	 DMA_ATTR_CC_SHARED)
+	if ((ref->attrs & DMA_ATTR_UNMAP_VALID) !=
+	    (entry->attrs & DMA_ATTR_UNMAP_VALID)) {
+		err_printk(ref->dev, entry,
+			   "device driver frees "
+			   "DMA memory with different attributes "
+			   "[device address=0x%016llx] [size=%llu bytes] "
+			   "[mapped with 0x%lx] [unmapped with 0x%lx]\n",
+			   ref->dev_addr, ref->size, entry->attrs, ref->attrs);
+	}
+#undef DMA_ATTR_UNMAP_VALID
+
 	hash_bucket_del(entry);
 	put_hash_bucket(bucket, flags);
 

-- 
2.53.0

