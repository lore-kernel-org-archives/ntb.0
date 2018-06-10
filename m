Return-Path: <allenbh@gmail.com>
Received: from mail-wr0-x242.google.com (mail-wr0-x242.google.com. [2a00:1450:400c:c0c::242])
        by gmr-mx.google.com with ESMTPS id e18-v6si202102wmh.1.2018.06.09.18.45.49
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Jun 2018 18:45:49 -0700 (PDT)
Received: by mail-wr0-x242.google.com with SMTP id x4-v6so8703780wro.11
        for <linux-ntb@googlegroups.com>; Sat, 09 Jun 2018 18:45:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180609000819.13883-1-logang@deltatee.com>
References: <20180609000819.13883-1-logang@deltatee.com>
From: Allen Hubbe <allenbh@gmail.com>
Date: Sat, 9 Jun 2018 21:45:48 -0400
Message-ID: <CAJ80satPXHNXbZ5OYqzDNknxp7gug4ukg19Fuksvgrm0Y4AsZg@mail.gmail.com>
Subject: Re: [PATCH 0/8] Fix breakage caused by the NTB multi-port patchset
Content-Type: text/plain; charset="UTF-8"
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Serge Semin <fancer.lancer@gmail.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Shuah Khan <shuah@kernel.org>
List-ID: <linux-ntb.googlegroups.com>

On Fri, Jun 8, 2018 at 8:08 PM, Logan Gunthorpe <logang@deltatee.com> wrote:
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

Thanks Logan.

Series:
Acked-by: Allen Hubbe <allenbh@gmail.com>

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
