Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C10A7F6
	for <ntb@lists.linux.dev>; Mon, 20 Jun 2022 10:20:19 +0000 (UTC)
Received: by mail-lf1-f54.google.com with SMTP id c2so16537788lfk.0
        for <ntb@lists.linux.dev>; Mon, 20 Jun 2022 03:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fLU1dUDi/Pq+Ba4lsNjiH1qF+VglTLGjGdzZX+ydixY=;
        b=JNK3lbFsmhXhbmO0zFt3tFZ8vM7QUs+PNqmht1BeXJVio6KTW3WmMO7wj06ZAyAi6H
         7QP8ascQAqEj44ocDNKYDme57ylP3ho+VFb+uYr2VEpzaag0luJNTavy3/R+yqMdBdWm
         khI9pTX4xO5kmBe3zgxZyNQU7Y48vG4/vsjWLMfN0gRUw5S1wydheq9mL4XKc7gFKtl6
         fGP+eSQDNgmrAdsZFhqyDeBtGLZKLShEAur6BGZt8JG2OY4vlAgquCbQj2T1A1BrwQFj
         ii9e/Ht2D2R6RkGu0DrSHLDTAbR8qUFjRF3F9+ZhMjjDca3ccIsab8fUrVZIm0/HMwXP
         8nVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fLU1dUDi/Pq+Ba4lsNjiH1qF+VglTLGjGdzZX+ydixY=;
        b=IHyRsaL8ogerajemgRr0YEp8+SX0lHqT0PmVjWdpjo0GMxkj5ZnfbNmIY3wbSyDfW6
         RrXf5ATL/vtKFS+wJSgmlSj/XV/7uDKkBu8AXCJtDA3rH89ZpwIVV1BUnJCt3IUb7wE9
         Os4KaFlkk16WW4wHWFACpYzrpkMJ+HSCDa5d3yvDa19ZHspCnb085AbptTYLPqg/O54O
         +yB8XVRYFCMNBZio/RDF4OfznCf1c8mNSjEW2g/2h9n72PA8uUJGvoGX9dFUUH3SfXIj
         aR5mZhqoeIg1SS7N49FoKx9//3sSkP5dtNuPrF8kbowuBER+E3aFKB2ap4qySHxlPuMh
         GxLA==
X-Gm-Message-State: AJIora/rhorljSlYJV/aHy6njjhSZ2ep1kjGu+2GQvrXQixtpA6rqi5d
	lmeqqbz8ELUTZWrcCglVIpw=
X-Google-Smtp-Source: AGRyM1t+7e2EN1WOVaerQdDn3DV2Y5YJDLnPCrs7Dvgz//pKTxN3aWWY5SW84eyavs6v5+U7mBTPww==
X-Received: by 2002:a05:6512:3fa6:b0:47d:c87e:f8f8 with SMTP id x38-20020a0565123fa600b0047dc87ef8f8mr13185912lfa.159.1655720417392;
        Mon, 20 Jun 2022 03:20:17 -0700 (PDT)
Received: from localhost ([46.188.51.173])
        by smtp.gmail.com with ESMTPSA id q11-20020a056512210b00b0047f615b5cbfsm895443lfr.211.2022.06.20.03.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 03:20:16 -0700 (PDT)
Date: Mon, 20 Jun 2022 13:20:14 +0300
From: Alexander Fomichev <fomichev.ru@gmail.com>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Dave Jiang <dave.jiang@intel.com>, ntb@lists.linux.dev, linux@yadro.com,
	Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>,
	Guo Zhengkui <guozhengkui@vivo.com>,
	Alexander Fomichev <a.fomichev@yadro.com>
Subject: Re: [PATCH v3 0/3] ntb_perf: add new 'latency' test set
Message-ID: <20220620102014.7oiq3yh7jfvzacpm@yadro.com>
References: <20220513193704.36868-1-fomichev.ru@gmail.com>
 <60dd9f2e-57b1-7c9d-ca99-568c37fe286a@intel.com>
 <20220525085801.4r2l44vqiaqrbjk4@mobilestation>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220525085801.4r2l44vqiaqrbjk4@mobilestation>

Hi Serge,

On Wed, May 25, 2022 at 11:58:01AM +0300, Serge Semin wrote:
> 
> Ok. I'll have a look at the series on this week.
> 

I kindly remind you about the review.
Thanks.

-- 
Regards,
  Alexander
