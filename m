Received: from mail-qv1-f68.google.com (mail-qv1-f68.google.com [209.85.219.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7923E2E62C5
	for <ntb@lists.linux.dev>; Fri,  4 Apr 2025 20:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743796809; cv=none; b=TFvKxfnXmoWecyen1Q2HomEcim8t581hkyB9R5Dzut//JMjoEe5xqZ84cLg00Mq2pPgNxG16tqAshkFQKwN/GE+4cHf7Kz/my+6guqmeV4Rl6Oft09u5fT5GTUDvs6CDy0tstUfPoHbbrjYjRVTnLY8U+Fx2cBCTM58OF0n0rhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743796809; c=relaxed/simple;
	bh=Z+hEStOqVif7943lSI/sdGCcGpwnb6+xp/b4cL1hsyQ=;
	h=From:Date:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jZoLbVOuPArSoAT2xdrhfTR3vIfzscj8Eixg+SI52JicOzRqJN64g8hI4jI9dXkpWPcaZvGRVc2jaccgS0jfkUZCk5BvG9q3DRvUvNupQbmtKAwGHDlL7PbfKeEprGontnM8vovxssQstezidj6pAvDKh+Pl1FDJqceW5U0T9O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kudzu.us; spf=none smtp.mailfrom=kudzu.us; dkim=pass (2048-bit key) header.d=kudzu-us.20230601.gappssmtp.com header.i=@kudzu-us.20230601.gappssmtp.com header.b=qtQQe51K; arc=none smtp.client-ip=209.85.219.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kudzu.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kudzu.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kudzu-us.20230601.gappssmtp.com header.i=@kudzu-us.20230601.gappssmtp.com header.b="qtQQe51K"
Received: by mail-qv1-f68.google.com with SMTP id 6a1803df08f44-6e8fce04655so23790796d6.3
        for <ntb@lists.linux.dev>; Fri, 04 Apr 2025 13:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20230601.gappssmtp.com; s=20230601; t=1743796806; x=1744401606; darn=lists.linux.dev;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:date:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h5eZ3DGWv7e/HOiKc2xl6HutGoiiFu21dZ6Xc3YK3wc=;
        b=qtQQe51KvqpAVyRA7+MBE09zfLIRV3UQdeFvTbaDMHukGxkrFUmMYh47rhSnfNiU2x
         Wl1v8+J4X7IfKmNL1Q96MBLd3J/VhjPr+3Z3bsB5R4QI8x1otGkh3JuSG+dFBDyRYH/C
         tL8muERIc3a1SJDku3Sg1Z6V4IMlxjSOdevlhbbkBAysggKlFEamkLZTFzdwS8s+zq/6
         48u1BNlWIzaTMhUYLNVxfHINJ4UAj3oZKQj5g9BNnPn1F5W50PWnZoegNBocLANtit1p
         rGhhlGTonQONBfL9Np1xy3Tlvc+ISysPJMCF97GfdUDsm3rd2ZClFU9cI7NRyzYJiFfD
         28ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743796806; x=1744401606;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h5eZ3DGWv7e/HOiKc2xl6HutGoiiFu21dZ6Xc3YK3wc=;
        b=uZ4GCNxTwVeKVYowqxjMPXlFabQhNw3219FXA8q5aPjPaYunYIjdtJcHIJa3YmV91A
         lEqEVJssITHSd4AhTxRa5k16hhLbEX7J2nDrp2ozw6+WpZXyHGy7ENHLVmSfjSFnKvuN
         Kc4xXzGVhgs58n8r0LjntN+ZNchmrF7hOLiV8WEQWpjb4tn524HoRBtheGJaLq0SaK/j
         buJAg99tj3vkIM+BILL/PhVbEeUJ3CT+TmFK44gLIibf9VsOECxl3BtQcKCmWS+NYdas
         QmHVnZH4ZPZJ6v5/VC51SD7rX3g7AkAcPTPC2fTCFWHcHR2wMqRfl8VbltOcyh4G2boG
         xGRA==
X-Forwarded-Encrypted: i=1; AJvYcCXzexJZ47BhQyhJpJxsqFlKQMseLc8CeukKsCtUUVC5RKkCpb18m/PqElR2xvbEJ8TX5gg=@lists.linux.dev
X-Gm-Message-State: AOJu0YwRlp6a4ro7vk43MUhxK5JgzQW+48EeGnotkGjgZE/QP4Lk7HBY
	l91zkS77W6EoH2uaMdUG2ZsJ+b3f5oqGOjeSdqyz0XGugReCNlAtaIlCiEa2YQ==
X-Gm-Gg: ASbGnctfz29ybDC26ILW2GrOnzS6SBpVn2D3lEPbolB5SHJnRxXU7NbaBbD3tUaFVcL
	8jG+/RFYlaEdk4wxpL626zK1UidIx9pqsx6InblWIpusxfuTWLu8UAfTh2yAar3/Przib/A3Rn9
	Giv3JRWBpAwXrX0ssmj+/6uHSuyvcITBiU4IWnc3EfUwHWoBz5pybnWkZ6oLS4qwlzhEmxrHkdW
	vOAlbrx5duJ5DuowiZ0M4xcuk+HxmRqG+FP0JXEt5MoE8V9t82080u/oLlYgFmZZfQcVAp286Mt
	kv2YjLV4VmMI7Af5CFgMW0WE9okXgL0jl0bk
X-Google-Smtp-Source: AGHT+IH1dFd1V/bERQFGbzF7wB96i6ZViPRK9J2/g7n+bkagE+I2+GWu+MCxNK2rVP98gHE179j0aQ==
X-Received: by 2002:a05:6214:19ca:b0:6e8:f433:20a8 with SMTP id 6a1803df08f44-6f0b73f46afmr10169116d6.9.1743796806094;
        Fri, 04 Apr 2025 13:00:06 -0700 (PDT)
Received: from localhost ([136.56.27.188])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ef0f138d5dsm25238936d6.92.2025.04.04.13.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 13:00:05 -0700 (PDT)
From: Jon Mason <jdmason@kudzu.us>
X-Google-Original-From: Jon Mason <jdm@athena.kudzu.us>
Date: Fri, 4 Apr 2025 16:00:05 -0400
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, ntb@lists.linux.dev
Subject: [GIT PULL] NTB bug fixes for 6.15
Message-ID: <Z_A6RauUQ2sczSMr@athena.kudzu.us>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello Linus,
Here are a few NTB bug fixes and minor changes for 6.15.  Please consider pulling them.

Thanks,
Jon



The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  https://github.com/jonmason/ntb tags/ntb-6.15

for you to fetch changes up to bf8a7ce7e4c7267a6f5f2b2023cfc459b330b25e:

  ntb_hw_amd: Add NTB PCI ID for new gen CPU (2025-03-18 13:35:00 -0400)

----------------------------------------------------------------
Bug fixes for NTB Switchtec driver mw negative shift, Intel NTB link
status db, ntb_perf double unmap (in error case), and MSI 64bit
arithmetic.  Also, add new AMD NTB PCI IDs, update AMD NTB maintainer,
and pull in patch to reduce the stack usage in IDT driver.

----------------------------------------------------------------
Arnd Bergmann (1):
      ntb: reduce stack usage in idt_scan_mws

Basavaraj Natikar (1):
      ntb_hw_amd: Add NTB PCI ID for new gen CPU

Fedor Pchelkin (1):
      ntb: use 64-bit arithmetic for the MSI doorbell mask

Markus Elfring (1):
      ntb_perf: Delete duplicate dmaengine_unmap_put() call in perf_copy_chunk()

Nikita Shubin (1):
      ntb: intel: Fix using link status DB's

Shyam Sundar S K (1):
      MAINTAINERS: Update AMD NTB maintainers

Yajun Deng (1):
      ntb_hw_switchtec: Fix shift-out-of-bounds in switchtec_ntb_mw_set_trans

 MAINTAINERS                            |  1 -
 drivers/ntb/hw/amd/ntb_hw_amd.c        |  1 +
 drivers/ntb/hw/idt/ntb_hw_idt.c        | 18 +++++++-----------
 drivers/ntb/hw/intel/ntb_hw_gen3.c     |  3 +++
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c |  2 +-
 drivers/ntb/ntb_transport.c            |  2 +-
 drivers/ntb/test/ntb_perf.c            |  4 +---
 7 files changed, 14 insertions(+), 17 deletions(-)
