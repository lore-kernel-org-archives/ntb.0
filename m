Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35BEEA8
	for <ntb@lists.linux.dev>; Wed, 25 May 2022 08:58:06 +0000 (UTC)
Received: by mail-lj1-f181.google.com with SMTP id q1so14059767ljb.5
        for <ntb@lists.linux.dev>; Wed, 25 May 2022 01:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KQj7AtJgNaYpUrKmSfOG/MaLkEoVxOErcSY4pQJ5csk=;
        b=RALk5RoedwkXDj5j8+/dSa6QQKPGAL5GTu/XM7HDK0hf3nv0wdWsw5ABQwufiqiajb
         w9Haou2Wsf/DX5RaVuD8uqxswLL9vHXLpnlvwc7+nfBIwRfow4YohiC5mkiZgnj1UWXz
         2AvPhhvhvKuWqMb39CS/wLS49vF1POnA60Uo6RvrohTNtYCpZpw09U4/Bc5HQsvCU8IW
         OmjnO9jiMRN2GDkw0QHUF9Ao+WSfBWSnBfq8LIUX6dWp5X/Zs0YpuR/IymQGHqz1/Ki8
         zpG3KIiGBymvly4Ne4cVyy02gN9EwyMfEl5jgFmgFEu6pf1b0IeJCJkCy7omHixagTyQ
         zb9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KQj7AtJgNaYpUrKmSfOG/MaLkEoVxOErcSY4pQJ5csk=;
        b=FkgwN+rqUBcmPFJCYvU09kAFpty40QsgePOa4R139bA68KpcXuIO9L3M1DqgfA1a6x
         +de7DJz89oD+0axbil2EwzCjloZy+N1ntiyjRNpL9aTh2k2300B9s3nIKQyVwwxtbovE
         ZCDq/407JBqw+9VUbG48nQtHaUA8v5QCZkkrVrtBhGTU0drjnoUdg1dDTnZUF7PHYYvm
         4gerSadtjBrtDFscUjhem0UOUt3MgvXh46ix+o+JDvnImLS7CGrlxWHrkr83Qpb5kSA2
         spKvibOeuiRNNZGdpWWOx3hHrmMZ81l2WJASN6WFz5a/LvHb9dfOno2Wv8CdkGRPEQrm
         SpVg==
X-Gm-Message-State: AOAM531aKf7/xcJL+Wh48NRjAHbW8mXoVA/1tNtkaTXWze6Zwf6f5yav
	t3M0unKISEWZozYr8boLSP0=
X-Google-Smtp-Source: ABdhPJx6Xepue3dRzqeo54eepjGOTH0miyHt9CK5Mvmj+X/cBmZjN4kMbzn7anbyevgV4iYAK4vuYA==
X-Received: by 2002:a2e:bf01:0:b0:247:dfe7:62dc with SMTP id c1-20020a2ebf01000000b00247dfe762dcmr18781584ljr.365.1653469084586;
        Wed, 25 May 2022 01:58:04 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id x19-20020a056512131300b00478628920e1sm2030430lfu.103.2022.05.25.01.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 01:58:03 -0700 (PDT)
Date: Wed, 25 May 2022 11:58:01 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alexander Fomichev <fomichev.ru@gmail.com>, ntb@lists.linux.dev,
	linux@yadro.com, Jon Mason <jdmason@kudzu.us>,
	Allen Hubbe <allenbh@gmail.com>,
	Guo Zhengkui <guozhengkui@vivo.com>,
	Alexander Fomichev <a.fomichev@yadro.com>
Subject: Re: [PATCH v3 0/3] ntb_perf: add new 'latency' test set
Message-ID: <20220525085801.4r2l44vqiaqrbjk4@mobilestation>
References: <20220513193704.36868-1-fomichev.ru@gmail.com>
 <60dd9f2e-57b1-7c9d-ca99-568c37fe286a@intel.com>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60dd9f2e-57b1-7c9d-ca99-568c37fe286a@intel.com>

Hi Dave

On Mon, May 23, 2022 at 11:38:35AM -0700, Dave Jiang wrote:
> 
> On 5/13/2022 12:37 PM, Alexander Fomichev wrote:
> > From: Alexander Fomichev <a.fomichev@yadro.com>
> > 
> > The ntb_perf test provides a tool for NTB hardware performance
> > evaluation. For software impact elimination the test uses a simple method
> > (let's call it 'burst' mode), when the local system sends to the remote
> > system a data set and counts time interval until hardware completion
> > report, without the remote side confirming, nor data integrity check.
> > The measured metric is a 'burst' throughput bandwidth of NTB connection.
> > 
> > The patches extend ntb_perf with 3 new metrics:
> > 1) Burst latency
> > 2) Poll latency
> > 3) Doorbell latency
> > 
> > The resulting test set is fully backward compatible.
> > 
> > Alexander Fomichev (3):
> >    ntb_perf: extend with burst latency measurement
> >    ntb_perf: extend with poll latency measurement
> >    ntb_perf: extend with doorbell latency measurement
> > 
> >   drivers/ntb/test/ntb_perf.c | 826 +++++++++++++++++++++++++++++++++++-
> >   1 file changed, 810 insertions(+), 16 deletions(-)
> 

> Looks ok to me. Probably should get Serge's ack.

Ok. I'll have a look at the series on this week.

-Sergey

> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
