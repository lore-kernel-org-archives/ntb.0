Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E366F22F387
	for <ntb@lists.linux.dev>; Mon,  9 Dec 2024 13:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733749618; cv=none; b=WFLHkIhKnavfTKns5JlVo7WFUNTHLWsMryi1QSDr9/G8ocTaEilYDL23/ytMneMrvbpS2AtiDj469NeX0kasEptMZa4kFyrLNiL/mbItx0t7ncIhFnpoboNEuRx8iXVQpn6IVb9fR/sMuLGBwEFc3+wBRexYSsyWOWHjeSMtDyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733749618; c=relaxed/simple;
	bh=lb7GonT3+ZCBn5vd8Htudn5MDz8T66fffMcfmzxL9oM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=i4hqqldCQdnj/iv8LRBAz1mND4EjSu9en+3IYOP901FppkkXP0ZENmQvL6tzV+3wjDxtVBad9IuIAcEpXqjfyRAmAp52s4abYMqTDStJvTVcgTL2YEzhMlYYHF00lS4CEwsOdDNCzwF0VslHJS+YkJGl1ghspfbYVj3Q0jYWZLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I2MU793k; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I2MU793k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733749614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JzWiWxh4LRhHWrBZAH8gP8nNmxU8jwjjwHhpaGNecfw=;
	b=I2MU793kCJdxJqWTyIzOLeN324MDOAIZWMJja0gGcnDsxSHSaA29/T3dlUkmscviVXNiIS
	ITZ7sAM23lg0YyhO/j1V92jOxLUXwxC4+scckBibwmjVJ/pVr1z+cAqekNMX8/kw5Dtawo
	9x5/6mPpQCGTNuvvADbsXdyJzSw2zQs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-WeU--3TVOz-q4jI1Pzi-wg-1; Mon, 09 Dec 2024 08:06:52 -0500
X-MC-Unique: WeU--3TVOz-q4jI1Pzi-wg-1
X-Mimecast-MFC-AGG-ID: WeU--3TVOz-q4jI1Pzi-wg
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-434f0206a83so9746425e9.3
        for <ntb@lists.linux.dev>; Mon, 09 Dec 2024 05:06:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733749611; x=1734354411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JzWiWxh4LRhHWrBZAH8gP8nNmxU8jwjjwHhpaGNecfw=;
        b=OVD7eWYN1hj3HU6V+k6Z9E5YhduvoLIrjGMKiePZBi9Q0wgqrFYKJNM2xLHmwHQ0sc
         0HT9a0RgrclIRGhHRREptxAme5aIsHYjJ2Kum/iofXcWKJqBJDFBIEOaovYpRnW76OIh
         4jMfBlIVq1wK0qGY88Yb9fi6KfCjCjPVs7nIlnKDaePWrC48nCwyenAiiEn4V0L2/sMl
         +IPxjMpP0PpX2PYu04uVpiJ5SFHS1zUdTyirjpdIJ5tmVaLi5sI/rxATCpsTtHO/lLwS
         y9+RHvUwEVy9MSbMnBLKmkXVp9mPysQULZYblKBvjH1LRMc0k5fD0Dto9ZDQTCV2mxkn
         TlSw==
X-Forwarded-Encrypted: i=1; AJvYcCWOa4tR2FFvzRp8rhAQ0ApPxz4KkqIErAD6yBOb4ZPNr3h/balKcKnnvxenusLT4oCAKTs=@lists.linux.dev
X-Gm-Message-State: AOJu0YzU3KkxDrCHakQR67tr0GMx2/ErVBSHCsuMS+49Alv9SMz58LX2
	wheqdFScpP8dtONNmCZvKQLqHM7jHi01Q8lUokJoyP66k7m2IIDFM3uAgqvE64GiVvTtL4HY6dr
	GNz0BlXTMOEzlIoIg7e365NKN7Tx0tDeTGWYTP5jl1rRtbxTvmA==
X-Gm-Gg: ASbGnctnzl2iZNHQ9DwoHChZ37eebI4VcU/FoCFFHESq12GcJV34octEvipRBejOBU7
	4AZ63ya5PLAyiNwlgjtRxvY6A03mwYQJG3a/lYUc/VIZ+Iiwo/MSkiO5x4h40jj3ZS1kYGMey8f
	WldtiAJQWVOZvt/2SyEe4xVyKLHOv7L4dvUg4W6kt9Gbk+BVC6lVm9hVLHGirfRu9sLskZqkBPo
	+QF7taZxgWV/T0ZM4zPxxr9IyLQUzK4XFPJPMCbyrCib1hZGE37RbTNwCtHCMMKsri2COlPBkCD
	rW71O95q
X-Received: by 2002:a05:6000:186c:b0:385:f465:12f8 with SMTP id ffacd0b85a97d-386453f6891mr224960f8f.47.1733749611268;
        Mon, 09 Dec 2024 05:06:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYLGzMuES8pL8UNwc6rduiHNSssmgKFMI0arqDxmQvwrHwV9r5BJKNGyDbmmGP7hHm3hITRA==
X-Received: by 2002:a05:6000:186c:b0:385:f465:12f8 with SMTP id ffacd0b85a97d-386453f6891mr224791f8f.47.1733749609723;
        Mon, 09 Dec 2024 05:06:49 -0800 (PST)
Received: from eisenberg.redhat.com (nat-pool-muc-u.redhat.com. [149.14.88.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3862190965asm13200127f8f.82.2024.12.09.05.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 05:06:49 -0800 (PST)
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
Subject: [PATCH v3 02/11] drivers/xen: Use never-managed version of pci_intx()
Date: Mon,  9 Dec 2024 14:06:24 +0100
Message-ID: <20241209130632.132074-4-pstanner@redhat.com>
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
X-Mimecast-MFC-PROC-ID: h0kZge7ESjwUxmBlJWf5JgDRZMK6VY9_bO45dCqmkBc_1733749611
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

pci_intx() is a hybrid function which can sometimes be managed through
devres. To remove this hybrid nature from pci_intx(), it is necessary to
port users to either an always-managed or a never-managed version.

xen enables its PCI-Device with pci_enable_device(). Thus, it
needs the never-managed version.

Replace pci_intx() with pci_intx_unmanaged().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Acked-by: Juergen Gross <jgross@suse.com>
---
 drivers/xen/xen-pciback/conf_space_header.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/xen-pciback/conf_space_header.c b/drivers/xen/xen-pciback/conf_space_header.c
index fc0332645966..8d26d64232e8 100644
--- a/drivers/xen/xen-pciback/conf_space_header.c
+++ b/drivers/xen/xen-pciback/conf_space_header.c
@@ -106,7 +106,7 @@ static int command_write(struct pci_dev *dev, int offset, u16 value, void *data)
 
 	if (dev_data && dev_data->allow_interrupt_control &&
 	    ((cmd->val ^ value) & PCI_COMMAND_INTX_DISABLE))
-		pci_intx(dev, !(value & PCI_COMMAND_INTX_DISABLE));
+		pci_intx_unmanaged(dev, !(value & PCI_COMMAND_INTX_DISABLE));
 
 	cmd->val = value;
 
-- 
2.47.1

