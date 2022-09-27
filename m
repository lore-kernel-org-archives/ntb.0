Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6176D440E
	for <ntb@lists.linux.dev>; Tue, 27 Sep 2022 15:36:43 +0000 (UTC)
Received: by mail-pg1-f177.google.com with SMTP id 3so9765176pga.1
        for <ntb@lists.linux.dev>; Tue, 27 Sep 2022 08:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=pu5CUxxvzQDPV1MrZt0eySYk5qcgDQDMRS6x862FR3M=;
        b=hpOlDxF35EkFZOgnZUEUpb7bfMeNXlEs/6zeqAK6eTGvVycSXxN5mhIMc9S8WfoaF/
         cwWs267qASx0e+WT1TwXng5S9nSyp1dRWH7rUpDXZLoP8jh/myCkq/Dpt9Ocv61bMCrX
         KCVkGQ/DsIqrtNOayppyBxQYmf/6pDTp8loAtnshKT2GVLI7NiICfkvNXNmQwARXA4ba
         w7biRtQ/LR4lB7JOHBHhVgKhVaVGPDngj0vRuIKmH6akrigtDtDlTjL6PpQqW/lzhXea
         fBVQ0A2O0oriv/fWIVwEeR77bbp0SvmTpT9sZNgGsqs2ciLylmpapoYCcXrGggb+tFGz
         ksig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=pu5CUxxvzQDPV1MrZt0eySYk5qcgDQDMRS6x862FR3M=;
        b=wY0H7weWwkkCpzhfSUJpMoIgWTg+tyrAZ6rWRHLfWJP7tv6avD5uaJzGo1sNihx0AL
         w9CUjtKF+p7PahyjiEZAylJIu42v9CyRMByTsatSHNV/44QfKHvFAP0J05DsuMzh8sv3
         1X3kvTa32dhU4GW5lFMmqckRmC3EJdRWR/TrKkggKBc5wB6ZOArzycp40nDRMHyaKXM0
         mzhTd+sTJh8qcb4b8kt+r+VHXMPt8O9R0CajWUVbuCMSi+b4JZOpvFkOKhIqQkHMNeGR
         /bkrSeT/gTZRK8c8tXr+hr0Yf4xlUYB7rbnhMp1lQf/VJ+bZoopHTYyKYzdK+Px3WSU5
         7zaQ==
X-Gm-Message-State: ACrzQf0gnH744xAxYzNQ/PJNE4gVKrAtTrsYUvrOVOKYOfX5hOAi8for
	SgtdAHzubswKoYo+mO/40cGjdA==
X-Google-Smtp-Source: AMsMyM5Rm9HIrz8bymvsH/euOjrFQJ4/XBJHdRa6nFHuOBrWJvQLmhDheo/pfwZ79K47Gzo473rdQw==
X-Received: by 2002:aa7:8c4e:0:b0:54e:fa98:5031 with SMTP id e14-20020aa78c4e000000b0054efa985031mr29740531pfd.44.1664293002852;
        Tue, 27 Sep 2022 08:36:42 -0700 (PDT)
Received: from C02F63J9MD6R.bytedance.net ([61.120.150.77])
        by smtp.gmail.com with ESMTPSA id w16-20020aa79a10000000b0053639773ad8sm1933087pfj.119.2022.09.27.08.36.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Sep 2022 08:36:42 -0700 (PDT)
From: Zhuo Chen <chenzhuo.1@bytedance.com>
To: bhelgaas@google.com,
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
Subject: [PATCH v2 3/9] NTB: Change to use pci_aer_clear_uncorrect_error_status()
Date: Tue, 27 Sep 2022 23:35:18 +0800
Message-Id: <20220927153524.49172-4-chenzhuo.1@bytedance.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20220927153524.49172-1-chenzhuo.1@bytedance.com>
References: <20220927153524.49172-1-chenzhuo.1@bytedance.com>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Status bits for ERR_NONFATAL errors only are cleared in
pci_aer_clear_nonfatal_status(), but we want clear uncorrectable
error status in idt_init_pci(), so we change to use
pci_aer_clear_uncorrect_error_status().

Signed-off-by: Zhuo Chen <chenzhuo.1@bytedance.com>
---
 drivers/ntb/hw/idt/ntb_hw_idt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
index 0ed6f809ff2e..d5f0aa87f817 100644
--- a/drivers/ntb/hw/idt/ntb_hw_idt.c
+++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
@@ -2657,8 +2657,8 @@ static int idt_init_pci(struct idt_ntb_dev *ndev)
 	ret = pci_enable_pcie_error_reporting(pdev);
 	if (ret != 0)
 		dev_warn(&pdev->dev, "PCIe AER capability disabled\n");
-	else /* Cleanup nonfatal error status before getting to init */
-		pci_aer_clear_nonfatal_status(pdev);
+	else /* Cleanup uncorrectable error status before getting to init */
+		pci_aer_clear_uncorrect_error_status(pdev);
 
 	/* First enable the PCI device */
 	ret = pcim_enable_device(pdev);
-- 
2.30.1 (Apple Git-130)

