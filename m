Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id l13si322674qtj.1.2017.11.30.14.23.58
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Nov 2017 14:23:58 -0800 (PST)
References: <20170808101147.24625-1-fancer.lancer@gmail.com>
 <20171130213707.20910-1-fancer.lancer@gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <644da251-a309-14dc-02b2-cf565b3e3e17@deltatee.com>
Date: Thu, 30 Nov 2017 15:23:53 -0700
MIME-Version: 1.0
In-Reply-To: <20171130213707.20910-1-fancer.lancer@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] NTB: ntb_tool: Add full multi-port NTB API support
To: Serge Semin <fancer.lancer@gmail.com>, jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com, Shyam-sundar.S-k@amd.com, Xiangliang.Yu@amd.com
Cc: Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>



On 30/11/17 02:37 PM, Serge Semin wrote:
> Changelog v2:
> - Remove driver Author/Description/License macros

This patch is already very long and should be split up, and you added 
more to it? If you want to fix these macros it should be in it's own 
patch with it's own justification.

> -	u64 db_bits;
>   	char *buf, cmd;
> -	ssize_t rc;
> +	ssize_t ret;

I commented on this last time we saw these patches and changing the 
variable name from 'rc' to 'ret' (in a number of places) is unnecessary 
and just adds to the noise of an already gigantic patch. I'm personally 
not going to review it further until I see a cleaner easier to read 
patch or series.

Logan
