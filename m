Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020094.outbound.protection.outlook.com [52.101.229.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6266B36402D
	for <ntb@lists.linux.dev>; Wed, 12 Aug 2026 02:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786500946; cv=fail; b=kODHBxBW1jN5N+Nbo5ce6s1axaLsVARrWRy7bfvglsjvKXG+0BfltUmUaLEyWyP6JOVLw5GQRs/3qADDFrfOYMWhO3EZ77RaDjcXxLfPY+FLuva9YVtnaKXLPPSPebwlm/ABSuwCRf1eJl2/2v7Lc58DnALcAuOTU3Ck26AGPIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786500946; c=relaxed/simple;
	bh=YX8ZemRvOKOk98cDs9+1z9Y+Q7dwyFmfPfA7lsbpBrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MXKYRv2XbnLhXhUKekkVi+7BzMvGlruiiLSQp1IwAt4khuUiJIw08bCp/+kqsvsIs97Q4cH1fnUo9GE13iUIU4h8rjPDkQhc45042GWf//ecWS4g3446eTwvYJ+zcwdj+7EGA+sBO9ve+MTIusrB1PU/54BHUONIDzhXZM6e8zc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=CJ3cOw1X; arc=fail smtp.client-ip=52.101.229.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="CJ3cOw1X"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r9bO9MJaTB7LLNxSREPTu5E8cTbMK/9oqNqsVdK/2MvQBq1LvzWEN+acYd4DS29vby2MH+IwrQmsriRw+CTzgOGGaxJPgLxeaQ7j8GqcZ2ny2ULoJKdd3Uc9QTYp21fZ9Hl3521tiVICYVObqEpdXLsjIskTy7uUby+Xhn3OWkM1JpBq5iCDrJkRKyEzACrBygBwQjMK+Tpa5QMlGKwnFT8Pk1IMwHI4s4ZktJYXbkqP6Jva1afLYBYTlMrJjPfEdWfOGId5M0XQqVZp9YIqpgq/PuSM7rnMC/040zcDEi78hGNMZtLFUGLAKeVmSpqdIYPmVK0BBzy3tnzDpmj6+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DP7BOjRY4bkqOHWYo5bBgauGrOwANNYB996XO/wemoc=;
 b=W+v2pC4EeWfsA8DjSnYsFTkIBute31zB+H//ntByF1LM1Di897REDjV71RvsHybMw27fI9zkdIybNTwoMyO7HoDPBBILU5frisLyJlk+GXs3SjZ5pGI0pfzzVpAE91kkip89Jwv8WRcIU+vCZhBx/vAA4nkIelja1xDO8xOepgDXASExRYZ6Lg+5nTPzUYtMSNELFOtUeT1+sxHndekKgcy4W9qCinQfqlIrngZ5KoqOA3sHTjhfZUjtqy2D4kgEAtURVwsH/JQdc2GFENm8h0n7Bp9n8CJVs8NxlGjcWOvLNH2FVD9c7HNMMHPVgIWZRz/KNwR9Ey+zQ4oLLvwwUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DP7BOjRY4bkqOHWYo5bBgauGrOwANNYB996XO/wemoc=;
 b=CJ3cOw1X/zL/0H32hKdrJzz/TN5jXNiEuT0fKhZ2Oj083SZ9SW4e7gfaP421jOwhWQZs2j/s8P4QTrJvW0gJEjSA7tAV/CpVEDS06gevlAD0XvOoZ4eBkJzBn0fKEy/SAwcEXX3HTo4bnHw+h5RY49Fg0jUngijLqOTMPF7Md0E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB7317.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:44e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 02:15:39 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0292.024; Wed, 12 Aug 2026
 02:15:39 +0000
Date: Wed, 12 Aug 2026 11:15:37 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Frank Li <Frank.Li@kernel.org>, Allen Hubbe <allenbh@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Niklas Cassel <cassel@kernel.org>, 
	Nicholas Bellinger <nab@linux-iscsi.org>, ntb@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/16] NTB: ntb_transport: Abort link setup on QP MW
 allocation failure
Message-ID: <kdcjmsy7gqy2iolfom3tzigocecmkquzepbhusgprvzbfnfg6h@acqxas2tvpxb>
References: <20260810165136.2292436-1-den@valinux.co.jp>
 <20260810165136.2292436-2-den@valinux.co.jp>
 <anobdz2EDP1UiLbA@SMW015318>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anobdz2EDP1UiLbA@SMW015318>
X-ClientProxiedBy: TYCP286CA0156.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::20) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB7317:EE_
X-MS-Office365-Filtering-Correlation-Id: f8e9c311-36c3-453c-6367-08def8179a6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|376014|7416014|1800799024|366016|10067099003|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	fiwbqokbfoj60UBmuCIjdh94+W95E8vDqwiK4UANyAIV987HbtF+fGFS/qWDTEm4x4kXXABRXlwMf0SezX86iUDocCZVK79+pxj8KRWmhz+M1u0NzYq1dJ5luuGkvwhx82RXA1sK7D5GNs7Mai90ZVDNJT0idRNoJUUSgfJkMk46nuQ6DFFeBYVHPMj2dpzylRci+/T/5j6G7GqyBvGnWgaQFAQRePf7KTYGk9CqRtcXZFh3S+IKDTmcccU9d3bMGa+/VX36y8A2Hhy53887XPsMHZ6eyLfbTnwPRD2T5xCyHLxI9HFwVNBciwKQNJD+iX9icPAkxNVgCcX10+V2PX3vi8s0uo/aCXvKAqMwkwHGds2/+Kydc31mGSxnkz8C5aOydxNP4QMESOxc3CQF2flizKFLJerutuZq+salVR2EcjlNAnhAXGC9EP3A/Wjr8v+C7HHwP4pBlMoQ7rMyfCOHjpSIp253si8AI4LPc1EUqbjWrqxNigLTNGISCv0wtmNCOe4DW4Aefmzg4L89iGsvv+Yzxb/xXK1VFvH3SySTD0Xyx14cFqqKoNgGUh1Ssa6ULsiwuApgsiPKsVGHrvaqQik9dZL6tC4Yc2ygE5UCmu0LN/6kOoznwevCHEwnrbwaFsGb7B3clxPfsmNPUul5/JRdSFIVwtVjYmaTyg0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(376014)(7416014)(1800799024)(366016)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?etKWNg4RPZS3ctZMiVPxkRgaHe9xywId9i5TZNpHewIvZhs2Jg50+QazjSCG?=
 =?us-ascii?Q?QHQEt5LBJRNosYLlILED/vOtKdXcCJHxxHsmfIUqjun41fyJGZYJsGdh4PSk?=
 =?us-ascii?Q?9PGOIO43fODKssj49kR6yXAXHKH6PxZlDTofjo8Ta7wgGv3QtyYE2fLplVc6?=
 =?us-ascii?Q?NHIG6CQwID0llzxY6MRE0+z7Go6/zRezAQ3bhwXt1fcHpr24goyFtYjydhnK?=
 =?us-ascii?Q?uqlhf0KuO3RtY4CMLVMna6+j+bdbAc/o9BgbP2bAntkseN2Yr47RCRQXxtH1?=
 =?us-ascii?Q?fD4MIphUJpPzQuHiLBJ6JhbPMehsF+Xb2sJnhhu8y7ok8sg5DJqLsf+UEJ5a?=
 =?us-ascii?Q?g006zxO2Q4pS6OKlgLAbcOh8mTqe0FS1kJfBCMupAkfGYg3RCHfdaJMvZ799?=
 =?us-ascii?Q?K8GeW4bVk3OhIsD7Br3aO1ogmDk/ait4daPl5j5TJFmnVidxJrH46Unse9PE?=
 =?us-ascii?Q?r4US9rfqmmrfEwp+h2xpKCgNq8igTOdCduiR25P4Q9GLdyK8E4EV9wX2mrw9?=
 =?us-ascii?Q?QSifg6ZLYG4Gx1DIR2ZwZ7C487EWFW4OPlDPcyHxEyDJKFGo4jxbj9mVD4C2?=
 =?us-ascii?Q?vpaSEvUH8kbHhAiTFhOIJaaMACOM3k/Xv2JeaMKicI7dHgMiSlQ7GOzPYbZk?=
 =?us-ascii?Q?/IU9gRXaGiwW939Lu7wcxntFkXR66kpIB82QcNSf8VSjB6mkTVQcAN71R5nG?=
 =?us-ascii?Q?d1/WK/iWvVT2yiU3BdZBJHvCOFPIsJWgDNmeQ5YC+ctLjG63NnWlhD0RUPtg?=
 =?us-ascii?Q?PRWfUgDFV98QKh6/AloL4BYMvqftBT7FkuTlVgGkknUiBjqWzyhm7SMp5ul1?=
 =?us-ascii?Q?eFV/hEKjmFVS4tagxR4G2NgG/iPUF0ptF+eQd2iRr41UWHcgE3/L48x8Do0U?=
 =?us-ascii?Q?6vEIdgM8ngrRu7hM2sLxGqwZ5hm+7iJ5fNz1gY/QuBWl8/+b+pqTAjiMUETa?=
 =?us-ascii?Q?xPi4Un3PVKeWTZkiYXNCG6N2aBMK07cC3lRpKWMp1w1uWLthnxN5sgbfO4He?=
 =?us-ascii?Q?v7tjWbb4ToBlgP4MuL/t+XmBR6iPaW6z74qicfwQmi394tqFLF/jEQAYEmaJ?=
 =?us-ascii?Q?b3UkFG267v0NlysECVZ7uVhVWDejFpNfgji5ngcH75aFtkojZWb0wR+BXTgr?=
 =?us-ascii?Q?BnSqO9EmTKE1piPck7Rq2Dah3/5wDgP7CoyCZD01FeohRcrP3UNwPLVNeuqI?=
 =?us-ascii?Q?yW5iyCQg8fdXGEm5YzUufGR6VWYhaYFJzPUNUHz1ASe1S832WwoEPK1Z0sND?=
 =?us-ascii?Q?XB4Uk6E0wHJgibJAOucBJL+T//F7P8eDUDZg0wuQPuDtD8UrIBhKyfSqk62A?=
 =?us-ascii?Q?DHORrG0OnZix+ZZEcQNX+jdF0dG+ZeKoAE7PiQkueXeUlw3QrqQt5wV3A1h0?=
 =?us-ascii?Q?ZbBopIcuU02ZcskXpRJLg6lQuzthknj6tV6gkc22Ad29ruAD3R4JaU8hAAh0?=
 =?us-ascii?Q?Imp0HnePJGxDEettSiJCkosWmcaUH9G/goVQgRPXgwWrncctIb5d4DKRsxB1?=
 =?us-ascii?Q?dspq3AQlWwDp77gZAKDAD3zXN5H6w9vSIrl04yURzty5IVfFCQ2nJyWlOBzk?=
 =?us-ascii?Q?YUC1goMAZnwjj0fZ5w+fIeyJiZeGXlIXXzwikCjY2BZtzekSOPNlAEA94zAy?=
 =?us-ascii?Q?efrP+Hhg/svX2YKjLlPIg2LKjxtE8IDbTqShBE4f9BslsyNck0qF7miXDScG?=
 =?us-ascii?Q?NoI7kafQ0Q0/Ez508zew6Y6U1v21dxMmps1QsW1SETh5Ug3TsnlvAlSZS+do?=
 =?us-ascii?Q?G7/wt8iVL8lO/tW8AwQHNFTeNZhWnsHoe5yBjhPGEUlTEGqV6NxU?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: f8e9c311-36c3-453c-6367-08def8179a6d
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 02:15:39.3600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tyia2Ot8SFJ+88khNUBvyECeHCb54yuaw7ZevyyfTfpMKcASp4OYAhv9mFT5fHHSMo9hSI+7gHMLvBq02ZnjvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB7317

On Mon, Aug 10, 2026 at 01:41:59PM -0500, Frank Li wrote:
> On Tue, Aug 11, 2026 at 01:51:20AM +0900, Koichiro Den wrote:
> > ntb_transport_setup_qp_mw() can fail while growing a QP's RX entry pool,
> > but the link worker ignores that error. The worker can then publish a QP
> > whose memory-window state is only partly initialized, and later work can
> > use stale or incomplete pointers.
> >
> > Set up every QP memory window before publishing the transport link. On
> > failure, clear the QP pointers before releasing its MW backing and leave
> > the link down.
> >
> > Fixes: a754a8fcaf38 ("NTB: allocate number transport entries depending on size of ring size")
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> >  drivers/ntb/ntb_transport.c | 20 ++++++++++++++++----
> >  1 file changed, 16 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> > index f59f926d4bfa..3efc50955253 100644
> > --- a/drivers/ntb/ntb_transport.c
> > +++ b/drivers/ntb/ntb_transport.c
> > @@ -1084,14 +1084,19 @@ static void ntb_transport_link_work(struct work_struct *work)
> >  			goto out1;
> >  	}
> >
> > -	nt->link_is_up = true;
> > +	nt->link_is_up = false;
> > +	for (i = 0; i < nt->qp_count; i++) {
> > +		rc = ntb_transport_setup_qp_mw(nt, i);
> > +		if (rc)
> > +			goto out1;
> > +		ntb_transport_setup_qp_peer_msi(nt, i);
> > +	}
> >
> > +	/* Publish the link only after every QP has been set up. */
> > +	nt->link_is_up = true;
> 
> Not sure if need WRITE_ONCE() or other memory barrier to make sure
> ntb_transport_setup_qp_mw() and ntb_transport_setup_qp_peer_msi() actually
> complete before set this flag.

In that sense, I think we need a compiler barrier + WRITE_ONCE to avoid
use_msi=true <-> nt->link_is_up=true reordering in case dev_info becomes no-op.

But if we want this nt->link_is_up read/write more robust, here I would choose
smp_store_release(&nt->link_is_up, true), paired with smp_load_acquire() in
ntb_transport_link_up(), because another CPU can possibly observe
link_is_up=true there and queue the work.

I'm not sure this compiler or memory barrier issue should be folded into this
small patch, but if preferred, I'll do so.

Thanks for the review,
Koichiro

> 
> Frank
> 
> >  	for (i = 0; i < nt->qp_count; i++) {
> >  		struct ntb_transport_qp *qp = &nt->qp_vec[i];
> >
> > -		ntb_transport_setup_qp_mw(nt, i);
> > -		ntb_transport_setup_qp_peer_msi(nt, i);
> > -
> >  		if (qp->client_ready)
> >  			schedule_delayed_work(&qp->link_work, 0);
> >  	}
> > @@ -1099,6 +1104,13 @@ static void ntb_transport_link_work(struct work_struct *work)
> >  	return;
> >
> >  out1:
> > +	for (i = 0; i < nt->qp_count; i++) {
> > +		struct ntb_transport_qp *qp = &nt->qp_vec[i];
> > +
> > +		qp->rx_buff = NULL;
> > +		qp->remote_rx_info = NULL;
> > +	}
> > +
> >  	for (i = 0; i < nt->mw_count; i++)
> >  		ntb_free_mw(nt, i);
> >
> > --
> > 2.51.0
> >
