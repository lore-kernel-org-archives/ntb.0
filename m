Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AA81371
	for <ntb@lists.linux.dev>; Fri, 12 Aug 2022 14:15:10 +0000 (UTC)
Received: by mail-qk1-f178.google.com with SMTP id z7so832312qki.11
        for <ntb@lists.linux.dev>; Fri, 12 Aug 2022 07:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=gr3xJEF68aIrx2JrDgRpIsSM2UJRf9YlZlmbMyGrjVI=;
        b=5fMR8J1FQzOJMU3+wziIzIi1w2X4q439RCbF4O4LHcSX3vxuSjX2TO2NZUBDm8NN45
         JAFvOZtH3Qd7awS0hT+EceW9LpymDL1tpdnzmk9yDMFQt6SwIlaOy1kE8TB4H8ALYTF+
         6SuQNVkJ50bKCSLFtLrCSCgRBqKIa4r/l1EjlUN3yqDMz9Yp7QimmOdNc/a//o2NsRG6
         ZHRuWYlqswaPzcWMRH4q1qWezI6d9xAjHpIfBt3OR0mCUG0wVC5BLukMybjQASofAQbr
         xg1tWgBXVHC8V6GKPdExmnuBNN9dVKBUP7jw3aGgWOZDQdd/+St4yYbfDw/5ox7FPdwE
         Ob6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=gr3xJEF68aIrx2JrDgRpIsSM2UJRf9YlZlmbMyGrjVI=;
        b=QJmWDBPu1Z6eoOrHwcbw4YlKReZpAxH5luOt49DLi+DMwx6aC/XSpZjDI4oMU9IWZN
         3rm8GkmcDOxqb36Ph0XU5aC4hLUxNV19EVDLIvBB+NCPYrx8H0KlvGrlfl+oP9LFNhoy
         uXfCERGAwRIXz4L3tleOz07kchf3NGJhbi4MgtwlN3lqvZDZ+7jxdYTbwgOO8Vlo3IVe
         S705fVbz01YUB9CiqNKhizUSur7ROaWvNuVLlNeh/ysWQaP5H+OTfhWKNdKXnqTAbjIY
         N6+0Nh71lo/kefCeCQNS5o7JVQthOJTSDCSvsb75+nVYpONEuSy3/NZzk+S7RFGmR+fy
         XYAw==
X-Gm-Message-State: ACgBeo0UDbxZUrnoKfnQQq+2xr0Xm1xRj0uV8ghWt5ywcY8gRgQfP4R8
	EbsHM5eeEf/MXHg20udLrcFtbA==
X-Google-Smtp-Source: AA6agR7FZZwGrAEN4EtV30dhUAvcp9V2X7+8/6ETespdtD1NlnyBQS1+LdwSFcbbEm8Ht/g4V5RDAQ==
X-Received: by 2002:a37:9504:0:b0:6b9:1e2f:e5ca with SMTP id x4-20020a379504000000b006b91e2fe5camr2948625qkd.113.1660313708987;
        Fri, 12 Aug 2022 07:15:08 -0700 (PDT)
Received: from kudzu.us ([2605:a601:a608:5600::59])
        by smtp.gmail.com with ESMTPSA id m10-20020a05620a290a00b006b5e50057basm1862058qkp.95.2022.08.12.07.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 07:15:08 -0700 (PDT)
Date: Fri, 12 Aug 2022 10:15:06 -0400
From: Jon Mason <jdmason@kudzu.us>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>,
	Allen Hubbe <allenbh@gmail.com>, Dave Jiang <dave.jiang@intel.com>,
	ntb@lists.linux.dev, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] NTB: ntb_tool: uninitialized heap data in tool_fn_write()
Message-ID: <YvZgajV4lDVUyh3f@kudzu.us>
References: <YthJQqfMCb47jHbG@kili>
 <20220728114417.hkhnv4lkqy6uzqq3@mobilestation>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220728114417.hkhnv4lkqy6uzqq3@mobilestation>

On Thu, Jul 28, 2022 at 02:44:17PM +0300, Serge Semin wrote:
> On Wed, Jul 20, 2022 at 09:28:18PM +0300, Dan Carpenter wrote:
> > The call to:
> > 
> > 	ret = simple_write_to_buffer(buf, size, offp, ubuf, size);
> > 
> > will return success if it is able to write even one byte to "buf".
> > The value of "*offp" controls which byte.  This could result in
> > reading uninitialized data when we do the sscanf() on the next line.
> > 
> > This code is not really desigined to handle partial writes where
> > *offp is non-zero and the "buf" is preserved and re-used between writes.
> > Just ban partial writes and replace the simple_write_to_buffer() with
> > copy_from_user().
> > 
> > Fixes: 578b881ba9c4 ("NTB: Add tool test client")
> 
> Looks good. Thanks.
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> 
> -Sergey

Sorry for the extremely long delay in response.  This series is in my
ntb branch and will be in my pull request for v5.20 which should be
going out later today.

Thanks,
Jon

> 
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> >  drivers/ntb/test/ntb_tool.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c
> > index b7bf3f863d79..5ee0afa621a9 100644
> > --- a/drivers/ntb/test/ntb_tool.c
> > +++ b/drivers/ntb/test/ntb_tool.c
> > @@ -367,14 +367,16 @@ static ssize_t tool_fn_write(struct tool_ctx *tc,
> >  	u64 bits;
> >  	int n;
> >  
> > +	if (*offp)
> > +		return 0;
> > +
> >  	buf = kmalloc(size + 1, GFP_KERNEL);
> >  	if (!buf)
> >  		return -ENOMEM;
> >  
> > -	ret = simple_write_to_buffer(buf, size, offp, ubuf, size);
> > -	if (ret < 0) {
> > +	if (copy_from_user(buf, ubuf, size)) {
> >  		kfree(buf);
> > -		return ret;
> > +		return -EFAULT;
> >  	}
> >  
> >  	buf[size] = 0;
> > -- 
> > 2.35.1
> > 
> > 
