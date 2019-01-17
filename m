Return-Path: <arndbergmann@gmail.com>
Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com. [209.85.222.194])
        by gmr-mx.google.com with ESMTPS id r7si79897pls.0.2019.01.17.07.31.59
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 07:31:59 -0800 (PST)
Received: by mail-qk1-f194.google.com with SMTP id q1so6177597qkf.13
        for <linux-ntb@googlegroups.com>; Thu, 17 Jan 2019 07:31:59 -0800 (PST)
MIME-Version: 1.0
References: <20190116163253.23780-1-vincent.whitchurch@axis.com>
 <CAK8P3a2ifu9X+SXgoDPSFMYwnKr=Yex8_tD4qRimcOQAhuEa8Q@mail.gmail.com>
 <20190117105441.eqediwlekofp2srg@axis.com> <CAK8P3a2HtSJCLVdLcs=f0b5wv-k-6E_Z4Pt3Yp_kazUZh-Ek9A@mail.gmail.com>
 <20190117151529.GA3471@infradead.org> <20190117151920.GA20359@infradead.org>
In-Reply-To: <20190117151920.GA20359@infradead.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 17 Jan 2019 16:31:42 +0100
Message-ID: <CAK8P3a1r9ACPPuj90krYOB0yGVX3Usf86SYGxtnHpYCJ6_65hw@mail.gmail.com>
Subject: Re: [PATCH 0/8] Virtio-over-PCIe on non-MIC
Content-Type: text/plain; charset="UTF-8"
To: Christoph Hellwig <hch@infradead.org>
Cc: Vincent Whitchurch <vincent.whitchurch@axis.com>, sudeep.dutt@intel.com, ashutosh.dixit@intel.com, gregkh <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-pci <linux-pci@vger.kernel.org>, linux-ntb@googlegroups.com, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

On Thu, Jan 17, 2019 at 4:19 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Thu, Jan 17, 2019 at 07:15:29AM -0800, Christoph Hellwig wrote:
> > On Thu, Jan 17, 2019 at 01:39:27PM +0100, Arnd Bergmann wrote:
> > > Can you describe how you expect a VOP device over NTB or
> > > PCIe-endpoint would get created, configured and used?
> > > Is there always one master side that is responsible for creating
> > > virtio devices on it, with the slave side automatically attaching to
> > > them, or can either side create virtio devices? Is there any limit on
> > > the number of virtio devices or queues within a VOP device?
> >
> > For VOP device over NTB your configure your device using configfs
> > on one side, and for the other side it will just show up like any
> > other PCIe device, because it is.
>
> Sorry, I mean over the PCI-EP infratructure of course.  NTB actually
> is rather hairy and complicated.

My understanding was that with virtio, we would be able to have multiple
virtio devices on a single PCI-EP port, so you need a multi-step
configuration: You first set up the PCI-EP to instantiate a VOP device,
which is then seen on both ends of the connection. The question
is how to create a particular virtio device instance (or a set of those)
inside of it.

      Arnd
