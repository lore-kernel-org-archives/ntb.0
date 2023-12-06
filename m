Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC6A1096B
	for <ntb@lists.linux.dev>; Wed,  6 Dec 2023 05:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hsHYmFgD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=2RhN/R0YtQaRZfvdX9T+5bKdAJ94ubAzV2OGwtbT7fA=; b=hsHYmFgDYL2PjaTEKgfj9KAeOF
	ri4R7T/MbVbm+8WsHaq0dgIfH5ohWwJLtHPZABjUUmVOCXDz3BhegPiW06ZC3BcJC3I4MU9n9BlOF
	OhqHFUzh57RiTS79yYMqNEKmuU98ghwcYCVw88i4UcDJl5bMM59SnTmKtcjWRxqW/zPPtYeGlqwTE
	cbr8uFGYK1DDWAmCWp0z/4B8YFFD/bcnYVrr3GNvfTn4QxztS0bGHharOHdnX1RjUoL/hC2FQ+tyx
	0E9v7XAXFboV5nZkeKvQyZo1dvBQjgLC9TXMGsmZQWa++yT8k5QXlYxHVE6vqv4fMO7S+GY+JvyT6
	pGbTlr/g==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rAkwZ-0098zJ-0w;
	Wed, 06 Dec 2023 05:59:35 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	ntb@lists.linux.dev
Subject: [PATCH] NTB: epf: don't misuse kernel-doc marker
Date: Tue,  5 Dec 2023 21:59:34 -0800
Message-ID: <20231206055934.24079-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use "/*" instead of "/**" for common C comments to prevent warnings
from scripts/kernel-doc.

ntb_hw_epf.c:15: warning: expecting prototype for Host side endpoint driver to implement Non(). Prototype was for NTB_EPF_COMMAND() instead

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jon Mason <jdmason@kudzu.us>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Allen Hubbe <allenbh@gmail.com>
Cc: ntb@lists.linux.dev
---
 drivers/ntb/hw/epf/ntb_hw_epf.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
--- a/drivers/ntb/hw/epf/ntb_hw_epf.c
+++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/**
+/*
  * Host side endpoint driver to implement Non-Transparent Bridge functionality
  *
  * Copyright (C) 2020 Texas Instruments
