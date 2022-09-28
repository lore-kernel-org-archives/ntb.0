Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67C4EC0
	for <ntb@lists.linux.dev>; Wed, 28 Sep 2022 11:00:14 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id cp18so3050154pjb.2
        for <ntb@lists.linux.dev>; Wed, 28 Sep 2022 04:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=hqHsGeDKe0t7ifwT22YFmx420oJcPi+zdGlDsAhLUb0=;
        b=m+h1aSlRyOmyWLPEegkC4UTOP5mPnZb/u7MDJuDqO7L0oSlCnQoyJhUm3SWgCH00mF
         +4ujgBYFq2vlJ2WRylNv/WHQ5qJlHSfvxyY9LrO5aufZZS9Sc1omuaJhkAHcj0qBr8y6
         39gHedQoOOfGN/PofAoqNRkBKCo0PSVhB4/blu7M03tzfCb5REYVvITZevtJbJ8KQYbQ
         eRcN4dzRCZRBWc/f5UZFCe2JWbhiFs+jqRa7UzCLfrvuit8SQUOZVv6lzNOvsW7qAllk
         n1heNKwq4tOo4KNg/bito9QLe9QeNk63Rbrab/wZsmr9npT0K5U+1EVIP96nrXfB2KmT
         0FYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=hqHsGeDKe0t7ifwT22YFmx420oJcPi+zdGlDsAhLUb0=;
        b=TFmUGiMLf1EVhYhZvuTHqqfUorcejZ/NhtuyoLVxcUBpQvagJi0jbIS4dLVBAQ2vRb
         S0iXH7BGDL+p7CQxURnylOkccXB6sIaHJAZNl0S3s5YiE38WDTu9liKALxav07VxkanL
         JOYLKFh2n2WkU9K9bFgqAuokypKO6kS/dSov6QIwST4BLaLth6y+xsFPxyjWN8bDYw5y
         LSlGj/RRJWXBGfTACKKeafC4JwGuif1how3s3c5rxm8p5mYTNn/A3nSXN2dmRbdv8AnK
         AiVYhymASg3s+EVVSf5Djs+Nw7taS5puBKvWVzG8+w8ze895oRn7sfKf9TKMpjgg7iFC
         zwDQ==
X-Gm-Message-State: ACrzQf2shesyj4Dbue/E0Vl6KamtO1ONEd2i3Xfm9cDrwUOqlZYnFj1X
	t87obprSziWQ3IrpBxHl+SBDPQ==
X-Google-Smtp-Source: AMsMyM5C26cGEuhYulr7S2jFc6VQqD+oKgKzpNLlpxnRs14brLWhNpxe/xWjjleGrOws83qXpNbKMw==
X-Received: by 2002:a17:903:24e:b0:179:b755:b82f with SMTP id j14-20020a170903024e00b00179b755b82fmr29636731plh.34.1664362814279;
        Wed, 28 Sep 2022 04:00:14 -0700 (PDT)
Received: from C02F63J9MD6R.bytedance.net ([61.120.150.77])
        by smtp.gmail.com with ESMTPSA id b13-20020a170902d50d00b00177efb56475sm1539524plg.85.2022.09.28.04.00.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Sep 2022 04:00:14 -0700 (PDT)
From: Zhuo Chen <chenzhuo.1@bytedance.com>
To: sathyanarayanan.kuppuswamy@linux.intel.com,
	bhelgaas@google.com,
	ruscur@russell.cc,
	oohall@gmail.com,
	fancer.lancer@gmail.com,
	jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	james.smart@broadcom.com,
	dick.kennedy@broadcom.com,
	jejb@linux.ibm.com,
	martin.petersen@oracle.com
Cc: chenzhuo.1@bytedance.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev,
	linux-scsi@vger.kernel.org
Subject: [PATCH v3 2/9] PCI/DPC: Use pci_aer_clear_uncorrect_error_status() to clear uncorrectable error status
Date: Wed, 28 Sep 2022 18:59:39 +0800
Message-Id: <20220928105946.12469-3-chenzhuo.1@bytedance.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20220928105946.12469-1-chenzhuo.1@bytedance.com>
References: <20220928105946.12469-1-chenzhuo.1@bytedance.com>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pci_aer_clear_uncorrect_error_status() clears both fatal and non-fatal
errors. So use it in place of pci_aer_clear_nonfatal_status()
and pci_aer_clear_fatal_status().

Signed-off-by: Zhuo Chen <chenzhuo.1@bytedance.com>
---
 drivers/pci/pcie/dpc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 3e9afee02e8d..7942073fbb34 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -288,8 +288,7 @@ void dpc_process_error(struct pci_dev *pdev)
 		 dpc_get_aer_uncorrect_severity(pdev, &info) &&
 		 aer_get_device_error_info(pdev, &info)) {
 		aer_print_error(pdev, &info);
-		pci_aer_clear_nonfatal_status(pdev);
-		pci_aer_clear_fatal_status(pdev);
+		pci_aer_clear_uncorrect_error_status(pdev);
 	}
 }
 
-- 
2.30.1 (Apple Git-130)

