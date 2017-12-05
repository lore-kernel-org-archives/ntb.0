Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id d10si79884qkg.4.2017.12.05.15.39.10
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Dec 2017 15:39:11 -0800 (PST)
References: <20171203191736.3399-1-fancer.lancer@gmail.com>
 <20171205223918.28727-1-fancer.lancer@gmail.com>
 <20171205223918.28727-3-fancer.lancer@gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <2f48380b-6d38-4087-cb8c-54855ffb7bf1@deltatee.com>
Date: Tue, 5 Dec 2017 16:39:09 -0700
MIME-Version: 1.0
In-Reply-To: <20171205223918.28727-3-fancer.lancer@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 02/15] NTB: Set dma mask and dma coherent mask to NTB
 devices
To: Serge Semin <fancer.lancer@gmail.com>, jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com, Shyam-sundar.S-k@amd.com, Xiangliang.Yu@amd.com, gary.hook@amd.com
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>



On 05/12/17 03:39 PM, Serge Semin wrote:
> The dma_mask and dma_coherent_mask fields of the NTB struct device
> weren't initialized in hardware drivers. In fact it should be done
> instead of PCIe interface usage, since NTB clients are supposed to
> use NTB API and left unaware of real hardware implementation.
> In addition to that ntb_device_register() method shouldn't clear
> the passed ntb_dev structure, since it dma_mask is initialized
> by hardware drivers.

I think you still need to address my comments in the previous version. 
As best as I can see this patch does nothing.

Logan
