Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020092.outbound.protection.outlook.com [52.101.229.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32774C9009
	for <ntb@lists.linux.dev>; Fri, 21 Aug 2026 14:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787323128; cv=fail; b=GDXQVlNnx2Z2/uPW5ZPPxwMzIhNZfPDXYzfslFHfiqEOAIgH4dhzBeKwD0igXpY9kPf314bm54v6cVvOco5ANPrrCr5OKj36ujSa/Omzz1u7ypTHuxKORSSsHz1vR5jIHIVJwE8LHvgCYB0MAmWKHHl+rqkU46weBJwLg4dHY58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787323128; c=relaxed/simple;
	bh=7p1t8mDZq3M+qSEI2o7GXtcFlT5CeO49OikjsIPiEMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=s2D/vc4mrTEw6vP+F0lJGLEYOkj6KK99fBHpLl8OG1ZcprDdGeGN2Z4QomKTjRigQtWrvW2I8qQGNFV2lm/mJH9UNB2m3RvBISCu+n1WYzSkwlxL+2QgpMX+LIB9aYe9OL6PcINB4tTVtridGUzPjUrQ4PQw2EFgZWbIFxFciLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=R/dcXNmR; arc=fail smtp.client-ip=52.101.229.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="R/dcXNmR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Baw3nyp/mr+QwjBSxKwJGTVQzmW3sAH+L+1V+/k7fn8VS2qXErVllNxWf79NIBroPc/noivRt4dabCjDBjIFNBj8fQL6ij7ZzTzoHsxPV3+BtBptKf0ATQfK1RcKZfyVqBNGE6jipPns94+gtYTggtVDOsiBriYC4No4/+PsQEp+5e411ZeZGAN6yCu9YiOwBzA4hf1lHEW/UuE0dUrD0Ce3o5u55NahZB3uh1fl+scN/ILH2Ztr/payRj1nIHLReKijrGcUhEqusSIcpa9L0tOWaTYUYHNPsnF8MxCkje9TMpFIKpfvznyp3EKq2eeg5k+IhQic1guYDUNJ7K8J5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZIY713RqFp5NVR06NAeVokdgbce/zm9k12Minyyd7s=;
 b=YttF6vY1F36tG7o1SUOo2gx5hdg4FXD9L1BTFiuGyHUk6SSPQuYs8sVdIVOE+KeWyjuOZpviSzPIqTCV3NkFyuxaK7rv4IA5HvfLYFP1EBLF/g3wuY8+QrZN3T4qKIKquqdYyb0iTZXtiLnRg1xUhv9LR46kMd46Pwu2TwKwZEvBpS+tYQ2wClfag49TOYHKpdevnGYtbhdSvBQJug5vlrzJWoVZsX3uuQQ83bJZvGuWyOjzDqHRfCV9oD0cK6w/o9uD7dzP5InHP0ZrHDRysutAXk9WKwuRvzjet8DO3T66BDSHBlaWrGU/6l18clEcgwyqT08RitnjGLgQ5w4KhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZIY713RqFp5NVR06NAeVokdgbce/zm9k12Minyyd7s=;
 b=R/dcXNmRrcJoEyF7hYsHQcu1eELbtsLJccpOI1kvRwXNqybCbJIaIkcrSMlFBOcLXe2bf0fwFrUCI3WiAedV2xyPc6dJ/xeXpFU9tmsZIoN974YKIdPQupvO6Ml7/+gg4+ocu0QffbxCmyxJtyS9P1Ikjk3HqVj5EVzyhd61J9s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY4P286MB7086.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:33e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 14:38:36 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0339.007; Fri, 21 Aug 2026
 14:38:36 +0000
Date: Fri, 21 Aug 2026 23:38:34 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Jon Mason <jdmason@kudzu.us>, Frank Li <Frank.Li@kernel.org>, 
	Allen Hubbe <allenbh@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Niklas Cassel <cassel@kernel.org>, Nicholas Bellinger <nab@linux-iscsi.org>, ntb@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/16] NTB: ntb_transport: Add opt-in direct-DMA channel
 reservation
Message-ID: <xspfobekn74ua5g447ibtmqyvn5sbfflftnnebzf7gb3b55b4z@ls3mqy2xifva>
References: <20260810165136.2292436-1-den@valinux.co.jp>
 <20260810165136.2292436-9-den@valinux.co.jp>
 <60af3a30-dabd-4013-8324-f950d8add1fb@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60af3a30-dabd-4013-8324-f950d8add1fb@intel.com>
X-ClientProxiedBy: TYCP301CA0026.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:381::10) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY4P286MB7086:EE_
X-MS-Office365-Filtering-Correlation-Id: 951504a7-8c76-422d-3372-08deff91e219
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|10070799003|56012099006|10067099003|6133799003|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	md7OhnRHJtgXcOvZfgWjRlAEmoHr167a26shRrzKFgFFZxFMNaSutQgkzYwE0f5I1jDeUOlsN0tKsI+puJ0yQ02jO2N0ExjgfGOTKJZe8szuMga/TUPVBfk032GBMyF5ppNRXubMAISqb3u7refacpCQpkLMR09qrqk6/WcBofq2bCauvOan/cUHGyADLktXve8LKzoEw4BE4P3DsWCXv4Q1OPi67kdhVZJWGWt9+zm6T1YitOqn97Vb/zT7YxgSTMgqJpqf93j+NMiRG1FpM/YMRuvjwqtNlwUD7DVU0+xGnZ4IR9XVKJumAXddkz7PgecCcVnl22O7a8YvkiQcoPxeCSJ4ngvJhTVZg187OwndMj2LIBj22/091krc5gqRmyaz1p3f4/OhP3R/kcgkVGf91P/AWGHQcwo0rRtMhCyJjx1cyZmsQSCetP8PzKWDfDyuXUbil/C/6hz4HS7RVH+adSPTPbH5N/eN/zgaHG1lCXANx4j6JNwUKfIttt3IYyFKDrxytenQm30nKYPB7139/jHYwpIJnXYPm22nmiqtvp3Bml1lVeMkacVvtvhDggdURNAdojkOrQwq8yWQnQYqgSoz6EIb6RTGtXSF+8rBQfNv30WJ7M095Fk1g9iV5yVfHUiW5yHwio8CnFL3c1wtTYKuYSzlEVBq2iV5uOs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(10070799003)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dBB3DshrZaMisJHCWcUDV7RcghUETNhEvIOoOxghuhgKWGUp9MR6WmRotgRD?=
 =?us-ascii?Q?yCQpzRGoVXnZp0MrvhE+ym8I31qfhqx2Md6gdHcQzjzjZoOmIMqS9sum+Yga?=
 =?us-ascii?Q?DaPRG/aU1CBLzUCU2zw2lF6ciRFW4TdIYUFnnM/Q8mkcHZSgql7yi0Q3EtB1?=
 =?us-ascii?Q?zEbDGVM2eUg4TMGTHtSwq/7ckhGBrOOZgfkZFadt4ZH8kVe7D4HB4Ed7jbjj?=
 =?us-ascii?Q?JM8THpqpFE1h8gPkoL/hiYVRFbxx+2ELExT32SqOVwoTyeVnydBHwDj1ADix?=
 =?us-ascii?Q?1Ab2WdBg65Y4C1OUerRatSkxNmvFDPvjkri9Dzvk1wUZZeZUPoEKOUl+alxH?=
 =?us-ascii?Q?9xaa+yNh+N8lnjWQWqvYBxHgX5ay6eUW/aRlboAaGefA/7FQQlksd6wp609R?=
 =?us-ascii?Q?zM/qxjZgJSZuT0WV2CrXwDCfQ/WuQ2rRBgV/RMtprQV4VLLAdYvecBR9QCcz?=
 =?us-ascii?Q?ItjvtnbCRcpVrZ51TRKwMcNALbkOHncPX5fbxFmQTxbBO7NkosLUgXcdZRc2?=
 =?us-ascii?Q?8ZPgxRilkf1PvUCyBmTksSekw2Re5Or5ibdUaMXLvirWzP6GFILTEka24uCE?=
 =?us-ascii?Q?evZP/Brq1KNfGxjAI/15xrQ3zYatFr/jVLUgGneN5npSOmcYtPd+gKZDC/R/?=
 =?us-ascii?Q?MzadwumSJcuju8gO4LuIbRvbZ6BEmmaJU5HBkgkFogyRUEM8Sq1lwhUZx5Jb?=
 =?us-ascii?Q?vCePg57tghy5TRapl8u55wq4G74wOWEKVOaUkzy7Gq9s81+DMUPyZmwN+36S?=
 =?us-ascii?Q?bSBZZjJuZ99xv+UUFWsF7OELYoNIbOUNkm/0xeVudMPcKI2z8uvLnbMxMj3p?=
 =?us-ascii?Q?ggqSfSLe3r3M0TZD89IEohQSgX+1DQmphKTkFaM+xZztZYgBfZx7MGepgv5f?=
 =?us-ascii?Q?S4xHYVJk0OcNkI76GgnmY3TKoiz+xHiO9mWo2XnFUdWSVyG2bG8PjKMkq2XG?=
 =?us-ascii?Q?1wHkHoHYC16Cla7WsldiedAIviCxATor41bzKF4Rz7nvuF1OvZvliCXxIfRE?=
 =?us-ascii?Q?7prv8IygVDeYhUBzKN3JBedH3C1PN7La/Sm5L2Z57KklZnygaJ55iX3YWVOY?=
 =?us-ascii?Q?1PaBcIZixrOxdIdn7Ve564Ew5xo8P6ix7q8c65sn4cffl+jTKmrd8r0nU39d?=
 =?us-ascii?Q?bd0RUoWNhmXmYFgKX1LW5GAXjru6IVW7kalQX+tWbgqiNBcyDJkxSrvfZ2ji?=
 =?us-ascii?Q?RceON1ahpcXu2wOhdgNZbFZ/DkWTSaoq2ez92neqtXzgL+QZBarj1mjAV2oR?=
 =?us-ascii?Q?rbOIO9RYRe8fEG/NHBDNf7/7d072R4Jt5zH9OdTmvbM0TuU+OvWIOhARMNKE?=
 =?us-ascii?Q?vmjnVyYS0gmVclw0wPjfd21JXvpMku/NOHeNCtbGptQfWhq/dzEYGRArDGP6?=
 =?us-ascii?Q?eEDYiw3uOO1ZF+NlJTG5AuL2hO6rIZ6fsdFBJbPAqJ9foGeK2M1ZvmAgzNJH?=
 =?us-ascii?Q?KuNVB734ASq+SgVdFWNmq2hiWfLo5ZVkZDtS3r0ZuneDKVY9kYhhfexXD/Rd?=
 =?us-ascii?Q?KXaGbzWUSis7MtGI9KKWNoYITPgt/Edk5iLWS4SpY/7dlY2OJ94huj7BCMsg?=
 =?us-ascii?Q?O4PFsqC7e7pBHJmWnMxmdLkhJj8JCJSF3goZHpCjahN+9gpBVBYkD2vCdwiv?=
 =?us-ascii?Q?Uf4zcuWoA6fCBmbNawXgz3kgQclywR2qKBzW9bm6fbzXp09yOuVWhYuLVMkl?=
 =?us-ascii?Q?Ke+OfHtowJL6FCsBB5EdHTnhbrWfw6qTmVu5jVblE9sKuRL8amwUmRFa0OOI?=
 =?us-ascii?Q?7+fuR49XkcQSIOF2WXvvzXKeA62rLyjk7h/s+w1UkSjvRV/OJzF1?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 951504a7-8c76-422d-3372-08deff91e219
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 14:38:36.2829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J5zziugJrxTKK6Y2EUar2WtJzmHd3TPalIYxxTvmpJSXNoXLfvS2KVEnVxwo48kPkUnXYBkms8oQT2mIl3qo4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB7086

On Thu, Aug 20, 2026 at 01:03:45PM -0700, Dave Jiang wrote:
> 
> 
> On 8/10/26 9:51 AM, Koichiro Den wrote:
> > Direct DMA is opt-in. Add 'use_direct_dma' module parameter to request
> > it. Some endpoint integrations expose NTB and DMA through sibling PCI
> > functions, so add direct_dma_func to select the DMA function when the
> > NTB device cannot return the DMA device directly.
> > 
> > When use_direct_dma is set and negotiation scratchpads are available,
> > locate the DMA device and reserve one suitable channel for every QP
> > before registering clients. This avoids negotiating direct TX before a
> > later-created QP discovers that no channel is available. If the full set
> > is unavailable, leave direct TX disabled. Note that direct RX does not
> > require these channels.
> > 
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> >  drivers/ntb/ntb_transport.c | 120 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 120 insertions(+)
> > 
> > diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> > index f873eacd532b..6051d8abfc0d 100644
> > --- a/drivers/ntb/ntb_transport.c
> > +++ b/drivers/ntb/ntb_transport.c
> > @@ -98,6 +98,16 @@ static bool use_dma;
> >  module_param(use_dma, bool, 0644);
> >  MODULE_PARM_DESC(use_dma, "Use DMA engine to perform large data copy");
> >  
> > +static bool use_direct_dma;
> > +module_param(use_direct_dma, bool, 0644);
> > +MODULE_PARM_DESC(use_direct_dma,
> > +		 "Use PCI endpoint DMA to transfer directly to peer RX buffers");
> > +
> > +static unsigned int direct_dma_func;
> > +module_param(direct_dma_func, uint, 0644);
> > +MODULE_PARM_DESC(direct_dma_func,
> > +		 "PCI function number of a sibling endpoint DMA function");
> 
> This feel like very adhoc way of determining which DMA device to use. Is there a better way to do some sort of auto discovery without required user input?

Hi, thanks for the review.

Yes, I agree. The PCI function layout is still being discussed here:
https://lore.kernel.org/r/fg7cma2ccvdgjgcref7qa4q7ocvvume5dteekedikszebkq7rd@uhrjfp3nmmwh/
Depending on the outcome, we may not need this parameter at all.

If EPC-local DMA is exposed as part of the vNTB function, its association is
explicit and no function-number parameter is needed. That was my original
approach [1], which you also reviewed as part of my gigantic RFC (thanks
again!).

If we keep the separate PCI function used by this v1, its PCI class can narrow
down the candidates, but we still need a defined association when a slot has
more than one DMA-class function.

In any case, I'll align v2 with the outcome of that discussion.

[1]
https://lore.kernel.org/r/20260312165005.1148676-1-den@valinux.co.jp/
https://lore.kernel.org/r/sn67hi7kljh7cgmgodatb3naz2astlaklqfobdbxyyzgoohxqb@4nnetbhqwba4/
and later tried the separate PCI DMA function here:
https://lore.kernel.org/r/20260813063757.3131865-1-den@valinux.co.jp/

> 
> 
> > +
> >  static unsigned int direct_dma_ring_entries = 64;
> >  module_param(direct_dma_ring_entries, uint, 0644);
> >  MODULE_PARM_DESC(direct_dma_ring_entries,
> > @@ -147,6 +157,7 @@ struct ntb_transport_qp {
> >  	void *cb_data;
> >  	struct dma_chan *tx_dma_chan;
> >  	struct dma_chan *rx_dma_chan;
> > +	struct dma_chan *direct_dma_chan;
> >  
> >  	bool client_ready;
> >  	bool link_is_up;
> > @@ -269,6 +280,7 @@ struct ntb_transport_ctx {
> >  	struct work_struct link_cleanup;
> >  
> >  	struct dentry *debugfs_node_dir;
> > +	struct device *direct_dma_dev;
> >  	u32 direct_features;
> >  	u32 peer_direct_features;
> >  	unsigned int direct_ring_entries;
> > @@ -352,6 +364,97 @@ static inline u32 ntb_direct_ring_used(u32 head, u32 tail)
> >  	return head - tail;
> >  }
> >  
> > +static bool ntb_direct_dma_filter_fn(struct dma_chan *chan, void *data)
> > +{
> > +	struct dma_slave_caps caps;
> > +
> > +	if (chan->device->dev != data || dma_get_slave_caps(chan, &caps))
> > +		return false;
> > +
> > +	/* Payload and completion descriptors must complete in order. */
> > +	return caps.cmd_terminate &&
> > +	       !dma_has_cap(DMA_COMPLETION_NO_ORDER, chan->device->cap_mask) &&
> > +	       (caps.directions & BIT(DMA_MEM_TO_DEV));
> > +}
> > +
> > +static struct device *ntb_direct_get_dma_dev(struct ntb_dev *ndev)
> > +{
> > +	struct pci_dev *pdev = ndev->pdev;
> > +	struct pci_dev *dma_pdev;
> > +	struct device *dev;
> > +
> > +	if (ndev->ops->get_dma_dev) {
> > +		dev = ntb_get_dma_dev(ndev);
> > +		return dev ? get_device(dev) : ERR_PTR(-ENODEV);
> > +	}
> > +
> > +	if (!pdev || !pdev->bus || direct_dma_func > 7)
> > +		return ERR_PTR(-ENODEV);
> > +
> > +	dma_pdev = pci_get_domain_bus_and_slot(pci_domain_nr(pdev->bus),
> > +					       pdev->bus->number,
> > +					       PCI_DEVFN(PCI_SLOT(pdev->devfn),
> > +							 direct_dma_func));
> > +	if (!dma_pdev)
> > +		return ERR_PTR(-ENODEV);
> > +
> > +	return &dma_pdev->dev;
> > +}
> > +
> > +static void ntb_direct_dma_release_channels(struct ntb_transport_ctx *nt)
> > +{
> > +	unsigned int i;
> > +
> > +	for (i = 0; i < nt->qp_count; i++) {
> > +		if (!nt->qp_vec[i].direct_dma_chan)
> > +			continue;
> > +
> > +		dma_release_channel(nt->qp_vec[i].direct_dma_chan);
> > +		nt->qp_vec[i].direct_dma_chan = NULL;
> > +	}
> > +}
> > +
> > +static void ntb_direct_dma_release(struct ntb_transport_ctx *nt)
> > +{
> > +	ntb_direct_dma_release_channels(nt);
> > +	if (nt->direct_dma_dev) {
> > +		put_device(nt->direct_dma_dev);
> > +		nt->direct_dma_dev = NULL;
> > +	}
> > +}
> > +
> > +static void ntb_direct_dma_init(struct ntb_transport_ctx *nt)
> > +{
> > +	dma_cap_mask_t mask;
> > +	unsigned int i;
> > +
> > +	if (!use_direct_dma)
> > +		return;
> > +
> > +	nt->direct_dma_dev = ntb_direct_get_dma_dev(nt->ndev);
> > +	if (IS_ERR(nt->direct_dma_dev)) {
> > +		dev_info(&nt->ndev->dev, "direct DMA device unavailable: %pe\n",
> > +			 nt->direct_dma_dev);
> > +		nt->direct_dma_dev = NULL;
> > +		return;
> > +	}
> > +
> > +	dma_cap_zero(mask);
> > +	dma_cap_set(DMA_SLAVE, mask);
> 
> Are only slave DMA usable in this case? Is it not possible to do DMA with host DMA engines?
> 
> My main concern in all of this is looking for a way to make this usable for all ntb_transport users if possible and not niche the generic code to a specific hardware vendor.

DMA_SLAVE is only the initial capability mask. ntb_direct_dma_filter_fn() then
filters further.

A host-local DMA controller may accelerate copies into a fixed NTB MW, as the
existing MEMCPY path does. But AFAICT it cannot generally write directly to
arbitrary endpoint RX buffers. Exposing each buffer per transfer through a
BAR-backed inbound mapping would put mapping reprogramming on the hot path and
defeat the throughput improvement purpose. Direct mode therefore needs EPC-local
DMA, but is not tied to a particular hardware vendor.

Best regards,
Koichiro

> 
> DJ
> > +
> > +	for (i = 0; i < nt->qp_count; i++) {
> > +		nt->qp_vec[i].direct_dma_chan =
> > +			dma_request_channel(mask, ntb_direct_dma_filter_fn,
> > +					    nt->direct_dma_dev);
> > +		if (!nt->qp_vec[i].direct_dma_chan) {
> > +			dev_info(&nt->ndev->dev,
> > +				 "not enough direct DMA channels for all QPs\n");
> > +			ntb_direct_dma_release_channels(nt);
> > +			return;
> > +		}
> > +	}
> > +}
> > +
> >  struct ntb_payload_header {
> >  	unsigned int ver;
> >  	unsigned int len;
> > @@ -1476,6 +1579,16 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
> >  		return -ENOMEM;
> >  
> >  	nt->ndev = ndev;
> > +	if (use_direct_dma &&
> > +	    (direct_dma_ring_entries < 2 ||
> > +	     direct_dma_ring_entries > NTB_DIRECT_MAX_RING_ENTRIES ||
> > +	     !is_power_of_2(direct_dma_ring_entries))) {
> > +		dev_err(&ndev->dev,
> > +			"direct DMA ring entries must be a power of two between 2 and %u\n",
> > +			NTB_DIRECT_MAX_RING_ENTRIES);
> > +		rc = -EINVAL;
> > +		goto err;
> > +	}
> >  	nt->direct_ring_entries = direct_dma_ring_entries;
> >  
> >  	/*
> > @@ -1582,6 +1695,11 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
> >  		if (rc)
> >  			goto err2;
> >  	}
> > +	if (ntb_direct_spads_available(nt))
> > +		ntb_direct_dma_init(nt);
> > +	else if (use_direct_dma)
> > +		dev_info(&ndev->dev,
> > +			 "not enough scratchpads for direct DMA negotiation\n");
> >  
> >  	mutex_init(&nt->link_event_lock);
> >  	INIT_DELAYED_WORK(&nt->link_work, ntb_transport_link_work);
> > @@ -1605,6 +1723,7 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
> >  err3:
> >  	ntb_clear_ctx(ndev);
> >  err2:
> > +	ntb_direct_dma_release(nt);
> >  	kfree(nt->qp_vec);
> >  err1:
> >  	while (i--) {
> > @@ -1648,6 +1767,7 @@ static void ntb_transport_free(struct ntb_client *self, struct ntb_dev *ndev)
> >  		iounmap(nt->mw_vec[i].vbase);
> >  	}
> >  
> > +	ntb_direct_dma_release(nt);
> >  	kfree(nt->qp_vec);
> >  	kfree(nt->mw_vec);
> >  	kfree(nt);
> 
