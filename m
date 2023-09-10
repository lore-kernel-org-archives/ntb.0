Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB89D8469
	for <ntb@lists.linux.dev>; Sun, 10 Sep 2023 19:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
	bh=xcilVeHv6ykY5H+2uQdXkLGtsOdwOH4P3neVlhn/mdQ=; b=T/wE5keXZTLFdt3W0rXxbq8g6P
	YjqqnDGdu0e5W6yyHkIf5bvmTKqSz0/FRN2gVDixrRxUVQLkaxDiyrRKy7zfbp/8iZIBSkHOXSTZV
	mL8a2PfgEtpAjrpoKGBBWMF05CoeCcQktpmjWqhSiipcJoVnog+84RQNzZVt7JJu6bnUNA5vUFPfn
	0+GLSMZL/vMdLFfauzf2lVmeJn6x0vTNQAeN3L8vsQWboZacAtK4WgL+R10vuurQbm+lonTxWPE94
	tDXKrJ2ELT0Lt3YgNtG/PzcCdFY6fcTlvYyJ7p4KPVVMzw33JKc7d61eMMiJE1K8CPfOUKVBRC0QC
	zEZSyYIg==;
Received: from [2601:1c2:980:9ec0::9fed]
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qfPwp-00GqfE-2R;
	Sun, 10 Sep 2023 19:18:19 +0000
Message-ID: <4bd520bd-f0d5-7db2-30a2-5dea5d1ae4a8@infradead.org>
Date: Sun, 10 Sep 2023 12:18:19 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] ntb_perf: Fix printk format
Content-Language: en-US
To: Max Hawking <maxahawking@sonnenkinder.org>, Jon Mason <jdmason@kudzu.us>,
 Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
 Serge Semin <fancer.lancer@gmail.com>, Minjie Du <duminjie@vivo.com>,
 ntb@lists.linux.dev, linux-kernel@vger.kernel.org
References: <f2fb85b9-278d-9e12-b61c-d951c71bf2f6@gmx.net>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <f2fb85b9-278d-9e12-b61c-d951c71bf2f6@gmx.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi--

On 9/10/23 00:34, Max Hawking wrote:
> The correct printk format is %pa or %pap, but not %pa[p].
> 
> Fixes: 99a06056124d ("NTB: ntb_perf: Fix address err in perf_copy_chunk")
> Signed-off-by: Max Hawking <maxahawking@sonnenkinder.org>
> ---
>  drivers/ntb/test/ntb_perf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
> index 553f1f46bc66..72bc1d017a46 100644
> --- a/drivers/ntb/test/ntb_perf.c
> +++ b/drivers/ntb/test/ntb_perf.c
> @@ -1227,7 +1227,7 @@ static ssize_t perf_dbgfs_read_info(struct file
> *filep, char __user *ubuf,

Those 2 lines above should be on one line.
(i.e., they should not wrap, so set tbird's wrap length to 0)

Documentation/process/email-clients.rst has some info about
how to coerce Thunderbird into working for patches.

>  			"\tOut buffer addr 0x%pK\n", peer->outbuf);
> 
>  		pos += scnprintf(buf + pos, buf_size - pos,
> -			"\tOut buff phys addr %pa[p]\n", &peer->out_phys_addr);
> +			"\tOut buff phys addr %pap\n", &peer->out_phys_addr);
> 
>  		pos += scnprintf(buf + pos, buf_size - pos,
>  			"\tOut buffer size %pa\n", &peer->outbuf_size);
> --
> 2.41.0

-- 
~Randy
