Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id y15si3383870qtn.4.2019.01.07.17.16.10
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 17:16:10 -0800 (PST)
References: <1546830776-3138-1-git-send-email-joey.zhang@microchip.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <2dccf9e6-d9d7-200e-f689-56c962ea5e7e@deltatee.com>
Date: Mon, 7 Jan 2019 18:16:02 -0700
MIME-Version: 1.0
In-Reply-To: <1546830776-3138-1-git-send-email-joey.zhang@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] NTB: ntb_transport: Free MWs in
 ntb_transport_link_cleanup()
To: Joey Zhang <joey.zhang@microchip.com>, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>



On 06/01/19 08:12 PM, Joey Zhang wrote:
> If NTB peer host crashes or reboots, the NTB transport link will be
> down and the MWs of NTB transport will be invalid. But the
> ntb_transport_link_cleanup() does not free these invalid MWs. When
> the NTB peer host is recovered later, NTB transport link will be
> up and the ntb_set_mw() will not reset up MWs. Because the MWs of
> NTB transport are invalid, the NTB transport will not work.
> 
> We can fix it by freeing MWs when NTB transport link is down, then
> the ntb_set_mw() will reset up MWs when NTB transport link is up.
> 
> Signed-off-by: Joey Zhang <joey.zhang@microchip.com>

Looks ok to me.

Reviewed By: Logan Gunthorpe <logang@deltatee.com>

> ---
>  drivers/ntb/ntb_transport.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 3bfdb45..6e8902d 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -862,6 +862,9 @@ static void ntb_transport_link_cleanup(struct ntb_transport_ctx *nt)
>  	if (!nt->link_is_up)
>  		cancel_delayed_work_sync(&nt->link_work);
>  
> +	for (i = 0; i < nt->mw_count; i++)
> +		ntb_free_mw(nt, i);
> +
>  	/* The scratchpad registers keep the values if the remote side
>  	 * goes down, blast them now to give them a sane value the next
>  	 * time they are accessed
> 
