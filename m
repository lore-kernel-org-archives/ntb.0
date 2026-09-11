Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020102.outbound.protection.outlook.com [52.101.229.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7654A6CDF
	for <ntb@lists.linux.dev>; Fri, 11 Sep 2026 18:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789150879; cv=fail; b=Dd8oZEgGA4NeXHjcJcDAtmpo6uzIkOB95mSslFjwq+68XEMw/U0yHXw8vcEIGARRuqsiMQ0YGXGbONUiF8gRNmqak9f64/MbxLawFn3U5zlZzK9qnM4qAKJA6S47IRpHmWuqO/4YfzEGhL1UG2S4xYWkM/rVbR/Z3kjMHsaWizk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789150879; c=relaxed/simple;
	bh=2kV8URj9QCBE69jBkeD3yFQHAAchokcJztrVNLxorAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bocqxi2QjJ60ha5kqFTdPcUYDrO9y5twOGp/MyqbIOouZootFI6d9j5+dthNDuD8ie9o47eSNAzIbJah/YN54tZXK5CwIGu1czHTM+kjJGq0N7alj2XgU/aGsSkkbyMyrtFG1X9gn4AHgg1GbR+zxmUGBim4mV1t85P8uKnBJoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=iQuZKJq+; arc=fail smtp.client-ip=52.101.229.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="iQuZKJq+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AlRxZRzBvwgIbKpvk5QJkdiunEjNjXSjAwXKWg83abaYQGNPH5grfRifiI1ONt8xnwlv4ArnYvDqncuPEF+Rqs4hGMM+GKWRtNT15FXKU2GFa7oloLqB1YhGxL2/lZwmupKFhRl22CaenhnSKCLbWQDZ8VohsERj2EyQFVxFSpG0UcZYvH9mD+w1JJlzdqJuqqCpiXLFCti4QZ4FKM90jl3Gjlp/do2XJxlnqyyC0baBfs1X4l+ruvb+c5Eec5yy0WfEZU1iTJNXQfjwkHhOOT5KJxE0YUUBGcXLe8CGVHJ6I47zkZmPEz7v4F/zBErMDm9MvLvxWlQISV3xkVpLEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F5+6APPXwEF1cc7bN56iKBXxtVI5ObeXACn3R7LKsxI=;
 b=Dub6RuJKJWonn9v7kZQMW5Po4z2EdPMKXWJU/YxEF7vmwDlUBcMkj8mAxwnggphEu1DiZ+utzyTr15llqRkfYYvs2/hlWDY/EeIvNEONaKtwqcLpTe4DZIDSBsOpsxrgm7Ox9PpXVlN6FJ3xVl8uLlpmuTgO8Huuta61W1uAuov3mRhePUcowXnHtZvM7zo3Gn14tIBodoAfwG7I3mMXEGZoiFLYxh3oaANPD0JflhpTlazoiUjrGmeQoj/6zmxC6glbxjwRMBMzYwMEjoWoCN4f44GDccilkyQ2nWom6V/tbpQyKUkno3W3nG3EwnZgMpPgYtPGf24U5tnYLmxWpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F5+6APPXwEF1cc7bN56iKBXxtVI5ObeXACn3R7LKsxI=;
 b=iQuZKJq+x0+IYuL92cMCq2ZgA3FKYnONzY0YYwYY4HTl96aqvNFfFxrsF+rse7TvKpyvQQCY82aaO7kAipaEEB9t26tLUvFToHfhmu1FokKkDbwlrQOU+gOaw5riSgfWqdFv1Rh4tIMUSGRe8tvfx0zsTntnWv0eOpGbxIZIUzE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYYP286MB4715.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:193::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 18:21:10 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 18:21:10 +0000
Date: Sat, 12 Sep 2026 03:21:08 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, Frank Li <Frank.Li@kernel.org>, 
	Logan Gunthorpe <logang@deltatee.com>, fuyuanli <fuyuanli0722@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nicholas Bellinger <nab@linux-iscsi.org>, 
	Joey Zhang <joey.zhang@microchip.com>, ntb@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/14] NTB: ntb_transport: Avoid losing QP link-up
 requests
Message-ID: <l5xf2iuwxgfa4xmtm2l3wn6nce5onfjxxkzfsj627k5xp3snmp@er6fkwlb3sgs>
References: <20260910040836.3792333-1-den@valinux.co.jp>
 <20260910040836.3792333-6-den@valinux.co.jp>
 <aqQyEbLbABhhvFTO@SMW015318>
 <ciucjqvb7qbendlxqdya2wigyivgj4bvqbxtc4cidulr4knq6j@xbwucjdsiayy>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ciucjqvb7qbendlxqdya2wigyivgj4bvqbxtc4cidulr4knq6j@xbwucjdsiayy>
X-ClientProxiedBy: TYCP286CA0165.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::11) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYYP286MB4715:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f195c1d-8353-43e0-4c16-08df1031747c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|10070799003|10067099003|4143699003|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	tsIdtCcm7LSjv4X7tViJmXsNrE00WNVEGk1m0ci22U3zcpwDEPZPql0O3/QPduqY+v6n6CmMQVwWN5L8YdS5/szLOqEMQsHULLUb3W5/PKDrAHUjUQd6s8L4hY1h7j0BmDV2VhLh0a5CiBnFN94+C/E4GOfjiCRh/lkD67APW2liLlK6uVbOIcw1M7p716XEI4PjuudDR4yYs49HGYwQMmiELq1XzFvXIYyEKnVEZr4NrKXxtV44xl4e2qJdqzy+BpFrD3EkglkyA4TJukAb0ola8CLPFjsaJQgM/KKHzS2lFufzeKre1Gjl3FAz99j66uRHSLqzKVgbUuQGqJuN3zLMuT9v8hQ/+CzniMb4PPP4Onj2bCjzhietULTm2udJmrIAe7Q5HgzX5J1X7dwYcNLtT/WNlGan4AVUkBkTSGlu5F5k76oYlCV27HBlrDGK8pOFAmVbzcrNyuEsty72TH1/AbBMIAaSbCNB1s3rZB5QTNWdRxG8k/DEoxNFDG1Wm48vX5ZzD0SW40lbkzGf3PAzOYJdRJB+RtfujQzXd6UQAt3ErtVHdNGx8lOOMdkqEbiC8tKhfqxQlMWlOlZpLOvo7y6XW98gLvD8Dfbeh+5B/h/7YhVlHVisJxXE36TL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(10070799003)(10067099003)(4143699003)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O5EQ0i66eBjd4ZPnNtqtF9sH3u/VKJLSmHnQt+E1h0rtAa8Rw0eMyw3OuD93?=
 =?us-ascii?Q?1FPySBdRwqo2fOvDguvLS2BNkxAT4YSDvW/0bhS+sCeo85svhbKZPE5WYu/6?=
 =?us-ascii?Q?D2Bbo2epMmbu10aaB95s3+qbYdb0MHrmF/njom1W35t7KYWi9vzlWG9au+5X?=
 =?us-ascii?Q?BzJ5Wovk25EyADtGc4z98lZYVZtFEOXPZULvFG3MehqUwTUl6ev/Bsq/C1Iw?=
 =?us-ascii?Q?wCY+5wmutxwxhJN8tibHwnrfhDUY2s44X9ElS04F/o/oLRbTMAz+l84ncHb5?=
 =?us-ascii?Q?HCWEecq0F0kTY8l1+gAXaKcXKxC/ePu4znf7BUaEb3V6ktnVNnHwg4O88FOV?=
 =?us-ascii?Q?rBphyPgQjvINkWV0tLD3WNXkSc5sCRp+pr7KahDsJSYPF4/VDmjr2CMn2H00?=
 =?us-ascii?Q?2M7cdZxfQ1r6wfZqlUT4mpx26YFXPH0agOM3mpg5C3ffxProoHBk532TLRx5?=
 =?us-ascii?Q?BnSkywadnc2qxEGvOhEl6mKeNmcSMrTaB8zqNf3+fkm45rGBG8UWj/CERO68?=
 =?us-ascii?Q?EG4R3nzgYQDdtQMLMYPcQdmOo46B6O1FKv8O43D1szA0cMuU46/co5tgR9nF?=
 =?us-ascii?Q?7tLIKRm7hawhWU3PxAqSw5iBjki0YBzWoGTqFHK3yCb7Mgt8dWTWgDjyCYYN?=
 =?us-ascii?Q?UpIRvsWWCWVAmTxf1hbGVsBdsaqftQCE7jnppxuz0son3T8abo8ClDKmrXfL?=
 =?us-ascii?Q?27Z9G0scc8RhAM5uAAh6UopmT6FHRNgdiQPwzYPBbC6lCDEu+ssvUVK+ed9k?=
 =?us-ascii?Q?WCxiizuOTUf1ZXbCFmtoxQUWt11wsBeYv0CEh4bY680XF0W0z+q/14VR4mYD?=
 =?us-ascii?Q?4Zl16uqwI1/IxAXpEIJ/JiHAOo7PJ3k7Ak1+jXTmmctn0mSluaOtRU6FC/vH?=
 =?us-ascii?Q?pjShLg2BKzKywMt6alJLejYzW+CHoPnjtsx6GDsvcGmiI9JC65tat6HlB50F?=
 =?us-ascii?Q?EZIlP+Pd88JIEtfv2KDbQO8jfCnznZcYdnqgNHEBOqYERDWquFVGVUEaNx2V?=
 =?us-ascii?Q?vLXAKgrJkGJ3fyUOwoaWMn494U6agHpCwYuk1Y7dmpxZb44iKtbsTqAEIP2A?=
 =?us-ascii?Q?49vRrMQKTip20EYnby7fOGKeVn4970z7qhLGWk8RTZyAAmSYYXNLpUwmplZI?=
 =?us-ascii?Q?EJVo3gLYz08uVaXNzGd7tT7oM2RUNot17iEVEZA32fMq+oGOjtk0En2ep3kF?=
 =?us-ascii?Q?nUGwcFDrol2J+caajkmOjJJ9hPNhHqmcg8cPuIQKnv91pCSLvpV55rZTdn+D?=
 =?us-ascii?Q?mGd1C+WEkGOxS/ruOi07K97OnrI4PQnpwGW/h7YwuZ3Zy3VrWAYxrSKCyA+e?=
 =?us-ascii?Q?n9Xt/O1iIKV2bt+zAfZL+AUHXtShnqfOeQOaRLVimrkO9NFa5JMMVIZf8VSj?=
 =?us-ascii?Q?CiVt2QNLb33QocTrgBVshDDg/FZ8UEjSQNQaAMKxXro+6I7WKs5wBJyzjkqa?=
 =?us-ascii?Q?A75T9WkqvYZNC2l9ipA/WKK9UHXFUuAb0dZC6hA4tPIwhnlM5SBgj6Bw0lR1?=
 =?us-ascii?Q?l5xdHkoM2ycezFBTJvl36uE8/gLNOzPqeU8gxcTyzjHF1A0JtgCj5gUWDxyi?=
 =?us-ascii?Q?GNcAYLyA+XW7KeprYwCtcN/8vv5NE3w3W7GpwEYWqiTdiPYux9CjgwsLHfGZ?=
 =?us-ascii?Q?VG26ezyJTv3dTWbvVfwZ07/vKBwQCo1zNwl6zfEsBWPNq1M3RPSc67QqkbGT?=
 =?us-ascii?Q?0aSuoN5tMBZWkiMxd8F/FMFHQNz1ptUr0scW2Qc/fi2cq75Z/RbY3NW7xapN?=
 =?us-ascii?Q?1H+BGLL1y5ROwLEozBxA75caJG5eK92j7WEgHsvuI5bPoASGexrY?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f195c1d-8353-43e0-4c16-08df1031747c
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 18:21:10.4140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v+18Y/7vuokjHm3Kr93EF6EhDoMHnGR2mOOH3MeBPggip9QtdY34iFOlJAoEeunWDO7+iDjj3VS2gYQF5KwVEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB4715

On Sat, Sep 12, 2026 at 03:04:21AM +0900, Koichiro Den wrote:
> On Fri, Sep 11, 2026 at 11:53:37AM -0500, Frank Li wrote:
> > On Thu, Sep 10, 2026 at 01:08:27PM +0900, Koichiro Den wrote:
> > > ntb_netdev_open() can call ntb_transport_link_up() while the transport
> > > worker is completing setup on another CPU. Concurrent transport setup
> > > and a client link-up request can both read the other's flag as false and
> > > leave QP link work unqueued. The QP then stays down until another link
> > > event or client link-up request.
> > >
> > > This is the store-buffering pattern described in
> > > tools/memory-model/Documentation/recipes.txt ("Store buffering").
> > >
> > > Add a full barrier between the store and load on each side, and
> > > mark the client_ready accesses with READ_ONCE()/WRITE_ONCE().
> > >
> > > Fixes: fce8a7bb5b4b ("PCI-Express Non-Transparent Bridge Support")
> > > Cc: stable@vger.kernel.org
> > > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > > Link: https://lore.kernel.org/r/20260907144701.702E41F00A3A@smtp.kernel.org/
> > > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > > ---
> > > Changes in v2:
> > >   - New patch (Sashiko)
> > >
> > >  drivers/ntb/ntb_transport.c | 13 +++++++++++--
> > >  1 file changed, 11 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> > > index 75d4a2e021f4..1332d53bcfe7 100644
> > > --- a/drivers/ntb/ntb_transport.c
> > > +++ b/drivers/ntb/ntb_transport.c
> > > @@ -1104,10 +1104,16 @@ static void ntb_transport_link_work(struct work_struct *work)
> > >  	/* Publish the link only after every QP has been set up. */
> > >  	smp_store_release(&nt->link_is_up, true);
> > >
> > > +	/*
> > > +	 * Prevent both sides from missing each other's flag. Pairs with
> > > +	 * the barrier in ntb_transport_link_up().
> > > +	 */
> > > +	smp_mb();
> > > +
> > >  	for (i = 0; i < nt->qp_count; i++) {
> > >  		struct ntb_transport_qp *qp = &nt->qp_vec[i];
> > >
> > > -		if (qp->client_ready)
> > > +		if (READ_ONCE(qp->client_ready))
> > 
> > I think it'd better change to use atomic variable for client_ready to avoid
> > manual handle smp sync.
> 
> AFAICT converting client_ready to atomic_t and using atomic_set()/atomic_read()
> instead of WRITE_ONCE()/READ_ONCE() would not free us from the smp sync, as
> those operations are unordered.
> So to illustrate this in litmus test like form:
> 
>    # L = nt->link_is_up
>    # R = qp->client_ready
>    # Both initially false
> 
>    Transport setup                  Client link-up
>    ---------------                  --------------
>     smp_store_release(&L, true);     WRITE_ONCE(R, true);
>     smp_mb(); /* added */            smp_mb(); /* added */
>     r0 = READ_ONCE(R);               r1 = smp_load_acquire(&L);
> 
>    Both reads return false?
>     Before: allowed
>     After:  forbidden
> 
> I might be misunderstanding your suggestion though. If you have something
> different in mind, please let me know.

Just for the record, smp_store_release/smp_load_acquire depicted above, instead
of WRITE_ONCE()/READ_ONCE(), is intentional. They are for MP ordering to publish
the QP setup, which is needed by an earlier patch:
https://lore.kernel.org/r/20260910040836.3792333-5-den@valinux.co.jp/

Best regards,
Koichiro

> 
> Thanks for the review.
> Koichiro
> 
> > 
> > Frank
> > 
> > >  			ntb_transport_schedule_qp_link(qp, 0);
> > >  	}
> > >
> > > @@ -2401,7 +2407,10 @@ void ntb_transport_link_up(struct ntb_transport_qp *qp)
> > >  	if (!qp)
> > >  		return;
> > >
> > > -	qp->client_ready = true;
> > > +	WRITE_ONCE(qp->client_ready, true);
> > > +
> > > +	/* Pairs with the barrier in ntb_transport_link_work(). */
> > > +	smp_mb();
> > >
> > >  	ntb_transport_schedule_qp_link(qp, 0);
> > >  }
> > > --
> > > 2.51.0
> > >
