Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1184A2064EF
	for <ntb@lists.linux.dev>; Wed, 13 Nov 2024 12:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731501771; cv=none; b=DOlltx2cxqG380lrZjIFO82zJ8kMsruiTZMxGZvZDl2/sIc3pDDbEBB3RqY2kkfMJLpIhXkfhqTrcrswRLYj4xsKWCYGdi6qENxUUx+OzTSUMdiGBQ++T+8yqLyotZZ27h/iQJy7WeJgpdKyGeFkElucT/E0xG8ufFUwpxO/Vik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731501771; c=relaxed/simple;
	bh=x/7QFhAzHkLj8+w14TM+V3xJvs5L48Anth4HQxPkvDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eip6vUi0q63dDYr1sHoRhD0WaCztXvRNYTxNJHzNRhJc1QQB/eXmj7MM/gYW2miiKOZfDm1c6Ry77SzOdwcSIwQV8miXZE8in7SULVEpzSRigd92YNrcwh4UA8GuPKnW/NkaRoHwja/wyQ85VdYnQr4uVkRwq1AYoWPHA6u5O88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fa7HJCWF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fa7HJCWF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731501769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NsJKOkpA+QoYlzqeYDbY0Dl9xjdlxWNvzFNzd4dMwhk=;
	b=Fa7HJCWF8rE5j5qeyCWhKRTG+oBNwl9DxDbJpw1HTEiknASUPiWlaW1+ASdJWDGK+ocVLh
	cJSz+rkbypRD+H9NJrauuzO63XFc66sMgSUsQJSpvcaR7+nPCdxuLpveiGn/yBv3ZzQ6R/
	VzqS7cpo0YHtn2tOwgIlg96Rk44NYa4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-dFf3Hs77PSKqxWrJdAprgw-1; Wed, 13 Nov 2024 07:42:47 -0500
X-MC-Unique: dFf3Hs77PSKqxWrJdAprgw-1
X-Mimecast-MFC-AGG-ID: dFf3Hs77PSKqxWrJdAprgw
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4316655b2f1so48136495e9.0
        for <ntb@lists.linux.dev>; Wed, 13 Nov 2024 04:42:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731501766; x=1732106566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NsJKOkpA+QoYlzqeYDbY0Dl9xjdlxWNvzFNzd4dMwhk=;
        b=rMzRQuDyt1IgYRpcmGgAO0a5y4kgP1Qux61zhlXSGkCbh8arqM3VLMgd7AlwFCAx9g
         +PoQNAoE1y0FpinHWLdz/0Yghcz3gPmeaaq8NAEgHovLMwvnBDIrMrkX/N3Kl1DiKfi3
         cljPLqBjHbAjSBexVvkBI9LHxrDQQvf0bIcGEZ/me390gO1o8VJSp3FCLdvPxsoWpmTH
         kTO1g7K/sFS3VE1xUSC5LD+G1neAi29HAkdNTBZB/X+lBBofmVT1dBL60Dd8j8p4AqTh
         doEGQEY3caX/kEY/WngDqqN//ZvJtFAXHjgrATFx1kWVotVSsDpOyPxfAWflQZZVoAuj
         Dh6w==
X-Forwarded-Encrypted: i=1; AJvYcCWBkkNhAQgUMhN2zb+hGDIbHLmzBucmOGvJJru4G35BPewcCxwUvKNsuGk75WsQ4HwMyjk=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx4+KmP4VJiw1rKcmuAeAw2KEuMEb3JdHDRtJML6sDGOYHdDu4T
	VNKa3ZQSk8t8gXmUtjNKwPb2d/zM5vJ4JK1pagPVDllfImJ9DEr2zUle6pDv/mSlKYwmqiNAOU0
	gOEIBnCen628kLX7n1TLFjnabr00lv4b3NVZxunuXph6HweNX9g==
X-Received: by 2002:a5d:47ac:0:b0:37d:5282:1339 with SMTP id ffacd0b85a97d-3820df6136cmr2369021f8f.22.1731501766125;
        Wed, 13 Nov 2024 04:42:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFpjkcG3JEnob3xzqfsNCARyMkng1y9gR5mdhMcNm6Gi1JEJjom42U2s4Q7CInAPcp8pAzepA==
X-Received: by 2002:a5d:47ac:0:b0:37d:5282:1339 with SMTP id ffacd0b85a97d-3820df6136cmr2368992f8f.22.1731501765706;
        Wed, 13 Nov 2024 04:42:45 -0800 (PST)
Received: from eisenberg.redhat.com (nat-pool-muc-u.redhat.com. [149.14.88.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed99aa18sm18023528f8f.61.2024.11.13.04.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 04:42:45 -0800 (PST)
From: Philipp Stanner <pstanner@redhat.com>
To: Damien Le Moal <dlemoal@kernel.org>,
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
	Philipp Stanner <pstanner@redhat.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Chen Ni <nichen@iscas.ac.cn>,
	Ricky Wu <ricky_wu@realtek.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Breno Leitao <leitao@debian.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Mostafa Saleh <smostafa@google.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Yi Liu <yi.l.liu@intel.com>,
	Kunwu Chan <chentao@kylinos.cn>,
	Ankit Agrawal <ankita@nvidia.com>,
	Christian Brauner <brauner@kernel.org>,
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
Subject: [PATCH v2 07/11] PCI: MSI: Use never-managed version of pci_intx()
Date: Wed, 13 Nov 2024 13:41:55 +0100
Message-ID: <20241113124158.22863-9-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241113124158.22863-2-pstanner@redhat.com>
References: <20241113124158.22863-2-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WvaFq0DmE70TCauTfV98WzJ9a61_wUJP6J_zMDMEm0I_1731501766
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

pci_intx() is a hybrid function which can sometimes be managed through
devres. To remove this hybrid nature from pci_intx(), it is necessary to
port users to either an always-managed or a never-managed version.

MSI sets up its own separate devres callback implicitly in
pcim_setup_msi_release(). This callback ultimately uses pci_intx(),
which is problematic since the callback of course runs on driver-detach.

That problem has last been described here:
https://lore.kernel.org/all/ee44ea7ac760e73edad3f20b30b4d2fff66c1a85.camel@redhat.com/

Replace the call to pci_intx() with one to the never-managed version
pci_intx_unmanaged().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/pci/msi/api.c | 2 +-
 drivers/pci/msi/msi.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/msi/api.c b/drivers/pci/msi/api.c
index b956ce591f96..c95e2e7dc9ab 100644
--- a/drivers/pci/msi/api.c
+++ b/drivers/pci/msi/api.c
@@ -289,7 +289,7 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 			 */
 			if (affd)
 				irq_create_affinity_masks(1, affd);
-			pci_intx(dev, 1);
+			pci_intx_unmanaged(dev, 1);
 			return 1;
 		}
 	}
diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 3a45879d85db..53f13b09db50 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -268,7 +268,7 @@ EXPORT_SYMBOL_GPL(pci_write_msi_msg);
 static void pci_intx_for_msi(struct pci_dev *dev, int enable)
 {
 	if (!(dev->dev_flags & PCI_DEV_FLAGS_MSI_INTX_DISABLE_BUG))
-		pci_intx(dev, enable);
+		pci_intx_unmanaged(dev, enable);
 }
 
 static void pci_msi_set_enable(struct pci_dev *dev, int enable)
-- 
2.47.0

