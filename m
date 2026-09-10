Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020135.outbound.protection.outlook.com [52.101.228.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEBB3B4423
	for <ntb@lists.linux.dev>; Thu, 10 Sep 2026 04:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789013349; cv=fail; b=RRvzCRO6exgmHwBrItygd+WHH2dtYBzd7/6FxPgEC6apLOXoFt+kx/LyRgx7sQyL7ZczBVbHJY8CNrSkJuvaHcFTehsLjUkjRWdcqpwybTDGMDK3oJjFcEmG/s7O05UdIDTbAQbXwvUeUVVMFniLK2LPnZv0A9ds10maSGdsmlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789013349; c=relaxed/simple;
	bh=v/4Qvm0vEp+ycw8WXx1HxXq1/elGVraoldpT6PKIBRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gGDVVOSNsNlHwuqhs0T17akZ5opaeRkkUA7x2m0AXO/I5YEE8cPxvUNq9Y10umPxurs7l9vJCETCdALmWLKaUc5VD+wop7zMgxg3GW5qMhAdqpn/F0qBbu1lND2nuKBBXmnN944dIyxW+0lv5U1lqqa29fN08z/0zzwwyaWw+8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=JljDt+Qd; arc=fail smtp.client-ip=52.101.228.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="JljDt+Qd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=isFNGKrvhoM3YU5Lk/MsaTjDYzzSJSJNz9CFfeIsoBi1u5RA7hsTw+IsfiE8VQuZP6Tz9i7bSJ8pk+7Ki/atVAh+h+xp0Q9DW5YAVHowj/3XW441QtMB+6JjJaJTP74JqibGWhWOIyRimnyPYuiIEmUkAzV3UDfgFfCcSt6M0SFs/zO5ynEFjQyuO5FlWtUnMa2cFzpL0OVUUzqxSSJFJeRY/sfejpAoYfxeuhEGvAJyYA3AY7Tg6+yWjuxHJ59GSOvq/MaPi+NlKtWehrXUOaDP0dUD0RZYYAPBGnc7tu5AFUw9V5RB2ZB2qJ0t0aZ+iZopDP4er9i28FRqjigR4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wUbW1OwyVicALEpXhVI28aUip4G/6mr0fnkbYpV0tDc=;
 b=daxIEb/c1pjLvK4oyDOkk6tEjJ9myn+tdvxDnfGFTCFObTnQp6rvqmUjPsjZyMqA+xHBo0sGd1X2znEGYdl0OTEEHz81whdJ/lL5PRBf7/rXC43rFvxYjkSOsg1tiA/wUsLJ/DV23/Nl7ZaMDGo56UPg8LgbNDs6ARZE7YTgMZXWE6VEoY4KajrunYY6GyQlpERcR1KEjMpcxOmVTheFwvfnhWqX3JwLRrbmMTpE+vcqRWq7gIleUbv9yIW8P2GI0H3Dq2UQGRgxEjbxovh9XhT1RZJFccuxPttMCXTIzlpNv7fcw1vburZJmBEoIQobjj+g/3Zb1LQ/PtHM72iM9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUbW1OwyVicALEpXhVI28aUip4G/6mr0fnkbYpV0tDc=;
 b=JljDt+Qda6vG47QUwCbNqvvLO5w2ylRq3alTDsF3b4/0XCYfhhmrf1rlOpnGgXctb03/J/GU2xtmCLH9i0AcoIDMcVZyAnU1CIoKqcE644EZrA5Bxl5TcVhvpVpXMSMqn4vdYdMMqGh3sWFZKJgxaNZU7yeP21HKv3/zVXikGpM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYWP286MB2220.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:13f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Thu, 10 Sep
 2026 04:08:52 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 04:08:52 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>
Cc: Frank Li <Frank.Li@kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>,
	fuyuanli <fuyuanli0722@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nicholas Bellinger <nab@linux-iscsi.org>,
	Joey Zhang <joey.zhang@microchip.com>,
	ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/14] NTB: ntb_transport: Clear QP pointers when freeing an MW
Date: Thu, 10 Sep 2026 13:08:34 +0900
Message-ID: <20260910040836.3792333-13-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260910040836.3792333-1-den@valinux.co.jp>
References: <20260910040836.3792333-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0011.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:26f::11) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYWP286MB2220:EE_
X-MS-Office365-Filtering-Correlation-Id: 468b60ba-4c69-43b0-5cbc-08df0ef1392d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|7416014|366016|10070799003|6133799003|22082099003|18002099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	9W9JWiAl/8LhtGX2ioPXIxXQAz44nWUWZAixTAhn2y3BBJfPNbw4lhdNTZFF1XnW7EEFakKUui7ZXUSST3GuNEwnDtnthKXaGpGnMJfhhOY+AImo3mR9nw9vJLgbdxL6j+Z4ZhKEzWW3yrMTeZcPw+PeeWYnVU1ymBhNNkwdYhzC8SUJMPp6dEeOpM/hXYnLK2/6h6u+HpvrFCHuze5WgMbPUFIKxfhQJH7j+rDdxxVftl+JgFNEe92nZcSHU7DCi1tXBYHIirj0tZu59fHJm8U24/C5STU8mOS4BhiljXD//IKmujW0qRDxq8gNFmF6YUIcWp1cwBeCIx0PWtkXIncgorAg+3x6cNvAomuVsl5Eqjrr0VrKS98aB9PQsHxJmkOS8/iTgodKOScuxkhtGyytkGDBigFEC3u86ZbsgJQmKjiwmSI4swXCExRJqPUMRfLdK5shesqw7YWuwwlzp3nCdp/zoCZs2WMnLOtkIJQlSDsic/7nArVnFix9uQS1Hd5rFaabzZaymPhy5gg04MTlZxy7SiQXrECywV+mz1DjTnL9ckTexrkgvNbQNCIMpxFC7yTriauMohEzMSSxJa8SLL3c6drf4l/wX+kesMF4DbafNOL2uSKemQDN3xeOncnSfDhhldnB8abDC2BojVZMzzU0I2f9dPSj8C9o1L8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(7416014)(366016)(10070799003)(6133799003)(22082099003)(18002099003)(10067099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mWj55qmcUkyzEAKKowdi1+rUM7LLPiwL7EFO3hphiV8BAelH6PBJvWJO06y7?=
 =?us-ascii?Q?KMbRror6stBXeJy4FNrtjX5NSkzkgpEiqEQs+M648gOxixshKZd11hTnrDR6?=
 =?us-ascii?Q?7dbFjfEZCp2BHoRr/omhlgb/57dteugr3lNSL8sbRAFpcmHbcgoIIp57UWkK?=
 =?us-ascii?Q?BNzrA472J9npzL1krSuOmzOtTb+5lyTC3af3RvTjp85bbIUYdOZO61nY8eo/?=
 =?us-ascii?Q?a3t23eCDxlTTCxN6+073VEGFT67oVUPrtXRfMK1VQ44EUhRlsUctxu4EuB++?=
 =?us-ascii?Q?4qwzjY9Sx+G5TRpx9uNk/LrYvvDap9/N/RzrtgdKdZ0J/B6+RhviKzf5T0jD?=
 =?us-ascii?Q?ExV8ogUnITmUbX5ZAfDdrWvG077J0sXXNnvV1YuPyySvxpVfSCqAPVideYFX?=
 =?us-ascii?Q?ihdS4PxnSQZq2fGEacGAbkoQCDbucBacKQ8nTeyRiEH2Z87FEHssq+d0e8Or?=
 =?us-ascii?Q?rTDnTAIMzuYZqkp6Z0zZlypCyrPOBwtBXKnF2f35Uw1Bk+HxP6vcAkklSLlG?=
 =?us-ascii?Q?6BOVTmwW7R4xHg9saNnvTm4gpA+11LATVJoMV9nmdvb02ePGAvPsEYge9KmI?=
 =?us-ascii?Q?f3fxrAPOhee/mXkfGvFCb4sCh9h0etBKZS0JHRTp6TzwVIrGhKqcB8+WP6RY?=
 =?us-ascii?Q?tnV6E4rnmWCCDEIqP7BF+6C3Xmft4mPKw8bz6nlMmvS8QnwmFcRGM1dem0XX?=
 =?us-ascii?Q?1u7ZcamJG78hctYmbqnYQxOS1qgBUyJn7vA0L1BGokFbYWGl7uvaLlZJu1YT?=
 =?us-ascii?Q?fqV7DmCFP3jt1rUYmDKNwywF7MBUx2zlY7EvMDBvdFaDwnLUpBwESoB+9vAw?=
 =?us-ascii?Q?Y6c3/IZYDuWoVQPngA84+BNNVCD3UlD64Rrzr5xSJ8fmXtmYdfzCut36DuFE?=
 =?us-ascii?Q?ID+WTwEMbzc6+ZDAE5SfLBUH/XSo2rED7F3BhcY3KQHZlFveGN8SLhAaLaf8?=
 =?us-ascii?Q?kodBACrS2l1Ryqyko1M4nuq2l963mbAkmgT3WsSNgDfbgfwZGbJMMjJuIPbk?=
 =?us-ascii?Q?3OD+lHUKLTp2DH78QyDZ1jfXHZTqXU9ud5taYjFs7NKf7RVJsN/J3gsQimLR?=
 =?us-ascii?Q?AbBkOR505xeYMTgHfaANBAoaPbox7+0t+thCSRS/sv6NdjvK4tAJ068bwY+P?=
 =?us-ascii?Q?QAjDhsiylJ2MzzbmM86spcvwPizDBMjwnd0qGx5SYPJD0Xu98vpxIfbZpvL8?=
 =?us-ascii?Q?cx/Ja/EXumz8Vxu+erdFGYHL2eqzfU0G1aMBiucNpdJrkjqSbJ1YhYukV2ci?=
 =?us-ascii?Q?fdP8JaLrAN2iGVOCHJSe+qUO6vEdQvDB7JgaoU4dL00C7ggWHxveWSjJeV/R?=
 =?us-ascii?Q?VCYYiUxHcAj0oAaHlVHq6STqL7/fcOOgi2+/FhpDWyxmZGbpZrm79RQ/4Mpk?=
 =?us-ascii?Q?JTiTGVQ+MyJz4GkL3y8XxtrpPnRcpORl+CDPPWwyAHtbHikZG4WYpAFCQuBs?=
 =?us-ascii?Q?XvTRaLMgrJLd/SmaQxx4zj+YhFrVnJNwbMPH5oB1t6qAeQIh6obnmSErA7zn?=
 =?us-ascii?Q?MerY5k04SPjwh91OuW7lRemV3E9nSjsAfD/I5YxT7Lhm8HGT3gKbWmIPZW28?=
 =?us-ascii?Q?RuhqBovWuVDZVEpLmu065gj5xBmTCkeJx1Jpvx8AJHCug1ARnWYVcU6RnUDt?=
 =?us-ascii?Q?l/KdTuEAUqxS3FrBxxc63dCHZSUwt9j1EeEzQnR6goXggvThyyPyXXmGbA73?=
 =?us-ascii?Q?foG0vH4J9oJtK197BxeFomwI/Kc/oKGeHqnh5/uWKxf6H9WaKeHtMB1qJWup?=
 =?us-ascii?Q?QJWoGx/aTgjdnHUajqexIOpwidC0Zk7tqrF4lNJVg8TL7SwfFuyc?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 468b60ba-4c69-43b0-5cbc-08df0ef1392d
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 04:08:51.9845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ko4auTyGZsVCArYMNUjsKgDfMKp7/Gm0mr8qBR8PFllmNFcNPFCxFOQ4sB46YxFv7w+Uzhx1dmpYe7FoUILjJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2220

ntb_transport_link_cleanup() frees MW buffers but leaves rx_buff and
remote_rx_info pointing into them. With a QP still allocated, another
link-down notification or transport unbind before MW setup runs again
can make ntb_qp_link_down_reset() write to freed memory through
remote_rx_info.

Clear both pointers in ntb_free_mw() for all QPs using that MW,
including those without a client. This also covers link-setup failures.

How to reproduce:

  1. Load ntb_transport and ntb_netdev on both sides and establish the
     transport/QP links once. Stop traffic, but leave ntb_netdev loaded
     on VHOST so its QPs remain allocated throughout the test.

  2. On HOST, unload ntb_netdev and ntb_transport, leaving ntb_hw_epf
     bound:

     modprobe -r ntb_netdev ntb_transport

     Transport removal sends COMMAND_LINK_DOWN to VHOST. Wait for
     ntb_transport_link_cleanup_work() to return on VHOST, using a
     function-graph trace. The "Link Cleanup" message is printed before
     MW release and is not sufficient to establish completion. Do not
     bring the link back up before the next step.

  3-(A). UAF via repeated link-down notification

     Use ntb_tool on HOST to send another link-down request:

     HOST# modprobe ntb_tool
     HOST# echo N > "/sys/kernel/debug/ntb_tool/$ntb_host_dev/link"

     ==================================================================
     BUG: KASAN: vmalloc-out-of-bounds in ntb_qp_link_down_reset+0x2c0..
     ...
     Call trace:
      ...
      __asan_report_store4_noabort+0x1c/0x28
      ntb_qp_link_down_reset+0x2c0/0x2e0 [ntb_transport]
      ntb_qp_link_cleanup+0xc4/0x148 [ntb_transport]
      ntb_transport_link_cleanup+0x314/0x350 [ntb_transport]
      ntb_transport_link_cleanup_work+0x2c/0x50 [ntb_transport]
      process_one_work+0x5b8/0x12f0
      ...

  3-(B). UAF via transport removal after link-down

     VHOST# echo "$ntb_vhost_dev" > \
         /sys/bus/ntb/drivers/ntb_transport/unbind

     ==================================================================
     BUG: KASAN: vmalloc-out-of-bounds in ntb_qp_link_down_reset+0x2c0..
     ...
     Call trace:
      ...
      __asan_report_store4_noabort+0x1c/0x28
      ntb_qp_link_down_reset+0x2c0/0x2e0 [ntb_transport]
      ntb_qp_link_cleanup+0xc4/0x148 [ntb_transport]
      ntb_transport_link_cleanup+0x314/0x350 [ntb_transport]
      ntb_transport_free+0x68/0x588 [ntb_transport]
      ntb_remove+0x5c/0xa0 [ntb]

Verified that neither test triggers a KASAN report with this patch.

Fixes: cc79bd2738c2 ("ntb: Clean up tx tail index on link down")
Cc: stable@vger.kernel.org
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v2:
  - No changes.

 drivers/ntb/ntb_transport.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index b949f36a4f2d..096be87e5ede 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -781,10 +781,17 @@ static void ntb_free_mw(struct ntb_transport_ctx *nt, int num_mw)
 {
 	struct ntb_transport_mw *mw = &nt->mw_vec[num_mw];
 	struct device *dma_dev = ntb_get_dma_dev(nt->ndev);
+	unsigned int i;
 
 	if (!mw->virt_addr)
 		return;
 
+	/* Drop references from every QP using this MW. */
+	for (i = num_mw; i < nt->qp_count; i += nt->mw_count) {
+		nt->qp_vec[i].rx_buff = NULL;
+		WRITE_ONCE(nt->qp_vec[i].remote_rx_info, NULL);
+	}
+
 	ntb_mw_clear_trans(nt->ndev, PIDX, num_mw);
 	dma_free_attrs(dma_dev, mw->alloc_size, mw->alloc_addr,
 		       mw->original_dma_addr, DMA_ATTR_FORCE_CONTIGUOUS);
-- 
2.51.0

