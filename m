Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf0-x22b.google.com (mail-lf0-x22b.google.com. [2a00:1450:4010:c07::22b])
        by gmr-mx.google.com with ESMTPS id a6-v6si191928wmg.4.2018.06.15.12.48.40
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 12:48:40 -0700 (PDT)
Received: by mail-lf0-x22b.google.com with SMTP id o9-v6so16260115lfk.1
        for <linux-ntb@googlegroups.com>; Fri, 15 Jun 2018 12:48:40 -0700 (PDT)
Return-Path: <fancer.lancer@gmail.com>
Date: Fri, 15 Jun 2018 22:48:48 +0300
From: Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH 3/8] NTB: Fix the default port and peer numbers for
 legacy drivers
Message-ID: <20180615194848.GA22880@mobilestation>
References: <20180609000819.13883-1-logang@deltatee.com>
 <20180609000819.13883-4-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180609000819.13883-4-logang@deltatee.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Shuah Khan <shuah@kernel.org>
List-ID: <linux-ntb.googlegroups.com>

On Fri, Jun 08, 2018 at 06:08:13PM -0600, Logan Gunthorpe <logang@deltatee.com> wrote:
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
> 
> Fixes: 1e5301196a88 ("NTB: Add indexed ports NTB API")
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

As a part of the multi-port NTB API the port-index interface was freshly
introduced. The main idea was to somehow address local/peer domains within one
NTB device, since from now there can be more than one peer domain to send
message to or to set MWs up with. For this we invented the two-spaces interface
which mapped in general non-linear ports space to the locally linear ports
indexes space, and vise-versa. That mapping was implemented by new callbacks:
ntb_port*()/ntb_peer_port*().

Even though it perfectly fitted the IDT NTB functions, the Intel/AMD devices
didn't have explicit ports numbering. Instead we decided to assign the numbers
by using the topology type. So the Primary and B2B US sides got port
NTB_PORT_PRI_USD, Secondary and B2B DS sides got port NTB_PORT_SEC_DSD.
In order to make it being default for all pure two-ports devices like
Intel/AMD the new methods ntb_default_port_number() and
ntb_default_peer_port_number() were developed and utilized in the
ntb_port*()/ntb_peer_port*() API functions (see ntb.h header file).

So to speak the main purpose of the default methods is to assign some unique
port number to the NTB devices based on the topology at current implementation.
Please note, that it is essential for the NTB API to have each port uniquely
enumerated within one device. This is the way the multi-port NTB API has been
designed in the first place. That was the reason we altered the Intel/AMD and
IDT drivers about two years ago.

Based on this I redeveloped the ntb_tool/ntb_perf/ntb_pingpong drivers.
Needless to say that I was sure all the NTB devices followed the API convention
regarding the port numbers. Since the Switchtec driver doesn't provide the
explicit port-index API callbacks, the NTB API internals uses the default
methods, which as you can see don't know anything about SWITCH and CROSSLINK
topologies. That's why the methods return -EINVAL so the test drivers don't
work properly.

Concerning the fix of the discovered issues and fixes introduced by this
patchset. I'd suggest to add the ports-index callbacks to the Switchtec
driver, which identify local and peer ports. After this the current version
of all the test drivers shall perfectly work.

As far as I can see the PFX family switches documentation operates with the
definitions like Ports/Partitions (similar to the IDT switches) as well as
the switchtec management driver. It might be a clue to the switch functionality,
which can be used to find something similar to the ports numbering.

Regards,
-Sergey

> ---
>  drivers/ntb/ntb.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/ntb/ntb.c b/drivers/ntb/ntb.c
> index 93f24440d11d..d955a92a095a 100644
> --- a/drivers/ntb/ntb.c
> +++ b/drivers/ntb/ntb.c
> @@ -225,10 +225,8 @@ int ntb_default_port_number(struct ntb_dev *ntb)
>  	case NTB_TOPO_B2B_DSD:
>  		return NTB_PORT_SEC_DSD;
>  	default:
> -		break;
> +		return 0;
>  	}
> -
> -	return -EINVAL;
>  }
>  EXPORT_SYMBOL(ntb_default_port_number);
>  
> @@ -251,10 +249,8 @@ int ntb_default_peer_port_number(struct ntb_dev *ntb, int pidx)
>  	case NTB_TOPO_B2B_DSD:
>  		return NTB_PORT_PRI_USD;
>  	default:
> -		break;
> +		return 0;
>  	}
> -
> -	return -EINVAL;
>  }
>  EXPORT_SYMBOL(ntb_default_peer_port_number);
>  
> @@ -326,4 +322,3 @@ static void __exit ntb_driver_exit(void)
>  	bus_unregister(&ntb_bus);
>  }
>  module_exit(ntb_driver_exit);
> -
> -- 
> 2.11.0
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/20180609000819.13883-4-logang%40deltatee.com.
> For more options, visit https://groups.google.com/d/optout.
