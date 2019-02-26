Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id s73si715271vkd.1.2019.02.26.08.18.45
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Feb 2019 08:18:45 -0800 (PST)
References: <20190213175454.7506-1-logang@deltatee.com>
 <20190226093445.GC19617@8bytes.org>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <f0eaeb8d-caf2-d20a-5687-2a3995407bdb@deltatee.com>
Date: Tue, 26 Feb 2019 09:18:30 -0700
MIME-Version: 1.0
In-Reply-To: <20190226093445.GC19617@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 00/12] Support using MSI interrupts in ntb_transport
To: Joerg Roedel <joro@8bytes.org>
Cc: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, Jon Mason <jdmason@kudzu.us>, Bjorn Helgaas <bhelgaas@google.com>, Allen Hubbe <allenbh@gmail.com>, Dave Jiang <dave.jiang@intel.com>, Serge Semin <fancer.lancer@gmail.com>, Eric Pilmore <epilmore@gigaio.com>
List-ID: <linux-ntb.googlegroups.com>



On 2019-02-26 2:34 a.m., Joerg Roedel wrote:
> On Wed, Feb 13, 2019 at 10:54:42AM -0700, Logan Gunthorpe wrote:
>>   iommu/vt-d: Add helper to set an IRTE to verify only the bus number
>>   iommu/vt-d: Allow interrupts from the entire bus for aliased devices
> 
> Applied these two to the iommu tree, thanks.
> 

Thanks!

Logan
