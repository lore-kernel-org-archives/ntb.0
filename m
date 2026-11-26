Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795663207;
	b=AV9EhKIa28SnZJ3jvBgfrLGfDCVRcDoRV+ba+aB/oaxtbTPvmCPtKFztzZbqCoLyc/Er
	 O6FdvYRDxhGPO6mkvpLGpVjyDQ6fOxep+TDCyCT0a7CYJgau3MgkHULF0t0M6vJl+90Bq
	 ZW32Cqo69lA2Jlmmyo+S5LYjctNiw0TKPVyPl83dSi0OcA/O4ss9VDsFQPZ17yo2NPnMc
	 Zcjm35kMFxNNbXGEgMtLpn90q3qvnJfNLHT9afvItyhwzlIT07gJgLA0E+kwo6teK+/bw
	 Qr+7ng+6ABOS3WPqlIjjPKwVKlczGxELZoa5DJFvVTrn1OsPsf3IG9LT9UK9uAnqvUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795663207;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ddFS5afo7Q+Q+cm9cTOpxmimaZ1i0Ia2B8XMfOPwFsk=;
	b=cduVkplMSFk7XlaMpGK05uq8OhtNZHR4J38oESs+lTpk3csfBd2xoe7s5SLLS9+KRdBp
	 XWX1VCjjEN1muYyYlcvQb0aCKjw8qxJnue4lHyPCEKLq8F9QV75CiMU1k/ZBbJ2ikFK5U
	 P/Mj8A9ieWsujbkcDAx6dkVUX1fnBUP5GvZAne+G6TmIGn1GnQN7QkJIc0VZZpdB8gqFT
	 rF0lLXNeEvDSH+RTUd91jYrvkpwfHcYA1ncnFuBKo6Q6lWbWky+VADwxqwBlXSNlp9BO7
	 ipIAP/JsaBJL9lV8wgN0IuhFDvn0JW0yfwlFREqKCD9HGa9eV103XE0l+knw/CftTyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="lu3CX/Pw";
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C317606A321
	for <ntb@lists.linux.dev>; Thu, 26 Nov 2026 03:20:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C317606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lu3CX/Pw
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a207b02a2cso46348665e9.1
        for <ntb@lists.linux.dev>; Wed, 25 Nov 2026 19:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795663206; x=1796268006; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ddFS5afo7Q+Q+cm9cTOpxmimaZ1i0Ia2B8XMfOPwFsk=;
        b=lu3CX/Pw6K4nr1KZwe+y7H8vNLSRP5cxGSWuvVCV68QcQy+8tqhcqd4RLqBtAGKw+j
         EhQHpVJEYh546EmKOVfEyb4cvvk2RlPdWJ4JvFeYO2TUKBQnHWJ6+9YADCVxf3NLtarA
         mgnjJNiMVm2cy2OPslhxds6DrD6BtSCVoGigPNGHPP6Mfh65fxtLRe59e0ameYb/6zZn
         oO5iXL3J4y6B5sTy2W51LWRVY2+WUbRcZCb8tZqR7LZCml6ub3i115g3JOoETAiD/V1/
         bLUeFY21aLWOjn0Il4dAkNz0SoloaC+jFbdc/0uRIlb8K5nZv9XxWund9O07baVcs4+E
         XOFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795663206; x=1796268006;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ddFS5afo7Q+Q+cm9cTOpxmimaZ1i0Ia2B8XMfOPwFsk=;
        b=J6v823AqfrcSJvVTVNApNYNk7uDqVg438gfYMXL30myZTrvJlIFnFQVWHS9fXhP/3Y
         rrzPAvaO4cwGPRem5VapIVlcjhX31HjwexfkXEjFdET51x6SRMAyr7X5AXm/OK5gWdt9
         gIqj+q1UJzD8PnA5/XzLZkQ3aZeCEErl4N7I2qQI7sw457RIqagzC8uZSOSli58fjs1O
         e9wd5gap2F6t1jYh1BZ613g4SQlXMAMxSIaAKMvW/qoY/x7eQ/CoQ3frxlJUtQnQBlol
         3jbOSDjuwardV1CIWrskkX4u31g9I31XvwnAZCfpDlwcUit0TlCmHmgoJDy/Vsg69NVe
         +mYg==
X-Gm-Message-State: APuU4Z9d987LxvsAZ6rFnAA8jGkVuFP3J7jQ+f95Qba/jhanGAN8vhgO
	dvIxsZcJSsxoY2GUwRIJKObigwbN5r91wCdwRRU0za7Ej4OYwMNqUMVy
X-Gm-Gg: AZFdTZc4h9AexkFAOx1TBABmDA5+5CcSFog1wEwdq3kr1+4XGPOXtnMNy34uWNNSTuL
	61cHCzn/6whMMMwnGh8tkHTh2TbOkjzdLx4t6/ccDoFFVXoRbvBxm4ugwj/GPE2F3XiyGSGlw4n
	UopEc84FRmJVam6K3V+bXG80XWpxwgwO46PUyo0LYxtwu0mBRrn5wprqhOHcbAoogeO0HtwnCHK
	l+t1puPGexLaRr/RWWtjy6PKqHv7hIUyBEiZBSKQ48ul+9uthCR07Eq3hb3/lYFA8kA1+VhTubT
	8Tou1dAkUZeCpXq22Zphd+Lt+doDtrLvbwU6PVeMbW+NgnJnTeB7EDBb7767yJNwSLOEM/B58rp
	jOAwhqsO2Vdl4+JhtTX8Mz+o0OCUfo2ab+h4irI1vVpNwrfujpzqLGHHktdVoB+gKzjXFGIWzIr
	wQRKxLynMeAI6iDgqZ/iYN3KZe0vOrexcZzq4NV/gVzOBxHB18cYNowM+C/3PGFvPK/u6FSydPe
	Wi+n7/so265lSUBVa6F0LlJP810z/XKPhyrGnpMC6J8KKhZiPLvfyAsfHGTi3ufkJ2hkUzzvivc
	ARBGCuRyBbuYW9NbKwJyYbGBduiiK17wyExLQ2ixDLDu9ClaHKvP/GzW0EvmZFJliojHKNQucnr
	NHQJGWgQoEdDJUKh4UuP3ZnVl7KK3yQrGLPf2wiAuIvBg+iq5pbLa4YcvXoeN/rXaT9pLKeqcvB
	2t25Np07G3JmXYsB/XJ7UQMgkYd9oNSbEDDQ==
X-Received: by 2002:a05:600c:a085:b0:4a2:526b:d410 with SMTP id 5b1f17b1804b1-4bb8881092bmr401946965e9.13.1795663205742;
        Wed, 25 Nov 2026 19:20:05 -0800 (PST)
Received: from localhost.localdomain ([31.223.101.75])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8849e598sm537902925e9.8.2026.11.25.19.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 19:20:05 -0800 (PST)
From: Oguzhan KAYNAK <kaynak.oguzhan0@gmail.com>
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>
Cc: ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Oguzhan KAYNAK <kaynak.oguzhan0@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ntb: ntb_tool: fix use-after-free of memory window debugfs files on remove
Date: Thu, 26 Nov 2026 06:19:54 +0300
Message-Id: <20261126031954.168544-1-kaynak.oguzhan0@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Post: <mailto:ntb@lists.linux.dev>
List-Help: <mailto:ntb+help@lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
List-Owner: <mailto:ntb+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tool_remove() removes the device's whole debugfs directory with
debugfs_remove_recursive() before tool_clear_mws() frees the memory
windows. The per-window files peer<N>/mw<M> and peer<N>/peer_mw<M> are
created in that directory, so they are already gone when
tool_free_mw() and tool_free_peer_mw() pass their stored dentries to
debugfs_remove() again. Those dentries have been killed (d_inode is
NULL) and are freed after an RCU grace period.

Removing ntb_tool, or unbinding it from the device, while a memory
window is set up therefore crashes. With lockdep on x86-64:

  BUG: kernel NULL pointer dereference, address: 0000000000000140
  ...
  Call Trace:
   down_write_nested
   __simple_recursive_removal
   debugfs_remove
   tool_free_peer_mw [ntb_tool]
   tool_clear_mws [ntb_tool]
   tool_remove [ntb_tool]
   ntb_remove [ntb]

(0x140 is offsetof(struct inode, i_rwsem) + offsetof(struct
rw_semaphore, dep_map) read through the NULL d_inode.) With KASAN the
same access is reported as "null-ptr-deref in range
[0x0000000000000140-0x0000000000000147]". If an RCU grace period has
passed by then, the dentries themselves are already freed.

Found and tested on a virtual NTB device in QEMU: removing ntb_tool
with an inbound window, an outbound window, or both set up crashed every
time (tool_free_mw() or tool_free_peer_mw() in the trace); with this
patch it unloads cleanly on lockdep and KASAN kernels.

Forget the window files once the directory has been removed, so that the
free functions only release the windows themselves. Removing debugfs
first is kept: it ends all user space access to the files before the
windows go away.

Fixes: 7f46c8b3a552 ("NTB: ntb_tool: Add full multi-port NTB API support")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Oguzhan KAYNAK <kaynak.oguzhan0@gmail.com>
---
 drivers/ntb/test/ntb_tool.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

--- a/drivers/ntb/test/ntb_tool.c
+++ b/drivers/ntb/test/ntb_tool.c
@@ -1599,7 +1599,22 @@ static void tool_setup_dbgfs(struct tool
 
 static void tool_clear_dbgfs(struct tool_ctx *tc)
 {
+	int pidx, widx;
+
 	debugfs_remove_recursive(tc->dbgfs_dir);
+	tc->dbgfs_dir = NULL;
+
+	/*
+	 * The memory window files lived in tc->dbgfs_dir and are gone now.
+	 * Forget their dentries so that tool_clear_mws() doesn't remove
+	 * them a second time.
+	 */
+	for (widx = 0; widx < tc->outmw_cnt; widx++)
+		tc->outmws[widx].dbgfs_file = NULL;
+
+	for (pidx = 0; pidx < tc->peer_cnt; pidx++)
+		for (widx = 0; widx < tc->peers[pidx].inmw_cnt; widx++)
+			tc->peers[pidx].inmws[widx].dbgfs_file = NULL;
 }
 
 static int tool_probe(struct ntb_client *self, struct ntb_dev *ntb)
-- 
2.34.1
