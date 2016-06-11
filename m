Return-Path: <allenbh@gmail.com>
Received: from mail-yw0-x243.google.com (mail-yw0-x243.google.com. [2607:f8b0:4002:c05::243])
        by gmr-mx.google.com with ESMTPS id j141si195004ywg.2.2016.06.10.19.27.53
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Jun 2016 19:27:53 -0700 (PDT)
Received: by mail-yw0-x243.google.com with SMTP id v137so2258979ywa.2
        for <linux-ntb@googlegroups.com>; Fri, 10 Jun 2016 19:27:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <e447cedb6197b62f141e7688ed2329c259f33eb9.1465598632.git.logang@deltatee.com>
References: <cover.1465598632.git.logang@deltatee.com> <e447cedb6197b62f141e7688ed2329c259f33eb9.1465598632.git.logang@deltatee.com>
From: Allen Hubbe <allenbh@gmail.com>
Date: Fri, 10 Jun 2016 22:27:53 -0400
Message-ID: <CAJ80sasERM19iz7d9+VeyDg-nasQvBpSqe9crB16GBMez8dFew@mail.gmail.com>
Subject: Re: [PATCH 6/8] ntb_tool: Add link status file to debugfs
Content-Type: text/plain; charset=UTF-8
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Shuah Khan <shuahkh@osg.samsung.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, linux-kselftest@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

On Fri, Jun 10, 2016 at 6:54 PM, Logan Gunthorpe <logang@deltatee.com> wrote:
> In order to more successfully script with ntb_tool it's useful to
> have a link file to check the link status so that the script
> doesn't use the other files until the link is up.
>
> This commit adds a 'link' file to the debugfs directory which reads
> 0 or 1 depending on the link status. For scripting convenience, writing
> will block until the link is up (discarding anything that was written).
>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  drivers/ntb/test/ntb_tool.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>
> diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c
> index 954e1d5..116352e 100644
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
> + * root@self# echo > $DBG_DIR/link

I think a file to get and set the link status is a good idea, but the
way it is done as proposed here is not in a similar style to other
ntb_tool operations.  Other operations simply read a register and
format the value, or scan a value and write a register.  Similarly, I
think the link status could be done in the same way: use the read file
operation to get the current status with ntb_link_is_up(), and use the
file write operation to enable or disable the link with
ntb_link_enable() and ntb_link_disable().

Waiting for link status is an interesting concept, too.  Really, one
might be interested in a change in link status, whether up or down.
What about a link event file that supports write to arm the event, and
read to block for the event.  Consider an implementation based on
<linux/completion.h>.  It would be used in combination with the link
status file, above, as follows.

1: Write 1 to the event file.  This arms the event.
  - The event will be disarmed by the next tool_link_event().

2: The application may read the link status file if it is interested
in waiting for a particular event.

3. The application may wait for an event by reading the event file
  - The application will wait as long as the event is still armed.
  - If the event was disarmed before waiting, the application will not block.

4. The application should read the link status again.

In any case, I think it would be more expected and natural to block
while reading a file versus writing it.

> + *
>   * # Set the doorbell mask
>   * root@self# echo 's 1' > $DBG_DIR/mask
>   *
> @@ -127,6 +133,7 @@ struct tool_ctx {
>         struct work_struct link_cleanup;
>         bool link_is_up;
>         struct delayed_work link_work;
> +       wait_queue_head_t link_wq;
>         int mw_count;
>         struct tool_mw mws[MAX_MWS];
>  };
> @@ -237,6 +244,7 @@ static void tool_link_work(struct work_struct *work)
>                         "Error setting up memory windows: %d\n", rc);
>
>         tc->link_is_up = true;
> +       wake_up(&tc->link_wq);
>  }
>
>  static void tool_link_cleanup(struct work_struct *work)
> @@ -573,6 +581,39 @@ static TOOL_FOPS_RDWR(tool_peer_spad_fops,
>                       tool_peer_spad_read,
>                       tool_peer_spad_write);
>
> +static ssize_t tool_link_read(struct file *filep, char __user *ubuf,
> +                             size_t size, loff_t *offp)
> +{
> +       struct tool_ctx *tc = filep->private_data;
> +       char *buf;
> +       ssize_t pos, rc;
> +
> +       buf = kmalloc(64, GFP_KERNEL);
> +       if (!buf)
> +               return -ENOMEM;
> +
> +       pos = scnprintf(buf, 64, "%d\n", tc->link_is_up);
> +       rc = simple_read_from_buffer(ubuf, size, offp, buf, pos);
> +
> +       kfree(buf);
> +
> +       return rc;
> +}
> +
> +static ssize_t tool_link_write(struct file *filep, const char __user *ubuf,
> +                              size_t size, loff_t *offp)
> +{
> +       struct tool_ctx *tc = filep->private_data;
> +
> +       if (wait_event_interruptible(tc->link_wq, tc->link_is_up))
> +               return -ERESTART;
> +
> +       return size;
> +}
> +
> +static TOOL_FOPS_RDWR(tool_link_fops,
> +                     tool_link_read,
> +                     tool_link_write);
>
>  static ssize_t tool_mw_read(struct file *filep, char __user *ubuf,
>                             size_t size, loff_t *offp)
> @@ -708,6 +749,9 @@ static void tool_setup_dbgfs(struct tool_ctx *tc)
>         debugfs_create_file("peer_spad", S_IRUSR | S_IWUSR, tc->dbgfs,
>                             tc, &tool_peer_spad_fops);
>
> +       debugfs_create_file("link", S_IRUSR | S_IWUSR, tc->dbgfs,
> +                           tc, &tool_link_fops);
> +
>         mw_count = min(ntb_mw_count(tc->ntb), MAX_MWS);
>         for (i = 0; i < mw_count; i++) {
>                 char buf[30];
> @@ -741,6 +785,7 @@ static int tool_probe(struct ntb_client *self, struct ntb_dev *ntb)
>         }
>
>         tc->ntb = ntb;
> +       init_waitqueue_head(&tc->link_wq);
>         INIT_DELAYED_WORK(&tc->link_work, tool_link_work);
>         INIT_WORK(&tc->link_cleanup, tool_link_cleanup);
