Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020114.outbound.protection.outlook.com [52.101.228.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398E63E5A30
	for <ntb@lists.linux.dev>; Mon, 14 Sep 2026 08:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789375735; cv=fail; b=H6wD5c4B+MbpZLM5u6J7Y4Z9pnuk44YM4wDvF54JfMm5QU4Zjp+GcEpDjJ65pCbHoYQ9cneragTn6JXXRHNCqVeodmyAD2di0MfNpAIax2f/uwz6LhhepKlB/bYXDuO3sUDEtRPsuqJIvbLTnltJgPgTFC76AQRRup4nebYpPUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789375735; c=relaxed/simple;
	bh=ZpiqxBRk7OXUSZoGI8tJvhb11X3bpdvaD0vIu1qU+eU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ur4oS/MM1OiO9xjNV9+iRfofAm6LfSksJWs++z+pDsaIHBt8zJcLx3z79xfN+K4QdYYfZzgTqh0FFimPIXRtkVmE4dtPNHs1tdXxBeBtYh8h3bLC7T5KtZJ10h7U1cJ4o3kSnmPP/Va9QuAFmrvCukrZiluYTsqPDgc2vzwAIdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=tYlDRnmg; arc=fail smtp.client-ip=52.101.228.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="tYlDRnmg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JNdM0jkyOkHmlSIepS271FWCmmsN6drL5Oe3pxotW9PcHBgtS87TQ/lYA+gftHWiWBl28zZFGSuTYTownYXz5+CmDcU03rS1eWkL85Nio97z40nZ2rEs6q+VNj381aLTK8QQJbKhXteahG+iapqt7w5C1OHVIDYsTypdFtkVV35WvDbk+yaePMpZoyKRhoKKX39XYmR8A+woRMZl7JdLCOp1+aNOOVGLLr4YldF3QemQguI3oMM5ynCKHt8uo8MKuvdxTdePCZ6XXtXCZ4Wn69NiYVcLjLeTJF8Zhq2+ZeIkUc+04K9PH03cHEXxrxJ2n3Hg4qV98CStJ7DO0qD58A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1K+yIujhq+xYov2GWHI8ub4ifp62GCkjRyH7ywtrYr0=;
 b=lIFIEQpMBs3YbP9B2fOl/wEnCxwMTtmPOf4bokUP0qN1dU8MsPLeGCZk36ehY+LBV0uC2KZJS4ea6CB6xSYzMxGeYzV5PJiY2LTn3f6a8qgTYzdty5OG0VCjb7oU/B407uH1tKODE5Os2BL5SYzLB7CMWXwpa1bQLpU/k7QLLXTf06DDk+/X4nuw7xVB1DgDPqW3UqenUtuvS+ym1sN1cNu8ElYtj8GVM6ld/WWeQHZga2taj5ERr5TcPg9cuDTlftZZ3dGrW+uVyfHi0UaBmT6BqTfivkO1VchlmeddD8UmFyhNViB3kOiwW+T3wMoNgl0jB40a2vsqzNeuB/4YKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1K+yIujhq+xYov2GWHI8ub4ifp62GCkjRyH7ywtrYr0=;
 b=tYlDRnmgqSd4S8DsJyvq9yAEIRejV/U3XuHs4yTESo+aAG8c9mRbnztcerqNENVrm26G9dDlGcy2kXy37bhn5CSdJfwxUxP6qzYQnxdUHrrAkaj52kay3rpWcgn1CHkSCuZPERQNaM9PlYpCQTss7eTpkNvz5c3y4ehpEtkYCno=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYTP286MB4022.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:188::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 08:48:48 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 08:48:48 +0000
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
Subject: [PATCH net-next v4 07/10] net: ntb_netdev: Reject short RX frames
Date: Mon, 14 Sep 2026 17:48:35 +0900
Message-ID: <20260914084838.2158249-8-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260914084838.2158249-1-den@valinux.co.jp>
References: <20260914084838.2158249-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0297.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::20) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYTP286MB4022:EE_
X-MS-Office365-Filtering-Correlation-Id: fcd56223-422d-4e27-deaa-08df123cfe16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|23010399003|1800799024|366016|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ftIke/aBlL4K4VxepViYscgNYtFWybqty1nATX16pZzaMUCdPiehBwRrM4lXlxuiyKVeVVkT4OFxA3vLSgMmFTjNZmgExTLHYeLd8v8BspckxqIsSwz4rLOZI9syBMqDh2rEiiZaBzwe3EeJiSuFWmLPFIKRkNGNnK8+8r1IscxeKL8GG52a28qGPGYqFyLBwh7pLWvsbsEJLueIZv2AC7IItlBIrqqISTtWx7rMaldbq4ICup18y7/+26RRXWAi4HMrT1aJa/hQd/r/Qev+G4UhENw59BWUM6UUWUK6Xy9SCEiX6nHk2vMXWY3xrg51sC+C+pjksrYhFi8nPKcJJ9Q697fpThLuDmhkoBlVpDi5aG/UQ3iDYrpo3uDzjOMNd1nszaH1I0qGgh0Two+M05KzOj2ESYfW7ujaGsph9rdFoGxImL9ouJVSg30haR90Z9Hko8EXi0Pj7qjU6cQB/f6BOG9IgCgCIvT2FV2ETuiOJlQKO4qGx8d0ZmBaQcGCV1rvLWWlkmEoRBtCsqVCQ6kXTa1dGWiFlX9vJsFxfWdFHWPnT1CpZk6QmFk6/udaUv0kNQWzoXHq8o94MR8kiGlaEJZ4sQSNR5AEKP6WLoGOUvbgjy9DjgJiiK3Y4kGYs8DW5ulZwsmH+riGlbDmv8ipO1AT1JBCLJc4cr6D42A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(23010399003)(1800799024)(366016)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ydh3w07NfdR3lxRCXcdRV+CLQN4khNvF9WnLRj5hDhJMbzTdkBRK6gUCo1cz?=
 =?us-ascii?Q?8j32o5xNDBypspKuWs3Mt4w4vrQWkNI9joQ0Rxwle4HZa+Xhi83FVc3gicmI?=
 =?us-ascii?Q?ILS29mL474qT+szOwnknF/rJmV2X+Bu5i37IFVtRsKMGQ6KS3b578xGD6bEo?=
 =?us-ascii?Q?e2mPbo0pEAXHOZLGvd7DRu0C6w0jO0HiAa4fKeUG+QkPNbknxdgUxKJD9nGY?=
 =?us-ascii?Q?ixwympMOVirU5ikgp9CkDvi7k8OqsAg1vgmKumJjtsAthqarNsosAgEejV+A?=
 =?us-ascii?Q?OnOyN5WIn070c/lmjZW+HpcDY8SikyTAB1IAofBeDaLx7X/ZyeoFQVkR31HX?=
 =?us-ascii?Q?ZX025P4zwqiGkrInG7ZkFOPHHfZ8iXmMIHk7D0TvtbqzBYVMKGFhjuy3Qqaw?=
 =?us-ascii?Q?qqo7v+AxCfr5YlUki2lr8S1eWVkPp3jUU/fxlipjjS55MktnKcvDh3rAQUVm?=
 =?us-ascii?Q?w/pbmBINW6GmtxeT3WuU7ODFWuDFnrkqKNWHcyUxrNJsLYPZYVHrz/DOeL9d?=
 =?us-ascii?Q?rLjDP0C3tb7o9+OYk/MyZxyP5MnuZt09TQFqMoI3heokTs8opBR2L6wf64n/?=
 =?us-ascii?Q?hQ8Xq+csxKd4sDNqq5Q7pIlywCAZAOJkha7V9fz11cbBGa62vMTRiOPN2bgw?=
 =?us-ascii?Q?EzDjLAXEgcVOXOcbOB4AjyMO2NZRwkHiVwifBqZm60O/SJdTVZGu+w/Vl7Tx?=
 =?us-ascii?Q?SfqnGh92/W9AwNg0PX4FVM9lexpsG7mzxuLYCubPf3uLcBuYK6Pvo3PPRBEh?=
 =?us-ascii?Q?XRfaXdsmnatgPVCXq6O2rlnO/djEQ12EzUvjDtfKZ4xvQIVgZ0glY3tF7N2N?=
 =?us-ascii?Q?16tNMUEhobLPq6Lr1gLMqVc4aLY3qU5quuUdFt1HUeaxdiMmhqsFY0cZpbpo?=
 =?us-ascii?Q?vVwyU6W1Vz9yJkh6Y9Kx3PQXr3o36aPUMBmRMfSgA7p1gZsu0xUUFHEbFBYF?=
 =?us-ascii?Q?AT4p2c812i6yFlM7s+x3o0s2A7leBb8jLpKrNGrIN/lzBbQ1gvmp2mPTZUg0?=
 =?us-ascii?Q?uNMTRAajmZE228CUJq/rUpK/UUDpeJtCtDUxrw6PEQJyTToSyPY/1feIoz4i?=
 =?us-ascii?Q?x3q6gpcotTepJG4hkNxIgZTE6VYZ+HGMJUbQp6LqegraZENJ78zniRjwlq4r?=
 =?us-ascii?Q?nYi5RJiVYMfaitD2gubPytS8wc4spSTJrXEYDRBUnuYc9/VwkJiOcQ19vb0F?=
 =?us-ascii?Q?JuAD7ErfMy5pDLY14ucX2k7TD238iuJiPqLsbFHu1yF02lDkzD4lgydZVxvq?=
 =?us-ascii?Q?OB6qekaMxT8djykUBhjoi8ZuT/FRcOmqiLmxYoh3+O66oAQhi/89qQd7G7kV?=
 =?us-ascii?Q?oO4qpqyPSY8YKoXAMrH9wgi65Dr2iRFGCfxCoLyIkXo0WEV6p8i42nYzucid?=
 =?us-ascii?Q?p3Q9vWx89l2LK0hFOTjJGxJ82N6QCNtcUtuMnrjvYhH4c1rsAHhJDYwl46YL?=
 =?us-ascii?Q?yEHkne8aFK6/+gSFbdHY7OaospeRQaK66iAycqL+Bo2p0aiOY9ySxLQiOI0B?=
 =?us-ascii?Q?T/rn89ccndLiYsqlT8vkFIpgnEmWzVQoaiBBo1C2yf1ql6UtvGn30376BVXf?=
 =?us-ascii?Q?NzAJcN/IUJwh55PG+qUd9urhzGBZpw9aao2rb9HO9mHA7xD9IhIQ2lNXCZro?=
 =?us-ascii?Q?lGH6Qu2mSxU53HXJYYqLPI0FuemAMRoJB6tcLsPWjrMGB0oBDcxAHcsvMr0x?=
 =?us-ascii?Q?69VRh9TKCq7vtIr3U2RuJ4XoMG4EC8EeYFqXu1//szHN+4ssUR4deD5s0lpC?=
 =?us-ascii?Q?y8iOfHA9YIQK7eRJ/gM5Rm9J0gu/oTgEPIp4z4LjAbhab2tgGtfl?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: fcd56223-422d-4e27-deaa-08df123cfe16
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 08:48:48.1162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cJiQqNr08voVYJcEDyFO46cjqL3x1P+ACH1YPW9CWL2u1E2c9Oio6IjT6vgFlZHK4dYHzGGO3h1QyciMxUwjVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYTP286MB4022

ntb_netdev passes RX frames shorter than ETH_HLEN to eth_type_trans(),
which expects a complete Ethernet header.

Reject them as length errors.

Fixes: 548c237c0a99 ("net: Add support for NTB virtual ethernet device")
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v4:
  - New patch. Included here to fix the existing RX length check before
    adding checks for ntb_netdev_hdr later in the series.

 drivers/net/ntb_netdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
index 78df47659d45..84fdd81ebd16 100644
--- a/drivers/net/ntb_netdev.c
+++ b/drivers/net/ntb_netdev.c
@@ -140,7 +140,7 @@ static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
 
 	netdev_dbg(ndev, "%s: %d byte payload received\n", __func__, len);
 
-	if (len < 0) {
+	if (len < ETH_HLEN) {
 		DEV_STATS_INC(ndev, rx_errors);
 		DEV_STATS_INC(ndev, rx_length_errors);
 		goto enqueue_again;
-- 
2.51.0

