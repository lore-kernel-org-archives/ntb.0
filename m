Return-Path: <allenbh@gmail.com>
Received: from mail-wm0-x236.google.com (mail-wm0-x236.google.com. [2a00:1450:400c:c09::236])
        by gmr-mx.google.com with ESMTPS id q17-v6si438661lfc.4.2018.07.24.10.26.24
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 10:26:24 -0700 (PDT)
Received: by mail-wm0-x236.google.com with SMTP id o18-v6so3346126wmc.0
        for <linux-ntb@googlegroups.com>; Tue, 24 Jul 2018 10:26:24 -0700 (PDT)
MIME-Version: 1.0
References: <20180720180034.3964-1-logang@deltatee.com> <20180720180034.3964-5-logang@deltatee.com>
 <CAJ80sat2gx3jaDi3LVDG6GhZ6qKmuKWxyaP_0VoR5k3VfGybqw@mail.gmail.com> <b14a3c42-4a23-bff5-3e1b-9a1423611230@deltatee.com>
In-Reply-To: <b14a3c42-4a23-bff5-3e1b-9a1423611230@deltatee.com>
From: Allen Hubbe <allenbh@gmail.com>
Date: Tue, 24 Jul 2018 13:26:12 -0400
Message-ID: <CAJ80saunKS6hbNFBKjbQqSo32+KeLZurksCtnHNw-C35Zjq2Xw@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] NTB: ntb_pingpong: Choose doorbells based on port number
Content-Type: text/plain; charset="UTF-8"
To: logang@deltatee.com
Cc: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, Jon Mason <jdmason@kudzu.us>, fancer.lancer@gmail.com, Shyam-sundar.S-k@amd.com, shuah@kernel.org, dmeyer@gigaio.com
List-ID: <linux-ntb.googlegroups.com>

On Mon, Jul 23, 2018 at 12:08 PM Logan Gunthorpe <logang@deltatee.com> wrote:
> I don't think you'll ever have a case where two peers have the same
> index, as the index is really an abstract concept the hardware doesn't
> really know about.

That is the point of index, that there should never be two peers with
the same index, and also that the range of index values is bounded.
Port numbers are problematic, so I'm worried about the change to use
port number in the client drivers instead of using index.  For
example, this change assumes that the index value is < bits per long
long, because the value is used in BIT_ULL(port number).

Maybe I'm missing something...  In the crosslink case, there is
another doorbell register on the other side of the crosslink.  Whether
to use the nearby or via-crosslink doorbell depends on the peer
index... making assumptions about the hw driver, but is that about
right?  Then you are selecting bits in the doorbell register based on
port number, ok, that must be how the bits of the shared db register
are associated with ports in your configuration.  Maybe what's
actually needed is a ntb_peer_db_valid_mask(peer index), and if only
the port-numbered db bit (or any other combination) is valid for that
peer, so be it, that can be an implementation choice of the hw driver
and below.
