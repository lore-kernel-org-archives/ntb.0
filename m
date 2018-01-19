Return-Path: <jdmason@kudzu.us>
Received: from mail-qt0-x22a.google.com (mail-qt0-x22a.google.com. [2607:f8b0:400d:c0d::22a])
        by gmr-mx.google.com with ESMTPS id q187si682274iof.3.2018.01.19.07.43.04
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jan 2018 07:43:04 -0800 (PST)
Received: by mail-qt0-x22a.google.com with SMTP id e2so4803537qti.0
        for <linux-ntb@googlegroups.com>; Fri, 19 Jan 2018 07:43:04 -0800 (PST)
Return-Path: <jdmason@kudzu.us>
Date: Fri, 19 Jan 2018 10:43:01 -0500
From: Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH] NTB: ntb_perf: fix printing of resource_size_t
Message-ID: <20180119154300.GA23366@kudzu.us>
References: <20180119145813.1141817-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180119145813.1141817-1-arnd@arndb.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Gary R Hook <gary.hook@amd.com>, Serge Semin <fancer.lancer@gmail.com>, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

On Fri, Jan 19, 2018 at 03:55:28PM +0100, Arnd Bergmann wrote:
> On 32-bit architectures, resource_size_t is usually 'unsigned int' or
> 'unsigned long' but not 'unsigned long long', so we get a warning
> about printing the wrong data:
> 
> drivers/ntb/test/ntb_perf.c: In function 'perf_setup_peer_mw':
> drivers/ntb/test/ntb_perf.c:1390:35: error: format '%llx' expects argument of type 'long long unsigned int', but argument 4 has type 'resource_size_t {aka unsigned int}' [-Werror=format=]
> 
> This changes the format string to the special %pa that is already
> used elsewhere in the same file.

Applied to my ntb-next branch.

Thanks,
Jon

> 
> Fixes: b83003b3fdc1 ("NTB: ntb_perf: Add full multi-port NTB API support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/ntb/test/ntb_perf.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
> index 8de72f3fba4d..1829a17dd461 100644
> --- a/drivers/ntb/test/ntb_perf.c
> +++ b/drivers/ntb/test/ntb_perf.c
> @@ -1387,8 +1387,8 @@ static int perf_setup_peer_mw(struct perf_peer *peer)
>  	if (max_mw_size && peer->outbuf_size > max_mw_size) {
>  		peer->outbuf_size = max_mw_size;
>  		dev_warn(&peer->perf->ntb->dev,
> -			"Peer %d outbuf reduced to %#llx\n", peer->pidx,
> -			peer->outbuf_size);
> +			"Peer %d outbuf reduced to %pa\n", peer->pidx,
> +			&peer->outbuf_size);
>  	}
>  
>  	return 0;
> -- 
> 2.9.0
> 
