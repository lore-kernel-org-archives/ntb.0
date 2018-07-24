Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id f187-v6si280640ywa.2.2018.07.24.10.37.44
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 10:37:44 -0700 (PDT)
References: <20180720180034.3964-1-logang@deltatee.com>
 <20180720180034.3964-5-logang@deltatee.com>
 <CAJ80sat2gx3jaDi3LVDG6GhZ6qKmuKWxyaP_0VoR5k3VfGybqw@mail.gmail.com>
 <b14a3c42-4a23-bff5-3e1b-9a1423611230@deltatee.com>
 <CAJ80saunKS6hbNFBKjbQqSo32+KeLZurksCtnHNw-C35Zjq2Xw@mail.gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <8809f02e-93de-f81a-31e0-90f2c1983b70@deltatee.com>
Date: Tue, 24 Jul 2018 11:37:37 -0600
MIME-Version: 1.0
In-Reply-To: <CAJ80saunKS6hbNFBKjbQqSo32+KeLZurksCtnHNw-C35Zjq2Xw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 4/8] NTB: ntb_pingpong: Choose doorbells based on port
 number
To: Allen Hubbe <allenbh@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, Jon Mason <jdmason@kudzu.us>, fancer.lancer@gmail.com, Shyam-sundar.S-k@amd.com, shuah@kernel.org, dmeyer@gigaio.com
List-ID: <linux-ntb.googlegroups.com>



On 24/07/18 11:26 AM, Allen Hubbe wrote:
> On Mon, Jul 23, 2018 at 12:08 PM Logan Gunthorpe <logang@deltatee.com> wrote:
>> I don't think you'll ever have a case where two peers have the same
>> index, as the index is really an abstract concept the hardware doesn't
>> really know about.
> 
> That is the point of index, that there should never be two peers with
> the same index, and also that the range of index values is bounded.

Yes, I think we are making the same point.

> Port numbers are problematic, so I'm worried about the change to use
> port number in the client drivers instead of using index.  For
> example, this change assumes that the index value is < bits per long
> long, because the value is used in BIT_ULL(port number).

Huh?, I'm not making that change... We still use the index to refer to
the peer, but the resource we are using is based on the port number,
just as it was before my changes. Perhaps you can point out in my
patches what change you are worried about?

> Maybe I'm missing something...  In the crosslink case, there is
> another doorbell register on the other side of the crosslink.  Whether
> to use the nearby or via-crosslink doorbell depends on the peer
> index... making assumptions about the hw driver, but is that about
> right? 

Not really. Given that we know there are only two peers, we always use
the other side's doorbell register. You'd only use the nearby doorbell
register if you wanted to trigger your own interrupt -- that would be
weird and we don't really have the API sophistication to do that.

If we wanted to support multiple peers with some number in crosslink
then we'd need to revamp things _significantly_. In this case we'd have
multiple doorbell registers which each apply to a different subset of
peers. This gets _very_ complicated and hurts my head. But as I said,
I'm not trying to add new functionality for multi-peer crosslink or
anything like that. I'm just trying to fix the 2 crosslink peer case so
it works like it did when it was originally merged.

Logan
