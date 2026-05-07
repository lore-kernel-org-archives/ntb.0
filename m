Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3C62E5B1B
	for <ntb@lists.linux.dev>; Thu,  7 May 2026 16:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778170320; cv=none; b=nhX7k3SfDBhzNDZqaNBSxf0cr9ucMuX2qI5sAk1y3HLlYgaJQfNaGQ5DWnxDMUq/zTI6+9q8QLcrO9w5M2uIOvfMdVT72lRPUQyrgjCs1ZFlaS6x/2zEhV2x5mCwdrAGjVUl5a1URM5uH11dkDgu277+0HBcSBP8SawT+U0iA+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778170320; c=relaxed/simple;
	bh=NTsgWKUdinM9gp/+oKkg44S7SaUr/+f4Jz3ckbQXY9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=efB3g2Nq3I0SRnKzWh68/l8dC2YjOag1E+sOV5616jaSU3PwR15tEZe8o/eGf9bSmNtWqjyjUmGsnnvQgToEEP+hgCaNE9FEKQR5x9ejwGIai3JCS1NXOuJmfzCAdeHgflahFnMXuQpGqZcx3dYfVcAwzKF7uJBnogLjtupEs+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GDIcPHAM; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GDIcPHAM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778170319; x=1809706319;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NTsgWKUdinM9gp/+oKkg44S7SaUr/+f4Jz3ckbQXY9c=;
  b=GDIcPHAMb64DxuFH9ZwhIKzUhhpwYV+1SRbxsVo+zOR3rg0lh8gVB8Ib
   jwei6WSD28a/lv/MUfcMxTeOxVN/gtZQHVFQRS0Hs8uElhvNv9Ozgwg2A
   H/Iu/z72JDyBxsRjG32TLGXTn45k/2dOTfbsBVb286SnTRjrhk+Vd0qO6
   6ZB35Kk3KtHF8Gvv7LTcR69obi2fR2gWQS/MRubaUgXx4VnVWrcIXzw1Z
   eyjkePgHJU4whiLCH35qaDT6MIKCeks23oLYtb2VC30MWUksHjGeXbwX7
   vX7PJAUB0L4op8QjMidI64cmOBFjkm1fY79inb+IgwCzZ5IXzxLVyitLj
   w==;
X-CSE-ConnectionGUID: LpAoZrSGTNCR92WLu5koSg==
X-CSE-MsgGUID: 1sDvLLWMT9aK5MBUZThAMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="89822358"
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="89822358"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 09:11:48 -0700
X-CSE-ConnectionGUID: azvfb1CcRu+d0KD7gbcg7g==
X-CSE-MsgGUID: +vgQ3UvAQU2QdwfB3Ocj+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="236765471"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.110.240]) ([10.125.110.240])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 09:11:39 -0700
Message-ID: <72f4abb9-d6d4-427b-85ac-e99bf77e083c@intel.com>
Date: Thu, 7 May 2026 09:11:37 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ntb: amd: Use named initializer for
 pci_device_id::driver_data
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>, Basavaraj Natikar
 <Basavaraj.Natikar@amd.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>, ntb@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260507074102.2654314-2-u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260507074102.2654314-2-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/7/26 12:41 AM, Uwe Kleine-König (The Capable Hub) wrote:
> The current list initialisation depends on the well hidden two zeros in
> the PCI_VDEVICE macro. Instead use a named initialisation that is more
> robust and easier to understand.
> 
> Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
> Hello,
> 
> while being a cleanup that can stand on its own this is also a
> preparation for making .driver_data an anonymous union which allows to
> do:
> 
> 	diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
> 	index 55408b431365..ee77d1235ec4 100644
> 	--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
> 	+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
> 	@@ -1233,7 +1233,7 @@ static int amd_ntb_pci_probe(struct pci_dev *pdev,
> 			goto err_ndev;
> 		}
> 
> 	-	ndev->dev_data = (struct ntb_dev_data *)id->driver_data;
> 	+	ndev->dev_data = id->driver_data_ptr;
> 
> 		ndev_init_struct(ndev, pdev);
> 
> 	@@ -1328,14 +1328,14 @@ static const struct ntb_dev_data dev_data[] = {
> 	 };
> 
> 	 static const struct pci_device_id amd_ntb_pci_tbl[] = {
> 	-	{ PCI_VDEVICE(AMD, 0x145b), .driver_data = (kernel_ulong_t)&dev_data[0] },
> 	-	{ PCI_VDEVICE(AMD, 0x148b), .driver_data = (kernel_ulong_t)&dev_data[1] },
> 	-	{ PCI_VDEVICE(AMD, 0x14c0), .driver_data = (kernel_ulong_t)&dev_data[1] },
> 	-	{ PCI_VDEVICE(AMD, 0x14c3), .driver_data = (kernel_ulong_t)&dev_data[1] },
> 	-	{ PCI_VDEVICE(AMD, 0x155a), .driver_data = (kernel_ulong_t)&dev_data[1] },
> 	-	{ PCI_VDEVICE(AMD, 0x17d4), .driver_data = (kernel_ulong_t)&dev_data[1] },
> 	-	{ PCI_VDEVICE(AMD, 0x17d7), .driver_data = (kernel_ulong_t)&dev_data[2] },
> 	-	{ PCI_VDEVICE(HYGON, 0x145b), .driver_data = (kernel_ulong_t)&dev_data[0] },
> 	+	{ PCI_VDEVICE(AMD, 0x145b), .driver_data_ptr = &dev_data[0] },
> 	+	{ PCI_VDEVICE(AMD, 0x148b), .driver_data_ptr = &dev_data[1] },
> 	+	{ PCI_VDEVICE(AMD, 0x14c0), .driver_data_ptr = &dev_data[1] },
> 	+	{ PCI_VDEVICE(AMD, 0x14c3), .driver_data_ptr = &dev_data[1] },
> 	+	{ PCI_VDEVICE(AMD, 0x155a), .driver_data_ptr = &dev_data[1] },
> 	+	{ PCI_VDEVICE(AMD, 0x17d4), .driver_data_ptr = &dev_data[1] },
> 	+	{ PCI_VDEVICE(AMD, 0x17d7), .driver_data_ptr = &dev_data[2] },
> 	+	{ PCI_VDEVICE(HYGON, 0x145b), .driver_data_ptr = &dev_data[0] },
> 		{ }
> 	 };
> 	 MODULE_DEVICE_TABLE(pci, amd_ntb_pci_tbl);
> 
> which is also a nice cleanup *and* further hints at also doing
> 
> 	diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.h b/drivers/ntb/hw/amd/ntb_hw_amd.h
> 	index e8c3165fa38b..4ef7bafd21f7 100644
> 	--- a/drivers/ntb/hw/amd/ntb_hw_amd.h
> 	+++ b/drivers/ntb/hw/amd/ntb_hw_amd.h
> 	@@ -186,7 +186,7 @@ struct amd_ntb_dev {
> 		u32 cntl_sta;
> 		u32 peer_sta;
> 
> 	-	struct ntb_dev_data *dev_data;
> 	+	const struct ntb_dev_data *dev_data;
> 		unsigned char mw_count;
> 		unsigned char spad_count;
> 		unsigned char db_count;
> 
> due to a compiler warning. So all in all this yields easier to read
> initialisation (not shorter and more compact but easier to grasp),
> better type safety and harder to make mistakes due to the added const.
> 
> Best regards
> Uwe
> ---
>  drivers/ntb/hw/amd/ntb_hw_amd.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
> index 1a163596ddf5..55408b431365 100644
> --- a/drivers/ntb/hw/amd/ntb_hw_amd.c
> +++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
> @@ -1328,15 +1328,15 @@ static const struct ntb_dev_data dev_data[] = {
>  };
>  
>  static const struct pci_device_id amd_ntb_pci_tbl[] = {
> -	{ PCI_VDEVICE(AMD, 0x145b), (kernel_ulong_t)&dev_data[0] },
> -	{ PCI_VDEVICE(AMD, 0x148b), (kernel_ulong_t)&dev_data[1] },
> -	{ PCI_VDEVICE(AMD, 0x14c0), (kernel_ulong_t)&dev_data[1] },
> -	{ PCI_VDEVICE(AMD, 0x14c3), (kernel_ulong_t)&dev_data[1] },
> -	{ PCI_VDEVICE(AMD, 0x155a), (kernel_ulong_t)&dev_data[1] },
> -	{ PCI_VDEVICE(AMD, 0x17d4), (kernel_ulong_t)&dev_data[1] },
> -	{ PCI_VDEVICE(AMD, 0x17d7), (kernel_ulong_t)&dev_data[2] },
> -	{ PCI_VDEVICE(HYGON, 0x145b), (kernel_ulong_t)&dev_data[0] },
> -	{ 0, }
> +	{ PCI_VDEVICE(AMD, 0x145b), .driver_data = (kernel_ulong_t)&dev_data[0] },
> +	{ PCI_VDEVICE(AMD, 0x148b), .driver_data = (kernel_ulong_t)&dev_data[1] },
> +	{ PCI_VDEVICE(AMD, 0x14c0), .driver_data = (kernel_ulong_t)&dev_data[1] },
> +	{ PCI_VDEVICE(AMD, 0x14c3), .driver_data = (kernel_ulong_t)&dev_data[1] },
> +	{ PCI_VDEVICE(AMD, 0x155a), .driver_data = (kernel_ulong_t)&dev_data[1] },
> +	{ PCI_VDEVICE(AMD, 0x17d4), .driver_data = (kernel_ulong_t)&dev_data[1] },
> +	{ PCI_VDEVICE(AMD, 0x17d7), .driver_data = (kernel_ulong_t)&dev_data[2] },
> +	{ PCI_VDEVICE(HYGON, 0x145b), .driver_data = (kernel_ulong_t)&dev_data[0] },
> +	{ }
>  };
>  MODULE_DEVICE_TABLE(pci, amd_ntb_pci_tbl);
>  
> 
> base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731

