Return-Path: <allenbh@gmail.com>
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com. [2a00:1450:4864:20::141])
        by gmr-mx.google.com with ESMTPS id s124si211364wmf.0.2019.02.15.07.55.46
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 07:55:46 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id g2so7511868lfh.11
        for <linux-ntb@googlegroups.com>; Fri, 15 Feb 2019 07:55:46 -0800 (PST)
MIME-Version: 1.0
References: <1550222224-26475-1-git-send-email-Sanju.Mehta@amd.com>
In-Reply-To: <1550222224-26475-1-git-send-email-Sanju.Mehta@amd.com>
From: Allen Hubbe <allenbh@gmail.com>
Date: Fri, 15 Feb 2019 10:55:34 -0500
Message-ID: <CAJ80sas1Aryeo14JnTKS3NXL7wov6KPHaUrSzvNyTO=Qa=Mv2g@mail.gmail.com>
Subject: Re: [PATCH 0/4] bug fixes in ntb_hw_amd and ntb_perf
Content-Type: text/plain; charset="UTF-8"
To: "Mehta, Sanju" <Sanju.Mehta@amd.com>
Cc: "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>, "jdmason@kudzu.us" <jdmason@kudzu.us>, "dave.jiang@intel.com" <dave.jiang@intel.com>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-ID: <linux-ntb.googlegroups.com>

On Fri, Feb 15, 2019 at 4:17 AM Mehta, Sanju <Sanju.Mehta@amd.com> wrote:
>
> From: Sanjay R Mehta <sanju.mehta@amd.com>
>
> Add bug fix for ntb_perf and ntb_hw_amd
>
> Sanjay R Mehta (4):
>   NTB: ntb_perf: Increased the number of message retries to 1000
>   NTB: ntb_perf: Disable NTB link after clearing peer XLAT registers
>   NTB: ntb_perf: Clear stale values in doorbell and command SPAD
>     register
>   NTB: ntb_hw_amd: set peer limit register

This series,
Acked-by: Allen Hubbe <allenbh@gmail.com>

>
>  drivers/ntb/hw/amd/ntb_hw_amd.c |  8 ++++----
>  drivers/ntb/test/ntb_perf.c     | 14 +++++++++++---
>  2 files changed, 15 insertions(+), 7 deletions(-)
>
> --
> 2.7.4
>
