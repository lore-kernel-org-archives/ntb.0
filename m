Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3931364
	for <ntb@lists.linux.dev>; Tue, 19 Apr 2022 16:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=bn5gyY+3+xnocaEXQ1ub68fqvMC/+QyIGS1VbmoqLzQ=; b=JYMbw00HEy1svWGf07hspaVsEQ
	xxqaDgs+25Q9sfbTe402CuAO9HkfXNEKpLfcFKpb4fAChFXUiOwkNLh6wua7vFlS+W+kZ/dmdFidN
	Icr0t+fABKKCRc3zxG8FEG1u2hBnIY7LTqY15YHDKVpuUUwv7bl9Cq1N7YwRrVMqLjdHyG666Qkjd
	mXQaoH95+jXgftDPCiRaxs9NTsYyeYmVa2Z+CnUjFOb7L6vwk4o0tzVStv9xbRotdHo7Oq1HJlgLI
	siVQjwQjL5JWv9SCzj+ySXUBiO6ovIjNu+bF1Ev1sx6UO7+0fMewlC30tvEU8dMKNvMpJYrGAJFAz
	RylFh2zQ==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <logang@deltatee.com>)
	id 1ngq73-00BbRv-Ru; Tue, 19 Apr 2022 09:49:58 -0600
Message-ID: <7cb4d3be-925f-05bd-78fe-67a69dfee18d@deltatee.com>
Date: Tue, 19 Apr 2022 09:49:51 -0600
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-CA
To: Guo Zhengkui <guozhengkui@vivo.com>, Jon Mason <jdmason@kudzu.us>,
 Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
 Yang Li <yang.lee@linux.alibaba.com>,
 Alexander Fomichev <fomichev.ru@gmail.com>,
 Serge Semin <fancer.lancer@gmail.com>,
 "open list:NTB DRIVER CORE" <ntb@lists.linux.dev>,
 open list <linux-kernel@vger.kernel.org>
Cc: zhengkui_guo@outlook.com
References: <20220419071855.23338-1-guozhengkui@vivo.com>
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20220419071855.23338-1-guozhengkui@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: guozhengkui@vivo.com, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, yang.lee@linux.alibaba.com, fomichev.ru@gmail.com, fancer.lancer@gmail.com, ntb@lists.linux.dev, linux-kernel@vger.kernel.org, zhengkui_guo@outlook.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=5.0 tests=ALL_TRUSTED,BAYES_00,
	NICE_REPLY_A,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
Subject: Re: [PATCH] ntb_perf: fix doubletest cocci warning
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2022-04-19 01:18, Guo Zhengkui wrote:
> `!data->ops.init` has been repeated triple. The original logic is to
> check whether `.init`, `.run` and `.clear` callbacks are NULL or not.
> 
> Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>

This appears to be a patch against Alexander's patch which has not been
accepted yet. Posting a note on his patch so he fixes it for the next
posting would be preferable.

Logan

> ---
>  drivers/ntb/test/ntb_perf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
> index c106c3a5097e..dcae4be91365 100644
> --- a/drivers/ntb/test/ntb_perf.c
> +++ b/drivers/ntb/test/ntb_perf.c
> @@ -1451,7 +1451,7 @@ static void perf_ext_lat_work(struct work_struct *work)
>  {
>  	struct perf_ext_lat_data *data = to_ext_lat_data(work);
>  
> -	if (!data->ops.init || !data->ops.init || !data->ops.init) {
> +	if (!data->ops.init || !data->ops.run || !data->ops.clear) {
>  		struct perf_ctx *perf = data->perf;
>  
>  		data->status = -EFAULT;
