Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F6318E02A;
	Sun,  1 Mar 2026 01:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328594; cv=none; b=Ies3NIeBYz0ERD7tcwsyvBKGXBqzO6KJBAyBnjwSfXFA+PdUaJVkN9Up9NDPRRbuzJNkJSbDHIpLw1361JQM0DPSfWrEoQv0e/IviUEIG6bbM3uOmwTtWTvSlc9HFdaRzLZ+disBNLVoUA0gHdZw7Hw8C6bMGrKihU5tU31wzwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328594; c=relaxed/simple;
	bh=K2cGs3E1rkxQ+FCaRNxy+ARurf+Q27Azq/49plwfPUA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cDnF1+jqnbMlr3iTktlIynAqpdBCSrs+3kIFkyI98tMxesFmsSDVVpAEuncVjHW5ZUCUVVdlqow8Bik2FXZULcoXPnJzvix+clSZTNQpzZI6Geo8jcnQ00uUt4gY1uccbKu080zpVqM54l24Ewjp6frOupd51t0GCg1NvEJxGyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LU8ssF8K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LU8ssF8K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2B54C19421;
	Sun,  1 Mar 2026 01:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328594;
	bh=K2cGs3E1rkxQ+FCaRNxy+ARurf+Q27Azq/49plwfPUA=;
	h=From:To:Cc:Subject:Date:From;
	b=LU8ssF8K0Ez685FcPBMNvvBrt+y72XNUtGBgoQz+ALtp2aP1mlkSBL5UnhNUEUUr/
	 YcbvZhbd0swVlUskYYlgjEiEcvGGf9VVKlpDHiX8WQGWZyOHBRgKdqw4cXWfvph3B4
	 cHKaxIBZgSNcSk7NvC/N8+WES/80RWKg+Zi2ckAg9DWmzHobJyzn2UzOMwbMrwbxgj
	 kjepyHyTj+lo2XAoeyxL87MRmCc2GRx1JXSzGOhco6EnSgGTvJ7ncw8SpEwLsYRs3K
	 s4/ITJnD6lCfLke8qU31ZcY0VKxuVQSbxGXaQbctFlIAe91FvyVxjNoloTzBfgpGyg
	 IG+4ywNOA1ctA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	den@valinux.co.jp
Cc: Frank Li <Frank.Li@nxp.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Jon Mason <jdmason@kudzu.us>,
	ntb@lists.linux.dev
Subject: FAILED: Patch "NTB: ntb_transport: Fix too small buffer for debugfs_name" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:29:52 -0500
Message-ID: <20260301012952.1687763-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 6a4b50585d74fe45d3ade1e3e86ba8aae79761a5 Mon Sep 17 00:00:00 2001
From: Koichiro Den <den@valinux.co.jp>
Date: Wed, 7 Jan 2026 13:24:57 +0900
Subject: [PATCH] NTB: ntb_transport: Fix too small buffer for debugfs_name

The buffer used for "qp%d" was only 4 bytes, which truncates names like
"qp10" to "qp1" and causes multiple queues to share the same directory.

Enlarge the buffer and use sizeof() to avoid truncation.

Fixes: fce8a7bb5b4b ("PCI-Express Non-Transparent Bridge Support")
Cc: <stable@vger.kernel.org> # v3.9+
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
Signed-off-by: Jon Mason <jdmason@kudzu.us>
---
 drivers/ntb/ntb_transport.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index a7dd983adf7b0..50f3b1f1b9262 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -1252,9 +1252,9 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
 	qp->tx_max_entry = tx_size / qp->tx_max_frame;
 
 	if (nt->debugfs_node_dir) {
-		char debugfs_name[4];
+		char debugfs_name[8];
 
-		snprintf(debugfs_name, 4, "qp%d", qp_num);
+		snprintf(debugfs_name, sizeof(debugfs_name), "qp%d", qp_num);
 		qp->debugfs_dir = debugfs_create_dir(debugfs_name,
 						     nt->debugfs_node_dir);
 
-- 
2.51.0




