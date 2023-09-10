Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28141FA5
	for <ntb@lists.linux.dev>; Sun, 10 Sep 2023 07:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sonnenkinder.org;
 s=s31663417; t=1694331289; x=1694936089; i=maxahawking@sonnenkinder.org;
 bh=uduYsRahk7i/WLApHkAW1ssxy9JsPpHNWq31ZnQre5E=;
 h=X-UI-Sender-Class:Date:To:From:Subject;
 b=mraY0DVAtU32j09PNbu3njaZcg1PSjOpb8KYzEwlpUdbdSob1l+EejLSz6Yxbwm+lqyIP8M
 kAYAazbpgpO1W9otgqyx/gUTLgucOKY/PHVFPpOJYjytjEv56LL/pVlwjUo4zRPq8PtTunzdX
 nJmoKDsU1IrIUxib+E6bQluVith/njigRN0BSNTp4QX+bJNf2VOCR1cyrT6f2XgAZaN1ptBao
 GvILVRzXNSWiypCJAyr+iYPaNkwZhs56sV2p0yEV+/yTfDEPEE/fTbqSGCPdeuIPtNhBLPwvY
 XIj2lJjJhVa2fnYgt/ihpmsWDZbHyX4WzrDBoXYfWQBqb+pQiDNg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.209] ([173.228.106.87]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MCKBc-1qWxVj0uY6-009RBd; Sun, 10
 Sep 2023 09:34:49 +0200
Message-ID: <f2fb85b9-278d-9e12-b61c-d951c71bf2f6@gmx.net>
Date: Sun, 10 Sep 2023 00:34:34 -0700
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
Subject: [PATCH] ntb_perf: Fix printk format
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:u8A+cnwcfruJt/G0gfFbh6fXDEBIfo5yiTJJcq6+MazBNVXDLPt
 e1/xWI8v7R9J608pWIthOaYAj6w/DZXByEZDtMuGowBX8W/Ca7bAvAAKik3HplUjvYpyW4m
 qLtzWXAIUeXV0/QjD4INZ3e6N/RQhBhFhVP9QIpFoRqmZ7Xf4tCErJic2xPtE38Cq4Kc7Jx
 b6tUCwDJMHvc98jVMlrcg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lw73znpoC0w=;J796ncGRtOFx9PYBzB8Bqc4yPJ6
 YrelQThsV4+m6lco0hV4WQs3Q2Eu0UfYWc9R36DZW+rNZkIVgmE4LWN731hkJQcVe770G7+ZH
 s1anBz657mzGOiN+LnFgg07K6HLdy8RcEg7k7fqZnO4aCRXke4r5MHsaSXSpdAs1zvneMGR8X
 uBw2oXR6qiWeHlihxyc/ZaAdGFzpUc9oE7/MjRtA0+9jwF9GXYSC467GXZD4h9vdNemZTkOjr
 3ZJuJFFYsGrGbKrYsTbJAeFgHUvKFfNV2naUX3RIbMRphSpZRzD3IRa8r2j29Vm6eR1DIY9RZ
 RvwKDFU/yI+v6tG/mGQNPzeofctQjIOfPIQj3kzhvuofNGPcS2SYL8K4IJWfseKkmaQ4H6aoT
 m056qI1T42dyWWadkqOZGawgi8YjdE507zwnTSSESJwGMlE+BZ2JVyi/UecvzyU6rPEi95/lF
 Pd777YvlVr5G4mvI0icu6KWjwiITvxYiGlG1pPR83F6VuulbMXBScukzNBMkTKlwFTPpHCiPt
 US1mpgFJcOiHzH7tcg2PgvGnuIAFdmsiHOm0vEfB5USesotGcFkherJmEcPHHvmAT/02gpppA
 G/Dc7OidrSJczdOPrqaNufCyRktPHayICL7OClFBQRRlKn5nv22xrMz6aR1HbBdLSgst/ZfvZ
 qAWdm1fSci3eAMkP+rsa1KGJm6aS59LNyluXRQz4JTjr5/A9rTrHeCPx81tdQemQPkp/jsrzO
 vrHX51WU4L6rxFawhAmS3dp73P8VINdTY5KdbQhbus/8/SWH8JzqDTqF8m4g3dXAoSRDdrnXs
 sQQB3YTr60XsaVyKLsJSFtCumIDRaQ+Y+A8UK8YNnsZvh1hKh2k1Wb78vhrtn72h44jZyLV1t
 Sv0KDlbckmolOLJaeKY54XDcT5KenJ5ucYDr6v1gzisB7MAmu/OZohvmdgHdykTplOgoGxYuh
 9Bq5j1GbylbxLBLQ/X9ffrfqbpg=

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
@@ -1227,7 +1227,7 @@ static ssize_t perf_dbgfs_read_info(struct file
*filep, char __user *ubuf,
 			"\tOut buffer addr 0x%pK\n", peer->outbuf);

 		pos +=3D scnprintf(buf + pos, buf_size - pos,
-			"\tOut buff phys addr %pa[p]\n", &peer->out_phys_addr);
+			"\tOut buff phys addr %pap\n", &peer->out_phys_addr);

 		pos +=3D scnprintf(buf + pos, buf_size - pos,
 			"\tOut buffer size %pa\n", &peer->outbuf_size);
=2D-
2.41.0
