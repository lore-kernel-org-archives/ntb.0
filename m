Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020139.outbound.protection.outlook.com [52.101.229.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A0A376A03
	for <ntb@lists.linux.dev>; Sat, 19 Sep 2026 13:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789823175; cv=fail; b=GKb8ACpH2v68NvksT5Xh3ZeMrTQ6DZmqmJ3D40Zq6c9BreMjbB3o9GMX3wJ03+fyvHRnpYPERa2T39hSVKeAJ8v6Cc/0LTIPQtO9V/tSmRYF5gahsle8dhPinY0u5OmGQFOBfCXFhmC2Ty4gnF1zrKaCyEJniAAX4lnnjgPevGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789823175; c=relaxed/simple;
	bh=b//uZ26kSUxFIHdhFUIaMnsixkWPD+rNaPcNqrTC+ys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=T3yR6eZOT6+p+HQW07grccgix5S9fPEmVOhJmaLikCdTHIRm2G5cZLT+6WkReIl0V+nSvUdmIk9bTkdI4YcJaMK/eWZKsgyInBSAARJXasCK7hOfOlZ0EYSdsDI5F0Du+sfu1LwjRWwjbDw8CTSyTtr2Gc52dUMDiKc6tqnnlqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=wvuQqKW2; arc=fail smtp.client-ip=52.101.229.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="wvuQqKW2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M8t1axjkQ1F+6NsyBTEKIkueSI3yeuJAETRfkC1jBApsSiZI/JaAWHJavNbDNyMZPGK52gtZNkaCF+nQR8N5mnbCCSAg5dxtolVT9cFYPhAMY476aICcUnyz2cCjeg1MoGDJkXCF65coCXZQMyyTu2kCu1qfjvCs19lCQ+jUgSQMkkDz1bPCK8DZtOJ0Ia31RGuqN2Y1Hhe+i6A83BnoSrfc5u3W9asB04776KmeZ6OR8qBkKTnQYbdvEhWJo6AVp13BBEx6c3D/fH4isMEzfwInHmWzYdaxncEzCYOeumgWoC+KoenU31aC2SF9bHINmf92ssWOLfPgbx1VN/Y0cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rkICNCTT2/nsRmPJGwbSRv0c3ijJVQCVhi2J3TNm/bY=;
 b=JN+Gtb1/ro782oo93U1LKmSLQaKfb7dJsS7RhM7AF6wKUb2mAWrGRfUuCjhssYMBnhP2TNkrxyNZTCT9cHMzDbYlX6zJ0aChNMDka9h+Lj/NHcQF3iae6uO/C7ylSCzeNn6fd5HQE70BhtSO0FdOgTTqKG0yDY7ytYY44FFQ+JZrDhmKdGAEH753D0XL7ffFJUR1JEggKm7NE1/1222IYgSdVe2VlFfszY5l0k3MfeGwKT/KDzCgFTstl5rZF0WdL3bwXbtgEKMxZrs3HsSMTLz3TtE5t0uuc3RW3evTcm+b25J4wXU3qi4npvMfHELbARyH5hnJKTk2PzgQ/yxtdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rkICNCTT2/nsRmPJGwbSRv0c3ijJVQCVhi2J3TNm/bY=;
 b=wvuQqKW2fIFoHZuRsLUQsswUl0MEfoxssM+eltDBpGIqoZH3N5KY+Y5GmQS+X31I/39qckGsqbu7qM8JjYhI9eLmDZjvQNKpw7fLQUN4nVjbVHZiysVs8cT+9VFNfazORdOw6iCdZAkgNTPU+4rn0bMo4sNkoWckY/yGlDUBEZc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS3P286MB2405.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:156::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Sat, 19 Sep
 2026 13:06:10 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0428.014; Sat, 19 Sep 2026
 13:06:10 +0000
Date: Sat, 19 Sep 2026 22:06:09 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Joe Damato <joe@dama.to>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, ntb@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 02/10] NTB: ntb_transport: Use little-endian
 shared fields
Message-ID: <ji5b44c5mnxugcfpwplajmfucncf32h4j5rd36creeip4ruml3@ls5qzhkwgmem>
References: <20260914084838.2158249-1-den@valinux.co.jp>
 <20260914084838.2158249-3-den@valinux.co.jp>
 <aq3dSqE2euoxQeQr@devvm20253.cco0.facebook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aq3dSqE2euoxQeQr@devvm20253.cco0.facebook.com>
X-ClientProxiedBy: TY4P286CA0072.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36d::11) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OS3P286MB2405:EE_
X-MS-Office365-Filtering-Correlation-Id: ef07b363-64c2-433e-40ff-08df164ec642
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|23010399003|7416014|376014|1800799024|56012099006|4143699003|10067099003|22082099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Pg2zNGcJ8M+o1STQXJL1iadbxJejyssDSPj0jCmESQgt5BUmSofHbJI8L/g+4RcYHo503pd8FHRi1/6wWaj8QUis9nXHWDI1FK3nirwu9XUqgd9MTbD3WmTir8XkD+rm59H08bU2UOtqWZuBuL/lvVhs+CpZZwebASrJ76E7FqbF/I0rLgJhoMTve1SJ4hZTUnaWaU1PrN/3yC4OwLvD+x0NB3tUjiZ9YSAdOaliUW6coUncmkhDC1ZyrGPJ58GZ8hD2gx5sBCorqQAlwUmkRE1u5jo9VLjevrrjoYbjrapwcoEsagNPtAtiFUjui0nvL36u3qcqQdt4tFhRrGkG+2GmRcWOT2HJPNgkXG4osrl17CE3f2etb+eg6mJDotr5vngmK9+iaSdjGg9SsXXraF8t3fptH4Lu6q6td7lg2sg12NxM+UP7EQsk7uGrCkIthxcioL6aV0X70K+50Rj1D3/HH6BUdJasHDODpZb17z3Fz2qhEhmaWhx2dROhEOehoJzEUYuyCRXkkpds9Vir5uxlZn3QI2CifbFDgL6il2vdtc6S2inPEV15vlLZIfUDjBheyuegPOFRB94hunGptchQGnAXfqeF85baXO7vnhH9Y7Brxw6TyP8RK5BHYG8T
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(23010399003)(7416014)(376014)(1800799024)(56012099006)(4143699003)(10067099003)(22082099003)(6133799003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nkbJkLyZPkqmQeY4lj+7ZdcaYFcMjEsXhSstO9y3A3SLI3WQmEiedbopq/4u?=
 =?us-ascii?Q?RgRCYsXicXPoyLNXlPFLVX7/PfwJzSelMQAvKKZX4QsWARvV+KRiO5lrfnHH?=
 =?us-ascii?Q?fLVvnF8yQysQXj4oopbcNf8srIlFEq73kba9+rYJJYRwR5SAdwVfFKECVxyk?=
 =?us-ascii?Q?vBtzNZ0h25LnBVupjJqFs6DOy3/+6UfUIb5yStyUfV1b02dcLHf6YJhEnC7g?=
 =?us-ascii?Q?9+VpnF5nK1SdjdKhb1H8mBfF1YJYsMZAUAF24BITO+6PeMRsF97sTaPQlKsh?=
 =?us-ascii?Q?2T53hcQJWOerQrVaCvVFmTcOYw5eV8bi0qP7t62O6LMVbHRaqhEY4WQan4rZ?=
 =?us-ascii?Q?v91lLEvQZ6nCZ4DMIXvtpB/i4DYjMAQ2QpjIYOQQlMbVvC4I25p3cstQBHGI?=
 =?us-ascii?Q?YYmHjBmDEMziyMI+PIkTTlzgl6KTyLY29/9ZPnz2I2o6sXb3PMRmpGb+7RUw?=
 =?us-ascii?Q?vXUEXA0DrQCEY2MVgZY4/a7kkxV8VtnOsX1a7K+zozzikfzfneH9JM0kBBoh?=
 =?us-ascii?Q?EUQB10QaaOeVg9ZcTchT8SjZUy2zFcYpVXJALpJqxbmV9xvCXiVtyVdsNOLo?=
 =?us-ascii?Q?bDiZGecXv/bMxbVjxnfcNwyCTVQjheaFTpRIuHiDOhY1ezJMilPyGYadLvX+?=
 =?us-ascii?Q?ZjMyGCtfNEwWZQhVQiCwpciMtBVRfJNSzOlzRgB/s8YsoGoBu2C7GnNxm7Cu?=
 =?us-ascii?Q?JTvAuUU3UBMq6puV6mh/obwmXlGR5FggjwS6Cc49W1ph44UULN0GiltnKqtN?=
 =?us-ascii?Q?/Pvupp8lKZbBScDx2KUTcn+DYlNCHavI6ev2r6t5qCCHwOaN18q2xMpMQNZc?=
 =?us-ascii?Q?nQuQmGNv40wQbIFTrECqmETL88rkZN6GqSHPChrptDetJMrk9IKDEA4GLjNJ?=
 =?us-ascii?Q?sR9cTSXoeicbXsxIM78RyqHQuS+VHsLTo2Hz0QM5Fd4vqInaswP/G2DsQ+LT?=
 =?us-ascii?Q?cC3ZVfLddT+vsWrlCFoAWe0ADM8nbTRlRfFi5Gx0K1VbQTIP/fULoxEZcG+q?=
 =?us-ascii?Q?GMQwm4eAWgUiTLN8rMRfEOXbpnIAxb6692/7lrHVspz/tcv7dJUL4Vg2jMRq?=
 =?us-ascii?Q?UNOpniL/9papvsguEpMaihq7/GXtUHeMFpO4TA0hKixl6cBzw+jNnIziZD0O?=
 =?us-ascii?Q?9PtkqpUYcPt0WZDF/eIPQpRi5EDlhb7bz8o1SX/EeViSs8u8tJI89U6B4C0z?=
 =?us-ascii?Q?nueWcPVQZ8CN/QwjbbLhkgZ66OvEsKml1lATqW2TPLKDqCVVNAPWuvmjzQrx?=
 =?us-ascii?Q?gOUB8eoVFdFCoiagQc3JomU7dHtpFl1bQPI8GhHoI9qECb+zSqSJWrn7cznV?=
 =?us-ascii?Q?5vyfgld5h3q3rTrDYQhFYnXYNUPFi/EoxmvNxuPNzv9TDZzBHYHUM9HtbPyO?=
 =?us-ascii?Q?Pt/wwYcuaWLpVhN7jr0VP49iLy6GbwWdeeZH3FootPG9/qfHQARIWXeCz9B7?=
 =?us-ascii?Q?Zh4NSOGWqNasAuYXDIZj83caOX/JF23VjcDYqVvDk0S2IMb5Kx9Cqke2Jj0L?=
 =?us-ascii?Q?QrZIFZfsztiHJ8secr6A0RTP21R7rNX42zmT0JVV68HFEYP8UATYF1EWiPTn?=
 =?us-ascii?Q?lcNlvwVOHfcfvAiuzWxjoTwqunPfd0WhoIT1HZ2nNqR0nY+HpRBC03vVvLFs?=
 =?us-ascii?Q?TOhbWHLnHt+7h9ClT1r0dvFEJYMhhg02rqh2mWEyuWFW3tujj6eSb+4LRPLV?=
 =?us-ascii?Q?GFZeIFEx9Nm0Gem7XKTKzrtQl/RNxRcD2nxBhc6X8vIxB4sq8bxTYMdC56f4?=
 =?us-ascii?Q?4GNvZmv6pURBzjexrfP2suaIDkxpIMuy53nRBD3uH2kIJM2lm+AA?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: ef07b363-64c2-433e-40ff-08df164ec642
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2026 13:06:10.0081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JUNEpMKf4/tl0jetsX/EHrDDrrkN9+RQU7zhNYwAoC4wjV65uXe/Q3kR41TZFDrnj7CM3HnFW9I1gHgOdOox/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB2405

On Fri, Sep 18, 2026 at 05:54:34PM -0700, Joe Damato wrote:
> On Mon, Sep 14, 2026 at 05:48:30PM +0900, Koichiro Den wrote:
> > ntb_transport writes payload headers and the RX ring tail with
> > iowrite32(), but reads peer-written copies from coherent memory as native
> > integers. The values are therefore byte-swapped when read on a big-endian
> > system.
> > 
> > Mark the shared fields as __le32 and convert coherent-memory accesses
> > accordingly. Read hdr->ver and hdr->len once so their checks and later
> > uses see the same values.
> > 
> > Fixes: 74465645cdb4 ("NTB: Fix Sparse Warnings")
> > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > Link: https://lore.kernel.org/r/20260815032932.151F11F000E9@smtp.kernel.org/
> > Link: https://lore.kernel.org/r/20260818064951.7EA231F000E9@smtp.kernel.org/
> > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> > Changes in v4:
> >   - No changes.
> > 
> >  drivers/ntb/ntb_transport.c | 47 +++++++++++++++++++++----------------
> >  1 file changed, 27 insertions(+), 20 deletions(-)
> > 
> > diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> > index 74f4f8c1c7be..3f497a62673f 100644
> > --- a/drivers/ntb/ntb_transport.c
> > +++ b/drivers/ntb/ntb_transport.c
> 
> [...]
> 
> > @@ -514,7 +514,8 @@ static int ntb_qp_debugfs_stats_show(struct seq_file *s, void *v)
> >  	seq_printf(s, "tx_err_no_buf - %llu\n", qp->tx_err_no_buf);
> >  	seq_printf(s, "tx_mw - \t0x%p\n", qp->tx_mw);
> >  	seq_printf(s, "tx_index (H) - \t%u\n", qp->tx_index);
> > -	seq_printf(s, "RRI (T) - \t%u\n", qp->remote_rx_info->entry);
> > +	seq_printf(s, "RRI (T) - \t%u\n",
> > +		   le32_to_cpu(qp->remote_rx_info->entry));
> 
> it looks like the code READ_ONCE's this field below.... is that needed here
> too?

This is only a debugfs snapshot. But using the same helper that you suggested
below makes sense.

> 
> 
> >  	seq_printf(s, "tx_max_entry - \t%u\n", qp->tx_max_entry);
> >  	seq_printf(s, "free tx - \t%u\n", ntb_transport_tx_free_entry(qp));
> >  	seq_putc(s, '\n');
> > @@ -633,7 +634,7 @@ static int ntb_transport_setup_qp_mw(struct ntb_transport_ctx *nt,
> >  		qp->rx_alloc_entry++;
> >  	}
> >  
> > -	qp->remote_rx_info->entry = qp->rx_max_entry - 1;
> > +	qp->remote_rx_info->entry = cpu_to_le32(qp->rx_max_entry - 1);
> 
> you read_once below, do you need a write_once too ?

This initializes the local tail before normal QP operation. The READ_ONCE() in
ntb_transport_tx_free_entry() is for updates from the peer via iowrite32(), not 
this initialization.

> 
> i wonder if the read_once / write_once with endian conversion can be wrapped
> up in a helper or something to simplify? not sure, it might introduce more
> code than really necessary.
> 
> >  	/* setup the hdr offsets with 0's */
> >  	for (i = 0; i < qp->rx_max_entry; i++) {
> > @@ -919,7 +920,7 @@ static void ntb_qp_link_down_reset(struct ntb_transport_qp *qp)
> >  {
> >  	ntb_qp_link_context_reset(qp);
> >  	if (qp->remote_rx_info)
> > -		qp->remote_rx_info->entry = qp->rx_max_entry - 1;
> > +		qp->remote_rx_info->entry = cpu_to_le32(qp->rx_max_entry - 1);
> 
> same as above with the onces ?

Looks like this one deserves more care. Local readers can possibly overlap the
reset, so WRITE_ONCE() would make sense here.

Thanks for spotting this. But simply adding WRITE_ONCE() here wouldn't fix such
a race with late peer writes, though. That would need a separate lifecycle fix.

> 
> >  }
> >  
> >  static void ntb_qp_link_cleanup(struct ntb_transport_qp *qp)
> > @@ -1445,7 +1446,7 @@ static void ntb_complete_rxc(struct ntb_transport_qp *qp)
> >  		if (!(entry->flags & DESC_DONE_FLAG))
> >  			break;
> >  
> > -		entry->rx_hdr->flags = 0;
> > +		entry->rx_hdr->flags = cpu_to_le32(0);
> 
> this looked weird to me but grep says this is a common idiom, so TIL
> cpu_to_le32(0) is a thing.
> 
> [...]
> 
> > @@ -2490,7 +2495,9 @@ EXPORT_SYMBOL_GPL(ntb_transport_max_size);
> >  unsigned int ntb_transport_tx_free_entry(struct ntb_transport_qp *qp)
> >  {
> >  	unsigned int head = qp->tx_index;
> > -	unsigned int tail = qp->remote_rx_info->entry;
> > +	unsigned int tail;
> > +
> > +	tail = le32_to_cpu(READ_ONCE(qp->remote_rx_info->entry));
> 
> see above re: read_once and write_once on this field...

Here READ_ONCE() keeps the comparison and calculation on the same tail value
while the peer updates it. (Perhaps this READ_ONCE() addition should belong in a
separate patch?)

> 
> i didn't really try prototyping anything but seeing this repeated pattern
> makes me wonder if
> 
> static inline u32 ntb_remote_rx_entry(blah)
> {
>   return le32_to_cpu(READ_ONCE(....));
> }

Thanks, this seems reasonable.

Best regards,
Koichiro

> 
> would make the code clearer ... or less clear. not sure.
