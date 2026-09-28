Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020133.outbound.protection.outlook.com [52.101.229.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0134848A9
	for <ntb@lists.linux.dev>; Mon, 28 Sep 2026 08:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790585485; cv=fail; b=TUFRoSOInpqpWoEqttZL2Q+UERE3utQhFxCxgSA9Y7P9Ol5ZnWhrDZJNOwugNhti6kd2izoGLfPBXEPuysEDdDw9ZgahChOZpi3sXy+uAPAillPKaXTthZURy4oIL+da/5Uzld4jXwRwNd9LcTcmPd86kmcUVz0Ad3abAYgBD5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790585485; c=relaxed/simple;
	bh=l11zCsc+O5w8Faed+sXxnJGwH1Srswx5rvuR+H4WQW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RIJmd9mT0CzeVxZKoDlVtZrD441C5lBLDlb4UqrTS1ndBdVa8RdTC2gBJyixkA2QjxwAxrKbZ5h9npsc6q/1HjG8tbMawk4g6jetKIEIIme7rDy8uovgSSz2T7TEHix1Dn4o4KacjLpIUiU448mJ/N1JGlHjNWj2dJSEn6WjCKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=DCswLbqq; arc=fail smtp.client-ip=52.101.229.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="DCswLbqq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iuJWh444G2IT/cGV1t/g9hZoZVQb6Rgw2Uq/E9KhdeegukIMVcKZuoMHTOvJqVREE1HbakWIUBa8o8N4cAa4fSLYd9ykX8JOhQzWXM5ril9y3rf5vNZ0IU+SN3xQaRRgPznxJQRt2YSrIhqOuWRVbRgV0XxACbcz30CEjygBCujSWprX3nKlwC087t7LXIA/kiLC1/Mb0l5dEqhNAMqcyrHIjF5m1BOpvmi11yTtzl+uhAziGriTXnaISAuGf7g8Knbi4DM/7rpM3pLqiV4IKdt/xUgMfhON0AvTrt/s1lStjAmj7qR+51q368yn9VjFE5GE2j6lFJPZHugVFLjjnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wbrqdBnKXeyfxFaBHcC6DudDb6fKMW1VkQYUfFRTHIM=;
 b=LeDgQiR5jP66PcgFUaiix0DYQ8MG3Po89QfQQ+KGHP16Q1BIn8dqEyiHkwI2SLZg3+/SvVpAr8TrszoclZTRoVWD0p6RQ+4eD2LYh3IeVWZV6d0xU5wtGM5qKc92yhhoJ5QE3uBF52M+WEI9hZjtH3QMOOox0grElcKHeVwflBn8NOOlEeLWCpM8UoJ6loZ7sJeO6Ev8tQMBZiA6zeSA9KKEi/uF+ad4mxIUuu8q5oTQ1RKk2EcxjDhsw3UT88Cs3sJ+TgISMZ88m0XY43/5bE4USkKf3IftMG2TIbtdlqsivjULd4JGVUigJHGLL8zLIu1wa7QMb8Lq0zy5yl45xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wbrqdBnKXeyfxFaBHcC6DudDb6fKMW1VkQYUfFRTHIM=;
 b=DCswLbqqr10AvhXaTEHJNrjMZR5SuV0GlC3+k+797IHBA54GJ/idkbw4rmlMJAfiHj88ayNcorBQewto4PppRX7amBY7xo14tB09FZa6JVSyu223Q4mnGRhktx7xDNzMh3HipkrM/sC3MxoTIP7HGIcmz17b/At8canZ5u3tkfE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OSZP286MB2396.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:15d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 08:51:17 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 08:51:17 +0000
Date: Mon, 28 Sep 2026 17:51:15 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>, 
	Frank Li <Frank.Li@kernel.org>, Logan Gunthorpe <logang@deltatee.com>, 
	fuyuanli <fuyuanli0722@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Nicholas Bellinger <nab@linux-iscsi.org>, Joey Zhang <joey.zhang@microchip.com>, ntb@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 11/14] NTB: ntb_transport: Prepare remote RX info
 accesses for MW teardown
Message-ID: <hkrizcxjisnrkedwzycnkvhxynncgj66oj7crozf5ynuz4ys6c@7i7tixcnt2oa>
References: <20260910040836.3792333-1-den@valinux.co.jp>
 <20260910040836.3792333-12-den@valinux.co.jp>
 <11a47b77-b140-46df-bee6-3484e18ad62e@intel.com>
 <879429f5-b209-49ef-be1c-184eb7d5783b@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <879429f5-b209-49ef-be1c-184eb7d5783b@intel.com>
X-ClientProxiedBy: TY4P301CA0093.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37a::11) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OSZP286MB2396:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bb4b815-3689-4637-8a59-08df1d3da8c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|23010399003|1800799024|10070799003|4143699003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	TPEQZOZJPR7DjBXtrneBEXwlXz7oK0TsdX3PDkBJQT5xjsULPL9DAMYqP7c36ooGP81cqFNow3Uik9lCvNkc7CIxFnhX4YnJ7+GocfXFssJxwgzGkXDtCWyVI21tOkwbncdkcbOF2N9pTiiHOf62ebdkhSKjtcP803uaEDIMvwqkfFT4bJ7BAgrVQiZRgx2ANDMHI2RMgEh3aWWcsqxLZK88GxxTR0l2VVmQuwbU1B9Qv8a5mLN/xreV9mE72MfPfMDUL47A98TuLG3JpqWB83T4ZYd9tN0uxUiTNv0fsIBormG7ZaMpaIzBRliIxZJc24tOIISLcVnowzTQnCXxozf3jEZRYR3VCfVO2qxrmAEFokVZ693JK1vYGSQknfhGFE619gHV8zSDOdJ8kc8wQlkmIAVgqtZq/O+DzCkxQ37wQXYQWHWinRfV+Ls70bj9umDGT/37y2Kqob4J48/RhHv4GMMzDMzunR6KsYKyIVWaw3FdfdbezlPLvaVqBAnBrEqn6e/tvU/F5p+tPD8eBjG8RE4m5hr8Towy9mZGQEO8U80BYpiGH9ZZxk/HCFM0DsAHBao4dCQZPAOsDaqHPQB4sF14YDXiuWho62nEwjizG3E3Sd9NbKxI6Ov29HjGIIgj/WjchVvn/845L1lxctfgsEhgEa+3p6XJAobXPVQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(10070799003)(4143699003)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dXwNH0q9sTSe30vwSHmjHuNZj3NF9Ywn9O2xPi+kPt/vl1z6q3MnPGQ62j2s?=
 =?us-ascii?Q?uk8wYV0oZffj9KKgFgwu26HXzL7yE4hMHZ32l+k1vDcvn9pGuKY7u2aP1UnI?=
 =?us-ascii?Q?cFkRuoLxbJ2S6qPoiW1KofBY7Y4UsZuDV8Jeto6ml86q2Nf/ptgzKhoJQYUG?=
 =?us-ascii?Q?ArFNs1MwSXh4NggedpvfdftrG9yXuz3iZK6tXEzRndJ9BTJfybL6+lsu/du4?=
 =?us-ascii?Q?lHqW7gO7Jzqh7XFz956/7aXdtfzzQ37OyTpI/AmH4QH7+IzSY0nt/a6u+a5T?=
 =?us-ascii?Q?GS+yelbl+nx6n1RrJWjwHk4wjS2aIt6myIbjN4NbbiySGLBLDyxf3Y/2zLAR?=
 =?us-ascii?Q?CMGequqDgO1PI679yeO1gAkbAw5nKdJGx8dMFx1ZjvVuD8KxRL7kSfXjJHds?=
 =?us-ascii?Q?d4otJl6mg5sJbMdl7rDBotdwVEWSnJcVi9LnbQJMLumOKTsPzUrDr+Wei6Yn?=
 =?us-ascii?Q?OTJTXBVSBIbDd/wZkzZoYL1C7vutZfL2/bw2DH+mPms1/2FsSOZJDZ2vvZ40?=
 =?us-ascii?Q?u1aficUynuKHpXG/5DG+JACCdDje8Aehc4aI77RwJrN3nXztqrbAWajMr1NU?=
 =?us-ascii?Q?sDm+Ea0g5NPt0NHLhrIAXfYKu6AvhGlSESy0aDqUJ3W+OL5hWSQRZgVR749C?=
 =?us-ascii?Q?C4Beg2KLp13m0e5pzI9TJ9tUF/XOUGlTguYNTA5VtEEu69Tx6rhgWZQst695?=
 =?us-ascii?Q?+6aIX95o+Eis8BQo4Fvbt+9uTCiBzy/SY71mbrtzpxgNpth9AquCn73kil9I?=
 =?us-ascii?Q?gY4jT7LdoeJJLAU+EGj4IVhegdRMq79sRibmYPlVTltrS65AiZ39pIdgDQ+J?=
 =?us-ascii?Q?oVyD+IicTcddCRkEElmkUM3QyCPJlMYVVLTNeQiYq+NagTTcH8IIiDN8IRle?=
 =?us-ascii?Q?jCtuPm1sq+8li0k6hr4fpuJXS08A7isZo/ZrFWBM7kdmspa8qkx1TMYByrzl?=
 =?us-ascii?Q?XbUsJcUvNzPc4hxyDEsFt5VYMyRvOQdZhAZn1w6yIeBN7LKZxXlp08i3ZNt+?=
 =?us-ascii?Q?a78ceNXOtL2sRbUli0+oVhciNSnQW8FaKUkkTVa/puQaLX0GZpKiNDEU/dQa?=
 =?us-ascii?Q?7PRb6CrilYFDeg/AzsdnZUNIn34Qf4MiP0zEBuMfvr36o1TDnP4L7Umzdi6A?=
 =?us-ascii?Q?WXoN6Ju5oRqk5ye0UCVEQg9gmEoRLvIRoQX56M7NA5v/gDCPWVMUi1lW8e2t?=
 =?us-ascii?Q?Wb6eRHLDzqBIOaVq5mfkV/NF8ym4D7xSFTrQL5KXdBMQrkWf7cvQXbiXtE/R?=
 =?us-ascii?Q?2pzpMIAsOHKaBXQRmJtkKPvC2GFr3zxFXmDRQbdrn1abnMDv6jwxh9eoD6xA?=
 =?us-ascii?Q?6l7UxI98hq/eW4UuoxJDZnUldCJ22vZSF1tzoPKuFLF72CWDGPMCIlfEcM0m?=
 =?us-ascii?Q?9LA8mSalG5FcJhC3FIyU5Z62Ib1sIjLttQdQTp+1RwHbKSep5ePltBPvz0eQ?=
 =?us-ascii?Q?35Bx5YzrO7rmFi2VAYc8Hez+7s/ue9FBoXut7LiJEGJy5HZ+AsIVmmzjU6jp?=
 =?us-ascii?Q?KSXVHA2X32SE6wINVf2LJ4/EWezWefU00qAiE6GuZwZi/Sh6ubUeXtKh2qHT?=
 =?us-ascii?Q?0R9vrP6+hnJWGzfoWTXSrHkJHGNWqvwH8cLoBE00nONUlOR1mAngqjAGSEzn?=
 =?us-ascii?Q?7ploGDvbXoppKcpJPl9i3beIaEB44X32wMF5n859F/oaNkXulTMp4hRb293i?=
 =?us-ascii?Q?PRgDKSI7xcSmQVTbxHhQyFdyMlth/KuWss9MIMl+8+U01OJfB2F/iVQQ+dBm?=
 =?us-ascii?Q?iGTYCe2XJLtReWIQK5oXs5usf0zwJc3Sg4uNikPHM1PFJ6A7qLjF?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bb4b815-3689-4637-8a59-08df1d3da8c7
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 08:51:17.3221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qr1m70oaDsn27IRBJ/QXkGbw/EKjcvZjOW+VQeC46dDQRRDRnZTJyUDHs+fa2I6hm84mspyInCdkPPvL8y1vNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB2396

On Thu, Sep 24, 2026 at 08:57:49AM -0700, Dave Jiang wrote:
> 
> 
> On 9/24/26 8:56 AM, Dave Jiang wrote:
> > 
> > 
> > On 9/9/26 9:08 PM, Koichiro Den wrote:
> >> The next patch clears remote_rx_info when freeing its MW.
> >> ntb_transport_tx_free_entry() and debugfs stats reads can run during
> >> link cleanup, so make them handle a NULL pointer.
> >>
> >> The pointer is accessed locklessly. Use READ_ONCE() and WRITE_ONCE()
> >> to prevent compiler-induced tearing, and retain the read value so
> >> the NULL check and dereference use the same pointer.
> >>
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > 
> > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
> Probably should take a look at the sashiko raised issue.

I looked into it and thought we might as well fix the TX/MW teardown race too.
In fact, with patch 14, transport removal stops netdev TX and its timer before
freeing MWs, but ordinary link-down cleanup doesn't wait for them.
I gave this a try locally, but it all ended up being quite a rework..

So for this series, I'd just drop WARN_ON_ONCE(!ntb_transport_tx_free_entry(qp))
from ntb_async_tx().

The caller already checks for space. Clean-up can clear remote_rx_info before
this second check, which now returns 0 and trips the WARN. The WARN doesn't stop
TX anyway.

This won't fix the existing lifetime race, but it does remove the new warning
Sashiko pointed out. I'd leave the broader fix for separate work. Still,
returning 0 when we see a cleared pointer seems at least better than
dereferencing a stale one.

I'm planning to send v3 with this one-line deletion, but if you have a better
idea, please let me know.

Best regards,
Koichiro

> 
> > 
> >> ---
> >> Changes in v2:
> >>   - No changes.
> >>
> >>  drivers/ntb/ntb_transport.c | 22 +++++++++++++++++-----
> >>  1 file changed, 17 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> >> index 7ccba2c04f54..b949f36a4f2d 100644
> >> --- a/drivers/ntb/ntb_transport.c
> >> +++ b/drivers/ntb/ntb_transport.c
> >> @@ -489,6 +489,7 @@ EXPORT_SYMBOL_GPL(ntb_transport_unregister_client);
> >>  static int ntb_qp_debugfs_stats_show(struct seq_file *s, void *v)
> >>  {
> >>  	struct ntb_transport_qp *qp = s->private;
> >> +	struct ntb_rx_info *remote_rx_info;
> >>  
> >>  	if (!qp || !qp->link_is_up)
> >>  		return 0;
> >> @@ -516,7 +517,9 @@ static int ntb_qp_debugfs_stats_show(struct seq_file *s, void *v)
> >>  	seq_printf(s, "tx_err_no_buf - %llu\n", qp->tx_err_no_buf);
> >>  	seq_printf(s, "tx_mw - \t0x%p\n", qp->tx_mw);
> >>  	seq_printf(s, "tx_index (H) - \t%u\n", qp->tx_index);
> >> -	seq_printf(s, "RRI (T) - \t%u\n", qp->remote_rx_info->entry);
> >> +	remote_rx_info = READ_ONCE(qp->remote_rx_info);
> >> +	if (remote_rx_info)
> >> +		seq_printf(s, "RRI (T) - \t%u\n", remote_rx_info->entry);
> >>  	seq_printf(s, "tx_max_entry - \t%u\n", qp->tx_max_entry);
> >>  	seq_printf(s, "free tx - \t%u\n", ntb_transport_tx_free_entry(qp));
> >>  	seq_putc(s, '\n');
> >> @@ -611,7 +614,7 @@ static int ntb_transport_setup_qp_mw(struct ntb_transport_ctx *nt,
> >>  	qp->rx_buff = mw->virt_addr + rx_size * (qp_num / mw_count);
> >>  	rx_size -= sizeof(struct ntb_rx_info);
> >>  
> >> -	qp->remote_rx_info = qp->rx_buff + rx_size;
> >> +	WRITE_ONCE(qp->remote_rx_info, qp->rx_buff + rx_size);
> >>  
> >>  	/* Due to housekeeping, there must be atleast 2 buffs */
> >>  	qp->rx_max_frame = min(transport_mtu, rx_size / 2);
> >> @@ -934,9 +937,12 @@ static void ntb_qp_link_context_reset(struct ntb_transport_qp *qp)
> >>  
> >>  static void ntb_qp_link_down_reset(struct ntb_transport_qp *qp)
> >>  {
> >> +	struct ntb_rx_info *remote_rx_info;
> >> +
> >>  	ntb_qp_link_context_reset(qp);
> >> -	if (qp->remote_rx_info)
> >> -		qp->remote_rx_info->entry = qp->rx_max_entry - 1;
> >> +	remote_rx_info = READ_ONCE(qp->remote_rx_info);
> >> +	if (remote_rx_info)
> >> +		remote_rx_info->entry = qp->rx_max_entry - 1;
> >>  }
> >>  
> >>  static void ntb_transport_schedule_qp_link(struct ntb_transport_qp *qp,
> >> @@ -2558,8 +2564,14 @@ EXPORT_SYMBOL_GPL(ntb_transport_max_size);
> >>  
> >>  unsigned int ntb_transport_tx_free_entry(struct ntb_transport_qp *qp)
> >>  {
> >> +	struct ntb_rx_info *remote_rx_info = READ_ONCE(qp->remote_rx_info);
> >>  	unsigned int head = qp->tx_index;
> >> -	unsigned int tail = qp->remote_rx_info->entry;
> >> +	unsigned int tail;
> >> +
> >> +	if (!remote_rx_info)
> >> +		return 0;
> >> +
> >> +	tail = remote_rx_info->entry;
> >>  
> >>  	return tail >= head ? tail - head : qp->tx_max_entry + tail - head;
> >>  }
> > 
> 
