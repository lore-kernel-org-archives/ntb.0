Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id f86si373159pfh.0.2019.01.31.12.48.42
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 12:48:42 -0800 (PST)
References: <20190131185656.17972-1-logang@deltatee.com>
 <345197a6-89e6-c0de-5f7b-a646b5f396c9@intel.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <bafe9db4-6d5b-0453-d7e7-e49e9293dd01@deltatee.com>
Date: Thu, 31 Jan 2019 13:48:31 -0700
MIME-Version: 1.0
In-Reply-To: <345197a6-89e6-c0de-5f7b-a646b5f396c9@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 0/9] Support using MSI interrupts in ntb_transport
To: Dave Jiang <dave.jiang@intel.com>, linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, Jon Mason <jdmason@kudzu.us>, Bjorn Helgaas <bhelgaas@google.com>, Joerg Roedel <joro@8bytes.org>
Cc: Allen Hubbe <allenbh@gmail.com>, Serge Semin <fancer.lancer@gmail.com>, Eric Pilmore <epilmore@gigaio.com>
List-ID: <linux-ntb.googlegroups.com>



On 2019-01-31 1:20 p.m., Dave Jiang wrote:
> Does this work when the system moves the MSI vector either via software 
> (irqbalance) or BIOS APIC programming (some modes cause round robin 
> behavior)?


I don't know how irqbalance works, and I'm not sure what you are
referring to by BIOS APIC programming, however I would expect these
things would not be a problem.

The MSI code I'm presenting here doesn't do anything crazy with the
interrupts, it allocates and uses them just as any PCI driver would. The
only real difference here is that instead of a piece of hardware sending
the IRQ TLP, it will be sent through the memory window (which, from the
OS's perspective, is just coming from an NTB hardware proxy alias).

Logan
