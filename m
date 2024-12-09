Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317B922ACFD
	for <ntb@lists.linux.dev>; Mon,  9 Dec 2024 13:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733749612; cv=none; b=EUcjgBMpa63insrmgFXtFP5jLPQQ6zdkkPVgBnuWmT4I2L27pTirYSxM5FcG+MfXGl996chn+zS9T+vz40xaQIBwWMkDN+To6SnyzNdi3a2Ot0w/WsQPKGb0cElUSiVKzPlG7JFJvolPHiQ+rX73magWEcgoYNMB4ajrLqUTp9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733749612; c=relaxed/simple;
	bh=Uqm9vlD4EuHqqogtqTHA9FO+0cpdFzd1I9e7PeN+AqE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=Qr6v0S930qXBneEQRtabpham1MFX9cDgUW3RH4+mm6tOHqkf3MXTkJROyna1ubd8Ms3nGFfPBM5maXUFK/uvEkmgZOwBB+vELIDJsn8N+/eisQz2+8ePomNUMuUxNeMCfQMGZcwQGBvWhju02fnRYXM5aHmjMMh8CZQywlmgORI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=db6a2V0e; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="db6a2V0e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733749609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ChZary8egFvw+XcfiLo4meSQA+SNlXlrlIPLWf6ynjo=;
	b=db6a2V0erd6VE+l4AD5XpBdZaXFl1+/UptyWwCKboksiC8JzOa+C8ypXC8TmXgxmAtqm6d
	eDDgMTnJptZPGqkZrMPlJ3Ak4p6l5NAUL3Qzss0kwS2F1wM9AmXn1OC0+ioD+U6813gY0V
	D3BRXitCs+e6leb6shvN1xqSKmoL7D0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-ZSo34szfOhetA_UbAO5wPw-1; Mon, 09 Dec 2024 08:06:47 -0500
X-MC-Unique: ZSo34szfOhetA_UbAO5wPw-1
X-Mimecast-MFC-AGG-ID: ZSo34szfOhetA_UbAO5wPw
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-385dfa9b758so1722361f8f.0
        for <ntb@lists.linux.dev>; Mon, 09 Dec 2024 05:06:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733749606; x=1734354406;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ChZary8egFvw+XcfiLo4meSQA+SNlXlrlIPLWf6ynjo=;
        b=J6wvE2gmHslveAviVyv8Jh450D+7Fyl2/+5LO3bU0Vf6RYgMzIg2uGTaF9iDdMt2pY
         iVtNZUm0U67Q49b7hAvvfYGpu/fiTRi+SBm6Mv+bDvqzucn7z4D+ex0Ls0S3uyaQlzFa
         p93CrvFv0L35cRDQRj2UsXhdIL6FwinYsLa9MeCFJwMWLYJbKckygaBO8gUifeAgKb/o
         XtRHCYv7ZTbWc7o/LlvIb83BU+9pj8MjNYRs8Yg1VjceDBMPaTCCjAbwrz1SsV45LdR2
         B1wFAhG8QI9I2NCipAT4aX6r4zSnprcWMCP/z0DxkNxvLPXmAHLMlQ0jGOKJTeN7L1TU
         nOew==
X-Forwarded-Encrypted: i=1; AJvYcCXTg6Zpl438tPMpsFwzvwodYTOaILv0IHsQ/YfyldNAfhwewUbHhLaPKc8MioCvWNMoU/c=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz7ZFTtwbt4JvsmBV83jZ65O1mNhs439ODlCU/kCtz8vQsBj0bb
	5XHc8z0d+7Z6b0WGUwbOTQHTpDn+4TQD3A/DsRoJE+rNR6pjR3cBsvGN9xJwLeeOPA6ktmqRlVP
	KZF7IMKmFATrHo9ND1nQkNEKpiKG5+sVvs4M1rj/aEDkK3b7LSg==
X-Gm-Gg: ASbGncsI0PZyjYm56c9nHSK6+oPw+mgW0ap79f9l/OjqW7zg0Z9E8oSvFL0xFld7D1C
	xp3baMXhn+38Z1DHt2Ipy9XlwNDRrEVsDIbAFYyPmJ5eB5wE9TaMUh3VRxTPnT+5aJl1QiqD5jQ
	jrLZXl3lE9trgczXH1hAlVmEJmDPZV7QYc7A4uRYKKvpNEi+xE3UN+U+POV2jGO6AMMTCkR0E2Z
	8vgH5ERcGpYM7JPSodovfF9FMUbDOPIvU2xAC54bev94zSqXBR8ky5Dhx19zzcqsfuXZhAIIrZh
	Z/xzen1E
X-Received: by 2002:a5d:5886:0:b0:385:f114:15d6 with SMTP id ffacd0b85a97d-3862b355e4bmr9451344f8f.13.1733749605828;
        Mon, 09 Dec 2024 05:06:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3aZqcp+qWXyKCP+s6A/eeOG43m5kb4cM7P1FP5MJVsW/bqky4A5d7q1L7C7R7quzo+4CpVg==
X-Received: by 2002:a5d:5886:0:b0:385:f114:15d6 with SMTP id ffacd0b85a97d-3862b355e4bmr9451253f8f.13.1733749605217;
        Mon, 09 Dec 2024 05:06:45 -0800 (PST)
Received: from eisenberg.redhat.com (nat-pool-muc-u.redhat.com. [149.14.88.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3862190965asm13200127f8f.82.2024.12.09.05.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 05:06:44 -0800 (PST)
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
Subject: [PATCH v3 00/11] Remove implicit devres from pci_intx()
Date: Mon,  9 Dec 2024 14:06:22 +0100
Message-ID: <20241209130632.132074-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TlbGaagzUyjikZG-I5r9YTL0L8-uq4JpsSF-jvfz5W0_1733749606
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

@Driver-Maintainers: Your driver might be touched by patch "Remove
devres from pci_intx()". You might want to take a look.

Changes in v3:
  - Add Thomas' RB.

Changes in v2:
  - Drop pci_intx() deprecation patch.
  - ata: Add RB from Sergey and Niklas.
  - wifi: Add AB by Kalle.
  - Drop INTx deprecation patch
  - Drop ALSA / hda_intel patch because pci_intx() was removed from
    there in the meantime.

Changes since the RFC [1]:
  - Add a patch deprecating pci{m}_intx(). (Heiner, Andy, Me)
  - Add Acked-by's already given.
  - Export pcim_intx() as a GPL function. (Alex)
  - Drop patch for rts5280, since this driver will be removed quite
    soon. (Philipp Hortmann, Greg)
  - Use early-return in pci_intx_unmanaged() and pci_intx(). (Andy)

Hi all,

this series removes a problematic feature from pci_intx(). That function
sometimes implicitly uses devres for automatic cleanup. We should get
rid of this implicit behavior.

To do so, a pci_intx() version that is always-managed, and one that is
never-managed are provided. Then, all pci_intx() users are ported to the
version they need. Afterwards, pci_intx() can be cleaned up and the
users of the never-managed version be ported back to pci_intx().

This way we'd get this PCI API consistent again.

Patch "Remove devres from pci_intx()" obviously reverts the previous
patches that made drivers use pci_intx_unmanaged(). But this way it's
easier to review and approve. It also makes sure that each checked out
commit should provide correct behavior, not just the entire series as a
whole.

Merge plan for this is to enter through the PCI tree.

[1] https://lore.kernel.org/all/20241009083519.10088-1-pstanner@redhat.com/


Regards,
P.

Philipp Stanner (11):
  PCI: Prepare removing devres from pci_intx()
  drivers/xen: Use never-managed version of pci_intx()
  net/ethernet: Use never-managed version of pci_intx()
  net/ntb: Use never-managed version of pci_intx()
  misc: Use never-managed version of pci_intx()
  vfio/pci: Use never-managed version of pci_intx()
  PCI: MSI: Use never-managed version of pci_intx()
  ata: Use always-managed version of pci_intx()
  wifi: qtnfmac: use always-managed version of pcim_intx()
  HID: amd_sfh: Use always-managed version of pcim_intx()
  Remove devres from pci_intx()

 drivers/ata/ahci.c                            |  2 +-
 drivers/ata/ata_piix.c                        |  2 +-
 drivers/ata/pata_rdc.c                        |  2 +-
 drivers/ata/sata_sil24.c                      |  2 +-
 drivers/ata/sata_sis.c                        |  2 +-
 drivers/ata/sata_uli.c                        |  2 +-
 drivers/ata/sata_vsc.c                        |  2 +-
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c        |  4 ++--
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c |  2 +-
 .../wireless/quantenna/qtnfmac/pcie/pcie.c    |  2 +-
 drivers/pci/devres.c                          | 24 +++----------------
 drivers/pci/pci.c                             | 16 +++----------
 include/linux/pci.h                           |  1 +
 13 files changed, 18 insertions(+), 45 deletions(-)

-- 
2.47.1

