Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964CC7B
	for <ntb@lists.linux.dev>; Wed, 28 Sep 2022 11:00:07 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id n7so2736885plp.1
        for <ntb@lists.linux.dev>; Wed, 28 Sep 2022 04:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=/lUorqWHVGRnAT88EYIdYelQLnJZ6JU0rZvIuXw4R/I=;
        b=eFgcRFG8rZyt+ZzLjBVqt80mtlecZJilGFgBqp58JU1Th4+tjpU45u+gTrJURz6bU5
         PZAKAIfYGUPeGJVCZmJg3vuzIfVwjnpOKC5ZUeOa4l5p7zXBugRQL+YNsLY/0707Lyn9
         +qi4Uy0poKd8Sa4di3uUH+bWu2LaE4sKFOthWF/BkPiaa60pme+zM70DdJ8bi5BHQRrd
         zTgZFxfVJ1KS7X/LARzkICgCaD/+fH3z7w2NTbKIQJuAcpKztxzFV3FqhvJxhvv9Ztsp
         m+we2ILuvR+mw7GbnzjEDY/mut4/9s5b7+B54gO+wZHygWoM1S92vyJYtTH4k9+Pr7DT
         h49g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=/lUorqWHVGRnAT88EYIdYelQLnJZ6JU0rZvIuXw4R/I=;
        b=AkY0yMSJfgiTBU6tjVamTVU8fF0waq5c5XDEu3LUN3Zz3soBcVGL9TnZzug3Gs3qcn
         DkOfeOIIncxYmW/LeBrWC7wUnH9+WS02LYsWSVnM/gDAa3O9CDq/EfoSZKa0AIGW9GIo
         EiDxmZvFAXYG4f35tsJG8gOc++lzmecetBqDKKfAeiSi3l40jqArCX3XJQrg7RV923M/
         XYysfGqgZyn2wYNmZPHclUEFRGtSSeanPhrmyHcLsvwlRiwdSVWUn2LPvvqt1yz+1w3L
         CXjQQyheh2l9tI5ih62nbNuKhCUQS4Jlkdnff7Pi5Cj+XVBDCFwMg8S3F4pnajVIilqQ
         Ztbw==
X-Gm-Message-State: ACrzQf0uv8vIV2LrZ+wa4SB/WLoMlAdS2iTPYNO/ccR05T5Qwu16ipBj
	6FzOUyqamzOIfXT40Q6vfMgG9A==
X-Google-Smtp-Source: AMsMyM7nBvyxUePl2eO0BDL+QbLpFrILFxB/8WP0FtnmYokq9Cgk3HqUDyZWcIKuWIYPint1G/hLIg==
X-Received: by 2002:a17:902:e154:b0:17a:606:6431 with SMTP id d20-20020a170902e15400b0017a06066431mr1417596pla.107.1664362806820;
        Wed, 28 Sep 2022 04:00:06 -0700 (PDT)
Received: from C02F63J9MD6R.bytedance.net ([61.120.150.77])
        by smtp.gmail.com with ESMTPSA id b13-20020a170902d50d00b00177efb56475sm1539524plg.85.2022.09.28.04.00.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Sep 2022 04:00:06 -0700 (PDT)
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
Subject: [PATCH v3 1/9] PCI/AER: Add pci_aer_clear_uncorrect_error_status() to PCI core
Date: Wed, 28 Sep 2022 18:59:38 +0800
Message-Id: <20220928105946.12469-2-chenzhuo.1@bytedance.com>
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

In lpfc_aer_cleanup_state(), uncorrectable error status needs to be
cleared, which can be done by calling pci_aer_clear_nonfatal_status()
and pci_aer_clear_fatal_status(). Meanwhile they can be combined in
one function (the same in dpc_process_error). So add
pci_aer_clear_uncorrect_error_status() function to PCI core and
export symbol to other modules which wants to use it.

Signed-off-by: Zhuo Chen <chenzhuo.1@bytedance.com>
---
 drivers/pci/pcie/aer.c | 16 ++++++++++++++++
 include/linux/aer.h    |  5 +++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index e2d8a74f83c3..4e637121be23 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -286,6 +286,22 @@ void pci_aer_clear_fatal_status(struct pci_dev *dev)
 		pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, status);
 }
 
+int pci_aer_clear_uncorrect_error_status(struct pci_dev *dev)
+{
+	int aer = dev->aer_cap;
+	u32 status;
+
+	if (!pcie_aer_is_native(dev))
+		return -EIO;
+
+	pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, &status);
+	if (status)
+		pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, status);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_aer_clear_uncorrect_error_status);
+
 /**
  * pci_aer_raw_clear_status - Clear AER error registers.
  * @dev: the PCI device
diff --git a/include/linux/aer.h b/include/linux/aer.h
index 97f64ba1b34a..154690c278cb 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -45,6 +45,7 @@ struct aer_capability_regs {
 int pci_enable_pcie_error_reporting(struct pci_dev *dev);
 int pci_disable_pcie_error_reporting(struct pci_dev *dev);
 int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
+int pci_aer_clear_uncorrect_error_status(struct pci_dev *dev);
 void pci_save_aer_state(struct pci_dev *dev);
 void pci_restore_aer_state(struct pci_dev *dev);
 #else
@@ -60,6 +61,10 @@ static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
 {
 	return -EINVAL;
 }
+static inline int pci_aer_clear_uncorrect_error_status(struct pci_dev *dev)
+{
+	return -EINVAL;
+}
 static inline void pci_save_aer_state(struct pci_dev *dev) {}
 static inline void pci_restore_aer_state(struct pci_dev *dev) {}
 #endif
-- 
2.30.1 (Apple Git-130)

