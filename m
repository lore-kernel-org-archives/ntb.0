Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7463B218AAF
	for <ntb@lists.linux.dev>; Sat, 21 Feb 2026 15:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771688466; cv=none; b=BCaQwwuXJ4ia8ROEf9LwizdMa+8WRsq2GgfF1wN6z3SxJHPy/KkNqwM3C30Z2UO421wMoKxME7Gi9JJQmhbx/wLCmU4xKN50eRCAofgYXjqVWfvxcdT9584YEFLg71/Cbn9JdeCsOzAb2dhxbCqShZncvNUpw1+FC/uICeiJen0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771688466; c=relaxed/simple;
	bh=4NTgRmqq2U4qNp0PI5vdZcsHC3S/a4dzR6pQ+24UP1s=;
	h=From:Date:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eRjYa7FYa3X0npEAxFRY5wl8HHhJ+7dso5dVkAXWL1r2/mBCPdnzYyR75krpdJkb1vJsXRHMBqptLOJb0p9wVeHezqGPCxxVydiE+6mqmxNxuM+WLXolAdSnzW0wA+st/7EMUJCEqtg3XxDZuUHO8R/1in11UZwIEztg/iXAixA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kudzu.us; spf=none smtp.mailfrom=kudzu.us; dkim=pass (2048-bit key) header.d=kudzu-us.20230601.gappssmtp.com header.i=@kudzu-us.20230601.gappssmtp.com header.b=TXFmpoN3; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kudzu.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kudzu.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kudzu-us.20230601.gappssmtp.com header.i=@kudzu-us.20230601.gappssmtp.com header.b="TXFmpoN3"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-896f95e07f5so24524536d6.3
        for <ntb@lists.linux.dev>; Sat, 21 Feb 2026 07:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20230601.gappssmtp.com; s=20230601; t=1771688464; x=1772293264; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QRd7Y7PXPI3j682bYmHeBpE+1SaErlUd/rhgBEUU+NY=;
        b=TXFmpoN32O1AaCk4ApejSMbI69UksnMKO9Umx6SR8v+dFOxQTCbGb8ajkKOXcDegzk
         g0LgfG64skFmlzszDEOToLlvBluGflu1hSBZhbItRt3yIW+lsdHU8RoO53X8wxkIOus3
         qSSUA59kHnGZGQLW9D77NNdl7zVLVA6JBMHb7JO+qMFXBHOOhAC1qTt7FY7IgEDK2jK5
         aoUaHhbsw6+Z7qXNA3k+0wGOVkB36RZZEPl12OzZJndvnqd7dxvcf1G8cdtnONzDrRZu
         4bfJVZUJF6n0mL+shjdXH54vNeMxCNLm8UvvEa3S7OszHxnMPINjQQ+qoDzCymadIEHj
         Vfxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771688464; x=1772293264;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QRd7Y7PXPI3j682bYmHeBpE+1SaErlUd/rhgBEUU+NY=;
        b=KojU8PxMsFWx/XxkBfdifOnaEO6ygMtAvfgk4sbzrVcGGA+B12NTX5Jl8rrKj4+zlh
         R1WTEPViwqszJHIYV5Va9GDdzkoYdY+fPpjdD1fKtxDi/iiA8XemQgXRWJCss+eylq8e
         5Qe3UtGQYd1ctzh5iIhldvLaZ7U2efLfjzk6wI/pA0ZNQeYBoywFX57foBgYYcDtBhzk
         eRsd2UOHYTEggf8QqMpDj4jsE1H747Nl6ZZz942OePDHhHPBTcLZG6M1EpLHU9n5l6WN
         mCeKZkVZiaalU6VTU76tz9deY/GF4AHPk3GX78iRI2XkxgV8S9FLkq7mgweXCrhrrW/N
         0WAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvma/Wqh+23tIiJrbzxScFkMpJ6sdOQ6J64ASRW+ru29bHoSyEsHfViAdjF4ucufbOCu8=@lists.linux.dev
X-Gm-Message-State: AOJu0YyVaZfwJ44AiYELBZGhkY/CrJcUj5+QBrKga+TZ1nBcnPddHWOZ
	8sSwgPjWCIzqug2s5nbdkfTEF5Mo0O+b6uwPxLzds0DQTHJxix28akQKrmk8cV8MtH1W/FW0DrB
	hjdc=
X-Gm-Gg: AZuq6aLJXrSx8ysaR/F3ewywaqx5REQLJsb3j+3KsmBeVPG/gkJ2m+hoa5eYBv1om5K
	1n2NDaYrhC9kT0BMR7rap7pqpcFYDO6wceI8Zl+v4qDTK5TFK6FpaAjvs/Z3vuUosC8mxyzwxxn
	waHTm7D6SY/0QysnPrTYaUx7fcGqEAN19YomdKdKPKK5BTKMxqQ4vR1ffSSH6b8+PSwagEIMiQI
	nByn7+b7DL4bGXSyknhi7yXBKPgP9D+Se/aZBBMq+YZM1N95s4HzMWc21lT1XIavuigbXV5cejb
	AdLDvWFu4fiRuzoKIvJnDQ2zE1kuo8pZpQBVJIzAnJWC1rMdyPZakTUyqjKaW8kkml/A0a0WJ+V
	MZbKmsMKGc4ZRABZD8+vY03GYkRnNsWljcc5RkNfRuWrzU/15aeDQmrsR0I/GcQGa97FdLCYxNH
	26A2RtP2As1ttq
X-Received: by 2002:ad4:5e8e:0:b0:896:fb02:e3fc with SMTP id 6a1803df08f44-89979ecb5ffmr49176416d6.38.1771688464221;
        Sat, 21 Feb 2026 07:41:04 -0800 (PST)
Received: from localhost ([136.56.27.188])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8997e243147sm19632616d6.28.2026.02.21.07.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Feb 2026 07:41:03 -0800 (PST)
From: Jon Mason <jdmason@kudzu.us>
X-Google-Original-From: Jon Mason <jdm@athena.kudzu.us>
Date: Sat, 21 Feb 2026 10:40:59 -0500
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, ntb@lists.linux.dev
Subject: [GIT PULL] NTB bug fixes for 7.0
Message-ID: <aZnSC9wgzEOq8fb2@athena.kudzu.us>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Linus,
Here is my PR for the v7.0 kernel. It includes fixes, cleanups, and
support for a new Intel NTB. The patches have been in my tree for some
time, though the tag is new. Please consider pulling them.

Thanks,
Jon

The following changes since commit 05f7e89ab9731565d8a62e3b5d1ec206485eeb0b:

  Linux 6.19 (2026-02-08 13:03:27 -0800)

are available in the Git repository at:

  https://github.com/jonmason/ntb tags/ntb-7.0

for you to fetch changes up to 8c1f92ca8bca3ce2d2c085571af89503bc7bc7c4:

  NTB: ntb_transport: Use seq_file for QP stats debugfs (2026-02-20 17:31:55 -0500)

----------------------------------------------------------------
NTB updates include debugfs improvements, correctness fixes,
cleanups, and new hardware support. ntb_transport QP stats are
converted to seq_file, a tx_memcpy_offload module parameter is
introduced with associated ordering fixes, and a debugfs queue
name truncation bug is corrected. Additional fixes address format
specifier mismatches in ntb_tool and boundary conditions in the
Switchtec driver, while unused MSI helpers are removed and the
codebase migrates to dma_map_phys(). Intel Gen6 (Diamond Rapids)
NTB support is also added.

----------------------------------------------------------------
Baruch Siach (1):
      NTB: epf: allow built-in build

Chu Guangqing (1):
      ntb: migrate to dma_map_phys instead of map_page

Dave Jiang (1):
      ntb: intel: Add Intel Gen6 NTB support for DiamondRapids

Dr. David Alan Gilbert (1):
      NTB/msi: Remove unused functions

Koichiro Den (4):
      NTB: ntb_transport: Remove unused 'retries' field from ntb_queue_entry
      NTB: ntb_transport: Add 'tx_memcpy_offload' module option
      NTB: ntb_transport: Fix too small buffer for debugfs_name
      NTB: ntb_transport: Use seq_file for QP stats debugfs

Maciej Grochowski (3):
      ntb: ntb_hw_switchtec: Fix shift-out-of-bounds for 0 mw lut
      ntb: ntb_hw_switchtec: Fix array-index-out-of-bounds access
      ntb: ntb_hw_switchtec: Increase MAX_MWS limit to 256

yangqixiao (1):
      ntb/ntb_tool: correct sscanf format for u64 and size_t in tool_peer_mw_trans_write

 drivers/ntb/hw/epf/Kconfig             |   1 -
 drivers/ntb/hw/intel/ntb_hw_gen1.c     |  14 +-
 drivers/ntb/hw/intel/ntb_hw_gen4.c     |  22 ++-
 drivers/ntb/hw/intel/ntb_hw_gen4.h     |   2 +
 drivers/ntb/hw/intel/ntb_hw_intel.h    |   6 +
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c |  14 +-
 drivers/ntb/msi.c                      |  64 --------
 drivers/ntb/ntb_transport.c            | 263 +++++++++++++++++++--------------
 drivers/ntb/test/ntb_tool.c            |   2 +-
 include/linux/ntb.h                    |  14 --
 10 files changed, 196 insertions(+), 206 deletions(-)
