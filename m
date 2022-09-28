Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941FD7B
	for <ntb@lists.linux.dev>; Wed, 28 Sep 2022 11:00:29 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id q9so11877317pgq.8
        for <ntb@lists.linux.dev>; Wed, 28 Sep 2022 04:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=TvC/ALrxAJSA8jgElYrPaDlRpGjWvJ+S5PU3u9AGQW0=;
        b=wC+q4gRayIrrojd5NNz/4k7eSkzCZifqS791bKfvn1KPZjMCq4khGbNFBM+HJO9Moh
         SDZIxqn2z1ZKYCLxC+8vBo+XConeT223VVXe2zkEJ3WNxA47YbRu87WrN1Xu0y76Y4XU
         WHH7KC6eNBVqibeF+Y+M7JWgrw0pPmjVRDWLSvzU2XUb5Jm/cJSyUSwvOmgOhPEiNOTS
         jHAY5J9OTHvpi4EMLOq6zkJ+Al16ABpJ0+awGZonyn0TdixlwEhZzu/OtcwnRHT2Chr/
         tyDl8tzD+WlEFr9PKwgHpJyh5RB/1G1+t7YHi3WFxpkjrrCGfOTY216lm4YjBX6ZrOfK
         bqpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=TvC/ALrxAJSA8jgElYrPaDlRpGjWvJ+S5PU3u9AGQW0=;
        b=a8/c/q8f+P/XxpshAVxfBNd9igJh/nEhjI1h1SdQ1Qb7jY632gC8DNsTbM/M3VOVt4
         agvM41o3PK+4+RMEA26B6bMrGYysdWr1ER8wB079AaGQGvV8xXSBVFzcab/69kvaWNUh
         3+u/0zIRMYt9On5wunzc4s2IUnE+FIzIgbY1e4MTjO4cNll9gXELy1rj/fAES8gKiR2+
         1ARdOrGLulMH8KRKd5sPiRHzrQMwpgMdPDI7hmwK+iVsw/8Mj0uDgrhCfBBWhSnYgB9d
         nHum3QfDnKWkP3TTr7wynSO9plAFN7Yxd51HrsvILy/5A/Eiaddziqw7LUOGa8hlX8Y8
         1TOw==
X-Gm-Message-State: ACrzQf3DenCcR7e4hN+/qAzfazGBcYIsrJ4YtIsrjmtJOn4KdQNBBgcr
	S/COYrYTUHC+D7k2iREWWEhRjw==
X-Google-Smtp-Source: AMsMyM7bWfktbsleKoDwZH3+i0nno4js4FOHZ9d6s4pKKsRup/J0ok5b6UIhDd+31p7y1B8DxaaKWg==
X-Received: by 2002:a63:4408:0:b0:439:befa:3d47 with SMTP id r8-20020a634408000000b00439befa3d47mr27860398pga.64.1664362829108;
        Wed, 28 Sep 2022 04:00:29 -0700 (PDT)
Received: from C02F63J9MD6R.bytedance.net ([61.120.150.77])
        by smtp.gmail.com with ESMTPSA id b13-20020a170902d50d00b00177efb56475sm1539524plg.85.2022.09.28.04.00.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Sep 2022 04:00:28 -0700 (PDT)
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
Subject: [PATCH v3 4/9] scsi: lpfc: Change to use pci_aer_clear_uncorrect_error_status()
Date: Wed, 28 Sep 2022 18:59:41 +0800
Message-Id: <20220928105946.12469-5-chenzhuo.1@bytedance.com>
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

lpfc_aer_cleanup_state() requires clearing both fatal and non-fatal
uncorrectable error status. But using pci_aer_clear_nonfatal_status()
will only clear non-fatal error status. To clear both fatal and
non-fatal error status, use pci_aer_clear_uncorrect_error_status().

Signed-off-by: Zhuo Chen <chenzhuo.1@bytedance.com>
---
 drivers/scsi/lpfc/lpfc_attr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_attr.c b/drivers/scsi/lpfc/lpfc_attr.c
index 09cf2cd0ae60..d835cc0ba153 100644
--- a/drivers/scsi/lpfc/lpfc_attr.c
+++ b/drivers/scsi/lpfc/lpfc_attr.c
@@ -4689,7 +4689,7 @@ static DEVICE_ATTR_RW(lpfc_aer_support);
  * Description:
  * If the @buf contains 1 and the device currently has the AER support
  * enabled, then invokes the kernel AER helper routine
- * pci_aer_clear_nonfatal_status() to clean up the uncorrectable
+ * pci_aer_clear_uncorrect_error_status() to clean up the uncorrectable
  * error status register.
  *
  * Notes:
@@ -4715,7 +4715,7 @@ lpfc_aer_cleanup_state(struct device *dev, struct device_attribute *attr,
 		return -EINVAL;
 
 	if (phba->hba_flag & HBA_AER_ENABLED)
-		rc = pci_aer_clear_nonfatal_status(phba->pcidev);
+		rc = pci_aer_clear_uncorrect_error_status(phba->pcidev);
 
 	if (rc == 0)
 		return strlen(buf);
-- 
2.30.1 (Apple Git-130)

