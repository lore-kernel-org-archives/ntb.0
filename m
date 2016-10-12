Return-Path: <BATV+052f65e740ecc85b2c80+4798+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org. [2001:1868:205::9])
        by gmr-mx.google.com with ESMTPS id a143si1337351pfa.2.2016.10.12.05.21.53
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Oct 2016 05:21:53 -0700 (PDT)
Date: Wed, 12 Oct 2016 05:21:44 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC PATCH 00/11] pci: support for configurable PCI endpoint
Message-ID: <20161012122144.GA2009@infradead.org>
References: <1473829927-20466-1-git-send-email-kishon@ti.com>
 <2837059.ka7z3gzjF2@wuerfel>
 <57DA5CC1.6030502@ti.com>
 <6722152.QTF992tLpW@wuerfel>
 <57E8BB69.4020804@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57E8BB69.4020804@ti.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, hch@infradead.org, Joao.Pinto@synopsys.com, mingkai.hu@nxp.com, m-karicheri2@ti.com, Pratyush Anand <pratyush.anand@gmail.com>, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Joao Pinto <jpinto@synopsys.com>, Rob Herring <robh+dt@kernel.org>, nsekhar@ti.com, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On Mon, Sep 26, 2016 at 11:38:41AM +0530, Kishon Vijay Abraham I wrote:
> > Ok, so in theory there can be other hardware (and quite likely is)
> > that supports multiple functions, and we can extend the framework
> > to support them without major obstacles, but your hardware doesn't,
> > so you kept it simple with one hardcoded function, right?
> 
> right, PCIe can have upto 8 functions. So the issues with the current framework
> has to be fixed. I don't expect major obstacles with this as of now.

I wouldn't be too worried about.  We have two kinds of functions in
PCIe: physical functions, or virtual functions using SR-IOV.

For the first one we pretty much just need the controller driver to
report them separately as there is almost no interaction between
functions.

SR-IOV support will be more interesting as the physical functions
controls creation of the associated virtual functions.  I'd like to
defer that problem until we get hold of a software programmable
controller that supports SR-IOV and has open documentation.  (That
beeing said, if someone has a pointer to such a beast send it my way!)

> > We should still find out whether it's important that you can have
> > a single PCI function with a software multi-function support of some
> > sort. We'd still be limited to six BARs in total, and would also need
> > something to identify those sub-functions, so implementing that might
> > get quite hairy.
> > 
> > Possibly this could be done at a higher level, e.g. by implementing
> > a PCI-virtio multiplexer that can host multiple virtio based devices
> > inside of a single PCI function. If we think that would be a good idea,
> > we should make sure the configfs interface is extensible enough to
> > handle that.
> 
> Okay. So here the main function (actual PCI function) *can* perform the work of
> virtio muliplexer if the platform wants to support sub-functions or it can be a
> normal PCI function. right?

I really don't think we should be worried about this multiplexer.  It's
not something real PCIe devices do (sane ones anyway, the rest is
handled by ad-hoc multiplexers), and we should avoid creating our own
magic periphals for it.

> > One use case I have in mind for this is to have a PCI function that
> > can use virtio to provide rootfs (virtio-blk or 9pfs), network
> > and console to the system that implements the PCI function (note
> > that this is the opposite direction of what almost everyone else
> > uses PCI devices for).
> 
> Do you mean the virtio should actually be in the host side? Even here the
> system that implements PCI function should have multiple functions right? (one
> for network, other for console etc..). So there should be a virtio multiplexer
> both in the host side and in the device side?

We already support virtio over phsysical PCIe buses to support intel MIC
devices.  Take a look at drivers/misc/mic/bus/vop_bus.c and
drivers/misc/mic/vop (yes, what a horrible place for that code, not my
fault)
