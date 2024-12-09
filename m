Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAD9230D1F
	for <ntb@lists.linux.dev>; Mon,  9 Dec 2024 13:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733749628; cv=none; b=NYtiplzymg6hRBH34U3UBAziIC0qO2omIkQnrfiv8AiEdnSwni58LehZuUpfY4E+MtGoZU2cYviY+MG04PnGAbtixEm47cSmGyQWD7GYeeTpg53AYSvF76XTVSHgBUnDjTlT5jOF8fmO3jBNBVp387G8T26JKrNiJW0DE7lQYP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733749628; c=relaxed/simple;
	bh=MrbDrpIsvZ1dKVLDYervP0Vycy2eBw/58VpDKwA2pz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=r++GuReIIr/F6fRO1yH62dHRhlPf316oU3pxRkzPMmSwbgJp9XL7BmPvfjFtCGK1oehdX3MtuaNW9zUEI3B1bxMwtc+TLCUerN893jPjIw05E9GDkcNDSjTDcPoGtlrUNhSKTooa2bG3UjO2bG4NDen/RPh2HGQiW3gHO3rC3GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FQQGU/eL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FQQGU/eL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733749619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jVrHbQL/WtPUoVmg5iNOH6KPahEUlaDR0JYKoVLlaPE=;
	b=FQQGU/eLyXeosp5gHBq1ad4KTyJhj28poXUFVI/N7vwfJf7nOgnTONQORJ4puWZLAkZ6DX
	schHeQIxcksso3yrl+INtDimcnUWXCyng/KFahEmzoUiYZLBiSXiR3FjYKFbZbNFQ3WOZw
	zG9E3ixvaYnrnp4GVXzwpImEd2WY6jY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-MVmN-DUuNjiBbhDC3LaQDA-1; Mon, 09 Dec 2024 08:06:56 -0500
X-MC-Unique: MVmN-DUuNjiBbhDC3LaQDA-1
X-Mimecast-MFC-AGG-ID: MVmN-DUuNjiBbhDC3LaQDA
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-434f47b0512so8002035e9.2
        for <ntb@lists.linux.dev>; Mon, 09 Dec 2024 05:06:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733749615; x=1734354415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jVrHbQL/WtPUoVmg5iNOH6KPahEUlaDR0JYKoVLlaPE=;
        b=kxGNOz0735r3xegSlrHHAJbw9SCJTqfjtv63Ai2Adt/M6mL/kQtgomIu65GdH++pZJ
         EIQ9wQ+30Ob58jjH/5uF9QtHDPfC6e4idubVHJvgfjw6v+shJbLyYVuIgbh3gSEyyxtK
         GUJzIO2XqXu/uDIkYc7cnRHh9y8kSSD1WeWiezIVUMAkzDR3T4hPxZhYa4g8XKN3KJNU
         DkvDwZEMY3zYUQ9HAG2ZOdQEkmYbqWk5+gJ+VW6Qf1INmgIhxVSAaoCrIjM7RRrBSd50
         eFxX/jZZTwzPEKyxvvo/VoMALON89s4I4la7Wyra746xhdo8FaSAX6xkU4vH2LsIRxKC
         YM1g==
X-Forwarded-Encrypted: i=1; AJvYcCWegIqcPyx0rjp+6AZa7292XheI1JooDFoCcp6cHfcYnema3pdYgkU2hiVPxk8E+GPh0/w=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx7oCPRWATj0NwWrKFHduAxZ5oX6xZGb8O3LiZ6lcmH3lvG9Ps3
	inkuouIXO6EYRhrKvhNEn/jamsxH/RxA6BqkLDyz7a43/jFg6w7CeEhvYBsFvlxp3vVsJg4cjQ3
	9ct1LqW5gM2lsXDC34q1phPvsmtgQWqsjFEf1eZH8bz2W6Hv57w==
X-Gm-Gg: ASbGncueIeKLbIuR8g82IOYzgMRgmOJmHqIObtpxOUXT0vOjwMkzu+4GluDBb0LK4IA
	d2bJUh/fgJWL9zbb/n9dtC6d1DlphGur3raV2IL/5uoAF8BV3o+yRdxrhqsMWIIRBH2KB1/TBZE
	hk0LDHURtAZuwSOp9VIlju+FxGFjVa56rkmTWxmr1TqDqUWx62+EpCbonzThGMs6Hg54xsmR0g4
	nGOPCkKKrDo4LCIHcboqn2ocMda1weKBv214cdVIwLqhvrhENGxk/lva/4T0bLQnBYWxoGD1p3E
	GLd8+Sd1
X-Received: by 2002:a05:600c:3544:b0:431:60ec:7a91 with SMTP id 5b1f17b1804b1-434ddeade70mr103095295e9.2.1733749615444;
        Mon, 09 Dec 2024 05:06:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8dWBtsXMwPpsQh4FEW+o80sVo3gsVutdK8rZwCICXTNWn24DfDXUekpZhDfdomYwt5/+rkA==
X-Received: by 2002:a05:600c:3544:b0:431:60ec:7a91 with SMTP id 5b1f17b1804b1-434ddeade70mr103094435e9.2.1733749614932;
        Mon, 09 Dec 2024 05:06:54 -0800 (PST)
Received: from eisenberg.redhat.com (nat-pool-muc-u.redhat.com. [149.14.88.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3862190965asm13200127f8f.82.2024.12.09.05.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 05:06:54 -0800 (PST)
From: Philipp Stanner <pstanner@redhat.com>
To: amien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Basavaraj Natikar <basavaraj.natikar@amd.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alex Dubov <oakad@yahoo.com>,
	Sudarsana Kalluru <skalluru@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rasesh Mody <rmody@marvell.com>,
	GR-Linux-NIC-Dev@marvell.com,
	Igor Mitsyanko <imitsyanko@quantenna.com>,
	Sergey Matyukevich <geomatsi@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sanjay R Mehta <sanju.mehta@amd.com>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Chen Ni <nichen@iscas.ac.cn>,
	Philipp Stanner <pstanner@redhat.com>,
	Ricky Wu <ricky_wu@realtek.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Breno Leitao <leitao@debian.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Kevin Tian <kevin.tian@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mostafa Saleh <smostafa@google.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Yi Liu <yi.l.liu@intel.com>,
	Kunwu Chan <chentao@kylinos.cn>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Eric Auger <eric.auger@redhat.com>,
	Ye Bin <yebin10@huawei.com>
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	kvm@vger.kernel.org,
	xen-devel@lists.xenproject.org
Subject: [PATCH v3 04/11] net/ntb: Use never-managed version of pci_intx()
Date: Mon,  9 Dec 2024 14:06:26 +0100
Message-ID: <20241209130632.132074-6-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241209130632.132074-2-pstanner@redhat.com>
References: <20241209130632.132074-2-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2H5WnIOVIZVZhQlxjcXf6Ds0IaZ29YeYnnS5725nhDQ_1733749615
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

pci_intx() is a hybrid function which can sometimes be managed through
devres. To remove this hybrid nature from pci_intx(), it is necessary to
port users to either an always-managed or a never-managed version.

hw/amd and how/intel enable their PCI-Device with pci_enable_device().
Thus, they need the never-managed version.

Replace pci_intx() with pci_intx_unmanaged().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Acked-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com> #for ntb_hw_amd.c
Acked-by: Dave Jiang <dave.jiang@intel.com> # for ntb_hw_gen1.c
---
 drivers/ntb/hw/amd/ntb_hw_amd.c    | 4 ++--
 drivers/ntb/hw/intel/ntb_hw_gen1.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index d687e8c2cc78..b146f170e839 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -791,7 +791,7 @@ static int ndev_init_isr(struct amd_ntb_dev *ndev,
 err_msi_enable:
 
 	/* Try to set up intx irq */
-	pci_intx(pdev, 1);
+	pci_intx_unmanaged(pdev, 1);
 
 	rc = request_irq(pdev->irq, ndev_irq_isr, IRQF_SHARED,
 			 "ndev_irq_isr", ndev);
@@ -831,7 +831,7 @@ static void ndev_deinit_isr(struct amd_ntb_dev *ndev)
 		if (pci_dev_msi_enabled(pdev))
 			pci_disable_msi(pdev);
 		else
-			pci_intx(pdev, 0);
+			pci_intx_unmanaged(pdev, 0);
 	}
 }
 
diff --git a/drivers/ntb/hw/intel/ntb_hw_gen1.c b/drivers/ntb/hw/intel/ntb_hw_gen1.c
index 079b8cd79785..9ad9d7fe227e 100644
--- a/drivers/ntb/hw/intel/ntb_hw_gen1.c
+++ b/drivers/ntb/hw/intel/ntb_hw_gen1.c
@@ -445,7 +445,7 @@ int ndev_init_isr(struct intel_ntb_dev *ndev,
 
 	/* Try to set up intx irq */
 
-	pci_intx(pdev, 1);
+	pci_intx_unmanaged(pdev, 1);
 
 	rc = request_irq(pdev->irq, ndev_irq_isr, IRQF_SHARED,
 			 "ndev_irq_isr", ndev);
-- 
2.47.1

