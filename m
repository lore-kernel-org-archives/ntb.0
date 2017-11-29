Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id e18si79717qtc.5.2017.11.29.08.41.36
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Nov 2017 08:41:36 -0800 (PST)
From: Logan Gunthorpe <logang@deltatee.com>
References: <20171128220144.13294-1-logang@deltatee.com>
 <f30f393f-3efd-d720-154e-a54bbad89238@deltatee.com>
 <CAPoiz9zxTgMsRJpQ+fkdsrdREmAA0BcvQd6OJHsv6ErLUU_cSw@mail.gmail.com>
 <CAJQW-Q5yGaS21iAjL3e4GULDu5jBH1pXmGHm=SXDN6GGG0jV2Q@mail.gmail.com>
 <4fefc563-0687-9e03-2c82-f9ca163dfb0b@deltatee.com>
Message-ID: <653a0b04-0dc6-7ac4-34b8-10a0feb8a01c@deltatee.com>
Date: Wed, 29 Nov 2017 09:41:34 -0700
MIME-Version: 1.0
In-Reply-To: <4fefc563-0687-9e03-2c82-f9ca163dfb0b@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ntb_hw_switchtec: Force down the peer's link before
 initializing
To: ThanhTuThai <cruisethai@gmail.com>, Jon Mason <jdmason@kudzu.us>
Cc: linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

Also,

Can you grab the switchtec management utility[1] and send me the output of:

sudo switchtec gas dump > gas_dump.dat

On the good host after the bad host came back up?

Thanks,

Logan
