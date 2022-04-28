Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A059E7B
	for <ntb@lists.linux.dev>; Thu, 28 Apr 2022 11:28:03 +0000 (UTC)
Received: by mail-lj1-f169.google.com with SMTP id y19so6283285ljd.4
        for <ntb@lists.linux.dev>; Thu, 28 Apr 2022 04:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HwZkqEXv4w7b8jkMu+iMCwLDxmNEnbxpNvbedQSzv/o=;
        b=FNlJO2il4A+SkRJKMM79JaelRaYrBvPXdZw8YrQPC0XhDfykhoYdrreYdiZpQvXXxf
         ZaKOumdlDR6KIyqk2dRVjYzVsVp89ymFqCgw2yXUvKZA9716iiNdIVSRiUaBG5OG+2BK
         6lkHptAfvtLFEsdSqX7Bgh3cFMrSS87MIs1ePmd0N/MRP5WqlCE2v92tAsCQpUfcW6xg
         fKL/eS5Q2x2TEYpeotKdA1YDTt0YQLh3gugbLNJZRsrMH68lockJzo9ior2E2EqK0pgo
         MNRHS8zMM/u6gpTWew3d52fNCHOTDYJRaaKvCA7eqLCahLyX7VtBYM+uL6+fPlpNLDjA
         N1+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HwZkqEXv4w7b8jkMu+iMCwLDxmNEnbxpNvbedQSzv/o=;
        b=E+k8zgglIz6nTbTCrSQlUYdUvpeuSkOM5v027JuKs5lnv0yQhd+fVXkBzrOKddkFdY
         IfjDfAY3gWA//zIABmJzu2M+TB3/cHq+APFe4SHk8sM8D6zlspafE8bCV5P6u913o7SL
         uiDF8gMkT3kWO/fPBypTQxDzyLGH5S2kXjMDnM+cTl+0ONhg0ZsEhOvP/jJAs43rEzUs
         Ov3gWwSiqIsbFCk+fTY8wA2dtD286Y4/p5XzXKiOPEcU6li5iN6RN2OtrCRLWuxfExSQ
         zbyVd8LyKLw08yGLXryG09Tqd1c0iR+p4Ze+sAjxqDR6ZFK0ADBLrbQBwemC/DO0qM9A
         bxAQ==
X-Gm-Message-State: AOAM533xQ7Bw5+N6jC7aVrheJi11aa6qEOiZSl3kSl2+3vWNQtDPXI24
	yIh7iS4nhW2Sah8ToUtj92I=
X-Google-Smtp-Source: ABdhPJyk91AmsezHXBExRqOcLWE1jUWU2HOO1bSD9h7/dqTJGTH3yUka7zscjCtY9IBefxbIDLHzeQ==
X-Received: by 2002:a05:651c:1145:b0:24f:22fe:360c with SMTP id h5-20020a05651c114500b0024f22fe360cmr8250686ljo.54.1651145281506;
        Thu, 28 Apr 2022 04:28:01 -0700 (PDT)
Received: from mobilestation.baikal.int (mail.baikalelectronics.com. [87.245.175.226])
        by smtp.gmail.com with ESMTPSA id bn38-20020a05651c17a600b0024b507c5cebsm2101617ljb.126.2022.04.28.04.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 04:28:00 -0700 (PDT)
Date: Thu, 28 Apr 2022 14:27:58 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Alexander Fomichev <fomichev.ru@gmail.com>
Cc: ntb@lists.linux.dev, linux@yadro.com, Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
	Guo Zhengkui <guozhengkui@vivo.com>,
	Alexander Fomichev <a.fomichev@yadro.com>
Subject: Re: [PATCH v2 1/3] ntb_perf: extend with burst latency measurement
Message-ID: <20220428112721.r2l44c5yeylmgksr@mobilestation.baikal.int>
References: <20220422113703.48820-1-fomichev.ru@gmail.com>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422113703.48820-1-fomichev.ru@gmail.com>

Hello Alexander

On Fri, Apr 22, 2022 at 02:37:01PM +0300, Alexander Fomichev wrote:
> From: Alexander Fomichev <a.fomichev@yadro.com>
> 
> The ntb_perf test provides a tool for NTB hardware performance
> evaluation. For software impact elimination the test uses a simple method
> (let's call it 'burst' mode), when the local system sends to the remote
> system a data set and counts time interval until hardware completion
> report, without the remote side confirming, nor data integrity check.
> The measured metric is a 'burst' throughput bandwidth of NTB connection.
> 
> The proposed change extends ntb_perf with 1 of 3 new metrics. The resulting
> test is fully backward compatible.
> 
> 1. Burst latency. It's a delay between start to send 1 byte to the
> remote system and hardware readiness to send another byte. The
> measurement performed within bandwidth test procedure. The DMA Engine is
> off. Data integrity is not checked. This mode can be disabled by
> 'perf_latency=N' module parameter.
> 
> Signed-off-by: Alexander Fomichev <a.fomichev@yadro.com>
> ---
>  drivers/ntb/test/ntb_perf.c | 135 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 132 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
> index 65e1e5cf1b29..79faa4a7fe94 100644
> --- a/drivers/ntb/test/ntb_perf.c
> +++ b/drivers/ntb/test/ntb_perf.c
> @@ -106,6 +106,9 @@ MODULE_DESCRIPTION("PCIe NTB Performance Measurement Tool");
>  
>  #define PERF_BUF_LEN 1024
>  
> +#define LAT_MIN_TRIES	20
> +#define RESCHEDULE_RATIO	10000
> +
>  static unsigned long max_mw_size;
>  module_param(max_mw_size, ulong, 0644);
>  MODULE_PARM_DESC(max_mw_size, "Upper limit of memory window size");
> @@ -122,6 +125,14 @@ static bool use_dma; /* default to 0 */
>  module_param(use_dma, bool, 0644);
>  MODULE_PARM_DESC(use_dma, "Use DMA engine to measure performance");
>  
> +static bool perf_latency = true;
> +module_param(perf_latency, bool, 0644);
> +MODULE_PARM_DESC(perf_latency, "Also measure latency");
> +
> +static unsigned long lat_time_ms = 1000; /* default 1s */
> +module_param(lat_time_ms, ulong, 0644);
> +MODULE_PARM_DESC(lat_time_ms, "Time (in ms) to test latency");
> +
>  /*==============================================================================
>   *                         Perf driver data definition
>   *==============================================================================
> @@ -178,6 +189,8 @@ struct perf_thread {
>  	void *src;
>  	u64 copied;
>  	ktime_t duration;
> +	ktime_t latency;
> +	u64 tries;
>  	int status;
>  	struct work_struct work;
>  };
> @@ -783,7 +796,7 @@ static void perf_dma_copy_callback(void *data)
>  }
>  
>  static int perf_copy_chunk(struct perf_thread *pthr,
> -			   void __iomem *dst, void *src, size_t len)
> +			   void __iomem *dst, void *src, size_t len, bool use_dma_)
>  {
>  	struct dma_async_tx_descriptor *tx;
>  	struct dmaengine_unmap_data *unmap;
> @@ -794,7 +807,7 @@ static int perf_copy_chunk(struct perf_thread *pthr,
>  	void __iomem *dst_vaddr;
>  	dma_addr_t dst_dma_addr;
>  

> -	if (!use_dma) {
> +	if (!use_dma_) {

The postfixed underscore is less distinctive from the postfix-less
name than the prefixed one. Anyway seeing the dma-less code is just a
small subset of the generic perf copy method I'd suggest to just split
the method up into two: perf_dma_copy_chunk() and
perf_mem_copy_chunk(). It will be more readable to call one of them
depending on the code context or on the global 'use_dma' flag state.

>  		memcpy_toio(dst, src, len);
>  		goto ret_check_tsync;
>  	}
> @@ -940,7 +953,7 @@ static int perf_run_test(struct perf_thread *pthr)
>  
>  	/* Copied field is cleared on test launch stage */
>  	while (pthr->copied < total_size) {
> -		ret = perf_copy_chunk(pthr, flt_dst, flt_src, chunk_size);
> +		ret = perf_copy_chunk(pthr, flt_dst, flt_src, chunk_size, use_dma);
>  		if (ret) {
>  			dev_err(&perf->ntb->dev, "%d: Got error %d on test\n",
>  				pthr->tidx, ret);
> @@ -1018,6 +1031,66 @@ static void perf_clear_test(struct perf_thread *pthr)
>  	kfree(pthr->src);
>  }
>  
> +static int perf_run_latency(struct perf_thread *pthr)
> +{

> +	struct perf_peer *peer = pthr->perf->test_peer;
> +	struct ntb_dev *ntb = pthr->perf->ntb;
> +	void *flt_src;
> +	void __iomem *flt_dst, *bnd_dst;
> +	int ret;
> +	u64 stop_at = ktime_get_real_fast_ns() + lat_time_ms * NSEC_PER_MSEC;

Please preserve the reverse xmas tree order of the local variables
definition for the consistency with the main part of the rest of the driver
methods.

Also I'd suggest to move the 'stop_at' variable initialization out of
the definition block to a some-line before the while loop. Thus the
time measurements will look more localized.

> +

> +	pthr->tries = 0;

I don't see you functionally using the 'tries' field anywhere but in
this method. What about defining it locally? (See my next comments for
more about the 'tries' field.)

> +	pthr->latency = ktime_get();
> +	flt_src = pthr->src;
> +	flt_dst = peer->outbuf;
> +	bnd_dst = peer->outbuf + peer->outbuf_size;
> +
> +	while (ktime_get_real_fast_ns() < stop_at) {
> +		ret = perf_copy_chunk(pthr, flt_dst, flt_src, 1, false);
> +		if (ret) {
> +			dev_err(&ntb->dev, "%d: Latency testing error %d\n",
> +				pthr->tidx, ret);
> +			pthr->latency = ktime_set(0, 0);
> +			return ret;
> +		}
> +
> +		pthr->tries++;
> +		flt_dst++;
> +		flt_src++;
> +
> +		if (flt_dst >= bnd_dst || flt_dst < peer->outbuf) {
> +			flt_dst = peer->outbuf;
> +			flt_src = pthr->src;
> +		}
> +
> +		/* Avoid processor soft lock-ups */
> +		if (!(pthr->tries % RESCHEDULE_RATIO))
> +			schedule();
> +	}
> +
> +	/* Stop timer */
> +	pthr->latency = ktime_sub(ktime_get(), pthr->latency);
> +


> +	if (pthr->tries < LAT_MIN_TRIES) {

Hm, why 20 is enough? If you think that at least 20 re-tries must be
performed, then why would you need the lat_time_ms parameter at all?
I'd suggest to either define a lat_tries_cnt parameter instead or drop
that parameter and use a fixed number of retries (20, 30, whatever you
think would be enough to get a more-or-less precise mean latency).

(See my last comment in this context.)

> +		dev_err(&ntb->dev, "%d: Too few steps (%d) to measure Latency, "
> +			"recommended > %d. Increase value of 'lat_time_ms' "
> +			"parameter\n", pthr->tidx, pthr->tries, LAT_MIN_TRIES);

Please no for the string breakage (see '2. Breaking long lines and
strings' in Documentation/process/coding-style.rst).

> +		pthr->latency = ktime_set(0, 0);
> +		return -EINVAL;
> +	}
> +
> +	dev_dbg(&ntb->dev, "%d: made %llu tries, lasted %llu usecs\n",
> +		pthr->tidx, pthr->tries, ktime_to_us(pthr->latency));
> +
> +	pthr->latency = ns_to_ktime(ktime_divns(pthr->latency, pthr->tries));
> +
> +	dev_dbg(&ntb->dev, "%d: latency %llu us (%llu ns)\n", pthr->tidx,
> +		ktime_to_us(pthr->latency), ktime_to_ns(pthr->latency));
> +
> +	return 0;
> +}
> +
>  static void perf_thread_work(struct work_struct *work)
>  {
>  	struct perf_thread *pthr = to_thread_work(work);
> @@ -1043,6 +1116,11 @@ static void perf_thread_work(struct work_struct *work)
>  	}
>  
>  	pthr->status = perf_sync_test(pthr);
> +	if (pthr->status)
> +		goto err_clear_test;
> +
> +	if (perf_latency)
> +		pthr->status = perf_run_latency(pthr);
>  
>  err_clear_test:
>  	perf_clear_test(pthr);
> @@ -1142,6 +1220,18 @@ static int perf_read_stats(struct perf_ctx *perf, char *buf,
>  			"%d: copied %llu bytes in %llu usecs, %llu MBytes/s\n",
>  			tidx, pthr->copied, ktime_to_us(pthr->duration),
>  			div64_u64(pthr->copied, ktime_to_us(pthr->duration)));
> +
> +		if (perf_latency && ktime_compare(pthr->latency, ktime_set(0, 0))) {
> +			if (ktime_to_us(pthr->latency) < 10) {
> +				(*pos) += scnprintf(buf + *pos, size - *pos,
> +						"%d: latency %llu ns\n",
> +						tidx, ktime_to_ns(pthr->latency));
> +			} else {
> +				(*pos) += scnprintf(buf + *pos, size - *pos,
> +						"%d: latency %llu us\n",
> +						tidx, ktime_to_us(pthr->latency));
> +			}
> +		}
>  	}
>  
>  	clear_bit_unlock(0, &perf->busy_flag);
> @@ -1344,12 +1434,48 @@ static ssize_t perf_dbgfs_write_tcnt(struct file *filep,
>  	return size;
>  }
>  
> +static ssize_t perf_dbgfs_read_lattrs(struct file *filep, char __user *ubuf,
> +				    size_t size, loff_t *offp)
> +{
> +	struct perf_ctx *perf = filep->private_data;
> +	char *buf;
> +	ssize_t pos, ret;
> +	size_t buf_size = min_t(size_t, size, PERF_BUF_LEN);
> +	int tidx;
> +
> +	buf = kmalloc(buf_size, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	pos = scnprintf(buf, buf_size, "    Peer %d latency try count:\n",
> +			perf->test_peer->pidx);
> +
> +	for (tidx = 0; tidx < perf->tcnt; tidx++) {
> +		struct perf_thread *pthr = &perf->threads[tidx];
> +

> +		pos += scnprintf(buf + pos, buf_size - pos,
> +			"%d: made %llu tries\n",
> +			tidx, pthr->tries);

AFAIU from the patch log the main goal of this patch is to add the IO
latency measurement functionality. Why would you need to print the
number of reties then? I don't find it much informative especially
seeing you are already printing the available mean latency. I'd rather
drop the 'latency_tries' entry.

-Sergey

> +	}
> +
> +	ret = simple_read_from_buffer(ubuf, size, offp, buf, pos);
> +
> +	kfree(buf);
> +
> +	return ret;
> +}
> +
>  static const struct file_operations perf_dbgfs_tcnt = {
>  	.open = simple_open,
>  	.read = perf_dbgfs_read_tcnt,
>  	.write = perf_dbgfs_write_tcnt
>  };
>  
> +static const struct file_operations perf_dbgfs_lattrs = {
> +	.open = simple_open,
> +	.read = perf_dbgfs_read_lattrs
> +};
> +
>  static void perf_setup_dbgfs(struct perf_ctx *perf)
>  {
>  	struct pci_dev *pdev = perf->ntb->pdev;
> @@ -1375,6 +1501,9 @@ static void perf_setup_dbgfs(struct perf_ctx *perf)
>  	debugfs_create_u8("total_order", 0500, perf->dbgfs_dir, &total_order);
>  
>  	debugfs_create_bool("use_dma", 0500, perf->dbgfs_dir, &use_dma);
> +
> +	debugfs_create_file("latency_tries", 0400, perf->dbgfs_dir, perf,
> +			    &perf_dbgfs_lattrs);
>  }
>  
>  static void perf_clear_dbgfs(struct perf_ctx *perf)
> -- 
> 2.30.2
> 
> 
