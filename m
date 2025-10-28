Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011071.outbound.protection.outlook.com [40.107.74.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4E721D3E8
	for <ntb@lists.linux.dev>; Tue, 28 Oct 2025 01:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761614228; cv=fail; b=K2YlKYX/iRQ6QONd/rhmJbdHhiQbP/TVYrgWf2XUWuICQ9TfUEj15fTDcMC7crZHtDzmbjYNlZB3acDagXqDOjTz6BNPI+/p14jFyzPWQ8Q3FbkhyuEaE+3K1trpJOFvDCsuZh5P+DK16Y4GtSe0zZPLz0POK/RY7BCTFbIhhAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761614228; c=relaxed/simple;
	bh=xMpvUk3kwtNs0612lEWpZt5nv1FTyhpHO7X4SL8aWys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZRRGFg/e7avwVOU0t1zG3xyS0v1sF+3ipfUrpvZGOk2MH7S4x7bI0g8jyEuMG6Yc28EK0RuUmm7YY7C0f/xT1BR8vEJ0u4J7ddDdzdEBN/o6E/aSbPEyXIfZ2aPMVSMMtpqICG4E3UKDHtBI7NyshuDqEsI7ywwvbXWXOcIHFYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=DtJMhogX; arc=fail smtp.client-ip=40.107.74.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="DtJMhogX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QHzdXvz6a9gzII5eLfk57m+bnUPiBCmwCcXbyzirPZRpj+hARl+kMX8OYADsEeZB2ngJn0564p9NTLh/TCdXh9OnOH6WztP86z5DWwcPjpiChlFVGMmrIg6+uHv6QHBRD8NJ5k+2UTxplKnN/XyaNEOIcgeMKqvM2DI7ryMsZlrzn2VVXaMr7KkwgSXN9cTAAJfoiHYEW9OBXO5Xy/oSuHYhB4IcWLxoF6k4WriBU501NFpA8pRYPOph7L2e+m6f8RRAnHTmMuBs9EzwvE+zCPpFxF/kjPkAmAa3WS9CrIEXDmp/X2oTwnkD8f6e8E8LmWXGbGuSIjSBMqyg7k4Jsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SrsY9WJ6Mv+bLLhZxj6ESTw2Fn2V/mGRKPnZUmlJ3zw=;
 b=BrtjF9zquMdPq2pQ55ZUG3uupQH3ufK/FyKczCm0mWbryfBL/GsllnrJHgaCjMq+xHF/WmehxHhnvSnmYItM+T5u6XID/xtPXVXnEylpmuttWfJQ10l1kT29wXaizHbLsLK67ttWRuvm5F5otH+XtynNvqSgXimjbilJCytdRrF//tOD1FSMzGQmssS4ROtrPAaFkF6KZFNgDHo08dzKIrlg2j8DHyncIZk0dU94XoyRVfvJv24bwLkFrPk/1eM/udid9zTwzuM04X3ySnoFin9z8bSh4ejeOyzIFMSFOXzQFRHcjcRoj1icfAtbc2XN5W1Pk41/6v5/+eAMu9e6XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SrsY9WJ6Mv+bLLhZxj6ESTw2Fn2V/mGRKPnZUmlJ3zw=;
 b=DtJMhogXnaVR/1ssgPfDV2d2mVfPgkA34qVFZe+pm9OHcCvcghsZsIxIyrPHbOGV6rmCN/0mkwDQqC/uc0gIOjL9aXxVnZCUDjlfUzmXmSm5b2/cPLZSwxvvMvGVVWCYpKAZMibZZ6hDmfcAu9B8Ws7J3jVNrjT17E3e1Di8Q3g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:10d::7)
 by TY7P286MB6230.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:330::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.17; Tue, 28 Oct
 2025 01:17:03 +0000
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a]) by OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a%5]) with mapi id 15.20.9253.018; Tue, 28 Oct 2025
 01:17:03 +0000
Date: Tue, 28 Oct 2025 10:17:01 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Dave Jiang <dave.jiang@intel.com>
Cc: ntb@lists.linux.dev, linux-kernel@vger.kernel.org, jdmason@kudzu.us, 
	allenbh@gmail.com
Subject: Re: [PATCH 4/4] NTB: ntb_transport: Support multi-channel DMA via
 module parameters
Message-ID: <qnmf7dmftg4nvgor46hrwcldefss5prb4ai7jgz4um3le76gt6@5uq4lt5ll3cx>
References: <20251027004331.562345-1-den@valinux.co.jp>
 <20251027004331.562345-5-den@valinux.co.jp>
 <658755f6-d8d5-474b-8dd1-e5fd27cd48c0@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <658755f6-d8d5-474b-8dd1-e5fd27cd48c0@intel.com>
X-ClientProxiedBy: TYCP286CA0221.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::7) To OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:10d::7)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB0979:EE_|TY7P286MB6230:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ed14570-4f12-446f-3fb8-08de15bfb37f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+eT0w4Rm2as72/Q8frjumgYk9fr/PbdsjepdrClvDCKjfHlTjAOLCM0iBUCY?=
 =?us-ascii?Q?UpDjhYSblHweP8INGifmYtmVg4oJiipOcBZXP8qQj3T8w94qaEzKdAm/6feY?=
 =?us-ascii?Q?5c3Z5mX95rdjd6N+3GCE/0IGOlIBWr5iTwivViWCNGJR8GmvPpESVWioVf4V?=
 =?us-ascii?Q?nZE8QTfuhqqaX19q34/hZx5AuTV9Cgq2eNmISq0Zrzs298fWa2qAQcNEm2N4?=
 =?us-ascii?Q?+rDZ0z28/P6+S04ND9YAZxraJiPX4UWi0Ww+/ZbG5VbAf0X/PA06ohhye8ca?=
 =?us-ascii?Q?SICQ3muG2biV3JQeweLcA98BPMG4uG/K0/QfkPjPWP01kOZpsYAtpdQ05uNM?=
 =?us-ascii?Q?G5jeAxUbnwvSk0sIm0EdHAEONF05s8Xk1gaT5npIR2cp+STAl7GQLbQ9q+e6?=
 =?us-ascii?Q?l0xrRZGbahN1mpUSBSmKxmAR7Gb17tfgc+8bdJ1fCmoC2RtIvuS3M+G6MGZh?=
 =?us-ascii?Q?Ng4I2boxIT5BfVQboO1aVacxCsgMlHU+gggUwNlxVIKBDT0n06tKN6PMZv0k?=
 =?us-ascii?Q?izqXryRVSRKxKmMoVu/oSKIwDhGXoZzkLMZFzCsow2efWqQS+rw0QEctLPO2?=
 =?us-ascii?Q?J3KUNZmqWADNb60+3y5zoc2pyKz+gsicacsk2zPgSmjTgcRrpGXQQniIzvF9?=
 =?us-ascii?Q?B0kku2tJxHHpRvUIYTtZFmBZ84mw2E7Jd12qZfXcwx8bC9bIT1IoUR4RQaBm?=
 =?us-ascii?Q?qFYZfj8q/68HQjUDY6MnUTDGXoJ6sR6j5/W4RPSIUzi/qBUwfnTKkPCYPCLg?=
 =?us-ascii?Q?OLzHHbMJIJ1FlG7f7EYxIzeFSTjw5hlymp0a5LUIZQveSnFs139I0QhkEtpe?=
 =?us-ascii?Q?/RubEU1kcINMF3wdFj+AxLFzFtSuaMGgECwxh/xEFrH3ArlEJyx6fYG+FX3N?=
 =?us-ascii?Q?52n2gbaPICNJsY5rYkXGEG1RoFzDwono3bg47gt9/DAw1tN6WU16sM1WFnKV?=
 =?us-ascii?Q?QtlOFq+2MMJFKO2KRP8jLFi9m5XavdNXmO/gzZWPW8HJFmT92TTvARUNbdEU?=
 =?us-ascii?Q?RT/XNuAF+a4+RdpZ9xNTPhFkztU2Pgjnak3TnecIZOhtcm9gppZUTEmq/i66?=
 =?us-ascii?Q?4Q8i7PMFX0N6qRqgtEc3hA7UUjcnHFkmOEmDNfLHWA6yljXp5GMNnA5V9eho?=
 =?us-ascii?Q?0nyOFP86Hh9pxWdm9+44msnqUuG57VpxgjsLMCu4iJkkRTp810fDt+IHIE6Z?=
 =?us-ascii?Q?Sl2M2qcx3TJeyzpee98e73iIdfHq62oAuc81RhYz44f5dgtbnkgb6frTy7TQ?=
 =?us-ascii?Q?OWNroChglP678tJHn43SUuhIljhbaINPBP+7AOWG+5kSDScTV7gtFz4Mn72n?=
 =?us-ascii?Q?fY3G7R4w5ouUTjRTu6UVwgiJEH7/3s08E9iToXB6+Ts8h2aq7luJp88LgEFj?=
 =?us-ascii?Q?4u3tEaladkEJu0Swd9W2LFaJ70KOE4uGgIf7uf8Ex/78Xyva0kUGOwzQHeap?=
 =?us-ascii?Q?Ud12iEQLqoaq58XI1Azp1InixRVKPtsA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O7YOsyRA8mFza7e9S00Lc89RgEz3aHB/IKJ794T1ZwqEQby83QXs6xGrlJ0I?=
 =?us-ascii?Q?sHBXK+V1OgdEUPEOlpbMmQcyPrGbmTQ2cO7RE2w+zgzX+pBfPDvwA3Z1PBWm?=
 =?us-ascii?Q?OMM0DH6cgFOdO+kI0YO/y1CU+jcpTeB1ZUhHZLo2O/hz2bgoOhdTbchOh75v?=
 =?us-ascii?Q?8U2124sHEu/eIRrRcZcZqmjrst/dJTnrRT3H0Lx7WM2Vr4A1R0KFnP0+Br6w?=
 =?us-ascii?Q?y7QzsHwffWpBlCpgKMK+UajyU2vAsQhnJ89p6PtPVCBIXorrpmJj22Tn5kFt?=
 =?us-ascii?Q?soyGL3XecoSq/aeT/2QY54mBpQM8wz+o9dlW5LGg6J/n2uXeZgJ3Hf0EAuwo?=
 =?us-ascii?Q?rS5XhEv6Z4nO1/QCgJhKXy4/QNX0MIdvUZev+nWhmvdG6oWhSDm3hT8Qjj8v?=
 =?us-ascii?Q?8bRGJ1xea9LJWHiIQNinFXGwcmZoLGYHS0ZYJXzlel9AeKjbrNSQ0C3HFkWS?=
 =?us-ascii?Q?1kR55bjpS3+MVbWAX2p7Q8YJLF2xKOfXUpqeq/Zjgp4wUvUACjAc2YhQnorv?=
 =?us-ascii?Q?v/1iSJQusxLJWjvlfpv0a7Iom9wBWM58jcvIlSY9KCxCAPfkG9q+7Nng2b4Y?=
 =?us-ascii?Q?mjeeMOX2b2Y3oFCz77cMrEtedzzOq19ZbukZi1PGIKTt8Nm38uFX7dWroRcT?=
 =?us-ascii?Q?teLKTvgfhYYRP/8+JnHaXUFIt3GtCEhs97+Ok+ZW5SIWc73T6ct6xODEzKAD?=
 =?us-ascii?Q?LczlHXyy7TVSMbFrMe+yaz+Ucm5H2UQ9nML4AcRHWT1p4l0kYQaY2VgLcMHF?=
 =?us-ascii?Q?CC6sN2JT+/eAnXD9uRnQZcC/UYeWWhquDPXsnzo6kWZY57qjcw/nyBLXe0as?=
 =?us-ascii?Q?aIkqHNc4R2zkb2Vq7lBWMy4S1aHtOYW+qWgNmYS2c2mNj4W9mH1qSHx2yE8Z?=
 =?us-ascii?Q?n6luWxXVDDel9jAOMgPDVoF0oa2mIq2gxZoJCWnUBCKZzgwXImZRYHytrCMe?=
 =?us-ascii?Q?xUWfXhJmW0JcqK5urLurKPkvoKR4TZGBuJg0HiUQPYk7r4bLHu/l+lb68mdf?=
 =?us-ascii?Q?31UQAjSDU/IXrvBsIxZa1jXdKbrygufJLCTLRv8GA36TH1BXu2dqwYEklays?=
 =?us-ascii?Q?VcyGp6vsS5282e54RTapxMUzndUX19d7BFOxTq37dXo4wOHzNYpN/KyZ3pYP?=
 =?us-ascii?Q?H9LbQoeZlk/EmslIJcZkQPXNpaN8WlRbhoDrIpcrUzy/yIzTemPVMUkybTQ0?=
 =?us-ascii?Q?A2yMNJju41eUm0Dx5Qku7/316j+9Lqs/cNx92LpjBpZ+w8/iR85NrYk6I2DT?=
 =?us-ascii?Q?cfk9Zr69NrwHOSKrkG9w6Ve1WjUFQ7A/UwBKy9CTMxd/bIMQfyNgvGRbKZ1J?=
 =?us-ascii?Q?zzRTCXSYko8Sp0Bfe6z3li2iJDWjVEHTHF4yhtCl3D0MqzvP6MGB1hkz7L8z?=
 =?us-ascii?Q?VO2i/TUG0UkFZoJGNBxfnKH0f+yO9pQeBR3kMonmsaE5UlLLV3CHBQIx9NrH?=
 =?us-ascii?Q?TZo+WMp9SrBi5Y5Xh/jJ+7ndDTTFyVKZE4ZjbFRgyOA5YKdyWpDBWUd1z/AX?=
 =?us-ascii?Q?1I+eAKXjQQ4N0tQ3KQZ/F6OTr3xfudqtZtyPEqgsJY5IGWEXEgx2nRHYnfyj?=
 =?us-ascii?Q?mI9l1jOSW+hy492wV5MUz3QifsSoZrbOfXidxQpaNLVLZoAqmXFO3Z5QJckj?=
 =?us-ascii?Q?PeAZv4BBza2kpVpWEKHHCLE=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ed14570-4f12-446f-3fb8-08de15bfb37f
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 01:17:02.8788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eTOpJRBa+Gz5P5/j1tHDPKjdiMEjslC3EX2bJQXMw5ODD5WFJahvp8VYSr+7EE4hoLZTAUmgmkDrgrzbxwSYTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB6230

On Mon, Oct 27, 2025 at 08:50:15AM -0700, Dave Jiang wrote:
> 
> 
> On 10/26/25 5:43 PM, Koichiro Den wrote:
> > The reclamation delay of ntb_queue_entry can be a key performance
> > limiter and the MEMCPY portion often accounts for a large part of the
> > round-trip latency when DMA MEMCPY is used. Distributing work across
> > multiple channels can improve overall throughput on busy systems by
> > increasing the average service rate of the MEMCPY part, as observed on
> > R-Car S4.
> > 
> > Allow ntb_transport to use multiple DMA engine channels per queue to
> > better utilize hardware under load with the new module parameters:
> > 
> >   - num_tx_dma_chan: TX DMA channels per queue (default 1)
> >   - num_rx_dma_chan: RX DMA channels per queue (default 1)
> > 
> > Channel selection is a simple round-robin driven by an atomic counter.
> > A least-used policy was also tested on R-Car S4, but showed not much
> > benefit, so the simpler round-robin approach is chosen.
> > 
> > Behavior is unchanged when DMA is disabled or only one channel is used,
> > and the CPU memcpy fallback remains.
> > 
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> 
> Thanks for adding the improvements!
> 
> Is it possible to split the tx and rx changes for this patch? May help with git bisect in the future if there are problems in one of the paths. Otherwise the series LGTM.

That sounds reasonable. I'll do so, let me prepare v2.
Thanks for the review.

-Koichiro

> 
> DJ
> 
> > ---
> >  drivers/ntb/ntb_transport.c | 368 ++++++++++++++++++++++++------------
> >  1 file changed, 252 insertions(+), 116 deletions(-)
> > 
> > diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> > index aee6793812bc..1860e15295b3 100644
> > --- a/drivers/ntb/ntb_transport.c
> > +++ b/drivers/ntb/ntb_transport.c
> > @@ -47,6 +47,7 @@
> >   * Contact Information:
> >   * Jon Mason <jon.mason@intel.com>
> >   */
> > +#include <linux/atomic.h>
> >  #include <linux/debugfs.h>
> >  #include <linux/delay.h>
> >  #include <linux/dmaengine.h>
> > @@ -102,6 +103,14 @@ static bool use_rx_dma;
> >  module_param(use_rx_dma, bool, 0644);
> >  MODULE_PARM_DESC(use_rx_dma, "Use DMA engine to perform large data copy on RX");
> >  
> > +static unsigned int num_tx_dma_chan = 1;
> > +module_param(num_tx_dma_chan, uint, 0644);
> > +MODULE_PARM_DESC(num_tx_dma_chan, "Number of TX DMA channels per queue (round-robin). 1 by default");
> > +
> > +static unsigned int num_rx_dma_chan = 1;
> > +module_param(num_rx_dma_chan, uint, 0644);
> > +MODULE_PARM_DESC(num_rx_dma_chan, "Number of RX DMA channels per queue (round-robin). 1 by default");
> > +
> >  static bool use_msi;
> >  #ifdef CONFIG_NTB_MSI
> >  module_param(use_msi, bool, 0644);
> > @@ -137,12 +146,21 @@ struct ntb_rx_info {
> >  	unsigned int entry;
> >  };
> >  
> > +struct ntb_transport_dma {
> > +	struct dma_chan **chan;
> > +	unsigned int num_chan;
> > +	atomic_t cur_chan;
> > +	/* cache for graceful teardown */
> > +	dma_cookie_t *last_cookie;
> > +};
> > +
> >  struct ntb_transport_qp {
> >  	struct ntb_transport_ctx *transport;
> >  	struct ntb_dev *ndev;
> >  	void *cb_data;
> > -	struct dma_chan *tx_dma_chan;
> > -	struct dma_chan *rx_dma_chan;
> > +
> > +	struct ntb_transport_dma tx_dma;
> > +	struct ntb_transport_dma rx_dma;
> >  
> >  	bool client_ready;
> >  	bool link_is_up;
> > @@ -161,7 +179,7 @@ struct ntb_transport_qp {
> >  	void __iomem *tx_mw;
> >  	phys_addr_t tx_mw_phys;
> >  	size_t tx_mw_size;
> > -	dma_addr_t tx_mw_dma_addr;
> > +	dma_addr_t *tx_mw_dma_addr;
> >  	unsigned int tx_index;
> >  	unsigned int tx_max_entry;
> >  	unsigned int tx_max_frame;
> > @@ -178,7 +196,6 @@ struct ntb_transport_qp {
> >  	unsigned int rx_max_entry;
> >  	unsigned int rx_max_frame;
> >  	unsigned int rx_alloc_entry;
> > -	dma_cookie_t last_cookie;
> >  	struct tasklet_struct rxc_db_work;
> >  
> >  	void (*event_handler)(void *data, int status);
> > @@ -549,10 +566,10 @@ static ssize_t debugfs_read(struct file *filp, char __user *ubuf, size_t count,
> >  			       "\n");
> >  	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> >  			       "Using TX DMA - \t%s\n",
> > -			       qp->tx_dma_chan ? "Yes" : "No");
> > +			       qp->tx_dma.num_chan > 0 ? "Yes" : "No");
> >  	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> >  			       "Using RX DMA - \t%s\n",
> > -			       qp->rx_dma_chan ? "Yes" : "No");
> > +			       qp->rx_dma.num_chan > 0 ? "Yes" : "No");
> >  	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> >  			       "QP Link - \t%s\n",
> >  			       qp->link_is_up ? "Up" : "Down");
> > @@ -1559,16 +1576,43 @@ static inline struct page *ntb_vaddr_to_page(const void *addr)
> >  	return is_vmalloc_addr(addr) ? vmalloc_to_page(addr) : virt_to_page(addr);
> >  }
> >  
> > +static inline struct dma_chan *
> > +ntb_pick_dma_chan(struct ntb_transport_dma *dma, unsigned int *idx_out)
> > +{
> > +	unsigned int n = dma->num_chan;
> > +	unsigned int cur, idx;
> > +
> > +	if (unlikely(!n))
> > +		return NULL;
> > +
> > +	if (n == 1) {
> > +		if (idx_out)
> > +			*idx_out = 0;
> > +		return dma->chan[0];
> > +	}
> > +
> > +	cur = (unsigned int)atomic_inc_return(&dma->cur_chan) - 1;
> > +	idx = cur % n;
> > +	if (idx_out)
> > +		*idx_out = idx;
> > +	return dma->chan[idx];
> > +}
> > +
> >  static int ntb_async_rx_submit(struct ntb_queue_entry *entry, void *offset)
> >  {
> > -	struct dma_async_tx_descriptor *txd;
> >  	struct ntb_transport_qp *qp = entry->qp;
> > -	struct dma_chan *chan = qp->rx_dma_chan;
> > -	struct dma_device *device;
> > -	size_t pay_off, buff_off, len;
> > +	struct dma_async_tx_descriptor *txd;
> >  	struct dmaengine_unmap_data *unmap;
> > -	dma_cookie_t cookie;
> > +	size_t pay_off, buff_off, len;
> > +	struct dma_device *device;
> >  	void *buf = entry->buf;
> > +	struct dma_chan *chan;
> > +	unsigned int cidx = 0;
> > +	dma_cookie_t cookie;
> > +
> > +	chan = ntb_pick_dma_chan(&qp->rx_dma, &cidx);
> > +	if (unlikely(!chan))
> > +		return -ENODEV;
> >  
> >  	len = entry->len;
> >  	device = chan->device;
> > @@ -1613,7 +1657,9 @@ static int ntb_async_rx_submit(struct ntb_queue_entry *entry, void *offset)
> >  
> >  	dmaengine_unmap_put(unmap);
> >  
> > -	qp->last_cookie = cookie;
> > +	dma_async_issue_pending(chan);
> > +
> > +	qp->rx_dma.last_cookie[cidx] = cookie;
> >  
> >  	qp->rx_async++;
> >  
> > @@ -1630,10 +1676,9 @@ static int ntb_async_rx_submit(struct ntb_queue_entry *entry, void *offset)
> >  static void ntb_async_rx(struct ntb_queue_entry *entry, void *offset)
> >  {
> >  	struct ntb_transport_qp *qp = entry->qp;
> > -	struct dma_chan *chan = qp->rx_dma_chan;
> >  	int res;
> >  
> > -	if (!chan)
> > +	if (!qp->rx_dma.chan)
> >  		goto err;
> >  
> >  	if (entry->len < copy_bytes)
> > @@ -1742,9 +1787,6 @@ static void ntb_transport_rxc_db(unsigned long data)
> >  			break;
> >  	}
> >  
> > -	if (i && qp->rx_dma_chan)
> > -		dma_async_issue_pending(qp->rx_dma_chan);
> > -
> >  	if (i == qp->rx_max_entry) {
> >  		/* there is more work to do */
> >  		if (qp->active)
> > @@ -1842,17 +1884,22 @@ static int ntb_async_tx_submit(struct ntb_transport_qp *qp,
> >  			       struct ntb_queue_entry *entry)
> >  {
> >  	struct dma_async_tx_descriptor *txd;
> > -	struct dma_chan *chan = qp->tx_dma_chan;
> > +	struct dmaengine_unmap_data *unmap;
> >  	struct dma_device *device;
> > +	size_t dest_off, buff_off;
> >  	size_t len = entry->len;
> >  	void *buf = entry->buf;
> > -	size_t dest_off, buff_off;
> > -	struct dmaengine_unmap_data *unmap;
> > -	dma_addr_t dest;
> > +	struct dma_chan *chan;
> > +	unsigned int cidx = 0;
> >  	dma_cookie_t cookie;
> > +	dma_addr_t dest;
> > +
> > +	chan = ntb_pick_dma_chan(&qp->tx_dma, &cidx);
> > +	if (unlikely(!chan))
> > +		return -ENODEV;
> >  
> >  	device = chan->device;
> > -	dest = qp->tx_mw_dma_addr + qp->tx_max_frame * entry->tx_index;
> > +	dest = qp->tx_mw_dma_addr[cidx] + qp->tx_max_frame * entry->tx_index;
> >  	buff_off = (size_t)buf & ~PAGE_MASK;
> >  	dest_off = (size_t)dest & ~PAGE_MASK;
> >  
> > @@ -1901,7 +1948,6 @@ static void ntb_async_tx(struct ntb_transport_qp *qp,
> >  			 struct ntb_queue_entry *entry)
> >  {
> >  	struct ntb_payload_header __iomem *hdr;
> > -	struct dma_chan *chan = qp->tx_dma_chan;
> >  	void __iomem *offset;
> >  	int res;
> >  
> > @@ -1913,7 +1959,7 @@ static void ntb_async_tx(struct ntb_transport_qp *qp,
> >  	iowrite32(entry->len, &hdr->len);
> >  	iowrite32((u32)qp->tx_pkts, &hdr->ver);
> >  
> > -	if (!chan)
> > +	if (!qp->tx_dma.chan)
> >  		goto err;
> >  
> >  	if (entry->len < copy_bytes)
> > @@ -1999,8 +2045,99 @@ static bool ntb_dma_filter_fn(struct dma_chan *chan, void *node)
> >  	return dev_to_node(&chan->dev->device) == (int)(unsigned long)node;
> >  }
> >  
> > +static void ntb_transport_teardown_dma(struct ntb_transport_dma *dma,
> > +				       dma_addr_t *mem, size_t size)
> > +{
> > +	struct dma_chan *chan;
> > +	unsigned int i;
> > +
> > +	if (!dma)
> > +		return;
> > +
> > +	if (!dma->chan) {
> > +		kfree(dma->last_cookie);
> > +		dma->last_cookie = NULL;
> > +		return;
> > +	}
> > +
> > +	for (i = 0; i < dma->num_chan; i++) {
> > +		chan = dma->chan[i];
> > +		if (!chan)
> > +			continue;
> > +
> > +		if (dma->last_cookie)
> > +			/* Try to be nice and wait for any queued DMA engine
> > +			 * transactions to process before smashing it with a rock
> > +			 */
> > +			dma_sync_wait(chan, dma->last_cookie[i]);
> > +
> > +		dmaengine_terminate_all(chan);
> > +		if (mem && mem[i])
> > +			dma_unmap_resource(chan->device->dev, mem[i], size,
> > +					   DMA_FROM_DEVICE, 0);
> > +		dma_release_channel(chan);
> > +		dma->chan[i] = NULL;
> > +	}
> > +
> > +	kfree(dma->chan);
> > +	kfree(dma->last_cookie);
> > +	dma->chan = NULL;
> > +	dma->num_chan = 0;
> > +	dma->last_cookie = NULL;
> > +}
> > +
> > +static unsigned int ntb_transport_setup_dma(struct pci_dev *pdev,
> > +					    struct ntb_transport_dma *dma,
> > +					    unsigned int req, int node)
> > +{
> > +	dma_cap_mask_t dma_mask;
> > +	struct dma_chan *c;
> > +	unsigned int i = 0;
> > +
> > +	dma_cap_zero(dma_mask);
> > +	dma_cap_set(DMA_MEMCPY, dma_mask);
> > +
> > +	dma->last_cookie = NULL;
> > +	dma->num_chan = 0;
> > +	dma->chan = kcalloc_node(req, sizeof(*dma->chan), GFP_KERNEL, node);
> > +	if (!dma->chan) {
> > +		dev_info(&pdev->dev, "Unable to alloc DMA arrays\n");
> > +		return 0;
> > +	}
> > +
> > +	atomic_set(&dma->cur_chan, 0);
> > +	for (i = 0; i < req; i++) {
> > +		c = dma_request_channel(dma_mask, ntb_dma_filter_fn,
> > +					(void *)(unsigned long)node);
> > +		if (!c) {
> > +			if (!i)
> > +				dev_info(&pdev->dev,
> > +					 "Unable to allocate DMA channel(s)\n");
> > +			break;
> > +		}
> > +		dma->chan[i] = c;
> > +		dma->num_chan++;
> > +	}
> > +	if (!dma->num_chan)
> > +		goto err_out;
> > +
> > +	dma->last_cookie = kcalloc_node(dma->num_chan, sizeof(dma_cookie_t),
> > +					GFP_KERNEL, node);
> > +	if (!dma->last_cookie)
> > +		goto err_out;
> > +
> > +	return dma->num_chan;
> > +
> > +err_out:
> > +	for (i = 0; i < dma->num_chan; i++)
> > +		dma_release_channel(dma->chan[i]);
> > +	kfree(dma->chan);
> > +	dma->chan = NULL;
> > +	dma->num_chan = 0;
> > +	return 0;
> > +}
> > +
> >  /**
> > - * ntb_transport_create_queue - Create a new NTB transport layer queue
> >   * @data: pointer for callback data
> >   * @client_dev: &struct device pointer
> >   * @handlers: pointer to various ntb queue (callback) handlers
> > @@ -2024,7 +2161,8 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
> >  	struct ntb_transport_qp *qp;
> >  	u64 qp_bit;
> >  	unsigned int free_queue;
> > -	dma_cap_mask_t dma_mask;
> > +	struct dma_chan *c;
> > +	dma_addr_t mw_dma;
> >  	int node;
> >  	int i;
> >  
> > @@ -2036,7 +2174,7 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
> >  
> >  	free_queue = ffs(nt->qp_bitmap_free);
> >  	if (!free_queue)
> > -		goto err;
> > +		return NULL;
> >  
> >  	/* decrement free_queue to make it zero based */
> >  	free_queue--;
> > @@ -2051,54 +2189,70 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
> >  	qp->tx_handler = handlers->tx_handler;
> >  	qp->event_handler = handlers->event_handler;
> >  
> > -	dma_cap_zero(dma_mask);
> > -	dma_cap_set(DMA_MEMCPY, dma_mask);
> > -
> >  	if (use_dma) {
> >  		use_tx_dma = true;
> >  		use_rx_dma = true;
> >  	}
> > -	if (use_tx_dma) {
> > -		qp->tx_dma_chan =
> > -			dma_request_channel(dma_mask, ntb_dma_filter_fn,
> > -					    (void *)(unsigned long)node);
> > -		if (!qp->tx_dma_chan)
> > -			dev_info(&pdev->dev, "Unable to allocate TX DMA channel\n");
> > -	} else
> > -		qp->tx_dma_chan = NULL;
> > -
> > -	if (use_rx_dma) {
> > -		qp->rx_dma_chan =
> > -			dma_request_channel(dma_mask, ntb_dma_filter_fn,
> > -					    (void *)(unsigned long)node);
> > -		if (!qp->rx_dma_chan)
> > -			dev_info(&pdev->dev, "Unable to allocate RX DMA channel\n");
> > -	} else
> > -		qp->rx_dma_chan = NULL;
> > -
> > -	qp->tx_mw_dma_addr = 0;
> > -	if (qp->tx_dma_chan) {
> > -		qp->tx_mw_dma_addr =
> > -			dma_map_resource(qp->tx_dma_chan->device->dev,
> > -					 qp->tx_mw_phys, qp->tx_mw_size,
> > -					 DMA_FROM_DEVICE, 0);
> > -		if (dma_mapping_error(qp->tx_dma_chan->device->dev,
> > -				      qp->tx_mw_dma_addr)) {
> > -			qp->tx_mw_dma_addr = 0;
> > -			goto err1;
> > +
> > +	/* setup TX dma if requested */
> > +	qp->tx_dma.chan = NULL;
> > +	qp->tx_dma.num_chan = 0;
> > +	if (use_tx_dma)
> > +		ntb_transport_setup_dma(pdev, &qp->tx_dma, num_tx_dma_chan ?: 1,
> > +					node);
> > +
> > +	/* setup RX dma if requested */
> > +	qp->rx_dma.chan = NULL;
> > +	qp->rx_dma.num_chan = 0;
> > +	if (use_rx_dma)
> > +		ntb_transport_setup_dma(pdev, &qp->rx_dma, num_rx_dma_chan ?: 1,
> > +					node);
> > +
> > +	/* setup TX dma dest map */
> > +	if (qp->tx_dma.num_chan > 0) {
> > +		qp->tx_mw_dma_addr = kcalloc_node(qp->tx_dma.num_chan,
> > +				sizeof(*qp->tx_mw_dma_addr), GFP_KERNEL, node);
> > +		if (!qp->tx_mw_dma_addr)
> > +			/* this sets qp->tx_dma.num_chan back to 0 */
> > +			ntb_transport_teardown_dma(&qp->tx_dma, NULL, 0);
> > +
> > +		for (i = 0; i < qp->tx_dma.num_chan; i++) {
> > +			c = qp->tx_dma.chan[i];
> > +			mw_dma = dma_map_resource(c->device->dev,
> > +						  qp->tx_mw_phys,
> > +						  qp->tx_mw_size,
> > +						  DMA_FROM_DEVICE, 0);
> > +			if (dma_mapping_error(c->device->dev, mw_dma)) {
> > +				dev_info(&pdev->dev,
> > +					 "TX MW dma_map_resource failed for channel %u\n", i);
> > +				break;
> > +			}
> > +			qp->tx_mw_dma_addr[i] = mw_dma;
> >  		}
> > +		if (qp->tx_dma.num_chan > 0 && i < qp->tx_dma.num_chan)
> > +			/* this sets qp->tx_dma.num_chan back to 0 */
> > +			ntb_transport_teardown_dma(&qp->tx_dma,
> > +						   qp->tx_mw_dma_addr,
> > +						   qp->tx_mw_size);
> >  	}
> >  
> > -	dev_dbg(&pdev->dev, "Using %s memcpy for TX\n",
> > -		qp->tx_dma_chan ? "DMA" : "CPU");
> > +	if (qp->tx_dma.num_chan > 0)
> > +		dev_dbg(&pdev->dev, "Using DMA memcpy for TX (num_chan = %u)\n",
> > +			qp->tx_dma.num_chan);
> > +	else
> > +		dev_dbg(&pdev->dev, "Using CPU memcpy for TX\n");
> >  
> > -	dev_dbg(&pdev->dev, "Using %s memcpy for RX\n",
> > -		qp->rx_dma_chan ? "DMA" : "CPU");
> > +	if (qp->rx_dma.num_chan > 0)
> > +		dev_dbg(&pdev->dev, "Using DMA memcpy for RX (num_chan = %u)\n",
> > +			qp->rx_dma.num_chan);
> > +	else
> > +		dev_dbg(&pdev->dev, "Using CPU memcpy for RX\n");
> >  
> > +	/* alloc and link entries */
> >  	for (i = 0; i < NTB_QP_DEF_NUM_ENTRIES; i++) {
> >  		entry = kzalloc_node(sizeof(*entry), GFP_KERNEL, node);
> >  		if (!entry)
> > -			goto err1;
> > +			goto err;
> >  
> >  		entry->qp = qp;
> >  		ntb_list_add(&qp->ntb_rx_q_lock, &entry->entry,
> > @@ -2109,7 +2263,7 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
> >  	for (i = 0; i < qp->tx_max_entry; i++) {
> >  		entry = kzalloc_node(sizeof(*entry), GFP_KERNEL, node);
> >  		if (!entry)
> > -			goto err2;
> > +			goto err;
> >  
> >  		entry->qp = qp;
> >  		ntb_list_add(&qp->ntb_tx_free_q_lock, &entry->entry,
> > @@ -2123,23 +2277,20 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
> >  
> >  	return qp;
> >  
> > -err2:
> > +err:
> >  	while ((entry = ntb_list_rm(&qp->ntb_tx_free_q_lock, &qp->tx_free_q)))
> >  		kfree(entry);
> > -err1:
> > -	qp->rx_alloc_entry = 0;
> >  	while ((entry = ntb_list_rm(&qp->ntb_rx_q_lock, &qp->rx_free_q)))
> >  		kfree(entry);
> > -	if (qp->tx_mw_dma_addr)
> > -		dma_unmap_resource(qp->tx_dma_chan->device->dev,
> > -				   qp->tx_mw_dma_addr, qp->tx_mw_size,
> > -				   DMA_FROM_DEVICE, 0);
> > -	if (qp->tx_dma_chan)
> > -		dma_release_channel(qp->tx_dma_chan);
> > -	if (qp->rx_dma_chan)
> > -		dma_release_channel(qp->rx_dma_chan);
> > +	qp->rx_alloc_entry = 0;
> > +
> > +	ntb_transport_teardown_dma(&qp->rx_dma, NULL, 0);
> > +	ntb_transport_teardown_dma(&qp->tx_dma, qp->tx_mw_dma_addr,
> > +				   qp->tx_mw_size);
> > +	kfree(qp->tx_mw_dma_addr);
> > +	qp->tx_mw_dma_addr = NULL;
> > +
> >  	nt->qp_bitmap_free |= qp_bit;
> > -err:
> >  	return NULL;
> >  }
> >  EXPORT_SYMBOL_GPL(ntb_transport_create_queue);
> > @@ -2163,40 +2314,11 @@ void ntb_transport_free_queue(struct ntb_transport_qp *qp)
> >  
> >  	qp->active = false;
> >  
> > -	if (qp->tx_dma_chan) {
> > -		struct dma_chan *chan = qp->tx_dma_chan;
> > -		/* Putting the dma_chan to NULL will force any new traffic to be
> > -		 * processed by the CPU instead of the DAM engine
> > -		 */
> > -		qp->tx_dma_chan = NULL;
> > -
> > -		/* Try to be nice and wait for any queued DMA engine
> > -		 * transactions to process before smashing it with a rock
> > -		 */
> > -		dma_sync_wait(chan, qp->last_cookie);
> > -		dmaengine_terminate_all(chan);
> > -
> > -		dma_unmap_resource(chan->device->dev,
> > -				   qp->tx_mw_dma_addr, qp->tx_mw_size,
> > -				   DMA_FROM_DEVICE, 0);
> > -
> > -		dma_release_channel(chan);
> > -	}
> > -
> > -	if (qp->rx_dma_chan) {
> > -		struct dma_chan *chan = qp->rx_dma_chan;
> > -		/* Putting the dma_chan to NULL will force any new traffic to be
> > -		 * processed by the CPU instead of the DAM engine
> > -		 */
> > -		qp->rx_dma_chan = NULL;
> > -
> > -		/* Try to be nice and wait for any queued DMA engine
> > -		 * transactions to process before smashing it with a rock
> > -		 */
> > -		dma_sync_wait(chan, qp->last_cookie);
> > -		dmaengine_terminate_all(chan);
> > -		dma_release_channel(chan);
> > -	}
> > +	ntb_transport_teardown_dma(&qp->rx_dma, NULL, 0);
> > +	ntb_transport_teardown_dma(&qp->tx_dma, qp->tx_mw_dma_addr,
> > +				   qp->tx_mw_size);
> > +	kfree(qp->tx_mw_dma_addr);
> > +	qp->tx_mw_dma_addr = NULL;
> >  
> >  	qp_bit = BIT_ULL(qp->qp_num);
> >  
> > @@ -2444,17 +2566,31 @@ EXPORT_SYMBOL_GPL(ntb_transport_qp_num);
> >  unsigned int ntb_transport_max_size(struct ntb_transport_qp *qp)
> >  {
> >  	unsigned int max_size;
> > -	unsigned int copy_align;
> > +	unsigned int copy_align = 0;
> >  	struct dma_chan *rx_chan, *tx_chan;
> > +	unsigned int i;
> >  
> >  	if (!qp)
> >  		return 0;
> >  
> > -	rx_chan = qp->rx_dma_chan;
> > -	tx_chan = qp->tx_dma_chan;
> > -
> > -	copy_align = max(rx_chan ? rx_chan->device->copy_align : 0,
> > -			 tx_chan ? tx_chan->device->copy_align : 0);
> > +	if (qp->rx_dma.chan) {
> > +		for (i = 0; i < qp->rx_dma.num_chan; i++) {
> > +			rx_chan = qp->rx_dma.chan[i];
> > +			if (!rx_chan)
> > +				continue;
> > +			copy_align = max(copy_align,
> > +					 rx_chan->device->copy_align);
> > +		}
> > +	}
> > +	if (qp->tx_dma.chan) {
> > +		for (i = 0; i < qp->tx_dma.num_chan; i++) {
> > +			tx_chan = qp->tx_dma.chan[i];
> > +			if (!tx_chan)
> > +				continue;
> > +			copy_align = max(copy_align,
> > +					 tx_chan->device->copy_align);
> > +		}
> > +	}
> >  
> >  	/* If DMA engine usage is possible, try to find the max size for that */
> >  	max_size = qp->tx_max_frame - sizeof(struct ntb_payload_header);
> 
