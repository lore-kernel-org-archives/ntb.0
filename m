Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id un17si1260743pab.0.2016.06.14.14.01.52
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jun 2016 14:01:52 -0700 (PDT)
References: <cover.1465919682.git.logang@deltatee.com>
 <cad111de08474152044d0b02aa0ee303d8a68150.1465919683.git.logang@deltatee.com>
 <000401d1c673$9705bf50$c5113df0$@emc.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <576070AE.10500@deltatee.com>
Date: Tue, 14 Jun 2016 15:01:34 -0600
MIME-Version: 1.0
In-Reply-To: <000401d1c673$9705bf50$c5113df0$@emc.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 6/8] ntb_tool: Add link status and files to debugfs
To: Allen Hubbe <Allen.Hubbe@emc.com>, 'Jon Mason' <jdmason@kudzu.us>, 'Dave Jiang' <dave.jiang@intel.com>
Cc: 'Shuah Khan' <shuahkh@osg.samsung.com>, 'Sudip Mukherjee' <sudipm.mukherjee@gmail.com>, 'Arnd Bergmann' <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, linux-kselftest@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>



On 14/06/16 01:33 PM, Allen Hubbe wrote:
>> diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c
>> index cba31fd..9bebd0d 100644
>> --- a/drivers/ntb/test/ntb_tool.c
>> +++ b/drivers/ntb/test/ntb_tool.c
>> @@ -59,6 +59,13 @@
>>   *
>>   * Eg: check if clearing the doorbell mask generates an interrupt.
>>   *
>> + * # Check the link status
>> + * root@self# cat $DBG_DIR/link
>> + *
>> + * # Block until the link is up
>> + * root@self# echo Y > $DBG_DIR/link_event
>> + * root@self# cat $DBG_DIR/link_event
>> + *
>>   * # Set the doorbell mask
>>   * root@self# echo 's 1' > $DBG_DIR/mask
>>   *
>> @@ -126,7 +133,9 @@ struct tool_ctx {
>>  	struct dentry *dbgfs;
>>  	struct work_struct link_cleanup;
>>  	bool link_is_up;
> 
> Really, link_is_up means "memory windows are configured."  This comes from your earlier patch that introduced memory windows to ntb_tool.

Yes, this is technically true. However, I don't think the distinction is
necessary. The user only really cares whether everything is up and
usable -- not whether the link is just physically up or not.


>> +	bool link_event;
>>  	struct delayed_work link_work;
>> +	wait_queue_head_t link_wq;
>>  	int mw_count;
>>  	struct tool_mw mws[MAX_MWS];
>>  };
>> @@ -237,6 +246,7 @@ static void tool_link_work(struct work_struct *work)
>>  			"Error setting up memory windows: %d\n", rc);
>>
>>  	tc->link_is_up = true;
> 
> In other words, "memory windows are configured" = true.

Technically, yes.

>> +	wake_up(&tc->link_wq);
>>  }
>>
>>  static void tool_link_cleanup(struct work_struct *work)
>> @@ -246,6 +256,9 @@ static void tool_link_cleanup(struct work_struct *work)
>>
>>  	if (!tc->link_is_up)
>>  		cancel_delayed_work_sync(&tc->link_work);
>> +
>> +	tc->link_is_up = false;
> 
> If this was never set false anywhere in the patch that added memory windows, I wonder if there is a bug.

Yup, this looks like an oversight on my part. However, I don't think it
resulted in any noticeable bug seeing, at the time, the only way to
bring the link back down was to remove the module or the device. It is
only strictly necessary now that we have the 'link' file which can
control the link.

>> +	wake_up(&tc->link_wq);
>>  }
>>
>>  static void tool_link_event(void *ctx)
>> @@ -578,6 +591,95 @@ static TOOL_FOPS_RDWR(tool_peer_spad_fops,
>>  		      tool_peer_spad_read,
>>  		      tool_peer_spad_write);
>>
>> +static ssize_t tool_link_read(struct file *filep, char __user *ubuf,
>> +			      size_t size, loff_t *offp)
>> +{
>> +	struct tool_ctx *tc = filep->private_data;
>> +	char buf[3];
>> +
>> +	buf[0] = tc->link_is_up ? 'Y' : 'N';
> 
> I think tc->link_is_up should instead be ntb_link_is_up(tc->ntb).

I disagree. Bad things will happen if the user waits on the event and
then immediately uses the memory windows. It will just be buggy and
racy. I can't see a situation where the user would want to wait for the
link to come up and not have everything in ntb_tool ready and usable.

>> +	buf[1] = '\n';
>> +	buf[2] = '\0';
>> +
>> +	return simple_read_from_buffer(ubuf, size, offp, buf, 2);
>> +}
>> +
>> +static ssize_t tool_link_write(struct file *filep, const char __user *ubuf,
>> +			       size_t size, loff_t *offp)
>> +{
>> +	struct tool_ctx *tc = filep->private_data;
>> +	char buf[32];
>> +	size_t buf_size;
>> +	bool val;
>> +	int rc;
>> +
>> +	buf_size = min(size, (sizeof(buf) - 1));
>> +	if (copy_from_user(buf, ubuf, buf_size))
>> +		return -EFAULT;
>> +
>> +	buf[buf_size] = '\0';
>> +
>> +	rc = strtobool(buf, &val);
>> +	if (rc)
>> +		return rc;
>> +
>> +	if (val)
>> +		ntb_link_enable(tc->ntb, NTB_SPEED_AUTO, NTB_WIDTH_AUTO);
>> +	else
>> +		ntb_link_disable(tc->ntb);
>> +
>> +	return size;
>> +}
>> +
>> +static TOOL_FOPS_RDWR(tool_link_fops,
>> +		      tool_link_read,
>> +		      tool_link_write);
>> +
>> +static ssize_t tool_link_event_read(struct file *filep, char __user *ubuf,
>> +				    size_t size, loff_t *offp)
>> +{
>> +	struct tool_ctx *tc = filep->private_data;
>> +	char buf[3];
>> +
>> +	if (wait_event_interruptible(tc->link_wq,
>> +				     tc->link_is_up == tc->link_event))
> 
> I think tc->link_is_up should instead be ntb_link_is_up(tc->ntb).

See above.

>> +		return -ERESTART;
>> +
>> +	buf[0] = tc->link_is_up ? 'Y' : 'N';
>> +	buf[1] = '\n';
>> +	buf[2] = '\0';
>> +
>> +	return simple_read_from_buffer(ubuf, size, offp, buf, 2);
>> +}
>> +
>> +static ssize_t tool_link_event_write(struct file *filep,
>> +				     const char __user *ubuf,
>> +				     size_t size, loff_t *offp)
>> +{
>> +	struct tool_ctx *tc = filep->private_data;
>> +	char buf[32];
>> +	size_t buf_size;
>> +	bool val;
>> +	int rc;
>> +
>> +	buf_size = min(size, (sizeof(buf) - 1));
>> +	if (copy_from_user(buf, ubuf, buf_size))
>> +		return -EFAULT;
>> +
>> +	buf[buf_size] = '\0';
>> +
>> +	rc = strtobool(buf, &val);
>> +	if (rc)
>> +		return rc;
>> +
>> +	tc->link_event = val;
> 
> All writing the event file does is set the value of tc->link_event, so we have the same value that was set when reading the file.  It's rather inefficient, and oops, what if some other script comes along and writes a different value?  If script-A wants to wait for link up, and the link is already up, really it should not wait.  But if script-B changes tc->link_event to wait for link down before script-A reads the file, then script-A will incorrectly wait.
> 
> Really, I think the best thing after all would be just to wait here in the write function.

Yeah, I agree. It makes everything much simpler to block on the write. I
was going on your comment that it was more natural to block on the read.
I'll change this for v3. Are we happy to stick with the 'link' and
'link_event' files? Or do you like the 'link_wait' name better?


Logan

