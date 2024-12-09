Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510241B0404
	for <ntb@lists.linux.dev>; Mon,  9 Dec 2024 13:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733749635; cv=none; b=HKcgtKc9ePzMPvdDH1x5Uynbp+WdDpnJFEhGiTfZrsnpdZxMiwrrkpQJYjxCL8tF4sSOSP+acQpX6stokTE69wV/nvPgpDGFTf7ulNk0iPdoHVSwkQqa10dkDYdWbLQ/vKpRpcTURskHS2qU78ZrAB7dTgshDUjzIiFo7lRr7Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733749635; c=relaxed/simple;
	bh=kEzRZlYHQ35CA9CnBRQZ7a8YwaQDWA/y9wHnTg2Gq0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=lFYbX6IgLrcr1LNXV3lHNDUBWEfzxIcnwCSeJexp0QfeqhLXD602A0bOiXhtlhBqyygH9JFyxUroWsuCrPOD/pQS90l21eFz9bgZkps5+S1vF7qCBVqvnX/2vWZ3kxwUTkx6MHs1hR7ihLrG5EZDJLcfb1KwyoaDkmpwcBxsMTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VM7y4uGe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VM7y4uGe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733749630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cg5FDrf0+9NG9f4wa7LEIeg49zn7uGzDf8HKpIKXKbU=;
	b=VM7y4uGewQosbc7LfMjsniDOAjbmfqEqTJM42BDCKc9Prxx5eOrQ9Nsp/YveAiXus5TM5u
	RdvYDaOP306MnCVwa/0Dtc58OJT5j3poeEwL5ne0FQHuohxfTjALZIn5hsALMbQ7VU494a
	FfncfBtBrqtNN+JsovTTGurqk97jNj0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-qxTuBZq7N56MUw5_n9QK9Q-1; Mon, 09 Dec 2024 08:07:09 -0500
X-MC-Unique: qxTuBZq7N56MUw5_n9QK9Q-1
X-Mimecast-MFC-AGG-ID: qxTuBZq7N56MUw5_n9QK9Q
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3862c67763dso1832579f8f.3
        for <ntb@lists.linux.dev>; Mon, 09 Dec 2024 05:07:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733749628; x=1734354428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cg5FDrf0+9NG9f4wa7LEIeg49zn7uGzDf8HKpIKXKbU=;
        b=MQ8xgcemtX4pPxkRUay4bZDI8CTLUIPMzDB3cmZybA/7W/LgWog506RM27bFutq6np
         VbePwpskYOyD9IN16OGSotEU1XpUQvU2ZiMiuoiwhEgW4JJpullYWgO+s+sj1qsLuYuE
         AHoQOat3lLiIETnF1mx0ayT8oDxhWaNRHstSoCsKT33KLpcGBSugK1lyQO9K7AggIvik
         2Kp2ILx0TEDedk03OueiC2mEK/jhESkYUQdGjSA4qhAbbpi6VJ9jHjVz2I+lJBznnRLz
         8PYQvnjy3e/I14hXE298kpfSMYJQnMisKbogQ0iJcPr057v9lpw1sDCP/tTOIXVQN4fO
         vf6A==
X-Forwarded-Encrypted: i=1; AJvYcCVqIMfCcWLS0/QJ2OtD04lbSFLqRyBV1tBvHKk2zYi7RbTpOQMJxcTjb7gbrz1A38i/KRg=@lists.linux.dev
X-Gm-Message-State: AOJu0YxRTgpDF1sPbxeerhMt9sYeW5qwpGWwL8b8pTCntKioSGq8Io3F
	rg1+TqQuu9MdQ6+EVwMLbCdzMCXroNT0YJuJ9mBG1DlIZ5DI0+wxHCtjb8bEoXpaZ2S4HvbAGlU
	FjuaqRXQ3nVTAwOQ7g0popy275BPTKmZOYuMW1dBxeUYS/Jmang==
X-Gm-Gg: ASbGncvo8v+Asg0MbjY5+MIxbdphmteoz/udJAcDFf9RmCkO19dQeOT572zzKEePQbu
	nevhqfuq9bJRtbfAuJmyqxydlBDTZVO3NqwU1naN+FI/U1xBhtI6unXfNt+AJDbY5dkq+M6IdjM
	8hI67Ev8ojGJmNELfdtCuYow5o7fKnNxdFyaYm/QCPxYgsQpTrtdilZuJB9jAkjY7geLpaTtueY
	RLK3qm3z9Gpsf+POTVfucd8xXcyGH29SSueVE0Rli+BiFEbQZUxDYfKNBeYJSZbaHFd6yhNNVbW
	+YYSutXO
X-Received: by 2002:a05:6000:2d12:b0:385:faec:d94d with SMTP id ffacd0b85a97d-3862b3e2f99mr6786242f8f.51.1733749628305;
        Mon, 09 Dec 2024 05:07:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGzvkT5DctzF6sU2GBgKgYj4TZMfZMHtf63D+x4hcRmPdkPLtxCBfCUCCjCewKM8z5+rRuxWg==
X-Received: by 2002:a05:6000:2d12:b0:385:faec:d94d with SMTP id ffacd0b85a97d-3862b3e2f99mr6786186f8f.51.1733749627860;
        Mon, 09 Dec 2024 05:07:07 -0800 (PST)
Received: from eisenberg.redhat.com (nat-pool-muc-u.redhat.com. [149.14.88.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3862190965asm13200127f8f.82.2024.12.09.05.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 05:07:07 -0800 (PST)
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
	xen-devel@lists.xenproject.org,
	Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH v3 10/11] HID: amd_sfh: Use always-managed version of pcim_intx()
Date: Mon,  9 Dec 2024 14:06:32 +0100
Message-ID: <20241209130632.132074-12-pstanner@redhat.com>
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
X-Mimecast-MFC-PROC-ID: 9_JTaLlAO7gB67qD4a0mn8nm2H6n5RiMSHC-rHbLkSs_1733749628
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

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
2.47.1

