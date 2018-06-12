Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id s14-v6si40119qkl.1.2018.06.12.09.18.17
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 09:18:18 -0700 (PDT)
References: <20180609000819.13883-1-logang@deltatee.com>
 <20180609000819.13883-3-logang@deltatee.com>
 <CAPoiz9ykPufmQi=fhhA8k=CXdXwdo0v7+UPQwNwnkokXU-vWjw@mail.gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <ba7e652f-493c-eb92-042b-f60897b79045@deltatee.com>
Date: Tue, 12 Jun 2018 10:18:12 -0600
MIME-Version: 1.0
In-Reply-To: <CAPoiz9ykPufmQi=fhhA8k=CXdXwdo0v7+UPQwNwnkokXU-vWjw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/8] NTB: Setup the DMA mask globally for all drivers
To: Jon Mason <jdmason@kudzu.us>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-ntb <linux-ntb@googlegroups.com>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Serge Semin <fancer.lancer@gmail.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Shuah Khan <shuah@kernel.org>
List-ID: <linux-ntb.googlegroups.com>



On 12/06/18 09:48 AM, Jon Mason wrote:
> ntb.c is more of a glue layer, and this is more device specific.
> While I like adding it here for more common code, it should probably
> reside in the ntb_hw_*.c files to enforce the hw specific code all
> reside in that layer.  So, this probably needs to be replaced with a
> patch which adds the setting of the mask to the switchtec driver.

I disagree strongly. You can tell it's not device specific seeing we
have 4 devices that need the exact same code. In fact, there is nothing
device specific in those lines of code as the device specific part comes
when a driver sets the PCI parent device's DMA mask. These lines just
initialize the dma_mask for the new NTB device with its parent's mask.
This is just sensible given that nothing now works if it is not done and
trusting driver writers to get it right is not a good idea seeing we
already screwed it up once. Furthermore, it violates DRY (do not repeat
yourself).

If there is something driver specific that must be done (although I
can't actually imagine what this would be) the drivers are free to
change the mask after calling ntb_register but getting the common case
setup in common code is just good design.

Logan
