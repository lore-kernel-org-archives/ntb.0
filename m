Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91643CC9EA
	for <ntb@lists.linux.dev>; Thu, 19 Mar 2026 14:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773930630; cv=none; b=cug3a44Ou/rTg5kpnsqUfSnD8TVYz9MjXtNeWLKdm0tkEkGp/YCC2Pw/bkTq57df+ioFSXikHuhT8r94+xBJBh+o2b3MUpxBsBS8dlj4a/Lv1/Dn6rT4yOUn4RPyYoqWaTL27e7C/Rl5xL9pDQR3Su+MahcY+lvSNS0uGQccWMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773930630; c=relaxed/simple;
	bh=0U1cBpvOCNPePVaP2IPHp384oNJRHwgGTQ8W0VSQz5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nE66kUzRmfb7ZcXMfp4N1hrfGjDb6MjF7dUerLXoTt7vNPQDZR1ATAi8WVo3TFgRwZRWPkeWhcHsY2mknJxoDK8chDdZlv0qp2kWkWRhVcGCjo9G6FiWPvbCmwoeaCRRxyHQx33yxF4nweMPQuGw+F7Mt4r1C/iy62MvlR5aN4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oBpBhh+m; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oBpBhh+m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773930629; x=1805466629;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0U1cBpvOCNPePVaP2IPHp384oNJRHwgGTQ8W0VSQz5s=;
  b=oBpBhh+mMHpBMEAKIxhpK/u67kHN1e9oqD1gLwkbcYXIKl59/DLLiaAg
   qw1ym+3ROkVXyOx6sx4XqzYjCRBRx0tlRPPhMh6zjQRLu0MVQg2RMilZ5
   wDnDXCZacEJhxqAoMgcoqxshLfQxpCzPP3UngXiGgjsi2dt1scAS6V7lr
   dqkby/JM/qoh52FUDGPvTzBUSpiNWpA8j3IocLyj0n4Z0qgMcvmB93Ke5
   jReX+A99KE0UwY5JztWMumddiz8WGJGJypewiJo2eRO7xjOT19rXuOxoP
   oWp66cn2QlyQ7VtW+3BFCUPnD78qNmhA6CkMIeyJFI5K6kQhZ71/7g199
   Q==;
X-CSE-ConnectionGUID: 6vqTDcV7RQ+ccv+2dFhCLQ==
X-CSE-MsgGUID: n+wkSZ3zRNSA9SNlr0BzPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="85705685"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="85705685"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 07:30:28 -0700
X-CSE-ConnectionGUID: Kg3pZmTFS2KSO+OF/lA30Q==
X-CSE-MsgGUID: gMiuDgaQSMiceGvLZY8JvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="253443365"
Received: from jmaxwel1-mobl.amr.corp.intel.com (HELO [10.125.109.49]) ([10.125.109.49])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 07:30:28 -0700
Message-ID: <5730bc52-63c3-43b0-aa53-5440addc5ce6@intel.com>
Date: Thu, 19 Mar 2026 07:30:26 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] NTB: epf: Avoid pci_iounmap() with offset when PEER_SPAD
 and CONFIG share BAR
To: Koichiro Den <den@valinux.co.jp>, Jon Mason <jdmason@kudzu.us>,
 Allen Hubbe <allenbh@gmail.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Frank Li <Frank.Li@nxp.com>
Cc: ntb@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260304020527.1067049-1-den@valinux.co.jp>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260304020527.1067049-1-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/3/26 7:05 PM, Koichiro Den wrote:
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

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

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

