Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEEF7460
	for <ntb@lists.linux.dev>; Thu,  1 Sep 2022 18:18:01 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id i7-20020a17090adc0700b001fd7ccbec3cso6256271pjv.0
        for <ntb@lists.linux.dev>; Thu, 01 Sep 2022 11:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=3DXCPe1BdEtYuRHvCYZXZkquoUJcR5dxO1Uv98IS8Fo=;
        b=Aehod6L+M3ml0QOxN7x+0w3h0/6goHcKiCZebMRRRooSJP64c5JGUMmT0Xs0eXcJQX
         KAebQ+kqsEsjzxwwCuCi+sTSZ9ePGDRJ4Ke8LtzrvIc85ZUFTKXl6caEY+cTLN//OYSf
         0QqAgptsvqA+mNuSroupv9lAYWD/oiajx3bhNgTGjKE+5FJqGpp5hl75V/YPuX9vsEwJ
         H9pYqtwIfWdmAJsRJBDrKwHc/OkPFAj95m1JVMfBleKx9eJGlDea3htyn18Jqhle3msk
         1aFF1ndcoISes5UYjaPU1OELeWO86cea/I3zJ3XNGnx8Nc3DA33tRGi9jv4uXcMiqB7J
         p+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=3DXCPe1BdEtYuRHvCYZXZkquoUJcR5dxO1Uv98IS8Fo=;
        b=RIFIdUVj/XeimgqLmODisHW2jlP1POcBt9N5S7yiDTCS/NgewvSa/JJQ1/b6SOkTmT
         3A7lB33WzeSGNTejUOnQh7tk5q2eR97u2mJXdvjfEaHqGQ9IJk9zGAqYh6YPzUSpA02E
         AgI6HoR7lh5RH4OTluJk0DR8qK5WiETJuaOYGXrDF+39yx05+SkYFiGHFub/K4QVYjoK
         R/4TUbBg4I8ZUbLIInpS0v6BLpFBsRg2hlfTWqJo2W9EZoh7MnxRihiTAfn2zhW4q5su
         mhQNgMqf2baYPpOemxO8tgr8zjnprP23kLWZA0KfBSb2iTFFcJQKCA2dWiBDiDgCmpi9
         rPUA==
X-Gm-Message-State: ACgBeo2fIR7M1C+s45cWv6fERD3KXPgwmJM7JJLLSvfTQtu9a2BHrD2u
	WU9CwRsChLYkO7ytbQLNhGCOiA==
X-Google-Smtp-Source: AA6agR5k3r5xfxPxjuPBt32QIykPTxBunw1TVl9SKzFPTIijRtI9vvEivAH4/47P1EXXXpyDgDMWRQ==
X-Received: by 2002:a17:903:32d2:b0:172:f62a:2f33 with SMTP id i18-20020a17090332d200b00172f62a2f33mr31495269plr.16.1662056281071;
        Thu, 01 Sep 2022 11:18:01 -0700 (PDT)
Received: from C02F63J9MD6R.bytedance.net ([61.120.150.77])
        by smtp.gmail.com with ESMTPSA id b13-20020a170903228d00b0017519b86996sm6320538plh.218.2022.09.01.11.17.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Sep 2022 11:18:00 -0700 (PDT)
From: Zhuo Chen <chenzhuo.1@bytedance.com>
To: fancer.lancer@gmail.com,
	jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	bhelgaas@google.com,
	ruscur@russell.cc,
	oohall@gmail.com,
	james.smart@broadcom.com,
	dick.kennedy@broadcom.com,
	jejb@linux.ibm.com,
	martin.petersen@oracle.com
Cc: chenzhuo.1@bytedance.com,
	ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-scsi@vger.kernel.org
Subject: [PATCH 3/3] PCI/AER: Use pci_aer_raw_clear_status() to clear root port's AER error status
Date: Fri,  2 Sep 2022 02:16:34 +0800
Message-Id: <20220901181634.99591-4-chenzhuo.1@bytedance.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20220901181634.99591-1-chenzhuo.1@bytedance.com>
References: <20220901181634.99591-1-chenzhuo.1@bytedance.com>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Statements clearing AER error status in aer_enable_rootport() has the
same function as pci_aer_raw_clear_status(). So we replace them, which
has no functional changes.

Signed-off-by: Zhuo Chen <chenzhuo.1@bytedance.com>
---
 drivers/pci/pcie/aer.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index d2996afa80f6..eb0193f279f2 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1287,12 +1287,7 @@ static void aer_enable_rootport(struct aer_rpc *rpc)
 				   SYSTEM_ERROR_INTR_ON_MESG_MASK);
 
 	/* Clear error status */
-	pci_read_config_dword(pdev, aer + PCI_ERR_ROOT_STATUS, &reg32);
-	pci_write_config_dword(pdev, aer + PCI_ERR_ROOT_STATUS, reg32);
-	pci_read_config_dword(pdev, aer + PCI_ERR_COR_STATUS, &reg32);
-	pci_write_config_dword(pdev, aer + PCI_ERR_COR_STATUS, reg32);
-	pci_read_config_dword(pdev, aer + PCI_ERR_UNCOR_STATUS, &reg32);
-	pci_write_config_dword(pdev, aer + PCI_ERR_UNCOR_STATUS, reg32);
+	pci_aer_raw_clear_status(pdev);
 
 	/*
 	 * Enable error reporting for the root port device and downstream port
-- 
2.30.1 (Apple Git-130)

