Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021095.outbound.protection.outlook.com [40.107.74.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2FA2C0261
	for <ntb@lists.linux.dev>; Wed, 19 Aug 2026 02:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787106380; cv=fail; b=mkQ7l6Zdr1OwfKuGqC8vNu3YjRBgbgapz+wUq7dw+r3KwCBqq6796/2VDksTEtXCMwdJnyKDV9qWjUpgekCUFCNrTbUP2zGuVtwIFWSYs6ePngAKP5Il7h/9q9Ig8hkIyRWFT86/pE7J4MAfgeaLm/uqIhYibZPbwVbXYiFfryk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787106380; c=relaxed/simple;
	bh=gvTBdGzu/b5LHbDFIBIrFx6goyxtjjpnpdKTUnjMPBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qE3oUwm6+wNX5jNsfmqKsNdfSiUoUwJI6ViGht8esC9aerHZPBZ5TCrRh3zxgDMx7vALf66P32+zT8Yf28GQQmuwUHehB07Opc7dv0rPYVIESxlbJzluUp2GiTf12fQe2evC+trDvMZ6wpuzQgVVAtkYCdwi+Zm49SfqI9e8pKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=dgRrvL6i; arc=fail smtp.client-ip=40.107.74.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="dgRrvL6i"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qQ2JLtWCRirz+Kq1DN+LBxOnZ9UW7xAFrKdsVjff20YwH7ON4/13CN5KbBaSwPi+HOnTiJKfOUIBPUTPQFlUOQQGlreTerVesSTgMFM1ZhCYm+NUAYTQTJqpO6q3MoJS9pZpKSwbJcbiy9iiE/pEhafFr/WCVaVHgfOTiqdT1rQAM7PGhFs846Dnuyp9wcc2IZMoJi0GaYPt0/3iuXoW+fN6aW9NQzxBjxx0Jp1to76boHK1NNKbvtbxlm5qsQIQhXX9OGEmFRYzPAvkZxybQp2aNNFybibBClSHfqkctcIIcdZCDtL5FxmRbIiikcRKSnRzt1+boCq6H0jdYUvdVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rMyFmVWNAwWxCYaKvcwF6yfrOuhmwyGFoMNpKZrKygk=;
 b=pHK49rpjpVkEs9Dbks10hFTxCpvks4SRJku+0TWovN4SvbYhYjJw4IlF3X+sKxtjYSS8+cXTh7ktM8H37mfIqCT3ZQF3Jso3gBHh4kKuo+S2i2gmg7LD7/gIISZ98zhBmTHAvrsaq4xOhoeVgdRNP6ZITuETIdY7Qkm7DXaWEs+wXqivIAFB+gWKiVWVw5QQVCtvsnn3CIbNnPLYam85bH7icpaJz4/H7hUCotWup/39Y3iCjPh7s6VW6iMQ4q9L4BcmpggOXoGT7RUabnnoZf61a5rqXhwkSfM0QyBbyIUtAc5L/N7nA3IrQ9GvTZkLXrowE6JaB5NavQ9EqG19+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rMyFmVWNAwWxCYaKvcwF6yfrOuhmwyGFoMNpKZrKygk=;
 b=dgRrvL6iItoYwGZgotlY1qpRcVKd/qmfBEJP0W1BHyQBdnxuV/Sij5qrZxcKeaY3f8I8LUKh9wJNzHV6iLayZ3Pvo5fDSTLSR/D926suxVpry4mWmLM+hD/DEss5Qa5HMgpvsb5ARSfZ1nd7CJOYAHk6uzmw6dBPxUcngYKLM5s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY4P286MB7284.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:34f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 02:26:13 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0315.016; Wed, 19 Aug 2026
 02:26:13 +0000
Date: Wed, 19 Aug 2026 11:26:11 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Jakub Kicinski <kuba@kernel.org>
Cc: jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	ntb@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: ntb_netdev: Preserve CHECKSUM_PARTIAL
 across NTB
Message-ID: <kgboch4omu7tcft3welfszxtkdyhianwrg6pck42hscl5z2bxx@kmzpfdp2iiuo>
References: <20260814032913.3558500-3-den@valinux.co.jp>
 <20260818162741.3982261-1-kuba@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818162741.3982261-1-kuba@kernel.org>
X-ClientProxiedBy: TYCP301CA0084.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::8) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY4P286MB7284:EE_
X-MS-Office365-Filtering-Correlation-Id: c3762f7c-ef95-4d4c-441e-08defd993d0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|10070799003|7416014|366016|6133799003|10067099003|5023799004|4143699003|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	Il6bH6205BDgJgFrG7JZvyiy/eG+GVCBtS8jqtzvIw4v3uT7eCjGqDHIVSpL3WUg3s8ms5MYn3X/asRviqJsywxPvPl5kzImehLXoSWJD3X3515kAxCb+geU12GZgG2ydLK4EK+jJq8mPmzr+aiCeAgrzmeRuCmfD+1/WOZf5cZUg3uSnNOBIFjeMdoxOrSuRjdMo+ujvXd9MUDEHlyYuzh0Fz6UQlyNLb8nUK5cgbpQ4FAz2mMnxTD3kP02LRbcn2tSCPDGAvldzRHubVA+pdYE8wfcC5nUrUfTJbUMZySuL1leTQbQZGlUsLdH0u86xUerN8ekD0U5+yABZngjeVCEEILqC4FWu7GCHvLZDFTi8QB7K9EeGNncec3yjFSLlJQ41XVxbowB/iQ1O03onOrqzK8VaO0hfL5l8eqUOuYw3d/BMfJM5V5ThSSAZoe92JNwmPofCUajBKr9MwkPLujOQAcL+FZh+m5tC6H06t2+g/aL6DNgOallVLjhcbXob2yhLdkaf9b23MII9+q3mbhxZWOjY6uRpGzi1z5YNHjp2p02gSDu79/yV/VBTb+/lzdrKvbYEEhSwzf0UtNb7Q/av0MEi4URoDoOdlCZRJm9RkpVKp4p8dfes9Bs73Nk1pMwC4zD7PyhHhr0NLEa0cg85GAoPIaUar+BnFNAKcc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(10070799003)(7416014)(366016)(6133799003)(10067099003)(5023799004)(4143699003)(56012099006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ttkbgh/LBET3U9dRqWQNq4bYFSpXdEG/bRWFoFbfotHxsYBYvYuZwYGF6ZCN?=
 =?us-ascii?Q?eg6RJfXNhzSVinL8nFukcF336mhLOOdRkpiIAsnwKEFMZGASQyTVNVAb1MDT?=
 =?us-ascii?Q?j3qIwOzak8DSCTbH6TtK0pMG9c/U81+ZeGJNqZ6PWXtT93qhCxTvNjWLWTkM?=
 =?us-ascii?Q?3MkPVdcMcPYEzrOOziM8bHvRYNKGD9kUbz9ODNZIJvJPuT91hqrXJK3abOZc?=
 =?us-ascii?Q?IAhCs9+MKR4SRmocEVBZcE20c0h2ihsMXTFlVv9/JLDy3k4YFbJFbhY6O6ye?=
 =?us-ascii?Q?LX84K4orYPS7W9oh+mAcNLseSfJx2bAP+pkYZM80VPIiMEuOdVf9NxVKzeRi?=
 =?us-ascii?Q?muh08jz11H0I/9Ja9RMRqgWzk2Jf6XsV9QF6RVM45gLtjzghCfwQB1/co7SR?=
 =?us-ascii?Q?MgIIUZgRQihd3D4Wfn8wkCm2utqX46gQ+nlxA8LFgPofSAFP8BWTpBYLfIbw?=
 =?us-ascii?Q?jShP8xtVrJ8e5OA7uGiXulyCzH+qQ4hZoyTKcv+pDXGYAF0+OgZjxOGBI5lf?=
 =?us-ascii?Q?Oc9MpKlz0DHrbJ3nka4vdZumfGh6tbaCU+n0hTIftBus34U6yQnLVt44blJZ?=
 =?us-ascii?Q?5OgogaZuuxLEOPYzGrx480pCbT9mSdhwcbvjqvd5R682g10/3yJTkVKAeESu?=
 =?us-ascii?Q?WBePC2VUU+KQKPlwE+926Pqq9T9S/ml1D5fo9NbbcoOrXxUajnwftESP11/s?=
 =?us-ascii?Q?YjUIFxrL7NVdbzLtMRVh6D7DBrzwBmY7s+UsiVI2nQ2zGkQqLlU+rAr1eFON?=
 =?us-ascii?Q?fOghi4fk7uf4FTA66vcATXFLxvb4PSvR7Bz/7dSa+VgKkxyqJR1pLwc2DwwV?=
 =?us-ascii?Q?9wHKpHDAhlF5uZUIfmLWX/g5JTbXT7jIhBv2XsaSscoKYomJZXMK0/WFUZUj?=
 =?us-ascii?Q?DlmJ6QBeTAT/WnZXl2rLNP0d6rrN9OOVqcplN8JBRenPVmhSxok0JpC+CsKE?=
 =?us-ascii?Q?Cz5Qg8it/wST7MX4bnIrSSj/6boTmYzAmVjF3yhhfphxES0yWi8MdtiSqtP2?=
 =?us-ascii?Q?jGoaWHAm1qEoANdR643occ9NsxdV5D7j4l3LiEBdGb2TmgwdT+wtR0ep8Kru?=
 =?us-ascii?Q?B+XlPPjdsvEx46uWWSVZ4V9OQBVuPaGQ/cH2Z61KkPh0bJy++tQD+pdUNDAl?=
 =?us-ascii?Q?+sWkZtqxC478v2DaaLkjmAJpchGfDBKN5kKLcCgPPb3GB4t1duoR1qBFut1h?=
 =?us-ascii?Q?itaMiGbdlSWHTQgurdc7zNPx/nWApgR99wzcQJ5DVyNaAvSAsaQHdX3QUmrw?=
 =?us-ascii?Q?zXQr0j0xoMU3OTsv8Gctn/xHYHLeXw258lhx2a9bW4d9TsgKdpQ+6CXmVP+t?=
 =?us-ascii?Q?qbfrGxWhpxca4Jm4s4gMgQRqIsYGEdOISFwsBqW5zJBghuVyIOVv+XsRGG9V?=
 =?us-ascii?Q?KpwrBBSlJ7z13DXG8MPlGinDqrlYoXqWbvWkGnnlkEbmGF4Ydab/e0lAkIYl?=
 =?us-ascii?Q?TWMFUUpln+dOuZ7REdul2nLl6CuNuXkKLLMrxkOCm6kfQpMisnQ0fOlnhFvE?=
 =?us-ascii?Q?zCzgr3D80gteTjuNkK/NUHg+vd0MZp7uuRru4U5FvL2p6TqvR53ZYuIaOWR6?=
 =?us-ascii?Q?s+HSp0QSOmCSuHaPDl/sOChvOGzXOLRZY32TPRzMW53NK5dZTi7QmHejrNeL?=
 =?us-ascii?Q?25FUtPJ12fsQoOb660OJ2fDnla52HWDFxWydVw8y44dNl3yH/3sQxWu+iT6P?=
 =?us-ascii?Q?F/JXlHsLZs2fTpSK+BM3CleBMg2c6xth1kCaZwMKkNhiYWKnSnArwuG0f7B2?=
 =?us-ascii?Q?e0DOahH3axkvpprZRERkyI5UW16XEq3b+SbBA/4GG9bZEUHznu+M?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: c3762f7c-ef95-4d4c-441e-08defd993d0b
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 02:26:13.0041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lskL4w6VbU2UBLBiKRvQ/n+nTbRVEcx5Z/QuD7L4yGgJkRqw6y5E3SpvuNZaCcbXZk6bCz7BxH+yg1gMN/WN/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB7284

On Tue, Aug 18, 2026 at 09:27:41AM -0700, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net: ntb_netdev: Preserve CHECKSUM_PARTIAL across NTB
> 
> This carries CHECKSUM_PARTIAL (csum_start and csum_offset) in the NTB
> transport metadata word so that L4 checksums do not have to be computed
> on either side of the link. A capability bit is advertised on every
> transmitted frame, and both TX and RX checksum offload are left off by
> default and exposed through hw_features so users can opt in.
> 
> > diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
> > index 5c7fe6883cb93..b9a78ff695c87 100644
> > --- a/drivers/net/ntb_netdev.c
> > +++ b/drivers/net/ntb_netdev.c
> 
> [ ... ]
> 
> > @@ -29,6 +30,21 @@ static unsigned int tx_stop = 5;
> >  #define NTB_NETDEV_MAX_QUEUES		64
> >  #define NTB_NETDEV_DEFAULT_QUEUES	1
> >  
> > +/*
> > + * Checksum metadata layout:
> > + *   bit 23     capability, advertised on every packet
> > + *   bit 22     per-packet CHECKSUM_PARTIAL flag
> > + *   bit 21..6  skb_checksum_start_offset() (16 bits)
> > + *   bit 5..0   skb->csum_offset (6 bits)
> > + *
> > + * Until the capability is observed, complete partial checksums in software.
> > + * Six offset bits cover TCP/UDP. Larger offsets use software checksumming.
> > + */
> > +#define NTB_NETDEV_META_CAP_CSUM		BIT(23)
> > +#define NTB_NETDEV_META_CSUM			BIT(22)
> > +#define NTB_NETDEV_META_CSUM_START_SHIFT	6
> > +#define NTB_NETDEV_META_CSUM_OFFSET_MASK	GENMASK(5, 0)
> > +
> >  struct ntb_netdev;
> >  
> >  struct ntb_netdev_queue {
> > @@ -44,6 +60,7 @@ struct ntb_netdev {
> >  	struct net_device *ndev;
> >  	unsigned int num_queues;
> >  	struct ntb_netdev_queue *queues;
> > +	bool peer_csum;
> >  };
> >  
> >  #define	NTB_TX_TIMEOUT_MS	1000
> > @@ -108,6 +125,8 @@ static void ntb_netdev_event_handler(void *data, int link_is_up)
> >  	struct net_device *ndev;
> >  
> >  	ndev = dev->ndev;
> > +	if (!link_is_up)
> > +		WRITE_ONCE(dev->peer_csum, false);
> >  
> >  	netdev_dbg(ndev, "Event %x, Link %x, qp %u\n", link_is_up,
> >  		   ntb_transport_link_query(q->qp), q->qid);
> > @@ -151,8 +170,21 @@ static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
> >  	}
> >  
> >  	skb_put(skb, len);
> > +	if (meta & NTB_NETDEV_META_CAP_CSUM)
> > +		WRITE_ONCE(dev->peer_csum, true);
> 

Thanks for the review. To summarize:

  #1: Already addressed in v2.
  #2: Thanks for catching it! I'll address it in v3.
  #3: Already being handled in a separate series.

> [Severity: Medium]
> Can the clear of dev->peer_csum in ntb_netdev_event_handler() be lost
> against this set in ntb_netdev_rx_handler()?
> 
> The two writes run from different contexts with no common lock, and
> WRITE_ONCE() only prevents tearing:
> 
> CPU0 (workqueue, ntb_qp_link_cleanup() -> qp->event_handler())
> 	ntb_netdev_event_handler(link_is_up = 0)
> 	    WRITE_ONCE(dev->peer_csum, false);
> 
> CPU1 (rx tasklet, ntb_complete_rxc() -> qp->rx_handler(), called after
>       spin_unlock_irqrestore(&qp->ntb_rx_q_lock, irqflags))
> 	ntb_netdev_rx_handler()
> 	    WRITE_ONCE(dev->peer_csum, true);   /* stale frame */
> 
> ntb_qp_link_context_reset() only sets qp->active = false, which gates
> future tasklet_schedule() calls; tasklet_kill(&qp->rxc_db_work) happens
> only in ntb_transport_free_queue(). So an rx callback from the previous
> link generation can still run after, or overlap with, the clear.
> 
> Since there is no matching re-initialisation on the link-up transition
> (ntb_qp_link_work() just calls the event handler with link_is_up = 1),
> does the stale true then persist? After reconnecting to a peer that
> ignores the metadata word, ntb_netdev_start_xmit() would read true, set
> NTB_NETDEV_META_CSUM and skip skb_checksum_help(), so frames leave with
> only a pseudo-header checksum and the old peer's stack drops them without
> incrementing any counter on either side. Would tying the flag to a link
> generation, or clearing it unconditionally in the event handler
> (including on link-up), close this?

This was address in v2 by resetting peer_csum on every link event:
https://patchwork.kernel.org/project/netdevbpf/patch/20260817064916.13278-5-den@valinux.co.jp/

> 
> > +
> > +	if (meta & NTB_NETDEV_META_CSUM) {
> > +		u16 csum_start = (meta >> NTB_NETDEV_META_CSUM_START_SHIFT) & U16_MAX;
> > +		u16 csum_offset = meta & NTB_NETDEV_META_CSUM_OFFSET_MASK;
> > +
> > +		if (!skb_partial_csum_set(skb, csum_start, csum_offset))
> > +			goto rx_drop;
> 
> [Severity: High]
> Is csum_start validated enough here? It is a full 16-bit peer-supplied
> value, and skb_partial_csum_set() only bounds it against the frame as
> received:
> 
> net/core/skbuff.c:skb_partial_csum_set() {
> 	u32 csum_end = (u32)start + (u32)off + sizeof(__sum16);
> 	u32 csum_start = skb_headroom(skb) + (u32)start;
> 
> 	if (unlikely(csum_start >= U16_MAX || csum_end > skb_headlen(skb)))
> 		...
> 		return false;
> 	skb->ip_summed = CHECKSUM_PARTIAL;
> 	skb->csum_start = csum_start;
> 	...
> }
> 
> So csum_start = 0 with csum_offset = 16 is accepted. eth_type_trans()
> then pulls ETH_HLEN, and skb_checksum_start_offset() becomes negative
> (start - 14) while ip_summed stays CHECKSUM_PARTIAL when
> NETIF_F_RXCSUM is enabled.
> 
> The other consumer of untrusted partial-checksum metadata rejects this
> explicitly:
> 
> include/linux/virtio_net.h:__virtio_net_hdr_to_skb() {
> 		if (!skb_partial_csum_set(skb, start, off))
> 			return -EINVAL;
> 		if (skb_transport_offset(skb) < nh_min_len)
> 			return -EINVAL;
> }
> 
> Downstream, a negative offset is not caught cleanly. skb_checksum_help()
> compares the signed offset against unsigned skb_headlen() and fires
> WARN_ONCE() plus skb_dump(), which a peer can trigger at will (fatal
> with panic_on_warn). And skb_copy_and_csum_dev() does:
> 
> net/core/skbuff.c:skb_copy_and_csum_dev() {
> 	long csstart;
> 
> 	if (skb->ip_summed == CHECKSUM_PARTIAL)
> 		csstart = skb_checksum_start_offset(skb);
> 	...
> 	BUG_ON(csstart > skb_headlen(skb));
> 
> 	skb_copy_from_linear_data(skb, to, csstart);
> }
> 
> The BUG_ON does not trigger for a negative csstart on 64-bit (the
> unsigned int result is promoted to long), and the length parameter is
> unsigned:
> 
> include/linux/skbuff.h:skb_copy_from_linear_data() {
> 	memcpy(to, skb->data, len);   /* const unsigned int len */
> }
> 
> Can that turn a negative csstart into a multi-gigabyte memcpy into a
> fixed-size driver TX buffer? Drivers that advertise checksum offload and
> call this helper unconditionally still exist (8139too sets
> NETIF_F_HW_CSUM in rtl8139_init_one() and calls skb_copy_and_csum_dev()
> from rtl8139_start_xmit(); sc92031 fakes NETIF_F_IP_CSUM the same way),
> so skb_csum_hwoffload_help() will not sanitize the skb first. A negative
> offset survives to egress whenever the ingress pull exceeds the egress
> push, for example locally terminated IPIP/GRE
> (__iptunnel_pull_header() advances skb->data via skb_pull_rcsum() and
> iptunnel_pull_offloads() leaves ip_summed alone) followed by forwarding
> the inner packet out such a NIC.
> 
> Would a check that skb_transport_offset(skb) leaves room for the
> Ethernet and L3 headers, mirroring the virtio_net one, be appropriate
> here?

The csum_start issue is real. Thanks for catching this. The missing lower bound
check needs to be added, but I don't think requiring room for an L3 header as
virtio_net does is appropriate here. It would be too restrictive for
ntb_netdev's protocol-agnostic NETIF_F_HW_CSUM contract.

I'll make sure csum_start values below ETH_HLEN are rejected in v3.

> 
> > +
> > +		if (!(ndev->features & NETIF_F_RXCSUM) &&
> > +		    skb_checksum_help(skb))
> > +			goto rx_drop;
> > +	}
> >  	skb->protocol = eth_type_trans(skb, ndev);
> > -	skb->ip_summed = CHECKSUM_NONE;
> >  	skb_record_rx_queue(skb, q->qid);
> >  
> >  	if (netif_rx(skb) == NET_RX_DROP) {
> 
> [ ... ]
> 
> > @@ -252,13 +292,24 @@ static netdev_tx_t ntb_netdev_start_xmit(struct sk_buff *skb,
> >  	struct ntb_netdev *dev = netdev_priv(ndev);
> >  	u16 qid = skb_get_queue_mapping(skb);
> >  	struct ntb_netdev_queue *q;
> > +	unsigned int meta = NTB_NETDEV_META_CAP_CSUM;
> >  	int rc;
> >  
> >  	q = &dev->queues[qid];
> >  
> >  	ntb_netdev_maybe_stop_tx(ndev, q, tx_stop);
> >  
> > -	rc = ntb_transport_tx_enqueue(q->qp, skb, skb->data, skb->len, 0);
> > +	if (skb->ip_summed == CHECKSUM_PARTIAL) {
> > +		if (READ_ONCE(dev->peer_csum))
> > +			meta |= NTB_NETDEV_META_CSUM |
> > +				(skb_checksum_start_offset(skb) <<
> > +				 NTB_NETDEV_META_CSUM_START_SHIFT) |
> > +				skb->csum_offset;
> > +		else if (skb_checksum_help(skb))
> > +			goto drop;
> > +	}
> > +
> > +	rc = ntb_transport_tx_enqueue(q->qp, skb, skb->data, skb->len, meta);
> >  	if (rc)
> >  		goto err;
> 
> [Severity: High]
> This isn't a bug introduced by this patch, since the baseline already
> treated rc == 0 as a completed handoff with meta = 0, but does the
> rc == 0 path here leak the skb when the QP link is going down?
> 
> drivers/ntb/ntb_transport.c:ntb_transport_tx_enqueue() {
> 	/* If the qp link is down already, just ignore. */
> 	if (!qp->link_is_up)
> 		return 0;
> 
> 	entry = ntb_list_rm(&qp->ntb_tx_free_q_lock, &qp->tx_free_q);
> 	...
> 	entry->cb_data = cb;
> }
> 
> The early return happens before entry->cb_data = cb, so the transport
> never records the skb and ntb_netdev_tx_handler() -- the only place that
> calls dev_kfree_skb_any() for a transmitted skb -- is never invoked for
> it. start_xmit() then returns NETDEV_TX_OK without freeing.
> 
> The window looks reachable: qp->link_is_up is cleared in
> ntb_qp_link_context_reset() before ntb_netdev_event_handler() stops the
> subqueue, and both __ntb_netdev_maybe_stop_tx() and
> ntb_netdev_tx_timer() re-open the queue based on a check-then-act
> ntb_transport_link_query():
> 
> 		if (__netif_subqueue_stopped(ndev, q->qid) &&
> 		    ntb_transport_link_query(q->qp))
> 			netif_wake_subqueue(ndev, q->qid);
> 
> Would repeated peer link flaps then leak one sk_buff per racing packet?
> With this patch each leaked skb can additionally carry a freshly
> allocated linear buffer, because skb_checksum_help() may reallocate the
> head via pskb_expand_head() just before the enqueue.

The link-down skb leak is being handled by the separate net fix series:
https://patchwork.kernel.org/project/netdevbpf/cover/20260817053519.4135287-1-den@valinux.co.jp/

Best regards,
Koichiro

> 
> [ ... ]
> -- 
> pw-bot: cr
