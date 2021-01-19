Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.kernel.org (mail.kernel.org. [198.145.29.99])
        by gmr-mx.google.com with ESMTPS id s10si1538815ild.2.2021.01.19.10.38.18
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jan 2021 10:38:18 -0800 (PST)
Date: Tue, 19 Jan 2021 19:38:14 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v9 10/17] PCI: endpoint: Allow user to create
 sub-directory of 'EPF Device' directory
Message-ID: <YAcnFiExcr5o4FKa@kroah.com>
References: <20210104152909.22038-11-kishon@ti.com>
 <20210119183405.GA2496684@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210119183405.GA2496684@bjorn-Precision-5520>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Tom Joseph <tjoseph@cadence.com>, Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On Tue, Jan 19, 2021 at 12:34:05PM -0600, Bjorn Helgaas wrote:
> [cc->to Greg]
> 
> On Mon, Jan 04, 2021 at 08:59:02PM +0530, Kishon Vijay Abraham I wrote:
> > Documentation/PCI/endpoint/pci-endpoint-cfs.rst explains how a user
> > has to create a directory in-order to create a 'EPF Device' that
> > can be configured/probed by 'EPF Driver'.
> > 
> > Allow user to create a sub-directory of 'EPF Device' directory for
> > any function specific attributes that has to be exposed to the user.
> 
> Maybe add an example sysfs path in the commit log?
> 
> Seems like there's restriction on hierarchy depth in sysfs, but I
> don't remember the details.  Moved Greg to "to" in case he wants to
> comment.

This is configfs, not sysfs, so I really do not know, sorry.

greg k-h
