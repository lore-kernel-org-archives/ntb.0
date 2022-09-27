Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02990440E
	for <ntb@lists.linux.dev>; Tue, 27 Sep 2022 15:37:19 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id g1-20020a17090a708100b00203c1c66ae3so10438974pjk.2
        for <ntb@lists.linux.dev>; Tue, 27 Sep 2022 08:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=AFdCbuK2STwU1a0Nvf1lTDCDj1ToB//H9Q+bBUP1Qko=;
        b=NvRgdBCT61Gudxqofirgx5th8IhGdXVH8ploDF6qA3ooguYlkZg71QV76whvsg9N6l
         R4KzgPkWN0h5/4Wa+jfAUT3X64/ZrWIc657LewcLsRa8odQNcnMLsWGTFDRG8vyEoBXq
         TJavhn1JY3shjpKopxaVJH4TRh6fLbyxkkYpmDlWls5S86f+jRYvc4HcSKwwjuTZetKu
         nRDD15OmlhogeMrBS17ayxlWc9/04/Cg6th9rUmLkxtuPjumSS559ESr/I/y3Z9c7fIn
         wpKIHX66ByA5ce2JXGh+pHeaqv7pxm0/5tBguNnJcxWHUMej+FaDDZah39r9lluVzFcQ
         XCgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=AFdCbuK2STwU1a0Nvf1lTDCDj1ToB//H9Q+bBUP1Qko=;
        b=8DcN8sv1FYKwFXr1xcdl90ztGdR0/zpEXe+7ej6psadUDl1bKX2e9GGtaintW/Tnad
         WoDlL+xweAFHHwR30PM/OHCWioYJnze03Xasuc/uQKmB3mkrl67yuBtbG2TOAzNz+0W7
         MXuaLrn+slxdgmZpL5pLPCmBCPbXh40sizLV8TmEqWV2RI/4TdB5klViwB0dpf58ely4
         ZzyyynYMQryHFDRb+/N+WUwvAVR41gNyBaksaHX3xtMJLscfQ95TBcTQYz8sXjlnmBPS
         FEiKG4k8fYI8l9YXxY0OLAAK0I1czXRqzLiNFzRcbUCPVWhp07796sgux+NALF1Vj079
         qcwA==
X-Gm-Message-State: ACrzQf2yxvGGFJOoIrU2XYqK9kHgxck2z3uVIA9eoBkEOY8gPw99KWFp
	JfPU5E53LH5Fck34kTm6onv+DA==
X-Google-Smtp-Source: AMsMyM5jyEmlaQH+Y1BsFMdvCalgfAKFQCnd9GdR1AeXlRDMfov29pS4+9anTO+gz3gmL+s4K9nTMQ==
X-Received: by 2002:a17:90a:6405:b0:203:6eaa:4999 with SMTP id g5-20020a17090a640500b002036eaa4999mr5266575pjj.8.1664293039489;
        Tue, 27 Sep 2022 08:37:19 -0700 (PDT)
Received: from C02F63J9MD6R.bytedance.net ([61.120.150.77])
        by smtp.gmail.com with ESMTPSA id w16-20020aa79a10000000b0053639773ad8sm1933087pfj.119.2022.09.27.08.37.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Sep 2022 08:37:19 -0700 (PDT)
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
Subject: [PATCH v2 8/9] PCI/ERR: Clear fatal status when pci_channel_io_frozen
Date: Tue, 27 Sep 2022 23:35:23 +0800
Message-Id: <20220927153524.49172-9-chenzhuo.1@bytedance.com>
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

When state is pci_channel_io_frozen in pcie_do_recovery(),
the severity is fatal and fatal status should be cleared.
So we add pci_aer_clear_fatal_status().

Signed-off-by: Zhuo Chen <chenzhuo.1@bytedance.com>
---
 drivers/pci/pcie/err.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index f80b21244ef1..b46f1d36c090 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -241,7 +241,10 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	pci_walk_bridge(bridge, report_resume, &status);
 
 	pcie_clear_device_status(dev);
-	pci_aer_clear_nonfatal_status(dev);
+	if (state == pci_channel_io_frozen)
+		pci_aer_clear_fatal_status(dev);
+	else
+		pci_aer_clear_nonfatal_status(dev);
 
 	pci_info(bridge, "device recovery successful\n");
 	return status;
-- 
2.30.1 (Apple Git-130)

