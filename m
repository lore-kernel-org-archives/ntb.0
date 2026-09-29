Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021111.outbound.protection.outlook.com [52.101.125.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2E21A9F91;
	Tue, 29 Sep 2026 01:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790645493; cv=fail; b=a8kkLcGo7QAO4LPH8poFunwCSQXrd2yqpmjZazxCh8NG0PG0JsV5B1hyRh0Qw+PDihMB8kLdP0A+0tBp+Lk33dQmKulZ+ewA+X+GXPC5nGKQ66eSimCc7rRyCUedUms3tJxXOTKN12i2ewPoukemg2+LPvvJxFu/shFSxNheNrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790645493; c=relaxed/simple;
	bh=MvXOHLkI8lKyOEV+VCqiJySeFlLIvPl5w9iYuMf09Wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nzK8rhIq/W6nAwD/2YiG86vjCr+oP2qAyoMndUOWMxYhGGACBZ6BbnvVqJgW7XB1dPr/zw62ChbliuoKtXOZLVAHbugTjmWZTXZnvP/vqNXCnI/K0WAGdhyG8jt+nSWuuc3is1GYlh59gDceSIHK7FYSvXwgkeHK2+UhTmXNgg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=fail (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=PDPumZEJ reason="signature verification failed"; arc=fail smtp.client-ip=52.101.125.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="PDPumZEJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rs8HCGP4s5hKercz6ZnN98MybOvoJoJmIJ6pgsVdtGOROcjzQJeHwxFieLU6dIelaKi61a2NQ54dPh3kJR4FV4kuZDPbnT73RPwDs2soxLug9+l8u0IUP9Nqz69KFnrqxbLKuwHj+QsMI/8BJsNTlv8kdz362Hzhko7bHIAu2l++adT7KEO/QFZUHVBM0t4rUGWHZ7Xjpq9rmXR2x7TOL2pMax2GVhZbh8yVipLifw23RI37Ob9+sgO1wylCNWWvmShrQvMhDzMAtMRVt5dm0w7dZJqUU0zr8nEp+YRRkpjQ0Gifi/fUgQa8+bIULjaQlg7uHigVCj5AxdBZL02qwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dwlvucKqLR23dJH7BiOski2MJHAf/4kH/iMZzQz4z/k=;
 b=eRREce0DxYn22vVT7IXvs9vhOUPoOTAsUZqmSbUYrIolafwI1GA79VenCIb7R8ziRzN5BM7Ks6X6GdOrqvsTloySyauVZEhUTtxsQCyV/oIGPWgT0wWm9OF3X7IbR474uSvPsU5iZYxYvLViHCHVX4aWip3A74G7PDrzh08TaepDs0QnaCVLrx8Swz93tQ9ukMjzQxl4CtYp75IFO+ZMmSujFmsg51D+RR3p9oCp5xXzXG25o5RgPKA1KuZt+aPfAwxoBRssZAK7zmwlzpYIOUwwMAyo/uIyH/t1+YUvg0R6H7XScoD4QHZOpb7D22ZsH0tkDcfGPX7EejCPCJ8Clg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dwlvucKqLR23dJH7BiOski2MJHAf/4kH/iMZzQz4z/k=;
 b=PDPumZEJ3pPY5E5gQJq6ps3QzIaflhqX0XR9XK2PbDhW6jIhpR6Walh8mICHs1zP6Oi/nLT2arWi6lqetupEvqz3EYDchx9Cr0m6lOrMXlbVHv6RRYOCd36VIG8A9A0tw3cvzClHU0Wea0zjCOpC5bg8dhk+Bwus+L8Fnjsuqng=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS9P286MB6568.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:418::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 01:31:28 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 01:31:28 +0000
Date: Tue, 29 Sep 2026 10:31:27 +0900
From: Koichiro Den <den@valinux.co.jp>
To: sashiko-reviews@lists.linux.dev
Cc: ntb@lists.linux.dev
Subject: Re: [PATCH v3 15/15] NTB: ntb_transport: Remove clients before
 freeing transport resources
Message-ID: <uqqrbx43oox44nlcofo4ddww354ack4hiwwbqfthyhupjfzdbr@6pboqe2e6ta2>
References: <20260928152550.3354675-1-den@valinux.co.jp>
 <20260928152550.3354675-16-den@valinux.co.jp>
 <20260928160444.4F31C1F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260928160444.4F31C1F000FF@smtp.kernel.org>
X-ClientProxiedBy: TYWPR01CA0050.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::19) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OS9P286MB6568:EE_
X-MS-Office365-Filtering-Correlation-Id: f188dc3b-d892-4604-9a81-08df1dc961fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|23010399003|376014|6133799003|10067099003|4143699003|5023799004|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	xqjEPK8Npc1nJ2gdCejbJcfK7grkL1SWdXUCCBmz+bijG0pCM5/0FoMHMWrRl66et3K5wpXh522fOIpPNG83JuR23jFEQ3u0HHj+0MOe+BmHh5Y1JiYmdoKYVERujHgdJsWF8qzV2J3iIpHRWqA/+3j5rRK8kEsVIEtyY1KOAhKbUKAbxc0153X/uw1+I4aThnV/XdzCJXJIEglAG6bM7Xmbk2sG795iSTJIEVwdfR1wHiN/42pcTG7iEtwqxoRIGHWWiazx0Ln+lxiDS3cIfL/bngJIcxdc/jXS4Z69wrzgGM7jpxvoHb5hFXm6X8l7wozGbbDWK5D3wWLZ9u/LtklIbjDi+Ow/tTUE4uoAjAPB1aTm0JU6bjbz3+/JMb1dvmpuhSo0pHabY/S9yChlFHgUK+PkPq/Kpsk0dzLw6yPVjlPrcIRNv3be9goKzDNcX6MwNHRJnDxsxRh7NbIsspa/wH9XNTYQK4KCGyCoKAanyY4BAZrkJHQZnZLY5dnfXW6hakQk5nlLpUOr76Fx0K/rd5QWtQ3ev+U3jnJVOlivaEJq9kYwU3PdEM539eaUv7YmBUrwy+LTvprHKZCWFeL7jwQcfTohzEeCTUIrrZg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(23010399003)(376014)(6133799003)(10067099003)(4143699003)(5023799004)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?BvEsVG+98PkP8ZPCwKrBekiNopTm13YIUFfbxe0AyeIHbJjzPN6QvMI3/V?=
 =?iso-8859-1?Q?0p2ZqcUz/mt3ETfuKDKiXKRYOOUkAOWvaFFidJcpPsqGa83BAhC2HpheNN?=
 =?iso-8859-1?Q?fu9EaVDeUb+IVq5xaCOx0Yj9KzzOpS8iquwCkD6IkW1TobGefYUOXV4SXB?=
 =?iso-8859-1?Q?kyqEiBYA3Qy9Gx4iDiBCF192ElAflVpC7v+hB/hbEtWlastpcJbckbCjA5?=
 =?iso-8859-1?Q?4C8qzLMp5zg9A0Mi2i1ZA5RoHRsLzCZjM3GANBe3bXibYcr29f7XiWrsPS?=
 =?iso-8859-1?Q?k8BNYjmQOjBTwpflFSU7ItRoSyBG5Q5I2BvShB7Ca7xq3rZZ7FxLS0jJZO?=
 =?iso-8859-1?Q?QL9RXE3HfnOsqEu6dNWUsQsZ2eBTkZV+F0sS1GCtdh3nFNFnXnGGYa96BM?=
 =?iso-8859-1?Q?FdyDQgIUOVS/HLkH88doTnvs4zulEutmtqINrFK9tcBK+oc4V3MHBzmDcD?=
 =?iso-8859-1?Q?G6ima1AqEAAl/QMD7xhElmPDyRVFutm4BIfR8qUyKzzMoqueqDSoHuvG1h?=
 =?iso-8859-1?Q?5w0Pf9FM3aIOU1LbUnMWuGGxjA7TprFic0P+kKeWExwcqVLWFo4kkZW1wT?=
 =?iso-8859-1?Q?wUE3+xfTxbVRxtQ/p0FWrWMCeIliWwix2lZejkPL16jS8Lj884eYIe327u?=
 =?iso-8859-1?Q?MjiI+HQUVL19m19nP30oX3kErKF91lDgWNg+OG9psOA6mE95ezK5MEvwTm?=
 =?iso-8859-1?Q?WInZOfsmAh20dTOIsLlLmpE/rIMmQMgPiEliAjfzHPN4l07GN30RuVl5Gj?=
 =?iso-8859-1?Q?HQcwSD8JZUQ+7c0k5wEX040zsJAAapayHvkz+48mcxt882fryUWgsVRH2h?=
 =?iso-8859-1?Q?D9MqnVkzvBfALmIfDESNuK50+dlpNz1RwttxNPkkuK8S79lpKGx1vlJ+uI?=
 =?iso-8859-1?Q?eRKI2XQS6sOsDXHqY1TORh52oCuMp65E/9NMw/69g+uQ6GlEfI13V81C5g?=
 =?iso-8859-1?Q?bAQ2HJ1PPtZBguRyWTojXOzCaCx74Sc/XQwzhQBpufQ4WXrakyAqk52vKf?=
 =?iso-8859-1?Q?vGXYDuQXeXyt3CXyVLsLiR1LZTgjnDYvVnSzG8GvQocLwBxiY5lhUXoVAf?=
 =?iso-8859-1?Q?nw1+X1odjN4IMxpLWx7s/m4UPlTP7Q1ZKVJypdmNfUiEkG7ttpyRlknlsj?=
 =?iso-8859-1?Q?mR8rPKuocCSirUI0uHxWp0uPCbwVUMdZcmd+P4MROBNeGZ4YCPiW7bsv7g?=
 =?iso-8859-1?Q?io8FI39AIGaDUd9c/oT/anWG+4TJxGG+jUUZtxSfjJo3nXz+IBkbORXmoK?=
 =?iso-8859-1?Q?cxRWXxsTTLmeRxlCRMxwjn+cjpJFgsrCIoTRVuY5hHyTjsiUZckRkfUVLZ?=
 =?iso-8859-1?Q?Qc2Q4T+dKORI4qrJFW6U9m2v2LTynF76455V4UKiBRcrJ0WbePzHag+Pfu?=
 =?iso-8859-1?Q?S11JnhhL78IW9UWlG34e5xb7+Nr0dRHWqDZfjhYRDViYLQ3OI3qbLpSn4B?=
 =?iso-8859-1?Q?pEREA3CyLo5eyqNF1CkKIv0AqSP8KMOMfLtvjNyLhUUzIxznMrE1spAYWI?=
 =?iso-8859-1?Q?OWPu6loMIh5a3CtTHcl0bWT046P8htipP/UwO9SVo2syu9GbXu+OCs3xQq?=
 =?iso-8859-1?Q?Yn1uuONetobiOYktEYR6apDQch9/bFVrS+aFwNpvLVdeL10wD+gBJJDl1K?=
 =?iso-8859-1?Q?MGeEtFu0qfSBE44yL7wAgWtPygIj6wVlH9iGIy24w8PoVHgpf0Zx+PAAhY?=
 =?iso-8859-1?Q?ObLxgTVjV2RU9CPOpFuEHVwVE/UiV3B9P/74R2t7aAjCCxBM5m8wt1Yzhi?=
 =?iso-8859-1?Q?WPvVfx7jqgdD4eFiLgrQR+cCV4nV7IG/Qs9vnluounvnaswoWIFPAlHKnx?=
 =?iso-8859-1?Q?KrIDw0kEVk7y3x3RgYVIwy52J8qPAumFi2imaNPz5Vmd0dM2i36h?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: f188dc3b-d892-4604-9a81-08df1dc961fd
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 01:31:28.0835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zidfLFPexQnp5OpVhJ6IMeRO5PXV/zr+aixmhxJNJKq5OuRpM3KitA3MlenuXvSvGdgEetqSqRiDX1R+Fi+rAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB6568

On Mon, Sep 28, 2026 at 04:04:43PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] ntb: use-after-free and DMA memory corruption in teardown due to bypassed wait loop
> --
> 
> commit 51bc5e4115a3fe5b0d9105d1dfb2a458cfc0b016
> Author: Koichiro Den <den@valinux.co.jp>
> NTB: ntb_transport: Remove clients before freeing transport resources
> 
> This commit fixes a tear-down order issue where transport resources are
> freed before unregistering clients. It modifies ntb_transport_free to
> disable transport work and call ntb_bus_remove earlier. It also reorders
> the transport link cleanup after queue freeing to prevent setup during
> removal.
> 
> > diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> > index af7f240479f4e..eef3a214d91a0 100644
> > --- a/drivers/ntb/ntb_transport.c
> > +++ b/drivers/ntb/ntb_transport.c
> [ ... ]
> > @@ -1497,11 +1499,10 @@ static void ntb_transport_free(struct ntb_client *self, struct ntb_dev *ndev)
> >  			ntb_transport_free_queue(qp);
> >  	}
> >  
> > +	ntb_transport_link_cleanup(nt);
> 
> [Severity: High]
> Does this reordering inadvertently skip the DMA synchronization wait loop?
> 
> When ntb_transport_free_queue is called in the loop above, it frees the
> queues and marks them as free by updating the bitmap:
> 
> void ntb_transport_free_queue(struct ntb_transport_qp *qp)
> {
>         ...
>         qp->transport->qp_bitmap_free |= qp_bit;
> }
> 
> Then, when ntb_transport_link_cleanup is called immediately after, it
> evaluates the allocated queues using the updated bitmap:
> 
> static void ntb_transport_link_cleanup(struct ntb_transport_ctx *nt)
> {
>         ...
>         qp_bitmap_alloc = nt->qp_bitmap & ~nt->qp_bitmap_free;
>         
>         for (i = 0; i < nt->qp_count; i++)
>                 if (qp_bitmap_alloc & BIT_ULL(i)) {
>                         qp = &nt->qp_vec[i];
>                         ntb_qp_link_cleanup(qp);
>                         ...
> }
> 
> Because the queues were just marked as free by ntb_transport_free_queue,
> qp_bitmap_alloc evaluates to zero. This completely bypasses the loop that
> calls ntb_qp_link_cleanup.
> 
> Bypassing ntb_qp_link_cleanup skips the critical DMA wait loop:
> 
> while (!ntb_transport_rx_idle(qp))
>         fsleep(1000);
> 
> Without this synchronization, entries in rx_post_q are freed in
> ntb_transport_free_queue while the hardware might still be actively
> accessing them via DMA. Could this lead to a use-after-free or memory
> corruption when ntb_rx_copy_callback later asynchronously executes and
> operates on the freed queue entries?

Yes, this bypasses the RX wait the earlier patch introduces, but DMA teardown
still runs in ntb_transport_free_queue(). The dmaengine driver limitations were
discussed in v2:
https://lore.kernel.org/r/vuoc76ik5ethjsq25gu3aku5o3yvdsm4ko6dnp4n3biheiqdy2@pxxgq24tk2cy/

Best regards,
Koichiro

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260928152550.3354675-1-den@valinux.co.jp?part=15
