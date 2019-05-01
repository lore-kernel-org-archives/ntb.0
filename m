Return-Path: <epilmore@gigaio.com>
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com. [2a00:1450:4864:20::332])
        by gmr-mx.google.com with ESMTPS id z185si253589wmb.0.2019.05.01.12.32.35
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 12:32:35 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id p21so259529wmc.0
        for <linux-ntb@googlegroups.com>; Wed, 01 May 2019 12:32:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQPn8vMn4h=oGWWKa3Uge7WYMkmRAmTyhR6RPjGVtrR1hfhOQ@mail.gmail.com>
 <4389bccb-6993-4a86-b4e4-202e971e2080@deltatee.com> <20190501155813.GB26910@localhost.localdomain>
In-Reply-To: <20190501155813.GB26910@localhost.localdomain>
From: Eric Pilmore <epilmore@gigaio.com>
Date: Wed, 1 May 2019 12:32:23 -0700
Message-ID: <CAOQPn8sbDjafaop2+bhB5PrxrhMWOOJ4Y5YMy6Se7+A9zrhrFg@mail.gmail.com>
Subject: Re: NVMe peer2peer TLPs over NTB getting split
Content-Type: text/plain; charset="UTF-8"
To: Keith Busch <kbusch@kernel.org>
Cc: Logan Gunthorpe <logang@deltatee.com>, linux-ntb <linux-ntb@googlegroups.com>, linux-pci@vger.kernel.org, Armen Baloyan <abaloyan@gigaio.com>, D Meyer <dmeyer@gigaio.com>, S Taylor <staylor@gigaio.com>
List-ID: <linux-ntb.googlegroups.com>

On Wed, May 1, 2019 at 9:04 AM Keith Busch <kbusch@kernel.org> wrote:
>

> Note that Max Payload Size may not be the same across root ports,
> so splitting transactions may be the correct thing to do under some
> circumstances. Kernel parameter "pci=pcie_bus_peer2peer" should make
> all MPS settings the same, though I doubt that will help for the
> hardware desribed here.

This is an interesting point which I had not considered before. The
TLPs coming directly from the NVMe drive are on a MaxPayLoad path of
256 bytes. When the TLPs get relayed from the Host Bridge, the
originating Host Bridge (BDF=00:00.0) has a MaxPayload of 128 bytes.
So, perhaps understandable that the TLPs would get broken up, although
going from 256 bytes to 1 byte TLPs is rather extreme, but perhaps
that's how this bridge deals with it.

Thanks,
Eric
