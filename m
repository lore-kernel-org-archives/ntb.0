Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id n74si100975ybg.3.2017.12.05.15.36.46
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Dec 2017 15:36:47 -0800 (PST)
References: <20171203191736.3399-1-fancer.lancer@gmail.com>
 <20171205223918.28727-1-fancer.lancer@gmail.com>
 <20171205223918.28727-2-fancer.lancer@gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <922d0bdc-d6ab-e3b5-e930-d24255a440f1@deltatee.com>
Date: Tue, 5 Dec 2017 16:36:44 -0700
MIME-Version: 1.0
In-Reply-To: <20171205223918.28727-2-fancer.lancer@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 01/15] NTB: Rename NTB messaging API methods
To: Serge Semin <fancer.lancer@gmail.com>, jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com, Shyam-sundar.S-k@amd.com, Xiangliang.Yu@amd.com, gary.hook@amd.com
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>



On 05/12/17 03:39 PM, Serge Semin wrote:
> There is a common methods signature form used over all the NTB API
> like functions naming scheme, arguments names and order, etc.
> Recently added NTB messaging API IO callbacks were named a bit
> different so should be renamed to be in compliance with the rest
> of the API.

I still think we should not do this so this patch gets a NAK from me.

Logan
