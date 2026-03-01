Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EEF13B58A;
	Sun,  1 Mar 2026 01:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329188; cv=none; b=JnOtnf02/bXPBXWzRLAlCe8qcTkR/+EO15bj2X0IA6M34PVuUJxyc4e3iRsIFbzGb0tWPdyKZMrZY0q3PJaZcHKXWyI/xuDO3Xz9P7CqJwIxy7q5KMFKP8sGLQCtrr/Q4tQiEhFrmp6nbQfzjeU1puMRRU2Trn/wMNuCR6LO900=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329188; c=relaxed/simple;
	bh=MtS5LB5x87ffvn9/v5UZWctpxo+E2I06z3cVHfHYO94=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fth/VM3Sv55cn/B8DdocGM1UySAHsgAQ7d+3c+Orq8BNZmcqzf3gPqNQSaU1xsCka4szgI8yKknlSMR+vT0BZfF9ab/Z+UtCkIDGEI/0WiXmsuL1Z1oEZ7fhdjbJTQenKeCPYjFTSuIGByuf1ztTfFl65HtSETvWVpqKm87CsZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BXV/tgXm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BXV/tgXm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F31CC19421;
	Sun,  1 Mar 2026 01:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329188;
	bh=MtS5LB5x87ffvn9/v5UZWctpxo+E2I06z3cVHfHYO94=;
	h=From:To:Cc:Subject:Date:From;
	b=BXV/tgXmiZi5VmZ1ohVWYfIY0nVZkhEwe9wyJx4PIfnl/6rC3odxDQ0xLt39Q04y5
	 Qnt0OXJjZHagLY6ne1RldZlWFE9rDdhsP9wQKd8cgv3W1kGGtvehxYCrDFgf6sHPt9
	 Psh2YwRq6SULDK0y2dYd27cHs7MMdvktUCKVkYdTY/Ut+5b0aFgzb1FDbuvvIjrsKS
	 uUCX/wF/FitDLQ2ei4dO1FT3a1hwkJzWaLXDbi+EzKgQuqYq/yM48k56GznwIN4tax
	 oEMEGOGHrRp/4Srlpv28XlYpkJ36timfgFZb5nb/Xoi62tk/E6ld6rl4GDl4D22NvP
	 mDBPjzlraoyYQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	den@valinux.co.jp
Cc: Frank Li <Frank.Li@nxp.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Jon Mason <jdmason@kudzu.us>,
	ntb@lists.linux.dev
Subject: FAILED: Patch "NTB: ntb_transport: Fix too small buffer for debugfs_name" failed to apply to 6.6-stable tree
Date: Sat, 28 Feb 2026 20:39:45 -0500
Message-ID: <20260301013946.1700849-1-sashal@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
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




