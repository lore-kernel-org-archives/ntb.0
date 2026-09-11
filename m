Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021081.outbound.protection.outlook.com [40.107.74.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B40468C1F
	for <ntb@lists.linux.dev>; Fri, 11 Sep 2026 17:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789148502; cv=fail; b=l1BNxa7JBjysLQSQJt5LcFOckpDOIAfa4d4BLG2A7VjI5NDRiaqvSe4SJuDdVg5M9S1lhko0qw1NKPdSDAGRs7LyaMg6CJ2psR6EEuOZ6jLvd01AYu31wmsIkLvlt3rHGgWaWSASriwVMCiBNLv3FZB1Ds1qrMC8NBOvf1JC16k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789148502; c=relaxed/simple;
	bh=0pgcApXnG7dPzgli1mxbinpMZwNVwJ8zE0AJ9ELlZ8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CnAPfRKlPRqUQolRlmTZPe/7/KFFIDJoQKiLlNc6TS5CTYOpA6odEwNtgNNaMwCfELn2qRDvPlwvStXEn5OgYeuZrkwwa9JcXbboeKFrlJ3dfaMGgaz9hzo17amIp5jsr/4sm9hWzwktDv5fF1eHTR0F3ErKVuAS+aWaQ9mM8a0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=UzzzHs4g; arc=fail smtp.client-ip=40.107.74.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="UzzzHs4g"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DJIF3vxEDjouKo8cq5Cr2x3/dWdpFNi4pB492dvS0k6qMbfYaewNE2sYHKyo8fT6wXEA7N6GZtpjjBKuS/Gm/JmdP2zbfh1DGzeJKFId2eHSgtOKh2BnGXFqeoPq+dJvd6oqP8fUQjQf+Xj8Z3L4WWQx+eczx1sj6i06KPEXDw/dUEoACJQsNT6I0HXmLChiTastCJccUTJo7F1WRrN2Of2UMenNJPO35QxQYZi2/VbSPqDyCZqNOjA2UAhTe7BonR9ZlNMmZl17dt74KUI6gYiPNpzRJ19FppCAxo+lEm23xk57dzFSeMFhowhQxGMLtSDdU+oP6x0wEUba9LIw7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e9N+U596JvfNlauorbWKZxwNFqY2a823mF1ZCQJXsFM=;
 b=OOK745KZRCeTCcygMB6Ad+C2VPYmocF2g9F+0hwTF8YvAH/znnbVvBhTb0d8yuWF9LNLSjky+G/X7cYDdSPXOZIrnOo7rNWfBI+l5Xp8uXhNiVSi+B2mVMhUOTaMx0gKHrc1Vf+QqUHkMMJqT2721+futUxhyXmU739nDWFZziQyA7tSeFDbs2gt+3f5SJs3PUAUjFT+s4V4ObktqWXDypISNlmxGxcYFpAitxiK1/UbLwjPXjLzrOAON2i/bykAXCDO5GWwZOthSv2lUfxEmE/WXXRSl2TFraQaMoTnvA5fViIvOlpq62+2kgQHrHf/2F+sAxEXid+c/jIka51OQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e9N+U596JvfNlauorbWKZxwNFqY2a823mF1ZCQJXsFM=;
 b=UzzzHs4g0HHq1+GVZ3wJACVk8sKqAgnu3baFXXjZmP6KQCzQ3/gu+rb1lr0eIEXyaGibVuQo/G6YhJ58ZmRoznAs6b90maLIDvxsvJg5lUzUvzw/gB03nYcIo1hNoN8iNu1LC+VrvM2jyU3dfPLSMpSrt4j1QEZQWEj40chRUZ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYWP286MB2542.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:230::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Fri, 11 Sep
 2026 17:41:26 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 17:41:26 +0000
Date: Sat, 12 Sep 2026 02:41:25 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, Frank Li <Frank.Li@kernel.org>, 
	Logan Gunthorpe <logang@deltatee.com>, fuyuanli <fuyuanli0722@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nicholas Bellinger <nab@linux-iscsi.org>, 
	Joey Zhang <joey.zhang@microchip.com>, ntb@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/14] NTB: ntb_transport: Avoid deadlock when
 cancelling link work
Message-ID: <k2dsuf5c6ld7xdovnaavk5semqsujcrfrbihguyoagjtfr3lyu@vka7awtbihpe>
References: <20260910040836.3792333-1-den@valinux.co.jp>
 <20260910040836.3792333-4-den@valinux.co.jp>
 <aqQql6oOVIITjr82@SMW015318>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqQql6oOVIITjr82@SMW015318>
X-ClientProxiedBy: TYCP301CA0041.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::7) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYWP286MB2542:EE_
X-MS-Office365-Filtering-Correlation-Id: afab41a1-ffa3-499e-34bd-08df102be7a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|10070799003|7416014|376014|1800799024|6133799003|4143699003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	XemUuT2KH3sJu63imcFoPBLekQ5tkC5rO+vKoQTYpx4lYb3AUkOJ/iahWkIFocPOfRwfTjMf6KBfz1N5NQS0NZ6+rYfJmDqBWdsh09c5zBITP8Mbsr+XuFwe0i3nouyEsI6cyRJ5Cme/le0zyLHgwrS3r1hcsx9UOhG5EpscF3WJtj957lCjc6YnbISRNEpP2W1ctQ2UsLWXxJTXUXkyf7rkHL0QMgfo2w4uKlTz5HsctGPylI//B8vTs+L3eHkcydXGZL+fu9W24WebYXMi2osxlsgW2xghZzkfYL/DlK+Jn6l8IR/DZBQLC5+eQLTJP5pMA7sszArr7d3UP/JTJyhfd0+qPSuTH73laZkcyW0Fwot/CWFbSjcgyV5ix2YUXRkcbmrk7KkWmS6c0iG1NrHlh/nD8V2boHDLkAfPrkwck1UplsSR1dDb6DBPy8FblJpmu+15FbmdfOvFUjeAwR7J5DNTKf9Xzvjjm9sx7OkqdIj+ONod+7us6MN2E5bhMApxxkqwWu65+Yg1ObzkzOxFWLVEoWeGPlXl6mW6e+GN2AeMx6p7a5tYnTOO8rBE29qryzd4vttvAplEb+/3Fm/HCuneK/tzzuIJFILnZX40PgYauJw6FrSbanslRcaSGROrPB3pKNlMEmpqkQv/scPVkx0FCRkSbkX+mqp7JLA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(10070799003)(7416014)(376014)(1800799024)(6133799003)(4143699003)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IHtAyPf335SWA4eX8upm7PO93bzFlhB3Xzm+m6Eac3FGwUeeGYi8b/EkXM5/?=
 =?us-ascii?Q?P2+Ih3700FA0hGRYjP9EBlRmRtj8iRWcfv/pP+24fMqIWrVSoreqzTBN7MAq?=
 =?us-ascii?Q?rf2OpoVOyTENllIS/bEYDuzKVa7puP2uqcVUWCptbtR3X2+kFDm7tYpa1SNa?=
 =?us-ascii?Q?8OPI5n4fxIYV0cBY5VAAR96UUCzSByRDS6tjMZdXLw4po2klZRu6nEc37yfa?=
 =?us-ascii?Q?J6TXcxreb+hXLW6UZJDPDpXIAaNAbCjYx1gxqdQZ1JvJYRfHn5dCPlM9n/Ms?=
 =?us-ascii?Q?izBYrFV4wViBK1a5M/4IH7Wl3I1YBqOFpbkJPZxpyLomgoZYRQkvO4rcv/5z?=
 =?us-ascii?Q?JNxdDZw4YF1dGe6rYYsj1Mmnik6xj4r0Dk/A99tUfbr5/NL49w2wBEqOUjTw?=
 =?us-ascii?Q?0vVBR69Gc/wSiyVTpUKANryDT+Muqcgg1zUOWuA1gzWbsuV/sPpBUAt0RbCE?=
 =?us-ascii?Q?oTri73Vqa+1KWziy4kq//aFep4AO5PgzFYRdJnvRgt4J+2uJpMShd7UxLJha?=
 =?us-ascii?Q?6xOykp+akjY2Cgs2LTQMTIx3p5XGdzBKmR1Gefo2cuR3yWjTnWxb8kWKfjW5?=
 =?us-ascii?Q?NnFL+dIdVG/IGYcCbRtekyozjmQ7nIHZKyCPEH02wn4d08kHi2cXn7WyXK5+?=
 =?us-ascii?Q?f+BMicqdr/2Hd9QOQLFc5tWiq8usu5JfytWEVgtS6zJcM/4ntMOTEWXexme7?=
 =?us-ascii?Q?SnOejsrFUAdLeu6QrCq2WeNErA0+jzpdjiqV+HXHPEoo6EPWT+jLVa4nGigC?=
 =?us-ascii?Q?pEEey8F91UaHjM0Gs7ReLMlTOupIF86AKHwKqlcLURmudFGHRkXn/JcheP+t?=
 =?us-ascii?Q?BoiKP0rSi3bZFueoYMv9Q6sWOHI5ygdt9I2HfmJjL9zJNMWgqF0aZ9PeSHUn?=
 =?us-ascii?Q?rD9VfyMpiNNm6ZThhME2hf17KWC4B56MLnd8rQF/bMuJXBbdU5Q9N0Sg5I4M?=
 =?us-ascii?Q?nGwkz6r+08mbc7PHvd1PPWRLfDA7XDtFWuYxBFdxoZ1gOm8T7Fm049jV3Hw5?=
 =?us-ascii?Q?aZ5lGCGQTD9IJdBHBo41cdc7xUm5xsZLhoTK33zRFa4yHxzcUvNsM7SPRQbs?=
 =?us-ascii?Q?wckH8ZgLc3kKeQ+ESqs1ycIKm93NhG4rnex+GSL7pEpu9rrFpMZ4RXVfsdB9?=
 =?us-ascii?Q?dyh2uXBLbXMZnUuOcuIsEQ58bi7WOakjRvma88NKzcy8SGSDf2HmBXRT7mf2?=
 =?us-ascii?Q?MzHRmcg+JaMVqtiBbiTmABbJRh9xmBoNKBqK8DjE7UJvLNIDuxWZ0qeXXrO/?=
 =?us-ascii?Q?Yuydn73a+6D4Ab8qL44IqQhyQc6kaZ7/erJnC5nQsY07ro/AEFmrxxXP8f1w?=
 =?us-ascii?Q?wxUWchsmNXPcP+nq7fJtgXe0IKHoU2jm+vSAwDYIMxMhiwdSgiht0euxItvO?=
 =?us-ascii?Q?8t6sdAyrIDNamKxcV9e8L1vfn5CM5zwNf7VcBhJaQYBD0HrHV/slRzzhtQKU?=
 =?us-ascii?Q?1kHdYpZEa8mQv3xYxLbcXt/ZAAR9WILUM4L0d/OuOpSdWfcwOMhKs9ZtEQjI?=
 =?us-ascii?Q?KKUw4PKq6nuM/3LdzqnMhzncNmphC8dbmKbJ6Pg0/fYoFY3RiOwtUMLaf4mc?=
 =?us-ascii?Q?9bk6PXtoNi8kdCu4PQ/3vxBakqjp/aUfwzG5lSD4aGurkB1X1AdE0zjcv/ov?=
 =?us-ascii?Q?FRoQvDnA3yz34yG6ujrI1QjRxYDYhfT3uPWpT1nZ4pBuU6OpZmzL1g4bfTnf?=
 =?us-ascii?Q?n2Rj3ZalbAWV8VpqrZ8Tanyu/s6zDCvgnu3D0LmqfUWEkeGczNfEvQ/M7drf?=
 =?us-ascii?Q?ahbfQcrwhcpKAZWKdSOL17JNP/6UYLyImd6SCG3rgTkekvB16pHH?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: afab41a1-ffa3-499e-34bd-08df102be7a9
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 17:41:26.7052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X80e8iMC+HL+U1NTyIr/gxBgkBCtEr3tdFhPQ7De0qrhzFsj6uWxBFA18YfoSsrSUvjHNHmgd5qD7ByNM7P9vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2542

On Fri, Sep 11, 2026 at 11:21:43AM -0500, Frank Li wrote:
> On Thu, Sep 10, 2026 at 01:08:25PM +0900, Koichiro Den wrote:
> > During initial link setup, ntb_transport_link_work() can retry with
> > nt->link_is_up still false. A retry can block on link_event_lock
> > while cleanup holds it and waits in cancel_delayed_work_sync(),
> > leading to deadlock.
> >
> > Move the conditional cancellation outside link_event_lock, before
> > QP cleanup. Keep QP cleanup and MW release under the lock so link
> > work cannot restart QPs between them. Put the locking in
> > ntb_transport_link_cleanup() to cover both worker and remove paths.
> >
> > Fixes: 3db835dd8f9a ("ntb: Add mutex to make link_event_callback executed linearly.")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> > Changes in v2:
> >   - No changes.
> >
> >  drivers/ntb/ntb_transport.c | 13 +++++++++----
> >  1 file changed, 9 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> > index 55a20ae9a85e..c77b173dca01 100644
> > --- a/drivers/ntb/ntb_transport.c
> > +++ b/drivers/ntb/ntb_transport.c
> > @@ -960,6 +960,15 @@ static void ntb_transport_link_cleanup(struct ntb_transport_ctx *nt)
> >  	struct ntb_transport_qp *qp;
> >  	u64 qp_bitmap_alloc;
> >  	unsigned int i, count;
> > +	bool cancel_link_work;
> > +
> > +	scoped_guard(mutex, &nt->link_event_lock)
> > +		cancel_link_work = !nt->link_is_up;
> > +
> > +	if (cancel_link_work)
> > +		cancel_delayed_work_sync(&nt->link_work);
> 
> what happen if schedule new work here?

Both link_work and link_cleanup can race to take link_event_lock.

- If link_work wins and completes setup, cleanup can tear the link down again.
  The old code also allowed setup to run before a pending cleanup though. In
  that sense, although Sashiko flagged it as a new issue, I believe the ordering
  issue itself is pre-existing.
- If link_cleanup wins, link_work just waits for cleanup to finish before
  starting setup.

This patch fixes the deadlock, not the event ordering. I would prefer to handle
the ordering issue separately.

Best regards,
Koichiro

> 
> Frank
> > +
> > +	guard(mutex)(&nt->link_event_lock);
> >
> >  	qp_bitmap_alloc = nt->qp_bitmap & ~nt->qp_bitmap_free;
> >
> > @@ -972,9 +981,6 @@ static void ntb_transport_link_cleanup(struct ntb_transport_ctx *nt)
> >  			cancel_delayed_work_sync(&qp->link_work);
> >  		}
> >
> > -	if (!nt->link_is_up)
> > -		cancel_delayed_work_sync(&nt->link_work);
> > -
> >  	for (i = 0; i < nt->mw_count; i++)
> >  		ntb_free_mw(nt, i);
> >
> > @@ -992,7 +998,6 @@ static void ntb_transport_link_cleanup_work(struct work_struct *work)
> >  	struct ntb_transport_ctx *nt =
> >  		container_of(work, struct ntb_transport_ctx, link_cleanup);
> >
> > -	guard(mutex)(&nt->link_event_lock);
> >  	ntb_transport_link_cleanup(nt);
> >  }
> >
> > --
> > 2.51.0
> >
