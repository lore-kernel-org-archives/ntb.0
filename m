Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F251E746B
	for <ntb@lists.linux.dev>; Mon, 27 Feb 2023 15:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677513511; x=1709049511;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5H0k3qY8U+R+Lr/NVi0+45TqQXSQ5y01pcav2hkOVdg=;
  b=VDNBQPpYW9iUMA7+4qX6QD9Dms3uTFQNwS5q5rL3Bh7YARSzy+BF1hUi
   SVqk1GQmA8yMZP5sAE1zZLgSJ+jprnt+Q/EsI6BBSKQIjRkd0bJllp7SS
   NXqiOwqCK696iPsjzfHjzX12IyD/vLeIGuRGbsr9zeWtkfmQ7k/0uZY2w
   L07Yu+y5JOUyT0jjkGRaaS/TBANWItnw2VxIm7V3aSKrIQ2fdolXVGKg5
   ulZT38QAfw2P5PoDsmeDvQK9YXiExJ5Ei5gji/1KAsZVQsHpPqjuH5RNA
   c4SCLW6fP6xDUlC3J8mA/+5yJ7E90OvxPSbH12syaoNMK/BptMlLy6Cjw
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="314314765"
X-IronPort-AV: E=Sophos;i="5.98,219,1673942400"; 
   d="scan'208";a="314314765"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 07:58:30 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="919395922"
X-IronPort-AV: E=Sophos;i="5.98,219,1673942400"; 
   d="scan'208";a="919395922"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.113.7]) ([10.212.113.7])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 07:58:30 -0800
Message-ID: <caa8671d-ab6c-dcec-c363-e12e1515f65e@intel.com>
Date: Mon, 27 Feb 2023 08:58:29 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH] ntb_tool: check null return of devm_kcalloc in
 tool_init_mws
Content-Language: en-US
To: Kang Chen <void0red@gmail.com>, jdmason@kudzu.us
Cc: allenbh@gmail.com, ntb@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230226055743.2522819-1-void0red@gmail.com>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230226055743.2522819-1-void0red@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/25/23 10:57 PM, Kang Chen wrote:
> devm_kcalloc may fails, tc->peers[pidx].outmws might be null
> and will cause null pointer dereference later.
> 
> Signed-off-by: Kang Chen <void0red@gmail.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/ntb/test/ntb_tool.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c
> index 5ee0afa62..eeeb4b1c9 100644
> --- a/drivers/ntb/test/ntb_tool.c
> +++ b/drivers/ntb/test/ntb_tool.c
> @@ -998,6 +998,8 @@ static int tool_init_mws(struct tool_ctx *tc)
>   		tc->peers[pidx].outmws =
>   			devm_kcalloc(&tc->ntb->dev, tc->peers[pidx].outmw_cnt,
>   				   sizeof(*tc->peers[pidx].outmws), GFP_KERNEL);
> +		if (tc->peers[pidx].outmws == NULL)
> +			return -ENOMEM;
>   
>   		for (widx = 0; widx < tc->peers[pidx].outmw_cnt; widx++) {
>   			tc->peers[pidx].outmws[widx].pidx = pidx;
