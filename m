Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id i10si1742896ioi.5.2019.04.30.14.27.58
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Apr 2019 14:27:59 -0700 (PDT)
References: <CAOQPn8vMn4h=oGWWKa3Uge7WYMkmRAmTyhR6RPjGVtrR1hfhOQ@mail.gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <4389bccb-6993-4a86-b4e4-202e971e2080@deltatee.com>
Date: Tue, 30 Apr 2019 15:27:53 -0600
MIME-Version: 1.0
In-Reply-To: <CAOQPn8vMn4h=oGWWKa3Uge7WYMkmRAmTyhR6RPjGVtrR1hfhOQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: NVMe peer2peer TLPs over NTB getting split
To: Eric Pilmore <epilmore@gigaio.com>, linux-ntb <linux-ntb@googlegroups.com>, linux-pci@vger.kernel.org
Cc: Armen Baloyan <abaloyan@gigaio.com>, D Meyer <dmeyer@gigaio.com>, S Taylor <staylor@gigaio.com>
List-ID: <linux-ntb.googlegroups.com>



On 2019-04-24 4:46 p.m., Eric Pilmore wrote:
> Hi Folks,
> 
> Does anybody know why a Host Bridge might break up a full-sized (max
> payload) TLP into single byte TLPs when those TLPs are traveling from
> peer-to-peer?

Host bridges can't be relied on to do the right thing with respect to
P2P. This is why the p2pdma code explicitly rejects them. Bad
performance is often the symptom and splitting may be the cause (I've
never bothered to stick an analyzer on it. There are patches floating
around to add a whitelist to p2pdma which would be what you'd want to do
and avoid anything that doesn't go through a switch.

Logan
