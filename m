Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org. [198.145.29.99])
        by gmr-mx.google.com with ESMTPS id l23si534593otn.4.2019.03.22.09.47.45
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 09:47:46 -0700 (PDT)
Date: Fri, 22 Mar 2019 11:47:43 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v3 09/10] NTB: Add MSI interrupt support to ntb_transport
Message-ID: <20190322164743.GN251185@google.com>
References: <20190322000645.15580-1-logang@deltatee.com>
 <20190322000645.15580-10-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322000645.15580-10-logang@deltatee.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, Jon Mason <jdmason@kudzu.us>, Joerg Roedel <joro@8bytes.org>, Allen Hubbe <allenbh@gmail.com>, Dave Jiang <dave.jiang@intel.com>, Serge Semin <fancer.lancer@gmail.com>, Eric Pilmore <epilmore@gigaio.com>
List-ID: <linux-ntb.googlegroups.com>

Hi Logan,

Drive-by nits:

On Thu, Mar 21, 2019 at 06:06:44PM -0600, Logan Gunthorpe wrote:
> Introduce the module parameter 'use_msi' which, when set uses

s/set/set,/

> MSI interrupts instead of doorbells for each queue pair (QP). T
> he parameter is only available if NTB MSI support is configured into

Spurious newline in the middle of "The".

> the kernel. We also require there to be more than one memory window
> (MW) so that an extra one is available to forward the APIC region.
> 
> To use MSIs, we request one interrupt per QP and forward the MSI address
> and data to the peer using scratch pad registers (SPADS) above the MW
> spads. (If there are not enough SPADS the MSI interrupt will not be used.)

/spads/SPADS/ for consistency

> Once registered, we simply use ntb_msi_peer_trigger and the recieving

s/recieving/receiving/

> ISR simply queues up the rxc_db_work for the queue.
> 
> This addition can significantly improve performance of ntb_transport.
> In a simple, untuned, apples-to-apples comparision using ntb_netdev
> and iperf with switchtec hardware, I see 3.88Gb/s without MSI
> interrupts and 14.1Gb/s which is a more than 3x improvement.

s/which is/with MSI, which is/

Bjorn
