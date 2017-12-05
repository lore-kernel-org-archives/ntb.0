Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id 62si80049ybf.2.2017.12.05.15.36.49
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Dec 2017 15:36:49 -0800 (PST)
References: <20171203191736.3399-1-fancer.lancer@gmail.com>
 <20171205223918.28727-1-fancer.lancer@gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <131e9052-bc88-bd41-7f6e-904e85064b25@deltatee.com>
Date: Tue, 5 Dec 2017 16:36:35 -0700
MIME-Version: 1.0
In-Reply-To: <20171205223918.28727-1-fancer.lancer@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 00/15] NTB: Add full multi-port API support to the test
 drivers
To: Serge Semin <fancer.lancer@gmail.com>, jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com, Shyam-sundar.S-k@amd.com, Xiangliang.Yu@amd.com, gary.hook@amd.com
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

Please be kind to your reviewers and list all your changes in the cover 
letter.

Also, your Sergey.Semin@t-platforms.ru email which was CC'd doesn't seem 
to work for me so I've dropped it from my responses.

Thanks,

Logan

On 05/12/17 03:39 PM, Serge Semin wrote:
> The multi-port NTB API was introduced in kernel 4.13 as well as the
> first driver for the true multi-port devices of IDT PCIe-switches
> series. But the test drivers still were left almost unchanged. Yes,
> they didn't fail being used with new NTB API, but they only worked
> with two-ports NTB devices. This patchset is intended to fix the
> issue by amending the NTB test drivers and script so they would be
> fully compatible with multi-port NTB API.
> 
> Additionally I found a few NTB subsystem issues while developing the
> submitted patches. So they are also fixed in this patchset.
> 
> Serge Semin (15):
>    NTB: Rename NTB messaging API methods
>    NTB: Set dma mask and dma coherent mask to NTB devices
>    NTB: Fix UB/bug in ntb_mw_get_align()
>    NTB: ntb_pp: Add full multi-port NTB API support
>    NTB: ntb_tool: Add full multi-port NTB API support
>    NTB: ntb_perf: Add full multi-port NTB API support
>    NTB: ntb_test: Safely use paths with whitespace
>    NTB: ntb_test: Add ntb_tool port tests
>    NTB: ntb_test: Update ntb_tool link tests
>    NTB: ntb_test: Update ntb_tool DB tests
>    NTB: ntb_test: Update ntb_tool Scratchpad tests
>    NTB: ntb_test: Add ntb_tool Message tests
>    NTB: ntb_test: Update ntb_tool MW tests
>    NTB: ntb_test: Update ntb_perf tests
>    NTB: ntb_hw_idt: Set NTB_TOPO_SWITCH topology
> 
>   drivers/ntb/hw/amd/ntb_hw_amd.c         |    4 +
>   drivers/ntb/hw/idt/ntb_hw_idt.c         |   37 +-
>   drivers/ntb/hw/intel/ntb_hw_intel.c     |    4 +
>   drivers/ntb/ntb.c                       |    1 -
>   drivers/ntb/test/ntb_perf.c             | 1825 +++++++++++++++++++++----------
>   drivers/ntb/test/ntb_pingpong.c         |  450 +++++---
>   drivers/ntb/test/ntb_tool.c             | 1823 ++++++++++++++++++++----------
>   include/linux/ntb.h                     |   36 +-
>   tools/testing/selftests/ntb/ntb_test.sh |  307 ++++--
>   9 files changed, 3022 insertions(+), 1465 deletions(-)
> 
