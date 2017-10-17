Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id e51si621215qtf.2.2017.10.17.13.57.59
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Oct 2017 13:58:00 -0700 (PDT)
References: <1508271773-17827-1-git-send-email-dmeyer@gigaio.com>
 <CAPoiz9y-6kyjF1ypt7p+7K6E-m55_Fra5hgFYy--5YXz7V2PdQ@mail.gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <03a7e0e1-6863-e1ae-122f-ec630f4209dd@deltatee.com>
Date: Tue, 17 Oct 2017 14:57:53 -0600
MIME-Version: 1.0
In-Reply-To: <CAPoiz9y-6kyjF1ypt7p+7K6E-m55_Fra5hgFYy--5YXz7V2PdQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] NTB: ntb_hw_switchtec: Fix peer BAR bug in
 switchtec_ntb_init_shared_mw
To: Jon Mason <jdmason@kudzu.us>, D Meyer <dmeyer@gigaio.com>
Cc: Kurt Schwemmer <kurt.schwemmer@microsemi.com>, stephen.bates@microsemi.com, Dave Jiang <dave.jiang@intel.com>, "Hubbe, Allen" <Allen.Hubbe@emc.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, linux-ntb@googlegroups.com, linux-kernel <linux-kernel@vger.kernel.org>
List-ID: <linux-ntb.googlegroups.com>



On 17/10/17 02:25 PM, Jon Mason wrote:
>> Signed-off-by: Doug Meyer <dmeyer@gigaio.com>

Thanks Doug! This looks good to me.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Fixes: 678784a44ae8 ("NTB: switchtec_ntb: Initialize hardware for memory 
windows")


Logan
