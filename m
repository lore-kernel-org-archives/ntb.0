Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020110.outbound.protection.outlook.com [52.101.228.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF4F31E857
	for <ntb@lists.linux.dev>; Mon, 28 Sep 2026 05:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790573684; cv=fail; b=L579J4k3OzkBrFSBFX59rruxNRjJjytwgBCitDeUHN72j8S6tN+Cb4gIYmiApqBHcTOfNhv8m/D3NLWlQ+QXpqPd7mv9EeDy0IsQXY9rdt/grQWbJUqJSQumaJtNL4lkSFs7IWe8lEtIKOTlxcx7QUEmoe1XSdv86FQHThZi37U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790573684; c=relaxed/simple;
	bh=NpcF/mLHkGSwY9bBqmina8/4JJOOEI51lEKpg4XZPns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z/KqJpROKfPBOl2xRcY3kslYAQHl3d5tVWaaqgr960fmlHbe2MQzHK0PQDsZYAJE+yqkmN0dkZRWktH6BzXGB81KAqfOlU1QuxiHuHRw0lcAlqgLoZif3KZS+CxOfh53TGaQWGtpMKSXzwh2JRp9V9S4WJ3lOUSahWwBz7JqKZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=b+bvQZke; arc=fail smtp.client-ip=52.101.228.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="b+bvQZke"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WXqi6CBbPo7o67wv74HhXoEB/8R1Md0sQLk52o1DETkFjdQK8ma7VeVCLK1CnSCKRu4sChc47h/s2hoFrrIF/fqBUlYc/vbG4vqElVg/zUZNy3G5nIC1YMqWOscH3foqc9wSQ3TlQEv1M9wuCPs70ITxK2bNpzjyzpJylG3U7JEB4TOfuUdJSD8IqgqkF2fIm8+GkoqSxRgMlSl8ffpT4ezTzZaV2cYZYzNJF4u6HfbqXHYh7Xiczx2YpSDnGJ1j/fr4s3ir2CCVIZv1npO7KKpcRJmFHYUA/QQjHyijek3D1i0vXblfl9JAUuUl1EVWCHpFcoX/5MmrWjh2Q0Jl7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3WNueM1YYPKAecb1AXh5zXnymFltZzj0nEzVfqhyyZ4=;
 b=mMgHyNTCoLpy+8c+pUKBQDCVQ8uSuCtbEOVZRgn7jejdI5KtWjhbY15fuwF88F/dzoJHbCi/HdFXsZ/jQ20AUlDHJXdqGqfRUSndZnb6GBY6Szphk0aeZYHqrRwuenEyW1CqwOaMQ2K8paa32Ig8S7Ukw5EVHmqdzcWBIdpzfGdX3Z7avmku9LkPgVINvkpwFZuQzKBG7q4+I4eDrDNW85TzCm15nx6URtU3+lJbakOiCssvPXeg09eoAd/kVw82eIjm1lf8VxeH23uvFGIp7b10DokBL1FBqd79lICNzA9x9oraSGwpT1w668ZKZCqUOYt8qaAwys0WQprICwlYAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3WNueM1YYPKAecb1AXh5zXnymFltZzj0nEzVfqhyyZ4=;
 b=b+bvQZkejnjTo8A8LJnDydTaVM7m73aDOIcK0juV90Mc0NKeCHgQm51/42X7DMrslE/kC4okFK08iLafPvwuAQUhxZ4F1devmvbAclYy0/KozRHXGvwpJiV3yIZ9mpVCqOw5np1NfcBM68NSnpOqt+a8Bjehvajbwg6DOsE9r/c=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYYP286MB4094.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:154::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 05:34:35 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 05:34:35 +0000
Date: Mon, 28 Sep 2026 14:34:34 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>, 
	Frank Li <Frank.Li@kernel.org>, Logan Gunthorpe <logang@deltatee.com>, 
	fuyuanli <fuyuanli0722@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Nicholas Bellinger <nab@linux-iscsi.org>, Joey Zhang <joey.zhang@microchip.com>, ntb@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/14] NTB: ntb_transport: Drain RX tasklets during
 link cleanup
Message-ID: <ilrlkscx4zmmqtthcgalbcd2tlld5sgmh5dlgeziekesvmnfht@fpjj5r3edy5r>
References: <20260910040836.3792333-1-den@valinux.co.jp>
 <20260910040836.3792333-10-den@valinux.co.jp>
 <6a0db9eb-c1b4-4545-8b12-2dd8326d664b@intel.com>
 <81b16606-4000-4e21-ba32-ab00a471d44f@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81b16606-4000-4e21-ba32-ab00a471d44f@intel.com>
X-ClientProxiedBy: TY4P286CA0098.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:369::6) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYYP286MB4094:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a470054-186c-400a-8c17-08df1d222e78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|10070799003|1800799024|7416014|376014|4143699003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	oUw+RFT0uapq0wsSEJWu2IYU6J51m/Kcy7sQW3RJPA1emRfh9CMhf9TqRN8D7fY9gkcsNrdK6ODKOPoEfegooZrlKwnoMt/B/zQZGOTTSGM1pU9rvBbnkwawzGwBIyu/xV4QxP0M+SZ4chb/kkYYWOxE5zzusjtDmpi2L+G5u5vGtJB+zCtReGfP1aEU9nx34ZVVxlZUU8XjKgdIw70/+LzYrv5sAhLMcPzQvPf1vBOVhZWjSggHpzLKcAP871Nr3y7TYitriiw+2wzaVGnyUzm9CA4EIUl4CtJKblPwAI45SZvpAtOIrC2RGy3wa7BNo+x2FEDygKooj7zWdhqXuCqOxKagIEoXbHc9zoto+kPOlhcMgUuQIg2jVcC4YUJBCGWgMvx3QzEJ7QbJVdJPyfS1k7LW/eO3z8JYp2GDJqxdzlx590CsBQUrG8U3+IxUZqMmRpE1iDQOSTr6Vjac0boaikorlqoLvIkKuzcvR1+CuURSqlEHc7zZAUQTroOuHHkYaYoxcrw7JIQVjIHwhoEueBiiFGWE1N5lQN2env6l3vsp7Ckv70j4jFk6KTRWj+dFcuJX0LgopxOnFJiGofoYAkkUkGn1xOcnmhPSyq1OWpxfyTWapCe2ss/BtrJwJGSGcVrgnErUKjFKB3g4+iOl08buqUaCuxYKwa2du8Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(10070799003)(1800799024)(7416014)(376014)(4143699003)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7gOJYlHOnwhazAISKDn4eV+PRQ/uRfEWrQuki8z660YbR5O9FMbHZsaVJGkU?=
 =?us-ascii?Q?fNG/snXzW1lQrkJADr8/BxXF+91nAI2YDIvIAeD0WG6griUaxcysQW5KD9TD?=
 =?us-ascii?Q?Q/VwJEMC1zSUAb1qHeGySfZ3dTL3dbdt32yPKvtFKAWix3wcnfGDnfAbW7WO?=
 =?us-ascii?Q?ljxUDwMQxEHq0s0gP8jDGrDJJP6PTJtcHYNVxnQOtFveO7fJB+/38YR5JXoB?=
 =?us-ascii?Q?xh2plf8ebpeWZcSHx/k1+7GEWP3pBRZhG2anqBDYkYWCF7Ov3hTB4IQh9Zol?=
 =?us-ascii?Q?4q/3b8SsDys4Lm3clCDH9d8KfmlNbW+3NURXPhLP8+5Zzyds37tT2AoYoLb+?=
 =?us-ascii?Q?rOhqbUQqguRZmIoY6IGhRkfO7yCs7B9DaPngDfppDJKoCTMeSE6rvlTvmHQX?=
 =?us-ascii?Q?MwiFxDGp5l8rImhU30eO+LCSwzbWVyRv9e0yeCZoABVnYkCjkKfvvhsuzFIr?=
 =?us-ascii?Q?KVbXl8bg6M+NYJkpD5WQvbMOHPKEKi1MHyhUvZCpi/rSF5d0f9eqtiNY8C8H?=
 =?us-ascii?Q?YsrXvkokjMzT8ENV3Q23cKToLqCbxOOYUVwrYE+MoY+dOgnGadRyXw6qllF3?=
 =?us-ascii?Q?gbtj0rtcRrwFuLtE4zo9Q6ctoJ1iYd6nmCPosdtiDeAiKks6IaJmkwjR2txp?=
 =?us-ascii?Q?Z4+QgHP1BSofsxshS0c5gqjFeV+TgeGnRliaTvIILJHoqa1L1F8W0jf3Xle0?=
 =?us-ascii?Q?nk9hg2fSaCBbdYVwjv8qMLzqUDxJZG4yp0355G/ddbrGomyaGGeDtjEcSO60?=
 =?us-ascii?Q?z4xWLvSX92oFWPo2POE5Gf9NCVMqCl4XaL38qO9yKH3/KPA86h8Vr47u9xqa?=
 =?us-ascii?Q?YME3XmxbZK4UClVhtolM6A7zHzUglJdU8dvDK9SW1F7TqXPRA/Zec7OPIdRr?=
 =?us-ascii?Q?5j+D+hZVbmQan/WxF+IFhSjiRQVCx3ArfrwUFZMnuNtsSaCvWQwkSsv/sfnV?=
 =?us-ascii?Q?1+csjbT6wp7dCaTn33dPNK31PzyPwwxuDrH/a3V8t7MMACbYNO/VVpKnkbL/?=
 =?us-ascii?Q?QSCYE+IkICT7aJQh1Gh+FCRR0LehipXJrS6lNpAZpqQtxIduYKWcLFN0W5JZ?=
 =?us-ascii?Q?xjxdBqiMo0yXDLJlGpuufILOUTZb0GceBY2lssMIL0kioZ8Byj2ubfL2iPB7?=
 =?us-ascii?Q?TZp4veNcmRGH4ks4Ejh+WY2DqVChXZT5BLkU3zLF8dG621mg6udW416GcjqV?=
 =?us-ascii?Q?wxOnnaZzd5skeTQKrKboenjPon8TfvJPOxt8R+0GxR6SuKw57UYM47cABVIr?=
 =?us-ascii?Q?hRGEIFO4OdvVKjEwyrrdnrbtfnEJzrNq5XDsOQHXbhQp/wsBmRKltZMk0xN7?=
 =?us-ascii?Q?Wb/qPRTai9HUuuMn3j6v8GYnBY4VNDkoTxco3KcsNu8ttvFruMJCOdJc5w9C?=
 =?us-ascii?Q?QRl2fALaauml77LhpsE8Jcb5hR/8MqWgxuJR//weodfECiRkpJXizTA9On4S?=
 =?us-ascii?Q?iRt4/O+kaodE8frmpKEjspruwMO6YlVcnc5oLq3IsygbFW9LQlXuIXc3ORGO?=
 =?us-ascii?Q?H828ZtMRkvpYz+66c5Tb/G3mywfG9HnwjdSMiCyMEU1IzZgPzHFBh6pX+1KQ?=
 =?us-ascii?Q?bVOzweZaCcvLr1fJwqK4A1YKhP2T6Gr7fTtJzWo8ZdgVkHEMcPdbQSkqcXvY?=
 =?us-ascii?Q?vbgaB8uk73Jmukgn9g+FVtsDAp0xNqgrQjixE8rGi4dyE7NtRTqp66mvGdKc?=
 =?us-ascii?Q?o9K3thAEmI0VejHNqEt3ftFJfG+gTJK7jnUuFPJQxzIfeJ8NwFRHr5yqmGtJ?=
 =?us-ascii?Q?6JtjaHshGoixunOBiqfX2W31OmijJEOkZ/IYmxjvpmrtX0ZnuDZJ?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a470054-186c-400a-8c17-08df1d222e78
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 05:34:35.7228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OAW6bKzxgXWJnp/mR2m6vB3o2Dlrbv3OMPXEyRC1Ilvi1BLF1LfW/3eaEXCtLHs8FXeqeYgl6B1WR6mdZwhd5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB4094

On Thu, Sep 24, 2026 at 08:53:35AM -0700, Dave Jiang wrote:
> 
> 
> On 9/24/26 8:51 AM, Dave Jiang wrote:
> > 
> > 
> > On 9/9/26 9:08 PM, Koichiro Den wrote:
> >> ntb_qp_link_cleanup() cancels QP link work but does not wait for the RX
> >> tasklet. The tasklet can still be processing the ring while cleanup
> >> resets the QP, and transport link cleanup can free the MW before the
> >> tasklet finishes.
> >>
> >> Clear active under rx_sched_lock and drain the tasklet before resetting
> >> the QP. Temporarily disable QP link work so a concurrent client link-up
> >> request cannot reactivate RX during cleanup, then re-enable it for the
> >> existing link setup paths.
> >>
> >> This does not drain RX DMA transfers or their completion callbacks.
> > 
> > Is this something that we should handle?
> 
> Ah I see you are handling it in the next patch. I would add a comment to say that is being handled follow on.
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Yes, I'll add a note in v3. Thanks for the review!

Best regards,
Koichiro Den

> 
> > 
> > DJ
> > 
> >>
> >> Fixes: 9143595a7e05 ("NTB: ntb_transport: Free MWs in ntb_transport_link_cleanup()")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> >> ---
> >> Changes in v2:
> >>   - No changes.
> >>
> >>  drivers/ntb/ntb_transport.c | 7 ++++++-
> >>  1 file changed, 6 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> >> index 45d4365becac..36797ea3ff45 100644
> >> --- a/drivers/ntb/ntb_transport.c
> >> +++ b/drivers/ntb/ntb_transport.c
> >> @@ -956,11 +956,16 @@ static void ntb_qp_link_cleanup(struct ntb_transport_qp *qp)
> >>  
> >>  	dev_info(&pdev->dev, "qp %d: Link Cleanup\n", qp->qp_num);
> >>  
> >> -	cancel_delayed_work_sync(&qp->link_work);
> >> +	disable_delayed_work_sync(&qp->link_work);
> >> +	ntb_transport_set_qp_active(qp, false);
> >> +	tasklet_kill(&qp->rxc_db_work);
> >> +
> >>  	ntb_qp_link_down_reset(qp);
> >>  
> >>  	if (qp->event_handler)
> >>  		qp->event_handler(qp->cb_data, qp->link_is_up);
> >> +
> >> +	enable_delayed_work(&qp->link_work);
> >>  }
> >>  
> >>  static void ntb_qp_link_cleanup_work(struct work_struct *work)
> > 
> 
