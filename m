Return-Path: <araut@codeaurora.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org. [198.145.29.96])
        by gmr-mx.google.com with ESMTPS id a25-v6si500406ioc.1.2018.05.09.19.10.32
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 May 2018 19:10:32 -0700 (PDT)
Subject: Re: [PATCH v2 1/4] NTB : Introduce message library
References: <1525634420-19370-1-git-send-email-araut@codeaurora.org>
 <1525634420-19370-2-git-send-email-araut@codeaurora.org>
 <65020028-564a-c679-e31f-2aa7d4390666@deltatee.com>
From: Atul Raut <araut@codeaurora.org>
Message-ID: <37573d5a-cbe1-123c-f522-9a7fbb11d489@codeaurora.org>
Date: Wed, 9 May 2018 19:10:31 -0700
MIME-Version: 1.0
In-Reply-To: <65020028-564a-c679-e31f-2aa7d4390666@deltatee.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Logan Gunthorpe <logang@deltatee.com>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

Hi Logan,

Thanks for reviewing patches.

>> Should we really encode the type of data sent in the library?
Agree, few points would like to bring it here & see if that makes
sense ?
1. Here Library brings some useful things, that  currently two 
client are using it with assumption that these things may
need for feature clients as well.
2. The main objective of library is to solve common problem
that any client driver may have, and that is configuring
inbound/outbound memory window by sharing some info using these
registers in certain way, one way is my patch that derived from
Sergey's ntb_perf module.
The idea is to have basic infrastructure in place which solves
basic configuration problem for any client driver.
Not sure these answers your question, but if any one has some
other suggestions on library implementation I will give an try.

>> Do we really need a cmd_wid message? 
These will act dummy for scratchpad based registers, added just to 
have common API's for scratchpad & message registers.
 
Regards,
Atul

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
Linux Foundation Collaborative Project
