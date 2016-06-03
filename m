Return-Path: <Allen.Hubbe@emc.com>
Received: from mailuogwdur.emc.com (mailuogwdur.emc.com. [128.221.224.79])
        by gmr-mx.google.com with ESMTPS id t202si547994ywe.0.2016.06.03.14.21.04
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Jun 2016 14:21:04 -0700 (PDT)
From: "Allen Hubbe" <Allen.Hubbe@emc.com>
References: <cover.1464986161.git.logang@deltatee.com> <a573b7044c8f38d28bdad9eb0ea7d2aaaedc7e19.1464986161.git.logang@deltatee.com>
In-Reply-To: <a573b7044c8f38d28bdad9eb0ea7d2aaaedc7e19.1464986161.git.logang@deltatee.com>
Subject: RE: [PATCH 3/3] ntb_tool: Add memory window debug support
Date: Fri, 3 Jun 2016 17:20:32 -0400
Message-ID: <000801d1bddd$c3a9eb10$4afdc130$@emc.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
To: 'Logan Gunthorpe' <logang@deltatee.com>, 'Jon Mason' <jdmason@kudzu.us>, 'Dave Jiang' <dave.jiang@intel.com>, 'John Kading' <john.kading@gd-ms.com>, 'Sudip Mukherjee' <sudipm.mukherjee@gmail.com>, 'Arnd Bergmann' <arnd@arndb.de>
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

From: Logan Gunthorpe 
> We allocate some memory window buffers when the link comes up, then we
> provide debugfs files to read/write each side of the link.
> 
> This is useful for debugging the mapping when writing new drivers.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

Thanks! This was on my wish list.

Acked-by: Allen Hubbe <Allen.Hubbe@emc.com>

> ---
>  drivers/ntb/test/ntb_tool.c | 258 +++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 257 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c
> index 209ef7c..4c01057 100644
> --- a/drivers/ntb/test/ntb_tool.c
> +++ b/drivers/ntb/test/ntb_tool.c
> @@ -89,6 +89,7 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/pci.h>
>  #include <linux/slab.h>
> +#include <linux/uaccess.h>
> 
>  #include <linux/ntb.h>
> 
> @@ -105,11 +106,29 @@ MODULE_VERSION(DRIVER_VERSION);
>  MODULE_AUTHOR(DRIVER_AUTHOR);
>  MODULE_DESCRIPTION(DRIVER_DESCRIPTION);
> 
> +#define MAX_MWS 16
> +
> +static unsigned long mw_size = 16;
> +module_param(mw_size, ulong, 0644);
> +MODULE_PARM_DESC(mw_size, "size order [n^2] of the memory window for testing");
> +
>  static struct dentry *tool_dbgfs;
> 
> +struct tool_mw {
> +	resource_size_t size;
> +	u8 __iomem *local;
> +	u8 *peer;
> +	dma_addr_t peer_dma;
> +};
> +
>  struct tool_ctx {
>  	struct ntb_dev *ntb;
>  	struct dentry *dbgfs;
> +	struct work_struct link_cleanup;
> +	bool link_is_up;
> +	struct delayed_work link_work;
> +	int mw_count;
> +	struct tool_mw mws[MAX_MWS];
>  };
> 
>  #define SPAD_FNAME_SIZE 0x10
> @@ -124,6 +143,111 @@ struct tool_ctx {
>  		.write = __write,		\
>  	}
> 
> +static int tool_setup_mw(struct tool_ctx *tc, int idx)
> +{
> +	int rc;
> +	struct tool_mw *mw = &tc->mws[idx];
> +	phys_addr_t base;
> +	resource_size_t size, align, align_size;
> +
> +	if (mw->local)
> +		return 0;
> +
> +	rc = ntb_mw_get_range(tc->ntb, idx, &base, &size, &align,
> +			      &align_size);
> +	if (rc)
> +		return rc;
> +
> +	mw->size = min_t(resource_size_t, 1 << mw_size, size);
> +	mw->size = round_up(mw->size, align);
> +	mw->size = round_up(mw->size, align_size);
> +
> +	mw->local = ioremap_wc(base, size);
> +	if (mw->local == NULL)
> +		return -EFAULT;
> +
> +	mw->peer = dma_alloc_coherent(&tc->ntb->pdev->dev, mw->size,
> +				      &mw->peer_dma, GFP_KERNEL);
> +
> +	if (mw->peer == NULL)
> +		return -ENOMEM;
> +
> +	rc = ntb_mw_set_trans(tc->ntb, idx, mw->peer_dma, mw->size);
> +	if (rc)
> +		return rc;
> +
> +	return 0;
> +}
> +
> +static void tool_free_mws(struct tool_ctx *tc)
> +{
> +	int i;
> +
> +	for (i = 0; i < tc->mw_count; i++) {
> +		if (tc->mws[i].peer) {
> +			ntb_mw_clear_trans(tc->ntb, i);
> +			dma_free_coherent(&tc->ntb->pdev->dev, tc->mws[i].size,
> +					  tc->mws[i].peer,
> +					  tc->mws[i].peer_dma);
> +
> +		}
> +
> +		tc->mws[i].peer = NULL;
> +		tc->mws[i].peer_dma = 0;
> +
> +		if (tc->mws[i].local)
> +			iounmap(tc->mws[i].local);
> +
> +		tc->mws[i].local = NULL;
> +	}
> +
> +	tc->mw_count = 0;
> +}
> +
> +static int tool_setup_mws(struct tool_ctx *tc)
> +{
> +	int i;
> +	int rc;
> +
> +	tc->mw_count = min(ntb_mw_count(tc->ntb), MAX_MWS);
> +
> +	for (i = 0; i < tc->mw_count; i++) {
> +		rc = tool_setup_mw(tc, i);
> +		if (rc)
> +			goto err_out;
> +	}
> +
> +	return 0;
> +
> +err_out:
> +	tool_free_mws(tc);
> +	return rc;
> +}
> +
> +static void tool_link_work(struct work_struct *work)
> +{
> +	int rc;
> +	struct tool_ctx *tc = container_of(work, struct tool_ctx,
> +					   link_work.work);
> +
> +	tool_free_mws(tc);
> +	rc = tool_setup_mws(tc);
> +	if (rc)
> +		dev_err(&tc->ntb->dev,
> +			"Error setting up memory windows: %d\n", rc);
> +
> +	tc->link_is_up = true;
> +}
> +
> +static void tool_link_cleanup(struct work_struct *work)
> +{
> +	struct tool_ctx *tc = container_of(work, struct tool_ctx,
> +					   link_cleanup);
> +
> +	if (!tc->link_is_up)
> +		cancel_delayed_work_sync(&tc->link_work);
> +}
> +
>  static void tool_link_event(void *ctx)
>  {
>  	struct tool_ctx *tc = ctx;
> @@ -135,6 +259,11 @@ static void tool_link_event(void *ctx)
> 
>  	dev_dbg(&tc->ntb->dev, "link is %s speed %d width %d\n",
>  		up ? "up" : "down", speed, width);
> +
> +	if (up)
> +		schedule_delayed_work(&tc->link_work, 2*HZ);
> +	else
> +		schedule_work(&tc->link_cleanup);
>  }
> 
>  static void tool_db_event(void *ctx, int vec)
> @@ -443,8 +572,112 @@ static TOOL_FOPS_RDWR(tool_peer_spad_fops,
>  		      tool_peer_spad_read,
>  		      tool_peer_spad_write);
> 
> +
> +static ssize_t tool_mw_read(struct file *filep, char __user *ubuf,
> +			    size_t size, loff_t *offp)
> +{
> +	struct tool_mw *mw = filep->private_data;
> +	ssize_t rc;
> +	loff_t pos = *offp;
> +	void *buf;
> +
> +	if (mw->local == NULL)
> +		return -EIO;
> +	if (pos < 0)
> +		return -EINVAL;
> +	if (pos >= mw->size || !size)
> +		return 0;
> +	if (size > mw->size - pos)
> +		size = mw->size - pos;
> +
> +	buf = kmalloc(size, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	memcpy_fromio(buf, mw->local + pos, size);
> +	rc = copy_to_user(ubuf, buf, size);
> +	if (rc == size) {
> +		rc = -EFAULT;
> +		goto err_free;
> +	}
> +
> +	size -= rc;
> +	*offp = pos + size;
> +	rc = size;
> +
> +err_free:
> +	kfree(buf);
> +
> +	return rc;
> +}
> +
> +static ssize_t tool_mw_write(struct file *filep, const char __user *ubuf,
> +			     size_t size, loff_t *offp)
> +{
> +	struct tool_mw *mw = filep->private_data;
> +	ssize_t rc;
> +	loff_t pos = *offp;
> +	void *buf;
> +
> +	if (pos < 0)
> +		return -EINVAL;
> +	if (pos >= mw->size || !size)
> +		return 0;
> +	if (size > mw->size - pos)
> +		size = mw->size - pos;
> +
> +	buf = kmalloc(size, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	rc = copy_from_user(buf, ubuf, size);
> +	if (rc == size) {
> +		rc = -EFAULT;
> +		goto err_free;
> +	}
> +
> +	size -= rc;
> +	*offp = pos + size;
> +	rc = size;
> +
> +	memcpy_toio(mw->local + pos, buf, size);
> +
> +err_free:
> +	kfree(buf);
> +
> +	return rc;
> +}
> +
> +static TOOL_FOPS_RDWR(tool_mw_fops,
> +		      tool_mw_read,
> +		      tool_mw_write);
> +
> +
> +static ssize_t tool_peer_mw_read(struct file *filep, char __user *ubuf,
> +				   size_t size, loff_t *offp)
> +{
> +	struct tool_mw *mw = filep->private_data;
> +
> +	return simple_read_from_buffer(ubuf, size, offp, mw->peer, mw->size);
> +}
> +
> +static ssize_t tool_peer_mw_write(struct file *filep, const char __user *ubuf,
> +				    size_t size, loff_t *offp)
> +{
> +	struct tool_mw *mw = filep->private_data;
> +
> +	return simple_write_to_buffer(mw->peer, mw->size, offp, ubuf, size);
> +}
> +
> +static TOOL_FOPS_RDWR(tool_peer_mw_fops,
> +		      tool_peer_mw_read,
> +		      tool_peer_mw_write);
> +
>  static void tool_setup_dbgfs(struct tool_ctx *tc)
>  {
> +	int mw_count;
> +	int i;
> +
>  	/* This modules is useless without dbgfs... */
>  	if (!tool_dbgfs) {
>  		tc->dbgfs = NULL;
> @@ -473,6 +706,20 @@ static void tool_setup_dbgfs(struct tool_ctx *tc)
> 
>  	debugfs_create_file("peer_spad", S_IRUSR | S_IWUSR, tc->dbgfs,
>  			    tc, &tool_peer_spad_fops);
> +
> +	mw_count = min(ntb_mw_count(tc->ntb), MAX_MWS);
> +	for (i = 0; i < mw_count; i++) {
> +		char buf[30];
> +
> +		snprintf(buf, sizeof(buf), "mw%d", i);
> +		debugfs_create_file(buf, S_IRUSR | S_IWUSR, tc->dbgfs,
> +				    &tc->mws[i], &tool_mw_fops);
> +
> +		snprintf(buf, sizeof(buf), "peer_mw%d", i);
> +		debugfs_create_file(buf, S_IRUSR | S_IWUSR, tc->dbgfs,
> +				    &tc->mws[i], &tool_peer_mw_fops);
> +
> +	}
>  }
> 
>  static int tool_probe(struct ntb_client *self, struct ntb_dev *ntb)
> @@ -486,13 +733,15 @@ static int tool_probe(struct ntb_client *self, struct ntb_dev *ntb)
>  	if (ntb_spad_is_unsafe(ntb))
>  		dev_dbg(&ntb->dev, "scratchpad is unsafe\n");
> 
> -	tc = kmalloc(sizeof(*tc), GFP_KERNEL);
> +	tc = kzalloc(sizeof(*tc), GFP_KERNEL);
>  	if (!tc) {
>  		rc = -ENOMEM;
>  		goto err_tc;
>  	}
> 
>  	tc->ntb = ntb;
> +	INIT_DELAYED_WORK(&tc->link_work, tool_link_work);
> +	INIT_WORK(&tc->link_cleanup, tool_link_cleanup);
> 
>  	tool_setup_dbgfs(tc);
> 
> @@ -507,6 +756,8 @@ static int tool_probe(struct ntb_client *self, struct ntb_dev *ntb)
> 
>  err_ctx:
>  	debugfs_remove_recursive(tc->dbgfs);
> +	cancel_delayed_work_sync(&tc->link_work);
> +	cancel_work_sync(&tc->link_cleanup);
>  	kfree(tc);
>  err_tc:
>  	return rc;
> @@ -516,6 +767,11 @@ static void tool_remove(struct ntb_client *self, struct ntb_dev *ntb)
>  {
>  	struct tool_ctx *tc = ntb->ctx;
> 
> +	cancel_delayed_work_sync(&tc->link_work);
> +	cancel_work_sync(&tc->link_cleanup);
> +
> +	tool_free_mws(tc);
> +
>  	ntb_clear_ctx(ntb);
>  	ntb_link_disable(ntb);
> 
> --
> 2.1.4


