Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002F62C9D
	for <ntb@lists.linux.dev>; Sun, 13 Aug 2023 14:48:30 +0000 (UTC)
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2b9a2033978so52475411fa.0
        for <ntb@lists.linux.dev>; Sun, 13 Aug 2023 07:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691938108; x=1692542908;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=187ilsO8HuDey2NBIRz6vfzKW5d6juB5N1HZU8xAdH0=;
        b=KqndpWeVatyQzoUq7yUXz+Dj3qBBUJ8zB85GIfMZORyV6s0kQj9sc2EUdCINwEKUtn
         jIvo6rm3YzbM1DpWXx5Go9NoKrv5hgEjZPWJZMuR+2buFsQyj7Wu6yma2zrZFFa6Oxno
         hJ7QgBdLxNYNBtvhfsUX98f0ywk9/Ap0jFiPY+6gG149nkG6I8d1xSoeZ1Mj+v8dCP3Y
         e/SHGoiOfRY7nrXrxhsMJnuKWDY89E2jIfISM9igZLjXnu9oQzw7QNXAwCsywTz2JtBi
         jOxhi5XvfajBWAGTOGnqPo1syv7ZwIog6SEbQ8MPqcBzDNUQCE2jcZb+lGmj2XObYqar
         0Q8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691938108; x=1692542908;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=187ilsO8HuDey2NBIRz6vfzKW5d6juB5N1HZU8xAdH0=;
        b=amoPAXMKePWESErVRoildKb5LlOq2omvtrsWMrQ2obFdN3cz3yePGWJX2ZVUBPKN5K
         FXLnBUPbWZ98l3ys7hQO2JG7qU8VXqOVEjZkMAZzNGZ0wG/Mzv5ULF1sACi5FgW3Bnx8
         e+zZOs3HIWUSevf08kVSgqFpsgi/oSdTUip57L1enJhmY3nhiI0rM686xYO1ou8difDp
         3a53TpfzTb7bEwGfLioYBbsMZqCZ/X6YogNRSQCR/V+Ay2GmQOmyvb4QsBSfv9tsrwr0
         9kPebDv6FWnWU329Q53H3vlS7OkUtFrbjSMU8bHCNKQVleD1hArEQZYgGv7ivzWxjTat
         fx/g==
X-Gm-Message-State: AOJu0YzyV8jExUfqtJoYwT5wJNibDN1jsSpvq9LfFMxUYb8MwesZMHKR
	F+Ct8QWpOxyti26J8/WwSsmtc1/M03U=
X-Google-Smtp-Source: AGHT+IFAbi3JCbVWWNlqjZ12qOrnWC7aa2xwJmRaI/CaTp3YRlYdLWnYw5tBAJjgAY+n8ER/KXmzGQ==
X-Received: by 2002:a05:6512:33d1:b0:4fb:7b4c:d38c with SMTP id d17-20020a05651233d100b004fb7b4cd38cmr5615923lfg.60.1691938108393;
        Sun, 13 Aug 2023 07:48:28 -0700 (PDT)
Received: from mobilestation ([109.194.233.135])
        by smtp.gmail.com with ESMTPSA id v13-20020ac2558d000000b004fdfefdf4acsm1532295lfg.39.2023.08.13.07.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 07:48:27 -0700 (PDT)
Date: Sun, 13 Aug 2023 17:48:25 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Minjie Du <duminjie@vivo.com>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	"open list:NTB DRIVER CORE" <ntb@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>, 
	opensource.kernel@vivo.com
Subject: Re: [PATCH v1] dtivers: ntb: fix parameter check in
 perf_setup_dbgfs()
Message-ID: <k7tdkycc2r4f4zjyzv3zdhufkt5lpeyyouptgf6pij4mpxi3yt@aulhd5he5ydm>
References: <20230713034728.2157-1-duminjie@vivo.com>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713034728.2157-1-duminjie@vivo.com>

On Thu, Jul 13, 2023 at 11:47:27AM +0800, Minjie Du wrote:
> Make IS_ERR() judge the debugfs_create_dir() function return
> in perf_setup_dbgfs().

The patch itself is correct for sure:
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

But as I already noted in a similar patch submitted for ntb_tool.c:
https://lore.kernel.org/ntb/5d0cd0e0-d92e-42d3-a6d9-ec9fc3229b7b@kadam.mountain/T/#m78d5823691d2f205d43aaa9e09028674d57296ab

Neither NTB perf, nor NTB tool, nor NTB pong-ping (nor likely NTB MSI
test) drivers make any sense without DebugFS because their
functionality has been developed based on the DebugFS nodes. The
better change would be to just fail the NTB devices probing in these
drivers if DebugFS is unsupported.

-Serge(y)

> 
> Signed-off-by: Minjie Du <duminjie@vivo.com>
> ---
>  drivers/ntb/test/ntb_perf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
> index 65e1e5cf1..553f1f46b 100644
> --- a/drivers/ntb/test/ntb_perf.c
> +++ b/drivers/ntb/test/ntb_perf.c
> @@ -1355,7 +1355,7 @@ static void perf_setup_dbgfs(struct perf_ctx *perf)
>  	struct pci_dev *pdev = perf->ntb->pdev;
>  
>  	perf->dbgfs_dir = debugfs_create_dir(pci_name(pdev), perf_dbgfs_topdir);
> -	if (!perf->dbgfs_dir) {
> +	if (IS_ERR(perf->dbgfs_dir)) {
>  		dev_warn(&perf->ntb->dev, "DebugFS unsupported\n");
>  		return;
>  	}
> -- 
> 2.39.0
> 
> 
