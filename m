Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020104.outbound.protection.outlook.com [52.101.228.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB089460
	for <ntb@lists.linux.dev>; Fri, 28 Aug 2026 01:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787880744; cv=fail; b=a0InmtuKZcQB6HpTVwFQVGmHMgMd2oq8XbQoYapK645k515r8gyWD+Cqo509W9dqnOt62ngUkmrXdTD5cjspH2Xi8dGfuNcdvcwwEQk52j3HVV55bj6sWJT2kRjIrRT2uUGbtcm9u3eCtuhgv1ntEsXRpoDy/ED1cA7tWigRmu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787880744; c=relaxed/simple;
	bh=lCLlLc19t5RvemCHXp/fR9yJAzI4WnDfl+Jyh3kP3GE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iQ6qEYm1PZgPz++yujrsv15efZaDRwo22O3tpkE5DnWElP39BcMfjfYIZZ+kOQBfiGo+2zAcSsoa2taPRasBEl559CItIV2uceGAPYT7IpUzWdSus/2Aq+e3sst1jg2yPWR4So3nThhK4k8g8HsklalmxCUCu6wZhl4x7s3GwPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=bZxqsBTt; arc=fail smtp.client-ip=52.101.228.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="bZxqsBTt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yR+JtmUVyxRUMV0xDgnY1Pw6X874wGEtiuJegNzRud8X+n7WycR7qc7NTSbLBCLg3yOPJY9vUC3DMUQ4nULLzzMxveJtZLDOKi1u6DoEqrwYCZ4Q1zUkTZr7ZUBS6Smmfa4mXzvPEFfc5KFjWbFQ4b4S6dcx5k5ZjQiZfGC6aaNKtDD+KHMOt7jp2bIkkZZem2U2CuUbfVfRq7TGr69P5wPZQsjnINevLo8sFuyigrpxOIM1AEQKuWaV1y5QvbN/YC98vR+i0WxsxSXP+iv1vGS057gz+7pFON7MnxInJ8Jxc5bxGHllHgRVunxlniLhEm7FQWe5MaGokaYZOqZ3Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6j3sbz6CUPIMp42SO496+yRNoGMwAw9KWodekZLIhwA=;
 b=GX1pOYnabuRwX4d6aIFUB6sFQIW4CyEVZYNzOFYUPXF3/8uxJmioB/rAiWCibehXNeV4udSrke/JXUuFC8Ih7kgHN/ZTgw+1r2tfzqkYGBeEiy03IMZOXibIer2EGI9xwHpfMqmJLUTOMEQdLoH5MhKnw6LLXt1zBH760NfEjkd0d1sqBvxYAmfimPdnG3innRKg8xwoxi71XntjHhWAICSXi/Wsjip8Ic2gkOR/5rffFXcCGV8Lt8yljn4pAWNK56Z94yUdv000vN/xoFaoc/6kmwR8QhcV6Vt497bFgP+OvrQrFo5C4zafsGLcXfm4o3r6Ka9w9W/EM5Ko75RXUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6j3sbz6CUPIMp42SO496+yRNoGMwAw9KWodekZLIhwA=;
 b=bZxqsBTtjmTjXTlI1n673dGOuGlwUJAbfbOOPkPSa50YJ1UBJDl5wo2BM7F6iQtT92zmDWM020C1KKxaVZ0yKnKJLcXicvt/RzLD6UOQByzMf1YZQMbo1aDqO8AXt9CAjg5OvdQR0F9Eb8dyAEQeo6hfqyLWghiO55fTQm4LZMk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYTP286MB4085.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:188::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 01:32:18 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 01:32:18 +0000
Date: Fri, 28 Aug 2026 10:32:17 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Jon Mason <jdmason@kudzu.us>, Frank Li <Frank.Li@kernel.org>, 
	Allen Hubbe <allenbh@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Niklas Cassel <cassel@kernel.org>, Nicholas Bellinger <nab@linux-iscsi.org>, ntb@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/16] NTB: ntb_transport: Implement direct-DMA QP
 session handshake
Message-ID: <jmc2p5uc4bpdxbigmbojwz3p2q47tqjzzhrqrpogmelb6qttlz@yeb73mwowvut>
References: <20260810165136.2292436-1-den@valinux.co.jp>
 <20260810165136.2292436-11-den@valinux.co.jp>
 <4ce6682d-526b-4d78-8bff-1dd26422496a@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ce6682d-526b-4d78-8bff-1dd26422496a@intel.com>
X-ClientProxiedBy: TYCP286CA0283.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::11) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYTP286MB4085:EE_
X-MS-Office365-Filtering-Correlation-Id: 16e1222b-574b-4af5-96b8-08df04a432cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|10070799003|1800799024|23010399003|10067099003|22082099003|6133799003|18002099003|5023799004|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	sAOY1aKcINLvzTC3QolNTK7m4HCpLJXpYmsI9Ekk9DT7ub9gfWe6q4BoZueSEmiEP+BUqpUfRflyflj6n8p2IylVBQH5oy5TQcubwdihnM3xlZymjD/hLu6SWVOqTlZghllLkP+XX0/IbviB+81KWJ30bdT+Lqqi7X0Klv++1ksuHpoaommC2egJfiTNRQlp8l4vki/srL0QLBFOQq/q4i9wCVwly1sU9VEsf/nA0PHvsgf4uryK5N5wsIBBB3Dw0tOKwd5K3B/Rr+FoOyonSQaR1rMNrQ4XYqkdZLxJoK1A4e6HjDYkzhInQiNQUfZif+4zbHsE1UaKR8xe9YihkOJGcbopqESyjGyqariFofZGtRhGVHDbbzrNX9oOYvgTvRgMnbPra8lvQXG1NiGrdNaoC6Uc9+pJZHmOAcO+TF5jZg0ibRUY6xMqPs2UsD2eLEjrJv394pEUiEniTAH7tyC1LhKTHY8q0vI9NgsjHiCECLpKDMfsXNY5gJXGDjNJGm/pbenZC87EQDiHQWaO1x65pAIn9G5x2B6IRhskPXQBb+SQg1b3LNkGoB8fC2RArvdpa/yEI1Oi3/y/rzGEpNfsCRMx/gW1sXltKuOPn/EIBsov4RR2TV2FeG2TvmJwMKbpW8zdPSJV4ixAsE9iEJYpH+LWfreB2SCo3V4Jpe4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(10070799003)(1800799024)(23010399003)(10067099003)(22082099003)(6133799003)(18002099003)(5023799004)(4143699003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WrBWl/Iqiu8ioiAN6PRF6D3gliI6fFTqQp1ifmYX6JpexfeVwyh1ZKzZo3lW?=
 =?us-ascii?Q?G6yNSg/g2PcHkk6tCu9rY28Is+tSR0TEKDY9JCnqfKf7jyYX4xDhu7fo+TZc?=
 =?us-ascii?Q?t5vOjQqet1Z8gNJVLWhjK6ccpazJPyRdHRGR0uCBm1pooPrQMm6hsfcGDfl+?=
 =?us-ascii?Q?4mWCJiCgilQiFeQxdyI8/ymemhWl1ViFf/UH4+VLFnu/ecKzbHESh7jlmxdu?=
 =?us-ascii?Q?93ueyCsw8kuKm2WKf0BfOFD1W2hwkqqnNzq5/I4bzWlttq+MfpVDtsoXry9d?=
 =?us-ascii?Q?SQVWoD2s4baZOwNsx6kBMkOUFLOdN8wzoscOJw2JDM3gjQgXsGC3xgrSIkwX?=
 =?us-ascii?Q?skRrPJ198SVrYyMCJh02W/x/d3jBNiA/n/HrsxOrI4aBtp0y0GJlEIXLEqjW?=
 =?us-ascii?Q?pEeYu0hDXI6nM9vmATFOuLhGj26Q/9OdLj3OfWJ26H51kFI8Lnz/CKwxSLUO?=
 =?us-ascii?Q?T6b25UJth8jAFQAnbDV7DJ51eUHE0tvQNgFJzL3IfYrWb1GZRstrKUX6zEwT?=
 =?us-ascii?Q?oYYTSBSe6P1PQyU/7bdJEwmFRgsox3jPNqt4a4gfD4/jIiTde3kBKadz9YI3?=
 =?us-ascii?Q?3Y4kb9UZlZEkWRP7vOuxSzjsYooqq68DX5IKLAfblJUPI1KXaMJNgtoe2aHM?=
 =?us-ascii?Q?eFIQu25UzL4IsJVljdMu4dhqr2Gpz0M7eHiYWs5R0mN7YaWkZW8rc6h5+sbS?=
 =?us-ascii?Q?Eq1aSFvhELq4j1ZpgJVJXR/Gu+fljR3hOLxRyVe0GuhgmTeodSThB1T5mYSH?=
 =?us-ascii?Q?MUkEQWm2QNO+BWXlUCZP5+R050LDiJ8h9EakmBtPij9rJP6TtEfnPL9OpM5Y?=
 =?us-ascii?Q?HL06neQ6WTs17ZSJlOEhSv3nHyARDrOLlMDlC2dDm9b4TNJ3ULwGveucEYzH?=
 =?us-ascii?Q?lwRGvO3QphiUWRSUydU5Gy7J7BLJf3MrcwkqS6Sa7V8EBugYcTOenTpVhXoE?=
 =?us-ascii?Q?TPYaA1SlcVAEVqa99zNHH8DLolKgDVctgbbyPuYHcFal9zmG6ml53a5H75Qg?=
 =?us-ascii?Q?kUG238JZ1tRkTf875OnLLCucvF82LyLguPihzCBculPY/uSbFteD8p5jWnGP?=
 =?us-ascii?Q?Ervsq/VCSu948izcpR4axpzi5ov1/Ovza8QGyX94cYhcLXzI53xjDWQaBgkD?=
 =?us-ascii?Q?xbtrViJcrHnpPUmnWX5UKJxX/vObOZwum2GXLtWPLM78LvV4DLBARPnAeD36?=
 =?us-ascii?Q?9+j3lSm/75PAOjrOVseN9k+ajQxUzqjKkQ5kjnbHfgJjplKkh+7myvffK27U?=
 =?us-ascii?Q?heZbHSLo4iFPtAtIWSs9nU22fU/Nzv/3GPYaAMIMo9bCrwXqJ6bs9jfetnFL?=
 =?us-ascii?Q?VBhgx17SUWbRNtBiWKlpSrtttZGmmI+2x9PpS7DSNd7jKg/wMO/6FRVB8/Wc?=
 =?us-ascii?Q?5xMMgOP2h4nzAbEfr9VcS/6ylrnvixn2BeF5Hu6JRwm1MPxxh0x7RtOvxT0O?=
 =?us-ascii?Q?xOsIE0ozjTqgoAPcrY+UIJ3ZaiH0GOtRWAPUHlTKu83M2JVgRue08j0nxEvE?=
 =?us-ascii?Q?olNAU9jVxQaC25WpUszRHwbrxXMMe2o7cKFOC93smiZxxlCU58e1zkv9EhuB?=
 =?us-ascii?Q?zpOdAWeDFN2i4Ebd8UxmE0EYezu7OX/uH/Lr5Exkg4YAOwRvmywWJNIzOrx/?=
 =?us-ascii?Q?NgpikrGRC+AtUqJlhg7aDgrR1AAc3PI2x2sNgbe/Vvkex4YoiXdtaFJNd6GR?=
 =?us-ascii?Q?xZ4kf/0qML3URltafL1Zi0F2b5j17vlSBsr1fl0gYk8c2GZVTSYkVSqRiCHx?=
 =?us-ascii?Q?Cfpgsd4lN664WxUP+sbJ2rqzs8DfxPLD2amOuf9OR0l1Yha1vrsV?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 16e1222b-574b-4af5-96b8-08df04a432cc
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 01:32:18.4183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z2PDbjIh7oeCGUjjHtNFlTQGQj+JEUM23KZ/KHsHaAiAuac2njftPDSz+/YO5o3vEKy5NuFwujVOkVTS4ELRkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYTP286MB4085

On Thu, Aug 27, 2026 at 09:03:42AM -0700, Dave Jiang wrote:
> 
> 
> On 8/10/26 9:51 AM, Koichiro Den wrote:
> > A logical QP can be reused while its shared memory still contains RX
> > addresses and completions from the previous instance. Without a session
> > ID, the new QP could accept that stale state.
> > 
> > Give each QP instance a fresh session ID and enable direct DMA only
> > after both peers acknowledge it. Teardown also exchanges the final
> > issued boundary so RX mappings remain valid until all outstanding
> > transfers have completed.
> > 
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> >  drivers/ntb/ntb_transport.c | 275 ++++++++++++++++++++++++++++++++++--
> 
> Will you considered moving most of the ntb_direct code to ntb_transport_direct.c instead of increasing the size of ntb_transport.c? Just from an organization perspective this may be better for maintenance and reading in the future.

Thanks for the comment. Let me rethink how best to split it out.

(For v1, I thought it would be fine to keep it in ntb_transport.c, because,
compared to the previous ntb_transport_edma RFC, it can now fall back to the
standard MW memcpy path, and the vendor-specific parts are gone after moving
them under the standard dmaengine API. I had thought keeping it together would
be simpler, so thanks for the feedback.)

Best regards,
Koichiro

> 
> DJ
> 
> >  1 file changed, 267 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> > index 67044d0ea0ff..ca08cb690311 100644
> > --- a/drivers/ntb/ntb_transport.c
> > +++ b/drivers/ntb/ntb_transport.c
> > @@ -58,6 +58,7 @@
> >  #include <linux/limits.h>
> >  #include <linux/module.h>
> >  #include <linux/pci.h>
> > +#include <linux/random.h>
> >  #include <linux/slab.h>
> >  #include <linux/seq_file.h>
> >  #include <linux/types.h>
> > @@ -153,6 +154,14 @@ struct ntb_rx_info {
> >  	unsigned int entry;
> >  };
> >  
> > +enum ntb_direct_state {
> > +	NTB_DIRECT_DOWN,
> > +	NTB_DIRECT_HANDSHAKE,
> > +	NTB_DIRECT_ACTIVE,
> > +	NTB_DIRECT_QUIESCING,
> > +	NTB_DIRECT_QUIESCED,
> > +};
> > +
> >  struct ntb_transport_qp {
> >  	struct ntb_transport_ctx *transport;
> >  	struct ntb_dev *ndev;
> > @@ -195,6 +204,8 @@ struct ntb_transport_qp {
> >  	struct ntb_direct_shared *direct_shared;
> >  	struct ntb_direct_shared __iomem *peer_direct_shared;
> >  	unsigned int direct_ring_entries;
> > +	/* Serialize direct session, TX ring, and RX publication state. */
> > +	spinlock_t direct_lock;
> >  	u32 *direct_rx_cpl;
> >  	dma_addr_t direct_rx_cpl_dma;
> >  	u32 *direct_tx_cpl;
> > @@ -203,6 +214,9 @@ struct ntb_transport_qp {
> >  	u32 direct_rx_cons;
> >  	u32 direct_tx_issue;
> >  	u32 direct_tx_cons;
> > +	u32 direct_session;
> > +	u32 direct_peer_session;
> > +	enum ntb_direct_state direct_state;
> >  	void *rx_buff;
> >  	unsigned int rx_index;
> >  	unsigned int rx_max_entry;
> > @@ -509,6 +523,228 @@ static bool ntb_direct_layout(struct ntb_transport_ctx *nt)
> >  #define QP_TO_MW(nt, qp)	((qp) % nt->mw_count)
> >  #define NTB_QP_DEF_NUM_ENTRIES	100
> >  #define NTB_LINK_DOWN_TIMEOUT	10
> > +#define NTB_DIRECT_TEARDOWN_RETRY_INTERVAL_MS	10
> > +
> > +static bool ntb_direct_rx_mode(struct ntb_transport_qp *qp)
> > +{
> > +	struct ntb_transport_ctx *nt = qp->transport;
> > +
> > +	return (nt->direct_features & NTB_DIRECT_FEAT_RX) &&
> > +	       (nt->peer_direct_features & NTB_DIRECT_FEAT_TX);
> > +}
> > +
> > +static bool ntb_direct_tx_mode(struct ntb_transport_qp *qp)
> > +{
> > +	struct ntb_transport_ctx *nt = qp->transport;
> > +
> > +	return (nt->direct_features & NTB_DIRECT_FEAT_TX) &&
> > +	       (nt->peer_direct_features & NTB_DIRECT_FEAT_RX);
> > +}
> > +
> > +static bool ntb_direct_link_capable(struct ntb_transport_qp *qp)
> > +{
> > +	return ntb_direct_rx_mode(qp) || ntb_direct_tx_mode(qp);
> > +}
> > +
> > +static void ntb_transport_notify_peer(struct ntb_transport_qp *qp)
> > +{
> > +	if (qp->use_msi)
> > +		ntb_msi_peer_trigger(qp->ndev, PIDX, &qp->peer_msi_desc);
> > +	else
> > +		ntb_peer_db_set(qp->ndev, BIT_ULL(qp->qp_num));
> > +}
> > +
> > +static bool ntb_direct_tx_idle(struct ntb_transport_qp *qp)
> > +{
> > +	return qp->direct_tx_issue == qp->direct_tx_cons;
> > +}
> > +
> > +static bool ntb_direct_rx_drained(struct ntb_transport_qp *qp)
> > +{
> > +	struct ntb_direct_shared *shared = qp->direct_shared;
> > +	u32 session = qp->direct_session;
> > +
> > +	if (!shared || !session || READ_ONCE(shared->quiesce) != session)
> > +		return false;
> > +
> > +	/* quiesce is written after its final issue boundary. */
> > +	dma_rmb();
> > +	return READ_ONCE(qp->direct_rx_cons) ==
> > +	       READ_ONCE(shared->quiesce_issue);
> > +}
> > +
> > +static bool ntb_direct_tx_acked(struct ntb_transport_qp *qp)
> > +{
> > +	struct ntb_direct_shared *shared = qp->direct_shared;
> > +	u32 session = qp->direct_session;
> > +
> > +	return shared && session &&
> > +	       READ_ONCE(shared->quiesce_ack) == session;
> > +}
> > +
> > +static bool ntb_direct_control_pending(struct ntb_transport_qp *qp)
> > +{
> > +	struct ntb_direct_shared *shared = qp->direct_shared;
> > +	enum ntb_direct_state state = READ_ONCE(qp->direct_state);
> > +	u32 peer_session = READ_ONCE(qp->direct_peer_session);
> > +	u32 session = READ_ONCE(qp->direct_session);
> > +
> > +	if (!shared)
> > +		return false;
> > +	if (state == NTB_DIRECT_HANDSHAKE)
> > +		return READ_ONCE(shared->session) != peer_session ||
> > +		       READ_ONCE(shared->session_ack) == session;
> > +	if (state != NTB_DIRECT_ACTIVE)
> > +		return false;
> > +
> > +	return READ_ONCE(shared->session) != peer_session ||
> > +	       READ_ONCE(shared->quiesce) == session;
> > +}
> > +
> > +static void ntb_direct_control_publish_locked(struct ntb_transport_qp *qp)
> > +{
> > +	struct ntb_direct_shared __iomem *peer = qp->peer_direct_shared;
> > +	u32 peer_session = qp->direct_peer_session;
> > +
> > +	lockdep_assert_held(&qp->direct_lock);
> > +
> > +	/* Publish the completion array address before its session. */
> > +	iowrite32(lower_32_bits(qp->direct_rx_cpl_dma), &peer->cpl_addr_lo);
> > +	iowrite32(upper_32_bits(qp->direct_rx_cpl_dma), &peer->cpl_addr_hi);
> > +
> > +	iowrite32(qp->direct_session, &peer->session);
> > +	if (!peer_session)
> > +		return;
> > +
> > +	iowrite32(peer_session, &peer->session_ack);
> > +	if (qp->direct_state == NTB_DIRECT_QUIESCING) {
> > +		/* Publish the final exclusive TX boundary before its marker. */
> > +		iowrite32(qp->direct_tx_issue, &peer->quiesce_issue);
> > +		iowrite32(peer_session, &peer->quiesce);
> > +	}
> > +	if (ntb_direct_rx_drained(qp))
> > +		iowrite32(peer_session, &peer->quiesce_ack);
> > +}
> > +
> > +/*
> > + * Accept the peer session during HANDSHAKE. In ACTIVE or QUIESCING, a
> > + * replacement peer session or quiesce request enters the local teardown path.
> > + */
> > +static bool ntb_direct_control_progress(struct ntb_transport_qp *qp)
> > +{
> > +	struct ntb_direct_shared *shared = qp->direct_shared;
> > +	u32 peer_session, session_ack, quiesce;
> > +	bool published = false;
> > +	bool cleanup = false;
> > +	bool ready = false;
> > +
> > +	if (!qp->transport->link_is_up || !shared ||
> > +	    !qp->peer_direct_shared ||
> > +	    !ntb_direct_link_capable(qp) ||
> > +	    ntb_link_is_up(qp->ndev, NULL, NULL) != 1)
> > +		return true;
> > +
> > +	peer_session = READ_ONCE(shared->session);
> > +	session_ack = READ_ONCE(shared->session_ack);
> > +	quiesce = READ_ONCE(shared->quiesce);
> > +
> > +	scoped_guard(spinlock_bh, &qp->direct_lock) {
> > +		if (!qp->direct_session)
> > +			goto out;
> > +
> > +		if (qp->direct_state == NTB_DIRECT_HANDSHAKE && peer_session) {
> > +			qp->direct_peer_session = peer_session;
> > +		} else if (qp->direct_state == NTB_DIRECT_ACTIVE && peer_session &&
> > +			   peer_session != qp->direct_peer_session) {
> > +			qp->direct_state = NTB_DIRECT_QUIESCING;
> > +		}
> > +
> > +		if (quiesce == qp->direct_session &&
> > +		    (qp->direct_state == NTB_DIRECT_HANDSHAKE ||
> > +		     qp->direct_state == NTB_DIRECT_ACTIVE)) {
> > +			qp->direct_state = NTB_DIRECT_QUIESCING;
> > +			cleanup = qp->client_ready;
> > +		}
> > +
> > +		ntb_direct_control_publish_locked(qp);
> > +		published = true;
> > +		if (qp->direct_state == NTB_DIRECT_HANDSHAKE &&
> > +		    qp->direct_peer_session &&
> > +		    session_ack == qp->direct_session)
> > +			qp->direct_state = NTB_DIRECT_ACTIVE;
> > +		ready = qp->direct_state == NTB_DIRECT_ACTIVE;
> > +	}
> > +
> > +out:
> > +	if (published)
> > +		ntb_transport_notify_peer(qp);
> > +	if (cleanup)
> > +		schedule_work(&qp->link_cleanup);
> > +
> > +	return ready;
> > +}
> > +
> > +static void ntb_direct_session_start(struct ntb_transport_qp *qp)
> > +{
> > +	u32 session;
> > +
> > +	if (!ntb_direct_link_capable(qp) || !qp->direct_shared)
> > +		return;
> > +
> > +	session = get_random_u32_above(0);
> > +
> > +	memset(qp->direct_shared, 0, sizeof(*qp->direct_shared));
> > +	/* Complete local shared-state reset before publishing the new session. */
> > +	dma_wmb();
> > +
> > +	guard(spinlock_bh)(&qp->direct_lock);
> > +	qp->direct_session = session;
> > +	qp->direct_peer_session = 0;
> > +	qp->direct_state = NTB_DIRECT_HANDSHAKE;
> > +}
> > +
> > +static void ntb_direct_quiesce(struct ntb_transport_qp *qp)
> > +{
> > +	bool done;
> > +
> > +	if (!ntb_direct_link_capable(qp))
> > +		return;
> > +
> > +	scoped_guard(spinlock_bh, &qp->direct_lock) {
> > +		if (qp->direct_state == NTB_DIRECT_DOWN ||
> > +		    qp->direct_state == NTB_DIRECT_QUIESCED)
> > +			return;
> > +		if (!qp->direct_peer_session) {
> > +			/*
> > +			 * No peer session means RX publication and TX
> > +			 * submission never became active.
> > +			 */
> > +			qp->direct_state = NTB_DIRECT_QUIESCED;
> > +			return;
> > +		}
> > +		qp->direct_state = NTB_DIRECT_QUIESCING;
> > +	}
> > +
> > +	/*
> > +	 * Keep the mappings until the peer acknowledges the final boundaries,
> > +	 * or until the link is down or the peer starts a new session.
> > +	 */
> > +	for (;;) {
> > +		ntb_direct_control_progress(qp);
> > +
> > +		scoped_guard(spinlock_bh, &qp->direct_lock)
> > +			done = ntb_direct_tx_idle(qp) &&
> > +			       ntb_direct_tx_acked(qp) &&
> > +			       ntb_direct_rx_drained(qp);
> > +		if (done || ntb_link_is_up(qp->ndev, NULL, NULL) != 1)
> > +			break;
> > +
> > +		msleep(NTB_DIRECT_TEARDOWN_RETRY_INTERVAL_MS);
> > +	}
> > +
> > +	guard(spinlock_bh)(&qp->direct_lock);
> > +	qp->direct_state = NTB_DIRECT_QUIESCED;
> > +}
> >  
> >  /**
> >   * ntb_transport_rx_queue_size - Query the RX queue depth
> > @@ -1204,6 +1440,9 @@ static void ntb_qp_link_context_reset(struct ntb_transport_qp *qp)
> >  	qp->direct_rx_cons = 0;
> >  	qp->direct_tx_issue = 0;
> >  	qp->direct_tx_cons = 0;
> > +	qp->direct_session = 0;
> > +	qp->direct_peer_session = 0;
> > +	qp->direct_state = NTB_DIRECT_DOWN;
> >  }
> >  
> >  static void ntb_qp_link_down_reset(struct ntb_transport_qp *qp)
> > @@ -1221,6 +1460,7 @@ static void ntb_qp_link_cleanup(struct ntb_transport_qp *qp)
> >  	dev_info(&pdev->dev, "qp %d: Link Cleanup\n", qp->qp_num);
> >  
> >  	cancel_delayed_work_sync(&qp->link_work);
> > +	ntb_direct_quiesce(qp);
> >  	ntb_qp_link_down_reset(qp);
> >  
> >  	if (qp->event_handler)
> > @@ -1457,6 +1697,7 @@ static void ntb_qp_link_work(struct work_struct *work)
> >  						   link_work.work);
> >  	struct pci_dev *pdev = qp->ndev->pdev;
> >  	struct ntb_transport_ctx *nt = qp->transport;
> > +	bool direct_ready;
> >  	int val;
> >  
> >  	if (!qp->client_ready)
> > @@ -1466,13 +1707,17 @@ static void ntb_qp_link_work(struct work_struct *work)
> >  
> >  	val = ntb_spad_read(nt->ndev, QP_LINKS);
> >  
> > +	if (qp->direct_state == NTB_DIRECT_DOWN)
> > +		ntb_direct_session_start(qp);
> > +
> >  	ntb_peer_spad_write(nt->ndev, PIDX, QP_LINKS, val | BIT(qp->qp_num));
> > +	direct_ready = ntb_direct_control_progress(qp);
> >  
> >  	/* query remote spad for qp ready bits */
> >  	dev_dbg_ratelimited(&pdev->dev, "Remote QP link status = %x\n", val);
> >  
> >  	/* See if the remote side is up */
> > -	if (val & BIT(qp->qp_num)) {
> > +	if ((val & BIT(qp->qp_num)) && direct_ready) {
> >  		dev_info(&pdev->dev, "qp %d: Link Up\n", qp->qp_num);
> >  		qp->link_is_up = true;
> >  		qp->active = true;
> > @@ -1559,6 +1804,7 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
> >  	spin_lock_init(&qp->ntb_rx_q_lock);
> >  	spin_lock_init(&qp->ntb_tx_free_q_lock);
> >  	spin_lock_init(&qp->ntb_tx_offl_q_lock);
> > +	spin_lock_init(&qp->direct_lock);
> >  
> >  	INIT_LIST_HEAD(&qp->rx_post_q);
> >  	INIT_LIST_HEAD(&qp->rx_pend_q);
> > @@ -2054,6 +2300,11 @@ static void ntb_transport_rxc_db(struct work_struct *work)
> >  	dev_dbg(&qp->ndev->pdev->dev, "%s: doorbell %d received\n",
> >  		__func__, qp->qp_num);
> >  
> > +	if (ntb_direct_control_pending(qp))
> > +		ntb_direct_control_progress(qp);
> > +	if (!qp->active)
> > +		goto clear_db;
> > +
> >  	/* Limit the number of packets processed in a single interrupt to
> >  	 * provide fairness to others
> >  	 */
> > @@ -2070,7 +2321,11 @@ static void ntb_transport_rxc_db(struct work_struct *work)
> >  		/* there is more work to do */
> >  		if (qp->active)
> >  			queue_work(system_dfl_wq, &qp->rxc_db_work);
> > -	} else if (ntb_db_read(qp->ndev) & BIT_ULL(qp->qp_num)) {
> > +		return;
> > +	}
> > +
> > +clear_db:
> > +	if (ntb_db_read(qp->ndev) & BIT_ULL(qp->qp_num)) {
> >  		/* the doorbell bit is set: clear it */
> >  		ntb_db_clear(qp->ndev, BIT_ULL(qp->qp_num));
> >  		/* ntb_db_read ensures ntb_db_clear write is committed */
> > @@ -2080,7 +2335,9 @@ static void ntb_transport_rxc_db(struct work_struct *work)
> >  		 * ntb_process_rxc and clearing the doorbell bit:
> >  		 * there might be some more work to do.
> >  		 */
> > -		if (qp->active)
> > +		if (qp->active ||
> > +		    (qp->client_ready &&
> > +		     READ_ONCE(qp->direct_state) == NTB_DIRECT_HANDSHAKE))
> >  			queue_work(system_dfl_wq, &qp->rxc_db_work);
> >  	}
> >  }
> > @@ -2128,10 +2385,7 @@ static void ntb_tx_copy_callback(void *data,
> >  	dma_mb();
> >  	ioread32(&hdr->flags);
> >  
> > -	if (qp->use_msi)
> > -		ntb_msi_peer_trigger(qp->ndev, PIDX, &qp->peer_msi_desc);
> > -	else
> > -		ntb_peer_db_set(qp->ndev, BIT_ULL(qp->qp_num));
> > +	ntb_transport_notify_peer(qp);
> >  
> >  	/* The entry length can only be zero if the packet is intended to be a
> >  	 * "link down" or similar.  Since no payload is being sent in these
> > @@ -2586,6 +2840,7 @@ void ntb_transport_free_queue(struct ntb_transport_qp *qp)
> >  
> >  	cancel_work_sync(&qp->link_cleanup);
> >  	cancel_delayed_work_sync(&qp->link_work);
> > +	ntb_direct_quiesce(qp);
> >  	qp->active = false;
> >  
> >  	if (qp->tx_offload_thread) {
> > @@ -2636,6 +2891,7 @@ void ntb_transport_free_queue(struct ntb_transport_qp *qp)
> >  	/* Catch cleanup queued while draining RX processing. */
> >  	cancel_work_sync(&qp->link_cleanup);
> >  	cancel_delayed_work_sync(&qp->link_work);
> > +	ntb_qp_link_context_reset(qp);
> >  
> >  	qp->cb_data = NULL;
> >  	qp->rx_handler = NULL;
> > @@ -2822,6 +3078,7 @@ void ntb_transport_link_down(struct ntb_transport_qp *qp)
> >  		return;
> >  
> >  	qp->client_ready = false;
> > +	ntb_direct_quiesce(qp);
> >  
> >  	val = ntb_spad_read(qp->ndev, QP_LINKS);
> >  
> > @@ -2927,7 +3184,9 @@ static void ntb_transport_doorbell_callback(void *data, int vector)
> >  		qp_num = __ffs(db_bits);
> >  		qp = &nt->qp_vec[qp_num];
> >  
> > -		if (qp->active)
> > +		if (qp->active ||
> > +		    (qp->client_ready &&
> > +		     READ_ONCE(qp->direct_state) == NTB_DIRECT_HANDSHAKE))
> >  			queue_work(system_dfl_wq, &qp->rxc_db_work);
> >  
> >  		db_bits &= ~BIT_ULL(qp_num);
> 
