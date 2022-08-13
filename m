Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E80639
	for <ntb@lists.linux.dev>; Sat, 13 Aug 2022 03:46:00 +0000 (UTC)
Received: by mail-qt1-f178.google.com with SMTP id a4so2129249qto.10
        for <ntb@lists.linux.dev>; Fri, 12 Aug 2022 20:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20210112.gappssmtp.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc;
        bh=wSz2jLwt8XGZiBsTeXMm2hepCeFx2oOvn4Pac4I1m2M=;
        b=VRp8Vv4SQsePAIYL8QWq4sigSUk09jY8sCa0snfh1NGNPMb+HJQwrNlk3cY7SCOxyK
         ji6zYb06uM6L0YLoXGch/UpPgXNmmJ1+r2+QSWn1UV2JyZn6OBxskc4zjgZClMjHpgGk
         sxdlJzYku5/AdLyMVskDPqYaQ8drvHJg96G8u0jzJV76/TQIUFaTE2myRrf0plyNdo3u
         D9p63OO0cTOzG+147/6h+VsRM+eyJSuyPSab3u7oxmmeESFPRmNaSTtwowZ0xLhfQLn5
         MBwiB+Q9zNINq3Y+bkM2V1iekbUM7lIUp1VApSriDxzfCpi4OHhxIeyeMNpwl+QWtHh3
         BABw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc;
        bh=wSz2jLwt8XGZiBsTeXMm2hepCeFx2oOvn4Pac4I1m2M=;
        b=0qsSvz8v3mD1J8gJgx+LCE6FHdwdCC5pM4Utr0GeVL0RY6bpALmvjX2kDMcQDjFa8Z
         OOzPy0oNMiSPhWCFCMBlRvszhymmyM8hBTRqPqIKTClW1Q1KgecC6AkFOliD8pbIzD5n
         rvup24H6MM8rBGFa6CuDdqh2EqxtpLrKeTR+FPhT4E0tegFau1ql8hvuXtbFo+8V/wlA
         CCWMmwWVTpGzbMKC+bvSXzmdzIkTpPtM9mNos9VGFzFRmUlamo61S2waBtt+m5ljuGUC
         1X84GLd2JL2ZhY+OsvhTTdgicHuKXON4DkZHGaHW9ncHykyOCRgBa50sjte5pbWKWWEQ
         kMeg==
X-Gm-Message-State: ACgBeo3zZGoSxnIFDIpWewXob83DuEvIuVByOl/8gqssPNU8/qDV9mSR
	6N4Y4S5l+ewuvsFl7l5kAkw9+A==
X-Google-Smtp-Source: AA6agR5jQxe8ti/vYxtVNZuu5vJf2+8CVfcm0UY+ARA/2Ij3c97dnrT4w03swk0XefjfmlcTP5SoGw==
X-Received: by 2002:a05:622a:24b:b0:343:4f6c:7bee with SMTP id c11-20020a05622a024b00b003434f6c7beemr6208191qtx.637.1660362359612;
        Fri, 12 Aug 2022 20:45:59 -0700 (PDT)
Received: from localhost ([2605:a601:a608:5600::59])
        by smtp.gmail.com with ESMTPSA id f4-20020a05620a280400b006b905e003a4sm3186732qkp.135.2022.08.12.20.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 20:45:59 -0700 (PDT)
From: Jon Mason <jdmason@kudzu.us>
X-Google-Original-From: Jon Mason <jdm@athena.kudzu.us>
Date: Fri, 12 Aug 2022 23:45:58 -0400
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, ntb@lists.linux.dev
Subject: [GIT PULL] NTB patches for v5.20
Message-ID: <YvcedivdOTR1dsik@athena.kudzu.us>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Linus,
Here are a number of patches for v5.20.  Included in them is PCI
Endpoint NTB, which received a number of fixes while in linux-next, as
well as a number of other bug fixes.  Please consider pulling them.

Thanks,
Jon



The following changes since commit 3d7cb6b04c3f3115719235cc6866b10326de34cd:

  Linux 5.19 (2022-07-31 14:03:01 -0700)

are available in the Git repository at:

  https://github.com/jonmason/ntb tags/ntb-5.20

for you to fetch changes up to e4fe2a2fc423cb51bfd36c14f95f3ca1d279ca92:

  MAINTAINERS: add PCI Endpoint NTB drivers to NTB files (2022-08-12 16:00:59 -0400)

----------------------------------------------------------------
Fix of heap data and clang warnings, support for a new Intel NTB device,
and NTB EndPoint Function (EPF) support and the various fixes from that
being in -next for Linux v5.20

----------------------------------------------------------------
Bagas Sanjaya (2):
      Documentation: PCI: Use code-block block for scratchpad registers diagram
      Documentation: PCI: extend subheading underline for "lspci output" section

Colin Ian King (1):
      NTB: EPF: set pointer addr to null using NULL rather than 0

Dan Carpenter (3):
      NTB: ntb_tool: uninitialized heap data in tool_fn_write()
      NTB: EPF: Fix error code in epf_ntb_bind()
      NTB: EPF: Tidy up some bounds checks

Dave Jiang (1):
      ntb: intel: add GNR support for Intel PCIe gen5 NTB

Frank Li (4):
      PCI: designware-ep: Allow pci_epc_set_bar() update inbound map address
      NTB: epf: Allow more flexibility in the memory BAR map method
      PCI: endpoint: Support NTB transfer between RC and EP
      Documentation: PCI: Add specification for the PCI vNTB function device

Jon Mason (1):
      MAINTAINERS: add PCI Endpoint NTB drivers to NTB files

Justin Stitt (1):
      ntb: idt: fix clang -Wformat warnings

Ren Zhijie (1):
      PCI: endpoint: Fix Kconfig dependency

Tom Rix (1):
      PCI: endpoint: pci-epf-vntb: reduce several globals to statics

Yang Yingliang (1):
      PCI: endpoint: pci-epf-vntb: fix error handle in epf_ntb_mw_bar_init()

 Documentation/PCI/endpoint/index.rst             |    2 +
 Documentation/PCI/endpoint/pci-vntb-function.rst |  129 ++
 Documentation/PCI/endpoint/pci-vntb-howto.rst    |  167 +++
 MAINTAINERS                                      |    1 +
 drivers/ntb/hw/epf/ntb_hw_epf.c                  |   48 +-
 drivers/ntb/hw/idt/ntb_hw_idt.c                  |    6 +-
 drivers/ntb/hw/intel/ntb_hw_gen1.c               |   12 +-
 drivers/ntb/hw/intel/ntb_hw_gen4.c               |    2 +-
 drivers/ntb/hw/intel/ntb_hw_intel.h              |    7 +
 drivers/ntb/test/ntb_tool.c                      |    8 +-
 drivers/pci/controller/dwc/pcie-designware-ep.c  |   10 +-
 drivers/pci/endpoint/functions/Kconfig           |   12 +
 drivers/pci/endpoint/functions/Makefile          |    1 +
 drivers/pci/endpoint/functions/pci-epf-vntb.c    | 1442 ++++++++++++++++++++++
 14 files changed, 1822 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/PCI/endpoint/pci-vntb-function.rst
 create mode 100644 Documentation/PCI/endpoint/pci-vntb-howto.rst
 create mode 100644 drivers/pci/endpoint/functions/pci-epf-vntb.c
