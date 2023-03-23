Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23342A95C
	for <ntb@lists.linux.dev>; Thu, 23 Mar 2023 16:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679590301; x=1711126301;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=d9ywmKZwPZMfidXQiYHgda70SVYEXn3j56eoKfCXPYM=;
  b=KdCw5EwF2TCTwC69HhZO1zKTMoPgStzjytsoSdrxNumIExAxNmMvW1qi
   NESQSffNakG8VS+JwUPycIaNO80hVZs0YUzHc4edWtaXmDmGZ1Uo4uaPU
   NrQAPKzk7Yj/x9wNFsfe90HpdY8HXcjy0Av3uud67kL4E2LHtWYee0hvW
   DRjA6RFPq67aZgIv8fXQmQPMkssbrdG6vIph9wfiBTa5/oZ2wr01UyJ7n
   Fh0aFJrnMRcXFV6lTEIH4OaJ/0OdQs1CaoLFlUscKo4PQIsuhKe9xMz0R
   cVa18k5Inm5mJwFtRtdAZyuH1QaXIfk3Ny83zMSJZ+tUoezopOkcawMri
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="337061042"
X-IronPort-AV: E=Sophos;i="5.98,285,1673942400"; 
   d="scan'208";a="337061042"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 09:51:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="632495129"
X-IronPort-AV: E=Sophos;i="5.98,285,1673942400"; 
   d="scan'208";a="632495129"
Received: from sramak5-mobl.amr.corp.intel.com (HELO [10.212.70.194]) ([10.212.70.194])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 09:51:39 -0700
Message-ID: <20d2cb3a-3f6d-23ca-1044-3105704cc144@intel.com>
Date: Thu, 23 Mar 2023 09:51:38 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH 3/3] ntb: intel: Remove redundant pci_clear_master
Content-Language: en-US
To: Cai Huoqing <cai.huoqing@linux.dev>
Cc: Sanjay R Mehta <sanju.mehta@amd.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Jon Mason <jdmason@kudzu.us>,
 Allen Hubbe <allenbh@gmail.com>, Frank Li <Frank.Li@nxp.com>,
 ntb@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230323115336.12986-1-cai.huoqing@linux.dev>
 <20230323115336.12986-3-cai.huoqing@linux.dev>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230323115336.12986-3-cai.huoqing@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/23/23 4:53 AM, Cai Huoqing wrote:
> Remove pci_clear_master to simplify the code,
> the bus-mastering is also cleared in do_pci_disable_device,
> like this:
> ./drivers/pci/pci.c:2197
> static void do_pci_disable_device(struct pci_dev *dev)
> {
> 	u16 pci_command;
> 
> 	pci_read_config_word(dev, PCI_COMMAND, &pci_command);
> 	if (pci_command & PCI_COMMAND_MASTER) {
> 		pci_command &= ~PCI_COMMAND_MASTER;
> 		pci_write_config_word(dev, PCI_COMMAND, pci_command);
> 	}
> 
> 	pcibios_disable_device(dev);
> }.
> And dev->is_busmaster is set to 0 in pci_disable_device.
> 
> Signed-off-by: Cai Huoqing <cai.huoqing@linux.dev>

Acked-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/ntb/hw/intel/ntb_hw_gen1.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/ntb/hw/intel/ntb_hw_gen1.c b/drivers/ntb/hw/intel/ntb_hw_gen1.c
> index 60a4ebc7bf35..9ab836d0d4f1 100644
> --- a/drivers/ntb/hw/intel/ntb_hw_gen1.c
> +++ b/drivers/ntb/hw/intel/ntb_hw_gen1.c
> @@ -1791,7 +1791,6 @@ static int intel_ntb_init_pci(struct intel_ntb_dev *ndev, struct pci_dev *pdev)
>   
>   err_mmio:
>   err_dma_mask:
> -	pci_clear_master(pdev);
>   	pci_release_regions(pdev);
>   err_pci_regions:
>   	pci_disable_device(pdev);
> @@ -1808,7 +1807,6 @@ static void intel_ntb_deinit_pci(struct intel_ntb_dev *ndev)
>   		pci_iounmap(pdev, ndev->peer_mmio);
>   	pci_iounmap(pdev, ndev->self_mmio);
>   
> -	pci_clear_master(pdev);
>   	pci_release_regions(pdev);
>   	pci_disable_device(pdev);
>   	pci_set_drvdata(pdev, NULL);
