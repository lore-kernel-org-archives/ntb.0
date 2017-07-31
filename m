Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org. [198.145.29.99])
        by gmr-mx.google.com with ESMTPS id g192si114564ita.8.2017.07.31.13.27.04
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Jul 2017 13:27:04 -0700 (PDT)
Date: Mon, 31 Jul 2017 15:27:00 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v3 12/16] switchtec_ntb: add link management
Message-ID: <20170731202700.GE9303@bhelgaas-glaptop.roam.corp.google.com>
References: <20170725205753.4735-1-logang@deltatee.com>
 <20170725205753.4735-13-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170725205753.4735-13-logang@deltatee.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-ntb@googlegroups.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>, Bjorn Helgaas <bhelgaas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kurt Schwemmer <kurt.schwemmer@microsemi.com>, Stephen Bates <sbates@raithlin.com>, Serge Semin <fancer.lancer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

On Tue, Jul 25, 2017 at 02:57:49PM -0600, Logan Gunthorpe wrote:
> switchtec_ntb checks for a link by looking at the shared memory
> window. If the magic number is correct and the otherside indicates
> their link is enabled then we take the link to be up.
> 
> Whenever we change our local link status we send a msg to the
> otherside to check whether it's up and change their status.

s/otherside/other side/ (twice)

> The current status is maintained in a flag so ntb_is_link_up
> can return quickly.
> 
> We utilize Switchtec's link status notifier to also check link changes
> when the switch notices a port changes state.
