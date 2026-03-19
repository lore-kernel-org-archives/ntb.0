Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020104.outbound.protection.outlook.com [52.101.228.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA03B37269E
	for <ntb@lists.linux.dev>; Thu, 19 Mar 2026 01:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773884881; cv=fail; b=C8n7LB4SrSb4wZQMMZforCKxkuv4V0080ofSGxiiCwItucko+bN6jrQ7e7dL79JAsNPtvAO2d4V6ky5ok2SlZkZrDr+2Ku/fDUn5L6YDR/7PnZn22s3vK87rJTfbssjjxSzTrVDTp24nFQN6yYTr2yPJwtMyPxXTAwXJmJ6Vmok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773884881; c=relaxed/simple;
	bh=a/LvisvawcuMLEz878lK61T9tQk4ZvSMflzV9A1PGIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nmF7t0boI4vV+082CV/bg5PFiL7qm3v+EQVxtmXA7ARLAH++vhLoEtsCKdOyrsI0zMGywj4LPhR8wex+cZ511U3BFDaPdAf2dqlYovqUQX56U/NMz7BG86i4NyMZaFPQ7GGpEbL5ED0PeP7e74YnPbDOH+n6t4u5J58Rz1Z8vrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=agGiBtpB; arc=fail smtp.client-ip=52.101.228.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="agGiBtpB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FUG/LAMy3w5u/MtRSMDOyG6f4ke5lL9/KxGL48lGpE015QTdZ5Rm69L7JJa2/LUJKRcLGTcO0pIFKbpUOToe5B6ORHrIBZf176jWnq6+uwaf2sYG9Bh7bZr5ts+sXxJFd7LZV3zIrXyyBr8LRW7YKja49du3jV8pmXcWf/gT1kBmdt4NZhtC4Ek9ffjwbqUh0vIW3tG0rI7MXAr0axPQvHBXnz55WExhSqxjqBbJKcm5AJYLhiiyu2tAJIwTtVEs6HUOzAXZIdeQiF83Y7VBMHx52s2oB30yswAKCWgG3pbEr1xHAACsPWbU+QHxvSlIZOfSTvMgkoXhRGQLHYjNqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ODi0/++ffKQUVDuy563zqnkbrU02SIlvHzVLjaTKkOE=;
 b=DMQ2rHJwwNnELxB59fXNMekNyiSx+UO4BRM4Vpeu4xrLjvywe7RV69NooFdSEeINxN6xFmiSR6qkFAi8TfAaJJFnv7IzzN8NKIzRBFeqU7TFQjtzyD2rgKn4DLbm66IYpsSAV4G3lfhPojWSZZdHN/lM/kw9p53mgfiZWaFhrc92LQ5DX1p4IvMtplOvnFQA724jIC44xJMsdIr//YSWzE8yiMlsHxAW5roBfllI4VtPjHTTCUKAh9wyGmXogqbNLR4KjRDPIQTJH8/KM/XSoX6kkPjVhcRVIyGpshw5YPu2v8JODB9OQAWk8u4F2FMkw2Y5lOhEFMqlwe4ZQNyIsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ODi0/++ffKQUVDuy563zqnkbrU02SIlvHzVLjaTKkOE=;
 b=agGiBtpBzEcKX6iW2JgQdoGOtD6LlWWRvtxAY6m97qqhWs6RVRoDzyF1VVPmtC3NZ+zz433fL5lJXX9KnJrNbvwgoahILO9TrG4YlDPHbL2J4yZzPdz6Y7DIfw2zWI/E0VrsYAD1ptlxRRosZS/Mi8N0o6EzhhdYZ1GC+YEm5v8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:23e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 01:47:52 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 01:47:52 +0000
Date: Thu, 19 Mar 2026 10:47:50 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>
Cc: Allen Hubbe <allenbh@gmail.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Frank Li <Frank.Li@nxp.com>, ntb@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NTB: epf: Avoid pci_iounmap() with offset when PEER_SPAD
 and CONFIG share BAR
Message-ID: <xkejqnvicthypmr7giev7mhdnwausrfcqsoo3ciqh5e52fo4p2@7z6ahltrhea5>
References: <20260304020527.1067049-1-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304020527.1067049-1-den@valinux.co.jp>
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
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY3P286MB2611:EE_
X-MS-Office365-Filtering-Correlation-Id: 0958495c-d82a-4621-d0b1-08de85598851
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	dNdXz4MmSIq3dRVnfMi0DXl7T16I6+UgwrOWfgcW2AWl79z62R7HxChEIYPunkyw7duX5mf6NThWxbjavYYwG5UnSRmEbn49uLtg0hxLqMwycqOFr7MhjArcuLZ956CdfyY3asb0pm/nHeJqxM6RE1hsaJ7THXvgN9BYrU0OZcWr1dH66uhN2o1vw8oqr2dPzg1pNV3b87mXrNMUfsn/2VansrPrOHVsesjOE93YWv0p4ZSHkLB3dCMhvI29buNW9ziekzCe0sAiQNXKLRxpdH/SNwjNHroNRAQE339L6wO/Ye+z4Litj/+EByG5eLDujD1Q/4uRu5N2ChilunqZY2bdptqs0dGBMbC3rJMUpTcZ5JsA9KvX09JWZlDsiGlnxY1BU0jLhxScA97rWTxZpmRMwuDqswi8QldrHx+4XY1LtSVHW7WUTTke4Ahdr0LEAE+EhGiuYWk0z2pcMULGOEqKonfOBf8LZJzYiI1shHO/VdrjCRGOFRobwjbxjuBmNy1u1v0+bSq5GffRmH6PZRAHe7eBJyxumxt7lxpYwcbU7WzCdYH2G0kvQPs3eUZHxdvO1r3m7kKjnYAtVpr2P2KhzJp97L/HkOqJakJvvGdARvSq8Sch42a4lrSulFY5kGLdEEtyWWgyf1FSp9ptblRFSKSXcZmdpnpUEYfAQnaitkKydJGBbErw4LyvoggpFtXEuNggDSYD5qzZ7W4gbvdb15XgpWbESSEPKjm4EaQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Gd4FOk39/K/gwo5JoezetTe6ZK6dSdMLOdsGsRY/YGlt6Lo4GRDP0LUudZFr?=
 =?us-ascii?Q?f5j6Y36sjnQ86J11vSa+qOu90TP8VXYJYjeVmPii0oYoSwrWBtAgfTM64H3v?=
 =?us-ascii?Q?5MF3UWY9YLsdZAGVok1UVH/uEvHmfDuUG+80RfMGLwsmlWn7VdtvffnEMqL5?=
 =?us-ascii?Q?o/ivxIax6xIj9zRByvxtR9cJMBeM8TQiu8u3YhItip5n4sLbg/t8zFO8/rgU?=
 =?us-ascii?Q?tCJLCrcjNXUJCgdXFO9iJmaupPPK+mNDfoKIvjCcGI+Qbet8X31/wqvz51iY?=
 =?us-ascii?Q?tDSpqjOzq2pZejiBffAC/BcJlbUhyTbVWMnshVQo87mMSFlr36MDT3qQYfpq?=
 =?us-ascii?Q?JUllZAj/7qJocIoJW/rrr4MbbKrdviLQvuHSsE9zk24gQglXOwCEB2HjI3Gc?=
 =?us-ascii?Q?bgbS47atBl3J5Wcn/qFjLekEefeBSR9LA23OK9z8iYTzcxaCiEWVT+zwhrKS?=
 =?us-ascii?Q?sROM32oESf4HAh7kwGsEqLJ/F3nhWDPyDq8OR+3VsKZkzPtarx0OKb5HKmM8?=
 =?us-ascii?Q?HZU3JW0Gw5dXaVWZOsesbaZfhr6XT+7brqkVoEwGClThKl5YWqcpRoxWeS0S?=
 =?us-ascii?Q?cJrVDSggcVFsxjsz7i21eebKtUPs6r78YabVolmchnJgovT99a+Rnj/EkonQ?=
 =?us-ascii?Q?83VGQhkgworzKQgDpUL5fLt5LhS8ANwfNhROi+oZihY0aJOEPCDMmz/lGWVd?=
 =?us-ascii?Q?bGSu+eawHRsR5UwqqZjPxWzFVXHBDPRNc83u4BlWrY+2+J0dZN6Hgf0N6c8u?=
 =?us-ascii?Q?fR7G9Wo2eXpnXrt6aVyk1XY88qKbY9dHNzxfB/hayo3x4OnnmAvPq32HPUxv?=
 =?us-ascii?Q?CUOB42tB80EhZ/QCYRCtpxIEmGxNOeKWoSLEm3yQALcOFqaYbmQpLK+zEC2x?=
 =?us-ascii?Q?PSbhi/oHMfTHriXPwtoACRjVta6DPt4QQnY9NsDpuw4ZR/60fTgMPhfS5lHG?=
 =?us-ascii?Q?eJj2jQnrQ8zde3T8Lh5zsGoLNM1n6rmDiYvLeTxEdi1cvssT4v3t43E7TFi1?=
 =?us-ascii?Q?8qi6P+6ctXDDXLbZUo6DscdlLDQnpsxADK+w1TwQYQ16wFbnu+3BpB09P38a?=
 =?us-ascii?Q?Ty3hNgB/Z0/eWTUz9usaW+yFgRVIxDB7tSD6IJOi9IKfjahyhVz4bWohJbvK?=
 =?us-ascii?Q?dw7P7jAL3iCgoLAImcVngUmqRY0Dl9AS3IxIfD/eC4ny1VSVpNpD4BOevQgE?=
 =?us-ascii?Q?BLcFgNiIE2LNyF01hieupUu288ybyxE9R83298R82U+VcDasdWC7umRq2UBn?=
 =?us-ascii?Q?5/qTC9VBCNDt8+B2W6uxriMdASRrhqr0tHd5jItDBOQH0gaMhScLeOGrX+O6?=
 =?us-ascii?Q?Nn+DZiAAD1/p/O0wWE7mikwhvCg6Ta+/FufQ5vAGfjNsHRcZecS6RWiYWlUi?=
 =?us-ascii?Q?P9NubAXZHYNq6vZRdRezJvpX/N91/o+NinsLPjLCjpYRJ9TQTVaxjw99QNpa?=
 =?us-ascii?Q?ug5lSyZDqE4hUlUe20zL2HKASSNnD0irTAQPTankydYYS1EvZO+6utsU54r1?=
 =?us-ascii?Q?ts+d3/joj3EdgLRnPL7Z0Q/ivaXI8T7i86jOYyrkXPNzwyYgCatqb4QNaGTQ?=
 =?us-ascii?Q?Ltz9h0+s+Glt4qMUW11+67k24wXJVRsbKqwDOG2QuptkioioFxeggj0vis24?=
 =?us-ascii?Q?rKD9ufiUcuFTWDb3dIdh5GdxVLYT44slqOaVBvThGrlRC9RWfwqzHdPmFKQq?=
 =?us-ascii?Q?MFS4b3V6N097xxoQBJbWMYc8Drp/1TU7v/kLt2dqCJDVMTWf5dz/fmTirF5Z?=
 =?us-ascii?Q?WW276HjLV/nTX1kjdWLxpLceRCfaj9KFLwqDEmcBWe1sj0225ADY?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 0958495c-d82a-4621-d0b1-08de85598851
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 01:47:52.0145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OEWffA/Bsq6YQKlW7zZcN1PqBlenWh/fDd9O5M9qEbYPqBUBGgKYveqPe99VoXBUsRSO5dgPOJ533txRKdELiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB2611

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

Hi Dave (cc: Jon),

Gentle ping on this fix.

Could you please take a look when you have a chance?

Thanks again for reviewing the other fix series on ntb_hw_epf.c yesterday:
https://lore.kernel.org/all/d931ce45-b3c8-4cb7-80ec-7acadf26a22d@intel.com/

Best regards,
Koichiro

> ---
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
> 
