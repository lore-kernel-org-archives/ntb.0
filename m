Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id u18-v6si72796ita.1.2018.06.15.13.01.28
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Jun 2018 13:01:28 -0700 (PDT)
References: <20180609000819.13883-1-logang@deltatee.com>
 <20180609000819.13883-8-logang@deltatee.com>
 <20180615195030.GA25303@mobilestation>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <627b30c0-fb98-08a7-9a09-a5f45368740c@deltatee.com>
Date: Fri, 15 Jun 2018 14:01:24 -0600
MIME-Version: 1.0
In-Reply-To: <20180615195030.GA25303@mobilestation>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 6/8] NTB: perf: Fix support for hardware that doesn't have
 port numbers
To: Serge Semin <fancer.lancer@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Shuah Khan <shuah@kernel.org>
List-ID: <linux-ntb.googlegroups.com>



On 15/06/18 01:50 PM, Serge Semin wrote:
> On Fri, Jun 08, 2018 at 06:08:17PM -0600, Logan Gunthorpe <logang@deltatee.com> wrote:
>> Legacy drivers do not have port numbers (but is reliably only two ports)
>> and was broken by the recent commit that added mult-port support to
>> ntb_perf. This is especially important to support the cross link
>> topology which is perfectly symmetric and cannot assign unique port
>> numbers easily.
>>
> 
> Please, see the comment to the patch 3/8. I explained everything there
> including the fact, that the Intel/AMD drivers do have unique port numbers
> assigned.

See my comments as to why this is impossible.

Logan
