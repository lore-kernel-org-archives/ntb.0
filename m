Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020091.outbound.protection.outlook.com [52.101.229.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D1E485939
	for <ntb@lists.linux.dev>; Fri, 11 Sep 2026 18:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789149867; cv=fail; b=Cx9/38JdkLJECZPPvqay5zXbMIT2lJg1HyEGqOHeXWRVgFtEUcBvajq3ylAUiUGC8JWM76/m+FR83Sl/rvVkqWAfvo6lgVLo9nPlq1UJMKqJhR/pDSzY4IWDe/YxDg788ePeR+g+XcYA/PeCZKn9uF3oo+DbZjQf4TtnP9C9cE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789149867; c=relaxed/simple;
	bh=trwQaA8a9vvRq50eJPbDv4Sv1NBr+YAbL23cWcIn+rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=h4IWNQewfEf7irmiIpW6kueAbWy4L6nFRJupTjdI9DqMEyS675GKPby31GmPLYtMMa1N8fjpcWBo/L/r2bs3UiI4V1HpqfcE+cJWujODeirheW+788DOcXTFzw7AePgFZX8Qeq45e1xzUKOKdBc9IiOJhhMkMSJhNiP5Dh+uYs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=AIMG67C+; arc=fail smtp.client-ip=52.101.229.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="AIMG67C+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LmgrRvuh9Ul3s+uoOIqij0+Ip06+sFDoLmuo20ceuPZHUGS+4brGhZsz7qmsgs/vICvxLBuJXPEzoKIDR7hgmaAfhOdupOqoJJgGoKFJp89kAH9az2xy8j/OHyTViDAqno/IYhmrTgA4DJvav1WNw2MsP85dDTDU8IN9v+kiQoHfvzWF1WoJ/tzR6p+bD7kgb+McCXLtQlJ7w3pZJAsqorfGYA0PmriD/gNylJXJsU4tjzXPmWYKA55H/8M3IJuvsxN5Rv10MKCOr/4mRFTQDFzKmXygRM6bWEdRumiz8dCsAGU5xFgHDOkrJJaYDAsB6cn2cIapLXhnsqvsnTdOyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fSpjubdXbCP+pJBWXxOzwhCGPRLgEk8mIK/N4/6iQlc=;
 b=SAzrL3t+Cu8KSKyK444BppSwMLNV9qWXqkVfWti4PHNv3Oe/AEaX4abwaBKWT1P+qsiVumtGCog7EHyPfhKfdUlOOQH17aaXSSapRWVdp/SBsVXUOQS3hS/wRvMJOtB9iysArvf8ptrXUFM0dArvUG9DssEPL0k4OPt80ov5gfwLNK9kywFV/3+HjkbWD6IfRkIoK222X9c7WH7bhBf+li0a0tde5LkEWgaIp/SdYtmeMUnqfXSAvP9KsgUpR1wAO54W0cxfN53mwNefw6u8BeeKrWvp3+btV/1/pbRR0ZCte2YmfF1WMeM7zmX/EhuUUWc54gOpB/vtP9u94y1skQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fSpjubdXbCP+pJBWXxOzwhCGPRLgEk8mIK/N4/6iQlc=;
 b=AIMG67C+ZUjz4p32QNGI0A0lzYjbYuNTtag+TXcB7wXNnC54KYEB+Hsf71V1p98ABu62PxFc4+z5HiCGxKTw/WwPBCs/Vw8VEqKdAsJXnh6e1AIv3vvcccsz4Cr1mQealnN5QjVWZqClBQR1fha6NoTP1zSwXk7rPAI2Hzk7S7E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY3P286MB2546.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:228::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Fri, 11 Sep
 2026 18:04:21 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 18:04:21 +0000
Date: Sat, 12 Sep 2026 03:04:19 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, Frank Li <Frank.Li@kernel.org>, 
	Logan Gunthorpe <logang@deltatee.com>, fuyuanli <fuyuanli0722@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nicholas Bellinger <nab@linux-iscsi.org>, 
	Joey Zhang <joey.zhang@microchip.com>, ntb@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/14] NTB: ntb_transport: Avoid losing QP link-up
 requests
Message-ID: <ciucjqvb7qbendlxqdya2wigyivgj4bvqbxtc4cidulr4knq6j@xbwucjdsiayy>
References: <20260910040836.3792333-1-den@valinux.co.jp>
 <20260910040836.3792333-6-den@valinux.co.jp>
 <aqQyEbLbABhhvFTO@SMW015318>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqQyEbLbABhhvFTO@SMW015318>
X-ClientProxiedBy: TY6P301CA0039.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3ba::18) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY3P286MB2546:EE_
X-MS-Office365-Filtering-Correlation-Id: 70821df1-cbc8-4a72-825e-08df102f1ac7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|10070799003|4143699003|6133799003|10067099003|56012099006|18002099003|22082099003|27256017;
X-Microsoft-Antispam-Message-Info:
	X8x31o0HMliaagjvMlsy4uCwsBY/CzJNuDtkksZNbgilPhMNqjIS1lOdKggAcsP13E1yRNccj86uO9lAVffGbiFdkd2U8/cIzrhnEaM4QZJ6U6YqwEmPKL3xvi28QFxF+PDAeSORBGZ1iNSIJgK0Q3rsN012KK2qtg3h0Emsi02UdEYMaE+gFvVdr5Xl3rgtr0rAKPPPSbMu2ThUX21K4rV1CrlsH5jCMYA/BX4zbu+9/+osOIzeD0lSxkrXr6kehE21G4i0+1Fk6aPJvx4UoEFY0uysHx8shtuyLc0R20TrgReUtCOSO4L6oizOUtt2BCN2xAOyZrBpDCIi43O/6+5uGzKuWKcLLun+xS4SIXGp72/RXyHBGPkcrZZwouSMqwm4hD9xLy3oSMNvFo4uOUMoUE00rpcjxtEyk2tU6Sfy6uBTchrnF+GVgtZOYLn0UZOnOczyLqH2f9KyhLGkUx2WgB/Xcd+0YUFuTyZAqcedQAU/d40CaZwXE+ayvwg2OflK/zzKw0+DDM/ceKezFsufIowXAgF39hD5F1LjFwk3Wyt1OGrEbY590tqNN7UeMTa9YTd7VMIEBPGwWbUhLUYt9kYEl0LWzhx4BFd+aNYM5d9/IX889HMJ4vZ6gaUKhZMjTt2mKjybM6+rUgPtT1iHYOgBWYIfATzQmwpVF4M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(10070799003)(4143699003)(6133799003)(10067099003)(56012099006)(18002099003)(22082099003)(27256017);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rx2gu+3OA3xAUDb/BQwGN9O3wmx3D1LPvrxvdfwv5p5u/c/d2vGQsh+JQsJm?=
 =?us-ascii?Q?h7EDWjXnk4A4saXTLapRnLvGrT967Su+1zzTsVeRkOVwFGMUAE4ex/7hRR0X?=
 =?us-ascii?Q?lXuy9vzCkf8G2PDS9eOC99hCu/K1WuszN2IfnPzd1mSJzCF8eSra//tVzteR?=
 =?us-ascii?Q?j+NW0NN3k9XEs8NdIcri6WzDTfATURPdevgqk5ROE4mpbUf0l3LbzfJBz3Te?=
 =?us-ascii?Q?AE3NA5oBrhUmlPP1ZnNZT9W6C5UqQzRQV/Vreha1A75L3fTen2gwVaOZqM+P?=
 =?us-ascii?Q?7Ux60H9fQCO/DfvAyzXlGTgZW9j0BFbuJfMdn6g3XAF1iCVL70XnCa+abPBQ?=
 =?us-ascii?Q?nHWP4uJBR38/1zCbSv/xeJAjUljzv/lAcsb3FnhRSYIRb/tDpD7Jl5hIRRQB?=
 =?us-ascii?Q?/W+3mG+QAJVeS34KK/XAbmWbffwYVXDv3s15yDp0Yb5NMj0dPkbFpF5vbFRg?=
 =?us-ascii?Q?gG1AKxSbIo7W/xvTTBf6iETs3gaYEv5VgajYr2y798ZnCd882n1mjEMAsCYG?=
 =?us-ascii?Q?hJyVPh7nuUdbEIv1BXw/mnXh0dcFsSCtX2ePCmEKaXDOE2+ZP8/EA+6OaRX6?=
 =?us-ascii?Q?QSONvUAlvjqAlTVLjVwm4Y8X6SuqeHnrEpNrv9Ged9Z0j+z1XRnQJbMwVwgv?=
 =?us-ascii?Q?WMbNU4CqNBM8iWAWgPGX2wUpIBX4h5ORT4CKdSu4MTNJYuGPo4jjLhn0acp0?=
 =?us-ascii?Q?7+Dbfb7Ty/Kvb8n8f5nbvC2VHQxUOtDBRqWn2cSH/GluWGj4FELey7EbVzO3?=
 =?us-ascii?Q?RSeed7ELfEAB/XXm+qRcH87DVzi+f4HXXeqTu+kFiRQtwFyyaYsKpXIWSzgA?=
 =?us-ascii?Q?XDrAwkYdth/c/WgkErRm4yjqdiRhmp66jYmPxKp6bfWt58m5/ADLnqOv7tyH?=
 =?us-ascii?Q?/lzo4NGjXVmi5301R1KZeWG4MgKFSOLAP+mawLWV5RLh8NFkxfTZ6Vr/TZov?=
 =?us-ascii?Q?tVMpoONpYnJhiiTbH+4dF0+MyfP9zuQR9qu6MkCmMTi2uo6wSqtzys+L11Lm?=
 =?us-ascii?Q?nZi6kE0+xIwZl0H3JevxmMTEwnbij/A/+z/PgooINT2XhPEDSYchqS0NK7xz?=
 =?us-ascii?Q?NTHNgRfs0K8bFqFeZxPHS555aSPk6irPA2OCqGgZ9RRu347RoHArxEcd+frQ?=
 =?us-ascii?Q?+vL3Z+e4d3CSYi9jwEc5Tevpng/fz6Jgm+g3IxRlAenwqGK6J1mW5cHFUl2u?=
 =?us-ascii?Q?XXzYt4MQFiq0hR4NRpSfSHnfpq5SBZ1hZQ46zKyjiWPx9nNjGQHFolkOR3MG?=
 =?us-ascii?Q?7c1P/iOGyE96UA6wPyvyDw0hBmLyluu3y7XCnOPK5whCYh9CcQGyvBoNlm2a?=
 =?us-ascii?Q?0UOygCa1n/FVHZ/KGTXQsGUBJb+kJTE6KhTcc5DwX2dyDSqSMYGJCjOScJ7b?=
 =?us-ascii?Q?gvVKwj5L6vwSvx1qMru7osenGMlPVICb2qvd109bL0jhMyXOtkIUlnd7o58D?=
 =?us-ascii?Q?piCmacbCYMxUw0V8Z6bcrYNqC2NyGTvrZwXON6oXzGUM0WMtbkiSr/nZDqfK?=
 =?us-ascii?Q?QX4nwwkC3EwHXFvJx8XWljTpHIZd0+Q56W7Pu7XIzLAznO+uqNbwqWAbnubC?=
 =?us-ascii?Q?Q/9LpdiqtcA5HUYElCC3WnPUQWE3yWwietFQ+YiqVOOCfQ/yOYkOryjhCCGh?=
 =?us-ascii?Q?e7b5wzr+GwkNNnnlLL/CYN0bhY5z8B8LEpvGx3xhmlTYEvYnVHY+lmG1ZeKL?=
 =?us-ascii?Q?IvHURFt8E3fxgFT8JnKN4IL4YK7bNxW7LLZNINrlIhRK4kEtROdmeZ/+vDeW?=
 =?us-ascii?Q?waCjTHTND/KCF3i4Bd9XifkjksQeKDHqV5teIYT6/e/xtsRCgEJC?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 70821df1-cbc8-4a72-825e-08df102f1ac7
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 18:04:20.9631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y6dK+t27YU737L07IdwjeHsBEs89Cg1RzuUSl67jGwbM60E8TGJsSI2smA+rcoALd3Zs8JodCRVK0w9sF629rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB2546

On Fri, Sep 11, 2026 at 11:53:37AM -0500, Frank Li wrote:
> On Thu, Sep 10, 2026 at 01:08:27PM +0900, Koichiro Den wrote:
> > ntb_netdev_open() can call ntb_transport_link_up() while the transport
> > worker is completing setup on another CPU. Concurrent transport setup
> > and a client link-up request can both read the other's flag as false and
> > leave QP link work unqueued. The QP then stays down until another link
> > event or client link-up request.
> >
> > This is the store-buffering pattern described in
> > tools/memory-model/Documentation/recipes.txt ("Store buffering").
> >
> > Add a full barrier between the store and load on each side, and
> > mark the client_ready accesses with READ_ONCE()/WRITE_ONCE().
> >
> > Fixes: fce8a7bb5b4b ("PCI-Express Non-Transparent Bridge Support")
> > Cc: stable@vger.kernel.org
> > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > Link: https://lore.kernel.org/r/20260907144701.702E41F00A3A@smtp.kernel.org/
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> > Changes in v2:
> >   - New patch (Sashiko)
> >
> >  drivers/ntb/ntb_transport.c | 13 +++++++++++--
> >  1 file changed, 11 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> > index 75d4a2e021f4..1332d53bcfe7 100644
> > --- a/drivers/ntb/ntb_transport.c
> > +++ b/drivers/ntb/ntb_transport.c
> > @@ -1104,10 +1104,16 @@ static void ntb_transport_link_work(struct work_struct *work)
> >  	/* Publish the link only after every QP has been set up. */
> >  	smp_store_release(&nt->link_is_up, true);
> >
> > +	/*
> > +	 * Prevent both sides from missing each other's flag. Pairs with
> > +	 * the barrier in ntb_transport_link_up().
> > +	 */
> > +	smp_mb();
> > +
> >  	for (i = 0; i < nt->qp_count; i++) {
> >  		struct ntb_transport_qp *qp = &nt->qp_vec[i];
> >
> > -		if (qp->client_ready)
> > +		if (READ_ONCE(qp->client_ready))
> 
> I think it'd better change to use atomic variable for client_ready to avoid
> manual handle smp sync.

AFAICT converting client_ready to atomic_t and using atomic_set()/atomic_read()
instead of WRITE_ONCE()/READ_ONCE() would not free us from the smp sync, as
those operations are unordered.
So to illustrate this in litmus test like form:

   # L = nt->link_is_up
   # R = qp->client_ready
   # Both initially false

   Transport setup                  Client link-up
   ---------------                  --------------
    smp_store_release(&L, true);     WRITE_ONCE(R, true);
    smp_mb(); /* added */            smp_mb(); /* added */
    r0 = READ_ONCE(R);               r1 = smp_load_acquire(&L);

   Both reads return false?
    Before: allowed
    After:  forbidden

I might be misunderstanding your suggestion though. If you have something
different in mind, please let me know.

Thanks for the review.
Koichiro

> 
> Frank
> 
> >  			ntb_transport_schedule_qp_link(qp, 0);
> >  	}
> >
> > @@ -2401,7 +2407,10 @@ void ntb_transport_link_up(struct ntb_transport_qp *qp)
> >  	if (!qp)
> >  		return;
> >
> > -	qp->client_ready = true;
> > +	WRITE_ONCE(qp->client_ready, true);
> > +
> > +	/* Pairs with the barrier in ntb_transport_link_work(). */
> > +	smp_mb();
> >
> >  	ntb_transport_schedule_qp_link(qp, 0);
> >  }
> > --
> > 2.51.0
> >
