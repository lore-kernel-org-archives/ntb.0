Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org. [198.145.29.99])
        by gmr-mx.google.com with ESMTPS id n5-v6si1350565otk.5.2018.05.22.14.51.29
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 May 2018 14:51:29 -0700 (PDT)
Date: Tue, 22 May 2018 16:51:26 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH 2/2] NTB: PCI Quirk to Enable Switchtec NT Functionality
 with IOMMU On
Message-ID: <20180522215126.GA22385@bhelgaas-glaptop.roam.corp.google.com>
References: <1526558413-23113-1-git-send-email-dmeyer@gigaio.com>
 <1526558413-23113-3-git-send-email-dmeyer@gigaio.com>
 <20180517134521.GC19955@bhelgaas-glaptop.roam.corp.google.com>
 <9dd68ac0-5b9e-b257-49d2-20327c2ab282@deltatee.com>
 <CA+GK6en+g+T9H0sOMdVXv-_aD3rRcuzZ1JdfK0moEoTuuJnrqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+GK6en+g+T9H0sOMdVXv-_aD3rRcuzZ1JdfK0moEoTuuJnrqQ@mail.gmail.com>
To: Doug Meyer <dmeyer@gigaio.com>
Cc: Logan Gunthorpe <logang@deltatee.com>, kurt.schwemmer@microsemi.com, linux-pci@vger.kernel.org, linux-ntb <linux-ntb@googlegroups.com>, Bjorn Helgaas <bhelgaas@google.com>, Jon Mason <jdmason@kudzu.us>, "Jiang, Dave" <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-kernel@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>
List-ID: <linux-ntb.googlegroups.com>

[+cc Alex]

On Tue, May 22, 2018 at 02:09:59PM -0700, Doug Meyer wrote:
> Logan answered the questions quite thoroughly. (Thanks, Logan!)

When you repost it, please rework the commit log so it answers the
questions directly.  Otherwise the next reader may have the same
questions again.  E.g., say something about how the proxy IDs are not
programmable and are fixed in the hardware so all we have to do is
read them.

I don't think the question of when the aliases need to be added is
quite closed.  Logan said "it seems pci_add_dma_alias() must be called
before the driver is initialized and therefore in a quirk", but that
doesn't make clear *why* the alias needs to be added before the driver
is initialized.  The alias shouldn't be needed until the device does a
DMA, and it shouldn't do that until after the driver initializes.

I suspect the reason the existing quirks are in drivers/pci/quirks.c
is because the IOMMU driver is in the host OS, but the host may not
have a driver for the device if the device is passed through to a
guest OS.  In that case, the only way to add the alias is by using a
quirk that is always built into the host OS.

We could argue that the driver in the guest should be able to tell the
host's IOMMU driver about these aliases, but I doubt there's an
interface for that.

Bjorn
