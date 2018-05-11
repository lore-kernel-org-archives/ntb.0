Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf0-x236.google.com (mail-lf0-x236.google.com. [2a00:1450:4010:c07::236])
        by gmr-mx.google.com with ESMTPS id q44-v6si146067wrb.5.2018.05.11.15.43.56
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 May 2018 15:43:56 -0700 (PDT)
Received: by mail-lf0-x236.google.com with SMTP id 16-v6so442866lfs.13
        for <linux-ntb@googlegroups.com>; Fri, 11 May 2018 15:43:56 -0700 (PDT)
Return-Path: <fancer.lancer@gmail.com>
Date: Sat, 12 May 2018 01:44:01 +0300
From: Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH v2 2/4] NTB :  Add message library NTB API
Message-ID: <20180511224401.GA5458@mobilestation>
References: <1525634420-19370-1-git-send-email-araut@codeaurora.org>
 <1525634420-19370-3-git-send-email-araut@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525634420-19370-3-git-send-email-araut@codeaurora.org>
To: Atul Raut <araut@codeaurora.org>
Cc: linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On Sun, May 06, 2018 at 12:20:18PM -0700, Atul Raut <araut@codeaurora.org> wrote:
> This patch brings in function definations for
> the NTB library API.
> 
> Signed-off-by: Atul Raut <araut@codeaurora.org>
> ---
>  drivers/ntb/ntb.c | 222 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 222 insertions(+)
> 
> diff --git a/drivers/ntb/ntb.c b/drivers/ntb/ntb.c
> index 2581ab7..c025e03 100644
> --- a/drivers/ntb/ntb.c
> +++ b/drivers/ntb/ntb.c
> @@ -258,6 +258,228 @@ int ntb_default_peer_port_idx(struct ntb_dev *ntb, int port)
>  }
>  EXPORT_SYMBOL(ntb_default_peer_port_idx);
>  
> +int nt_spad_cmd_send(struct ntb_dev *ntb, int pidx, enum nt_cmd cmd,
> +			    int cmd_gidx, u64 data)
> +{

These functions aren't used within a work-thread anymore (like it was in the
ntb_perf driver). It means there might be a race-condition of the Scratchpad/Message
registers access from different threads. You must make sure, that the simultaneous
access is ordered.
See the Allen Hubbe comment at the patchset v1.

> +	int try;
> +	u32 sts;
> +	int gidx = ntb_port_number(ntb);
> +
> +	for (try = 0; try < MSG_TRIES; try++) {

>> Allen Hubbe
>> Maybe one try, or msg_tries is a parameter instead of constant.

Allen, there can't be just one try. Imagine you've sent some data to a peer and made it
being notified of incoming data pending in the scratchpad/message registers. Then
the peer handler starts fetching the data from the registers while you or some
other peer tries to send data there before the peer finished the retrieval operation.
In this case you'd need to perform several retries before giving up and return
something like -EAGAIN. As I suggested before, it might be better to move number
of retries parameter definition to the kernel menuconfig.

> +		if (!ntb_link_is_up(ntb, NULL, NULL))
> +			return -ENOLINK;
> +
> +		sts = ntb_peer_spad_read(ntb, pidx,
> +					 NT_SPAD_CMD(gidx));

>> Allen Hubbe
>> Can it be done without reading peer spads?

Alas, it can't within the current communication layer design. We need to check
the status of the sent data. When the peer marked it as read, only then we can
send a next portion of pending outbound data.

> +		if (sts != NT_CMD_INVAL) {
> +			usleep_range(MSG_UDELAY_LOW, MSG_UDELAY_HIGH);

>> Allen Hubbe
>> Even though it doesn't sleep, the delay limits what context this can
>> reasonably be called in.  Imagine if any kind of interrupts were
>> disabled in the caller (eg rcu_read_lock or spin_lock_bh), and then
>> the call in the ntb api delays the caller for 1s, that's not very
>> nice.
>> How bad would it be to take out the retries, or would it just stop working.
>> If taking out the retries breaks it, is there a better way to design
>> the whole thing to be less fragile with respect to timing?  Or maybe
>> schedule_timeout_interruptible would be ok, and just require the
>> caller to be in a context where that is allowed.

Allen, since we have just one channel of communication and have to wait while
a peer reads the data from inbound registers, I don't see other choice but
either to use the status polling design or specifically allocate some Doorbell
bits for notifications (Message registers case doesn't need it). I'd rather
stay with polling case, since it is simpler, consumes less hardware resources,
and well fits both Scratchpad and Message registers hardware. See the comment
in the cover letter with the design suggestion.

> +			continue;
> +		}
> +
> +		ntb_peer_spad_write(ntb, pidx,
> +				    NT_SPAD_LDATA(gidx),
> +				    lower_32_bits(data));
> +		ntb_peer_spad_write(ntb, pidx,
> +				    NT_SPAD_HDATA(gidx),
> +				    upper_32_bits(data));
> +		mmiowb();

>> Allen Hubbe
>> spad_write is like iowrite32, so writes are ordered without extra mmiowb.

Allen, I may misunderstand something, but according to the kernel Documentation in
general they aren't (specifically for prefetchable MWs - hello to the emulated
scratchpads) so we need the MMIO barrier here. See the doc about mmiowb():
https://www.kernel.org/doc/Documentation/memory-barriers.txt
We must make sure, that the data is sent before the status change and
before the peer is notified by means of Doorbell setting.

> +		ntb_peer_spad_write(ntb, pidx,
> +				    NT_SPAD_CMD(gidx),
> +				    cmd);
> +

See the comment above. mmiowb() should be here.

Regards,
-Sergey

> +		ntb_peer_db_set(ntb, NT_SPAD_NOTIFY(cmd_gidx));
> +
> +		break;
> +	}
> +
> +	return try < MSG_TRIES ? 0 : -EAGAIN;
> +}
> +EXPORT_SYMBOL(nt_spad_cmd_send);
> +
> +int nt_spad_cmd_recv(struct ntb_dev *ntb, int *pidx,
> +			enum nt_cmd *cmd, int *cmd_wid, u64 *data)
> +{
> +	u32 val;
> +	int gidx = 0;
> +	int key = ntb_port_number(ntb);
> +
> +	ntb_db_clear(ntb, NT_SPAD_NOTIFY(key));
> +
> +	for (*pidx = 0; *pidx < ntb_peer_port_count(ntb); (*pidx)++, gidx++) {
> +		if ((*pidx) == key)
> +			++gidx;
> +
> +		if (!ntb_link_is_up(ntb, NULL, NULL))
> +			continue;
> +
> +		val = ntb_spad_read(ntb, NT_SPAD_CMD(gidx));
> +		if (val == NT_CMD_INVAL)
> +			continue;
> +
> +		*cmd = val;
> +
> +		val = ntb_spad_read(ntb, NT_SPAD_LDATA(gidx));
> +		*data = val;
> +
> +		val = ntb_spad_read(ntb, NT_SPAD_HDATA(gidx));
> +		*data |= (u64)val << 32;
> +
> +		/* Next command can be retrieved from now */
> +		ntb_spad_write(ntb, NT_SPAD_CMD(gidx),
> +			NT_CMD_INVAL);
> +
> +		return 0;
> +	}
> +
> +	return -ENODATA;
> +}
> +EXPORT_SYMBOL(nt_spad_cmd_recv);
> +
> +int nt_msg_cmd_send(struct ntb_dev *nt, int pidx, enum nt_cmd cmd,
> +int cmd_wid, u64 data)
> +{
> +	int try, ret;
> +	u64 outbits;
> +
> +	outbits = ntb_msg_outbits(nt);
> +	for (try = 0; try < MSG_TRIES; try++) {
> +		if (!ntb_link_is_up(nt, NULL, NULL))
> +			return -ENOLINK;
> +
> +		ret = ntb_msg_clear_sts(nt, outbits);
> +		if (ret)
> +			return ret;
> +
> +		ntb_peer_msg_write(nt, pidx, NT_MSG_LDATA,
> +			cpu_to_le32(lower_32_bits(data)));
> +
> +		if (ntb_msg_read_sts(nt) & outbits) {
> +			usleep_range(MSG_UDELAY_LOW, MSG_UDELAY_HIGH);
> +			continue;
> +		}
> +
> +		ntb_peer_msg_write(nt, pidx, NT_MSG_HDATA,
> +			cpu_to_le32(upper_32_bits(data)));
> +		mmiowb();
> +
> +		ntb_peer_msg_write(nt, pidx, NT_MSG_CMD_WID,
> +			cpu_to_le32(cmd_wid));
> +
> +		/* This call shall trigger peer message event */
> +		ntb_peer_msg_write(nt, pidx, NT_MSG_CMD,
> +			cpu_to_le32(cmd));
> +
> +		break;
> +	}
> +
> +	return try < MSG_TRIES ? 0 : -EAGAIN;
> +}
> +EXPORT_SYMBOL(nt_msg_cmd_send);
> +
> +int nt_msg_cmd_recv(struct ntb_dev *nt, int *pidx,
> +			enum nt_cmd *cmd, int *cmd_wid, u64 *data)
> +{
> +	u64 inbits;
> +	u32 val;
> +
> +	inbits = ntb_msg_inbits(nt);
> +
> +	if (hweight64(ntb_msg_read_sts(nt) & inbits) < 4)
> +		return -ENODATA;
> +
> +	val = ntb_msg_read(nt, pidx, NT_MSG_CMD);
> +	*cmd = le32_to_cpu(val);
> +
> +	val = ntb_msg_read(nt, pidx, NT_MSG_CMD_WID);
> +	*cmd_wid = le32_to_cpu(val);
> +
> +	val = ntb_msg_read(nt, pidx, NT_MSG_LDATA);
> +	*data = le32_to_cpu(val);
> +
> +	val = ntb_msg_read(nt, pidx, NT_MSG_HDATA);
> +	*data |= (u64)le32_to_cpu(val) << 32;
> +
> +	/* Next command can be retrieved from now */
> +	ntb_msg_clear_sts(nt, inbits);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(nt_msg_cmd_recv);
> +
> +int nt_enable_messaging(struct ntb_dev *ndev, int gidx)
> +{
> +	u64 mask, incmd_bit;
> +	int ret, sidx, scnt;
> +
> +	mask = ntb_db_valid_mask(ndev);
> +	(void)ntb_db_set_mask(ndev, mask);
> +
> +	if (ntb_msg_count(ndev) >= NT_MSG_CNT) {
> +		u64 inbits, outbits;
> +
> +		inbits = ntb_msg_inbits(ndev);
> +		outbits = ntb_msg_outbits(ndev);
> +		(void)ntb_msg_set_mask(ndev, inbits | outbits);
> +
> +		incmd_bit = BIT_ULL(__ffs64(inbits));
> +		ret = ntb_msg_clear_mask(ndev, incmd_bit);
> +	} else {
> +		scnt = ntb_spad_count(ndev);
> +		for (sidx = 0; sidx < scnt; sidx++)
> +			ntb_spad_write(ndev, sidx, NT_CMD_INVAL);
> +		incmd_bit = NT_SPAD_NOTIFY(gidx);
> +		ret = ntb_db_clear_mask(ndev, incmd_bit);
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(nt_enable_messaging);
> +
> +void nt_disable_messaging(struct ntb_dev *ndev, int gidx)
> +{
> +	if (ntb_msg_count(ndev) >= NT_MSG_CNT) {
> +		u64 inbits;
> +
> +		inbits = ntb_msg_inbits(ndev);
> +		(void)ntb_msg_set_mask(ndev, inbits);
> +	} else {
> +		(void)ntb_db_set_mask(ndev, NT_SPAD_NOTIFY(gidx));
> +	}
> +
> +}
> +EXPORT_SYMBOL(nt_disable_messaging);
> +
> +int nt_init_messaging(struct ntb_dev *ndev, struct msg_type *msg_ptr)
> +{
> +	u64 mask;
> +	int pcnt = ntb_peer_port_count(ndev);
> +
> +	if (ntb_peer_mw_count(ndev) < (pcnt + 1)) {
> +		dev_err(&ndev->dev, "Not enough memory windows\n");
> +		return -EINVAL;
> +	}
> +
> +	if (ntb_msg_count(ndev) >= NT_MSG_CNT) {
> +		msg_ptr->cmd_send = nt_msg_cmd_send;
> +		msg_ptr->cmd_recv = nt_msg_cmd_recv;
> +
> +		return 0;
> +	}
> +
> +	mask = GENMASK_ULL(pcnt, 0);
> +	if (ntb_spad_count(ndev) >= NT_SPAD_CNT(pcnt) &&
> +	    (ntb_db_valid_mask(ndev) & mask) == mask) {
> +		msg_ptr->cmd_send = nt_spad_cmd_send;
> +		msg_ptr->cmd_recv = nt_spad_cmd_recv;
> +
> +		return 0;
> +	}
> +	dev_err(&ndev->dev, "Command services unsupported\n");
> +
> +	return -EINVAL;
> +}
> +EXPORT_SYMBOL(nt_init_messaging);
> +
>  static int ntb_probe(struct device *dev)
>  {
>  	struct ntb_dev *ntb;
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/1525634420-19370-3-git-send-email-araut%40codeaurora.org.
> For more options, visit https://groups.google.com/d/optout.
