Return-Path: <bhelgaas@google.com>
Received: from mail-ig0-x22c.google.com (mail-ig0-x22c.google.com. [2607:f8b0:4001:c05::22c])
        by gmr-mx.google.com with ESMTPS id x1si227871igb.2.2015.06.09.09.43.49
        for <linux-ntb@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2015 09:43:49 -0700 (PDT)
Received: by mail-ig0-x22c.google.com with SMTP id pi8so17522416igb.0
        for <linux-ntb@googlegroups.com>; Tue, 09 Jun 2015 09:43:49 -0700 (PDT)
Return-Path: <bhelgaas@google.com>
Date: Tue, 9 Jun 2015 11:43:43 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v3 13/18] NTB: Use NUMA memory and DMA chan in transport
Message-ID: <20150609164343.GF23119@google.com>
References: <cover.1433838377.git.Allen.Hubbe@emc.com>
 <405348e755bb4f78b6229f0d1ff2a347f0497505.1433838377.git.Allen.Hubbe@emc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <405348e755bb4f78b6229f0d1ff2a347f0497505.1433838377.git.Allen.Hubbe@emc.com>
To: Allen Hubbe <Allen.Hubbe@emc.com>
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>
List-ID: <linux-ntb.googlegroups.com>

On Tue, Jun 09, 2015 at 05:44:40AM -0400, Allen Hubbe wrote:
> Allocate memory and request the dma channel for the same numa node as
> the ntb device.

It'd be nice if DMA, NUMA, and NTB were capitalized in the changelog the
same way as in the subject line.
