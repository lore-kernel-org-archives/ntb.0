Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013049.outbound.protection.outlook.com [52.101.72.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B4C4746C8
	for <ntb@lists.linux.dev>; Wed, 12 Aug 2026 15:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786546824; cv=fail; b=QQcB5+Quqbv08KCt+oXP8pIPnzAsISklTOgOvlgjuaFkczVfGnNTS3NoXmuAN+wtd9ME5hQETxzxAc/Q4vLqMDq1UIZdej0fLbfZlNcBcA+1nktpZfb4TyxAwBg6iUK0Jipx9gN1GCCcUdyyThoFZ/O3i6gXekiW6vbZnZS1ppI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786546824; c=relaxed/simple;
	bh=akIyX5PVvVdNZwvdiGe1dwlTgaZUXz6rAiE/q8hGzyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bqutSsNMUJk7sMLUj+9eHMlQcUIi6VkvsSM1OGu+DZkXWQUmbWREy5CIDJIJSKWtZi+BL+G/6sPI9ATaoxC8MCE1j8ZqpJaBKwjFpqXIXgGWRFzRhHQkvGFWbt+ojPQ5c5Z+5piExox4U89vG+n/WEsDJ0RGORjZOfhtczo+2DU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=nNjUBkWR; arc=fail smtp.client-ip=52.101.72.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="nNjUBkWR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C6oAkrjCJNgLVTMUKqxYxPA/6am8hBywihzxGx9UcQGzeEAqD+iDOrVZsqEtRE+VaCpwIdphTljnEZBdUWSnKHeEGuf4X2GKTA5S9OZsSY7D1KBl7SL05yaJ6HFSCZrifZeqwAezFheZBPlOeAEvQYpY5NNbVWwnKJgkeOLlvzup5SiF7Ol9DgBAQdyiEFmFfeGBK3lyDRGqIIHKMvVmcGUDvtM8voVme1BTnPZitrsvmA/ci90spzWea6/UgTGHzdG2MKt0Znm6+zEpwg6u7POTFf54y9bRWr/EjWW2J3D9DpI2jGrkrix6JVXLSa2VYQCPMk0x1RhtUuHqW/F7ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OLnUByN0+/vT681dV62LemX31Wk2MvrE6AlRgrODQ8c=;
 b=u3ArOd0JJ8/E2hgdR8lEJNMHS0kcL+MNAqi/juViIMMbQHcSqHxdnWbYP1TeQ/x2Y7MWv1W/WQvSN0+uuUo5oq1R4wU7GF4cKCOelw+Pczv/M33jTeitZuKanml5YcwC+1Tc6RH4IFd8kDszng0R4Ll6J9no3cq4jPxhf4QlA+ggd3QTey4Wm3ZpQWcLvmOo1wFFGGyZ4lUUNYwvivSDp0RRB6SCgFOFG2baZGHp96BFACzz79FV0fl0vYxbD1A8hFCbVVL0+ne1DKQyTXW4T60XFoNL3NCEH2HAyG5xqXhUN7DbtQgDZXujUe+dUYZtv1mlHrkCLe68IGzOb+6Vmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLnUByN0+/vT681dV62LemX31Wk2MvrE6AlRgrODQ8c=;
 b=nNjUBkWRqWWRQF7ExGWZlMFTl8lZRUDS2E/7gkDh2K0YlGtdnSaZIJUYcKU1ZvnsTSEHBgGOFYwx0V9DUY63upQ8IoMeUU2/9++2E3Gqm3yyrPjOfB/dV4HGob4xD6cZMSZjHfOQSVKDNHbKpPRJ/kZMtm4sx5+N8+YCOIRZQzUd28QTQeMMUVKTjYR7xePapUgYG3uz//5690sMumVLneZpsN7nM5PmkdYfyUfdyz9pWoKCysLmheWUOnm1Zt6pRmVGs9i5t75oyqJD3s+Ho2xgoy4bULcDO2VhlYhPfxKpMBtCf8x5NK7y7pP1pqRvn5l9DikCfx+Ps6r208EWCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI1PR04MB6911.eurprd04.prod.outlook.com (2603:10a6:803:12e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Wed, 12 Aug
 2026 15:00:07 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0315.012; Wed, 12 Aug 2026
 15:00:07 +0000
Date: Wed, 12 Aug 2026 09:59:58 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Frank Li <Frank.Li@kernel.org>, Allen Hubbe <allenbh@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Niklas Cassel <cassel@kernel.org>,
	Nicholas Bellinger <nab@linux-iscsi.org>, ntb@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/16] NTB: ntb_transport: Abort link setup on QP MW
 allocation failure
Message-ID: <anyKbq3mpLG4y7rb@SMW015318>
References: <20260810165136.2292436-1-den@valinux.co.jp>
 <20260810165136.2292436-2-den@valinux.co.jp>
 <anobdz2EDP1UiLbA@SMW015318>
 <kdcjmsy7gqy2iolfom3tzigocecmkquzepbhusgprvzbfnfg6h@acqxas2tvpxb>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <kdcjmsy7gqy2iolfom3tzigocecmkquzepbhusgprvzbfnfg6h@acqxas2tvpxb>
X-ClientProxiedBy: PH8P220CA0033.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:348::11) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI1PR04MB6911:EE_
X-MS-Office365-Filtering-Correlation-Id: f9a14db8-9f7c-400d-a385-08def88265e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|23010399003|376014|7416014|366016|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	h2DfkxQA3unOr7i+NdVZ9SmvtqX7oqQY3iDGghu1T6/nROx8nPQZ/eUw1kFrI8xYoPz8nG6VuY7E3+V2cDQdJs9eUwIHkC0Gn5QN8o09NZHl4q2eIUWVCs4DOqXO9tRhJ4tLMbiD71JICJ+ftSnoQhAhwCkD3c9rcY6n9HV6qohSBU7NheBYb3CzAkWOJcTK955xcYYMZFS/qb7pHn0ZIea8LObbDQhPX5juer8THL48Un27IiunWP9ZCSk2Wf73VbftsJ7BOpzmRWllhgJqdv5lBhkkCfhqHRuws6EIzPWJn8gVydlwnnDB9w7MHlsjJE8fMbdtJVuOHMc3H4rwpOoCpenj9ai6StDkQKHyFHu3qNjV2LtVsKWdp93RmCzgg4xB6+zaeCkUEGd44vsVXAko37lTAYTRE6jnhIYy5pDLphrlxnu3+v/jHAuYqhLPUdUO6sI0rO6Fy2zuVgnGgIEbBmOmeHBS12SSWH2Np4WSs4blfSez/N1y7sGYNCrEhEkgwi5m3Zj5Ae0pz472gNJ16BLhEyTNrMK/CdrERBtJ6x3mVSVWbdvh3ZtnRnptrsXVsuktENcJSAPJT9LbKNvxZOTm3S22tHNMBIAG9ImTLFVhgdGeJLMORwtmLGzyZjC3WeLN8eFjuSUfQmhaDVz3m5uL+/Y6VuA5Z3r5arM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(23010399003)(376014)(7416014)(366016)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8o4rvU4PQOprliZjJ8Z2C1LTg4udzIg3707bPYcdafr9QoU7+tPCHvzXgh95?=
 =?us-ascii?Q?SK7bLogZFN5FM5yKXGtcd9HkU2wwPYx7G0VyQxFHPDk7/vB3AzwiWaH2rbC4?=
 =?us-ascii?Q?ggJfeHo1QA58y5HLpXnwGNb0YzxOthr42GRkAKhoRpjb38FvIdfEgSsHcV4x?=
 =?us-ascii?Q?eGiM5CzctQ0sV2cNQec9i3zW7eefq0aBoeQQszTaO7+w84hpsTFihluOWWzS?=
 =?us-ascii?Q?P/8Ofu/1MLGs+Y91PSsOHbtG5xQMrpCsH60eGerJkzlHBucpp/7xmjmf42E7?=
 =?us-ascii?Q?GdmXFwBAEOjpf2q2XkCy0EuH/vtbqQ++fDu0vE1uzJ5Fsa+WtVM0OZ+NIkGk?=
 =?us-ascii?Q?rwzpGrtGiz1RdtIDb1MC6wQLygzz0/hMkAHLaxNz1UCZDRpavxq2Pipqegys?=
 =?us-ascii?Q?7rYawOTPQj/ZK4U6aliQwM79GIFjJf2FnbhcsK3x/TW37VBccUcbQ9Yb4JMT?=
 =?us-ascii?Q?S0mSTwqM4IIgSVrwGb+7v1+Vd/vgb+LAY6lU75cfry46o+fajpG1RdPqJ8QS?=
 =?us-ascii?Q?V/R1JUhtbf0dWZ0/w3bPKCuUdftgJxozmmC19CNETFCz4CgkAAJbNN0l2Pnw?=
 =?us-ascii?Q?gruzjz9fIPRHukJsoVpsqfMGGVn9D+Nz7iFxNBb/oJVtZj9cxRHAe8q53WxF?=
 =?us-ascii?Q?p+bT4ixj1yD2htzTCyxJVhzZcBNXXOQKOAvynBBYqs4n5BBepiJ5vugfhh0r?=
 =?us-ascii?Q?wovFvuzs9uOnhFUyvKt96fqxuHlXnw1DEtsfMRQQON2AagrHBUKEdSkcNZVg?=
 =?us-ascii?Q?WDiFJsAapmHR2RZv2HFDgRXVEZbBLgYj4/9qVUPKWo3JAjkdomkscrnHcgh7?=
 =?us-ascii?Q?HLL+nrjREdVW/0IbNjJ0dK/FguwWxxUcln3fpDvqrIpqNEFcIFu6ynp1ccmp?=
 =?us-ascii?Q?xUL2eUQGV9gp+CuDplYSES6jCjFTucvAnAtHSshLG+0a4BjRYReJCoO2TY/Q?=
 =?us-ascii?Q?I1L8MN+LLwGlNXSYZmPXMcAKGtn3xbcWjt96FgpAYCUmNdVN9BWGBdv+YIWE?=
 =?us-ascii?Q?TgF8+rP+qzJ8JKcU1dNEIfQOF2XquTgCAmSxJP2d7emwBMDB/7m5rPee7yi2?=
 =?us-ascii?Q?1MFJw/st2Zehf3hR70El2SVDOG1g5WD6kGU3rLQi2wqIIWrK/iyfBS3kmBIR?=
 =?us-ascii?Q?hsYlNu92hsCHqo1NR205yQct11LxCBxXtESqdUbISdCki8mFM2Sb9XjYKmd6?=
 =?us-ascii?Q?sXCtRvL5GhXyyT4eMv6WnmQRy/Yre9xW6mUjBTCsxI0OnuWc+lJDs9AlTICL?=
 =?us-ascii?Q?lZxEigNp4ObI47I28RP0DEe50geSF5yfmecE4LXLv5Yua5/Tuzkncx/yeLcM?=
 =?us-ascii?Q?9oEogVkOho8zqg1BRT7rGbcpq+VMEL5e+3K1QxJjMFoJhvvoY5Z5YUYo6mWB?=
 =?us-ascii?Q?PFcc64EvJRX817x1XBll2RNcL9i2td6BggZDy20QtzGrSMocRkbzYE5fPdtS?=
 =?us-ascii?Q?tjUdRv7SYKVdEA/Tc0Tz4aDOC+Stobi2xSz/X7TzJ45X1QLAYu98pK0a+4qT?=
 =?us-ascii?Q?UE0f2O/Q1BydUeMJCjHcF8Fhvd7REVV75Z/FN6ZWddKqObgmad3PnoZRKzot?=
 =?us-ascii?Q?sFTIqkgvgM3H5QDM/ZE19ow34LIdU/6qYqBKVJsGxu9k+FZ98mSf3KidkQZs?=
 =?us-ascii?Q?OAhVkuyc0ZICDodLWpwsZC29Hb4QVMq/BGf1qUqE/IYGAcaD4zZivIhBHBH5?=
 =?us-ascii?Q?fRBqXVazZ+oJ3vnZqaeyTb8Qi18SD2mILEnq4LRYDsSeaKuHRtZ5vPw4P26M?=
 =?us-ascii?Q?eL4ocUQBOyNiXCAWChSnHOuyBIO++iQTaupWBkntaig/aipaNaAa?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9a14db8-9f7c-400d-a385-08def88265e8
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 15:00:07.5231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fYTRnHGn2fSN2No66OoGhUo1AbQl3X/70LyNPThvtXXonNZdl+w6jgHmIiaRDILYo18LvTltekJzLOhGbtkQ8yAT3Rst6kT6CkOC4nclWOZVF7LnCWkzaHr7YrWQdVue
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6911

On Wed, Aug 12, 2026 at 11:15:37AM +0900, Koichiro Den wrote:
> On Mon, Aug 10, 2026 at 01:41:59PM -0500, Frank Li wrote:
> > On Tue, Aug 11, 2026 at 01:51:20AM +0900, Koichiro Den wrote:
> > > ntb_transport_setup_qp_mw() can fail while growing a QP's RX entry pool,
> > > but the link worker ignores that error. The worker can then publish a QP
> > > whose memory-window state is only partly initialized, and later work can
> > > use stale or incomplete pointers.
> > >
> > > Set up every QP memory window before publishing the transport link. On
> > > failure, clear the QP pointers before releasing its MW backing and leave
> > > the link down.
> > >
> > > Fixes: a754a8fcaf38 ("NTB: allocate number transport entries depending on size of ring size")
> > > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > > ---
> > >  drivers/ntb/ntb_transport.c | 20 ++++++++++++++++----
> > >  1 file changed, 16 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> > > index f59f926d4bfa..3efc50955253 100644
> > > --- a/drivers/ntb/ntb_transport.c
> > > +++ b/drivers/ntb/ntb_transport.c
> > > @@ -1084,14 +1084,19 @@ static void ntb_transport_link_work(struct work_struct *work)
> > >  			goto out1;
> > >  	}
> > >
> > > -	nt->link_is_up = true;
> > > +	nt->link_is_up = false;
> > > +	for (i = 0; i < nt->qp_count; i++) {
> > > +		rc = ntb_transport_setup_qp_mw(nt, i);
> > > +		if (rc)
> > > +			goto out1;
> > > +		ntb_transport_setup_qp_peer_msi(nt, i);
> > > +	}
> > >
> > > +	/* Publish the link only after every QP has been set up. */
> > > +	nt->link_is_up = true;
> >
> > Not sure if need WRITE_ONCE() or other memory barrier to make sure
> > ntb_transport_setup_qp_mw() and ntb_transport_setup_qp_peer_msi() actually
> > complete before set this flag.
>
> In that sense, I think we need a compiler barrier + WRITE_ONCE to avoid
> use_msi=true <-> nt->link_is_up=true reordering in case dev_info becomes no-op.
>
> But if we want this nt->link_is_up read/write more robust, here I would choose
> smp_store_release(&nt->link_is_up, true), paired with smp_load_acquire() in
> ntb_transport_link_up(), because another CPU can possibly observe
> link_is_up=true there and queue the work.
>
> I'm not sure this compiler or memory barrier issue should be folded into this
> small patch, but if preferred, I'll do so.

It should be seperate patch to fix it.

Frank
>
> Thanks for the review,
> Koichiro
>
> >
> > Frank
> >
> > >  	for (i = 0; i < nt->qp_count; i++) {
> > >  		struct ntb_transport_qp *qp = &nt->qp_vec[i];
> > >
> > > -		ntb_transport_setup_qp_mw(nt, i);
> > > -		ntb_transport_setup_qp_peer_msi(nt, i);
> > > -
> > >  		if (qp->client_ready)
> > >  			schedule_delayed_work(&qp->link_work, 0);
> > >  	}
> > > @@ -1099,6 +1104,13 @@ static void ntb_transport_link_work(struct work_struct *work)
> > >  	return;
> > >
> > >  out1:
> > > +	for (i = 0; i < nt->qp_count; i++) {
> > > +		struct ntb_transport_qp *qp = &nt->qp_vec[i];
> > > +
> > > +		qp->rx_buff = NULL;
> > > +		qp->remote_rx_info = NULL;
> > > +	}
> > > +
> > >  	for (i = 0; i < nt->mw_count; i++)
> > >  		ntb_free_mw(nt, i);
> > >
> > > --
> > > 2.51.0
> > >
