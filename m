Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456D425DB12
	for <ntb@lists.linux.dev>; Sun, 15 Mar 2026 20:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773606847; cv=none; b=IPvEwJAJIir0KJLWf5iwgdMREExAMbGCaGJbg6RJMzIizkJ7febwYrBRQ5QYUDFMWb7G0gDG6M4jfd2WKi0YGTK39kMsoap2Dpqxj/QEGh3b77NAEZYQi9B2j+jRuarmWyH/K4yINX3VhB8uM2XY+5zUjlZC3PRWxhPIjCD98gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773606847; c=relaxed/simple;
	bh=x4XBVU9NFJfJ98e7T4O3wN4hyNxkuoou/kNYOhtbu9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qACaXeENVy1CFP5IMU9Ttajj4UknhnTYZNZwf4u6g6wiLWkDXIruNyk6H8K9MsJYhNvPM7AWZjf9ZkQSnpKb0BPkI9xtC6Ln0lpusATkinv8Bz9uPKAukaPVB9ImNX/9ylswo23S/X7+W+NFw2mPbA1v5/5g/igW11WGZ89wegs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bi8HMNZP; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bi8HMNZP"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-59dea72099eso3914539e87.0
        for <ntb@lists.linux.dev>; Sun, 15 Mar 2026 13:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773606844; x=1774211644; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fas1ofkBzdL1TrT2Z69laHicj7pCtwPGHSuUlDLcpxc=;
        b=Bi8HMNZPZneRhvdi82uMnXXsYGKslq3P2tOiXWA6kY5KBeLdCP7pnKa1cd+e1h2lNo
         6qjDRWemj41GvcA8VX5Ttc3FXwmFb3QOyTgOv5Zp9ITdKBYWWkeIoh27nr35h+ao8eeN
         mEMSDfRxSIUa1TfLSi6EkOTsB82+HvpORM8iyhE5oz81s5MzYiDtFrCVj3fc9+MHlofx
         rmYyacALLsghiE/EtxYcuYY2nrDaAeTzCBjpbAnsWLLF8GUn3afFbgMfdAGBGAK+OGhQ
         fdg8myjGiwxCHJs/ewYgQu4Wtpwg+c/hC4FXhE373Nz81YX7GFvZnMBgQ0DZ5+QnUU45
         5EeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773606844; x=1774211644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fas1ofkBzdL1TrT2Z69laHicj7pCtwPGHSuUlDLcpxc=;
        b=mQvoUz4B+GR13QrRbEecbxviS7AS9rFaitsuf8JtNYnqXdzESj52NlKbBzzl9xaKfN
         Htrq/3TFIu/+STjB0RhL105drM798a959lHZyht2Z+JKqGjlcT+txjFUmnTdQMTft+Av
         pp8HdsyJsWW3nym/IZQO9QdmqxITWoqrXtm4883NghwKPr/ADOAmbbLPNzuQC36vzWP4
         RkYEPfybCREUlJNXLmTo5rJp8cjBxivk4tu+nuY3axnkx9r45DYRa7JFFQERIMzeo0xb
         Ij5qaoEj+2ce5sKB4EfkD1FsadeZGIDbMtRZqQNWFw+8TEtvLeirwVwYIktdhKegVBF2
         /ZMA==
X-Forwarded-Encrypted: i=1; AJvYcCVSI8+1L6zx0P+1gzDmBi1DCAEYQmC8ggbRiUg/o0tEgrsX18ocAGsQgTd156GXEVGfW7Q=@lists.linux.dev
X-Gm-Message-State: AOJu0YxDd6Mv/6GOJFAXMhJFp5QVWq5fdFNvCzZ02C6mrY94jesmepK0
	e4WGcD6183LfyebuYUS8Ckt1pYnpDAgzMhwi/QB0KUJ8CtZn9/KZKlZA
X-Gm-Gg: ATEYQzzlzBbTOslTrLHjDxk3wTxkHh4npOcbIV5NX5MJemk9AM9qv32DvvmMFqDPKvK
	qas/bY+P6KegQyW3lIQVMbgCqIRIq9fqwWFhs851xi/bco1V9d1vjg/MRYq0mzNfpF6KXuSGScw
	yktUd3NW990AGb66YPf/Ghua4qxQe24Vr5uXYUElnINxPElEQ5QtmTQ/Bjo3XHRTkBAADK4yNfx
	pSB3A3lgs0sK3bHCSPxAMypXAYPDmc+yjnN3WLl7ivp4BgCpxRe9KtAeLT3wyrxY03EkwLIGiEp
	5eHCaVboDzl94ayMc/YW90XJ2Nx4oSU81bOmRpinT43m0UgBqz8DZvA86sxsLfae1517Ex72Up4
	HIudpX7+omv0sL5amnXZkdoXBxtP7CkcaP0zHSfXM0060ZXf9bEPfWGEG6G9R3U7i/I+B/eRK5w
	3uu41iDINdkdVDyuuIS2ncnWRsOi8cO1KrU8PVuI7Tzgwy3EgbwPtZIotAp1urJi0CnFO/DdGIU
	A==
X-Received: by 2002:a05:6512:154b:10b0:5a1:2f9e:ec8f with SMTP id 2adb3069b0e04-5a1627039ecmr2505232e87.10.1773606843664;
        Sun, 15 Mar 2026 13:34:03 -0700 (PDT)
Received: from T6NXCV08J99224A.lan (81-237-238-191-no600.tbcn.telia.com. [81.237.238.191])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a15602e18fsm2916297e87.22.2026.03.15.13.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 13:34:03 -0700 (PDT)
From: Oskar Ray-Frayssinet <rayfraytech@gmail.com>
To: jdmason@kudzu.us
Cc: dave.jiang@intel.com,
	allenbh@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	ntb@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Oskar Ray-Frayssinet <rayfraytech@gmail.com>
Subject: [PATCH] net: ntb_netdev: add SPDX-License-Identifier tag
Date: Sun, 15 Mar 2026 21:33:45 +0100
Message-ID: <20260315203345.13657-1-rayfraytech@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing SPDX-License-Identifier tag to reflect the dual
GPL-2.0-only/BSD-3-Clause license of this file.

Signed-off-by: Oskar Ray-Frayssinet <rayfraytech@gmail.com>
---
 drivers/net/ntb_netdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
index fbeae05817e9..3890074b26c9 100644
--- a/drivers/net/ntb_netdev.c
+++ b/drivers/net/ntb_netdev.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause
 /*
  * This file is provided under a dual BSD/GPLv2 license.  When using or
  *   redistributing this file, you may do so under either license.
-- 
2.43.0

