Return-Path: <joro@8bytes.org>
Received: from theia.8bytes.org (8bytes.org. [81.169.241.247])
        by gmr-mx.google.com with ESMTPS id m1si585912wrj.4.2019.02.26.01.34.48
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Feb 2019 01:34:48 -0800 (PST)
Date: Tue, 26 Feb 2019 10:34:46 +0100
From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v2 00/12] Support using MSI interrupts in ntb_transport
Message-ID: <20190226093445.GC19617@8bytes.org>
References: <20190213175454.7506-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213175454.7506-1-logang@deltatee.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, Jon Mason <jdmason@kudzu.us>, Bjorn Helgaas <bhelgaas@google.com>, Allen Hubbe <allenbh@gmail.com>, Dave Jiang <dave.jiang@intel.com>, Serge Semin <fancer.lancer@gmail.com>, Eric Pilmore <epilmore@gigaio.com>
List-ID: <linux-ntb.googlegroups.com>

On Wed, Feb 13, 2019 at 10:54:42AM -0700, Logan Gunthorpe wrote:
>   iommu/vt-d: Add helper to set an IRTE to verify only the bus number
>   iommu/vt-d: Allow interrupts from the entire bus for aliased devices

Applied these two to the iommu tree, thanks.
