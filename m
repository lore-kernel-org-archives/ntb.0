Return-Path: <jdmason@kudzu.us>
Received: from mail-io0-x244.google.com (mail-io0-x244.google.com. [2607:f8b0:4001:c06::244])
        by gmr-mx.google.com with ESMTPS id c202-v6si75032itc.1.2018.06.12.08.59.33
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 08:59:33 -0700 (PDT)
Received: by mail-io0-x244.google.com with SMTP id r24-v6so28659271ioh.9
        for <linux-ntb@googlegroups.com>; Tue, 12 Jun 2018 08:59:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180609000819.13883-4-logang@deltatee.com>
References: <20180609000819.13883-1-logang@deltatee.com> <20180609000819.13883-4-logang@deltatee.com>
From: Jon Mason <jdmason@kudzu.us>
Date: Tue, 12 Jun 2018 11:59:32 -0400
Message-ID: <CAPoiz9yF1c8ybJzA1ViUkvgxo2=u9ytTn6+kYuKv1HZSsUOuWw@mail.gmail.com>
Subject: Re: [PATCH 3/8] NTB: Fix the default port and peer numbers for legacy drivers
Content-Type: text/plain; charset="UTF-8"
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-ntb <linux-ntb@googlegroups.com>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Serge Semin <fancer.lancer@gmail.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Shuah Khan <shuah@kernel.org>
List-ID: <linux-ntb.googlegroups.com>

On Fri, Jun 8, 2018 at 8:08 PM, Logan Gunthorpe <logang@deltatee.com> wrote:
> When the commit adding ntb_default_port_number() and
> ntb_default_peer_port_number()  entered the kernel there was no
> users of it so it was impossible to tell what the API needed.
>
> When a user finally landed a year later (ntb_pingpong) there were
> more NTB topologies were created and no consideration was considered
> to how other drivers had changed.
>
> Now that there is a user it can be fixed to provide a sensible default
> for the legacy drivers that do not implement ntb_{peer_}port_number().
> Seeing ntb_pingpong doesn't check error codes returning EINVAL was also
> not sensible.
>
> Patches for ntb_pingpong and ntb_perf follow (which are broken
> otherwise) to support hardware that doesn't have port numbers. This is
> important not only to not break support with existing drivers but for
> the cross link topology which, due to its perfect symmetry, cannot
> assign unique port numbers to each side.

This is a very long way of saying "no clients are checking the error
codes, so removing them". :)
I think the history and references to follow-on patches are not
necessary in the commit message and belong more in a 0/X.

This is more of a feature than a bug fix.  Can you break this (and the
pingpong and perf changes caused by this) off into a separate series,
as I'll want to apply this to the ntb-next and not bugfixes branch?

Thanks,
Jon

> Fixes: 1e5301196a88 ("NTB: Add indexed ports NTB API")
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  drivers/ntb/ntb.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/ntb/ntb.c b/drivers/ntb/ntb.c
> index 93f24440d11d..d955a92a095a 100644
> --- a/drivers/ntb/ntb.c
> +++ b/drivers/ntb/ntb.c
> @@ -225,10 +225,8 @@ int ntb_default_port_number(struct ntb_dev *ntb)
>         case NTB_TOPO_B2B_DSD:
>                 return NTB_PORT_SEC_DSD;
>         default:
> -               break;
> +               return 0;
>         }
> -
> -       return -EINVAL;
>  }
>  EXPORT_SYMBOL(ntb_default_port_number);
>
> @@ -251,10 +249,8 @@ int ntb_default_peer_port_number(struct ntb_dev *ntb, int pidx)
>         case NTB_TOPO_B2B_DSD:
>                 return NTB_PORT_PRI_USD;
>         default:
> -               break;
> +               return 0;
>         }
> -
> -       return -EINVAL;
>  }
>  EXPORT_SYMBOL(ntb_default_peer_port_number);
>
> @@ -326,4 +322,3 @@ static void __exit ntb_driver_exit(void)
>         bus_unregister(&ntb_bus);
>  }
>  module_exit(ntb_driver_exit);
> -
> --
> 2.11.0
>
