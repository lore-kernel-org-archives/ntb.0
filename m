Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id s125si981815pgs.1.2019.06.18.22.39.49
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Jun 2019 22:39:49 -0700 (PDT)
References: <20190619053205.GA10452@mwanda>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <2f4dea74-d78e-8b53-8dec-df8dc032759c@deltatee.com>
Date: Tue, 18 Jun 2019 23:39:44 -0600
MIME-Version: 1.0
In-Reply-To: <20190619053205.GA10452@mwanda>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] NTB: test: remove a duplicate check
To: Dan Carpenter <dan.carpenter@oracle.com>, Jon Mason <jdmason@kudzu.us>
Cc: Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

,,

On 2019-06-18 11:32 p.m., Dan Carpenter wrote:
> We already verified that the "nm->isr_ctx" allocation succeeded so there
> is no need to check again here.
> 
> Fixes: a6bed7a54165 ("NTB: Introduce NTB MSI Test Client")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Hmm, yup, not sure how that slipped through, must have been a bad rebase
or something. Thanks Dan!

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

> ---
> Hey Logan, can pick a patch prefix when you're introducing a new module?
> "[PATCH] NTB/test: Introduce NTB MSI Test Client" or whatever.

I don't quite follow you there. NTB doesn't really have a good standard
for prefixes. NTB/test might have made sense.

Logan
