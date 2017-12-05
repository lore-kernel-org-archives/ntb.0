Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id m22si82288uab.4.2017.12.05.13.50.34
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Dec 2017 13:50:34 -0800 (PST)
References: <20171203191736.3399-1-fancer.lancer@gmail.com>
 <20171203191736.3399-5-fancer.lancer@gmail.com>
 <CAPoiz9zGoa53FEpG6yZMK_GowN9hh70xWiLOeLtczv6-P4gQ0g@mail.gmail.com>
 <20171205195335.GE1701@mobilestation>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <11050889-2014-fcbc-4314-e9bd6bbc9224@deltatee.com>
Date: Tue, 5 Dec 2017 14:50:32 -0700
MIME-Version: 1.0
In-Reply-To: <20171205195335.GE1701@mobilestation>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 04/15] NTB: ntb_pp: Add full multi-port NTB API support
To: Serge Semin <fancer.lancer@gmail.com>, Jon Mason <jdmason@kudzu.us>
Cc: Dave Jiang <dave.jiang@intel.com>, "Hubbe, Allen" <Allen.Hubbe@emc.com>, "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>, "Yu, Xiangliang" <Xiangliang.Yu@amd.com>, Gary R Hook <gary.hook@amd.com>, Sergey.Semin@t-platforms.ru, linux-ntb <linux-ntb@googlegroups.com>, linux-kernel <linux-kernel@vger.kernel.org>
List-ID: <linux-ntb.googlegroups.com>



On 05/12/17 12:53 PM, Serge Semin wrote:
> Is it really necessary to have all of this info defined in macro? We don't use
> them anywhere in the source below. I add this change here due to the last Greg
> patch, where he removed DRIVER_LICENSE from the code. He said, that the license
> check tool needs it to be directly defined in the MODULE_LICENSE. The rest of
> macro aren't used by any tool, but still there might be some utility in future
> to collect all the driver authors or descriptions. Still if you think it is
> unnecessary and it's ok to still have the macro left here, I'll get them back
> to the drivers code.

No one's arguing against the actual change, only that it does not belong 
in this patch. If you want to make the change send it as it's own patch 
with it's own justification and we can discuss it there.

Logan
