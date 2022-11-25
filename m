Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF862F46
	for <ntb@lists.linux.dev>; Fri, 25 Nov 2022 11:49:08 +0000 (UTC)
Received: by mail-lf1-f46.google.com with SMTP id g12so6529024lfh.3
        for <ntb@lists.linux.dev>; Fri, 25 Nov 2022 03:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qEeTFgj6vtT8z9vOAzPfVZVEyvXymEWt+IDPrKUsU7Y=;
        b=B4AuyHeU250ikjrEPn9GPuTChIwjk4npQjcZwnS5jcaOJPAoAgPFPi/K4lGY33Y0vR
         ptevEnkh0nxKd7XGEStpO5LoXn26Bpa9tZuDsQHSxAhq+hEb6atqVKxsm/rPk0E3ROpv
         jPEyRHk6chBfszmlGT4pkpOjGghwARnvwW8Dkui7+dUgw9hx+StyEHMu9yxEQ3YUb/Zd
         GZQxjeatjx7LHANIgGvRc1BEu6oTe9D/nZ7BQqDKfXe6tGelvv2u49ncg7WwuU3MCxwo
         Rs1p73ZnxvgiKYe57AaDxGFsw7UgLKfHqxqkNt/169v5gdDdVTa+WEQMKkut0UEv8hjb
         XITw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qEeTFgj6vtT8z9vOAzPfVZVEyvXymEWt+IDPrKUsU7Y=;
        b=oF8Ph8/2bDbwGLzPJAMkoixlSX5BpDZYLejNGnUbKgbJwAxajU+tdDW1CFvT073v54
         X/LStYNyZ8ZvUP2f2UJMzeIzGinsFyNe+iynvnD1uEZqybvOaoD+HSBawNTmku5mQh8f
         DjLZ9D2KpNp0yvVg6MsgBdCuaJi30jHxoauHdHQzxZNcV5OJ4di3D5ZnaKKW/Q/+U/Ny
         Obtj93qjMBl38YEOThy10xP9sWiQ0a+xUrRqkZMj/z0Z6PnjPmQaQdhyukJke7JxbHX8
         hSiDSUpScKLF5wzVyns2yjz2m9Hurwu6FLpdrRXWGQr0swq3votrXJso97u5QrEj6QTi
         mJdw==
X-Gm-Message-State: ANoB5pnVD43E7eWw8yl/pugAffsaookj/bFjEweAM2xR+/T928dHHYf7
	N75BZJquFq5jYWrfhGZXVIw=
X-Google-Smtp-Source: AA0mqf7zYcxxJfmxkfye5xKy3CmTBgFFoMZREedCoqU9op1U7gaG0Gu66/5ECHk/a0scqUhCCOndGQ==
X-Received: by 2002:a05:6512:715:b0:4b4:e552:5638 with SMTP id b21-20020a056512071500b004b4e5525638mr4607720lfs.287.1669376946303;
        Fri, 25 Nov 2022 03:49:06 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id p8-20020a2eba08000000b002776eb5b1ccsm340479lja.4.2022.11.25.03.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 03:49:05 -0800 (PST)
Date: Fri, 25 Nov 2022 14:49:03 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc: jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
	error27@gmail.com, ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NTB: ntb_tool: Add check for devm_kcalloc
Message-ID: <20221125114903.dby6ysdr5qkeo5ay@mobilestation>
References: <20221122033244.5777-1-jiasheng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122033244.5777-1-jiasheng@iscas.ac.cn>

On Tue, Nov 22, 2022 at 11:32:44AM +0800, Jiasheng Jiang wrote:
> As the devm_kcalloc may return NULL pointer,
> it should be better to add check for the return
> value, as same as the others.
> 
> Fixes: 7f46c8b3a552 ("NTB: ntb_tool: Add full multi-port NTB API support")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>

Right. Thanks!
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Sergey

> ---
>  drivers/ntb/test/ntb_tool.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c
> index 5ee0afa621a9..eeeb4b1c97d2 100644
> --- a/drivers/ntb/test/ntb_tool.c
> +++ b/drivers/ntb/test/ntb_tool.c
> @@ -998,6 +998,8 @@ static int tool_init_mws(struct tool_ctx *tc)
>  		tc->peers[pidx].outmws =
>  			devm_kcalloc(&tc->ntb->dev, tc->peers[pidx].outmw_cnt,
>  				   sizeof(*tc->peers[pidx].outmws), GFP_KERNEL);
> +		if (tc->peers[pidx].outmws == NULL)
> +			return -ENOMEM;
>  
>  		for (widx = 0; widx < tc->peers[pidx].outmw_cnt; widx++) {
>  			tc->peers[pidx].outmws[widx].pidx = pidx;
> -- 
> 2.25.1
> 
> 
