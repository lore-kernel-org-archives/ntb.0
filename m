Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [204.191.154.188])
        by gmr-mx.google.com with ESMTPS id n15si1250758uaw.1.2022.01.04.08.55.24
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 08:55:24 -0800 (PST)
References: <20211224012334.89173-1-kelvin.cao@microchip.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <91ece4bb-5ab3-4ec9-acb0-0b054d4ec435@deltatee.com>
Date: Tue, 4 Jan 2022 09:55:20 -0700
MIME-Version: 1.0
In-Reply-To: <20211224012334.89173-1-kelvin.cao@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 0/6] Switchtec NTB Fixes and Improvements
To: Kelvin Cao <kelvin.cao@microchip.com>, Kurt Schwemmer <kurt.schwemmer@microsemi.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-pci@vger.kernel.org, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
Cc: kelvincao@outlook.com, Jeremy Pallotta <jmpallotta@gmail.com>
List-ID: <linux-ntb.googlegroups.com>



On 2021-12-23 6:23 p.m., Kelvin Cao wrote:
> Hi,
> 
> Please find a bunch of patches for the Switchtec NTB driver.
> 
> Patche 1, 2 and 6 fix three minor bugs. Patch 3 works around a minor
> firmware issue. Patch 4 updates the method of getting management VEP
> instance ID based on a new firmware change. Patch 5 removes code that
> disables ID protection to avoid conflict with static Switchtec config
> settings.
> 
> This patchset is based on 5.16.0-rc5.
> 
> Thanks,
> Kelvin
> 
> Jeremy Pallotta (2):
>   ntb_hw_switchtec: Fix pff ioread to read into mmio_part_cfg_all
>   ntb_hw_switchtec: AND with the part_map for a valid tpart_vec
> 
> Kelvin Cao (3):
>   ntb_hw_switchtec: Update the way of getting VEP instance ID
>   ntb_hw_switchtec: Remove code for disabling ID protection
>   ntb_hw_switchtec: Fix a minor issue in config_req_id_table()
> 
> Wesley Sheng (1):
>   ntb_hw_switchtec: Fix bug with more than 32 partitions

I've reviewed all these patches and they look good to me.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Thanks,

Logan
