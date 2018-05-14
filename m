Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id a25-v6si1192150iod.3.2018.05.14.14.04.30
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 May 2018 14:04:30 -0700 (PDT)
References: <1525634420-19370-1-git-send-email-araut@codeaurora.org>
 <20180511223925.GB24717@mobilestation>
 <0f17dee9-9d68-642e-9fe0-6aaf31605cdf@deltatee.com>
 <20180514204036.GD24717@mobilestation>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <3e0ed65a-4823-b9cd-b480-4b53917d5bab@deltatee.com>
Date: Mon, 14 May 2018 15:04:27 -0600
MIME-Version: 1.0
In-Reply-To: <20180514204036.GD24717@mobilestation>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 0/4] NTB : Introduce message library
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Atul Raut <araut@codeaurora.org>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On 5/14/2018 2:40 PM, Serge Semin wrote:
> I've got the same experience. But one thing I also got from it. If I knew a
> maintainers notion about a change, I would have developed a code in accordance
> with it. At least I'd try to understand the maintainer ideas and after discussions
> we'd come up to some agreement. So if I had a way to chat with subsystem support
> team, I would have used it without a doubt. Of course this doesn't mean that a
> patchset would be accepted right after a first submit, but you must admit it would
> lead to a code closer to acceptance than if it was created without the consultation.

I'm obviously not saying you shouldn't discuss design decisions with
stake holders at all points in the process. The point is you shouldn't
expect that just having the discussion ahead of time will mean everyone
will get it right the first time and your patchset will be immediately
merged. Often times the end of a discussion is to wait and see the
code/implementation and then it can be evaluated further. My main point
is: always expect you will do re-writes at least until everyone has seen
it and a consensus is forming.

Logan
