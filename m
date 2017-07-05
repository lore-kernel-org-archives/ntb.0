Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org. [198.145.29.99])
        by gmr-mx.google.com with ESMTPS id 23si1123750ith.6.2017.07.05.12.37.23
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jul 2017 12:37:23 -0700 (PDT)
Date: Wed, 5 Jul 2017 14:37:21 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH 01/16] switchtec: move structure definitions into a
 common header
Message-ID: <20170705193721.GA25063@bhelgaas-glaptop.roam.corp.google.com>
References: <20170629032648.3073-1-logang@deltatee.com>
 <20170629032648.3073-2-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170629032648.3073-2-logang@deltatee.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-ntb@googlegroups.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>, Bjorn Helgaas <bhelgaas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kurt Schwemmer <kurt.schwemmer@microsemi.com>, Stephen Bates <sbates@raithlin.com>, Serge Semin <fancer.lancer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

On Wed, Jun 28, 2017 at 09:26:33PM -0600, Logan Gunthorpe wrote:
> Create the switchtec.h header in include/linux with hardware defines
> and the switchtec_dev structure moved directly from switchtec.c.
> This is a prep patch for created an NTB driver for switchtec.

s/created/creating/
