Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43581209F42
	for <ntb@lists.linux.dev>; Wed, 13 Nov 2024 12:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731501778; cv=none; b=MVXOrJ7WJR1CH4T7MJ3usN6JDOMLU5FkVl/FubxouG+e7phag2JsmALz9NJ4P930DILyITCVKbayEWOtR35dFS7uaY82RdtOqoNkhNTZniVg1K+eajXmkOtv2s7HerWU20IMhIsd8/NNMIStwAXaKG278vRaGODIROx6YnsAqZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731501778; c=relaxed/simple;
	bh=aAbe7GmqFC4E4dG0vzWtJY0/IVRJ0ypsn5oCbly1PXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s7L4v9OwvM0IeDMBa8Sa5eZ7GvJ19g8s7+rM4QEIt0ezDiQ1Iz1ko43/JpL/e54PaCm94AgbdsZ47EVcPCsZkLqKXUCyj18UyDHPJcQhaWmY8DAWj1nYmdXxe4sCyB4WRRFa2uEHJ8pihsj4Sj6idNUA1369JqUvR7G4kcGp3rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e4Hvp2NE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e4Hvp2NE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731501775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nkAJx4kdHqc1uo2Ugvp3a9JlaC6teLxc6IU39omygl8=;
	b=e4Hvp2NEdNb2hpVr7xapE1wumKdjI2DK7VfUxgtHRCrQCNun8eo0enjap2Q9qjT/jj8Qk+
	bhtkPgmqrDEllv9eCzA/jgeluU5xQ7lKns4mYZjtoB/C/D6q01dAGYb0mgsgf7/hIzyBOI
	sdOe9z7uxKu2utzPtoxOf8Zd8oqJGkE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-JwnSfWkLOLOfrucZfv_dnQ-1; Wed, 13 Nov 2024 07:42:54 -0500
X-MC-Unique: JwnSfWkLOLOfrucZfv_dnQ-1
X-Mimecast-MFC-AGG-ID: JwnSfWkLOLOfrucZfv_dnQ
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43163a40ee0so50915715e9.0
        for <ntb@lists.linux.dev>; Wed, 13 Nov 2024 04:42:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731501773; x=1732106573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nkAJx4kdHqc1uo2Ugvp3a9JlaC6teLxc6IU39omygl8=;
        b=jObRfLv35mYFgG4/yi0xHUeug1BXXroaGhGguqBTxBP/TqEK/Zvnh7PyUEz3vuEwUn
         hbf+K8H67VAQX7aipMW5oBp/XnNCZTAWPLb3lgDegCfPoSot027TPGPwuSLDXPanqIfd
         8CsUJ56YvU5EC/vH51WhWZrfNozCfLWlQfRskUx0VJhalFvihZQkep2H9VNUaNB+IBtE
         JiyBg/J2jcOKipwY7hKxMegkrxsKy/dPPyKsGM7VfasanTUFwPSsWyIcmgMhaS+L7n23
         imGJiNxAFm7eY6fzJiylnTp3NuP9gUamhfx319m/uS4LqQIGkaU4quU7FXmRo28+kGUR
         iaFA==
X-Forwarded-Encrypted: i=1; AJvYcCXpD8KMAAHKMES++I+VEpU6CxK03GxqKnwqOxWBBY5pUgT0xxMY5XjuYq8tSR4+gE9sgz0=@lists.linux.dev
X-Gm-Message-State: AOJu0YzMdk3Cs4xwghAn+7DUJqlJ5FDeoTXbQJe16TD6fEoAIu8s5emn
	irqv+ltu3Db1fTV3xqHAMUFMz2ZDkvxX8bqZfMq9i1mhYO/HpprARK0YXonYDbj4E1XD2mmN4OE
	9enDUkN52pb/5/wVm3iMBJFo65RoYV56NXmu/gf8m2rdRzvIhxg==
X-Received: by 2002:a05:6000:154d:b0:37d:45f0:dd0a with SMTP id ffacd0b85a97d-381f18672b7mr16331831f8f.1.1731501773097;
        Wed, 13 Nov 2024 04:42:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEPqy3tZYPqlqBkgyQss8AcuM2Gl+gY1MhPytnhmt1YoQ9bjJfa0GqSVyef5YXet7H2WA4PfQ==
X-Received: by 2002:a05:6000:154d:b0:37d:45f0:dd0a with SMTP id ffacd0b85a97d-381f18672b7mr16331752f8f.1.1731501772675;
        Wed, 13 Nov 2024 04:42:52 -0800 (PST)
Received: from eisenberg.redhat.com (nat-pool-muc-u.redhat.com. [149.14.88.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed99aa18sm18023528f8f.61.2024.11.13.04.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 04:42:52 -0800 (PST)
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
	xen-devel@lists.xenproject.org,
	Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH v2 10/11] HID: amd_sfh: Use always-managed version of pcim_intx()
Date: Wed, 13 Nov 2024 13:41:58 +0100
Message-ID: <20241113124158.22863-12-pstanner@redhat.com>
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
X-Mimecast-MFC-PROC-ID: YwM_Ad46n6mHUpYzc8f5zDjid-jt8nQ3hMuX8xn_O6E_1731501773
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

pci_intx() is a hybrid function which can sometimes be managed through
devres. To remove this hybrid nature from pci_intx(), it is necessary to
port users to either an always-managed or a never-managed version.

All users of amd_mp2_pci_remove(), where pci_intx() is used, call
pcim_enable_device(), which is why the driver needs the always-managed
version.

Replace pci_intx() with pcim_intx().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Acked-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
---
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c        | 4 ++--
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
index 0c28ca349bcd..48cfd0c58241 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
@@ -122,7 +122,7 @@ int amd_sfh_irq_init_v2(struct amd_mp2_dev *privdata)
 {
 	int rc;
 
-	pci_intx(privdata->pdev, true);
+	pcim_intx(privdata->pdev, true);
 
 	rc = devm_request_irq(&privdata->pdev->dev, privdata->pdev->irq,
 			      amd_sfh_irq_handler, 0, DRIVER_NAME, privdata);
@@ -248,7 +248,7 @@ static void amd_mp2_pci_remove(void *privdata)
 	struct amd_mp2_dev *mp2 = privdata;
 	amd_sfh_hid_client_deinit(privdata);
 	mp2->mp2_ops->stop_all(mp2);
-	pci_intx(mp2->pdev, false);
+	pcim_intx(mp2->pdev, false);
 	amd_sfh_clear_intr(mp2);
 }
 
diff --git a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c
index db36d87d5634..ec9feb8e023b 100644
--- a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c
+++ b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c
@@ -289,7 +289,7 @@ static void amd_mp2_pci_remove(void *privdata)
 	sfh_deinit_emp2();
 	amd_sfh_hid_client_deinit(privdata);
 	mp2->mp2_ops->stop_all(mp2);
-	pci_intx(mp2->pdev, false);
+	pcim_intx(mp2->pdev, false);
 	amd_sfh_clear_intr(mp2);
 }
 
-- 
2.47.0

