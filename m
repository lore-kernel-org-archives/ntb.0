Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793541433;
	b=o1RaAIqc41XunI55SNN0J+MUPDGi4bsyIkx0DsN9Hh9CiD48T0ZPdbfKMr83kUmSSKXe
	 KSCDddcDmENyc/1764mhQpM/0xapO4MweoTyIiignGZS31BCKDm18eYdbnl27PofqTv0w
	 QnjN75j27gAkzGS/0PoUFWEUuRduVFNW1DJVI854AF/8MEOVZ8Scyjf8Cx98ikLhvE5P0
	 W9ff5HjFAhZBTkzYhgwSnSwl4u/pxUtq9A+Pz370Se/BGHBwBIKYjw4QZwnxLsYudgJ3s
	 KoXbBJLJNuIfvBQ9vOr96l6W5xgAnEdvyR2M6e9U0cYvQvOfejH2kgRTX9I1XDhBGdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793541433;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=jl1CsF9NMZircnSwAYemIaX1sWHDdB1YRVfnBFy5nVA=;
	b=H31XTMxHmU2IAjhKYGKdzGH+6Jj5FOZKWhhcie+7s0cUp3r/kIpObhOXnbBmS/MEZ3aX
	 kUjjltv7NSxYwG2VN7KT8VzdkjJLce2rSZammfXZOcyPjXgSpNrAVgKGM883jSB+gpyMp
	 8UbND7GAOLspdxDZjox5fv8220l7C1HvhYW2QVxn9tDV3hEugmij/3X/vAPwUWraYMhvT
	 w9IO15jDKhAwhyGCufofWs/prLf/cGyNm1PZ/hESnTfc9oCbfZFP+FMxf2/jTrJYlWtEH
	 3DBtfKwpotaAqmqEjhB6x9UMp4qAbZJD+LfJfVxk0q52mMfsAvMzKPPJiiUHdQVTwtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="QEogH/vT";
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6EC606A326
	for <ntb@lists.linux.dev>; Sun,  1 Nov 2026 13:57:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE6EC606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QEogH/vT
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48c45111bebso879090f8f.0
        for <ntb@lists.linux.dev>; Sun, 01 Nov 2026 05:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793541431; x=1794146231; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jl1CsF9NMZircnSwAYemIaX1sWHDdB1YRVfnBFy5nVA=;
        b=QEogH/vTTdtGUxrknGqQ6uaJciQ5SI6eYI1ATup6OgvIh0QEHM6mAnyZ0MnZNVUHT5
         tGHovlFceFKckgcUganDjfiObG7dhqqY1HwPPUifiHdrCIPefFyHWdOThZ9YWRb/0fl0
         H0Vr67ptHHfAdtHHoMY0fChazEolgS+4z9AVnxjlXZm5y1l3pXdy4MXUMfnJeMjtbRdJ
         RDGA1/EdbC/ipuGJWPXZxO86Myq3KcbHzVaqVEoXCsB6fzXbZGHioVber6vAvoW19Rdm
         jJ0vJTnqLh4/OZeJ/eTEWSXzZwzMgLKNxkD8qFpagY3Qz89iVeuojGY2Kpok4AA46gbX
         smJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793541431; x=1794146231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jl1CsF9NMZircnSwAYemIaX1sWHDdB1YRVfnBFy5nVA=;
        b=zHhOqUOFB20nNYGQXr4p9t66wYjAhtz5C03Omld43CFhkSbvqm+9nYs2Drv+nt4l9v
         2ugOlpa8RWIzVPhKByBkyh6zRHR4Xv3RBNoSZS61BFNs5j45tL3HW5pOd0UDXCG6SePR
         QfQTFybdeJfPS3YrrXc+EVWmjV82BGu7PwHUpugaP9h0CteRq9mXiKcA1HYv2PlB0rji
         wY0fkqX1sQA8Jn9vhx0B6ajRRWiY2w0He8fif80yuz18FT0oU+ETW1rlw6wgTEmuT0Wh
         2JRj3epRZsFCZhOJiGpBQSSVHuppBb40UdtjC4ujDkI4bf2Nm8UZNwN6jI9R9dOOaW3O
         M8MQ==
X-Forwarded-Encrypted: i=1; AKwUvByT0lIihgMd60iXxsDrdtizA7GYrx3TCSlJkCzkD5TdtoxjJbJAdnzgoHj8KuLNqtgVvi4=@lists.linux.dev
X-Gm-Message-State: APuU4Z/5nKoizOXRtJw+d3eNDkrQu3Snj8l5XzBHsPF5XQDYvAU3cP2r
	fG3aa/Q41c3vMDphjB94TLPGO78Sdi3aPfBYhyw01xBbaUQWjh8k/65h
X-Gm-Gg: AYBFou2yet+EsrKbuV3MhL1XjCr9/UU+X2IspTquauyk5FMvk9r57ewYBCTw0rK9sjM
	Z8s6cqpgeWuI1y/E+5RxYiyyMLpp4WnoQqCBbpdjGBUU55Ti4efwFFsddZRmODWbjUV2PH079IU
	Qzem/5I/KnWVMJTu+q+lvgmQYVswcF/CguSCj/33WNin+gHq559Wl127dmenn79tQ3RL5lPHhhC
	yeJ/8RPmHjjiswR7pAA4FlBOjHQhr8PBxPTFOhs2eDFkHNAQF6TZ27pK1pq6OwQNwrlpznEPZHA
	XhdVeusPKgXjZScuh5SFLaFBtBQyk3pnbKKpxVKcH3nnDlY7C2TNM6IJ3w1MkWuDZ0hAj/8a+aQ
	CCv3OuvtuQVd6aqpuBdIH49o+TT5E0fV0sMheE6h0daUrQcis5M5y5N2tWMDpgYIYJjHKWHSQGU
	+hBu1Twt3JpNROyXX/bs6XOyqKuCvipadnD67BCIpFi2MFU9DTlduoTkqGq4TAsvR4YGhatB0+R
	73yyS15oDHsML9GrGNu5/+DuXicMoRkPyVKSUKplEGj6lDhbEYbyGO8Lk/8C5BdPb4f8JFRVFr1
	yj6HG7eZW99jBrYb2ANLqSKRe9kAzyBpBvlN
X-Received: by 2002:a5d:6f0e:0:b0:48a:ef5c:fc2c with SMTP id ffacd0b85a97d-48e6e515db3mr17552899f8f.48.1793541431219;
        Sun, 01 Nov 2026 05:57:11 -0800 (PST)
Received: from LAPTOP-AVI.lan ([2a06:c701:4773:6f00:9c55:89d4:b00d:2bbe])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b789ecsm13856454f8f.29.2026.11.01.05.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 05:57:10 -0800 (PST)
From: Avi Weiss <thnkslprpt@gmail.com>
To: Jon Mason <jdmason@kudzu.us>
Cc: Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Koichiro Den <den@valinux.co.jp>,
	Frank Li <Frank.Li@nxp.com>,
	ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Avi Weiss <thnkslprpt@gmail.com>
Subject: [PATCH v2 1/2] NTB: epf: serialize memory window parameter writes
Date: Sun,  1 Nov 2026 15:57:05 +0200
Message-ID: <eeb0cfec451d748b2f997c16a0a3a2afb56569e9.1793540847.git.thnkslprpt@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793540847.git.thnkslprpt@gmail.com>
References: <cover.1793540847.git.thnkslprpt@gmail.com>
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

ntb_epf_mw_set_trans() writes the address and size to shared control
registers before ntb_epf_send_command() acquires cmd_lock. Concurrent
memory window setup requests can overwrite each other's parameters,
causing one window to use another's DMA address.

Hold cmd_lock across the parameter writes and command submission.
Use a locked command helper to preserve the existing serialization
for other command callers.

Fixes: 812ce2f8d14e ("NTB: Add support for EPF PCI Non-Transparent Bridge")
Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
---
 drivers/ntb/hw/epf/ntb_hw_epf.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
index c47607d4f8a7f..da7fbe1800656 100644
--- a/drivers/ntb/hw/epf/ntb_hw_epf.c
+++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
@@ -123,15 +123,14 @@ struct ntb_epf_dev {
 
 #define ntb_ndev(__ntb) container_of(__ntb, struct ntb_epf_dev, ntb)
 
-static int ntb_epf_send_command(struct ntb_epf_dev *ndev, u32 command,
-				u32 argument)
+static int ntb_epf_send_command_locked(struct ntb_epf_dev *ndev, u32 command,
+				       u32 argument)
 {
 	ktime_t timeout;
 	bool timedout;
 	int ret = 0;
 	u32 status;
 
-	mutex_lock(&ndev->cmd_lock);
 	writel(argument, ndev->ctrl_reg + NTB_EPF_ARGUMENT);
 	writel(command, ndev->ctrl_reg + NTB_EPF_COMMAND);
 
@@ -157,6 +156,17 @@ static int ntb_epf_send_command(struct ntb_epf_dev *ndev, u32 command,
 	}
 
 	writew(0, ndev->ctrl_reg + NTB_EPF_CMD_STATUS);
+
+	return ret;
+}
+
+static int ntb_epf_send_command(struct ntb_epf_dev *ndev, u32 command,
+				u32 argument)
+{
+	int ret;
+
+	mutex_lock(&ndev->cmd_lock);
+	ret = ntb_epf_send_command_locked(ndev, command, argument);
 	mutex_unlock(&ndev->cmd_lock);
 
 	return ret;
@@ -494,11 +504,13 @@ static int ntb_epf_mw_set_trans(struct ntb_dev *ntb, int pidx, int idx,
 		return -EINVAL;
 	}
 
+	mutex_lock(&ndev->cmd_lock);
 	writel(lower_32_bits(addr), ndev->ctrl_reg + NTB_EPF_LOWER_ADDR);
 	writel(upper_32_bits(addr), ndev->ctrl_reg + NTB_EPF_UPPER_ADDR);
 	writel(lower_32_bits(size), ndev->ctrl_reg + NTB_EPF_LOWER_SIZE);
 	writel(upper_32_bits(size), ndev->ctrl_reg + NTB_EPF_UPPER_SIZE);
-	ntb_epf_send_command(ndev, CMD_CONFIGURE_MW, idx);
+	ntb_epf_send_command_locked(ndev, CMD_CONFIGURE_MW, idx);
+	mutex_unlock(&ndev->cmd_lock);
 
 	return 0;
 }
-- 
2.43.0

