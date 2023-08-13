Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825642C9D
	for <ntb@lists.linux.dev>; Sun, 13 Aug 2023 14:00:42 +0000 (UTC)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-4fe28e4671dso5377511e87.0
        for <ntb@lists.linux.dev>; Sun, 13 Aug 2023 07:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691935240; x=1692540040;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EaAFctz41hALp0AaENbsggiXJ5f/QU9OD+8pfoYzelw=;
        b=IDxPLJZJwVFEhezwzhZDfNUE3WPXo5RUBf0oJbD2xwiBL92T5oj/WewIlEjsgqFYra
         a/ZdiMbcefqdJJ87pdLn/a/WOVdNv9N1Myl4N4fYruT9vRoEg8h4bwGhRjVevHDJoPLu
         TCh5ufiYGrJV6pEjJU4AIjhBeWklImuxbGwLYUfCEeOUsqIiyi3MrqJDfzTB85SDM0vq
         d81ow63MjQzNXyO6lCsCUbGjnjF/9fMVYQTYNVAKtX93XsUwhXkaIrBL00m7bSdAOA13
         xhK90/+T2+u2i7xpq/jib/27Dsf3diwom2ScmqjBeHs2fHq7D1AGLxG3H5AEyk09kA+X
         ixzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691935240; x=1692540040;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EaAFctz41hALp0AaENbsggiXJ5f/QU9OD+8pfoYzelw=;
        b=DtizHhh8eUFMXfNay5jZo5/j1boK4zIrA2UJjlttXJ/2kJNUmY5RbE0+X7JzjoLsxr
         S8BTzsZi5OxuT/YYcIWXW0VW4UbfGZirzi5lVZTQBzUjQPCZFGfEUWDMLqHUJ0CRLcKO
         ejyDJw/5vj3Ft+iOAB9e/EwcOCudG/3zRtHlomQH3KTSNNRMAsJKlsl4pz57fPrgHr5B
         Eq0kldHkgTnHmmIpzmr2KAF7U+/6H5bj0AeejLeIhOE7/uPDdi1thdrv+aUDVcDK7qhZ
         EF6w+L4yfsdc/ngCIX96AqFn8ctJDu8YIjCuevbZ6sfzZPJB5gFtaPosZJn1pP9R1UZC
         ou5g==
X-Gm-Message-State: AOJu0Yx066gssG/o7PDUZlSoYxTyHJfIsmAJOyiGxE4bawDTZ5rEzFZR
	CS+wNY6epmC9GuDk3V1AIgo=
X-Google-Smtp-Source: AGHT+IHMHsIC6rkOdAUAkFhWfM+q/CCZ0/mj0dFeX9NVCRDvHEdu6rxbpj9FUdpSvU6eVmAuU7lUJA==
X-Received: by 2002:a05:6512:5d2:b0:4f9:6b65:32cb with SMTP id o18-20020a05651205d200b004f96b6532cbmr4162634lfo.57.1691935239977;
        Sun, 13 Aug 2023 07:00:39 -0700 (PDT)
Received: from mobilestation ([109.194.233.135])
        by smtp.gmail.com with ESMTPSA id g7-20020a19ac07000000b004fdfa760a83sm1552277lfc.55.2023.08.13.07.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 07:00:39 -0700 (PDT)
Date: Sun, 13 Aug 2023 17:00:36 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Ruan Jinjie <ruanjinjie@huawei.com>
Cc: jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, 
	dan.carpenter@linaro.org, machel@vivo.com, jiasheng@iscas.ac.cn, ntb@lists.linux.dev
Subject: Re: [PATCH -next] NTB: ntb_tool: Switch to memdup_user_nul() helper
Message-ID: <nl4xu7tecp3ytntobzkxmnqeraa3lpaveolz7uft6gdzyr4aa6@h4mf4otod3ew>
References: <20230810111402.1923113-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810111402.1923113-1-ruanjinjie@huawei.com>

On Thu, Aug 10, 2023 at 07:14:02PM +0800, Ruan Jinjie wrote:
> Use memdup_user_nul() helper instead of open-coding to simplify the code.
> 
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
> ---
>  drivers/ntb/test/ntb_tool.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c
> index e0acc11d29ba..641cb7e05a47 100644
> --- a/drivers/ntb/test/ntb_tool.c
> +++ b/drivers/ntb/test/ntb_tool.c
> @@ -370,16 +370,9 @@ static ssize_t tool_fn_write(struct tool_ctx *tc,
>  	if (*offp)
>  		return 0;
>  
> -	buf = kmalloc(size + 1, GFP_KERNEL);
> -	if (!buf)
> -		return -ENOMEM;
> -
> -	if (copy_from_user(buf, ubuf, size)) {
> -		kfree(buf);
> -		return -EFAULT;
> -	}
> -
> -	buf[size] = 0;
> +	buf = memdup_user_nul(ubuf, size);
> +	if (IS_ERR(buf))
> +		return PTR_ERR(buf);

Nice code simplification. Thanks!
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

>  
>  	n = sscanf(buf, "%c %lli", &cmd, &bits);
>  
> -- 
> 2.34.1
> 
