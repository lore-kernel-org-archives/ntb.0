Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4CC440E
	for <ntb@lists.linux.dev>; Tue, 27 Sep 2022 15:36:33 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id v10-20020a17090a634a00b00205e48cf845so736703pjs.4
        for <ntb@lists.linux.dev>; Tue, 27 Sep 2022 08:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Q86dpO4MZD0CA12jM08xWGYyYtYWODVJgw7gnIuH5Tk=;
        b=IMIPIN6w3MO7MCbD7V3ThsGSRsp1g0IjueBKGf/11rJ6MD5qN4UR3XGmJipX9CK++6
         eiOchrYYinPyoOBn+0Y+rDP0uVRFImrpBNU1UDXtOMNUxPlRqmop3RFvpzPbyEybSG5F
         CRDPQ1enPFC99WOwYFVY2QZDmn8jSfY/zTlBpgKJUVPQ+lpJjVT0rmsBeR4eYvaQSxZK
         dvTm2obycBfI5P1tTJ+khPgiPLQGLeUoFr7m2HgOHrjHsPGgqHpQ2Yy3mDC88pmtuxyB
         YdSpANeZeOxf58GtYGN2R1FOht2o+Xmi4V/D1Ny4qiePO8a/2BpFtrT8iUKZBeNMTtOh
         RWSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Q86dpO4MZD0CA12jM08xWGYyYtYWODVJgw7gnIuH5Tk=;
        b=hkSscErYbd8cDT2wigI/xRHFvx18+6A+KAJ/ww88NhhmUHkg9ceek18tfBJbeepb8h
         x/wTIPaZvMqKAXrgkn3kEl+uBYylW+G4sPgIAZtHBm7p57VkN21jnyKVJ+RPvqhgP6xl
         IsSYrlzFgMThJyTBZLCy8bXhqOgrkGCQdHFF34oTpTeTMs/mgwyQVQaTb7SkiZj7YrX+
         LJRag224g4MfXLaIpgPxiLgKeq1swhPw2/eXEhz6/jq3KcdwbGI2Belg0lgTui0GvN2v
         dMYQQNlbpRzEQaLGsCZJJuJcUcABDVrohMh8E/lxIuPySuDrfrsZS2kUvzs0AWIi/YJ+
         eDpA==
X-Gm-Message-State: ACrzQf2jTitxRhwf1IS06CFoQMD7Da3jeZWeYky2DFBl6stNnEGn88lA
	du3LWEYozuVrQMUa9mIwXbzncQ==
X-Google-Smtp-Source: AMsMyM5RaT7WFGyUZHFYqoVH6SiLBpf6gppnLFccPidOBspFk2OpmdxZsinWDsz9SjngtrgXs1RPug==
X-Received: by 2002:a17:90b:17cf:b0:202:95a2:e310 with SMTP id me15-20020a17090b17cf00b0020295a2e310mr5447237pjb.76.1664292992706;
        Tue, 27 Sep 2022 08:36:32 -0700 (PDT)
Received: from C02F63J9MD6R.bytedance.net ([61.120.150.77])
        by smtp.gmail.com with ESMTPSA id w16-20020aa79a10000000b0053639773ad8sm1933087pfj.119.2022.09.27.08.36.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Sep 2022 08:36:32 -0700 (PDT)
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
Subject: [PATCH v2 2/9] PCI/DPC: Use pci_aer_clear_uncorrect_error_status() to clear uncorrectable error status
Date: Tue, 27 Sep 2022 23:35:17 +0800
Message-Id: <20220927153524.49172-3-chenzhuo.1@bytedance.com>
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

Use pci_aer_clear_nonfatal_status() in dpc_process_error(), which has
no functional changes.

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

