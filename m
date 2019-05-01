Return-Path: <kbusch@kernel.org>
Received: from mga03.intel.com (mga03.intel.com. [134.134.136.65])
        by gmr-mx.google.com with ESMTPS id a193si818102ywh.3.2019.05.01.09.04.01
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 09:04:01 -0700 (PDT)
Date: Wed, 1 May 2019 09:58:13 -0600
From: Keith Busch <kbusch@kernel.org>
Subject: Re: NVMe peer2peer TLPs over NTB getting split
Message-ID: <20190501155813.GB26910@localhost.localdomain>
References: <CAOQPn8vMn4h=oGWWKa3Uge7WYMkmRAmTyhR6RPjGVtrR1hfhOQ@mail.gmail.com>
 <4389bccb-6993-4a86-b4e4-202e971e2080@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4389bccb-6993-4a86-b4e4-202e971e2080@deltatee.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Eric Pilmore <epilmore@gigaio.com>, linux-ntb <linux-ntb@googlegroups.com>, linux-pci@vger.kernel.org, Armen Baloyan <abaloyan@gigaio.com>, D Meyer <dmeyer@gigaio.com>, S Taylor <staylor@gigaio.com>
List-ID: <linux-ntb.googlegroups.com>

On Tue, Apr 30, 2019 at 03:27:53PM -0600, Logan Gunthorpe wrote:
> On 2019-04-24 4:46 p.m., Eric Pilmore wrote:
> > Hi Folks,
> > 
> > Does anybody know why a Host Bridge might break up a full-sized (max
> > payload) TLP into single byte TLPs when those TLPs are traveling from
> > peer-to-peer?
> 
> Host bridges can't be relied on to do the right thing with respect to
> P2P. This is why the p2pdma code explicitly rejects them. Bad
> performance is often the symptom and splitting may be the cause (I've
> never bothered to stick an analyzer on it. There are patches floating
> around to add a whitelist to p2pdma which would be what you'd want to do
> and avoid anything that doesn't go through a switch.

Note that Max Payload Size may not be the same across root ports,
so splitting transactions may be the correct thing to do under some
circumstances. Kernel parameter "pci=pcie_bus_peer2peer" should make
all MPS settings the same, though I doubt that will help for the
hardware desribed here.
