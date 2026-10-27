Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793116198;
	b=HxmhKvVCy6peenWLpDBze1+NhAM20XaQU3wBZPq6xa3ww1zt2coPC9NDEg4pQMwgSjmT
	 0mPOsf4tdbVS1rjA2UTf6kLDSugURvKEZIgtmANeUe8DsFhpRXPXi4OA6D1JoF9CUsLYk
	 3FyinzsE6UBoRzMRO2cHIRAi8DYKxnUs3Og0HlIiTM+vOcrA3S+JaycwyL3CgKLQbBDi2
	 LOAvNWp2/KkScgVUZPtLAMKjIe4Z711mEOnP8+teEgEbFSfDueHeOPS9YqmHIPwgr4ByX
	 AGzAo8DPPX61LIJYMzrnGkrtqGdhN34bXTUmSVcKhgv9TIkWUqECRtwDhpeyZHF5TAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793116198;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vMJhlpSMWK3+HIJ++d06DQtbz1b9MhuB921he62vO+U=;
	b=chsZeEvbC8y8w3ZwKcoiDKPE9VBS5cgogO3pl7pW+UMCvsy+cunN7fLt/6tpQ8vBnTs+
	 QduGegAYC2Wd0v/AUsSnI12DJikL0heBiaczoI+32YCHHfGEHygbZIl/svf5JuIZjnjSp
	 GJxfgqHbX96yz9ZLRnN02OrjLswtaW5u/hOB9+kUE/qT3QVa26hHavBS4AZTqYt/JrzNt
	 tBYV5fRgtZkgrxoE1wActuia7IvjpCBW5QeOVvn9Rrg3ihDVPmmRdRXpmCRNvaEvI+LVx
	 HgbAp+n5O30bX531DokaYMfZW4fIpyMWLUxDBfRK9sJCpcivCoPieXTwaOn5CkEuElw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nJY+5oen;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAEC606AB5C
	for <ntb@lists.linux.dev>; Tue, 27 Oct 2026 15:49:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCAEC606AB5C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nJY+5oen
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48c45111bebso1981865f8f.0
        for <ntb@lists.linux.dev>; Tue, 27 Oct 2026 08:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793116196; x=1793720996; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vMJhlpSMWK3+HIJ++d06DQtbz1b9MhuB921he62vO+U=;
        b=nJY+5oent9k622Bpui2rl6aV01KsnYpqqyaVSh3Ejy/FSOXnrEYqOQcy7PM9z1gAyu
         evgyLK+NyrdjuAG3pK/F8IwwXYxZVFgpXFf5AW1ocuFx8akENl7WyP9KJjUpo5kiKAJm
         TITYpOTToeuIXYYJvR9aXfJz1TwOmprm1khKgyPQyh4BI4jig81YtXBkzVEnrFqcCsiu
         ST37w8k7Awx4aHPrU0acOy0WFvbzJ/HWkiQwpjD+AiPWDWFxnKL0ncEaXk03Y9S0ac8+
         /f3FM5tcLt2zvcazbJz7eqI7xtRdzA7HQYnGAlRr8JEMs3Ppwib8rne7oMctO/dCfkck
         GI5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793116196; x=1793720996;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vMJhlpSMWK3+HIJ++d06DQtbz1b9MhuB921he62vO+U=;
        b=kqOO1/ejC7eOUuGI2upfKPRsYSN/+7tZR2G50KhY3o4Z7viMU33Nvq/M4mghnD7P4T
         9YWhrn5iHixE8Xr4k/+QOh4gAX+xjRGCbKRpE8Ui3XsTrG2fdT9j9UcfepDjmf4w6Q8v
         sc9m0XceOIGp10Vy/aOjulipyklkEz79jPhKi3fEWRigKZyB7cFor26hEn0HV2z7ql/7
         y9Je2BIPAcMKvcrSWGOoyxMqLCEj6ByI1SGU6tiXE9SIOA9UB7PUUdzkVhT49z8LsLF5
         TSfgb0tClxH3+XJ3mHsYXQtVHnWtXzb3gG4DXf1hiI18MGXyBNfZZOkmOZuTzzSlpjlb
         8z3w==
X-Forwarded-Encrypted: i=1; AKwUvBxI1mAEFe7rQJUN7vSWlTxzdc3Kq97YrmYVoaBPAjFzqLDu0FAQAhvirKso7kmjqI1C2uI=@lists.linux.dev
X-Gm-Message-State: AFq9FYI22yvKK4NzWj8+I2EvTndCgSrtaRUASSCeIIQlcsu351kI5M5b
	yp6x+Da7XrB9C9E4aufv4AWz4OweAT9sOYN5ZYty60um+JVR6q9+t5/M
X-Gm-Gg: AYBFou3JlPy7nUJUl0Kwf+MtYGhF/kdRGd9xboX0zqzF2UVCBTIcIrhy8rZGjDYyE5Z
	Jl3AcC8eOCOze3hBGnCXmxFhAc0zCe4Jw9EuYp5N1/DSV6c5YKUnHY33Shslomes4ngufcIGp3F
	FNhGXSaEUEegG56orB2G4dTQjepeS/pcUdx1aKl1Uxc/Hie80nSUsNZGyirAxSGawsYJ2HqyT6R
	ntLi7VI4D0vCBlucKva+PXgW/jDCCIgZgBVRMOk6u60Tvp7TiVHiH4V+wAdcYkjCafNrw65KsFZ
	qUBs5bU6avqd61Rvrnp9NZxqdTY8C7PIjltXSHvYuQ+iZ2B9wC1g2CxZ7FkAj46AXKleJZhJ601
	pD2ZhgI11I9Q72qoEaQhnr/dM0az1GAEuHimPpd4jcnhr92FwhrD6hRVRap030u8xRtOnksu24k
	6at8qq5X8uuVD3w41Ki2vSt65VX3anSxZOA4+BJyV3Lv5fA55/5VCVpiqggetpHgTgbno61lvvB
	/aQm2GrkU+iwBr+oa5oUIIwM7sX9lmkU8Le9B18N+XOOa6tAwfayFPvd7qkgq+cn53LVQtj
X-Received: by 2002:a05:600c:3e8c:b0:4a2:392:9de2 with SMTP id 5b1f17b1804b1-4a35acab6cdmr176493125e9.28.1793116196133;
        Tue, 27 Oct 2026 08:49:56 -0700 (PDT)
Received: from localhost.localdomain ([2a06:c701:4778:c500:5434:54a3:4661:4f45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a5822a7sm286673925e9.11.2026.10.27.08.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 08:49:55 -0700 (PDT)
From: Avi Weiss <thnkslprpt@gmail.com>
To: Jon Mason <jdmason@kudzu.us>
Cc: Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Koichiro Den <den@valinux.co.jp>,
	Frank Li <Frank.Li@nxp.com>,
	ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Avi Weiss <thnkslprpt@gmail.com>
Subject: [PATCH] NTB: epf: propagate memory window command errors
Date: Tue, 27 Oct 2026 17:49:53 +0200
Message-ID: <20261027154952.250683-2-thnkslprpt@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Post: <mailto:ntb@lists.linux.dev>
List-Help: <mailto:ntb+help@lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
List-Owner: <mailto:ntb+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ntb_epf_mw_set_trans() and ntb_epf_mw_clear_trans() discard the result
of ntb_epf_send_command() and return success even when the endpoint
reports a command failure or fails to respond. This prevents NTB
clients from detecting a failed memory window operation.

Return the command status from both callbacks. Preserve the existing
teardown error diagnostic.

Fixes: 812ce2f8d14e ("NTB: Add support for EPF PCI Non-Transparent Bridge")
Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
---
 drivers/ntb/hw/epf/ntb_hw_epf.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
index c47607d4f8a7f..dd10c30bdbec4 100644
--- a/drivers/ntb/hw/epf/ntb_hw_epf.c
+++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
@@ -498,18 +498,16 @@ static int ntb_epf_mw_set_trans(struct ntb_dev *ntb, int pidx, int idx,
 	writel(upper_32_bits(addr), ndev->ctrl_reg + NTB_EPF_UPPER_ADDR);
 	writel(lower_32_bits(size), ndev->ctrl_reg + NTB_EPF_LOWER_SIZE);
 	writel(upper_32_bits(size), ndev->ctrl_reg + NTB_EPF_UPPER_SIZE);
-	ntb_epf_send_command(ndev, CMD_CONFIGURE_MW, idx);
-
-	return 0;
+	return ntb_epf_send_command(ndev, CMD_CONFIGURE_MW, idx);
 }
 
 static int ntb_epf_mw_clear_trans(struct ntb_dev *ntb, int pidx, int idx)
 {
 	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
 	struct device *dev = ndev->dev;
-	int ret = 0;
+	int ret;
 
-	ntb_epf_send_command(ndev, CMD_TEARDOWN_MW, idx);
+	ret = ntb_epf_send_command(ndev, CMD_TEARDOWN_MW, idx);
 	if (ret)
 		dev_err(dev, "Failed to teardown memory window\n");
 

base-commit: d135ab453a7400a34930bdda1ef4bdc8acfac80e
-- 
2.43.0

