Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483B4222566
	for <ntb@lists.linux.dev>; Fri, 21 Feb 2025 16:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740156863; cv=none; b=Phc6/lrJ1JVVOassGkj+CSgWhoQPUAYwYPxLqRNc7iW/wFhybJKDwEdHaQSXcGYyGYj49PAg2qBZvojArDtHWBtbFk5OebnIZq7xaSgGk4p9+MnhaThLGTyOAaYRDE7mrqfIXE5lG1Y7f6iOm+winqJawkWXPQNBmrM7ttKaDvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740156863; c=relaxed/simple;
	bh=WQcQgwN6rj0CXjCqPcouJGQfDiiFhGzfaeRKYbGINW0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DdaOC/R7K6WjfS7Gfz/IV3NEQwfJKoDoj+f08gPxyGmAqvLnffrw6QpfAOkMfRX60A2BpDuoJR9xesYSbd+pCHEbJfvZzPGYwqD71tFH9mnnL5y90eD7gEqem8yyugPnN9gjevR76vrO8CD93fTjqhX4xlz+MAhKt626LiWlGF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AfbQxiH9; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AfbQxiH9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740156862; x=1771692862;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WQcQgwN6rj0CXjCqPcouJGQfDiiFhGzfaeRKYbGINW0=;
  b=AfbQxiH9Kc/NA8bQOGM/iAskO+Xu3a4EQS7uNTABsSxS2lOIlpCNC5RP
   yKGF2DQFFhiv18PFfXlN/dp6ubRsbPyNFURyDSA7ilHNa7vMBdZmDBoju
   ZNbuG++2qolErabxEfCMV9T9+c2toEB9oRRr7q+M5ms0dPUQmQedSeTTp
   VDnaa7d+GQ8qA/UEeJTVS3K5FKWcT5Y45SULxVO4qiNBXC0S7+JDzaO2j
   b2NAWCyEi9b/Ywlp7RyN3cGxPESXimbLLFuLxdZHa03ATlVSHb//wB4XK
   hOvFWs20aov0q55lg23y8w3UX2Qwyb9yR/84YWZgsJUEJi43sjYzc1+2n
   g==;
X-CSE-ConnectionGUID: f7wmswz6Se2Mh3Oyu3zOIA==
X-CSE-MsgGUID: 4mBvZ7oNRwqvzjAQhW10Hw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="41186972"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="41186972"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 08:54:22 -0800
X-CSE-ConnectionGUID: pe7mYYldSG69/kmRYpcI4w==
X-CSE-MsgGUID: ZvrjvW7NRZqkS1cwcGaeNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119540641"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by fmviesa003.fm.intel.com with ESMTP; 21 Feb 2025 08:54:17 -0800
From: Raag Jadav <raag.jadav@intel.com>
To: perex@perex.cz,
	tiwai@suse.com,
	broonie@kernel.org,
	lgirdwood@gmail.com,
	deller@gmx.de,
	andriy.shevchenko@linux.intel.com,
	sre@kernel.org,
	sakari.ailus@linux.intel.com,
	mchehab@kernel.org,
	hverkuil-cisco@xs4all.nl,
	jdmason@kudzu.us,
	fancer.lancer@gmail.com
Cc: linux-sound@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-media@vger.kernel.org,
	ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1 08/13] power: supply: sc27xx: use devm_kmemdup_array()
Date: Fri, 21 Feb 2025 22:23:28 +0530
Message-Id: <20250221165333.2780888-9-raag.jadav@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221165333.2780888-1-raag.jadav@intel.com>
References: <20250221165333.2780888-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert to use devm_kmemdup_array() which is more robust.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/power/supply/sc27xx_fuel_gauge.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/sc27xx_fuel_gauge.c b/drivers/power/supply/sc27xx_fuel_gauge.c
index f36edc2ba708..573838ca8ed8 100644
--- a/drivers/power/supply/sc27xx_fuel_gauge.c
+++ b/drivers/power/supply/sc27xx_fuel_gauge.c
@@ -1014,9 +1014,8 @@ static int sc27xx_fgu_hw_init(struct sc27xx_fgu_data *data)
 	if (!table)
 		return -EINVAL;
 
-	data->cap_table = devm_kmemdup(data->dev, table,
-				       data->table_len * sizeof(*table),
-				       GFP_KERNEL);
+	data->cap_table = devm_kmemdup_array(data->dev, table, data->table_len,
+					     sizeof(*table), GFP_KERNEL);
 	if (!data->cap_table) {
 		power_supply_put_battery_info(data->battery, info);
 		return -ENOMEM;
-- 
2.34.1

