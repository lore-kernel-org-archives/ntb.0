Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id v76-v6si794742vke.4.2018.09.17.09.06.49
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 09:06:49 -0700 (PDT)
References: <20180720180034.3964-1-logang@deltatee.com>
 <20180917151622.lnlckvkiyqqxlt4c@alfbook-pro.local>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <cdf8ac35-75d3-afd2-1bcb-f9d5ac256459@deltatee.com>
Date: Mon, 17 Sep 2018 10:06:39 -0600
MIME-Version: 1.0
In-Reply-To: <20180917151622.lnlckvkiyqqxlt4c@alfbook-pro.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 0/8] Fix breakage caused by the NTB multi-port patchset
To: Alexander Fomichev <fomichev.ru@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>, Serge Semin <fancer.lancer@gmail.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Shuah Khan <shuah@kernel.org>, Doug Meyer <dmeyer@gigaio.com>, linux@yadro.com
List-ID: <linux-ntb.googlegroups.com>



On 17/09/18 09:16 AM, Alexander Fomichev wrote:
>> Logan Gunthorpe (8):
>>   NTB: ntb_tool: reading the link file should not end in a NULL byte
>>   NTB: Setup the DMA mask globally for all drivers
>>   NTB: Fix the default port and peer numbers for legacy drivers
>>   NTB: ntb_pingpong: Choose doorbells based on port number
>>   NTB: perf: Don't require one more memory window than number of peers
>>   NTB: perf: Fix support for hardware that doesn't have port numbers
>>   NTB: perf: Fix race condition when run with ntb_test
>>   NTB: ntb_test: Fix bug when counting remote files
> 
> Tested successfully on i5-based desktop PC, NTB on PM8535 chip, both
> ends are on the local system.
> 
> Tested-by: Alexander Fomichev <fomichev.ru@gmail.com>

Thanks Alexander!

Logan
