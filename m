Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011014.outbound.protection.outlook.com [52.101.70.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE8033121F
	for <ntb@lists.linux.dev>; Wed,  4 Mar 2026 15:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772637361; cv=fail; b=kaWBYokDebkxsEZkNpHCH/0iEG9oePicAhzT4ZwbpZLHUEEryvZr6bAFqD0NSLZzV8IU3Y+C6fnZgyPzT3b9ae73vmuokrthg19Co9NzhvFhGmiGvN+6TU9SWr1Ab6QWJT3gihSY+j4ZKC4qbmb/N/8yJBs6GA5YF6MOUm3TfpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772637361; c=relaxed/simple;
	bh=qZqsb+NnL3TQYr4OA7CU3wOIwka3Zr9ty4Ig9qMRh64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZnD7VFb3/UQoqby33uyzA9GT6I7iT0ugNPsUrWNNw/QTu8LWPTbn8H/6LS2IRGDRq5/wrnGAo2RtXXPmGID9I02zDxiTLG+OeXlSJbdC0iv95EnNsKVn1VQx8Om7jLSfS/fW9AxCG4+CXwDkPpkwV2uD3nxgpJDH6XUFvF05skI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IwOMTjFq; arc=fail smtp.client-ip=52.101.70.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IwOMTjFq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zFNU8D7JW4HpHKJGDyh3t7qhKa+OKSKzaUQYlW6s8+YvbqAaN6Qq1wa9R7R3IqqPPCdSug57HujNUKFUBfi5hO/033TfVCI58cC/U1AZlXNPQKUdL1Xe0jYL7Q9q6vmkBYWCI3LX7YW2K8VivgOx6tNQl7IWaGaBZ6jFIrKMXfWODGfLIETZRBsBJQ+fJwjQJU4sZkLeAmilp+RMKYPa8/Fs+8d3B29vbeoi178QvTE9MQImK+3Jo37xAWchgxt2QokxVcFYXG6vVm9gYKnddjFCMQ1cAagGsMEbwccDzFRktcYG7J3ypHywOpQb/99aznQpUv+lR0AL01ztQIw09Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9enrEt4QhDPvomyy3zM3SZNxxOPg1+toFDn8ZP0jmPQ=;
 b=wCnOUmkNv4DTBfGTKOx2W3CliePWrqprtjz7wIxrZ/S25ixQIQlOOg7v53KSnb8fBUY4yZrMsj/j96yxyNaUSY8+c9oUQAHciIYAbherC2pRTsgqzoevRAt8LffpyWNnU5zFXK28o5QpoPexjccsm9U3geLVC8B6G5SCpikfqHhlYZ+QKKuWvmmuDOwtfyGtOR3NjGI1MLiQFGxJfluTpVP5cRmiLQ4vZJ8jS8d3ESLRpHOgiWysAtj2GE5iosmE4g03taXQfn3LS3bVuGO/HknwWenOXvI40qxqyxQ6UCXfWQoO7ZQdiBd9OTM2q1vwZl4SED1sq72CRk4QWSAHcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9enrEt4QhDPvomyy3zM3SZNxxOPg1+toFDn8ZP0jmPQ=;
 b=IwOMTjFqVb2iEQEI1WYFw1VfyJd56TuEdBHaiA2LNo5NcC2/uSY6hYE0fShm5fBV17mHri8aJMJ7ZNBEwfIHuGyDvzylQlfEReAUkSmPQstPqvUuYlxNwGtpUFyMmahkp/QvKpOsP4GEhNHH6fUJi3e1MAsqvWvme60A3KB3ftMDoRLWBum1dmwIM/aNKC8BuVLyXNBt3F94ByxPUkJLU6Wt/qgYxMSj8Zc9v8w9miUYrbuG8ZXv6/HW3bCxZFXlgPIC5yZkxW7JWLJ9V5dTb8Vyh4cc+HDGKmYj9OvuUQWcGTvlHhQqVJYq5ESOLMvs00TpiBB/jWPkRHaoYPbsZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AS4PR04MB9551.eurprd04.prod.outlook.com (2603:10a6:20b:4fa::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 15:15:56 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9654.020; Wed, 4 Mar 2026
 15:15:55 +0000
Date: Wed, 4 Mar 2026 10:15:49 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Jerome Brunet <jbrunet@baylibre.com>, ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NTB: epf: Avoid pci_iounmap() with offset when PEER_SPAD
 and CONFIG share BAR
Message-ID: <aahMpa1IPMRp9cbp@lizhi-Precision-Tower-5810>
References: <20260304020527.1067049-1-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304020527.1067049-1-den@valinux.co.jp>
X-ClientProxiedBy: PH7PR17CA0024.namprd17.prod.outlook.com
 (2603:10b6:510:324::21) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AS4PR04MB9551:EE_
X-MS-Office365-Filtering-Correlation-Id: fdf66472-2931-41f0-faa7-08de7a00ee80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|52116014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	3VvkkkKPLtdS+vp+qHdBL2lb1V0+oaqxTQ4q0YCFApleqs+wtSOSauBWx958u5ZTtRzlJu7wKCz5gNe9HZLS+pwhbtjqABHc62tNhVNWXdzbOYESsp5if3EMOFDflKBh6B6CYH/Nyr4ygsGaVgexLyLXB3Udcbg5F3pInAfmksSPMJU12S50WYFYNkHgzVYn51f0R75kvSmF9VpN7YM+ElCZmT/ad6t6xPxwqd3JOHBfH6mMNpuBYfX/GniGGT7esu0sp30wonexIhWeBDHgQc15hnWev8G5LPPj1iAJyQ9Fvl+z99Exn7amkUZYCRlz9xt++4GSbbMnMXHcy/3bqjH9kFzwmSkn/ZEGf5aeT93lb4KT/JGFT0HiEJNzCy/DFhzGCBbQ7fJhTS071JmolXXdjBhKBrmMB6XXYz/Gs9Io9Du4ofKlsXE0wNYdSp4PbpYZE6E4ZETxIPuFpx0R0TCVD4groon4AImvH6XvY7JVTNAJKLE6M7xnnxV2wz29v1+UpwBYd/pA9NVcsEnuI/LvDH7MXdWj53CefXaVNQbDWJ1gW+S4Esm0D/kVxc9yA+tjOsH7PBT7sxhEbj9CkUq/WrfQ/M6i1qov7pexIIQzJ/6aF+5M1Q3sM0oLgPBZDnD0cwzMeMXq03LNQyF4RjuVxfAgJuxeA080O5N1FufQ668tmySqQPChDGpoIADOe9vnhCLpukIzQUG8yXfuWbuTGFl7D+TVt+BEfR7hXGJzsmUa//igE7XJtiu7uKb0z4bwUgOxl1k9xkDDs2HcctDWyVslWQaQr1bw1DXzpKI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(52116014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A5PKa9r7ygQgmrKRpeIgfN3E3QHzqCfWtdIbAeoIKiXymjpnsTd8jETf+uMt?=
 =?us-ascii?Q?gG0hF06C8YqP9zq+uSJb6vFB04N0SC13NLvTZSokGExVY0bDNIMGecXDoTly?=
 =?us-ascii?Q?2OU/AOIS5lqNienpPqoxXr8F5ksLeNpnVBt1/XZjyYQfCxZhIdsiBEFaHmOn?=
 =?us-ascii?Q?YIUI3lMBQQEEXwM46zNjcjXOYqg0LvSDYwQkbZd4qhrSLby0ubcPtR45dU5S?=
 =?us-ascii?Q?ERzuwcR3idUfEOPsityZ9nrbRhMnAvsWRtyOMQDuQM/MtuiC9O7GixyqoBcu?=
 =?us-ascii?Q?b3oIAQq+s4A3YH/EEAemcMIFtL4ncT275wbY3vNjb0VGIx+94oVbQPI65PZX?=
 =?us-ascii?Q?qF+R+7MBU/AxsY43wFOSJgwvcp10KRD0heEXApQ6/D5g8HcABsHxC6zHDgBq?=
 =?us-ascii?Q?epa+I6Rlev7zbBEl0T7I6zcNYURkI9vU2zAmL18Dera+njxh7Gmmbw+HEMJ7?=
 =?us-ascii?Q?Pf+w6ZlSKiX4wFSF8bujuion44ZixuW7NNP+48nSIGNu3xr0PnezILPIMKs5?=
 =?us-ascii?Q?MjjNGLtS1KVFaac4nuXUtLzRG8rmOuUv41pIcH02XScl8aUXkCUskZLXmPg6?=
 =?us-ascii?Q?b62r23kR90D7f+D4NKfvR0pdKo3GSyOw2vzM6ZrGzVsynKphM3mm2cnPadpy?=
 =?us-ascii?Q?751UKbfFc0IXpeFKOzd9zr38uBUHqF2mAIcR+VcbDVK1eryy8g0UjKqajeA6?=
 =?us-ascii?Q?zqW8lXqbfizT0P8fzRfn0SL7rVLQ5IYRtIcDvgXxtb0xPujHdqKTZIn1HRHF?=
 =?us-ascii?Q?xVk+acfgVjjL5/6gtCHSfVSNn9AW8pV6xxPw+KHeIXWizZh9QIXPxvNUbFW0?=
 =?us-ascii?Q?tBhj3ZWkPg4wQWmf9CIomoW9nAoLFfxcYh7GtKv8p75oES6bXMUCJ+GoVJxi?=
 =?us-ascii?Q?6OyqaY4kFb7AG7KPNg6BLRYBx0rSaefoC0pxcbqcxEEv8Qsnq3lmSut2X2+z?=
 =?us-ascii?Q?X+ez8bTE5fbDat5k6ozdGdAjG9uNKPHjET5SiIeWmPqbqjN9OKmbUc21kmna?=
 =?us-ascii?Q?LsAZmSjnCkGcBKkaYJ7T7v8CnKM+q/FwSF9lrqI7mngB7LexFS7zjx5BrWPF?=
 =?us-ascii?Q?EB3sMuQWSonEworF3swUf5XhVrVEUipNquKPKdXEUJZwibST5txpxunHnzKE?=
 =?us-ascii?Q?gyLhzsBuM/lwEJlNz5D9EiR5G3B4ki8a8WYzrmZPUx35JYfKb52fvT9gXSMk?=
 =?us-ascii?Q?N8YxzKrbFVyhgm5cNv+2EGm4FCrQ0PNo4PaNUoTBlQU5sBMkb7frHOp2ARSD?=
 =?us-ascii?Q?ohzT1bBx5Xj5qhN3XcWohPXigF3R3WUFvFZabH4PT4Om966U1HUOqk9IxuNy?=
 =?us-ascii?Q?l3EPMVSmNaqPC+yvyNSJ4LjzdLHR5a4+PyGlaG1huSB9u01ZkvYrvB+jlRL0?=
 =?us-ascii?Q?bUEoLDbo7MBlkk2EiPBtIbq47kcPJ3l2y/Z3hHn96ECaJxxK3KSgV2U1fXE2?=
 =?us-ascii?Q?0ooPbjKiKhw1saknNj2YX72euVIhomIIZLyY2GUHNA9s6Ye9FAjUr2wYKHYW?=
 =?us-ascii?Q?7nZ2BMcMhHQT2bvaPBnUEww1VlC7+BA+PsA/e/VCpmgnYiBo4OusQsj45iHB?=
 =?us-ascii?Q?ec6xNQFVO/3phLiz2gqVjD5l+PgRFRp0hnJEnfzesklBNEmQUx1toOPD36Dx?=
 =?us-ascii?Q?xAsLE4XFomw5f8Iuz50CyQoTwJC1ZegpRPq91K14g3fGXymNe4yBaa6MgxrV?=
 =?us-ascii?Q?Cx2rFoj0feeIgjkwCJmi4vVTZtX17ZcIZAMDcD4EiXZH6wgN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdf66472-2931-41f0-faa7-08de7a00ee80
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 15:15:55.5101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: emY/OYHrCEWM8Jz/fRlB2y0LGkS9DttJHRM5i5h8uSckDwYmN+dXDkfFWtMFHB4AkMcvKcqqJ4qJR2AgAyIdKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9551

On Wed, Mar 04, 2026 at 11:05:27AM +0900, Koichiro Den wrote:
> When BAR_PEER_SPAD and BAR_CONFIG share one PCI BAR, the module teardown
> path ends up calling pci_iounmap() on the same iomem with some offset,
> which is unnecessary and triggers a kernel warning like the following:
>
>   Trying to vunmap() nonexistent vm area (0000000069a5ffe8)
>   WARNING: mm/vmalloc.c:3470 at vunmap+0x58/0x68, CPU#5: modprobe/2937
>   [...]
>   Call trace:
>    vunmap+0x58/0x68 (P)
>    iounmap+0x34/0x48
>    pci_iounmap+0x2c/0x40
>    ntb_epf_pci_remove+0x44/0x80 [ntb_hw_epf]
>    pci_device_remove+0x48/0xf8
>    device_remove+0x50/0x88
>    device_release_driver_internal+0x1c8/0x228
>    driver_detach+0x50/0xb0
>    bus_remove_driver+0x74/0x100
>    driver_unregister+0x34/0x68
>    pci_unregister_driver+0x34/0xa0
>    ntb_epf_pci_driver_exit+0x14/0xfe0 [ntb_hw_epf]
>   [...]
>
> Fix it by unmapping only when PEER_SPAD and CONFIG use difference bars.
>
> Cc: stable@vger.kernel.org
> Fixes: e75d5ae8ab88 ("NTB: epf: Allow more flexibility in the memory BAR map method")
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Split off from a previously combined series:
> https://lore.kernel.org/linux-pci/20251202072348.2752371-2-den@valinux.co.jp/
>
>  drivers/ntb/hw/epf/ntb_hw_epf.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
> index d3ecf25a5162..9935da48a52e 100644
> --- a/drivers/ntb/hw/epf/ntb_hw_epf.c
> +++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
> @@ -646,7 +646,8 @@ static void ntb_epf_deinit_pci(struct ntb_epf_dev *ndev)
>  	struct pci_dev *pdev = ndev->ntb.pdev;
>
>  	pci_iounmap(pdev, ndev->ctrl_reg);
> -	pci_iounmap(pdev, ndev->peer_spad_reg);
> +	if (ndev->barno_map[BAR_PEER_SPAD] != ndev->barno_map[BAR_CONFIG])
> +		pci_iounmap(pdev, ndev->peer_spad_reg);
>  	pci_iounmap(pdev, ndev->db_reg);
>
>  	pci_release_regions(pdev);
> --
> 2.51.0
>
