Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010050.outbound.protection.outlook.com [52.101.228.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895861367
	for <ntb@lists.linux.dev>; Tue,  4 Nov 2025 00:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762216388; cv=fail; b=ihi5tSKKe6brG0VJdJuwAN4/Uxlh5ynFwXYNTvMKPIOErKwPDzId/A43F6rLtX6Zq6rMgRwa7kic/Yu3Ri6yv94fXNiLCoEMftLTaMCi0RQpD4sCQrZXDR+AEKTYDIciD/pu28oyg2QRNpAd91eahyyxCJipzHUp7A9UM/zo2FA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762216388; c=relaxed/simple;
	bh=IzRxvHMhIgoZDF4hm9XsNj+deyJtacPjjFXf1CnLkfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XRuSgHN8O7VC/xT/z6dMCkn2O29EelzLlcFf7qdN8oNd7xkkk+U0e2vhyCNsziNPiNLOnOmGj6M6C3DqJS0O9Jw3zzN7Tiut2Uw2pESuV2zAv6pLGYLZXYfI3/FPYXpysxgORndlLWSYQi1sGC+Z2fYk4a6c+MJPW8bUfNocaPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=FW0tBDlZ; arc=fail smtp.client-ip=52.101.228.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="FW0tBDlZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PrtxdSirA+sNLrpuXwAwznvKfeQcRK5EbNXcACr6lMiMN+46NCgSlX2BuUsLyjr5V3St7iHsmZWDu52dKhdjeQDPGTjbEPWvjh/CjnJLAqQvvVUXm58Vr8ydZCIcnD0z0H27egRQmLUpqGE8UL9LBuurXaMPgZjZlX/7HtNs0i54nbnWQtEY02faYIhtdcO08DbTyUaNNPw7phCsGCwbhaRN7LiYuV6NDJNrSyuFB6h+BNDZlLaGhEABtmo0nAQmVCfOnaioTm4pk0Lo8qZkh/L0Rz63ZXfD2i2GOiQq7eAw8dqVm9/7/M5vT6PxXPgyAal+HmuAhe3kvX4fVpfTqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RxepLvkohRLuxzdQPDaya6pzj3rk2j/IHayIvlIs2lU=;
 b=iBAjbREH0KNJwbuYFXWmIEhsRCeANlSSxuoIYLfAW1AwW3HiiXqSQ+CV6+MbF6iyETXQr9rJtMA28OUJvL1tTEY3HdSlVEw4hNKsovzGCwfjz7qaRzjp8IQnO0/MYTjlWjCRLR47ZySj4JmPcZQz3bFAGP05nUEarzHe81iVtPS8x01WX92V4NfOhntRBQ/7nLtXsnMEIj54I4mkseTaigZ5/r5R5HQXLWlXUpJmXuylCbudQLWpFVe2WZfcfC4RFMscYJXHIqQ3LJWUYieHhLLsEg8Vd/V8Vf4JfsxcAl/0LGg3jCd55UatfbDcP1PA5R16luKpU2kYPRM6fmbtaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RxepLvkohRLuxzdQPDaya6pzj3rk2j/IHayIvlIs2lU=;
 b=FW0tBDlZg6sla9OPoeTgwKswvOh/Vkr2KveGF+6yj9VNHToUqyhtjjWf8nk2epodNhjwni9GU4+To1PpowTo8v8pVcZZqIRNdy66WbTrLUXAfr3RTYx1Jv8cBOVzgQjvP2PLJk2wTh74+S6NwQ+Ypm9zOGNdAXVe1B47BKWzul8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:10d::7)
 by TY1P286MB3373.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2e2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Tue, 4 Nov
 2025 00:33:02 +0000
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a]) by OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a%5]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 00:33:01 +0000
Date: Tue, 4 Nov 2025 09:32:59 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Baruch Siach <baruch@tkos.co.il>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, ntb@lists.linux.dev
Subject: Re: [PATCH] NTB: ntb_transport: fix use after free
Message-ID: <y23vpg5ynutkwck3w6wynsy47yovpqywil2jqk4omg63qdocjb@xkcvg6h3jy2d>
References: <c4727cd0bdeb8385b893da59c5eb97a189bf4282.1762190599.git.baruch@tkos.co.il>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4727cd0bdeb8385b893da59c5eb97a189bf4282.1762190599.git.baruch@tkos.co.il>
X-ClientProxiedBy: TYCP286CA0206.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::14) To OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:10d::7)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB0979:EE_|TY1P286MB3373:EE_
X-MS-Office365-Filtering-Correlation-Id: 8afed956-3bf9-4734-669d-08de1b39b5db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CWUBzPhr4JpirBeJGUMNS3zVYIqCg27rIOhtyMWGaQ6BeHARnWQ68LzqncQR?=
 =?us-ascii?Q?jB8GeWmV9DfmhLVZcrnYBDA0av55PtmBcMypdF/IyHsZUeGmhjIhJbFobIXt?=
 =?us-ascii?Q?dhtFDE1hfCMIzXv1hhDt2i+pf1XxSXnGP+5oHaabtQN5NRtT7e1brHfaECkU?=
 =?us-ascii?Q?3Vd4YzVMEC7IIXbHbKra9PVtvbQh9LE2EtpFHyIpoT+f+Et3MSR2266YWHOy?=
 =?us-ascii?Q?oPJJEJfom0Tf1m/wtSP9ra9TmyJ8PnoHN/mRRi8EBPFu9HNYiAdNEdDjpBQO?=
 =?us-ascii?Q?ohxY5yObPcV2B6k7YCEu/YcPSnB5Iggc+wd9HQJvlBUfHVwBOMtYxQx0/Xj6?=
 =?us-ascii?Q?Bp0tPcHhQdph6cubWDuzMqgu2xuJyqloKZvTkHPVZPO0N7/rb6+EWu30bRs0?=
 =?us-ascii?Q?yILyVt9f4YRk3UtcKsMNxE7ydJwIMaqi3zpJ94C5xitQILLeY7+YzQLDeJsG?=
 =?us-ascii?Q?OyFYc+2FxjOZJV5GVwsOIBgNWISoD2oFaC/lS0+S819GFKd+QA21xVzu+QlD?=
 =?us-ascii?Q?pBPFtpJPVchmAKdmL1zxgXtJHaAMfzN43/nFAMSKCOXCQm62XW7f8Aum5emC?=
 =?us-ascii?Q?X6siEzKyJ4HhlgPDf6sgoERZOBl4y1C2b1NeaNNyKf1GcluUl9xaQqAu5XP+?=
 =?us-ascii?Q?F9w9hAWE+WfqsEP4/IVTC/B3w2iXS+NFVuLH6c4XPDfPdsefTQEo9rE+FwAT?=
 =?us-ascii?Q?Tl/SA/sNav5G3AY6fqKHrfrw7O5hqITSm4V6TMlv8qCkukPm2L/hmUOsvDje?=
 =?us-ascii?Q?ckpyhnT0kjJ6kO3qqOyaUW/aN8YqqMTSRa6Jf6ROsA8Ci25qDA1+pM75rpDS?=
 =?us-ascii?Q?Twf0y2nnr3MRCE5t3sw4bRddy1dzeMCRDKK773huOU+H2LZDvg07A4+bH8Ow?=
 =?us-ascii?Q?+KFDp05SXb43kPIEC0iIQAD5BV1W7gBNy5a4Ks+OzflRdRLtyNeBqLWCz1q5?=
 =?us-ascii?Q?Vr/keemm+M3S/aevOB7PZftp0pVFtW4tCh9VPhWWBo3uL4s5Qojjgj3ipAD7?=
 =?us-ascii?Q?s4AbsbVdZT9FJu7p7frRT1DFFiR44yluRzzzF7TJD8vES8upUWeFSA3Hl7Vv?=
 =?us-ascii?Q?rJeDC/6HFwhvUj9J8cyDRHBYoN4uBqv6tYkiwaXOA3a1LkaLuD/PynI33M0E?=
 =?us-ascii?Q?HRyPOkp1AAoztTpPb9glOeTifLoLy+LNiyKPplOjpnUMxi37bdKP4SS5RZqi?=
 =?us-ascii?Q?YMIsvRQbvmGqY+Vn/3O3jCpslOhzQ2xSid0EAxxamHWyzJXY1CWxJNtRh8r9?=
 =?us-ascii?Q?lJVxNDC43anORtU/irhS2U4YMldraoUQPpV+laerG3F7DBmawHTsV4A07C6c?=
 =?us-ascii?Q?qRawto6Xtc4Zm9xBzygZbLn+i38JGXst7ACGhamLPEjrxN4KA8TMAkF3iqk8?=
 =?us-ascii?Q?0w581Sl3gSZjt0JCNkdwahvCHPb9dlLBFpStmPg9SIKm8+niURGlHBMF9Fqw?=
 =?us-ascii?Q?Afnm3TBKsfxCoBJtoEU/ED0Gqo9ppKnU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?scFFSSoxDysmY+CtC2XdfzM01nf/JRmN+tHlQmpHkNSkm9+BpeGBEXqN8mwh?=
 =?us-ascii?Q?XUVtv84gieM2tvto2ZCJxHJndexyGYqeVrTpw4OBK5gBKDIALy3PuEWdsmoK?=
 =?us-ascii?Q?xhNC/py6AFYxhtTKGfctC/vCmzv2xF/uNI7FjcjcSyqw4dB4P1/01n2TokHE?=
 =?us-ascii?Q?k5ljYfu/4TZ3knBV5UsblxdB5Xqh/PMwKppus4sEC+zchCySAhveGGzwN99R?=
 =?us-ascii?Q?FihCvdyLzRPOqMZ3yIQb/t76FOktkBGSOMpWa8oTfnFzpfGzRCs+aKwdRPwn?=
 =?us-ascii?Q?bCsZM78sPOM/3Ii7T2lqXGHSJhAL/801UEEJMHqruuF6/joswTlV7ynWrCz+?=
 =?us-ascii?Q?BFqq8b2BjqqRj6BnAc71iug9+u0+ww5s7onO+R8h3ebc41H0OucYCnYIkvb0?=
 =?us-ascii?Q?lWAdCrEr7z1iZUI+hV8JIeKNuTAAkv/pyNBuJ4VluoUugKlVURHdRE9Ccp4L?=
 =?us-ascii?Q?TlDZJYy9Bs93mqXxEt1InmkRBOWshdPnhcYJFBP3QF77lwOTVKcffybHBNHi?=
 =?us-ascii?Q?Q/08xNhL+Ob/MlEm6Y0GWz1H4PR73+Oxxg4E2wdLtZAJu0oP2mJVpIioTw46?=
 =?us-ascii?Q?vmTEwa578AFjAyC2Gkozt3abfWiMDmKGARkzwbM/adTFEE9lAInPqy3HKH5O?=
 =?us-ascii?Q?deh3illzDsqUmULOnlZAzAXUmo5Z6y3SkVMUC8YEFec3GPnO+53PRvwPYgJs?=
 =?us-ascii?Q?gZ97f7X0zyb1iACzfinZorBOlxsjs3i87q3IwsFutdSspMaa41Tg+Y0tQRqs?=
 =?us-ascii?Q?uI+4dO4vdPwyv7IGgqstErY0Q7xQ45+13IOhDTU/+NlJ2HuF3cm74cu9Dhct?=
 =?us-ascii?Q?gLgKx2Q/QCx3xCFXmUyW0UVXbzJmQDG6LeDeoi/YrV+erTZoRUOHGztFHQro?=
 =?us-ascii?Q?i7Te/U4NUvivM2HzH+tWhO9bXTmsSHuJ2E1I22xa3vZhWZQz/QYwJ+W03Q8u?=
 =?us-ascii?Q?LuB+WVSqxi4976akl3m2xXHdPYxFPWoQWQYejDh8MrgeDZVbPkmccr1rSmN/?=
 =?us-ascii?Q?rAIQT+Y+A0J5rUSROOQvVaKRQcpQpZF7zg+N9H6v/QXmtD6L8l2y6a6IxYBp?=
 =?us-ascii?Q?2paPTML2WT6XvZgK94oQ53UF5SPohWb5R4Pg59fWbBGkJGRX7I4jaoJOFTc2?=
 =?us-ascii?Q?ZXbKXP06TmZwx4DuKK/7DAyG8RCa5nATjQvrAtDx+Fn9MBzsYyTosKPGmVey?=
 =?us-ascii?Q?Ko00coIc7Cy3BlAcSHfJ8YwTxp1NBCGEN8qrP46ujRSH17ZLSyJIC2uPxw+j?=
 =?us-ascii?Q?/VWs4j8rVt5Vw3IhEYfaMDfRRwr5xI2eidtSafdWABgDpTIQPkdJLbL4FG0h?=
 =?us-ascii?Q?ndj3lAMwOG3AtfIMuaaJ2j3Ecs0esjqT8/Fb3W0YfKRRRsWdToDNO0CF/M50?=
 =?us-ascii?Q?tR76ujWhJMdGZb9sAKFq+DscUNLWCb4w+M+BzMUdtAV8fHhQJKUeAJvqlwIz?=
 =?us-ascii?Q?bbvWrZoYkgff+n7muMGtw3o7VjPwUuXQCLBeUneWDEP182Sz988yiJRHz8Rm?=
 =?us-ascii?Q?exPYWxfaxoJ3/96yfUGVRr+tq4h8dCxzAM2j2GX28JawXUMA3Z3uh810P8ZW?=
 =?us-ascii?Q?rrOG7Z6hsKaDqtEoKI7zgOLt1/OxzRPAe4nq/1X9JUW8w/Jo97v5x0VmOhUM?=
 =?us-ascii?Q?y7AKnKcVJ9PNTLqAiFXOksU=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 8afed956-3bf9-4734-669d-08de1b39b5db
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 00:33:01.6630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N/urJjO2wFlJf+rB7RKgqw0R3eTlPidCAZR8wGbo4CJmqynkZDlyw48DzvK94+SnCXySgl6rIFMblJ7h38ZO+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1P286MB3373

On Mon, Nov 03, 2025 at 07:23:19PM +0200, Baruch Siach wrote:
> Don't call dmaengine_unmap_put() twice for the same pointer. This
> results in mempool_free() being called on a freed element.

Hi,

While the second dmaengine_unmap_put() looks redundant at first glance, my
understanding was that it compensates for the refcount decrement that would
normally happen on the dmaengine completion path, which never occurs when
dmaengine_submit() fails. Am I missing something?

-Koichiro

> 
> Fixes: 6f57fd0578df ("NTB: convert to dmaengine_unmap_data")
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  drivers/ntb/ntb_transport.c | 22 +++++++++-------------
>  1 file changed, 9 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index eb875e3db2e3..809fb09658b4 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -1573,14 +1573,14 @@ static int ntb_async_rx_submit(struct ntb_queue_entry *entry, void *offset)
>  	unmap->addr[0] = dma_map_page(device->dev, virt_to_page(offset),
>  				      pay_off, len, DMA_TO_DEVICE);
>  	if (dma_mapping_error(device->dev, unmap->addr[0]))
> -		goto err_get_unmap;
> +		goto err_unmap;
>  
>  	unmap->to_cnt = 1;
>  
>  	unmap->addr[1] = dma_map_page(device->dev, virt_to_page(buf),
>  				      buff_off, len, DMA_FROM_DEVICE);
>  	if (dma_mapping_error(device->dev, unmap->addr[1]))
> -		goto err_get_unmap;
> +		goto err_unmap;
>  
>  	unmap->from_cnt = 1;
>  
> @@ -1588,7 +1588,7 @@ static int ntb_async_rx_submit(struct ntb_queue_entry *entry, void *offset)
>  					     unmap->addr[0], len,
>  					     DMA_PREP_INTERRUPT);
>  	if (!txd)
> -		goto err_get_unmap;
> +		goto err_unmap;
>  
>  	txd->callback_result = ntb_rx_copy_callback;
>  	txd->callback_param = entry;
> @@ -1596,7 +1596,7 @@ static int ntb_async_rx_submit(struct ntb_queue_entry *entry, void *offset)
>  
>  	cookie = dmaengine_submit(txd);
>  	if (dma_submit_error(cookie))
> -		goto err_set_unmap;
> +		goto err_unmap;
>  
>  	dmaengine_unmap_put(unmap);
>  
> @@ -1606,9 +1606,7 @@ static int ntb_async_rx_submit(struct ntb_queue_entry *entry, void *offset)
>  
>  	return 0;
>  
> -err_set_unmap:
> -	dmaengine_unmap_put(unmap);
> -err_get_unmap:
> +err_unmap:
>  	dmaengine_unmap_put(unmap);
>  err:
>  	return -ENXIO;
> @@ -1854,14 +1852,14 @@ static int ntb_async_tx_submit(struct ntb_transport_qp *qp,
>  	unmap->addr[0] = dma_map_page(device->dev, virt_to_page(buf),
>  				      buff_off, len, DMA_TO_DEVICE);
>  	if (dma_mapping_error(device->dev, unmap->addr[0]))
> -		goto err_get_unmap;
> +		goto err_unmap;
>  
>  	unmap->to_cnt = 1;
>  
>  	txd = device->device_prep_dma_memcpy(chan, dest, unmap->addr[0], len,
>  					     DMA_PREP_INTERRUPT);
>  	if (!txd)
> -		goto err_get_unmap;
> +		goto err_unmap;
>  
>  	txd->callback_result = ntb_tx_copy_callback;
>  	txd->callback_param = entry;
> @@ -1869,16 +1867,14 @@ static int ntb_async_tx_submit(struct ntb_transport_qp *qp,
>  
>  	cookie = dmaengine_submit(txd);
>  	if (dma_submit_error(cookie))
> -		goto err_set_unmap;
> +		goto err_unmap;
>  
>  	dmaengine_unmap_put(unmap);
>  
>  	dma_async_issue_pending(chan);
>  
>  	return 0;
> -err_set_unmap:
> -	dmaengine_unmap_put(unmap);
> -err_get_unmap:
> +err_unmap:
>  	dmaengine_unmap_put(unmap);
>  err:
>  	return -ENXIO;
> -- 
> 2.51.0
> 
