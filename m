Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020112.outbound.protection.outlook.com [52.101.229.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C70435B14B
	for <ntb@lists.linux.dev>; Wed,  4 Mar 2026 15:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772639781; cv=fail; b=FgDzDvmDqDhJE39lX0WaKlb35UCKokI1D2iZDr8fKieMza2Ko4dLSpcKZAnAAeCiB6XTl5x+WP10lGfkv2utDFIQ66szK5A3RcZ9TqULkJuXVbPPxHIpqJKiaLoF0RGqckTYB0G2Z4OWhp+M+cwEC2WY/wy5qYi8UnCZ/FAIEyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772639781; c=relaxed/simple;
	bh=V1TCPMtx8VYc7VtIf8rkpK2QcubSMQFjKTTEbL0novQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iC7z3BPwRkuziG+mesD2IeQAmTD75Or2y4lOy5W81wrb+JpTe6Wzb8NjKCWK7tBbLTQo5Us9kQkz7WjmDA/EN0ACyzmVUhIQ7VmBw+NTjPCuWt/2veeKhcU9ngvRBIaJYNLngBD6YGp4WVhBqnuiYJGAcbz7BH1syeuaznXY34c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=fCD0mqpn; arc=fail smtp.client-ip=52.101.229.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="fCD0mqpn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aJ9eqZZ+kUV0wU8rA/cvHP9OitfhX7WkHZoky239Zg3tghOp1FpnKlNs79auAmkwsb7NoftrG9UbCssIA4iIdhrSsg0ZJKxobwdptnbHmT5wfesFavJ3GWgDO3YGo3DvgeCl3nnrI43hgwoRAtuJUR+UZ/Hw4qFaYW/tacWlZclwUhzZGa86xo8VFAWkq4DojInrWAtK+1kgJclAYnyZjzYcNoq3Ate93tYEXFwvj9AkG2JmiCJCbWz7TzLgLxE3Y9WVD1QrgGlDRWYVzB5aQemK9o9+XbMrYfKysf6frchCZlUzinJb0Gk5azqaSPlDU9aLgmbQ/jI0ErKGXjgZ4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YbOIHcBI5IZIzvRvN1SVH3bZC0K0Z1cdDqxA3uFwPbc=;
 b=MrfzVmvCGV3LMXEmkN7Wkq8IPQMGxLAFHYZA4Qd84SxBtZe/Gy1fqFagN+ZOcQs74/R/BqXkL0ToB5DDFi2VxRgJzmuIP4gvxttYkWrEpTmGXY4/hgslQ1jX7IcplfdnRJtWwNmriXhvdwIiptyUn3NxaAA8YqLYwlhsMq38RV5RWaD2IJAJLWvj3PYCLTP4zyugJm/m96w7PU9HOv6e6PKWygwFx/2qyNj8HXCerlbrPzXRm1YEytsxubIaVp3B/RKeMQyUNdWt1q8NA57YvOOdfrk201CH3CBPIWDgnbpg6B6F0Yz1SzO8zz7f7WPyhEuymljP36765Z0SWT7Wvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YbOIHcBI5IZIzvRvN1SVH3bZC0K0Z1cdDqxA3uFwPbc=;
 b=fCD0mqpnTw0aE0a1dAFE76B7vTVKenmU6oM7bjk4gR02/s6PDia9dA305tvjLiltVZOoeUnys+Psuw154O8VvlJOSlq/ONS86FaFrkLf76GhAEn+iO73Pq40qRz9Y/7TgkDxzVJpUNcOd6iKdhe20eInJiZv45AdOhjphPMNa5g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY4P286MB6457.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:334::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Wed, 4 Mar
 2026 15:56:16 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9678.016; Wed, 4 Mar 2026
 15:56:12 +0000
Date: Thu, 5 Mar 2026 00:56:11 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>, 
	Frank Li <Frank.Li@nxp.com>, Niklas Cassel <cassel@kernel.org>, ntb@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] NTB: Allow drivers to provide DMA mapping device
Message-ID: <lycec7prrdejp3mpzrn5rzh5252vi7c7yypjiggrr74mcutdvq@y7kzzjm332rm>
References: <20260302144522.750620-1-den@valinux.co.jp>
 <3ddba488-6577-4f04-8a50-d64850b7cc5b@intel.com>
 <2jb2u6hm2u7dcmexzhi45kaclgfysfhr3nxomvqfnxbp5dlwfx@dt7hraa6u52v>
 <244af3c1-21f4-4023-b465-0ccd85e1eb79@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <244af3c1-21f4-4023-b465-0ccd85e1eb79@intel.com>
X-ClientProxiedBy: TYCP301CA0031.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::8) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY4P286MB6457:EE_
X-MS-Office365-Filtering-Correlation-Id: fc5323b4-3b29-4535-7ed4-08de7a068f48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	RItZhOmra2T+QjBCO+O7Aae5yIAhPO9j5ve//3Avp/qhxunx6vDxeAPXhWBnukVFKKTLKTqj5FJRioTDuLX/44hyghKWLEmhbwXZ3aB3EgXPcacxFOxD3Qbkf/VvxZ2j7Xq/3FEBRS/oBK0gm4ggrhn7cNLtErWpj5IvAWtpjtXvn0XJcDqj8PlniciXBEKwLdpgB1lGq0yGzhCBZJI9Taho0MpKatRY+rN8D/e6P062lHEN0jifCFJ88BqQmwad+x/UYJt/8YiL8szK0YVmHoM0ebTtNYkyZLjcVDC/ZA0EwwNGWNg+v6BN3CSBvTKqC42x2zRReI910oWYwWwOSla+dtJ+TLuzkbXVZJB9SwyflYytY6g8gqeQM1Su988DiM30UOPggWb0a2i0+1FbFGvWS98N9rDfdova8Xuindqfi/pVTpeXUTRPBMZHQ3Q6jWR32QwZwlVFhqaFzxB0zMKWQfWj9iWcB0BW6m+j5CQZfSJ2k+1nwaRankyluvgrBSrF0mJqXcNv9AJU4Ms9oa9c9W0hOTTBmy4knqKJtRuDtzdE6C0Iv+kwBxg29LmgZMhBlsXIV2LlQ1c5trJDIkTBotu7/Fi6OTpquY9P/RFjZ2bP0I45tb9sRkR6KUJ+TUEvponM+BVsr9HQf68gh1OrPo5OP/v/YvxIxgUZE9B3WH5tep/ySVAeOVsjK3ZNVpIkglin3uz5950M8vdUy3z0MPvhzF9In+hFQB7EEBk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8+6eE50ZNp0/+MeMIel/QCfr/5b6ggBCWo1a/OhuzlsUF6qMTUmellj8xX/B?=
 =?us-ascii?Q?FehPByWPK7HYN697lDU/HtvKHi1GoYw1XjaK/+yJ+yhcYv5c0AqFXMJhkY/L?=
 =?us-ascii?Q?nPnStJ2l3cyqihSFP5BpJhaw2jrAyRA7ZBZg1/8VMFQcWHy6dl9TwJCGCgpW?=
 =?us-ascii?Q?yr4wE00rXp5QDpfBwS8RLYjKNX52DVhdkPtV9YP/MGxpTUGdE71me+UbInXR?=
 =?us-ascii?Q?/yOXxBTPPqeCKOYCDzThuBs7C3umxDNHB2N2z0Vcixyp1zwqLEFnpEGYS1Tr?=
 =?us-ascii?Q?T7RbiplBjIdn6EHURP8XN869B0muT5JcCJgXFVfBKmuJZ/fN7IPmnAoNGAvc?=
 =?us-ascii?Q?tk1EX1IFikQk8hZ+MglJ4XLDPqV+1zH25q7+DxWAwPbKpLT8/Q1wkYHTWsk+?=
 =?us-ascii?Q?AJ3dLSm7A2dVyAZaNKkJwHj0VGpoIHAffEbiCJKW6FqhZuzGW1fkNKEcfxnq?=
 =?us-ascii?Q?jwFRD4Xrzl5An/forDm2ITviD/bNFwRQzREf5HhgtjtVaciPJzQ+vB3rQzWa?=
 =?us-ascii?Q?x5XM9lzmjqqfIir+H6xGUYCpFJwvtsA4JTxCaR5jbVu48LamZS5oTYkIAOSc?=
 =?us-ascii?Q?vN8EsQLt+K6NT2+kDak0pbMPGeWyg6cjX75nKNQv1eaHn1UH7P4tGXnbnx93?=
 =?us-ascii?Q?LY716J8hVFSQcqoX94rHmbw3LfNj+rzQWvjSMIkmIQ9S+Fd0CzXbZW0p1NEp?=
 =?us-ascii?Q?msLpxVa43Qh8bFSICdISIv6KJyUz8PdDwNk2g9d4L71SogTJOxwq0Fft4u3L?=
 =?us-ascii?Q?L4VaO/Brt8TrdVRqVQgL1XJBLBhI6jfK4mVAz/P7Z4QXC5Y3eXmBB0nzoGWu?=
 =?us-ascii?Q?J4QpqbeIYdl6ZMgBXTdckfxEq1S06bamqhzhS5IC2TIb7tyhTg1KA/grsdBV?=
 =?us-ascii?Q?xNGUn3jl7tk/V8/NVvaTB04GkMNLC0vIjr3aFFE9Dy/DAbVBNIcHF9MiUEEN?=
 =?us-ascii?Q?5U9weRmRhH8bVPAdjzbGc+5fNLmEsCjQtCV9g0UPWpvuxUJRxhnWCN3WKUuQ?=
 =?us-ascii?Q?XcKXDCyZcVQciajvwgW46A4T2trpzgiMNlYHBgqM75iTu2ndeQCEaAn05ER6?=
 =?us-ascii?Q?/l0a94sbn12Vg3ADjaMBYSkgjWeAedkeFkOwFETmcljRt7Irm7lM4xy1zY+/?=
 =?us-ascii?Q?rFWbuJ226yK7QKo4MNE/EPVwTb5DfAntDhd22x8nur7lnttF1IfJv40i08fv?=
 =?us-ascii?Q?AzpnyOGZY8YalIFppTCCj/CMDCPkrLUwcqDwEPc2Fl5DvcbfEzMhwKj3Whb3?=
 =?us-ascii?Q?nv0EpceEay0kkmbSwFZQNmeLh5bt2HZL7LPFO0IUwrIVkYFpgktOZUyHHayz?=
 =?us-ascii?Q?GXe05HjLhp2LJmtqeK4bl5Myd5Kxb0qWNSYZgFPzxK8aYwr1MLNUyqtWHdT1?=
 =?us-ascii?Q?8enTgC4fVPO9ecLpF3Xc6aLvayU6CLjj8PMFUg56Vq2hjfJPLsJaa2WbwkS4?=
 =?us-ascii?Q?gYv/3nVNxXBavDTTdGvmHIkcM4XHhJOjG51c75nQNAPJmEUSqOET9VPoJ34M?=
 =?us-ascii?Q?FXHUHYhScJc8sOY7qv962fD6ii563+bKKsCKHYcb6lR9rdJ5J+zAwcn6LSRI?=
 =?us-ascii?Q?i4oIieHr9wQDXKwWGzBu8N/eJfYqMEioOudZuH/7+IYt4sjZDSKaOSMdJoqK?=
 =?us-ascii?Q?Zew0+qUoR+RtlWxL/M1bCXmLYgDUTN2BIkOuocv9eBptFQQAhkPSmIh6arQf?=
 =?us-ascii?Q?sJ8Inefqq3E23fYrbVhLEP7CrvkM5X4F8VCmoDzWg3PXSf+OPcOl1+UKgNGD?=
 =?us-ascii?Q?X/7xsjRZRCrfFRRgZEVAQcP/2rXKzcPMMQh90mvXiIJh+5gf13Mk?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: fc5323b4-3b29-4535-7ed4-08de7a068f48
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 15:56:12.6834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hthB72ib2oYpdl2wzmWV9T44APERWWkNmX1Xmrm8Feeb3WkwICV/VhFqgjORiXbghwBu9dwllG7oYSb6h6kpsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB6457

On Tue, Mar 03, 2026 at 08:42:53AM -0700, Dave Jiang wrote:
> 
> 
> On 3/2/26 9:56 PM, Koichiro Den wrote:
> > On Mon, Mar 02, 2026 at 09:52:08AM -0700, Dave Jiang wrote:
> >>
> >>
> >> On 3/2/26 7:45 AM, Koichiro Den wrote:
> >>> Some NTB implementations are backed by a "virtual" PCI device, while the
> >>> actual DMA mapping context (IOMMU domain) belongs to a different device.
> >>>
> >>> One example is vNTB, where the NTB device is represented as a virtual
> >>> PCI endpoint function, but DMA operations must be performed against the
> >>> EPC parent device, which owns the IOMMU context.
> >>>
> >>> Today, ntb_transport implicitly relies on the NTB device's parent device
> >>> as the DMA mapping device. This works for most PCIe NTB hardware, but
> >>> breaks implementations where the NTB PCI function is not the correct
> >>> device to use for DMA API operations.
> >>
> >> Actually it doesn't quite work. This resulted in 061a785a114f ("ntb: Force
> >> physically contiguous allocation of rx ring buffers"). As you can see it
> >> tries to get around the issue as a temp measure. The main issue is the
> >> memory window buffer is allocated before the dmaengine devices are allocated.
> >> So the buffer is mapped against the NTB device rather than the DMA device.
> >> So I think we may need to come up with a better scheme to clean up this
> >> issue as some of the current NTBs can utilize this change as well.
> > 
> > Thanks for the feedback.
> > 
> > I think there are two issues which are related but separable:
> > 
> > - 1). Ensuring the correct DMA-mapping device is used for the MW translation
> >       (i.e. inbound accesses from the peer).
> > - 2). RX-side DMA memcpy re-maps the MW source buffer against the dmaengine
> >       device ("double mapping").
> > 
> > (1) is what this series is addressing. I think this series does not worsen (2).
> > I agree that (2) should be improved eventually.
> > 
> > (Note that in some setups such as vNTB, the device returned by ntb_get_dma_dev()
> > can be the same as chan->device->dev, in that case the double mapping could be
> > optimized away. However, I undersntand that you are talking about a more
> > fundamental improvement.)
> > 
> >>
> >> The per queue DMA device presents an initialization hierarchy challenge with the
> >> memory window context. I'm open to suggestions.  
> > 
> > In my view, what is written in 061a785a114f looks like the most viable long-term
> > direction:
> > 
> >     A potential future solution may be having the DMA mapping API providing a
> >     way to alias an existing IOVA mapping to a new device perhaps.
> > 
> > I do not immediately see a more practical alternative. E.g., deferring MW
> > inbound mapping until ntb_transport_create_queue() would require a substantial
> > rework, since dma_chan is determined per-QP at that stage and the mapping would
> > become dynamic per subrange. I doubt it would be worth doing or acceptable.
> > Pre-allocating dma_chans only for this purpose also seems excessive.
> > 
> > So I agree that (2) needs a clean-up eventually. However, in my opinion the
> > problem this series tries to solve is independent, and the approach here does
> > not interfere with that direction.
> 
> Fair assessment. For the series:
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Thanks for the review.

Once this looks good to Jon as well and gets queued in the NTB tree, I'll submit
a small patch to PCI EP for vNTB (the real user of the interface), something
like the following:


diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index be6c03f4516e..8aeacbae8b77 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -1501,6 +1501,15 @@ static int vntb_epf_link_disable(struct ntb_dev *ntb)
        return 0;
 }

+static struct device *vntb_epf_get_dma_dev(struct ntb_dev *ndev)
+{
+       struct epf_ntb *ntb = ntb_ndev(ndev);
+
+       if (!ntb || !ntb->epf)
+               return NULL;
+       return ntb->epf->epc->dev.parent;
+}
+
 static const struct ntb_dev_ops vntb_epf_ops = {
        .mw_count               = vntb_epf_mw_count,
        .spad_count             = vntb_epf_spad_count,
@@ -1522,6 +1531,7 @@ static const struct ntb_dev_ops vntb_epf_ops = {
        .db_clear_mask          = vntb_epf_db_clear_mask,
        .db_clear               = vntb_epf_db_clear,
        .link_disable           = vntb_epf_link_disable,
+       .get_dma_dev            = vntb_epf_get_dma_dev,
 };

 static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)


Best regards,
Koichiro

> 
> > 
> > Best regards,
> > Koichiro
> > 
> >>
> >> DJ
> >>
> >>>
> >>> This small series introduces an optional .get_dma_dev() callback in
> >>> struct ntb_dev_ops, together with a helper ntb_get_dma_dev(). If the
> >>> callback is not implemented, the helper falls back to the existing
> >>> default behavior. Drivers that implement .get_dma_dev() must return a
> >>> non-NULL struct device.
> >>>
> >>> - Patch 1/2: Add .get_dma_dev() to struct ntb_dev_ops and provide
> >>>              ntb_get_dma_dev().
> >>>
> >>> - Patch 2/2: Switch ntb_transport coherent allocations and frees to use
> >>>              ntb_get_dma_dev().
> >>>
> >>> No functional changes are intended by this series itself.
> >>>
> >>> A follow-up patch implementing .get_dma_dev() for the vNTB EPF driver
> >>> (drivers/pci/endpoint/functions/pci-epf-vntb.c) will be submitted
> >>> separately to the PCI Endpoint subsystem tree. That will enable
> >>> ntb_transport to work correctly in IOMMU-backed EPC setups.
> >>>
> >>> Best regards,
> >>> Koichiro
> >>>
> >>>
> >>> Koichiro Den (2):
> >>>   NTB: core: Add .get_dma_dev() callback to ntb_dev_ops
> >>>   NTB: ntb_transport: Use ntb_get_dma_dev() for DMA buffers
> >>>
> >>>  drivers/ntb/ntb_transport.c | 14 +++++++-------
> >>>  include/linux/ntb.h         | 23 +++++++++++++++++++++++
> >>>  2 files changed, 30 insertions(+), 7 deletions(-)
> >>>
> >>
> > 
> 
