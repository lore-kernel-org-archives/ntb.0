Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id k67si69936vki.0.2017.12.05.11.40.34
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Dec 2017 11:40:34 -0800 (PST)
References: <20171129175530.31032-1-logang@deltatee.com>
 <20171129175530.31032-6-logang@deltatee.com>
 <CAPoiz9zaT+agL3KZEqnx7O2N38dM4QqHKLii_gzqDWXgQu1jyw@mail.gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <152d55bb-be8f-2699-f13c-cdc1d59e460e@deltatee.com>
Date: Tue, 5 Dec 2017 12:40:30 -0700
MIME-Version: 1.0
In-Reply-To: <CAPoiz9zaT+agL3KZEqnx7O2N38dM4QqHKLii_gzqDWXgQu1jyw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 5/7] ntb_hw_switchtec: Expand PFF CSR registers
To: Jon Mason <jdmason@kudzu.us>
Cc: linux-ntb <linux-ntb@googlegroups.com>, linux-kernel <linux-kernel@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>, Kelvin Cao <kelvin.cao@microsemi.com>
List-ID: <linux-ntb.googlegroups.com>



On 05/12/17 12:12 PM, Jon Mason wrote:
> It sucks that we don't already have a struct for PCI config space we
> can reuse here.  If you find the time, it would be good to add in the
> future to reduce duplicate code here and in the PCI core.  However,
> this patch is fine without it.

I agree. And believe me I looked for one. I'm not sure if it makes sense 
to add it to general code at this time when I'm the only user.

Logan
