Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388BE4C8C
	for <ntb@lists.linux.dev>; Fri, 14 Jul 2023 05:57:53 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-315adee6ac8so1626594f8f.2
        for <ntb@lists.linux.dev>; Thu, 13 Jul 2023 22:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689314272; x=1691906272;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pwPQ9teSwd7Nb0FFHLc2ex+bU+I6qkcibvl/8wSBGpM=;
        b=mpRqdXBs8lf/WLyEeojTNe9gL7TaquUgfb/wvL2K/bifpt0UIXhRSzaLPzzNy33XY/
         yyAMv6o6KSpYRQEG9t9Fm+OH22gcjDUXIydlyvTrpqPQSzLXqY5KxYsPdvIZT38PqJMr
         5CgNVtPMpQ1/hzxc/9cbr0C2tTrVBoJ038wIA5Oc5STTsg1qMN8jTySe+w3wGfwVFA7z
         6oomNO5mP5ddl4X/7t+6e+kO+nELxB0PDUxl1UjjkIUHyT8/TAIjla+o/3vqFqfWPRrR
         v+iP3HI9vQihXu4ujzNHXnnFR7W/JMJZksnAOaKxRrrMqs5cszQi+0ZoyTzXchMfNUhA
         jkfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689314272; x=1691906272;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pwPQ9teSwd7Nb0FFHLc2ex+bU+I6qkcibvl/8wSBGpM=;
        b=f6nJcn9fQmcC56e7eSrqQuZBAWxsMjgVctzcA28MROyxOnCEIWZanqGh09OcB/Zezq
         SEkJwTCYT7FsmkJaG3foqWesErB85Do7/CraJ8gef0pszle0ozCIkussmnVaxRU+HPJX
         3ysDY+FyRzSRS3Iaas4aFoleKFWayagOb/gNO7r60frU0NaDPFqM97J4e+SvRAGZQ3ZW
         5RWykp3LB5ZNeO7BIJ089PEC5EKpk9XClI56g+y8oTspN/eJD45va/XDg7ixUoRqhyZ7
         gbKlrtFMszaKY8CY0JacGlZnoIJnhY0gZ3wd+asoncOYA+/6Er62+NS76mRMQLTeQwkg
         KhwA==
X-Gm-Message-State: ABy/qLZTE7tdrQXcXbxlZYwasF7kYnkz0gWwV9NTHOa7jrr+OQ2/RAUF
	6TJLU7nXDh1yUFgbBPPoK3yMog==
X-Google-Smtp-Source: APBJJlEiO62Awkmfn/b8CTowVt52CzGQlfo4zygUtugdcmsF4JuaJ1Tq6jXK3SdounlkLp1n8IkMlw==
X-Received: by 2002:a5d:680b:0:b0:316:f099:209f with SMTP id w11-20020a5d680b000000b00316f099209fmr173009wru.70.1689314272135;
        Thu, 13 Jul 2023 22:57:52 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id o18-20020a5d6712000000b003113ed02080sm9735214wru.95.2023.07.13.22.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 22:57:50 -0700 (PDT)
Date: Fri, 14 Jul 2023 08:57:46 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Wang Ming <machel@vivo.com>, opensource.kernel@vivo.com,
	kernel-janitors@vger.kernel.org, ntb@lists.linux.dev,
	Allen Hubbe <allenbh@gmail.com>, Dan Carpenter <error27@gmail.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Jiasheng Jiang <jiasheng@iscas.ac.cn>, Jon Mason <jdmason@kudzu.us>,
	Serge Semin <fancer.lancer@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>, Minjie Du <duminjie@vivo.com>
Subject: Re: [PATCH v3] ntb: Remove error checking for debugfs_create_dir()
Message-ID: <791a3c06-47cd-450a-8c4e-24fe52fdaa4e@kadam.mountain>
References: <20230713085621.3380-1-machel@vivo.com>
 <e93e7bb2-c254-06e2-87b7-1f59e52930f6@web.de>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e93e7bb2-c254-06e2-87b7-1f59e52930f6@web.de>

Markus is banned from vger so only people who are on the CC list can
see his email.  A number of maintainers have asked him to stop
commenting on patches.

regards,
dan carpenter

