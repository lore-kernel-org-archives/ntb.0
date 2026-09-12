Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020076.outbound.protection.outlook.com [52.101.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9ED23BD06
	for <ntb@lists.linux.dev>; Sat, 12 Sep 2026 14:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789224754; cv=fail; b=rthfnQKlLqZFzIohU6LhA1arsQAH/fkNfvosMOnmWadugGoKPebTr73TQFIRYRwRredK4MjYQgkJFACx5WU/sTL/Pz13HKqpW3OrKQyb1etu2TU9lq+QNG83e6xitaiAeeVHaAcvoA4Hmg29oB9k2gXBfb/0YNLNhNX5NvgZArQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789224754; c=relaxed/simple;
	bh=9Lz1o0Wf4IubEXSq5eoQbQLacqhKC288FCKoRnVZ25s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nxOt+Nps6Sa6AEVG2JBhFj94c7h3MXJENqjOghgmVqpxw/i5tgKSbtTG2uPVZg2RkcbJFGaZrV4bm/kfwEspPB0oO7KZFqVvcY4iLM5fmWwftUt/syJZ6g0kD8lIh1aN6JbS8ZICCHJt6LBekt21cZ6vp2+xpn5cPkMXbR1VrBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=dSp9Oeaq; arc=fail smtp.client-ip=52.101.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="dSp9Oeaq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cMDns5WyLuwjXVibhr/3QB4QIzuOxKIhFDut+MnPpjPwBm1tKduNikXWOOtEglwamtRQGrl12u3syxUH00VMVTo5bnHBXut1vPz/4zbOMTiMcnwaRsg3WiNVlD64wKlMSZ8rVfuWYoL+6TULwez+4USRkQenPSPsxLBvfsEXGce2mmpiwGmPxvIYZZx3jomtabwyPqCuuTQERMxJuN+6ys/eN7VTgnYNsNw3wBxfRnbvY847juX6jvj6iu8HJk8KlBVEN/LFXVCUeTHP1RbJLF1MlfFHvnv62K3v6OvlYqNkIHqWoUPjdrpvp82tLRdV/+SSvJQ2o6V7qonbxnAO4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fBG5TqE3JlxdZBa5TILKXFvT8bezE10kN8jVN+grVLc=;
 b=IYuzz8AKq4qHIq21OnLXhb01ZAgOD/1zp7dgfJ+AWFHTJtp7/1T6lY13FgSvJnu9XdiQ9+A2L/8GeleKVJH6B0QKil2a1RoDa1Qf0Nl/qgLK6hboRzpHmu7Vcp84m1z12Hlkx4x2Ox5bntqxb9fONyF7zIVfsSJ/Z+tq9nzomgoQdVoRYGC6BQd9Ar9nmrIclXRe6HDjNT+FFAEtxEgmVh6mm49ZbukRZdX+gWzxEOTFhtSOSbgzeC6dWkDWyYiYJIoRtk4M5ztcBYMaIspV7VwUyfeIO5OnLI36TgFoMQIEvdBWAWakeF5oRWqfDPwMJqy1K3QNrjjGlcU61jwavg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fBG5TqE3JlxdZBa5TILKXFvT8bezE10kN8jVN+grVLc=;
 b=dSp9Oeaq6R1ayRQqsUoI1LadDPS+it02qwk5YMPbaLJtWy6gxR7o9wbf6Ygk7nUbRlh2gQ1Ue/HB1L88vZl6EG8bNHwGJAdq0JJs9HICjDEE9qhMYRalwEgvCqrAo37VVMO2EFJm8VUaZ0ADYKkV7bIYHnPMSTHHKCsw3ogfTRw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY7P286MB7233.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:365::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.11; Sat, 12 Sep
 2026 14:52:28 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0406.007; Sat, 12 Sep 2026
 14:52:28 +0000
Date: Sat, 12 Sep 2026 23:52:26 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, Frank Li <Frank.Li@kernel.org>, 
	Logan Gunthorpe <logang@deltatee.com>, fuyuanli <fuyuanli0722@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nicholas Bellinger <nab@linux-iscsi.org>, 
	Joey Zhang <joey.zhang@microchip.com>, ntb@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/14] NTB: ntb_transport: Avoid losing QP link-up
 requests
Message-ID: <i3b4kyeuwyjssav2kne5uhxmltwl2bmug2weyfaujxtrwlkuox@ms6ozb55tmz5>
References: <20260910040836.3792333-1-den@valinux.co.jp>
 <20260910040836.3792333-6-den@valinux.co.jp>
 <aqQyEbLbABhhvFTO@SMW015318>
 <ciucjqvb7qbendlxqdya2wigyivgj4bvqbxtc4cidulr4knq6j@xbwucjdsiayy>
 <l5xf2iuwxgfa4xmtm2l3wn6nce5onfjxxkzfsj627k5xp3snmp@er6fkwlb3sgs>
 <aqTFAi8uo4LwzSj0@SMW015318>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqTFAi8uo4LwzSj0@SMW015318>
X-ClientProxiedBy: TY4P301CA0052.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36b::15) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY7P286MB7233:EE_
X-MS-Office365-Filtering-Correlation-Id: 058ecf66-2327-46e4-ca70-08df10dd76e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|10070799003|23010399003|366016|6133799003|56012099006|4143699003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	4XTZGvgZGtFsa0pvKchjAGsD9XchkOXY//f8p0c6ZtoXgKjenYut4IvmI0EUrhep94xYudZ4xFjWQu1k4gyRAa/1oXSQZq/1+emid6bsdTlNWsbwHo3bD5ZdKmfGsdz3fnP1YHyFAXDeQi5O3DClvJJlR+2PIIXElydVsBkCR2F8o8H4wWPNNxdsUE6xe84608Pl8OaYE4CgB4EZUIEuk1Xu5Y5mHRShFbGhFON17fn//bxmEahobAWwatfmP8o39vf1cQdhv0Pns66dVFzF/lGmC9VlZdM0/gUC2CzGc1BmVtteE2Yc2CkCMiLHX3Cs7o1gOcVQtZ7vMdMqTxGzCd01RvNluQGHbNr7cXClZXZbbwh1KVq57HnQN3fnU6NAgA0oFkFYfOfyi7Y8MCKFY/pJufg3gvipp5xDiL3/sNGBeyl9afAhDp9Wa+MmOeVfw7gVGd7fZStubjG7FOTDQTRD+UJ/x3xrEkWwevzgXTWDs8GNLUDYHyR/dV8G7D46IiwXRoeE9lKIya6FKfMT7pBH5DQoxd70WHJTyQOwrt8I20JzwzoBRc/lsMr528j8f45iUIgLCIOGQduZvnvLzX0ZlFVGhDzhy/NaBTcycY1wgMNWLpVfoNQe8sCmZK7a
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(23010399003)(366016)(6133799003)(56012099006)(4143699003)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MXjJgi+fosjS86m9sYD3lUu8DQhocXl+m6ANlD2uGIfQ3dvJV5rSw/PxZ644?=
 =?us-ascii?Q?Shu2dtDJG7D8+VWx0SBIyVFArai9qNOUiQVTII+x00HU3/uboqDgBae9hvZA?=
 =?us-ascii?Q?EkVV1ImHZeD/+MQyTXWGJaebu2cPo7qjeS3IJJHOkvkha+hjcA6ee19HcOkG?=
 =?us-ascii?Q?wpS4ClIGU0M/pB63tnhirNeX7hit0486FfRDHVTMAWsJgp56eVs80RcBn8n7?=
 =?us-ascii?Q?Z5ZsJBXHGDdAF8JY0jF+ws9llx0IjLkU+zrD7ywNS14LxalYqiFDgo2x321k?=
 =?us-ascii?Q?Yu1VLmJY9VMiz4ITfJ+HJ3gBPRFo6UOrlz9REHJ9zzn9fJWrbWnUBAvn9GW3?=
 =?us-ascii?Q?UZqreaDrku+Se7tynX+/oUDtfOiAKarlXVxxrsHgRE8a9p39eSQyG5HvZx2H?=
 =?us-ascii?Q?JSmt2mRLYpzp3ERwceypcltC9+gSp5FXm0POhXoA7P/Om3pu15JKEzP7J2mi?=
 =?us-ascii?Q?kevbwVGcdFbrmGlKwSxy5f0vrZUhyBap5n+zvLwPfzQ1U4V7b/lhCGwttZg4?=
 =?us-ascii?Q?MPvJj/ujb1/jwGl7Drd24Y720jW5qyRdkvjh7Mxe+19mwcHMcoh7UPpaoTGS?=
 =?us-ascii?Q?4Pjr2Aa7a5DK8oOIqU89Nh4pRHGMcmmhoW+KBlN54jLGVqMeEa4SSgDol/QI?=
 =?us-ascii?Q?2HMdYixv/uUyAwq/Xn4RSnjIJRDotd4XnKI9KAQAAxocj5vhjkY6H1FKorj0?=
 =?us-ascii?Q?GqFQ94NA7q7ZmJ0d1TXvbMIazYIqM37VCcjixLiaMQ012WXiMTsAggckfVHO?=
 =?us-ascii?Q?9mY32RhIF08UXvZNvzo7eVjCIJIsfm/S3GnKEmbqLyoTEhtG8ete+9DZk/p1?=
 =?us-ascii?Q?gbL8DAfkeb8kOQjE4hgYn8hIDz2iUvac3gY7Qw4opGjSyX2iylREUDhfKGmT?=
 =?us-ascii?Q?MOsg8LM46CDX46R8Lh5AjQRF1S7zVr5GaJ1/wHlf9eUsfmZ0OiN82LM8sWSv?=
 =?us-ascii?Q?/mpZ5dImq2AI5CYTiaoILxWC8yV/oO3uA5p0Jyt7QoXJ//EH9h9SAwJFBhJj?=
 =?us-ascii?Q?f/Gu9W8H0G3W97IoqjJ4zxspVbjn1j0ndvHXVe+CQRSU1Zv7iv7O+XBbRuLg?=
 =?us-ascii?Q?yksiwEeOshpAc6tvX69+riGXkKkTprujXZ9w78li0dX+YTvpg3Y5hcOkvUQk?=
 =?us-ascii?Q?yKUsy4bXn2ClTVAeYIFMlUFz6xUzy5WLaWzjOlzzlT5zh1D2O5tPoF+tDDT6?=
 =?us-ascii?Q?tGHxhaPNPcvuEkphjsqumrTreDYzzgLngVYDbcDf8PWf4udZMGMMg/ffAr/i?=
 =?us-ascii?Q?C7Rn2nXb1KqLFszVKaOp/kJxZMS/U+0nCg5/9wY3jiRKhLAyQLEeV3U2vxkM?=
 =?us-ascii?Q?V6CYcJToTTatXASuwoOgwUDx2VFzsWdQPeiMsdGyvY/iFhQdU1XGpsErYyPX?=
 =?us-ascii?Q?NhrMFS4XTz8az/Vkztnzju9LVjoXWAnWyuzuL1gVtMZBjVNo2y9tVuoRz4vi?=
 =?us-ascii?Q?jHiGwiI+4p6zLz6pr5mrP2QsKmHocLAfuGZacXyTfSFZIbWe3cXJ81uh5xJE?=
 =?us-ascii?Q?Guls9scsyc6aB+e7DQ3s2jEck8gsq8clEY99TRFtBxDGhnCRE+EOc4tb+C0c?=
 =?us-ascii?Q?NFqv0qo+VnDt2Tya/uo/H33nBm1VevKayob6m9KpoW2X94P3jfqk0HVyHZ69?=
 =?us-ascii?Q?qwy055hXNj6XBCrzuhQej6AsMJEJQIHG4BY0k9H330pPXSTSkWlj/q5xhLqv?=
 =?us-ascii?Q?TOcI/touSI3vh9gyEe5iaBDE0MZQf+iX232krG9R6nVj8ZuYYj+BkkkuQlRJ?=
 =?us-ascii?Q?/F3EdrUnbiEOReNg+WMle1hKxfYYgaa+QODbWf7ZC75ukOwKCvQH?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 058ecf66-2327-46e4-ca70-08df10dd76e2
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2026 14:52:27.9419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: neZdkzSqtXjuLt7jqPNdsYKuaiBo5P//32rx5OiwI/bGYbjStdVmxF9su7UqV19TBBfk08yEh/p1JhjLaotsHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB7233

On Fri, Sep 11, 2026 at 10:20:34PM -0500, Frank Li wrote:
> On Sat, Sep 12, 2026 at 03:21:08AM +0900, Koichiro Den wrote:
> > On Sat, Sep 12, 2026 at 03:04:21AM +0900, Koichiro Den wrote:
> > > On Fri, Sep 11, 2026 at 11:53:37AM -0500, Frank Li wrote:
> > > > On Thu, Sep 10, 2026 at 01:08:27PM +0900, Koichiro Den wrote:
> > > > > ntb_netdev_open() can call ntb_transport_link_up() while the transport
> > > > > worker is completing setup on another CPU. Concurrent transport setup
> > > > > and a client link-up request can both read the other's flag as false and
> > > > > leave QP link work unqueued. The QP then stays down until another link
> > > > > event or client link-up request.
> > > > >
> > > > > This is the store-buffering pattern described in
> > > > > tools/memory-model/Documentation/recipes.txt ("Store buffering").
> > > > >
> > > > > Add a full barrier between the store and load on each side, and
> > > > > mark the client_ready accesses with READ_ONCE()/WRITE_ONCE().
> > > > >
> > > > > Fixes: fce8a7bb5b4b ("PCI-Express Non-Transparent Bridge Support")
> > > > > Cc: stable@vger.kernel.org
> > > > > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > > > > Link: https://lore.kernel.org/r/20260907144701.702E41F00A3A@smtp.kernel.org/
> > > > > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > > > > ---
> > > > > Changes in v2:
> > > > >   - New patch (Sashiko)
> > > > >
> > > > >  drivers/ntb/ntb_transport.c | 13 +++++++++++--
> > > > >  1 file changed, 11 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> > > > > index 75d4a2e021f4..1332d53bcfe7 100644
> > > > > --- a/drivers/ntb/ntb_transport.c
> > > > > +++ b/drivers/ntb/ntb_transport.c
> > > > > @@ -1104,10 +1104,16 @@ static void ntb_transport_link_work(struct work_struct *work)
> > > > >  	/* Publish the link only after every QP has been set up. */
> > > > >  	smp_store_release(&nt->link_is_up, true);
> > > > >
> > > > > +	/*
> > > > > +	 * Prevent both sides from missing each other's flag. Pairs with
> > > > > +	 * the barrier in ntb_transport_link_up().
> > > > > +	 */
> > > > > +	smp_mb();
> > > > > +
> > > > >  	for (i = 0; i < nt->qp_count; i++) {
> > > > >  		struct ntb_transport_qp *qp = &nt->qp_vec[i];
> > > > >
> > > > > -		if (qp->client_ready)
> > > > > +		if (READ_ONCE(qp->client_ready))
> > > >
> > > > I think it'd better change to use atomic variable for client_ready to avoid
> > > > manual handle smp sync.
> > >
> > > AFAICT converting client_ready to atomic_t and using atomic_set()/atomic_read()
> > > instead of WRITE_ONCE()/READ_ONCE() would not free us from the smp sync, as
> > > those operations are unordered.
> 
> there are acquire version for atomic
> 
> atomic_set_release()
> 
> atomic_read_acquire()
> 
> My key point is use existing higher level sync APIs to avoid consider
> barrier problem, which need more brain cell to think it.
> 
> this is just sync state, which don't impact performance.

I agree with the idea of changing both flags to atomic_t for cleaner code, but
I'm not sure if it frees us from "the smp sync" or the "barrier problem". We'd
still need both smp_mb()s and still have to think about *_release/*_acquire when
revisiting the code and maybe scratching our heads, right?

BTW, I once wondered whether it might be worth consolidating
link_work/link_cleanup into a single state machine worker per transport or QP.
That could simplify synchronization between setup and cleanup, which aren't
really performance-critical, as you say. However, that would possibly require a
larger rework, so for now I've put together this fix series as a small step. I
would be interested to hear what NTB maintainers think about the possibility of
such a rework.

Best regards,
Koichiro

> 
> Frank
> 
> > > So to illustrate this in litmus test like form:
> > >
> > >    # L = nt->link_is_up
> > >    # R = qp->client_ready
> > >    # Both initially false
> > >
> > >    Transport setup                  Client link-up
> > >    ---------------                  --------------
> > >     smp_store_release(&L, true);     WRITE_ONCE(R, true);
> > >     smp_mb(); /* added */            smp_mb(); /* added */
> > >     r0 = READ_ONCE(R);               r1 = smp_load_acquire(&L);
> > >
> > >    Both reads return false?
> > >     Before: allowed
> > >     After:  forbidden
> > >
> > > I might be misunderstanding your suggestion though. If you have something
> > > different in mind, please let me know.
> >
> > Just for the record, smp_store_release/smp_load_acquire depicted above, instead
> > of WRITE_ONCE()/READ_ONCE(), is intentional. They are for MP ordering to publish
> > the QP setup, which is needed by an earlier patch:
> > https://lore.kernel.org/r/20260910040836.3792333-5-den@valinux.co.jp/
> >
> > Best regards,
> > Koichiro
> >
> > >
> > > Thanks for the review.
> > > Koichiro
> > >
> > > >
> > > > Frank
> > > >
> > > > >  			ntb_transport_schedule_qp_link(qp, 0);
> > > > >  	}
> > > > >
> > > > > @@ -2401,7 +2407,10 @@ void ntb_transport_link_up(struct ntb_transport_qp *qp)
> > > > >  	if (!qp)
> > > > >  		return;
> > > > >
> > > > > -	qp->client_ready = true;
> > > > > +	WRITE_ONCE(qp->client_ready, true);
> > > > > +
> > > > > +	/* Pairs with the barrier in ntb_transport_link_work(). */
> > > > > +	smp_mb();
> > > > >
> > > > >  	ntb_transport_schedule_qp_link(qp, 0);
> > > > >  }
> > > > > --
> > > > > 2.51.0
> > > > >
