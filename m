Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf0-x243.google.com (mail-lf0-x243.google.com. [2a00:1450:4010:c07::243])
        by gmr-mx.google.com with ESMTPS id z203-v6si324797lff.3.2018.06.15.12.49.21
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 12:49:21 -0700 (PDT)
Received: by mail-lf0-x243.google.com with SMTP id q11-v6so16241523lfc.7
        for <linux-ntb@googlegroups.com>; Fri, 15 Jun 2018 12:49:21 -0700 (PDT)
Return-Path: <fancer.lancer@gmail.com>
Date: Fri, 15 Jun 2018 22:49:29 +0300
From: Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH 4/8] NTB: ntb_pingpong: Choose doorbells based on port
 number
Message-ID: <20180615194929.GA24025@mobilestation>
References: <20180609000819.13883-1-logang@deltatee.com>
 <20180609000819.13883-5-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180609000819.13883-5-logang@deltatee.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Shuah Khan <shuah@kernel.org>
List-ID: <linux-ntb.googlegroups.com>

On Fri, Jun 08, 2018 at 06:08:14PM -0600, Logan Gunthorpe <logang@deltatee.com> wrote:
> This commit fixes pingpong support for existing drivers that do not
> implement ntb_default_port_number() and ntb_default_peer_port_number().
> This is required for hardware (like the crosslink topology of
> switchtec) which cannot assign reasonable port numbers to each port due
> to its perfect symmetry.
> 
> Instead of picking the doorbell to use based on the the index of the
> peer, we use the peer's port number. This is a bit clearer and easier
> to understand.
> 

Thanks for the patch. It was the original version of the ping-pong driver,
I was going to submit. But I've decided to develop it a bit different. And
here is why.

My goal was to create the multi-port version of the ping-pong test.
The idea of the new driver was to implement the cyclic port-to-port
ping-pong algorithm. Simply speaking each port selects two partner-ports,
one partner would be used as the source of pings and another one would be
target of pongs sent to with the defined delay.

Since IDT got a global Doorbell register, which is shared between all
the ports, I had to assign an unique doorbell bit to each port. I created a
simple algorithm, which linearised in general non-linear port numbers.
Then I used the globally unique port index to select the corresponding
doorbell bit. pp_init_flds() methods implements the corresponding algorithm,
while pp_find_next_peer() performs the next port selection to convey the
pong to.

Regarding the patch. The idea of using the port number instead of linearised
unique index should also work for Intel/AMD/IDT drivers. But the ports-space
linearization algorithm was created for the case if the real port numbers
would exceed the available Doorbell bits. I thought this might be the case of
multi-ports version of the switchtec driver.

Needless to say, that if Switchtec driver had the ports-index API implementation,
this patch wouldn't be needed.

Regards,
-Sergey

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
>  	link = ntb_link_is_up(pp->ntb, NULL, NULL);
>  
>  	/* Find next available peer */
> -	if (link & pp->nmask) {
> +	if (link & pp->nmask)
>  		pidx = __ffs64(link & pp->nmask);
> -		out_db = BIT_ULL(pidx + 1);
> -	} else if (link & pp->pmask) {
> +	else if (link & pp->pmask)
>  		pidx = __ffs64(link & pp->pmask);
> -		out_db = BIT_ULL(pidx);
> -	} else {
> +	else
>  		return -ENODEV;
> -	}
> +
> +	out_db = BIT_ULL(ntb_peer_port_number(pp->ntb, pidx));
>  
>  	spin_lock(&pp->lock);
>  	pp->out_pidx = pidx;
> @@ -303,7 +302,7 @@ static void pp_init_flds(struct pp_ctx *pp)
>  			break;
>  	}
>  
> -	pp->in_db = BIT_ULL(pidx);
> +	pp->in_db = BIT_ULL(lport);
>  	pp->pmask = GENMASK_ULL(pidx, 0) >> 1;
>  	pp->nmask = GENMASK_ULL(pcnt - 1, pidx);
>  
> @@ -435,4 +434,3 @@ static void __exit pp_exit(void)
>  	debugfs_remove_recursive(pp_dbgfs_topdir);
>  }
>  module_exit(pp_exit);
> -
> -- 
> 2.11.0
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/20180609000819.13883-5-logang%40deltatee.com.
> For more options, visit https://groups.google.com/d/optout.
