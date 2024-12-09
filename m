Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F7C234972
	for <ntb@lists.linux.dev>; Mon,  9 Dec 2024 13:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733749629; cv=none; b=SfigWdhI8tRhNc5PKAWUd6512qMW1ExyWNiTRvSOGq7WCZHP4kHK6yeKHp5XJIrMMIjGmh1EhFfK+DtyBeYcq04tL2WHpPuTCicgXN6ZAkNXx7HGTYjyTx6EL9cSLqZ074YTKrWtmzESV7BhyHjuFQ9ekklr0XbtZNJs9wvzE4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733749629; c=relaxed/simple;
	bh=9Z1Cy2anDz0HAw/5Tw9Wb58QkDW/mnPO9GaPuFYE3VA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=C580RROlBzJQYxLbdYTXs14SuH4uCAvrh5L+6ylAX9kj5KviDgP5e2wnpsl/nE2/wHI2uq3GmrXM/SKULa/BuNu5gPcTXKBfMJv6u+a3IDj5vT8GLqEJr9uSBZZWSTEXiFjiqu+2j8Iw2cP1IZ4jIZChe4IEt5OryT/rRbS1z2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eUs8Rv4T; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eUs8Rv4T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733749626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oiILKR2a3QjvArtxAPrSG5MTRD3aI59eir0l7Eg71/Q=;
	b=eUs8Rv4TbziekXVV36RNSDyOsZlArC5rtz6d9u9rQoFTG+vS4M9tDgeorAfJWvQm6ptea1
	bfgeURj/kezC2d8gbgNDqu2Rz72woxZmo9z+EsboN5RX/pbVl4nWJdOq73gRxyRKBuRH9V
	yG3+IbPi9adgB3f5N3QuLnCNAcmIwjg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-79uHokEKNruHsu4vlSS-iw-1; Mon, 09 Dec 2024 08:07:03 -0500
X-MC-Unique: 79uHokEKNruHsu4vlSS-iw-1
X-Mimecast-MFC-AGG-ID: 79uHokEKNruHsu4vlSS-iw
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-385dcae001fso1583767f8f.1
        for <ntb@lists.linux.dev>; Mon, 09 Dec 2024 05:07:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733749622; x=1734354422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oiILKR2a3QjvArtxAPrSG5MTRD3aI59eir0l7Eg71/Q=;
        b=xFZXMSTjqRzs3eX+ht5/3CLqMDF/thoTZj1iJRqZ1s4Eln4Tf4+ihZ/L7OcK1VZ21I
         vJTMrEEc+daA5Lh+Zs6QUe56tGOJvRYDcP5UcV9bW5wpMZjrZr5K+9IZz/fookCZinYo
         hYpywEM9KKaLWaUvFH44NMi6SdSaNpgAKyXohGjPftAcf4VXzijI2UVTCY8FttBws8ha
         QGxr35QShujVcM4t5r30hNPERmct0mOSJsb87U3lURTE52OVwFKuc4cEGzTgkk/8n244
         XY8CZFKhoXMr0dwYucGC5RrAe21MhCIb6YWpr0/WSWolTtuK6fcKc2raS6taOdkAdp53
         wtPA==
X-Forwarded-Encrypted: i=1; AJvYcCUpp8ZR/wc8Bj21Le3Q1gQ2Ilu/60jRHlNXZl0rKlKouJAj2t32mjUR0hQ2C6c3pf3isug=@lists.linux.dev
X-Gm-Message-State: AOJu0Ywn+54lpTQM2xYLxp8Xi4MhEfEUYzo9F5vxtirTNfLcxuuIudDI
	xSmYFZdX9VC9lw0iiAb5KFsY3o0IK3U1yZJMmWjwiLuj28F0XLw2xpJgihZkB3mGZTqfzYHosjp
	//Tmj8Og0FiBlHv/QxWBBTUQIA44lCSEjhpNIyfCtKrmKJ1h+Xw==
X-Gm-Gg: ASbGncsJL0qj/6PYAVsbkgifMyxVHfk6jjmus2OUYTTB/GYRAb6tj9M3jhVq9I9yCsb
	WQag4jThGX+gmwA9cy4vKb+91gvvbiNM52SmZMwiCCq+RaajsO6QAUyuq3rAa7+TsaDRbT0Kmc5
	hk3OyrdvcTe3JsF+yeaped7AlCmgKSowu+L9HTSzdP9SsYf3JYARlanzcXYF29f2TTDFFoGRJmP
	IYvnzrTFcVSxBFWAAR0Hjyg72su3D3T6uD0f4IegUTu8+YN2tR/dVe7fTqDdgIaEghhy0T/NlFj
	oLAfW8dv
X-Received: by 2002:adf:e18a:0:b0:385:e3b8:f331 with SMTP id ffacd0b85a97d-3862b355ed9mr8982762f8f.14.1733749621855;
        Mon, 09 Dec 2024 05:07:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFEcWIoVaHlqXXOi6I/o8U0Sx4v85WRQCbXdmf3r6S4bXIGyWlICGFsXbMo+gcSn1pLdSeKWw==
X-Received: by 2002:adf:e18a:0:b0:385:e3b8:f331 with SMTP id ffacd0b85a97d-3862b355ed9mr8982697f8f.14.1733749621414;
        Mon, 09 Dec 2024 05:07:01 -0800 (PST)
Received: from eisenberg.redhat.com (nat-pool-muc-u.redhat.com. [149.14.88.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3862190965asm13200127f8f.82.2024.12.09.05.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 05:07:01 -0800 (PST)
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
Subject: [PATCH v3 07/11] PCI: MSI: Use never-managed version of pci_intx()
Date: Mon,  9 Dec 2024 14:06:29 +0100
Message-ID: <20241209130632.132074-9-pstanner@redhat.com>
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
X-Mimecast-MFC-PROC-ID: QkjGUBEXTgAUfTXR5wjOU_j69wq1uSxSGe5QkGv5A9o_1733749622
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

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
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
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
2.47.1

