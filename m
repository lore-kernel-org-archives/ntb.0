Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.128
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793166479;
	b=z11/ekoCWULj0rumq+ggJm8MViB50WQi+XEa5Gq3GVUfI/HwjqV+AVH4P5lpPx4ewz3X
	 J6/zgqtjVHWSimY96BauK49I4DAbDbZuGuKddSx4GTya6FBsrQN2ZCAXMmaKlo71I5QgU
	 DPPu3kYE7FIwfWymnlaX4dp+RYpHjZUVXcB+zJ88xhFCS7XFHAHIPUTxTBAkBvHHkDLa8
	 NlVTuaSF1soYKLtDcJhDrWjysv4V3GN8X9APbvEYIjnXI/CqyjIxVNhXkErK4hWKWfKuf
	 ix9xZIjYNs3wh43IRTm2dUP0Ld7QWlctP9q5yedTgbmV3h6yMRFqPv31QAtZLtdLL7A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793166479;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=bTyg7vHfbbc0auvL2o9TrZ/vDQ+SyvZq1KezZ+xVLLo=;
	b=lGrOBTc8jgwd/bf2DHqKUwYA7aIPUHsxCDnBEjIKCtCz+PVHpAFvhNSysZ5k+AStN/oo
	 Yg+fGXzEwVjXh8JHkrD/Ow4G+biOpMZ57WSfQ7eRxSZFuZa4iQleDkeO9hD4K3QokZaCY
	 IvsvHwhUZeiSXT/z+/mwdn8EvQVw6OiCVB8c3M5NNx6HA4NKFCDG6/gjl/zRR0ZkjrvKr
	 aH3xvz18l95KP6kBS2wOmkX0KEyt7+vOD1cAdDusx8cfTDYn86iziVzvRHR8IUwlKjlH6
	 errXiDaX5aUczG1t0QsgnHI2c3rFgmnNdBIseHKeUiN63nj+1/zki8uBo6IknxHz7sw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=jjIwE5FS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.128
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020128.outbound.protection.outlook.com [52.101.229.128])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E1E606A31E
	for <ntb@lists.linux.dev>; Wed, 28 Oct 2026 05:47:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72E1E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=jjIwE5FS
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v7rposi0moFN5IjLWKEn+IGbifsvUO36x2xvEg3UyizLvLa33XZL1SA91V0o+1phXo3/CPYG4fBPC2ek3tPOvDF0Z2C7dAfy2+lAaEAJT0gvQOxs+9doL+gi4EDECFtuBAkUvX+CsIT7+/1wyjCCsZzC56dF/yLWdeJqTDEFl8tHmUPvGFHXoWJwpX16fH3lNnSyuFUa5HOV5w36TedlL/TVX8nkCItNut8VwGkhra6SYCUrojVR9ySVloIvz29bjPJt8/WiZD+tu03JSKhVTJcptl9fByhkIgb6JR2EGeWqcVw9WsRLkcvdBKfbPptZMpDMJfuqaQrKaaJtULO8Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bTyg7vHfbbc0auvL2o9TrZ/vDQ+SyvZq1KezZ+xVLLo=;
 b=fRUuE6nLY4tRPafjyIL6VYAlqqo/QbtqgUpbPW8Xl+gNkhKjmtoIGr11LgHXkr2D+igzrDlBMJcG8Wx+f7xInUdfMt8q1DxqqxZg5n2fg1tslUYA1IkXxH0tYLeRI3sJjdwEzoiORmn9HpBbsyYaAKQLvEN+4I+s/PsHBvvaqjfAYrynXpDz/0Coi+IfBl8Oa/eWHJ4sQ8nNWvHyUTD4mNfaWOZRsFZX6CqeCmAo/BB6O+rLTqHD7v8ZSxMRGHL7+mJxKnE47cT7zPhawyti4nEILmbRuzty99FLwTzbzfrajPbz8xEW0yActrFgtgTJuPJV5fXBv5Wffcr4w2b2WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bTyg7vHfbbc0auvL2o9TrZ/vDQ+SyvZq1KezZ+xVLLo=;
 b=jjIwE5FSx+hBViMcSwZpF+P9XuiUWpAM3b9ZgKHgJ9028VLB61jXTkg62S2hBYzUFyK/DqYwL9q3hYx0GxLxvWe1uzqF+s2dU/luPpmw2iQrRRuDBRK2GQbppAtPfBbh+8uyAhj08Ef479FksjwaHeRIM/sScK7o0YszI60bVto=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OSCP286MB5085.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:342::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 05:47:55 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 05:47:54 +0000
Date: Wed, 28 Oct 2026 14:47:53 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Avi Weiss <thnkslprpt@gmail.com>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, Frank Li <Frank.Li@nxp.com>, ntb@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NTB: epf: propagate memory window command errors
Message-ID: <2hgjl7icyatwg37h2ntfualg5w2n4cvr27fr7skbuowk2aufp7@wjvapfewayqq>
References: <20261027154952.250683-2-thnkslprpt@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027154952.250683-2-thnkslprpt@gmail.com>
X-ClientProxiedBy: TYCPR01CA0160.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::13) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Post: <mailto:ntb@lists.linux.dev>
List-Help: <mailto:ntb+help@lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
List-Owner: <mailto:ntb+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OSCP286MB5085:EE_
X-MS-Office365-Filtering-Correlation-Id: 816bdf65-b8a9-449c-b28c-08df34b70338
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|376014|23010399003|366016|261026140227099003|261021123027099003|56012099006|10067099003|261021121427099003|261009223027099003|261022105027099003|261022075727099003|22082099003|261026121527099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	tNUnzrtCQkZeTxzkdZ5h2RdvtlMN91+pNZLBM9TJUeagJHmQoYhYQ2BJwjLb2YgLJw5H7MIEljfKk67DVv1DWx3s2xrynaARi8h6xVCPcXhnpZmxxv3BbmID4J7WnxH5EEkifssX4+w1bDc35dTyrjNhHpmBwdi4amTZgmfc772kDKIvf5qo4/uZ6kMuReltlcLMCBcFMS3hrpvG4v7/MLBKSNWVdYFbpEnBQhPAXaCEy3K47nrJzEeZiFJ87M8QWjG61mE6NnKRTsL7CFykgUWbMik8jTjAGwYj9LiH7cHUDD7Xc5FdKcNlDFb21dpqSaKYTlP5dzOojihQJLfzA/+/g+cJ1XQn+Ua4mXfPuiP1vBUTQgdPwx+zuta4Cw6dDnDHJttBjxljCXgN+xoEfXPO08rTx6XkABUld4nuuCi5fCwwcz0Kbagfi2aFRh7SoYaGCnRttmsS/YZs0vTJruJJ2hTGckfOgJt9q/PXlkBY4Jhru2rb8eJ7TU8knGN9/aGHzxfpMk+sGoEmPq/C/zg5TfgcYN5s84SvaFbbcsKpmzE5y22Wble/y3RpwG/RbmceueH6+A9U0bFaqA/mNGHz15JthxYkBeU+TfZhmNN0XYV6lTu36UUpyK+NCJZKOUJqBPuv4E3k6OeAdxhJXEgp+3tZWukWJFxnl4f+Q9k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(23010399003)(366016)(261026140227099003)(261021123027099003)(56012099006)(10067099003)(261021121427099003)(261009223027099003)(261022105027099003)(261022075727099003)(22082099003)(261026121527099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6BLFO8ytGZ2CYFcn1jQUyzru1jULXGgX7RK9eQ766x7682h8nYH445fomyJa?=
 =?us-ascii?Q?HdxepTT6zzU6CD308i79cAZW9MGMSdqfGHmZVLFmlB1bVTKmeHFVvV+5+KN7?=
 =?us-ascii?Q?z6uHCFF6BoBMokVKUaaQ+BwG1f3BLSwMPdiNJUmCme9Uk2XoXe0fTb4NyVuL?=
 =?us-ascii?Q?WqwGNii7Gu9x1gO2sSbUVpJ3h7m4I5kHbjnUrZd4IJtroVxc9HuLPi7L471Z?=
 =?us-ascii?Q?rzFu4Ss52m1798i6OG6FlYD2UOfG03MrXm1s+mqENEobjD4UT9HTwkmwsulZ?=
 =?us-ascii?Q?/UgUD2bQnUnxU4TdmC0aAeHSOYr/KnQt+0kKVkvQGyUEhTxmF7WNKaj2FUCE?=
 =?us-ascii?Q?luZriT5ap5o4gowxI7f9nERdndkQ0fip2w3C4HNZ8JHPrx+0cC5i1aR4XQGa?=
 =?us-ascii?Q?YeZhCGNJKrNvA2R+7FVp8vq/BVq256v39+VgRRVW3XDm/DltfJ/g8U93I+0D?=
 =?us-ascii?Q?LTAkB0+Q2EZrAbyiTpQqxQBEOqvA5dFv6HgVmhn+dyN9Rx2dxEROGlrF+mTg?=
 =?us-ascii?Q?g72z+uLL7XGwhmJDsZbHH/WduT2dBZZEV2ArH8xMdDDSdSc2sM8ksRk8W+4u?=
 =?us-ascii?Q?8q6BzPWd1CydV8qQecJacWE5zbTmJn+qMYv2e25KIsamSNv4CHENTQLnWhn6?=
 =?us-ascii?Q?Brn0M5V2t2G2Uz0cNDa2KTO/hlRaGx41QxfWpBgwYQleZNiGvoEiHSg82VZq?=
 =?us-ascii?Q?fNacWT7TtrAAUG5G9Wxhv0rftv/3OBJQp8pUUi6piSbxHm688cf1gthFsMy9?=
 =?us-ascii?Q?FSIJT9QJiNjtHMJB87BwiJzjVqHKFGfokwDcjvwyFdSsvzDJjpxQxJdxXf2T?=
 =?us-ascii?Q?kwy4vdvzldiH40XX0kZRdjo+8pO+3XEcEOnEVedXs1D4M6KzEUNrwbDPmjVD?=
 =?us-ascii?Q?oMckIc6/gltheNPhx0iSU4w/OJYfMz0Edfzv5AkPfoHdnPkBUWlVNdvuzklQ?=
 =?us-ascii?Q?6Bq5Al/85OrBvUNgiKh8lVMYHSoquQcSLTgjAxHAQXMK+79A6OuQaH/L/4Cj?=
 =?us-ascii?Q?ers/4RPfHrB6o/JGIfE7B29S150rHmgc0k+mIrykc2Y6M/VLgZjwzOlA8u4M?=
 =?us-ascii?Q?VJv7Bee5DN1plBjgmdvDMqVNsV3bIKI3dc2NIjgXFnqtSqMgXoYTXtJGnYc5?=
 =?us-ascii?Q?ayLissFhIbJZYW6Sa38ebegFX+tojAWOY2zJDqVMp355xpC3dh/QVdAtKnFN?=
 =?us-ascii?Q?jWYN+9o1qhd1FpGMLWCVSI0zGF3TAQz5raYu/wUbYKXEQ3+Hmgj0goaZKAW/?=
 =?us-ascii?Q?Fyxoe/E7FoMxRQDVFADbHSOEa8xUnoZzfoCB8FY4wQwAV7d3HHBAWAxzrtfu?=
 =?us-ascii?Q?cJImBFpONomTHM0TqqKdw10W91xZHEst4w4vp3mq65m+DDJVlhWqWwVm4jfg?=
 =?us-ascii?Q?rHX/+S5J0BEZMxFGH1jp/oNg9I2ET5KFmM7BhgvCHsy86HZD8hyoNHJiNBFO?=
 =?us-ascii?Q?XTZ1zctKw8VzuPMFprcI1506AXsMmCwbXkmmRLxPBbIH8l5BLBgJnApvQYvk?=
 =?us-ascii?Q?r++rMP/lNwb33xsK051hBOLU9otgYQS4ag4yXAJ73XhQPEkvTNf5wu5YqYLV?=
 =?us-ascii?Q?aAcWpSWOSJt8+aGGY2tiEwdYDFuaELhO95RX/DWDo0Y7tYjWytq+nROrNHW1?=
 =?us-ascii?Q?u6V/Z9bPy3GYaqDzGDjb7smLuvfrfQJ1n+Y+8N3q38vsNstz/QKXRcrOIX6S?=
 =?us-ascii?Q?5nv1N9oBxRekqLgtIIhvstoVRQ1RFX6A1/GsCpykYXvdYDimgohAvP8CL3tF?=
 =?us-ascii?Q?nlJPxJkHSKKyPUQpcukZaoB0hV3b6w9c2kgOXc+lBZ8XznDJ2Mrk?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 816bdf65-b8a9-449c-b28c-08df34b70338
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 05:47:54.8833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zUKlRJ3wiS2h2M7BpDIAMRrR7oIPiX2IS7oWhcxr7bH+R+HKDTQ6cWAeKRqFjLKCGW6zwPnI3g0hqARYtIoC6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB5085

On Tue, Oct 27, 2026 at 05:49:53PM +0200, Avi Weiss wrote:
> ntb_epf_mw_set_trans() and ntb_epf_mw_clear_trans() discard the result
> of ntb_epf_send_command() and return success even when the endpoint
> reports a command failure or fails to respond. This prevents NTB
> clients from detecting a failed memory window operation.
> 
> Return the command status from both callbacks. Preserve the existing
> teardown error diagnostic.
> 
> Fixes: 812ce2f8d14e ("NTB: Add support for EPF PCI Non-Transparent Bridge")
> Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
> ---
>  drivers/ntb/hw/epf/ntb_hw_epf.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
> index c47607d4f8a7f..dd10c30bdbec4 100644
> --- a/drivers/ntb/hw/epf/ntb_hw_epf.c
> +++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
> @@ -498,18 +498,16 @@ static int ntb_epf_mw_set_trans(struct ntb_dev *ntb, int pidx, int idx,
>  	writel(upper_32_bits(addr), ndev->ctrl_reg + NTB_EPF_UPPER_ADDR);
>  	writel(lower_32_bits(size), ndev->ctrl_reg + NTB_EPF_LOWER_SIZE);
>  	writel(upper_32_bits(size), ndev->ctrl_reg + NTB_EPF_UPPER_SIZE);
> -	ntb_epf_send_command(ndev, CMD_CONFIGURE_MW, idx);
> -
> -	return 0;
> +	return ntb_epf_send_command(ndev, CMD_CONFIGURE_MW, idx);

I agree with propagating the error, but there's one thing I'm wondering:

On timeout, the endpoint (pci-epf-*ntb) may just be slow and complete
CONFIGURE_MW later. E.g. tool_setup_mw() in ntb_tool frees the buffer when
ntb_mw_set_trans() returns an error. Could this leave an MW pointing at freed
memory?

Previously, it always returned 0, so tool_setup_mw() kept the buffer. I'm
wondering if this change could introduce a subtle regression. To avoid that
risk, how about keeping the existing timeout behavior?

  ret = ntb_epf_send_command(ndev, CMD_CONFIGURE_MW, idx);
  return ret == -ETIMEDOUT ? 0 : ret;

I'd love to hear your thoughts, thanks!

Best regards,
Koichiro Den

>  }
>  
>  static int ntb_epf_mw_clear_trans(struct ntb_dev *ntb, int pidx, int idx)
>  {
>  	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
>  	struct device *dev = ndev->dev;
> -	int ret = 0;
> +	int ret;
>  
> -	ntb_epf_send_command(ndev, CMD_TEARDOWN_MW, idx);
> +	ret = ntb_epf_send_command(ndev, CMD_TEARDOWN_MW, idx);
>  	if (ret)
>  		dev_err(dev, "Failed to teardown memory window\n");
>  
> 
> base-commit: d135ab453a7400a34930bdda1ef4bdc8acfac80e
> -- 
> 2.43.0
> 
