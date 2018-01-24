Return-Path: <jdmason@kudzu.us>
Received: from mail-qt0-x233.google.com (mail-qt0-x233.google.com. [2607:f8b0:400d:c0d::233])
        by gmr-mx.google.com with ESMTPS id h3si146848pfk.1.2018.01.23.20.18.09
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jan 2018 20:18:09 -0800 (PST)
Received: by mail-qt0-x233.google.com with SMTP id f4so7215467qtj.6
        for <linux-ntb@googlegroups.com>; Tue, 23 Jan 2018 20:18:09 -0800 (PST)
Return-Path: <jdmason@kudzu.us>
Date: Tue, 23 Jan 2018 23:18:06 -0500
From: Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH] NTB: ntb_perf: fix cast to restricted __le32
Message-ID: <20180124041805.GD20474@kudzu.us>
References: <20180119173044.8013-1-fancer.lancer@gmail.com>
 <CAK8P3a3SxeON4m8bjehjNKtX_T75udDFEEXnQ4j2KDe3vKz5vA@mail.gmail.com>
 <20180119210310.GA2284@mobilestation>
 <CAK8P3a2AUWfhg+srzt9m=oj4_jN4BDg3bWrwK3dDN1tNsGoqMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2AUWfhg+srzt9m=oj4_jN4BDg3bWrwK3dDN1tNsGoqMg@mail.gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Serge Semin <fancer.lancer@gmail.com>, Dave Jiang <dave.jiang@intel.com>, Allen.Hubbe@gmail.com, "Hook, Gary" <gary.hook@amd.com>, Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-ntb.googlegroups.com>

On Fri, Jan 19, 2018 at 10:26:37PM +0100, Arnd Bergmann wrote:
> On Fri, Jan 19, 2018 at 10:03 PM, Serge Semin <fancer.lancer@gmail.com> wrote:
> >
> > Actually the provided patch is the best solution I could come up with.
> > The thing is, that the methods can't be changed. Those functions are
> > the part of the NTB API methods used by many drivers. So basically they
> > are like pci_{read,write}_config_{byte,word,dword}() methods. We can't
> > change their prototypes only because it's suit some driver. The methods
> > give an access to the NTB device dummy u32-sized registers, nothing
> > else. So endianness is the transmitted data settings in this case.
> >
> > NTB is the technology to interconnect some two systems with possibly
> > different endianness (unlike PCI, which interconnect CPU with LE devices).
> > In this case I'd need to set some agreement up between two systems about
> > the endianness of the exchanged data like host and network types in
> > Linux networking. I've chosen the network data to be little-endian,
> > that's why I needed first to convert them from CPU to le32, then on
> > remote side convert them back from le32 to CPU.
> >
> > If you have any better suggestion how the warning can be fixed, I'd
> > be glad to stick to it.
> 
> I don't think your description matches what you actually do: The
> underlying ntb hardware drivers (amd, idt, intel, mscc) all treat the
> incoming data as CPU-endian and convert it to little-endian on
> the register side, so the framework already assumes that whatever
> you do here uses a little-endian wire-level protocol.
> 
> On a little-endian kernel/CPU, nothing is ever swapped here, neither
> in the ntb_perf front-end nor in the back-ends. On a big-endian
> kernel/CPU, they both swap, so you end up with CPU-endian
> data on the wire, so it should be impossible for a big-endian
> system to talk to a little-endian one. Have you actually tried that
> combination with the current code?

I do not believe anyone has every tried NTB on a big endien system,
let alone tried it with one side LE and the other BE.  To my
knowledge, this has only ever been used on x86 to x86.

> If my interpretation is correct, then the best solution would be to
> completely remove the cpu_to_le32/le32_to_cpu conversions
> from ntb_perf, and just define that it works like any other PCI
> device, exchanging little-endian data.

Yes, this would be the best solution.  Thank you for the insight.

Serge, when you get a chance, please make this change and resumbit.

Thanks,
Jon


> 
> There are two interesting cases to consider though:
> 
> - if someone wants to implement an NTB based protocol
>   using big-endian data on the wire, you probably want to add
>   a ntb_peer_spad_read_be()/ntb_peer_msg_write_be()
>   set of interfaces, to go along with ioread32_be()/iowrite32_be()
>   the same way that ntb_peer_spad_read()/ntb_peer_msg_write()
>   ends up doing ioread32()/iowrite32() with the implied little-endian
>   behavior.
> 
> - memcpy_toio()/memcpy_fromio() and ioread32_rep()/iowrite32_rep
>   importantly do not do any byteswap, they are meant to
>   transfer byte streams.
> 
>         Arnd
