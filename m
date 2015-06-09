Return-Path: <bhelgaas@google.com>
Received: from mail-ie0-x234.google.com (mail-ie0-x234.google.com. [2607:f8b0:4001:c03::234])
        by gmr-mx.google.com with ESMTPS id g4si220723igc.3.2015.06.09.09.23.49
        for <linux-ntb@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2015 09:23:49 -0700 (PDT)
Received: by mail-ie0-x234.google.com with SMTP id gx4so17820533ieb.0
        for <linux-ntb@googlegroups.com>; Tue, 09 Jun 2015 09:23:49 -0700 (PDT)
Return-Path: <bhelgaas@google.com>
Date: Tue, 9 Jun 2015 11:23:46 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v3 02/18] NTB: Add NTB hardware abstraction layer
Message-ID: <20150609162346.GC23119@google.com>
References: <cover.1433838377.git.Allen.Hubbe@emc.com>
 <21347a93355f40d945cf9f565f95e790d9b3bda5.1433838377.git.Allen.Hubbe@emc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21347a93355f40d945cf9f565f95e790d9b3bda5.1433838377.git.Allen.Hubbe@emc.com>
To: Allen Hubbe <Allen.Hubbe@emc.com>
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>
List-ID: <linux-ntb.googlegroups.com>

These refer to English text usage (doc, comments, Kconfig help), not C code:

  s/ntb/NTB/ (except where it refers directly to the driver)
  s/pci/PCI/
  s/PCI-E/PCIe/
  s/api/API/
  s/intel/Intel/

On Tue, Jun 09, 2015 at 05:44:29AM -0400, Allen Hubbe wrote:
> Abstract the ntb device behind a programming interface, so that it can
> support different hardware.  Change the intel hardware driver to fit the
> abstraction.
> 
> Expose the ntb hardware api to client drivers instead of tying it to
> ntb_transport.  Make ntb_transport a client of the ntb hardware api.
