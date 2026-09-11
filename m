Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012007.outbound.protection.outlook.com [52.101.66.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31D937B003
	for <ntb@lists.linux.dev>; Fri, 11 Sep 2026 16:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789144784; cv=fail; b=M1LXw+VAEJMxE5YGpFdQQpvSCNNKTxWZZhCx+FwOthm9IonerEF2yje92Gt2z17ugmSsnr273UCfD95zvC69pnEaAWeqZvT2axDaay9MnbEMN4bumC2XCpj8xYvlcEkFselpm+DVKKiW/JWfALffLxvKBu+MKuHN5KffWPjeV18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789144784; c=relaxed/simple;
	bh=LJCrfGQnZ4S4LH1CSQFA9u6Lm+UA/YPWdVKfFmmpENs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hKfOmp/IULz1aE8SzZ2HAZUDWJmu56gYw1/znGP+nSWN1XJ2WhMgku5dg0mhkVbDPMSBHAMIAQvls6FhI7yAZyJIrV85uunhXn4BVeCe3IKQc2RW49S4laEi1oTq7f3NtyE7ac3IjI6+DEJvDtxL+AlhnQPLpIOf8QqkEywL9JQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=dJ0VgbmY; arc=fail smtp.client-ip=52.101.66.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="dJ0VgbmY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oigNm7B71zV+pjS6wg3xtAv3qAq6Di4SwMX31u7itm2KpyVS9wJbDlT8vqjNd2Xer0pia3cO5zrwBDO+sjbYs5LBleaGghtYzeYME8ENu2A5BLo1nEciCQaUx99Loxxu5QXeufO4XP5bqQxD0nmP5E+nHD//6k/jSKpv9CzE2Nm6rJcT+vJsBNR8fdVQRdVDmi8EDbN13NsigoWwX+JbLni7xAnZQDzf4uKIiuORuusCNPwhWNa93L6aog+kQ4XgC0ehF7a2ULtQSs7ahmVh2e39LblLKRFTmuifKJEI6nQ0M0q3Hx+dadZBePLS1lLXvmYOMIGZpkjLn2ZNmdGqYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TK292hmwFwT1Cj9nWM0aALichiuP6ntdcuhp2R7rqTg=;
 b=f3nTKMHyLo76hG6W2Ql7RKax7bYKeNSNqzd7XEpRCNFRdxquSl94Rsh7AJQUhQx0lREKhlneJ0UMowZCzm7NaBoO2Y0poaBeyL/Xju7BhU6nRM5tmBAIA+VpimFWSDX35oGkZ4m2LHikwuNijH8PhPfVMV/cpuTb5ip+w4TmuAZ7OWNOMoc+Q/TkcoGg5jFa8tIAT3C5eEr7Mq53GsT1Lc32ZmcVVkhpHtrFIpGrCRMR2keXQi/9lZiQSgsMIynq6fJGp1zO98vF9hCADYlnjdpbrsyaSjmpTI6hmnTSzJY/+ZAKe5GsqMS5vktVu8AJ67D1XN3W6hoM03GqMMWG5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TK292hmwFwT1Cj9nWM0aALichiuP6ntdcuhp2R7rqTg=;
 b=dJ0VgbmYK2cB2SaKxacEg8cL8nfVilvMBVXsFa9kMkGC2sI8Es+e9HdgGBwGqm3AFgKLY0J4noBy6XyXunXOl6Wm3K/2fa2gEheN7tQFWGrJvyTIcLPhyouZy0fM9n7XPo+WUO38A5evF9S6Al35yoga+8KUveO1V54etRLF+IaS4SsIbRtim5k0L7nnbelnHhk2JKFRMLzvc4KZYwCEcDBJvi0DZ5FmZw0Hv/mIPVWitofTkaGb6y8sP+LC2kGfPZbF9lPFc027ebwAvRXuDdm9Rtip5Okscczda2JTup5+OUF1UtV0rkUtcg7xoEF58bqUVfb/dJj254hQeKoQKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA4PR04MB8015.eurprd04.prod.outlook.com (2603:10a6:102:c6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 16:39:34 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 16:39:34 +0000
Date: Fri, 11 Sep 2026 11:39:25 -0500
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
Subject: Re: [PATCH v2 04/14] NTB: ntb_transport: Publish link state after QP
 setup
Message-ID: <aqQuvWacR6FSaMvn@SMW015318>
References: <20260910040836.3792333-1-den@valinux.co.jp>
 <20260910040836.3792333-5-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910040836.3792333-5-den@valinux.co.jp>
X-ClientProxiedBy: PH8P221CA0063.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:349::15) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA4PR04MB8015:EE_
X-MS-Office365-Filtering-Correlation-Id: 6447390d-5f01-4702-b70f-08df102342ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|366016|1800799024|376014|7416014|11063799006|4143699003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	tTVi2AbXm6aPgaPAceTteUvs/65PrSeyC2q3BGYIIza5ckMojMECMmO53wcYIAYn35AjGEWNymIXA2CQDpeO0fWdKjC5r66KU14vfU71KWj9VWnhwdTf+YTUUGVpuVzOKlSijQLwgiCMnoLWTFm0cjW4N43sO4ejL7qkvknXAicU/nnt/PhiD8/EtyMd1LCA4Y2NbCLDBNE7WSMy0JtRqwAz7H4SnwZYsv07/z5e1woPeDWTymwGRo0O47jafbTpxvHd1t/PBh8zPvevXzUCAIXoCc7YSLo2Q/lx35RVAW/3B/DvPhDucnRXOqvJIs1Elw/YkyNUdkaIEISFer/9Rlvjs+oJBfvEYE9/79OHV9KYDE0b6Y4k9V656DJpwZHx0zHq4qD+2uJQ1XMS0A+BsfTI5ZfY+cDhf8lU+7KE25yqqsh0FLh8hQxBmcd4l1hE77Cu/0Ka745wiUwumJF4DXENy8lcP+E5l79KqFWoUEqq+M5kvdOvcl8X2MeiCTOfj3qq7TwjBLtscBgfAF9XtvSJc3SGjbXoa2VFhhZ65cWyI3UWrMAQHV8ARW78Goae5K0vuv8ACpk06cZVXf83jai/JyI5Ax6JNBkI6IwXdr203aFw45MFO1Om+B29Dn0QMSSFaWslqxmKM6VS71gXm9ATFy4RIS2FULPyQH7jnRw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(366016)(1800799024)(376014)(7416014)(11063799006)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0IbK1AVXbGRhGz8A1HAcmjX5eUGtO7V7Yd62GRljLUYCmMczscfH6RDRSUKb?=
 =?us-ascii?Q?D+pypryP9T6cxiaP5lfzGoCQp2NrCAEwxL1GE2uM39H0A/FSHWFBe9JIusXd?=
 =?us-ascii?Q?nxovnSN1r0YbVqSlfPfsSopC8BLG0v/NC7XErs39vwC+D9JRFqUf+Oylkozy?=
 =?us-ascii?Q?IOJPoL+MWILhymUP4QjXNONqCGpvsCtVU1uIEv5B3g/lBrYaklAzHAp3nwm0?=
 =?us-ascii?Q?Z/BvriM+lfU+iEYy/bnfcywOQgcctebNrF7x//am4XmpnrqjgkKyg9GcqPz4?=
 =?us-ascii?Q?NoQ7651e3yVZOEudg2/hWYqi3z8dOIiRXyt+wW1P6o+KpmILhqm6agO31j/3?=
 =?us-ascii?Q?yb7qkjW+JrDoCNtETAn90WYXxfy2ZcO9F2mOEmSTJOSx3HXsIB5JiE/5CXVn?=
 =?us-ascii?Q?nuJKQj/RLvFM8z4DoTvFzQDr7HDauu86UDdz6Ud+BxODr9z4bJ7++N2RxcRj?=
 =?us-ascii?Q?flNVfMHEeV3z0D8OC6XjsBxPG0sZkyqA/t2WAe+9OFbi5CLIR/Lfg436rufs?=
 =?us-ascii?Q?2NKLFtFkXDtpl/H3PGvE1DB3YTkZCOm1FHdjqVweFwAL7XFCWSa2jqN6+/GA?=
 =?us-ascii?Q?5Zz9/50Z/Hm4AJXN0vsvA8worBqSoB7xKRJ4k2EevgovWOiJgUihbQWwI8LW?=
 =?us-ascii?Q?21LdrBUdbzeQV93dFe3Oh4X8DOwjs7lETaPm4pmhRewDmEjfiTQmi8824slB?=
 =?us-ascii?Q?VPmnw3t5Vwfizg1lSnY3G17kDcRCP1QybJgizntG1Mx8rD5xQ+0v+sKazky9?=
 =?us-ascii?Q?zmes8IBvVumHjbl9iHuTA2lcd5fB3DUHItNfHy7H9JXoyCu96kHxav6ixRDR?=
 =?us-ascii?Q?XOTTgFGXYwrlC2wIo6n3GhAmBcw5feN03zGmj0w3Npeqcx6RiTJzpb+Mr1Sp?=
 =?us-ascii?Q?OJw1b3NN3t/rxZF1VFWuDla+p90X0/fTjYxl5i8FYmNXIsHoY4BYdgaSDLVj?=
 =?us-ascii?Q?W/zbHyammlIUFE+mROUAZ2JcZjLoX7cMwlWxjfBs47dSgUb96msO32NOQhXL?=
 =?us-ascii?Q?sSYgWL2Giuv5uW7kDGhSurtR9ygUty0B1zCc75n74kptKwlV4BephwSCBwJy?=
 =?us-ascii?Q?OlutaxX+zBDl9Rx0+IQw5SAhqa24wThcYD28v7KU2+IXk9aFb2ox6yFx1J7Z?=
 =?us-ascii?Q?yIGD13mVhqgy290bP5eztwQM7KQ3jNMF8xKsZ1dIginOyrXqKSxhqTJ9DJJi?=
 =?us-ascii?Q?Mkl+8icv67Cc5IrvxobvdoUvFJVPfhzLKYNI/m0okzuupbTMtUqFEc1DHipQ?=
 =?us-ascii?Q?/jRoPlIGF90/SYcD9QS7u8W5WzbupBQJTF+l8ahEXzrij9gpMMbGATofuqFH?=
 =?us-ascii?Q?jpXvrzLh8mQ9F7GzfRNwpNHMYLbSIJ4Vp9XfWwiT1zrIacNGdHu/FO0pnEkx?=
 =?us-ascii?Q?f1YONi6HUYqzVNBC5auipz0YZf2F891i3CehQ41fie/58pt5Dkeb4lO8IJ2G?=
 =?us-ascii?Q?jXTIoFO7qY8IsjIxamPOG+m2lko0xWjEISj2RjU8n3N9MBN1iTWwtrggtqku?=
 =?us-ascii?Q?IaNuSK4g973RtXzJPW8R/nzy0GxCVRXpebqKhjEMjiu9qtOdKaxQQd6jxfPt?=
 =?us-ascii?Q?H6DwhmxB61HUBrnUJF9wQ1o9GPJKwV/nxsUyKuPdBDW5u5l+abBb8zllMky4?=
 =?us-ascii?Q?dC/fXnEo3g7tJ5WxbCq22dXN5V5EYdhwrEJVmljq+//LBCrxT4hTIfMJxKJU?=
 =?us-ascii?Q?/l7hys5fsc7naFj1Mrra3YKYAL/ARMJI7Z5N/pYsNAnHNV8/8zqN4dVq28rx?=
 =?us-ascii?Q?GKGJWN61iJ4aHa4IV3lWEDHYcnXa2NvRceVU0RK/dMHPSEVIDu60?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6447390d-5f01-4702-b70f-08df102342ec
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 16:39:34.5353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +RuQscAbwQw8EUOzMosjs5iFiHs5N2jJDajO1eH/WF/w6tv6cakG1qHIHFC2o7n+I52dLzTc1DUOZ+nvoXoKnmEm4WySx3yMoXORcrMrYBSwifo4bZlK+g7pVuOst2FT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8015

On Thu, Sep 10, 2026 at 01:08:26PM +0900, Koichiro Den wrote:
> ntb_transport_link_work() marks the transport link up before setting
> up the QPs' MW and peer MSI state. A concurrent ntb_transport_link_up()
> can then queue QP link work, which may enable RX and notify the client
> before setup finishes.
>
> Publish link_is_up with a release store after setting up all QPs,
> and use acquire loads before queuing QP link work.
>
> Fixes: fce8a7bb5b4b ("PCI-Express Non-Transparent Bridge Support")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/r/anyKbq3mpLG4y7rb@SMW015318
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes in v2:
>   - No changes.
>
>  drivers/ntb/ntb_transport.c | 40 +++++++++++++++++++++++--------------
>  1 file changed, 25 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index c77b173dca01..75d4a2e021f4 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -922,6 +922,16 @@ static void ntb_qp_link_down_reset(struct ntb_transport_qp *qp)
>  		qp->remote_rx_info->entry = qp->rx_max_entry - 1;
>  }
>
> +static void ntb_transport_schedule_qp_link(struct ntb_transport_qp *qp,
> +					   unsigned long delay)
> +{
> +	struct ntb_transport_ctx *nt = qp->transport;
> +
> +	/* Pair with the link publication in ntb_transport_link_work(). */
> +	if (smp_load_acquire(&nt->link_is_up))
> +		schedule_delayed_work(&qp->link_work, delay);
> +}
> +
>  static void ntb_qp_link_cleanup(struct ntb_transport_qp *qp)
>  {
>  	struct ntb_transport_ctx *nt = qp->transport;
> @@ -941,13 +951,10 @@ static void ntb_qp_link_cleanup_work(struct work_struct *work)
>  	struct ntb_transport_qp *qp = container_of(work,
>  						   struct ntb_transport_qp,
>  						   link_cleanup);
> -	struct ntb_transport_ctx *nt = qp->transport;
>
>  	ntb_qp_link_cleanup(qp);
> -
> -	if (nt->link_is_up)
> -		schedule_delayed_work(&qp->link_work,
> -				      msecs_to_jiffies(NTB_LINK_DOWN_TIMEOUT));
> +	ntb_transport_schedule_qp_link(qp,
> +				       msecs_to_jiffies(NTB_LINK_DOWN_TIMEOUT));
>  }
>
>  static void ntb_qp_link_down(struct ntb_transport_qp *qp)
> @@ -1089,16 +1096,19 @@ static void ntb_transport_link_work(struct work_struct *work)
>  			goto out1;
>  	}
>
> -	nt->link_is_up = true;
> -
>  	for (i = 0; i < nt->qp_count; i++) {
> -		struct ntb_transport_qp *qp = &nt->qp_vec[i];
> -
>  		ntb_transport_setup_qp_mw(nt, i);
>  		ntb_transport_setup_qp_peer_msi(nt, i);
> +	}
> +
> +	/* Publish the link only after every QP has been set up. */
> +	smp_store_release(&nt->link_is_up, true);
> +
> +	for (i = 0; i < nt->qp_count; i++) {
> +		struct ntb_transport_qp *qp = &nt->qp_vec[i];
>
>  		if (qp->client_ready)
> -			schedule_delayed_work(&qp->link_work, 0);
> +			ntb_transport_schedule_qp_link(qp, 0);
>  	}
>
>  	return;
> @@ -1146,9 +1156,10 @@ static void ntb_qp_link_work(struct work_struct *work)
>
>  		if (qp->active)
>  			tasklet_schedule(&qp->rxc_db_work);
> -	} else if (nt->link_is_up)
> -		schedule_delayed_work(&qp->link_work,
> -				      msecs_to_jiffies(NTB_LINK_DOWN_TIMEOUT));
> +	} else {
> +		ntb_transport_schedule_qp_link(qp,
> +					       msecs_to_jiffies(NTB_LINK_DOWN_TIMEOUT));
> +	}
>  }
>
>  static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
> @@ -2392,8 +2403,7 @@ void ntb_transport_link_up(struct ntb_transport_qp *qp)
>
>  	qp->client_ready = true;
>
> -	if (qp->transport->link_is_up)
> -		schedule_delayed_work(&qp->link_work, 0);
> +	ntb_transport_schedule_qp_link(qp, 0);
>  }
>  EXPORT_SYMBOL_GPL(ntb_transport_link_up);
>
> --
> 2.51.0
>
