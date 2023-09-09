Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E82A1101
	for <ntb@lists.linux.dev>; Sat,  9 Sep 2023 01:46:48 +0000 (UTC)
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6556d05a55fso14697506d6.3
        for <ntb@lists.linux.dev>; Fri, 08 Sep 2023 18:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20230601.gappssmtp.com; s=20230601; t=1694224007; x=1694828807; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=26BI+0n04B5aNtj8zPuXi+pIvROzpuhpiJ4Kp/E4q6A=;
        b=p9+mRM2i/YiWmDLlYM595lM5zo0gyicgF07gkqOQPjd2hARzTk0+9lAgti90CiKtR8
         C5OvYVQMQ8uxuo2qQU9a9QkJgljeHh8Wc4667ZNJZaJT8/SkDM2xP5N3npu3GkwHGrUe
         1QurXmSaiyvz33aE7rM/2tpJ6lbTcNRoW/EVN0Pk1iEpgbdOu5kcgpITicF30lhpseyR
         V1hDFhDCk1M8dZg5YgvGxJwli34KWUqGlBBjr2fMjevmFPubljM80eViGEsWPMFDjzQk
         t8yShjiGcYkO9v7vrqCUWpjmYjIFGaVsGx3sZBIok3Ye6ihny9zJCAGq44EFlvLOpvtG
         ltmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694224007; x=1694828807;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=26BI+0n04B5aNtj8zPuXi+pIvROzpuhpiJ4Kp/E4q6A=;
        b=ZxfmHcAUUdcl5JEQQU0phyav9ItiEPsxgPRHPnf5yl/1NHnWldemMCryDO4Qmrzjq+
         dIphrRPYnTtDsnUfNaFkKFwqgAozyetphD8IEIZRjQ84gNXq7k9brA373BH1rpvhav31
         SW0Tx3MVP0j4vywPRJ+JDlUsqEH1kGA4c60j/H0S0e7U3FqjNgeumP+zbq9xVVqJ/Fvb
         VG1Cwg96sEAbwo8qy+JDQsu65NogFmBMAzKRPzpRcJl66rA8yX8K6OPbV4oP6NTiIYO5
         6sbgO+WE8v2VZX9jgCOU23dNVd+XJ8lgYV+CocsBEbDSok83j77zicobRmv3tRKjcFIh
         3OSg==
X-Gm-Message-State: AOJu0YwDZc2tygZ73+ZhIIbJ1S6ySPmBakDww3awRsgGcO+FnE0LbzZO
	esdqTcl0ckgpX/ZGrRZ5ses7GA==
X-Google-Smtp-Source: AGHT+IH8jIhg4dy1rQ87RnbLG0KNPA2cA2o7nnNQ3ZjQ/vgD5iXTEY3mC7rWrjAqPU/q1vJGn+Mwow==
X-Received: by 2002:a0c:a892:0:b0:64f:3bee:93a6 with SMTP id x18-20020a0ca892000000b0064f3bee93a6mr3424599qva.42.1694224007216;
        Fri, 08 Sep 2023 18:46:47 -0700 (PDT)
Received: from localhost ([2605:a601:a697:5800:8ac9:b3ff:febf:a2f8])
        by smtp.gmail.com with ESMTPSA id v4-20020a0ce1c4000000b0064dd4b5fdb4sm1176989qvl.6.2023.09.08.18.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 18:46:46 -0700 (PDT)
From: Jon Mason <jdmason@kudzu.us>
X-Google-Original-From: Jon Mason <jdm@athena.kudzu.us>
Date: Fri, 8 Sep 2023 21:46:40 -0400
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, ntb@lists.linux.dev
Subject: [GIT PULL] NTB bug fixes for 6.6
Message-ID: <ZPvOgFe6+hUx9SUC@athena.kudzu.us>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Linus,
Here are a few NTB bug fixes for 6.6.  Please consider pulling them.

Thanks,
Jon



The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  https://github.com/jonmason/ntb tags/ntb-6.6

for you to fetch changes up to 643982232860887fed493144957ea5794b6557d1:

  ntb: Check tx descriptors outstanding instead of head/tail for tx queue (2023-08-22 12:38:19 -0400)

----------------------------------------------------------------
Link toggling fixes and debugfs error path fixes

----------------------------------------------------------------
Dave Jiang (4):
      ntb: Clean up tx tail index on link down
      ntb: Drop packets when qp link is down
      ntb: Fix calculation ntb_transport_tx_free_entry()
      ntb: Check tx descriptors outstanding instead of head/tail for tx queue

Minjie Du (1):
      dtivers: ntb: fix parameter check in perf_setup_dbgfs()

Ruan Jinjie (2):
      NTB: ntb_tool: Switch to memdup_user_nul() helper
      ntb: amd: Drop unnecessary error check for debugfs_create_dir

Wang Ming (1):
      ntb: Remove error checking for debugfs_create_dir()

 drivers/ntb/hw/amd/ntb_hw_amd.c | 11 ++++-------
 drivers/ntb/ntb_transport.c     | 21 ++++++++++++++++-----
 drivers/ntb/test/ntb_perf.c     |  2 +-
 drivers/ntb/test/ntb_tool.c     | 15 +++------------
 4 files changed, 24 insertions(+), 25 deletions(-)
