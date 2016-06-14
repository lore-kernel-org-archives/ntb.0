Return-Path: <Allen.Hubbe@emc.com>
Received: from mailuogwdur.emc.com (mailuogwdur.emc.com. [128.221.224.79])
        by gmr-mx.google.com with ESMTPS id j141si1103488ywg.2.2016.06.14.08.45.39
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jun 2016 08:45:39 -0700 (PDT)
From: "Allen Hubbe" <Allen.Hubbe@emc.com>
References: <cover.1465598632.git.logang@deltatee.com> <e447cedb6197b62f141e7688ed2329c259f33eb9.1465598632.git.logang@deltatee.com> <CAJ80sasERM19iz7d9+VeyDg-nasQvBpSqe9crB16GBMez8dFew@mail.gmail.com> <575C2E28.9020604@deltatee.com> <CAJ80sasHLMN3FZnFOKgfU6d7KBmr4zt2H5ej58EapYDBaoqZag@mail.gmail.com>
In-Reply-To: <CAJ80sasHLMN3FZnFOKgfU6d7KBmr4zt2H5ej58EapYDBaoqZag@mail.gmail.com>
Subject: RE: [PATCH 6/8] ntb_tool: Add link status file to debugfs
Date: Tue, 14 Jun 2016 11:45:09 -0400
Message-ID: <000101d1c653$bc673280$35359780$@emc.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
To: 'Allen Hubbe' <allenbh@gmail.com>, 'Logan Gunthorpe' <logang@deltatee.com>
Cc: 'Jon Mason' <jdmason@kudzu.us>, 'Dave Jiang' <dave.jiang@intel.com>, 'Shuah Khan' <shuahkh@osg.samsung.com>, 'Sudip Mukherjee' <sudipm.mukherjee@gmail.com>, 'Arnd Bergmann' <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, linux-kselftest@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

From: Allen Hubbe
> On Sat, Jun 11, 2016 at 11:28 AM, Logan Gunthorpe <logang@deltatee.com> wrote:
> > Hey Allen,
> >
> > Thanks for the feedback it's a bit more complicated but I don't object to
> > that. I'll work something up on Monday.
> >
> > I was trying to avoid adding link controls, but if we do, would you say the
> > module should still enable the link when it's installed? Or would we have
> > the user explicitly have to enable the link before using it?
> 
> I would vote to keep the current behavior and enable the link when the
> module loads.
> 
> >
> > Thanks,
> >
> > Logan
> >
> >
> > On 10/06/16 08:27 PM, Allen Hubbe wrote:
> >>
> >> On Fri, Jun 10, 2016 at 6:54 PM, Logan Gunthorpe <logang@deltatee.com>
> >> wrote:
> >>>
> >>> In order to more successfully script with ntb_tool it's useful to
> >>> have a link file to check the link status so that the script
> >>> doesn't use the other files until the link is up.
> >>>
> >>> This commit adds a 'link' file to the debugfs directory which reads
> >>> 0 or 1 depending on the link status. For scripting convenience, writing
> >>> will block until the link is up (discarding anything that was written).
> >>>
> >>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> >>> ---
> >>>   drivers/ntb/test/ntb_tool.c | 45
> >>> +++++++++++++++++++++++++++++++++++++++++++++
> >>>   1 file changed, 45 insertions(+)
> >>>
> >>> diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c
> >>> index 954e1d5..116352e 100644
> >>> --- a/drivers/ntb/test/ntb_tool.c
> >>> +++ b/drivers/ntb/test/ntb_tool.c
> >>> @@ -59,6 +59,12 @@
> >>>    *
> >>>    * Eg: check if clearing the doorbell mask generates an interrupt.
> >>>    *
> >>> + * # Check the link status
> >>> + * root@self# cat $DBG_DIR/link
> >>> + *
> >>> + * # Block until the link is up
> >>> + * root@self# echo > $DBG_DIR/link
> >>
> >>
> >> I think a file to get and set the link status is a good idea, but the
> >> way it is done as proposed here is not in a similar style to other
> >> ntb_tool operations.  Other operations simply read a register and
> >> format the value, or scan a value and write a register.  Similarly, I
> >> think the link status could be done in the same way: use the read file
> >> operation to get the current status with ntb_link_is_up(), and use the
> >> file write operation to enable or disable the link with
> >> ntb_link_enable() and ntb_link_disable().
> >>
> >> Waiting for link status is an interesting concept, too.  Really, one
> >> might be interested in a change in link status, whether up or down.
> >> What about a link event file that supports write to arm the event, and
> >> read to block for the event.  Consider an implementation based on
> >> <linux/completion.h>.  It would be used in combination with the link
> >> status file, above, as follows.
> >>
> >> 1: Write 1 to the event file.  This arms the event.
> >>    - The event will be disarmed by the next tool_link_event().
> >>
> >> 2: The application may read the link status file if it is interested
> >> in waiting for a particular event.
> >>
> >> 3. The application may wait for an event by reading the event file
> >>    - The application will wait as long as the event is still armed.
> >>    - If the event was disarmed before waiting, the application will not
> >> block.
> >>
> >> 4. The application should read the link status again.
> >>
> >> In any case, I think it would be more expected and natural to block
> >> while reading a file versus writing it.

Feel free to disregard my suggestion above.  I hope my comment has not cost you too much time.

The way you have written it already, and used it in the self-test script is much more concise.

> > + * root@self# echo > $DBG_DIR/link

Acked-by: Allen.Hubbe@emc.com



Eventually, I think it would be useful to let ntb_tool enable and disable the link.  In that case, it might also be useful in a test script to wait for link down, not just link up.

What about this:

# Wait for the link to be up or down
root@self# echo 1 > $DBG_DIR/link
root@self# echo 0 > $DBG_DIR/link

It need not be a part of this patch, but eventually:

# Enable or disable the link
root@self# echo 1 > $DBG_DIR/link_ctrl
root@self# echo 0 > $DBG_DIR/link_ctrl

# Reading the link_ctrl file can also give the link status
root@self# cat $DBG_DIR/link_ctrl

Finally, I wonder if the file called "link" in this patch should be called "link_wait" or similar, so its purpose is obviously not for enabling and disabling the link.

> >>
> >>> + *
> >>>    * # Set the doorbell mask
> >>>    * root@self# echo 's 1' > $DBG_DIR/mask
> >>>    *
> >>> @@ -127,6 +133,7 @@ struct tool_ctx {
> >>>          struct work_struct link_cleanup;
> >>>          bool link_is_up;
> >>>          struct delayed_work link_work;
> >>> +       wait_queue_head_t link_wq;
> >>>          int mw_count;
> >>>          struct tool_mw mws[MAX_MWS];
> >>>   };
> >>> @@ -237,6 +244,7 @@ static void tool_link_work(struct work_struct *work)
> >>>                          "Error setting up memory windows: %d\n", rc);
> >>>
> >>>          tc->link_is_up = true;
> >>> +       wake_up(&tc->link_wq);
> >>>   }
> >>>
> >>>   static void tool_link_cleanup(struct work_struct *work)
> >>> @@ -573,6 +581,39 @@ static TOOL_FOPS_RDWR(tool_peer_spad_fops,
> >>>                        tool_peer_spad_read,
> >>>                        tool_peer_spad_write);
> >>>
> >>> +static ssize_t tool_link_read(struct file *filep, char __user *ubuf,
> >>> +                             size_t size, loff_t *offp)
> >>> +{
> >>> +       struct tool_ctx *tc = filep->private_data;
> >>> +       char *buf;
> >>> +       ssize_t pos, rc;
> >>> +
> >>> +       buf = kmalloc(64, GFP_KERNEL);
> >>> +       if (!buf)
> >>> +               return -ENOMEM;
> >>> +
> >>> +       pos = scnprintf(buf, 64, "%d\n", tc->link_is_up);
> >>> +       rc = simple_read_from_buffer(ubuf, size, offp, buf, pos);
> >>> +
> >>> +       kfree(buf);
> >>> +
> >>> +       return rc;
> >>> +}
> >>> +
> >>> +static ssize_t tool_link_write(struct file *filep, const char __user
> >>> *ubuf,
> >>> +                              size_t size, loff_t *offp)
> >>> +{
> >>> +       struct tool_ctx *tc = filep->private_data;
> >>> +
> >>> +       if (wait_event_interruptible(tc->link_wq, tc->link_is_up))
> >>> +               return -ERESTART;
> >>> +
> >>> +       return size;
> >>> +}
> >>> +
> >>> +static TOOL_FOPS_RDWR(tool_link_fops,
> >>> +                     tool_link_read,
> >>> +                     tool_link_write);
> >>>
> >>>   static ssize_t tool_mw_read(struct file *filep, char __user *ubuf,
> >>>                              size_t size, loff_t *offp)
> >>> @@ -708,6 +749,9 @@ static void tool_setup_dbgfs(struct tool_ctx *tc)
> >>>          debugfs_create_file("peer_spad", S_IRUSR | S_IWUSR, tc->dbgfs,
> >>>                              tc, &tool_peer_spad_fops);
> >>>
> >>> +       debugfs_create_file("link", S_IRUSR | S_IWUSR, tc->dbgfs,
> >>> +                           tc, &tool_link_fops);
> >>> +
> >>>          mw_count = min(ntb_mw_count(tc->ntb), MAX_MWS);
> >>>          for (i = 0; i < mw_count; i++) {
> >>>                  char buf[30];
> >>> @@ -741,6 +785,7 @@ static int tool_probe(struct ntb_client *self, struct
> >>> ntb_dev *ntb)
> >>>          }
> >>>
> >>>          tc->ntb = ntb;
> >>> +       init_waitqueue_head(&tc->link_wq);
> >>>          INIT_DELAYED_WORK(&tc->link_work, tool_link_work);
> >>>          INIT_WORK(&tc->link_cleanup, tool_link_cleanup);
> 
> --
> You received this message because you are subscribed to the Google Groups "linux-ntb"
> group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-
> ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-
> ntb/CAJ80sasHLMN3FZnFOKgfU6d7KBmr4zt2H5ej58EapYDBaoqZag%40mail.gmail.com.
> For more options, visit https://groups.google.com/d/optout.

