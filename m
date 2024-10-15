Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCEA1B6CFD
	for <ntb@lists.linux.dev>; Tue, 15 Oct 2024 18:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729018307; cv=none; b=mgJccxF0yYy7QxRCgR1/Pf3zCZJQxuBvyRDlJaSfsa/WluhnDltCkpl1jZNP3MXle6SWy6n6XMl3+DSStJOCJcS2qCynFMV9SCs5USZzRg7ublSvXnjE8a0H3PE9q9IN9E6SjMbAaqSbkSQHUfGWSHMBLHyOScVZ4a6hgRU2LFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729018307; c=relaxed/simple;
	bh=YYwOSyuNwzPMG+/oq7uN2BePBtYq5BuqWQxzXADBcmY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tu1nsTQDHbn86K6bFB/8QkxtAgHAZ0Rbe7FX2E2Pxa7hpLkUNDmfSG1VFhu5EySMWIAxzYUjY8CrLRHcBL5ALEf8QRDUTyf3PWafeDavHii1KbTIq5DPDRPk1v/i3R4PkmTTDjiQKTw+mnKVzmUvj19NdyjXrq1rBJ33RIru/Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ekcl0yhw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ekcl0yhw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729018304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=N0GRF4pPtSOgd1WabJUy8wYxVfX9TEQxA2AbPtBzocc=;
	b=Ekcl0yhwcweB6CQsrL3Idhb5sLx8MjXzNBQcNtzJYyoauKCLVSOmNp8CCpsffUO62a2Wsk
	ljtd38u+xu3NcPBvZOOT/T7K+QS9z5RKYmeDqRhS29Qjz7umzdycyp85Nwsz3Wv3heBu8k
	YEiMjyQQlMeEYTzMbGB8lh1Gh51HFS8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-I6UBR89HPwCMKqhEODgj6A-1; Tue, 15 Oct 2024 14:51:41 -0400
X-MC-Unique: I6UBR89HPwCMKqhEODgj6A-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5c9217064f6so4369810a12.3
        for <ntb@lists.linux.dev>; Tue, 15 Oct 2024 11:51:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729018300; x=1729623100;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N0GRF4pPtSOgd1WabJUy8wYxVfX9TEQxA2AbPtBzocc=;
        b=NtUJSWMKpTuTt1OGArdJvwLD3QFSHqS9m0LiCC+aE8MT+UjS30BK1Q3d+fcwg8oGio
         hMyXCjKpFHiLU25BdWOF3eHxVfQPK3vFqm8sAellG+XagXzIorzoPlnG/fUFvIMzWZeD
         lJM5O/z8hFs51s/Sdd5qlNwoOe3ZWkVLUGYC4ed7mlYV/OFNo8nv0l+BhHIj8QpzShs2
         /W4x58gULG6L2EbktzkDr2MGok22UWfstRN5JViGWHkB61VrILxglZrGdS6awrr91SB7
         xH9cvRkLLZFge0aXiKDLrO86oZLpwuducOcdKgcJXu5ZMebFv6ZPByq7366vPKo7A5Kn
         Rbpw==
X-Forwarded-Encrypted: i=1; AJvYcCVO2krA09WJGTcidCeFzdMsU1d/xZz09pEUcRferzqnRTBqRpp2LzpLMtZFKRDubzTa0Wo=@lists.linux.dev
X-Gm-Message-State: AOJu0YwwSdL0gjvTaW9QdYuBjDLCZRjhKFTi695i4vU85LvY7k4OVhFD
	KWdbiLChXPwguicBsCkZWx0X4/mWuy5TydMFllsisRVJ/leJn9JAPaDhaWdI81i0OlKmAtsDNjd
	Rfm4bH8Xxj0YuHudO9vIBbTSt5tsXvkbTh2u5Y0G7cgBlKmlwlg==
X-Received: by 2002:a05:6402:5212:b0:5c9:547d:99 with SMTP id 4fb4d7f45d1cf-5c99501ced5mr1032565a12.2.1729018300237;
        Tue, 15 Oct 2024 11:51:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoUi+m94pA/sZ0UkPSNqunOeFPcNR+QjlgzRmDDQ7K7kAorm0A07Mz2aeKaa+48zMcVX+P9g==
X-Received: by 2002:a05:6402:5212:b0:5c9:547d:99 with SMTP id 4fb4d7f45d1cf-5c99501ced5mr1032505a12.2.1729018299657;
        Tue, 15 Oct 2024 11:51:39 -0700 (PDT)
Received: from eisenberg.fritz.box (200116b82d5d5a0006e2615320d1d4db.dip.versatel-1u1.de. [2001:16b8:2d5d:5a00:6e2:6153:20d1:d4db])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c98d39a9a2sm974438a12.0.2024.10.15.11.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 11:51:38 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Basavaraj Natikar <basavaraj.natikar@amd.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alex Dubov <oakad@yahoo.com>,
	Sudarsana Kalluru <skalluru@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
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
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Chen Ni <nichen@iscas.ac.cn>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Ricky Wu <ricky_wu@realtek.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Breno Leitao <leitao@debian.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mostafa Saleh <smostafa@google.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Yi Liu <yi.l.liu@intel.com>,
	Christian Brauner <brauner@kernel.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Eric Auger <eric.auger@redhat.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Ye Bin <yebin10@huawei.com>,
	=?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Rui Salvaterra <rsalvaterra@gmail.com>
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	kvm@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	linux-sound@vger.kernel.org
Subject: [PATCH 00/13] Remove implicit devres from pci_intx()
Date: Tue, 15 Oct 2024 20:51:10 +0200
Message-ID: <20241015185124.64726-1-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

@Driver-Maintainers: Your driver might be touched by patch "Remove
devres from pci_intx()". You might want to take a look.

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

Philipp Stanner (13):
  PCI: Prepare removing devres from pci_intx()
  ALSA: hda_intel: Use always-managed version of pcim_intx()
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
  PCI: Deprecate pci_intx(), pcim_intx()

 drivers/ata/ahci.c                            |  2 +-
 drivers/ata/ata_piix.c                        |  2 +-
 drivers/ata/pata_rdc.c                        |  2 +-
 drivers/ata/sata_sil24.c                      |  2 +-
 drivers/ata/sata_sis.c                        |  2 +-
 drivers/ata/sata_uli.c                        |  2 +-
 drivers/ata/sata_vsc.c                        |  2 +-
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c        |  4 +--
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c |  2 +-
 .../wireless/quantenna/qtnfmac/pcie/pcie.c    |  2 +-
 drivers/pci/devres.c                          | 29 +++++--------------
 drivers/pci/pci.c                             | 19 ++++--------
 include/linux/pci.h                           |  1 +
 sound/pci/hda/hda_intel.c                     |  2 +-
 14 files changed, 26 insertions(+), 47 deletions(-)

-- 
2.47.0

