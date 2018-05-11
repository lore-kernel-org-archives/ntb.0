Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf0-x244.google.com (mail-lf0-x244.google.com. [2a00:1450:4010:c07::244])
        by gmr-mx.google.com with ESMTPS id x17-v6si51631wmd.0.2018.05.11.15.40.23
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 May 2018 15:40:23 -0700 (PDT)
Received: by mail-lf0-x244.google.com with SMTP id p85-v6so10012429lfg.7
        for <linux-ntb@googlegroups.com>; Fri, 11 May 2018 15:40:23 -0700 (PDT)
Return-Path: <fancer.lancer@gmail.com>
Date: Sat, 12 May 2018 01:40:27 +0300
From: Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH v2 1/4] NTB : Introduce message library
Message-ID: <20180511224027.GA25768@mobilestation>
References: <1525634420-19370-1-git-send-email-araut@codeaurora.org>
 <1525634420-19370-2-git-send-email-araut@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525634420-19370-2-git-send-email-araut@codeaurora.org>
To: Atul Raut <araut@codeaurora.org>
Cc: linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On Sun, May 06, 2018 at 12:20:17PM -0700, Atul Raut <araut@codeaurora.org> wrote:
> Library created by refactoring common code from
> ntb_perf module so that all client can make use
> of it.
> The library is based on scratchpad and message registers
> based apis.
> 

See the comment in the cover letter. I suggest to have a separate header file
for the library interface somewhere like:
include/linux/ntb_lib_exch.h

> Signed-off-by: Atul Raut <araut@codeaurora.org>
> ---
>  include/linux/ntb.h | 163 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 163 insertions(+)
> 
> diff --git a/include/linux/ntb.h b/include/linux/ntb.h
> index 181d166..19fe973 100644
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

>> Allen Hubbe
>> 500 * 2000us = 1s is a long delay for a caller that might not have the
>> luxury of being able to wait.

Since this is the driver configurable parameter we can make it available
in the kernel config menu. Allen?

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

These macro are specific to the client drivers, particularly to the
ntb_perf driver, so they need to stay there and being used on top
of the Cross-Interface library.

>  /**
>   * struct ntb_client_ops - ntb client operations
>   * @probe:		Notify client of a new device.
> @@ -1502,4 +1554,115 @@ static inline int ntb_peer_msg_write(struct ntb_dev *ntb, int pidx, int midx,
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
> +int nt_spad_cmd_send(struct ntb_dev *ntb, int pidx, enum nt_cmd cmd,
> +		     int cmd_gidx, u64 data);
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
> +int nt_spad_cmd_recv(struct ntb_dev *ntb, int *pidx,
> +		     enum nt_cmd *cmd, int *cmd_wid, u64 *data);
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
> +int nt_msg_cmd_send(struct ntb_dev *nt, int pidx, enum nt_cmd cmd,
> +		    int cmd_wid, u64 data);
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
> +int nt_msg_cmd_recv(struct ntb_dev *nt, int *pidx,
> +		    enum nt_cmd *cmd, int *cmd_wid, u64 *data);
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
> +int nt_enable_messaging(struct ntb_dev *ndev, int gidx);
> +
> +/**
> + * nt_disable_messaging() - Disable messaging support.
> + * @ntb:	NTB device context.
> + * @gidx:	Global device Index
> + *
> + * Check message type(spad/message) and disable messaging support.
> + *
> + */
> +void nt_disable_messaging(struct ntb_dev *ndev, int gidx);
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
> +int nt_init_messaging(struct ntb_dev *ndev, struct msg_type *msg_ptr);
> +

See the cover letter comment with the design considerations.

Regards,
-Sergey

>  #endif
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/1525634420-19370-2-git-send-email-araut%40codeaurora.org.
> For more options, visit https://groups.google.com/d/optout.
