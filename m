Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id l11-v6si265097iti.0.2018.06.15.12.56.36
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Jun 2018 12:56:36 -0700 (PDT)
References: <20180609000819.13883-1-logang@deltatee.com>
 <20180609000819.13883-5-logang@deltatee.com>
 <20180615194929.GA24025@mobilestation>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <6fab7e2b-e7aa-8e67-a318-5ce790677c0d@deltatee.com>
Date: Fri, 15 Jun 2018 13:56:28 -0600
MIME-Version: 1.0
In-Reply-To: <20180615194929.GA24025@mobilestation>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 4/8] NTB: ntb_pingpong: Choose doorbells based on port
 number
To: Serge Semin <fancer.lancer@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Shuah Khan <shuah@kernel.org>
List-ID: <linux-ntb.googlegroups.com>



On 15/06/18 01:49 PM, Serge Semin wrote:
> Regarding the patch. The idea of using the port number instead of linearised
> unique index should also work for Intel/AMD/IDT drivers. But the ports-space
> linearization algorithm was created for the case if the real port numbers
> would exceed the available Doorbell bits. I thought this might be the case of
> multi-ports version of the switchtec driver.

Well, the switchtec driver splits its 64 doorbells in two sets, one for
each port right now. That will likely have to change when we go to a
multi-port implementation. In that case we will have 64 doorbells and a
maximum 48 ports. So I don't think we have to concern ourselves with
more ports than doorbells.

> Needless to say, that if Switchtec driver had the ports-index API implementation,
> this patch wouldn't be needed.

As I've said, it's impossible to write for the crosslink topology so the
clients must support that case.

Logan
