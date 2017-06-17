Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org. [140.211.169.12])
        by gmr-mx.google.com with ESMTPS id 140si1218990wmr.2.2017.06.16.22.14.34
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Jun 2017 22:14:34 -0700 (PDT)
Date: Sat, 17 Jun 2017 07:14:29 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH 04/13] switchtec: add link event notifier block
Message-ID: <20170617051429.GF6040@kroah.com>
References: <20170615203729.9009-1-logang@deltatee.com>
 <20170615203729.9009-5-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170615203729.9009-5-logang@deltatee.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-ntb@googlegroups.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>, Bjorn Helgaas <bhelgaas@google.com>, Kurt Schwemmer <kurt.schwemmer@microsemi.com>, Stephen Bates <sbates@raithlin.com>
List-ID: <linux-ntb.googlegroups.com>

On Thu, Jun 15, 2017 at 02:37:20PM -0600, Logan Gunthorpe wrote:
> In order for the switchtec NTB code to handle link change events we
> create a notifier block in the switchtec code which gets called
> whenever an appropriate event interrupt occurs.
> 
> In order to preserve userspace's ability to follow these events,
> we compare the event count with a stored copy from last time we
> checked.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Stephen Bates <sbates@raithlin.com>
> Reviewed-by: Kurt Schwemmer <kurt.schwemmer@microsemi.com>
> ---
>  drivers/pci/switch/switchtec.c | 53 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/switchtec.h      |  5 ++++
>  2 files changed, 58 insertions(+)
> 
> diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
> index e9bf17b1934e..63e305b24fb9 100644
> --- a/drivers/pci/switch/switchtec.c
> +++ b/drivers/pci/switch/switchtec.c
> @@ -972,6 +972,50 @@ static const struct file_operations switchtec_fops = {
>  	.compat_ioctl = switchtec_dev_ioctl,
>  };
>  
> +static void link_event_work(struct work_struct *work)
> +{
> +	struct switchtec_dev *stdev;
> +
> +	stdev = container_of(work, struct switchtec_dev, link_event_work);
> +
> +	dev_dbg(&stdev->dev, "%s\n", __func__);

You do know about ftrace, right?  It's good to drop debugging code like
this for "final" versions.

> +
> +	blocking_notifier_call_chain(&stdev->link_notifier, 0, stdev);
> +}

Do you really need a notifier call chain?  How many different things are
going to "hook up" to this?  I ask as they tend to get really messy over
time while direct callbacks are easier to handle and manage.

thanks,

greg k-h
