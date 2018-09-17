Return-Path: <fomichev.ru@gmail.com>
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com. [2a00:1450:4864:20::230])
        by gmr-mx.google.com with ESMTPS id z14-v6si508224wrh.4.2018.09.17.08.16.25
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 08:16:25 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id p10-v6so13559043ljg.2
        for <linux-ntb@googlegroups.com>; Mon, 17 Sep 2018 08:16:25 -0700 (PDT)
Return-Path: <fomichev.ru@gmail.com>
Date: Mon, 17 Sep 2018 18:16:23 +0300
From: Alexander Fomichev <fomichev.ru@gmail.com>
Subject: Re: [PATCH v2 0/8] Fix breakage caused by the NTB multi-port patchset
Message-ID: <20180917151622.lnlckvkiyqqxlt4c@alfbook-pro.local>
References: <20180720180034.3964-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180720180034.3964-1-logang@deltatee.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>, Serge Semin <fancer.lancer@gmail.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Shuah Khan <shuah@kernel.org>, Doug Meyer <dmeyer@gigaio.com>, linux@yadro.com
List-ID: <linux-ntb.googlegroups.com>

On Fri, Jul 20, 2018 at 12:00:26PM -0600, Logan Gunthorpe wrote:

> To reiterate the main points on the feedback: the switchtec driver,
> in the cross link mode, will not be able to implement the port number
> function callbacks and will have to always return 0. It's a physical
> impossibility due to the symmetry. Therefore, in order fix this feature
> (which worked when merged), the clients must be changed to support not
> knowing the port number in the way they worked previously (ie. a legacy
> mode where there will only be two ports and you know there will be two
> sets of doorbells, one for each peer). The majority of this patch set
> fixes these issues.
> 
> The other point of controversy is the dma mask. I still strongly
> disagree with doing it in the driver as the code is clearly common
> to all and not at all driver specific. Moreover, I think as written,
> it is extra dangerous seeing all impleminting drivers are operating on
> the new struct device before it's initialized in ntb_register().
> Patch 2 in this series also fixes that.
> 
> [...]
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

Tested successfully on i5-based desktop PC, NTB on PM8535 chip, both
ends are on the local system.

Tested-by: Alexander Fomichev <fomichev.ru@gmail.com>

-- 
Regards,
  Alexander
