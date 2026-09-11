Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013025.outbound.protection.outlook.com [40.107.162.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BEF415B62
	for <ntb@lists.linux.dev>; Fri, 11 Sep 2026 16:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789143210; cv=fail; b=JHwhROW9b5A5azH9wArfoeS7jzI7sbln0CKqkbZAF2Fq4aKAlV0yfvM+/Xnggn1Ohzq5/XXnI6XplQo06oZ7eLt5734LeSXya2v67lRy6IZxM7nONwuYXpW3wYgWpRkvvcy3hN4vPiu2Ib6wTF3/CT2eQ15RWCQvw/pXGtzaovE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789143210; c=relaxed/simple;
	bh=vmcayLzpQGbnfXJCysyMTSAiOOhprxYrm+FpjOkP9yI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Zh6pQCnrQPOJSOh78SNdUlGCW0vYT3OMX35xRm611z0IsPUipYSq4uHgDePJ32gXmmXndtuT4hq2MHYpdJqvAxE6jQua18luEnb4r9uW0B7kGzmDxtwF9cFMpCkRRwSBgvoe31vq5Kk8Uez7cPxFOXZ/h3FhRfE0ZlH1RwKEd6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Hqyxuj/D; arc=fail smtp.client-ip=40.107.162.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Hqyxuj/D"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iAFJdSzyKinSfGxs/h4/2A6B5wyCOdt+V0OLu9nhVavkNz8nltTjCm91IK/huMBBTtSoQqnB/5JnYp0fvWb/iDbZcw1j6Vtbl7SBQcg5Cc0ulYumh2PIQwEPZMwKn0p3hRyWCrDFLvh0SgfjGDTnUJ08rrBSoG6y6sDlIwQk8W17aGtecziM4S9QidRkaQeunhTjkJr3bVvOamQqJqBN/NR3fFwSkqPNIaG5Y+MQRSS7ABUsPjK0shDw8bWDkUK/2Gg2TA8Bv3+mh0WPxUs9215Kub6hiZyO9Nbeo52aA1k2915yZuexzDvig9/vLl4zf0piDJiTZOVC/g0eYOH4ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a484cDhGeKRqjj8usEIZ8utqwbvCO6DLzGCJmj6YS4s=;
 b=j+lI/kHFkU7JwTobzzqzLMaV06FH6tPtLx70r/FZ08a4fnCZERXrkkMqS4YGsi6FVBDsKgZbLN5nJ6Kcl2uvEw++qEBan20fMiXC7qFYlgBRg9i2P9hZX33fOE/md6n1Uvspu1ZIKq/8dbWjKq6rHyZdUIM8RgR9CEVPECqg09NiSO2kk85f/UPTsasL+iKH/d5IbQeXQi5ZuO44Wd0i76ilu6DWlvR/ZouVPFakRcISENb5Rv+ElPACbkSDW8/qskcR3dG2o3NkT8eODH0Gn5EvL+DgHi9CEOdD4XOQ8HezGnbN5lAXAHU8GabEClnzHSwc/Ua0Hy+io5+2COy/+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a484cDhGeKRqjj8usEIZ8utqwbvCO6DLzGCJmj6YS4s=;
 b=Hqyxuj/DSYGj8XuBa7SUyvU+Uf55Knw+bk/x2397tqpj76q4qY5nS3FWYGo9Rli85yPgQJgZV3BCoOmhaREdZPhZgz6J0xD2qCbh2jW0K90rIWXqmSOlZeZEz2Ysm+0gqJ8qToDE6SIetLjv4ivU2wuHtGLts2wfTpbxy3zbbfkedBb27ov+ZeG0RhHA/zm9E2edKqxYrjHfUF+sIyGm/bGmsRoChzDIvDe9t7E29+xpkhnEg6IcKSnAyZZP6qSfyVLbSXY4KZ/Sz9OiQ/wcdJLWbegfK0VuaTbHjrTp/W7Mk0Dd/Amj71nkAJYYnc6oXEMqx4RfZOzCq9UfHML87Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by BR0PR04MB334636.eurprd04.prod.outlook.com (2603:10a6:2c8:30::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 16:13:25 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 16:13:25 +0000
Date: Fri, 11 Sep 2026 11:13:16 -0500
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
Subject: Re: [PATCH v2 02/14] NTB: ntb_transport: Start TX offload thread
 after queue setup
Message-ID: <aqQonN8pQ9HHZqve@SMW015318>
References: <20260910040836.3792333-1-den@valinux.co.jp>
 <20260910040836.3792333-3-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910040836.3792333-3-den@valinux.co.jp>
X-ClientProxiedBy: CY3P220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:930:fb::10) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|BR0PR04MB334636:EE_
X-MS-Office365-Filtering-Correlation-Id: 73e155c9-16e4-4473-876e-08df101f9b8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|19092799006|22082099003|18002099003|56012099006|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	/PNNvch14ecTdWQfgoU7tQFgszArhhxlwJLbKhbKjmQzmK49pCfO3gessXlRg+6mnisiQ+yJ/k2BJ82FHms+tghAGBIyfyiXhkdAWbw6gY0YjqALYhAttj2lKEmI16fx2DNagWAVe6ocjjAkbqo6x/uDFzNDN66Q11N2M9N2tWJehGSOMzzgF/34a2uz5fv5sRlp5Cj7/noVbZnQHsaX6IHjY4xf6t1E9B4Xha7TmzKKUzDgYtISG0pGtQXYnwHzcK4/eImnoOKJPYR6HqFr+So277cVh9/Yu05swv3np4+VrsrfFGkO3fWiaYWF56AMvJmPDeath2GHLxRQPuirE/7sfcLvB0HbNEVcJC+nLu3RRyX4jrfvcDlOVVwMXrvv1461zXWMEOs+QpYgDDrmYIvq9NVgac+cqAkrMSCFxz/hJxY/QAai+S/uDV7cn9DDGHVoS8zfBNGB+kR2ixKbwras7WsmgCePHsA8X6CyFIVckiRq+OTyoBkZic+0BIED/iA5zviPwH1Xj2SG5jEhaBu9P31qOSXgyF+xUmeEdRbxzqf1y+Y4IcxTwnf0DbLVu6sIt4k/7WnaXeKFRI1m4Ykf/QoEXx3cWn3si74rcZr4YQRp6f+AwQrO0c8/3QQU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(19092799006)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zWcbc+KH13xofU0B62wPPSjgYgLOK25sMW0CsSA2Ev5AHnIPWBD6kr6MuX5L?=
 =?us-ascii?Q?bPvOd3hzfuWmTAO5d9HSizE3B9Gel5KbsGmQoqfv2pEtCEVvpWs6AAxrYMT4?=
 =?us-ascii?Q?ZZ7DFm/cVMFnyKp6CxqLNI9HYqa50603DlAdldyypzf0UlPR/xq5dR72w++X?=
 =?us-ascii?Q?Rf7fbpFOqh7xvJRW65GUIjQRKk5Hd0NWp4AlhKTeejNlYmrsrvZTu0jrOo8S?=
 =?us-ascii?Q?YcGZjtPSG4jvsdfwhA4mxa/oiou9BowmCJZGsm9RxTFyr6vA8PeMe59rAG2C?=
 =?us-ascii?Q?m9b+bKPvRmMreJhyx7JHGeVWdkxsuD7XztuY2EPb+JbeY4MqqfdhBqZzePP0?=
 =?us-ascii?Q?fvC1RAUjzDzas0CqdvlGyoaUTK10FPoOkvr+td2JGMB51C03YCMTkC2aWp3G?=
 =?us-ascii?Q?H5yHWAlQi4bqYO0GrUgsURcxCASypDR/2AMh0kyELpgUjIJGQXMvo3Mhi+5R?=
 =?us-ascii?Q?l3KHc7DwdAW4tGZ3ePPCksn0hVZqvhoddmaU1ksLGm1J2k62m9xtW46ZkgJU?=
 =?us-ascii?Q?i2p+XVE4wVXEjFPArO4xeDan7+myTrdEIDJeCCAubel+KccezLPkET5+w6mU?=
 =?us-ascii?Q?Hl4nKzNhTnCs9q3p4YpQPb7ehdvilIfBkTsQdk8Tu5Xg8V9K4sZrkmEQLS47?=
 =?us-ascii?Q?sAOtY23srlzRQZ38CRfAGjACHl9yTfw7nKifjzcaD4nu9qumn24b4xviFA4P?=
 =?us-ascii?Q?zVmG7X2WPRggsldv9wMoTmrLzdv7dKlOlVEbYAezhjjjbWQQvrMPbHvHGVCm?=
 =?us-ascii?Q?seR3cOiiq+O3fpzJEPn2HHyXVTfNw3EZFKACNOzywCPdR+OLatTCBtOT6Ms/?=
 =?us-ascii?Q?ktPvzLY/MCJB5lV2wisgzSSgJrQnr8Fh9M2tLjwYQBG/lG1AqPR42m3a48Xk?=
 =?us-ascii?Q?0h5vJmxtZgUGMJIvdwDi3XOw6Fo/kzIgJwhofyycY5HAdI/WAedrPUoGQfsb?=
 =?us-ascii?Q?zj+tIex8AoyxpIsoFKgubD1MUlxsElU9zzlsPLDc5XHLSjrrOjIprU6ju5Xc?=
 =?us-ascii?Q?m++1pMZGDO91rO6NL8wlJzNGH6TZNhFohThbwIirF7zOTR1wYwFjX/PfjiUo?=
 =?us-ascii?Q?KJC1Gqnwh8ZIVZ2DpAMTx2Fi1B4QZEze99SYC7OL0QAHzSwbjczTBsAZM92z?=
 =?us-ascii?Q?LSbdbraQqjHNwr7h4nYUJ/XxIWm4lBKjjvyF1Waf9brg3s/0eBLH/qXb73dp?=
 =?us-ascii?Q?HyANEblARVLCeLZ4POBskTga9MwDzUkVDum7rH/5V4eHKfYFmKX57Op1Blio?=
 =?us-ascii?Q?afhliczOe2OQ8zQZUD0adWtZ5jHBPFiwsGMuVgyFrCKU8Pf9FVNuLF0EvmWv?=
 =?us-ascii?Q?sO2jtk9Q6zRcvOPTjbMulk/pxcqJxkI9R6+1ex8Va2j8uehvC9w4Khq1YeHy?=
 =?us-ascii?Q?elznp9rA2O671FMF5RD6HSoXkz7wi0o43RSVyjBveEZNbIkjGA4gGu1AdEk2?=
 =?us-ascii?Q?62xWcEFA29+CJttvtWoKMu2ZW0kOCOxkJ+HV/ra/uKdCjNboCPxs+0oO9bii?=
 =?us-ascii?Q?YoE7+rk1Vl7ObOq6TZva3KcKbZ0FYPjoTbHtWI5s9JlTul2qOgYZxlSDhvzt?=
 =?us-ascii?Q?iY8+zk0OqFwjAfnBMXbFbaOraYqdv8HuG75KBQKRr4EVRnyUA9alR8768tCD?=
 =?us-ascii?Q?ejvXM2ZZwhAbgZ89LvAy7vnF8/r1AKZUyUP62WJrDEVm1mB4lvJZOQL4E+1f?=
 =?us-ascii?Q?ru/pL+yY5UEqN5aJ5uPzJVHNvJ9jjltZwlO/D9lnUYhWkWrhtv0dX4qe/Ohy?=
 =?us-ascii?Q?Y1dsfs6SLevHrMTxWBYv8rPs+LlJgVozsi+5CVP5HvFqBd9kcUaF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73e155c9-16e4-4473-876e-08df101f9b8a
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 16:13:25.2798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tPaw3jobYGE7ZuUO/m9mEYIQP95IDh1/4gJeQ5mSWqwaD+Ni9hB/PeOkx15IH0u6tmrG4GOjbEOwuUeUhV1BCLGKUzmkKdOTRHg+DLBrEbveRRs7MIpPZjnCBcZWzIN+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR0PR04MB334636

On Thu, Sep 10, 2026 at 01:08:24PM +0900, Koichiro Den wrote:
> ntb_transport_create_queue() starts the per-QP TX offload thread before
> DMA mappings and queue entries are allocated. If later setup fails, the
> error path returns the QP to the free bitmap without stopping the
> thread. A retry can then reinitialize its waitqueue while the old thread
> is still waiting on it.
>
> Start the thread after queue setup.
>
> Fixes: 322617a06c97 ("NTB: ntb_transport: Add 'tx_memcpy_offload' module option")
> Cc: stable@vger.kernel.org
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes in v2:
>   - No changes.
>
> NOTE: Originally submitted as part of the direct TX/RX series v1:
> https://lore.kernel.org/r/20260810165136.2292436-4-den@valinux.co.jp/
>
>  drivers/ntb/ntb_transport.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 3389d6ca9ebd..55a20ae9a85e 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -2055,20 +2055,6 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
>  	qp->tx_handler = handlers->tx_handler;
>  	qp->event_handler = handlers->event_handler;
>
> -	init_waitqueue_head(&qp->tx_offload_wq);
> -	if (tx_memcpy_offload) {
> -		qp->tx_offload_thread = kthread_run(ntb_tx_memcpy_kthread, qp,
> -						    "ntb-txcpy/%s/%u",
> -						    pci_name(ndev->pdev), qp->qp_num);
> -		if (IS_ERR(qp->tx_offload_thread)) {
> -			dev_warn(&nt->ndev->dev,
> -				 "tx memcpy offload thread creation failed: %ld; falling back to inline copy\n",
> -				 PTR_ERR(qp->tx_offload_thread));
> -			qp->tx_offload_thread = NULL;
> -		}
> -	} else
> -		qp->tx_offload_thread = NULL;
> -
>  	dma_cap_zero(dma_mask);
>  	dma_cap_set(DMA_MEMCPY, dma_mask);
>
> @@ -2129,6 +2115,20 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
>  			     &qp->tx_free_q);
>  	}
>
> +	init_waitqueue_head(&qp->tx_offload_wq);
> +	qp->tx_offload_thread = NULL;
> +	if (tx_memcpy_offload) {
> +		qp->tx_offload_thread = kthread_run(ntb_tx_memcpy_kthread, qp,
> +						    "ntb-txcpy/%s/%u",
> +						    pci_name(ndev->pdev), qp->qp_num);
> +		if (IS_ERR(qp->tx_offload_thread)) {
> +			dev_warn(&nt->ndev->dev,
> +				 "tx memcpy offload thread creation failed: %ld; falling back to inline copy\n",
> +				 PTR_ERR(qp->tx_offload_thread));
> +			qp->tx_offload_thread = NULL;
> +		}
> +	}
> +
>  	ntb_db_clear(qp->ndev, qp_bit);
>  	ntb_db_clear_mask(qp->ndev, qp_bit);
>
> --
> 2.51.0
>
