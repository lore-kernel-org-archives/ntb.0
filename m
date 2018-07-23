Return-Path: <allenbh@gmail.com>
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com. [2a00:1450:4864:20::42f])
        by gmr-mx.google.com with ESMTPS id d8-v6si277958wrj.2.2018.07.23.07.01.55
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 07:01:55 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id t6-v6so831112wrn.7
        for <linux-ntb@googlegroups.com>; Mon, 23 Jul 2018 07:01:55 -0700 (PDT)
MIME-Version: 1.0
References: <20180720180034.3964-1-logang@deltatee.com> <20180720180034.3964-5-logang@deltatee.com>
In-Reply-To: <20180720180034.3964-5-logang@deltatee.com>
From: Allen Hubbe <allenbh@gmail.com>
Date: Mon, 23 Jul 2018 10:01:44 -0400
Message-ID: <CAJ80sat2gx3jaDi3LVDG6GhZ6qKmuKWxyaP_0VoR5k3VfGybqw@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] NTB: ntb_pingpong: Choose doorbells based on port number
Content-Type: text/plain; charset="UTF-8"
To: logang@deltatee.com
Cc: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, Jon Mason <jdmason@kudzu.us>, fancer.lancer@gmail.com, Shyam-sundar.S-k@amd.com, shuah@kernel.org, dmeyer@gigaio.com
List-ID: <linux-ntb.googlegroups.com>

On Fri, Jul 20, 2018 at 2:00 PM Logan Gunthorpe <logang@deltatee.com> wrote:
>
> This commit fixes pingpong support for existing drivers that do not
> implement ntb_default_port_number() and ntb_default_peer_port_number().
> This is required for hardware (like the crosslink topology of
> switchtec) which cannot assign reasonable port numbers to each port due
> to its perfect symmetry.
>
> Instead of picking the doorbell to use based on the the index of the
> peer, we use the peer's port number. This is a bit clearer and easier
> to understand.

Does this solve the issue where two of the the port numbers are the
same, because of symmetry over a crosslink?  I think the two ports
with the "same" number should be identified as different peer index,
even if the port numbers are the same.

Maybe the port of any peer connected over the crosslink should be the
local switch's crosslink port.  The local port number might be needed
to configure translation tables in the local switch.  If a globally
unique port number is needed, maybe encode a chip number in some high
bits of the port number?  If a locally unique port number is needed,
maybe encode a path, that could be useful for configuring address
translations across multiple crosslinks.  Encoding a path, then each
port will have a different number, depending on the perspective of the
source port, which could be confusing (already, peer index is local
perspective, so can cause the same kind of confusion).  IMO port
number can be anything useful for specific ntb driver and devices, or
maybe just be informative, but peer index should be useful for ntb
client drivers.

> Fixes: c7aeb0afdcc2 ("NTB: ntb_pp: Add full multi-port NTB API support")
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  drivers/ntb/test/ntb_pingpong.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/ntb/test/ntb_pingpong.c b/drivers/ntb/test/ntb_pingpong.c
> index 65865e460ab8..18d00eec7b02 100644
> --- a/drivers/ntb/test/ntb_pingpong.c
> +++ b/drivers/ntb/test/ntb_pingpong.c
> @@ -121,15 +121,14 @@ static int pp_find_next_peer(struct pp_ctx *pp)
>         link = ntb_link_is_up(pp->ntb, NULL, NULL);
>
>         /* Find next available peer */
> -       if (link & pp->nmask) {
> +       if (link & pp->nmask)
>                 pidx = __ffs64(link & pp->nmask);
> -               out_db = BIT_ULL(pidx + 1);

Without +1 here, does this ring the same bell again?

> -       } else if (link & pp->pmask) {
> +       else if (link & pp->pmask)
>                 pidx = __ffs64(link & pp->pmask);
> -               out_db = BIT_ULL(pidx);
> -       } else {
> +       else
>                 return -ENODEV;
> -       }
> +
> +       out_db = BIT_ULL(ntb_peer_port_number(pp->ntb, pidx));

Can it not be made to work with peer index?

>
>         spin_lock(&pp->lock);
>         pp->out_pidx = pidx;
> @@ -303,7 +302,7 @@ static void pp_init_flds(struct pp_ctx *pp)
>                         break;
>         }
>
> -       pp->in_db = BIT_ULL(pidx);
> +       pp->in_db = BIT_ULL(lport);
>         pp->pmask = GENMASK_ULL(pidx, 0) >> 1;
>         pp->nmask = GENMASK_ULL(pcnt - 1, pidx);
>
> @@ -435,4 +434,3 @@ static void __exit pp_exit(void)
>         debugfs_remove_recursive(pp_dbgfs_topdir);
>  }
>  module_exit(pp_exit);
> -
> --
> 2.11.0
