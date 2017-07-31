Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org. [198.145.29.99])
        by gmr-mx.google.com with ESMTPS id h77si748227itb.0.2017.07.31.13.26.10
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Jul 2017 13:26:10 -0700 (PDT)
Date: Mon, 31 Jul 2017 15:26:06 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v3 10/16] switchtec_ntb: initialize hardware for
 doorbells and messages
Message-ID: <20170731202606.GD9303@bhelgaas-glaptop.roam.corp.google.com>
References: <20170725205753.4735-1-logang@deltatee.com>
 <20170725205753.4735-11-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170725205753.4735-11-logang@deltatee.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-ntb@googlegroups.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>, Bjorn Helgaas <bhelgaas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kurt Schwemmer <kurt.schwemmer@microsemi.com>, Stephen Bates <sbates@raithlin.com>, Serge Semin <fancer.lancer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

On Tue, Jul 25, 2017 at 02:57:47PM -0600, Logan Gunthorpe wrote:
> Set up some hardware registers and creates interrupt service routines
> for the doorbells and messages.
> 
> There are 64 doorbells in the switch that are shared between all
> partitions. The upper 4 doorbells are also shared with the messages
> and are there for not used. Thus, this provides 28 doorbells for each

s/there for/therefore/

> partition.
