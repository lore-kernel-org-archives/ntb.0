Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CCE1DDF0
	for <ntb@lists.linux.dev>; Thu, 10 Aug 2023 11:19:30 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-3fe4cdb72b9so6716735e9.0
        for <ntb@lists.linux.dev>; Thu, 10 Aug 2023 04:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691666368; x=1692271168;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rhb6zTDj18JqNMHSbw5wTCioPVDSMcp1wkC0zCALPU0=;
        b=hfDlhES/l/42IvARNd4zgfDk4slF16GgZkaBhemSh3a1mi9j1XObaU7bzJOhsvEWrU
         sh/XPGXDCY7okmMAmd+IzdBAwvhXf9RPQdiP8xnFW8jqpTV9SryR8fGaMCrn+qqLc2uN
         AEK4vQXl6hHhQHLCJrEukQDo2VQNDJkrTHyqw42ZZoMOUvxekOleHuXbiK8yNH4Rzxbc
         POsNxFHNQXyPysZA2+4xD+1WpMucdExs2X9/OAO3BsO255uDfomOTFVAcGhAUcXEYxia
         SX1/5a6a/i/PfKq0y4PcQXwcF10xzwGn19ec8/Vvbozi4pgRwg8arVMTVpbOYyhxU6dR
         3mjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691666368; x=1692271168;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rhb6zTDj18JqNMHSbw5wTCioPVDSMcp1wkC0zCALPU0=;
        b=IFr+T4hot0QenOzG+mpZ/LRBPCLDMhYyibH1v8BmQLnwgEwwOQ6tvByiPVPQQNuTf2
         yyproQl1QwSRFBgngOcxp65JskVFyVWUZjvT4BS32qDxKdKCCG7yg5aeoDviP42+tsuj
         p83oA5/2Q+Am0TRA/F84XdqbZnQplS91xMCf91pXJtwlH8yxL+o7z5VWde6xfE/hgs2e
         jlQ9MXMnAK/LccvMeOVxJFDHG5BtP9U7H9uIsUw/bjgIHv5MzdPYIfDeVPdC8/OdDQUJ
         jwFyzLXohmGLtkBuBiQpGjnMq/OjYUn5XJ1UvMHutLCq3iQcSwmvJxnr9QvupcLSmtgi
         DMFA==
X-Gm-Message-State: AOJu0YxcBvijI+9ov+9zX2l6GQoOZZikTlPZMiTwe9QwDXMxE3paGvEr
	cu4J820ZYTS6XCBBmZ+Rig8kTg==
X-Google-Smtp-Source: AGHT+IG7SyRleBXP7RFP+oa8Og+YqWmWk6QF4fEh2+vyKN4H2kjYVzEtxQlA5ZHR6vsMUNgLdB9SNw==
X-Received: by 2002:a1c:7408:0:b0:3fa:97ad:2ba5 with SMTP id p8-20020a1c7408000000b003fa97ad2ba5mr1773347wmc.31.1691666368524;
        Thu, 10 Aug 2023 04:19:28 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id p16-20020a05600c205000b003fe26bf65e7sm1823085wmg.13.2023.08.10.04.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 04:19:28 -0700 (PDT)
Date: Thu, 10 Aug 2023 14:19:25 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ruan Jinjie <ruanjinjie@huawei.com>
Cc: jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
	fancer.lancer@gmail.com, machel@vivo.com, jiasheng@iscas.ac.cn,
	ntb@lists.linux.dev
Subject: Re: [PATCH -next] NTB: ntb_tool: Switch to memdup_user_nul() helper
Message-ID: <8efeafb1-7f22-437b-8ee1-26b4a6e4ed46@kadam.mountain>
References: <20230810111402.1923113-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810111402.1923113-1-ruanjinjie@huawei.com>

On Thu, Aug 10, 2023 at 07:14:02PM +0800, Ruan Jinjie wrote:
> Use memdup_user_nul() helper instead of open-coding to simplify the code.
> 
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
> ---

LGTM.

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter

