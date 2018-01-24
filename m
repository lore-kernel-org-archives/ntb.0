Return-Path: <arndbergmann@gmail.com>
Received: from mail-oi0-x243.google.com (mail-oi0-x243.google.com. [2607:f8b0:4003:c06::243])
        by gmr-mx.google.com with ESMTPS id c12si489552qkb.3.2018.01.24.00.07.27
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jan 2018 00:07:27 -0800 (PST)
Received: by mail-oi0-x243.google.com with SMTP id t16so2257953oif.10
        for <linux-ntb@googlegroups.com>; Wed, 24 Jan 2018 00:07:27 -0800 (PST)
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <20180124074845.32125-1-fancer.lancer@gmail.com>
References: <20180119173044.8013-1-fancer.lancer@gmail.com> <20180124074845.32125-1-fancer.lancer@gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 24 Jan 2018 09:07:26 +0100
Message-ID: <CAK8P3a2vp1U1i9-b1vX_FEs-_DGvWx-ut+Z_5hk4R_CxUNiucg@mail.gmail.com>
Subject: Re: [PATCH v2] NTB: ntb_perf: fix cast to restricted __le32
Content-Type: text/plain; charset="UTF-8"
To: Serge Semin <fancer.lancer@gmail.com>
Cc: jdmason@kudzu.us, Dave Jiang <dave.jiang@intel.com>, allenbh@gmail.com, "Hook, Gary" <gary.hook@amd.com>, Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-ntb.googlegroups.com>

On Wed, Jan 24, 2018 at 8:48 AM, Serge Semin <fancer.lancer@gmail.com> wrote:
> Sparse is whining about the u32 and __le32 mixed usage in the driver
>
> drivers/ntb/test/ntb_perf.c:288:21: warning: cast to restricted __le32
> drivers/ntb/test/ntb_perf.c:295:37: warning: incorrect type in argument 4 (different base types)
> drivers/ntb/test/ntb_perf.c:295:37:    expected unsigned int [unsigned] [usertype] val
> drivers/ntb/test/ntb_perf.c:295:37:    got restricted __le32 [usertype] <noident>
> ...
>
> NTB hardware drivers shall accept CPU-endian data and translate it to
> the portable formate by internal means, so the explicit conversions
> are not necessary before Scratchpad/Messages API usage anymore.
>
> Fixes: b83003b3fdc1 ("NTB: ntb_perf: Add full multi-port NTB API support")
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

Looks good to me,

Acked-by: Arnd Bergmann <arnd@arndb.de>
