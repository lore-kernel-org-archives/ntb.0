Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585A650271;
	Mon, 23 Sep 2024 09:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727082995; cv=none; b=DmyHCYAtv12b9ysAUDttr7SYJ0kdjlj6DNSMnP43344cyVtQphC/1TPqtc2AvO66R/ggIaLCoevDZVl3aga6RYy8bha4WHtyRC0wL/fbPNUdzrTlff7bciyJvyGioB4Y0lELWiP9eKfxyDHk9xjc2iBH9iF5Jxfk+n80s4xLyOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727082995; c=relaxed/simple;
	bh=I4d1eMOngevenCeV4pyIggCoWxlR/zLRuyoTd/KZjag=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ffha380Hl6y9JPMA9W95NLBJtie13igBhkIoHWcbWgiK2kuxd/jbZgdN10aN0U5Ry8dY9IqOSpOL4gpjBhc8lw1tZcP77tZvg/zFSn69vzzIiwslqLck1jXuL7Q5hjKFNLPCL9V3I/zVkvmCLMmcW8amb2JKactOzhzsVQg/+Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=EdelSllC; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="EdelSllC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727082987; x=1727687787; i=markus.elfring@web.de;
	bh=gEHXQEBo8ric1s6xuJSkm7nhGT69Fh62s8e4bXO/lYk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=EdelSllCkfUndiEax7HY9adBe248/dJ7f6Q61sCmOlmPWqOy5QZ75/KQ/bYstwXS
	 Jo0PE2qMc+Pqx69BRamA+ZmjSLSLpxl+PhZLI7+iU70cYb31xwwhSTA6aDCzHrRGB
	 ZwFub7QKGKqwLDyY4Jt4ZupSTDFvLps4jctHP9eLMiqebaElmTSIqmRyVAtOqCeqE
	 yU5YAMaBSnNPsjDSx9ifOW0DDmpWzE+o9j/EqYD7v/m448dGZBopR+gKsVV/hRPEg
	 Zd0ypm55T9D7WEE3H2FgMAQkrDF9Gys9utS9djtXN1tu7VapOjQIphKqpvNhiwF6D
	 GGeKW2Mbn0sX+1p5Fg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MjgXH-1sDFk93xaV-00fB1O; Mon, 23
 Sep 2024 11:16:26 +0200
Message-ID: <dd95348b-8711-4afe-af8a-62cfb1a1d9f1@web.de>
Date: Mon, 23 Sep 2024 11:16:26 +0200
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/2] ntb_perf: Use common error handling code in
 perf_copy_chunk()
From: Markus Elfring <Markus.Elfring@web.de>
To: ntb@lists.linux.dev, kernel-janitors@vger.kernel.org,
 Allen Hubbe <allenbh@gmail.com>, Dave Jiang <dave.jiang@intel.com>,
 Jon Mason <jdmason@kudzu.us>, Max Hawking <maxahawking@sonnenkinder.org>,
 Serge Semin <fancer.lancer@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <c7654504-a455-4972-9861-39800732d0df@web.de>
Content-Language: en-GB
In-Reply-To: <c7654504-a455-4972-9861-39800732d0df@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SD6MdWnC55/FVomgL7r5WmMFNs2L8PgR6E+yfLGx0+6pae3SJVO
 pSC1RndTpQ2UQ33TNGPYkpsp/f7CbilnMEDblaZ1e5GRcZceilCeedGHgRjTjcT3aOW0yNP
 htCFJ51yvJ/Ys21sU0VusKjRTcUuz6hFIhhfkDDo7j/8iDczrRY+cNIUo6IkbiohwVLaWCj
 IoNg65/emMSCQ50rbbU/g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:sUD3ekOYPhk=;ZXTIq2D+yMvHyDELPJjedeGzUfK
 ptHHJKBSjIAoBn8oXQItZMUi1xQn3ubdr5PJVrJXAy2Dpgqk4b8dNgxrCRS+sRNxegjrOSjrT
 qZtMMZnybJCaJeRJz+2lzIOqC1mSefKxOkK1DEWTBV4RshICB4ngQknBpmKj1QInk68Ym3iTf
 DpLWpa6J+0RdlE1muF+GePd98acP0nI5b9BUNn5OS1rMCdkhjeC0u7BE8ZUGkURKlszf9A1UZ
 RYB57Khpj4A9jxtuHYI+zUWHV/Kw7i139xeMKkU4YQSz8FJKdnQR1vbNV8Gx026IvrZ50koJV
 TTGKI2P59XN5/meXgqRjLPo3FHlPooB3sqIPQjMmNvczfDCH6KcSg22/JCf3X8xLGLkYsV7PG
 rFRYL9uYMOEVbj2R8k/IylQUk7xit4kABZEAVS5jvUEMjN8OzOexg2wev0i8WTq22tsINMY7+
 Shv4S7eW9mFqBS5ekcBFxMnVdZDIQToOJqKLkzjN07Xf5K1bgG5WBMNhErB0HhcLCz1VCc6JT
 EVSjpCov0zsbvm2YTqTHBQjEzSDziKpJvRwBxdoacrHkPhU28Uc0/hJGY16BRaoEQsLz090iZ
 lK4siuzqIVe2nc3hFHTR62m8BRBh07c62osqd+0zEqGvpMkBtuy5OCeUELnyIAO3q89swP3ur
 CRZFoIvOXrnsU4WyJHg5bboQFfExhBRANyZhWFqSSYpHRM9UDknSDVl0LrT+gailqyRT+Ws3O
 5jDlmRYnhoxwrgZE5ZiuSN2btPTMHYGiNdV9Ly03UNqEYEsow1qPSCQpnYy/NPQ23pF78Chs7
 49eBI/lhfSXwbC9DmLS/b3QA==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 23 Sep 2024 10:48:17 +0200

Add a jump target so that a bit of exception handling can be better reused
at the end of this function implementation.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/ntb/test/ntb_perf.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index dfd175f79e8f..88c5192b81eb 100644
=2D-- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -816,10 +816,9 @@ static int perf_copy_chunk(struct perf_thread *pthr,
 	unmap->len =3D len;
 	unmap->addr[0] =3D dma_map_page(dma_dev, virt_to_page(src),
 		offset_in_page(src), len, DMA_TO_DEVICE);
-	if (dma_mapping_error(dma_dev, unmap->addr[0])) {
-		ret =3D -EIO;
-		goto err_free_resource;
-	}
+	if (dma_mapping_error(dma_dev, unmap->addr[0]))
+		goto e_io;
+
 	unmap->to_cnt =3D 1;

 	do {
@@ -829,10 +828,8 @@ static int perf_copy_chunk(struct perf_thread *pthr,
 			msleep(DMA_MDELAY);
 	} while (!tx && (try++ < DMA_TRIES));

-	if (!tx) {
-		ret =3D -EIO;
-		goto err_free_resource;
-	}
+	if (!tx)
+		goto e_io;

 	tx->callback =3D perf_dma_copy_callback;
 	tx->callback_param =3D pthr;
@@ -850,6 +847,8 @@ static int perf_copy_chunk(struct perf_thread *pthr,
 ret_check_tsync:
 	return likely(atomic_read(&pthr->perf->tsync) > 0) ? 0 : -EINTR;

+e_io:
+	ret =3D -EIO;
 err_free_resource:
 	dmaengine_unmap_put(unmap);

=2D-
2.46.1

