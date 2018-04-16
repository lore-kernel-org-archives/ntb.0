Return-Path: <dave.jiang@intel.com>
Received: from mga17.intel.com (mga17.intel.com. [192.55.52.151])
        by gmr-mx.google.com with ESMTPS id m7si1281656qtn.2.2018.04.16.09.26.05
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Apr 2018 09:26:05 -0700 (PDT)
Subject: Re: [PATCH] NTB: Add support to message registers based devices
References: <20180410004822.GA6040@codeaurora.org>
 <CAJ80sauVAeFLfMMQxqnCThUZnYJ1A7Kvy=UogPMe_kWCu_Dw9w@mail.gmail.com>
 <c4d81c97-71f3-a832-2b6b-52c84b9854ac@codeaurora.org>
From: Dave Jiang <dave.jiang@intel.com>
Message-ID: <3dbf0543-8a0c-5493-54d3-116514a55a1b@intel.com>
Date: Mon, 16 Apr 2018 09:26:03 -0700
MIME-Version: 1.0
In-Reply-To: <c4d81c97-71f3-a832-2b6b-52c84b9854ac@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Atul Raut <araut@codeaurora.org>, Allen Hubbe <allenbh@gmail.com>
Cc: linux-ntb@googlegroups.com, fancer.lancer@gmail.com, Jon Mason <jdmason@kudzu.us>, atulraut17@gmail.com, rauji.raut@gmail.com
List-ID: <linux-ntb.googlegroups.com>



On 04/13/2018 07:13 PM, Atul Raut wrote:
> Hi Allen,Dave,
> 
> I have split the patches & sharing here for review. 
> Also addressing some of comments for ntb.h.
> All three patches are dependent to each other.
> Some comments didnt address, as code derived from ntb_perf
> module so please revisit it again.

Please post them as a series of 3 separate patches with a cover.

> 
>>> 500 * 2000us = 1s is a long delay for a caller that might not have the
>>> luxury of being able to wait.
> Library is derive from ntb_perf module with some modifications 
> to it by removing ntb_perf related stuff & try to make it generic.
>  
>>> These functions are complex to keep in the header file.
> Shall I introduce new .[c] as library file here say ntblib.c ?

It's just for message registers right? Maybe ntb_message.c? But yes I
think if you are going to have common code, you'll need new .c files. I
wonder if we should have a ./lib directory for common code being shared
by various transports. Jon or Allen?


> 
> Regards,
> Atul
> 
> From 452d7f703fe2cfbd3e31f9a507673975e2dcb1f6 Mon Sep 17 00:00:00 2001
> From: Atul Raut <araut@codeaurora.org>
> Date: Fri, 13 Apr 2018 18:43:47 -0700
> Subject: [PATCH 3/3] NTB :  Introduce message library
> 
> Library created by refactoring common code from
> ntb_perf module so that all client can make use
> of it.
> The library is based on scratchpad and message registers
> based apis.
> 
> Signed-off-by: Atul Raut <araut@codeaurora.org>
> ---
>  include/linux/ntb.h | 360 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 360 insertions(+)
> 
> diff --git a/include/linux/ntb.h b/include/linux/ntb.h
> index 181d166..287afd3 100644
> --- a/include/linux/ntb.h
> +++ b/include/linux/ntb.h
> @@ -58,6 +58,8 @@
>  
>  #include <linux/completion.h>
>  #include <linux/device.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
>  
>  struct ntb_client;
>  struct ntb_dev;
> @@ -163,6 +165,56 @@ enum ntb_default_port {
>  #define NTB_DEF_PEER_CNT	(1)
>  #define NTB_DEF_PEER_IDX	(0)
>  
> +enum nt_cmd {
> +	NT_CMD_INVAL = -1,/* invalid spad command */
> +	NT_CMD_SSIZE = 0, /* send out buffer size */
> +	NT_CMD_RSIZE = 1, /* recv in  buffer size */
> +	NT_CMD_SXLAT = 2, /* send in  buffer xlat */
> +	NT_CMD_RXLAT = 3, /* recv out buffer xlat */
> +	NT_CMD_CLEAR = 4, /* clear allocated memory */
> +	NT_STS_DONE  = 5, /* init is done */
> +	NT_STS_LNKUP = 6, /* link up state flag */
> +	NT_QP_LINKS        = 7, /* available QP link */
> +	NT_CMD_NUM_MWS        = 8, /* number of memory windows */
> +	NT_CMD_NUM_QPS        = 9, /* number of QP */
> +	NT_CMD_NTB_VERSION    = 10, /* ntb version */
> +};
> +
> +struct msg_type {
> +/* Scratchpad/Message IO operations */
> +	int (*cmd_send)(struct ntb_dev *nt, int pidx, enum nt_cmd cmd,
> +			int cmd_wid, u64 data);
> +	int (*cmd_recv)(struct ntb_dev *nt, int *pidx, enum nt_cmd *cmd,
> +			int *cmd_wid, u64 *data);
> +};
> +
> +#define MSG_TRIES		50
> +#define MSG_UDELAY_LOW		1000
> +#define MSG_UDELAY_HIGH		2000
> +
> +/**
> + * Scratchpads-base commands interface
> + */
> +#define NT_SPAD_CNT(_pcnt) \
> +	(3*((_pcnt) + 1))
> +#define NT_SPAD_CMD(_gidx) \
> +	(3*(_gidx))
> +#define NT_SPAD_LDATA(_gidx) \
> +	(3*(_gidx) + 1)
> +#define NT_SPAD_HDATA(_gidx) \
> +	(3*(_gidx) + 2)
> +#define NT_SPAD_NOTIFY(_gidx) \
> +	(BIT_ULL(_gidx))
> +
> +/**
> + * Messages-base commands interface
> + */
> +#define NT_MSG_CMD		0
> +#define NT_MSG_CMD_WID	        1
> +#define NT_MSG_LDATA		2
> +#define NT_MSG_HDATA		3
> +#define NT_MSG_CNT		4
> +
>  /**
>   * struct ntb_client_ops - ntb client operations
>   * @probe:		Notify client of a new device.
> @@ -1502,4 +1554,312 @@ static inline int ntb_peer_msg_write(struct ntb_dev *ntb, int pidx, int midx,
>  	return ntb->ops->peer_msg_write(ntb, pidx, midx, msg);
>  }
>  
> +/**
> + * nt_spad_cmd_send() - send messages to peer using spad register.
> + * @ntb:	NTB device context.
> + * @pidx:	Port index of peer device.
> + * @cmd:	ntb commands.
> + * @cmd_gidx:	Global device index.
> + * @data:	message data.
> + *
> + * Send data to the port specific scratchpad
> + *
> + * Perform predefined number of attempts before give up.
> + * We are sending the data to the port specific scratchpad, so
> + * to prevent a multi-port access race-condition. Additionally
> + * there is no need in local locking since only thread-safe
> + * service work is using this method.
> + *
> + * Set peer db to inform data is ready.
> + *
> + * Return: Zero on success, otherwise an error number.
> + */
> +static int nt_spad_cmd_send(struct ntb_dev *ntb, int pidx, enum nt_cmd cmd,
> +			    int cmd_gidx, u64 data)
> +{
> +	int try;
> +	u32 sts;
> +	int gidx = ntb_port_number(ntb);
> +
> +	for (try = 0; try < MSG_TRIES; try++) {
> +		if (!ntb_link_is_up(ntb, NULL, NULL))
> +			return -ENOLINK;
> +
> +		sts = ntb_peer_spad_read(ntb, pidx,
> +					 NT_SPAD_CMD(gidx));
> +		if (sts != NT_CMD_INVAL) {
> +			usleep_range(MSG_UDELAY_LOW, MSG_UDELAY_HIGH);
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
> +		ntb_peer_spad_write(ntb, pidx,
> +				    NT_SPAD_CMD(gidx),
> +				    cmd);
> +
> +		ntb_peer_db_set(ntb, NT_SPAD_NOTIFY(cmd_gidx));
> +
> +		break;
> +	}
> +
> +	return try < MSG_TRIES ? 0 : -EAGAIN;
> +}
> +
> +/**
> + * nt_spad_cmd_recv() - Receive the messages using spad register.
> + * @ntb:	NTB device context.
> + * @pidx:	Port index of peer device a message being receive
> + * @cmd:	NTB command
> + * @cmd_wid:	Gloable device Index
> + * @data:	Received data
> + *
> + * Clear bits in the peer doorbell register, arming the bits for the next
> + * doorbell.
> + *
> + * We start scanning all over, since cleared DB may have been set
> + * by any peer. Yes, it makes peer with smaller index being
> + * serviced with greater priority, but it's convenient for spad
> + * and message code unification and simplicity.
> + *
> + * Return: Zero on success, otherwise an error number.
> + */
> +static int nt_spad_cmd_recv(struct ntb_dev *ntb, int *pidx,
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
> +
> +/**
> + * nt_msg_cmd_send() - send messages to peer using message register.
> + * @ntb:	NTB device context.
> + * @pidx:	Port index of peer device.
> + * @cmd:	ntb commands.
> + * @cmd_gidx:	Memory window index.
> + * @data:	message data.
> + *
> + * Perform predefined number of attempts before give up. Message
> + * registers are free of race-condition problem when accessed
> + * from different ports, so we don't need splitting registers
> + * by global device index. We also won't have local locking,
> + * since the method is used from service work only.
> + *
> + * Return: Zero on success, otherwise an error number.
> + */
> +static int nt_msg_cmd_send(struct ntb_dev *nt, int pidx, enum nt_cmd cmd,
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
> +
> +/**
> + * nt_msg_cmd_recv() - Receive the messages using message register.
> + * @ntb:	NTB device context.
> + * @pidx:	Port index of peer device a message being receive
> + * @cmd:	NT command
> + * @cmd_wid:	Memory window Index
> + * @data:	Received data
> + *
> + * Get memory window index and data.
> + *
> + * Return: Zero on success, otherwise an error number.
> + */
> +static int nt_msg_cmd_recv(struct ntb_dev *nt, int *pidx,
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
> +
> +/**
> + * nt_enable_messaging() - Enable messaging support.
> + * @ntb:	NTB device context.
> + * @gitx:	Global device Index.
> + *
> + * Check which messaging support to enable
> + *
> + * Return: Zero on success, otherwise an error number.
> + */
> +static int nt_enable_messaging(struct ntb_dev *ndev, int gidx)
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
> +
> +/**
> + * nt_disable_messaging() - Disable messaging support.
> + * @ntb:	NTB device context.
> + * @gidx:	Global device Index
> + *
> + * Check message type(spad/message) and disable messaging support.
> + *
> + */
> +static void nt_disable_messaging(struct ntb_dev *ndev, int gidx)
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
> +
> +/**
> + * nt_init_messaging() - Enable Messaging
> + * @ntb:	NTB device context.
> + * @msg_ptr:	Handle to function pointers Scratchpad or Message.
> + *
> + *
> + * Enable Scratchpad/Message IO operations.
> + *
> + * Return: Zero on success, otherwise an error number.
> + */
> +static int nt_init_messaging(struct ntb_dev *ndev, struct msg_type *msg_ptr)
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
> +
>  #endif
> 
