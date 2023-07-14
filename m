Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE48111B4
	for <ntb@lists.linux.dev>; Fri, 14 Jul 2023 10:00:43 +0000 (UTC)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-4fb77f21c63so2929613e87.2
        for <ntb@lists.linux.dev>; Fri, 14 Jul 2023 03:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689328842; x=1691920842;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nW17uulaRP+RzVbFI1UVw6jezngQMBzbw6+rTsBgQ78=;
        b=FEaWOpZLavjysJsvR3BbULO6j53U+vn5Phun4cT01xIYLHlJSLFdtHG46xtHuNtDTJ
         1KKts5LWVtDJF2LCN79TLbCStPSYp889j5QIrQqEfcGSYx8ISkfdLNhNQObgIfuIezM6
         Fv1R5G4wNPYfGHCjGsjfkYXp+Ftv3AyE7Z+4gDHbyrTlT7z9I9JzRgSfhQk8TiyDx5Mv
         mnAOX4Ys1SBcp7EJeoaXqYu3xtVrv+OLMfTSRbtN2gM0QVndnaq0ABIQU+CEPXnxWNRs
         kITpjxPO4N625IAjMV7GZP5ngMi+eiUyW0oFqxkecMeeF14M0+Ij396odW0iAddSx8Kc
         JCdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689328842; x=1691920842;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nW17uulaRP+RzVbFI1UVw6jezngQMBzbw6+rTsBgQ78=;
        b=XZ3evHRi3Mz4lhxxU81ho5ICdIPb7PPJ0c1k43kapjhHMPRaLKKGDPprN/6zHkk3AW
         5ohuCvfhxxS+0KkcyHZJ/R3U6/zT0DNd4v+eGaqYsTeaaP3KAVgsACsZr2kN9aEYA78c
         iklTqBs/BNGLTopmkgLq3rGTfY5R+hSIdYwMQu4xx2PIxgPRlgUsnFkCZiG6FsaxmZsb
         HcmFJsB7Jgauil2gt8MMR62ChsnQG4zh5pLcZMGme/1rEsYWOuVFQQapvYYh4DLinxlS
         Ojl0aIgiNFdN76szC56lqUv6siSZG8MjSoycJgz3QmvlQAbSvY/g2QE7/IKQWAqL6j7j
         mY4A==
X-Gm-Message-State: ABy/qLY8jmMk3gswJpUFQTjLeYoscE66pfeeY4HqUI7PIe6cUC8Kpe2F
	/Kp8jBi8gD8RnsHlmnN/Ofo=
X-Google-Smtp-Source: APBJJlGGNBWhR2IdwTTuepUBlE9+94vub89vKZOU8jvUrJ/TBvUCAXO+Br8gzdikwbx88q8DtyHtEg==
X-Received: by 2002:a19:2d05:0:b0:4f8:7697:5207 with SMTP id k5-20020a192d05000000b004f876975207mr2979938lfj.23.1689328841558;
        Fri, 14 Jul 2023 03:00:41 -0700 (PDT)
Received: from mobilestation ([85.249.20.77])
        by smtp.gmail.com with ESMTPSA id g15-20020ac2538f000000b004fb881e5c23sm1424489lfh.47.2023.07.14.03.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 03:00:41 -0700 (PDT)
Date: Fri, 14 Jul 2023 13:00:38 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Wang Ming <machel@vivo.com>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, Dan Carpenter <error27@gmail.com>, 
	Jiasheng Jiang <jiasheng@iscas.ac.cn>, ntb@lists.linux.dev, linux-kernel@vger.kernel.org, 
	opensource.kernel@vivo.com, dan.carpenter@linaro.org
Subject: Re: [PATCH v3]  ntb: Remove error checking for debugfs_create_dir()
Message-ID: <ag2uziaj2mbsqryo6ss25w5s3ryenshoylraejtgp46gxce6hh@qcggqjnqheb5>
References: <20230713085621.3380-1-machel@vivo.com>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713085621.3380-1-machel@vivo.com>

On Thu, Jul 13, 2023 at 04:56:06PM +0800, Wang Ming wrote:
> It is expected that most callers should _ignore_ the errors
> return by debugfs_create_dir() in tool_setup_dbgfs()
> 
> Signed-off-by: Wang Ming <machel@vivo.com>

The patch itself is correct for sure:
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

As a side note IMO I would have converted the driver to successfully
probe an NTB device only if DebugFS is enabled and all the DebugFS-nodes
are successfully created. That's because the driver fully relies on
the DebugFS nodes to activate its functionality. Without them being
available it's absolutely useless. The way the test-driver is utilized
is demonstrated for instance in the NTB-test script:
tools/testing/selftests/ntb/ntb_test.sh .

* It concerns all the NTB test drivers...

-Serge(y)

> ---
>  drivers/ntb/test/ntb_tool.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c
> index eeeb4b1c97d2..e0acc11d29ba 100644
> --- a/drivers/ntb/test/ntb_tool.c
> +++ b/drivers/ntb/test/ntb_tool.c
> @@ -1495,8 +1495,6 @@ static void tool_setup_dbgfs(struct tool_ctx *tc)
>  
>  	tc->dbgfs_dir = debugfs_create_dir(dev_name(&tc->ntb->dev),
>  					   tool_dbgfs_topdir);
> -	if (!tc->dbgfs_dir)
> -		return;
>  
>  	debugfs_create_file("port", 0600, tc->dbgfs_dir,
>  			    tc, &tool_port_fops);
> -- 
> 2.25.1
> 
