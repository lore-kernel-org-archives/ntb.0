Return-Path: <arndbergmann@gmail.com>
Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com. [209.85.222.193])
        by gmr-mx.google.com with ESMTPS id h203si5892931vkh.0.2019.01.18.08.02.39
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 08:02:39 -0800 (PST)
Received: by mail-qk1-f193.google.com with SMTP id w204so8337125qka.2
        for <linux-ntb@googlegroups.com>; Fri, 18 Jan 2019 08:02:39 -0800 (PST)
MIME-Version: 1.0
References: <b143b40446c1870fb8d422b364ead95d54552be9.1527264077.git.lsun@mellanox.com>
 <1541089538-175682-1-git-send-email-lsun@mellanox.com> <1541089538-175682-5-git-send-email-lsun@mellanox.com>
In-Reply-To: <1541089538-175682-5-git-send-email-lsun@mellanox.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 18 Jan 2019 17:02:21 +0100
Message-ID: <CAK8P3a2NRbEaS_EJNtBaZ3GCUtRiH2rUDRzJFjvcw2ZacZM1qw@mail.gmail.com>
Subject: Re: [PATCH v6 5/9] soc: mellanox: host: Add the common host side
 Rshim driver
Content-Type: text/plain; charset="UTF-8"
To: Liming Sun <lsun@mellanox.com>
Cc: Olof Johansson <olof@lixom.net>, David Woods <dwoods@mellanox.com>, Robin Murphy <robin.murphy@arm.com>, arm-soc <arm@kernel.org>, DTML <devicetree@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Vincent Whitchurch <vincent.whitchurch@axis.com>, linux-pci <linux-pci@vger.kernel.org>, linux-ntb@googlegroups.com, Christoph Hellwig <hch@lst.de>
List-ID: <linux-ntb.googlegroups.com>

On Thu, Nov 1, 2018 at 5:49 PM Liming Sun <lsun@mellanox.com> wrote:
>
> An external host can connect to a Mellanox BlueField SoC via an
> interface called Rshim. The Rshim driver provides boot, console,
> and networking services over this interface. This commit is
> the common driver where the other backend (transport) driver will
> use.
>
> Reviewed-by: David Woods <dwoods@mellanox.com>
> Signed-off-by: Liming Sun <lsun@mellanox.com>

Hi Liming,

I've taken a new look at your patch series for drivers/soc/ now,
thanks for your continued submissions.

This is again just a set of very high-level comments, but I think we
should resolve some of the fundamental questions first.
Incidentally, Vincent Whitchurch has recently posted another
patch series with a very similar intention, but for other hardware
and taking a different approach.

In both cases, the idea is to use virtio based drivers to provide
services from a host machine into another Linux instance running
on an embedded system behind a PCIe slot or similar. Your
Bluefield SoC patches are well written, but are intentionally
kept specific to a particular use case and tied to one piece
of hardware. In contrast, Vincent uses the existing code from
drivers/misc/mic/vop/ that is equally hardware specific, but he
extends it to be applicable to other hardware as well.

It would be good if you could look at each other's approaches
to see where we could take it from here. I think ideally we
should have a common driver framework for doing the same
thing across both of your devices and as well as others.

That would also resolve my main concern about the drivers,
which is the placement in drivers/soc/ for a set of drivers
that are unlike most drivers in that directory not mean for
running on the SoC itself in order drive unusual functionality
on the SoC, but are (at least partially) meant for running on
a host machine to communicate with that SoC over PCIe
or USB.

As an example, your network driver should really be placed
in drivers/net/, though it is unclear to me how it relates
to the existing virtio_net driver. In the case of mic/vop,
the idea is to use virtio_net on the device side, but have
vhost_net or a user space implementation on the host side,
but that is apparently not what you do here. Can you
explain why?

Another high-level question I have is on how your various
drivers relate to one another. This should normally be
explained in the 0/9 email, but I don't seem to have received
such a mail. I see that you have multiple back-end drivers
for the underlying transport, with one of them based on USB.
Have you come up with a way to use the same high-level
driver such as the network link over this USB back-end,
or is this for something else?

      Arnd
