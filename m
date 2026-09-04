Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC1F43B6C4
	for <ntb@lists.linux.dev>; Fri,  4 Sep 2026 11:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788522941; cv=none; b=AUO70zbrE+VnQ0eowQtBl3+7vOVgnJ1Wkb6zM5FJ859c/CobrPQVnW6ieWz75aJDThgQs9B8njse/xsGX1+chftGjz6WqhXFDsyZ201dLu82IdpLCUZKWpBTQw2WnfGRW2VAz1SIxR5slXNTl0/k5ULXXiGuWZnQa2vrU/QTWbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788522941; c=relaxed/simple;
	bh=z8iIzs5DDnWzQtw2LUYeiEuFEzPHhCuXMUc1+Axn0VU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IJE+MZe221uc+87qbclfCiahXYZUqUHuKDEMgBDoCPxCfNuvgwWqQT9WkZLLfQlENMSfkYAXAidewm2776WpwPX2jVR8sq7Xunq1vNpssRWsmxwMeJCpG5N8HhyFM26IafD7ZlzEWaxSANZQcXuMj3QGiGNhvnBH7niG41SQLps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CRFCGpxp; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRFCGpxp"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2d91ded8174so7473725ad.1
        for <ntb@lists.linux.dev>; Fri, 04 Sep 2026 04:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788522940; x=1789127740; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Xdr1Kg5gJsWYJr/v5Af5lr5k6jYnKDbP79UXMnLtwuM=;
        b=CRFCGpxpfJ+S4X41iMWLdCeytPHrCWPaaX75ccYdjVXtottyqQwA7rjjkevRQsJ5lM
         yJ5g7MIElBKQDZaOipx9d+qx956s2p0GsWabr+ewaZN1QS/kpdGR86vk6XM67Q3eUtUm
         iLN6IK368XmOI8m0yK489KWJ5Rghj6cBU2qzvaBqoBaf33RprCrloKfnH9eNQ1p3MkMu
         jSrVFgR1eqpFBUhF/QQdBsmSZirzj6UT9ZzUsgvcQ3a1Bu5fsWVxmtq5LTM3yvbfPqwf
         VFW3/oFVqyxdK+4jD/tChCH1LtZtgh+IABJgimzBNTdUKN0ECo/cbKHQWwRc+VPFyiZD
         T5Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788522940; x=1789127740;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xdr1Kg5gJsWYJr/v5Af5lr5k6jYnKDbP79UXMnLtwuM=;
        b=YzaYPLweW6CR0+7rE6dd/DZO/7P2Qfifi45hTr9LpUGXW+lw65C1dbjG9tEJYdGxXc
         oVW/sACMeRrCrX+anZ4Dr/FLSmFLjrEUoqcbR3BWXFVPFIMoCYfaLzfh47+bUVEwgzQw
         HhWxdiear5/CIS2EAu70sIrcOx7xgY16Vrthr6fBRC+yxYqntaRnUJ07330YRpTNYT9S
         5YtHJjsGwQBzs1VPDDkIIH242Z/wp44bjfc1HHeYhRt7ZVI9NXkI1yrVYaso6/puvxLl
         gkdETlgufbx8PphlPURA3BujZ05cizX2KrxJKIp6zHhVJskt2WWPab1dZJ2+3NiJObzL
         Pirw==
X-Forwarded-Encrypted: i=1; AKwUvByjdlKTCAgef/+3KPbV7PlLzact3zqj8oF5v0UG7py2G3Gf5KgrXMTP4FE1xnjfQUICx8M=@lists.linux.dev
X-Gm-Message-State: AFuF++nPbrMlk7MXgWRhY3qT0iJjQvU+TZKBXPKhx7p7FrHQyMbbzzRo
	9XOcuQ910R5YcWGH0OQ3NjqiL/Cti6NVx5jB7jjKq9UqB7qdEk88nsc4
X-Gm-Gg: AYBFou3lUfukX1RFl2kZeSrrBoVVB89xNg6g5kpyY7RJtfeJ7ZlaKH2/q+coE1y6F5L
	jK3jYs6RHDiSegRkuAmceh3mehxNqD/17zdWCHubVPYIeNCqowaeKLFU7b6322rTsojbkDDxE/j
	OEuM0PYAl2IQ562HqfeC9POT/aSi0f4h4E54aEnJbY5aadKgTarKX+UbcVYW4GZFCiVRo5kPYoK
	AdXmVzBDPVS8KCUJA/E96/PdyLZy8EnqtIj6Q1Izp9YVSafYkF2i8BtJZE6uD6YTi7l09pn7kiW
	FGBmNIH6FnSWXzKX294Lr+7K7KbDOrWtBLaaC+7vs4ElwKdUhW00AQnxKneMznhgFDrG6IiDZvH
	Z3UZi77ykPoLWghLAqdQKNVj1+6+0j/dB6W72ccFE+8ct0TiWhQ99Z2RR/NstYfe8GmYjZAuSYD
	Tq0qh6YsTNWN0IEcfEt2Z1FLfEH4l+hZfq/bA1F2yHoK1yUgG/PtBeL2Z/owWuHs81v1ur+XvRJ
	q22mevMYiTukjw=
X-Received: by 2002:a17:90b:2749:b0:398:d292:e6d5 with SMTP id 98e67ed59e1d1-39b26304385mr9396199a91.24.1788522939620;
        Fri, 04 Sep 2026 04:55:39 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339af25062sm9246445eec.16.2026.09.04.04.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 04:55:39 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH] ntb: fix typo "atleast" in comments
Date: Fri,  4 Sep 2026 17:25:33 +0530
Message-ID: <20260904115534.11165-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct "atleast" to "at least", reported by scripts/checkpatch.pl using
the misspelling list in scripts/spelling.txt.  Only touches comments, no
code changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 drivers/ntb/ntb_transport.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index f9caa1a653c5..47585dc62eb7 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -611,7 +611,7 @@ static int ntb_transport_setup_qp_mw(struct ntb_transport_ctx *nt,
 
 	qp->remote_rx_info = qp->rx_buff + rx_size;
 
-	/* Due to housekeeping, there must be atleast 2 buffs */
+	/* Due to housekeeping, there must be at least 2 buffs */
 	qp->rx_max_frame = min(transport_mtu, rx_size / 2);
 	qp->rx_max_entry = rx_size / qp->rx_max_frame;
 	qp->rx_index = 0;
@@ -1195,7 +1195,7 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
 	tx_size -= sizeof(struct ntb_rx_info);
 	qp->rx_info = qp->tx_mw + tx_size;
 
-	/* Due to housekeeping, there must be atleast 2 buffs */
+	/* Due to housekeeping, there must be at least 2 buffs */
 	qp->tx_max_frame = min(transport_mtu, tx_size / 2);
 	qp->tx_max_entry = tx_size / qp->tx_max_frame;
 
-- 
2.48.1

