Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51D1495AE5
	for <ntb@lists.linux.dev>; Fri, 18 Sep 2026 10:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789727959; cv=none; b=Fn8PVcnFa61pV8dvLNPUzfKsUpAJs92ZUquxzJVEEhLNC/QEkFX5BXfPa3JaVZ1FBUAk6spfSmHxgqeN1K9YgKIlp7r2XfY/vvYmYHRAdChMvvsidkiLUCnKwcJhuQMrcP5rMK+dqewmnQyya8a8FEUttBnve0iOtoElOLk7e9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789727959; c=relaxed/simple;
	bh=buQw2+8dh42QZE2jp5fC1omG1He++xBkKZ8VO1g+ckA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EBevAyiu6upSq1MODwcbZ3hBDyIc+ZOeWNu1Y88gl0oBgfU2uqKtra2PLBSVGh34+sj8VhdnbHxwPvzDlmI8LKGiv5XQpiWC0K0dP4g1vkTE4hjQv0MWuRqo64Pl4j9SlaORgr4VSFmfGRhgjabMVbgHhUaJKVmWshK4cjGeACw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iegp6tNS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4q3zguBt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iegp6tNS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4q3zguBt"
Date: Fri, 18 Sep 2026 12:39:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1789727955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=VAWwwz6NGnc9amOnbvKC5ZTbrKgsbm4I0C3Fv52Wqw0=;
	b=iegp6tNS2Y6lXtDmFiicr+rS6pZTyl+IWXg4L2C7SHavvhNWgPYZM6U+CN9mITjAcDYmGK
	riMnnN/EEcfeIqIN9zcRWQNbAr2TOn3HjV08xLC0fQpNWPVD67AiD2OY1uxwARJw9jPH/k
	JS+Z4n8TSMQ5FM95bS13JXpv8EGrljVNqUnFW/zvpyuwNs8Dn3UMF4KzCSsSj2ypmdH7bL
	Ey7MOVJZEI9tkTg/L3T25a/42/P3lrqLz10vHBccIXJvP9Slf2XOnoBsu/GkNgunhPPpEK
	/DpxsdOWmWKnuO0uzf+u0xglxMAQKVIqYN+MNgWMZoqB9Cga9oI+5XwjO1CUyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1789727955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=VAWwwz6NGnc9amOnbvKC5ZTbrKgsbm4I0C3Fv52Wqw0=;
	b=4q3zguBtkchOxjpVR+vE/naiRFQYUUQYLJJ0F7G+Qyb/nI33Vy9UUZ9fCevTMOagny+8N7
	njbD/R7CtHmzQZCQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: ntb@lists.linux.dev
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>
Subject: [PATCH] ntb: Use %p for pointer formatting
Message-ID: <20260918103914.XRVeXpwB@linutronix.de>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Since commit ad67b74d2469d ("printk: hash addresses printed with
%p") pointers are hashed by default and the behaviour can be controller
by `hash_pointers' boot argument.
The policy on %p is to not introduce new ones.
Removing %pK makes it possible to remove its handling from the library.

The usage here is restricted to debugfs and testing.

Use %p instead %pK.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/ntb/test/ntb_perf.c | 4 ++--
 drivers/ntb/test/ntb_tool.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index dfd175f79e8f0..c4c572c754f18 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -1222,7 +1222,7 @@ static ssize_t perf_dbgfs_read_info(struct file *filep, char __user *ubuf,
 			test_bit(PERF_STS_LNKUP, &peer->sts) ? "up" : "down");
 
 		pos += scnprintf(buf + pos, buf_size - pos,
-			"\tOut buffer addr 0x%pK\n", peer->outbuf);
+			"\tOut buffer addr 0x%p\n", peer->outbuf);
 
 		pos += scnprintf(buf + pos, buf_size - pos,
 			"\tOut buff phys addr %pap\n", &peer->out_phys_addr);
@@ -1240,7 +1240,7 @@ static ssize_t perf_dbgfs_read_info(struct file *filep, char __user *ubuf,
 		}
 
 		pos += scnprintf(buf + pos, buf_size - pos,
-			"\tIn buffer addr 0x%pK\n", peer->inbuf);
+			"\tIn buffer addr 0x%p\n", peer->inbuf);
 
 		pos += scnprintf(buf + pos, buf_size - pos,
 			"\tIn buffer size %pa\n", &peer->inbuf_size);
diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c
index 06881047f5bcd..63d830924ae91 100644
--- a/drivers/ntb/test/ntb_tool.c
+++ b/drivers/ntb/test/ntb_tool.c
@@ -666,7 +666,7 @@ static ssize_t tool_mw_trans_read(struct file *filep, char __user *ubuf,
 			 inmw->pidx);
 
 	off += scnprintf(buf + off, buf_size - off,
-			 "Window Address \t0x%pK\n", inmw->mm_base);
+			 "Window Address \t0x%p\n", inmw->mm_base);
 
 	off += scnprintf(buf + off, buf_size - off,
 			 "DMA Address    \t%pad\n",
@@ -899,7 +899,7 @@ static ssize_t tool_peer_mw_trans_read(struct file *filep, char __user *ubuf,
 	}
 
 	off += scnprintf(buf + off, buf_size - off,
-			 "Virtual address     \t0x%pK\n", outmw->io_base);
+			 "Virtual address     \t0x%p\n", outmw->io_base);
 
 	off += scnprintf(buf + off, buf_size - off,
 			 "Phys Address        \t%pap\n", &map_base);
-- 
2.55.0

