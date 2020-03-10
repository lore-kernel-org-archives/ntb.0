Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id q1si8390pff.4.2020.03.10.14.31.13
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 14:31:13 -0700 (PDT)
References: <1583873694-19151-1-git-send-email-sanju.mehta@amd.com>
 <1583873694-19151-3-git-send-email-sanju.mehta@amd.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <3c350277-8fe6-04b2-673e-7d4c8fb6ce24@deltatee.com>
Date: Tue, 10 Mar 2020 15:31:10 -0600
MIME-Version: 1.0
In-Reply-To: <1583873694-19151-3-git-send-email-sanju.mehta@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 2/5] ntb_perf: send command in response to EAGAIN
To: Sanjay R Mehta <sanju.mehta@amd.com>, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, arindam.nath@amd.com, Shyam-sundar.S-k@amd.com
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>



On 2020-03-10 2:54 p.m., Sanjay R Mehta wrote:
> From: Arindam Nath <arindam.nath@amd.com>
> 
> perf_spad_cmd_send() and perf_msg_cmd_send() return
> -EAGAIN after trying to send commands for a maximum
> of MSG_TRIES re-tries. But currently there is no
> handling for this error. These functions are invoked
> from perf_service_work() through function pointers,
> so rather than simply call these functions is not
> enough. We need to make sure to invoke them again in
> case of -EAGAIN. Since peer status bits were cleared
> before calling these functions, we set the same status
> bits before queueing the work again for later invocation.
> This way we simply won't go ahead and initialize the
> XLAT registers wrongfully in case sending the very first
> command itself fails.

So what happens if there's an actual non-recoverable error that causes
perf_msg_cmd_send() to fail? Are you proposing it just requeues high
priority work forever?

I never really reviewed this stuff properly but it looks like it has a
bunch of problems. Using the high priority work queue for some low
priority setup work seems wrong, at the very least. The spad and msg
send loops also look like they have a bunch of inter-host race condition
problems as well. Yikes.

Logan



> Signed-off-by: Arindam Nath <arindam.nath@amd.com>
> Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
> ---
>  drivers/ntb/test/ntb_perf.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
> index 6d16628..9068e42 100644
> --- a/drivers/ntb/test/ntb_perf.c
> +++ b/drivers/ntb/test/ntb_perf.c
> @@ -625,14 +625,24 @@ static void perf_service_work(struct work_struct *work)
>  {
>  	struct perf_peer *peer = to_peer_service(work);
>  
> -	if (test_and_clear_bit(PERF_CMD_SSIZE, &peer->sts))
> -		perf_cmd_send(peer, PERF_CMD_SSIZE, peer->outbuf_size);
> +	if (test_and_clear_bit(PERF_CMD_SSIZE, &peer->sts)) {
> +		if (perf_cmd_send(peer, PERF_CMD_SSIZE, peer->outbuf_size)
> +		    == -EAGAIN) {
> +			set_bit(PERF_CMD_SSIZE, &peer->sts);
> +			(void)queue_work(system_highpri_wq, &peer->service);
> +		}
> +	}
>  
>  	if (test_and_clear_bit(PERF_CMD_RSIZE, &peer->sts))
>  		perf_setup_inbuf(peer);
>  
> -	if (test_and_clear_bit(PERF_CMD_SXLAT, &peer->sts))
> -		perf_cmd_send(peer, PERF_CMD_SXLAT, peer->inbuf_xlat);
> +	if (test_and_clear_bit(PERF_CMD_SXLAT, &peer->sts)) {
> +		if (perf_cmd_send(peer, PERF_CMD_SXLAT, peer->inbuf_xlat)
> +		    == -EAGAIN) {
> +			set_bit(PERF_CMD_SXLAT, &peer->sts);
> +			(void)queue_work(system_highpri_wq, &peer->service);
> +		}
> +	}
>  
>  	if (test_and_clear_bit(PERF_CMD_RXLAT, &peer->sts))
>  		perf_setup_outbuf(peer);
> 
