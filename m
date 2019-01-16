Return-Path: <arndbergmann@gmail.com>
Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com. [209.85.160.195])
        by gmr-mx.google.com with ESMTPS id t16si391603pfa.3.2019.01.16.09.08.10
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 09:08:10 -0800 (PST)
Received: by mail-qt1-f195.google.com with SMTP id t13so7999629qtn.3
        for <linux-ntb@googlegroups.com>; Wed, 16 Jan 2019 09:08:10 -0800 (PST)
MIME-Version: 1.0
References: <20190116163253.23780-1-vincent.whitchurch@axis.com>
In-Reply-To: <20190116163253.23780-1-vincent.whitchurch@axis.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 16 Jan 2019 18:07:53 +0100
Message-ID: <CAK8P3a2ifu9X+SXgoDPSFMYwnKr=Yex8_tD4qRimcOQAhuEa8Q@mail.gmail.com>
Subject: Re: [PATCH 0/8] Virtio-over-PCIe on non-MIC
Content-Type: text/plain; charset="UTF-8"
To: Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc: sudeep.dutt@intel.com, ashutosh.dixit@intel.com, gregkh <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vincent Whitchurch <rabinv@axis.com>, Kishon Vijay Abraham I <kishon@ti.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-pci <linux-pci@vger.kernel.org>, linux-ntb@googlegroups.com, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

On Wed, Jan 16, 2019 at 5:33 PM Vincent Whitchurch
<vincent.whitchurch@axis.com> wrote:
>
> The Virtio-over-PCIe framework living under drivers/misc/mic/vop implements a
> generic framework to use virtio between two Linux systems, given shared memory
> and a couple of interrupts.  It does not actually require the Intel MIC
> hardware, x86-64, or even PCIe for that matter.  This patch series makes it
> buildable on more systems and adds a loopback driver to test it without special
> hardware.
>
> Note that I don't have access to Intel MIC hardware so some testing of the
> patchset (especially the patch "vop: Use consistent DMA") on that platform
> would be appreciated, to ensure that the series does not break anything there.

Hi Vincent,

First of all, I think it is a very good idea to make virtio over PCIe avaialable
more generally. Your patches also make sense here, they mostly fix
portability bugs, so no objection there.

I think we need to take a step back though and discuss what combinations
we actually do want to support. I have not actually read the whole mic/vop
driver, so I don't know if this would be a good fit as a generic interface --
it may or may not be, and any other input would be helpful.

Aside from that, I should note that we have two related subsystems
in the kernel: the PCIe endpoint subsystem maintained by Kishon and
Lorenzo, and the NTB subsystem maintained by Jon, Dave and Allen.

In order to properly support virtio over PCIe, I would hope we can come
up with a user space interface that looks the same way for configuring
virtio drivers in mic, pcie-endpoint and ntb, if at all possible. Have
you looked at those two subsystems?

        Arnd
