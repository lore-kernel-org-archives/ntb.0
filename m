Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECE21365
	for <ntb@lists.linux.dev>; Fri, 29 Apr 2022 15:00:58 +0000 (UTC)
Received: by mail-lf1-f53.google.com with SMTP id p10so14508903lfa.12
        for <ntb@lists.linux.dev>; Fri, 29 Apr 2022 08:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rLXhvvF1lM3adi8shdKyRUj3oscYDBTIKe9bXb6LvjM=;
        b=aY+fRtX8fMJ6Nk9NJrP5sRiNDWZjwA7Fe/LeziGdKxKdfgZXf/QMblCR4Q8MuO5RYO
         ri8gQDG6OYKHnalBhfEmRE9cN/X/ydWHncpq0lqdRLPb8a0zB9Qgl8pj6MjLvjRi/3la
         lzNur+dAqXFDOQO4JhFvvKI91pp0ZK3Fegeaet+lYErMAmNdkD9myDb7DX7TKSVMMxXr
         7BifVlH5FjdnWYZLzdAruNVOb26N6CmgRFVM24x70cn0Mcfj3lv8nxbdB798EaIGrU66
         Gl7az2Or/20aEPKSmWDiVg0ciRknDRqkH6dTj8f/CS7j+na6Lq3+d+fPwp/y5/6rV8OT
         nZKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rLXhvvF1lM3adi8shdKyRUj3oscYDBTIKe9bXb6LvjM=;
        b=BNlBjhzeJdwdJL93/KUtF3LJzHoLbzKsvhpCC6HnZLto9WIuKa1J1PxN66eEr81xIv
         g3rOQQ03UCpeOkwBNQ+9DjlhhOYe5m/+YGRkSNKjifwMD16FjKGdZLFd5UtwvtAXOuWO
         kadzUPBN/lc/vN+Upsqr5y9x27PezV4VrwVOklj+IvpTgMECE3Um8p8OuxFaf10ji0XF
         hFH8TKQoTAMkgFcjAyYG+LXHvidQptmxmDvUN0gCvQLBD/AwLAdpvshfDCDzKUduj2xi
         QuhagnmeaeQOarz72zg30+W/lYPQOH3Pzk0SSFkjE98cWw3rgnzsS8xLTupiiZvt2WDJ
         RaHQ==
X-Gm-Message-State: AOAM533oMatf/OsvzvwsyRyGRFvH5Kbu6EjtnMVaBVbhpQvKOZtSoxVR
	jbno8AVUSedKONC/O90YAoU=
X-Google-Smtp-Source: ABdhPJyI2HLhp8AQSUJExzZejH5yMNcX9NZxJphGD4dn4/1dyRO0034Azuo/RbGdosTMpO2Ln9hntw==
X-Received: by 2002:a19:4f10:0:b0:471:fb4e:bf28 with SMTP id d16-20020a194f10000000b00471fb4ebf28mr22194272lfb.274.1651244455914;
        Fri, 29 Apr 2022 08:00:55 -0700 (PDT)
Received: from localhost ([62.217.189.101])
        by smtp.gmail.com with ESMTPSA id bd25-20020a05651c169900b0024f3d1daea9sm295491ljb.49.2022.04.29.08.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 08:00:55 -0700 (PDT)
Date: Fri, 29 Apr 2022 18:00:54 +0300
From: Alexander Fomichev <fomichev.ru@gmail.com>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: ntb@lists.linux.dev, linux@yadro.com, Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
	Guo Zhengkui <guozhengkui@vivo.com>,
	Alexander Fomichev <a.fomichev@yadro.com>
Subject: Re: [PATCH v2 1/3] ntb_perf: extend with burst latency measurement
Message-ID: <20220429150054.lz74golqnphli5jq@yadro.com>
References: <20220422113703.48820-1-fomichev.ru@gmail.com>
 <20220428112721.r2l44c5yeylmgksr@mobilestation.baikal.int>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220428112721.r2l44c5yeylmgksr@mobilestation.baikal.int>

Hi Sergey,

On Thu, Apr 28, 2022 at 02:27:58PM +0300, Serge Semin wrote:
> 
> > -	if (!use_dma) {
> > +	if (!use_dma_) {
> 
> The postfixed underscore is less distinctive from the postfix-less
> name than the prefixed one. Anyway seeing the dma-less code is just a
> small subset of the generic perf copy method I'd suggest to just split
> the method up into two: perf_dma_copy_chunk() and
> perf_mem_copy_chunk(). It will be more readable to call one of them
> depending on the code context or on the global 'use_dma' flag state.
> 
Then why should we have 2 similar functions with only couple of lines
difference? I think re-using code is always preferable unless it makes
the code unclear.
Prefixed underscore is OK. Maybe it's better to rename the local
variable at all.

> 
> > +	pthr->tries = 0;
> 
> I don't see you functionally using the 'tries' field anywhere but in
> this method. What about defining it locally? (See my next comments for
> more about the 'tries' field.)
> 
> 
> > +	if (pthr->tries < LAT_MIN_TRIES) {
> 
> Hm, why 20 is enough? If you think that at least 20 re-tries must be
> performed, then why would you need the lat_time_ms parameter at all?
> I'd suggest to either define a lat_tries_cnt parameter instead or drop
> that parameter and use a fixed number of retries (20, 30, whatever you
> think would be enough to get a more-or-less precise mean latency).
> 
> 
> > +		pos += scnprintf(buf + pos, buf_size - pos,
> > +			"%d: made %llu tries\n",
> > +			tidx, pthr->tries);
> 
> AFAIU from the patch log the main goal of this patch is to add the IO
> latency measurement functionality. Why would you need to print the
> number of reties then? I don't find it much informative especially
> seeing you are already printing the available mean latency. I'd rather
> drop the 'latency_tries' entry.
> 
These all were made on purpose. The main usages for the NTB performance
measurement are to evaluate new hardware and to tune its settings. In
the real world 1 iteration can last from tens ns to hundreds ms. It's a
huge difference. And while in my opinion the best measurement results
are gained through 1000 iterations, it may turn the test system
irresponsible for several minutes in the worst case. And contrary, too
low value being hardcoded would produce quite inaccurate results in the
best case.
Therefore it's better to use a parameter, which is predictable for a
user. So LAT_MIN_TRIES macro is defined to protect the test accuracy from
too low 'lat_time_ms' value. And also sysfs entry for 'tries' variable helps
to evaluate accuracy.

-- 
Regards,
  Alexander
