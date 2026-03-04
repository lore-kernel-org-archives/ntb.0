Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021113.outbound.protection.outlook.com [40.107.74.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9783F33E7
	for <ntb@lists.linux.dev>; Wed,  4 Mar 2026 16:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772640189; cv=fail; b=Y2do+py0ckOMfW2hS9dQgiuOlzfAUFBiAdu3t0QY7T3hiTuIxqb4BHac1dvli/EzF7IMfo8Ix8C7u9bwxt79FV+7FMmhcAz7BoGDff+5gJNBF8nQT0UQoXHTEfBFoLZkivVxobU7cpeQq/3El1RAk9dfeS+s7OWEKor69boqv7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772640189; c=relaxed/simple;
	bh=IYPpcqdAd0wc4V3YOB5TvccpxVOfcgQJ+VhFDER9IQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rZDjTyeJsoIHeT9DEcMG2MjTbjcSTE4zPjHIT6IbuWDe9isIupAFOt6GN6Y2bG/eGMps8VwRrQpL7irT7omwM8fPprC3ByqOP2dzv4yP7nEL4xun02Y6g6ERgeiTCo307P6uLmqRDsZUbsAW/zVXBexEuO+VR67ezKA+NsgwwLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=kDO9pGJv; arc=fail smtp.client-ip=40.107.74.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="kDO9pGJv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bBfZTefyDgAj6pDJfg6vEPbYeMCDLhLhgX6d38m9g/n9Zuxs4QNn8cNplz+GILuzvdMFYlkYAnBc9ppEoQdXwJ5VOqgFVaiMHh2b2yAWCf9CbtcNgMDEp/ANnIK4RuC1RjLi3D4RYjpgmbKIiKfBhGmC0FKLOdP25gkPPfjaPysf1aU+2Z8dk3HV57VZstQA67fi6lslE4RUqkb6KbFEgM7TsZwm9Z57vwEI03WN5efsH11R8h5z9IBt9otUBeL836sz8NKcWGPWoUdsRGxd/+Sup5zN3z7/S1K9GN3bL7kbiMdyoCV+NAXl3Aqh30k9lfTG/cxfmRloW9oMfd64Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i2R1ajpDCgk5l/Q99ktWMf5S+0G4L25D/tJcX1lqD4g=;
 b=SFRPeXNhSZ+UrxKaw+q1cELqL/k2ZLX1pqHElxrIlZkxjmn2YMkX5sWhuq+Y0P+9EC7v0J/sfwGPVU+MW3GEMrtmt/jYhvwAyk0asN8bxFaGs60uERpiGKOx91+Y7MMqM9+cWUiHvEkJ8pJlMsdCzJqC/lOgMKPRJaYECgAimGBWKtXOpmm45cz0HFf+dhHljkeVbmwFyhTVkaby1Ak8RDszFdRkyl3jlpI19yXl+x3Q2T0FQqbyGAjHbOVIiuH2qotamwLidMcsUPyQuRhnePbA1x1M3UMDndyZggdXVMxvdV2plS/lo6xU5CPhJJzueIu/DLUI2z4H6ZeoPfhiNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2R1ajpDCgk5l/Q99ktWMf5S+0G4L25D/tJcX1lqD4g=;
 b=kDO9pGJvMGuQc5hlr0XEMM0xAsnNC6Du5BLpg3hmF7OjHyFGJtHfhC5vu+ISeszV695U/IIRxKWXkHScAa+OlQecHjIfe2N5mWUZN6WAuetKYvpSFgMMP3Hb/PE0rVFLFM4dnJJsbsabGhSl0ObczvaUVYNkVE4Y/u1l44yOFho=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYRP286MB6158.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:1cf::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Wed, 4 Mar
 2026 16:03:04 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9678.016; Wed, 4 Mar 2026
 16:03:04 +0000
Date: Thu, 5 Mar 2026 01:03:03 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>, 
	Frank Li <Frank.Li@nxp.com>, Niklas Cassel <cassel@kernel.org>, ntb@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] NTB: Allow drivers to provide DMA mapping device
Message-ID: <452poyhhm3244zrf6cqtpmf2w5zsdbtbbjupd7fu4debjjd72x@hv5azl7ew6e4>
References: <20260302144522.750620-1-den@valinux.co.jp>
 <3ddba488-6577-4f04-8a50-d64850b7cc5b@intel.com>
 <2jb2u6hm2u7dcmexzhi45kaclgfysfhr3nxomvqfnxbp5dlwfx@dt7hraa6u52v>
 <244af3c1-21f4-4023-b465-0ccd85e1eb79@intel.com>
 <lycec7prrdejp3mpzrn5rzh5252vi7c7yypjiggrr74mcutdvq@y7kzzjm332rm>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lycec7prrdejp3mpzrn5rzh5252vi7c7yypjiggrr74mcutdvq@y7kzzjm332rm>
X-ClientProxiedBy: TYCP286CA0046.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::6) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYRP286MB6158:EE_
X-MS-Office365-Filtering-Correlation-Id: ff836e51-152b-44b9-3513-08de7a0784de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|10070799003|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	yuq5R6EsP04UKwIllocCzd3EHBTgbYE08sDz0YMZuwAKtlzxaPNYqV6xxCYnICf49wXHd5VnRwRo+K1Vco2FBKpGEh7wwUA7Il3Qv0k+3THoIRy518VdUBnE0QJ+X3m/FX1P4kmoPx4EwBq9e0NYXst8TjeVXG24VrFpEE8VNwzT8zjMIB+9pLvULRiNVD8v6s5bY1Kwglj1hr11Azjv3KPdZxjOkUl86cXMonC7hA9pAu9+5SfLi2jHkeiZ5HLfg2xBbavgwuNsIn2eSmF+tLugPEcQvBkPNnt2laNqvC9SonzIlXbpuwxduY+UMWLU9Qv2lZ+CHFd/W1HYaXy1e0IYheMELhQ57WO/PP/+Rwxw0oLOTusVgtofDsTwiOccdlnhsiVjNGc0xclUZpnsT/sBVwn8PdLa1WycrBTmJmJ+GEhOHWaLf/USw69Fc7FYQNZj5PT8NsdwJVW0tG5AXx71o6tzhKuKr6MwgIbAjd81Smjlh1JH3D3Kag6/SYAXLDhjjFz2IuV8+KBrVjXb58zbL15sGlNHvYCTmg3IkNuMTrNLXMwzzdpMmBEF0IeXLJXjPvDhCqq7EJr08N9vG/0+zGVBT/LB51o0Fu4LciY9MMf+EqI0ZG+zCwPSLCaX0lJiJzSk3Ra24PRqnCKwjvx+UsAXto6nfnfol6lw7uz2eISp14knbSu2TzRi3O5etujMVQxF+Kl8oS3ngz+7N0ShuyMKUFvhX48BNGc/sL8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VbSXlrCp9fzaLSZ9MYw1Fl0hQDdmmp7UjUALWFK0vn9P1+GvxswttKABt/G/?=
 =?us-ascii?Q?6kGESaWF/aizdElNSUq1WIuCDNKn9tuYHKP3ANbdbG6O8FWb828ch9DZlY72?=
 =?us-ascii?Q?SGKOfA8UklzeUXydIGOxXwDtgSOVdvSbwDagtT4x0omll8HGoFf+svsjeFjZ?=
 =?us-ascii?Q?fLAdAO1ECBahdw+Ok39/fDqC6/4oxZHLxhSjiE2kZl9uLgCGeLnYJwvqz06x?=
 =?us-ascii?Q?PwyUgI0LIvIYt4rrRmB41ton+QyZlJ1F3UWaTKW+gYZkRrEzmBLkLTay+mzn?=
 =?us-ascii?Q?xlZo5Sedaucd98rGGIwLNa0IEFHJDEpHdHv8yoRGcfgcWakYZUDWPMaR2g/f?=
 =?us-ascii?Q?dXdU7caNsEgoORjasvjeU/YR3XoRgXsi37W25AFK9SwTU+rEvCPJM7lefa0t?=
 =?us-ascii?Q?z5MNtuhBC23iLwd5jNwGY6bHARx+oHsA48iY3wb6fVhFhl83mftG4AzJc8vw?=
 =?us-ascii?Q?S6oQqX54uHhUcoBOaXNgpCyghSjfUzqkNOZPTxky9tCBRTWGRiAqrSfflnfb?=
 =?us-ascii?Q?xP918VHlzRxB+RcxLfqE8lGG6nYBOI5+A1xrk37W8GfKJ54fqqN+StEdwID4?=
 =?us-ascii?Q?/625hCthQDTZxTKgYq8L+KHRb50MTKBorF6uhQ7q3UgkkSs/Gc9L+7DQtmjI?=
 =?us-ascii?Q?zRxb/3vCgokgRbz7EOamg5m2LuMGjTKFFct4+ajSI1DOxQNgD3+F8RTH3W3G?=
 =?us-ascii?Q?v8MmGK+6OA/w1E5VEznt6vUPzzzFAAqlKQxDN7QiIvUOkb5K09zSHLK02ONe?=
 =?us-ascii?Q?uHUJtV6peMPauT5h1/DMyKSbR0qAKLj3XiQeSJx6PfrGEw29qIsEpku8+62e?=
 =?us-ascii?Q?TWtkw4iGrZC46OwNz8RNuPVwSwEBK6avDSQF8EIF9XlQBa/W01PRKrYjzOxZ?=
 =?us-ascii?Q?qgy+ql6U7zsKnCszAO8/48U2yI3f2V3VPsb0UrZru89GPcNxJ2G9bCiDnj0D?=
 =?us-ascii?Q?r8fZEyIH4bY+aO7U6RGk4j7c8+oRVUz9WBwHd7Z8RFhgyQyLpb4v4J2dC2f4?=
 =?us-ascii?Q?0I/JC4dsSrz4/ruxnoMBd+zvar9oderpv9hkWX1HwWIFXohlY38NtzGHkPCD?=
 =?us-ascii?Q?eytF5m2NhODwmdMXFfCmRbx0xUCu91p0khiymkkTLFucBH1mhZxgoIPY+5R6?=
 =?us-ascii?Q?xIN4eOE60XSMF7CPcosGMi8eJPqD2PRzPdKflVp8yZZgBYI37d/koo68KGGQ?=
 =?us-ascii?Q?5fehaK1aA91XeIuZNXIt9bJuZH570AbcwA/1gGAMToZpw8J8FtaTKRg3SdoW?=
 =?us-ascii?Q?FIFelQDpHW3C7Es35BZwWPy7dD2n0j+o/tv1//rhS26/1bUMpUSpdEinQFcg?=
 =?us-ascii?Q?I+EJxrDJTdgHafsVUNCRExuBswIQBOHWjV2mwUx1hjIHrYyeaBoy4SllsDZX?=
 =?us-ascii?Q?+H8rc++j7sxGEfW/hECn/XAOh+dwkrZGtlz47il96gwfxEEtbPnlwZOWwRxi?=
 =?us-ascii?Q?eEW29jis99NeXs9FHQwy64tfnyInj2m3hqe06dUdI9Sgx0/bvSY6eA1zdDcC?=
 =?us-ascii?Q?ZpX7VP2ISVUrAaoZYNP4mrH5DvVnlG3GZhEqgd0xchW9vy3bQ43xki4SgPZX?=
 =?us-ascii?Q?+RZXl2Aoc1p0Jb66oNuKPH7PHLiSJdu9eiWA4Xlmlze75UtGdmTXBXP0ZUUp?=
 =?us-ascii?Q?2RRUKIUA5wGTkmPigq+tSiEkcx44Kzhw/Ryzv6wTDZefU8Sk/dDGQBKa65AT?=
 =?us-ascii?Q?D7nN4iWID/IH2o6IBGkwg+iW52ag28j3P+c843MNVLUawOawGpqrE456a5m4?=
 =?us-ascii?Q?QnaorLvxvoXCbZKxHAmqj7pPSJR7h14tWYyN0Fvi3aBBX+7OEt4F?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: ff836e51-152b-44b9-3513-08de7a0784de
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 16:03:04.6230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oFsIeDJkqKug00OQDNVCCgwtj1DRNGPSGwDglU9L6PP3DPfwW31gwzBL1xIejR1Je8rRxTtL88IsZWUiVuicHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB6158

On Thu, Mar 05, 2026 at 12:56:12AM +0900, Koichiro Den wrote:
> On Tue, Mar 03, 2026 at 08:42:53AM -0700, Dave Jiang wrote:
> > 
> > 
> > On 3/2/26 9:56 PM, Koichiro Den wrote:
> > > On Mon, Mar 02, 2026 at 09:52:08AM -0700, Dave Jiang wrote:
> > >>
> > >>
> > >> On 3/2/26 7:45 AM, Koichiro Den wrote:
> > >>> Some NTB implementations are backed by a "virtual" PCI device, while the
> > >>> actual DMA mapping context (IOMMU domain) belongs to a different device.
> > >>>
> > >>> One example is vNTB, where the NTB device is represented as a virtual
> > >>> PCI endpoint function, but DMA operations must be performed against the
> > >>> EPC parent device, which owns the IOMMU context.
> > >>>
> > >>> Today, ntb_transport implicitly relies on the NTB device's parent device
> > >>> as the DMA mapping device. This works for most PCIe NTB hardware, but
> > >>> breaks implementations where the NTB PCI function is not the correct
> > >>> device to use for DMA API operations.
> > >>
> > >> Actually it doesn't quite work. This resulted in 061a785a114f ("ntb: Force
> > >> physically contiguous allocation of rx ring buffers"). As you can see it
> > >> tries to get around the issue as a temp measure. The main issue is the
> > >> memory window buffer is allocated before the dmaengine devices are allocated.
> > >> So the buffer is mapped against the NTB device rather than the DMA device.
> > >> So I think we may need to come up with a better scheme to clean up this
> > >> issue as some of the current NTBs can utilize this change as well.
> > > 
> > > Thanks for the feedback.
> > > 
> > > I think there are two issues which are related but separable:
> > > 
> > > - 1). Ensuring the correct DMA-mapping device is used for the MW translation
> > >       (i.e. inbound accesses from the peer).
> > > - 2). RX-side DMA memcpy re-maps the MW source buffer against the dmaengine
> > >       device ("double mapping").
> > > 
> > > (1) is what this series is addressing. I think this series does not worsen (2).
> > > I agree that (2) should be improved eventually.
> > > 
> > > (Note that in some setups such as vNTB, the device returned by ntb_get_dma_dev()
> > > can be the same as chan->device->dev, in that case the double mapping could be
> > > optimized away. However, I undersntand that you are talking about a more
> > > fundamental improvement.)
> > > 
> > >>
> > >> The per queue DMA device presents an initialization hierarchy challenge with the
> > >> memory window context. I'm open to suggestions.  
> > > 
> > > In my view, what is written in 061a785a114f looks like the most viable long-term
> > > direction:
> > > 
> > >     A potential future solution may be having the DMA mapping API providing a
> > >     way to alias an existing IOVA mapping to a new device perhaps.
> > > 
> > > I do not immediately see a more practical alternative. E.g., deferring MW
> > > inbound mapping until ntb_transport_create_queue() would require a substantial
> > > rework, since dma_chan is determined per-QP at that stage and the mapping would
> > > become dynamic per subrange. I doubt it would be worth doing or acceptable.
> > > Pre-allocating dma_chans only for this purpose also seems excessive.
> > > 
> > > So I agree that (2) needs a clean-up eventually. However, in my opinion the
> > > problem this series tries to solve is independent, and the approach here does
> > > not interfere with that direction.
> > 
> > Fair assessment. For the series:
> > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
> Thanks for the review.
> 
> Once this looks good to Jon as well and gets queued in the NTB tree, I'll submit
> a small patch to PCI EP for vNTB (the real user of the interface), something
> like the following:
> 
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index be6c03f4516e..8aeacbae8b77 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -1501,6 +1501,15 @@ static int vntb_epf_link_disable(struct ntb_dev *ntb)
>         return 0;
>  }
> 
> +static struct device *vntb_epf_get_dma_dev(struct ntb_dev *ndev)
> +{
> +       struct epf_ntb *ntb = ntb_ndev(ndev);
> +
> +       if (!ntb || !ntb->epf)
> +               return NULL;
> +       return ntb->epf->epc->dev.parent;
> +}
> +
>  static const struct ntb_dev_ops vntb_epf_ops = {
>         .mw_count               = vntb_epf_mw_count,
>         .spad_count             = vntb_epf_spad_count,
> @@ -1522,6 +1531,7 @@ static const struct ntb_dev_ops vntb_epf_ops = {
>         .db_clear_mask          = vntb_epf_db_clear_mask,
>         .db_clear               = vntb_epf_db_clear,
>         .link_disable           = vntb_epf_link_disable,
> +       .get_dma_dev            = vntb_epf_get_dma_dev,
>  };
> 
>  static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)

No, sorry, my mistake. That was incorrect. It should look like the following:


diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 20a400e83439..e5433404f573 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -1436,6 +1436,14 @@ static int vntb_epf_link_disable(struct ntb_dev *ntb)
        return 0;
 }

+static struct device *vntb_epf_get_dma_dev(struct ntb_dev *ndev)
+{
+       struct epf_ntb *ntb = ntb_ndev(ndev);
+       struct pci_epc *epc = ntb->epf->epc;
+
+       return epc->dev.parent;
+}
+
 static const struct ntb_dev_ops vntb_epf_ops = {
        .mw_count               = vntb_epf_mw_count,
        .spad_count             = vntb_epf_spad_count,
@@ -1457,6 +1465,7 @@ static const struct ntb_dev_ops vntb_epf_ops = {
        .db_clear_mask          = vntb_epf_db_clear_mask,
        .db_clear               = vntb_epf_db_clear,
        .link_disable           = vntb_epf_link_disable,
+       .get_dma_dev            = vntb_epf_get_dma_dev,
 };

 static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)


Sorry for the noise.

Best regards,
Koichiro

> 
> 
> Best regards,
> Koichiro
> 
> > 
> > > 
> > > Best regards,
> > > Koichiro
> > > 
> > >>
> > >> DJ
> > >>
> > >>>
> > >>> This small series introduces an optional .get_dma_dev() callback in
> > >>> struct ntb_dev_ops, together with a helper ntb_get_dma_dev(). If the
> > >>> callback is not implemented, the helper falls back to the existing
> > >>> default behavior. Drivers that implement .get_dma_dev() must return a
> > >>> non-NULL struct device.
> > >>>
> > >>> - Patch 1/2: Add .get_dma_dev() to struct ntb_dev_ops and provide
> > >>>              ntb_get_dma_dev().
> > >>>
> > >>> - Patch 2/2: Switch ntb_transport coherent allocations and frees to use
> > >>>              ntb_get_dma_dev().
> > >>>
> > >>> No functional changes are intended by this series itself.
> > >>>
> > >>> A follow-up patch implementing .get_dma_dev() for the vNTB EPF driver
> > >>> (drivers/pci/endpoint/functions/pci-epf-vntb.c) will be submitted
> > >>> separately to the PCI Endpoint subsystem tree. That will enable
> > >>> ntb_transport to work correctly in IOMMU-backed EPC setups.
> > >>>
> > >>> Best regards,
> > >>> Koichiro
> > >>>
> > >>>
> > >>> Koichiro Den (2):
> > >>>   NTB: core: Add .get_dma_dev() callback to ntb_dev_ops
> > >>>   NTB: ntb_transport: Use ntb_get_dma_dev() for DMA buffers
> > >>>
> > >>>  drivers/ntb/ntb_transport.c | 14 +++++++-------
> > >>>  include/linux/ntb.h         | 23 +++++++++++++++++++++++
> > >>>  2 files changed, 30 insertions(+), 7 deletions(-)
> > >>>
> > >>
> > > 
> > 
