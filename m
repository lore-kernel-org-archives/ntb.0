Return-Path: <gregkh@linuxfoundation.org>
Received: from dfw.source.kernel.org (dfw.source.kernel.org. [139.178.84.217])
        by gmr-mx.google.com with ESMTPS id o19si2078692wme.2.2021.11.28.03.07.11
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Nov 2021 03:07:11 -0800 (PST)
Date: Sun, 28 Nov 2021 12:07:05 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [patch 31/32] genirq/msi: Simplify sysfs handling
Message-ID: <YaNi2RkiYdnoEDau@kroah.com>
References: <20211126230957.239391799@linutronix.de>
 <20211126232736.135247787@linutronix.de>
 <YaIlX8bef2jPLkUE@kroah.com>
 <87lf19fl9i.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lf19fl9i.ffs@tglx>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>, Megha Dey <megha.dey@intel.com>, Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On Sat, Nov 27, 2021 at 08:31:37PM +0100, Thomas Gleixner wrote:
> On Sat, Nov 27 2021 at 13:32, Greg Kroah-Hartman wrote:
> > On Sat, Nov 27, 2021 at 02:23:15AM +0100, Thomas Gleixner wrote:
> >> The sysfs handling for MSI is a convoluted maze and it is in the way of
> >> supporting dynamic expansion of the MSI-X vectors because it only supports
> >> a one off bulk population/free of the sysfs entries.
> >> 
> >> Change it to do:
> >> 
> >>    1) Creating an empty sysfs attribute group when msi_device_data is
> >>       allocated
> >> 
> >>    2) Populate the entries when the MSI descriptor is initialized
> >
> > How much later does this happen?  Can it happen while the device has a
> > driver bound to it?
> 
> That's not later than before. It's when the driver initializes the
> MSI[X] interrupts, which usually happens in the probe() function.
> 
> The difference is that the group, (i.e.) directory is created slightly
> earlier.

Ok, but that still happens when probe() is called for the driver, right?

> >> +
> >> +static inline int msi_sysfs_create_group(struct device *dev)
> >> +{
> >> +	return devm_device_add_group(dev, &msi_irqs_group);
> >
> > Much nicer, but you changed the lifetime rules of when these attributes
> > will be removed, is that ok?
> 
> The msi entries are removed at the same place as they are removed in the
> current mainline code, i.e. when the device driver shuts the device
> down and disables MSI[X], which happens usually during remove()
> 
> What's different now is that the empty group stays around a bit
> longer. I don't see how that matters.

How much longer does it stick around?

What happens if this sequence happens:
	- probe()
	- disconnect()
	- probe()
with the same device (i.e. the device is not removed from the system)?

Which can happen as userspace can trigger disconnect() or even worse, if
the driver is unloaded and then loaded again?  Will the second call to
create this directory fail as it is not cleaned up yet?

I can never remember if devm_*() stuff sticks around for the device
lifecycle, or for the driver/device lifecycle, which is one big reason
why I don't like that api...

> > I still worry that these attributes show up "after" the device is
> > registered with the driver core, but hey, it's no worse than it
> > currently is, so that's not caused by this patch series...
> 
> Happens that register before or after driver->probe()?

During probe is a bit too late, but we can handle that as we are used to
it.  If it happens after probe() succeeds, based on something else being
asked for in the driver (like the device being opened), then userspace
has no chance of ever noticing these attributes being added.

But again, this isn't new to your code series, so I wouldn't worry about
it.  Obviously userspace tools do not care or really notice these
attributes at all otherwise the authors of them would have complained
a long time ago :)

So again, no real objection from me here, just meta-comments, except for
the above thing with the devm_* call to ensure that the
probe/disconnect/probe sequence will still work just as well as it does
today.  Should be easy enough to test out by just unloading a module and
then loading it again with this patch series applied.

thanks,

greg k-h
