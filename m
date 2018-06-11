Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id i3-v6si951399qtp.2.2018.06.11.15.33.37
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Jun 2018 15:33:38 -0700 (PDT)
References: <20180611203926.2666-1-jdmason@kudzu.us>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <ab8d44fc-6cd6-724e-0429-e7b3a1afb8d6@deltatee.com>
Date: Mon, 11 Jun 2018 16:33:34 -0600
MIME-Version: 1.0
In-Reply-To: <20180611203926.2666-1-jdmason@kudzu.us>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ntb_netdev: fix sleep time mismatch
To: Jon Mason <jdmason@kudzu.us>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>



On 11/06/18 02:39 PM, Jon Mason wrote:
> The tx_time should be in usecs (according to the comment above the
> variable), but the setting of the timer during the rearming is done in
> msecs.  Change it to match the expected units.

I'm curious what the user visible effects of this bug were. Will this
significantly improve the performance of ntb_netdev?

Logan
