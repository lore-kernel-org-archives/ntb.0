Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E5A27453
	for <ntb@lists.linux.dev>; Tue, 10 Oct 2023 15:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kudzu.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kudzu.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kudzu-us.20230601.gappssmtp.com header.i=@kudzu-us.20230601.gappssmtp.com header.b="fraLANI2"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-1e1e25ab32bso3975377fac.1
        for <ntb@lists.linux.dev>; Tue, 10 Oct 2023 08:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20230601.gappssmtp.com; s=20230601; t=1696952005; x=1697556805; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IGlpVdouqGa9tjwhATNKF2y55bHjxSTMENocH/RFUw0=;
        b=fraLANI2sQWUZ0/j3RnKlpF9imNUjZJN6T3R1BINDwc3Wrc14HK0f56osjmNeUcK/B
         aiHWMWJwBgTvdXzo1f/94MBeA6oK8gSoPZQi1nL7KTSo+x5O6+DltV1Zgq9IFB/CPltu
         UrCMVTiX6zDJ5BQufRd0br6Clm/8BoxSs2/zXbxiVTkjEdvsoV3NS4OjXb9qfHz+kumo
         5RFxal0V77pXkuwOeLWF8PcPQB/egq81z8QWUBimVKVDRtNzsNTByEOjiVcN9DwLlMe+
         Yssem9eNCvW4iP5CuHpMdBZ6KwbU/Kmb8YqjBC2YHGEw380vpgmUKZxojV/FRRMD1a7q
         lyLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696952005; x=1697556805;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IGlpVdouqGa9tjwhATNKF2y55bHjxSTMENocH/RFUw0=;
        b=STp733tfjHUDwn5Ayj7fDXCULWeKFcNKCMCRm3ad2V9mRKQkNXawhGP/4t6vVhnm8+
         YsV2IVYX8+nvGcblUBSHxADsHa2OSGOgtoTWaZK5vHUQE8lGHte7ge0f3HAOBnqKZ5+h
         fyMCTGYcTlo1z1uQTio2dG3JpErdBlKyx/26Qudr6ZnANXiixqxobCHQpYcD/OYFLkoH
         lQh0jmZssiujEdgQxtTOQKQ9YEdjo/Xq/d93UlcWCmwOA+PKdi8DGt9ss3/deoqO3P33
         2UBZjVwx22zJgg0/kcmLh4PEUjrDHqgZ5W++Smn8BuCpgd7owj2JLcDcKUBgMQ40k6LE
         J94w==
X-Gm-Message-State: AOJu0YwWGjWc8jTXxjXmEoW523it9G4bXf1XBxynuEn7mcVccBcLBkyj
	ST/BuVc/R0Fbuye7KS/O/j49FKqvtTQ7YcN9kAw=
X-Google-Smtp-Source: AGHT+IHaVjBX/KKQCZ+08ab9lVXi9B7/NzADTcWcYhQJpdODEVyyVsyCdZOr1780dfWB9WEehXuuBw==
X-Received: by 2002:a05:6870:ac1f:b0:1bf:50e0:95d9 with SMTP id kw31-20020a056870ac1f00b001bf50e095d9mr22193563oab.26.1696952005357;
        Tue, 10 Oct 2023 08:33:25 -0700 (PDT)
Received: from kudzu.us ([2605:a601:a684:4100:8ac9:b3ff:febf:a2f8])
        by smtp.gmail.com with ESMTPSA id w9-20020a0cb549000000b0065b14fcfca6sm4862356qvd.118.2023.10.10.08.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 08:33:24 -0700 (PDT)
Date: Tue, 10 Oct 2023 11:33:17 -0400
From: Jon Mason <jdmason@kudzu.us>
To: Max Hawking <maxahawking@sonnenkinder.org>
Cc: Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Minjie Du <duminjie@vivo.com>, ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] ntb_perf: Fix printk format
Message-ID: <ZSVuvSh0B4usJkMX@kudzu.us>
References: <2ad3273e-1212-428d-b598-e6a82c2bc570@sonnenkinder.org>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ad3273e-1212-428d-b598-e6a82c2bc570@sonnenkinder.org>

On Sun, Oct 08, 2023 at 08:45:16PM -0700, Max Hawking wrote:
> The correct printk format is %pa or %pap, but not %pa[p].
> 
> Fixes: 99a06056124d ("NTB: ntb_perf: Fix address err in perf_copy_chunk")
> Signed-off-by: Max Hawking <maxahawking@sonnenkinder.org>

Applied to my ntb branch

Thanks,
Jon

> ---
>  drivers/ntb/test/ntb_perf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
> index 553f1f46bc66..72bc1d017a46 100644
> --- a/drivers/ntb/test/ntb_perf.c
> +++ b/drivers/ntb/test/ntb_perf.c
> @@ -1227,7 +1227,7 @@ static ssize_t perf_dbgfs_read_info(struct file *filep, char __user *ubuf,
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
> 
