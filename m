Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020137.outbound.protection.outlook.com [52.101.229.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7ED44F554
	for <ntb@lists.linux.dev>; Fri, 11 Sep 2026 07:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789112932; cv=fail; b=Jc1Pvopuqkt1hZbgdiz1IjwZZ51LJQDxE9HLEJd0SjyiAxtzKZhR04BI77E9oEQchk9bYnSRXX5YxhZ12niXf/ZQ8/KLA/wvR5Ja7pVsv8DO01eYD5mNzmtZ5sxFIuly31F7Hnkkia232RLDDp2Y0pPlzu9TZCTmGsjwPO8uuLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789112932; c=relaxed/simple;
	bh=JwJzkxn0D10q6Kn6y0+WwqZ5jfnHxczLUVY4VgtxD2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EIhVsaBV3oqh4G9D2KEOT9HM1b3A3cuGGw9wcDRnNLRwO+51gjPouwqpEMhhCWvzu2JFuz01A33fgch+Xv4BY+EGGPpLu00L2TzWu0BOHyJ9cqyenUhqMit6GYJ1MQQYgVrmgxZjhL4zEAx+IHUG7XkkhP2tKN3174yGnAfzR/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=lungoPHM; arc=fail smtp.client-ip=52.101.229.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="lungoPHM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ym+Jx0oo5cSdbTKof5xn1tS3mhSHO4I5LzDxgTOeqS+l/mowIsXxquPkHbAndbnHATe2oL8F8Htd7QHXScuoFQMAYh7wPoj/RB8Ttw+0oAFYpUUeHVEowcZ3OcJ/m13wB2DA9gk0eMma+jcMOloduEsTr3r4PjQYWyFSxAFEdmXdnNHkWRuWW+FwUD3DA//RD7hIoijZAp7gDbK+A6xORnFa+uVHoVTcWOn4qOefrqxC6K8N9aTv6FAyXwsTVqWPQpQ1JgfDZg4uPcp57/+FME7+XYRRKZp426ReAhCUluAN2lsSNYoaPcGgQBgssa2n2M3OJjGYcKQHpRCj+E2Hsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FUtYiTkOtmlujCG73sTAZW3n4BQY3fyiWgG1pZtCOP8=;
 b=YyUZL1PEmc4bDh7cW0WI0d66ujR5QybvGtgoQWiOHH8l+4DW7sSAhwSf/QkOav/aH/vsC/bZ5dwqN8FtBrevw1oP5Kd4jFTEBiayw8Hcan3sHphf+Be4GBLyX5SMH0ATprznugL+uNohzKRwjbv6yZ4eTP36TtM2Sn5q/qG/fcCmqLtVY7R7cnPdo67tvLR4Cc0xI+voS0yBIQdoO93dmfrxhAVgrIYFc24+6y1QE4PO+2hTWvls+XAXFLXWqbUcEe51sHBfbu830lgDnYxSoapc3Q/Oj+GxQe5J+34KggzdJX+7f1Qd+DqNNE793oWX7LWp72VPcBI4FsbRLqxcLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FUtYiTkOtmlujCG73sTAZW3n4BQY3fyiWgG1pZtCOP8=;
 b=lungoPHMr1MQLuDP5Vt33GnvPrNH0T7ZmBClDixtFk+2g9Ac4KxEcFGBg3R3BxxvcuAYtvCNkzZT0NPmJWsTmaSz4YfptpqlgJx3NSPg9MbbAC2SnY+AX3mOsV+G1b2qLygsVwdjk4DGwSZN3x5kSJVe6ql82vDholeGvByx03k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY3P286MB3583.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3b6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 07:48:46 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 07:48:46 +0000
Date: Fri, 11 Sep 2026 16:48:45 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, ntb@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 3/4] NTB: ntb_transport: Add per-payload
 client metadata
Message-ID: <odfl7c5xkvybndm7sqvk5srhn5cfjlcbswxrmzvnyqrpgxydqi@6o3ic5taxfhi>
References: <20260904052134.2970111-1-den@valinux.co.jp>
 <20260904052134.2970111-4-den@valinux.co.jp>
 <20260910171856.251c90d3@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910171856.251c90d3@kernel.org>
X-ClientProxiedBy: TYCP301CA0035.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::11) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY3P286MB3583:EE_
X-MS-Office365-Filtering-Correlation-Id: eb146b2f-c5d6-4185-48db-08df0fd91c3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|23010399003|376014|7416014|4143699003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	J/jdjEMinS4te738MHuUWJQXTzV4bRurx2cTI3YaYvNTVD7l/WfVjkoQK/BHuCvE4yEkLQGDXJR/1m7PdhN/J/hHKu4XzfJSbN/NONpuD/IJJfmXvTxTwtdl3aqNzzDszBeoBB1GvvdcyMc/bLky/gcRK75qKgvNtc+2AVSvz5vyAj0zuIolz5Ja9rfP21WmKDLCtrY1sShpEZghCw687kIYg9s2XMmCVkttaLioROoep1lesBcHTQNTGhkP8MpY0A70Xbrk8isi8SHeh3lza+DGt65m/tvmFILjQo2H3u/7BtBaFU5lvuJWlPg5Lf7jhj5KcALUTgvml7Zmig5naGjzV8wSE/eBfRhZBqRR2NiPP1bTERcXh0HcFmr9DsfXICYn1pmf5pBc/MBr8QupMrziJJoX2uVgOfeYC6S8jq8dBQdgCCVhMJJavjyOM594u609iR0eIJbPXi95nmwUqqjVs72pAokNEvzZQ8EYq1zsFa6HGWTfKNiXTCuOyGYAm0O6EBiVUtYwItwJyBEqOmqpbVbNG05ztsR6GL0ZnMn5mMgec+Bpq+Y4cKSsBJ4IxbYtNeWqYZsfkoKqf6995OyNd4BDKgVKCLKZfkUnIiSBI4wsMBUJjqAfprkd3nfcFy/UYp3a3pK04ZINu3vaEHshNqWUUp2chEaVJMUl7Uc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(23010399003)(376014)(7416014)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cVV+/pGHAYD7uBbU4S2WPxMfWcBfAYoruzVF1BgCU9QNhUH0vqer7SVGmJi/?=
 =?us-ascii?Q?+lAdlYXt+Aq1hbixfxcO8rnIC1HgEfbjkfguonFhp2pOnUbVgskrxJOPSUfL?=
 =?us-ascii?Q?7nyGcljiny+hD+Qy2IQgQvoV9T1+XAmBc2efjPhVN2q4Z8mQDXFr7Duwnml9?=
 =?us-ascii?Q?fbnP/Djw8p9qmChmrnyqdVIt6efXLM1gvlwPw7tQXmRdwGhzs0wJCbl2wSOV?=
 =?us-ascii?Q?o/qFXsDsBoLVNYm05rghAq1d12pJghmdHWILCi6ix8YfF+iGrV7hVKkiE//G?=
 =?us-ascii?Q?ORNKhQ9yHsHNaPuJN74mRXQxW6eQuwilry035ji0WfaL5Y6yWBaxq4dvTNT0?=
 =?us-ascii?Q?Afhw6HNyKE6pRz43snI3qVfzE/T+aQ0dvYtcxX/3hs6RfP4Lbd4/PF2Yzq+y?=
 =?us-ascii?Q?sQ/gAgKWNQbW1kBqmSM+7Vm29nsjOswkDBjrvY9lEDHfZV27KEEsdu54MoKm?=
 =?us-ascii?Q?/IiabKhUqKF070V6OKe5ms38L9nbWWKn4+wX1vc4kiPqWaqnr3X942P7d/7K?=
 =?us-ascii?Q?8sDQDmzMLynVoc/41wlzPMbvs+VhRetSqcPrj0FW7GGEyXD26f7kVoFPt7Jo?=
 =?us-ascii?Q?AZSKWh30nNGh6mCoFbyceuFlr7M75YMtDgYBr9wYsOEuIoI/zRaBs3tX+KvA?=
 =?us-ascii?Q?bo0ynBm0L90G6EVdrQgBCSWfqh0PjTtqiV/wtqqYYCbnVj2RF+QV5w6tympu?=
 =?us-ascii?Q?11yzNEkjfeBF5rOms9HwS/uAoIiryGZABOamSYVDbDlgOKx4eVB8VgxF/Kxa?=
 =?us-ascii?Q?Y27Y9/oyAG2DJAYnQlzfrnmrLNIeZKk2rkoPvxyHG/myeEpR4PoUsUD8028w?=
 =?us-ascii?Q?NCqePcEjOrbB869xRx/3xNIUN4QHCAN6Zmu/HzaGlY3z/R3cHzT8CmSjhkxI?=
 =?us-ascii?Q?ZmnHXhUj2X+434aksCW+e3ZdAvhm/R4AqIUuwbinTYqZQ8uoxsuZICy7Xa+1?=
 =?us-ascii?Q?wUL18SpzYhqG0yDnacfWQY/lxJIjXdCBM+stzhN6HwtHcfBuF9Rwy3o9TESk?=
 =?us-ascii?Q?57QQ9346UsUKrzp1pDIoTv5oXPcRtfW5aLkU0IuX630MypxHSVVLC0f8WNLU?=
 =?us-ascii?Q?pM4qr2gMW28CJ+1RtUS8gGeFFJkLAd/04NwNdZRY314ywqbdDoWzGBlBr55y?=
 =?us-ascii?Q?TvaYencjLCdwUXBaXgZJcDtHySjEmUGnhSxq0O8QCgbao44b+eL/38lDCTwN?=
 =?us-ascii?Q?kW/+dw9moMZV9xQky7E81dcXVAMwpxLWIPQfR1fCjjMhgYWgWMefDypxH4xu?=
 =?us-ascii?Q?HqY06BEAY+FJLoEqLGRUZL9DTa6cL6F++6+sCHx7+7V8LqH9Sw/eT9ZOEwqg?=
 =?us-ascii?Q?7ytUoGQUgtxGhvmARlT2GahiAKeDPe4QWLrSgtROxeHXwSQgGRhZeArwdYHE?=
 =?us-ascii?Q?iJ4uYxppaVye706pYCf3U0RsDB8HJZqOuGqJwwC8pRs1UpayqheaEtDISAee?=
 =?us-ascii?Q?WFHiHVXjzdLMsL3+7HWPj5QszvQIILmyHZ0QAcczJt0LqzWwe1bKu16NkqnH?=
 =?us-ascii?Q?qqouVVg2inxiFn9S5GzT3T9K8e/q7Hk4we4QydKEbBqWmBeWjcvjJU4Cr39T?=
 =?us-ascii?Q?gbU1nSEZ55iS4b5E/q/daCf7GJNlRiacNV3HaxaA+PKkXr60EICyGGZDt/pk?=
 =?us-ascii?Q?eTfLQ9njOhOeGXFqQT9AAtADOyzqNFEZYd7xY27vserqxNfok5vqdv0eDGv1?=
 =?us-ascii?Q?1P6qgM6Z0C6ZRC49QJnUrybSlmVd5iMBjib2CEV2CvOlgltFKJGMyuEeXVuv?=
 =?us-ascii?Q?MJHAeoVAupIit8HkQxWSd3YWG7if5HONcKdxqUGwbGMRUTClAcaI?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: eb146b2f-c5d6-4185-48db-08df0fd91c3e
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 07:48:46.7035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z8YeAXzwJqhpUIEDXIn97oZoe+/vJyBnjejf/Y0uhxmHeA90bMvNkHJ6lVbPS+v9l0MDUR5kokoS0odtCYUWAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB3583

On Thu, Sep 10, 2026 at 05:18:56PM -0700, Jakub Kicinski wrote:
> On Fri,  4 Sep 2026 14:21:33 +0900 Koichiro Den wrote:
> > +/* Reserve the low byte for transport flags. */
> > +#define DESC_META_SHIFT		8
> > +#define DESC_META_MASK		(~0U << DESC_META_SHIFT)
> 
> IMHO the code would be more readable if you defined this with 
> one GENMASK and then used FILED_GET() / _PREP() / _MAX() on it

Will do, thanks for the review!

Best regards,
Koichiro
