Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011005.outbound.protection.outlook.com [52.101.65.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788994BEE2C
	for <ntb@lists.linux.dev>; Sat, 12 Sep 2026 03:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789183258; cv=fail; b=OvLDrJHOsw7gM/m0WnEM4t6riZXfTbR0shwpJ43C8ApS9wAV3i1gH0+dnkMrAB868Nrx4j1ONd2VPEzdmiwAUAFKJVOR6VciE9oY8LLiE+pUfyGFQUhiU9S7P4W/ir1ylE1WrQMEf2qCJQVJn0caxtj6OOxW0RTTgqRC/TAKU+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789183258; c=relaxed/simple;
	bh=A0E5no9kcGfdCOYmIFJxxooeGSMJLcN7E0WAzywhuBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mh085nSvPi7Y7WyPVz2ytAm4eTKSE4/GJNvohu5JwcoEY9pFy9TLeWIDrMBPeej0wF326FIxsBXE/yJzAaPyo07GIUTG6xp4I33YP8ge4S495XNbu2K0YHsxtB/dSZoIHmLf/4R6PJ5NKI8XSMTm5G9d9+oGVOcZWKF+32qpTno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=rdjt///k; arc=fail smtp.client-ip=52.101.65.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="rdjt///k"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DD0OQ+Mq4ALaCVtABIWuy2jIlCT2j8guNYfEF/U1CnM5xHmL87Fi0DTrm95wfAXGcgG7/sQz/86c9zw870DfHKDc0uGaJBeFohvyMKUxGm4sAhdEBlYueYmgZ8CoXulTBDeAPIoqFaFGTPCm9WbVX467KqeRJhGDnoVnLygV7NOBJB1j7Mjsx9nLfr3NuBdO8+oRuOEo+cl2hZ2zgY4C5IjSXGZ8L18zYsBfUw4SNTti9kn1l7JNCSJN2jrZioQ13EFxfN4h4/zf75LveFSI9fKNqSgWAI+tzVaJ7HgpmkAv45us4kYtsWLiIAxFEgXgrHpjDPbp2qy+onDUTzJhoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=44pq4cSWZJzY7C9LD3Ruf6Sc0xiE0GuMr28wBufa8nc=;
 b=Zjg+JuGLJYmiROn6mgq2qQqIHdvG27+ucRDBSp2buo1lTkwDfgqcebAxDSsadb6lQjoy9Mnc9ZLeHoYUBaWDvzKbq34u7aEUQV99uYsJxR4mzQaLtKChciC1TYOEpeoxzFtE+4BefRWueHVBrCaInifidpBdQRu+9hczokkL6RktabrMnrUC21LscUqKeSUSB1qwcVJJQUKoKsUy892+aditJuHlvSs0N6SYanWKh0rWZptHOF40iJ+8J2QpqIXxBlSxkrD6F3giaCH6DLHFNE79fxUVfOMRUNGWXptgkFITlaG2B43RQJLuGiT4TVirfw/s+836UbmAVbF+HsgM7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=44pq4cSWZJzY7C9LD3Ruf6Sc0xiE0GuMr28wBufa8nc=;
 b=rdjt///kXXuo0kNwoVv6Mtm9i+b874YW6z1rsCQZLejnHmWlU1HkQBCUvAxynqrPTdq9NylFw+KT1ZDX97e7wgI3V7NPw6PI/J78K+/FuD+X8qrgT7lS2Yepn+ZtYBnuj9nCzgS+Any/oe4akBHiztZitDBAdLV4codeh+2A7WP3hPzWWCB6XAshe4VySwSen9YsSrR3v5XpOAHNQM8zBfk6wcJOiIPELrV8uF6NcdGDEFYQPt2EuHimLzUIYz9jaq9vdpS53JQE+yaDv3SE74c25GVTYDCUwaIjFxeqkWoZJ2anU2+FY6QQiLUEeNDj3U2VLRhElwuzogSMDFPHgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU4PR04MB11791.eurprd04.prod.outlook.com (2603:10a6:10:623::11)
 by PA4PR04MB7967.eurprd04.prod.outlook.com (2603:10a6:102:b8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Sat, 12 Sep
 2026 03:20:51 +0000
Received: from DU4PR04MB11791.eurprd04.prod.outlook.com
 ([fe80::11ca:6b74:3234:d7de]) by DU4PR04MB11791.eurprd04.prod.outlook.com
 ([fe80::11ca:6b74:3234:d7de%5]) with mapi id 15.21.0406.007; Sat, 12 Sep 2026
 03:20:51 +0000
Date: Fri, 11 Sep 2026 22:20:34 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>, Frank Li <Frank.Li@kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>,
	fuyuanli <fuyuanli0722@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nicholas Bellinger <nab@linux-iscsi.org>,
	Joey Zhang <joey.zhang@microchip.com>, ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/14] NTB: ntb_transport: Avoid losing QP link-up
 requests
Message-ID: <aqTFAi8uo4LwzSj0@SMW015318>
References: <20260910040836.3792333-1-den@valinux.co.jp>
 <20260910040836.3792333-6-den@valinux.co.jp>
 <aqQyEbLbABhhvFTO@SMW015318>
 <ciucjqvb7qbendlxqdya2wigyivgj4bvqbxtc4cidulr4knq6j@xbwucjdsiayy>
 <l5xf2iuwxgfa4xmtm2l3wn6nce5onfjxxkzfsj627k5xp3snmp@er6fkwlb3sgs>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <l5xf2iuwxgfa4xmtm2l3wn6nce5onfjxxkzfsj627k5xp3snmp@er6fkwlb3sgs>
X-ClientProxiedBy: CY5PR22CA0045.namprd22.prod.outlook.com
 (2603:10b6:930:1d::22) To VI0PR04MB11784.eurprd04.prod.outlook.com
 (2603:10a6:800:2ea::12)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU4PR04MB11791:EE_|PA4PR04MB7967:EE_
X-MS-Office365-Filtering-Correlation-Id: 859ff8c7-4cf1-47a1-7ed3-08df107cd88b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|7416014|23010399003|376014|1800799024|6133799003|18002099003|22082099003|4143699003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	m/1v9jV8UYRaHTzwEbBiGRdHCkwgRrkqDIOaXJqPh/6441zb0UH0IoLZFsmxuvmVWjNQb3is5O0aytKu/igEUbzRNyIVXA57uouoEpLmpwAqVJLaN23D6pLJXrxNVXIid5cFNVnp8FZsEjUhF/O4lsFS4eHrnp4H9czf4jviKByD6M8MGlrjvAIUOs2bR7D+G8R2N1SOrg9YekhrMejj4Dpr5AD92nQFSwgMFQbOqNL4xqq/1hwrF+e5FRMjJpwya04RWDbq3iyJUSFl87povE9XdfDTMLVK2DPA7LxUSUuDPjow5tIE0oaFCqe2qkK0ks1QAAufxEgodxL2IIRg74ZqfB43iJQXEYvgEjBDbKK3DbOr8wGRNKnt7kjaMUZAMgjhLLLwY/lBEGuFZXRkpc2lUHva1J0iWiJKT1601yZZM7jx+k72JBDc33P01O07hIrJNrfPswjAr5+c64KgYDgfde14HJBX3RkuqkzBI6hkjSkJHbAGQS/dw2o2QzuLB+Nrjh5uUv6Koy01dXsp6DA7BMh63osOA5pO88GQ5qg3/t5GSWbhlgwuspK5ZKKAAmDUdjHTAP/gVj+sZeb30/f1N45tLzmj0E/J4ex7jWPve+abBDih+00LeZckICfg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU4PR04MB11791.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(23010399003)(376014)(1800799024)(6133799003)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M52a7CxVBq1vEGxUEi+IeN+YOsGkV0YjxfCm12oNISv7Pzkv5xONlRFX0RhC?=
 =?us-ascii?Q?7TFAWGd1vwoBZyK4LYHvCYx5akcI6iVM5mLOAC0V6SaHCJ00e1x+DsU2xe46?=
 =?us-ascii?Q?M09HiwAxolCHEW1J9E5xqMk6j4lSPuNvbu/xgB4Mrq3rJiPioChAeU+4npvQ?=
 =?us-ascii?Q?uV+2rQm5UYH88GJaTO7CEY2U65HJYSCO5kYUWkxw9Ut2HhrZ4sjSjhVRAXm+?=
 =?us-ascii?Q?Vz979j21voeqqBm4RGafsjNTABq0JykzQsKEWxWokHFaEcCvetTjZUUaTN/M?=
 =?us-ascii?Q?LZ2bA8u4ai3CU+jMu9fxKKm8csBV2CdGnj/4NOMR+0kyD9xv03b8VpzrIjew?=
 =?us-ascii?Q?c/0M/cg0lvMMeB51fPyr5LLFBuXmtHE1uhf7/h67COxktBAvIV3JIXEyEu+v?=
 =?us-ascii?Q?QfTlcBs1Ek9IHNFOTwf/HiULaUVe097DYLLBUCorsQEqUHpiP/2eOAcpPW9v?=
 =?us-ascii?Q?CxGeoXMHIAnJb1NaBugUCLXMSmhJbO9bBOrxHTRW7142eGdxfNJHKsF+vRcc?=
 =?us-ascii?Q?kQBpEgq4ro9FEzTm8DbltV2kOkIr1+NSOA68SPIUJSB7y3CiazWuZ60Xs8sv?=
 =?us-ascii?Q?qYl47RYne5INB2QW4ACjvCmMXR1SVoiohOWE1cx+5vZXXyNWxg5Ak4Pel0yu?=
 =?us-ascii?Q?fhXp134X5DfQqK4Hzl3E5ImnwI/tlIOgQUfSn5PfvrvKwA947FItbqTZQCix?=
 =?us-ascii?Q?f581TboKVmLg689KQgAj70uBUY3/aRAKe0G11vmUx7soqLLS/rpEmGL8HhH+?=
 =?us-ascii?Q?/uBmQX8wuJh9GoOIigCTetw3SsCHLRJ4oDqEUU7RM1A2ikGZaZlsV3HQUFQC?=
 =?us-ascii?Q?PgXxEBNDBi+W0xe7PdGiB56dlXUjQljAeCLLnW7RsSkRygqdlyjVVW5LoDn5?=
 =?us-ascii?Q?3/KDLnwH+Zc9XzExrS5F16q8fR3Be/kYojphzSvS5JlYR8aVCVfWr4nnBBeO?=
 =?us-ascii?Q?n+zp4n7JuCsBbJl9gm2knLy5nIX7ESreZMBK7gBvyXqEm6mznuym5oFYvPzD?=
 =?us-ascii?Q?PnvEziXRdCULJoLQGpBHEIxhEFflgra4Z2Ms8OiATZZgMW75YkEzNls26+zk?=
 =?us-ascii?Q?Z1J+hstGWg4eKsp5EI6Ui6bHlRMUeUOl2f++2GhfdIQ0ghw6bVSTiiiSUHtn?=
 =?us-ascii?Q?9VNiQtIh7Mp1G7VIQnouk/qU3FT3ptABlO6/dHt5Yh3Rgc/lmdCjjgxTAX1w?=
 =?us-ascii?Q?264VMuCgSn1AU+mWrpoUPVPmSnEGKwUebw8RRsbKIog4EUi1MBc4zSuyquIT?=
 =?us-ascii?Q?LECVN2WY56fF//ToAkIwxsvkSwB2REYQsDGjDh4FHKmaIwxFQjdpJ3T4AaMR?=
 =?us-ascii?Q?0uKHzBI9FrGHVFEV+YpDZmU+FMhyUYtXQZcfVUMnzJ9lawsE0bn2WE0vSoBL?=
 =?us-ascii?Q?idc4vFaWQohx1tMjTUk5xiP1jPdoKUllZ3I0LAsZ/etT3HVnA98HfggvLtAM?=
 =?us-ascii?Q?qM2L+ky2j2CXwvq1dHRgFkIJNAjSo3Vu6jLpqbs1q/AQng22lkEZbDVFOo3E?=
 =?us-ascii?Q?baAOZVfN9kM64p+pm2Cq0IIDbOeD+/lJZAO9AfBTukTDkutjsucsPR7ATCR5?=
 =?us-ascii?Q?4NulSINKaQI5TrqcqO2y5yZIqEWZxFL8y/31tG4a+pvG/apqmSA8ePIqyr5k?=
 =?us-ascii?Q?lEzuUd/4FJ/XhGFha2bpc9cX8dx0lP//laOHCj0ne/4Pyr8hSeJRwj1bHQUY?=
 =?us-ascii?Q?lCSeNKOBpskhz/n0hjKdDkfic95fPGD65tkQ2xOI/GLWPxJP1VYRekIykM7R?=
 =?us-ascii?Q?KbCRCCx35RuA7/zGFSOntTNi3psLKKsZpcIErNsiibFSFk2iu93R?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 859ff8c7-4cf1-47a1-7ed3-08df107cd88b
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB11784.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2026 03:20:51.7450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FugGJ4hCrX+ED0ED0QyUeUsQkJtqUWzt1lH79f+WaOX17AOiaWiSRiDE7gDJh3Ut515HrBu3zmkiZNjRz8Xm7Rkr+vuqfSGfHmeJvcsred5tWLCeEy7Rg8IwKPHLQbdp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7967

On Sat, Sep 12, 2026 at 03:21:08AM +0900, Koichiro Den wrote:
> On Sat, Sep 12, 2026 at 03:04:21AM +0900, Koichiro Den wrote:
> > On Fri, Sep 11, 2026 at 11:53:37AM -0500, Frank Li wrote:
> > > On Thu, Sep 10, 2026 at 01:08:27PM +0900, Koichiro Den wrote:
> > > > ntb_netdev_open() can call ntb_transport_link_up() while the transport
> > > > worker is completing setup on another CPU. Concurrent transport setup
> > > > and a client link-up request can both read the other's flag as false and
> > > > leave QP link work unqueued. The QP then stays down until another link
> > > > event or client link-up request.
> > > >
> > > > This is the store-buffering pattern described in
> > > > tools/memory-model/Documentation/recipes.txt ("Store buffering").
> > > >
> > > > Add a full barrier between the store and load on each side, and
> > > > mark the client_ready accesses with READ_ONCE()/WRITE_ONCE().
> > > >
> > > > Fixes: fce8a7bb5b4b ("PCI-Express Non-Transparent Bridge Support")
> > > > Cc: stable@vger.kernel.org
> > > > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > > > Link: https://lore.kernel.org/r/20260907144701.702E41F00A3A@smtp.kernel.org/
> > > > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > > > ---
> > > > Changes in v2:
> > > >   - New patch (Sashiko)
> > > >
> > > >  drivers/ntb/ntb_transport.c | 13 +++++++++++--
> > > >  1 file changed, 11 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> > > > index 75d4a2e021f4..1332d53bcfe7 100644
> > > > --- a/drivers/ntb/ntb_transport.c
> > > > +++ b/drivers/ntb/ntb_transport.c
> > > > @@ -1104,10 +1104,16 @@ static void ntb_transport_link_work(struct work_struct *work)
> > > >  	/* Publish the link only after every QP has been set up. */
> > > >  	smp_store_release(&nt->link_is_up, true);
> > > >
> > > > +	/*
> > > > +	 * Prevent both sides from missing each other's flag. Pairs with
> > > > +	 * the barrier in ntb_transport_link_up().
> > > > +	 */
> > > > +	smp_mb();
> > > > +
> > > >  	for (i = 0; i < nt->qp_count; i++) {
> > > >  		struct ntb_transport_qp *qp = &nt->qp_vec[i];
> > > >
> > > > -		if (qp->client_ready)
> > > > +		if (READ_ONCE(qp->client_ready))
> > >
> > > I think it'd better change to use atomic variable for client_ready to avoid
> > > manual handle smp sync.
> >
> > AFAICT converting client_ready to atomic_t and using atomic_set()/atomic_read()
> > instead of WRITE_ONCE()/READ_ONCE() would not free us from the smp sync, as
> > those operations are unordered.

there are acquire version for atomic

atomic_set_release()

atomic_read_acquire()

My key point is use existing higher level sync APIs to avoid consider
barrier problem, which need more brain cell to think it.

this is just sync state, which don't impact performance.

Frank

> > So to illustrate this in litmus test like form:
> >
> >    # L = nt->link_is_up
> >    # R = qp->client_ready
> >    # Both initially false
> >
> >    Transport setup                  Client link-up
> >    ---------------                  --------------
> >     smp_store_release(&L, true);     WRITE_ONCE(R, true);
> >     smp_mb(); /* added */            smp_mb(); /* added */
> >     r0 = READ_ONCE(R);               r1 = smp_load_acquire(&L);
> >
> >    Both reads return false?
> >     Before: allowed
> >     After:  forbidden
> >
> > I might be misunderstanding your suggestion though. If you have something
> > different in mind, please let me know.
>
> Just for the record, smp_store_release/smp_load_acquire depicted above, instead
> of WRITE_ONCE()/READ_ONCE(), is intentional. They are for MP ordering to publish
> the QP setup, which is needed by an earlier patch:
> https://lore.kernel.org/r/20260910040836.3792333-5-den@valinux.co.jp/
>
> Best regards,
> Koichiro
>
> >
> > Thanks for the review.
> > Koichiro
> >
> > >
> > > Frank
> > >
> > > >  			ntb_transport_schedule_qp_link(qp, 0);
> > > >  	}
> > > >
> > > > @@ -2401,7 +2407,10 @@ void ntb_transport_link_up(struct ntb_transport_qp *qp)
> > > >  	if (!qp)
> > > >  		return;
> > > >
> > > > -	qp->client_ready = true;
> > > > +	WRITE_ONCE(qp->client_ready, true);
> > > > +
> > > > +	/* Pairs with the barrier in ntb_transport_link_work(). */
> > > > +	smp_mb();
> > > >
> > > >  	ntb_transport_schedule_qp_link(qp, 0);
> > > >  }
> > > > --
> > > > 2.51.0
> > > >
