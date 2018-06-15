Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf0-x242.google.com (mail-lf0-x242.google.com. [2a00:1450:4010:c07::242])
        by gmr-mx.google.com with ESMTPS id v25-v6si152506wmh.2.2018.06.15.12.47.10
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 12:47:11 -0700 (PDT)
Received: by mail-lf0-x242.google.com with SMTP id p23-v6so4537087lfh.11
        for <linux-ntb@googlegroups.com>; Fri, 15 Jun 2018 12:47:10 -0700 (PDT)
Return-Path: <fancer.lancer@gmail.com>
Date: Fri, 15 Jun 2018 22:47:17 +0300
From: Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH 0/8] Fix breakage caused by the NTB multi-port patchset
Message-ID: <20180615194717.GA15240@mobilestation>
References: <20180609000819.13883-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180609000819.13883-1-logang@deltatee.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Shuah Khan <shuah@kernel.org>
List-ID: <linux-ntb.googlegroups.com>

On Fri, Jun 08, 2018 at 06:08:10PM -0600, Logan Gunthorpe <logang@deltatee.com> wrote:

Good day, Logan.
Thanks for the patchset you submitted. My hopefully useful comments are
under the corresponding patches.

Regards,
-Sergey

> Hey,
> 
> Here are all the fixes required to get ntb_test on switchtec working
> again after the multi-port test patches were merged.
> 
> I'd appreciate it if future changes can be a) more careful about
> not breaking things, b) communicated more clearly so that better
> review can be done, and c) not merged until sufficient review actually
> is done.
> 
> Note, I sent the first patch in this series earlier; please disregard
> the earlier one.
> 
> Thanks,
> 
> Logan
> 
> Logan Gunthorpe (8):
>   NTB: ntb_tool: reading the link file should not end in a NULL byte
>   NTB: Setup the DMA mask globally for all drivers
>   NTB: Fix the default port and peer numbers for legacy drivers
>   NTB: ntb_pingpong: Choose doorbells based on port number
>   NTB: perf: Don't require one more memory window than number of peers
>   NTB: perf: Fix support for hardware that doesn't have port numbers
>   NTB: perf: Fix race condition when run with ntb_test
>   NTB: ntb_test: Fix bug when counting remote files
> 
>  drivers/ntb/hw/amd/ntb_hw_amd.c         |  4 ----
>  drivers/ntb/hw/idt/ntb_hw_idt.c         |  6 ------
>  drivers/ntb/hw/intel/ntb_hw_intel.c     |  4 ----
>  drivers/ntb/ntb.c                       | 22 ++++++++++++++--------
>  drivers/ntb/test/ntb_perf.c             | 22 +++++++++++++++++++---
>  drivers/ntb/test/ntb_pingpong.c         | 14 ++++++--------
>  drivers/ntb/test/ntb_tool.c             |  3 +--
>  tools/testing/selftests/ntb/ntb_test.sh |  2 +-
>  8 files changed, 41 insertions(+), 36 deletions(-)
> 
> --
> 2.11.0
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/20180609000819.13883-1-logang%40deltatee.com.
> For more options, visit https://groups.google.com/d/optout.
