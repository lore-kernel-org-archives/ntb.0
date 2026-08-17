Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020078.outbound.protection.outlook.com [52.101.228.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCA03909AB
	for <ntb@lists.linux.dev>; Mon, 17 Aug 2026 05:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786944938; cv=fail; b=p/lNSrQtpjFVPVMsTfUq/5HbX1iY3giHqvE37XZW9J3cdcA4VpFpIOt2gUD9JcZZCUBgoWA89Kx6eoPVenlC50hBDm6mytjVOjp6HqVsD24J4wuE3VI/zYCpKUdw65GO7g1p7EDO3I8HJsLTb4UTdfJxd91xMwbqwT0f4vmTmNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786944938; c=relaxed/simple;
	bh=eoGT+8j5UZsCwZYNZOI5RNBM+D+mF70ju69eQURsEn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ebFIdOIiRdlxjggXJ7UzlKw39i2+awq91R/q2yHA3TjYsTeez5eA/gPRz2mmXpvIVDfY8Q5t11xY/GhgRCdp4i+FJ4kW439iepQxohJijLSE1HGpU+F0FJY/q2UJBQIyBNeOwYiJFUQPgdyqqvRDd2UfkyaXlZMuazqN3Kp2pkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=i6oX+C0p; arc=fail smtp.client-ip=52.101.228.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="i6oX+C0p"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RZU24ZFBGk71oGf/29cjQVRbKP3PtQz6VaTtCjfpje0o6C64jZ57PREGt77PV+2o0vuz01wJnglbXI3Lt5l6XbHSCOyNS1WrkeSIgbFe6u35CLapSo1RxadaZXey8k4cuxs023zZ2fYCO5H9codIxt3agKiMws7HW868cTdTd3EcvxrPgo1pae9AAqdpqD/W+xQW+WSwhgKZ1gJk4TIxB9sAWWbyz8DmhI+r3bXc2i1cj8c0G1j3vB1taWidmZ5zTYdbHqrQnzT6WlBqQiQKE3VcrUzvXbGux0zr3GMRH6Kn+9aY0Hc+DciwzWqZemrnzpaaVtCAL0r+Lm7ZTjiTsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1FioNml4Esz9PNz7NHMhWK6al3168R9v6xSTk0U24bY=;
 b=nulw5swI492jwcMEhd2xIIEkRm0M6spu4hfVjhrFCpsTEAFJTkExwMFxLHEV9e/jp2ZjJOJ7UTJ56iERkgAoWOIUZ70uzQNKSlqpMvQ++Ou7GZwhxRDtIYq2biQIrdjT80ElfTUk2zLrHraHuM4/88HfFrLqart8eLFLtV1KjEF+lI8BB4YluvEBiw5VVaBU2zQ5bGVU0f5gGzvf4SxrkC39qtqxvcDsyiNz7S7ALaP/k988El/Th7wc/xsl7E8G5YgUMXxr9wAE6Q6R//gR8emizGZjeSMlXj5I07wPRl72clrGNLyWhgVR6VcF0yUQwEPEjJZkRKgkEleVe43Hbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1FioNml4Esz9PNz7NHMhWK6al3168R9v6xSTk0U24bY=;
 b=i6oX+C0p/cOZkwGEBR6lPJgyxEajIkPlelqSyKTHEgMYVE/bhLsqiiZURSBAT7XRf47Vc/cr7aG+4BYc90xYC+ks0ELvRTd6yXoSMYhFIgL/cvZSdqFE0oevQj6y847uxl2vjZS5W6/S/WjvBe0teXrjvsxl0vkSK8BY7VJHChg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYYP286MB2996.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:30a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 05:35:24 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 05:35:24 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: ntb@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 3/4] NTB: ntb_transport: Fail TX enqueue when the QP link is down
Date: Mon, 17 Aug 2026 14:35:18 +0900
Message-ID: <20260817053519.4135287-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260817053519.4135287-1-den@valinux.co.jp>
References: <20260817053519.4135287-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0026.jpnprd01.prod.outlook.com
 (2603:1096:405:2bf::12) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYYP286MB2996:EE_
X-MS-Office365-Filtering-Correlation-Id: 57a9c326-7c86-48c4-5c12-08defc215651
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|1800799024|366016|23010399003|18002099003|22082099003|56012099006|5023799004|10067099003;
X-Microsoft-Antispam-Message-Info:
	9pp9N5AAP63o+mMopdjffaQQ7cdE5qYqJoxE7Ux9kuNDGthTSqCM5GH/p/XSw5/WCvJxh/sDM4ngYwOlP5uwbYOVqdLLbBhcYVv2ZZxeD8hViQDWNOz5T8mqvbU7yvBVwPaiVeSW3ZYgftVU67PNEdBT8L3RWaq8lduwK/KxG9dw7j3Ip1QaUEFc1AXP37s6d8gxk4nJJ6fvYkUIvWmxZ+RuzMbZ+XrO2TIn1qb93/sXRJBvKbPKDsMUygUi0iTffMEt9nk3qSGq/Trb9Il3JBjwzcR31OjySU4Br+9Vtuc4VGrZXytsVK0ckKJz11BMR8g6uMPYk14PX1/TewePgoH0UtRzby9s8HfARNfA4PRCs8GjA+iehRUl4yvB76R29t6K5pVjIPV+EPwzt1nSgOx0rkK56y7g2JxN1UAMJC/79rCDtbAzNZycAmogpIPfHbr9BDqWMHFRCBDxwK2AvRzP59MQykc2+Sg3ktX2/bXhZp+2Af3iRljUiuVbWISjFOwB6Q57C3szKCS1mekt8Ns3K+KvmCzYnXniRHKaFdjED8n10znSzaplIDCg9X31Ag++kXACd3Eq9kiJK7Xj31rATbmGAvcViU22jEvIXRoOnIooNqm2st2FvdaG1/sBBtqZtZ5GV90V71+6gYAuDQf542RkRzi1+nzPjPSGazQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(1800799024)(366016)(23010399003)(18002099003)(22082099003)(56012099006)(5023799004)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?27yyP3Ryp/LzFDRwjv92NX7ho2shUY6T76y1m1YEG70EcdrqVpSo8wTqTz5x?=
 =?us-ascii?Q?oMZLdzJfiWVKKh5CipX/DL2dk8/qeqJRE7jP3pbkjePN+XSmuyZ0nV8crfzo?=
 =?us-ascii?Q?QFeDH0LW2N4rBwIM7W3w4hZwF+gV+4Z2U7dXfMQ9BgqCC/QMPIV1fn08SRBT?=
 =?us-ascii?Q?/Ltg28hywe0KMP5vxl+bOlwB/diV2bdGtp8JEiO60vClCM/L8Vhz0jnApmRM?=
 =?us-ascii?Q?zFYc1jFyh6AmRQolZYwa4hR8Vmu2r3ewHs/jsI7nM+PB8C4VWul+YmsMV9Vo?=
 =?us-ascii?Q?m8i1KWRi0NswlNozdvduHixFAVXjdDNTF9tytoG016n8exHczVjrzotVxOll?=
 =?us-ascii?Q?/F8pjSG+D1IdFmxwvKMS9gTpPDopd5v9I8CNS638fC/t2cGguxPWd8axijBg?=
 =?us-ascii?Q?w0FkvtsqFqKmKa/kbqmusp2UAOB8CUEOeeBi9iE+P9R5SGoF5gPjkz6gq3vL?=
 =?us-ascii?Q?Px0LSiuwEiimf4d/VhxugSZC/IKMGmki93NxNd5hAMbtSJvtNRfcwZosV1nu?=
 =?us-ascii?Q?LOYqm5bK5eVyaGFXWjo8pHhomJYmhnmYVgOTllRN0MTV/2AHPvyTB5w12OMX?=
 =?us-ascii?Q?3+ABZz1gZ2VEMTFz+Wc9FNVnv3oCj61gLMZg6+J1fw+KbSlYPZzFWZtmc/KX?=
 =?us-ascii?Q?AZ/EXZePjRn6448bMp3dW8JmMfzcPza1cdOs7+ZSxmJz7dKLfdqsndJRsKSI?=
 =?us-ascii?Q?vHkCRQPGE3TL+3K4rcUulWgvIprnllcrvwuUBAF2ulKgyH+XFawgBBRCrIr5?=
 =?us-ascii?Q?hXYjack4pTQpYrOfWH/ZZJCyOU0WvVMCGUSuczPfKpMIUGoUPwU+XWkdEYuG?=
 =?us-ascii?Q?1MKvhN67nHtQGP9SjioPSfDNnqGXceGYQ3g89faxorbf+XdIejhWnzdoOanA?=
 =?us-ascii?Q?Tf5J3ZJ/Q5ncWJVJrtWVkFMmM44AmsO7EbOKUgsmox2bi8SUak5qu1RRj+5p?=
 =?us-ascii?Q?7SrN9OMjL39ojb+z92yy4BRlkeetrsPWGQhwCm2hkZMTEBH+IIC7sei+CLwN?=
 =?us-ascii?Q?+Ra2Yjzyc3NRKTMIiK6xuGd0cHPd8P49qrKQWmE/UWTNhf96xLtHvY3z4aCV?=
 =?us-ascii?Q?VzdolpZw9ntjkLaRxJdsY/Ywyn5ik8/bTnsgbtty7uTEbwHVy+okLTb0lLmv?=
 =?us-ascii?Q?qem08MJvtbHeXWMl80ZMQl035Jk2aTyJNgGXqvUoMzaDeqbxVfe9MzIo8B4+?=
 =?us-ascii?Q?MlVhIBFO4FgXhZnzPLdrJiY+Xo4nFhMogK7YzUSH+H2DRzQTgqy3JVIwcbId?=
 =?us-ascii?Q?a7H5Ret/7gAfHGugrCF6o+r+s1XHxeUwaFMLI5esJpTpGz+FXi0p9WXPnD1+?=
 =?us-ascii?Q?YnAF4AdFEe2TIhas8jCnyJYjohG506luw6rCYU9I9QFeff0Kd8tagHbELIlr?=
 =?us-ascii?Q?PboR1AeZ+Q26FqC0rjhvRGsLKtf6YtuJlEfthqJgRYWSUNGHYGNiNGLEZfTN?=
 =?us-ascii?Q?H2vNKWmIxKe7+HQe1ecS0riWqW/a3wFFCQQYqcn0tb/C5jxawdkIJVR4HOgC?=
 =?us-ascii?Q?+jM+9yw4h6r72Nvuq3I6cIQga3wyPJHcJDS9jXGCd8mfAPXcpNVA+ADC505Z?=
 =?us-ascii?Q?Fzg4LSjczvzDxdi6Bs0vqwnSYsiVwslxBAmnhl896BPo2dcU3HkiY3qEclfK?=
 =?us-ascii?Q?bJd8few+Ta0ZQCsLdaZWznSUZeUc3NhQImm6MXGwszTj56w/VKMSyrHipGRq?=
 =?us-ascii?Q?HjQnbIjV4AY9r3Uo09C+ivykC/lMCPN13dSHxKibjSesTKCLS6/z9IlcUn3E?=
 =?us-ascii?Q?NqcNvPL9LeC2xjaeK6TkTqJ8hfH7Gkun8YiMDlHZ9cngQEIUoZRF?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 57a9c326-7c86-48c4-5c12-08defc215651
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 05:35:24.6456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ccVBPuC8LsXxe2ttHEPclXTmGhE2jZbaMd9sB21uZVq+F9UNONm3AN+pp4APBuJBuqFEe81cxSzUHZSEuaxqrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB2996

Commit f195a1a6fe41 ("ntb: Drop packets when qp link is down") meant to
make ntb_transport_tx_enqueue() drop packets submitted while the QP link
is down, but it only returns 0 without consuming the packet. Zero means
success by this function's contract, so ntb_netdev reports NETDEV_TX_OK
and forgets the skb: nothing queued it, nothing frees it, and it leaks,
one skb for every transmit racing a link-down.

Return -ENOLINK instead, restoring the contract that a non-zero return
leaves the buffer owned by the caller. With the preceding patch,
ntb_netdev frees the skb on non-retryable enqueue failures and returns
NETDEV_TX_OK, so a packet racing with link-down is dropped without leaking
or entering a busy retry loop.

Fixes: f195a1a6fe41 ("ntb: Drop packets when qp link is down")
Cc: stable@vger.kernel.org
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/ntb_transport.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index e92b96f4afad..4bdd81edcb87 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -2353,9 +2353,8 @@ int ntb_transport_tx_enqueue(struct ntb_transport_qp *qp, void *cb, void *data,
 	if (!qp || !len)
 		return -EINVAL;
 
-	/* If the qp link is down already, just ignore. */
 	if (!qp->link_is_up)
-		return 0;
+		return -ENOLINK;
 
 	entry = ntb_list_rm(&qp->ntb_tx_free_q_lock, &qp->tx_free_q);
 	if (!entry) {
-- 
2.51.0

