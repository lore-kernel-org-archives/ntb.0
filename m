Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id r14-v6si436941ith.4.2018.05.09.21.35.21
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 May 2018 21:35:21 -0700 (PDT)
References: <1525634420-19370-1-git-send-email-araut@codeaurora.org>
 <1525634420-19370-2-git-send-email-araut@codeaurora.org>
 <65020028-564a-c679-e31f-2aa7d4390666@deltatee.com>
 <37573d5a-cbe1-123c-f522-9a7fbb11d489@codeaurora.org>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <ab2b9171-ae76-0cdb-5cbc-9aa08a3a29ab@deltatee.com>
Date: Wed, 9 May 2018 22:35:16 -0600
MIME-Version: 1.0
In-Reply-To: <37573d5a-cbe1-123c-f522-9a7fbb11d489@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/4] NTB : Introduce message library
To: Atul Raut <araut@codeaurora.org>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>



On 09/05/18 08:10 PM, Atul Raut wrote:
> Agree, few points would like to bring it here & see if that makes
> sense ?
> 1. Here Library brings some useful things, that  currently two 
> client are using it with assumption that these things may
> need for feature clients as well.
> 2. The main objective of library is to solve common problem
> that any client driver may have, and that is configuring
> inbound/outbound memory window by sharing some info using these
> registers in certain way, one way is my patch that derived from
> Sergey's ntb_perf module.
> The idea is to have basic infrastructure in place which solves
> basic configuration problem for any client driver.
> Not sure these answers your question, but if any one has some
> other suggestions on library implementation I will give an try.

Well, I'd much rather try for something a little better and actually see
the code get cleaner instead of just copying what was in one client into
a library. Case in point: you're adding way more lines to
ntb_transport.c despite creating a library that's supposed to make it's
code simpler.

I'd suggest an API that accepts a small block of memory and sends it
over either spads or msgs (whichever is available). The protocol for
this can be defined by the library and the clients won't care how the
data is sent. Clients then only need to create and populate a small
structure with data it requires to initialize itself. The structure can
then be sent and received with minimal code by the clients. This will
clean up the clients and avoid having them parse and send all these CMD
IDs. It also lets clients define the data they want to send themselves
instead of encoding all possible commands in the library. Such an API
would also be much more future proof as future clients will be able to
use it for any kind of initialization data.


>>> Do we really need a cmd_wid message? 
> These will act dummy for scratchpad based registers, added just to 
> have common API's for scratchpad & message registers.

I don't understand this. But the fact is, it will not work with
Switchtec as there is only 3 messages available. So you will have to
think of something else.

Logan
