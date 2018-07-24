Return-Path: <allenbh@gmail.com>
Received: from mail-wm0-x235.google.com (mail-wm0-x235.google.com. [2a00:1450:400c:c09::235])
        by gmr-mx.google.com with ESMTPS id a7-v6si410947ljj.1.2018.07.24.11.12.23
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 11:12:23 -0700 (PDT)
Received: by mail-wm0-x235.google.com with SMTP id t25-v6so3428469wmi.3
        for <linux-ntb@googlegroups.com>; Tue, 24 Jul 2018 11:12:23 -0700 (PDT)
MIME-Version: 1.0
References: <20180720180034.3964-1-logang@deltatee.com> <20180720180034.3964-5-logang@deltatee.com>
 <CAJ80sat2gx3jaDi3LVDG6GhZ6qKmuKWxyaP_0VoR5k3VfGybqw@mail.gmail.com>
 <b14a3c42-4a23-bff5-3e1b-9a1423611230@deltatee.com> <CAJ80saunKS6hbNFBKjbQqSo32+KeLZurksCtnHNw-C35Zjq2Xw@mail.gmail.com>
 <8809f02e-93de-f81a-31e0-90f2c1983b70@deltatee.com>
In-Reply-To: <8809f02e-93de-f81a-31e0-90f2c1983b70@deltatee.com>
From: Allen Hubbe <allenbh@gmail.com>
Date: Tue, 24 Jul 2018 14:12:11 -0400
Message-ID: <CAJ80sauPtUBJ5q9iSGPArwvetBwEkjNaRmS_6adP5moK5ejLqg@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] NTB: ntb_pingpong: Choose doorbells based on port number
Content-Type: text/plain; charset="UTF-8"
To: logang@deltatee.com
Cc: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, Jon Mason <jdmason@kudzu.us>, fancer.lancer@gmail.com, Shyam-sundar.S-k@amd.com, shuah@kernel.org, dmeyer@gigaio.com
List-ID: <linux-ntb.googlegroups.com>

On Tue, Jul 24, 2018 at 1:37 PM Logan Gunthorpe <logang@deltatee.com> wrote:
> Not really. Given that we know there are only two peers, we always use
> the other side's doorbell register. You'd only use the nearby doorbell
> register if you wanted to trigger your own interrupt -- that would be
> weird and we don't really have the API sophistication to do that.
>
> If we wanted to support multiple peers with some number in crosslink
> then we'd need to revamp things _significantly_. In this case we'd have
> multiple doorbell registers which each apply to a different subset of
> peers. This gets _very_ complicated and hurts my head.

...huh, looks like peer index was omitted from ntb_peer_db_set and
friends.  Adding peer index there would make the interface consistent
with other ntb_peer functions.  Peer index would allow the hw driver
to select which doorbell register to use for each peer.  Adding a
ntb_peer_db_valid_bits to that would allow a subset of bits in the
shared register to be associated with each peer.

I think that's all that would need to change, not significantly more,
to support multiple doorbell registers associated with different
subsets of peers.  The complication would at least be hidden in the hw
driver, where it would need to maintain some mapping from peer index
to the right set of registers.

> But as I said,
> I'm not trying to add new functionality for multi-peer crosslink or
> anything like that. I'm just trying to fix the 2 crosslink peer case so
> it works like it did when it was originally merged.

I thought for sure ntb_peer_db_set already had peer index, and I was
wrong.  Go ahead with the change as in your patch, I won't force the
issue or that you to do that extra work and touch all the drivers
again for this.  It can be addressed when there is renued interest in
making things work more than one peer.

This patch, and the others in this series:
Acked-by: Allen Hubbe <allenbh@gmail.com>
