Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org. [198.145.29.99])
        by gmr-mx.google.com with ESMTPS id k19si1922516ybj.5.2021.01.19.10.35.21
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jan 2021 10:35:21 -0800 (PST)
Date: Tue, 19 Jan 2021 12:35:19 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v9 10/17] PCI: endpoint: Allow user to create
 sub-directory of 'EPF Device' directory
Message-ID: <20210119183519.GA2496938@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210119183405.GA2496684@bjorn-Precision-5520>
To: Kishon Vijay Abraham I <kishon@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Tom Joseph <tjoseph@cadence.com>, Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On Tue, Jan 19, 2021 at 12:34:07PM -0600, Bjorn Helgaas wrote:
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

Oh, I see this is for *configfs*, not for *sysfs*.  Sorry for the
noise.

> > Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> > ---
> >  drivers/pci/endpoint/pci-ep-cfs.c | 23 +++++++++++++++++++++++
> >  include/linux/pci-epf.h           |  3 +++
> >  2 files changed, 26 insertions(+)
> > 
> > diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
> > index 8f750961d6ab..f3a8b833b479 100644
> > --- a/drivers/pci/endpoint/pci-ep-cfs.c
> > +++ b/drivers/pci/endpoint/pci-ep-cfs.c
> > @@ -490,7 +490,29 @@ static struct configfs_item_operations pci_epf_ops = {
> >  	.release		= pci_epf_release,
> >  };
> >  
> > +static struct config_group *pci_epf_type_make(struct config_group *group,
> > +					      const char *name)
> > +{
> > +	struct pci_epf_group *epf_group = to_pci_epf_group(&group->cg_item);
> > +	struct config_group *epf_type_group;
> > +
> > +	epf_type_group = pci_epf_type_add_cfs(epf_group->epf, group);
> > +	return epf_type_group;
> > +}
> > +
> > +static void pci_epf_type_drop(struct config_group *group,
> > +			      struct config_item *item)
> > +{
> > +	config_item_put(item);
> > +}
> > +
> > +static struct configfs_group_operations pci_epf_type_group_ops = {
> > +	.make_group     = &pci_epf_type_make,
> > +	.drop_item      = &pci_epf_type_drop,
> > +};
> > +
> >  static const struct config_item_type pci_epf_type = {
> > +	.ct_group_ops	= &pci_epf_type_group_ops,
> >  	.ct_item_ops	= &pci_epf_ops,
> >  	.ct_attrs	= pci_epf_attrs,
> >  	.ct_owner	= THIS_MODULE,
> > @@ -553,6 +575,7 @@ static struct config_group *pci_epf_make(struct config_group *group,
> >  		goto free_name;
> >  	}
> >  
> > +	epf->group = &epf_group->group;
> >  	epf_group->epf = epf;
> >  
> >  	kfree(epf_name);
> > diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
> > index b241e7dd171f..6833e2160ef1 100644
> > --- a/include/linux/pci-epf.h
> > +++ b/include/linux/pci-epf.h
> > @@ -9,6 +9,7 @@
> >  #ifndef __LINUX_PCI_EPF_H
> >  #define __LINUX_PCI_EPF_H
> >  
> > +#include <linux/configfs.h>
> >  #include <linux/device.h>
> >  #include <linux/mod_devicetable.h>
> >  #include <linux/pci.h>
> > @@ -128,6 +129,7 @@ struct pci_epf_bar {
> >   *   EPC device
> >   * @sec_epc_bar: represents the BAR of EPF device associated with secondary EPC
> >   * @sec_epc_func_no: unique (physical) function number within the secondary EPC
> > + * @group: configfs group associated with the EPF device
> >   */
> >  struct pci_epf {
> >  	struct device		dev;
> > @@ -150,6 +152,7 @@ struct pci_epf {
> >  	struct list_head	sec_epc_list;
> >  	struct pci_epf_bar	sec_epc_bar[6];
> >  	u8			sec_epc_func_no;
> > +	struct config_group	*group;
> >  };
> >  
> >  /**
> > -- 
> > 2.17.1
> > 
