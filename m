Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF32633E4
	for <ntb@lists.linux.dev>; Mon, 27 Jun 2022 15:57:16 +0000 (UTC)
Received: by mail-pf1-f172.google.com with SMTP id n12so9484913pfq.0
        for <ntb@lists.linux.dev>; Mon, 27 Jun 2022 08:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q7ZSEV4LTD7LAEM2Qop9QWeKPyT8Eo98shgP/WcfAJM=;
        b=TD25yDZjhKN9TW36xDeM7TC/WXolSNS4MNswQEtngcUO1oXtqBPpHKRVemyWExAlFW
         TqyvvXlQnhbGsHE73jVzf9Y9myNUkq+LmwxSgmvbIrAkTKRE8ajBfNydza4Fe1PWDCGo
         XN9lsNhRoOlrS3Twls6Nfrj9RBXQIGwY5DmVwoSfnp2Ara+fYn8fsBgPHgdzCdEMq0mO
         UMFJ0JsZO9r/GyZxyRU76iYGgF/7rl0zwXLixDbWPgyWOQ63wjrZwwnOr3K1Jnv7a9PF
         QKEiklV9Wc5SFJuofCme726CpZgab0fToWe4ZqGpSUmTSEqY0DkQgIKX3LCCrRr03tgp
         bLGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q7ZSEV4LTD7LAEM2Qop9QWeKPyT8Eo98shgP/WcfAJM=;
        b=1omkPiG9NpW2WVNPr2XbUV4LLMFKvpogOzO4Rsn2qu9wcAK8e9qcIhpqccAoGvczzS
         cckvE/7dWzOxrBYf5aAUuvFh048AhzbW34CJpuL69OHWclY95C46DcpqRYjAnrd7NLNF
         RpJmSbf+GDHDdKkT1CFe2c500DQPqxivAKrStGLlbgdRyXwzbbcjdf7EBd1G63nKrZoS
         zdiNKEoR5KQmLDGX+1DXKPBjDoUUUMLwQcevpfwykOCWx+KTsQfW+MH+3SgUudlk2sq8
         yV2uiZpawm8U+X//QKdpvYc79gF5m3AQlc6dh1TwrFdj0w+6Dokel5tbFVeENg7+tqDi
         V6BA==
X-Gm-Message-State: AJIora8k93hiVBpsMfp9EYg6y/vrLiSdHDaldU/7BLApQLpYxmR+hj+b
	u5yPKIncO91AnwEq153AXVU=
X-Google-Smtp-Source: AGRyM1v0/J58YZ3w/3MSk7WzTC+fbEwFJrbTeOxEdqpHzith/X6cEbp8QvXyQ3UyKtR/zcQ/eIEfuw==
X-Received: by 2002:a05:6a00:1a0c:b0:523:1a23:957f with SMTP id g12-20020a056a001a0c00b005231a23957fmr15619816pfv.45.1656345436401;
        Mon, 27 Jun 2022 08:57:16 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:26dc:1818:7133:85db])
        by smtp.gmail.com with ESMTPSA id h4-20020a056a001a4400b005252e524d1csm7499932pfv.211.2022.06.27.08.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 08:57:15 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: linux-next@vger.kernel.org,
	ntb@lists.linux.dev,
	Alexander Fomichev <a.fomichev@yadro.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Jon Mason <jdmason@kudzu.us>,
	Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] drivers/ntb/test: avoid 64-bit modulus operation
Date: Mon, 27 Jun 2022 08:57:10 -0700
Message-Id: <20220627155710.2067032-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Redefine RESCHEDULE_RATIO to a closest power of 2 so that the following
code in the perf_run_latency

	/* Avoid processor soft lock-ups */
	if (!(pthr->tries % RESCHEDULE_RATIO))
		schedule();

doesn't do 64-bit modulus operation.
This fixes the following build failures on 32-bit architectures visible
in linux-next:

  ERROR: modpost: "__umoddi3" [drivers/ntb/test/ntb_perf.ko] undefined!

Fixes: dc150dfb081f ("ntb_perf: extend with burst latency measurement")
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 drivers/ntb/test/ntb_perf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index 23e154bd41b9..536fab0030f3 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -126,7 +126,7 @@ MODULE_DESCRIPTION("PCIe NTB Performance Measurement Tool");
 #define PERF_BUF_LEN 1024
 
 #define LAT_MIN_TRIES	20
-#define RESCHEDULE_RATIO	10000
+#define RESCHEDULE_RATIO	8192 /* power of 2, to avoid actual division */
 
 static unsigned long max_mw_size;
 module_param(max_mw_size, ulong, 0644);
-- 
2.30.2

