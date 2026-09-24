Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224B31EFFA1
	for <ntb@lists.linux.dev>; Thu, 24 Sep 2026 15:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790264245; cv=none; b=AoutOMwQMUaZVDKJedNhBnx/qGQ3UTOX06gihC888VDzX7QfMpQQPf5lab+dH6ZnGqbNjKX6RrPo8e8zkd/rbX9ofsXwp16Fh3zoiT7RkUYVXLZTsw7a3OAijfdi4uWNOZQ7AN6TX4n6+uknsmjykMS3iVNaQtl2L2WSWJA+gC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790264245; c=relaxed/simple;
	bh=9vTo/wdRH46ycDkV7NiiUNfGnXYGFZM5LVlPxq+BT6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W5a65+7M+4Hn6KYpPHHf8wg8ET7uyPewUbgpRJV2plsHH3S4Hp4v9642/R1AEzMIOZ1Lx6krh95mCuyFP+qHQVp3NLr4EIJNBcZXS74rGjcZSPX8HuzNXBYc1eiE8h8tc87SFA6t9DgOOo1xdAK8pjUVGgwdua1xtJbm7G6LwjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MZT52m5L; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MZT52m5L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790264244; x=1821800244;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9vTo/wdRH46ycDkV7NiiUNfGnXYGFZM5LVlPxq+BT6g=;
  b=MZT52m5LJkfsOPGZMhshq8aW32NhJnx2IjbVwJYnfoxFfY4m1A2iwcFB
   gOapQzJBiCG1YZOmn3UAmwAd1elOWdetWcPTEMWRQ2y+gswMrw6fOL518
   44ZoAxZYuo1eQFuiKzAGXAAU9ywi5lDy1z1FrXyjAkL6+sKSjVDX2zTci
   xHD8d9d2NeRkuhyTzQXt8c+fHQfQ7RRTNoADV21QaA8hwypxCex3cODaR
   wrAtWERUTfkKXT5FIrKJ6umGR6aPC69HVTU8mDxh+c3xduumQacbd1DEU
   AmRxr0q7ViQsW7qbybtkrkpejwIoOO0HOFHOi1jPardTAB++HrsSd+cF5
   g==;
X-CSE-ConnectionGUID: qX7U01nuTMSFTKrF5HU69w==
X-CSE-MsgGUID: cQFpW/gZSEepqZVPqy0TDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="89901886"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="89901886"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 08:37:23 -0700
X-CSE-ConnectionGUID: AwfNXJ4eTeSVLvwNFL4tjg==
X-CSE-MsgGUID: vWn8the1RmyJVxhAXQQt8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="272193068"
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.110.186]) ([10.125.110.186])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 08:37:23 -0700
Message-ID: <31db5eff-dd07-45e7-ba21-1059fa846569@intel.com>
Date: Thu, 24 Sep 2026 08:37:21 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/14] NTB: ntb_transport: Remove the device debugfs
 directory
To: Koichiro Den <den@valinux.co.jp>, Jon Mason <jdmason@kudzu.us>,
 Allen Hubbe <allenbh@gmail.com>
Cc: Frank Li <Frank.Li@kernel.org>, Logan Gunthorpe <logang@deltatee.com>,
 fuyuanli <fuyuanli0722@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nicholas Bellinger <nab@linux-iscsi.org>,
 Joey Zhang <joey.zhang@microchip.com>, ntb@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260910040836.3792333-1-den@valinux.co.jp>
 <20260910040836.3792333-2-den@valinux.co.jp>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260910040836.3792333-2-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/9/26 9:08 PM, Koichiro Den wrote:
> ntb_transport_free() removes QP debugfs directories but leaves the
> device directory. On rebind, debugfs_create_dir() fails with -EEXIST
> and QP statistics files are not recreated. Module unload masks this
> by removing the entire debugfs tree.
> 
> To reproduce:
> 
>   # ls /sys/kernel/debug/ntb_transport/0001:10:00.0/
>   qp0
>   # echo 0001:10:00.0 > /sys/bus/ntb/drivers/ntb_transport/unbind
>   # ls /sys/kernel/debug/ntb_transport/
>   0001:10:00.0   <-- should not remain
>   # echo 0001:10:00.0 > /sys/bus/ntb/drivers/ntb_transport/bind
> 
>   .. and then dmesg shows:
>   debugfs: '0001:10:00.0' already exists in 'ntb_transport'
> 
>   # ls /sys/kernel/debug/ntb_transport/0001:10:00.0/
>   (nothing)      <-- should be 'qp0'
> 
> Remove the device debugfs tree on teardown and probe failure.
> 
> Verified that unbind removes the directory and rebind recreates qp0.
> 
> Fixes: c8650fd03d32 ("NTB: Fix transport stats for multiple devices")
> Cc: stable@vger.kernel.org
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
> Changes in v2:
>   - No changes.
> 
>  drivers/ntb/ntb_transport.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index f9caa1a653c5..3389d6ca9ebd 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -1382,6 +1382,7 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
>  err3:
>  	ntb_clear_ctx(ndev);
>  err2:
> +	debugfs_remove_recursive(nt->debugfs_node_dir);
>  	kfree(nt->qp_vec);
>  err1:
>  	while (i--) {
> @@ -1401,6 +1402,8 @@ static void ntb_transport_free(struct ntb_client *self, struct ntb_dev *ndev)
>  	u64 qp_bitmap_alloc;
>  	int i;
>  
> +	debugfs_remove_recursive(nt->debugfs_node_dir);
> +
>  	ntb_transport_link_cleanup(nt);
>  	cancel_work_sync(&nt->link_cleanup);
>  	cancel_delayed_work_sync(&nt->link_work);
> @@ -1412,7 +1415,6 @@ static void ntb_transport_free(struct ntb_client *self, struct ntb_dev *ndev)
>  		qp = &nt->qp_vec[i];
>  		if (qp_bitmap_alloc & BIT_ULL(i))
>  			ntb_transport_free_queue(qp);
> -		debugfs_remove_recursive(qp->debugfs_dir);
>  	}
>  
>  	ntb_link_disable(ndev);

