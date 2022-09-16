Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328302C80
	for <ntb@lists.linux.dev>; Fri, 16 Sep 2022 07:57:24 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id q3so20271877pjg.3
        for <ntb@lists.linux.dev>; Fri, 16 Sep 2022 00:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=YuvBuqEBRJCl7zorVVAVVlmcoiWTc8c8OVPLn4Ys5UE=;
        b=P6dmFhRycQyiwrMOwJkNsZ/BBg8kqPR9AYtgGpqG0fCqzoY37IK1RLuYdcNjzUZ1mS
         maZaszqH8MsEkW3jg90SoSs73SkpUEg+y3d4NSnzq7lQCueWN2urDuMwAVA7bGzWLhYT
         PqzvuNNlUFQ+SDGFk1PcrLvcMeaBug8oOl71yI4aU/VWrW1dQ3CvRFWYz4E759KusM4H
         WMwJO2pJg7ZvEnclA/1addscjrgWNb1Vllmh5/yzQ8XnhG99etnim1ZPgJEHNSgu5dQt
         rzke/AU2JFdSkBOLUm2YBUtky6Ipj44Iv/QhlikY0SDtDwUosMBbhndm0lJl2T26sx4s
         54Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=YuvBuqEBRJCl7zorVVAVVlmcoiWTc8c8OVPLn4Ys5UE=;
        b=5Z5ZBqT+q6AU7fmstQ61sflqJmCpLUOFMO8nPcTlgtS3bXpeTU6DWklJRU5bZHBDg1
         g79mRixqZsoqZtHMFlINmaJoeAHJBrNg7BGi4q20kVFsZw4+5SK32hlU4djRqg9CnDb2
         CC/QxtWn+N3WZyv5DQs7wPv9Yc/awV4WJdWeTME+dPD/1mIprQE2iHymbGKqlqbMAFG1
         gNL3Juu6CmrSzNGN1U0n8P5i0QWQ/wXt5JHcbFiwx7NFyOkEanywNKkNBqj0ehH0qHIK
         HAJP7hE/+CBN6vjYHHbSbv2c1EHSrXVaBKLUBCqrPUqIExnFKs3VakYiadaoLa2eagIl
         GN1A==
X-Gm-Message-State: ACrzQf2vfXebaUmuRe8iaMJ2M6tH8AlOKN5XBzApNICM+XZlYywmcsb1
	eezQCudPR/IWfra7gpAClzujLQ==
X-Google-Smtp-Source: AMsMyM6luTj24P0sD683SpaOotadfC+IV3ZQEMuBb4fBCtTB5Ow6HhSJK2rfhpdTg/TKXxasRvWXFA==
X-Received: by 2002:a17:902:f612:b0:172:cbb0:9b4f with SMTP id n18-20020a170902f61200b00172cbb09b4fmr3449108plg.142.1663315043503;
        Fri, 16 Sep 2022 00:57:23 -0700 (PDT)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id y28-20020aa79e1c000000b00543236e83e6sm11319867pfq.22.2022.09.16.00.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 00:57:22 -0700 (PDT)
From: Shunsuke Mie <mie@igel.co.jp>
To: Jon Mason <jdmason@kudzu.us>
Cc: Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shunsuke Mie <mie@igel.co.jp>
Subject: [PATCH] PCI: endpoint: pci-epf-{,v}ntb: fix a check for no epc alignment constraint
Date: Fri, 16 Sep 2022 16:56:51 +0900
Message-Id: <20220916075651.64957-1-mie@igel.co.jp>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>

Some pci endpoint controllers has not alignment constraint, and the
epc_features->align becomes 0. In this case, IS_ALIGNED() in
epf_ntb_config_spad_bar_alloc() doesn't work well. So this patch adds the 0
checking before the IS_ALIGNED().

Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-ntb.c  | 2 +-
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-ntb.c b/drivers/pci/endpoint/functions/pci-epf-ntb.c
index 9a00448c7e61..f74155ee8d72 100644
--- a/drivers/pci/endpoint/functions/pci-epf-ntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-ntb.c
@@ -1021,7 +1021,7 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb,
 	peer_size = peer_epc_features->bar_fixed_size[peer_barno];
 
 	/* Check if epc_features is populated incorrectly */
-	if ((!IS_ALIGNED(size, align)))
+	if (align && (!IS_ALIGNED(size, align)))
 		return -EINVAL;
 
 	spad_count = ntb->spad_count;
diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 0ea85e1d292e..5e346c0a0f05 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -418,7 +418,7 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
 	size = epc_features->bar_fixed_size[barno];
 	align = epc_features->align;
 
-	if ((!IS_ALIGNED(size, align)))
+	if (align && !IS_ALIGNED(size, align))
 		return -EINVAL;
 
 	spad_count = ntb->spad_count;
-- 
2.17.1

