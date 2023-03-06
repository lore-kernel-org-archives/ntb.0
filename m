Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAC9320E
	for <ntb@lists.linux.dev>; Mon,  6 Mar 2023 15:28:14 +0000 (UTC)
Received: by mail-lf1-f46.google.com with SMTP id n2so13206192lfb.12
        for <ntb@lists.linux.dev>; Mon, 06 Mar 2023 07:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678116492;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=My1MFXSD/RWeKCEqSJZ9TX01DdnzJtrMv7kbrxpycI4=;
        b=Ymb5/WI4gW9yBplYiAuQmNp4N4SodHb4uZk6ZUxx+RZs7ew9PDJE/0mgtAbuhqBi5D
         WkWK6zrEy+v6ecFJcYvc52rHLuMmLMgubaWjFa0MLdlPpJiolqfa0N5JnVdDS0PV8Obz
         G9j7Lk+Lg/T1BYlGFETEoI5liD3S3ujz7Hszlol8PnZJ7rRdh+xQ+b1UC1CZP7zOFGFw
         59iyTMrK+ZWKqDIKlgXGiXDSwnOLkyoyn/Dc9lbytn/jsI+DcEB25xbZP4MfLv9fBjja
         y+WHx6Baj0UHvp10YMReenk4y4Y0OELP0UGR45wYFHsypZOM+7Col5a9/Bgjl4hEjacU
         CRDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678116492;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=My1MFXSD/RWeKCEqSJZ9TX01DdnzJtrMv7kbrxpycI4=;
        b=zCJV+gmleA9lrRiFu4EqQaHUGUaKm1ecM+SHJt0xBKO1FrEeBWJyNG0Zng+wCiE7UB
         z6DDUClJkNhMEXsdmeozkIyoXTKupWev6J+lKLGJhgo40JsDwEQ4Lig1own3jWdO5tGF
         fcAqIy2KR44JU1Id5JjOA1v7H3/lSSK/qkJTgrDEbuJiiOZt2Z5Xp/TDdQq4cpcHWBHh
         PP7ZnxyycnYbJa5bR1ZwB1XTV1yY7/F2sdjRIgPZjfSPKHNZblk7/Lqe2TQUxt0B1GBN
         J187N8U5aCr0FysH056sll1OpRzxJE5+5FL2Gd8smZGC74D+3xSylyqHEiEUDiKpoYed
         R04A==
X-Gm-Message-State: AO0yUKX54YcmGdvBDsB5DifkXmMn85n5NZwR9HNRK97fgKySj3OrEQvg
	9HT+h5LcE/wndqVMgN8W/mM=
X-Google-Smtp-Source: AK7set8QknUUjBPaJJUkVEulRaDql/56Ncy5gJ4sSLp6mFoFQ470mVFeJDp9hdw1jnhsTrNCM/AN9Q==
X-Received: by 2002:ac2:4a65:0:b0:4dc:8215:5524 with SMTP id q5-20020ac24a65000000b004dc82155524mr2553337lfp.31.1678116492513;
        Mon, 06 Mar 2023 07:28:12 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id a18-20020ac25212000000b004d813ec9b47sm1666020lfl.132.2023.03.06.07.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 07:28:11 -0800 (PST)
Date: Mon, 6 Mar 2023 18:28:10 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Kang Chen <void0red@gmail.com>
Cc: jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
	ntb@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ntb_tool: check null return of devm_kcalloc in
 tool_init_mws
Message-ID: <20230306152810.ptb622tfhoxehhdc@mobilestation>
References: <20230226055743.2522819-1-void0red@gmail.com>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230226055743.2522819-1-void0red@gmail.com>

On Sun, Feb 26, 2023 at 01:57:43PM +0800, Kang Chen wrote:
> devm_kcalloc may fails, tc->peers[pidx].outmws might be null
> and will cause null pointer dereference later.
> 
> Signed-off-by: Kang Chen <void0red@gmail.com>

Please add the fixes tag:
Fixes: 7f46c8b3a552 ("NTB: ntb_tool: Add full multi-port NTB API support")
so the patch could be noticeable by the stable kernel maintainers.

Other than that looks good.
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

* Please don't forget to add the Rb-tags on v2.

-Serge(y)

> ---
>  drivers/ntb/test/ntb_tool.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c
> index 5ee0afa62..eeeb4b1c9 100644
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
> 2.34.1
> 
> 
