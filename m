Return-Path: <fancer.lancer@gmail.com>
Received: from mail-wm0-x242.google.com (mail-wm0-x242.google.com. [2a00:1450:400c:c09::242])
        by gmr-mx.google.com with ESMTPS id p138si42116wme.1.2016.12.12.13.09.14
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Dec 2016 13:09:14 -0800 (PST)
Received: by mail-wm0-x242.google.com with SMTP id m203so13842487wma.3
        for <linux-ntb@googlegroups.com>; Mon, 12 Dec 2016 13:09:14 -0800 (PST)
Return-Path: <fancer.lancer@gmail.com>
From: Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH v2 4/9] NTB: Alter MW API to support multi-ports devices
Date: Tue, 13 Dec 2016 00:08:17 +0300
Message-Id: <1481576902-21091-5-git-send-email-fancer.lancer@gmail.com>
In-Reply-To: <1481576902-21091-1-git-send-email-fancer.lancer@gmail.com>
References: <1480439777-1080-1-git-send-email-fancer.lancer@gmail.com>
 <1481576902-21091-1-git-send-email-fancer.lancer@gmail.com>
To: jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com, Xiangliang.Yu@amd.com
Cc: Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

Multi-port NTB devices permit to share a memory between all accessible peers.
Memory Windows API is altered to correspondingly initialize and map memory
windows for such devices:
 ntb_mw_count(pidx); - number of inbound memory windows, which can be allocated
for shared buffer with specified peer device.
 ntb_mw_get_align(pidx, widx); - get alignment and size restrition parameters
to properly allocate inbound memory region.
 ntb_peer_mw_count(); - get number of outbound memory windows.
 ntb_peer_mw_get_addr(widx); - get mapping address of an outbound memory window

If hardware supports inbound translation configured on the local ntb port:
 ntb_mw_set_trans(pidx, widx); - set translation address of allocated inbound
memory window so a peer device could access it.
 ntb_mw_clear_trans(pidx, widx); - clear the translation address of an inbound
memory window.

If hadrware supports outbound translation configured on the peer ntb port:
 ntb_peer_mw_set_trans(pidx, widx); - set translation address of a memory
window retrieved from a peer device
 ntb_peer_mw_clear_trans(pidx, widx); - clear the translation address of an
outbound memory window

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---
 drivers/ntb/hw/amd/ntb_hw_amd.c     |  68 +++++++++---
 drivers/ntb/hw/amd/ntb_hw_amd.h     |   2 +
 drivers/ntb/hw/intel/ntb_hw_intel.c |  90 ++++++++++++----
 drivers/ntb/hw/intel/ntb_hw_intel.h |   2 +
 drivers/ntb/ntb.c                   |   2 +
 drivers/ntb/ntb_transport.c         |  21 +++-
 drivers/ntb/test/ntb_perf.c         |  17 ++-
 drivers/ntb/test/ntb_tool.c         |  43 +++++---
 include/linux/ntb.h                 | 208 ++++++++++++++++++++++++++++--------
 9 files changed, 346 insertions(+), 107 deletions(-)

diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index b6a4291..74fe9b8 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -5,6 +5,7 @@
  *   GPL LICENSE SUMMARY
  *
  *   Copyright (C) 2016 Advanced Micro Devices, Inc. All Rights Reserved.
+ *   Copyright (C) 2016 T-Platforms. All Rights Reserved.
  *
  *   This program is free software; you can redistribute it and/or modify
  *   it under the terms of version 2 of the GNU General Public License as
@@ -13,6 +14,7 @@
  *   BSD LICENSE
  *
  *   Copyright (C) 2016 Advanced Micro Devices, Inc. All Rights Reserved.
+ *   Copyright (C) 2016 T-Platforms. All Rights Reserved.
  *
  *   Redistribution and use in source and binary forms, with or without
  *   modification, are permitted provided that the following conditions
@@ -213,40 +215,42 @@ static int ndev_mw_to_bar(struct amd_ntb_dev *ndev, int idx)
 	return 1 << idx;
 }
 
-static int amd_ntb_mw_count(struct ntb_dev *ntb)
+static int amd_ntb_mw_count(struct ntb_dev *ntb, int pidx)
 {
+	if (pidx > NTB_PIDX_MAX)
+		return -EINVAL;
+
 	return ntb_ndev(ntb)->mw_count;
 }
 
-static int amd_ntb_mw_get_range(struct ntb_dev *ntb, int idx,
-				phys_addr_t *base,
-				resource_size_t *size,
-				resource_size_t *align,
-				resource_size_t *align_size)
+static int amd_ntb_mw_get_align(struct ntb_dev *ntb, int pidx, int idx,
+				resource_size_t *addr_align,
+				resource_size_t *size_align,
+				resource_size_t *size_max)
 {
 	struct amd_ntb_dev *ndev = ntb_ndev(ntb);
 	int bar;
 
+	if (pidx > NTB_PIDX_MAX)
+		return -EINVAL;
+
 	bar = ndev_mw_to_bar(ndev, idx);
 	if (bar < 0)
 		return bar;
 
-	if (base)
-		*base = pci_resource_start(ndev->ntb.pdev, bar);
-
-	if (size)
-		*size = pci_resource_len(ndev->ntb.pdev, bar);
+	if (addr_align)
+		*addr_align = SZ_4K;
 
-	if (align)
-		*align = SZ_4K;
+	if (size_align)
+		*size_align = 1;
 
-	if (align_size)
-		*align_size = 1;
+	if (size_max)
+		*size_max = pci_resource_len(ndev->ntb.pdev, bar);
 
 	return 0;
 }
 
-static int amd_ntb_mw_set_trans(struct ntb_dev *ntb, int idx,
+static int amd_ntb_mw_set_trans(struct ntb_dev *ntb, int pidx, int idx,
 				dma_addr_t addr, resource_size_t size)
 {
 	struct amd_ntb_dev *ndev = ntb_ndev(ntb);
@@ -256,6 +260,9 @@ static int amd_ntb_mw_set_trans(struct ntb_dev *ntb, int idx,
 	u64 base_addr, limit, reg_val;
 	int bar;
 
+	if (pidx > NTB_PIDX_MAX)
+		return -EINVAL;
+
 	bar = ndev_mw_to_bar(ndev, idx);
 	if (bar < 0)
 		return bar;
@@ -328,6 +335,31 @@ static int amd_ntb_mw_set_trans(struct ntb_dev *ntb, int idx,
 	return 0;
 }
 
+static int amd_ntb_peer_mw_count(struct ntb_dev *ntb)
+{
+	/* The same as for inbound MWs */
+	return ntb_ndev(ntb)->mw_count;
+}
+
+static int amd_ntb_peer_mw_get_addr(struct ntb_dev *ntb, int idx,
+				    phys_addr_t *base, resource_size_t *size)
+{
+	struct amd_ntb_dev *ndev = ntb_ndev(ntb);
+	int bar;
+
+	bar = ndev_mw_to_bar(ndev, idx);
+	if (bar < 0)
+		return bar;
+
+	if (base)
+		*base = pci_resource_start(ndev->ntb.pdev, bar);
+
+	if (size)
+		*size = pci_resource_len(ndev->ntb.pdev, bar);
+
+	return 0;
+}
+
 static u64 amd_ntb_db_valid_mask(struct ntb_dev *ntb)
 {
 	return ntb_ndev(ntb)->db_valid_mask;
@@ -482,8 +514,10 @@ static const struct ntb_dev_ops amd_ntb_ops = {
 	.link_enable		= amd_ntb_link_enable,
 	.link_disable		= amd_ntb_link_disable,
 	.mw_count		= amd_ntb_mw_count,
-	.mw_get_range		= amd_ntb_mw_get_range,
+	.mw_get_align		= amd_ntb_mw_get_align,
 	.mw_set_trans		= amd_ntb_mw_set_trans,
+	.peer_mw_count		= amd_ntb_peer_mw_count,
+	.peer_mw_get_addr	= amd_ntb_peer_mw_get_addr,
 	.db_valid_mask		= amd_ntb_db_valid_mask,
 	.db_vector_count	= amd_ntb_db_vector_count,
 	.db_vector_mask		= amd_ntb_db_vector_mask,
diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.h b/drivers/ntb/hw/amd/ntb_hw_amd.h
index 1aeb08f..3296c98 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.h
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.h
@@ -5,6 +5,7 @@
  *   GPL LICENSE SUMMARY
  *
  *   Copyright (C) 2016 Advanced Micro Devices, Inc. All Rights Reserved.
+ *   Copyright (C) 2016 T-Platforms. All Rights Reserved.
  *
  *   This program is free software; you can redistribute it and/or modify
  *   it under the terms of version 2 of the GNU General Public License as
@@ -13,6 +14,7 @@
  *   BSD LICENSE
  *
  *   Copyright (C) 2016 Advanced Micro Devices, Inc. All Rights Reserved.
+ *   Copyright (C) 2016 T-Platforms. All Rights Reserved.
  *
  *   Redistribution and use in source and binary forms, with or without
  *   modification, are permitted provided that the following conditions
diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.c b/drivers/ntb/hw/intel/ntb_hw_intel.c
index f37b6fb..5a57d9e 100644
--- a/drivers/ntb/hw/intel/ntb_hw_intel.c
+++ b/drivers/ntb/hw/intel/ntb_hw_intel.c
@@ -6,6 +6,7 @@
  *
  *   Copyright(c) 2012 Intel Corporation. All rights reserved.
  *   Copyright (C) 2015 EMC Corporation. All Rights Reserved.
+ *   Copyright (C) 2016 T-Platforms. All Rights Reserved.
  *
  *   This program is free software; you can redistribute it and/or modify
  *   it under the terms of version 2 of the GNU General Public License as
@@ -15,6 +16,7 @@
  *
  *   Copyright(c) 2012 Intel Corporation. All rights reserved.
  *   Copyright (C) 2015 EMC Corporation. All Rights Reserved.
+ *   Copyright (C) 2016 T-Platforms. All Rights Reserved.
  *
  *   Redistribution and use in source and binary forms, with or without
  *   modification, are permitted provided that the following conditions
@@ -1156,20 +1158,26 @@ static int intel_ntb_link_disable(struct ntb_dev *ntb)
 	return 0;
 }
 
-static int intel_ntb_mw_count(struct ntb_dev *ntb)
+static int intel_ntb_mw_count(struct ntb_dev *ntb, int pidx)
 {
+	if (pidx > NTB_PIDX_MAX)
+		return -EINVAL;
+
 	return ntb_ndev(ntb)->mw_count;
 }
 
-static int intel_ntb_mw_get_range(struct ntb_dev *ntb, int idx,
-				  phys_addr_t *base,
-				  resource_size_t *size,
-				  resource_size_t *align,
-				  resource_size_t *align_size)
+static int intel_ntb_mw_get_align(struct ntb_dev *ntb, int pidx, int idx,
+				  resource_size_t *addr_align,
+				  resource_size_t *size_align,
+				  resource_size_t *size_max)
 {
 	struct intel_ntb_dev *ndev = ntb_ndev(ntb);
+	resource_size_t bar_size, mw_size;
 	int bar;
 
+	if (pidx > NTB_PIDX_MAX)
+		return -EINVAL;
+
 	if (idx >= ndev->b2b_idx && !ndev->b2b_off)
 		idx += 1;
 
@@ -1177,24 +1185,26 @@ static int intel_ntb_mw_get_range(struct ntb_dev *ntb, int idx,
 	if (bar < 0)
 		return bar;
 
-	if (base)
-		*base = pci_resource_start(ndev->ntb.pdev, bar) +
-			(idx == ndev->b2b_idx ? ndev->b2b_off : 0);
+	bar_size = pci_resource_len(ndev->ntb.pdev, bar);
 
-	if (size)
-		*size = pci_resource_len(ndev->ntb.pdev, bar) -
-			(idx == ndev->b2b_idx ? ndev->b2b_off : 0);
+	if (idx == ndev->b2b_idx)
+		mw_size = bar_size - ndev->b2b_off;
+	else
+		mw_size = bar_size;
+
+	if (addr_align)
+		*addr_align = pci_resource_len(ndev->ntb.pdev, bar);
 
-	if (align)
-		*align = pci_resource_len(ndev->ntb.pdev, bar);
+	if (size_align)
+		*size_align = 1;
 
-	if (align_size)
-		*align_size = 1;
+	if (size_max)
+		*size_max = mw_size;
 
 	return 0;
 }
 
-static int intel_ntb_mw_set_trans(struct ntb_dev *ntb, int idx,
+static int intel_ntb_mw_set_trans(struct ntb_dev *ntb, int pidx, int idx,
 				  dma_addr_t addr, resource_size_t size)
 {
 	struct intel_ntb_dev *ndev = ntb_ndev(ntb);
@@ -1204,6 +1214,9 @@ static int intel_ntb_mw_set_trans(struct ntb_dev *ntb, int idx,
 	u64 base, limit, reg_val;
 	int bar;
 
+	if (pidx > NTB_PIDX_MAX)
+		return -EINVAL;
+
 	if (idx >= ndev->b2b_idx && !ndev->b2b_off)
 		idx += 1;
 
@@ -1292,6 +1305,36 @@ static int intel_ntb_mw_set_trans(struct ntb_dev *ntb, int idx,
 	return 0;
 }
 
+static int intel_ntb_peer_mw_count(struct ntb_dev *ntb)
+{
+	/* Numbers of inbound and outbound memory windows match */
+	return ntb_ndev(ntb)->mw_count;
+}
+
+static int intel_ntb_peer_mw_get_addr(struct ntb_dev *ntb, int idx,
+				     phys_addr_t *base, resource_size_t *size)
+{
+	struct intel_ntb_dev *ndev = ntb_ndev(ntb);
+	int bar;
+
+	if (idx >= ndev->b2b_idx && !ndev->b2b_off)
+		idx += 1;
+
+	bar = ndev_mw_to_bar(ndev, idx);
+	if (bar < 0)
+		return bar;
+
+	if (base)
+		*base = pci_resource_start(ndev->ntb.pdev, bar) +
+			(idx == ndev->b2b_idx ? ndev->b2b_off : 0);
+
+	if (size)
+		*size = pci_resource_len(ndev->ntb.pdev, bar) -
+			(idx == ndev->b2b_idx ? ndev->b2b_off : 0);
+
+	return 0;
+}
+
 static int intel_ntb_db_is_unsafe(struct ntb_dev *ntb)
 {
 	return ndev_ignore_unsafe(ntb_ndev(ntb), NTB_UNSAFE_DB);
@@ -1922,7 +1965,7 @@ static int intel_ntb3_link_enable(struct ntb_dev *ntb,
 
 	return 0;
 }
-static int intel_ntb3_mw_set_trans(struct ntb_dev *ntb, int idx,
+static int intel_ntb3_mw_set_trans(struct ntb_dev *ntb, int pidx, int idx,
 				   dma_addr_t addr, resource_size_t size)
 {
 	struct intel_ntb_dev *ndev = ntb_ndev(ntb);
@@ -1932,6 +1975,9 @@ static int intel_ntb3_mw_set_trans(struct ntb_dev *ntb, int idx,
 	u64 base, limit, reg_val;
 	int bar;
 
+	if (pidx > NTB_PIDX_MAX)
+		return -EINVAL;
+
 	if (idx >= ndev->b2b_idx && !ndev->b2b_off)
 		idx += 1;
 
@@ -2933,8 +2979,10 @@ static const struct ntb_dev_ops intel_ntb_ops = {
 	.link_enable		= intel_ntb_link_enable,
 	.link_disable		= intel_ntb_link_disable,
 	.mw_count		= intel_ntb_mw_count,
-	.mw_get_range		= intel_ntb_mw_get_range,
+	.mw_get_align		= intel_ntb_mw_get_align,
 	.mw_set_trans		= intel_ntb_mw_set_trans,
+	.peer_mw_count		= intel_ntb_peer_mw_count,
+	.peer_mw_get_addr	= intel_ntb_peer_mw_get_addr,
 	.db_is_unsafe		= intel_ntb_db_is_unsafe,
 	.db_valid_mask		= intel_ntb_db_valid_mask,
 	.db_vector_count	= intel_ntb_db_vector_count,
@@ -2963,8 +3011,10 @@ static const struct ntb_dev_ops intel_ntb3_ops = {
 	.link_enable		= intel_ntb3_link_enable,
 	.link_disable		= intel_ntb_link_disable,
 	.mw_count		= intel_ntb_mw_count,
-	.mw_get_range		= intel_ntb_mw_get_range,
+	.mw_get_align		= intel_ntb_mw_get_align,
 	.mw_set_trans		= intel_ntb3_mw_set_trans,
+	.peer_mw_count		= intel_ntb_peer_mw_count,
+	.peer_mw_get_addr	= intel_ntb_peer_mw_get_addr,
 	.db_valid_mask		= intel_ntb_db_valid_mask,
 	.db_vector_count	= intel_ntb_db_vector_count,
 	.db_vector_mask		= intel_ntb_db_vector_mask,
diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.h b/drivers/ntb/hw/intel/ntb_hw_intel.h
index f12c960..4fd75a1 100644
--- a/drivers/ntb/hw/intel/ntb_hw_intel.h
+++ b/drivers/ntb/hw/intel/ntb_hw_intel.h
@@ -6,6 +6,7 @@
  *
  *   Copyright(c) 2012 Intel Corporation. All rights reserved.
  *   Copyright (C) 2015 EMC Corporation. All Rights Reserved.
+ *   Copyright (C) 2016 T-Platforms. All Rights Reserved.
  *
  *   This program is free software; you can redistribute it and/or modify
  *   it under the terms of version 2 of the GNU General Public License as
@@ -15,6 +16,7 @@
  *
  *   Copyright(c) 2012 Intel Corporation. All rights reserved.
  *   Copyright (C) 2015 EMC Corporation. All Rights Reserved.
+ *   Copyright (C) 2016 T-Platforms. All Rights Reserved.
  *
  *   Redistribution and use in source and binary forms, with or without
  *   modification, are permitted provided that the following conditions
diff --git a/drivers/ntb/ntb.c b/drivers/ntb/ntb.c
index 2e25307..f6153af 100644
--- a/drivers/ntb/ntb.c
+++ b/drivers/ntb/ntb.c
@@ -5,6 +5,7 @@
  *   GPL LICENSE SUMMARY
  *
  *   Copyright (C) 2015 EMC Corporation. All Rights Reserved.
+ *   Copyright (C) 2016 T-Platforms. All Rights Reserved.
  *
  *   This program is free software; you can redistribute it and/or modify
  *   it under the terms of version 2 of the GNU General Public License as
@@ -18,6 +19,7 @@
  *   BSD LICENSE
  *
  *   Copyright (C) 2015 EMC Corporation. All Rights Reserved.
+ *   Copyright (C) 2016 T-Platforms. All Rights Reserved.
  *
  *   Redistribution and use in source and binary forms, with or without
  *   modification, are permitted provided that the following conditions
diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 37d428d..cb4f99889 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -685,7 +685,7 @@ static void ntb_free_mw(struct ntb_transport_ctx *nt, int num_mw)
 	if (!mw->virt_addr)
 		return;
 
-	ntb_mw_clear_trans(nt->ndev, num_mw);
+	ntb_mw_clear_trans(nt->ndev, PIDX, num_mw);
 	dma_free_coherent(&pdev->dev, mw->buff_size,
 			  mw->virt_addr, mw->dma_addr);
 	mw->xlat_size = 0;
@@ -742,7 +742,8 @@ static int ntb_set_mw(struct ntb_transport_ctx *nt, int num_mw,
 	}
 
 	/* Notify HW the memory location of the receive buffer */
-	rc = ntb_mw_set_trans(nt->ndev, num_mw, mw->dma_addr, mw->xlat_size);
+	rc = ntb_mw_set_trans(nt->ndev, PIDX, num_mw, mw->dma_addr,
+			      mw->xlat_size);
 	if (rc) {
 		dev_err(&pdev->dev, "Unable to set mw%d translation", num_mw);
 		ntb_free_mw(nt, num_mw);
@@ -1072,13 +1073,18 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
 	int node;
 	int rc, i;
 
-	mw_count = ntb_mw_count(ndev);
+	mw_count = ntb_mw_count(ndev, PIDX);
 	if (ntb_spad_count(ndev) < (NUM_MWS + 1 + mw_count * 2)) {
 		dev_err(&ndev->dev, "Not enough scratch pad registers for %s",
 			NTB_TRANSPORT_NAME);
 		return -EIO;
 	}
 
+	if (!ndev->ops->mw_set_trans) {
+		dev_err(&ndev->dev, "Inbound MW based NTB API is required\n");
+		return -EINVAL;
+	}
+
 	if (ntb_db_is_unsafe(ndev))
 		dev_dbg(&ndev->dev,
 			"doorbell is unsafe, proceed anyway...\n");
@@ -1109,8 +1115,13 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
 	for (i = 0; i < mw_count; i++) {
 		mw = &nt->mw_vec[i];
 
-		rc = ntb_mw_get_range(ndev, i, &mw->phys_addr, &mw->phys_size,
-				      &mw->xlat_align, &mw->xlat_align_size);
+		rc = ntb_mw_get_align(ndev, PIDX, i, &mw->xlat_align,
+				      &mw->xlat_align_size, NULL);
+		if (rc)
+			goto err1;
+
+		rc = ntb_peer_mw_get_addr(ndev, i, &mw->phys_addr,
+					  &mw->phys_size);
 		if (rc)
 			goto err1;
 
diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index 481827a..3efb5b5 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -453,7 +453,7 @@ static void perf_free_mw(struct perf_ctx *perf)
 	if (!mw->virt_addr)
 		return;
 
-	ntb_mw_clear_trans(perf->ntb, 0);
+	ntb_mw_clear_trans(perf->ntb, PIDX, 0);
 	dma_free_coherent(&pdev->dev, mw->buf_size,
 			  mw->virt_addr, mw->dma_addr);
 	mw->xlat_size = 0;
@@ -489,7 +489,7 @@ static int perf_set_mw(struct perf_ctx *perf, resource_size_t size)
 		mw->buf_size = 0;
 	}
 
-	rc = ntb_mw_set_trans(perf->ntb, 0, mw->dma_addr, mw->xlat_size);
+	rc = ntb_mw_set_trans(perf->ntb, PIDX, 0, mw->dma_addr, mw->xlat_size);
 	if (rc) {
 		dev_err(&perf->ntb->dev, "Unable to set mw0 translation\n");
 		perf_free_mw(perf);
@@ -560,8 +560,12 @@ static int perf_setup_mw(struct ntb_dev *ntb, struct perf_ctx *perf)
 
 	mw = &perf->mw;
 
-	rc = ntb_mw_get_range(ntb, 0, &mw->phys_addr, &mw->phys_size,
-			      &mw->xlat_align, &mw->xlat_align_size);
+	rc = ntb_mw_get_align(ntb, PIDX, 0, &mw->xlat_align,
+			      &mw->xlat_align_size, NULL);
+	if (rc)
+		return rc;
+
+	rc = ntb_peer_mw_get_addr(ntb, 0, &mw->phys_addr, &mw->phys_size);
 	if (rc)
 		return rc;
 
@@ -765,6 +769,11 @@ static int perf_probe(struct ntb_client *client, struct ntb_dev *ntb)
 		return -EIO;
 	}
 
+	if (!ntb->ops->mw_set_trans) {
+		dev_err(&ntb->dev, "Need inbound MW based NTB API\n");
+		return -EINVAL;
+	}
+
 	if (ntb_peer_port_count(ntb) != 1)
 		dev_warn(&ntb->dev, "Multi-port NTB devices unsupported\n");
 
diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c
index 85b6417..7aa6018 100644
--- a/drivers/ntb/test/ntb_tool.c
+++ b/drivers/ntb/test/ntb_tool.c
@@ -119,7 +119,8 @@ MODULE_VERSION(DRIVER_VERSION);
 MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESCRIPTION);
 
-#define MAX_MWS 16
+/* It is rare to have hadrware with greater than six MWs */
+#define MAX_MWS	6
 /* Only two-ports devices are supported */
 #define PIDX	0
 
@@ -670,28 +671,27 @@ static int tool_setup_mw(struct tool_ctx *tc, int idx, size_t req_size)
 {
 	int rc;
 	struct tool_mw *mw = &tc->mws[idx];
-	phys_addr_t base;
-	resource_size_t size, align, align_size;
+	resource_size_t size, align_addr, align_size;
 	char buf[16];
 
 	if (mw->peer)
 		return 0;
 
-	rc = ntb_mw_get_range(tc->ntb, idx, &base, &size, &align,
-			      &align_size);
+	rc = ntb_mw_get_align(tc->ntb, PIDX, idx, &align_addr,
+				&align_size, &size);
 	if (rc)
 		return rc;
 
 	mw->size = min_t(resource_size_t, req_size, size);
-	mw->size = round_up(mw->size, align);
+	mw->size = round_up(mw->size, align_addr);
 	mw->size = round_up(mw->size, align_size);
 	mw->peer = dma_alloc_coherent(&tc->ntb->pdev->dev, mw->size,
 				      &mw->peer_dma, GFP_KERNEL);
 
-	if (!mw->peer)
+	if (!mw->peer || !IS_ALIGNED(mw->peer_dma, align_addr))
 		return -ENOMEM;
 
-	rc = ntb_mw_set_trans(tc->ntb, idx, mw->peer_dma, mw->size);
+	rc = ntb_mw_set_trans(tc->ntb, PIDX, idx, mw->peer_dma, mw->size);
 	if (rc)
 		goto err_free_dma;
 
@@ -718,7 +718,7 @@ static void tool_free_mw(struct tool_ctx *tc, int idx)
 	struct tool_mw *mw = &tc->mws[idx];
 
 	if (mw->peer) {
-		ntb_mw_clear_trans(tc->ntb, idx);
+		ntb_mw_clear_trans(tc->ntb, PIDX, idx);
 		dma_free_coherent(&tc->ntb->pdev->dev, mw->size,
 				  mw->peer,
 				  mw->peer_dma);
@@ -744,8 +744,9 @@ static ssize_t tool_peer_mw_trans_read(struct file *filep,
 
 	phys_addr_t base;
 	resource_size_t mw_size;
-	resource_size_t align;
+	resource_size_t align_addr;
 	resource_size_t align_size;
+	resource_size_t max_size;
 
 	buf_size = min_t(size_t, size, 512);
 
@@ -753,8 +754,9 @@ static ssize_t tool_peer_mw_trans_read(struct file *filep,
 	if (!buf)
 		return -ENOMEM;
 
-	ntb_mw_get_range(mw->tc->ntb, mw->idx,
-			 &base, &mw_size, &align, &align_size);
+	ntb_mw_get_align(mw->tc->ntb, PIDX, mw->idx,
+			 &align_addr, &align_size, &max_size);
+	ntb_peer_mw_get_addr(mw->tc->ntb, mw->idx, &base, &mw_size);
 
 	off += scnprintf(buf + off, buf_size - off,
 			 "Peer MW %d Information:\n", mw->idx);
@@ -769,12 +771,16 @@ static ssize_t tool_peer_mw_trans_read(struct file *filep,
 
 	off += scnprintf(buf + off, buf_size - off,
 			 "Alignment             \t%lld\n",
-			 (unsigned long long)align);
+			 (unsigned long long)align_addr);
 
 	off += scnprintf(buf + off, buf_size - off,
 			 "Size Alignment        \t%lld\n",
 			 (unsigned long long)align_size);
 
+	off += scnprintf(buf + off, buf_size - off,
+			 "Size Max              \t%lld\n",
+			 (unsigned long long)max_size);
+
 	off += scnprintf(buf + off, buf_size - off,
 			 "Ready                 \t%c\n",
 			 (mw->peer) ? 'Y' : 'N');
@@ -829,8 +835,7 @@ static int tool_init_mw(struct tool_ctx *tc, int idx)
 	phys_addr_t base;
 	int rc;
 
-	rc = ntb_mw_get_range(tc->ntb, idx, &base, &mw->win_size,
-			      NULL, NULL);
+	rc = ntb_peer_mw_get_addr(tc->ntb, idx, &base, &mw->win_size);
 	if (rc)
 		return rc;
 
@@ -915,6 +920,12 @@ static int tool_probe(struct ntb_client *self, struct ntb_dev *ntb)
 	int rc;
 	int i;
 
+	if (!ntb->ops->mw_set_trans) {
+		dev_dbg(&ntb->dev, "need inbound MW based NTB API\n");
+		rc = -EINVAL;
+		goto err_tc;
+	}
+
 	if (ntb_db_is_unsafe(ntb))
 		dev_dbg(&ntb->dev, "doorbell is unsafe\n");
 
@@ -933,7 +944,7 @@ static int tool_probe(struct ntb_client *self, struct ntb_dev *ntb)
 	tc->ntb = ntb;
 	init_waitqueue_head(&tc->link_wq);
 
-	tc->mw_count = min(ntb_mw_count(tc->ntb), MAX_MWS);
+	tc->mw_count = min(ntb_mw_count(tc->ntb, PIDX), MAX_MWS);
 	for (i = 0; i < tc->mw_count; i++) {
 		rc = tool_init_mw(tc, i);
 		if (rc)
diff --git a/include/linux/ntb.h b/include/linux/ntb.h
index 47ec611..fb78663 100644
--- a/include/linux/ntb.h
+++ b/include/linux/ntb.h
@@ -5,6 +5,7 @@
  *   GPL LICENSE SUMMARY
  *
  *   Copyright (C) 2015 EMC Corporation. All Rights Reserved.
+ *   Copyright (C) 2016 T-Platforms. All Rights Reserved.
  *
  *   This program is free software; you can redistribute it and/or modify
  *   it under the terms of version 2 of the GNU General Public License as
@@ -18,6 +19,7 @@
  *   BSD LICENSE
  *
  *   Copyright (C) 2015 EMC Corporation. All Rights Reserved.
+ *   Copyright (C) 2016 T-Platforms. All Rights Reserved.
  *
  *   Redistribution and use in source and binary forms, with or without
  *   modification, are permitted provided that the following conditions
@@ -187,9 +189,13 @@ static inline int ntb_ctx_ops_is_valid(const struct ntb_ctx_ops *ops)
  * @link_enable:	See ntb_link_enable().
  * @link_disable:	See ntb_link_disable().
  * @mw_count:		See ntb_mw_count().
- * @mw_get_range:	See ntb_mw_get_range().
+ * @mw_get_align:	See ntb_mw_get_align().
  * @mw_set_trans:	See ntb_mw_set_trans().
  * @mw_clear_trans:	See ntb_mw_clear_trans().
+ * @peer_mw_count:	See ntb_peer_mw_count().
+ * @peer_mw_get_addr:	See ntb_peer_mw_get_addr().
+ * @peer_mw_set_trans:	See ntb_peer_mw_set_trans().
+ * @peer_mw_clear_trans:See ntb_peer_mw_clear_trans().
  * @db_is_unsafe:	See ntb_db_is_unsafe().
  * @db_valid_mask:	See ntb_db_valid_mask().
  * @db_vector_count:	See ntb_db_vector_count().
@@ -227,13 +233,20 @@ struct ntb_dev_ops {
 			   enum ntb_speed max_speed, enum ntb_width max_width);
 	int (*link_disable)(struct ntb_dev *ntb);
 
-	int (*mw_count)(struct ntb_dev *ntb);
-	int (*mw_get_range)(struct ntb_dev *ntb, int idx,
-			    phys_addr_t *base, resource_size_t *size,
-			resource_size_t *align, resource_size_t *align_size);
-	int (*mw_set_trans)(struct ntb_dev *ntb, int idx,
+	int (*mw_count)(struct ntb_dev *ntb, int pidx);
+	int (*mw_get_align)(struct ntb_dev *ntb, int pidx, int widx,
+			    resource_size_t *addr_align,
+			    resource_size_t *size_align,
+			    resource_size_t *size_max);
+	int (*mw_set_trans)(struct ntb_dev *ntb, int pidx, int widx,
 			    dma_addr_t addr, resource_size_t size);
-	int (*mw_clear_trans)(struct ntb_dev *ntb, int idx);
+	int (*mw_clear_trans)(struct ntb_dev *ntb, int pidx, int widx);
+	int (*peer_mw_count)(struct ntb_dev *ntb);
+	int (*peer_mw_get_addr)(struct ntb_dev *ntb, int widx,
+				phys_addr_t *base, resource_size_t *size);
+	int (*peer_mw_set_trans)(struct ntb_dev *ntb, int pidx, int widx,
+				 u64 addr, resource_size_t size);
+	int (*peer_mw_clear_trans)(struct ntb_dev *ntb, int pidx, int widx);
 
 	int (*db_is_unsafe)(struct ntb_dev *ntb);
 	u64 (*db_valid_mask)(struct ntb_dev *ntb);
@@ -282,9 +295,13 @@ static inline int ntb_dev_ops_is_valid(const struct ntb_dev_ops *ops)
 		ops->link_enable			&&
 		ops->link_disable			&&
 		ops->mw_count				&&
-		ops->mw_get_range			&&
-		ops->mw_set_trans			&&
+		ops->mw_get_align			&&
+		(ops->mw_set_trans			||
+		 ops->peer_mw_set_trans)		&&
 		/* ops->mw_clear_trans			&& */
+		ops->peer_mw_count			&&
+		ops->peer_mw_get_addr			&&
+		/* ops->peer_mw_clear_trans		&& */
 
 		/* ops->db_is_unsafe			&& */
 		ops->db_valid_mask			&&
@@ -570,79 +587,180 @@ static inline int ntb_link_disable(struct ntb_dev *ntb)
 }
 
 /**
- * ntb_mw_count() - get the number of memory windows
+ * ntb_mw_count() - get the number of inbound memory windows, which could
+ *                  be created for a specified peer device
  * @ntb:	NTB device context.
+ * @pidx:	Port index of peer device.
  *
  * Hardware and topology may support a different number of memory windows.
+ * Moreover different peer devices can support different number of memory
+ * windows. Simply speaking this method returns the number of possible inbound
+ * memory windows to share with specified peer device.
  *
  * Return: the number of memory windows.
  */
-static inline int ntb_mw_count(struct ntb_dev *ntb)
+static inline int ntb_mw_count(struct ntb_dev *ntb, int pidx)
 {
-	return ntb->ops->mw_count(ntb);
+	return ntb->ops->mw_count(ntb, pidx);
 }
 
 /**
- * ntb_mw_get_range() - get the range of a memory window
+ * ntb_mw_get_align() - get the restriction parameters of inbound memory window
  * @ntb:	NTB device context.
- * @idx:	Memory window number.
- * @base:	OUT - the base address for mapping the memory window
- * @size:	OUT - the size for mapping the memory window
- * @align:	OUT - the base alignment for translating the memory window
- * @align_size:	OUT - the size alignment for translating the memory window
- *
- * Get the range of a memory window.  NULL may be given for any output
- * parameter if the value is not needed.  The base and size may be used for
- * mapping the memory window, to access the peer memory.  The alignment and
- * size may be used for translating the memory window, for the peer to access
- * memory on the local system.
- *
- * Return: Zero on success, otherwise an error number.
+ * @pidx:	Port index of peer device.
+ * @widx:	Memory window index.
+ * @addr_align:	OUT - the base alignment for translating the memory window
+ * @size_align:	OUT - the size alignment for translating the memory window
+ * @size_max:	OUT - the maximum size of the memory window
+ *
+ * Get the alignments of an inbound memory window with specified index.
+ * NULL may be given for any output parameter if the value is not needed.
+ * The alignment and size parameters may be used for allocation of proper
+ * shared memory.
+ *
+ * Return: Zero on success, otherwise a negative error number.
  */
-static inline int ntb_mw_get_range(struct ntb_dev *ntb, int idx,
-				   phys_addr_t *base, resource_size_t *size,
-		resource_size_t *align, resource_size_t *align_size)
+static inline int ntb_mw_get_align(struct ntb_dev *ntb, int pidx, int widx,
+				   resource_size_t *addr_align,
+				   resource_size_t *size_align,
+				   resource_size_t *size_max)
 {
-	return ntb->ops->mw_get_range(ntb, idx, base, size,
-			align, align_size);
+	return ntb->ops->mw_get_align(ntb, pidx, widx, addr_align, size_align,
+				      size_max);
 }
 
 /**
- * ntb_mw_set_trans() - set the translation of a memory window
+ * ntb_mw_set_trans() - set the translation of an inbound memory window
  * @ntb:	NTB device context.
- * @idx:	Memory window number.
- * @addr:	The dma address local memory to expose to the peer.
+ * @pidx:	Port index of peer device.
+ * @widx:	Memory window index.
+ * @addr:	The dma address of local memory to expose to the peer.
  * @size:	The size of the local memory to expose to the peer.
  *
  * Set the translation of a memory window.  The peer may access local memory
  * through the window starting at the address, up to the size.  The address
- * must be aligned to the alignment specified by ntb_mw_get_range().  The size
- * must be aligned to the size alignment specified by ntb_mw_get_range().
+ * and size must be aligned in complience with restrictions of
+ * ntb_mw_get_align(). The region size should not exceed the size_max parameter
+ * of that method.
+ *
+ * This method may not be implemented due to the hardware specific memory
+ * windows interface.
  *
  * Return: Zero on success, otherwise an error number.
  */
-static inline int ntb_mw_set_trans(struct ntb_dev *ntb, int idx,
+static inline int ntb_mw_set_trans(struct ntb_dev *ntb, int pidx, int widx,
 				   dma_addr_t addr, resource_size_t size)
 {
-	return ntb->ops->mw_set_trans(ntb, idx, addr, size);
+	if (!ntb->ops->mw_set_trans)
+		return -EINVAL;
+
+	return ntb->ops->mw_set_trans(ntb, pidx, widx, addr, size);
 }
 
 /**
- * ntb_mw_clear_trans() - clear the translation of a memory window
+ * ntb_mw_clear_trans() - clear the translation address of an inbound memory
+ *                        window
  * @ntb:	NTB device context.
- * @idx:	Memory window number.
+ * @pidx:	Port index of peer device.
+ * @widx:	Memory window index.
  *
- * Clear the translation of a memory window.  The peer may no longer access
- * local memory through the window.
+ * Clear the translation of an inbound memory window.  The peer may no longer
+ * access local memory through the window.
  *
  * Return: Zero on success, otherwise an error number.
  */
-static inline int ntb_mw_clear_trans(struct ntb_dev *ntb, int idx)
+static inline int ntb_mw_clear_trans(struct ntb_dev *ntb, int pidx, int widx)
 {
 	if (!ntb->ops->mw_clear_trans)
-		return ntb->ops->mw_set_trans(ntb, idx, 0, 0);
+		return ntb_mw_set_trans(ntb, pidx, widx, 0, 0);
+
+	return ntb->ops->mw_clear_trans(ntb, pidx, widx);
+}
+
+/**
+ * ntb_peer_mw_count() - get the number of outbound memory windows, which could
+ *                       be mapped to access a shared memory
+ * @ntb:	NTB device context.
+ *
+ * Hardware and topology may support a different number of memory windows.
+ * This method returns the number of outbound memory windows supported by
+ * local device.
+ *
+ * Return: the number of memory windows.
+ */
+static inline int ntb_peer_mw_count(struct ntb_dev *ntb)
+{
+	return ntb->ops->peer_mw_count(ntb);
+}
+
+/**
+ * ntb_peer_mw_get_addr() - get map address of an outbound memory window
+ * @ntb:	NTB device context.
+ * @widx:	Memory window index (within ntb_peer_mw_count() return value).
+ * @base:	OUT - the base address of mapping region.
+ * @size:	OUT - the size of mapping region.
+ *
+ * Get base and size of memory region to map.  NULL may be given for any output
+ * parameter if the value is not needed.  The base and size may be used for
+ * mapping the memory window, to access the peer memory.
+ *
+ * Return: Zero on success, otherwise a negative error number.
+ */
+static inline int ntb_peer_mw_get_addr(struct ntb_dev *ntb, int widx,
+				      phys_addr_t *base, resource_size_t *size)
+{
+	return ntb->ops->peer_mw_get_addr(ntb, widx, base, size);
+}
+
+/**
+ * ntb_peer_mw_set_trans() - set a translation address of a memory window
+ *                           retrieved from a peer device
+ * @ntb:	NTB device context.
+ * @pidx:	Port index of peer device the translation address received from.
+ * @widx:	Memory window index.
+ * @addr:	The dma address of the shared memory to access.
+ * @size:	The size of the shared memory to access.
+ *
+ * Set the translation of an outbound memory window.  The local device may
+ * access shared memory allocated by a peer device sent the address.
+ *
+ * This method may not be implemented due to the hardware specific memory
+ * windows interface, so a translation address can be only set on the side,
+ * where shared memory (inbound memory windows) is allocated.
+ *
+ * Return: Zero on success, otherwise an error number.
+ */
+static inline int ntb_peer_mw_set_trans(struct ntb_dev *ntb, int pidx, int widx,
+					u64 addr, resource_size_t size)
+{
+	if (!ntb->ops->peer_mw_set_trans)
+		return -EINVAL;
+
+	return ntb->ops->peer_mw_set_trans(ntb, pidx, widx, addr, size);
+}
+
+/**
+ * ntb_peer_mw_clear_trans() - clear the translation address of an outbound
+ *                             memory window
+ * @ntb:	NTB device context.
+ * @pidx:	Port index of peer device.
+ * @widx:	Memory window index.
+ *
+ * Clear the translation of a outbound memory window.  The local device may no
+ * longer access a shared memory through the window.
+ *
+ * This method may not be implemented due to the hardware specific memory
+ * windows interface.
+ *
+ * Return: Zero on success, otherwise an error number.
+ */
+static inline int ntb_peer_mw_clear_trans(struct ntb_dev *ntb, int pidx,
+					  int widx)
+{
+	if (!ntb->ops->peer_mw_clear_trans)
+		return ntb_peer_mw_set_trans(ntb, pidx, widx, 0, 0);
 
-	return ntb->ops->mw_clear_trans(ntb, idx);
+	return ntb->ops->peer_mw_clear_trans(ntb, pidx, widx);
 }
 
 /**
-- 
2.6.6

