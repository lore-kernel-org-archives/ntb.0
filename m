Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020138.outbound.protection.outlook.com [52.101.228.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E8E136351
	for <ntb@lists.linux.dev>; Fri, 28 Aug 2026 01:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787879211; cv=fail; b=hG7/IfxE/6VXZww4EBaumB7VmBIKxusJTooB9IkWdLnBFV8dJcQHBNVFKgkRHhyeqeVxGrh/pFErokvqYoT/G9H7tHJDcxomngpZHUjKy5SZYDvKSslPRSDerCPhVZEJmOKCUQWd4mnh4JOh6u10Jk4CVjhg8cOkEB/zVqk3TAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787879211; c=relaxed/simple;
	bh=qekyD5S33AWYXZXKI24JL2Wr576A5ySoAvGhHLFolgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Cr/IadEVZjBA/VHie7k62lmkvJ05We3b1+WhoL3sqKxFp+sXKq4vLg4/sel3Syh0dGLxT02VhWbK26p+g2OPZUxucbK9MAf/t9SbdedeDdEwIXotKUMJkwF6mxZQ1BLWz/VS+pPBg7SqwRmcrRXo1yg4qyu4CgSzvGHAfioMNrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=mDo1P52q; arc=fail smtp.client-ip=52.101.228.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="mDo1P52q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KFznWQxWj6sXRnUbQcId1WkqjpeJeChQ0RufwKXXSVBtZV98EZ+YV/NpkwuJi9Efc8FdYM+mCtmEFPAFEUaxPQyobQ/gwNEoS1OzCAbevbLAgI+RC/+Gx5hE5F+8z/hHc4xiEjMvv4sTNAKp7t7NIbeg02TjMCF59teT5qK0VKNjj8MLZ6CbgRPJGjD3ejgYuusozEUhWVMuaMsAd1GLH1C1lqlyxAUCiQCPOaCnCEWiuM3DCc595Y1pqqYLdT3dPW3E6d1O4oeDyf7LS+3EU4XHO2k7Wr8hT05UyD2YRv+J61vd18Ev++6nKHDrA5gYg8yRy/I2KZn1tECl8jDBuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DQ+eWYdh9R3hFSdnn4DCvSf61t/77+JEJRG88GcGzdc=;
 b=Jo0FptMDnr/hm7bZdgNs/U5LHV5m+jk6jAgxKOF3kqSQya4PoJrAkHQIuvlI0xiq1fV1+UyAfavq7GCdZD9UaCXrVl4hDF9ISm2L+xULhRoSgezkCgg51hD7uBHQHgSgeWceXz2FzVhhws1rvtTH/X8foY4QS77Meu0BabtwZQ6rnhOrJ1wpu4Tj5d7+xJdjNWxUHg7m9YKyqV0aE6JwvUh+2ooVKL+6w813ukU8eZtmqqs9mnFYBaQ81c0Zrxu9Gn9sFT4jQ4NlxAp5fu73XfqqI/fcdLqhZjccgncRYUzu1yZttR47jU9cohxuCb/HUSVmMw8F6o1rS+ZzckgTeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DQ+eWYdh9R3hFSdnn4DCvSf61t/77+JEJRG88GcGzdc=;
 b=mDo1P52qzc33qaf7J//pXL8O0shOfjoRyfSWnJwHExTDrd0jTA/PllwymiT9ibCL9Cz5xIfdGskZw57ioIC2tEARrp+r9psGHmIb6/SvhiKd4i4studGJXWP+aEqyQTWHyZxYxjsmzWRubZ/wIusZ86pcYJO/G7AlvjRHzQZDuY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY3P286MB3804.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:377::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 01:06:43 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 01:06:43 +0000
Date: Fri, 28 Aug 2026 10:06:41 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Simon Horman <horms@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Jon Mason <jdmason@kudzu.us>, 
	Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	ntb@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: ntb_netdev: Fix statistics races
Message-ID: <iiyqrqqmoqyh5w5hvr3q7hxnetuw3iwwnxcmj7sid44xwjzlsk@wt2yn2u6cj3i>
References: <20260824025720.3520288-1-den@valinux.co.jp>
 <20260827110445.GD396647@horms.kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827110445.GD396647@horms.kernel.org>
X-ClientProxiedBy: TYCP301CA0046.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:384::10) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY3P286MB3804:EE_
X-MS-Office365-Filtering-Correlation-Id: 1090bd95-1f53-45e5-a28b-08df04a09fab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|10070799003|1800799024|366016|20046099003|18002099003|22082099003|5023799004|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	GEuL1uIqcsA7GP+TIDyEXOEZQgWOLYwB7QefvFxASPmHSxeG5C5gegJ0iYT1tE/0IGknK0WMp9bZgpEqf1EjDjggb/CaxS8nQUesVMH1PZHjHuzEuACWA3Ad74KSLmIBK6gBJYyM9XEpCjYcdsVP+OZtd2pnVrJvJlGhVOmFWeTzVNYPLuleFo+PZ2H3acNICo58F9uEgdsWys9TDS7fx2XfPNGDaWYPEB+YdNc1gXH4tcCvY8QQz1QJxNnrG5ztpCXFI953iR2hG0fh66ngizRX+RmRNuIZFOdOy2m5v41k7zs06ELzf+NrY1OasmPHa3xOaCHW6weECLQHGjs9ElS0o1tm5AMw9BcQnEfK4KTT1fowVIHktzYGejtHN8fNwO08V8JawCCXWplzcCOOvr2znxhWQFaZ3TGFdiWuEyYG1iShjsjnj3TtqaqYSgoyentrAF0KjIAmJk7sCVrBg+vGN05Ln5HvJ81eflcep3rmdV24bmc6qr0NyZT8OC35PXE4TUeD71m7AtjvVHfpV7BW9QrhiPvSfJPZHty77yWwkOnzUpBF4r4R9bIc1MEPqcGQcJ3GrFkYLG7sp8rEikXM3eg9ZNZ4B3Ms+m6u+XpOJCbB99dIAThx2VLvEP5B
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(10070799003)(1800799024)(366016)(20046099003)(18002099003)(22082099003)(5023799004)(56012099006)(4143699003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fWJjpmwMPMHL70cSWjJFkH8+SA4tJjiOYNJpXGRlloEl7sMpdHW75omTjTJM?=
 =?us-ascii?Q?lQeAD1Np2HazO411MfrCgUcD6OWwr2x5l0ZuGTlOLlZsgr/ndlZJXwXv2kmo?=
 =?us-ascii?Q?P9Rhwv14lAXu9JGJ4CrRFW0C/JU5p4santMWiwsP7FxkEALJ8HqGLLQOXSAb?=
 =?us-ascii?Q?TWB3oetMlKAp7Ioh/9mcoTvHV+6Lor5PbCq/d+jZ8TGkDJAQGU9kPxfhyL84?=
 =?us-ascii?Q?1RphtAXwNiKJ2Ws9p8//QiL4xJJjuWJ57bpdEr5+k1bsYTnyXMEfor+mskK3?=
 =?us-ascii?Q?V2wKuxVzLhn/P7h/63EtrZ61dTnaHRUfp+TY2L9Kj2He+z1WvJ2UlHzdrkpf?=
 =?us-ascii?Q?qTaVwcuQd7eEvE1tHW+G/8ebtu2l4/+/wK+/njC9uPp2+nqrBmunNwfa1I4s?=
 =?us-ascii?Q?8IEJmIHwQL4aGF8yPRm9keGe9uzGWVWDSzu9p5xIC5QOoTe8k8DhThYL9eHa?=
 =?us-ascii?Q?hIhyJ2xz3hXdqNexdT8uk0spDK2YOUgb/OqqkCPwgoUUabasSRdwijUD3nlC?=
 =?us-ascii?Q?xqEYtkCsktLx6pKf/wk2nMepR4T3hCAaFS1bZcdBYM4qvPVtvNz0ybGqDbVz?=
 =?us-ascii?Q?3+jY6nI+YSFqNFDQhYB5ETIPi08NVgDRCPEZW5EpPEfpQCWKzuJzpUSyIpYk?=
 =?us-ascii?Q?Ccj0PaF/6pjsS0B7a+bWtIHwRHF3SXty7DHrvtSMBX4Gz5UZCTy5eZs5y+/g?=
 =?us-ascii?Q?jZ2Xy9lJmso6kO3wJv1EghbRIpChLyo5vM5qjoHqnvHr+4lLUtcdsBVBOVE0?=
 =?us-ascii?Q?JMTNzi8IZarQa1KQRDcQ+tmaY6LfXz+FO96sd6i5Nf3YDFUjwezAHRmH0wXw?=
 =?us-ascii?Q?dSrsm4J99rsq5kQD7prtbc8x0abnHYdWdVkzvAU0uMUk3dNIr7U3JC/jCKUA?=
 =?us-ascii?Q?d7AeiPDhUAPTwrS3M1qOSG+rsjbU/U/uxbxSYhZTmfjBFkiCJkOkphW4JX+g?=
 =?us-ascii?Q?mp1cHUWtX8WLGnSxB/lz4JxWkC+f2qFJmc6678pFtdsdil6CuiJkFF18HE2W?=
 =?us-ascii?Q?zWQL1tLHMoSTXiyCzH5xKulEtfuDCR/w1G7HxrJJF6OUH3NpAujJUZ7noFkJ?=
 =?us-ascii?Q?BKUL/QMrNe+KqVx4dKagRihsM6ClfA3Jkf441f0jsgkDhXT1WKFa3dGBy+wb?=
 =?us-ascii?Q?c42KHs58Ncd11eHD58eHSwzUthZEpYZDyXwvPI13BdWbBWpiv5vyHxEMx3LJ?=
 =?us-ascii?Q?HCmR53RDWQrlAlWLEeUu+gGK14POzTc8WLMJDUbVeD8Q279A6oOJWh6I3JvG?=
 =?us-ascii?Q?kCu3oUcgDVJ3K5YMdwfHnbHf7KeywwPVKoQgDp4PuY5wTFkY6UvnreKIDhbi?=
 =?us-ascii?Q?ZgzSMrWas5eEgfQW88Jt3OixcAgCi95lIc+/gZdeQHXXI1QanANqmnGiAd8G?=
 =?us-ascii?Q?h7iV+NyIDhtTCYiDIE40TJ8aDBM3dA1ERGeoKKoj+VLfc+A55QYJtUXdu8N6?=
 =?us-ascii?Q?rNj5ga9nZn1aQA8dAtZhxVw/9hTKf24QW1c+KrVeOVkCZ3eJzWBtiLc87XNu?=
 =?us-ascii?Q?P+nR4TK5GHtJeQFxCd1rCQPPwp63P8XtwaY0ijfkdWOWVZEh/BBVmAleYXQI?=
 =?us-ascii?Q?6zw6+Y1oLgyq2YOM4/xTcjz5zJtR0d4GQQ8fUBPJHBNFrUaigM/DvtmmfPts?=
 =?us-ascii?Q?A0EwLNFiJZ24gFFxJ+/xDjoSb6+AETK2yLPz5L9V670+YTMvaknS8bAfprNP?=
 =?us-ascii?Q?xZYsZyAKHl/uurz+sWrK3EifHm0P25+z/MT6+eVtfZupp1gUl/Gj50vkDsJ1?=
 =?us-ascii?Q?JXtqKgjpxgNPyKh/FMZMIcoHIGuHUi8bF7Yq08QhdBVzM0+/eMhZ?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 1090bd95-1f53-45e5-a28b-08df04a09fab
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 01:06:43.1168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tOL32jBrjZG+sQTVAMB0+MhZMwyuqJOzmzOVGI7XO2X3wYItBxj2H58TWM15X6x7s4FfNxvqoJ3LVUjfk/EdHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB3804

On Thu, Aug 27, 2026 at 12:04:45PM +0100, Simon Horman wrote:
> On Mon, Aug 24, 2026 at 11:57:20AM +0900, Koichiro Den wrote:
> > ntb_netdev updates shared net_device stats from per-QP RX and TX
> > callbacks. Once multiple queues are enabled, concurrent updates can be
> > lost.
> > 
> > Use core-managed per-CPU dstats for packet, byte and drop counters.
> > Keep infrequent error counters in net_device_stats with atomic
> > DEV_STATS_INC(). The core handles allocation and aggregation.
> > 
> > Transport queues can still complete after ndo_stop. Tear them down from
> > ndo_uninit before the core frees dstats.
> > 
> > Fixes: 24d9e73c7e00 ("net: ntb_netdev: Support ethtool channels for multi-queue")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> > This is the follow-up mentioned here:
> > https://lore.kernel.org/r/20260819172539.1450821-1-den@valinux.co.jp/
> > The related TX and RX fixes have now landed in net.
> > 
> >  drivers/net/ntb_netdev.c | 44 ++++++++++++++++++++++++----------------
> >  1 file changed, 27 insertions(+), 17 deletions(-)
> > 
> > diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
> > index 9c171697e762..6a1e58d5d7d6 100644
> > --- a/drivers/net/ntb_netdev.c
> > +++ b/drivers/net/ntb_netdev.c
> 
> ...
> 
> > @@ -219,11 +218,13 @@ static void ntb_netdev_tx_handler(struct ntb_transport_qp *qp, void *qp_data,
> >  		return;
> >  
> >  	if (len > 0) {
> > -		ndev->stats.tx_packets++;
> > -		ndev->stats.tx_bytes += skb->len;
> > +		/* TX completion may run from the memcpy kthread. */
> > +		local_bh_disable();
> > +		dev_dstats_tx_add(ndev, skb->len);
> > +		local_bh_enable();
> 
> 
> Hi Den-san,
> 
> There is an AI-generated review of this patch available at [1].
> This is separate to the AI-generated review forwarded elswhere in this
> thread by sashiko-bot.
> 
> [1] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260824025720.3520288-1-den%40valinux.co.jp

Hi Simon,

Thanks. I missed both the netdev-ai report (again) and the netpoll context.
I'll respin this.

> 
> It raises a concern regarding using local_bh_disable/local_bh_enable.
> And I wonder if this might be addressed by unrolling dev_dstats_tx_add,
> something like this:
> 
> 		u64_stats_update_begin_irqsave(&dstats->syncp, syncp_flags);
> 		u64_stats_inc(&dstats->tx_packets);
> 		u64_stats_add(&dstats->tx_bytes, skb->len);
> 		u64_stats_update_end_irqrestore(&dstats->syncp, syncp_flags);

Looking around, I'm thinking of following the same pattern as
mctp_usblib_tx_stats_update(), using tstats:

  tstats = get_cpu_ptr(ndev->tstats);
  flags = u64_stats_update_begin_irqsave(&tstats->syncp);
  ...
  u64_stats_update_end_irqrestore(&tstats->syncp, flags);
  put_cpu_ptr(ndev->tstats);

Leaving pcpu_stat_type as NONE makes it driver-owned, so they can remain alive
until ntb_transport_free_queue() has finished. This should let me restore the
original teardown order, with QP teardown after unregister_netdev(), without
moving the DMA waits under RTNL.

Best regards,
Koichiro

> 
> AI-generated review text:
> 
>   Can ntb_netdev_tx_handler() run with interrupts disabled here?
> 
>   With the ntb_transport defaults (use_dma=false, tx_memcpy_offload=false)
>   the TX completion is not deferred to a kthread at all, it runs inline in
>   the ndo_start_xmit caller's context:
> 
>   ntb_netdev_start_xmit()
>     ntb_transport_tx_enqueue()
>       ntb_process_tx()
>         ntb_async_tx()            /* chan == NULL, goto err */
>           ntb_memcpy_tx()
>             ntb_memcpy_tx_on_stack()
>               ntb_tx_copy_callback()
>                 qp->tx_handler()  == ntb_netdev_tx_handler()
> 
>   netpoll calls ndo_start_xmit with interrupts off:
> 
>   net/core/netpoll.c:netpoll_send_skb() {
> 	...
> 	local_irq_save(flags);
> 	ret = __netpoll_send_skb(np, skb);
> 	local_irq_restore(flags);
> 	...
>   }
> 
>   and ntb_netdev does not set IFF_DISABLE_NETPOLL, so netconsole can bind
>   to the interface. In that context local_bh_enable() hits:
> 
>   kernel/softirq.c:__local_bh_enable_ip() {
> 	WARN_ON_ONCE(in_hardirq());
> 	lockdep_assert_irqs_enabled();
> 	...
> 	if (unlikely(!in_interrupt() && local_softirq_pending()))
> 		do_softirq();
> 	...
>   }
> 
>   so besides the splat, softirqs would be run from inside a netpoll/printk
>   section that expects interrupts to stay disabled.
> 
>   The pre-existing dev_kfree_skb_any() a couple of lines below already
>   assumes this handler can be entered from hardirq or with IRQs disabled,
>   which is the same assumption the plain ndev->stats.tx_packets++ was safe
>   under.
> 
>   There is also a second entry path: ntb_async_tx_submit() installs
>   ntb_tx_copy_callback() as txd->callback_result, and whether a dmaengine
>   provider calls that from hardirq is up to the provider. If it does, a
>   BH-disable is not enough to protect the pcpu_dstats syncp that the RX
>   side writes from the rxc_db tasklet on the same CPU, so on 32-bit the
>   seqcount can be torn.
> 
>   Would an IRQ-safe update (local_irq_save()/local_irq_restore() around
>   the update, or u64_stats_update_begin_irqsave() on
>   this_cpu_ptr(ndev->dstats)) be correct in all of these contexts?
> 
> >  	} else {
> > -		ndev->stats.tx_errors++;
> > -		ndev->stats.tx_aborted_errors++;
> > +		DEV_STATS_INC(ndev, tx_errors);
> > +		DEV_STATS_INC(ndev, tx_aborted_errors);
> >  	}
> >  
> >  	dev_kfree_skb_any(skb);
> > @@ -277,7 +278,7 @@ static netdev_tx_t ntb_netdev_start_xmit(struct sk_buff *skb,
> >  
> >  drop:
> >  	dev_kfree_skb_any(skb);
> > -	ndev->stats.tx_dropped++;
> > +	dev_dstats_tx_dropped(ndev);
> >  	return NETDEV_TX_OK;
> >  }
> >  
> > @@ -427,7 +428,19 @@ static int ntb_netdev_change_mtu(struct net_device *ndev, int new_mtu)
> >  	return rc;
> >  }
> >  
> > +static void ntb_netdev_uninit(struct net_device *ndev)
> > +{
> > +	struct ntb_netdev *dev = netdev_priv(ndev);
> > +	unsigned int q;
> > +
> > +	for (q = 0; q < dev->num_queues; q++) {
> > +		ntb_transport_free_queue(dev->queues[q].qp);
> > +		dev->queues[q].qp = NULL;
> > +	}
> > +}
> > +
> 
> [1] also raises a concern here relating to holding RTNL for too long.
> 
> I wonder if this can be addressed by quiescing the queues in
> ntb_netdev_uninit() while leaving the calls ntb_transport_free_queue()
> until after unregister_netdev() has been called in ntb_netdev_remove().
> 
> AI-generated review text:
> 
>   How long can RTNL be held by this new ndo_uninit path?
> 
>   ndo_uninit is called from unregister_netdevice_many_notify() with RTNL
>   held (unregister_netdev() -> rtnl_net_dev_lock()):
> 
>   net/core/dev.c:unregister_netdevice_many_notify() {
> 	...
> 		if (dev->netdev_ops->ndo_uninit)
> 			dev->netdev_ops->ndo_uninit(dev);
> 	...
>   }
> 
>   ntb_transport_free_queue() then drains the DMA channels for each queue
>   pair, once for TX and once for RX:
> 
>   drivers/ntb/ntb_transport.c:ntb_transport_free_queue() {
> 	...
> 		dma_sync_wait(chan, qp->last_cookie);
> 		dmaengine_terminate_all(chan);
> 	...
>   }
> 
>   and dma_sync_wait() is a busy-poll with a 5 second timeout and no early
>   abort:
> 
>   drivers/dma/dmaengine.c:dma_sync_wait() {
> 	unsigned long dma_sync_wait_timeout = jiffies + msecs_to_jiffies(5000);
> 	dma_async_issue_pending(chan);
> 	do {
> 		status = dma_async_is_tx_complete(chan, cookie, NULL, NULL);
> 		if (time_after_eq(jiffies, dma_sync_wait_timeout)) {
> 			dev_err(chan->device->dev, "%s: timeout!\n", __func__);
> 			return DMA_ERROR;
> 		}
> 		if (status != DMA_IN_PROGRESS)
> 			break;
> 		cpu_relax();
> 	} while (1);
> 	...
>   }
> 
>   With use_dma=1 and a wedged channel or a downed peer, that is up to
>   roughly 10 seconds of spinning per queue pair, multiplied by
>   dev->num_queues, plus kthread_stop(), tasklet_kill() and
>   cancel_delayed_work_sync(), all under RTNL. Before this patch the same
>   loop ran in ntb_netdev_remove() after unregister_netdev() returned, with
>   no locks held.
> 
>   Since the stats fix only needs the transport callbacks to stop before
>   the core frees dstats, could the channel drain and release stay in
>   ntb_netdev_remove()?
> 
> >  static const struct net_device_ops ntb_netdev_ops = {
> > +	.ndo_uninit = ntb_netdev_uninit,
> >  	.ndo_open = ntb_netdev_open,
> >  	.ndo_stop = ntb_netdev_close,
> >  	.ndo_start_xmit = ntb_netdev_start_xmit,
> > @@ -647,6 +660,7 @@ static int ntb_netdev_probe(struct device *client_dev)
> >  	}
> >  
> >  	ndev->features = NETIF_F_HIGHDMA;
> > +	ndev->pcpu_stat_type = NETDEV_PCPU_STAT_DSTATS;
> >  
> >  	ndev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
> >  
> > @@ -696,8 +710,7 @@ static int ntb_netdev_probe(struct device *client_dev)
> >  	return 0;
> >  
> >  err_free_qps:
> > -	for (q = 0; q < dev->num_queues; q++)
> > -		ntb_transport_free_queue(dev->queues[q].qp);
> > +	ntb_netdev_uninit(ndev);
> >  
> >  err_free_queues:
> >  	kfree(dev->queues);
> > @@ -711,11 +724,8 @@ static void ntb_netdev_remove(struct device *client_dev)
> >  {
> >  	struct net_device *ndev = dev_get_drvdata(client_dev);
> >  	struct ntb_netdev *dev = netdev_priv(ndev);
> > -	unsigned int q;
> >  
> >  	unregister_netdev(ndev);
> > -	for (q = 0; q < dev->num_queues; q++)
> > -		ntb_transport_free_queue(dev->queues[q].qp);
> >  
> >  	kfree(dev->queues);
> >  	free_netdev(ndev);
> > 
> > base-commit: 7cbfb180945ce529608e4d4e24a6d483699fab1e
> > -- 
> > 2.51.0
> > 
