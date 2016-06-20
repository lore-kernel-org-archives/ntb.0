Return-Path: <Allen.Hubbe@emc.com>
Received: from mailuogwdur.emc.com (mailuogwdur.emc.com. [128.221.224.79])
        by gmr-mx.google.com with ESMTPS id n132si881167ywb.1.2016.06.20.14.30.35
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jun 2016 14:30:35 -0700 (PDT)
From: "Allen Hubbe" <Allen.Hubbe@emc.com>
References: <cover.1466449562.git.logang@deltatee.com> <cab9ece5eee72425b93c22294d55f2ceab34840b.1466449562.git.logang@deltatee.com>
In-Reply-To: <cab9ece5eee72425b93c22294d55f2ceab34840b.1466449562.git.logang@deltatee.com>
Subject: RE: [PATCH v5 06/10] ntb_tool: Postpone memory window initialization for the user
Date: Mon, 20 Jun 2016 17:30:02 -0400
Message-ID: <00dd01d1cb3a$e8920380$b9b60a80$@emc.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
To: 'Logan Gunthorpe' <logang@deltatee.com>, 'Jon Mason' <jdmason@kudzu.us>, 'Dave Jiang' <dave.jiang@intel.com>
Cc: 'Shuah Khan' <shuahkh@osg.samsung.com>, 'Sudip Mukherjee' <sudipm.mukherjee@gmail.com>, 'Arnd Bergmann' <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, linux-kselftest@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

From: Logan Gunthorpe
> In order to make the interface closer to the raw NTB API, this commit
> changes memory windows so they are not initialized on link up.
> Instead, the 'peer_trans*' debugfs files are introduced. When read,
> they return information provided by ntb_mw_get_range. When written,
> they create a buffer and initialize the memory window. The
> value written is taken as the requested size of the buffer (which
> is then rounded for alignment). Writing a value of zero frees the buffer
> and tears down the memory window translation. The 'peer_mw*' file is
> only created once the memory window translation is setup by the user.
> 
> Additionally, it was noticed that the read and write functions for the
> 'peer_mw*' files should have checked for a NULL pointer.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

Acked-by: Allen Hubbe <Allen.Hubbe@emc.com>

> ---
>  drivers/ntb/test/ntb_tool.c | 366 +++++++++++++++++++++++++++-----------------
>  1 file changed, 228 insertions(+), 138 deletions(-)
> 
> diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c
> index cba31fd..1509b4c 100644
> --- a/drivers/ntb/test/ntb_tool.c
> +++ b/drivers/ntb/test/ntb_tool.c
> @@ -79,6 +79,13 @@
>   * root@self# cat $DBG_DIR/spad
>   *
>   * Observe that spad 0 and 1 have the values set by the peer.
> + *
> + * # Check the memory window translation info
> + * cat $DBG_DIR/peer_trans0
> + *
> + * # Setup a 16k memory window buffer
> + * echo 16384 > $DBG_DIR/peer_trans0
> + *
>   */
> 
>  #include <linux/init.h>
> @@ -108,25 +115,22 @@ MODULE_DESCRIPTION(DRIVER_DESCRIPTION);
> 
>  #define MAX_MWS 16
> 
> -static unsigned long mw_size = 16;
> -module_param(mw_size, ulong, 0644);
> -MODULE_PARM_DESC(mw_size, "size order [n^2] of the memory window for testing");
> -
>  static struct dentry *tool_dbgfs;
> 
>  struct tool_mw {
> +	int idx;
> +	struct tool_ctx *tc;
> +	resource_size_t win_size;
>  	resource_size_t size;
>  	u8 __iomem *local;
>  	u8 *peer;
>  	dma_addr_t peer_dma;
> +	struct dentry *peer_dbg_file;
>  };
> 
>  struct tool_ctx {
>  	struct ntb_dev *ntb;
>  	struct dentry *dbgfs;
> -	struct work_struct link_cleanup;
> -	bool link_is_up;
> -	struct delayed_work link_work;
>  	int mw_count;
>  	struct tool_mw mws[MAX_MWS];
>  };
> @@ -143,111 +147,6 @@ struct tool_ctx {
>  		.write = __write,		\
>  	}
> 
> -static int tool_setup_mw(struct tool_ctx *tc, int idx)
> -{
> -	int rc;
> -	struct tool_mw *mw = &tc->mws[idx];
> -	phys_addr_t base;
> -	resource_size_t size, align, align_size;
> -
> -	if (mw->local)
> -		return 0;
> -
> -	rc = ntb_mw_get_range(tc->ntb, idx, &base, &size, &align,
> -			      &align_size);
> -	if (rc)
> -		return rc;
> -
> -	mw->size = min_t(resource_size_t, 1 << mw_size, size);
> -	mw->size = round_up(mw->size, align);
> -	mw->size = round_up(mw->size, align_size);
> -
> -	mw->local = ioremap_wc(base, size);
> -	if (mw->local == NULL)
> -		return -EFAULT;
> -
> -	mw->peer = dma_alloc_coherent(&tc->ntb->pdev->dev, mw->size,
> -				      &mw->peer_dma, GFP_KERNEL);
> -
> -	if (mw->peer == NULL)
> -		return -ENOMEM;
> -
> -	rc = ntb_mw_set_trans(tc->ntb, idx, mw->peer_dma, mw->size);
> -	if (rc)
> -		return rc;
> -
> -	return 0;
> -}
> -
> -static void tool_free_mws(struct tool_ctx *tc)
> -{
> -	int i;
> -
> -	for (i = 0; i < tc->mw_count; i++) {
> -		if (tc->mws[i].peer) {
> -			ntb_mw_clear_trans(tc->ntb, i);
> -			dma_free_coherent(&tc->ntb->pdev->dev, tc->mws[i].size,
> -					  tc->mws[i].peer,
> -					  tc->mws[i].peer_dma);
> -
> -		}
> -
> -		tc->mws[i].peer = NULL;
> -		tc->mws[i].peer_dma = 0;
> -
> -		if (tc->mws[i].local)
> -			iounmap(tc->mws[i].local);
> -
> -		tc->mws[i].local = NULL;
> -	}
> -
> -	tc->mw_count = 0;
> -}
> -
> -static int tool_setup_mws(struct tool_ctx *tc)
> -{
> -	int i;
> -	int rc;
> -
> -	tc->mw_count = min(ntb_mw_count(tc->ntb), MAX_MWS);
> -
> -	for (i = 0; i < tc->mw_count; i++) {
> -		rc = tool_setup_mw(tc, i);
> -		if (rc)
> -			goto err_out;
> -	}
> -
> -	return 0;
> -
> -err_out:
> -	tool_free_mws(tc);
> -	return rc;
> -}
> -
> -static void tool_link_work(struct work_struct *work)
> -{
> -	int rc;
> -	struct tool_ctx *tc = container_of(work, struct tool_ctx,
> -					   link_work.work);
> -
> -	tool_free_mws(tc);
> -	rc = tool_setup_mws(tc);
> -	if (rc)
> -		dev_err(&tc->ntb->dev,
> -			"Error setting up memory windows: %d\n", rc);
> -
> -	tc->link_is_up = true;
> -}
> -
> -static void tool_link_cleanup(struct work_struct *work)
> -{
> -	struct tool_ctx *tc = container_of(work, struct tool_ctx,
> -					   link_cleanup);
> -
> -	if (!tc->link_is_up)
> -		cancel_delayed_work_sync(&tc->link_work);
> -}
> -
>  static void tool_link_event(void *ctx)
>  {
>  	struct tool_ctx *tc = ctx;
> @@ -260,10 +159,6 @@ static void tool_link_event(void *ctx)
>  	dev_dbg(&tc->ntb->dev, "link is %s speed %d width %d\n",
>  		up ? "up" : "down", speed, width);
> 
> -	if (up)
> -		schedule_delayed_work(&tc->link_work, 2*HZ);
> -	else
> -		schedule_work(&tc->link_cleanup);
>  }
> 
>  static void tool_db_event(void *ctx, int vec)
> @@ -591,10 +486,10 @@ static ssize_t tool_mw_read(struct file *filep, char __user *ubuf,
>  		return -EIO;
>  	if (pos < 0)
>  		return -EINVAL;
> -	if (pos >= mw->size || !size)
> +	if (pos >= mw->win_size || !size)
>  		return 0;
> -	if (size > mw->size - pos)
> -		size = mw->size - pos;
> +	if (size > mw->win_size - pos)
> +		size = mw->win_size - pos;
> 
>  	buf = kmalloc(size, GFP_KERNEL);
>  	if (!buf)
> @@ -627,10 +522,10 @@ static ssize_t tool_mw_write(struct file *filep, const char __user
> *ubuf,
> 
>  	if (pos < 0)
>  		return -EINVAL;
> -	if (pos >= mw->size || !size)
> +	if (pos >= mw->win_size || !size)
>  		return 0;
> -	if (size > mw->size - pos)
> -		size = mw->size - pos;
> +	if (size > mw->win_size - pos)
> +		size = mw->win_size - pos;
> 
>  	buf = kmalloc(size, GFP_KERNEL);
>  	if (!buf)
> @@ -658,20 +553,25 @@ static TOOL_FOPS_RDWR(tool_mw_fops,
>  		      tool_mw_read,
>  		      tool_mw_write);
> 
> -
>  static ssize_t tool_peer_mw_read(struct file *filep, char __user *ubuf,
> -				   size_t size, loff_t *offp)
> +				 size_t size, loff_t *offp)
>  {
>  	struct tool_mw *mw = filep->private_data;
> 
> +	if (!mw->peer)
> +		return -ENXIO;
> +
>  	return simple_read_from_buffer(ubuf, size, offp, mw->peer, mw->size);
>  }
> 
>  static ssize_t tool_peer_mw_write(struct file *filep, const char __user *ubuf,
> -				    size_t size, loff_t *offp)
> +				  size_t size, loff_t *offp)
>  {
>  	struct tool_mw *mw = filep->private_data;
> 
> +	if (!mw->peer)
> +		return -ENXIO;
> +
>  	return simple_write_to_buffer(mw->peer, mw->size, offp, ubuf, size);
>  }
> 
> @@ -679,9 +579,199 @@ static TOOL_FOPS_RDWR(tool_peer_mw_fops,
>  		      tool_peer_mw_read,
>  		      tool_peer_mw_write);
> 
> +static int tool_setup_mw(struct tool_ctx *tc, int idx, size_t req_size)
> +{
> +	int rc;
> +	struct tool_mw *mw = &tc->mws[idx];
> +	phys_addr_t base;
> +	resource_size_t size, align, align_size;
> +	char buf[16];
> +
> +	if (mw->peer)
> +		return 0;
> +
> +	rc = ntb_mw_get_range(tc->ntb, idx, &base, &size, &align,
> +			      &align_size);
> +	if (rc)
> +		return rc;
> +
> +	mw->size = min_t(resource_size_t, req_size, size);
> +	mw->size = round_up(mw->size, align);
> +	mw->size = round_up(mw->size, align_size);
> +	mw->peer = dma_alloc_coherent(&tc->ntb->pdev->dev, mw->size,
> +				      &mw->peer_dma, GFP_KERNEL);
> +
> +	if (!mw->peer)
> +		return -ENOMEM;
> +
> +	rc = ntb_mw_set_trans(tc->ntb, idx, mw->peer_dma, mw->size);
> +	if (rc)
> +		goto err_free_dma;
> +
> +	snprintf(buf, sizeof(buf), "peer_mw%d", idx);
> +	mw->peer_dbg_file = debugfs_create_file(buf, S_IRUSR | S_IWUSR,
> +						mw->tc->dbgfs, mw,
> +						&tool_peer_mw_fops);
> +
> +	return 0;
> +
> +err_free_dma:
> +	dma_free_coherent(&tc->ntb->pdev->dev, mw->size,
> +			  mw->peer,
> +			  mw->peer_dma);
> +	mw->peer = NULL;
> +	mw->peer_dma = 0;
> +	mw->size = 0;
> +
> +	return rc;
> +}
> +
> +static void tool_free_mw(struct tool_ctx *tc, int idx)
> +{
> +	struct tool_mw *mw = &tc->mws[idx];
> +
> +	if (mw->peer) {
> +		ntb_mw_clear_trans(tc->ntb, idx);
> +		dma_free_coherent(&tc->ntb->pdev->dev, mw->size,
> +				  mw->peer,
> +				  mw->peer_dma);
> +	}
> +
> +	mw->peer = NULL;
> +	mw->peer_dma = 0;
> +
> +	debugfs_remove(mw->peer_dbg_file);
> +
> +	mw->peer_dbg_file = NULL;
> +}
> +
> +static ssize_t tool_peer_mw_trans_read(struct file *filep,
> +				       char __user *ubuf,
> +				       size_t size, loff_t *offp)
> +{
> +	struct tool_mw *mw = filep->private_data;
> +
> +	char *buf;
> +	size_t buf_size;
> +	ssize_t ret, off = 0;
> +
> +	phys_addr_t base;
> +	resource_size_t mw_size;
> +	resource_size_t align;
> +	resource_size_t align_size;
> +
> +	buf_size = min_t(size_t, size, 512);
> +
> +	buf = kmalloc(buf_size, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	ntb_mw_get_range(mw->tc->ntb, mw->idx,
> +			 &base, &mw_size, &align, &align_size);
> +
> +	off += scnprintf(buf + off, buf_size - off,
> +			 "Peer MW %d Information:\n", mw->idx);
> +
> +	off += scnprintf(buf + off, buf_size - off,
> +			 "Physical Address      \t%pa[p]\n",
> +			 &base);
> +
> +	off += scnprintf(buf + off, buf_size - off,
> +			 "Window Size           \t%lld\n",
> +			 (unsigned long long)mw_size);
> +
> +	off += scnprintf(buf + off, buf_size - off,
> +			 "Alignment             \t%lld\n",
> +			 (unsigned long long)align);
> +
> +	off += scnprintf(buf + off, buf_size - off,
> +			 "Size Alignment        \t%lld\n",
> +			 (unsigned long long)align_size);
> +
> +	off += scnprintf(buf + off, buf_size - off,
> +			 "Ready                 \t%c\n",
> +			 (mw->peer) ? 'Y' : 'N');
> +
> +	off += scnprintf(buf + off, buf_size - off,
> +			 "Allocated Size       \t%zd\n",
> +			 (mw->peer) ? (size_t)mw->size : 0);
> +
> +	ret = simple_read_from_buffer(ubuf, size, offp, buf, off);
> +	kfree(buf);
> +	return ret;
> +}
> +
> +static ssize_t tool_peer_mw_trans_write(struct file *filep,
> +					const char __user *ubuf,
> +					size_t size, loff_t *offp)
> +{
> +	struct tool_mw *mw = filep->private_data;
> +
> +	char buf[32];
> +	size_t buf_size;
> +	unsigned long long val;
> +	int rc;
> +
> +	buf_size = min(size, (sizeof(buf) - 1));
> +	if (copy_from_user(buf, ubuf, buf_size))
> +		return -EFAULT;
> +
> +	buf[buf_size] = '\0';
> +
> +	rc = kstrtoull(buf, 0, &val);
> +	if (rc)
> +		return rc;
> +
> +	tool_free_mw(mw->tc, mw->idx);
> +	if (val)
> +		rc = tool_setup_mw(mw->tc, mw->idx, val);
> +
> +	if (rc)
> +		return rc;
> +
> +	return size;
> +}
> +
> +static TOOL_FOPS_RDWR(tool_peer_mw_trans_fops,
> +		      tool_peer_mw_trans_read,
> +		      tool_peer_mw_trans_write);
> +
> +static int tool_init_mw(struct tool_ctx *tc, int idx)
> +{
> +	struct tool_mw *mw = &tc->mws[idx];
> +	phys_addr_t base;
> +	int rc;
> +
> +	rc = ntb_mw_get_range(tc->ntb, idx, &base, &mw->win_size,
> +			      NULL, NULL);
> +	if (rc)
> +		return rc;
> +
> +	mw->tc = tc;
> +	mw->idx = idx;
> +	mw->local = ioremap_wc(base, mw->win_size);
> +	if (!mw->local)
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
> +static void tool_free_mws(struct tool_ctx *tc)
> +{
> +	int i;
> +
> +	for (i = 0; i < tc->mw_count; i++) {
> +		tool_free_mw(tc, i);
> +
> +		if (tc->mws[i].local)
> +			iounmap(tc->mws[i].local);
> +
> +		tc->mws[i].local = NULL;
> +	}
> +}
> +
>  static void tool_setup_dbgfs(struct tool_ctx *tc)
>  {
> -	int mw_count;
>  	int i;
> 
>  	/* This modules is useless without dbgfs... */
> @@ -713,18 +803,16 @@ static void tool_setup_dbgfs(struct tool_ctx *tc)
>  	debugfs_create_file("peer_spad", S_IRUSR | S_IWUSR, tc->dbgfs,
>  			    tc, &tool_peer_spad_fops);
> 
> -	mw_count = min(ntb_mw_count(tc->ntb), MAX_MWS);
> -	for (i = 0; i < mw_count; i++) {
> +	for (i = 0; i < tc->mw_count; i++) {
>  		char buf[30];
> 
>  		snprintf(buf, sizeof(buf), "mw%d", i);
>  		debugfs_create_file(buf, S_IRUSR | S_IWUSR, tc->dbgfs,
>  				    &tc->mws[i], &tool_mw_fops);
> 
> -		snprintf(buf, sizeof(buf), "peer_mw%d", i);
> +		snprintf(buf, sizeof(buf), "peer_trans%d", i);
>  		debugfs_create_file(buf, S_IRUSR | S_IWUSR, tc->dbgfs,
> -				    &tc->mws[i], &tool_peer_mw_fops);
> -
> +				    &tc->mws[i], &tool_peer_mw_trans_fops);
>  	}
>  }
> 
> @@ -732,6 +820,7 @@ static int tool_probe(struct ntb_client *self, struct ntb_dev *ntb)
>  {
>  	struct tool_ctx *tc;
>  	int rc;
> +	int i;
> 
>  	if (ntb_db_is_unsafe(ntb))
>  		dev_dbg(&ntb->dev, "doorbell is unsafe\n");
> @@ -746,8 +835,13 @@ static int tool_probe(struct ntb_client *self, struct ntb_dev *ntb)
>  	}
> 
>  	tc->ntb = ntb;
> -	INIT_DELAYED_WORK(&tc->link_work, tool_link_work);
> -	INIT_WORK(&tc->link_cleanup, tool_link_cleanup);
> +
> +	tc->mw_count = min(ntb_mw_count(tc->ntb), MAX_MWS);
> +	for (i = 0; i < tc->mw_count; i++) {
> +		rc = tool_init_mw(tc, i);
> +		if (rc)
> +			goto err_ctx;
> +	}
> 
>  	tool_setup_dbgfs(tc);
> 
> @@ -761,9 +855,8 @@ static int tool_probe(struct ntb_client *self, struct ntb_dev *ntb)
>  	return 0;
> 
>  err_ctx:
> +	tool_free_mws(tc);
>  	debugfs_remove_recursive(tc->dbgfs);
> -	cancel_delayed_work_sync(&tc->link_work);
> -	cancel_work_sync(&tc->link_cleanup);
>  	kfree(tc);
>  err_tc:
>  	return rc;
> @@ -773,9 +866,6 @@ static void tool_remove(struct ntb_client *self, struct ntb_dev *ntb)
>  {
>  	struct tool_ctx *tc = ntb->ctx;
> 
> -	cancel_delayed_work_sync(&tc->link_work);
> -	cancel_work_sync(&tc->link_cleanup);
> -
>  	tool_free_mws(tc);
> 
>  	ntb_clear_ctx(ntb);
> --
> 2.1.4


