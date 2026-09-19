Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020138.outbound.protection.outlook.com [52.101.229.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF9D3F12EF
	for <ntb@lists.linux.dev>; Sat, 19 Sep 2026 12:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789822427; cv=fail; b=MKTxdKc8deoN537uNFkvuFYJ/MBuSzNyKV46/YWeB+aiClvmc5WsR6BFqPjBTG9dm7oi/2e/dQ+pHA0AbzxJPHzhf8a4oqjGl9SeJQ+o7WfkSW6isD/BIL4LUAgL1ovjdhhrgMsrFaFTNUofcdcOJLxwW1o8klcVhumYWbtmL3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789822427; c=relaxed/simple;
	bh=DTvvlm13K7FEYVK8XXHFjGsyY4vnTXXYzK8wjWIpkoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RcyNLVqbEvOMttpCCkbBPfp5FJiJs08XjfpW576/aaTd5AIuRLLUmRrcCZUUxdgckN63CjTKtITNdQPP33O28k5qdbJ0brp5gavKHiTjsXrFPh3pHWXJcXFoBbxyUJnWRNn4IFGNGRL32/jKYiM3rcxuNErlo3JmvH+O+5Yswy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=pHPIILjC; arc=fail smtp.client-ip=52.101.229.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="pHPIILjC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rqja18C9cMUD0809LXlmJPPWFBPB7zGYdLXdyHpjiwXoko2wYXW0BKQ6WTri+FKK/WFutzQ/ErH28JQo7+nEtaBCPUyMVDBK4hT62uUNMFe5IuYvSuCtutf1CRCAQJPvMX1EEjMBC5W6lEJI9YrSzAb8Ixxn/cXjbfewHGWSXnvWN5hEusXoJAwQjvwXmYAlQDvvMXFXCpGGbKmoXfN0JtGL1XcoX+dTBgoV+GiuoMFuRc5nG2U0LfJsSVHe+Pxcpwh2y3MjBkhwInomYS6A7BDYT00NVEQNkogU1fJlfS5j/wZOHs8t/WiyY9tIc4WDg+e8nfL97wd4rFZ/eFDhYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8RA5V3k/gF97vMnooWlCDwSpBf8zAFiHh8xSu1/JoY4=;
 b=PuiW59rREUZKq5j9i1X6RRYcH7CIijqmcqgl9FFX4PH+trl0wMk2G0KDLEuzX9AooXkyTDKr7iRKMKc+VNmM1N7xzmYcsbZY1lRNubErubV6Q2+XwksDTztM9U3bsATdC1gy1uhzZ/riF+YrQY3Z8QMazEtQrc4oYzvQKujx6FQ7ouPYHnoI8iiM0/pa8rCe3TCxRU6wQg0trNfLSf+/DnfieESmG1u87xKYj7j5K4oMdxHHBcSdyyyq6/ILqNY0NmbsqQYdiINnlmAeX+15NsS1trzDL9NpKns5DrMRHi2/xagYgpR/o1u2l3/cLIzNl1PSQakHLAY6gEe/L6JkqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8RA5V3k/gF97vMnooWlCDwSpBf8zAFiHh8xSu1/JoY4=;
 b=pHPIILjCQzlvxJvKgP48m5BnOUIWBE8Ybst2Ph8Q0MNtJIqJybemJufBH+krgzYUOwnF0AsSvxhBMXA3KVN/us6CRR7dA7d5ridWEyWuxTyqxQNPuVtKKY8NyCi61fJnrDV5Na2RYwqP/TqcZDP0GMGLTDN3clnxF+FJEyPE8ZI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYWP286MB2971.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2ff::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Sat, 19 Sep
 2026 12:53:43 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0428.014; Sat, 19 Sep 2026
 12:53:42 +0000
Date: Sat, 19 Sep 2026 21:53:41 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Joe Damato <joe@dama.to>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, ntb@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 03/10] NTB: ntb_transport: Order RX entry
 completion
Message-ID: <wecjjkz7m4uk737tymgpk4y3o2a5a2tpkepojyyosgrmonuib6@mtmqftofk2w2>
References: <20260914084838.2158249-1-den@valinux.co.jp>
 <20260914084838.2158249-4-den@valinux.co.jp>
 <aq3hD4D+VfMUd7vq@devvm20253.cco0.facebook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aq3hD4D+VfMUd7vq@devvm20253.cco0.facebook.com>
X-ClientProxiedBy: TYCPR01CA0137.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::13) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYWP286MB2971:EE_
X-MS-Office365-Filtering-Correlation-Id: a0ada99a-efe1-4033-3e01-08df164d08f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|7416014|10070799003|1800799024|4143699003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	x/5PngfzMLczApuOWcGZhGLD9setXtthJreBFkwh6Z78tXTAlrx34yvCkiCY4XEMOy6CikCMnGLBDKSy4lyY3PPKaW9YtCF6OMl5TZvfdW32ejxEvz4De+S1x9aPp40dDHm8WzuGAopA/sGywkRJ9tf4HcknIjFpbCIupAFRsJKCvB2c+hQS/e5JHgdxFn8fQ7q1WBleQTynSDjynpMlNF9d9zeL5ZqnCcRmnsF4xMq63NscwqqpAvYnBvdW3+09z3o/ry97oMQbqzBHNFNp0AyegIX2WHSkQR+MQ2BRSALK9hHYZvJoqWteyDYnW6+XcYRvs0QwHdbOzDgrsvArGrDEZrs/EPPmfwf4JYZsdeUrrOdGh5z+Tv4SdTH1/RHdRvnCSP+PoKGe+/kvWRk9pjF51eYSStV3B6XsP2g14KAkIEYOEhf9J5zjtyoIBynna0PpL7+/sr8e+8Bf13qSnx0MOlMIOm6Cr+84SIQXJ/9R48KxlSfGg5mDMHmyJWElWn3Q9uqvzWTVKGmBm8Jmo7KXklurSkiD4L9D6wlk0AfFkoJ1utNnhm7kWgRF7sGGgV9ulWaqlBc6pyf2kPinqRjdVDYb/Bw+6QQ6LQ9th8zTYfG39U4YgY0M0cw4Ou73
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(10070799003)(1800799024)(4143699003)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J/dRHFGnBqAE+q+pTZYOR+d2Ulk2bJyFnSg06I2kuE/0AXrnlSRhHn5UfFIS?=
 =?us-ascii?Q?R/07Rab2CYB2+n0kGADkSkbRw/TSdLBxv9qrFMNh2SbaP9jYWYg0ve7/oXkG?=
 =?us-ascii?Q?vYPk2gu+shkzKg1kxOCRuQLAfikoKOHlLrBakxLpFhf1xZf0DE7qDME9F0yE?=
 =?us-ascii?Q?gdUSBGpHgWS3aSAhwidOl3SyveOXqNQ45+uqek9Oxs0wydJ7pwj34c4XP20e?=
 =?us-ascii?Q?rTLXBI/35LyoUeMyQe40H2vSxQOVje6F69adQT+FRj2AK7tVzxKCVvBcQ/UZ?=
 =?us-ascii?Q?g69mYpOQ7PY1rjfiJXUqUtbXXxw2p8pCre+K2n36qrSbthTxDaJicdJVlFku?=
 =?us-ascii?Q?usaYW4WOSPZGbvm74CiaFgVljdq3NbXHvABBDxQnkuPOx3JQeqMY7BOY1VCW?=
 =?us-ascii?Q?OSsbyIqJBylAww0VWh6XNIxfma7T8qN3yMqgGn0C5MwaPh22DGPat5mrZ0n7?=
 =?us-ascii?Q?mh3RYf+jg1FYws2Geo/YvUSHWPrxrz87LkDk0smvj3x0cg5s9ww4QgJmwW0k?=
 =?us-ascii?Q?l7TwR3+4+LXsDzmI5FsLSp1DCmGycBbqdigVSQq5dXPeUSPiB5SpEY/ifelH?=
 =?us-ascii?Q?8jpLpOl0Vs46K8PzQ/izn34hq1snRRYivvJNO9OsCXv8xhPcWI9n0RjSWOgB?=
 =?us-ascii?Q?X32mckYZe8ltxdN8bFOXItOU/5V07I7BxXPVXtCT4ENZ0tcxZE8wxeb4kDML?=
 =?us-ascii?Q?tOUWwUW6wZXPy+KexCgRbXRfw9P0CsVKVsBoUzveDKJ8CeCE02KDKdhZhxZk?=
 =?us-ascii?Q?9ByEoXo/V37Rh+3WVWvZL937IMWwIuldZmlRh+hpz5TwKfveLlZW7N7QBEnd?=
 =?us-ascii?Q?jX7XYurebFT3al6F2bVcVxd+ShH8srBoafKT7UA+X/AyNo5h6fDvMfMFQf+S?=
 =?us-ascii?Q?bW2nVZLUqXPpu0qJoriKyZ5iXJf4HxBh6J6gJ+rTu3k34P9/fYhU0WQykBzX?=
 =?us-ascii?Q?ejg5ewuHI8GTrhSxhk0cYK43aMufmoq6LD3DBeb1xYTtq466GH0t2UWFl0Kb?=
 =?us-ascii?Q?thklVBBcbxVojWKV8QXjUgzki8CDKLBL2TX0SEyF8nGAGhyRaEfoxObAv94Q?=
 =?us-ascii?Q?wRFCQuMs5pMyia3ctVYD/GHYt7ERhC7AY14x/XHo+XGMmOOMNnhFrkN41Kr/?=
 =?us-ascii?Q?wUaq7uWue7/LQtgUYwUzviXe5Kgm2SA75tti1i5n5UBdn0yoWzfU6pR3DU5s?=
 =?us-ascii?Q?qxW4OmvOyDnnd3JKPiCQi8Vn22jTlcEWeA69004eUPldN6TaECXkmhndDv1x?=
 =?us-ascii?Q?Sh4bbjjFCozTiSsDmqzxZ9lWIi1C5bpJR8rd1wCk9bjuXRyXMzo30EMQruFX?=
 =?us-ascii?Q?BE7KUF0ZdK9jhzz/xPqXMmftbxPa6/xrmfXC0HhFcMhwNr5ahXvM/S3NlhDr?=
 =?us-ascii?Q?9HAzsafRUGuIFX8zbfL4fsZB3JCNMFczaWe4+HMW4g5YsmORYAjD3CIAugkG?=
 =?us-ascii?Q?5C183xnfCmuu58OIRUObb8SbyPXDzcDVEViRXJJu8gSCXz8592f9B/2HqxHQ?=
 =?us-ascii?Q?1TpiSVO/L7klwizieXPW6sWVVO+slxPED9f6dAYsvTqFPWr77OISfhksN4/4?=
 =?us-ascii?Q?u1Q5lGuvDtWxBXUNxMHTrP0WKGMguYZUiL+pz5OOExRfAH4GwIIAgT5mBwsj?=
 =?us-ascii?Q?RZt+W/MY92EAh/o4sSFxdqx87UBrdTtqq8lajQHgLDybAD/4gdP66OU0NLuk?=
 =?us-ascii?Q?9RZAHibzMKv7ikhUcHS3Vsr3lOsrugRUzVwuZPCTZHaNwacKtIlrbO8tI7rc?=
 =?us-ascii?Q?lI4KOk8SlWR/DNUNn2N07+cEQ18sjEvTcNpWu5WbzcW1oEjvJI9e?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: a0ada99a-efe1-4033-3e01-08df164d08f3
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2026 12:53:42.8927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cNcJ9xTMerVwuKPOoCZM8jX+YS7CKx7KEbXiOX199tURlaVq9gbCc0LrLpiI6zIvk8SCgC5+yrX/+kThnqzstQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2971

On Fri, Sep 18, 2026 at 06:10:39PM -0700, Joe Damato wrote:
> On Mon, Sep 14, 2026 at 05:48:31PM +0900, Koichiro Den wrote:
> > RX entries are added to rx_post_q before their fields are filled in.
> > The overflow path sets DONE without a write barrier, and
> > ntb_complete_rxc() has no read barrier after checking DONE. A concurrent
> > completion can therefore consume stale entry fields.
> > 
> > Publish DONE with release ordering and check it with acquire ordering in
> > ntb_complete_rxc(). Use the same publication rule in the copy callback.
> > 
> > Fixes: da2e5ae56164 ("NTB: Fix ntb_transport out-of-order RX update")
> > Cc: stable@vger.kernel.org
> > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260904052134.2970111-1-den%40valinux.co.jp?part=3
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> > Changes in v4:
> >   - New patch (Sashiko)
> > 
> >  drivers/ntb/ntb_transport.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> > index 3f497a62673f..b69e8ac8047d 100644
> > --- a/drivers/ntb/ntb_transport.c
> > +++ b/drivers/ntb/ntb_transport.c
> 
> [...]
> 
> > -	entry->flags |= DESC_DONE_FLAG;
> > +	/* Pair with the acquire load in ntb_complete_rxc(). */
> > +	smp_store_release(&entry->flags, entry->flags | DESC_DONE_FLAG);
>                                           ^^^^^^^^^^^
> 
> 
> >  
> >  	ntb_complete_rxc(entry->qp);
> >  }
> > @@ -1664,7 +1666,8 @@ static int ntb_process_rxc(struct ntb_transport_qp *qp)
> >  		qp->rx_err_oflow++;
> >  
> >  		entry->len = -EIO;
> > -		entry->flags |= DESC_DONE_FLAG;
> > +		/* Pair with the acquire load in ntb_complete_rxc(). */
> > +		smp_store_release(&entry->flags, entry->flags | DESC_DONE_FLAG);
>                                                  ^^^^^^^^^^^^
> 
> are these two smp_store_release lines right? i am asking because it looks like
> they do a load ? i honestly have no idea if there is a race here but it looks
> sus to me

There are no concurrent writers to entry->flags here, so I think the plain load
on the right hand side is fine.

Best regards,
Koichiro
