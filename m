Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868E2137B
	for <ntb@lists.linux.dev>; Thu, 28 Jul 2022 11:44:21 +0000 (UTC)
Received: by mail-lf1-f48.google.com with SMTP id q23so2462857lfr.3
        for <ntb@lists.linux.dev>; Thu, 28 Jul 2022 04:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tbXP8qNprGm58AEISDfBUgGwntYkFNWKEaIhjBXeL5Y=;
        b=esxMVpWf7Ufk58lF0ldIcDSVr5QyRlOOu7fM0kl4YwnV5Vpr3L9RxQ6e2shda+3p5T
         anWabe2tUmuF197IvT7ZJkXHwAphqfxjJHhhG8AqwW3AxTfmDAk9+mbnX1rTe+W07qcr
         iIaldCEKZiMGxnKzD0pjfoQDFG16v+3Dw5AJv4co3fpgUu9jAmIt1UoRNxePn12sb8Fm
         IwI1IrMeaeNHgGXfoSN8rpAxfgmk3xHUlwnFlWTwO4+oqeZkbit28U/hmF4joT1SO3Jr
         atgsaFQ8FmeveNNYRv4ffpDnZhcACv8GHUx1bZZxisrjRzOS2ZSeGpNIXNv4a43oYmSV
         DDeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tbXP8qNprGm58AEISDfBUgGwntYkFNWKEaIhjBXeL5Y=;
        b=7yxUAEHe9drqSVHBpqpaynv+BwNFfoAJw3Rvj7p0GG+T7+KUJ3y+V2E3EwsYDts+qt
         wobfDHpJCFnAZda0p7JCRoO1vVIVsib/PRfPdNVMeMK1L2YgjNROtTqGAExTwu0rxdJo
         aN+jbBa2jO+qi7GquprEaPOGpc5kSrpHrOG3mQM4bUgFK3BDp3sfxEuZ53Nmjq5Tydg9
         YUNRvYH845//6IgmANP6dW7dDBwJTARWg0SdFVNyImXD0I/VFm5f6yG5ST+hLFKbaZgv
         iGIONhizZk8fS7iA1EayeA4KYbrpTsynQcaMluYSIMBW8XH9zuxl4L+supNWv9q0yVym
         u+2A==
X-Gm-Message-State: AJIora9kpY39m1MB9bA1Ga5Raw8eh05L+27Yml9DKlvUvLstf6BJfWOP
	7xFVm3xATkhKmPjqX5/KSmA=
X-Google-Smtp-Source: AGRyM1tEOsvAfwLqoLibNHpjwJhC83hvw9zfhdQw7Y85VRUWXN1y5KpC76gcjsEyggJXeii+igNP7A==
X-Received: by 2002:a05:6512:3691:b0:48a:81ff:343d with SMTP id d17-20020a056512369100b0048a81ff343dmr9863235lfs.553.1659008659563;
        Thu, 28 Jul 2022 04:44:19 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id u21-20020ac25195000000b0047fa16f71e6sm167045lfi.30.2022.07.28.04.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 04:44:18 -0700 (PDT)
Date: Thu, 28 Jul 2022 14:44:17 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>,
	Dave Jiang <dave.jiang@intel.com>, ntb@lists.linux.dev,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] NTB: ntb_tool: uninitialized heap data in tool_fn_write()
Message-ID: <20220728114417.hkhnv4lkqy6uzqq3@mobilestation>
References: <YthJQqfMCb47jHbG@kili>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YthJQqfMCb47jHbG@kili>

On Wed, Jul 20, 2022 at 09:28:18PM +0300, Dan Carpenter wrote:
> The call to:
> 
> 	ret = simple_write_to_buffer(buf, size, offp, ubuf, size);
> 
> will return success if it is able to write even one byte to "buf".
> The value of "*offp" controls which byte.  This could result in
> reading uninitialized data when we do the sscanf() on the next line.
> 
> This code is not really desigined to handle partial writes where
> *offp is non-zero and the "buf" is preserved and re-used between writes.
> Just ban partial writes and replace the simple_write_to_buffer() with
> copy_from_user().
> 
> Fixes: 578b881ba9c4 ("NTB: Add tool test client")

Looks good. Thanks.
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Sergey

> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/ntb/test/ntb_tool.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c
> index b7bf3f863d79..5ee0afa621a9 100644
> --- a/drivers/ntb/test/ntb_tool.c
> +++ b/drivers/ntb/test/ntb_tool.c
> @@ -367,14 +367,16 @@ static ssize_t tool_fn_write(struct tool_ctx *tc,
>  	u64 bits;
>  	int n;
>  
> +	if (*offp)
> +		return 0;
> +
>  	buf = kmalloc(size + 1, GFP_KERNEL);
>  	if (!buf)
>  		return -ENOMEM;
>  
> -	ret = simple_write_to_buffer(buf, size, offp, ubuf, size);
> -	if (ret < 0) {
> +	if (copy_from_user(buf, ubuf, size)) {
>  		kfree(buf);
> -		return ret;
> +		return -EFAULT;
>  	}
>  
>  	buf[size] = 0;
> -- 
> 2.35.1
> 
> 
