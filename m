Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id k4si24096ioc.4.2017.12.04.19.00.02
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Dec 2017 19:00:03 -0800 (PST)
References: <20171204175721.10322-1-logang@deltatee.com>
 <CAJQW-Q6DXi4ipyc_cKfa=HYAqcu1sstJXU1mJmqvWH1c1aGePA@mail.gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <0f0a4d34-ed0b-99cf-8f7d-d47e62235a3b@deltatee.com>
Date: Mon, 4 Dec 2017 20:00:00 -0700
MIME-Version: 1.0
In-Reply-To: <CAJQW-Q6DXi4ipyc_cKfa=HYAqcu1sstJXU1mJmqvWH1c1aGePA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] ntb_hw_switchtec: Force down the link before
 initializing
To: ThanhTuThai <cruisethai@gmail.com>
Cc: linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>



On 04/12/17 06:47 PM, ThanhTuThai wrote:
> The problem is that the good host even didn't receive any message when
> the crashed peer come up, so your  "re-init scheduled work" will not be
> activated.
> Because the good peer didn't receive any interrupt to activate the
> scheduled work.

What's your evidence here? You haven't really sent me anything to go on.
Did you actually try the patch or did you just assume it doesn't work?

In any case, if your assertion is correct, then it's a firmware issue
and you'll have to contact Microsemi and get them to look at it.

Logan
