Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [204.191.154.188])
        by gmr-mx.google.com with ESMTPS id j19si199223jat.1.2022.01.21.08.25.03
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 08:25:03 -0800 (PST)
References: <20220120230247.GA40182@embeddedor>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <b2d9c1ad-9a6d-4e0c-e877-44029f4c1a7e@deltatee.com>
Date: Fri, 21 Jan 2022 09:24:59 -0700
MIME-Version: 1.0
In-Reply-To: <20220120230247.GA40182@embeddedor>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH][next] NTB/msi: Use struct_size() helper in devm_kzalloc()
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>




On 2022-01-20 4:02 p.m., Gustavo A. R. Silva wrote:
> Make use of the struct_size() helper instead of an open-coded version,
> in order to avoid any potential type mistakes or integer overflows that,
> in the worst scenario, could lead to heap overflows.
> 
> Also, address the following sparse warnings:
> drivers/ntb/msi.c:46:23: warning: using sizeof on a flexible structure
> 
> Link: https://github.com/KSPP/linux/issues/174
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks, looks good to me.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
