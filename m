Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id s85-v6si348680pfk.4.2018.07.24.11.23.19
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 11:23:19 -0700 (PDT)
References: <20180720180034.3964-1-logang@deltatee.com>
 <20180720180034.3964-5-logang@deltatee.com>
 <CAJ80sat2gx3jaDi3LVDG6GhZ6qKmuKWxyaP_0VoR5k3VfGybqw@mail.gmail.com>
 <b14a3c42-4a23-bff5-3e1b-9a1423611230@deltatee.com>
 <CAJ80saunKS6hbNFBKjbQqSo32+KeLZurksCtnHNw-C35Zjq2Xw@mail.gmail.com>
 <8809f02e-93de-f81a-31e0-90f2c1983b70@deltatee.com>
 <CAJ80sauPtUBJ5q9iSGPArwvetBwEkjNaRmS_6adP5moK5ejLqg@mail.gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <8bc2ed4f-f032-c969-2e7f-f00135f567ec@deltatee.com>
Date: Tue, 24 Jul 2018 12:23:13 -0600
MIME-Version: 1.0
In-Reply-To: <CAJ80sauPtUBJ5q9iSGPArwvetBwEkjNaRmS_6adP5moK5ejLqg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 4/8] NTB: ntb_pingpong: Choose doorbells based on port
 number
To: Allen Hubbe <allenbh@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, Jon Mason <jdmason@kudzu.us>, fancer.lancer@gmail.com, Shyam-sundar.S-k@amd.com, shuah@kernel.org, dmeyer@gigaio.com
List-ID: <linux-ntb.googlegroups.com>



On 24/07/18 12:12 PM, Allen Hubbe wrote:
> On Tue, Jul 24, 2018 at 1:37 PM Logan Gunthorpe <logang@deltatee.com> wrote:
>> Not really. Given that we know there are only two peers, we always use
>> the other side's doorbell register. You'd only use the nearby doorbell
>> register if you wanted to trigger your own interrupt -- that would be
>> weird and we don't really have the API sophistication to do that.
>>
>> If we wanted to support multiple peers with some number in crosslink
>> then we'd need to revamp things _significantly_. In this case we'd have
>> multiple doorbell registers which each apply to a different subset of
>> peers. This gets _very_ complicated and hurts my head.
> 
> ...huh, looks like peer index was omitted from ntb_peer_db_set and
> friends.  Adding peer index there would make the interface consistent
> with other ntb_peer functions.  Peer index would allow the hw driver
> to select which doorbell register to use for each peer.  Adding a
> ntb_peer_db_valid_bits to that would allow a subset of bits in the
> shared register to be associated with each peer.

The way the switch hardware works (switchtec and I assume IDT) is that
there is only one doorbell register for all peers which can trigger any
peer that doesn't have the corresponding bit masked. So the way it was
designed without the index maxes sense except when we start to add
multi-peer crosslink insanity. I don't think adding a peer index would
be sufficient as the clients would need to know which peers share which
doorbells.

If I were to attempt something like this, I'd probably look at
introducing a segment index to the entire API. So that each switch in a
crosslink topology is it's own segment with it's own set of peers, peer
index space, doorbell registers, etc. But that's all very complicated
and messy and probably something I wouldn't even look at until we have
finished with traditional multi-host setups.

> I thought for sure ntb_peer_db_set already had peer index, and I was
> wrong.  Go ahead with the change as in your patch, I won't force the
> issue or that you to do that extra work and touch all the drivers
> again for this.  It can be addressed when there is renued interest in
> making things work more than one peer.
> 
> This patch, and the others in this series:
> Acked-by: Allen Hubbe <allenbh@gmail.com>

Thanks!

Logan

