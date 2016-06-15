Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id tp10si4458435pac.2.2016.06.15.15.30.57
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jun 2016 15:30:57 -0700 (PDT)
References: <cover.1466025130.git.logang@deltatee.com>
 <a37e02139ad94ab322bfac087524a0394ec0383a.1466025130.git.logang@deltatee.com>
 <007901d1c74f$dcdab6c0$96902440$@emc.com> <5761CE79.8090703@deltatee.com>
 <007b01d1c753$b9b6e840$2d24b8c0$@emc.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <5761D711.4020700@deltatee.com>
Date: Wed, 15 Jun 2016 16:30:41 -0600
MIME-Version: 1.0
In-Reply-To: <007b01d1c753$b9b6e840$2d24b8c0$@emc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 09/10] ntb_test: Add a selftest script for the NTB
 subsystem
To: Allen Hubbe <Allen.Hubbe@emc.com>, 'Jon Mason' <jdmason@kudzu.us>, 'Dave Jiang' <dave.jiang@intel.com>
Cc: 'Shuah Khan' <shuahkh@osg.samsung.com>, 'Sudip Mukherjee' <sudipm.mukherjee@gmail.com>, 'Arnd Bergmann' <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, linux-kselftest@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>



On 15/06/16 04:17 PM, Allen Hubbe wrote:
> This test should fail on Intel RP/TB topology (two cpu sharing one ntb).  The link state is the link state of the secondary side pcie bus connected to the secondary side cpu.  The link must be up in order for the secondary side cpu to discover the ntb device, so the driver does not allow the link to be disabled in such topology.

Ok, I wasn't aware of this.  But looking closer I think I have a better
solution:

ntb_link_disable should return -EINVAL if the hardware can't support
bringing the link down. If I add the error check to my tool_link_write
(which I neglected to do) then writing an "N" to $LOC/link will fail and
the test could be skipped. I'll make a v4 spin.

Logan

> A simple thing to do here might be:
> 
> write_file "N" "$LOC/link"
> sleep 1
> read_file "$REM/link"
> 
> You already have my Ack.  This minor issue can be fixed later if anyone cares.  I don't think it is a big deal, just worth pointing out that the script will hang here instead of report a failure.  If it is worth fixing later, at that point we might also want to change this script to continue with other tests instead of exit on the first failure.
> 
