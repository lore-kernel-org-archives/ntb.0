Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB56E257E
	for <ntb@lists.linux.dev>; Sun, 10 Sep 2023 15:04:38 +0000 (UTC)
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3a81154c570so2213411b6e.1
        for <ntb@lists.linux.dev>; Sun, 10 Sep 2023 08:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20230601.gappssmtp.com; s=20230601; t=1694358278; x=1694963078; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nDYqf7NAkj0kLanm9WYb8IsGKxG9JNncVcxESiCiOCw=;
        b=ROAFdoCA8RW6SNZjb4xAsJwHRM3D3nZra9254dL00wTJiOmWoDd+WsqnRD9m2t+8FA
         ueuNF15BFFQx7gheqeE3cVPNsZtHYS7ueR6UfK0E2JN4Hvg9DUP/h6xkLKWiHJ1EetNZ
         vl14f1UsuA3H4JPKTgiIA4BmpO7HjKekQR8q9guAkldr9ZTmzJ4U4MZzYjQlrMbRr7PS
         z7foWmeFyk5S5CuyZ4293TbbPPozl7A4ChFQiKymbBChPN/6Gq1VxEPXi4lbi5zsHtfH
         R3YhVgtNZqbeTR33E9/ERxHkNXaxnftYnePN1L+gUUm0+uTbsv8huDhckJG8RAUQRl0y
         ffuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694358278; x=1694963078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nDYqf7NAkj0kLanm9WYb8IsGKxG9JNncVcxESiCiOCw=;
        b=tO47MK6PJCYyKETSsbyEcbGSvZwanF82Sm19ubkba3stK8vX+AEKWQDDH+0Jf68wq5
         5EFztEMGg2jQ7RsInGwI2rfONhQQ2BvtZ4kyZrqydJCvN3sC7f/Jrk7WQx/cXwQ8zPTb
         PT3moEizJqGF6KP8JnLvDcJpdCfjKUmBDHmjNi5Qi/np/pMSIvCxyaY5XZE602pBNjcl
         xqcBl7EZ7gw4sQZLNIqtDSnMEsRi1mK1AU6PUdJ/iPUNsHA7BQ3p6IflHE+KxUiMfU4w
         NbK1flpL4Mdz73PMNwW9SUlcBGWR+42PBiLcToRylaEt7JEDY5bHb0iWXBmkV480oA8Q
         xPUQ==
X-Gm-Message-State: AOJu0YytZpYVbDAurLZ0lRYAD8uLvxG7z3URVevaGjBqNogODRgRG4hV
	bY68ciH4+gXZZHWeViW1pz3brw==
X-Google-Smtp-Source: AGHT+IEXCD+cmi1LV9MsXjHZZwUEKfle6kVjsgzdfhPyLV3ELs7tz/YuXNuCfcJSgFQueW67sF3UDw==
X-Received: by 2002:aca:2b1a:0:b0:3a7:56a7:6a91 with SMTP id i26-20020aca2b1a000000b003a756a76a91mr6976757oik.23.1694358277912;
        Sun, 10 Sep 2023 08:04:37 -0700 (PDT)
Received: from kudzu.us ([2605:a601:a697:5800:8ac9:b3ff:febf:a2f8])
        by smtp.gmail.com with ESMTPSA id j2-20020ac84402000000b0040324785e4csm1979738qtn.13.2023.09.10.08.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Sep 2023 08:04:37 -0700 (PDT)
Date: Sun, 10 Sep 2023 11:04:30 -0400
From: Jon Mason <jdmason@kudzu.us>
To: Max Hawking <maxahawking@sonnenkinder.org>
Cc: Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Minjie Du <duminjie@vivo.com>, ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ntb_perf: Fix printk format
Message-ID: <ZP3a/oD0nzaFdPo/@kudzu.us>
References: <f2fb85b9-278d-9e12-b61c-d951c71bf2f6@gmx.net>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2fb85b9-278d-9e12-b61c-d951c71bf2f6@gmx.net>

On Sun, Sep 10, 2023 at 12:34:34AM -0700, Max Hawking wrote:
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

For some reason this patch isn't applying cleanly for me, I'm seeing
the following issue:
$ b4 am -o - f2fb85b9-278d-9e12-b61c-d951c71bf2f6@gmx.net | patch -p1

...

patching file drivers/ntb/test/ntb_perf.c
patch: **** malformed patch at line 23: *filep, char __user *ubuf,

Please rebase and resend.

Thanks,
Jon
