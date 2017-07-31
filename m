Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org. [198.145.29.99])
        by gmr-mx.google.com with ESMTPS id 79si691444iti.6.2017.07.31.15.50.06
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Jul 2017 15:50:06 -0700 (PDT)
Date: Mon, 31 Jul 2017 17:50:03 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v3 01/16] switchtec: move structure definitions into a
 common header
Message-ID: <20170731225003.GA19800@bhelgaas-glaptop.roam.corp.google.com>
References: <20170725205753.4735-1-logang@deltatee.com>
 <20170725205753.4735-2-logang@deltatee.com>
 <20170731201542.GA9303@bhelgaas-glaptop.roam.corp.google.com>
 <07990806-349c-669c-ef32-3dc2f6a12296@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07990806-349c-669c-ef32-3dc2f6a12296@deltatee.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-ntb@googlegroups.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>, Bjorn Helgaas <bhelgaas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kurt Schwemmer <kurt.schwemmer@microsemi.com>, Stephen Bates <sbates@raithlin.com>, Serge Semin <fancer.lancer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

On Mon, Jul 31, 2017 at 02:51:35PM -0600, Logan Gunthorpe wrote:
> Hey,
> 
> I've never found any consistency in the capitalization and prefixes
> patch titles. I used to capitalize them all but I've seen many
> developers use lower case. In any case, I've changed them as you requested.

Thanks!  Granted, most people don't seem to care, but I'm not
completely alone in this; I try follow Ingo's preferences [1] for
drivers/pci, so there is some consistency there.

Bjorn

[1] http://lkml.kernel.org/r/20120711080446.GA17713@gmail.com
