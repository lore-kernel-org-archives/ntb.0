Return-Path: <Allen.Hubbe@emc.com>
Received: from mailuogwdur.emc.com (mailuogwdur.emc.com. [128.221.224.79])
        by gmr-mx.google.com with ESMTPS id m78si1964945ywd.4.2016.06.14.12.33.42
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jun 2016 12:33:42 -0700 (PDT)
From: "Allen Hubbe" <Allen.Hubbe@emc.com>
References: <cover.1465919682.git.logang@deltatee.com> <cad111de08474152044d0b02aa0ee303d8a68150.1465919683.git.logang@deltatee.com>
In-Reply-To: <cad111de08474152044d0b02aa0ee303d8a68150.1465919683.git.logang@deltatee.com>
Subject: RE: [PATCH v2 6/8] ntb_tool: Add link status and files to debugfs
Date: Tue, 14 Jun 2016 15:33:10 -0400
Message-ID: <000401d1c673$9705bf50$c5113df0$@emc.com>
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
> This commit adds a 'link' file to the debugfs directory which reads a
> boolean (Y or N) depending on the link status. Writing to the file will
> change the link state using ntb_link_enable or ntb_link_disable.
> 
> A 'link_event' file is also provided so an application can block until
> the link changes to a desired state. This file is primed by writing a
> boolean. If the user writes a 1, the next read of link_event will
> block until the link is up. If the user writes a 0, the next read
> will block until the link is down. Besides blocking, reads return the
> same value as the 'link' file.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  drivers/ntb/test/ntb_tool.c | 111 +++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 110 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c
> index cba31fd..9bebd0d 100644
> --- a/drivers/ntb/test/ntb_tool.c
> +++ b/drivers/ntb/test/ntb_tool.c
> @@ -59,6 +59,13 @@
>   *
>   * Eg: check if clearing the doorbell mask generates an interrupt.
>   *
> + * # Check the link status
> + * root@self# cat $DBG_DIR/link
> + *
> + * # Block until the link is up
> + * root@self# echo Y > $DBG_DIR/link_event
> + * root@self# cat $DBG_DIR/link_event
> + *
>   * # Set the doorbell mask
>   * root@self# echo 's 1' > $DBG_DIR/mask
>   *
> @@ -126,7 +133,9 @@ struct tool_ctx {
>  	struct dentry *dbgfs;
>  	struct work_struct link_cleanup;
>  	bool link_is_up;

Really, link_is_up means "memory windows are configured."  This comes from your earlier patch that introduced memory windows to ntb_tool.

> +	bool link_event;
>  	struct delayed_work link_work;
> +	wait_queue_head_t link_wq;
>  	int mw_count;
>  	struct tool_mw mws[MAX_MWS];
>  };
> @@ -237,6 +246,7 @@ static void tool_link_work(struct work_struct *work)
>  			"Error setting up memory windows: %d\n", rc);
> 
>  	tc->link_is_up = true;

In other words, "memory windows are configured" = true.

> +	wake_up(&tc->link_wq);
>  }
> 
>  static void tool_link_cleanup(struct work_struct *work)
> @@ -246,6 +256,9 @@ static void tool_link_cleanup(struct work_struct *work)
> 
>  	if (!tc->link_is_up)
>  		cancel_delayed_work_sync(&tc->link_work);
> +
> +	tc->link_is_up = false;

If this was never set false anywhere in the patch that added memory windows, I wonder if there is a bug.

> +	wake_up(&tc->link_wq);
>  }
> 
>  static void tool_link_event(void *ctx)
> @@ -578,6 +591,95 @@ static TOOL_FOPS_RDWR(tool_peer_spad_fops,
>  		      tool_peer_spad_read,
>  		      tool_peer_spad_write);
> 
> +static ssize_t tool_link_read(struct file *filep, char __user *ubuf,
> +			      size_t size, loff_t *offp)
> +{
> +	struct tool_ctx *tc = filep->private_data;
> +	char buf[3];
> +
> +	buf[0] = tc->link_is_up ? 'Y' : 'N';

I think tc->link_is_up should instead be ntb_link_is_up(tc->ntb).

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
> +static ssize_t tool_link_event_read(struct file *filep, char __user *ubuf,
> +				    size_t size, loff_t *offp)
> +{
> +	struct tool_ctx *tc = filep->private_data;
> +	char buf[3];
> +
> +	if (wait_event_interruptible(tc->link_wq,
> +				     tc->link_is_up == tc->link_event))

I think tc->link_is_up should instead be ntb_link_is_up(tc->ntb).

> +		return -ERESTART;
> +
> +	buf[0] = tc->link_is_up ? 'Y' : 'N';
> +	buf[1] = '\n';
> +	buf[2] = '\0';
> +
> +	return simple_read_from_buffer(ubuf, size, offp, buf, 2);
> +}
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
> +	tc->link_event = val;

All writing the event file does is set the value of tc->link_event, so we have the same value that was set when reading the file.  It's rather inefficient, and oops, what if some other script comes along and writes a different value?  If script-A wants to wait for link up, and the link is already up, really it should not wait.  But if script-B changes tc->link_event to wait for link down before script-A reads the file, then script-A will incorrectly wait.

Really, I think the best thing after all would be just to wait here in the write function.

> +
> +	return size;
> +}
> +
> +static TOOL_FOPS_RDWR(tool_link_event_fops,
> +		      tool_link_event_read,
> +		      tool_link_event_write);
> 
>  static ssize_t tool_mw_read(struct file *filep, char __user *ubuf,
>  			    size_t size, loff_t *offp)
> @@ -658,7 +760,6 @@ static TOOL_FOPS_RDWR(tool_mw_fops,
>  		      tool_mw_read,
>  		      tool_mw_write);
> 
> -
>  static ssize_t tool_peer_mw_read(struct file *filep, char __user *ubuf,
>  				   size_t size, loff_t *offp)
>  {
> @@ -713,6 +814,12 @@ static void tool_setup_dbgfs(struct tool_ctx *tc)
>  	debugfs_create_file("peer_spad", S_IRUSR | S_IWUSR, tc->dbgfs,
>  			    tc, &tool_peer_spad_fops);
> 
> +	debugfs_create_file("link", S_IRUSR | S_IWUSR, tc->dbgfs,
> +			    tc, &tool_link_fops);
> +
> +	debugfs_create_file("link_event", S_IRUSR | S_IWUSR, tc->dbgfs,
> +			    tc, &tool_link_event_fops);
> +
>  	mw_count = min(ntb_mw_count(tc->ntb), MAX_MWS);
>  	for (i = 0; i < mw_count; i++) {
>  		char buf[30];
> @@ -746,8 +853,10 @@ static int tool_probe(struct ntb_client *self, struct ntb_dev *ntb)
>  	}
> 
>  	tc->ntb = ntb;
> +	init_waitqueue_head(&tc->link_wq);
>  	INIT_DELAYED_WORK(&tc->link_work, tool_link_work);
>  	INIT_WORK(&tc->link_cleanup, tool_link_cleanup);
> +	tc->link_event = true;
> 
>  	tool_setup_dbgfs(tc);
> 
> --
> 2.1.4

