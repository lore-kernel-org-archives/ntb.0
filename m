Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020102.outbound.protection.outlook.com [52.101.228.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944D3324B32;
	Wed,  9 Sep 2026 04:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788928959; cv=fail; b=dqKCdydmgGq5zphIHg9yCQVGGzuJU/gDexzMSt0EJ70KAGg8/IelaIu2I6tkeWdrFWs9u0ptKaS6ksolN+AB0dkzQO3RtFjS+/l0KYlpT6GrR/aH8lJRWaqHH8xcm9+FWQoTlCSv2l1LqFW5ewVw6kgdX/Bbekt4dE8QkWJcXGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788928959; c=relaxed/simple;
	bh=8FM54roZANxQU5muWjd+FotMA5KVJ0PSd/42dsSong4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VAgxj8meQ+gujR3dVSYi1zbpRdcMOm0v932xsP8TyK/QU67CyOiesfVtTloAjVLID4VxFIaZfCgM8MMRThy6b5LAoqZWD862WtN7D6sl8itZq0ZXK/5wcrK0DbLAxrYgiRUNqN/0wglC1pl0AuPnXcJZnkztzEGHcPO5zlyfotc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=fail (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=nXLZi243 reason="signature verification failed"; arc=fail smtp.client-ip=52.101.228.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="nXLZi243"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B5mr4Ide/QDTFnj5reTgen6LhFcUz3yvcdcodtkVFCvbP59Nl5rR/SXlgzfpKVlWkOjb/eGC02LtY9EvntD+KJ4if+VFdejyXWWFLE1QHSmQoccXMNNueIGRQihhFrPgiqu3vp5U7aTejaTk40BKjjBATJEizdoWS0ORC5wgSvwL7VzP62S6XprVRoVIaAjmEABVgJqpM74ExXn99YY/inZO1X2qxyRyeO/Y9NglXSnFdsotSChmcHyc8NRV3RNCMzcrNV/wifkpcbXi9BiwLtis535/5fPqj4LnQ42xK6Nd/NKsTT5w+zLPa2eaTdUzF3V/VWIX3rB9G5YAyONWmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xy3MeZw4jxNujW13c+M/5hK65tNm+G88y/wSebjYBVY=;
 b=o4SjRmP0AEScp8gP5KLP/d/UFt6NhFEH2VJdqsFhQ0zNNmekwAltzzbx8EQE5hJX4jVxHP4PbN7nd7d+pOYnhlKP9LqWlTKIJ95iUXAa2agZFK2AJNNUcEwQqcKlqGA8XkUWT9ouvvHdVaz8rOgqlP9mU8Z+3oP1V4FLmsqp4JFRZCAm7JhQ/0fwpoax1oQTyf+jSE6pn2UGr6OHk7bJ/mqig3svoaChb8K3+c4dgTszSvMjcvXvvQ9cUPjqbdyaqbM2UxG4DyR8egvdhlxeMe+9jH+at5TJP17YAq5kc3Zk7A29rlXqJz0ws3m7WNt17ibEIJ08FCPyw68hdgaqyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xy3MeZw4jxNujW13c+M/5hK65tNm+G88y/wSebjYBVY=;
 b=nXLZi2434wfRe2e5hb4CaCmTROpIhGiZw7ydS8t4K3eFfQbVTTP2dzwhYOqbKDueeukAeWM0j3H4P5IJQcOnnBXHUMjdeDloREgU7lkq2+qVvyO2bY0zrBOQGOuzWt6t/tpZ15UGR9bZvHDegyZX6zLjCHgODqRli5c4/a1io0U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OSCP286MB5274.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:34f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 04:42:31 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 04:42:31 +0000
Date: Wed, 9 Sep 2026 13:42:29 +0900
From: Koichiro Den <den@valinux.co.jp>
To: sashiko-reviews@lists.linux.dev
Cc: ntb@lists.linux.dev
Subject: Re: [PATCH 06/11] NTB: ntb_transport: Publish link state after QP
 setup
Message-ID: <776xeoitf37k33pveq3lswmtfldsrrx2sef3o4pzvw6d7pnywl@s2xfijenfkjr>
References: <20260907142429.951930-1-den@valinux.co.jp>
 <20260907142429.951930-7-den@valinux.co.jp>
 <20260907144701.702E41F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260907144701.702E41F00A3A@smtp.kernel.org>
X-ClientProxiedBy: TY6P286CA0013.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b8::14) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSCP286MB5274:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cd4028f-9c98-4908-6b57-08df0e2cc260
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|10070799003|6133799003|22082099003|18002099003|4143699003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	H4+DTTKg0s+BotBlAcqzdKlUtdv5Co5hL4CssPm+HhCcaxPWGlnBZbEuYhlywQZwFr63vX9UyOfsjRfbNXyxZHnIrMJXbtwm6p+ATCC5JawHteIDI81/a9hSfLTCTGYqe/prf59bkZJvLawgORIZjc3Ps/bK+SMW2O9Fk/8FTLLoFWMTfFZtUxzRlgKZHqq8KJm7LHhMKfb01IDPskzxLGZc1vByHbvI65yYukgTUfdfHCXpD4HiTxwEWTVxbQyQVhquti+CaxUv5boSglmkAiDnKcOgLUQkqcoFNPCbwvEWEEoLNIWWXsYiqR0SXvMMtPdKURPKC4gaqfsSEmrCwxn+/lJw2E8zRfQngPLUJ3ECcFu0X/MY0gwbEkNgAXuTMk2s7hsT3XBp0oK1gelmCRziG9+YPQfM07AfkowUFNew4pbozFyt47Bx+8DRx2xlv+cMAhJwombfiavqM4dEjCB/ST5F7LlcXEY902Chw+J1Yq7i0bAJADEJLKXprgYn/DY1Q7lR6226oggkq5l+UC6aTr7OGUskAXJbDVwFdhTxycgQgWZi5OXFYj80bclLrjGEHgahiDJFV0fEcZA6iBjw5zjvQp/NM8ItecuqahQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10070799003)(6133799003)(22082099003)(18002099003)(4143699003)(56012099006)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?5RKLV1rUmazWFZFVvpJ8G/cBCJlzjExQ8Vg2HGZJsPhDWocpQovdniHizQ?=
 =?iso-8859-1?Q?pt5gJlJ3+KcLVUkrRIlG7rMIh9HhaN2neUXB/gWKpa9ytT+9a4Uvt9y1Yu?=
 =?iso-8859-1?Q?t+Bzjyls4sdDkbYM6HxR0twyC5ynuXp0QP948UZOmccoCowClsexTdPz5D?=
 =?iso-8859-1?Q?pYy8gFgFwA8tJ17q2EqM5lb28f1nItJYO28yCCHAGumjcR+kxsTMNbVcyT?=
 =?iso-8859-1?Q?z5gELSR55WcglY9hO76SKpke0lZRCyAhlmC4HW0XULuk9ZJ96bpiIS+i3m?=
 =?iso-8859-1?Q?KIPG18O32QMrOrDbYhvHz0qsDkkmbUUz3L1CfkLIMi1uHyj7keVCxekaiP?=
 =?iso-8859-1?Q?o/RXc5eLZNG6Sz8ZDq/xVdJVqQDdotEGTCWs/KR2c4P6IohP6usAUsmj0j?=
 =?iso-8859-1?Q?+Cnj0mX9GTsvNwFr4xcWRIuwv/q8io7/38lSiPKIB51m8HqeVXjjyf2rFp?=
 =?iso-8859-1?Q?d85MJmccQR+uopTO2yX9swbXM+S8/AQQ1fPlsCtc9XMJtGdz8bF565AyeZ?=
 =?iso-8859-1?Q?j5SalqgRtYXyebKVparr2GA1DxwRU+DSBurQyEscqH2ereGdEK3F4b01I6?=
 =?iso-8859-1?Q?2HW1CKNDf9JVKwqlidUWjjMbNHk8UCc2ybrv4OKDgcSq4atJf3i9MKP8JL?=
 =?iso-8859-1?Q?EdC0VOjJL078GSuZ4It7OGD9CaJbbZQaU9VGTF2CglrvwifeRCzmzL8Cn0?=
 =?iso-8859-1?Q?EFuhu27Y72y1vt16dh+HvNT3DPgM6iQqRUT8DN58VoUefUtpu23CmzE9La?=
 =?iso-8859-1?Q?KnqGmYJa6n5ckXMXUwiz5C+eP2fUrHWLuCKxyKTkNHZULPHiSaoug6Utbs?=
 =?iso-8859-1?Q?VLz3URPrv+rdmF6FndWllybaM+glZ5Igj7bTsVf/rJCCIr6eF4agwSSOfQ?=
 =?iso-8859-1?Q?iTZneVEcDn7yOl1E7DuguIVDBvFB5JbxyjcdHbDP9PkCmFQx9CTuM7SoVi?=
 =?iso-8859-1?Q?RhwQn/Fj8ccjg8Mz4yqQr9aTJR1OPgAfTTlbiCvsr5pWNu0Q8WBNoshwYH?=
 =?iso-8859-1?Q?VFsn2h+y5z8/03biy6zeuUBEX7j6DLgnwwI3RoJn0lwSCm74+rKqdwCUZL?=
 =?iso-8859-1?Q?1zdVBi7nJsw43AGVQT8XmJGmeQy50tHJfIzuhtD2E9mxgWa+724ei0YJie?=
 =?iso-8859-1?Q?UoTRpDwVJFXMu742T4B7SannWMJao6LuiJf+ZccX6LmGzIq4URvAA3Np+x?=
 =?iso-8859-1?Q?37e5Pg9f+700dXdzPx3SBJLz9/J0JBqONcvGiDNDIegvrS9g6R9eZTMbc7?=
 =?iso-8859-1?Q?J0IX1fXC3XwXxGzvKE3++RzA8b9jB7ts/oUa54b5OqwNSifL7jtepn+60+?=
 =?iso-8859-1?Q?dXH9InAmuteT4wOb/nhpS4yaZxfSzBPUk6/UpDu919bjZhhptbHTof9v1v?=
 =?iso-8859-1?Q?QnLbwD9ujKfWEjvXtmyEkXCjJrM0eslxt7iHmjAz/eb2Nk5KYYZV/H/nbb?=
 =?iso-8859-1?Q?/QKmoHeAM+l0yciROjt+8WPSrCq/Dbx5g4P8yyWHeW2276FXAywl+IDk+M?=
 =?iso-8859-1?Q?hUYOXKY/odllE1TSCm80AWxkxiaen5youqRFcHfOMI+oM8/AA+ErSZmYus?=
 =?iso-8859-1?Q?q7klqoYK5wBO9w/O5Cg87X3bfgl0s1N0AT8dpqu8+ePw+euFPxKSXgRyTq?=
 =?iso-8859-1?Q?oS6EBJa/7wyyejyUIzwA1q5QzlTt3dWj1KK20TcP4Pt9SzdUWy5wjdi0vU?=
 =?iso-8859-1?Q?ModHVXw7uwbgj31p5WbOjZ3bMzX9uwB269Q9yWAfXX3W3kbhJEkP19GLvb?=
 =?iso-8859-1?Q?bD1OdaT2wyv0VZ2sOOfUp9M3Hy+pEZ8wC/w/G+9CKEl10kRCNGUJpILwze?=
 =?iso-8859-1?Q?PE6kLyBkVG319cvg0pQeWfNT0zctAVcT6jxpSOTvsNPTNsg3sysI?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cd4028f-9c98-4908-6b57-08df0e2cc260
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 04:42:31.3430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 03B83ZKIG+pk/T0HjFf+4Eg3JEWU4Epoxl+3eRYnWN0ifnlvf6aC0Fs6FoyBMT/Y3KAyvXr9p1T+E2Y3URLbSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB5274

On Mon, Sep 07, 2026 at 02:47:00PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> New issues:
> - [High] Store-Load memory ordering race between `nt->link_is_up` and `qp->client_ready` allows both threads to miss link scheduling, potentially deadlocking link establishment.
> 
> Pre-existing issues:
> - [High] Workqueue teardown race leading to Use-After-Free during `ntb_transport_free()`.
> - [High] Missing minimum size validation for memory windows causes an integer underflow when calculating tx_size and rx_size, leading to massive out-of-bounds MMIO writes and kernel heap memory corruption.
> --
> 
> commit 07de6dd89d3b67c6e867804f1d8d493ce3b736ff
> Author: Koichiro Den <den@valinux.co.jp>
> 
> NTB: ntb_transport: Publish link state after QP setup
> 
> This commit delays publishing the transport link state until all QPs' MW and
> peer MSI states are set up. It uses a release store for link state publication
> and acquire loads before queuing QP link work to avoid premature execution.
> 
> Link: https://lore.kernel.org/r/anyKbq3mpLG4y7rb@SMW015318
> 
> > diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> > index c8e7fc774b4fd..411017873a83b 100644
> > --- a/drivers/ntb/ntb_transport.c
> > +++ b/drivers/ntb/ntb_transport.c
> 
> [ ... ]
> 
> > @@ -1102,16 +1109,19 @@ static void ntb_transport_link_work(struct work_struct *work)
> >  			goto out1;
> >  	}
> >  
> >  	for (i = 0; i < nt->qp_count; i++) {
> >  		ntb_transport_setup_qp_mw(nt, i);
> >  		ntb_transport_setup_qp_peer_msi(nt, i);
> > +	}
> > +
> > +	/* Publish the link only after every QP has been set up. */
> > +	smp_store_release(&nt->link_is_up, true);
> > +
> > +	for (i = 0; i < nt->qp_count; i++) {
> > +		struct ntb_transport_qp *qp = &nt->qp_vec[i];
> >  
> >  		if (qp->client_ready)
> > -			schedule_delayed_work(&qp->link_work, 0);
> > +			ntb_transport_schedule_qp_link(qp, 0);
> 
> [Severity: High]
> Does this code have a Store-Load memory ordering race that could lead to a
> deadlock?
> 
> In this thread, ntb_transport_link_work() performs a release store to
> nt->link_is_up, followed by a plain load of qp->client_ready.
> 
> Meanwhile, ntb_transport_link_up() performs a plain store to qp->client_ready,
> followed by an acquire load of nt->link_is_up via
> ntb_transport_schedule_qp_link():
> 
> drivers/ntb/ntb_transport.c:ntb_transport_link_up() {
>     ...
>     qp->client_ready = true;
>     ntb_transport_schedule_qp_link(qp, 0);
>     ...
> }
> 
> Since neither smp_store_release() nor smp_load_acquire() provides a full
> memory barrier (Store-Load ordering), is it possible for both threads to delay
> their stores in the CPU store buffer? If this happens, both threads could read
> false and miss the wakeup, leaving the link permanently inactive.

This store-buffering pattern does seem possible (with ntb_netdev), although the
race window is very narrow. A small patch can make this robust, so let me add
one patch in v2.

Best regards,
Koichiro

> 
> [ ... ]
> 
> [Severity: High]
> This is a pre-existing issue, but is there a use-after-free race during
> workqueue teardown?
> 
> Looking at ntb_transport_free(), the delayed work is canceled before the
> hardware events are neutralized:
> 
> drivers/ntb/ntb_transport.c:ntb_transport_free() {
>     ...
>     ntb_transport_link_cleanup(nt);
>     cancel_work_sync(&nt->link_cleanup);
>     cancel_delayed_work_sync(&nt->link_work);
> 
>     qp_bitmap_alloc = nt->qp_bitmap & ~nt->qp_bitmap_free;
> 
>     /* verify that all the qp's are freed */
>     for (i = 0; i < nt->qp_count; i++) {
>         qp = &nt->qp_vec[i];
>         if (qp_bitmap_alloc & BIT_ULL(i))
>             ntb_transport_free_queue(qp);
>     }
> 
>     ntb_link_disable(ndev);
>     ntb_clear_ctx(ndev);
>     ...
> }
> 
> If a hardware link event fires between cancel_delayed_work_sync() and
> ntb_clear_ctx(), the interrupt handler could requeue the work item. After
> ntb_transport_free() finishes freeing the context, couldn't the requeued work
> execute and dereference the freed memory?
> 
> [Severity: High]
> This is a pre-existing issue, but does this code lack minimum size validation
> for memory windows, leading to a potential integer underflow?
> 
> In ntb_transport_init_queue(), the tx_size calculation unconditionally subtracts
> the size of the struct:
> 
> drivers/ntb/ntb_transport.c:ntb_transport_init_queue() {
>     ...
>     tx_size -= sizeof(struct ntb_rx_info);
>     ...
> }
> 
> Similarly, in ntb_transport_setup_qp_mw():
> 
> drivers/ntb/ntb_transport.c:ntb_transport_setup_qp_mw() {
>     ...
>     rx_size -= sizeof(struct ntb_rx_info);
>     ...
> }
> 
> If tx_size or rx_size is less than 4 bytes, this will underflow. For tx_size,
> setting the max_mw_size module parameter to a small value could trigger an
> underflow. For rx_size, if a remote peer advertises a window size that
> truncates to 0, could it underflow and lead to out-of-bounds MMIO writes
> or memory corruption?
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260907142429.951930-1-den@valinux.co.jp?part=6
