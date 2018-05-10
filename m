Return-Path: <araut@codeaurora.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org. [198.145.29.96])
        by gmr-mx.google.com with ESMTPS id r14-v6si627995ith.4.2018.05.10.11.13.30
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 May 2018 11:13:30 -0700 (PDT)
Subject: Re: [PATCH v2 1/4] NTB : Introduce message library
References: <1525634420-19370-1-git-send-email-araut@codeaurora.org>
 <1525634420-19370-2-git-send-email-araut@codeaurora.org>
 <65020028-564a-c679-e31f-2aa7d4390666@deltatee.com>
 <37573d5a-cbe1-123c-f522-9a7fbb11d489@codeaurora.org>
 <ab2b9171-ae76-0cdb-5cbc-9aa08a3a29ab@deltatee.com>
From: Atul Raut <araut@codeaurora.org>
Message-ID: <1f0e367f-a577-a0f9-df04-40715fb3ee4f@codeaurora.org>
Date: Thu, 10 May 2018 11:13:28 -0700
MIME-Version: 1.0
In-Reply-To: <ab2b9171-ae76-0cdb-5cbc-9aa08a3a29ab@deltatee.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Logan Gunthorpe <logang@deltatee.com>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

Hi Logan,

Thanks for your feedback on this.

>> the code get cleaner instead of just copying what was in one client into 
>>a library. 
The reason I did this way, because I got suggestion over IRC, to reuse existing
code as library, but as you explain seems it didnt scale well.

>> I'd suggest an API that accepts a small block of memory and sends it
>> over either spads or msgs (whichever is available). 
I will revisit my changes and try out your suggestion.

Regards,
Atul Raut
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
Linux Foundation Collaborative Project
