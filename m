Return-Path: <Allen.Hubbe@emc.com>
Received: from mailuogwhop.emc.com (mailuogwhop.emc.com. [168.159.213.141])
        by gmr-mx.google.com with ESMTPS id a126si443111wmd.2.2016.03.22.07.01.09
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Mar 2016 07:01:09 -0700 (PDT)
From: "Allen Hubbe" <Allen.Hubbe@emc.com>
References: <17b414e0af3e8caf31b3b3aa5dddb842ef397c1a.1458550127.git.Allen.Hubbe@emc.com> <6a2984f3c623f41aae210f08f23813b680a19d56.1458550127.git.Allen.Hubbe@emc.com> <BLUPR12MB04207A01BAAA208E33D1E745EB800@BLUPR12MB0420.namprd12.prod.outlook.com>
In-Reply-To: <BLUPR12MB04207A01BAAA208E33D1E745EB800@BLUPR12MB0420.namprd12.prod.outlook.com>
Subject: RE: [PATCH 2/2] NTB: Remove _addr functions from ntb_hw_amd
Date: Tue, 22 Mar 2016 10:00:45 -0400
Message-ID: <000001d18443$3bb6dc50$b32494f0$@emc.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
To: "'Yu, Xiangliang'" <Xiangliang.Yu@amd.com>, linux-ntb@googlegroups.com
Cc: 'Jon Mason' <jdmason@kudzu.us>, 'Dave Jiang' <dave.jiang@intel.com>
List-ID: <linux-ntb.googlegroups.com>

> From: Yu, Xiangliang
> > From: Allen Hubbe
> > Kernel zero day testing warned about address space confusion.  A virtual
> > iomem address was used where a physical address is expected.  The
> > offending functions implement an optional part of the api, so they are
> > removed.  They can be added later, after testing.
> 
> Ntb_dev_ops_is_valid will check the related implement and AMD ntb driver can't
> Register ntb device if you remove the two functions.

See [PATCH 1/2].

> I think this addr should be is iomem address not physical address as address space
> Is IO space.

The programming interface specifies to return a physical address.  Returning a virtual address is incorrect.

> Do you map IO space again after getting the physical address?
> Please help clarify the usage scenarios.

The use case can be applied in the combination of NTB and a DMA engine to offload memory copy operations.  The physical address enables an optimization for that use case.  The DMA engine operates in the physical address space, without a virtual memory mapping, so there is no need to map the IO space again.

Using the physical address, a dma descriptor can be inserted into the chain of operations to be executed by the dma hardware.  The inserted descriptor would be a write of the appropriate bits to the doorbell register.  The write will have the effect of ringing the doorbell.

The dma hardware processes the chain of descriptors asynchronously, and notifies the dma driver as descriptors are completed.  By inserting the doorbell write operation in the chain, it is executed asynchronously along with other dma operations, and it does not require the round trip and overhead of processing a dma completion to ring the doorbell.

