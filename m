Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C911F38422E
	for <ntb@lists.linux.dev>; Fri, 24 Apr 2026 09:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777022632; cv=none; b=epfpalpnXROUgj1iRO96A8wJ9RDV8YbZKzi0QBFu/KsctbGIKACST3KKOc03USansPzszE5RNM4FktJgEUSFnnjMQ1W08+PxpZ2SCqKIh/QyLaxJO58Ay8MeA/a8RmzK8gBdYrIMsxAthVlo/D7zBG5YSSWwCgBXLisak43zRmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777022632; c=relaxed/simple;
	bh=/SUBSuk+SDC4GASHaWbhSGL6TnOTTOKiHU48wlDRCnE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Apfh2cdLiVwqkUAyobBdWyZkjZSdFOdohjrXRGvHU6h175wOUlazTdFcAEH4OS5b+98lFMBjg9/ICHTi6hNrv2BGnLCnKSH+TG53GQpUxLSVry2XE7LHevlDcNoFxsLdaaKB+2LGARN3CWUPlWAnYfkYAHWkLY4M4uXyr8OBCMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ipa3Zo/u; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ipa3Zo/u"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-50fb1932b62so35120591cf.2
        for <ntb@lists.linux.dev>; Fri, 24 Apr 2026 02:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777022630; x=1777627430; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ngbszeOkNODL28DsRhILz9Ks1a8MdcqJNW+bjGsrVkE=;
        b=ipa3Zo/uTtrr01PoAjwnPn84N9yvsAIIAlVC4lRqpqZkWmk1aiehs3ROf0nKYfsNkE
         W1ZgTDCjNMNXztvejPc0ZeZDcamFSALEwHDpp7UVZqaGvg30iySaIsoBKR0CDCLt2cYd
         U3yhEvWfWSJK9sPYgySXiygGu5vSMBqVEFrrHoBBhuHtJ63bAd8moEDwWh0eV+LH/hGD
         Sm8hI3btLLDTbjj2MHoK8zBCaWgKKVATAU0+MKHPJO0GW0rYhxD54Y3t46E1kE3lQv0K
         CX2ZqaGjR66ojZstXjIkmN0XrESoHW8MvlxsL5jG4wUTR8dJyvEs+l8OITV6TMvZn9Yn
         zR2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777022630; x=1777627430;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ngbszeOkNODL28DsRhILz9Ks1a8MdcqJNW+bjGsrVkE=;
        b=EcPpocp3CcPNtfFq9M6yT+4OhUFo+N45x6EFaDxF+NwdTyljNNjlNV+LIPgYtjfFL5
         h0DiP53B/c5tvO+9INJc7fgLgZRKrSKTcFSDR4oBMWJJAPQ09a9CfBiAueXRwozKUPAm
         VvdAnpSF9wKRCJnb0Q7ofBGJxMOkrVRR0Pi1lPG9HGoI7LbPKwKRbHF+XBQr47P/lduR
         JRVKN79qAkzMpzB7XcTFxoO79xvlPXP4g/GOJNbsgoo+HLYOcuG3u+cTMeTU5EFtbJp3
         7uBZ3OoctOw4is3Ex6JTL4jb8V8R3mi0U5q6tIC1TVp+SpkWRoWMdqOhQW1jKP4yLZHT
         1mvQ==
X-Gm-Message-State: AOJu0YwjCf1Ob20+MF4Ur/XdpbKzLGjPRPXrwYgf8WQJg8zk7Ut0Jyie
	IdoBXkP9ULnUDrEuNrVg8RLINc8wRZx3Q3f+4gcaMubwFSuqL0IbRQw3
X-Gm-Gg: AeBDievMC8sgVW1hH2OTOFvNcrMVkU37HUqAZBLlzO+kSPIWG0igJrl0h9dQHM2WbrK
	4pUTdjleqkm9lVFoQT1CXrJj/JQmNZhxVXsyhmXlhHRXAHJtSIm+7nvFZR/APUqfdnBb1y3+R0M
	e7Bd7TocnjIBswaCJSiDeK2IeuPJan6WpGJYWD5R32lDq4GC6RaEcnC3ceYJS/vyhFIsFvxsAZR
	tMvk2plb6mWTpYtj5LaEB6GTfirAzE76do/aFDZrl1l35HqCeojr3jDer6f+9KZWXXEBNDgWWhn
	Z9gFRk5UzA6XMAKm0tuOwYYnU7ZCSuGd4iKbenO8N+ETR+c/CY7Rh3vO6jkEY9Sq8efkf5/ivyV
	bRe07kkxTINz4QAlTDdz/H/dFpPzu1L7MYSSfC/n614f8XkAQKaYlnUlvjyi8AAiLVhaoHlXFJP
	R6F5+qEs0qQlZLDvy93uteE6sWGEo+F2KoV7+a
X-Received: by 2002:ac8:5e49:0:b0:50f:ca25:fb45 with SMTP id d75a77b69052e-50fca260350mr110587411cf.8.1777022629540;
        Fri, 24 Apr 2026 02:23:49 -0700 (PDT)
Received: from xa-004773.. ([160.22.157.50])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e393ff941sm186022941cf.19.2026.04.24.02.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 02:23:49 -0700 (PDT)
From: Xingbang Liu <liu.airalert@gmail.com>
To: jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com
Cc: ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Xingbang Liu <liu.airalert@gmail.com>
Subject: [PATCH v1] ntb_transport: replace wmb() with dma_wmb() in TX paths
Date: Fri, 24 Apr 2026 17:23:40 +0800
Message-Id: <20260424092340.3792297-1-liu.airalert@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TX paths currently use wmb() after memcpy_toio() to ensure that
writes to the peer memory window are visible before subsequent
notification.

The actual ordering requirement is to ensure that data written to the
peer memory is observed before the associated notification or status
update. This matches the semantics of dma_wmb(), which orders memory
writes with respect to external observers.

The peer memory window is mapped with ioremap_wc(), allowing
write-combining. On weakly ordered architectures such as arm64,
dma_wmb() ensures that prior writes are committed from write-combining
buffers and become visible to the peer before subsequent operations.

This aligns with common patterns in PCIe-based drivers, where it is
used to order descriptor or payload writes before notification, while
avoiding the stronger ordering semantics of wmb().

The ordering with respect to peer observation is completed by the
subsequent notification mechanism.

No functional change is intended.

Signed-off-by: Xingbang Liu <liu.airalert@gmail.com>
---
 drivers/ntb/ntb_transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 7cabc82305d6..c8ef46ddcc57 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -1791,7 +1791,7 @@ static void ntb_memcpy_tx_on_stack(struct ntb_queue_entry *entry, void __iomem *
 #endif
 
 	/* Ensure that the data is fully copied out before setting the flags */
-	wmb();
+	dma_wmb();
 
 	ntb_tx_copy_callback(entry, NULL);
 }
-- 
2.34.1

