Return-Path: <BATV+bd442da0e4c2cc164bb2+5625+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org. [2607:7c80:54:e::133])
        by gmr-mx.google.com with ESMTPS id r7si78254pls.0.2019.01.17.07.19.25
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 07:19:25 -0800 (PST)
Date: Thu, 17 Jan 2019 07:19:20 -0800
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 0/8] Virtio-over-PCIe on non-MIC
Message-ID: <20190117151920.GA20359@infradead.org>
References: <20190116163253.23780-1-vincent.whitchurch@axis.com>
 <CAK8P3a2ifu9X+SXgoDPSFMYwnKr=Yex8_tD4qRimcOQAhuEa8Q@mail.gmail.com>
 <20190117105441.eqediwlekofp2srg@axis.com>
 <CAK8P3a2HtSJCLVdLcs=f0b5wv-k-6E_Z4Pt3Yp_kazUZh-Ek9A@mail.gmail.com>
 <20190117151529.GA3471@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117151529.GA3471@infradead.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Vincent Whitchurch <vincent.whitchurch@axis.com>, sudeep.dutt@intel.com, ashutosh.dixit@intel.com, gregkh <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-pci <linux-pci@vger.kernel.org>, linux-ntb@googlegroups.com, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

On Thu, Jan 17, 2019 at 07:15:29AM -0800, Christoph Hellwig wrote:
> On Thu, Jan 17, 2019 at 01:39:27PM +0100, Arnd Bergmann wrote:
> > Can you describe how you expect a VOP device over NTB or
> > PCIe-endpoint would get created, configured and used?
> > Is there always one master side that is responsible for creating
> > virtio devices on it, with the slave side automatically attaching to
> > them, or can either side create virtio devices? Is there any limit on
> > the number of virtio devices or queues within a VOP device?
> 
> For VOP device over NTB your configure your device using configfs
> on one side, and for the other side it will just show up like any
> other PCIe device, because it is.

Sorry, I mean over the PCI-EP infratructure of course.  NTB actually
is rather hairy and complicated.
