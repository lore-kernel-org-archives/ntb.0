Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DAF33EA;
	Fri, 21 Feb 2025 08:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740128276; cv=none; b=aHIgtNJ9AvcxQQ2WwcKs3ogCQ3paI6RCg5CkxA2ps0HAlHnojVK9U/azDEvzIULepG6q2d/4Fo9Ep5LUh19apvAzbJ9nYFx92ZFbf3EQ+YU8ET5pSMh8ZaQSP0SmsaknuFK9S16XukPn4FlV6FsTvU7QiFh2cnvO1wbVWA6dXMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740128276; c=relaxed/simple;
	bh=fBw0UDC89FHrebKrtI/LVhQbDEBN1NoKY48D4jfNI/4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g+BTgLbcQNE7ww/NskVQO3Ap4YXgIRyfl8oXBaEfhkRba1k2YQbGdi+Dir0iFxFuusPjRsigC5Pbp9a0qWA8vrtyDksSaf20KpnI304sxhwIBZ5Kp0HMGPkmvpFhQSouj9MedI3iec/V0LKt/fh6ZFlgKPdPVoCiWineu3zksOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e7osRNB1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e7osRNB1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEF7FC4CED6;
	Fri, 21 Feb 2025 08:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740128275;
	bh=fBw0UDC89FHrebKrtI/LVhQbDEBN1NoKY48D4jfNI/4=;
	h=From:To:Cc:Subject:Date:From;
	b=e7osRNB1vgiJM2lAyOgcJTiKzPsS4C9vEWWgtvHhyI+qQ5MYeb/DrEEcUxbRF92cS
	 r1tfUJW/bGTWJDRoo/JmGIkybzYak7KUd45njB/NKpE08vJkHvtzDOM8v6t5n2yP78
	 oZ99aVg/b0tvW245qk2ktNfDYzWkeubMvcTMe+HVpzg8feb4ZYNnFyN0fYwCgYKGWg
	 dZzQ9r9W2SsMvyYtB1CJBK8+/6azVbi3OZOYwEELSujq8JNRTxSk6dp10TYCHzslPn
	 Y4ZmtzuHW5rHbqD3IREwleZr+a/K4XQUFRc+CtugNLNjErcX0k/rzjVC/tuYoXCITo
	 i0bDJYxaquWWw==
From: Arnd Bergmann <arnd@kernel.org>
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	kernel test robot <lkp@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	zhang jiao <zhangjiao2@cmss.chinamobile.com>,
	Philipp Stanner <pstanner@redhat.com>,
	ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ntb: reduce stack usage in idt_scan_mws
Date: Fri, 21 Feb 2025 09:57:25 +0100
Message-Id: <20250221085748.2298463-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

idt_scan_mws() puts a large fixed-size array on the stack and copies
it into a smaller dynamically allocated array at the end. On 32-bit
targets, the fixed size can easily exceed the warning limit for
possible stack overflow:

drivers/ntb/hw/idt/ntb_hw_idt.c:1041:27: error: stack frame size (1032) exceeds limit (1024) in 'idt_scan_mws' [-Werror,-Wframe-larger-than]

Change it to instead just always use dynamic allocation for the
array from the start. It's too big for the stack, but not actually
all that much for a permanent allocation.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/all/202205111109.PiKTruEj-lkp@intel.com/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
A number of users have reported this in the past, but I couldn't
find any other patch for it so far.
---
 drivers/ntb/hw/idt/ntb_hw_idt.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
index 544d8a4d2af5..f27df8d7f3b9 100644
--- a/drivers/ntb/hw/idt/ntb_hw_idt.c
+++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
@@ -1041,7 +1041,7 @@ static inline char *idt_get_mw_name(enum idt_mw_type mw_type)
 static struct idt_mw_cfg *idt_scan_mws(struct idt_ntb_dev *ndev, int port,
 				       unsigned char *mw_cnt)
 {
-	struct idt_mw_cfg mws[IDT_MAX_NR_MWS], *ret_mws;
+	struct idt_mw_cfg *mws;
 	const struct idt_ntb_bar *bars;
 	enum idt_mw_type mw_type;
 	unsigned char widx, bidx, en_cnt;
@@ -1049,6 +1049,11 @@ static struct idt_mw_cfg *idt_scan_mws(struct idt_ntb_dev *ndev, int port,
 	int aprt_size;
 	u32 data;
 
+	mws = devm_kcalloc(&ndev->ntb.pdev->dev, IDT_MAX_NR_MWS,
+			   sizeof(*mws), GFP_KERNEL);
+	if (!mws)
+		return ERR_PTR(-ENOMEM);
+
 	/* Retrieve the array of the BARs registers */
 	bars = portdata_tbl[port].bars;
 
@@ -1103,16 +1108,7 @@ static struct idt_mw_cfg *idt_scan_mws(struct idt_ntb_dev *ndev, int port,
 		}
 	}
 
-	/* Allocate memory for memory window descriptors */
-	ret_mws = devm_kcalloc(&ndev->ntb.pdev->dev, *mw_cnt, sizeof(*ret_mws),
-			       GFP_KERNEL);
-	if (!ret_mws)
-		return ERR_PTR(-ENOMEM);
-
-	/* Copy the info of detected memory windows */
-	memcpy(ret_mws, mws, (*mw_cnt)*sizeof(*ret_mws));
-
-	return ret_mws;
+	return mws;
 }
 
 /*
-- 
2.39.5

