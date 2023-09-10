Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3E5749C
	for <ntb@lists.linux.dev>; Sun, 10 Sep 2023 16:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sonnenkinder.org;
 s=s31663417; t=1694363986; x=1694968786; i=maxahawking@sonnenkinder.org;
 bh=BooXJXIX021ufBUvb5WRfivwZXsb/EQtHjhdIiYTc8g=;
 h=X-UI-Sender-Class:Date:To:From:Subject;
 b=tFVAmwh8pT9yj5MInVlgMraUv+ZQSsFrMbphjei/YuqEalE+hl6JT1AyRi7dC87t08Lzeg3
 ulo+jgC9rfmS5F7t3MWgdtB0jYjwkvEA5YmqMplR7/Sy4wG5OO2xYql8tOOK0zhVBgpfMycCS
 bvGhJd0IT913XKTbUNXgnx3twx58+dGRckStFVqflKRI/QnKSkXTJWLp4BMMfFolgTccmkmdZ
 Ravi2O4ysokz+DuT3ttmxin1ESJO1pO2EF0xKgs7voKz4yhVU4mRsQBTIyEJz7w6KjkxWS5P6
 PgpxSeOiPwHMA6rxDcQoV4zcGjUt60imsqNohURqeAxkQVv5nspw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.209] ([173.228.106.87]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MNbp3-1qHNTG49t5-00P4Dx; Sun, 10
 Sep 2023 18:39:46 +0200
Message-ID: <40984abe-5ec5-c2be-3a72-567c8834570e@gmx.net>
Date: Sun, 10 Sep 2023 09:39:40 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Content-Language: en-US
To: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
 Allen Hubbe <allenbh@gmail.com>, Serge Semin <fancer.lancer@gmail.com>,
 Minjie Du <duminjie@vivo.com>, ntb@lists.linux.dev,
 linux-kernel@vger.kernel.org
From: Max Hawking <maxahawking@sonnenkinder.org>
Subject: [PATCH RESEND] ntb_perf: Fix printk format
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5UYTcnmv74ZHo2c7hu/iBdfM7RLg1W37TErCY+8+xQAu2QUZ1hf
 GSRVy77KMK6L34dwF14ObVUHZxJ+aOSXxD5debusLPLGwB23KZfEq81kbuuKG6pHaCFACPZ
 4DyPeJ/Re1ptAnVli7cHTebfmY9R0OooFEYyEvjSQKw7qTdbUKmcv7pwzu6m9tfdvGHADeY
 JG2zWvHMqCAUTo8NYof5w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xf50s0QeB8k=;5GWrsjzS/mSs9qAndAu4WdwZpAP
 3vOF42eaeFZAAkJtP0LqxCQ1oI11rIUdqui8LCFD2R0ZLd3wfEQqGb2xYRtNdwevS+mXSpNze
 z9DdlSrKPKj39X/+G7E8iNB9zXxyvNnMCGOBWj9Rb7jR3zBdNf/kUscBaMH5XXALwxUypjuYm
 jDY204mVLh/FK9raphwn+YIzixhVqHlRFIdfcad6vVmmya3VqJx0OpmqY7qrD4YhsR8nOGYdV
 IaahpalEYqqYwu/IANckKePhlVYPMK8fLQUOKEOZLBev1fZSTHuVOsGxdGRSsCt5765/H8jiy
 gI62ybAAc6qED+3ressIBrQOdw1Duy2M/RZdpQkRtuF7EN63KCcGlv2xdlsKkuqHAtnR6fStz
 FKai8DVqacryyyADqRxpSPcZUb7KzJddiQ5WdY6Gi2lGkUF9qTRxYrsL9BMyv7Lz/6mgIpNIr
 uNTjcY4IrlSuC1q/heV6Mtor/S0VFOFBk9h9IORRq/PcxZjONkt273R0n0ZrB28mRtOWIQA2y
 XvOP//1O6ehiqcFragPNazUxfWWybmjq24oC+tp50HMvbMHN/LEChjd4DW8FusP40luF7VrC1
 BHY66xtflvP7ntIL1zBjcuxE+BRsuOE8Qpoa/f7oCq08ma6Xrp5F4qJZAD0YVf4I6161NwLZR
 lBjz76bOvJwTz1DxSXqHq4UjnMglabUqwtxYr8jITwsTmuU4HverfVzkpn6zPgjPeSM2ovQsL
 BEBHto/E4FGLwIz0Wn3S+P0WkD6fwa5KJpGx5RPFlPN8y6BNmZXARTeuBOtGYkWq9SZ/p6wwB
 ZBGw63Kgbpg9xDzP44nkwsXE4Qm9DkV7MJ/ObNwRCgZo77zTSTU6ot7Z8/+0ZHqyN8FY9UKed
 a7dDCHVZoAf/4Hm0L/B1kgvBQt4CfcKbppzlTXtoAx+jUZxaZ1uHlF4XO+jVWFOxhA9yQCHXo
 B4rwOZq8kKlUJkzJR1fFunBFaPs=

The correct printk format is %pa or %pap, but not %pa[p].

Fixes: 99a06056124d ("NTB: ntb_perf: Fix address err in perf_copy_chunk")
Signed-off-by: Max Hawking <maxahawking@sonnenkinder.org>
=2D--
 drivers/ntb/test/ntb_perf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index 553f1f46bc66..72bc1d017a46 100644
=2D-- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -1227,7 +1227,7 @@ static ssize_t perf_dbgfs_read_info(struct file *fil=
ep, char __user *ubuf,
 			"\tOut buffer addr 0x%pK\n", peer->outbuf);

 		pos +=3D scnprintf(buf + pos, buf_size - pos,
-			"\tOut buff phys addr %pa[p]\n", &peer->out_phys_addr);
+			"\tOut buff phys addr %pap\n", &peer->out_phys_addr);

 		pos +=3D scnprintf(buf + pos, buf_size - pos,
 			"\tOut buffer size %pa\n", &peer->outbuf_size);
=2D-
2.41.0
