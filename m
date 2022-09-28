Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7F07B
	for <ntb@lists.linux.dev>; Wed, 28 Sep 2022 11:00:22 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id i15-20020a17090a4b8f00b0020073b4ac27so1360739pjh.3
        for <ntb@lists.linux.dev>; Wed, 28 Sep 2022 04:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=hOXy/3B0e3cTGMIExCyp30h8nQPc8EN7HUScg4kF8wU=;
        b=hLncl5wigkp6LZxL1UHj5XXUDDZ7qtJq55Ge5vMbfW4Al2AGA2iQkMOvrdtdOf1VL2
         Rk/K/quMGIKxGPbpPAVJMtta7+wR+aeQCVaEZustg4IyVmieXUttW5qjciBXU//DM50q
         hGgVzPCREUx3DwaSPr8HwW088CPspOQqoZjpUpmyQMHz4xc+k6wRn2UheZ9k13pqJ4of
         S61hxLYNDw+33s1SeoYz6kEwxf25V4l4XlDghrJbkBTjFerJpQLwGBR528la4jpRrmBd
         c0uwJBogoeYHET4ns90XPd1dUcF8W6nI1xhKtZCRBBVuv2WRMWTiyUyYiZy/6E2YUYVj
         qoCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=hOXy/3B0e3cTGMIExCyp30h8nQPc8EN7HUScg4kF8wU=;
        b=CSBUObAbkgMLgcs321mdqsRV9RFwvlSckEEcsRm8dZLY1dBm1L4MspKlDTGsPZYGKp
         FEIcVAmgFkjgNgH0TsupwRm9SrwQj/8vn3sSBfjvzBm3BXWECh4i2znX+ukf9QRJ+FjU
         JiWP6fPOF4gC2iXNtThM2T4Nb04UQbD7KRazXxkpfxFqfSK91DCgmj4BwmjUgmf8xU6j
         H4Yp2WqwW3NqyrEW3hyujNOBWjN7c0J8vn75XcB73Xv8kIQAYIcguJK08VHNIMpE9hgO
         Nr2o3eJQ2F0B10SgGYz202EwEkusGdD8j92t8kSWetWbB5RjKHuseWGvGK+WX5bLMCQF
         NDOQ==
X-Gm-Message-State: ACrzQf3tuSzlQDOz9ADbY6B7he18iwx8tQbAEaTMwBFRnAl+2b/Jz0u1
	An3uk3ULwXjTaudHQQ0p+4Lx7Q==
X-Google-Smtp-Source: AMsMyM4zzBvJpGNUwArQu+atMDproDm1I0tlw6EBKQ2GB2pfCmWCLWQxTIq8rmIlylXF+q8NzyS4Lg==
X-Received: by 2002:a17:90b:374f:b0:205:e255:e8de with SMTP id ne15-20020a17090b374f00b00205e255e8demr6980382pjb.8.1664362821737;
        Wed, 28 Sep 2022 04:00:21 -0700 (PDT)
Received: from C02F63J9MD6R.bytedance.net ([61.120.150.77])
        by smtp.gmail.com with ESMTPSA id b13-20020a170902d50d00b00177efb56475sm1539524plg.85.2022.09.28.04.00.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Sep 2022 04:00:21 -0700 (PDT)
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
Subject: [PATCH v3 3/9] NTB: Remove pci_aer_clear_nonfatal_status() call
Date: Wed, 28 Sep 2022 18:59:40 +0800
Message-Id: <20220928105946.12469-4-chenzhuo.1@bytedance.com>
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

There is no need to clear error status during init code, so remove it.

Signed-off-by: Zhuo Chen <chenzhuo.1@bytedance.com>
---
 drivers/ntb/hw/idt/ntb_hw_idt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
index 0ed6f809ff2e..fed03217289d 100644
--- a/drivers/ntb/hw/idt/ntb_hw_idt.c
+++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
@@ -2657,8 +2657,6 @@ static int idt_init_pci(struct idt_ntb_dev *ndev)
 	ret = pci_enable_pcie_error_reporting(pdev);
 	if (ret != 0)
 		dev_warn(&pdev->dev, "PCIe AER capability disabled\n");
-	else /* Cleanup nonfatal error status before getting to init */
-		pci_aer_clear_nonfatal_status(pdev);
 
 	/* First enable the PCI device */
 	ret = pcim_enable_device(pdev);
-- 
2.30.1 (Apple Git-130)

