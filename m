Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758C88F74
	for <ntb@lists.linux.dev>; Thu, 10 Nov 2022 15:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668094417; x=1699630417;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8cSTym4wRT2aQAzyIKH9vytoP2uvVkoMcVD/5LC5hXA=;
  b=ae6UQ1BPORJ1PGVmukshbciZsPlbBbLu6gh15NacjoRLY2BhKnz5Mcxg
   iqj7D0Q/DvfcnPIVo/QhoCBFXPI2XuJNVjukvPecUrfTRL3c+xfL93Cvv
   I9PrO+mOr8AgpfG0UcBYuO9y7zuacJ2fe6MvQlWxktLTqcyHSPjMnoffN
   taCop3L/N+TSU3Ou3ItVr26YO5QYNuIL1Rf+XsJQ3oseQnrigOYLelUl1
   8TCAoVVJMsjeIIQMHS16VT3ohuNHWUfKnPu/2GcmbKbpmjLo/cJg0ss6u
   l7fGI4S0WpRU1VHn02lNzaKwICZBm70F9nvoCPUJPbpB8A1MpiflUx5Tz
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="397634580"
X-IronPort-AV: E=Sophos;i="5.96,154,1665471600"; 
   d="scan'208";a="397634580"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 07:33:36 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="726424295"
X-IronPort-AV: E=Sophos;i="5.96,154,1665471600"; 
   d="scan'208";a="726424295"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.49.246]) ([10.212.49.246])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 07:33:36 -0800
Message-ID: <d2b68fe0-214f-5464-f687-985dc6e7ccb8@intel.com>
Date: Thu, 10 Nov 2022 08:33:35 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.1
Subject: Re: [PATCH] NTB: ntb_transport: fix possible memory leak while
 device_register() fails
Content-Language: en-US
To: Yang Yingliang <yangyingliang@huawei.com>, ntb@lists.linux.dev
Cc: jdmason@kudzu.us, allenbh@gmail.com
References: <20221110151917.399214-1-yangyingliang@huawei.com>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20221110151917.399214-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/10/2022 7:19 AM, Yang Yingliang wrote:
> If device_register() returns error, the name allocated by
> dev_set_name() need be freed. As comment of device_register()
> says, it should use put_device() to give up the reference in
> the error path. So fix this by calling put_device(), then the
> name can be freed in kobject_cleanup(), and client_dev is freed
> in ntb_transport_client_release().
> 
> Fixes: fce8a7bb5b4b ("PCI-Express Non-Transparent Bridge Support")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/ntb/ntb_transport.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index a9b97ebc71ac..2abd2235bbca 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -410,7 +410,7 @@ int ntb_transport_register_client_dev(char *device_name)
>   
>   		rc = device_register(dev);
>   		if (rc) {
> -			kfree(client_dev);
> +			put_device(dev);
>   			goto err;
>   		}
>   
