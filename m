Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13BF364
	for <ntb@lists.linux.dev>; Sun, 26 Feb 2023 05:57:48 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id u10so3001672pjc.5
        for <ntb@lists.linux.dev>; Sat, 25 Feb 2023 21:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q7mel5hZ+WwOyr4vFQ+1SxGc09bvkF0xtIqhHxXgg+8=;
        b=cy3YKdEpKKdjVbRlotje9TmHKwGBjeZjFKwVWpuM+wUWvU0ls9rMH9lgPo8lKsng8m
         t0RWE24bIh/HvG+DC02UxdcraLbEbBdaHzVWQjF1Vd0KviXCUipZijtrQguIv+S0Zcph
         7ATgbptRfoMG1Jk/8FjDQvWT32ee4AhPKXkNwAULZwKrd8hDJ6F7x1PL48oKhtm582wW
         fDmkVz1OQfJdexvtBCcndLdq9axujJJcpGcKaWokHd/It6vrWCK0+/BgrCnv+amRMyJ4
         q00WyudL7xaWJAkxLUB/ZZpX+B5wHxM1vQuH9qPq6CShUNFFBbpy+zQ/2VYYrvVetRRa
         rR4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q7mel5hZ+WwOyr4vFQ+1SxGc09bvkF0xtIqhHxXgg+8=;
        b=eu4SyOUvY78zHMbEXeVANAcTFSFusNVjBUvDbzLVQlto9ydh85p+cFATlhXZDm+0MH
         7nyTlNp9VPwG+re75oRPv2tCsWbfdvH33ZwVHLJlcP4v87DADMzXUPDwR7CaAVcXNjau
         dzNXWqEUl+/STswHu2cUYr+Y06KLfFmQr04DLmFv/pkQt273//yrL9s9G1aiyIKgoMJU
         yDEzgzLnufrktGiv9z4QiXJnq1uIShEpIIjg+u2GpArVEfVd/faT9M2cj8ajNQRuyoZ8
         3YBc32MPb/D6XNUygvNhWpnTxv6Z9f30Qxc+swyGvx7v8P7bUMbGG/Nc+s2XYOCGOL7g
         g7WA==
X-Gm-Message-State: AO0yUKXn/wtNOZ2xHyYfb1hX5C6ut+vrPQIihNzv+xdyEXc1RQH6HfdL
	RcChGcw1MirIvics3uQgzCg=
X-Google-Smtp-Source: AK7set+upKe0U+VxsPpgDIQR2qLhjTHVJnCdOEGJbTvXjNIuTF7U0zM5e8ONFQVdGhKVSJ4SFMBuww==
X-Received: by 2002:a17:90b:1bc7:b0:237:b5d4:c0e3 with SMTP id oa7-20020a17090b1bc700b00237b5d4c0e3mr5521011pjb.33.1677391068338;
        Sat, 25 Feb 2023 21:57:48 -0800 (PST)
Received: from passwd123-ThinkStation-P920.. ([222.20.94.23])
        by smtp.gmail.com with ESMTPSA id hg3-20020a17090b300300b00233afe09177sm3854872pjb.8.2023.02.25.21.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 21:57:47 -0800 (PST)
From: Kang Chen <void0red@gmail.com>
To: jdmason@kudzu.us
Cc: dave.jiang@intel.com,
	allenbh@gmail.com,
	ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Kang Chen <void0red@gmail.com>
Subject: [PATCH] ntb_tool: check null return of devm_kcalloc in tool_init_mws
Date: Sun, 26 Feb 2023 13:57:43 +0800
Message-Id: <20230226055743.2522819-1-void0red@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

devm_kcalloc may fails, tc->peers[pidx].outmws might be null
and will cause null pointer dereference later.

Signed-off-by: Kang Chen <void0red@gmail.com>
---
 drivers/ntb/test/ntb_tool.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c
index 5ee0afa62..eeeb4b1c9 100644
--- a/drivers/ntb/test/ntb_tool.c
+++ b/drivers/ntb/test/ntb_tool.c
@@ -998,6 +998,8 @@ static int tool_init_mws(struct tool_ctx *tc)
 		tc->peers[pidx].outmws =
 			devm_kcalloc(&tc->ntb->dev, tc->peers[pidx].outmw_cnt,
 				   sizeof(*tc->peers[pidx].outmws), GFP_KERNEL);
+		if (tc->peers[pidx].outmws == NULL)
+			return -ENOMEM;
 
 		for (widx = 0; widx < tc->peers[pidx].outmw_cnt; widx++) {
 			tc->peers[pidx].outmws[widx].pidx = pidx;
-- 
2.34.1

