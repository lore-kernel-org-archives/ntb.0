Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B299F33C1;
	Tue, 12 Jul 2022 11:40:19 +0000 (UTC)
Received: by mail-lj1-f171.google.com with SMTP id q7so9512914lji.12;
        Tue, 12 Jul 2022 04:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=btM9O32CpBgf9kJSlQ2/qg4sExAM4lqY12hcCyew4L4=;
        b=MSCNJZqcyi8mLKBEVZJlWmSCppOBNhhpRe7h6+H3HIUBdpTsEKsK8mE5lh50C9J1Lm
         nT3Sb3CrPfGsF7hhOqdObCgxyuf40G6SkLrrzycPIIWYXKQ/S0uMKOGEJ0WP85Jy2nzp
         KTxPhM0jb28DNnO4QCy4HOR3X5/TDpTaes+UCL5HTlPYxYsteyyGf6yq+kGfALyQWjct
         o6A/37JpMnq5+fbbpQWIxPRnyX8GOlFS4Gg/cHxvhfpq5fGc/JSG+g/aePLYU6JxTIdp
         FaB7vxwy79asmV3Ip80BF2VnDIVY8722PywUdxDhQR0Y7ueS5HfAc5SnSta2p4ozEqWr
         UNEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=btM9O32CpBgf9kJSlQ2/qg4sExAM4lqY12hcCyew4L4=;
        b=KqzupxnffY9RY3ZMVtUeWhZ4sK7Hzj808pH/v5d/xI1KOJjC07AgjJnJyWo0LADrwb
         dKB33cLL/kZWkCnjKSIEJ8qRCQNn4pHIg2935d92RAWQVMuc6HDVjvUIP6RtVVwes+xI
         RnMF1iGAiG4pUnxc3AFTm7y+Sfxmkyzn9f7PndTJSQZwj+qjqe1IiDOn2+SMakKqZiw6
         YrDbHHhGlskNZY77tKVHFmOllwC8qOHedtwNktPVIlwBIacLZtR5n5lAx8NmKSBnhCp/
         trBem+eQULL3q200j8bEqlEidaaYOdp3vdihACf3tvoN6v7RRxMWm5DRwq1wz96gZ2Lq
         f+6Q==
X-Gm-Message-State: AJIora/PPhY+n2gv1kWcJ6a8WDOt05hT0pOeAjrez3VevXandkHZwMFf
	22JXipOV//lZh0mQ++2WkYA=
X-Google-Smtp-Source: AGRyM1uQru/cEAVmqTHTRN/afmY9LzWQVOeKtl+D8TNLyBugv3x8OQlAUpU8GfP7IvUNZtddlTr0Ag==
X-Received: by 2002:a05:651c:545:b0:25b:c791:816c with SMTP id q5-20020a05651c054500b0025bc791816cmr13015642ljp.161.1657626017605;
        Tue, 12 Jul 2022 04:40:17 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id g7-20020a19ee07000000b0047f7fc29169sm2135412lfb.223.2022.07.12.04.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 04:40:17 -0700 (PDT)
Date: Tue, 12 Jul 2022 14:40:15 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Justin Stitt <justinstitt@google.com>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>, ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] ntb: idt: fix clang -Wformat warnings
Message-ID: <20220712114015.uosuteetstheqhgj@mobilestation>
References: <20220711230148.2130871-1-justinstitt@google.com>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220711230148.2130871-1-justinstitt@google.com>

Hi Justin

On Mon, Jul 11, 2022 at 04:01:48PM -0700, Justin Stitt wrote:
> When building with Clang we encounter these warnings:
> | drivers/ntb/hw/idt/ntb_hw_idt.c:2409:28: error: format specifies type
> | 'unsigned char' but the argument has type 'int' [-Werror,-Wformat]
> | "\t%hhu-%hhu.\t", idx + cnt - 1);
> -
> | drivers/ntb/hw/idt/ntb_hw_idt.c:2438:29: error: format specifies type
> | 'unsigned char' but the argument has type 'int' [-Werror,-Wformat]
> | "\t%hhu-%hhu.\t", idx + cnt - 1);
> -
> | drivers/ntb/hw/idt/ntb_hw_idt.c:2484:15: error: format specifies type
> | 'unsigned char' but the argument has type 'int' [-Werror,-Wformat], src);
> 
> For the first two warnings the format specifier used is `%hhu` which
> describes a u8. Both `idx` and `cnt` are u8 as well. However, the
> expression as a whole is promoted to an int as you cannot get
> smaller-than-int from addition. Therefore, to fix the warning, use the
> promoted-to-type's format specifier -- in this case `%d`.
> 
> example:
> ``
> uint8_t a = 4, b = 7;
> int size = sizeof(a + b - 1);
> printf("%d\n", size);
> // output: 4
> ```
> 
> For the last warning, src is of type `int` while the format specifier
> describes a u8. The fix here is just to use the proper specifier `%d`.
> 
> See more:
> (https://wiki.sei.cmu.edu/confluence/display/c/INT02-C.+Understand+integer+conversion+rules)
> "Integer types smaller than int are promoted when an operation is
> performed on them. If all values of the original type can be represented
> as an int, the value of the smaller type is converted to an int;
> otherwise, it is converted to an unsigned int."
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/378
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Thanks for fixing this. Definitely
Acked-by: Serge Semin <fancer.lancer@gmail.com>

-Sergey

> ---
> Note: This patch silences the -Wformat warnings for this file (which is
> the goal) but in reality all instances of `%hh[dux]` should be converted
> to `%[dux]` for this file and probably every file. That's a bit larger
> scope than the goal of enabling -Wformat for Clang builds, though.
> 
>  drivers/ntb/hw/idt/ntb_hw_idt.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
> index 733557231ed0..0ed6f809ff2e 100644
> --- a/drivers/ntb/hw/idt/ntb_hw_idt.c
> +++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
> @@ -2406,7 +2406,7 @@ static ssize_t idt_dbgfs_info_read(struct file *filp, char __user *ubuf,
>  				"\t%hhu.\t", idx);
>  		else
>  			off += scnprintf(strbuf + off, size - off,
> -				"\t%hhu-%hhu.\t", idx, idx + cnt - 1);
> +				"\t%hhu-%d.\t", idx, idx + cnt - 1);
>  
>  		off += scnprintf(strbuf + off, size - off, "%s BAR%hhu, ",
>  			idt_get_mw_name(data), ndev->mws[idx].bar);
> @@ -2435,7 +2435,7 @@ static ssize_t idt_dbgfs_info_read(struct file *filp, char __user *ubuf,
>  					"\t%hhu.\t", idx);
>  			else
>  				off += scnprintf(strbuf + off, size - off,
> -					"\t%hhu-%hhu.\t", idx, idx + cnt - 1);
> +					"\t%hhu-%d.\t", idx, idx + cnt - 1);
>  
>  			off += scnprintf(strbuf + off, size - off,
>  				"%s BAR%hhu, ", idt_get_mw_name(data),
> @@ -2480,7 +2480,7 @@ static ssize_t idt_dbgfs_info_read(struct file *filp, char __user *ubuf,
>  		int src;
>  		data = idt_ntb_msg_read(&ndev->ntb, &src, idx);
>  		off += scnprintf(strbuf + off, size - off,
> -			"\t%hhu. 0x%08x from peer %hhu (Port %hhu)\n",
> +			"\t%hhu. 0x%08x from peer %d (Port %hhu)\n",
>  			idx, data, src, ndev->peers[src].port);
>  	}
>  	off += scnprintf(strbuf + off, size - off, "\n");
> -- 
> 2.37.0.144.g8ac04bfd2-goog
> 
