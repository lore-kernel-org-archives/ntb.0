Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id i8-v6si118141itb.0.2018.06.15.12.51.26
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Jun 2018 12:51:26 -0700 (PDT)
References: <20180609000819.13883-1-logang@deltatee.com>
 <20180609000819.13883-4-logang@deltatee.com>
 <20180615194848.GA22880@mobilestation>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <5fbee1ec-b66d-3e82-c19f-dbb8d8582509@deltatee.com>
Date: Fri, 15 Jun 2018 13:51:16 -0600
MIME-Version: 1.0
In-Reply-To: <20180615194848.GA22880@mobilestation>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 3/8] NTB: Fix the default port and peer numbers for legacy
 drivers
To: Serge Semin <fancer.lancer@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Shuah Khan <shuah@kernel.org>
List-ID: <linux-ntb.googlegroups.com>



On 15/06/18 01:48 PM, Serge Semin wrote:
> Concerning the fix of the discovered issues and fixes introduced by this
> patchset. I'd suggest to add the ports-index callbacks to the Switchtec
> driver, which identify local and peer ports. After this the current version
> of all the test drivers shall perfectly work.

Well that will work for the simple switchtec case. The crosslink
topology CAN NOT produce port numbers like you ask. It is perfectly
symmetric and the two hosts cannot reliably figure out which is port 0
and which is port 1. So these patches support this case.

Logan
