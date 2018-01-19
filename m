Return-Path: <arndbergmann@gmail.com>
Received: from mail-oi0-x244.google.com (mail-oi0-x244.google.com. [2607:f8b0:4003:c06::244])
        by gmr-mx.google.com with ESMTPS id u194si725064ywu.2.2018.01.19.12.42.18
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jan 2018 12:42:18 -0800 (PST)
Received: by mail-oi0-x244.google.com with SMTP id t16so1984394oif.10
        for <linux-ntb@googlegroups.com>; Fri, 19 Jan 2018 12:42:18 -0800 (PST)
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <20180119173044.8013-1-fancer.lancer@gmail.com>
References: <20180119173044.8013-1-fancer.lancer@gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 19 Jan 2018 21:42:17 +0100
Message-ID: <CAK8P3a3SxeON4m8bjehjNKtX_T75udDFEEXnQ4j2KDe3vKz5vA@mail.gmail.com>
Subject: Re: [PATCH] NTB: ntb_perf: fix cast to restricted __le32
Content-Type: text/plain; charset="UTF-8"
To: Serge Semin <fancer.lancer@gmail.com>
Cc: jdmason@kudzu.us, Dave Jiang <dave.jiang@intel.com>, Allen.Hubbe@gmail.com, "Hook, Gary" <gary.hook@amd.com>, Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-ntb.googlegroups.com>

On Fri, Jan 19, 2018 at 6:30 PM, Serge Semin <fancer.lancer@gmail.com> wrote:
> Sparse is whining about the u32 and __le32 mixed usage in the
> driver.
>
> drivers/ntb/test/ntb_perf.c:288:21: warning: cast to restricted __le32
> drivers/ntb/test/ntb_perf.c:295:37: warning: incorrect type in argument 4 (different base types)
> drivers/ntb/test/ntb_perf.c:295:37:    expected unsigned int [unsigned] [usertype] val
> drivers/ntb/test/ntb_perf.c:295:37:    got restricted __le32 [usertype] <noident>
> ...
>
> The NTB API can't be changed so ntb_spad_*() methods
> would return either pure __le32 or __be32, since the scratchpad
> data can have arbitrary endianness in general. In this case we
> need to forcibly cast all the u32 to be __le32 and vise-versa
> where it's supposed to be in accordance with the driver logic.
>

There's got to be a better way to do this than sprinkling lots of __force
typecasts throughout the code.

It looks like all those casts are about
ntb_peer_spad_read()/ntb_peer_msg_write() calls, so why not change
those function prototypes to work on __le32 types?

There should also be some form of documentation regarding why you
need to swap the data twice, since all the ntb drivers later end up
doing another cpu_to_le32() on the little-endian data.

       Arnd
