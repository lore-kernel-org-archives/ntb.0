Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021107.outbound.protection.outlook.com [40.107.74.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D9F37D123
	for <ntb@lists.linux.dev>; Fri, 28 Aug 2026 17:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787937126; cv=fail; b=friZfwHnoykg3ed4dE5EsFRNHcy8JKMfGaWBCHNsX3AIJSbuDCdwz/i4Zi7ElK9x9uGNRbtsMyNQd6vpUaIaO8Cf8qODJ6Oy0IME/yvoFPahwBp04E8Db4ZCw2W82c1lOVe8aiU9yACAgvFA/hQCgQROHFb+ts7wVCexy9lWiE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787937126; c=relaxed/simple;
	bh=jEzLJskZqVa7yzsdyyf9fQLCdfkAQRiv6wshqOOdR50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bxJWrStGDYyUGiFSgIC24Nmei7zUMAp9l7sby8tPeV19qXYp1W3qPQTEW+8iO2t7So7J+4bgEpabbAe9rH6EmB0w7Un1jO5mVMxyTlAGwTIR6ycZ0iSpg/KFMcIuLQm4+gMpLF1VLcx8OJsswFeM6JWxaz5kOEglsGIuO2JMO7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=mwexN6rU; arc=fail smtp.client-ip=40.107.74.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="mwexN6rU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U4L/LEAumjb22tZ7KO9QpkopHf0jRZv9rHf4yZJ/24aSVxAzXYvuHceJBu2vC8N64SUt09v496+5nb2T7xoTaYquWAN7/qFxGBNicx/ckRf5o7ZP/rwdekUpQKmg+nW6Y0iUyitx2rlKFzGzvclbck6HKYTb9zfNs+Os/VZcS7ZwG+/1Ku1n99whqOEr26wB39JDxOc8H+nztgJzIraux2FPqInSm/qEuM49+soMsUk5d3AmCGiFZhjBvy4kLAWjdr2btHAi+ao2nZUrrhND9DurNKU4dphgMCVoSyi/5mBEd5FqO2WSTxS5Sxzy9U3sPFAOhE6jt/04ECRrdwPxsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O5FoYBP+S3sSG90jfq1540cgv1MajsGS2KLjoqCKYc0=;
 b=ZAUndDpbrM5KmVgG1DaLCmRpXgDLHzo1ToB2F5Oe1BbFa/1mRjBhcqTIoAImTK8FsQ9cm4Cqif6AT79F0K0bqsmyUV246dWZIUJiUBlhlv544qFI9HNrokN5GRbh/KFi9mQp7E4qavL2K/j03bpSAtfKRf6P/9vvvlH2ip+jMQTNqvzQ4APFQIPXRSciySBKnDEcy5+Lj/WOMQXRsgUtaPTkF0OQXMOdXxNDvosdijzKtjKRWhDYAnu6Ms29+jrtvk8bNc9ufDiEZ1S/+7N9e7DEca8pR749uytse5z382XdEEZATher9aOTltsWleZ7klcDO8+PKz4MgMLLt9TjkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5FoYBP+S3sSG90jfq1540cgv1MajsGS2KLjoqCKYc0=;
 b=mwexN6rUAIDVPoG5SsheUar7BkANooFdNaLpzIjZ1m9NXBAcG6ax6o3foOMVM30sHIafObCcUaoBxgC5BUbAYTExOQcmt0AcDW7oyO9p6/BKWmgwFJhlHy/sQ/AL5V/DI+6lZ49OvUJn2fWM687dgXVIahUTL6z94Mx7VpL6SQY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY6P286MB7951.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:3a6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 17:12:01 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 17:12:01 +0000
Date: Sat, 29 Aug 2026 02:12:00 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Jon Mason <jdmason@kudzu.us>, Frank Li <Frank.Li@kernel.org>, 
	Allen Hubbe <allenbh@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Niklas Cassel <cassel@kernel.org>, Nicholas Bellinger <nab@linux-iscsi.org>, ntb@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/16] NTB: ntb_transport: Implement direct-DMA QP
 session handshake
Message-ID: <fcp4dsvkccohl2qfxthgk64qgqca3o5xfohz3x2pn75wzeu5ft@eosmsao44bzp>
References: <20260810165136.2292436-1-den@valinux.co.jp>
 <20260810165136.2292436-11-den@valinux.co.jp>
 <4ce6682d-526b-4d78-8bff-1dd26422496a@intel.com>
 <jmc2p5uc4bpdxbigmbojwz3p2q47tqjzzhrqrpogmelb6qttlz@yeb73mwowvut>
 <51d2fe16-4a71-481c-a32e-b258cd3be10d@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51d2fe16-4a71-481c-a32e-b258cd3be10d@intel.com>
X-ClientProxiedBy: TY4P286CA0053.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36e::18) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY6P286MB7951:EE_
X-MS-Office365-Filtering-Correlation-Id: c56ce78a-45a8-44bd-7970-08df0527796c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|23010399003|376014|7416014|1800799024|10067099003|6133799003|4143699003|56012099006|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	+8m/OVTH75lQ93MlHZTylCz6/1nBdOZY3T4xfkiPyU7f1QHkx2Tejf3p74FRIxtxe9MigUDYd5D2oJ7ajFZRX9gsK59LZu0ewQ1/qCFmK5KOGQ1MqAA5F9UhWEipjXN8XgFa7SKmR3lsqlM3cLRTDTktud+jZt1Z+H10w/s/iz9RnT5HykJdxuwqTGH2MK8XEdvUo/49HeW/Xiq9V9daXl1A2beb2U0NGjIxyRY0Y2dhqsBJRXBP8Pgo9wagUTNMPhdRiGznAuHEKHErCrJhvVBkWEKlqarSRX5dVQQRwuPPNDtMGlDolAfcgNSz+tCe3aAD3IZGw/v1HB0tih8+tiKFs03t36k0Y2SIVP2APUrB8buyvsUnMqc94zO06H5m0O0GAC5iz1D7iaR+hi/z7AAAwb30knpQHmysKZls4cOgpHJ8TFKK9FqY0lizgXnAM0DMcLB0qMR6HG273EyZeyqSeg6wxdCqDv+WawiCBJ+4eGm/7OIsP0o4/QcP5MApvX+dkhjGBcqzxSkEem7EUDVfN8aOv1KveGG7FPCDc/o8RfFPml/nX6RhnYd4hOvkU1dPeZqA2QrNMvyP7PLS17CI6CaXv6Vo3S1TrCY6BBHesjh7zukolJChTIhb3MPp6Rq1psyavVxy63FvA9paedRpFOn2Rx9O6vO82oEN0oY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(23010399003)(376014)(7416014)(1800799024)(10067099003)(6133799003)(4143699003)(56012099006)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GIRmJnKarfI6pGES03WcsiTTP8Fc5VO4N7zsgDoYPflclnjhg+LyGxVMrn6w?=
 =?us-ascii?Q?DaDzHzusg/Fp3SvTOZyKc7Yx9ZVLH9dovE5lrCM2FgUaGIdLaik8eFLq9GNE?=
 =?us-ascii?Q?RGFISwrr4LRcAwy6QawRiebkSKGr3j4oqom68RMipvHdD5O3zJzRp8DWK9C/?=
 =?us-ascii?Q?HLqO/XGeEWsYM7dmNSkg9Vx1i/RLqr+7bVPRyet4TjXB99vaOHmT5z4EB6Hg?=
 =?us-ascii?Q?MU/OxsAM30epLWZayqsUhCR5hU+rGyfoO1h8DP8DytNOvgROUmpn3mHG3O8n?=
 =?us-ascii?Q?ariX1SA3CPCPIVLXZX5gMgVYp34fzCKYevkg1n8U0FEldr4/9ICHzoSH37lk?=
 =?us-ascii?Q?X8SgN68WXc+kR2N2HYILpQsBJMoUS8+S+mnt9Fth/KIHMJ5I/Ah3Vd7QGg4w?=
 =?us-ascii?Q?yc1x2mmP/qzMcgWQDRBFjHz6nk48hiMk+UKmG2GPWoEDz643m91ANb/3YVvK?=
 =?us-ascii?Q?AKFFnn50Wu2mLBZ8iwZ5Jk7hTMEi8TAXyzaBkVOn/w4lad/zC7zyBAkax86Q?=
 =?us-ascii?Q?8DShV/7mCwplOT7pgi8SDt3NbMVrn0B8mKbjvl8jdr7n0SGrlmGYV/JmNbMQ?=
 =?us-ascii?Q?ankl7F/K7RJzoU5kOZraH7UON6SQFrPCDXKRNfzskr0RWFvOlQ328Bxx7XIh?=
 =?us-ascii?Q?Zj16OHaoMj++cb6GICOeaPXpR7xW/n95jYyAmXjuUwBZl8fF493JU+6weEN9?=
 =?us-ascii?Q?i/JpEEl5tyzDaaNFbP9/fRj3G4lBPpUk+rjHL52Oa10nziWpc1Hqj+KrM3TJ?=
 =?us-ascii?Q?ZwjTgr7z9vOi8UCZmXUBAJAsteiV9GCtB7QunS+CJqpMuLL0PY8gw1KX9d+U?=
 =?us-ascii?Q?z4bWkkCyy9CZ+N91H1mLfK8C+fXuxVPb2JlxELczXV1mrzy4xxdIQ1rT/7SN?=
 =?us-ascii?Q?EK9djQMfPCV4RrQN77Qc5bYoPQPgHQ+3RBtjZsWYKEqvoX1bIUlAUBUvINR/?=
 =?us-ascii?Q?6j7hkMmZRCD9V7kTcgjkFpv1kANPoZczspcGber05ztUzmiAzVjBaM7/t6Jq?=
 =?us-ascii?Q?U/uAGndNU0P0NwgSpkedes5dQS97XQdQids2MO7dUCEckjNKd8kbio9wLXzT?=
 =?us-ascii?Q?EX76jBA+gkS4kQ8DkluS6nRknbCFINFTEwMppHv07xkOftvizjGivSw3QQR6?=
 =?us-ascii?Q?6PJlBZy7RBgoZNPmspXKA6XK3w0R1WHsnzNXXe8I2EA8YyEgHawRBvEPigtv?=
 =?us-ascii?Q?bVdbUevaghGv0jpVw+hEcn4xNJFEpqfVEPStgrpU9k1yQyOfC/KvNEpONP37?=
 =?us-ascii?Q?Z+in+9alrIxhJLR4Q5R5vtsWoPI+kh+CghcDcjVd4aHOO1xQ+RVhjFGAZjwv?=
 =?us-ascii?Q?DjzT1kI7J4x6H+e1ds3qUM+Ecgp6rBDM5RldHjN+5auTJoiMAcR5vEOyeeQI?=
 =?us-ascii?Q?zzLIEeG33LdMQ9cz+3p9xP0PDgbafHgRGeBX8Cey54e3CNghAC98UnwvPfrL?=
 =?us-ascii?Q?D7GM0jdrN1k2w407EIMrqvj4+DAsbb/LwuP45K+Um8w3lMVU9J2hNtLD6Q4W?=
 =?us-ascii?Q?vXHIV7fDrNgP83aZKVxHj7pyTkVOTIbphThYgzq6QyjE/W9I6FlFxEgBelG6?=
 =?us-ascii?Q?miG137xfaMl6mKBQyvWPuVRp23raSHv3g8+QTBW7epAv7bzhxG3d8gNJzrbp?=
 =?us-ascii?Q?6BbXOyUwrP//TlQdEFwazn0CyvpyqK/QhlyNUByfeLX439hWgJMa3y4qJB+x?=
 =?us-ascii?Q?UtnGMrgoo25pTvSnWc2Akr9nlPaPsO78u1dHaMhlxbEKdOl0u18J98HlmQ3l?=
 =?us-ascii?Q?DfWZ/fxerI/MJeOmQD63QekRh8Kg8SkNqF3wvWjXQXSj9QpAuC+g?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: c56ce78a-45a8-44bd-7970-08df0527796c
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 17:12:00.9772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G8P39WEIWW1zWBmDW8P8bZilQOFrGkdLezYg3vec+ZZI7X2ly4wLmZBJni3hiPq8VyFS4Uty3sXH+I58snFM8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY6P286MB7951

On Fri, Aug 28, 2026 at 07:47:35AM -0700, Dave Jiang wrote:
> 
> 
> On 8/27/26 6:32 PM, Koichiro Den wrote:
> > On Thu, Aug 27, 2026 at 09:03:42AM -0700, Dave Jiang wrote:
> >>
> >>
> >> On 8/10/26 9:51 AM, Koichiro Den wrote:
> >>> A logical QP can be reused while its shared memory still contains RX
> >>> addresses and completions from the previous instance. Without a session
> >>> ID, the new QP could accept that stale state.
> >>>
> >>> Give each QP instance a fresh session ID and enable direct DMA only
> >>> after both peers acknowledge it. Teardown also exchanges the final
> >>> issued boundary so RX mappings remain valid until all outstanding
> >>> transfers have completed.
> >>>
> >>> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> >>> ---
> >>>  drivers/ntb/ntb_transport.c | 275 ++++++++++++++++++++++++++++++++++--
> >>
> >> Will you considered moving most of the ntb_direct code to ntb_transport_direct.c instead of increasing the size of ntb_transport.c? Just from an organization perspective this may be better for maintenance and reading in the future.
> > 
> > Thanks for the comment. Let me rethink how best to split it out.
> > 
> > (For v1, I thought it would be fine to keep it in ntb_transport.c, because,
> > compared to the previous ntb_transport_edma RFC, it can now fall back to the
> > standard MW memcpy path, and the vendor-specific parts are gone after moving
> > them under the standard dmaengine API. I had thought keeping it together would
> > be simpler, so thanks for the feedback.)
> 
> I just mean a different C source file with a shared private header file. Still same module.

I see. Thanks for the suggestion!

Best regards,
Koichiro

> 
> DJ> 
> > Best regards,
> > Koichiro
> > 
> >>
> >> DJ
> >>
> >>>  1 file changed, 267 insertions(+), 8 deletions(-)
> >>>
> >>> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> >>> index 67044d0ea0ff..ca08cb690311 100644
> >>> --- a/drivers/ntb/ntb_transport.c
> >>> +++ b/drivers/ntb/ntb_transport.c
> >>> @@ -58,6 +58,7 @@
> >>>  #include <linux/limits.h>
> >>>  #include <linux/module.h>
> >>>  #include <linux/pci.h>
> >>> +#include <linux/random.h>
> >>>  #include <linux/slab.h>
> >>>  #include <linux/seq_file.h>
> >>>  #include <linux/types.h>
> >>> @@ -153,6 +154,14 @@ struct ntb_rx_info {
> >>>  	unsigned int entry;
> >>>  };
> >>>  
> >>> +enum ntb_direct_state {
> >>> +	NTB_DIRECT_DOWN,
> >>> +	NTB_DIRECT_HANDSHAKE,
> >>> +	NTB_DIRECT_ACTIVE,
> >>> +	NTB_DIRECT_QUIESCING,
> >>> +	NTB_DIRECT_QUIESCED,
> >>> +};
> >>> +
> >>>  struct ntb_transport_qp {
> >>>  	struct ntb_transport_ctx *transport;
> >>>  	struct ntb_dev *ndev;
> >>> @@ -195,6 +204,8 @@ struct ntb_transport_qp {
> >>>  	struct ntb_direct_shared *direct_shared;
> >>>  	struct ntb_direct_shared __iomem *peer_direct_shared;
> >>>  	unsigned int direct_ring_entries;
> >>> +	/* Serialize direct session, TX ring, and RX publication state. */
> >>> +	spinlock_t direct_lock;
> >>>  	u32 *direct_rx_cpl;
> >>>  	dma_addr_t direct_rx_cpl_dma;
> >>>  	u32 *direct_tx_cpl;
> >>> @@ -203,6 +214,9 @@ struct ntb_transport_qp {
> >>>  	u32 direct_rx_cons;
> >>>  	u32 direct_tx_issue;
> >>>  	u32 direct_tx_cons;
> >>> +	u32 direct_session;
> >>> +	u32 direct_peer_session;
> >>> +	enum ntb_direct_state direct_state;
> >>>  	void *rx_buff;
> >>>  	unsigned int rx_index;
> >>>  	unsigned int rx_max_entry;
> >>> @@ -509,6 +523,228 @@ static bool ntb_direct_layout(struct ntb_transport_ctx *nt)
> >>>  #define QP_TO_MW(nt, qp)	((qp) % nt->mw_count)
> >>>  #define NTB_QP_DEF_NUM_ENTRIES	100
> >>>  #define NTB_LINK_DOWN_TIMEOUT	10
> >>> +#define NTB_DIRECT_TEARDOWN_RETRY_INTERVAL_MS	10
> >>> +
> >>> +static bool ntb_direct_rx_mode(struct ntb_transport_qp *qp)
> >>> +{
> >>> +	struct ntb_transport_ctx *nt = qp->transport;
> >>> +
> >>> +	return (nt->direct_features & NTB_DIRECT_FEAT_RX) &&
> >>> +	       (nt->peer_direct_features & NTB_DIRECT_FEAT_TX);
> >>> +}
> >>> +
> >>> +static bool ntb_direct_tx_mode(struct ntb_transport_qp *qp)
> >>> +{
> >>> +	struct ntb_transport_ctx *nt = qp->transport;
> >>> +
> >>> +	return (nt->direct_features & NTB_DIRECT_FEAT_TX) &&
> >>> +	       (nt->peer_direct_features & NTB_DIRECT_FEAT_RX);
> >>> +}
> >>> +
> >>> +static bool ntb_direct_link_capable(struct ntb_transport_qp *qp)
> >>> +{
> >>> +	return ntb_direct_rx_mode(qp) || ntb_direct_tx_mode(qp);
> >>> +}
> >>> +
> >>> +static void ntb_transport_notify_peer(struct ntb_transport_qp *qp)
> >>> +{
> >>> +	if (qp->use_msi)
> >>> +		ntb_msi_peer_trigger(qp->ndev, PIDX, &qp->peer_msi_desc);
> >>> +	else
> >>> +		ntb_peer_db_set(qp->ndev, BIT_ULL(qp->qp_num));
> >>> +}
> >>> +
> >>> +static bool ntb_direct_tx_idle(struct ntb_transport_qp *qp)
> >>> +{
> >>> +	return qp->direct_tx_issue == qp->direct_tx_cons;
> >>> +}
> >>> +
> >>> +static bool ntb_direct_rx_drained(struct ntb_transport_qp *qp)
> >>> +{
> >>> +	struct ntb_direct_shared *shared = qp->direct_shared;
> >>> +	u32 session = qp->direct_session;
> >>> +
> >>> +	if (!shared || !session || READ_ONCE(shared->quiesce) != session)
> >>> +		return false;
> >>> +
> >>> +	/* quiesce is written after its final issue boundary. */
> >>> +	dma_rmb();
> >>> +	return READ_ONCE(qp->direct_rx_cons) ==
> >>> +	       READ_ONCE(shared->quiesce_issue);
> >>> +}
> >>> +
> >>> +static bool ntb_direct_tx_acked(struct ntb_transport_qp *qp)
> >>> +{
> >>> +	struct ntb_direct_shared *shared = qp->direct_shared;
> >>> +	u32 session = qp->direct_session;
> >>> +
> >>> +	return shared && session &&
> >>> +	       READ_ONCE(shared->quiesce_ack) == session;
> >>> +}
> >>> +
> >>> +static bool ntb_direct_control_pending(struct ntb_transport_qp *qp)
> >>> +{
> >>> +	struct ntb_direct_shared *shared = qp->direct_shared;
> >>> +	enum ntb_direct_state state = READ_ONCE(qp->direct_state);
> >>> +	u32 peer_session = READ_ONCE(qp->direct_peer_session);
> >>> +	u32 session = READ_ONCE(qp->direct_session);
> >>> +
> >>> +	if (!shared)
> >>> +		return false;
> >>> +	if (state == NTB_DIRECT_HANDSHAKE)
> >>> +		return READ_ONCE(shared->session) != peer_session ||
> >>> +		       READ_ONCE(shared->session_ack) == session;
> >>> +	if (state != NTB_DIRECT_ACTIVE)
> >>> +		return false;
> >>> +
> >>> +	return READ_ONCE(shared->session) != peer_session ||
> >>> +	       READ_ONCE(shared->quiesce) == session;
> >>> +}
> >>> +
> >>> +static void ntb_direct_control_publish_locked(struct ntb_transport_qp *qp)
> >>> +{
> >>> +	struct ntb_direct_shared __iomem *peer = qp->peer_direct_shared;
> >>> +	u32 peer_session = qp->direct_peer_session;
> >>> +
> >>> +	lockdep_assert_held(&qp->direct_lock);
> >>> +
> >>> +	/* Publish the completion array address before its session. */
> >>> +	iowrite32(lower_32_bits(qp->direct_rx_cpl_dma), &peer->cpl_addr_lo);
> >>> +	iowrite32(upper_32_bits(qp->direct_rx_cpl_dma), &peer->cpl_addr_hi);
> >>> +
> >>> +	iowrite32(qp->direct_session, &peer->session);
> >>> +	if (!peer_session)
> >>> +		return;
> >>> +
> >>> +	iowrite32(peer_session, &peer->session_ack);
> >>> +	if (qp->direct_state == NTB_DIRECT_QUIESCING) {
> >>> +		/* Publish the final exclusive TX boundary before its marker. */
> >>> +		iowrite32(qp->direct_tx_issue, &peer->quiesce_issue);
> >>> +		iowrite32(peer_session, &peer->quiesce);
> >>> +	}
> >>> +	if (ntb_direct_rx_drained(qp))
> >>> +		iowrite32(peer_session, &peer->quiesce_ack);
> >>> +}
> >>> +
> >>> +/*
> >>> + * Accept the peer session during HANDSHAKE. In ACTIVE or QUIESCING, a
> >>> + * replacement peer session or quiesce request enters the local teardown path.
> >>> + */
> >>> +static bool ntb_direct_control_progress(struct ntb_transport_qp *qp)
> >>> +{
> >>> +	struct ntb_direct_shared *shared = qp->direct_shared;
> >>> +	u32 peer_session, session_ack, quiesce;
> >>> +	bool published = false;
> >>> +	bool cleanup = false;
> >>> +	bool ready = false;
> >>> +
> >>> +	if (!qp->transport->link_is_up || !shared ||
> >>> +	    !qp->peer_direct_shared ||
> >>> +	    !ntb_direct_link_capable(qp) ||
> >>> +	    ntb_link_is_up(qp->ndev, NULL, NULL) != 1)
> >>> +		return true;
> >>> +
> >>> +	peer_session = READ_ONCE(shared->session);
> >>> +	session_ack = READ_ONCE(shared->session_ack);
> >>> +	quiesce = READ_ONCE(shared->quiesce);
> >>> +
> >>> +	scoped_guard(spinlock_bh, &qp->direct_lock) {
> >>> +		if (!qp->direct_session)
> >>> +			goto out;
> >>> +
> >>> +		if (qp->direct_state == NTB_DIRECT_HANDSHAKE && peer_session) {
> >>> +			qp->direct_peer_session = peer_session;
> >>> +		} else if (qp->direct_state == NTB_DIRECT_ACTIVE && peer_session &&
> >>> +			   peer_session != qp->direct_peer_session) {
> >>> +			qp->direct_state = NTB_DIRECT_QUIESCING;
> >>> +		}
> >>> +
> >>> +		if (quiesce == qp->direct_session &&
> >>> +		    (qp->direct_state == NTB_DIRECT_HANDSHAKE ||
> >>> +		     qp->direct_state == NTB_DIRECT_ACTIVE)) {
> >>> +			qp->direct_state = NTB_DIRECT_QUIESCING;
> >>> +			cleanup = qp->client_ready;
> >>> +		}
> >>> +
> >>> +		ntb_direct_control_publish_locked(qp);
> >>> +		published = true;
> >>> +		if (qp->direct_state == NTB_DIRECT_HANDSHAKE &&
> >>> +		    qp->direct_peer_session &&
> >>> +		    session_ack == qp->direct_session)
> >>> +			qp->direct_state = NTB_DIRECT_ACTIVE;
> >>> +		ready = qp->direct_state == NTB_DIRECT_ACTIVE;
> >>> +	}
> >>> +
> >>> +out:
> >>> +	if (published)
> >>> +		ntb_transport_notify_peer(qp);
> >>> +	if (cleanup)
> >>> +		schedule_work(&qp->link_cleanup);
> >>> +
> >>> +	return ready;
> >>> +}
> >>> +
> >>> +static void ntb_direct_session_start(struct ntb_transport_qp *qp)
> >>> +{
> >>> +	u32 session;
> >>> +
> >>> +	if (!ntb_direct_link_capable(qp) || !qp->direct_shared)
> >>> +		return;
> >>> +
> >>> +	session = get_random_u32_above(0);
> >>> +
> >>> +	memset(qp->direct_shared, 0, sizeof(*qp->direct_shared));
> >>> +	/* Complete local shared-state reset before publishing the new session. */
> >>> +	dma_wmb();
> >>> +
> >>> +	guard(spinlock_bh)(&qp->direct_lock);
> >>> +	qp->direct_session = session;
> >>> +	qp->direct_peer_session = 0;
> >>> +	qp->direct_state = NTB_DIRECT_HANDSHAKE;
> >>> +}
> >>> +
> >>> +static void ntb_direct_quiesce(struct ntb_transport_qp *qp)
> >>> +{
> >>> +	bool done;
> >>> +
> >>> +	if (!ntb_direct_link_capable(qp))
> >>> +		return;
> >>> +
> >>> +	scoped_guard(spinlock_bh, &qp->direct_lock) {
> >>> +		if (qp->direct_state == NTB_DIRECT_DOWN ||
> >>> +		    qp->direct_state == NTB_DIRECT_QUIESCED)
> >>> +			return;
> >>> +		if (!qp->direct_peer_session) {
> >>> +			/*
> >>> +			 * No peer session means RX publication and TX
> >>> +			 * submission never became active.
> >>> +			 */
> >>> +			qp->direct_state = NTB_DIRECT_QUIESCED;
> >>> +			return;
> >>> +		}
> >>> +		qp->direct_state = NTB_DIRECT_QUIESCING;
> >>> +	}
> >>> +
> >>> +	/*
> >>> +	 * Keep the mappings until the peer acknowledges the final boundaries,
> >>> +	 * or until the link is down or the peer starts a new session.
> >>> +	 */
> >>> +	for (;;) {
> >>> +		ntb_direct_control_progress(qp);
> >>> +
> >>> +		scoped_guard(spinlock_bh, &qp->direct_lock)
> >>> +			done = ntb_direct_tx_idle(qp) &&
> >>> +			       ntb_direct_tx_acked(qp) &&
> >>> +			       ntb_direct_rx_drained(qp);
> >>> +		if (done || ntb_link_is_up(qp->ndev, NULL, NULL) != 1)
> >>> +			break;
> >>> +
> >>> +		msleep(NTB_DIRECT_TEARDOWN_RETRY_INTERVAL_MS);
> >>> +	}
> >>> +
> >>> +	guard(spinlock_bh)(&qp->direct_lock);
> >>> +	qp->direct_state = NTB_DIRECT_QUIESCED;
> >>> +}
> >>>  
> >>>  /**
> >>>   * ntb_transport_rx_queue_size - Query the RX queue depth
> >>> @@ -1204,6 +1440,9 @@ static void ntb_qp_link_context_reset(struct ntb_transport_qp *qp)
> >>>  	qp->direct_rx_cons = 0;
> >>>  	qp->direct_tx_issue = 0;
> >>>  	qp->direct_tx_cons = 0;
> >>> +	qp->direct_session = 0;
> >>> +	qp->direct_peer_session = 0;
> >>> +	qp->direct_state = NTB_DIRECT_DOWN;
> >>>  }
> >>>  
> >>>  static void ntb_qp_link_down_reset(struct ntb_transport_qp *qp)
> >>> @@ -1221,6 +1460,7 @@ static void ntb_qp_link_cleanup(struct ntb_transport_qp *qp)
> >>>  	dev_info(&pdev->dev, "qp %d: Link Cleanup\n", qp->qp_num);
> >>>  
> >>>  	cancel_delayed_work_sync(&qp->link_work);
> >>> +	ntb_direct_quiesce(qp);
> >>>  	ntb_qp_link_down_reset(qp);
> >>>  
> >>>  	if (qp->event_handler)
> >>> @@ -1457,6 +1697,7 @@ static void ntb_qp_link_work(struct work_struct *work)
> >>>  						   link_work.work);
> >>>  	struct pci_dev *pdev = qp->ndev->pdev;
> >>>  	struct ntb_transport_ctx *nt = qp->transport;
> >>> +	bool direct_ready;
> >>>  	int val;
> >>>  
> >>>  	if (!qp->client_ready)
> >>> @@ -1466,13 +1707,17 @@ static void ntb_qp_link_work(struct work_struct *work)
> >>>  
> >>>  	val = ntb_spad_read(nt->ndev, QP_LINKS);
> >>>  
> >>> +	if (qp->direct_state == NTB_DIRECT_DOWN)
> >>> +		ntb_direct_session_start(qp);
> >>> +
> >>>  	ntb_peer_spad_write(nt->ndev, PIDX, QP_LINKS, val | BIT(qp->qp_num));
> >>> +	direct_ready = ntb_direct_control_progress(qp);
> >>>  
> >>>  	/* query remote spad for qp ready bits */
> >>>  	dev_dbg_ratelimited(&pdev->dev, "Remote QP link status = %x\n", val);
> >>>  
> >>>  	/* See if the remote side is up */
> >>> -	if (val & BIT(qp->qp_num)) {
> >>> +	if ((val & BIT(qp->qp_num)) && direct_ready) {
> >>>  		dev_info(&pdev->dev, "qp %d: Link Up\n", qp->qp_num);
> >>>  		qp->link_is_up = true;
> >>>  		qp->active = true;
> >>> @@ -1559,6 +1804,7 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
> >>>  	spin_lock_init(&qp->ntb_rx_q_lock);
> >>>  	spin_lock_init(&qp->ntb_tx_free_q_lock);
> >>>  	spin_lock_init(&qp->ntb_tx_offl_q_lock);
> >>> +	spin_lock_init(&qp->direct_lock);
> >>>  
> >>>  	INIT_LIST_HEAD(&qp->rx_post_q);
> >>>  	INIT_LIST_HEAD(&qp->rx_pend_q);
> >>> @@ -2054,6 +2300,11 @@ static void ntb_transport_rxc_db(struct work_struct *work)
> >>>  	dev_dbg(&qp->ndev->pdev->dev, "%s: doorbell %d received\n",
> >>>  		__func__, qp->qp_num);
> >>>  
> >>> +	if (ntb_direct_control_pending(qp))
> >>> +		ntb_direct_control_progress(qp);
> >>> +	if (!qp->active)
> >>> +		goto clear_db;
> >>> +
> >>>  	/* Limit the number of packets processed in a single interrupt to
> >>>  	 * provide fairness to others
> >>>  	 */
> >>> @@ -2070,7 +2321,11 @@ static void ntb_transport_rxc_db(struct work_struct *work)
> >>>  		/* there is more work to do */
> >>>  		if (qp->active)
> >>>  			queue_work(system_dfl_wq, &qp->rxc_db_work);
> >>> -	} else if (ntb_db_read(qp->ndev) & BIT_ULL(qp->qp_num)) {
> >>> +		return;
> >>> +	}
> >>> +
> >>> +clear_db:
> >>> +	if (ntb_db_read(qp->ndev) & BIT_ULL(qp->qp_num)) {
> >>>  		/* the doorbell bit is set: clear it */
> >>>  		ntb_db_clear(qp->ndev, BIT_ULL(qp->qp_num));
> >>>  		/* ntb_db_read ensures ntb_db_clear write is committed */
> >>> @@ -2080,7 +2335,9 @@ static void ntb_transport_rxc_db(struct work_struct *work)
> >>>  		 * ntb_process_rxc and clearing the doorbell bit:
> >>>  		 * there might be some more work to do.
> >>>  		 */
> >>> -		if (qp->active)
> >>> +		if (qp->active ||
> >>> +		    (qp->client_ready &&
> >>> +		     READ_ONCE(qp->direct_state) == NTB_DIRECT_HANDSHAKE))
> >>>  			queue_work(system_dfl_wq, &qp->rxc_db_work);
> >>>  	}
> >>>  }
> >>> @@ -2128,10 +2385,7 @@ static void ntb_tx_copy_callback(void *data,
> >>>  	dma_mb();
> >>>  	ioread32(&hdr->flags);
> >>>  
> >>> -	if (qp->use_msi)
> >>> -		ntb_msi_peer_trigger(qp->ndev, PIDX, &qp->peer_msi_desc);
> >>> -	else
> >>> -		ntb_peer_db_set(qp->ndev, BIT_ULL(qp->qp_num));
> >>> +	ntb_transport_notify_peer(qp);
> >>>  
> >>>  	/* The entry length can only be zero if the packet is intended to be a
> >>>  	 * "link down" or similar.  Since no payload is being sent in these
> >>> @@ -2586,6 +2840,7 @@ void ntb_transport_free_queue(struct ntb_transport_qp *qp)
> >>>  
> >>>  	cancel_work_sync(&qp->link_cleanup);
> >>>  	cancel_delayed_work_sync(&qp->link_work);
> >>> +	ntb_direct_quiesce(qp);
> >>>  	qp->active = false;
> >>>  
> >>>  	if (qp->tx_offload_thread) {
> >>> @@ -2636,6 +2891,7 @@ void ntb_transport_free_queue(struct ntb_transport_qp *qp)
> >>>  	/* Catch cleanup queued while draining RX processing. */
> >>>  	cancel_work_sync(&qp->link_cleanup);
> >>>  	cancel_delayed_work_sync(&qp->link_work);
> >>> +	ntb_qp_link_context_reset(qp);
> >>>  
> >>>  	qp->cb_data = NULL;
> >>>  	qp->rx_handler = NULL;
> >>> @@ -2822,6 +3078,7 @@ void ntb_transport_link_down(struct ntb_transport_qp *qp)
> >>>  		return;
> >>>  
> >>>  	qp->client_ready = false;
> >>> +	ntb_direct_quiesce(qp);
> >>>  
> >>>  	val = ntb_spad_read(qp->ndev, QP_LINKS);
> >>>  
> >>> @@ -2927,7 +3184,9 @@ static void ntb_transport_doorbell_callback(void *data, int vector)
> >>>  		qp_num = __ffs(db_bits);
> >>>  		qp = &nt->qp_vec[qp_num];
> >>>  
> >>> -		if (qp->active)
> >>> +		if (qp->active ||
> >>> +		    (qp->client_ready &&
> >>> +		     READ_ONCE(qp->direct_state) == NTB_DIRECT_HANDSHAKE))
> >>>  			queue_work(system_dfl_wq, &qp->rxc_db_work);
> >>>  
> >>>  		db_bits &= ~BIT_ULL(qp_num);
> >>
> 
> 
