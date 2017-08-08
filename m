Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id 64si61049ith.7.2017.08.08.10.33.03
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Aug 2017 10:33:03 -0700 (PDT)
References: <20170808101047.24518-1-fancer.lancer@gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <8fb6cd0d-65e7-8c63-2dc0-8f5190f05b52@deltatee.com>
Date: Tue, 8 Aug 2017 11:32:56 -0600
MIME-Version: 1.0
In-Reply-To: <20170808101047.24518-1-fancer.lancer@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] NTB: Rename NTB messaging API methods
To: Serge Semin <fancer.lancer@gmail.com>, jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com, Shyam-sundar.S-k@amd.com, Xiangliang.Yu@amd.com, gary.hook@amd.com
Cc: Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>



On 08/08/17 04:10 AM, Serge Semin wrote:
> There is a common methods signature form used over all the NTB API
> like functions naming scheme, arguments names and order, etc.
> Recently added NTB messaging API IO callbacks were named a bit
> different so should be renamed to be in compliance with the rest
> of the API.

This could describe the actual change(s) a bit better and
justifications. What is this common method signature and why do we
actually want to make these changes?

> -static inline int ntb_msg_read(struct ntb_dev *ntb, int midx, int *pidx,
> -			       u32 *msg)
> +static inline u32 ntb_msg_read(struct ntb_dev *ntb, int *pidx, int midx)
>  {
>  	if (!ntb->ops->msg_read)
> -		return -EINVAL;
> +		return ~(u32)0;

I don't like this change at all. It makes error handling impossible to
do correctly because the msg returned could easily be zero or -1. The
way you had it originally is much better. Also, dropping the standard
kernel error codes for 0 and -1 don't seem useful.

Logan
