Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AE828F5
	for <ntb@lists.linux.dev>; Thu, 22 Sep 2022 09:24:05 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id d64-20020a17090a6f4600b00202ce056566so1602204pjk.4
        for <ntb@lists.linux.dev>; Thu, 22 Sep 2022 02:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=9Z9yPSyc6+khx5jUdo6dOi29lzFmWOZWB0sb02RmgsQ=;
        b=kj6pJGO5Y/moxtWM7HndQV5eZSroGtOIl8X840LQrtBjfUpyrlIqIo3O9pYNAV+C50
         CRbItabzk9BTHzgj0RyXZ4TzjRNLwMaEHyx4v149IpN8wZeQSthIMFXVOX/OHD/li26Q
         zq19vpPl/AInUNH5anlKn2iXacx2hhIneCFkXWQD5cVnE12G0ZOGQ/si6ulY4NtFsT66
         ApBliiQZcu5B0CMjyLNFILuyF903JrB8eyVTpqQ0nseedSRh4gC1Xu9NxxZ+NGn9vvNW
         flW4rw9gF4d3DMYqp4Zw6+9kC9BkcWQEeXDg3WBHAgZUHAZAw196XGRgv075hThCggi+
         s+mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=9Z9yPSyc6+khx5jUdo6dOi29lzFmWOZWB0sb02RmgsQ=;
        b=q+8Y/0jwOq63MAcUlypn7/LM9P+RLjPdVcZ2bGDT/5TBrh4M7F7txhL2PY/v6d9Z0f
         5mst8n78UlgwA3LlbPdFRFNC0355rE72E260SADEelG7dO8g5ikKePsBdfLd95c46DeA
         XLiqyWqdTalifU8futusWIQT8lnO7C2+qvjp1cnJf8vqM5OOtvUMfkG8wfjVWndYJ4o5
         NsbVXg7eBc8QeCwD2EG/4FRv/0TulWyyN4bNBgYsKdBPhTrWp4gLjUVcePkZQ36g07E7
         G0nozn/v4UUcRpef5Zu3DUgoqSLHgqZ/fo9dEv4TTkvTG0tGC7F1vmvq8QLVx7p8c/9T
         EJ/A==
X-Gm-Message-State: ACrzQf3OOEOIsnRENIJuxgZANFNt7DCvp+IEQJnd7xENmNaV94jeE03o
	6jWrX+EYXK3be7CnfsqUBnkgqg==
X-Google-Smtp-Source: AMsMyM63x/ngMQSxKqooTncWKscwUzeMa9LoEy7hBxh6sONYbvEL/JdwiA2ruZ5pW1eceE0HPc8Dgg==
X-Received: by 2002:a17:903:4112:b0:178:29d8:6d56 with SMTP id r18-20020a170903411200b0017829d86d56mr2478509pld.143.1663838644615;
        Thu, 22 Sep 2022 02:24:04 -0700 (PDT)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id f135-20020a62388d000000b00555ba949f96sm28190pfa.157.2022.09.22.02.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 02:24:03 -0700 (PDT)
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
Subject: [PATCH v2] PCI: endpoint: pci-epf-{,v}ntb: fix a check for no epc alignment constraint
Date: Thu, 22 Sep 2022 18:23:57 +0900
Message-Id: <20220922092357.123732-1-mie@igel.co.jp>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>

Some PCI endpoint controllers have no alignment constraints, and the
epc_features->align becomes 0. In this case, IS_ALIGNED() in
epf_ntb_config_spad_bar_alloc() doesn't work well. Check for this before
IS_ALIGNED().

Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
---
Changes in v2:
* Fix the commit message in phrasings and words.
---
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

