Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1348F51
	for <ntb@lists.linux.dev>; Mon, 28 Nov 2022 15:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669650428; x=1701186428;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=ou3Loa0MWcDspSQwMCa/XZiFez5PSZ3tHARIcmHlK8Y=;
  b=Uobw7LYQ4Pr9dIhZl8Z4wj6eN8QtEr/CPy9WfTp07CkRNNndruxOw5sX
   jU38dCU8oxjmH7cbumMCwRD4d0atNxbtdvml2ETBMhS2Pu9K6lfFVa+S4
   dAzQeFjlUSOPvNisoh7vwdGcxZ4Dgi2kv510Fsp0FkCA2s7ZNTJfRCqfb
   LZcWVMJTgnKqm8SMHmAyEEN3AAhSBc/QLiZsHrzo728wUib3Zbk8xWVnD
   DWbfGOmuhgVvtjinDG++dyUqAP1MdoBt7l5xSqz+YduqGCdamP/SDW3Vo
   w2iqut4608m/Aac38fSNCjCJKLLax9p8mRkV9KT0sYIQ6AmT3vLOAMpAw
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="294566257"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="294566257"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 07:38:26 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="785673271"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="785673271"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.209.161.118]) ([10.209.161.118])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 07:38:24 -0800
Message-ID: <dd693036-961a-ea1d-3bad-378222430dc9@intel.com>
Date: Mon, 28 Nov 2022 08:38:23 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
Subject: Re: [PATCH] net: net_netdev: Fix error handling in
 ntb_netdev_init_module()
Content-Language: en-US
To: Yuan Can <yuancan@huawei.com>, jdmason@kudzu.us, allenbh@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, nab@linux-iscsi.org, gregkh@linuxfoundation.org,
 ntb@lists.linux.dev, netdev@vger.kernel.org
References: <20221124070917.38825-1-yuancan@huawei.com>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20221124070917.38825-1-yuancan@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/24/2022 12:09 AM, Yuan Can wrote:
> The ntb_netdev_init_module() returns the ntb_transport_register_client()
> directly without checking its return value, if
> ntb_transport_register_client() failed, the NTB client device is not
> unregistered.
> 
> Fix by unregister NTB client device when ntb_transport_register_client()
> failed.
> 
> Fixes: 548c237c0a99 ("net: Add support for NTB virtual ethernet device")
> Signed-off-by: Yuan Can <yuancan@huawei.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/net/ntb_netdev.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
> index 464d88ca8ab0..a4abea921046 100644
> --- a/drivers/net/ntb_netdev.c
> +++ b/drivers/net/ntb_netdev.c
> @@ -484,7 +484,14 @@ static int __init ntb_netdev_init_module(void)
>   	rc = ntb_transport_register_client_dev(KBUILD_MODNAME);
>   	if (rc)
>   		return rc;
> -	return ntb_transport_register_client(&ntb_netdev_client);
> +
> +	rc = ntb_transport_register_client(&ntb_netdev_client);
> +	if (rc) {
> +		ntb_transport_unregister_client_dev(KBUILD_MODNAME);
> +		return rc;
> +	}
> +
> +	return 0;
>   }
>   module_init(ntb_netdev_init_module);
>   
