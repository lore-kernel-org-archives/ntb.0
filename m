Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B8733A03A
	for <ntb@lists.linux.dev>; Mon, 16 Mar 2026 19:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773689049; cv=none; b=dnYtM+/o2kbYz5UlnPR75ITD9jHwEfuwmlpnNBek7qDjn8gVQu3FrS4AZpMmdQcIygozPYF1j7PXFARWfzIDsuMs7ICPP3xPNNZEyIgp4frreXzq6Y+IniqItWh9DuHZOvXMs0csZLNJc8Z7tJEvMiofZIhD2PjA/Bio7t4FaVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773689049; c=relaxed/simple;
	bh=mok+0GN/V4P5qG+TDfFZAcX6xlih6/hGqugS54vAftM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TquhanGFtdAYxXH9xnWAbKypNUzwUnBbPYC9MKXVzm8TxvFThyCfPnHb9rVPRpMmJDZFEj85KCR5ZPLd4VS360rlEJJN5yephpch1AtAluoWyD4Wg9HzCY9uPu0NtqQk0WAC5iPYD1ARXb5zDorClVj4RRwCrsOtyoH3EZ0RDeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQEcd4yI; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQEcd4yI"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a131870b72so5104331e87.1
        for <ntb@lists.linux.dev>; Mon, 16 Mar 2026 12:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773689046; x=1774293846; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OeUzdNtqUzZ05FUtZtH1B/y/MvIg739iNl7JRLf75nM=;
        b=QQEcd4yIE9P01b1H0EUakzGy0n+ZI/i1eMznOrsmKbhpSbVnX/DdOodFL2sWgxvCro
         CLZCI7al5yxPzO8TI/BrDVmfH5o5Eezu3Ecit0H2Jynhelp9qYcCR94N5qLbutBOwbJW
         RU4Ptgf6N5FSKhuaEYKXov3Tid0AsQfxIa6KyL4xFh0YRP7ru9Fmf0ewwseXjySs0RhD
         bSwnxQrgojkia4f9FMm+DFskptgZaWCRh1RgXRLM5b02hov0xCeMyEgh/kpFmE22IHXu
         lP2tjRLeXc16OxJ8P4M6o8SMTIVV5BUQwl5cGlsrEZ8EnrEQgCm56Ri8IYY5QxrJSEee
         vmbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773689046; x=1774293846;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OeUzdNtqUzZ05FUtZtH1B/y/MvIg739iNl7JRLf75nM=;
        b=LYZrbAfpNY/4KQUSwlmX43C0n8rJtj+7yN0Hoy+jQSKVudtSUtJYGjbFKmrm6N8vkV
         rF3KfMeq4f2sl8bAHSWuBzVGTh/QJ7T3GOnJX+yqb95ZwjATaITo6Is5lGtfYLCHdA43
         C3I6Rl6MXSV3PorRwob3MH4D0/0lT1VtPd0+t82uXAiq4Jm/b/GtuXj4HTkjp5QB5BsU
         J+mR4nlnz3RLOCx6C8D9JOMoal7GzZ83iVCTvssf6D7C6kJw5cACw6bq9N77jTqgM8+V
         x2L5mv2jZSbjdpf7CBxgHktZ088ElQspENxY6dR996Ci+t5VzR9Unhhk/8xMZtfgiRSK
         0EjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqPiescYW8g/TLv2P3SPDIOebGPfWODox+JZm1GBFYkoR5e/wkyigaE+Yug6NttmYVXd8=@lists.linux.dev
X-Gm-Message-State: AOJu0YzsE/qYbzup59OmExm/RAnYdLnC2L3V6ALhoWTqPfnHabDn5SDl
	AT1uiyvXIT6xD0ptOs0Gm52mYuZM2wRrr3g2sVhONYf8eJI8lRrLWeFw
X-Gm-Gg: ATEYQzyUArrmDanxQpwU/38avLnS0HUlAczM3te3QE3WmfEhK8VPE14sOlpixjsen8K
	uoZFLUwLPnlfIvjbaG3FmQTO3dZogf8rY9n6+BRJ7iL4cnHhFKAz/pdHaSOpf903DIW0DFMrjIR
	fQhGQTGz6AEymigDQhpsF/KxhSUA2oQxfd0JP8uSuEgNPDk1xd4S78lK+RZOAOTBAYcf+2cSDIB
	AMkKz6LjPBvbC1pwz8DlyichXMJXSDwLgj9rlfHsfk72nSgIXEcRD4oh14aKJIA/W0PfEjSkXsD
	8xOXgzVeIIDJedWoNjVcwHUgsAgWWz+NZyy8K0Xf2HE3E+kIZ2/0A47cIzg65GCprClTtTg+4HV
	pEOWC/DwwttmpcIUEchhPeBK31PuYmuWHcBmbeKk7UWhVUkerU6bschzPZLrKFA7awwqjRGBYxD
	A0a5RN+MVyyNBIoRx3+PZtPEyi4pwjWpL3EOd4skNU6jnx1XB3O8y9jJovPugGpl9k//+BezSgg
	Q==
X-Received: by 2002:ac2:43c8:0:b0:5a1:2ccd:ad56 with SMTP id 2adb3069b0e04-5a162aee2b1mr3140079e87.9.1773689045753;
        Mon, 16 Mar 2026 12:24:05 -0700 (PDT)
Received: from T6NXCV08J99224A.lan (81-237-238-191-no600.tbcn.telia.com. [81.237.238.191])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a16c8eb1bcsm1708226e87.41.2026.03.16.12.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 12:24:04 -0700 (PDT)
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
Subject: [PATCH v3] net: ntb_netdev: add SPDX tag and remove boilerplate license text
Date: Mon, 16 Mar 2026 20:22:48 +0100
Message-ID: <20260316192248.518-1-rayfraytech@gmail.com>
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
boilerplate license text, and keep the driver description
and contact information.

Signed-off-by: Oskar Ray-Frayssinet <rayfraytech@gmail.com>
Acked-by: Dave Jiang <dave.jiang@intel.com>
---
v3: Keep driver description and contact information as
    suggested by Dave Jiang
v2: Also remove redundant boilerplate license text as
    suggested by Stephen Hemminger
v1: Add SPDX-License-Identifier tag only

 drivers/net/ntb_netdev.c | 44 +---------------------------------------
 1 file changed, 1 insertion(+), 43 deletions(-)

diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
index fbeae05817e9..48482b18c73e 100644
--- a/drivers/net/ntb_netdev.c
+++ b/drivers/net/ntb_netdev.c
@@ -1,47 +1,5 @@
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
  *
  * Contact Information:
-- 
2.43.0

