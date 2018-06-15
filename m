Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf0-x243.google.com (mail-lf0-x243.google.com. [2a00:1450:4010:c07::243])
        by gmr-mx.google.com with ESMTPS id j15-v6si319437ljg.5.2018.06.15.12.51.14
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 12:51:14 -0700 (PDT)
Received: by mail-lf0-x243.google.com with SMTP id j13-v6so16223795lfb.13
        for <linux-ntb@googlegroups.com>; Fri, 15 Jun 2018 12:51:14 -0700 (PDT)
Return-Path: <fancer.lancer@gmail.com>
Date: Fri, 15 Jun 2018 22:51:22 +0300
From: Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH 7/8] NTB: perf: Fix race condition when run with ntb_test
Message-ID: <20180615195122.GA25387@mobilestation>
References: <20180609000819.13883-1-logang@deltatee.com>
 <20180609000819.13883-9-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180609000819.13883-9-logang@deltatee.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Shuah Khan <shuah@kernel.org>
List-ID: <linux-ntb.googlegroups.com>

On Fri, Jun 08, 2018 at 06:08:18PM -0600, Logan Gunthorpe <logang@deltatee.com> wrote:
> When running ntb_test, the script tries to run the ntb_perf test
> immediately after probing the modules. Since adding multi-port support,
> this fails seeing the new initialization procedure in ntb_perf
> can not complete instantly.
> 
> To fix this we add a completion which is waited on when a test is
> started. In this way, run can be written any time after the module is
> loaded and it will wait for the initialization to complete instead of
> sending an error.
> 

Hmm, this behavior is the feature of the driver and isn't a bug or race to be
fixed. ntb_perf driver returns -ENOLINK until the link is actually established,
when the memory windows are properly initialized so the test can be performed.
What do you think of leaving the algorithm as is, but instead to develop
the polling scheme in the ntb_test.sh script and break the script execution if
the link isn't established after sometime? At least we won't need to wait forever
in case if the peer hanged up or crashed while the NTB link negotiation algorithm
was in-progress.

Regards,
-Sergey

> Fixes: 5648e56d03fa ("NTB: ntb_perf: Add full multi-port NTB API support")
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  drivers/ntb/test/ntb_perf.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
> index 6285cb8515ac..8e2b7630ecc9 100644
> --- a/drivers/ntb/test/ntb_perf.c
> +++ b/drivers/ntb/test/ntb_perf.c
> @@ -158,6 +158,8 @@ struct perf_peer {
>  	/* NTB connection setup service */
>  	struct work_struct	service;
>  	unsigned long		sts;
> +
> +	struct completion init_comp;
>  };
>  #define to_peer_service(__work) \
>  	container_of(__work, struct perf_peer, service)
> @@ -549,6 +551,7 @@ static int perf_setup_outbuf(struct perf_peer *peer)
>  
>  	/* Initialization is finally done */
>  	set_bit(PERF_STS_DONE, &peer->sts);
> +	complete_all(&peer->init_comp);
>  
>  	return 0;
>  }
> @@ -639,6 +642,7 @@ static void perf_service_work(struct work_struct *work)
>  		perf_setup_outbuf(peer);
>  
>  	if (test_and_clear_bit(PERF_CMD_CLEAR, &peer->sts)) {
> +		init_completion(&peer->init_comp);
>  		clear_bit(PERF_STS_DONE, &peer->sts);
>  		if (test_bit(0, &peer->perf->busy_flag) &&
>  		    peer == peer->perf->test_peer) {
> @@ -1046,8 +1050,9 @@ static int perf_submit_test(struct perf_peer *peer)
>  	struct perf_thread *pthr;
>  	int tidx, ret;
>  
> -	if (!test_bit(PERF_STS_DONE, &peer->sts))
> -		return -ENOLINK;
> +	ret = wait_for_completion_interruptible(&peer->init_comp);
> +	if (ret < 0)
> +		return ret;
>  
>  	if (test_and_set_bit_lock(0, &perf->busy_flag))
>  		return -EBUSY;
> @@ -1413,6 +1418,7 @@ static int perf_init_peers(struct perf_ctx *perf)
>  			peer->gidx = pidx;
>  		}
>  		INIT_WORK(&peer->service, perf_service_work);
> +		init_completion(&peer->init_comp);
>  	}
>  	if (perf->gidx == -1)
>  		perf->gidx = pidx;
> -- 
> 2.11.0
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/20180609000819.13883-9-logang%40deltatee.com.
> For more options, visit https://groups.google.com/d/optout.
