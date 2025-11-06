Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010040.outbound.protection.outlook.com [52.101.229.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F6518DB2A
	for <ntb@lists.linux.dev>; Thu,  6 Nov 2025 03:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762401569; cv=fail; b=R0HnsMN7DgVT/dLwpuJhYXOczsglM+VwSROf/QHPNmqXI7V4AcVTAkMNkmdXJgoJ6Y8h+s9htRcS1mIHA8xIeRnvwjlJpQhKHHdGBrt/QAFqg5PbBb5DDbZKX7NV/wGUh8gv7Edr9V+d/KVpuUhXPhVcsAUpcAQ/BoNaG0/kK9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762401569; c=relaxed/simple;
	bh=XRufEigskYE0gG8u75dq83kM12oLgVbG86hqm8rJPT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Rmx9rGavIxZcT9AiJmbsPCkFi+w1Or9ZLQiGHYgHpX0ynT9KmmPb+Ap0fNYuHGGE/k2x3jntaZLliEcmaBa1sQ+tb9dj/CHKoRSnx+jWXyVCTzNwLiebwwpf+2xY9Cd9ihfWE/dlhcGO+D0d80DJyU6RpSIBDezrXZjeGKTDA8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=MwEY012m; arc=fail smtp.client-ip=52.101.229.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="MwEY012m"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XXN4q5ugADDcRF0RinuzgCcpWnVWmy2MgjHZes7Hk8S27MtvV7rOBHClA0zP8TxuAx6dWOZm6sLdnZuPlEbfCSu4i2V2nSmVpjrMpfWCeDxAXY8rvnP4f5Tyy0bbMAKBvd14PN4OlX3aZzVMQYgPlARkegl+8EHwKKPSHeOcp72D+ys5j0iu7+Mod+5bNEZpvE2csduStLRklTxuM50mWQK3dktW+uafPaEs5AIKWfbCiYjfcNWBG8+KbW0Kg0lk1wn8gFbnxUlv1d3RK0azWUYDjBFHpeasOXAx6k/CpLQi8/4DEIIXfJSjKjXiN6eLpYbWGCH8Sb710aUyveahyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7lFNhmHX3fqEvjWm97qRebSkbbZ/7FXZ6UOAGJyIHho=;
 b=r4UB/iTSGGXegn4S/KBrqjs5VkQToUZN8EDZyhNhACRKZsauAVfsZ37rTF4PeDeBXLYPKdenjd8hfQR9UN0eBnK1szfjW50fH2jDzIXZ5Y1rjSK5dM6HlXxDQJOAro7wDxXWH2CFXMfWdLcjwRPwh2h/bSTnl0wDHyusB/W9yEvT2i+iXIkYmITU4J+EU/3LjWO17aUl+nhB68jhTS8czsF6n83Fusc9t/f1HKOz9mKI0DpreMm9hIfT+YtlrIZCIdTfXhIu2TLdDuteSvOQPE2UQAwiNsrKNjuvYbpgDZYx9ukAJjn6n0+HoNLMYslMlxuzDdwRYkIWMnyJcRS5/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7lFNhmHX3fqEvjWm97qRebSkbbZ/7FXZ6UOAGJyIHho=;
 b=MwEY012mVNt+I3ZPleJvLq2SIYQv66SEMfpKM3pfvCIUPnuez5d8BnTQ4ztMJuIjOL1AHeibuT2fymXI0kUYzPuJhJU10RclpjkYeW4V9jiqDaWfQohWEfM8dGjg4tjmPgkz9/0zxQTZcND7tJX0FjWoRLn5Oz9k9ATG17AyWTw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:10d::7)
 by TYXP286MB6112.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:275::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.10; Thu, 6 Nov
 2025 03:59:23 +0000
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a]) by OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a%5]) with mapi id 15.20.9275.018; Thu, 6 Nov 2025
 03:59:23 +0000
Date: Thu, 6 Nov 2025 12:59:21 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Baruch Siach <baruch@tkos.co.il>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, ntb@lists.linux.dev
Subject: Re: [PATCH] NTB: ntb_transport: fix use after free
Message-ID: <6esry3tk3b5aslp2acp2qvnxcorzznza6ehdqmcyyqaoc4mm43@kgyhhva2mpkg>
References: <c4727cd0bdeb8385b893da59c5eb97a189bf4282.1762190599.git.baruch@tkos.co.il>
 <y23vpg5ynutkwck3w6wynsy47yovpqywil2jqk4omg63qdocjb@xkcvg6h3jy2d>
 <87v7jqs68y.fsf@tarshish>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v7jqs68y.fsf@tarshish>
X-ClientProxiedBy: TYCP286CA0137.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::15) To OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:10d::7)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB0979:EE_|TYXP286MB6112:EE_
X-MS-Office365-Filtering-Correlation-Id: 68b60264-a611-40c4-8ce5-08de1ce8de78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wGt0mt6Kw+M89Q+AJHvkdr4fkfZyxDGNX29SyUSadsLaSigxNRYV5LL6us9e?=
 =?us-ascii?Q?3xSEG7KhnaeHRWqn9PrBtaa9xGg7/kGNrvm62RdTvLt0z0jXvjQ/cDZhlHPt?=
 =?us-ascii?Q?MpmQZh5uY9f9LafU/PmjM3qfmO+5rNTnVWMp8w+4La+baTooyYss8NKVrYnP?=
 =?us-ascii?Q?HslzawdLGhDtIB1xsjJpboy89RyGkaut3Zq1Niy4Ns0d3En8cJym685RtqIp?=
 =?us-ascii?Q?/4lmVtirOL94kOQj5OhEqqHdbEVKQ1hdCfsH9doukjcNtWeFQwMM3I+RFC9e?=
 =?us-ascii?Q?oV2pmt/8RO9w4XnGrI7Ee/I8qQa3o+yXgX7QFEKe8OQmTeiIcZKXwgnUyeqL?=
 =?us-ascii?Q?F10ZLxgY8ym4xlLiOkBND3VMLpuLMyX1l36vl5v1wpVXb7/b4q36uXKoSjEP?=
 =?us-ascii?Q?TUpl6+Jxlt1hbXNYcA7FEOeHtaYpcVS4cvkaJaLznZiGhjnn3MkuIJPnhHvH?=
 =?us-ascii?Q?4TxAuwzyRZFaGu6DG6jke3WCOFO/HweGtAafF1lQ27mco0tv4LOh7CVYQe/T?=
 =?us-ascii?Q?UUwYR+6WTfw4NuulHJ2ynSPCix+hklzYqMKr3kczq0r9Ib6V+x1aWrhG8dMe?=
 =?us-ascii?Q?tUD7wI9HSwX0xD56R/h7g/kCevoScJxS2+Qnji65+mC2ly9NyNOdDbJHKMZl?=
 =?us-ascii?Q?NkbMx0UuB17s3VTQeUtAxc7X9aWl8rEvOSUshSt4AsPPDAwzavewzCIA3miT?=
 =?us-ascii?Q?+b5UCuZE0C4AgS+RPs4kwKOKLbPD+qrjqFjPvQOXSN69thfuNvKVhbDTzJXh?=
 =?us-ascii?Q?IRDyDFtPpLIy844p3yrc/hSwC5N24eR9fC3gY7g5q652bVmSjTtqKIIVHJQv?=
 =?us-ascii?Q?xt04bcEPTG2AtQ3utPSzu2AlGS2u1FdZcsKT3+yNf4aTN2yjod6t3mPQfRpv?=
 =?us-ascii?Q?NE/kgjtaWMoEA2AnRK9/zNUER8C/fSvlTsm7taPajNbaQxOviWlh4K3X57/W?=
 =?us-ascii?Q?ZuFhsklJFJTt6H4ejLTIk/3EVicySmDm/TeZ+600fu2iyXKvoKdiQt8gU/+F?=
 =?us-ascii?Q?WhzhrsgNBwWJzgl2mdtgN7bnYSAUKOe96M3lkQ4KRLVaPijmWfMNTWGC/Qtr?=
 =?us-ascii?Q?QO2DT1O+wxli52o3arcWbubODnNnrD+tMgzvNV3qJujx2to2fEXU7C/vTcp8?=
 =?us-ascii?Q?7gD/Pq6j2eRMQa38fRSP2DuWzi1bIrsKReS2YN8Gv/DMCA00qmgSClg8oBo8?=
 =?us-ascii?Q?sAbeLq2F3LdUpnsqfHewBYYBMeZEjrShiDFI1SU4CMo46GgzwElfo7+OJOe1?=
 =?us-ascii?Q?raW7S9m/+Jp9oXSgsJ5BxT3k+VdtwJQATMVmtrLB/aT0ZKUw2yY7ZSWDAKHv?=
 =?us-ascii?Q?NKRTp45Q61VPywdejWyYPlO3klOv5EUptVdiUMm0IxgT763OyjEIkFx5mf8L?=
 =?us-ascii?Q?GXXUVccnhj2e/M34gEW4MZMtZcEOw/GOtA1g07xHUy0/ZVMaPg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xOf5R7rMQ/1Kl+JnHihcRjLANUIaxZdJkVtJbt3re6+cXCte49VTaI9xtjJb?=
 =?us-ascii?Q?od+L3meMZ2a5hzXb8wyPpMfsDfbgFn5O4NgD1T806mqBl/p2Hg+FSLpDxH05?=
 =?us-ascii?Q?yc6SJq27oKaeL0OyDtajROKlVL4GZM3I90Sf/bZ0QQPqvzyU/S+83InTlBfZ?=
 =?us-ascii?Q?cfM4ZeEhgTSmGzUoVGFZp26hSQtQBK3zLMjLFQspk6BwuWnNv6x/3XDulZyX?=
 =?us-ascii?Q?uDcqqhH74ZK8CIbeJcnvexs2uHfbr+GIScFDzXLD3MwFUkrECbU6PnSSn2F3?=
 =?us-ascii?Q?87MhIQ9UzWonjcDoDDPBjnJFIaE9gRpKykTkS+zHGffLoTvMolFu8R2KqYg8?=
 =?us-ascii?Q?wbnV4s8+kprXZOTdVHQ1dzgXTOBRyJqzVn5Owjzu3+IGlfKwK5b/LLvsr2nS?=
 =?us-ascii?Q?Wr+nEJb2OeE8oFjs+5oqgSknqUDq+VnPvzonblewhgJ2PiTDn8eKvVMExmVt?=
 =?us-ascii?Q?2D9HHPb2UQEUA0eAFQ1cmx2t/8LbviEazxi7+Y3sUwZvlbriYwhaF0eEVOmc?=
 =?us-ascii?Q?DW4ks1GQl/QWwQZHZoBmTj2VHjC/S/P2062jGfUC5lAtG5Qb76cLTeK1asGM?=
 =?us-ascii?Q?6pHs4m8DWMxbanIHaI5uWWSQBJOX0G7plMstGVDvG6P7nMBg6GS8XdfkdNTz?=
 =?us-ascii?Q?skqzBYdvN798hAguk7CAxRO4u8xbAWnJRLmGeo8/7en6ujASgDqrmY1+D1QN?=
 =?us-ascii?Q?aFjMUeoxu90P9WmP4CfFZOfWwZ3JZ2UkkX83zjGAZIdxxSN5H+S7Ri2Y/99I?=
 =?us-ascii?Q?aFuKMWQGRz340KySS/L29bvzq/z22cjOCCaBHjpgB0e9dPtTlCRGFSVztNue?=
 =?us-ascii?Q?bXNx5CS1H0J6XfttRnirXxNQA3JEZW+UWutFNxtlHiLnzkr46PnsHmxFuY8t?=
 =?us-ascii?Q?ihXM/+TFyOJOYZsKFEiY/nG9F1O/24RrQygaY+3J5BLRcMw2tcVDHq/KVwKH?=
 =?us-ascii?Q?pt1Nre/UuCJzZO72kOx+xnotKbiQqIRgxJfxPHF6+8HHPn6FHcexhNoggIYE?=
 =?us-ascii?Q?3azdbS7YOMErPWv09+bV5y165B4i26hWDHUDIG6xVqLvn4AAMmJrK25BEmLN?=
 =?us-ascii?Q?+o3Rej1Zgg86VtwJivPVjZHBupqmD5SImfbjvHYDcPbq6KouNwicENKMFJyH?=
 =?us-ascii?Q?LTb6T8VdTQ57nTGMW89OiW4Wj9eCAqnu0IVsWCAwb38eWUL2HOnb0TY1Qz1u?=
 =?us-ascii?Q?nUYaXVXFzpwy4lncyrZ4Wk4Vn8wqULv4cKzzoWGiUmwb99GTlX7yGyoNW5ZY?=
 =?us-ascii?Q?V2GvoAgybNyzwRrb8RTd2Va0F2WleQCp/CioO8V1yuKjuLsuhCGkbuh0mzli?=
 =?us-ascii?Q?Ga7aZdSAC/oIoHb5cEOnRJI2bnW21DyG+qBhQwpDZOUzO3wvzcDVu3umUNXd?=
 =?us-ascii?Q?5yPpfiDbLRMo74OqYQOurcE9J7NkCWyOKFbZ3WalqshQBLgz7vKCb6+WfHIU?=
 =?us-ascii?Q?ai6/xqsfpxdKvmbxfWyn8YVXaNu2C9vjQh4lZFbCYgYSOCrJL/CF9k7p14lv?=
 =?us-ascii?Q?jb3cKhv/ggdhi3FdvERJQroAJJde7QljdX9dB25t24jVj3P3LeSOOD8GuQv+?=
 =?us-ascii?Q?9boLd6TSQvDxYBi+5Y2sH10Bf3UecC6Ezyr9FB4VOKdGux5f3C7WnQrljYQS?=
 =?us-ascii?Q?ohUk7A6RFTSQkw4MG9qpyok=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 68b60264-a611-40c4-8ce5-08de1ce8de78
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 03:59:23.1025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SQ92/DfZjnhyLQskxAJoHKiFthhl4Pt9tyEnfTgSAi1EUGePgHPJmNC/K8fEbYfhOemeLaNcJNISliGZ8ilcVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYXP286MB6112

On Tue, Nov 04, 2025 at 07:42:53AM +0200, Baruch Siach wrote:
> Hi Koichiro,
> 
> Thanks for taking the time to review this.
> 
> On Tue, Nov 04 2025, Koichiro Den wrote:
> > On Mon, Nov 03, 2025 at 07:23:19PM +0200, Baruch Siach wrote:
> >> Don't call dmaengine_unmap_put() twice for the same pointer. This
> >> results in mempool_free() being called on a freed element.
> >
> > While the second dmaengine_unmap_put() looks redundant at first glance, my
> > understanding was that it compensates for the refcount decrement that would
> > normally happen on the dmaengine completion path, which never occurs when
> > dmaengine_submit() fails. Am I missing something?
> 
> I guess you are right. Now I see that dma_set_unmap() increments the
> refcount. But I can't find the second refcount decrement in completion
> path. I only see one call to dmaengine_unmap_put(). Can you enlighten
> me?

Apologies for the late response. The dma_descriptor_unmap() wrapper should
handle that, shouldn't it?

Thanks,
-Koichiro

> 
> Thanks,
> baruch
> 
> >> Fixes: 6f57fd0578df ("NTB: convert to dmaengine_unmap_data")
> >> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> >> ---
> >>  drivers/ntb/ntb_transport.c | 22 +++++++++-------------
> >>  1 file changed, 9 insertions(+), 13 deletions(-)
> >> 
> >> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> >> index eb875e3db2e3..809fb09658b4 100644
> >> --- a/drivers/ntb/ntb_transport.c
> >> +++ b/drivers/ntb/ntb_transport.c
> >> @@ -1573,14 +1573,14 @@ static int ntb_async_rx_submit(struct ntb_queue_entry *entry, void *offset)
> >>  	unmap->addr[0] = dma_map_page(device->dev, virt_to_page(offset),
> >>  				      pay_off, len, DMA_TO_DEVICE);
> >>  	if (dma_mapping_error(device->dev, unmap->addr[0]))
> >> -		goto err_get_unmap;
> >> +		goto err_unmap;
> >>  
> >>  	unmap->to_cnt = 1;
> >>  
> >>  	unmap->addr[1] = dma_map_page(device->dev, virt_to_page(buf),
> >>  				      buff_off, len, DMA_FROM_DEVICE);
> >>  	if (dma_mapping_error(device->dev, unmap->addr[1]))
> >> -		goto err_get_unmap;
> >> +		goto err_unmap;
> >>  
> >>  	unmap->from_cnt = 1;
> >>  
> >> @@ -1588,7 +1588,7 @@ static int ntb_async_rx_submit(struct ntb_queue_entry *entry, void *offset)
> >>  					     unmap->addr[0], len,
> >>  					     DMA_PREP_INTERRUPT);
> >>  	if (!txd)
> >> -		goto err_get_unmap;
> >> +		goto err_unmap;
> >>  
> >>  	txd->callback_result = ntb_rx_copy_callback;
> >>  	txd->callback_param = entry;
> >> @@ -1596,7 +1596,7 @@ static int ntb_async_rx_submit(struct ntb_queue_entry *entry, void *offset)
> >>  
> >>  	cookie = dmaengine_submit(txd);
> >>  	if (dma_submit_error(cookie))
> >> -		goto err_set_unmap;
> >> +		goto err_unmap;
> >>  
> >>  	dmaengine_unmap_put(unmap);
> >>  
> >> @@ -1606,9 +1606,7 @@ static int ntb_async_rx_submit(struct ntb_queue_entry *entry, void *offset)
> >>  
> >>  	return 0;
> >>  
> >> -err_set_unmap:
> >> -	dmaengine_unmap_put(unmap);
> >> -err_get_unmap:
> >> +err_unmap:
> >>  	dmaengine_unmap_put(unmap);
> >>  err:
> >>  	return -ENXIO;
> >> @@ -1854,14 +1852,14 @@ static int ntb_async_tx_submit(struct ntb_transport_qp *qp,
> >>  	unmap->addr[0] = dma_map_page(device->dev, virt_to_page(buf),
> >>  				      buff_off, len, DMA_TO_DEVICE);
> >>  	if (dma_mapping_error(device->dev, unmap->addr[0]))
> >> -		goto err_get_unmap;
> >> +		goto err_unmap;
> >>  
> >>  	unmap->to_cnt = 1;
> >>  
> >>  	txd = device->device_prep_dma_memcpy(chan, dest, unmap->addr[0], len,
> >>  					     DMA_PREP_INTERRUPT);
> >>  	if (!txd)
> >> -		goto err_get_unmap;
> >> +		goto err_unmap;
> >>  
> >>  	txd->callback_result = ntb_tx_copy_callback;
> >>  	txd->callback_param = entry;
> >> @@ -1869,16 +1867,14 @@ static int ntb_async_tx_submit(struct ntb_transport_qp *qp,
> >>  
> >>  	cookie = dmaengine_submit(txd);
> >>  	if (dma_submit_error(cookie))
> >> -		goto err_set_unmap;
> >> +		goto err_unmap;
> >>  
> >>  	dmaengine_unmap_put(unmap);
> >>  
> >>  	dma_async_issue_pending(chan);
> >>  
> >>  	return 0;
> >> -err_set_unmap:
> >> -	dmaengine_unmap_put(unmap);
> >> -err_get_unmap:
> >> +err_unmap:
> >>  	dmaengine_unmap_put(unmap);
> >>  err:
> >>  	return -ENXIO;
> >> -- 
> >> 2.51.0
> >> 
> 
> -- 
>                                                      ~. .~   Tk Open Systems
> =}------------------------------------------------ooO--U--Ooo------------{=
>    - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
