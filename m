Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA658440E
	for <ntb@lists.linux.dev>; Tue, 27 Sep 2022 15:36:11 +0000 (UTC)
Received: by mail-pf1-f174.google.com with SMTP id b75so10008024pfb.7
        for <ntb@lists.linux.dev>; Tue, 27 Sep 2022 08:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=ENsxjBVLvcS9Sl/erSmzP+QvgvvXtgtHf/5YnhDAvHI=;
        b=VMxLQw+YzPOn2ZG207xNCd7dLUdSahvAo2cuZvccakSqdgflshCiO1x7gfYWchdJ7V
         MCbKf+oPmAXIPER4u7KiJyyz7pAcid/j6/AlL50WeYv/o2l8dj+CX7bohhgd6tHED0Ww
         VMT71agF2P2Am58mJrlx0azMo4TcSPcfRKByBmJl//FaKLgerEtYxKuFwTXtZHb5FLfl
         yhyajQl/AQ+9ykGvVPVSv+D+3GIKNbUm2Mit6c6d1/fe2Er8ssiIFJRXmnJf2LTqc1jU
         5qdhgsGc7x4OP7dpnBunyb2WPnVW5doGUv3OcRPtdGreBu3hN1KBDzTdqoETRdQhu9/b
         G5sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=ENsxjBVLvcS9Sl/erSmzP+QvgvvXtgtHf/5YnhDAvHI=;
        b=RD5GD1SXJvZEA1jT9pySJw5VzvUK9KtfCE2AQa8cWk0D6h9yo5oo1C2iVTjiC/jpR/
         7U3mhtKNHwZS577B7cgYBfllWovziZ1n9xS+dyvfh5xn10rjUlNGEZzZiQ1PhqvSuAOE
         dZUbySiuACV9l60fEz4zVNa9LKliB90QqsAaP/WT8aZHBDF9u0WIa0hbKLRAIKuOJxLv
         XHrYbbKf0MwSrgVycc6tt+lzRxNTHSF7AbXQpD9zML0wcDXieuEJgJXkcw6qbnxMuU3C
         DX2sRR149dSnY2gOm3Qag7iS/YU/K3fEfycqeyQRsxqwq66jBo5/SlPEv7CnCw4HgFLi
         aatw==
X-Gm-Message-State: ACrzQf0nJaFwxNAE8o9+bGSHs2uSiHtQ8ccCGCzJcL8FhJB02YYRU7gY
	w+BU/f17jZLod82mQIqTtCIVSA==
X-Google-Smtp-Source: AMsMyM4AesfztARYj7VKlI8kwy86tANKtLJm/3jYH/7q0idxBuYkgELKcxtj7x5R4ivUtTFXDoPKoA==
X-Received: by 2002:a05:6a02:205:b0:41b:96dc:bb2a with SMTP id bh5-20020a056a02020500b0041b96dcbb2amr25106581pgb.116.1664292971298;
        Tue, 27 Sep 2022 08:36:11 -0700 (PDT)
Received: from C02F63J9MD6R.bytedance.net ([61.120.150.77])
        by smtp.gmail.com with ESMTPSA id w16-20020aa79a10000000b0053639773ad8sm1933087pfj.119.2022.09.27.08.36.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Sep 2022 08:36:10 -0700 (PDT)
From: Zhuo Chen <chenzhuo.1@bytedance.com>
To: bhelgaas@google.com,
	ruscur@russell.cc,
	oohall@gmail.com,
	fancer.lancer@gmail.com,
	jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	james.smart@broadcom.com,
	dick.kennedy@broadcom.com,
	jejb@linux.ibm.com,
	martin.petersen@oracle.com
Cc: chenzhuo.1@bytedance.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev,
	linux-scsi@vger.kernel.org
Subject: [PATCH v2 0/9] PCI/AER: Fix and optimize usage of status clearing api
Date: Tue, 27 Sep 2022 23:35:15 +0800
Message-Id: <20220927153524.49172-1-chenzhuo.1@bytedance.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello.

Here comes patch v2, which contains some fixes and optimizations of
aer api usage. The original version can be found on the mailing list.

Changes since v1:
- Modifications to comments proposed by Bjorn. Split patch into more
  obvious parts.

Zhuo Chen (9):
  PCI/AER: Add pci_aer_clear_uncorrect_error_status() to PCI core
  PCI/DPC: Use pci_aer_clear_uncorrect_error_status() to clear
    uncorrectable error status
  NTB: Change to use pci_aer_clear_uncorrect_error_status()
  scsi: lpfc: Change to use pci_aer_clear_uncorrect_error_status()
  PCI/AER: Unexport pci_aer_clear_nonfatal_status()
  PCI/AER: Move check inside pcie_clear_device_status().
  PCI/AER: Use pcie_aer_is_native() to judge whether OS owns AER
  PCI/ERR: Clear fatal status when pci_channel_io_frozen
  PCI/AER: Refine status clearing process with api

 drivers/ntb/hw/idt/ntb_hw_idt.c |  4 +--
 drivers/pci/pci.c               |  7 +++--
 drivers/pci/pci.h               |  2 ++
 drivers/pci/pcie/aer.c          | 45 +++++++++++++++++++--------------
 drivers/pci/pcie/dpc.c          |  3 +--
 drivers/pci/pcie/err.c          | 15 ++++-------
 drivers/pci/pcie/portdrv_core.c |  3 +--
 drivers/scsi/lpfc/lpfc_attr.c   |  4 +--
 include/linux/aer.h             |  4 +--
 9 files changed, 46 insertions(+), 41 deletions(-)

-- 
2.30.1 (Apple Git-130)

