Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020101.outbound.protection.outlook.com [52.101.229.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A804E4C6EF4
	for <ntb@lists.linux.dev>; Wed, 19 Aug 2026 17:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787160354; cv=fail; b=cEYYRAS7pLi60ejcW5dMIEFezgQ1CL+sbpEaNk12u8B3fMKU9TwnwQqpzasv3DjzN5cYVWDaib7NTNKEsab4Md3G4XvT/iA3TsNqU7hBmiyRhvoDRFPlKAgGRtgHQdHnfEHRwjvZxJnWOgNta5hDILHOWfQVvampDbtQC5knY2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787160354; c=relaxed/simple;
	bh=rcCEVRqOWlcMH6e6mlU1PZutR6V+cZsJ0uijlllH1KU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J6FDX76MO9hKkLEveRacVWUTEr573N3oVbuT2LMMPQEisNPvSgLLpMhYjKp8cf6f5kQ3ppjIeG11uXWiS9ZAQvEHbws8REHVAxJXEe6fJzmner3iWkTJ0TCOqJPgiZiThijapf7K4D6552NwZCReqZei6cDbHSIc/qq5ewdrmMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=qArAdmrZ; arc=fail smtp.client-ip=52.101.229.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="qArAdmrZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MBdskZUl024KLSquEmZjs8Awgossf58BEnDgMUXLj7haYChb0hD9xOaJgEPX0lrHDSW8N3VEHUIW1+R5GksRLe5myea0QfZIubBfppKLhRYRyWgZf7mzURgWM+g2DeTTY/ipMVei5NT8E6TfBN4fupZ4LI+ZWk+1FPnJlqDlEbdCwrx+wHhtdz1h2jwGc86ixX3Aa03KAgyfz90oPYEG5GlCRXP6WfykkANNuTXQ1A9xLwlUbgDvyF0nGQLWfmLiUCP+2lU0FAeniCS/xHQTEk2mlNE6HgPmT0DQ9/EPfoGAeYFAMHYKpQb4ivwwHeV/kttMMQ2jQ6WvvNEFMYH7Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KSr3YH3XPPcWlfQGDRrjudTWO0yEPn5kZOZ+F1eP5f0=;
 b=qa4sOY+679hjWEUmTXN5jyL/ZeW7LDY/Yv2nYUp0w5ooWDhAt+V//K+lIv9UuYJeJN54bT5b/DQiMy0bYY9F6vjJw7FWf1IbvrqjWTxg991NRWh1bGmWKvAfp4RKrg+HDMh8MsPMILeoCEdjBPnhH/EGhkBO8ExOPMXGmcBBC+4zottSybvTevBd6WuTVPV65GxPE7Y+7U2LK5CzhiUdQ8Z9a9q4iweRZOmdgujq7QhKYYFRMHWKfZz1nQ1A1rH+zqdqIGVYVakFqEwkNMsFFlyFIVsYPyNVyBcboPaq3pC36w/c8P9fJ4BiD8nEwgDnqZuNG3jRHFEzVXexKy0iEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KSr3YH3XPPcWlfQGDRrjudTWO0yEPn5kZOZ+F1eP5f0=;
 b=qArAdmrZhsm/a0I8FRm9mcmPg1A65nsg8edgC3NIciG32nP3wp21XTIafJnvPgZqnb4lwj0xt1i9HiQkVyJSyoC5lB11OJpFlyrIpN+cB8xDwUfW4gB7tYjW160ATOLCspetczEMIB1tn9sWV9bI4j8Fqh7esGwFYzyWVsoKHhM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY7P286MB5333.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:1f0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 17:25:43 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 17:25:43 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jakub Kicinski <kuba@kernel.org>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nicholas Bellinger <nab@linux-iscsi.org>
Cc: ntb@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 2/2] net: ntb_netdev: Count packets dropped on RX refill failure
Date: Thu, 20 Aug 2026 02:25:39 +0900
Message-ID: <20260819172539.1450821-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260819172539.1450821-1-den@valinux.co.jp>
References: <20260819172539.1450821-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0032.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b2::10) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY7P286MB5333:EE_
X-MS-Office365-Filtering-Correlation-Id: d3842b2a-261d-4945-1c00-08defe16e5d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|10070799003|23010399003|10067099003|56012099006|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	spQ5bXsCBa6Oit9tHtxIxZDW08q1nMNNIodM3Qfu+8WrBWz9lMGYHm89Uh1oNvPdaLhv6xTuwYtlJHEd9T1A2HKN+8CtUKQiivekQqTT4StuiLgp6hOH9yY2XOTRGICrfKv1EJfTkNvUD76FnqRjuUaYDl6V/mJ3UcSnK+T7i+uSR2KiFkbxFXahas0zBZzRP6Oj/WlDJUFd36B6hVRm78Sb+gGESWH4YVlfTKoVv4xsRbOSUsxxc6c5i1BFfCHjyy9XRo2pQSKves1pKcYUHCgWEjXrBzr/ps7eB3/N3scsDxuk6Q7iIufW/dZP3YmUoOk/icuj+dpVMk6E7GWQyGtPOekM3TLvRB9SXm30FQK5jwcFtQLG+cAgvbnLKYmvUH6qanGe/kFMTbxqeBo5llEaNaWwV/pKInXPI905Y0bPQ1bTar3lrRQ0+rmlaSOSiatzqrivVRJBrURXaUxMnk8xOeb5vgn6tc76Sk5hc0Qd9uWRmV8qXsQnbL/gmG63GOt53VNQbbOofYp5bQB6qtBZuFJklUqzg3FqAL1MtoOw+nFBwogbVCNsgBdIvTeBGzDMpi9nOpV5OMQB4TJZRQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(10070799003)(23010399003)(10067099003)(56012099006)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l8naDzNDcBFwUBUj3fOQ7CrJ8rcgcCBSDaYuE5PLRIWOkgy/rUo6UOq3vdje?=
 =?us-ascii?Q?67lDG+MOgEomS8ZGOpDOkWH0EuB5tfX6U+1LwmsTYXzk5junA7BtOL26eZr6?=
 =?us-ascii?Q?7DE0kdQSbgwvCTm6ZVwI8SZJe4DJO91dzCVyTzrzyz+d6lxa6jn+bIjg2Oml?=
 =?us-ascii?Q?7TmCBDpNeQIKOHf4h5u5mSrI16ohq0ONKzQljO7Am2UQhgEQm+fk5mMi60kL?=
 =?us-ascii?Q?N9CPfiaWmpXiGKBPNHU5mP/nWQEE03XW31uGeBUqUH0Fpm4buy8dX2XH1c4M?=
 =?us-ascii?Q?kL1vTSjXrBOBkDz/DisfMq9Uv/YbXQeHUmf7LryTzqJ47SPxcD/nZ56IBsAM?=
 =?us-ascii?Q?ggzoSFYxTfaOmL5Dm/KYwe8NitVRfbqljzLUMYppZ1B0CvLX7ohyItgLSfvT?=
 =?us-ascii?Q?qb+MPQyAs0b6a34WL1RJM7GvmLfCTeU/18BEkmGvRjiVhYbDo5Kt0EOZKygb?=
 =?us-ascii?Q?OOOQWBejBaTw8PPLqmo4Y6cXGLyMIgd8vz/TiQAtwuE6SIrMbcoKRsyJNKdx?=
 =?us-ascii?Q?TZ15Csq+uC+Kx/+2rbejcQRE0Dlz/FwqGLjiRsKMtf1stZxZVxv5JKBkCD+Q?=
 =?us-ascii?Q?DSMu0Dkx4Q97NUNRCqOq59k6S/cXsWFgfRBk5bFwN1T+7uUIY1ttYi6E0bQo?=
 =?us-ascii?Q?BqAZQDxPQPigQteC8sfrlDjawFveAQDa89ssUMRNKfXjsHUls0g8aeUvlut+?=
 =?us-ascii?Q?5boj5gu/v8vxo6XImzig+ueIFTtrHQc4wu5pCquuCesDzjK/4oCid/nCDEIR?=
 =?us-ascii?Q?dwDq6LAc0rtapJaJNg4JOpjaeesi2BMZGNsUY8eeRnKl85KNus8ICOfQyruV?=
 =?us-ascii?Q?S5Zee4D/SEKJ3/NAXJF+i38S5VF9UNiLdeBUZgkoZzyTLH5zNrVIXBVRvuCY?=
 =?us-ascii?Q?pd1F236G2ZlhPIbjpM/NEsCauNsDjeJaUkRPOQbtgMTQXeuemgAmgF94PbjV?=
 =?us-ascii?Q?EErHH+cNm12APs64Bhn/F2HPYeJNj2xPWFNjJd8sE+FgnES/BJO8A9Kpor1W?=
 =?us-ascii?Q?1nBe0s/GzD47JPRjBKV0v6oOoZTkf5VByLB/CbpXoj3Nv//xTqfI9mP78T58?=
 =?us-ascii?Q?e2w+G3FQGsHkWHi9sTU74y6Un9AFSZ3+SGUCSZ1wVm43zqJN/xZxpGS7I7Uv?=
 =?us-ascii?Q?De3U/He94Z7pd35E0aAh9rtKeHTV/YPASaWlFH3oBuXDpchq1OWwPyQ2ecLp?=
 =?us-ascii?Q?f8YcNdpGFi9ipBgZEaZrlhgJQ8flzqFQH3PIuAAtcTKVV7o4XhXDQEtV39aq?=
 =?us-ascii?Q?AAeeqejhTlQ1gx0vG5slViq6aeXHf/14tjASQjeuFeVHOJJNKh5Knk+8cNG5?=
 =?us-ascii?Q?SDFBAO0Plj5lOkAY8tQX1582tfe+Zcmo/jqZJVAy5m6vRLTytmLxobHxkpBd?=
 =?us-ascii?Q?hT3RlifK6rMnMFNuCyzTft940jyOiRgbVhI+zkDAKlplfFdWgQW0LKd7laXz?=
 =?us-ascii?Q?MoNRkb7SFfs1wb3AHA/ygcGm1E+JaJPDKrmiSNgxe6jNTB5TeQx8zFYWZREQ?=
 =?us-ascii?Q?+L1Uy6cVraAc5WoHeQTG45QQ6DYngAhFEJJubJaCTfwWgGtgQNhhS3L84fxh?=
 =?us-ascii?Q?97ar5Jk0CpzuxGybzY+KIwfJQ9mrbLAnAOFh9MyOY5Dk/17J4P6yew7/7NAJ?=
 =?us-ascii?Q?YgPAdJWh6ah7a+UHUw1F/h6uxmrjgLbWdDcKkm0fEFmFsLMvDnpUiN41vunw?=
 =?us-ascii?Q?nV4qE9mJRXjt94TjNAvOLts93qjWlHiV/3jBkbMdOYHJWjvTHH12R5tEN0Md?=
 =?us-ascii?Q?+b0YCTb/xIL14CYcTGumxaZlayfdg5lawVGJRdl1/uLBBmJYHl9p?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: d3842b2a-261d-4945-1c00-08defe16e5d5
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 17:25:43.2329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xO2AVX80Zup+/3FhP1vz8wTRpNrF5sovgL20P39zeLfCGwqkC0gVujFGhxhUuPVMokX9OawJ62OdoDOCSirT5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB5333

When replacement skb allocation fails, ntb_netdev drops a packet that
was received successfully and requeues the original buffer. The drop is
counted, but rx_packets and rx_bytes are not.

Count every good packet before allocating its replacement.

Fixes: d2121faf133a ("NTB: ntb_netdev: Preserve RX queue depth on allocation failure")
Cc: stable@vger.kernel.org
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/net/ntb_netdev.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
index 4e53b00f016b..5bb0c8be00f9 100644
--- a/drivers/net/ntb_netdev.c
+++ b/drivers/net/ntb_netdev.c
@@ -144,6 +144,9 @@ static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
 		goto enqueue_again;
 	}
 
+	ndev->stats.rx_packets++;
+	ndev->stats.rx_bytes += len;
+
 	new_skb = netdev_alloc_skb(ndev, ndev->mtu + ETH_HLEN);
 	if (!new_skb) {
 		ndev->stats.rx_dropped++;
@@ -156,8 +159,6 @@ static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
 	skb_record_rx_queue(skb, q->qid);
 
 	netif_rx(skb);
-	ndev->stats.rx_packets++;
-	ndev->stats.rx_bytes += len;
 
 	skb = new_skb;
 
-- 
2.51.0

