Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id w125-v6si179661itb.0.2018.05.11.16.01.02
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 May 2018 16:01:02 -0700 (PDT)
References: <1525634420-19370-1-git-send-email-araut@codeaurora.org>
 <20180511223925.GB24717@mobilestation>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <0f17dee9-9d68-642e-9fe0-6aaf31605cdf@deltatee.com>
Date: Fri, 11 May 2018 17:00:59 -0600
MIME-Version: 1.0
In-Reply-To: <20180511223925.GB24717@mobilestation>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 0/4] NTB : Introduce message library
To: Serge Semin <fancer.lancer@gmail.com>, Atul Raut <araut@codeaurora.org>
Cc: linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On 5/11/2018 4:39 PM, Serge Semin wrote:
> Definitely I didn't tell you just to copy-and-paste the whole service functions
> from ntb_perf. One of the ntb_perf driver purpose was to create an example of
> possible cross-interface communication code, which turned to be the "service"
> subsystem of the driver. My idea was to have it used as a proof of concept and
> a stably working code for the future cross-iface library. The library is going
> to be a part of the NTB API itself - a part of the generic interface for the
> whole NTB subsystem, so I recommended to have the design discussed first, otherwise
> you'd risk to face review requests which would cause a serious code refactoring.
> As far as I can see, it turned out to be true.

IMO, and in my experience, when working on APIs that have multiple users 
in the kernel you should *expect* to refactor and rewrite the code a 
couple times before we land on something that is clean enough to merge. 
I have patch sets that have gone through many *significant* changes and 
they are still works in progress. This is normal and don't expect 
discussion ahead of time to converge on the right answer right away.
> Even though this more like a "philosophic" part, but this time Logan's opinion
> happens to agree with the design we discussed a while ago with the rest of the
> NTB maintainers:

Glad we agree for a change ;)

Logan

