Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1643A56
	for <ntb@lists.linux.dev>; Mon, 18 Apr 2022 21:11:33 +0000 (UTC)
Received: by mail-lf1-f41.google.com with SMTP id x33so26144512lfu.1
        for <ntb@lists.linux.dev>; Mon, 18 Apr 2022 14:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yW/Xtlm2DEmdlcKAJWnGvn+AxAEQ2Q/PaAl/FxXatQg=;
        b=JV/CeTBTDxZdIEZG5+RJY0irjC2pJax7Y3KJMpq7gZl5CU7YUloKLzx+QCW4CfmW55
         9Oz7lZ8Att8s3JZ/bA7bXUMRScOMu4tvhUofd85ED8UuFme5d2Huk3M4Ah8wra0pkiYb
         16GPSmTusg86p1fixswzzHNZPLMqwo08ove0Lv+FLpDgZc09NP4g8kUEY/v1Cv0sUbgP
         GbN3CPFN2x5EMoWTwAVB2JnFwE5zE/Y4rwXiyryhryWK+7QjFxp5/q39lHvHthnFgixm
         QyaGaHj2QubGxAf94ssvYNyqQyPb149btYKXQEACTGS+E+0MmmGLki1p1HnSSv3Q3mX8
         HdWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yW/Xtlm2DEmdlcKAJWnGvn+AxAEQ2Q/PaAl/FxXatQg=;
        b=JEEQ6pPv3uAeX1O+JB1zbaT4mFDhLuAOgAtR2/bIiLlxuqTKmJPyomm+NgQikifp1p
         puwAwMlwepKy+Pz4Ix39ZBRq7AksJATAslt7z2dLxLRsEvV7Lat5lirQXCwWKVGPsmKa
         +4MCk7Fh7QQfrqRjI2xUd6Wi5pF97/RnMzwA/m/Mzg++f+6g6QoYHP6A2PQrvzdHMOBM
         3vDB2mDJfqTQuXcJOa5KcesIhOz+4S0OGQFI8yTpl8ff7slnlXhGwmAjDhpgwSZxdYka
         Lo7rexEIA7iwttHlowUvutNHhznxwdsgehten7l/NFxmAJWjv2J+aJBx7bm4EdJq4lwq
         NkCw==
X-Gm-Message-State: AOAM532zZYl/mEymswp5ByrMv9gC0y44yMRzH+mDkJO1vmBdw2z+z423
	HCvsdCd4KPy5qHh4a4LE9WeOlCpsO8JWnhBO5xuoX+yv
X-Google-Smtp-Source: ABdhPJwXuBbIcTDn0lCJ9h2jEXjyTyL7oT/gpzXMi3e722ZMsWgeAQypOZ2MzjKRMM+qs/5hId6dGQ==
X-Received: by 2002:ac2:491d:0:b0:46d:ce9:69b2 with SMTP id n29-20020ac2491d000000b0046d0ce969b2mr9001484lfi.40.1650316291694;
        Mon, 18 Apr 2022 14:11:31 -0700 (PDT)
Received: from localhost ([46.188.51.232])
        by smtp.gmail.com with ESMTPSA id x40-20020a056512132800b004489691436esm1319222lfu.146.2022.04.18.14.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 14:11:31 -0700 (PDT)
Date: Tue, 19 Apr 2022 00:11:13 +0300
From: Alexander Fomichev <fomichev.ru@gmail.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: ntb@lists.linux.dev, linux@yadro.com, Jon Mason <jdmason@kudzu.us>,
	Allen Hubbe <allenbh@gmail.com>,
	Yang Li <yang.lee@linux.alibaba.com>,
	Serge Semin <fancer.lancer@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ntb_perf: extend with burst/poll/doorbell latency
 measurement
Message-ID: <20220418211113.oxidrif4jtjlqr2r@yadro.com>
References: <20220417235517.26865-1-a.fomichev@yadro.com>
 <9ad57247-36df-cb3d-d50f-feb3c80f17e6@intel.com>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ad57247-36df-cb3d-d50f-feb3c80f17e6@intel.com>

On Mon, Apr 18, 2022 at 07:52:50AM -0700, Dave Jiang wrote:
> 
> I don't see any major issues with the code. However, is it possible to break
> the introduction of these 3 metrics into 3 different patches for easier
> review?
> 
Sure. I'll re-post the separate patches soon.

-- 
Regards,
  Alexander
