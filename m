Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1CC203713
	for <ntb@lists.linux.dev>; Wed, 13 Nov 2024 12:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731501769; cv=none; b=LtIrgzzs0lPj9ARCKS2Ug+WFdtrC7pY3t1nPRc3FmUgQSMuKqnKijVhOrWt6WGVb15grCi4H/X92voTWqc31iVXad1mu22d87Qgqg8fONPbiDl5ywzMXxCtZtpOPMiQpdABJ2INGoIagkCUtP24Gl1Khhigr+DWPge36dRX8kuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731501769; c=relaxed/simple;
	bh=aRW1yWnGapeZAVe/15kwhBfTtKfyb2GHv/JRGJfOWSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aqMR70nz2kx2R7IMjdFTCEGlfVZJ8FgLPg5d5yYHLZaHdmnFe3Q3AHOq8Pc2MMNMbctmdQlQ87U1cZzftvDSLCpTfvaW6Rij9IzQZ8gELkuvGWOigqBmCLLH31TVRsuuFVZIt8Mdbdrmlv+tGyGO8Cb94Wx4fpslXddhOQ5UdTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eU82t0Rq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eU82t0Rq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731501766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=op+AvZ1YCKZsOQFtb06qEXzMr+HQn8e2wB0EdtWp+RY=;
	b=eU82t0RqZDMnOwn8zuoklPbH5eNIt669KIz1LYTG3y3dOL7f7M0Rf/a8OC3SUXdDvqJa3Y
	oxKNiXzRpn5VnFFLOGMhX5ykY6VfuqRwR716IL/46BxM82Uq0zKYGfx12Mfmnx/7u3SRg4
	z3jKFbJoJVquwtik2bU/Txtq90LgApc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-DRHIuHmpNcaD3Jx2oOQQiQ-1; Wed, 13 Nov 2024 07:42:45 -0500
X-MC-Unique: DRHIuHmpNcaD3Jx2oOQQiQ-1
X-Mimecast-MFC-AGG-ID: DRHIuHmpNcaD3Jx2oOQQiQ
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37d609ef9f7so3937576f8f.3
        for <ntb@lists.linux.dev>; Wed, 13 Nov 2024 04:42:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731501764; x=1732106564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=op+AvZ1YCKZsOQFtb06qEXzMr+HQn8e2wB0EdtWp+RY=;
        b=e6phYhwzF/jLdcV3rZy3of5gH2oK6Q179hMU6yMtUYblfgMOKObRV5/FqWPdUBZGBC
         5XpWBkKs6kw/6JGKpFUmeKAmTxl3xyOC/xqbx1zBc5hWBDIz0N2pM7HJqWnbpujV/BqY
         d+hgfQoUlfSjsOkx0gZyOFxxLx7EKYgN4h/ihOPgjokyP47lIH3Zn5fRgguV144ECoyA
         dKBEfDiaYGsbX9bPHmFTxkKxjzsvzhDvHu+x+yfORJFbgHS93XJ3NEprfjWVNWhHU/5i
         hGmXQmY91wSrzPPT4O/nYXNu6mVWU2Sx39tDlh3/yk7ZKdzv+k1o8eK7evmJgP0uNQ4x
         8drA==
X-Forwarded-Encrypted: i=1; AJvYcCXJ+2oSFLR7jahvbcY+7j7da2rmCOKhySVJoQS0eAHVlPqvAuB+QEVtdcmioSYaI5bGOGk=@lists.linux.dev
X-Gm-Message-State: AOJu0YxvjonpYdB+xMPomn1UGHvLwfpVidKZDgYqvbJzGp+DpcyZq0j4
	TtyWFnguNN4zRuUpUayNXK0VbIja2VTD+Vfhbm2/go3a0hz19VeqaBeOG5ZCdeeeNxjjDt160JB
	GnvWvF8gI6A1wAWO3wuw0wY+szXCNN+Khwv3iteJ5FypnB542QA==
X-Received: by 2002:a05:6000:704:b0:382:d0a:fe4e with SMTP id ffacd0b85a97d-3820df7add5mr2320617f8f.40.1731501763933;
        Wed, 13 Nov 2024 04:42:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFvKoYvBUp37kzzcOw/kNuKZIW7fG0pUujGd0dqmiteiiQa85bm4vAcxVjs1ubCq0XbXcf6/A==
X-Received: by 2002:a05:6000:704:b0:382:d0a:fe4e with SMTP id ffacd0b85a97d-3820df7add5mr2320584f8f.40.1731501763480;
        Wed, 13 Nov 2024 04:42:43 -0800 (PST)
Received: from eisenberg.redhat.com (nat-pool-muc-u.redhat.com. [149.14.88.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed99aa18sm18023528f8f.61.2024.11.13.04.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 04:42:43 -0800 (PST)
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
Subject: [PATCH v2 06/11] vfio/pci: Use never-managed version of pci_intx()
Date: Wed, 13 Nov 2024 13:41:54 +0100
Message-ID: <20241113124158.22863-8-pstanner@redhat.com>
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
X-Mimecast-MFC-PROC-ID: HGstaHgCqA9IqYwLwd8-ZYenDghLZi6UePElQWUBgVU_1731501764
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

pci_intx() is a hybrid function which can sometimes be managed through
devres. To remove this hybrid nature from pci_intx(), it is necessary to
port users to either an always-managed or a never-managed version.

vfio enables its PCI-Device with pci_enable_device(). Thus, it
needs the never-managed version.

Replace pci_intx() with pci_intx_unmanaged().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/vfio/pci/vfio_pci_core.c  |  2 +-
 drivers/vfio/pci/vfio_pci_intrs.c | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 1ab58da9f38a..90240c8d51aa 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -498,7 +498,7 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 		if (vfio_pci_nointx(pdev)) {
 			pci_info(pdev, "Masking broken INTx support\n");
 			vdev->nointx = true;
-			pci_intx(pdev, 0);
+			pci_intx_unmanaged(pdev, 0);
 		} else
 			vdev->pci_2_3 = pci_intx_mask_supported(pdev);
 	}
diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
index 8382c5834335..40abb0b937a2 100644
--- a/drivers/vfio/pci/vfio_pci_intrs.c
+++ b/drivers/vfio/pci/vfio_pci_intrs.c
@@ -118,7 +118,7 @@ static bool __vfio_pci_intx_mask(struct vfio_pci_core_device *vdev)
 	 */
 	if (unlikely(!is_intx(vdev))) {
 		if (vdev->pci_2_3)
-			pci_intx(pdev, 0);
+			pci_intx_unmanaged(pdev, 0);
 		goto out_unlock;
 	}
 
@@ -132,7 +132,7 @@ static bool __vfio_pci_intx_mask(struct vfio_pci_core_device *vdev)
 		 * mask, not just when something is pending.
 		 */
 		if (vdev->pci_2_3)
-			pci_intx(pdev, 0);
+			pci_intx_unmanaged(pdev, 0);
 		else
 			disable_irq_nosync(pdev->irq);
 
@@ -178,7 +178,7 @@ static int vfio_pci_intx_unmask_handler(void *opaque, void *data)
 	 */
 	if (unlikely(!is_intx(vdev))) {
 		if (vdev->pci_2_3)
-			pci_intx(pdev, 1);
+			pci_intx_unmanaged(pdev, 1);
 		goto out_unlock;
 	}
 
@@ -296,7 +296,7 @@ static int vfio_intx_enable(struct vfio_pci_core_device *vdev,
 	 */
 	ctx->masked = vdev->virq_disabled;
 	if (vdev->pci_2_3) {
-		pci_intx(pdev, !ctx->masked);
+		pci_intx_unmanaged(pdev, !ctx->masked);
 		irqflags = IRQF_SHARED;
 	} else {
 		irqflags = ctx->masked ? IRQF_NO_AUTOEN : 0;
@@ -569,7 +569,7 @@ static void vfio_msi_disable(struct vfio_pci_core_device *vdev, bool msix)
 	 * via their shutdown paths.  Restore for NoINTx devices.
 	 */
 	if (vdev->nointx)
-		pci_intx(pdev, 0);
+		pci_intx_unmanaged(pdev, 0);
 
 	vdev->irq_type = VFIO_PCI_NUM_IRQS;
 }
-- 
2.47.0

