Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795662922;
	b=Q0dDm5fZIuGDIErkkQdRxTeirNJgs77YWo3rZdWkRoxBjJplefs/atNUSl6wMVtQQ+kT
	 eBiUWmp+hlaBlgSWDYUB1hX4QWfx+83UHY7iDmEkJp6FpSr3PMHDboJWG7u5/AToj8UOn
	 9gMPdAGFEsLaAsBZMpvgAwKgMmwI5Z613oD0dZGe/fAm4oc5tjFWFrRmHclUuhBTHeDPF
	 /X80IWgT+B4H9LLXRS3h+5dKA3j/w6NEPQRV2jUuf664N9GZYayziNabuX5FXcHu9GJ5Z
	 GU7duwZkV5jys/vCxrXfz4k5oeklk/oyWzStTJ9ESspMm/MvIp+TfnY0lT1CyqbxSPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795662922;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=sNzRYBNLRKkf0Y/gp9OREoymKpw7SvFmjDC5u9+y2bU=;
	b=32dQBA9U/5sEpGBnNb7iDKzclzup4FF2bWjWd17/v+ps/eZVoRD2Fkt3mDZWi3Hzm1uF
	 FsHxTyifJP/4GsS2JbN36zBDUfLFVpsPuaISAhwa76zFbCryljINm+1q5aZW2xTlMaKqF
	 +VbVPHbxww/vfpJP2w87XUhqGzKXI+gXVjACPuAhqSsOLyJE96W/K0skUwF0cWB86KSHn
	 e1z/IsYQeVE60faA35aS2SVzxPu+1Ak6HMXXAlksHncwDXtAeIxaDsjqGKNPIQCg87LT9
	 zhkzGot/4B6xL9mfeM9PknvlY8OXaIuMn9UsKKUZaXmMhiQ9wRo0bfqsPa78I4HV1cQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="ZGP8/z3/";
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4158C606A32A
	for <ntb@lists.linux.dev>; Thu, 26 Nov 2026 03:15:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4158C606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZGP8/z3/
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4bb64ef5a00so52230235e9.3
        for <ntb@lists.linux.dev>; Wed, 25 Nov 2026 19:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795662919; x=1796267719; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sNzRYBNLRKkf0Y/gp9OREoymKpw7SvFmjDC5u9+y2bU=;
        b=ZGP8/z3/1no8K2E1WDpOoxojklCXFEj794LFuMmofOrKl36q817A0ytH1Gr2HWeCed
         ehJJ5c4K2xiMXdALHaSDjAZkEBSNeGS3hf0Q0NwPx9FDi4vuCFfgSPr9QG1nX/XCrEem
         ZPj4rWSKLHybXVrjIiiuTuEqH72IO08BgUJtEQd5l5QI3+vZpevTjKzBlb6bOQSzckd5
         avMtjKkcEnsVMoESIgQgrrYf4dzJt42hhZeXrUXDDMkLk0YwrJjgIzwgLJyAmvJhnQG/
         thLaWasWT1L8bCBIhKzPZDyoVCKbUE73lcYVJ67LdGt9zvU0WjelnKAjx+lZNHU7gkVt
         hRhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795662919; x=1796267719;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sNzRYBNLRKkf0Y/gp9OREoymKpw7SvFmjDC5u9+y2bU=;
        b=RyNuc59Ruj5DQFwNCixz3aRvWpohDxBznEFDg2T77gWND93ZJBAuMmr8OxfJHevtjN
         hBo25nAn6gzwDKktXo52qjfat0WeyijUkwKEg0gBHInLtu6ddvB3Yvfmi0bxRYYG7TKC
         tY3pkZOrFu/Exn3FqYVPXG2bdauactTW8x/eEj1MibBVQCzKmpzYNYK2UsF3Gi74bnPO
         zw3khvkZVhF9DxmW30DY0awbNajvFPXqdFgEPpbJyGpXqGA+13hEtP+8RcEiNrNa/ymA
         DjM3A8oZDCSoReNWdFG4/kr0xV3H4vg1NgDiZ5dlZuPjY3B/jWnUZ2Wn1y+GaleC6mlp
         nLcQ==
X-Gm-Message-State: APuU4Z+ChRLYt5ZjLL8NwocceiohgZB6Bp3Q4Rfadmh4NYV80syJK7wr
	B3TuGhjHPcxtpFWu+7VCYlL5ih7IzYvNT0Isk8+zC1ARYmeESaKL+2qv
X-Gm-Gg: AZFdTZcsmbvMh9GjFMLGXUyjNIVSU8nPEYX/KZ9lPun9gLfcTFWTQ0tG4PfFeo3zbTL
	yqk+49YPaJV3eAKv9xSgBAG6WYm3CmcdQasWFgpt0rKixnFZSjzK2UwZVDrwa7FslAemdy6lWYU
	jyhSbDxyWeMzY+hUDG+I3NMsS8WLIXeqNjfqQ//g5w0koEdH3bM0aDzIRQFLdigMjKOkqyBqevP
	Zd89O4ldxXYD8pYkYF7pNR69EIHMGZk6lQFwgkyGySUFrsV+2EzrWJHzURNprUwu+3lK+PpzkEX
	5yAu7BJzSGvjmFOwabOIWuLHGQ29nq8KSR5V4ff7Gj7kRxLg9ksxlOkkGMebjHbJm6OixjccR5C
	EekmqT5J2Nlif7FdNG0cVknBmY2wdH6RyS3fAouC++q3X9QtoG8q3QDSOKUDwaWgQtaeOVsL0Fn
	gIEdbGjjyecn+T4Tazt0fF4sGZZu1eG6Dbk0LulF6qgkVI66JkdK4sM9XQUjtZvf04c/Vze2jK4
	+ZpBOmhFJErcRSFjG3jxg7erYhndD1aM6ovmgcZDb7htjnZMjV2B0vNtpLynqta4uQvzU066Ulf
	6OOVGJVem+dM6XyqLCn54ySKhzj9KZaT6MJXqSGkq08NF2sMLKSUixOjLZMphO9ZTF9yckAf8JG
	d+SfpyQeRyWjZbzWc87kVr4AKMuwND4bNoLxpIIJiyJX8VK6aoVxAdH66WhR81yonDjXXaBUIel
	+6okRTIlibmmHtyWERTS43Rj29okw+ZUvJ8g==
X-Received: by 2002:a05:600c:3b98:b0:4bb:7033:c92f with SMTP id 5b1f17b1804b1-4bb88826810mr384054565e9.11.1795662919396;
        Wed, 25 Nov 2026 19:15:19 -0800 (PST)
Received: from localhost.localdomain ([31.223.101.75])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6baa3882sm37189290f8f.49.2026.11.25.19.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 19:15:19 -0800 (PST)
From: Oguzhan KAYNAK <kaynak.oguzhan0@gmail.com>
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>
Cc: ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Oguzhan KAYNAK <kaynak.oguzhan0@gmail.com>,
	stable@vger.kernel.org,
	regressions@lists.linux.dev,
	yangqixiao <yangqixiao@inspur.com>
Subject: [PATCH] ntb: ntb_tool: accept hexadecimal addresses in peer_mw_trans again
Date: Thu, 26 Nov 2026 06:15:06 +0300
Message-Id: <20261126031506.165973-1-kaynak.oguzhan0@gmail.com>
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

Parse the address with %lli again, which accepts any base, as before
that commit. To keep the format and the argument type matching, which
was the point of that commit, store it in a long long; it is passed on
as u64 as before. A negative address is accepted and converted to u64,
as it was before that commit. Keep %zu for the size.

Found by running the NTB selftest against a virtual NTB device in
QEMU; the fix was tested the same way (the unmodified selftest passes,
and hexadecimal writes to peer_mw_trans0 succeed 10 out of 10 times).

Fixes: 21fbdc4d0b1e ("ntb/ntb_tool: correct sscanf format for u64 and size_t in tool_peer_mw_trans_write")
Cc: stable@vger.kernel.org
Cc: regressions@lists.linux.dev
Cc: yangqixiao <yangqixiao@inspur.com>
Assisted-by: LLM
Signed-off-by: Oguzhan KAYNAK <kaynak.oguzhan0@gmail.com>
---
 drivers/ntb/test/ntb_tool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/ntb/test/ntb_tool.c
+++ b/drivers/ntb/test/ntb_tool.c
@@ -928,7 +928,7 @@ static ssize_t tool_peer_mw_trans_write(
 	size_t buf_size, wsize;
 	char buf[TOOL_BUF_LEN];
 	int ret, n;
-	u64 addr;
+	long long addr;
 
 	buf_size = min(size, (sizeof(buf) - 1));
 	if (copy_from_user(buf, ubuf, buf_size))
@@ -936,7 +936,7 @@ static ssize_t tool_peer_mw_trans_write(
 
 	buf[buf_size] = '\0';
 
-	n = sscanf(buf, "%llu:%zu", &addr, &wsize);
+	n = sscanf(buf, "%lli:%zu", &addr, &wsize);
 	if (n != 2)
 		return -EINVAL;
 
-- 
2.34.1

