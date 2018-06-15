Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id s13-v6si534679plp.1.2018.06.15.13.00.45
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Jun 2018 13:00:46 -0700 (PDT)
References: <20180609000819.13883-1-logang@deltatee.com>
 <20180609000819.13883-9-logang@deltatee.com>
 <20180615195122.GA25387@mobilestation>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <505f2281-adcf-d1dc-ddca-8090cb34b1e6@deltatee.com>
Date: Fri, 15 Jun 2018 14:00:40 -0600
MIME-Version: 1.0
In-Reply-To: <20180615195122.GA25387@mobilestation>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 7/8] NTB: perf: Fix race condition when run with ntb_test
To: Serge Semin <fancer.lancer@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Shuah Khan <shuah@kernel.org>
List-ID: <linux-ntb.googlegroups.com>



On 15/06/18 01:51 PM, Serge Semin wrote:
> On Fri, Jun 08, 2018 at 06:08:18PM -0600, Logan Gunthorpe <logang@deltatee.com> wrote:
>> When running ntb_test, the script tries to run the ntb_perf test
>> immediately after probing the modules. Since adding multi-port support,
>> this fails seeing the new initialization procedure in ntb_perf
>> can not complete instantly.
>>
>> To fix this we add a completion which is waited on when a test is
>> started. In this way, run can be written any time after the module is
>> loaded and it will wait for the initialization to complete instead of
>> sending an error.
>>
> 
> Hmm, this behavior is the feature of the driver and isn't a bug or race to be
> fixed. ntb_perf driver returns -ENOLINK until the link is actually established,
> when the memory windows are properly initialized so the test can be performed.
> What do you think of leaving the algorithm as is, but instead to develop
> the polling scheme in the ntb_test.sh script and break the script execution if
> the link isn't established after sometime? At least we won't need to wait forever
> in case if the peer hanged up or crashed while the NTB link negotiation algorithm
> was in-progress.

I think polling is really ugly and doesn't really address solve the
issue of waiting forever. It's pretty easy to interrupt out of the wait
and provides a much better clue to whats going on than an error.

If we want to be more explicit, it would be pretty easy to start a timer
in the bash script and use SIGALRM to exit if the link doesn't come up
after 30 seconds or something.

Logan
