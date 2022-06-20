Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF042562
	for <ntb@lists.linux.dev>; Mon, 20 Jun 2022 14:42:57 +0000 (UTC)
Received: by mail-qv1-f44.google.com with SMTP id n15so12139147qvh.12
        for <ntb@lists.linux.dev>; Mon, 20 Jun 2022 07:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BRPZJnRNYy/DD1FvBTWdfQQ5Lbdy4qCTAooGg2yZi/c=;
        b=zmSF1nwDTS711so3DzE8jlclEZmB7lvWo5SgOrY9VLRpUF2QX9OZEsQnLWrFFDSmXB
         xnE52Ywf8vRVgOt+jlhEEKK7ZPCD9688HswJIbuBgeGuRpinaBP04f0WB0bjZgVpNqjF
         YtjP7rN7M/42uf+iE5PpYaYOGdkDZnkB4qJRR4CM3TOetKR2nFUp4SZN4rIsTjcU0lgZ
         dotcu5E6FS2L37iWiM1fJHBlItrJvrJtbTkT1yR7Bt6e9D6gJckXLuGuH2auaMeJ0p2O
         /IQ6wWj/O0DTgDgqGvS95YAFqqs+xb9lV2LwMs8v3RIQ9Sq4D24yGuuPc0fr/pY9rjXI
         sJwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BRPZJnRNYy/DD1FvBTWdfQQ5Lbdy4qCTAooGg2yZi/c=;
        b=qLzn+/EfAu6hckuftTKfPwMKqa5Tn7sanzqyEtxfiRoKkb6chLfMUIOLkKLIljr0+w
         l5gqXoA68UnapDgNQ8f8ZNfjkdP0UeVcDwXCIcFRfMoowBejKa8ZwrUFBb0HYS2dpkVU
         e3X4nUqmLC7fk6c8/6676jZ2E5MhFasFBj3Tt1YkJBQ3zAJVxMyAD7wh9nxz/pk/vp64
         85/7d8al6o5LQjZh1sYdttRlVHl7TZEFFQ1ln7X10Io6PtzrP46q/Y81CW/Muo1mNkHj
         e0TdAkM7tBBaZEhqZcnH/qEyzgWCjB+DIRSsAHmCXlxyepHrLXd1OvGGbr1rHUZwY47M
         ZGlQ==
X-Gm-Message-State: AJIora/R2tHdiZivHp6wW44flT0zNFdx6UByvDJ7VqZ8zJsqlNrwHT+5
	9SGpAnNRFNIP49tnKkCWmsAozg==
X-Google-Smtp-Source: AGRyM1sQg01wmHrkj/50wfmgAsz4MFXPhaLu0VbwvLXZHrScsNIJLrNpn++0KXf71Q9pO1f6VhdOtQ==
X-Received: by 2002:a05:622a:15c4:b0:304:d9e7:786c with SMTP id d4-20020a05622a15c400b00304d9e7786cmr20289224qty.114.1655736176539;
        Mon, 20 Jun 2022 07:42:56 -0700 (PDT)
Received: from kudzu.us ([2605:a601:a608:5600::59])
        by smtp.gmail.com with ESMTPSA id u11-20020a05622a17cb00b00304bbcc1b8asm10594908qtk.28.2022.06.20.07.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 07:42:56 -0700 (PDT)
Date: Mon, 20 Jun 2022 10:42:54 -0400
From: Jon Mason <jdmason@kudzu.us>
To: Alexander Fomichev <fomichev.ru@gmail.com>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Dave Jiang <dave.jiang@intel.com>, ntb@lists.linux.dev,
	linux@yadro.com, Allen Hubbe <allenbh@gmail.com>,
	Guo Zhengkui <guozhengkui@vivo.com>,
	Alexander Fomichev <a.fomichev@yadro.com>
Subject: Re: [PATCH v3 0/3] ntb_perf: add new 'latency' test set
Message-ID: <YrCHbmrNy9obZe2t@kudzu.us>
References: <20220513193704.36868-1-fomichev.ru@gmail.com>
 <60dd9f2e-57b1-7c9d-ca99-568c37fe286a@intel.com>
 <20220525085801.4r2l44vqiaqrbjk4@mobilestation>
 <20220620102014.7oiq3yh7jfvzacpm@yadro.com>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220620102014.7oiq3yh7jfvzacpm@yadro.com>

On Mon, Jun 20, 2022 at 01:20:14PM +0300, Alexander Fomichev wrote:
> Hi Serge,
> 
> On Wed, May 25, 2022 at 11:58:01AM +0300, Serge Semin wrote:
> > 
> > Ok. I'll have a look at the series on this week.
> > 
> 
> I kindly remind you about the review.

I've pulled this into my ntb branch.  So, barring a nack by Serge,
I'll push it for v5.20.  And if I see an ack by him, I'll try to add
that in as well :)

Thanks,
Jon

> Thanks.
> 
> -- 
> Regards,
>   Alexander
