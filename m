Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE622238751
	for <ntb@lists.linux.dev>; Mon,  9 Dec 2024 13:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733749633; cv=none; b=S7s9Ax4EM7w2NNvG0nPo8piDPAOjcV2rWyY32qt7SHxoa4Qp2QCuM537hBQb/g8g3L0WnTSia4i7jxNcapMCL6tDeCZ5XRJG6HijK5datgkbTKOB9JM/3OLW7Fu2nxs8McxIenPHrIh/RwDmnLUmvzbyhUruAbrVFbdNgOsEFfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733749633; c=relaxed/simple;
	bh=jwv6lYop8TdP9htf7xZwf/ELhC2D1ascIg4aYDeJpYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Z/Bd2NUmvxrI8NEjSv7J+5Zncr6w51b31H22SA4pfEtJ/EBYHQYU+zOsg/Obz4vu6M8vtfM+4/L5iYGepX3s73OaOEFOUDjMjK+Z5gK6y9AZHiuNrpTkVTGrt3K+w07vkLf2kLohXoZeurYdkn/KToB6sqNageh15xDQVhbCHFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YmWQ6iKC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YmWQ6iKC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733749628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QrzFiyozzKwphrmER/QLBGC9UXhx6Rbz0xOMvDA9uiM=;
	b=YmWQ6iKCwI3+3rUQkJ6JMqQOz5ieCLFkktJvs5VRw9t5MIcph5sZF+kuysSoNRhgITxqDV
	J+TF7DK+cacr44n9J5nDKKAqWFJVmoct8+8AsS5BOGKAeVk0EltnLlAxOncBJoHVgSyqFz
	qH7Z8Pvh9oCvATd5ibX9yO3BILxOEl8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-TroXw4R7PFK7HAQgNvSEUQ-1; Mon, 09 Dec 2024 08:07:07 -0500
X-MC-Unique: TroXw4R7PFK7HAQgNvSEUQ-1
X-Mimecast-MFC-AGG-ID: TroXw4R7PFK7HAQgNvSEUQ
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-434f1084293so13365545e9.2
        for <ntb@lists.linux.dev>; Mon, 09 Dec 2024 05:07:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733749626; x=1734354426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QrzFiyozzKwphrmER/QLBGC9UXhx6Rbz0xOMvDA9uiM=;
        b=VLOE4/fijtdL6fNE//fZAvCjuj2q9lMi9afsOUybN/8hJEcG28D2ZTprYZQNz33Bfk
         BwIPm23fi6eHCav03B5MezjMtfx7yhnYZ3p811C7/lqJivHRl7kDj5XMLftPw7FnVBw1
         WBbN1t529NsMUkIvc9L+j3/m3HaZS+gidXBj1MblILZxtQ98Xk7Anr+HPOYRkkSSDjmS
         10WaMP8mFEKRE/Sx+M5Zyp0YBECO8ahMdHqO2UEPYXJlr3lJVtnraR4LMxZeQ34vUFYT
         t3VUdRb1xc0ajITYbbndkP7T4Cvmo8X29OP62H8zjUE+lyn8Lex3bnU2PfUxetQB0O3N
         DFgw==
X-Forwarded-Encrypted: i=1; AJvYcCWDv/ReCfM/KvAFUcMu9Djh0E06jJaqePpfGH0eN/mXoqZwmbZIG9sher4TtTKQ8igGJfo=@lists.linux.dev
X-Gm-Message-State: AOJu0YzmiyAyrW84u8PlveY/3vToSABLyFLA4SkRy73/DatAhWmlAIMy
	AmxQXYTNTTRXCLCIMYcb05IbZUewhp0s3fQvZYd7ld4UaCgPNuBH33yBAfFpuinrb1pAQzAWrYn
	SL80R/zrsScOBZO4m7uRHkUMeEyO9GwkG5ylVGgskSyoFtip9lg==
X-Gm-Gg: ASbGncs/ALGdyv+45WwUL+M2yRHvN0FA1EVxSwyU9cEL7LQ4eV80BKEkwSZAUA8fggi
	uUj2fmu1SsQEKlInZxpKh1IVq1PzMEphU7flGZTdg3SMfcXU4uaCb4gCssIWwr2OFQKdDEUBJAU
	Xcc554QHX2OcVDNbGozs5D6NfozJflJbogXuFw4nB8exVCy4FNDHk/RsRdMVdUSiehvpf+2PM8c
	gDUXF6UH9qYpz+c8LbgnFMmdKszIXATiQ8R+MzSlOZuLf+FSc/SUtf6I0pZ0C1q6SNEgbXH1u4W
	m/bjSPrI
X-Received: by 2002:a05:6000:79e:b0:385:e9c0:c069 with SMTP id ffacd0b85a97d-3862b3d0941mr9603898f8f.57.1733749626174;
        Mon, 09 Dec 2024 05:07:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IERHmOpW9Cz/hix9sJGhQKCFL65VOvqT0smHQwQu2JVZ9uttb5F5Byv3ep6mSTcPHbKk0ee2g==
X-Received: by 2002:a05:6000:79e:b0:385:e9c0:c069 with SMTP id ffacd0b85a97d-3862b3d0941mr9603809f8f.57.1733749625729;
        Mon, 09 Dec 2024 05:07:05 -0800 (PST)
Received: from eisenberg.redhat.com (nat-pool-muc-u.redhat.com. [149.14.88.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3862190965asm13200127f8f.82.2024.12.09.05.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 05:07:05 -0800 (PST)
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
Subject: [PATCH v3 09/11] wifi: qtnfmac: use always-managed version of pcim_intx()
Date: Mon,  9 Dec 2024 14:06:31 +0100
Message-ID: <20241209130632.132074-11-pstanner@redhat.com>
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
X-Mimecast-MFC-PROC-ID: DMKr1vgBI_xIrc8OR2mVoYg-54egtDbql6VD1rxffvA_1733749626
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

pci_intx() is a hybrid function which can sometimes be managed through
devres. To remove this hybrid nature from pci_intx(), it is necessary to
port users to either an always-managed or a never-managed version.

qtnfmac enables its PCI-Device with pcim_enable_device(). Thus, it needs
the always-managed version.

Replace pci_intx() with pcim_intx().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Acked-by: Kalle Valo <kvalo@kernel.org>
---
 drivers/net/wireless/quantenna/qtnfmac/pcie/pcie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/quantenna/qtnfmac/pcie/pcie.c b/drivers/net/wireless/quantenna/qtnfmac/pcie/pcie.c
index f66eb43094d4..3adcfac2886f 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/pcie/pcie.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/pcie/pcie.c
@@ -204,7 +204,7 @@ static void qtnf_pcie_init_irq(struct qtnf_pcie_bus_priv *priv, bool use_msi)
 
 	if (!priv->msi_enabled) {
 		pr_warn("legacy PCIE interrupts enabled\n");
-		pci_intx(pdev, 1);
+		pcim_intx(pdev, 1);
 	}
 }
 
-- 
2.47.1

