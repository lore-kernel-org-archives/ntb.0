Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021078.outbound.protection.outlook.com [40.107.74.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2EF23BCFD
	for <ntb@lists.linux.dev>; Wed,  7 Jan 2026 04:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767760165; cv=fail; b=Wn5x/Dp+EZ37v+TeUsK50LpjD/9i/qjBgMHYC/V84c01XsoTC75A+xvVJv19SNbNQEjtDkaFaj52sQZL/ZSdv5Q1l3ikpULQ2Yp+pCa3dyYgOASw5iKCHLlNjuzRnYO0kpnGMVhhslguX10+2pNpvud+ZRomLdWhTqekmNmfLP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767760165; c=relaxed/simple;
	bh=0FK0ac6E0Bu2JB6UOdi+V+vAjwQCtCHzLQIHhm/elNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HOUHKThFV7YD9tU0Sa15fuGXZk4LqJIxwrf6kajGXeL+I80ZRi+Z2gcG1rzruT86ZrKsto4nE4ixvdlMbuyXwgoxaWS3KzecU2baMK0QCQgyDlKbxN4qh7k+UPFj5KHFN1vVk9HyUD9spwFfEFBi4t5/KL3cAOrY3CBkgfiRC+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=TBbqAYai; arc=fail smtp.client-ip=40.107.74.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="TBbqAYai"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H6K5KIXLU6uzd5fINiWXhZ4SSIbIEH7YzkHEBy5dB9Y/x+YSs0UFjtWEzJe4LNbgC+fbvtYimY3otkHmlT4jxKAqMjEj29u9KalJqcDv9X7sWaWXljwhNBIt15pkPPTLI1uVgWUDNcskylaUxp4o0QVcFRHKaACrm536175FIi/rdmN5mVJx4FxAOdtru6XAZXdOi4Lyr5n3l9VmXu0CuNinWEB/NThGKXun/1C/ZKacuP+8uw3vPSkDH06dKecUGuLZ6pOEeeBBn9/ezA7yJNKboazRuUl56ByTNJ9A8rKpAyL8vNn5JF0DL66yJR6mpF9CtVztXsW8h0kkplKHeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5SLN9pcOlu3j/w6Hj0+7FQ783tDkZ7i3Q3F2qgS0uFs=;
 b=lWs0gVh4oa1hFk7M0zciGQoc/+QnGZcCZgmuN6dzyHsuMvT87660UJgvBCg2ZqqMqbpW3Ts2nnkH1TgkFGtuaXMU8+cXPImGpxOhr85ay4eexAV0Fdu1WSPnP2ppX+Im8gWa28iavjlelneGxojHpzoDZzNaMWgGwJXHLarx/T5WKgnAcWC6NANppJSAzjy1Y0YIJ3nnhtLB/wRrNHoHuMsjt5jZBOjQS7wLx62ztBqbhQKljJwIUPmqyIUOi1muqflsEk9h+TCreEI35s0uRD5xrTl3I4mu2eaBHciQ6uDO7Kn97o2OSJRFJp4wkYlOkF5V5yuDtLCcgiLv5BLypA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5SLN9pcOlu3j/w6Hj0+7FQ783tDkZ7i3Q3F2qgS0uFs=;
 b=TBbqAYaifkqOMUSN1g2CuzBndRCrwUeUAi/OVJ+Djg0HGUYtlsCY6uDQHKj17TeDP9f/aepiij2qucE0AO0LNtnCnRkOsZrfd/ID9FdGadrgVsUwCz0pxQChm4LW/XIp8zjwo8OfmYzdU5NdgCx2EFFv7PYyeFk4yyhbxS3iRE0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB7404.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:44f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.5; Wed, 7 Jan
 2026 04:29:18 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 04:29:18 +0000
Date: Wed, 7 Jan 2026 13:29:17 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Dave Jiang <dave.jiang@intel.com>
Cc: ntb@lists.linux.dev, linux-kernel@vger.kernel.org, jdmason@kudzu.us, 
	allenbh@gmail.com, Frank.Li@nxp.com
Subject: Re: [PATCH] NTB: ntb_transport: Use seq_file for QP stats debugfs
Message-ID: <xvvxd2znh4oevszatoonpefnggg5ujknx4phy667vzrevmztmi@t2swaz73yhdm>
References: <20251217081955.3137163-1-den@valinux.co.jp>
 <95093ebd-d641-44b3-9858-58997dc92cee@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95093ebd-d641-44b3-9858-58997dc92cee@intel.com>
X-ClientProxiedBy: TYCP286CA0272.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::18) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB7404:EE_
X-MS-Office365-Filtering-Correlation-Id: 3273af65-c805-4692-ebb9-08de4da5525c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ELgbWIFc0joOlJUrtx5q2pifwW/JhsqQCbY04Jyz92KboNdW6teCrXTkGuK4?=
 =?us-ascii?Q?cEpcpANNWpxoqKMPLSR5GAgpTGQMXOHSznKen7wyDskeyrQb93VSKXmcU6Pi?=
 =?us-ascii?Q?YeMDpjWcMyjlTyiNjnbZjwoUdeh2a2n1muon9q1MuG9jUkg2mdxfu+uqaJXL?=
 =?us-ascii?Q?zR9HHV2YMXGhOX8N9p9LrEC9PZy/7EX9rR1QNnu4x+gnSzF+xZ/GVhGhEqm9?=
 =?us-ascii?Q?RMRek7bY8xO9VyqpcpEbaoYD1cdNFh4ecVMa3UEDVNXy75bVfXewGZyyc8r/?=
 =?us-ascii?Q?YCt2C4amSACv5NrdscyWMvjdWdOMfJgvLd3MxRcm8H3Hn64wpclMzXSmQqCc?=
 =?us-ascii?Q?anfUfLnVXwVQJmk+2g8z3G3U4deHtgNUXUOWVyVWT6uzoS2VCtZyN9aJP1Z2?=
 =?us-ascii?Q?YZ0nRNVoz3AP/kr4FnAHBDY8kNK1fSw58rQ3Jen05SIusTMIT/z3FqWG/1Qa?=
 =?us-ascii?Q?3MU3XfjPHFIbUV0yFK4YVPeMTa0lTT8eK19IkZqw3qHopS2k9x3i2eioJ2nE?=
 =?us-ascii?Q?t763G0lSwA3bpNiY+qXy2h7wlZcsQBlXDxCCaT8uuL8pGSuxMk/de3fQgtki?=
 =?us-ascii?Q?gjAmTbTeUhORXtPNChf0vbdwgyHACnccLpGKdCc3zpV3fa0zNukE4ZywoXCq?=
 =?us-ascii?Q?Ekcr6VdVIl+5k38RWb2ChQmNvgWM1D4vaWLjDWOJHV+LL30yyPAUxjIOkwQo?=
 =?us-ascii?Q?JQ34FHQWrwNdVuwlEdo8xonwd7JOiIHnS6KFjj7BfiP72gBLAmnt1VTPJYKN?=
 =?us-ascii?Q?VEZuj+1FLxJNsDrU45m4k/wj93FdUCJBhidrFl9pUhJ1e1SPRCr7GmIv6XBu?=
 =?us-ascii?Q?5rxO43zb5G8oMe51bd0U0kXlnGIdjK+J4DBUPxYl7TP8h3YPvfbmO7gMz8hE?=
 =?us-ascii?Q?oNx2LmBGPKEe3HybTKdKVNhNzPe0DCyeRqddq1xQbhavApRGG1RncIuT2kqu?=
 =?us-ascii?Q?GIRPOdBHviwZplheaI/UY6Fuhx2+lC3cgCtRIhCXvTDYV+70VhiqYGeGQUDG?=
 =?us-ascii?Q?OmlqXoj2WqAeK6Qp9tf3f8npBmfOc9GoX422ayLtzbCFs+pc3Ikfj0442waG?=
 =?us-ascii?Q?Y2FhHAmtOrXEEAPRcLProttjLKGVRcG4ijchHXLog0pS0ILUcYan1B7g4/p0?=
 =?us-ascii?Q?shTqZti/ttiWkwd+jA4pJEj7JG0FzFGSIlyGqo1fdB48m0h/ynPBDZkLRiCh?=
 =?us-ascii?Q?IJR2WZjButu4PqsjeQd3BMoa4tNHFDLOFLgyF2dzFLS/Ne69PkvsBrw0DTxY?=
 =?us-ascii?Q?Gy4GGcp5Nn3GEVccpLiT+Oxc0WlqLPh1zicQd1IIwZlddACw0DA541c/nmw7?=
 =?us-ascii?Q?AkIEvq+7Wz3XoM+0Rb6AVbG0CPrdHV85Jb0n2uSb7/v53m5Du5dadZAVhfrJ?=
 =?us-ascii?Q?Uu/TWka5M/vchqGasUL3TMbtdTVvH9V2VbXhN6AWzIdZjMhLosXdyxmPP6yU?=
 =?us-ascii?Q?0fhsP2c3hzJaJEDc6h8hEeswbRaF0M/1UanuQsC2kd/DjbDdR1qEWw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dVuJ0Sw762akMGoXzimHosnk9lpy2WrmdnC5WU600dYidv29x8wZruX5XE5v?=
 =?us-ascii?Q?mNyNMP+6Ppk8gRJegmnw2v+7khuwI6vhVkuQyOXiUChez1I6Kr2XvkYCKd1x?=
 =?us-ascii?Q?S/Mu0TK8srVV2kcO6IZKR+1CalJGN0BXRRkBJJtCCKa51kOWfCMAtZMEvB3d?=
 =?us-ascii?Q?kG1SpnpNfe5tv9hdQ215jzDq7lVwZXuLBk4vmuOhuIRaik28zkCWf9z/1zLF?=
 =?us-ascii?Q?Ggs7zMJSzkeAchcB6YOqwc83dJfWxyTnNNcI6MEZvcAd0Kg7OsvI6+LrKlWs?=
 =?us-ascii?Q?1w/vdBcLplueOGClbiF/wqVLH6zKfNAWPKqrzgFsl5U9GSTs5AKDcWYoZ8H1?=
 =?us-ascii?Q?iCPOR5obFc4tslPFdZacdWL5OavvlgCwV1ZPSXD3Dmoc6EEbaXOIdxGHUlLP?=
 =?us-ascii?Q?kYYQCyAAp7Vl482eL4lPvQ7KkWIqftg52xy4HlGjCRbie6AHF3tfbKLhb+Sf?=
 =?us-ascii?Q?y6XKkroFIf9tFxIyyjIGnjuM7KzZID7f2iPvXEkwzc1xh4Nhd71QvNz+s8QX?=
 =?us-ascii?Q?Zy+QSpiHv+LY9B3jZHzMmlrI4ZM5GddEfzi/aHLlNdMojYJD7DrXuRMClpFp?=
 =?us-ascii?Q?bgjfGuM2XjGR98+qdyWAo1jWqPaZpWWA6ql0Czufr29lUIl7MyRRDwwhxfBY?=
 =?us-ascii?Q?TwdSNYpOjyRIKDY/U7JdA7dQcOWv5Zx/HYkZsf2Vmh1LH5IbJDwhmo/KZq1b?=
 =?us-ascii?Q?ip7i146hoUlAmms9GpQCX65RvNU1vGHbudKLgsAwCLHZHVvzM1TjA9ZboQEf?=
 =?us-ascii?Q?IwZHdypk3xai7++I2ppB3IthGqJ00WHytLoMBZLg5Oi7lYXlnrv6ja5fpmDl?=
 =?us-ascii?Q?p01lC2K1oe1IiETfSv7hJZnjW7OPB5gMGMaMIR3hWI3aAiORFuE4sftvjD27?=
 =?us-ascii?Q?cDoQ1ziBkCYcLYi3zxFpr+wIi1RVCtJ6mVAXlVNo9dpqlfNHibjRlxOQBiDJ?=
 =?us-ascii?Q?iaD9p2Xmz7tBboF2DSDviYCYGfrKgqXSQgx5+S73rcBHHr/d92rijX/dqOVL?=
 =?us-ascii?Q?VfLvwlzNWHzXhFRVJyPqYzV1eS77h0BoAhxqktvB9Ui6t3BFhxkDMcJCizEj?=
 =?us-ascii?Q?RU0hVlNfw9yQoNPCxzQfdeeu+jI0wkKPK9rc5BpzB/C/KNziLoRFsf9udQTS?=
 =?us-ascii?Q?Xv9zoOwFPVg7eXPJJGem6SbwdAD+TvEW6I2HShMy01RVIQpZq7b+XhvRr9+h?=
 =?us-ascii?Q?c7pw2XpL9AexC9SpxGzKZClZEfqTelihjT4y2OPIl4Gb1nHFP9caeVbmh67u?=
 =?us-ascii?Q?WVOiFeaYFIeNTMmURP+BxASeV6Gv8ATExOoaT1MsdbV790p878RVPMlW0Vxu?=
 =?us-ascii?Q?JSU4jK7Wa7i9s4OOGKFUJ7EVb2ganswR+/otGVsHLTbxCXYovcZLbgFhAkJX?=
 =?us-ascii?Q?JVxSO4LBuWiHJEGsNBmqNO3IJLsTGo3qhBhkzLJ1KCocuL1KjudO/Pw9MMsE?=
 =?us-ascii?Q?btO5txSXzu+2Iy3vLwRkI5xtDhiN/A15V4OrpXEa4HvC0unh51U/JasdZzWl?=
 =?us-ascii?Q?a97vHJTeT7lWKRs+/z6BsB1Sjh0CsE7j/WDAeWuxCbQrsTqBBUziRU47sN8J?=
 =?us-ascii?Q?mwxg6HX89oXTWVQTwY2U3wv+9oza6sSAFMej7+478fxUt5/KAJH2wI02qHod?=
 =?us-ascii?Q?RgrYp8D4D5aPpzp3xK+OrIm/EW56Umtz3q2YLD6uRfvlsu/k8crwAI5d4nEH?=
 =?us-ascii?Q?Y6eKhDoCzV4JlwUdoyqAAS76ffhVANe3uzhurSz/KO4wVbQ2QdvP2Ivs7Ndp?=
 =?us-ascii?Q?kodHT3xDc8qdn7PoRbFTW8LQyfx2KFXB9DrMw2jIG4JKIit95ONr?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 3273af65-c805-4692-ebb9-08de4da5525c
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 04:29:18.0503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: To0KVqVlyN30ci97i6dF6x2Jem2s7Pb+C17mV5WKAXYQoyjF6YGzsDL18G30kvT7hhWyuzR8UMK4Gt2oqhgrUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB7404

On Tue, Jan 06, 2026 at 09:37:06AM -0700, Dave Jiang wrote:
> 
> 
> On 12/17/25 1:19 AM, Koichiro Den wrote:
> > The ./qp*/stats debugfs file for each NTB transport QP is currently
> > implemented with a hand-crafted kmalloc() buffer and a series of
> > scnprintf() calls. This is a pre-seq_file style pattern and makes future
> > extensions easy to truncate.
> > 
> > Convert the stats file to use the seq_file helpers via
> > DEFINE_SHOW_ATTRIBUTE(), which simplifies the code and lets the seq_file
> > core handle buffering and partial reads.
> > 
> > While touching this area, fix a bug in the per-QP debugfs directory
> > naming: the buffer used for "qp%d" was only 4 bytes, which truncates
> > names like "qp10" to "qp1" and causes multiple queues to share the same
> > directory. Enlarge the buffer and use sizeof() to avoid truncation.
> > 
> > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
> Thanks for the improvement!
> 
> Can you please split out the bug fix and add a Fixes tag so it can go to stable kernels? Thanks!

I have split it out and sent v2 here:
https://lore.kernel.org/all/20260107042458.1987818-1-den@valinux.co.jp/

Thanks for the review,
Koichiro

> 
> > ---
> > Note: This patch is split out from the following series, where it was
> > originally included as a preparatory change (refactor + small fix):
> > https://lore.kernel.org/all/aS3xe0CNHeIMUu7P@lizhi-Precision-Tower-5810/
> > ---
> >  drivers/ntb/ntb_transport.c | 136 +++++++++++-------------------------
> >  1 file changed, 41 insertions(+), 95 deletions(-)
> > 
> > diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> > index eb875e3db2e3..d5a544bf8fd6 100644
> > --- a/drivers/ntb/ntb_transport.c
> > +++ b/drivers/ntb/ntb_transport.c
> > @@ -57,6 +57,7 @@
> >  #include <linux/module.h>
> >  #include <linux/pci.h>
> >  #include <linux/slab.h>
> > +#include <linux/seq_file.h>
> >  #include <linux/types.h>
> >  #include <linux/uaccess.h>
> >  #include <linux/mutex.h>
> > @@ -466,104 +467,49 @@ void ntb_transport_unregister_client(struct ntb_transport_client *drv)
> >  }
> >  EXPORT_SYMBOL_GPL(ntb_transport_unregister_client);
> >  
> > -static ssize_t debugfs_read(struct file *filp, char __user *ubuf, size_t count,
> > -			    loff_t *offp)
> > +static int ntb_qp_debugfs_stats_show(struct seq_file *s, void *v)
> >  {
> > -	struct ntb_transport_qp *qp;
> > -	char *buf;
> > -	ssize_t ret, out_offset, out_count;
> > -
> > -	qp = filp->private_data;
> > +	struct ntb_transport_qp *qp = s->private;
> >  
> >  	if (!qp || !qp->link_is_up)
> >  		return 0;
> >  
> > -	out_count = 1000;
> > -
> > -	buf = kmalloc(out_count, GFP_KERNEL);
> > -	if (!buf)
> > -		return -ENOMEM;
> > +	seq_puts(s, "\nNTB QP stats:\n\n");
> > +
> > +	seq_printf(s, "rx_bytes - \t%llu\n", qp->rx_bytes);
> > +	seq_printf(s, "rx_pkts - \t%llu\n", qp->rx_pkts);
> > +	seq_printf(s, "rx_memcpy - \t%llu\n", qp->rx_memcpy);
> > +	seq_printf(s, "rx_async - \t%llu\n", qp->rx_async);
> > +	seq_printf(s, "rx_ring_empty - %llu\n", qp->rx_ring_empty);
> > +	seq_printf(s, "rx_err_no_buf - %llu\n", qp->rx_err_no_buf);
> > +	seq_printf(s, "rx_err_oflow - \t%llu\n", qp->rx_err_oflow);
> > +	seq_printf(s, "rx_err_ver - \t%llu\n", qp->rx_err_ver);
> > +	seq_printf(s, "rx_buff - \t0x%p\n", qp->rx_buff);
> > +	seq_printf(s, "rx_index - \t%u\n", qp->rx_index);
> > +	seq_printf(s, "rx_max_entry - \t%u\n", qp->rx_max_entry);
> > +	seq_printf(s, "rx_alloc_entry - \t%u\n\n", qp->rx_alloc_entry);
> > +
> > +	seq_printf(s, "tx_bytes - \t%llu\n", qp->tx_bytes);
> > +	seq_printf(s, "tx_pkts - \t%llu\n", qp->tx_pkts);
> > +	seq_printf(s, "tx_memcpy - \t%llu\n", qp->tx_memcpy);
> > +	seq_printf(s, "tx_async - \t%llu\n", qp->tx_async);
> > +	seq_printf(s, "tx_ring_full - \t%llu\n", qp->tx_ring_full);
> > +	seq_printf(s, "tx_err_no_buf - %llu\n", qp->tx_err_no_buf);
> > +	seq_printf(s, "tx_mw - \t0x%p\n", qp->tx_mw);
> > +	seq_printf(s, "tx_index (H) - \t%u\n", qp->tx_index);
> > +	seq_printf(s, "RRI (T) - \t%u\n", qp->remote_rx_info->entry);
> > +	seq_printf(s, "tx_max_entry - \t%u\n", qp->tx_max_entry);
> > +	seq_printf(s, "free tx - \t%u\n", ntb_transport_tx_free_entry(qp));
> > +	seq_putc(s, '\n');
> > +
> > +	seq_printf(s, "Using TX DMA - \t%s\n", qp->tx_dma_chan ? "Yes" : "No");
> > +	seq_printf(s, "Using RX DMA - \t%s\n", qp->rx_dma_chan ? "Yes" : "No");
> > +	seq_printf(s, "QP Link - \t%s\n", qp->link_is_up ? "Up" : "Down");
> > +	seq_putc(s, '\n');
> >  
> > -	out_offset = 0;
> > -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> > -			       "\nNTB QP stats:\n\n");
> > -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> > -			       "rx_bytes - \t%llu\n", qp->rx_bytes);
> > -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> > -			       "rx_pkts - \t%llu\n", qp->rx_pkts);
> > -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> > -			       "rx_memcpy - \t%llu\n", qp->rx_memcpy);
> > -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> > -			       "rx_async - \t%llu\n", qp->rx_async);
> > -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> > -			       "rx_ring_empty - %llu\n", qp->rx_ring_empty);
> > -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> > -			       "rx_err_no_buf - %llu\n", qp->rx_err_no_buf);
> > -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> > -			       "rx_err_oflow - \t%llu\n", qp->rx_err_oflow);
> > -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> > -			       "rx_err_ver - \t%llu\n", qp->rx_err_ver);
> > -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> > -			       "rx_buff - \t0x%p\n", qp->rx_buff);
> > -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> > -			       "rx_index - \t%u\n", qp->rx_index);
> > -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> > -			       "rx_max_entry - \t%u\n", qp->rx_max_entry);
> > -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> > -			       "rx_alloc_entry - \t%u\n\n", qp->rx_alloc_entry);
> > -
> > -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> > -			       "tx_bytes - \t%llu\n", qp->tx_bytes);
> > -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> > -			       "tx_pkts - \t%llu\n", qp->tx_pkts);
> > -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> > -			       "tx_memcpy - \t%llu\n", qp->tx_memcpy);
> > -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> > -			       "tx_async - \t%llu\n", qp->tx_async);
> > -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> > -			       "tx_ring_full - \t%llu\n", qp->tx_ring_full);
> > -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> > -			       "tx_err_no_buf - %llu\n", qp->tx_err_no_buf);
> > -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> > -			       "tx_mw - \t0x%p\n", qp->tx_mw);
> > -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> > -			       "tx_index (H) - \t%u\n", qp->tx_index);
> > -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> > -			       "RRI (T) - \t%u\n",
> > -			       qp->remote_rx_info->entry);
> > -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> > -			       "tx_max_entry - \t%u\n", qp->tx_max_entry);
> > -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> > -			       "free tx - \t%u\n",
> > -			       ntb_transport_tx_free_entry(qp));
> > -
> > -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> > -			       "\n");
> > -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> > -			       "Using TX DMA - \t%s\n",
> > -			       qp->tx_dma_chan ? "Yes" : "No");
> > -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> > -			       "Using RX DMA - \t%s\n",
> > -			       qp->rx_dma_chan ? "Yes" : "No");
> > -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> > -			       "QP Link - \t%s\n",
> > -			       qp->link_is_up ? "Up" : "Down");
> > -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> > -			       "\n");
> > -
> > -	if (out_offset > out_count)
> > -		out_offset = out_count;
> > -
> > -	ret = simple_read_from_buffer(ubuf, count, offp, buf, out_offset);
> > -	kfree(buf);
> > -	return ret;
> > -}
> > -
> > -static const struct file_operations ntb_qp_debugfs_stats = {
> > -	.owner = THIS_MODULE,
> > -	.open = simple_open,
> > -	.read = debugfs_read,
> > -};
> > +	return 0;
> > +}
> > +DEFINE_SHOW_ATTRIBUTE(ntb_qp_debugfs_stats);
> >  
> >  static void ntb_list_add(spinlock_t *lock, struct list_head *entry,
> >  			 struct list_head *list)
> > @@ -1236,15 +1182,15 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
> >  	qp->tx_max_entry = tx_size / qp->tx_max_frame;
> >  
> >  	if (nt->debugfs_node_dir) {
> > -		char debugfs_name[4];
> > +		char debugfs_name[8];
> >  
> > -		snprintf(debugfs_name, 4, "qp%d", qp_num);
> > +		snprintf(debugfs_name, sizeof(debugfs_name), "qp%d", qp_num);
> >  		qp->debugfs_dir = debugfs_create_dir(debugfs_name,
> >  						     nt->debugfs_node_dir);
> >  
> >  		qp->debugfs_stats = debugfs_create_file("stats", S_IRUSR,
> >  							qp->debugfs_dir, qp,
> > -							&ntb_qp_debugfs_stats);
> > +							&ntb_qp_debugfs_stats_fops);
> >  	} else {
> >  		qp->debugfs_dir = NULL;
> >  		qp->debugfs_stats = NULL;
> 
