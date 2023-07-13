Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94557100A7
	for <ntb@lists.linux.dev>; Thu, 13 Jul 2023 09:27:08 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-31297125334so273421f8f.0
        for <ntb@lists.linux.dev>; Thu, 13 Jul 2023 02:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689240426; x=1691832426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kPFy8Pts0LcMar7vgk965ZkrW+eDzYXfD6qlexHCCf4=;
        b=GjzXsO5pvr5yTnC24wSsLxq4uUHCODJvmTmNBC61pJ+VcxVO+rded2Dqz7N7GQtuHX
         /CMowCrDZYxDdNVjv1939iL0uzJlRGbIcrZQZxHhjAmfi/mt7CTOwY5CnI3e2x9uzrQv
         7FGlkCTEtYe2KdVKGXzb9zBanasR2TKajAKWqal9AFMCID9xNosS5IJ1za3fOOrR9D+0
         vyl/h9hlx9R8nCPGSq9N8BE4DZQOOHe6fNvnLVa8hf+C7IkUIgkATScrdP6uQWL37FTZ
         vf0EDOGUIZ75T0AKn98LYQJRXDu3PxyA38Jh/ELD0REyhYenvGUJqReXWYVT6SrIq54T
         qLcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689240426; x=1691832426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kPFy8Pts0LcMar7vgk965ZkrW+eDzYXfD6qlexHCCf4=;
        b=Y5me1reOML8c6OIjGMUoPZbzOpqFdjHbSlAz+nLgGD8uvDDfppLLOGjKF2eCAvcOCg
         uYOypJo2cpQR/pOBd1Ws4OmMEyN0rzKDHANeS3ao2AX3p8V3Dxt/V4FaJdmZLw9Gpbgj
         rMJFTJcK+PCoTRwxS9mbnfaZypQOwEoOmSKTehtJgPXidnjXXgjeTJF/tjXoXN/vmeG+
         nIcZuwthboqrmmMmyMfclXwaqcpsvqC4IgkK12loevRi6XAaRc4VfF/VyVeBgbpRA8e+
         drKgXmlpFJ0k4VFX/UlLB8PX6Wz+pDQkv9e/oe6pf/ta76jE6HZPIKMz2k3J79sHuaEn
         H6Ig==
X-Gm-Message-State: ABy/qLYfTD7AloBjsdAh5c71WuZwyb4a+zXK0frefX1qHI0xk6EVcDDD
	FrBlc+0GZaHaFz9K3NHAUiE0Hg==
X-Google-Smtp-Source: APBJJlEYX4xUqsyCGASg6QHn74arKnVrzbqutPqoE+n1RDM76O8R2nfw2NapSkpg3xu7aIhhsaWFdw==
X-Received: by 2002:a5d:618f:0:b0:30f:c050:88dd with SMTP id j15-20020a5d618f000000b0030fc05088ddmr3716529wru.8.1689240426604;
        Thu, 13 Jul 2023 02:27:06 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id s19-20020a1cf213000000b003fc080acf68sm13920059wmc.34.2023.07.13.02.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 02:27:04 -0700 (PDT)
Date: Thu, 13 Jul 2023 12:27:00 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Wang Ming <machel@vivo.com>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Dan Carpenter <error27@gmail.com>,
	Jiasheng Jiang <jiasheng@iscas.ac.cn>, ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH v3]  ntb: Remove error checking for debugfs_create_dir()
Message-ID: <2676117e-cbaf-4c4b-9197-91c796682859@kadam.mountain>
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

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter

