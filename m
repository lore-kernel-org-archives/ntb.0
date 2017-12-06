Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id z1si195919pfh.0.2017.12.06.09.37.14
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Dec 2017 09:37:14 -0800 (PST)
References: <20171206141923.817850-1-arnd@arndb.de>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <6cdab766-60a2-0ef9-5495-f842acde8604@deltatee.com>
Date: Wed, 6 Dec 2017 10:37:06 -0700
MIME-Version: 1.0
In-Reply-To: <20171206141923.817850-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ntb_hw_switchtec: fix logic error
To: Arnd Bergmann <arnd@arndb.de>, Kurt Schwemmer <kurt.schwemmer@microsemi.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>
Cc: Stephen Bates <sbates@raithlin.com>, Colin Ian King <colin.king@canonical.com>, Doug Meyer <dmeyer@gigaio.com>, Kelvin Cao <kelvin.cao@microsemi.com>, linux-pci@vger.kernel.org, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

Hey,

Thanks, nice catch.

On 06/12/17 07:19 AM, Arnd Bergmann wrote:
> Newer gcc (version 7 and 8 presumably) warn about a statement mixing
> the << operator with logical and:
> 
> drivers/ntb/hw/mscc/ntb_hw_switchtec.c: In function 'switchtec_ntb_init_sndev':
> drivers/ntb/hw/mscc/ntb_hw_switchtec.c:888:24: error: '<<' in boolean context, did you mean '<' ? [-Werror=int-in-bool-context]
> 
> My interpretation here is that the author must have intended a bitmask
> rather than a comparison, so I'm changing the '&&' to '&', which makes
> a lot more sense in the context.
> 
> Fixes: 1b249475275d ("ntb_hw_switchtec: Allow using Switchtec NTB in multi-partition setups")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Logan
