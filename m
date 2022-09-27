Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B974440E
	for <ntb@lists.linux.dev>; Tue, 27 Sep 2022 15:36:57 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id q15-20020a17090a304f00b002002ac83485so10471097pjl.0
        for <ntb@lists.linux.dev>; Tue, 27 Sep 2022 08:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=RIt/qxR4EAUFbxZ1RMkWtn/7tkqNw/Ddhp3wGfxncRU=;
        b=Wsp7XHabqPR9cfN47YLDb5kP/+DtTWVPXDtUDkStJwV2rn/HziBanxswpSDmdcRLKo
         Dq48tAVzMZp92d4f2AamMdyY8zGEbeQXB6tLxpaB6Y6Wy1VanyBKBfRP9VCLyZAejQ5Y
         a93f5ZK+7C25YS/LlQfWf06VDV3NKB5Luu1bvtlF6PZbg7BkbqtGZsqyim91FVKC6lEU
         8muWZi3OdBTxGXgk0JYE5D0t+53+wm9AL7EvbMtB88Dvaw6MIid+MhOhPoX9yA5NOz7c
         BbZqCnkgyhan4o2ymTMZOD6XQFYA38i8N4n3lHJDN4qromb5YDGrzMTLjyHVlIv8DDnB
         2DOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=RIt/qxR4EAUFbxZ1RMkWtn/7tkqNw/Ddhp3wGfxncRU=;
        b=Y8/YZ6DlCG5QwyAvZUyG4FjQUqEYI6ceAJanEzhY8kyRkgaG3gJf7yiLmsBdS6Rsm/
         vpTIEio4kzXe4J5B6ii+/3rjPRmPK6cczYixpA+4ESoZUK2fj5gUbax5lqqYcdHTkoOm
         LkW5ZQfjOGU6iWvZnGlcfLnTa4wR24EBcT/jtKV7lhis0jgWaiyZXGzbXrd0b8Mjh81t
         j3yWRQWSJxXEiBSd2zQvqETlECIQacdqRbYsIpjNRfpfRK0E7aNlnVluBFeVCMm/CmaV
         7fX/Fe3mj9SChBLl3K9cvEADiKHxCp+1ha/Vd5s7y06P/WC6sSDUnNzGuGWcdacm817o
         n91w==
X-Gm-Message-State: ACrzQf0U0Og7AoZcyOpgS1Zm+t9D35RKgKRLYjELJPfN1NvBI2+kU4gq
	Uw60DAxoCA5StY9ReN9BT7706w==
X-Google-Smtp-Source: AMsMyM4PN/sa9EbDRewn4uJ6KiQJHc76Hv5S3W7v3hjUMHPJa2uK3esBhbriqEzLGCbP+ZwPX9ZUzw==
X-Received: by 2002:a17:902:8214:b0:178:95c9:bd5d with SMTP id x20-20020a170902821400b0017895c9bd5dmr28462138pln.106.1664293017089;
        Tue, 27 Sep 2022 08:36:57 -0700 (PDT)
Received: from C02F63J9MD6R.bytedance.net ([61.120.150.77])
        by smtp.gmail.com with ESMTPSA id w16-20020aa79a10000000b0053639773ad8sm1933087pfj.119.2022.09.27.08.36.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Sep 2022 08:36:56 -0700 (PDT)
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
Subject: [PATCH v2 5/9] PCI/AER: Unexport pci_aer_clear_nonfatal_status()
Date: Tue, 27 Sep 2022 23:35:20 +0800
Message-Id: <20220927153524.49172-6-chenzhuo.1@bytedance.com>
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

Since pci_aer_clear_nonfatal_status() is used only internally, move
its declaration to the PCI internal header file. Also, no one cares
about return value of pci_aer_clear_nonfatal_status(), so make it void.

Signed-off-by: Zhuo Chen <chenzhuo.1@bytedance.com>
---
 drivers/pci/pci.h      | 2 ++
 drivers/pci/pcie/aer.c | 7 ++-----
 include/linux/aer.h    | 5 -----
 3 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 785f31086313..a114175d08e4 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -684,6 +684,7 @@ void pci_aer_init(struct pci_dev *dev);
 void pci_aer_exit(struct pci_dev *dev);
 extern const struct attribute_group aer_stats_attr_group;
 void pci_aer_clear_fatal_status(struct pci_dev *dev);
+void pci_aer_clear_nonfatal_status(struct pci_dev *dev);
 int pci_aer_clear_status(struct pci_dev *dev);
 int pci_aer_raw_clear_status(struct pci_dev *dev);
 #else
@@ -691,6 +692,7 @@ static inline void pci_no_aer(void) { }
 static inline void pci_aer_init(struct pci_dev *d) { }
 static inline void pci_aer_exit(struct pci_dev *d) { }
 static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
+static inline void pci_aer_clear_nonfatal_status(struct pci_dev *dev) { }
 static inline int pci_aer_clear_status(struct pci_dev *dev) { return -EINVAL; }
 static inline int pci_aer_raw_clear_status(struct pci_dev *dev) { return -EINVAL; }
 #endif
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 4e637121be23..e2ebd108339d 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -251,13 +251,13 @@ int pci_disable_pcie_error_reporting(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_GPL(pci_disable_pcie_error_reporting);
 
-int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
+void pci_aer_clear_nonfatal_status(struct pci_dev *dev)
 {
 	int aer = dev->aer_cap;
 	u32 status, sev;
 
 	if (!pcie_aer_is_native(dev))
-		return -EIO;
+		return;
 
 	/* Clear status bits for ERR_NONFATAL errors only */
 	pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, &status);
@@ -265,10 +265,7 @@ int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
 	status &= ~sev;
 	if (status)
 		pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, status);
-
-	return 0;
 }
-EXPORT_SYMBOL_GPL(pci_aer_clear_nonfatal_status);
 
 void pci_aer_clear_fatal_status(struct pci_dev *dev)
 {
diff --git a/include/linux/aer.h b/include/linux/aer.h
index 154690c278cb..f638ad955deb 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -44,7 +44,6 @@ struct aer_capability_regs {
 /* PCIe port driver needs this function to enable AER */
 int pci_enable_pcie_error_reporting(struct pci_dev *dev);
 int pci_disable_pcie_error_reporting(struct pci_dev *dev);
-int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
 int pci_aer_clear_uncorrect_error_status(struct pci_dev *dev);
 void pci_save_aer_state(struct pci_dev *dev);
 void pci_restore_aer_state(struct pci_dev *dev);
@@ -57,10 +56,6 @@ static inline int pci_disable_pcie_error_reporting(struct pci_dev *dev)
 {
 	return -EINVAL;
 }
-static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
-{
-	return -EINVAL;
-}
 static inline int pci_aer_clear_uncorrect_error_status(struct pci_dev *dev)
 {
 	return -EINVAL;
-- 
2.30.1 (Apple Git-130)

