Return-Path: <arndbergmann@gmail.com>
Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com. [209.85.222.193])
        by gmr-mx.google.com with ESMTPS id b25si4330784qtq.2.2019.01.17.08.34.27
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 08:34:27 -0800 (PST)
Received: by mail-qk1-f193.google.com with SMTP id w204so6367400qka.2
        for <linux-ntb@googlegroups.com>; Thu, 17 Jan 2019 08:34:27 -0800 (PST)
MIME-Version: 1.0
References: <20190116163253.23780-1-vincent.whitchurch@axis.com>
 <CAK8P3a2ifu9X+SXgoDPSFMYwnKr=Yex8_tD4qRimcOQAhuEa8Q@mail.gmail.com>
 <20190117105441.eqediwlekofp2srg@axis.com> <CAK8P3a2HtSJCLVdLcs=f0b5wv-k-6E_Z4Pt3Yp_kazUZh-Ek9A@mail.gmail.com>
 <20190117151906.odvozs6kz3uvx32y@axis.com> <CAK8P3a17cw3LrbGOf=TxyfK70CHDy-bjbYkvrsvaQ9OM8nPeFQ@mail.gmail.com>
 <20190117162601.tbmi4ounrnktzjga@axis.com>
In-Reply-To: <20190117162601.tbmi4ounrnktzjga@axis.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 17 Jan 2019 17:34:10 +0100
Message-ID: <CAK8P3a3qoxXZqrAuusw++dAU8csHDLHkPNhojjO0AF3FL3jZBg@mail.gmail.com>
Subject: Re: [PATCH 0/8] Virtio-over-PCIe on non-MIC
Content-Type: text/plain; charset="UTF-8"
To: Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc: sudeep.dutt@intel.com, ashutosh.dixit@intel.com, gregkh <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-pci <linux-pci@vger.kernel.org>, linux-ntb@googlegroups.com, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

On Thu, Jan 17, 2019 at 5:26 PM Vincent Whitchurch
<vincent.whitchurch@axis.com> wrote:
> On Thu, Jan 17, 2019 at 04:53:25PM +0100, Arnd Bergmann wrote:
> > On Thu, Jan 17, 2019 at 4:19 PM Vincent Whitchurch

> > Ok, this seems fine so far. So the vop-host-backend is a regular PCI
> > driver that implements the VOP protocol from the host side, and it
> > can talk to either a MIC, or another guest-backend written for the PCI-EP
> > framework to implement the same protocol, right?
>
> Yes, but just to clarify:  the placement of the device page and the way
> to communicate the location of the device page address and any other
> information needed by the guest-backend are hardware-specific so there
> is no generic vop-host-backend implementation which can talk to both a
> MIC and to something else.

I'm not sure I understand what is hardware specific about it. Shouldn't
it be possible to define at least a vop-host-backend that could work with
any guest-backend running on the PCI-EP framework?

This may have to be different from the interface used on MIC, but
generally speaking that is what I expect from a PCI device.

       Arnd
