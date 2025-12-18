Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011019.outbound.protection.outlook.com [52.101.125.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31F7303C94
	for <ntb@lists.linux.dev>; Thu, 18 Dec 2025 05:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766035204; cv=fail; b=Yr69NtLuD98vSgIpH/p+Ml+bm2nSChwsGI74lBVH2sTBLRbbKo8tymrBO2Yv97twL1kzqLLMn6dANs42srFcF1km+YMwfDvnngk7mxRdf7EDggdXD/7FSg3y38b9g8iVCX8zlRyc7rztiXm0aIFrdZTblnqLtT3avGgdCn9dQ3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766035204; c=relaxed/simple;
	bh=i2qB1lJMDVgkGwVd5H/sG4qsH//DjeWKURmMz22Rifo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PPF35ddin60L9UFRoelidpaYZIuvo0epvVddEJwAYn464kzvxlSznVoXafqhO5jYZEW0QxKVLFXZ7QDbBdhlayAvSSaU4V8107OR2Osuk/dZB3qzniIQ8ZMuRGxQMlWzfRdDSpXJirzzTGOX7EoH2YYbwRINwXsaBE6JnMTmWh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=isIEWHnx; arc=fail smtp.client-ip=52.101.125.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="isIEWHnx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ke4HMJm2OD8ANrngOzYq0LgskperVJbvRX0Wc7uCoEBELz5xj3fCgwgeHPAWu+OZDOO3pU7X6RNoqdoDsE/s00dI+l/7F5yhA0yLPx6hsO22R/rSQMSBNiRvR0l/iTowPZhQDen/Q/fCyJvYM97gXHPcCbIXzNusXrO8Onc9aOp2n1TX1vagaVKkEhSzoiEpSjN4OAV/BazI2O7oS+qsgLwYmwUz2Uh4d7m86HCuwGsUjtVNidNxtfLY661FTRFGKwhQiNKiMGnEYcFdkB+g5ErqFeK0faDlhKSxIsMfHwDxSCT+DdANB0xriyYxmPjd5XDiwCOimWA+CrEWIXvSgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dcvoTyH8zEZdka8Num3D/aO2vEdgFcWn/3v43bMQ6SI=;
 b=DQhvaQCKBuoUnFPiHllhqA0Xwkn2I1hj68M/yuJtFYK70YFEScxGl7erKIkfCkEbLEdu02gnNtY65M9NSlKFDwx/LSY5NysEYAsaGajlrDh7JDczLVEPyEcO4TT2qWC2+XAgHDLGlqM7gZ2dUVNYNNTRbpL9Ucpffu8+n427D6n+kGc7iaZKs9OzIQlCMLC4FO3sCdpOH5fpaCLg71mF5mWtaHBRAjPcWDo4XTVcAnzr9zxQsZqjPK32Ym6rdxo/9BH302B57ffFwZh3K5XAUvFX5MTN5hxz4WO3yn030WzqTfpMmezFobZR6fTPhQB4UF9/0irwjya4j208Mmhp6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dcvoTyH8zEZdka8Num3D/aO2vEdgFcWn/3v43bMQ6SI=;
 b=isIEWHnxz9LyI1Ej6Gf5GXhkHapno1FRE5QWM4Ia64JpiVeXAfluFMzuMB+g9dS7eeECbrqDX4MGD93/xgUZG47P4bcHr4W2anla7hSCoeFM2FZmVTI/yEPQxJ7m7tOblOna+55EEKgYNy9J3Ne1AaBOdjxQYzo5YoE9+yajzo8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY3P286MB2708.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:257::10)
 by OS9P286MB7556.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:447::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.8; Thu, 18 Dec
 2025 04:46:28 +0000
Received: from TY3P286MB2708.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b17b:8311:62f:5639]) by TY3P286MB2708.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b17b:8311:62f:5639%3]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 04:46:28 +0000
Date: Thu, 18 Dec 2025 13:46:27 +0900
From: Koichiro Den <den@valinux.co.jp>
To: ntb@lists.linux.dev
Cc: jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, 
	Frank.Li@nxp.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NTB: ntb_transport: Use seq_file for QP stats debugfs
Message-ID: <ds2ok7teixvjeips22htvrickr3rmtgdkkbg7bfvgb7zcfxpdf@rapmqpkpsioa>
References: <20251217141801.3157143-1-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217141801.3157143-1-den@valinux.co.jp>
X-ClientProxiedBy: TYCP286CA0189.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:382::15) To TY3P286MB2708.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:257::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2708:EE_|OS9P286MB7556:EE_
X-MS-Office365-Filtering-Correlation-Id: 628ae090-1132-4769-c03e-08de3df06828
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|10070799003|1800799024|27256017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WVdpnxkl9NJpsB5CpPLvHjQJOaGFPwyYNCKHnmeZRUvKUIrvz/b1pfWOITqD?=
 =?us-ascii?Q?oMFNvB0MjHT3EXnHxCwngxhsQzyNeEZuqDzhLoUDQn/vghbE0z7qlvrb/Nq9?=
 =?us-ascii?Q?tL898kAWYB0qZPKjsEVn4E74yvgfOb6KmjEUu45dpAcm2szTvfvtjK4zW5hV?=
 =?us-ascii?Q?gxUaQmAAiU+d4nqq0hMckQw/vcHWrGe7QZEO4sLgLO/j9O7wYUu6nBECiaqn?=
 =?us-ascii?Q?WrON1N8KRHmpkomeBWkm7vZZB9kjPoGmyoRoT7riy3XT4QPVZROU0OVKRewq?=
 =?us-ascii?Q?GqkJD72cQtk5uFXeX/vcNIwfo+p9WXKP8YJRHyC3U8jT9BRxSIkvajsWQDv1?=
 =?us-ascii?Q?sx706tb86/6QnVi8O8nVYWCrcbiGga6uwuKnmf9D35hfdmMda7P/6FHlQDG7?=
 =?us-ascii?Q?GxuG3sFMdolScpovcpdNgyknqLJKjhHf3s3ZeFHcL63TKHwIlzTS2ETP5v+p?=
 =?us-ascii?Q?kND/m3kFyLJ4Xm8RNMu7Qpas1//SUgDReARsVrKRoqhu+rvzGw+AKx9xC6tu?=
 =?us-ascii?Q?4RQEsFrHq27vBbnYQdz2ZCmuqFQdY0EersAx7qgK7KfwIBSNZL7CAOU+PLDm?=
 =?us-ascii?Q?0m/gNXHHSMIjn+Ss3lGZwwtmZYa2hKv2sC9ik4Xjt12U0BvbmUq00yYHTPYv?=
 =?us-ascii?Q?vpBxZbW5qdPGlssE3eWCpajgkQj7nriXi5ttZ7/OFUIKGps3xfhCDxtSI3pv?=
 =?us-ascii?Q?TWFoGgMAq1wCCQo9XaB8/qLTiqJRd28rhvvFo5fBqGviPsXs8cjDYjxobYhX?=
 =?us-ascii?Q?5AJVZdj3oHa9Y6+nJ2jL5T66PqDbjXKrJpJSBUgdamkMByl0bNaDWb6LQb0d?=
 =?us-ascii?Q?MTG0wCzLl3HfhHUH7eSL+YHfh6uEb1XHJDm3kfsBJZRZfQIGLyz0SSD0jzta?=
 =?us-ascii?Q?nkJ52xZIT09lXWGQY3gkYQQTr8i7yXIHzwbh7+MouuIfGf7fTaXheBK2F+LP?=
 =?us-ascii?Q?tqXAlp2NLMGS6GKHBPq1ggVVImyTVVShEGkq3dO/15RJUyqls/gZemcR4Fvj?=
 =?us-ascii?Q?3ZsZGlW5TpjbPl73CXi84BEq66gTdAnCoRxsJHlYQlmHK3EjZ940FHeiNpU1?=
 =?us-ascii?Q?7PBSTYeXzVT+ehiuOj+pMcEJbxjf4+1061h0CKdpsIY70dA782vnXemlnRB5?=
 =?us-ascii?Q?WNOJGO11aOS0dhfYcTKMqnpHufLJZvGHKC7/5oT+0aHzZHLwRFpTwCvLj3D5?=
 =?us-ascii?Q?fZ88gvo/+SoWO0nxQFXx3h5GEqRDod4RigVplnwb6KJzbsGsT6Ze1EegXuR6?=
 =?us-ascii?Q?EFK+cwLbfQVdyoKlyBCbjBvkf6mhMHHNoKo5J+5iDZbb/lZ9B3rB+XoTJYQJ?=
 =?us-ascii?Q?Wj36d9dE1gtDd7IJ+LHRArIVDA9WVDhUwR4i5xK/ceK5t+VjfILvBGTssNy2?=
 =?us-ascii?Q?l4amp419JaOr4eDwdavVe7EvkYP51IoUT3akj7RRehZpD4nEOAQKJ9B66ov1?=
 =?us-ascii?Q?2DuTx8X2/zWxJm57uunlnEAIHycuQTKh5QAwJzUsqo5Agq70/jpk15ukBtNa?=
 =?us-ascii?Q?BPKNgC1ilqHoA0lK/qae999Nh055HNNbynqO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3P286MB2708.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(27256017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IXq6FV7R1tt1DcSWB+GeB+hORqDrSMImLhPJN4+npnstxx/eNN8uwYKlSRrA?=
 =?us-ascii?Q?oL52s++TzlGVZ6vKmnXRw2s13Zmelb34psZ5tu91agbQpnyQDfTOHihUaiAr?=
 =?us-ascii?Q?a6Pz7VvmlnsXz8+XxdEndFY5rjwnRgf+NitLRH2l4R4jyJqP5sHi1MoIpQku?=
 =?us-ascii?Q?JQRJaxRbAyhgedB/457O963oOnIaEiGR22WwzuzMUVV6EJ2CIQdePejIqlaW?=
 =?us-ascii?Q?LL3ARRT/huUF0pJTQmhsrypNa+S6B0MpNAIro9QKMFEdLXNJbLyQ1F7NNcUd?=
 =?us-ascii?Q?yJFvFpc4kgCfibiNp2CJAfxJ5oUtakGF2ftkJ3WhtI2igg5dduJiCaUOMBWD?=
 =?us-ascii?Q?3e1bgyWc+jTo5jvw2gKefZDPLFj8tisty+u7Ts3QNCtIE6NMB1+hGuaMYPLy?=
 =?us-ascii?Q?8mcfPppS2xhCUnKea+4njoEjxd2EV4Clj02YEqQHFj1kAiwzRNMhNylWNUW4?=
 =?us-ascii?Q?dH1dPam0RRx7GRuzwQPbcgN6RhAeii46lHbdgA10Q8oIWTuEei7/kybFdTxp?=
 =?us-ascii?Q?v+nz66p1I4Q6ajl856FFvywSV/Xts6c1KBYXN+/AU/Emq7lzft+UIS3CD8Pq?=
 =?us-ascii?Q?19CdchVHfP5gKB34C1WNzbM0kOPoAkrJ88MfOLPkYBn9YNfysSHgBe72KN3p?=
 =?us-ascii?Q?PpFDpe3bAPwckbBfFzIszBeH/05a+b4U4CkR0JT/pDI77+XZdDfgM8w84wVS?=
 =?us-ascii?Q?E0uSvVEH/cd71um0qwG8ACiPLm+D633r2fkGaaM+OR+JFAAkrToBwNm5kxKq?=
 =?us-ascii?Q?5w2Amc7lx4/uq8pDylL8uXxTMpFscnNORcfggFagrvZ425ZzS0p1tTEr7heA?=
 =?us-ascii?Q?6AoqwCg7qIgYp1Xqap3j2WKBWo+fsMWPbKUItdQjQb5xz+ikjMncc/bCqiHe?=
 =?us-ascii?Q?+cLSz5+cc8R8iYmfsHZZoOWveQnw0YMj5j7q/ds/rVO53nT/h5cxztzyoftv?=
 =?us-ascii?Q?4XSN7Hre7P+Khhn9J8cIDHZn+TJMQNJclrwQTMxddNSsiGzaoTGeNWHLwamW?=
 =?us-ascii?Q?AzjkDha0+ibE9f9tRqrRmrZwsX4q4KGL9pbZZ3K4JdUeIi5x0lwRTUoq8gy4?=
 =?us-ascii?Q?67ck6RoEsB08kIzu3KucL6W+/qZ24mvHZOaI6myr0/kxtyGLFRuNadgQH2qD?=
 =?us-ascii?Q?TVD6vC2zWr+l9IZo9s2z5ZeTRX42Z/03hWO5yyVuwhlDkis3orEdtVr6wwVK?=
 =?us-ascii?Q?RNxDbwLh46dcQU2vboCqiWEYZ680f0b3WDOWMLurFzg5++s8YCRfIbXUDjgQ?=
 =?us-ascii?Q?whcMfooEz/QF1PkYDv2nCw9dzNfMfGT+VRWoFv7oO5Ayw8ZYCjh2qgGrFhMD?=
 =?us-ascii?Q?luTXCLGAPYpmxBKY96qsqZT5V7e69Ke7XYStyrqJ8hN/+15IH7APM1jKDHgF?=
 =?us-ascii?Q?UMNL2L2B7VadS7+ZHpyWb/JdQ7DgrYQRH0/zuqEqpCzDOxepVTwAn8TmjTOZ?=
 =?us-ascii?Q?gBW1r8BuV2REVTdgyRgFXepFV4s+qpFK6vqc8zSiuoR+cRANxEGIXCGXOex2?=
 =?us-ascii?Q?HydS+kw4nskVV4ofFGUXiCdecsC51sZYiPdxGBUgLxHpg4CMDxA4IbRx2T7j?=
 =?us-ascii?Q?GTe2Sr5Gt0a3ZZe/TPRPWMvPo0qaE/iDUQjFdNXuM4p+dFfUMNm9QcAp7FNn?=
 =?us-ascii?Q?G7rF+INIXsfHrnOuhlJ3nGk=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 628ae090-1132-4769-c03e-08de3df06828
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2708.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 04:46:28.3123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iojbvt1T/m5hZiS7XBuF4U7QC09/oXinQkiKIXGah8obhVoyDSnSoDi31aiSf6Y8Kjjr192bfIWVPrEVndZhTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB7556

On Wed, Dec 17, 2025 at 11:18:01PM +0900, Koichiro Den wrote:
> The ./qp*/stats debugfs file for each NTB transport QP is currently
> implemented with a hand-crafted kmalloc() buffer and a series of
> scnprintf() calls. This is a pre-seq_file style pattern and makes future
> extensions easy to truncate.
> 
> Convert the stats file to use the seq_file helpers via
> DEFINE_SHOW_ATTRIBUTE(), which simplifies the code and lets the seq_file
> core handle buffering and partial reads.
> 
> While touching this area, fix a bug in the per-QP debugfs directory
> naming: the buffer used for "qp%d" was only 4 bytes, which truncates
> names like "qp10" to "qp1" and causes multiple queues to share the same
> directory. Enlarge the buffer and use sizeof() to avoid truncation.
> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Please disregard this submission.

This patch was re-sent because it initially appeared not to have
successfully reached ML. However, both submissions showed up in the end,
resulting in duplicate postings.

The original submission is here:
  https://lore.kernel.org/all/20251217081955.3137163-1-den@valinux.co.jp/

Sorry for the noise.

Koichiro

> ---
> Note: This patch is split out from the following series, where it was
> originally included as a preparatory change (refactor + small fix):
> https://lore.kernel.org/all/aS3xe0CNHeIMUu7P@lizhi-Precision-Tower-5810/
> 
>  drivers/ntb/ntb_transport.c | 136 +++++++++++-------------------------
>  1 file changed, 41 insertions(+), 95 deletions(-)
> 
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index eb875e3db2e3..d5a544bf8fd6 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -57,6 +57,7 @@
>  #include <linux/module.h>
>  #include <linux/pci.h>
>  #include <linux/slab.h>
> +#include <linux/seq_file.h>
>  #include <linux/types.h>
>  #include <linux/uaccess.h>
>  #include <linux/mutex.h>
> @@ -466,104 +467,49 @@ void ntb_transport_unregister_client(struct ntb_transport_client *drv)
>  }
>  EXPORT_SYMBOL_GPL(ntb_transport_unregister_client);
>  
> -static ssize_t debugfs_read(struct file *filp, char __user *ubuf, size_t count,
> -			    loff_t *offp)
> +static int ntb_qp_debugfs_stats_show(struct seq_file *s, void *v)
>  {
> -	struct ntb_transport_qp *qp;
> -	char *buf;
> -	ssize_t ret, out_offset, out_count;
> -
> -	qp = filp->private_data;
> +	struct ntb_transport_qp *qp = s->private;
>  
>  	if (!qp || !qp->link_is_up)
>  		return 0;
>  
> -	out_count = 1000;
> -
> -	buf = kmalloc(out_count, GFP_KERNEL);
> -	if (!buf)
> -		return -ENOMEM;
> +	seq_puts(s, "\nNTB QP stats:\n\n");
> +
> +	seq_printf(s, "rx_bytes - \t%llu\n", qp->rx_bytes);
> +	seq_printf(s, "rx_pkts - \t%llu\n", qp->rx_pkts);
> +	seq_printf(s, "rx_memcpy - \t%llu\n", qp->rx_memcpy);
> +	seq_printf(s, "rx_async - \t%llu\n", qp->rx_async);
> +	seq_printf(s, "rx_ring_empty - %llu\n", qp->rx_ring_empty);
> +	seq_printf(s, "rx_err_no_buf - %llu\n", qp->rx_err_no_buf);
> +	seq_printf(s, "rx_err_oflow - \t%llu\n", qp->rx_err_oflow);
> +	seq_printf(s, "rx_err_ver - \t%llu\n", qp->rx_err_ver);
> +	seq_printf(s, "rx_buff - \t0x%p\n", qp->rx_buff);
> +	seq_printf(s, "rx_index - \t%u\n", qp->rx_index);
> +	seq_printf(s, "rx_max_entry - \t%u\n", qp->rx_max_entry);
> +	seq_printf(s, "rx_alloc_entry - \t%u\n\n", qp->rx_alloc_entry);
> +
> +	seq_printf(s, "tx_bytes - \t%llu\n", qp->tx_bytes);
> +	seq_printf(s, "tx_pkts - \t%llu\n", qp->tx_pkts);
> +	seq_printf(s, "tx_memcpy - \t%llu\n", qp->tx_memcpy);
> +	seq_printf(s, "tx_async - \t%llu\n", qp->tx_async);
> +	seq_printf(s, "tx_ring_full - \t%llu\n", qp->tx_ring_full);
> +	seq_printf(s, "tx_err_no_buf - %llu\n", qp->tx_err_no_buf);
> +	seq_printf(s, "tx_mw - \t0x%p\n", qp->tx_mw);
> +	seq_printf(s, "tx_index (H) - \t%u\n", qp->tx_index);
> +	seq_printf(s, "RRI (T) - \t%u\n", qp->remote_rx_info->entry);
> +	seq_printf(s, "tx_max_entry - \t%u\n", qp->tx_max_entry);
> +	seq_printf(s, "free tx - \t%u\n", ntb_transport_tx_free_entry(qp));
> +	seq_putc(s, '\n');
> +
> +	seq_printf(s, "Using TX DMA - \t%s\n", qp->tx_dma_chan ? "Yes" : "No");
> +	seq_printf(s, "Using RX DMA - \t%s\n", qp->rx_dma_chan ? "Yes" : "No");
> +	seq_printf(s, "QP Link - \t%s\n", qp->link_is_up ? "Up" : "Down");
> +	seq_putc(s, '\n');
>  
> -	out_offset = 0;
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "\nNTB QP stats:\n\n");
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "rx_bytes - \t%llu\n", qp->rx_bytes);
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "rx_pkts - \t%llu\n", qp->rx_pkts);
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "rx_memcpy - \t%llu\n", qp->rx_memcpy);
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "rx_async - \t%llu\n", qp->rx_async);
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "rx_ring_empty - %llu\n", qp->rx_ring_empty);
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "rx_err_no_buf - %llu\n", qp->rx_err_no_buf);
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "rx_err_oflow - \t%llu\n", qp->rx_err_oflow);
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "rx_err_ver - \t%llu\n", qp->rx_err_ver);
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "rx_buff - \t0x%p\n", qp->rx_buff);
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "rx_index - \t%u\n", qp->rx_index);
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "rx_max_entry - \t%u\n", qp->rx_max_entry);
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "rx_alloc_entry - \t%u\n\n", qp->rx_alloc_entry);
> -
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "tx_bytes - \t%llu\n", qp->tx_bytes);
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "tx_pkts - \t%llu\n", qp->tx_pkts);
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "tx_memcpy - \t%llu\n", qp->tx_memcpy);
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "tx_async - \t%llu\n", qp->tx_async);
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "tx_ring_full - \t%llu\n", qp->tx_ring_full);
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "tx_err_no_buf - %llu\n", qp->tx_err_no_buf);
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "tx_mw - \t0x%p\n", qp->tx_mw);
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "tx_index (H) - \t%u\n", qp->tx_index);
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "RRI (T) - \t%u\n",
> -			       qp->remote_rx_info->entry);
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "tx_max_entry - \t%u\n", qp->tx_max_entry);
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "free tx - \t%u\n",
> -			       ntb_transport_tx_free_entry(qp));
> -
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "\n");
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "Using TX DMA - \t%s\n",
> -			       qp->tx_dma_chan ? "Yes" : "No");
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "Using RX DMA - \t%s\n",
> -			       qp->rx_dma_chan ? "Yes" : "No");
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "QP Link - \t%s\n",
> -			       qp->link_is_up ? "Up" : "Down");
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "\n");
> -
> -	if (out_offset > out_count)
> -		out_offset = out_count;
> -
> -	ret = simple_read_from_buffer(ubuf, count, offp, buf, out_offset);
> -	kfree(buf);
> -	return ret;
> -}
> -
> -static const struct file_operations ntb_qp_debugfs_stats = {
> -	.owner = THIS_MODULE,
> -	.open = simple_open,
> -	.read = debugfs_read,
> -};
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(ntb_qp_debugfs_stats);
>  
>  static void ntb_list_add(spinlock_t *lock, struct list_head *entry,
>  			 struct list_head *list)
> @@ -1236,15 +1182,15 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
>  	qp->tx_max_entry = tx_size / qp->tx_max_frame;
>  
>  	if (nt->debugfs_node_dir) {
> -		char debugfs_name[4];
> +		char debugfs_name[8];
>  
> -		snprintf(debugfs_name, 4, "qp%d", qp_num);
> +		snprintf(debugfs_name, sizeof(debugfs_name), "qp%d", qp_num);
>  		qp->debugfs_dir = debugfs_create_dir(debugfs_name,
>  						     nt->debugfs_node_dir);
>  
>  		qp->debugfs_stats = debugfs_create_file("stats", S_IRUSR,
>  							qp->debugfs_dir, qp,
> -							&ntb_qp_debugfs_stats);
> +							&ntb_qp_debugfs_stats_fops);
>  	} else {
>  		qp->debugfs_dir = NULL;
>  		qp->debugfs_stats = NULL;
> -- 
> 2.51.0
> 
