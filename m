Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C9A36C0C1
	for <ntb@lists.linux.dev>; Wed, 18 Mar 2026 21:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773868322; cv=none; b=kWvpkYoV39U0rTActW/VxLfHSqRrAxgRioi4Co6B2nV7eJjOTiM5LrcRnh9D6rqJQiGakpimr+8R+Uw/FtRwEPWuPPzQrOln7cC7NnUs73+KxuZ3wAQAQbU2IMhmvz/jOMYobw1KcuDeVyZL1hUS8mxUoO26DMB2VEfwkJFV5aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773868322; c=relaxed/simple;
	bh=Bc7FuaVfriVTlmWmJKPbflUCbTjIXZMDzHnpCnNX0fc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MGgfjf7bPeTsaLjlROlRQn0c+0Aqt5pSYeIXu5DwGb+f1grk0YM5PdBilVo2gLbuNed/GQYPa+W3jNNllfn5aJ5HCgBZ5jFdLgJKXl/jwLR60bEDk1AVO2wCwHMElChPIIg+YiJv6c56loKa48vuDNdGemPGsQ7M9YsU6qfC10M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bEkD/PFm; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bEkD/PFm"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a13f6bcbf4so374831e87.1
        for <ntb@lists.linux.dev>; Wed, 18 Mar 2026 14:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773868320; x=1774473120; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7uDPEFKy6/pc9tqIEzURrCbQW2EOE5IGjEosk7mUc9U=;
        b=bEkD/PFm1SRAIIKF6q2NeQL/QZSpWN8ZZEyfXi+l+TKDKHzBMdjbXco1ZvJ5XJCANs
         C8PvJqlAEH5Ofj0H4OEtESl3UFNuX2g3K+hLY6S02y8JUp2lbZBHvcFrqZEq9hlteISm
         I/x1qWJerCB/Jwk2aO26ndqwlMuCLI+Y8knYX+hlNJspw03g9Zsv8NHF1vW3FwktyGvM
         KcwlRqdV/JNqmxW9nmn9RY1l3plmj/V9JVsAR0Fc3R5fqy5VGZZLKsQR+5Q5bDE1h+ZH
         oPJuneXlKD98qYoU4+rLKnHQyc6rcAzsDmWTsiUdIloW7FBGTHonTo9FYumZy7j/u0Bm
         LsFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773868320; x=1774473120;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7uDPEFKy6/pc9tqIEzURrCbQW2EOE5IGjEosk7mUc9U=;
        b=SMZonRxdly2M9HrTWPdIZAkgleYc52tSdB3PgYkgKl36ksCmROTx3208xGzyhXyrip
         3kb1YOfS82hD3yHx6hzQ4xbcOdkr2kJw0/6NVaMbnlDq8kwAejbWP9a7r7/gRHbJJbCM
         XVHC6mLXU+93S6VCRXCBWi/bqs6M2HZBZMSRgL181ZOARm4WzfjtSy/tSeX04IqsW1Ot
         w7bQ8Q3Z6dqBTZLWEpSe8oGD/E17V33teOS3rYkD9U6MSF9/x08VRQL3SNif0nhPFhoI
         QdhEhAedBryHN6855uF+/TQE8kpfyPolMsVzLC7Wic3xUfhTAgsiyZMPUcLrgbwaftXp
         8JTg==
X-Forwarded-Encrypted: i=1; AJvYcCW2WxWo5kaGzG5fPxMFh5btD77kSLy5oWlMhfICbZLHYKZZYsF05VAi3ZlkcHuaEHw1Ipo=@lists.linux.dev
X-Gm-Message-State: AOJu0Yyj4IWOCN3+Kk2X1DMFnng+BkjAPUlGSgIm+Nv7lHK46DgYFifl
	/Dcu6GZnPkMzE+cD65Pp9ibQnevD0EfK9ymBPKhXGk7W3Gb293q9eLxR
X-Gm-Gg: ATEYQzxCVOmbE42TishdFaY9xkBQdWsYyjKpeFb2BBHF81eTXM8DapR1a+WZRJJzZYh
	qtAKIBegITNDGq2WBKIJLkf56k0/7KZ141RmhN/SAJ/dTrmwa7YJ2EKVDz97mkPpQOLH4bp8Bi6
	VL5LhPwWSCuiLn3ofq544F2fIZcfXG8TJPTu/ylSq64Wkk7WsDBup7r8NqsVprfvTYvwCLtQI8n
	qZQJZZFT+X5k1S8MYq6ms9s2aPTIh7TsDQ+P1PXc51OPIIdm44RmaHiZ5byuJ/A3FnIUlPqXSfL
	gsJ432cmJ1nbQ8FOGWubdFnZDMhjjCElHUdmoNCpzqUC7JiAXA5GxgRh7AjDwiLkNS6pZQ1P6Oc
	FAfmggcq7EE1dl+IOvJUfmtNnU+DlaLNM5c5IQ1rkrK/4UbrBDIXWLPfe7yWHI1fbN/7ZgjG9KI
	gZGIz7GYWQQmJsN7FxyVQ+1jIKeST9QbG9X75AEFtxjP8lFxM16jTRKGDSDMiPWnLl+8ELCIBAb
	g==
X-Received: by 2002:a05:6512:20c9:b0:5a1:381b:fae1 with SMTP id 2adb3069b0e04-5a279588187mr1510495e87.10.1773868319381;
        Wed, 18 Mar 2026 14:11:59 -0700 (PDT)
Received: from T6NXCV08J99224A.lan (81-237-238-191-no600.tbcn.telia.com. [81.237.238.191])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a279c7b7a8sm798082e87.80.2026.03.18.14.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 14:11:57 -0700 (PDT)
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
Subject: [PATCH net v4] net: ntb_netdev: add SPDX tag and remove boilerplate license text
Date: Wed, 18 Mar 2026 22:11:53 +0100
Message-ID: <20260318211153.9460-1-rayfraytech@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add SPDX-License-Identifier tag to reflect the dual
GPL-2.0-only/BSD-3-Clause license, remove the redundant
boilerplate license text and contact information, keeping
only the driver description.

Signed-off-by: Oskar Ray-Frayssinet <rayfraytech@gmail.com>
Acked-by: Dave Jiang <dave.jiang@intel.com>
---
v4: Remove contact information as suggested by Dave Jiang,
    keeping only the driver description
v3: Keep driver description and contact information as
    suggested by Dave Jiang
v2: Also remove redundant boilerplate license text as
    suggested by Stephen Hemminger
v1: Add SPDX-License-Identifier tag only

 drivers/net/ntb_netdev.c | 47 +---------------------------------------
 1 file changed, 1 insertion(+), 46 deletions(-)

diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
index fbeae05817e9..cf04aa5d2824 100644
--- a/drivers/net/ntb_netdev.c
+++ b/drivers/net/ntb_netdev.c
@@ -1,51 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause
 /*
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
  * PCIe NTB Network Linux driver
- *
- * Contact Information:
- * Jon Mason <jon.mason@intel.com>
  */
 #include <linux/etherdevice.h>
 #include <linux/ethtool.h>
-- 
2.43.0

