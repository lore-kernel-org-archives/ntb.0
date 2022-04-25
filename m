Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70D67E
	for <ntb@lists.linux.dev>; Mon, 25 Apr 2022 16:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650905385; x=1682441385;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IdJT1fMG2/OjJxII/sFPgg/FnXtyqRnsapvr7gTj5NA=;
  b=jfHB8KH5PSoCGaWgrh76W0vr98M9FCl2KhGHID5JGW4R0H0JExKrL/9d
   HStJcG9Pb4kGB1K9rlpHQhVZfezJxGE1VEytRjjmmejXU5CUDkLSfzY4I
   tP9lK5rRatmtMvmIdrkESm+B5tbW0+WKEpZiS4btKEcpaoeVJbCpuTPBC
   C5l71k6hep3teTLpU5a6GvQ9d6RG0C2RGa39D32ZK4PRclsNWeHLRBJo1
   S2yv6qMYw+4o+3x7Yzu0QNTVc+MvEO6cL0rNz7YU+r21DRlAL8jHZln0A
   guKVRvspiLRil3/UzBNw5KzVNQ4Lm9JPJxXIBsMdIf9cbEZ3rYQzmLCfd
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="245228850"
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="245228850"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 09:49:45 -0700
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="532204491"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.213.188.210]) ([10.213.188.210])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 09:49:44 -0700
Message-ID: <384e2fc0-27be-00f9-974d-70a4acdee1c5@intel.com>
Date: Mon, 25 Apr 2022 09:49:43 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 2/3] ntb_perf: extend with poll latency measurement
Content-Language: en-US
To: Alexander Fomichev <fomichev.ru@gmail.com>, ntb@lists.linux.dev
Cc: linux@yadro.com, Jon Mason <jdmason@kudzu.us>,
 Allen Hubbe <allenbh@gmail.com>, Guo Zhengkui <guozhengkui@vivo.com>,
 Alexander Fomichev <a.fomichev@yadro.com>
References: <20220422113703.48820-1-fomichev.ru@gmail.com>
 <20220422113703.48820-2-fomichev.ru@gmail.com>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20220422113703.48820-2-fomichev.ru@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 4/22/2022 4:37 AM, Alexander Fomichev wrote:
> From: Alexander Fomichev <a.fomichev@yadro.com>
>
> The proposed change extends ntb_perf with 2nd of 3 new metrics. The resulting
> test is fully backward compatible.
>
> 2. Poll latency. It's a delay between start to send 1 byte to the
> remote system and receiving the confirmation. The remote system needs to
> be run in server mode beforehand. Then the server polls the input buffer
> and on receiving data immediately sends the confirmation back.

This is a general comment. Please make the commit logs as they are 
individual standalone patches and not refer to each other.


>
> Signed-off-by: Alexander Fomichev <a.fomichev@yadro.com>
> ---
>   drivers/ntb/test/ntb_perf.c | 365 +++++++++++++++++++++++++++++++++++-
>   1 file changed, 364 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
> index 79faa4a7fe94..d4664410e543 100644
> --- a/drivers/ntb/test/ntb_perf.c
> +++ b/drivers/ntb/test/ntb_perf.c
> @@ -85,7 +85,7 @@
>   #include <linux/ntb.h>
>   
>   #define DRIVER_NAME		"ntb_perf"
> -#define DRIVER_VERSION		"2.0"
> +#define DRIVER_VERSION		"2.1"

Oddly random version change in the middle patch.


>   
>   MODULE_LICENSE("Dual BSD/GPL");
>   MODULE_VERSION(DRIVER_VERSION);
> @@ -133,6 +133,10 @@ static unsigned long lat_time_ms = 1000; /* default 1s */
>   module_param(lat_time_ms, ulong, 0644);
>   MODULE_PARM_DESC(lat_time_ms, "Time (in ms) to test latency");
>   
> +static unsigned long lat_timeout_us = 500;
> +module_param(lat_timeout_us, ulong, 0644);
> +MODULE_PARM_DESC(lat_timeout_us, "Timeout (in us) to wait for server reply");

I would refrain from using the word "timeout" for variable and 
description as that's typically used for when a set time expires. Maybe 
"Roundtrip Latency" would be the better description?


> +
>   /*==============================================================================
>    *                         Perf driver data definition
>    *==============================================================================
> @@ -149,6 +153,11 @@ enum perf_cmd {
>   	PERF_STS_LNKUP = 6, /* link up state flag */
>   };
>   
> +enum run_mode {
> +	RUN_PL_CLIENT,
> +	RUN_PL_SERVER,
> +};
> +
>   struct perf_ctx;
>   
>   struct perf_peer {
> @@ -197,6 +206,21 @@ struct perf_thread {
>   #define to_thread_work(__work) \
>   	container_of(__work, struct perf_thread, work)
>   
> +struct perf_poll_lat_data {
> +	struct perf_ctx *perf;
> +	void *src;
> +	ktime_t latency;
> +	u64 tries;
> +	int status;
> +	atomic_t running;
> +	struct work_struct clt_work;
> +	struct work_struct srv_work;
> +};
> +#define to_pldata_clt_work(__work) \
> +	container_of(__work, struct perf_poll_lat_data, clt_work)
> +#define to_pldata_srv_work(__work) \
> +	container_of(__work, struct perf_poll_lat_data, srv_work)
> +
>   struct perf_ctx {
>   	struct ntb_dev *ntb;
>   
> @@ -204,6 +228,7 @@ struct perf_ctx {
>   	int gidx;
>   	int pcnt;
>   	struct perf_peer *peers;
> +	struct perf_poll_lat_data pldata;
>   
>   	/* Performance measuring work-threads interface */
>   	unsigned long busy_flag;
> @@ -252,6 +277,8 @@ static struct dentry *perf_dbgfs_topdir;
>   
>   static struct workqueue_struct *perf_wq __read_mostly;
>   
> +static const u8 stop_word = 0xFF;
> +
>   /*==============================================================================
>    *                  NTB cross-link commands execution service
>    *==============================================================================
> @@ -1126,6 +1153,184 @@ static void perf_thread_work(struct work_struct *work)
>   	perf_clear_test(pthr);
>   }
>   
> +static int perf_init_pl(struct perf_poll_lat_data *pldata)
> +{
> +	struct perf_ctx *perf = pldata->perf;
> +	struct perf_peer *peer = perf->test_peer;
> +	u8 *bp;
> +
> +	pldata->src = kmalloc_node(peer->outbuf_size, GFP_KERNEL,
> +				 dev_to_node(&perf->ntb->dev));
> +	if (!pldata->src)
> +		return -ENOMEM;
> +
> +	/*
> +	 * Prepare random data to send, guaranteed exclusion of 0x00 (unreceived)
> +	 * and 0xFF (stop_word)
> +	 */
> +	get_random_bytes(pldata->src, peer->outbuf_size);
> +	for (bp = pldata->src; bp < (u8 *) pldata->src + peer->outbuf_size; bp++)
> +		while (*bp == 0 || *bp == stop_word)
> +			*bp = (u8)get_random_int();
> +
> +	memset(peer->inbuf, 0, peer->inbuf_size);
> +
> +	return 0;
> +}
> +
> +static int perf_poll_peer_reply(volatile u8 *cur)
> +{
> +	u64 wait_till = ktime_get_real_fast_ns() + lat_timeout_us * NSEC_PER_USEC;
> +
> +	while (ktime_get_real_fast_ns() < wait_till) {
> +		if (*cur == stop_word) {
> +			*cur = 0;
> +			return 1;
> +		}
> +		if (*cur != 0) {
> +			*cur = 0;
> +			return 0;
> +		}
> +	}
> +	return -EINTR;
> +}
> +
> +static int perf_run_pl_client(struct perf_poll_lat_data *pldata)
> +{
> +	struct perf_peer *peer = pldata->perf->test_peer;
> +	struct ntb_dev *ntb = pldata->perf->ntb;
> +	void *src = pldata->src;
> +	int ret;
> +	u64 stop_at = ktime_get_real_fast_ns() + lat_time_ms * NSEC_PER_MSEC;
> +
> +	dev_dbg(&ntb->dev, "poll_lat: client started.\n");
> +
> +	pldata->tries = 0;
> +	pldata->latency = ktime_get();
> +
> +	while (ktime_get_real_fast_ns() < stop_at) {
> +		memcpy_toio(peer->outbuf, src, 1);
> +
> +		/* Avoid processor soft lock-ups */
> +		schedule();
> +
> +		ret = perf_poll_peer_reply(peer->inbuf);
> +		if (ret < 0) {
> +			dev_err(&ntb->dev, "Timeout waiting for peer reply on poll latency\n");
> +			pldata->latency = ktime_set(0, 0);
> +			return -EINTR;
> +		} else if (ret == 1) {
> +			dev_warn(&ntb->dev, "Server terminated on poll latency, stopping\n");
> +			break;
> +		} else if (!atomic_read(&pldata->running)) {
> +			dev_err(&ntb->dev, "Poll latency client terminated\n");
> +			return -EINTR;
> +		}
> +
> +		pldata->tries++;
> +		src++;
> +
> +		if (src >= pldata->src + peer->outbuf_size)
> +			src = pldata->src;
> +	}
> +
> +	/* Stop timer */
> +	pldata->latency = ktime_sub(ktime_get(), pldata->latency);
> +	/* Send stop to peer */
> +	memcpy_toio(peer->outbuf, &stop_word, 1);
> +
> +	if (pldata->tries < LAT_MIN_TRIES) {
> +		dev_err(&ntb->dev, "Too few steps (%d) to measure Latency, "
> +			"recommended > %d. Increase value of 'lat_time_ms' "
> +			"parameter\n", pldata->tries, LAT_MIN_TRIES);
> +		pldata->latency = ktime_set(0, 0);
> +		return -EINVAL;
> +	}
> +
> +	dev_dbg(&ntb->dev, "poll_lat: made %llu tries, lasted %llu usecs\n",
> +		pldata->tries, ktime_to_us(pldata->latency));
> +
> +	pldata->latency = ns_to_ktime(ktime_divns(pldata->latency, pldata->tries));
> +
> +	dev_dbg(&ntb->dev, "poll_lat: latency %llu us (%llu ns)\n",
> +		ktime_to_us(pldata->latency), ktime_to_ns(pldata->latency));
> +
> +	return 0;
> +}
> +
> +static int perf_run_pl_server(struct perf_poll_lat_data *pldata)
> +{
> +	struct perf_peer *peer = pldata->perf->test_peer;
> +	struct ntb_dev *ntb = pldata->perf->ntb;
> +	void *src = pldata->src;
> +	int ret = 0;
> +
> +	dev_dbg(&ntb->dev, "poll_lat: server started.\n");
> +
> +	pldata->tries = 0;
> +
> +	while (ret != 1 && atomic_read(&pldata->running)) {
> +		ret = perf_poll_peer_reply(peer->inbuf);
> +		if (!ret) {
> +			/* Pong to client */
> +			memcpy_toio(peer->outbuf, src++, 1);
> +			if (src >= pldata->src + peer->outbuf_size)
> +				src = pldata->src;
> +
> +			pldata->tries++;
> +		}
> +
> +		/* Avoid processor soft lock-ups */
> +		schedule();
> +	}
> +
> +	if (pldata->tries < LAT_MIN_TRIES)
> +		dev_warn(&ntb->dev, "Poll latency test terminated too early. "
> +				"Increase client's test time\n");
> +
> +	dev_dbg(&ntb->dev, "poll_lat: server stopped, had responded %llu times\n",
> +		pldata->tries);
> +
> +	return atomic_read(&pldata->running) ? -ENODATA : -EINTR;
> +}
> +
> +static void perf_clear_pl(struct perf_poll_lat_data *pldata)
> +{
> +	struct perf_ctx *perf = pldata->perf;
> +	struct perf_peer *peer = perf->test_peer;
> +
> +	memset(peer->inbuf, stop_word, 1);
> +	atomic_set(&pldata->running, 0);
> +	wake_up(&perf->twait);
> +	kfree(pldata->src);
> +}
> +
> +static void perf_poll_lat_client_work(struct work_struct *work)
> +{
> +	struct perf_poll_lat_data *pldata = to_pldata_clt_work(work);
> +
> +	pldata->status = perf_init_pl(pldata);
> +	if (pldata->status)
> +		return;
> +
> +	pldata->status = perf_run_pl_client(pldata);
> +
> +	perf_clear_pl(pldata);
> +}
> +
> +static void perf_poll_lat_server_work(struct work_struct *work)
> +{
> +	struct perf_poll_lat_data *pldata = to_pldata_srv_work(work);
> +
> +	pldata->status = perf_init_pl(pldata);
> +	if (pldata->status)
> +		return;
> +
> +	pldata->status = perf_run_pl_server(pldata);
> +
> +	perf_clear_pl(pldata);
> +}
> +
>   static int perf_set_tcnt(struct perf_ctx *perf, u8 tcnt)
>   {
>   	if (tcnt == 0 || tcnt > MAX_THREADS_CNT)
> @@ -1146,7 +1351,10 @@ static void perf_terminate_test(struct perf_ctx *perf)
>   	int tidx;
>   
>   	atomic_set(&perf->tsync, -1);
> +	atomic_set(&perf->pldata.running, 0);
>   	wake_up(&perf->twait);
> +	cancel_work_sync(&perf->pldata.srv_work);
> +	cancel_work_sync(&perf->pldata.clt_work);
>   
>   	for (tidx = 0; tidx < MAX_THREADS_CNT; tidx++) {
>   		wake_up(&perf->threads[tidx].dma_wait);
> @@ -1192,6 +1400,46 @@ static int perf_submit_test(struct perf_peer *peer)
>   	return ret;
>   }
>   
> +static int perf_submit_poll_lat(struct perf_peer *peer, enum run_mode mode)
> +{
> +	struct perf_ctx *perf = peer->perf;
> +	int ret;
> +
> +	ret = wait_for_completion_interruptible(&peer->init_comp);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (test_and_set_bit_lock(0, &perf->busy_flag))
> +		return -EBUSY;
> +
> +	perf->test_peer = peer;
> +	atomic_set(&perf->pldata.running, 1);
> +	perf->pldata.status = -ENODATA;
> +	perf->pldata.tries = 0;
> +	perf->pldata.latency = ktime_set(0, 0);
> +
> +	switch (mode) {
> +	case RUN_PL_SERVER:
> +		(void)queue_work(perf_wq, &perf->pldata.srv_work);
> +		break;
> +	case RUN_PL_CLIENT:
> +	default:
> +		(void)queue_work(perf_wq, &perf->pldata.clt_work);
> +		break;
> +	}
> +
> +	ret = wait_event_interruptible(perf->twait,
> +				       !atomic_read(&perf->pldata.running));
> +	if (ret == -ERESTARTSYS) {
> +		perf_terminate_test(perf);
> +		ret = -EINTR;
> +	}
> +
> +	clear_bit_unlock(0, &perf->busy_flag);
> +
> +	return ret;
> +}
> +
>   static int perf_read_stats(struct perf_ctx *perf, char *buf,
>   			   size_t size, ssize_t *pos)
>   {
> @@ -1234,6 +1482,24 @@ static int perf_read_stats(struct perf_ctx *perf, char *buf,
>   		}
>   	}
>   
> +	if (perf->pldata.status != -ENODATA) {
> +		(*pos) += scnprintf(buf + *pos, size - *pos, "\n");
> +		if (perf->pldata.status) {
> +			(*pos) += scnprintf(buf + *pos, size - *pos,
> +				"poll latency: error status %d\n", perf->pldata.status);
> +		} else {
> +			if (ktime_to_us(perf->pldata.latency) < 10) {
> +				(*pos) += scnprintf(buf + *pos, size - *pos,
> +						"poll latency %llu ns\n",
> +						ktime_to_ns(perf->pldata.latency));
> +			} else {
> +				(*pos) += scnprintf(buf + *pos, size - *pos,
> +						"poll latency %llu us\n",
> +						ktime_to_us(perf->pldata.latency));
> +			}
> +		}
> +	}
> +
>   	clear_bit_unlock(0, &perf->busy_flag);
>   
>   	return 0;
> @@ -1247,6 +1513,10 @@ static void perf_init_threads(struct perf_ctx *perf)
>   	perf->tcnt = DEF_THREADS_CNT;
>   	perf->test_peer = &perf->peers[0];
>   	init_waitqueue_head(&perf->twait);
> +	perf->pldata.perf = perf;
> +	INIT_WORK(&perf->pldata.srv_work, perf_poll_lat_server_work);
> +	INIT_WORK(&perf->pldata.clt_work, perf_poll_lat_client_work);
> +	perf->pldata.status = -ENODATA;
>   
>   	for (tidx = 0; tidx < MAX_THREADS_CNT; tidx++) {
>   		pthr = &perf->threads[tidx];
> @@ -1403,6 +1673,64 @@ static const struct file_operations perf_dbgfs_run = {
>   	.write = perf_dbgfs_write_run
>   };
>   
> +static ssize_t perf_dbgfs_write_run_pl(struct file *filep, const char __user *ubuf,
> +				    size_t size, loff_t *offp, enum run_mode mode)
> +{
> +	struct perf_ctx *perf = filep->private_data;
> +	struct ntb_dev *ntb = perf->ntb;
> +	struct perf_peer *peer;
> +	int pidx, ret;
> +
> +	ret = kstrtoint_from_user(ubuf, size, 0, &pidx);
> +	if (ret)
> +		return ret;
> +
> +	if (pidx < 0 && mode == RUN_PL_SERVER) {
> +		dev_dbg(&ntb->dev, "poll_lat: kill server\n");
> +		if (test_bit(0, &perf->busy_flag)) {
> +			peer = perf->test_peer;
> +			/* Send stop to client */
> +			memcpy_toio(peer->outbuf, &stop_word, 1);
> +		}
> +		perf_terminate_test(perf);
> +		clear_bit_unlock(0, &perf->busy_flag);
> +		return size;
> +	}
> +
> +	if (pidx < 0 || pidx >= perf->pcnt)
> +		return -EINVAL;
> +
> +	peer = &perf->peers[pidx];
> +
> +	ret = perf_submit_poll_lat(peer, mode);
> +
> +	return ret ? ret : size;
> +}
> +
> +static ssize_t perf_dbgfs_write_run_client(struct file *filep, const char __user *ubuf,
> +				    size_t size, loff_t *offp)
> +{
> +	return perf_dbgfs_write_run_pl(filep, ubuf, size, offp, RUN_PL_CLIENT);
> +}
> +
> +static const struct file_operations perf_dbgfs_run_client = {
> +	.open = simple_open,
> +	.read = perf_dbgfs_read_run,
> +	.write = perf_dbgfs_write_run_client
> +};
> +
> +static ssize_t perf_dbgfs_write_run_server(struct file *filep, const char __user *ubuf,
> +				    size_t size, loff_t *offp)
> +{
> +	return perf_dbgfs_write_run_pl(filep, ubuf, size, offp, RUN_PL_SERVER);
> +}
> +
> +static const struct file_operations perf_dbgfs_run_server = {
> +	.open = simple_open,
> +	.read = perf_dbgfs_read_run,
> +	.write = perf_dbgfs_write_run_server
> +};
> +
>   static ssize_t perf_dbgfs_read_tcnt(struct file *filep, char __user *ubuf,
>   				    size_t size, loff_t *offp)
>   {
> @@ -1465,6 +1793,24 @@ static ssize_t perf_dbgfs_read_lattrs(struct file *filep, char __user *ubuf,
>   	return ret;
>   }
>   
> +static ssize_t perf_dbgfs_read_inbuf(struct file *filep, char __user *ubuf,
> +				    size_t size, loff_t *offp)
> +{
> +	struct perf_ctx *perf = filep->private_data;
> +	char buf[32];
> +	ssize_t pos;
> +	u64 *value;
> +
> +	if (!perf->test_peer || !perf->test_peer->inbuf) {
> +		pos = scnprintf(buf, sizeof(buf), "NULL\n");
> +	} else {
> +		value = perf->test_peer->inbuf;
> +		pos = scnprintf(buf, sizeof(buf), "0x%llx\n", *value);
> +	}
> +
> +	return simple_read_from_buffer(ubuf, size, offp, buf, pos);
> +}
> +
>   static const struct file_operations perf_dbgfs_tcnt = {
>   	.open = simple_open,
>   	.read = perf_dbgfs_read_tcnt,
> @@ -1476,6 +1822,11 @@ static const struct file_operations perf_dbgfs_lattrs = {
>   	.read = perf_dbgfs_read_lattrs
>   };
>   
> +static const struct file_operations perf_dbgfs_inbuf = {
> +	.open = simple_open,
> +	.read = perf_dbgfs_read_inbuf,
> +};
> +
>   static void perf_setup_dbgfs(struct perf_ctx *perf)
>   {
>   	struct pci_dev *pdev = perf->ntb->pdev;
> @@ -1492,6 +1843,12 @@ static void perf_setup_dbgfs(struct perf_ctx *perf)
>   	debugfs_create_file("run", 0600, perf->dbgfs_dir, perf,
>   			    &perf_dbgfs_run);
>   
> +	debugfs_create_file("run_client", 0600, perf->dbgfs_dir, perf,
> +			    &perf_dbgfs_run_client);
> +
> +	debugfs_create_file("run_server", 0600, perf->dbgfs_dir, perf,
> +			    &perf_dbgfs_run_server);
> +
>   	debugfs_create_file("threads_count", 0600, perf->dbgfs_dir, perf,
>   			    &perf_dbgfs_tcnt);
>   
> @@ -1504,6 +1861,12 @@ static void perf_setup_dbgfs(struct perf_ctx *perf)
>   
>   	debugfs_create_file("latency_tries", 0400, perf->dbgfs_dir, perf,
>   			    &perf_dbgfs_lattrs);
> +
> +	debugfs_create_u64("poll_latency_tries", 0400, perf->dbgfs_dir,
> +				&perf->pldata.tries);
> +
> +	debugfs_create_file("inbuf", 0400, perf->dbgfs_dir, perf,
> +			    &perf_dbgfs_inbuf);
>   }
>   
>   static void perf_clear_dbgfs(struct perf_ctx *perf)
