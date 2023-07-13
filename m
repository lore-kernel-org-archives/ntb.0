Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FD6100BB
	for <ntb@lists.linux.dev>; Thu, 13 Jul 2023 10:14:31 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-3fc04692e20so4590365e9.0
        for <ntb@lists.linux.dev>; Thu, 13 Jul 2023 03:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689243270; x=1691835270;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eylTNeGotPT4mFHd6mUGuPwign2b2eJWh9cYl75CktI=;
        b=sosSZTG63jbMiMaRY3hSW2RjHaOXG1Z9zgPoqAmXLkF0ZtSSRnNESPw7n71HK1CLmJ
         J1K1jLtUl1uvMqO8z3mlnL01YNAXolTJGpxAOON7tRLkUuqw4fhJx/BNK6vQogBRac1I
         tzaB0ttSOoaS2I7S/BmTGbedNrSAGTy7P898XCs1x6IYEcjnEGnXf4HcN3+RifTMpoT2
         qq7MBZC3scGMgyrAhjQDmE7Y2s/BmitlT0pIdhepROxLE7B3by6VRLy0qhvryF8H/1he
         s3MowmaHbviXWlXuw7Hzcx4VD/GFhAeEzZFoJH5jEPJnCDfMMwJ7F79B3Ljv8P3g/rfA
         RQOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689243270; x=1691835270;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eylTNeGotPT4mFHd6mUGuPwign2b2eJWh9cYl75CktI=;
        b=lAeIb/3+6j29cpWhyZG+EmTs3wnM5YJRPZAj8ETW0XaZEjAjMiw4lBey3AaV5ose5B
         oTR+2cDA+X4YmgmX92H+sHyLmXAp4j5k1MlAjlT+p3BvHXbUbrIrqo1700v8JhZ0Zhej
         ktNCOcnSwk4HH2tTeGxMZwIXTRfA7DbQpvlmgL2qpQ6ocNqSZ+oFvhweg5GKDH2omsqW
         St2xWZMkluuMqICZf36tMz9od0oNAufZpVxkLBuXi0843jfsKn0qCUm/p1P8aIy6I0E3
         h53AbmrWVjD22RvC9DzgrK2zoJVJahoQaN7EMyJeoYb4o6ncH1x9qtmLS3r3wZnDIbbo
         xIbw==
X-Gm-Message-State: ABy/qLZMg/SJfr/Uskdyw1mL8qTxmBzolEvAiKHGMjPKzFKbdcHKqc9v
	hF6u/GxbXNI8FKP8TmlecHbXcQ==
X-Google-Smtp-Source: APBJJlESa2LU/i2J1kg4/CXlx9uNZfKYQiFGk01+9QiwxaXq6nsOX7KVcE9MNxIJvj0zp16YUysJGA==
X-Received: by 2002:a5d:500f:0:b0:314:37a:4d2 with SMTP id e15-20020a5d500f000000b00314037a04d2mr1061868wrt.60.1689243270137;
        Thu, 13 Jul 2023 03:14:30 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id a25-20020a1cf019000000b003fbb346279dsm7467745wmb.38.2023.07.13.03.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 03:14:28 -0700 (PDT)
Date: Thu, 13 Jul 2023 13:14:25 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: =?utf-8?B?546L5piOLei9r+S7tuW6leWxguaKgOacr+mDqA==?= <machel@vivo.com>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Dan Carpenter <error27@gmail.com>,
	Jiasheng Jiang <jiasheng@iscas.ac.cn>,
	"ntb@lists.linux.dev" <ntb@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"opensource.kernel" <opensource.kernel@vivo.com>
Subject: Re: =?utf-8?B?5Zue5aSNOiBbUEFUQw==?= =?utf-8?Q?H?= v3]  ntb: Remove
 error checking for debugfs_create_dir()
Message-ID: <090a0dd4-cbe4-4a9d-8074-7148d69ea72b@kadam.mountain>
References: <20230713085621.3380-1-machel@vivo.com>
 <2676117e-cbaf-4c4b-9197-91c796682859@kadam.mountain>
 <SG2PR06MB3743648B9D54AF2D6CB4229ABD37A@SG2PR06MB3743.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SG2PR06MB3743648B9D54AF2D6CB4229ABD37A@SG2PR06MB3743.apcprd06.prod.outlook.com>

On Thu, Jul 13, 2023 at 10:07:45AM +0000, 王明-软件底层技术部 wrote:
> Hi dan carpenter
> Sorry to bother you again, Is there anything wrong with my patch? Can this patch be applied?
> 

I'm not the NTB maintainer.  I don't see a reason why it can't be
applied but, please, wait for two weeks for maintainer feedback.

regards,
dan carpenter

