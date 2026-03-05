Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021119.outbound.protection.outlook.com [40.107.74.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B02140E5F
	for <ntb@lists.linux.dev>; Thu,  5 Mar 2026 03:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772681013; cv=fail; b=s6wmBfZlKMRxtNln06MXnLl/KZh7uqQOmiDheC3WqkZuIsyhRbFndUFcfErhcLTAyld4GCyXBFRvBjoP43nZIee5q5xzYxo7QsYG0ELcxUp37BJ7cC0v6J+3jBAG1nSz4ZoDNHxzPZuz6SWm8wr4S4e8Sw5IoJ2xmP11mFIAbE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772681013; c=relaxed/simple;
	bh=Yghuj33Ebb8xiUr7EjYf59HdHtdimPbflrsEmQQvrtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=j3FeLx/vEVTMAcUyh/la5M7XHzKxXk3St936b/BExD9adYUTu1LTaqrdH0hUcEybHNj5Ud/PlckswJhIUCAmyGrODYDDJ+tA1tpTH8Amk8TySJyX0DW6yiZqVmgin0pCJWGz5/U9D5KN/JtLqyizW2O7ptsozThNoKBppRl0UI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=tdT9XiSr; arc=fail smtp.client-ip=40.107.74.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="tdT9XiSr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UGac0g6wNWZV5HWpbel9vNoal1MdoUmM+DgjKJF88kD0a3JmhflI27Uka6x3EXVdhMZlyjRiYx/DXy5OLSZkHVZjpjigbGId+rLExbVuCFHiJ8Y13dy3qqBHsOA3EmLe96gvfE6qTT3OE4rE0h/gs0r4Ca4obxHJzbJqHWS1QvkIrsqG3/y49wSqVNZ/t86lZTTAgdIP5A7+KQHPWTNmPJmjcT6GiYFVyMknbB9heW1Uc+dVz1jMOAKUOD8EwwHOMRv+dtY5bIkOL19Yjgz7jPS+rAvRG3slxuKy43XRJ3IqvumLs5tpCIktkkCDKAfzrkORMe2dnFjNjmdTZorLPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OvZMuZTJdoWVaQWvAuBDEbtvXy6T7fdICfbyloDY90U=;
 b=tDK7hv4tiM7a79VEqKW/IQRg4OTjz9fk5aVw1XGr0i6og0nQWXlHdRIxbOsbOU6AXEQzliukjXxWzJxtYyoekITJWVI/Mfqoz9oTcQS28B5wcFTUYMuP6ru2OGRKMALcxttMOZIsBbUJagS3rcEd+x8B5zh9W+JQdc2O84OE4LyEjM/BhwQhhVN+r0XvBDL35ldk48/+DH7JicY11ApTduzkpPsKx8jXLswioXijzEAW23iLCZdd/SgzMxTvDI4IKgUeNH1nJ/HINSmOXNaTGhBfrPzv71Fs/1sRBprcdpSOyx+Lia69LI8ML4LvXUCsNvBEqRcXJx/GxBLR6e2yOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OvZMuZTJdoWVaQWvAuBDEbtvXy6T7fdICfbyloDY90U=;
 b=tdT9XiSr0yK0NkWf5y5Iz4XGfgd9rCZnx7Bv2nFZL34PdDcDg6TFcjs10Lx85CEv+uM/cPNAdFZVTloc6ZHs2rtyx6FM/fl3qfFyi3XZFss3hX8ba44R07dPn3fuyKnVtCvicoM5mj5xC2SHUzLlqaImfSmAOPIyAvq0v7t3ntA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYYP286MB4512.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:197::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Thu, 5 Mar
 2026 03:23:29 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9678.016; Thu, 5 Mar 2026
 03:23:27 +0000
Date: Thu, 5 Mar 2026 12:23:25 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Dave Jiang <dave.jiang@intel.com>, Jon Mason <jdmason@kudzu.us>
Cc: Allen Hubbe <allenbh@gmail.com>, Frank Li <Frank.Li@nxp.com>, 
	Niklas Cassel <cassel@kernel.org>, ntb@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] NTB: Allow drivers to provide DMA mapping device
Message-ID: <lwayvep2vqwplyc45nr45zcz7rawutxe6q637p6gagw6asmlu3@ohqlnlmoymwl>
References: <20260302144522.750620-1-den@valinux.co.jp>
 <3ddba488-6577-4f04-8a50-d64850b7cc5b@intel.com>
 <2jb2u6hm2u7dcmexzhi45kaclgfysfhr3nxomvqfnxbp5dlwfx@dt7hraa6u52v>
 <244af3c1-21f4-4023-b465-0ccd85e1eb79@intel.com>
 <lycec7prrdejp3mpzrn5rzh5252vi7c7yypjiggrr74mcutdvq@y7kzzjm332rm>
 <b17c238b-3d0a-49b3-a012-a6e33766b8b0@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b17c238b-3d0a-49b3-a012-a6e33766b8b0@intel.com>
X-ClientProxiedBy: TYCP286CA0186.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:382::14) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYYP286MB4512:EE_
X-MS-Office365-Filtering-Correlation-Id: 14b14df9-c2aa-47d0-20ee-08de7a6690e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|27256017;
X-Microsoft-Antispam-Message-Info:
	hjJ2SV/+hM5wN2cYqMN2zM4jrgTUGuHDo3H4NoB7gdVmsU9CW7Y6Gc9N0FWQs/ZOLfPFLWBjOXipLnqGc/7gaQOHwFZN6rlE/gas5A1awgzJcFSUrEvhRJCcMCaeA8Gbd03PjvzY00UjrLTIE+VO4X+Bd1A0aersmQYlDfXcvHyaJameZiKm9tcI5FVd98JjMeuCNZLOqyz+Wri/57JoOUdarVn0u073Cxsmyp0NuxnnGt2Vh0l0I9c+f3iicKUo5u78JpTdy5M4KVEOSDxFTnXbK5Pm4JYeT8FIBQZkKpC/Qmb5kdPizk7dnOeTigbm40IXcF25UiYqfiEKwFy9Su8qwdMwLK7r2FTj+Xd9fl97ayVIcC+cVfVj4Wzj40eeSAPHERrYgDUAS3APmrBykdHqzkQuYRXmpw1pH2S6rmZyeBiubPU65TlNaA9Xht3AgzPou6Tb7kkkbcIvTudBV7pVWwzk0fToYFe/rEhw8LmP5v/3Bi0cO9TYcxIYCbppqIfd0Sci4EGgxTPbPpixjBpw/c0jIZcOxvG0iV6aj5lbXC9w/v8UNyvf7T0sgx1j4xWx192E1L88GzaZeHyVrcda5qtXInfl5ndGLTkdZqzCcqD59qrRgxgBKD1sD3FdAdseTGhcLM3gjqI8tCZjsT6TIM1XH7YKD04DzDwvS00fcGhY7GTLKFQH4m1M3j/JBVNS8y7slk2VxsHQ+3Q+n9jtc1p1vqeRTHrBiL8jBVlcYfUyQhLXx0sZPnYQ4eYLTfwqEW1tlecfUtZSJXEWFMaeyyvZzuyn4eXrl3Uaz9c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(27256017);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VrEQIq/GQY6Ej2oUj1HRNDoLNaPWf4+otZzIxPp+QAGAtgM+O5gfl1ccuwTI?=
 =?us-ascii?Q?9vaxm4UJcCDR0R6pCZSMreQo+N6775jZFeex1UjEOrCvxkYaM8l8hjnCKzpC?=
 =?us-ascii?Q?Ok6ghU/9pQjFzCzwiJQUTF3G7319TL610w/Tw6RkNrBt6XofZa7+9v5ekXSF?=
 =?us-ascii?Q?CCj4H1ZoqbRwQBcvwi9hPhkqImmojHCfROJZ0Y/yOi3DTVzbdLnYYT7KsAUr?=
 =?us-ascii?Q?1pvnPWB06Vnnk3Ou6JG8gzRRQs+NzmWq4gYRq1HgT8q77Nxk7pgxNsdy4Jg4?=
 =?us-ascii?Q?xg/LxNWsmq/Qp9iX3vhWScjimtEpfQdsRuIXacW5HvXCvrByl3xQIXDZ5PHy?=
 =?us-ascii?Q?yASgrRaZJObdv2Iw9fPrQyDQY8p2Gi1BHbuq/g5fep4T0eJarln82o22zeZR?=
 =?us-ascii?Q?X0W0cuoBs70zMR2b4zCPZu+PKZv7nkIiDo8h1byOStaeWhGD2o/iHKgxamXN?=
 =?us-ascii?Q?aDUO2SO/BDSMPEqmtbmXu9cCqREgm7Q2XHUzjeFla3GQ6nVI1sVd81UesF6N?=
 =?us-ascii?Q?VvsXyapTkukd+5776OS1A74dLvJFTx+9Wa0eiPCJttkWcr9R7aOT9ccJyOSa?=
 =?us-ascii?Q?TFF+P42bPpaeP5uEcRuShB0FpPybzpFNQBdkVQ16jdqdxCmoB2B5r2j/pBGG?=
 =?us-ascii?Q?+QgDeKNQPnfG9lf0VR5jiA324zsu1qSfvjRUhOrF2g6dK54qzPIjz5/HAXtL?=
 =?us-ascii?Q?KXCbT5H/wzER1yrkj8VR4QPaLzv6tYU4IuOICyuX2fdYqKa84S7pr73B4hlV?=
 =?us-ascii?Q?uMYMLQ8hw7ldKkOlJ1MNHIfPq/0QbWjUJJaad5Qk4FjiUkfwCDGcmBab3jnr?=
 =?us-ascii?Q?6yv3H1iQc1buzZ6Maig+VRv+Gd/HuP0P/UcpZ2cHBsFLyKXnZxC94fo5FYBJ?=
 =?us-ascii?Q?JLaYn/7kkZrm+fCv7zr98CI5b21yfTzAUCdizPqF/NvAr19RVOMqCIDKBSTB?=
 =?us-ascii?Q?gLWsVGh/79EWq36kRXcEmPPzw2LCEQl3qAgawl0iE9yfTvcDaceEmnoN2smf?=
 =?us-ascii?Q?N/HdVHFPPZe/KJRyCq88hRi4ElRRXcf7YythiQAdFzv5udSO5Aed4jxakN0F?=
 =?us-ascii?Q?77nN62sWYmK2UCguGpmUlHpJFoeR2l/M2XQblGMIJJ6t1Gok5ivEwQazpzMh?=
 =?us-ascii?Q?MMEWCYcCZ+iQ1v4zwJCojemLhky5m5BDtzYdAsix6kkr+/5kYI0GC+8EZX/t?=
 =?us-ascii?Q?bYJBcto2PR8V7/OlYJezJUXnm3JdjKHfsfX7F/4JAULz50nEvZu7QxPuezT9?=
 =?us-ascii?Q?iB0KKjazfgcK7uSmTe1QWQJ5CT58k5wkInQmer16B8XTiBLtMc+R8Rk6hQUD?=
 =?us-ascii?Q?0R73hftYDf1Kzcy/mPE3/suiuCA/x7YwJFw8jwUZZjbH3Ia64r909RTsUGZI?=
 =?us-ascii?Q?V8h/A8O9u4cgFdZnR5b/87eSvsjTx/k9oK2yP46sUv/GKREIiR2XgZy6Mm0Z?=
 =?us-ascii?Q?nLgFin6m6k4x6etXVsQup4kU41nAM+7uCeYa7fIrUs5jMUJgbP7w2K6qjyZ8?=
 =?us-ascii?Q?78PxohMd+K6kuh2iZW8v1r/dV8lLM1VpT/8mODauc9mXmg3OtSiUiIZAVdBZ?=
 =?us-ascii?Q?S5+9u7DjFR6WjukG6s2lYm2XpNIMikkIda6J8TQLweW5T7nk0EzvK8W1HwOd?=
 =?us-ascii?Q?FSNw7hRxR/Nf8IbukO9vkOTmsSNhePsqLoLQon8U4npsTH0BBow73OSN9R/2?=
 =?us-ascii?Q?VS9o+q5Rhw1gyFCXK3X5ILP47zMbCrgCspxRXWrXhaCRAPTLTvWg/WvuGJMq?=
 =?us-ascii?Q?SQhzfdr60cLPZUXEeGrpcLg/RJNSOvNTKJIRTD+jChpWelqMASLW?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 14b14df9-c2aa-47d0-20ee-08de7a6690e9
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 03:23:27.1507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9dhCYaDRdPl87twbuHMi53iUvlBqFGu7W0V7C/5Ja4H1S9c9nbQxCvrQ3wWbJfd9JgxNzvDnaIhuGd1c3zwAhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB4512

On Wed, Mar 04, 2026 at 09:53:42AM -0700, Dave Jiang wrote:
> 
> 
> On 3/4/26 8:56 AM, Koichiro Den wrote:
> > On Tue, Mar 03, 2026 at 08:42:53AM -0700, Dave Jiang wrote:
> >>
> >>
> >> On 3/2/26 9:56 PM, Koichiro Den wrote:
> >>> On Mon, Mar 02, 2026 at 09:52:08AM -0700, Dave Jiang wrote:
> >>>>
> >>>>
> >>>> On 3/2/26 7:45 AM, Koichiro Den wrote:
> >>>>> Some NTB implementations are backed by a "virtual" PCI device, while the
> >>>>> actual DMA mapping context (IOMMU domain) belongs to a different device.
> >>>>>
> >>>>> One example is vNTB, where the NTB device is represented as a virtual
> >>>>> PCI endpoint function, but DMA operations must be performed against the
> >>>>> EPC parent device, which owns the IOMMU context.
> >>>>>
> >>>>> Today, ntb_transport implicitly relies on the NTB device's parent device
> >>>>> as the DMA mapping device. This works for most PCIe NTB hardware, but
> >>>>> breaks implementations where the NTB PCI function is not the correct
> >>>>> device to use for DMA API operations.
> >>>>
> >>>> Actually it doesn't quite work. This resulted in 061a785a114f ("ntb: Force
> >>>> physically contiguous allocation of rx ring buffers"). As you can see it
> >>>> tries to get around the issue as a temp measure. The main issue is the
> >>>> memory window buffer is allocated before the dmaengine devices are allocated.
> >>>> So the buffer is mapped against the NTB device rather than the DMA device.
> >>>> So I think we may need to come up with a better scheme to clean up this
> >>>> issue as some of the current NTBs can utilize this change as well.
> >>>
> >>> Thanks for the feedback.
> >>>
> >>> I think there are two issues which are related but separable:
> >>>
> >>> - 1). Ensuring the correct DMA-mapping device is used for the MW translation
> >>>       (i.e. inbound accesses from the peer).
> >>> - 2). RX-side DMA memcpy re-maps the MW source buffer against the dmaengine
> >>>       device ("double mapping").
> >>>
> >>> (1) is what this series is addressing. I think this series does not worsen (2).
> >>> I agree that (2) should be improved eventually.
> >>>
> >>> (Note that in some setups such as vNTB, the device returned by ntb_get_dma_dev()
> >>> can be the same as chan->device->dev, in that case the double mapping could be
> >>> optimized away. However, I undersntand that you are talking about a more
> >>> fundamental improvement.)
> >>>
> >>>>
> >>>> The per queue DMA device presents an initialization hierarchy challenge with the
> >>>> memory window context. I'm open to suggestions.  
> >>>
> >>> In my view, what is written in 061a785a114f looks like the most viable long-term
> >>> direction:
> >>>
> >>>     A potential future solution may be having the DMA mapping API providing a
> >>>     way to alias an existing IOVA mapping to a new device perhaps.
> >>>
> >>> I do not immediately see a more practical alternative. E.g., deferring MW
> >>> inbound mapping until ntb_transport_create_queue() would require a substantial
> >>> rework, since dma_chan is determined per-QP at that stage and the mapping would
> >>> become dynamic per subrange. I doubt it would be worth doing or acceptable.
> >>> Pre-allocating dma_chans only for this purpose also seems excessive.
> >>>
> >>> So I agree that (2) needs a clean-up eventually. However, in my opinion the
> >>> problem this series tries to solve is independent, and the approach here does
> >>> not interfere with that direction.
> >>
> >> Fair assessment. For the series:
> >> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > 
> > Thanks for the review.
> > 
> > Once this looks good to Jon as well and gets queued in the NTB tree, I'll submit
> > a small patch to PCI EP for vNTB (the real user of the interface), something
> > like the following:
> > 
> > 
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > index be6c03f4516e..8aeacbae8b77 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > @@ -1501,6 +1501,15 @@ static int vntb_epf_link_disable(struct ntb_dev *ntb)
> >         return 0;
> >  }
> > 
> > +static struct device *vntb_epf_get_dma_dev(struct ntb_dev *ndev)
> > +{
> > +       struct epf_ntb *ntb = ntb_ndev(ndev);
> > +
> > +       if (!ntb || !ntb->epf)
> > +               return NULL;
> > +       return ntb->epf->epc->dev.parent;
> > +}
> > +
> >  static const struct ntb_dev_ops vntb_epf_ops = {
> >         .mw_count               = vntb_epf_mw_count,
> >         .spad_count             = vntb_epf_spad_count,
> > @@ -1522,6 +1531,7 @@ static const struct ntb_dev_ops vntb_epf_ops = {
> >         .db_clear_mask          = vntb_epf_db_clear_mask,
> >         .db_clear               = vntb_epf_db_clear,
> >         .link_disable           = vntb_epf_link_disable,
> > +       .get_dma_dev            = vntb_epf_get_dma_dev,
> >  };
> > 
> >  static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > 
> > 
> 
> Probably should include it with this series if it's small. Having the user with new code is usually preferred.

I thought that, since the vNTB patch wouldn't work until the NTB changes are in,
asking both the NTB and PCI EP maintainers to coordinate the apply order might
be a bit awkward.

That said, if preferable, I can include the vNTB change in this series and
explicitly ask the PCI EP maintainers not to pick up (new) Patch 3 until the NTB
maintainers have acked and applied Patch 1-2.

I'd also appreciate any thoughts from Jon or others on this (i.e. keeping
this series NTB tree-only vs. including the vNTB change as well), as well
as any feedback on this v1 series itself.

P.S. I sent a corrected code snippet a few minutes after my original post. The
original snippet above was wrong, as it would violate the kernel-doc in Patch 1:

  "Drivers that implement .get_dma_dev() must return a non-NULL pointer."

Best regards,
Koichiro

> 
