Return-Path: <jdmason@kudzu.us>
Received: from mail-ua0-x241.google.com (mail-ua0-x241.google.com. [2607:f8b0:400c:c08::241])
        by gmr-mx.google.com with ESMTPS id 96si58235otr.1.2017.12.05.11.55.41
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Dec 2017 11:55:41 -0800 (PST)
Received: by mail-ua0-x241.google.com with SMTP id l2so1158283uak.2
        for <linux-ntb@googlegroups.com>; Tue, 05 Dec 2017 11:55:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <152d55bb-be8f-2699-f13c-cdc1d59e460e@deltatee.com>
References: <20171129175530.31032-1-logang@deltatee.com> <20171129175530.31032-6-logang@deltatee.com>
 <CAPoiz9zaT+agL3KZEqnx7O2N38dM4QqHKLii_gzqDWXgQu1jyw@mail.gmail.com> <152d55bb-be8f-2699-f13c-cdc1d59e460e@deltatee.com>
From: Jon Mason <jdmason@kudzu.us>
Date: Tue, 5 Dec 2017 14:55:40 -0500
Message-ID: <CAPoiz9w8YAj6Soc-_H_845p2ffBSBHCUbTV+HGzwf=he2KNrWQ@mail.gmail.com>
Subject: Re: [PATCH 5/7] ntb_hw_switchtec: Expand PFF CSR registers
Content-Type: text/plain; charset="UTF-8"
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-ntb <linux-ntb@googlegroups.com>, linux-kernel <linux-kernel@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>, Kelvin Cao <kelvin.cao@microsemi.com>
List-ID: <linux-ntb.googlegroups.com>

On Tue, Dec 5, 2017 at 2:40 PM, Logan Gunthorpe <logang@deltatee.com> wrote:
>
>
> On 05/12/17 12:12 PM, Jon Mason wrote:
>>
>> It sucks that we don't already have a struct for PCI config space we
>> can reuse here.  If you find the time, it would be good to add in the
>> future to reduce duplicate code here and in the PCI core.  However,
>> this patch is fine without it.
>
>
> I agree. And believe me I looked for one. I'm not sure if it makes sense to
> add it to general code at this time when I'm the only user.

No problem.

>
> Logan
