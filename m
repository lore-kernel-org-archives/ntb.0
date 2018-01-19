Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf0-x242.google.com (mail-lf0-x242.google.com. [2a00:1450:4010:c07::242])
        by gmr-mx.google.com with ESMTPS id c23si1235473lfg.0.2018.01.19.13.03.04
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jan 2018 13:03:04 -0800 (PST)
Received: by mail-lf0-x242.google.com with SMTP id o89so3603224lfg.10
        for <linux-ntb@googlegroups.com>; Fri, 19 Jan 2018 13:03:04 -0800 (PST)
Return-Path: <fancer.lancer@gmail.com>
Date: Sat, 20 Jan 2018 00:03:10 +0300
From: Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH] NTB: ntb_perf: fix cast to restricted __le32
Message-ID: <20180119210310.GA2284@mobilestation>
References: <20180119173044.8013-1-fancer.lancer@gmail.com>
 <CAK8P3a3SxeON4m8bjehjNKtX_T75udDFEEXnQ4j2KDe3vKz5vA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3SxeON4m8bjehjNKtX_T75udDFEEXnQ4j2KDe3vKz5vA@mail.gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: jdmason@kudzu.us, Dave Jiang <dave.jiang@intel.com>, Allen.Hubbe@gmail.com, "Hook, Gary" <gary.hook@amd.com>, Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-ntb.googlegroups.com>

On Fri, Jan 19, 2018 at 09:42:17PM +0100, Arnd Bergmann <arnd@arndb.de> wrote:
> On Fri, Jan 19, 2018 at 6:30 PM, Serge Semin <fancer.lancer@gmail.com> wrote:
> > Sparse is whining about the u32 and __le32 mixed usage in the
> > driver.
> >
> > drivers/ntb/test/ntb_perf.c:288:21: warning: cast to restricted __le32
> > drivers/ntb/test/ntb_perf.c:295:37: warning: incorrect type in argument 4 (different base types)
> > drivers/ntb/test/ntb_perf.c:295:37:    expected unsigned int [unsigned] [usertype] val
> > drivers/ntb/test/ntb_perf.c:295:37:    got restricted __le32 [usertype] <noident>
> > ...
> >
> > The NTB API can't be changed so ntb_spad_*() methods
> > would return either pure __le32 or __be32, since the scratchpad
> > data can have arbitrary endianness in general. In this case we
> > need to forcibly cast all the u32 to be __le32 and vise-versa
> > where it's supposed to be in accordance with the driver logic.
> >
> 
> There's got to be a better way to do this than sprinkling lots of __force
> typecasts throughout the code.
> 
> It looks like all those casts are about
> ntb_peer_spad_read()/ntb_peer_msg_write() calls, so why not change
> those function prototypes to work on __le32 types?
> 
> There should also be some form of documentation regarding why you
> need to swap the data twice, since all the ntb drivers later end up
> doing another cpu_to_le32() on the little-endian data.
> 
>        Arnd

Actually the provided patch is the best solution I could come up with.
The thing is, that the methods can't be changed. Those functions are
the part of the NTB API methods used by many drivers. So basically they
are like pci_{read,write}_config_{byte,word,dword}() methods. We can't
change their prototypes only because it's suit some driver. The methods
give an access to the NTB device dummy u32-sized registers, nothing
else. So endianness is the transmitted data settings in this case.

NTB is the technology to interconnect some two systems with possibly
different endianness (unlike PCI, which interconnect CPU with LE devices).
In this case I'd need to set some agreement up between two systems about
the endianness of the exchanged data like host and network types in
Linux networking. I've chosen the network data to be little-endian,
that's why I needed first to convert them from CPU to le32, then on
remote side convert them back from le32 to CPU.

If you have any better suggestion how the warning can be fixed, I'd
be glad to stick to it.

-Sergey

