Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id e90si122550pfb.1.2017.11.29.08.37.48
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Nov 2017 08:37:49 -0800 (PST)
References: <20171128220144.13294-1-logang@deltatee.com>
 <f30f393f-3efd-d720-154e-a54bbad89238@deltatee.com>
 <CAPoiz9zxTgMsRJpQ+fkdsrdREmAA0BcvQd6OJHsv6ErLUU_cSw@mail.gmail.com>
 <CAJQW-Q5yGaS21iAjL3e4GULDu5jBH1pXmGHm=SXDN6GGG0jV2Q@mail.gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <4fefc563-0687-9e03-2c82-f9ca163dfb0b@deltatee.com>
Date: Wed, 29 Nov 2017 09:37:46 -0700
MIME-Version: 1.0
In-Reply-To: <CAJQW-Q5yGaS21iAjL3e4GULDu5jBH1pXmGHm=SXDN6GGG0jV2Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ntb_hw_switchtec: Force down the peer's link before
 initializing
To: ThanhTuThai <cruisethai@gmail.com>, Jon Mason <jdmason@kudzu.us>
Cc: linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

Hey,

> It works only for soft-reboot, but for power-on reset, it doesn't.
> I saw the problem is: with the power-on reset, the good peer didn't 
> receive any message from the crashed peer even the crashed peer already 
> sent out the message.

Hmm, that's unexpected. If the link state changed on one of the ports 
the good host should have gotten an interrupt.

Can you send me the dmesg output on both hosts? Preferably with 
debugging[1] turned on.

Thanks,

Logan


[1] 
https://www.kernel.org/doc/html/latest/admin-guide/dynamic-debug-howto.html
