Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id k4-v6si34516ioq.5.2018.09.12.08.53.59
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 08:53:59 -0700 (PDT)
References: <DM2PR11MB0105BF7DD2EFB7F3874EB457951B0@DM2PR11MB0105.namprd11.prod.outlook.com>
 <DM2PR11MB0105A882E34348BC85F8EE79951B0@DM2PR11MB0105.namprd11.prod.outlook.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <9a810527-1e71-cc6c-410c-da78faefee7d@deltatee.com>
Date: Wed, 12 Sep 2018 09:53:43 -0600
MIME-Version: 1.0
In-Reply-To: <DM2PR11MB0105A882E34348BC85F8EE79951B0@DM2PR11MB0105.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] NTB: ntb_hw_switchtec: add pre-requisites for NTB driver
 and misc updates
To: Wesley.Sheng@microchip.com, kurt.schwemmer@microsemi.com, bhelgaas@google.com, corbet@lwn.net
Cc: linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

Thanks Wesley,

On 9/12/2018 2:55 AM, Wesley.Sheng@microchip.com wrote:
> From: Wesley Sheng <Wesley.Sheng@microchip.com>
> 
> 1.add pre-requisites for NTB driver
> 2.misc updates
>   change ntb hardware driver name to ntb_hw_switchtec
>   update the description of 2 partitions limit
>   add reference to Linux Documentation/ntb.txt
>   add use of term 'Command ID'
>   add use of term 'Command Return Value'
>   add a missing ')'

The commit message and patch title could use a bit of cleanup. It should
at least say you're updating the documentation, it reads as though you
are changing the driver.

Also, especially given the NTB tag in the patch title, you probably
should have CC'd the NTB List. (linux-ntb@googlegroups.com
<linux-ntb@googlegroups.com>)

> Signed-off-by: Kelvin Cao <kelvin.cao@microchip.com>
> Signed-off-by: Wesley Yung <Wesley.Yung@microchip.com>

Acked-by: Logan Gunthorpe <logang@deltatee.com>


Logan
