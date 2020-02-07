Return-Path: <Sanju.Mehta@amd.com>
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (mail-sn1nam04on061d.outbound.protection.outlook.com. [2a01:111:f400:fe4c::61d])
        by gmr-mx.google.com with ESMTPS id x5si105926ljh.5.2020.02.07.02.59.09
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Feb 2020 02:59:09 -0800 (PST)
Subject: Re: [PATCH 00/15] AMD ntb driver fixes and improvements
References: <cover.1580914232.git.arindam.nath@amd.com>
From: Sanjay R Mehta <sanmehta@amd.com>
Message-ID: <a8e98fe8-25da-3ea7-a204-2fee07c6061a@amd.com>
Date: Fri, 7 Feb 2020 16:28:53 +0530
In-Reply-To: <cover.1580914232.git.arindam.nath@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: sanmehta@amd.com
MIME-Version: 1.0
To: Arindam Nath <arindam.nath@amd.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Jiasen Lin <linjiasen@hygon.cn>, Sanjay R Mehta <sanju.mehta@amd.com>
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>



On 2/5/2020 9:24 PM, Arindam Nath wrote:
> [CAUTION: External Email]
> 
> This patch series fixes some bugs in the existing
> AMD NTB driver, cleans-up code, and modifies the
> code to handle NTB link-up/down events. The series
> is based on Linus' tree,
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> 
> Arindam Nath (15):
>   NTB: Fix access to link status and control register
>   NTB: clear interrupt status register
>   NTB: Enable link up and down event notification
>   NTB: define a new function to get link status
>   NTB: return the side info status from amd_poll_link
>   NTB: set peer_sta within event handler itself
>   NTB: remove handling of peer_sta from amd_link_is_up
>   NTB: handle link down event correctly
>   NTB: handle link up, D0 and D3 events correctly
>   NTB: move ntb_ctrl handling to init and deinit
>   NTB: add helper functions to set and clear sideinfo
>   NTB: return link up status correctly for PRI and SEC
>   NTB: remove redundant setting of DB valid mask
>   NTB: send DB event when driver is loaded or un-loaded
>   NTB: add pci shutdown handler for AMD NTB

The patch series looks good to me. Thanks for the changes.

For all the ntb_hw_amd changes:

Reviewed-by: Sanjay R Mehta <sanju.mehta@amd.com>


> 
>  drivers/ntb/hw/amd/ntb_hw_amd.c | 290 ++++++++++++++++++++++++++------
>  drivers/ntb/hw/amd/ntb_hw_amd.h |   8 +-
>  2 files changed, 247 insertions(+), 51 deletions(-)
> 
> --
> 2.17.1
> 
