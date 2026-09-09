Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021143.outbound.protection.outlook.com [40.107.74.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E972836A6;
	Wed,  9 Sep 2026 04:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788929274; cv=fail; b=ngqDvMMDMPO2zKNX8H+KMwBmtEbnTlBHphBlnbLkX6Q+Muc/GmFOGenBubaTAqBCX04M0tVir59/XTUagVn+lHCBaMfSLZMdkCnAwuu5xG78/K9VBUFE8da5sxXF2agQC3zl1fhx6vyVkcJ9ATtpSNI774RsEnTmnRtVyeD3X7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788929274; c=relaxed/simple;
	bh=3XA2zggVN4WMv4bdj13WMIAguA7mFXLDroDE8ycIhrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q2gV0CU4C9uqyYvWwhu4XdnAXbo5D3W4CQRCY8H0zMVOrmwdf6KcIySg2llBU2nQJ1FkDyOQM//U1idPiesdcjFTZuh3S48yVIlMvXSuqnt/P4eNOaiORUkulHmkU9sTjtKckgz5WWbD5+L30+VLs/z26pzu9MngINzliZZwqOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=fail (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=ljrfKOzS reason="signature verification failed"; arc=fail smtp.client-ip=40.107.74.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="ljrfKOzS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WW5JrfJ+vSAHQlDodPGPF83SEW3nD8TGIOktvPefRgiv0nsGxZxntYr0TI4SeIpMxoSWOE5tQdG2dvnmpoLkLhR+Lqy15NwHTsf7msLrIXY5p5+/BqhzyyOEFJChgek8q9mkD2Ae3ufUZEYyGKsEojjvDzofFxjAzzWMrP6HxZxKJaTFehg8dTQQmBP9gPWHCq4sz2poeOvbng3jDmBoLKxqd1nSUiH+vi02i/66xaVjzaEFvMYfaWjSuftHyr/H9nAzpVmW6Izy7YPjj/lL73LHLGGSPjKbub8rek78BA87DVYfmBcQ8J/f+z5ISf0HzYkMHz6mWtLiWMWe4qz4/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PYYKuNkVm7tztKd+VZ3UlFmsVpxIkHgZ+I/8X+rH7Pg=;
 b=Ldlm1f9gge3RtzuyY6A/FktHSNm0YehH/H4kBrqI3FWTYc1JgjbL3+fQ6prrM1BlxXtRf42x9/8Dscdz/TiAMV7pYN0tBGpi3sN1CE8tVsuncIZ24qL/6zI+QC/MbINuNDQMTq+Fpidu/XecwbXtnSE7CIZUR7ku5t/Fn/C+uti9oqDXES/8rPQdPg//gssKJT4CZ/9VTsrVfQNNqkzTTCDVnzVPtmJptzI7SOR1JDxHQHaqqqXbI+Roa/FEOlj+DvBhrGvsWHBEDfBm66QGavleWbrIyZYPN2t1ro+AbUZcHSB4BK3MHWDwy4V3i8jKD5lavULZACchThND8Qseww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PYYKuNkVm7tztKd+VZ3UlFmsVpxIkHgZ+I/8X+rH7Pg=;
 b=ljrfKOzSodNDsIbxVUYRHSVMH9oxabteY1qiJeS9j1uIzBxeES2/BxZxxjOena2c2eUb6XIVjdomH+j5wTfQAtKmyKUOzoA7yBrFUxLCW/htm2t+7do2N1CY6/SNn+WV281vCsXF89ENK0kL8LnwOZHd1w+K5Tue8GTNur/ohsY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY3P286MB3515.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3af::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 04:47:47 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 04:47:47 +0000
Date: Wed, 9 Sep 2026 13:47:46 +0900
From: Koichiro Den <den@valinux.co.jp>
To: sashiko-reviews@lists.linux.dev
Cc: ntb@lists.linux.dev
Subject: Re: [PATCH 07/11] NTB: ntb_transport: Clear link state before QP
 cleanup
Message-ID: <kueeh2eiyp5xecmb3vlgglb7pkznzjosamlzuctc3mfvbo5wrg@qzihetaj6te3>
References: <20260907142429.951930-1-den@valinux.co.jp>
 <20260907142429.951930-8-den@valinux.co.jp>
 <20260907144303.3D25A1F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260907144303.3D25A1F00A3A@smtp.kernel.org>
X-ClientProxiedBy: TYCP286CA0285.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::20) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY3P286MB3515:EE_
X-MS-Office365-Filtering-Correlation-Id: 00f887ef-052f-41d8-c601-08df0e2d7ec1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|10070799003|366016|10067099003|4143699003|5023799004|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	LBzwFER7IaYn3qV0L+ZYT8cB3P1A2Q/GvPaFAaAbD1KYRhAMw7Hz/CJIWH6MU0764Ogyedom+ZZQ4T8Fe4Or82Wzyj5vIqUl5wpwX+9e2YV8XvSEvmJQPZ6fyle3UpFivlQ9tH9at8ua1+sNPzMU6LPiTDVuI77RjV548qxgpsg+ttNhygCe+Mja6fXLlf6kpCsIDt36Zo2YcwbjUYV3S4b29q3VkPSkQS32ygH/qTgg3HORVPKFScJhWbQHPAuDy5O9k3/WTf0YHhel3A17M7/lwB3f6U8dG/smATLQRYiIhpzLj461Q3j2QaCOMvDG0btFy/2n7KCpTW6xDEtPOc5UvUj4jLyIlXJlRvdnazKXrilPutYjDIFqPBYn1TwXcuyR4wLGRLtr+LXGUSD8/MKfasWhee8UKowYxAjT0jTSWcKXio8uv3xpbslSrFCNA2eTFmwzo3h3X7GQCKCJlRrb/6oONBEn9eLJVJNFIZMDnSUAzlUMIePiMYeJZJ4Tu01k3hFCjz5xuVSvwfSkXE7/zvQ8UslFhN2wJXAqCFElF3OCo5FVrN52mwkWD5E2Oe0g+44JNeVmOu3x37hdze2qMteCki5h0zQMbAjv4HE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(10070799003)(366016)(10067099003)(4143699003)(5023799004)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?Qk2QPv0o8F0WHN4ASvNN7GsnR4Ys/dA0tSvxEAV0eBT0ocQCewM8BvBXHx?=
 =?iso-8859-1?Q?EFinPjsONBREGfHjqAqAzHjXyq5NhjLKrWBXLlYsYQY40Wn/MU9bH8JA5h?=
 =?iso-8859-1?Q?ItPUtcj4pXHBMrnqqPhIlusdeCHwVuQno79N4AuDzkr6CmW0JQKNMfqHyX?=
 =?iso-8859-1?Q?Pby3wYMaYbCwASh/Db8e/Srl1Ht/4GBupC2KvLc9ECEe2cHyikHMfccgs9?=
 =?iso-8859-1?Q?iu3mXIFd0lvuyPIxEn3MJ54Ve+ZMTvcddQb9kY/xeVo5Eb12DWlgn5JJk8?=
 =?iso-8859-1?Q?Up776JfjunN/ynQwqw54RE/EUsTdwNopFpcNlS4mCXrzLWEJM/Ey3bB4VR?=
 =?iso-8859-1?Q?UXokeearv4GYzgVmrQzXZgj8Eve3SjSmyYl0FwMCisQYtn4l+kmBdEt1tK?=
 =?iso-8859-1?Q?aWHnhi30j+ncqu9RUTZvdbu7adL+CGFLql6vG0XERTWyI8kHbIgVWcOBPT?=
 =?iso-8859-1?Q?8zJBMb7ggt0sa15R5Vg/GP5+oFs7Tw/IlaH+8aHmas8jAAJr6WHFDbsw+0?=
 =?iso-8859-1?Q?NB7+/ESIixWkxSihkTfezEMSEXbz51fwlw1sCrI5mly8AukR6g0si0fRv4?=
 =?iso-8859-1?Q?DkfP1F+/5KPBgru8aWU/d1w8DamON6CXN+gWDNdb5yp81Nm0fdHZyTIng7?=
 =?iso-8859-1?Q?MavbThhMIQmQ/zmzgcQfaGmhHr9yDGI5Lxca4VrPWtrKke5ukIyoBDCnlW?=
 =?iso-8859-1?Q?3ORobTGWmkzJU46ff3zE5IB7iTK36sUZnQn8ckFoIAS9LRwHdfY/3YBWSm?=
 =?iso-8859-1?Q?8A5mcbteerot/o/q5aFmRPdpM4rc7UoQGzqHUAiksSC7UxL3vMUbEfh2PA?=
 =?iso-8859-1?Q?2COPf8PvRScW7zqJtwHubMJxogb/+DzcvaDYvrufn0OCMNmsDR8xh2w5a+?=
 =?iso-8859-1?Q?EUSzakW/Q7mxkTtzMhBiduf1lsF6BtSfux6qWlY81fKl8wfleoGhRNf5Lm?=
 =?iso-8859-1?Q?ac1pE0H34Ps9YVS2i478ZF4jYbaOGEg/EV3NE3OTwtwDYwERZI7hKwZdos?=
 =?iso-8859-1?Q?uCMUSWpOKC4CnCar6VtRiwvfSzwSOiaMwO/Kc9mXKcUMiyONVhwBbTSP1n?=
 =?iso-8859-1?Q?2xTHaQVcYRds3oU6NYU+rTiE5TxvMteEnWv6XNfk3FoLdb1ZFlMpZFId0n?=
 =?iso-8859-1?Q?YgGz0hbr3EudLknUSSTt5CZD8d67vu0XnX2vjd/MVj2bVEOOfPXicfpvah?=
 =?iso-8859-1?Q?7mVaOKshZKC90dJJAhC5zVFrh4Sv0djB9xFTlchtkB09sLvsHsQlDZJbuw?=
 =?iso-8859-1?Q?jvky4F+Wdu449f7+aOg7NWxtC/eWa5PB/BEOTd+kY4nCcAGXCgCA3//sRr?=
 =?iso-8859-1?Q?CwtYxEgSTGeTaggoVYvbSLOa8DlXDeFNvga+vdUpDrDb2J6P58H5Qh1LyK?=
 =?iso-8859-1?Q?RziCtAFir5M5PFMUmwOgU0fVDhuL2xF3Kvc7pZdiagRf3NF/x8ZqKWY94P?=
 =?iso-8859-1?Q?Mplz+Yj1R5SNrjRa9Zszsi14M02Gp+T6hOQZm/cArYAAZYjQw3Kp/SUVxP?=
 =?iso-8859-1?Q?7qcd9TQFov7J1oJ46jclckbFGbafK3LSqBIg7ReHshj7IzN2Y61ZMMn0dq?=
 =?iso-8859-1?Q?OQNdRsevUKSy7DhzJm0W2B1pyziI1yddZumNM6pk2O56s3XWU+pnyLJUkb?=
 =?iso-8859-1?Q?hfJ/YaZOO5ng4L3xaA8G5vD9Gx1YPaM7wQWSGUeHt2N0z4vHBTf3/l3lbg?=
 =?iso-8859-1?Q?AF8QKEKFZVMzCMC77e29pj0F2aqnjgmAuhTRZbghAKTaFiH912SFEspk4H?=
 =?iso-8859-1?Q?0hrldL2t51mNJMX7y8P/VTaP8R0JYqTgyzBoN9b5+7JDhmaJF6Ex8YcrZI?=
 =?iso-8859-1?Q?S8NPxR0lbZlr2O8+b1AkNBvqztxtIScY21T1gDQo5TNkcgVXz8Q1?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 00f887ef-052f-41d8-c601-08df0e2d7ec1
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 04:47:47.3902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9cRIDFNltlAsXfDwOe+Rwcux9lJ1MfyxZIcG0rNmrggsFhjEAaZru/ZNvam/WY4mX2XglfyGKPvDX5GaDxDG9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB3515

On Mon, Sep 07, 2026 at 02:43:02PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 6 potential issue(s) to consider:
> 
> New issues:
> - [Medium] Coding Pattern Violation: Mixing guard() and goto-based cleanup

I think this is a pre-existing issue, ie. this patch does not introduce any
regression around this. Correct me if I'm wrong.

Best regards,
Koichiro

> 
> Pre-existing issues:
> - [High] Memory Ordering Race leading to lost wakeups
> - [High] Data Race in ntb_qp_link_cleanup allowing concurrent execution
> - [High] DMA Memory Corruption due to unterminated transactions
> - [High] Missing read memory barrier (dma_rmb) when reading payload after checking DESC_DONE_FLAG
> - [High] Stale Data Transmission due to missing flush on link down
> --
> 
> commit 3aa5fe6a4883f5e1056224f4eb903786b4edfe5a
> Author: Koichiro Den <den@valinux.co.jp>
> 
>     NTB: ntb_transport: Clear link state before QP cleanup
> 
>     Cleanup leaves the transport link marked up after releasing its MWs, allowing
>     client link-up requests to start QP link work prematurely. Clear link_is_up
>     before cancelling QP work and releasing MWs. Additionally, ensure QP link
>     work returns if the transport went down after it was queued.
> 
> > diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> > index 411017873a83b..4c0a29693ac23 100644
> > --- a/drivers/ntb/ntb_transport.c
> > +++ b/drivers/ntb/ntb_transport.c
> > @@ -990,6 +990,8 @@ static void ntb_transport_link_cleanup(struct ntb_transport_ctx *nt)
> >  
> >  	guard(mutex)(&nt->link_event_lock);
> >  
> > +	WRITE_ONCE(nt->link_is_up, false);
> > +
> >  	qp_bitmap_alloc = nt->qp_bitmap & ~nt->qp_bitmap_free;
> >  
> >  	/* Pass along the info to any clients */
> 
> [Severity: High]
> This is a pre-existing issue, but does this cleanup routine allow concurrent
> execution?
> 
> Looking at ntb_transport_link_cleanup(), it calls ntb_qp_link_cleanup() on all
> active QPs, and then synchronizes cancellation using cancel_work_sync():
> 
> drivers/ntb/ntb_transport.c:ntb_transport_link_cleanup() {
>     ...
>     for (i = 0; i < nt->qp_count; i++)
>         if (nt->qp_bitmap_alloc & BIT_ULL(i)) {
>             struct ntb_transport_qp *qp = &nt->qp_vec[i];
>             ntb_qp_link_cleanup(qp);
>             cancel_work_sync(&qp->link_cleanup);
>         }
>     ...
> }
> 
> If the ntb_qp_link_cleanup_work() worker is concurrently executing, it will
> also invoke ntb_qp_link_cleanup(). Since no lock synchronizes
> ntb_qp_link_cleanup(), it can execute concurrently across threads. This could
> lead to data races when resetting QP indices and cause duplicate concurrent
> calls to the client's event_handler, potentially corrupting the client driver
> state.
> 
> [Severity: High]
> This is a pre-existing issue, but is it possible for active DMA transactions to
> corrupt freed memory here?
> 
> Later in ntb_transport_link_cleanup(), it frees the backing DMA memory:
> 
> drivers/ntb/ntb_transport.c:ntb_transport_link_cleanup() {
>     ...
>     for (i = 0; i < nt->mw_count; i++)
>         ntb_free_mw(nt, i);
>     ...
> }
> 
> ntb_free_mw() calls dma_free_attrs() without ensuring the DMA channel is
> stopped. Prior to this, ntb_qp_link_cleanup() kills the RX tasklet with
> tasklet_kill(&qp->rxc_db_work), but does not terminate active DMA engine
> transactions (e.g., via dmaengine_terminate_all()).
> 
> If a DMA transfer was previously submitted, could it continue asynchronously in
> hardware, writing into the freed memory pages and leading to IOMMU faults or
> memory corruption?
> 
> [Severity: High]
> This is a pre-existing issue, but does resetting the link context leave stale
> data in the transmit queues?
> 
> When the link goes down, ntb_qp_link_down_reset() is called:
> 
> drivers/ntb/ntb_transport.c:ntb_qp_link_down_reset() {
>     ...
>     ntb_qp_link_context_reset(qp);
>     remote_rx_info = READ_ONCE(qp->remote_rx_info);
>     ...
> }
> 
> The QP context and indices (like qp->tx_index) are reset to 0, but pending
> entries in qp->tx_offl_q or other transmit queues are not flushed. These
> pending entries already have their entry->tx_index populated with old index
> values from before the link dropped.
> 
> When the tx_offload_thread processes them, could it write the data to the
> old, stale index locations instead of starting correctly at index 0, causing
> the remote receiver to hang or receive out-of-sequence packets?
> 
> [ ... ]
> 
> [Severity: Medium]
> Does ntb_transport_link_work() mix scope-based guard macros with legacy
> goto-based error cleanup?
> 
> The cleanup.md documentation explicitly mandates that usage of "goto" and
> cleanup helpers must never be mixed in the same function.
> 
> drivers/ntb/ntb_transport.c:ntb_transport_link_work() {
>     ...
>     guard(mutex)(&nt->link_event_lock);
>     ...
>         rc = ntb_set_mw(nt, i, val64);
>         if (rc)
>             goto out1;
>     ...
> out1:
>     for (i = 0; i < nt->mw_count; i++)
>         ntb_free_mw(nt, i);
>     ...
> }
> 
> This function uses guard(mutex)(&nt->link_event_lock) at the beginning, but
> continues to use goto out1; and goto out; for error handling and legacy cleanup
> paths. Does this violate the established architectural cleanup pattern?
> 
> [ ... ]
> 
> > @@ -1149,7 +1151,9 @@ static void ntb_qp_link_work(struct work_struct *work)
> >  	struct ntb_transport_ctx *nt = qp->transport;
> >  	int val;
> >  
> > -	WARN_ON(!nt->link_is_up);
> > +	/* Pair with the link publication in ntb_transport_link_work(). */
> > +	if (!smp_load_acquire(&nt->link_is_up))
> > +		return;
> >  
> >  	val = ntb_spad_read(nt->ndev, QP_LINKS);
> >  
> 
> [Severity: High]
> This is a pre-existing issue, but does this Dekker's algorithm pattern lack a
> full memory barrier, potentially leading to lost wakeups?
> 
> In ntb_transport_link_work(), nt->link_is_up is stored and qp->client_ready is
> read:
> 
> drivers/ntb/ntb_transport.c:ntb_transport_link_work() {
>     ...
>     smp_store_release(&nt->link_is_up, true);
> 
>     for (i = 0; i < nt->qp_count; i++) {
>         struct ntb_transport_qp *qp = &nt->qp_vec[i];
> 
>         if (qp->client_ready)
>             ntb_transport_schedule_qp_link(qp, 0);
>     }
>     ...
> }
> 
> Concurrently, ntb_transport_link_up() stores qp->client_ready and reads
> nt->link_is_up:
> 
> drivers/ntb/ntb_transport.c:ntb_transport_link_up() {
>     ...
>     qp->client_ready = true;
>     ntb_transport_schedule_qp_link(qp, 0);
>     ...
> }
> 
> Inside ntb_transport_schedule_qp_link(), it checks
> smp_load_acquire(&nt->link_is_up). Because smp_store_release() allows
> subsequent loads to be reordered before the store, and smp_load_acquire()
> allows preceding stores to be reordered after the load, both threads can read
> false for the counterpart flag.
> 
> Could this result in a lost wakeup where the QP link fails to initialize?
> 
> [ ... ]
> 
> [Severity: High]
> This is a pre-existing issue, but is a read memory barrier required after
> checking the DESC_DONE_FLAG?
> 
> In ntb_process_rxc(), the descriptor's done flag is read from the DMA-mapped
> memory to verify packet completion:
> 
> drivers/ntb/ntb_transport.c:ntb_process_rxc() {
>     ...
>     if (!(hdr->flags & DESC_DONE_FLAG)) {
>         dev_dbg(&qp->ndev->pdev->dev, "done flag not set\n");
>         qp->rx_ring_empty++;
>         return -EAGAIN;
>     }
>     ...
> }
> 
> However, there is no dma_rmb() issued after observing the flag. Could this
> allow the CPU to speculatively read the subsequent header fields (e.g.,
> hdr->ver, hdr->len) and the payload buffer before the done flag read
> completes, resulting in stale data being processed?
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260907142429.951930-1-den@valinux.co.jp?part=7
