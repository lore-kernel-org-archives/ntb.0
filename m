Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021092.outbound.protection.outlook.com [52.101.125.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF842367D3;
	Tue, 29 Sep 2026 01:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790645249; cv=fail; b=ZvhQnXr82TD5cUF1rXa3TB8VwLPJDyx4F/ALXQ4AB7JrFFXpJKsKWoBq1ICRGAvEH7uTM+R/bwF7HLwAFX1knfL1E3rsma0TKpAjDBXf4whanbpSgomZGxxWo4PrbA4qrJmWcBb/ya9pC4BfZttMU4hSw4vZb5IUqEBxTKgghLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790645249; c=relaxed/simple;
	bh=gbWj557I/0qJzNXA7YujDCBINRG7K5vgOQhyLCg4Mqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jdYh+4oO6U4MlfJKRBuJoAbHIagCoydkGZiRtdXnv5qmtVcHi0xiMKkvxayG6VnlLu46mgN0bziLE4oiO8X4EpBwucqXzZ81/5t3moBsW/wuXauhON71BjzgRRCgC/mqMG3G5yJgaDCiXTbRSrq6cQ9uT332sIT9k1bKG2rIqKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=fail (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=uWna/mdF reason="signature verification failed"; arc=fail smtp.client-ip=52.101.125.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="uWna/mdF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ndoJenDSoXgchQ3HggW+D4Elckgt7cUB01zB2vz3ihS06ongjJrdbcVGc+Lr4jT5mDkFYxn8g4WJCwIVLFptm2kY/P/xpumbBlpbEN8hrav9dp44gXSG6qCbUaTb/Xe3mWNZPNoy6YSKsMA3TJkBw/2huiFbQXKS9Bx87wT6PxNX41jaklNTRI4wOE3dSscnLeczWQl7FHf1xiGn7y7mZGMcI4mPTGxnl2xhQQ8Vkw++ulaklcyLZCyyjqRyF+9Qa4uwVbfS86CLYGfgebr9tuwM4OB5pvG5WawvCae9OrNCjoXxQk9RagKYMF+URD3F6ZwkoPVtw3JWMkjR1q1n1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s9vbW/14TWHT/Ba6hhSRq0Y8oP+SWLAfFcENQxI8zyY=;
 b=TRT5sKc3sXbUaIiQVVzL5DiLUHE8qk80EUM7xW6kVpV5VO/sAc4nT1SyRAHxw0hgiHFfZgix9O+k3jsLLQ2WKwLWgcOhELMeRsw/HF/g7rZ9M2jF3nJ5381nHsMEeGXmqtGSUgQ39DSzxtOzYKJDn58aPi9BlaRRmarPO5Hl3kg5K7hNvTJhjLjPPb6DljMNvcFXLQtjhKx35E7/DLBTBHKEy7+YzJjh2cAO/gVi+RalotEdLNypJdQEyrG0Fxw+mbvtVzQNh5QEsmAobHmHbx1qvXdyFSuSl2/XLfOCMU7nfBp9tqAgyXf4c5UrTllavpQQfzD9I1AgeLFvEnOOZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9vbW/14TWHT/Ba6hhSRq0Y8oP+SWLAfFcENQxI8zyY=;
 b=uWna/mdFfcY/zCzRh/8FwdZ/ivCLU6FrOfi6I7oPSgaYIWMLKFvjiBjLFQvrpq9aHrgxnOizY0CAmYSnH9esT32EtzD7YXit5UHugyP32BRw6uqPs46yJkYKObr+5eeTGItgQ3ijrt6leYd6Ig0gkrCVQ22+Qv9unAbhjxb97F4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TY4P286MB7207.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:366::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 01:27:22 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 01:27:21 +0000
Date: Tue, 29 Sep 2026 10:27:20 +0900
From: Koichiro Den <den@valinux.co.jp>
To: sashiko-reviews@lists.linux.dev
Cc: ntb@lists.linux.dev
Subject: Re: [PATCH v3 11/15] NTB: ntb_transport: Wait for RX completions
 before resetting a QP
Message-ID: <yt4rrm57ovjgxukko72ubfprr7maffakfj65rooobyq2wawn65@eeoah2kpci2y>
References: <20260928152550.3354675-1-den@valinux.co.jp>
 <20260928152550.3354675-12-den@valinux.co.jp>
 <20260928155410.783AD1F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260928155410.783AD1F000FF@smtp.kernel.org>
X-ClientProxiedBy: TY4P301CA0006.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:26f::10) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TY4P286MB7207:EE_
X-MS-Office365-Filtering-Correlation-Id: 796639bb-e558-4f25-d9ba-08df1dc8cf33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|10070799003|23010399003|1800799024|22082099003|18002099003|10067099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	iQkeOlMnWUq5qb+yG8FpEXA+AlGSL9/MqLsDyOI9/nr+HwFBI+Ks4Id0GsBNiZOMsR6+MsZ3gg2QxOfRcJOgqyg6aE3i6ISqGY5wyn802+HSJrKPKNFITu7VW2/QUVeZ9JtNLxJbM376usRHgL7UWsuSo0n4L0ffKpP8YelDrwz1gVExLgMqpzJUWlR2oWrpzS2Ohp0MgbnBGIMAGHkFdxr+B0JrnKYXZXp+ETgWAUQOg1+Hg3Fh750ujGMhtnGC2PSAiwKg8raxyIzcKxAE4YX0WG1H7bakQXhnk9i9Rj+XccLldCe4LDrbtMKCK514rc6znH2I9/icPQEb5TIkVYEUvMHfJz2lLrJsTK2hOi3IVdUb0qY6kVq1ftSzjVZMZb3uMBtlIkS/GRLBRIeKpJejdyIUtNf/tAH+MWZquGBGn0TXiokv4dTvu90rXi6xwH+4K6R7rwnLdsl4wmjgeaFH3lVIsTPwMuVAvcqknwJUrZVJnrsOcIUtIsbMCJ/r10skeOVNVlfrTvQ+0UrBG9+UDmj0tXRhblH8M3unXjGq8Q+tT8yPMMnDtcOXNMHdsddtbKTCJb9KuiwTJw8JY2HX8tWAzVZhuKl2jOxsIiU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(23010399003)(1800799024)(22082099003)(18002099003)(10067099003)(56012099006)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?mSNCF1HqrbL436kYscmPzwRh97QGDebEvFNdscjyJ4wDCR/eFu5gcv2/LK?=
 =?iso-8859-1?Q?OEodqWNYoceeQqgxHA71EAjj3n+jrSGOksovyB+b4ga85vIrlfxR34riqu?=
 =?iso-8859-1?Q?//d+X+PsJJhSyIy7uNU295yG7l8+u9TT+5e5glqznuXosNgrpZududy1nk?=
 =?iso-8859-1?Q?vtX2LMA7zRw8ps/qVs5JZ8m77Hu1exb5nSZY6sD9oTHH2Gjqk6jMAisBJD?=
 =?iso-8859-1?Q?YqCLATK36HdFwKj5OouNfXUg63+aoRbw+hz2ru+ZLO/kCng+hAu1vNWWTW?=
 =?iso-8859-1?Q?lsMkW9zmEz0vRM80hOAhalBNYuo4pHjxX/Ecju1EZqIWYkEsVlX4eVkOu5?=
 =?iso-8859-1?Q?JjQY2guRSuk7vWxwncK+8mS0I+0XGeFdPxIgVvflAEudB/TSQGGYiwG5uB?=
 =?iso-8859-1?Q?hw3BEGrjA/mJ+wCHS65PSJg8DhR1OwATGugWI4CFmIVuNxpB6MgFb/YMMl?=
 =?iso-8859-1?Q?/tOr229qdpjZLry3aXcxe1/YaitPHiHlF8CPzQugM3XWmFdQejYMYtrX8I?=
 =?iso-8859-1?Q?J3bJ+rAhmDAGl7BdpKyrhHRkU5f9TkCUBtrrTVlIWdma4BIueSJLFksSVc?=
 =?iso-8859-1?Q?wQYTXvRVbGqgfFIotEFv667Lln5RMFPYxQNvaaWoS/Y8V4ygZmglIkb/Q0?=
 =?iso-8859-1?Q?cnAUhoksMFRpj2L6EhRGluYs46bLq6y/D0EOtn+TUF23X5vLg+wWg6BlXY?=
 =?iso-8859-1?Q?5IcT/y60GmP8LphswRcwGhRZD5u5/auU1FwflBsPevqILxUsws/8Zq19wQ?=
 =?iso-8859-1?Q?Tw/ktmETq9weSeZJH4ypY9GXxWG6jd+ad3bs9j3yri1ikpSlveYTLApY67?=
 =?iso-8859-1?Q?GsP6542le1Sq/CThgi0sikJgwewPMULEoJOu/OWgkHeEBlSy5GVeB8YLec?=
 =?iso-8859-1?Q?NUDlXkdQ7oTBYxaQiWwMUuAFLBZqeC2e1hx9xKuOKC0gkRcNy5JZjqCcSy?=
 =?iso-8859-1?Q?7pFdMFanNfJ0aXe6W5vmbg4fG5gGOY/BJ3/esPx1Hd1pBKbrMZimSzXrAX?=
 =?iso-8859-1?Q?EvxXo27mI433EZWGLInKxyYFtKJqsMFHy+VZLxIWQ/zpj1AJAyM8vgSu1/?=
 =?iso-8859-1?Q?7nALhd4V26WQcQqakLODlwuK+FdXxRkbqaz81YTqH3ZZjlqXUvHFC4k8o8?=
 =?iso-8859-1?Q?/2jbF4nqUNTNMYgMLWQTDK5ov6MZcNLg9zBo6wSSlRfwenjrgdTRHNyBcm?=
 =?iso-8859-1?Q?tBjsWVIASjbUez41eLDxmTFxom12gq51GNDOxJ8ANdiC9CwB9OptL/0Yyp?=
 =?iso-8859-1?Q?SjO8Oif70AU8UB3f4j4BbQt4WxERfYEgeD6f6qjNRBFndmjB6J8osFmU2z?=
 =?iso-8859-1?Q?YS9afvcMxJAGmHZjaqvZUJQYVp5uY/jtECuRstvHyuZiPUr1x+cF31rKOA?=
 =?iso-8859-1?Q?M+k6Ycgf2JBbzeNXIo4PkQKqXHAxPa669LJolywcnKG9ul8OnUSkx8NLv3?=
 =?iso-8859-1?Q?K/Dw9xouUHWMFZkUaaAHDsjJmjRhi2fyHJLtB20gofC9EjMTDIX+NUNlkL?=
 =?iso-8859-1?Q?hMsJBP5V3SrMcnLCMrtwTIPmEd3mSVq5L7WvrRuTYR3IOK9mE1CzqWtEBP?=
 =?iso-8859-1?Q?0d4HdoS+AN7HRJqrEdfWI81LW1KVYPtt0CK1Mjlr6LV6Ej1rTJTAmpDESV?=
 =?iso-8859-1?Q?46yN4tjKbLEX+JuO9JR8YwG0+gdQZDGmzL9ZxOUTBYPO+q2FXeXGrspKmw?=
 =?iso-8859-1?Q?B9gF0KkDGew0xDVGvQ/Fj5YW6KfgX7eFh3bongmTbClZ6/v/LFycqR2DCo?=
 =?iso-8859-1?Q?nJBfgnpsx7uD+MAlD5jCXvTn/rtqfW1szJXdWRhSBTzkFoP+pyBEZn6jhg?=
 =?iso-8859-1?Q?tsqSkp3eq1FiFANN0P/V8MtHpYTSSY/jZmv89MKqYKKyiPGRR3up?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 796639bb-e558-4f25-d9ba-08df1dc8cf33
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 01:27:21.8614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C4BW73Q56HiDr8LO+AAbAfrkC6/I6J7cA7kT7o+NG+MfbS7vKm+2c2ZU2tdJ1pXcSFOa1Sk51SdYpoMo5sd5wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB7207

On Mon, Sep 28, 2026 at 03:54:10PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] ntb_transport: unbounded wait in ntb_qp_link_cleanup() can deadlock
> --
> 
> commit a765c073e53bc7d3e624d4540c20299c1d832801
> Author: Koichiro Den <den@valinux.co.jp>
> 
> NTB: ntb_transport: Wait for RX completions before resetting a QP
> 
> This commit adds a wait loop to ntb_qp_link_cleanup() to ensure the rx_post_q
> is fully drained before tearing down the connection. This prevents memory
> windows from being freed while they are still actively in use by the DMA
> hardware on systems that lack proper terminate and synchronize operations.
> 
> Link: https://lore.kernel.org/r/20260907144257.767281F00A3A@smtp.kernel.org/
> 
> > diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> > index 9f71af97a8ef9..8f1acf44bb53c 100644
> > --- a/drivers/ntb/ntb_transport.c
> > +++ b/drivers/ntb/ntb_transport.c
> 
> [ ... ]
> 
> > @@ -960,6 +967,17 @@ static void ntb_qp_link_cleanup(struct ntb_transport_qp *qp)
> >  	disable_delayed_work_sync(&qp->link_work);
> >  	ntb_transport_set_qp_active(qp, false);
> >  	tasklet_kill(&qp->rxc_db_work);
> > +	/*
> > +	 * Some DMA engines lack terminate/synchronize ops (e.g. IOAT), and
> > +	 * DMA_COMPLETION_NO_ORDER rules out cookie-based waits.
> > +	 *
> > +	 * Waiting for rx_post_q to empty suffices: ntb_complete_rxc() finishes
> > +	 * its MW accesses before removing each entry under ntb_rx_q_lock.
> > +	 * qp->active is false and rxc_db_work is stopped, so no new RX DMA
> > +	 * can be submitted.
> > +	 */
> > +	while (!ntb_transport_rx_idle(qp))
> > +		fsleep(1000);
> 
> [Severity: High]
> Could this loop wait indefinitely and cause a deadlock?
> 
> If a pending RX DMA operation never completes due to a wedged DMA engine,
> hardware fault, or dropped interrupt, ntb_complete_rxc() will never be called
> to remove the entry from rx_post_q.

It is a trade-off. If we time out and continue clean-up, DMA or its callback may
still acceass the freed memory, bringing back the UAF this patch is meant to
prevent.

> 
> Since the caller of this function, ntb_transport_link_cleanup(), acquires
> nt->link_event_lock prior to calling ntb_qp_link_cleanup(), an unbounded wait
> here could permanently deadlock the NTB link state machine and result in a
> hung task.

The RX completion path does not ever take link_event_lock, so holding it does
not prevent RX completion. There is no circular wait here, but clean-up can
indeed remain blocked if the dmaengine gets wedged (probably broken).

Best regards,
Koichiro

> 
> Would it make sense to add a timeout mechanism to this wait?
> 
> >  
> >  	ntb_qp_link_down_reset(qp);
> >
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260928152550.3354675-1-den@valinux.co.jp?part=11
