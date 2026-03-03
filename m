Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021092.outbound.protection.outlook.com [40.107.74.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D2733D6E1
	for <ntb@lists.linux.dev>; Tue,  3 Mar 2026 04:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772513785; cv=fail; b=iKFcaZWujKfSePzC2z5ZCKmfmONAvnjySu2SQFjW/eoWbGOSs50js4bNkr+GXN6aC2b6VZ1dHsaNaffMwdu/JAsAIShIaSvH4k/i9SPJj8oYiakznMmf1gzCpP5YYLhPbrYP7az5qUIiSsD+eLI3iOkKrpBEfRUbpB0p8sYxoqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772513785; c=relaxed/simple;
	bh=fTaQQPlr824YisF4JOW2sQec4DXJZ7KI+e/S6FgBmzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=n/XUMw3BgNS1CcaIj7bibbJcRAyTQJdg6DZp4+5NNM42n6CRlLwaWZDB6NCWT/nvYz9mHoxONNnolwjqVcTgFPCouvFZJS8daqtT6y+vkQbRAxIhuphcVbgIbQfHLQ9/TlcPDnizzOUOi8ggoO+e+7qfKGR/oOilsCKjQRAySJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=TviZJcbk; arc=fail smtp.client-ip=40.107.74.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="TviZJcbk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h2a8B3zyY9SPKvzwprmqExpnYHOuq50/vqqZaIRPKmPWXKTOq6WHGP7nho/sO3N2Wgp/VK3QKCvROcbazcDvQPIT1wyJMeRbS2243xPDnbxG5p8zjFLCHFpu4DyIT0Ccy6Q+HmsLblyLX9/+BTPIHQsuRnkbvlIF72c0U+N6k5kDIVcrxWXqcCR+tWvFLlOSlKq159TkGEViAgLs57G2nN2kP2jYb+fKQ0di3rlmHy7Yy/rNPr3czTIkGghlbJkywyDSmC2MqiCIOE/eOWOE2UQ911AW7HVwj7AoRsOM70iAsmtJMBp/M6NBhqRQ63un1v3C9JLnul07VbWEhfxDKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a7E4dKsIvbKxbJEB3Ebz4kqMzMkW9yMIRXsW3OVdNWU=;
 b=esnFfxfhuu1fugVCUFyJR253a7/fENuh6Tg6GZFWDqnuxZJRIkipl8RQCJrGIEZy9LV0hz6b5XZbWGnnPHCrK4Xa8XJpwjAFXV/YDdG8y1K5IIFy0ec+QvFckhLbpC0oogXtIsj++WgTivzCGDgh7nMnF8pp2Wp7I+cC1B8YYrovOD+utQbajEnsWLez1Ioi0LpvFZQ+hIofQ2MvstNcxbGpbKbPOb/KDlPnAQPsuJj7wWK9M2J4qRq6ypCU2B654ECGC/IfQPgqFQNCrsZeyjDupHD6c39pz4cDhTDLJScTZ+gdFZ0ZyRXUXjwhGakaIGMpuonWKpvkY9jmVS/d6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a7E4dKsIvbKxbJEB3Ebz4kqMzMkW9yMIRXsW3OVdNWU=;
 b=TviZJcbkPyiYtBeOZmvvi//d9pzTzFIU1HZAJt4rc+lwk9CPT7AD5MI9Yiy2jYKQlek9ZrtUIa7bY7mY+xkcUexi73JNOgBZxNN3meWV6IBMIcDLXftBj0JiWd5COeiKDM32RdrTzH1OXc/3G/ZAd2pT3DvBFHdr6zg+bkkCBF4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB3772.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:23b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 04:56:21 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9654.015; Tue, 3 Mar 2026
 04:56:21 +0000
Date: Tue, 3 Mar 2026 13:56:19 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>, 
	Frank Li <Frank.Li@nxp.com>, Niklas Cassel <cassel@kernel.org>, ntb@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] NTB: Allow drivers to provide DMA mapping device
Message-ID: <2jb2u6hm2u7dcmexzhi45kaclgfysfhr3nxomvqfnxbp5dlwfx@dt7hraa6u52v>
References: <20260302144522.750620-1-den@valinux.co.jp>
 <3ddba488-6577-4f04-8a50-d64850b7cc5b@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ddba488-6577-4f04-8a50-d64850b7cc5b@intel.com>
X-ClientProxiedBy: TY4P286CA0083.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36d::15) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB3772:EE_
X-MS-Office365-Filtering-Correlation-Id: 45c825ad-ea46-4f0c-77a9-08de78e1368e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	oocoV/CkcPWr+oygCN5kjOyGeFe9zpJ9kI8ySuN811VCbR3/lbL1dwRCv87v2wkGilAwU2o6hoEJr3JG0OIZcW0SiybQdNGbRggedUClLg5aaehW7kdwts6MXkhAOq3+5eZ6T2ZAVjzwDQ6/3gSsBgBhObgTbGC7iFJ8cHD8k6RXmKZkE9GKlrRkKo5EUFb5n4AIbOahRFK3/lBqU3GtR49XYDWgdCk23atWG6PnvFAl25FhFazhb/HYCRT9Sh7EkiGs5rGT1+ACc7pVRpZrCITZY1TggOt1YpDefH79ZEMQbjVphKcX1xvVH6NR3lV+TmA0P0WLveOLroy7uskTEkNf5vh4vLw86KozpCm7vRmELHaGZMchQ6BHYoyfT4yAEwYpumqjZc3uTq+sPxUJI7iUX/JBYJEcMq+VtGSo4aIPUScHhLSmtuuGB/afSR0hd7ax8k3ZgqvGDkuSZuuB4Jk1wAGRocrPZynjBTf42XKSwXqqiJ2kMv1oj/LV7vAhyWGXVKyGqjApq35V4iPLZhk8zaI+XdEKi7Tr8/c9Cqjh9Uyrq4ReNAVmgVQIDVGrUvMFKY3f/7wpiyaph1D5G81mnHZSrLq0+FyHP4cFhXkzNkJ4bKV/c2AlyxYLoTpSSlhgGJcPy2+6wEVFDetkd7q57u7skqoX78asuehU9NPbR4uPWGwLMDiappkS4dh1I7onEhpbOn9UMxqPvgjI6670hOJ+rXtZZJOztUBFiNo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q67Ln0QdMlxveZzbMnh9VOwPwdp9qrgnGIpAlgzYmRw++M6tzPruTKuHLQn6?=
 =?us-ascii?Q?4gzBFba+JcV3ogcgebAlbf6a0SPZmoNRUA8inuOly9o0WVXHcHbXqFZhuSay?=
 =?us-ascii?Q?I1rLUw3TL6MlqXXQE8JIWWpYfJQ6uQoYPba5tnppsjLR0Cy2yF+jbv8tX0dz?=
 =?us-ascii?Q?JU9e412BPFNGE5W4mogUREsZcbf8alsgyviXUqtIosgDJ2N3cGq/TO6b54aU?=
 =?us-ascii?Q?ZvcT8gzk7nZaMxx1+nLEfng+ipha3T6Q6EB6GAwS5O+llqzq03uWpvKze9Fq?=
 =?us-ascii?Q?XLYsMeAuRD5UhR1Hkdabqacq9nNCqr1OLR37Z9M7fm+DuDSPtLCRdSeIzfkY?=
 =?us-ascii?Q?qe8QGTh5l065NoZzvRHvwuDwpjXqJQ3XggvnfKR0IQDDAb9nGezfyw7MPsRg?=
 =?us-ascii?Q?LPBXBYJI2uYJF20MsN2NdHx8lXirYbQoPdzJY3zqGbW4nEbBGjec2UlFVEnb?=
 =?us-ascii?Q?KCE06W70z/HS7ufjIatvZCdjOCIZG9dCVuDvFK26WzSTWC34jc7sGrxnVM1e?=
 =?us-ascii?Q?0zKXWQBQw0zoOd8RRxcvYyUSPCcUvzw+4QgVJQwpU/lL8DgYIL75oCLxS96t?=
 =?us-ascii?Q?Br1hNLDZMmo+u3AGmgciT4n/xkAvxaATfLgl4IL5Pkcz4ffe6+CVQ8hB5xEA?=
 =?us-ascii?Q?4s6BHjZke2AeHROhycMTR6KHs57rfYtbQcv/yUw3Yr8p77WFKdXBouphCXve?=
 =?us-ascii?Q?H52UpuibgoeKba/3ZnAZ3Gs1PRKK36xl5mmJAm0wrjEu8I9pAFXu2Oil2QyD?=
 =?us-ascii?Q?wPGpQwgXp4u+DkNoWvpfAnYRa9EIN3VQoHg8XzTax7zDHE8LrWdqdPlMzYDx?=
 =?us-ascii?Q?ozw2/4MRwhpx5dJpXgnhACgSl83nJ89S8/sH1qaEhH37FednHNnzCk/PA4M/?=
 =?us-ascii?Q?dPLVtSI7AiFZ20hRDkI4om9Vc61oVH7FGMtdvUiRPuHCZ5uz2dkew37S/jyd?=
 =?us-ascii?Q?3LqreYEvIUrHQ5c0H5nzgTVJjROPF3kADly5BixwyTwuBnDDkdfStI0hGK1a?=
 =?us-ascii?Q?Ry4sg4+zYAq5kO4PxhDTaMU6j0kivEbhtLfvV+rPSp37aZRAJzIAMuBk3Y+A?=
 =?us-ascii?Q?Qe1omW5qB9xtgTHh6qbLiYSNApkrItvWyGG9gS2NApcM9WeWMgPFttLf4vWZ?=
 =?us-ascii?Q?/B8dOAIxRBOb1AlnUXdReV/StUSQkoCqxU9X5usXw3lKWCayxI4gOKVAoibv?=
 =?us-ascii?Q?6MIymg+sRNBRV0xbq4eayydkYzjCP8ueQZCQk29k8OHFyvepxbcHYEG2i5uy?=
 =?us-ascii?Q?HRTdMeqhXsWbNBHV2Z5sAk4ADNUemTINAHnd0AEh7Ux9N0aWgXepEHJjVkHZ?=
 =?us-ascii?Q?OIclVeLdL9H2NyAXE+9wVAPynipLvGdZWxM4pTMnnPFgle28YmYImrG5yHze?=
 =?us-ascii?Q?fc7MMh2igOq23X1db7GCWv/E5nr/jsOOWj9IejBQGWTWBNddkAOGIjUIy17Y?=
 =?us-ascii?Q?RHHy0Or/eogZJGXyjSD+kZcmKOfCXxn/Pm1qNeLuuOV3hsU6GT8wFVph6CGN?=
 =?us-ascii?Q?+hN10THmjkzvzy9+ObPCY1v60Dpci/+vrR2vUVxJVrbTcXlcW8evFCLXlc+S?=
 =?us-ascii?Q?VzOF1JLzXBp9UXJELoGSlH78mo7+0TnXzpM9bHh9be4gcbpCQUlmy+lw3O2R?=
 =?us-ascii?Q?t5AWNP/tWIaSN9JDToo8fTuiCQNkCoMa+CKISqWHxpk1XprWg2AfFbgpfxD9?=
 =?us-ascii?Q?khR2jKsexzY1AmsOGu/u0F2SOaUTTaWRL6ocrEwMuNwZvCAFnSLwgPfcflUg?=
 =?us-ascii?Q?l3Cq2aktftPQB/Y1r0tg8hKN0/0PddtZRFrhxoS7sC+d1spxh/ki?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 45c825ad-ea46-4f0c-77a9-08de78e1368e
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 04:56:21.2642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LdYB7NkX0KefjgQ+vQTYlcg8fVqSjLQqPteEzCHKW36r7p7ONjS/9ugeymZs7N5kZhO7OaTQALk+cPRLmpsnzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB3772

On Mon, Mar 02, 2026 at 09:52:08AM -0700, Dave Jiang wrote:
> 
> 
> On 3/2/26 7:45 AM, Koichiro Den wrote:
> > Some NTB implementations are backed by a "virtual" PCI device, while the
> > actual DMA mapping context (IOMMU domain) belongs to a different device.
> > 
> > One example is vNTB, where the NTB device is represented as a virtual
> > PCI endpoint function, but DMA operations must be performed against the
> > EPC parent device, which owns the IOMMU context.
> > 
> > Today, ntb_transport implicitly relies on the NTB device's parent device
> > as the DMA mapping device. This works for most PCIe NTB hardware, but
> > breaks implementations where the NTB PCI function is not the correct
> > device to use for DMA API operations.
> 
> Actually it doesn't quite work. This resulted in 061a785a114f ("ntb: Force
> physically contiguous allocation of rx ring buffers"). As you can see it
> tries to get around the issue as a temp measure. The main issue is the
> memory window buffer is allocated before the dmaengine devices are allocated.
> So the buffer is mapped against the NTB device rather than the DMA device.
> So I think we may need to come up with a better scheme to clean up this
> issue as some of the current NTBs can utilize this change as well.

Thanks for the feedback.

I think there are two issues which are related but separable:

- 1). Ensuring the correct DMA-mapping device is used for the MW translation
      (i.e. inbound accesses from the peer).
- 2). RX-side DMA memcpy re-maps the MW source buffer against the dmaengine
      device ("double mapping").

(1) is what this series is addressing. I think this series does not worsen (2).
I agree that (2) should be improved eventually.

(Note that in some setups such as vNTB, the device returned by ntb_get_dma_dev()
can be the same as chan->device->dev, in that case the double mapping could be
optimized away. However, I undersntand that you are talking about a more
fundamental improvement.)

> 
> The per queue DMA device presents an initialization hierarchy challenge with the
> memory window context. I'm open to suggestions.  

In my view, what is written in 061a785a114f looks like the most viable long-term
direction:

    A potential future solution may be having the DMA mapping API providing a
    way to alias an existing IOVA mapping to a new device perhaps.

I do not immediately see a more practical alternative. E.g., deferring MW
inbound mapping until ntb_transport_create_queue() would require a substantial
rework, since dma_chan is determined per-QP at that stage and the mapping would
become dynamic per subrange. I doubt it would be worth doing or acceptable.
Pre-allocating dma_chans only for this purpose also seems excessive.

So I agree that (2) needs a clean-up eventually. However, in my opinion the
problem this series tries to solve is independent, and the approach here does
not interfere with that direction.

Best regards,
Koichiro

> 
> DJ
> 
> > 
> > This small series introduces an optional .get_dma_dev() callback in
> > struct ntb_dev_ops, together with a helper ntb_get_dma_dev(). If the
> > callback is not implemented, the helper falls back to the existing
> > default behavior. Drivers that implement .get_dma_dev() must return a
> > non-NULL struct device.
> > 
> > - Patch 1/2: Add .get_dma_dev() to struct ntb_dev_ops and provide
> >              ntb_get_dma_dev().
> > 
> > - Patch 2/2: Switch ntb_transport coherent allocations and frees to use
> >              ntb_get_dma_dev().
> > 
> > No functional changes are intended by this series itself.
> > 
> > A follow-up patch implementing .get_dma_dev() for the vNTB EPF driver
> > (drivers/pci/endpoint/functions/pci-epf-vntb.c) will be submitted
> > separately to the PCI Endpoint subsystem tree. That will enable
> > ntb_transport to work correctly in IOMMU-backed EPC setups.
> > 
> > Best regards,
> > Koichiro
> > 
> > 
> > Koichiro Den (2):
> >   NTB: core: Add .get_dma_dev() callback to ntb_dev_ops
> >   NTB: ntb_transport: Use ntb_get_dma_dev() for DMA buffers
> > 
> >  drivers/ntb/ntb_transport.c | 14 +++++++-------
> >  include/linux/ntb.h         | 23 +++++++++++++++++++++++
> >  2 files changed, 30 insertions(+), 7 deletions(-)
> > 
> 
