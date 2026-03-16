Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205663CF052
	for <ntb@lists.linux.dev>; Mon, 16 Mar 2026 17:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773680528; cv=none; b=JQUNuZZ6YnmguVTLt+c1MUaEO5V097Xprj0Gm3Z5sg2ugbePLxvsN6HMKzo1qKffwRtCI3X/TiZbPu5CrpIn3CoIrFvD1N+84HLkacAIg3dENMvx5V4Rl1EB1yc2dwjD267+HaoIppf6MbV8+VZK80kvdUhFlU8evJVnu2mKt5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773680528; c=relaxed/simple;
	bh=JabMMdnsMTxWUIpUCHuaaYydbHEI4FzFLCz/JBCiC4M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tHVGySymxEjmn5eF3kND7xvHkSne/W7xozzys3V/GpiJPe37hJTvwTjh8RHzg17fpJaAozyOBuiS1Rm8tjOq9ojUygy1ispaDJgj8z8iKP4DTYy9i4k2BFJL3G/t3Kh24o/A+rZ+c6WYyswE25muROCPRfsgQLveqJqlthIE2DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gqa7KaHI; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gqa7KaHI"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5a12cd0bcd8so5545184e87.3
        for <ntb@lists.linux.dev>; Mon, 16 Mar 2026 10:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773680525; x=1774285325; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9FBv+DUbkZKn5UcTiH4mk1Kik16KscvfZ3cWgSXjFvg=;
        b=Gqa7KaHIY3ehA7+g3yYXnBiGtSy68xdfO6F/WrwxPlWhBnCmO86Ie5i++TFt1DNQp6
         sQHoAyC3GRIpzhgdgeUqsxTiEWMvwFGvdNlwGDIdyLfxOUFJsq0Dq5WhOJ+/qu4yJkmU
         709jESrNtb25PdYjw6JX4gepV1M8O5+cLCA/mXvQ6FMJqrrCj8O3dWTruluFLSsewwBx
         4xIUqB43jl+oUDCZP7jnn1qeTwyTkQgFARnUQ2ryyj6WYymnJFih8Da+9GiwrKQT8I0i
         LXFTht0hkyg1AyxappQCdklWcuZ9MHe8ZSmv21/bphTJ7jj7MjdO3OYIt5rLr2zDBa12
         IkgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773680525; x=1774285325;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9FBv+DUbkZKn5UcTiH4mk1Kik16KscvfZ3cWgSXjFvg=;
        b=sIv2rte/P8cY5g84cHRGrsNu/5yMplhQAwZhcJZm08rdPN1k1Qs5yOmQEqPhPfJz56
         ThRHyFnR4ryzF0o7tNOglUdlLWycZkagsxZQLeA/eHI5kF7WzrLAhvYuBWKk5EIlau5/
         JCkKcuXNIdK2TiN9MrYZcHergfhnS2529siEZoIwCe24iCsQ5bPqy+08Y0wtZSGlyz4I
         jciArYeDpQm/qpymyFp6yb4osFySedlePZh8uR1UQU0RtLCSyphnUNeQnDpTGkObznri
         aOYd+AFdr+m7aFRZXJnzx33LTf2InfFNpcS13kLVP/NtX7/3Ou2DD2mtL155LeSfK1gB
         ZC1g==
X-Forwarded-Encrypted: i=1; AJvYcCXhA55l2Wt96vg9tp+pNkKGqpfY4hvrpW0UwO1mgNWQ7SG34K+rSDFT9+tuFfFTnr1pWO8=@lists.linux.dev
X-Gm-Message-State: AOJu0YyMmhZRKG1eRXaSVMgmrVkz5gc0VxPtPshx8hLQ1u8ZZ7J0f9D/
	1D37fE26l33X/3HetiYMKMzNqwrUPa+TfzsuHpCz46oet+Da4RJ2KPWh
X-Gm-Gg: ATEYQzy8M1lSj75AE2v7Oa/nPnVM6S0EhFLik4clKjv7OnvDAJCTzjyjzVpVlhZpp/e
	LyV2/CCT2TYdAlJgOASogVPZb/hThAefgxZuwEGgVHHl6vTkVp9Ern/yCZtXUaJXRWYhbdJctN8
	BgJIm2lOO4Qi/IuKhKYAxVecztmO2USXhcna9MoDHUQEIxs2hUaVraIkrxuUOuLjkLBxQ2DUaEN
	o11JDNurZHkXnxktRCGeWBIORIuPYWIozMSSpjLKETeW970IqEWy0g+UsdMDweoNHn/RTWr8CDa
	eC+0KtpzSvXQ8f7Xn4RVToG3DRNfK3r0q/9LVjnns4C6aQaBJ1N1BUZDNeXq3wYilcPEEL7SsAe
	d8671wbUEuH0/BNMTsxR/VuuxHyCz4je3DSvWavqBBCRQObRvvc5D0M2yb6M9xL1BEPQwxDgXs+
	PHKhWCfllpquadM+/1lv5qZejQr+c95yZWBi/TdScCHNJk/Y2ZqzIl9MoqVC+wWJ41
X-Received: by 2002:a05:6512:3d08:b0:5a1:476f:bbcd with SMTP id 2adb3069b0e04-5a162b1febemr4357044e87.44.1773680524993;
        Mon, 16 Mar 2026 10:02:04 -0700 (PDT)
Received: from T6NXCV08J99224A.admin.jenseneducation.se ([185.154.228.175])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a16c8eb1bcsm1646911e87.41.2026.03.16.10.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 10:02:03 -0700 (PDT)
From: Oskar Ray-Frayssinet <rayfraytech@gmail.com>
To: jdmason@kudzu.us
Cc: dave.jiang@intel.com,
	allenbh@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	stephen@networkplumber.org,
	ntb@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Oskar Ray-Frayssinet <rayfraytech@gmail.com>
Subject: [PATCH v2] net: ntb_netdev: add SPDX tag and remove boilerplate license text
Date: Mon, 16 Mar 2026 18:01:41 +0100
Message-ID: <20260316170141.1792-1-rayfraytech@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add SPDX-License-Identifier tag to reflect the dual
GPL-2.0-only/BSD-3-Clause license and remove the redundant
boilerplate license text.

Signed-off-by: Oskar Ray-Frayssinet <rayfraytech@gmail.com>
Acked-by: Dave Jiang <dave.jiang@intel.com>
---
v2: Also remove redundant boilerplate license text as
    suggested by Stephen Hemminger
v1: Add SPDX-License-Identifier tag only

 drivers/net/ntb_netdev.c | 50 +---------------------------------------
 1 file changed, 1 insertion(+), 49 deletions(-)

diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
index fbeae05817e9..76806d1c5e69 100644
--- a/drivers/net/ntb_netdev.c
+++ b/drivers/net/ntb_netdev.c
@@ -1,52 +1,4 @@
-/*
- * This file is provided under a dual BSD/GPLv2 license.  When using or
- *   redistributing this file, you may do so under either license.
- *
- *   GPL LICENSE SUMMARY
- *
- *   Copyright(c) 2012 Intel Corporation. All rights reserved.
- *   Copyright (C) 2015 EMC Corporation. All Rights Reserved.
- *
- *   This program is free software; you can redistribute it and/or modify
- *   it under the terms of version 2 of the GNU General Public License as
- *   published by the Free Software Foundation.
- *
- *   BSD LICENSE
- *
- *   Copyright(c) 2012 Intel Corporation. All rights reserved.
- *   Copyright (C) 2015 EMC Corporation. All Rights Reserved.
- *
- *   Redistribution and use in source and binary forms, with or without
- *   modification, are permitted provided that the following conditions
- *   are met:
- *
- *     * Redistributions of source code must retain the above copyright
- *       notice, this list of conditions and the following disclaimer.
- *     * Redistributions in binary form must reproduce the above copy
- *       notice, this list of conditions and the following disclaimer in
- *       the documentation and/or other materials provided with the
- *       distribution.
- *     * Neither the name of Intel Corporation nor the names of its
- *       contributors may be used to endorse or promote products derived
- *       from this software without specific prior written permission.
- *
- *   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
- *   "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
- *   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
- *   A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
- *   OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
- *   SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
- *   LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
- *   DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
- *   THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- *   (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
- *   OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- * PCIe NTB Network Linux driver
- *
- * Contact Information:
- * Jon Mason <jon.mason@intel.com>
- */
+// SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause
 #include <linux/etherdevice.h>
 #include <linux/ethtool.h>
 #include <linux/module.h>
-- 
2.43.0

