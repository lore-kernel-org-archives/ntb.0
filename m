Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3348C20E8
	for <ntb@lists.linux.dev>; Fri, 14 Jul 2023 14:03:32 +0000 (UTC)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-4fa48b5dc2eso3280609e87.1
        for <ntb@lists.linux.dev>; Fri, 14 Jul 2023 07:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689343411; x=1691935411;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zyQ1wGKSe2LrCbJ8+PGAoDQN+cMjfuvHbZJDVsfUq3s=;
        b=A9TSLjm8DLMh4IJZWlhx4doiL0KL7691+0vW5RvqK5TOkPE/HPC+bzPJaBzSVyN0ph
         2T2NQdfKIZjchk5xPvQmuNkTqlInB0kEYbO7rm2tUZ+g3FhJVdLeV75QYSdwTcKcftuB
         mBK/wWZtlpgMA9Thas2wmNj77AHJLIki7ohLNQ1xTcb9KzV5PI58boJx7S8PqKuf11LK
         ZHpsTL8PgVHSJ0vMHhFQekRjR/xa73nGhFZMPEnmjjwDgwo8+UtrcWZ/fZBPpI3+g9Vw
         t0azTYqHB7TLu6C2wA+woKZbdOf2AqCd1AmbpOi5TN75EzpRZVFAtorQ2ZskHwOe7yy7
         01ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689343411; x=1691935411;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zyQ1wGKSe2LrCbJ8+PGAoDQN+cMjfuvHbZJDVsfUq3s=;
        b=EjCAHOGNlook7Z5QIkwjIM3BI2kqGkbdzrhYT9XGpyOKfheDD7KhqYRf6xLvyo3/N+
         gpa1XGkJQaV6ESbjvz8oY1w1mwsjbQoMvMhkKQXaqqbZktBkJNTKpTeCfdN3IAGOuRWr
         rLzPhAc6gcqaYO+qhYRHOy3wjaaXyRU8vyR5da4EXNBOGIUg1jYeH300V/yZwG8JDCjw
         OIe9SoRST1N6Jk0Xt1AGretNI0zXUZoKM+9Y+UC9yA7GaK1VbOBR2rCiGMPhqNqjutZU
         7f6onXXb8Ng/UgxtEXpRjTEmaec7m7/aC96OVn35oCH4gRWBlM5820+QLxTR1t6TwKP2
         GqEw==
X-Gm-Message-State: ABy/qLbXFx1bNEB9swqwsgpe1c3uEAo0JMbf7KiFPcTQtl9TCPOSTPKU
	BN9P10QkPEbfC9EO4QbFXFg=
X-Google-Smtp-Source: APBJJlHWMRotCK7ug2Ecga/I3rrVqZkCSnwzQ9itwO214u6fluik4f7pE6hByYuBuBhYHrfrDSxvYg==
X-Received: by 2002:a05:6512:3b2a:b0:4fa:9817:c1da with SMTP id f42-20020a0565123b2a00b004fa9817c1damr4573678lfv.21.1689343410723;
        Fri, 14 Jul 2023 07:03:30 -0700 (PDT)
Received: from mobilestation ([85.249.18.201])
        by smtp.gmail.com with ESMTPSA id u4-20020ac24c24000000b004fb7cd9651bsm1512901lfq.98.2023.07.14.07.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 07:03:30 -0700 (PDT)
Date: Fri, 14 Jul 2023 17:03:27 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Wang Ming <machel@vivo.com>, opensource.kernel@vivo.com, 
	kernel-janitors@vger.kernel.org, ntb@lists.linux.dev, Allen Hubbe <allenbh@gmail.com>, 
	Dan Carpenter <error27@gmail.com>, Dave Jiang <dave.jiang@intel.com>, 
	Jiasheng Jiang <jiasheng@iscas.ac.cn>, Jon Mason <jdmason@kudzu.us>, 
	LKML <linux-kernel@vger.kernel.org>, Minjie Du <duminjie@vivo.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH v3] ntb: Remove error checking for debugfs_create_dir()
Message-ID: <gkiohfwsrxclkgkrlvfu37kvbv72tahc6c4kvz34uh6hhwrunk@surqby5talzt>
References: <ag2uziaj2mbsqryo6ss25w5s3ryenshoylraejtgp46gxce6hh@qcggqjnqheb5>
 <b5139e22-cf5e-e95c-fd33-7e1b9b4d665b@web.de>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b5139e22-cf5e-e95c-fd33-7e1b9b4d665b@web.de>

On Fri, Jul 14, 2023 at 02:44:11PM +0200, Markus Elfring wrote:
> > > It is expected that most callers should _ignore_ the errors
> > > return by debugfs_create_dir() in tool_setup_dbgfs()
> …
> > The patch itself is correct for sure:
> > Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> 

> How does such information fit to the Linux development requirement
> for imperative change descriptions?
> 
> See also:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.5-rc1#n94

Well, the patch author does follow that rule in the subject. Regarding the
patch log body it is impossible to use the "imperative mood" always in the
entire text. In this case the explanation is pretty much clear and doesn't
use the patterns like "This patch", or any personal pronouns so IMO it's
fine to have the log as is.

> 
> 
> How do you think about to add the tag “Fixes” because of the deletion
> of an inappropriate error detection?

It doesn't fix any real bug. So there is no need in the tag.

-Serge(y)

> 
> Regards,
> Markus
