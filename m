Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020093.outbound.protection.outlook.com [52.101.229.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F8037CD2C
	for <ntb@lists.linux.dev>; Mon, 14 Sep 2026 08:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789375731; cv=fail; b=FSu0HPjgI24gqUcUCn+F9qwnG43vOMAPE9HLlaUZkeaqCGVOJWu4VHpU5ooaq2x2eXYJnQMuutkksWE1r9xeu1J/DLsomI8mn80+wOodNvT3H47Y2QcCQHidwTNB+71G/qaZKymM6QhOEGxRlF/soVBcqCdEn0ZTA3cL7Idj5r0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789375731; c=relaxed/simple;
	bh=foZ8+YSp3Ia09R1m+aBXHThQFp/xE22EeboPn+4ZLME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UYgCJDiZjR1fNhP2YNlYIwT5ENtNNpfMxgAMZZGZnTNfJcrlvsIf+0/YWrcqAeIczDpmc4fdxzhwOfIWW4EA0p8Kopn+1fKfPOKujAZHfY2cT/yTdbAWwFep4laSeR8zMAuBrc+MA/mu4yhZYzg7F8VmMMMFTVzlBxE/+IetYZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=rn93oKaD; arc=fail smtp.client-ip=52.101.229.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="rn93oKaD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KP2zL/+SPMQfcTr3yyQYFgs66W0dUgr++pqtamDdYyQy8jCTMQBwCH3pPw+gj8IYew5CSxOaZHkslUBYAFfbXj7sgJw4WfBQ0eA0Qc305AizreEqSX6zBkY0wglsIosR3QxMgUBPtLpbFLdY3e7HRdjsdhz3ETFz1Uul8Qqq1ZztJO9CTkG+vodCA1hvpoALjAm3IvyhVsaHr9xg8hU1t9RQMBeqhbQco6STGcqctcK8UT/oeq2mUUx1DaEqbuCRZUYDRa9oNwpfCtmUrjNZBm9cKL/JVhGzfzf+jd7WUbd1RUjrA9kKguXCbul63Uy6hd/GngIALcDaRp3cMHxmFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WYbRfe8rotDyZFD14lomX/I7s5/GflRA7eBGeMOrpjs=;
 b=Aw8ZH8ARRt3CQaXikkFolDqKiAdKHNSx0ziVa/FgrcbHPMhijgLFe3/tt0wtez2vd2Rbzabg+wKyi/GO5seAtewaiqr5nSWdTuDfWh9fecE6eKKZuwswG8BfWlK64BBJmlvTwapuvQA/7UraWTx+qD3Zhlvsz1/5znezoENKraticPnUJMp1PBFHXpB6gocPJXCku8QUSukWB3YAn0yVm4eKyRW+tn2YcWXcRr21uP3Wvi4L8TzoeZhgYgw1n2DJiDiA22drqifoxGr0bgWs33RXQl761FMas/FRhj2iw+mwqoPLeAygMFssc32sVpt9yBGmXhv4CqixZemUxEVTDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WYbRfe8rotDyZFD14lomX/I7s5/GflRA7eBGeMOrpjs=;
 b=rn93oKaD6NK9gdn9R8Y++M2WHOw12rrJl95bT0701Ambn2pcTAg0q8tyKT+8tAlOtqt2DfVeBNX0Vw6EyKR9UIuBipAnz3rxZJvEGUJhtniqQRbg01VbzQLcRYvwEuEBco97xRiHfRrgfkXf8/fiqvcVzJ1nafLOimFM3WQOWg4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TY7P286MB7153.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:326::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 08:48:43 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 08:48:42 +0000
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
Subject: [PATCH net-next v4 01/10] NTB: ntb_transport: Order RX descriptor reads after completion
Date: Mon, 14 Sep 2026 17:48:29 +0900
Message-ID: <20260914084838.2158249-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260914084838.2158249-1-den@valinux.co.jp>
References: <20260914084838.2158249-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0095.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::18) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TY7P286MB7153:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ae4fd4b-8485-4386-d952-08df123cfa91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|23010399003|1800799024|366016|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	EB9w1TZqVFkyelqSCCc9StJSfcvQzt2Zx3D87mHBk1Aou4RE2wwHIex6bBVxWjWaNfILeMWp4dVKP8DRU1I+taEQpz8Kd/V0nHeoftH+tNtYPVjzMvcokC1LuTODZmzdHHwtqWwlAUeMbasFGP52WNyi12yfrkqQZFnxgjXbEdU4dpjarlPxg9aZM3vghDjLscL8lW1Oo+qWxfr8pbtdA/6PBk4W07F82hs25NP3azQc5YzMcEyxORf9b3+IvHijcz5+JPeGwJYwS0aI2tiAmKS6Gk1okLvmcOCXZpJZxCXumz9dBYwDZbx2knsw5n2Cu48mheNSl6kQVJBNVni91y/q5xXJVTyz2dlj9blUhNnZcO5r+DRjgTC+hoImN5STaC5PqLDCnC71dM4ycO9iDdrtI5ZT5mkc5E8IcivAqnA+Y/kwk0PeOOWYRMGvY88Gjo5cOgiC9oSS1PJiOPc/c47J1Ipu7o4khFhyNsp/670EEYYaBcS6UYiJav6JGitIZlz+2VUnPA7vt/wQuIDOE3JhHeC5RCV9nuM+jwTPPdzeyQQFwxShKchykfTs1Y30x4IDkAoT2DgwAk/M9JmojPFENQ2Fy4OTtWGfsEOe45i8ZbEB8zwX9950XlEZtbSx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(23010399003)(1800799024)(366016)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qet96C61kXgIhLvd0M4WicQk2gRPU0rD89wdShEgE6ivRdx7OUi63WqSa4g1?=
 =?us-ascii?Q?XaHsbQy4x2e2nuXpkVR1o64esRhOY0xxUz7fFNG7r8lazGE0DYoEzBRaRMKm?=
 =?us-ascii?Q?sCt8XFWpJKKiWUyb5HwVAo0JQ+7GgpDsE4KcpxwULA0tBsD5pnopbbF3nwGA?=
 =?us-ascii?Q?O/E7tubBP9PkhXn6fKPwZC4/1hsz40CHR/v2rxZXBf/icohs3gga77Ha5m1T?=
 =?us-ascii?Q?TKjk5/Lt+ndtBdl7ODALIFxeX834vGEjOD8dFRVx3SqGwz1FENc3x7K8x33s?=
 =?us-ascii?Q?I/MzCVegiZ3Z8diq51C0EPId19Wt6Az1+unzqPZyWuEEA8CTz5/f6hrxOdAM?=
 =?us-ascii?Q?PsiRNbm/5Q53HC3jyJ6QvZhNNpxLHB5qdiET5DzGS+rVin6V7wNI0DzXx5O2?=
 =?us-ascii?Q?t8mCizxCdT0SbQLLWvayAKvIBy5/uI+cpzw7ogz2JTQGK4Og5NCa+CZCcYYl?=
 =?us-ascii?Q?avhsbE0YDelY52bu2THo8fbH3JALTstWpHLgacvjR8FFhGovvsC22+1SC/vv?=
 =?us-ascii?Q?jHv0Q0RY7CjND9aBiMllVPUcl7ufG2JqkIgPZHqpXlVUlNev8yXZ3uUG/gXJ?=
 =?us-ascii?Q?j+J0y63aEAS0t5aQsZp6fXtUULrUnXFlED0irJTe7+PzFWfKlehZZnaNY0qA?=
 =?us-ascii?Q?nEhjR60xkLZRCHy+xLifgKBQl9/FDXQ8y7MpxUw/0leSujpNyJRETcqAJ2tn?=
 =?us-ascii?Q?VtrMdJKx5WEX9gdl5AR8DNCyiaC0knVeH+D/mNl6vbJjlSUR7bXCu8oezqy5?=
 =?us-ascii?Q?uU4TLlTJPBGZMujG7GmG57Cl1H+oG5rOyrh3hSFBt0TBp3NgtDQWjJz0kDhQ?=
 =?us-ascii?Q?4Xq4MI2fYc/S0xXimbgQyURFlMCigdd01HgehfufHQY/SUcvSRyINxZMKtRI?=
 =?us-ascii?Q?aNYESwYdcIQIJWhZ0hBVwiOwYMlfJnDkLO33fV5bYanYuA1E3Fv2iois2m2l?=
 =?us-ascii?Q?+qfK5HeGGu/+wmT6DU/cpmdYnklG9hPjJm1WnFx+8x6ETocik2n/jrDuUNjV?=
 =?us-ascii?Q?ULY7k98/TPCWFOl3xtRcZOEh0QFZAKscRkH2gaIwNgrsddyJs1lq5Ke3ugqt?=
 =?us-ascii?Q?uNxMLLBxOmqN5pHgry8hnYzoZEvwWxLnKqwI4OtKQ1/xrhfcN5O85ovD9LRO?=
 =?us-ascii?Q?2U6LXfxlw0p5yT4SKQVAfgKY/HbP6cLKhuQ09nvCbh4JdNMfVzdkCSTZtqt6?=
 =?us-ascii?Q?ausaCD8C/6OKYOBB4oc9ysmys6SiZKSvvh/AV8rz95h0r4EPduKK8YviYGFF?=
 =?us-ascii?Q?b7lI24wJvO/RIHKJ2KOeEpn1FE/BD2uzUiLo+JXzWdU7RG3F/XcG47fUZTe+?=
 =?us-ascii?Q?03xdDbydG1MADpIztpkuvbuaBZOB9k2ePkdhXczalDJZHZz1hSsQwKT6HWnm?=
 =?us-ascii?Q?y1b7I/3HYpB0/yXtiRXKZgMQgdfbFTO5/amGINqu9eWH4E/S5nEctw6RrQ9r?=
 =?us-ascii?Q?nt3n0RVVzeg6/oFqASZQQZgAQG4X2PHTj7LizUonKrQ/cusP8kl7/Bd26qUQ?=
 =?us-ascii?Q?qrbwcunKcujq0+dpZvLB7jovUVvQpalD1mjBr4hlDumOD9mv7sPj1WvRYKuC?=
 =?us-ascii?Q?M8sUVOkIflojOfDeEkmVchTvB3ZISgsMe6/sSjPL2a2FdSlS29y67suWhsh2?=
 =?us-ascii?Q?Eots+8E5HmV9/7LzNfNJENP/abshQTMFpOdJkSefaGPvZABvsb7j4qxt8Fre?=
 =?us-ascii?Q?dtsTsdvHn0vEKYgbLp42b/+BA0JWx8vLrPMU2E6kpdjkkkDu7pka61NJgN3m?=
 =?us-ascii?Q?tD0g4frXL4Ni45V1jPLP4v0epzH/Oe24QkMyJa9pIb3P40vUABYF?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ae4fd4b-8485-4386-d952-08df123cfa91
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 08:48:42.2297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SDEKiSAL7NPDR5+wWSFgYObKDQo7NMfFgkZOARe4du76eaZNuUFXJ1dIBZu/xzMzfcquUYLRHbqiaUEfTnnu7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB7153

The peer writes payloads and descriptors into a DMA-coherent memory
window. ntb_process_rxc() checks DESC_DONE_FLAG before consuming the
descriptor and payload, but coherent memory alone does not order those
reads on weakly ordered CPUs.

Read the completion word once and issue dma_rmb() after DONE is observed.
Use the saved word for subsequent transport flag checks.

Fixes: fce8a7bb5b4b ("PCI-Express Non-Transparent Bridge Support")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/r/20260815032932.151F11F000E9@smtp.kernel.org/
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v4:
  - No changes.

 drivers/ntb/ntb_transport.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index f9caa1a653c5..74f4f8c1c7be 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -1609,21 +1609,25 @@ static int ntb_process_rxc(struct ntb_transport_qp *qp)
 {
 	struct ntb_payload_header *hdr;
 	struct ntb_queue_entry *entry;
+	unsigned int flags;
 	void *offset;
 
 	offset = qp->rx_buff + qp->rx_max_frame * qp->rx_index;
 	hdr = offset + qp->rx_max_frame - sizeof(struct ntb_payload_header);
 
-	dev_dbg(&qp->ndev->pdev->dev, "qp %d: RX ver %u len %d flags %x\n",
-		qp->qp_num, hdr->ver, hdr->len, hdr->flags);
-
-	if (!(hdr->flags & DESC_DONE_FLAG)) {
+	flags = READ_ONCE(hdr->flags);
+	if (!(flags & DESC_DONE_FLAG)) {
 		dev_dbg(&qp->ndev->pdev->dev, "done flag not set\n");
 		qp->rx_ring_empty++;
 		return -EAGAIN;
 	}
 
-	if (hdr->flags & LINK_DOWN_FLAG) {
+	dma_rmb();
+
+	dev_dbg(&qp->ndev->pdev->dev, "qp %d: RX ver %u len %d flags %x\n",
+		qp->qp_num, hdr->ver, hdr->len, flags);
+
+	if (flags & LINK_DOWN_FLAG) {
 		dev_dbg(&qp->ndev->pdev->dev, "link down flag set\n");
 		ntb_qp_link_down(qp);
 		hdr->flags = 0;
-- 
2.51.0

