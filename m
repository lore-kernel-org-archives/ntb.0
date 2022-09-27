Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4A8440E
	for <ntb@lists.linux.dev>; Tue, 27 Sep 2022 15:37:12 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id s206so9758918pgs.3
        for <ntb@lists.linux.dev>; Tue, 27 Sep 2022 08:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=u9XQU41RsTUx8hAj0GByCivfHFYNLe/LcJ7HOx2cRk8=;
        b=fsCBG+DPjSI2nTALjsV1M/duBiunTKI6jkFKOOGmtIR6r5bAo2o2uEDMVUtUArXGVW
         fTKfg77exYvCPT+Mzd0FRfvrUOIrPM0DrH3XCnFfLmLZAzuiZ2q+x3gMaVyQqyuZbgoc
         mGw37ZG9ieu06mhPTRrMnhx0rx5zACS7/QMWCatKRH3/B8MceesI9gSMJlvNlTGtys+s
         ZpK4iFTZ+b88nfx2U5yAVmqtVht2gc9J38/VXFStCvpAzAuNNnvoupyJoxQ0dC/t5q0l
         0LCVpcQakk9Ng6ATtk5ggTfQOe2Fv4tFHfwKswt99YRJayi96CpsLFwM80CWJJkYBuZB
         ajRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=u9XQU41RsTUx8hAj0GByCivfHFYNLe/LcJ7HOx2cRk8=;
        b=rT1ocjAjPbKbfHkwNquuhfPJmLMylbpjqDATMYw2HoULbi27+GyEIL0iEA6BxvXPtq
         YEjxtH4glmSLXvqd4Pt5RBd0QqhlWtcz0TEBh1RYkrdOiPSEXgbS1bE/hez3dSoYIHrT
         cxkLXPX8lkHD57n0LRRPKf/neL3X6pebFPTWGASa2tXPaAMAjPV2qsVoBHIoyZAF8/as
         znkBMTsObF29SpPR6VBt/FJ/sFjJ4tFUZ13dQ37965yWwEZNxAR6Q3v5d0i8vvPFWGl2
         JpisiDXgHD5vQuW2ZIi3+9tA29CdhyaKpXT3SFp9P/DpF68F2vAw4RFqpEdgDah2iw4B
         /Tdg==
X-Gm-Message-State: ACrzQf3LENqXDTWgbJ3gefPI0sNx6GRCtH8vLu/Sjr3F67bR2sKwOUsy
	E9eK/ElVAKGUC6gVioMOqb89GA==
X-Google-Smtp-Source: AMsMyM5AGc7YKPpik/CYAdx7+YLoe2LePT9l6+aEGScdw+MnDkvA4e2T5mugdpwTheK1NxozIxwQbQ==
X-Received: by 2002:a63:d40b:0:b0:43b:e86f:d384 with SMTP id a11-20020a63d40b000000b0043be86fd384mr24815734pgh.167.1664293032304;
        Tue, 27 Sep 2022 08:37:12 -0700 (PDT)
Received: from C02F63J9MD6R.bytedance.net ([61.120.150.77])
        by smtp.gmail.com with ESMTPSA id w16-20020aa79a10000000b0053639773ad8sm1933087pfj.119.2022.09.27.08.37.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Sep 2022 08:37:12 -0700 (PDT)
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
Subject: [PATCH v2 7/9] PCI/AER: Use pcie_aer_is_native() to judge whether OS owns AER
Date: Tue, 27 Sep 2022 23:35:22 +0800
Message-Id: <20220927153524.49172-8-chenzhuo.1@bytedance.com>
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

Use pcie_aer_is_native() in place of "host->native_aer ||
pcie_ports_native" to judge whether OS owns AER in aer_root_reset().

Replace "dev->aer_cap && (pcie_ports_native || host->native_aer)" in
get_port_device_capability() with pcie_aer_is_native(), which has no
functional changes.

Signed-off-by: Zhuo Chen <chenzhuo.1@bytedance.com>
---
 drivers/pci/pcie/aer.c          | 5 ++---
 drivers/pci/pcie/portdrv_core.c | 3 +--
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index e2320ab27a31..a6d29269ccf2 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1403,7 +1403,6 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
 	int type = pci_pcie_type(dev);
 	struct pci_dev *root;
 	int aer;
-	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
 	u32 reg32;
 	int rc;
 
@@ -1424,7 +1423,7 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
 	 */
 	aer = root ? root->aer_cap : 0;
 
-	if ((host->native_aer || pcie_ports_native) && aer) {
+	if (aer && pcie_aer_is_native(root)) {
 		/* Disable Root's interrupt in response to error messages */
 		pci_read_config_dword(root, aer + PCI_ERR_ROOT_COMMAND, &reg32);
 		reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;
@@ -1443,7 +1442,7 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
 			pci_is_root_bus(dev->bus) ? "Root" : "Downstream", rc);
 	}
 
-	if ((host->native_aer || pcie_ports_native) && aer) {
+	if (aer && pcie_aer_is_native(root)) {
 		/* Clear Root Error Status */
 		pci_read_config_dword(root, aer + PCI_ERR_ROOT_STATUS, &reg32);
 		pci_write_config_dword(root, aer + PCI_ERR_ROOT_STATUS, reg32);
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 1ac7fec47d6f..844297c0c85e 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -221,8 +221,7 @@ static int get_port_device_capability(struct pci_dev *dev)
 	}
 
 #ifdef CONFIG_PCIEAER
-	if (dev->aer_cap && pci_aer_available() &&
-	    (pcie_ports_native || host->native_aer))
+	if (pcie_aer_is_native(dev) && pci_aer_available())
 		services |= PCIE_PORT_SERVICE_AER;
 #endif
 
-- 
2.30.1 (Apple Git-130)

