Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05EE53B1
	for <ntb@lists.linux.dev>; Thu, 13 Jul 2023 06:00:28 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-3fbc54cab6fso2418545e9.0
        for <ntb@lists.linux.dev>; Wed, 12 Jul 2023 23:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689228027; x=1691820027;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CD3yM43uVnHI58j5asWPMcNTIiJ0VXkGdNi8zJM5rl8=;
        b=jPbN/2PN3o9FYzujK+crWu5CCRRJRoeTLtRw6l3ITIs32FKiFPJPLeOLwZq4h24rF8
         7oAxo5tBIscu4EdByBgJZFm24LSWy/fc9wrZA6Tw3RrLicgmsn5Ucz5H3kwQlARQ06gO
         f/BbDF3wzVAIUwd6nKXu8y6Q/2H8ScEsu83F+B9sWmZqtbatLnmExDgGb3Hh1B/bflth
         EVq1MlVLP4StOFw8L2Ju7KfWi29gNTo7AbSFuTCm2fyLx6oCZvasny0RKOYlHE/rxhxT
         M6YENiNygFmCLbjGrEeFPbny97ZvNqwchXSKwJBEMPeInyoQznQe/63M3gkcQWa/f3wX
         7qWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689228027; x=1691820027;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CD3yM43uVnHI58j5asWPMcNTIiJ0VXkGdNi8zJM5rl8=;
        b=aGza3y6/HJFCMOzyACj+5sRAHDxePGrtkcXGA/5LSqNW/mb//jb9O5IiPudbPPObfP
         9BK2clw8ohnZwHyNy0kQJMkHoXMMTCvKRykqTXK0+DoGe1xDGh5usu9aM9NhVQIJLGHv
         T6dkJCwpnh4rzjWaHo1GhRbOSSUKA+amReoFgsuxN0oMM23ogkGVnYzb1HAc/WKp3b0V
         MCm8B0S/sUoTOQct7mkz615gbUeG+wUanL3EsRUdfyHvE6iNcgahju72GcMRZbCEDnj1
         37+95V3fJFNOcRPXWM+nODJ72c5l0nF4kyaJw1cnUciXqyuz4WNYemX+vZWbu0JfaG7p
         P0ww==
X-Gm-Message-State: ABy/qLauUd14ES6tiRbs4GH8IXas26cqidiQ8LgvH3XmxZa049bBqaMC
	LCM7CX6/gK00xXOdcqbGZriQlQ==
X-Google-Smtp-Source: APBJJlHonhciDEd++BHU5EGIRUCt/hp64szoeIPE8MHsVC2B6aCGlD5ZkVr3/Z2zEogB2D9OgGuHPA==
X-Received: by 2002:a7b:c5ce:0:b0:3fb:dff2:9f17 with SMTP id n14-20020a7bc5ce000000b003fbdff29f17mr437447wmk.15.1689228026881;
        Wed, 12 Jul 2023 23:00:26 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id f11-20020a7bc8cb000000b003fa98908014sm17443210wml.8.2023.07.12.23.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 23:00:24 -0700 (PDT)
Date: Thu, 13 Jul 2023 09:00:20 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: =?utf-8?B?546L5piOLei9r+S7tuW6leWxguaKgOacr+mDqA==?= <machel@vivo.com>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Dan Carpenter <error27@gmail.com>,
	Jiasheng Jiang <jiasheng@iscas.ac.cn>,
	"ntb@lists.linux.dev" <ntb@lists.linux.dev>,
	LKML <linux-kernel@vger.kernel.org>,
	"opensource.kernel" <opensource.kernel@vivo.com>
Subject: Re: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjJdIG50?=
 =?utf-8?Q?b=3AFix_an_NULL_v?= =?utf-8?Q?s?= IS_ERR() bug for
 debugfs_create_dir() in tool_setup_dbgfs()
Message-ID: <bc1efd80-a490-4037-9e83-e0bb5cc0cb47@kadam.mountain>
References: <20230712124035.7981-1-machel@vivo.com>
 <138ab604-27de-4ac6-88fb-0886ee8f6b6d@kadam.mountain>
 <SG2PR06MB3743C36C711A4801F4CE2304BD37A@SG2PR06MB3743.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SG2PR06MB3743C36C711A4801F4CE2304BD37A@SG2PR06MB3743.apcprd06.prod.outlook.com>

On Thu, Jul 13, 2023 at 02:13:32AM +0000, 王明-软件底层技术部 wrote:
> Hi dan carpenter
> You mean that this modification is correct, but there is no need to do
> so, is that the understanding?

No, this patch is wrong.  Possibly harmless, possibly harmful but either
way it is wrong.  The correct way is:

diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c
index eeeb4b1c97d2..e0acc11d29ba 100644
--- a/drivers/ntb/test/ntb_tool.c
+++ b/drivers/ntb/test/ntb_tool.c
@@ -1495,8 +1495,6 @@ static void tool_setup_dbgfs(struct tool_ctx *tc)
 
 	tc->dbgfs_dir = debugfs_create_dir(dev_name(&tc->ntb->dev),
 					   tool_dbgfs_topdir);
-	if (!tc->dbgfs_dir)
-		return;
 
 	debugfs_create_file("port", 0600, tc->dbgfs_dir,
 			    tc, &tool_port_fops);
