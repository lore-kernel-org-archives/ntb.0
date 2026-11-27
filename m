Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795794129;
	b=Q9MhsH9kSUaPHuZ7ouDsGIsGn+w3aEQyr/WjPNKdKV13j4rLAXbzaNdzV6uoY+1fT9Yw
	 ThjpUO6+hnm/JyolOcNbYLBbKSzJDSyD+zrRFRYfN2YBXpQQePTM1YpT5y/0LGfMErm05
	 cAJcQmp392OAsYQtwW8sbqcaE0RZhE4GwJ4IM+6mjhjmW1sLkRVnzHCzL42uk52YDtS98
	 xtXgP8+LNwSu+BhQyzA8GopvnZEdcLalIh1TYGlfYK/sIUkRicbfjtzx/YpXt2FANpYri
	 /IiAEen6lS8p+TSXnQs0YaO2Jnm5bEixRG6fpFfl99zpALDTGhPE+JL8lMWeWKpweHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795794129;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=e2fJZFZERBeQNZtQBCOfYByS4NMe3sHfsqjEP9dc6kw=;
	b=N6victyRGEJA8TSXah6/hPSkT7oJgAecK77y3JC6dO+VU0i2I/clgHJtCzJlODqIkh9u
	 j5hlTXNlkN4q/sqanY0YIZ0vvc70+O/GZPEPQYuveGIL5qbjsimwZl0h1SnZYYU6kT0CY
	 9VfBgAtACus5cnnmrZFoBmITV/P3ea8J+6k1iEE0rWH+VJQ2u4LUcYVJTbzG0nAsqWIyO
	 a6g3LZPIz7xpOMqTe0L4yT7puf5ShcDIiOzuPNjHbos0ODdL5sy5vDzOv1ABIbChwKuSL
	 anKexahFGHpAj/5wwfVQDVzLhSUBmGgEHy7ao3EePLOjscnplGc1lxypWySjdiRJoEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SPZeye3Z;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC791606A31F
	for <ntb@lists.linux.dev>; Fri, 27 Nov 2026 15:42:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC791606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SPZeye3Z
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4bb6886d30aso78663275e9.3
        for <ntb@lists.linux.dev>; Fri, 27 Nov 2026 07:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795794127; x=1796398927; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=e2fJZFZERBeQNZtQBCOfYByS4NMe3sHfsqjEP9dc6kw=;
        b=SPZeye3ZsiWalqcv6Ga6AtJ4VUqjO9Sgi2az4AnEKMwiv3oeg+L7iGNCSJnVqtN0wa
         RoD9qn/89WkqKBdWXI9DtKPerN2OdSrNEXd+UfDnI8bNg13fr+P/FsZVyGDhKGwSEAl3
         5nngbCs72FxMgniVlnehgDpN1U8CwmZN3/lcPXcn+ENfMhQJaT2uthl+PD0Is9WpCZ+Y
         m+T2US53npGUoQKpGIUhZFP58weE1/AAMtjA57sqXjOYKpMtkqm/zITSeyvtbpVJFxvM
         rNqAqVWeeRJ+3Aw/ITLSWPvhdoIrDECnWBOrJwFPDLqXLnRCwhVnP3VqJhP3ircGtIPX
         kkfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795794127; x=1796398927;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e2fJZFZERBeQNZtQBCOfYByS4NMe3sHfsqjEP9dc6kw=;
        b=uSXGhjkBtm6Gu8bhvepbr7qEnG+JmBPvxm6S5fFSPYgrk5uJO+ot9F9wo30iksJlk6
         ZZMOznIIEzIWSSxNtxtFcCVmmlZ1yRXY1XswvzjllDXJoFUxA9cJankE9DWr3b/jRNjn
         j+tNaSzyeMTdKdM+NfOGMvB89NUKJzn3byMLFHN/86b4kjkFBJnQWX+LQpuDlYW8jLHo
         2CZY0wXiCWWClvk0jR7FufzH0Qe5PTIeAMxIrsvwV6XsnY8TCIEkGRh6ydG2y4GU7c2d
         qDAxu82j+u6LGvSmlEN+jJMlyw0fdm2qmBzUbac8j0kGbK8BwkWvmZR65xo0K+W5xdPU
         fdzw==
X-Forwarded-Encrypted: i=1; AL+hErEJji9pJskyYAmuAZa8PzvnwFnRh1uqibu9iO1OB/+DHACNAt/Y0HS/kusEnc2+qKd0HXw=@lists.linux.dev
X-Gm-Message-State: APuU4Z9CVmvf0YaF8UhVKL52Yspbk5m38KvwyEodl36NaiiDdtPeNTha
	MixcO8Cc97tYEEZbO3Qw+LBkyKust+9Qs5dsRHxmJnYAe/iGHSWqvhb+
X-Gm-Gg: AZFdTZcQv16GDK1ZCn4f50hoH8DettjgB5hZjP1eU5Ng0lj2ILzJx1+bjRWjVL7tF5g
	ClWlO4R05FzhszDUB6oWmgS0ph8qaZOEp1HEujFf2yNTKPHiMQ5S715ecXAMk11KK9L+GDfzxvT
	0z36UKWMqutuDmkXu29RfntjJ6Jh55pa3RCBQL3gfMgpeHtgO64ZFeZ4aL9p5XGog73tMnGUau5
	vX8weeNx4W+6ZcjHyMt5yFxDtVcVoaLiKKB4Lybk/PvHN8JEntISALX2D7nY4sYOVR1cBoGYtaT
	8vLSexMfSn4tKKCeD++Hc+EImGw2Ii1Pipy/c38qYLYnMLROh5Lxq2a20LGdz0PiC3lkcU/RFBY
	lyiahG0UyQYjBFDsSvSRJnprceKKJQP2pFz+kEgCPVncnjiKwvxPJjZI8bTeYRtgsSN6DQIlPO3
	I1+raT5X2MBtDNKoppoP0Lzm1Xktg2ZvNLJdxt6dCJoHM66TkHXUb9LRBT3IO6V68I1YgaHzjiV
	g8H6ykSUQHvqa05PuRCXvIgU1Nrtr+UVc+5kDOZJJvPVE8tp51H/QaXCfnIf55/SsRMaXjDy2Zt
	6CSu2dZrQ73I0LOboUPd8Dj7YeqOBJIzzwpPCwKOdcEfG9/gAxjLfhlJDBJaZtpo52GxRHeQsYc
	aBPUL+y860QgjMaqOkJnJjvemURS4qJgZVf45YCbs7fH4Ccy2ntaH95At8I5+Ea4LZ0bmJu6Jtn
	vFWWlCH/+p+06Z
X-Received: by 2002:a05:600c:c173:b0:4a1:813f:2a60 with SMTP id 5b1f17b1804b1-4bb88800134mr482703475e9.11.1795794126985;
        Fri, 27 Nov 2026 07:42:06 -0800 (PST)
Received: from localhost.localdomain ([31.223.101.75])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884b7515sm959073745e9.13.2026.11.27.07.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 07:42:06 -0800 (PST)
From: Oguzhan KAYNAK <kaynak.oguzhan0@gmail.com>
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>
Cc: Koichiro Den <den@valinux.co.jp>,
	ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	yangqixiao <yangqixiao@inspur.com>,
	stable@vger.kernel.org,
	Oguzhan KAYNAK <kaynak.oguzhan0@gmail.com>
Subject: [PATCH v2] ntb: ntb_tool: accept hexadecimal addresses in peer_mw_trans again
Date: Fri, 27 Nov 2026 18:41:57 +0300
Message-Id: <20261127154157.3541-1-kaynak.oguzhan0@gmail.com>
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

Commit 21fbdc4d0b1e ("ntb/ntb_tool: correct sscanf format for u64 and
size_t in tool_peer_mw_trans_write") changed the format of the
peer_mw_trans parser from "%lli:%zi" to "%llu:%zu". Unlike %lli, the
kernel's vsscanf() parses %llu in base 10 only, so an address written in
hexadecimal is read as 0, the ':' in the format no longer matches, and
the write fails with -EINVAL.

This breaks the usage documented at the top of ntb_tool.c
("echo 0xADD0BA5E:16384 > $DBG_DIR/peer0/peer_mw_trans0") and the NTB
selftest. tools/testing/selftests/ntb/ntb_test.sh writes back the "DMA
Address" that mw_trans<N> prints with %pad, i.e. in hexadecimal. As the
address format comes from ntb_tool itself, the first memory window test
fails this way independent of the NTB hardware driver:

  Running mw0 tests on: 0000:00:04.0 /  0000:00:05.0
  ntb_test.sh: line 117: echo: write error: Invalid argument

Split the input at the ':' and parse the address with kstrtou64() in
base 0, which accepts decimal and hexadecimal. A negative address stays
rejected, as it is since that commit. The size is parsed with %zu as
before.

Found by running the NTB selftest against a virtual NTB device in
QEMU; the fix was tested the same way (the unmodified selftest passes,
hexadecimal writes to peer_mw_trans0 succeed, and malformed input
including a negative address is rejected).

Fixes: 21fbdc4d0b1e ("ntb/ntb_tool: correct sscanf format for u64 and size_t in tool_peer_mw_trans_write")
Cc: stable@vger.kernel.org
Cc: regressions@lists.linux.dev
Cc: yangqixiao <yangqixiao@inspur.com>
Suggested-by: Koichiro Den <den@valinux.co.jp>
Assisted-by: LLM
Signed-off-by: Oguzhan KAYNAK <kaynak.oguzhan0@gmail.com>
---
v2:
- Keep rejecting a negative address: split at ':' with strsep() and
  parse the address with kstrtou64(base 0) instead of going back to
  %lli (Koichiro Den).
- Koichiro's Reviewed-by on v1 is not carried over, as the code changed.

v1: https://lore.kernel.org/all/20261126031506.165973-1-kaynak.oguzhan0@gmail.com/

 drivers/ntb/test/ntb_tool.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

--- a/drivers/ntb/test/ntb_tool.c
+++ b/drivers/ntb/test/ntb_tool.c
@@ -927,7 +927,8 @@ static ssize_t tool_peer_mw_trans_write(
 	struct tool_mw *outmw = outmw_wrap->mw;
 	size_t buf_size, wsize;
 	char buf[TOOL_BUF_LEN];
-	int ret, n;
+	char *addr_str, *size_str;
+	int ret;
 	u64 addr;
 
 	buf_size = min(size, (sizeof(buf) - 1));
@@ -936,8 +937,16 @@ static ssize_t tool_peer_mw_trans_write(
 
 	buf[buf_size] = '\0';
 
-	n = sscanf(buf, "%llu:%zu", &addr, &wsize);
-	if (n != 2)
+	size_str = buf;
+	addr_str = strsep(&size_str, ":");
+	if (!size_str)
+		return -EINVAL;
+
+	ret = kstrtou64(addr_str, 0, &addr);
+	if (ret)
+		return ret;
+
+	if (sscanf(size_str, "%zu", &wsize) != 1)
 		return -EINVAL;
 
 	tool_free_peer_mw(outmw->tc, outmw->widx);
-- 
2.34.1

