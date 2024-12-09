Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A107922F39D
	for <ntb@lists.linux.dev>; Mon,  9 Dec 2024 13:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733749618; cv=none; b=Ct2Vcny8ALTiQ1rUyzkDUXQaAI1Rvkc7fa5QPT6osp3v/yuLyBeJd4e3CunNVmCuA1B78T3/Iqok1lvUIx207nS3+criBZOfM1n22xUfKuH7x8usWeShYtLbMrLl24X3gTu+JBaDtbQAvp2Yixg9YXtbTJUVmWltr1+0LMkCdNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733749618; c=relaxed/simple;
	bh=mRkzqov/CYtFiWjgkuQOlRqwmB3d1pt6U/jB6t5Syi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=djzUeflnF3RpKHUpBjxrxvSLg6vlpg9OI5leQGYTw4n2I5uwXEduBE46HX+hcal4e7OPQemYW9bKHXnVv9OQNQZ878lhTA6AsLsxDnMUC8AT+lxCRRozKN7PmcrREZR5/h2VOMBgznzw+I/XAsvu52Tfp82nvM5CiJQTWFK3v0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EOTBUvcH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EOTBUvcH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733749615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BJlyFDGVHa1KIDhGsh03tIghv1/oE2/0tVlBeLCm6QY=;
	b=EOTBUvcHhIOKKGFdKCECoAywy8n7M8iN6vALgQJyQGiLP1FO7JtUZCROOx4VMJuRYmSXOW
	HjG5i9XmnuM5b9cV7eI/jrR/DobReYct22z9JHMkXbwGf3o0UfTuOdxakIotVxhkPW1YHV
	JFm6U7too/jrH4oyReeqoatjHSW26MA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-vbtkgjhDM0W14ZN94WeE9A-1; Mon, 09 Dec 2024 08:06:54 -0500
X-MC-Unique: vbtkgjhDM0W14ZN94WeE9A-1
X-Mimecast-MFC-AGG-ID: vbtkgjhDM0W14ZN94WeE9A
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-38639b4f19cso751297f8f.0
        for <ntb@lists.linux.dev>; Mon, 09 Dec 2024 05:06:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733749613; x=1734354413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BJlyFDGVHa1KIDhGsh03tIghv1/oE2/0tVlBeLCm6QY=;
        b=vroywBSW7z8v0nAx3G89MlrJPNw+iEhZrY01hB7lmUYDTB2yQ2xBf4Jpqg+OLTm5g7
         fxW9wWqzgxSRJSqUlkGQKJafoFQwPwfMz9Gm+KJaNlls3QURirwWAitYZG4CBpYRAA87
         Gz/rCcyJ1f4GQWYbyKqRZNJ6oUU/1cjS+6p9pKjvHDZ0U3iav/oa8x1D2dBIVuKkEAc4
         Fc+MmKOxoOMdh2CAOICo7gFA2rQD09Uow0AafPTQWZPLyrkjbhLhL8jjjCV49/23aISa
         V4YMi8wfJVBGiJbGIduedWwKa9mK07kfQCoNppytPiEXZXcZS1tpiqniS2FdxkY/t+iD
         uYUA==
X-Forwarded-Encrypted: i=1; AJvYcCV942XInW6pTysER0h8agFpwayqNNV5asPKqitPciZeyb0RfZjvokUlOw9pZI91vkA+M2I=@lists.linux.dev
X-Gm-Message-State: AOJu0Yy4QF8aqdHmfou7ODjqAon4wZs7HKm2cbM12FRX7vkWpzGyoWqV
	Euu83JMPogEYn7SZvlKznXxFBlBVf7ylwaMDNSSIMgmCOe+Rc9UwQqSmqtVr6WvkQXDEl/VPotH
	/U83YHqiE9YeVauSD74njA7eP06Zto2bR359A45PA6GNtx8/HVw==
X-Gm-Gg: ASbGncs0kvlB86TWnthfOGkxfDJXXZQZl72/WQtDZCh82BsYl9a/8/sBel0BLDspG2X
	6ns4xaQKR2kWjxZt4Ukg7UnNow1elIJUF1ZUfYL34oLXNrwgiHQkLk3YS/7zAnuAkjuSsPmfi7Y
	u1gYK4+NCkFZ0vfpTVwTIBPR+3h4K8K+ZTnMJMD2uqDiuNkEd496H6gg8mii1oCW0iLEgFEqX2H
	3tW3xZPWmo/e/k1BaTw0/faFx0P+8mqJmUJVqTKvPfix761MlcDEtNgJ4RBsSYJDUb6/u4mGK5A
	r7fWhU2q
X-Received: by 2002:a05:6000:2d08:b0:386:144d:680f with SMTP id ffacd0b85a97d-386453fd870mr188073f8f.54.1733749613272;
        Mon, 09 Dec 2024 05:06:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFj1wppsmKOkdvfdKSfuff+I9JjxqlZHOEEdHEk5K3zylRh/0qa/2JfnJnGp4etqXepLTEqow==
X-Received: by 2002:a05:6000:2d08:b0:386:144d:680f with SMTP id ffacd0b85a97d-386453fd870mr188043f8f.54.1733749612866;
        Mon, 09 Dec 2024 05:06:52 -0800 (PST)
Received: from eisenberg.redhat.com (nat-pool-muc-u.redhat.com. [149.14.88.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3862190965asm13200127f8f.82.2024.12.09.05.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 05:06:52 -0800 (PST)
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
Subject: [PATCH v3 03/11] net/ethernet: Use never-managed version of pci_intx()
Date: Mon,  9 Dec 2024 14:06:25 +0100
Message-ID: <20241209130632.132074-5-pstanner@redhat.com>
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
X-Mimecast-MFC-PROC-ID: zQnkz3gFPcInxzLihhkg2SB5yik2HWKazc-AqsLuvxE_1733749613
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

pci_intx() is a hybrid function which can sometimes be managed through
devres. To remove this hybrid nature from pci_intx(), it is necessary to
port users to either an always-managed or a never-managed version.

broadcom/bnx2x and brocade/bna enable their PCI-Device with
pci_enable_device(). Thus, they need the never-managed version.

Replace pci_intx() with pci_intx_unmanaged().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c | 2 +-
 drivers/net/ethernet/brocade/bna/bnad.c          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
index 678829646cec..2ae63d6e6792 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -1669,7 +1669,7 @@ static void bnx2x_igu_int_enable(struct bnx2x *bp)
 	REG_WR(bp, IGU_REG_PF_CONFIGURATION, val);
 
 	if (val & IGU_PF_CONF_INT_LINE_EN)
-		pci_intx(bp->pdev, true);
+		pci_intx_unmanaged(bp->pdev, true);
 
 	barrier();
 
diff --git a/drivers/net/ethernet/brocade/bna/bnad.c b/drivers/net/ethernet/brocade/bna/bnad.c
index ece6f3b48327..2b37462d406e 100644
--- a/drivers/net/ethernet/brocade/bna/bnad.c
+++ b/drivers/net/ethernet/brocade/bna/bnad.c
@@ -2669,7 +2669,7 @@ bnad_enable_msix(struct bnad *bnad)
 		}
 	}
 
-	pci_intx(bnad->pcidev, 0);
+	pci_intx_unmanaged(bnad->pcidev, 0);
 
 	return;
 
-- 
2.47.1

