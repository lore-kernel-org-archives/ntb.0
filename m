Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071506135
	for <ntb@lists.linux.dev>; Tue,  7 Mar 2023 12:20:27 +0000 (UTC)
Received: by mail-pf1-f170.google.com with SMTP id y10so7861173pfi.8
        for <ntb@lists.linux.dev>; Tue, 07 Mar 2023 04:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678191627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zR3SqOIJEtppTiQ5ZJZtYtRZxphAv9rsA+9/zUbIboo=;
        b=ntg9YKaHYSvNV0n9rp/He7GTZHoPjspMXn2a3Z+Xpo5HRF42WlyfzawcxBf4QHRaku
         O4+92vfVHLH+8ZQeivMZ3He+9MnpmVGwzOjG6tcnn1ihhSv+vQFMAThps7doRHBsZBYS
         Zag0lftoSAQs5oIBHyIC/Gb6HfJ9HrEjJ6MNBz5qagsT2AIzB8YMti7obBQVPvGM4Ssv
         3HmB7NcuiMCeEvcvMOG8JeSY+FzhnWDG/SE4dvYOu4wi+qPQSQgrj+1U2AKWb+ZBcxsb
         XA0C0VokCCxGvaHeMFj5NWevZa9/uhkIH4Za3uBUHGE8ojUN2LyKvN6Iq/w3poVHba9o
         OFHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678191627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zR3SqOIJEtppTiQ5ZJZtYtRZxphAv9rsA+9/zUbIboo=;
        b=ZB79BOBYxv3CVxJh8+caLZPqMY2tM5u4K7sqSnCWJ8ze4Jw7uo5SzcqIaQDUAyf2Kb
         QiC02yrLqAl0CyYZjco8Xv93/C5Yd/hkkfb4JaUKPEVpooOLIifCxSvSZGKRlQEbClIr
         m/weMt0xikk+150c1utlvuVZja6kh0UhvfBlAsqkAJYBWhLkYWv6zc6ROcH37VhGn7ro
         2547isyy9tuIvqt4tIpjCXzgJ+sxR6aoXfg9CML/QDiq8cqv4+WTkTCcZvmcz116ReV0
         joKk7bqQndTO3A465GmCsASPDAA4xBHfUtEit5il6CiwD92PMlS3LY7v69T8SjNR9iDk
         QXcA==
X-Gm-Message-State: AO0yUKX0xQYTC6jSOl1rr5uNGjbO/kyii4HIebkyyKPI8YTvgoJtRxDY
	KhWnYUREO5hV3xOCQ1USCrU=
X-Google-Smtp-Source: AK7set9Q+ap+0E+m5VrEF2rj5byWm+UCrUB/9hVJ1TyAMY7po6SpVX3AwPn8hzHuj4Cg2gVVQk6y2Q==
X-Received: by 2002:a62:7b03:0:b0:5a8:c699:3eaa with SMTP id w3-20020a627b03000000b005a8c6993eaamr14749539pfc.9.1678191627325;
        Tue, 07 Mar 2023 04:20:27 -0800 (PST)
Received: from passwd123-ThinkStation-P920.. ([222.20.94.23])
        by smtp.gmail.com with ESMTPSA id k19-20020aa792d3000000b0058173c4b3d1sm7792506pfa.80.2023.03.07.04.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 04:20:26 -0800 (PST)
From: Kang Chen <void0red@gmail.com>
To: fancer.lancer@gmail.com
Cc: allenbh@gmail.com,
	dave.jiang@intel.com,
	jdmason@kudzu.us,
	linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev,
	void0red@gmail.com
Subject: [PATCH v2] ntb_tool: check null return of devm_kcalloc in tool_init_mws
Date: Tue,  7 Mar 2023 20:20:21 +0800
Message-Id: <20230307122021.1569285-1-void0red@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230306152810.ptb622tfhoxehhdc@mobilestation>
References: <20230306152810.ptb622tfhoxehhdc@mobilestation>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

devm_kcalloc may fails, tc->peers[pidx].outmws might be null
and will cause null pointer dereference later.

Fixes: 7f46c8b3a552 ("NTB: ntb_tool: Add full multi-port NTB API support")
Signed-off-by: Kang Chen <void0red@gmail.com>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
---
v2 -> v1: add Fixes and Reviewed-by tags

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

