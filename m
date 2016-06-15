Return-Path: <Allen.Hubbe@emc.com>
Received: from mailuogwdur.emc.com (mailuogwdur.emc.com. [128.221.224.79])
        by gmr-mx.google.com with ESMTPS id k4si213148ywc.4.2016.06.15.14.49.09
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jun 2016 14:49:09 -0700 (PDT)
From: "Allen Hubbe" <Allen.Hubbe@emc.com>
References: <cover.1466025130.git.logang@deltatee.com> <32ec8e46e2f76dd74046b34c7b50cc84206090b3.1466025130.git.logang@deltatee.com>
In-Reply-To: <32ec8e46e2f76dd74046b34c7b50cc84206090b3.1466025130.git.logang@deltatee.com>
Subject: RE: [PATCH v3 07/10] ntb_tool: Add link status and files to debugfs
Date: Wed, 15 Jun 2016 17:48:48 -0400
Message-ID: <007801d1c74f$b3075100$1915f300$@emc.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
To: 'Logan Gunthorpe' <logang@deltatee.com>, 'Jon Mason' <jdmason@kudzu.us>, 'Dave Jiang' <dave.jiang@intel.com>
Cc: 'Shuah Khan' <shuahkh@osg.samsung.com>, 'Sudip Mukherjee' <sudipm.mukherjee@gmail.com>, 'Arnd Bergmann' <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, linux-kselftest@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

From: Logan Gunthorpe
> In order to more successfully script with ntb_tool it's useful to
> have a link file to check the link status so that the script
> doesn't use the other files until the link is up.
> 
> This commit adds a 'link' file to the debugfs directory which reads
> boolean (Y or N) depending on the link status. Writing to the file
> change the link state using ntb_link_enable or ntb_link_disable.
> 
> A 'link_event' file is also provided so an application can block until
> the link changes to the desired state. If the user writes a 1, it will
> block until the link is up. If the user writes a 0, it will block until
> the link is down.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

Acked-by: Allen Hubbe <Allen.Hubbe@emc.com>

> ---
>  drivers/ntb/test/ntb_tool.c | 89 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 89 insertions(+)
> 
> diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c
> index 031723d..caef74c 100644
> --- a/drivers/ntb/test/ntb_tool.c
> +++ b/drivers/ntb/test/ntb_tool.c
> @@ -59,6 +59,12 @@
>   *
>   * Eg: check if clearing the doorbell mask generates an interrupt.
>   *
> + * # Check the link status
> + * root@self# cat $DBG_DIR/link
> + *
> + * # Block until the link is up
> + * root@self# echo Y > $DBG_DIR/link_event
> + *
>   * # Set the doorbell mask
>   * root@self# echo 's 1' > $DBG_DIR/mask
>   *
> @@ -131,6 +137,7 @@ struct tool_mw {
>  struct tool_ctx {
>  	struct ntb_dev *ntb;
>  	struct dentry *dbgfs;
> +	wait_queue_head_t link_wq;
>  	int mw_count;
>  	struct tool_mw mws[MAX_MWS];
>  };
> @@ -159,6 +166,7 @@ static void tool_link_event(void *ctx)
>  	dev_dbg(&tc->ntb->dev, "link is %s speed %d width %d\n",
>  		up ? "up" : "down", speed, width);
> 
> +	wake_up(&tc->link_wq);
>  }
> 
>  static void tool_db_event(void *ctx, int vec)
> @@ -473,6 +481,80 @@ static TOOL_FOPS_RDWR(tool_peer_spad_fops,
>  		      tool_peer_spad_read,
>  		      tool_peer_spad_write);
> 
> +static ssize_t tool_link_read(struct file *filep, char __user *ubuf,
> +			      size_t size, loff_t *offp)
> +{
> +	struct tool_ctx *tc = filep->private_data;
> +	char buf[3];
> +
> +	buf[0] = ntb_link_is_up(tc->ntb, NULL, NULL) ? 'Y' : 'N';
> +	buf[1] = '\n';
> +	buf[2] = '\0';
> +
> +	return simple_read_from_buffer(ubuf, size, offp, buf, 2);
> +}
> +
> +static ssize_t tool_link_write(struct file *filep, const char __user *ubuf,
> +			       size_t size, loff_t *offp)
> +{
> +	struct tool_ctx *tc = filep->private_data;
> +	char buf[32];
> +	size_t buf_size;
> +	bool val;
> +	int rc;
> +
> +	buf_size = min(size, (sizeof(buf) - 1));
> +	if (copy_from_user(buf, ubuf, buf_size))
> +		return -EFAULT;
> +
> +	buf[buf_size] = '\0';
> +
> +	rc = strtobool(buf, &val);
> +	if (rc)
> +		return rc;
> +
> +	if (val)
> +		ntb_link_enable(tc->ntb, NTB_SPEED_AUTO, NTB_WIDTH_AUTO);
> +	else
> +		ntb_link_disable(tc->ntb);
> +
> +	return size;
> +}
> +
> +static TOOL_FOPS_RDWR(tool_link_fops,
> +		      tool_link_read,
> +		      tool_link_write);
> +
> +static ssize_t tool_link_event_write(struct file *filep,
> +				     const char __user *ubuf,
> +				     size_t size, loff_t *offp)
> +{
> +	struct tool_ctx *tc = filep->private_data;
> +	char buf[32];
> +	size_t buf_size;
> +	bool val;
> +	int rc;
> +
> +	buf_size = min(size, (sizeof(buf) - 1));
> +	if (copy_from_user(buf, ubuf, buf_size))
> +		return -EFAULT;
> +
> +	buf[buf_size] = '\0';
> +
> +	rc = strtobool(buf, &val);
> +	if (rc)
> +		return rc;
> +
> +	if (wait_event_interruptible(tc->link_wq,
> +		ntb_link_is_up(tc->ntb, NULL, NULL) == val))
> +		return -ERESTART;
> +
> +	return size;
> +}
> +
> +static TOOL_FOPS_RDWR(tool_link_event_fops,
> +		      NULL,
> +		      tool_link_event_write);
> 
>  static ssize_t tool_mw_read(struct file *filep, char __user *ubuf,
>  			    size_t size, loff_t *offp)
> @@ -793,6 +875,12 @@ static void tool_setup_dbgfs(struct tool_ctx *tc)
>  	debugfs_create_file("peer_spad", S_IRUSR | S_IWUSR, tc->dbgfs,
>  			    tc, &tool_peer_spad_fops);
> 
> +	debugfs_create_file("link", S_IRUSR | S_IWUSR, tc->dbgfs,
> +			    tc, &tool_link_fops);
> +
> +	debugfs_create_file("link_event", S_IWUSR, tc->dbgfs,
> +			    tc, &tool_link_event_fops);
> +
>  	for (i = 0; i < tc->mw_count; i++) {
>  		char buf[30];
> 
> @@ -825,6 +913,7 @@ static int tool_probe(struct ntb_client *self, struct ntb_dev *ntb)
>  	}
> 
>  	tc->ntb = ntb;
> +	init_waitqueue_head(&tc->link_wq);
> 
>  	tc->mw_count = min(ntb_mw_count(tc->ntb), MAX_MWS);
>  	for (i = 0; i < tc->mw_count; i++) {
> --
> 2.1.4


