Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id 189si7896ybc.1.2019.06.13.08.46.59
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Jun 2019 08:46:59 -0700 (PDT)
References: <20190523223100.5526-1-logang@deltatee.com>
 <20190613133014.GE1572@kudzu.us>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <985a41a9-80c2-7b60-da98-4ea92085319b@deltatee.com>
Date: Thu, 13 Jun 2019 09:46:44 -0600
MIME-Version: 1.0
In-Reply-To: <20190613133014.GE1572@kudzu.us>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5 00/10] Support using MSI interrupts in ntb_transport
To: Jon Mason <jdmason@kudzu.us>
Cc: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, Joerg Roedel <joro@8bytes.org>, Bjorn Helgaas <bhelgaas@google.com>, Allen Hubbe <allenbh@gmail.com>, Dave Jiang <dave.jiang@intel.com>, Serge Semin <fancer.lancer@gmail.com>, Eric Pilmore <epilmore@gigaio.com>
List-ID: <linux-ntb.googlegroups.com>



On 2019-06-13 7:30 a.m., Jon Mason wrote:
> On Thu, May 23, 2019 at 04:30:50PM -0600, Logan Gunthorpe wrote:
>> This is another resend as there has been no feedback since v4.
>> Seems Jon has been MIA this past cycle so hopefully he appears on the
>> list soon.
>>
>> I've addressed the feedback so far and rebased on the latest kernel
>> and would like this to be considered for merging this cycle.
>>
>> The only outstanding issue I know of is that it still will not work
>> with IDT hardware, but ntb_transport doesn't work with IDT hardware
>> and there is still no sensible common infrastructure to support
>> ntb_peer_mw_set_trans(). Thus, I decline to consider that complication
>> in this patchset. However, I'll be happy to review work that adds this
>> feature in the future.
>>
>> Also, as the port number and resource index stuff is a bit complicated,
>> I made a quick out of tree test fixture to ensure it's correct[1]. As
>> an excerise I also wrote some test code[2] using the upcomming KUnit
>> feature.
> 
> Sorry for the delay.  The patch is now in the ntb-next branch.  We've
> missed window for 5.2, but it will be in the 5.3 pull request (barring
> last minute comments).

Thanks Jon!

Logan
