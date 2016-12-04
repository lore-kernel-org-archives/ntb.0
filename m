Return-Path: <Allen.Hubbe@dell.com>
Received: from esa8.dell-outbound.iphmx.com (esa8.dell-outbound.iphmx.com. [68.232.149.218])
        by gmr-mx.google.com with ESMTPS id b67si861717ywc.2.2016.12.03.16.05.47
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Dec 2016 16:05:48 -0800 (PST)
From: "Allen Hubbe" <Allen.Hubbe@dell.com>
Subject: RE: [PATCH 04/22] NTB: Add messaging NTB API
Date: Sat, 3 Dec 2016 19:05:17 -0500
Message-ID: <003f01d24dc2$18faf5e0$4af0e1a0$@dell.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
To: 'Serge Semin' <fancer.lancer@gmail.com>, jdmason@kudzu.us, dave.jiang@intel.com, Xiangliang.Yu@amd.com
Cc: Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

From: Serge Semin 
> IDT PCIe-switches have message registers to communicate with peer devices.
> This patch adds new NTB API callback methods, which can be used to utilize
> these registers functionality.
> 

Please split: add msg api; make spads optional.

See comments below on ntb_dev_ops_is_valid.

> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> 
> ---
>  drivers/ntb/ntb.c   |  13 +++
>  include/linux/ntb.h | 236 ++++++++++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 241 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/ntb/ntb.c b/drivers/ntb/ntb.c
> index 2e25307..4b2cc60 100644
> --- a/drivers/ntb/ntb.c
> +++ b/drivers/ntb/ntb.c
> @@ -191,6 +191,19 @@ void ntb_db_event(struct ntb_dev *ntb, int vector)
>  }
>  EXPORT_SYMBOL(ntb_db_event);
> 
> +void ntb_msg_event(struct ntb_dev *ntb)
> +{
> +	unsigned long irqflags;
> +
> +	spin_lock_irqsave(&ntb->ctx_lock, irqflags);
> +	{
> +		if (ntb->ctx_ops && ntb->ctx_ops->msg_event)
> +			ntb->ctx_ops->msg_event(ntb->ctx);
> +	}
> +	spin_unlock_irqrestore(&ntb->ctx_lock, irqflags);
> +}
> +EXPORT_SYMBOL(ntb_msg_event);
> +
>  static int ntb_probe(struct device *dev)
>  {
>  	struct ntb_dev *ntb;
> diff --git a/include/linux/ntb.h b/include/linux/ntb.h
> index 4a150b5..59de1f6 100644
> --- a/include/linux/ntb.h
> +++ b/include/linux/ntb.h
> @@ -146,10 +146,12 @@ static inline int ntb_client_ops_is_valid(const struct
> ntb_client_ops *ops)
>   * struct ntb_ctx_ops - ntb driver context operations
>   * @link_event:		See ntb_link_event().
>   * @db_event:		See ntb_db_event().
> + * @msg_event:		See ntb_msg_event().
>   */
>  struct ntb_ctx_ops {
>  	void (*link_event)(void *ctx);
>  	void (*db_event)(void *ctx, int db_vector);
> +	void (*msg_event)(void *ctx);
>  };
> 
>  static inline int ntb_ctx_ops_is_valid(const struct ntb_ctx_ops *ops)
> @@ -158,6 +160,7 @@ static inline int ntb_ctx_ops_is_valid(const struct ntb_ctx_ops *ops)
>  	return
>  		/* ops->link_event		&& */
>  		/* ops->db_event		&& */
> +		/* ops->msg_event		&& */
>  		1;
>  }
> 
> @@ -202,6 +205,15 @@ static inline int ntb_ctx_ops_is_valid(const struct ntb_ctx_ops *ops)
>   * @peer_spad_addr:	See ntb_peer_spad_addr().
>   * @peer_spad_read:	See ntb_peer_spad_read().
>   * @peer_spad_write:	See ntb_peer_spad_write().
> + * @msg_count:		See ntb_msg_count().
> + * @msg_inbits:		See ntb_msg_inbits().
> + * @msg_outbits:	See ntb_msg_outbits().
> + * @msg_read_sts:	See ntb_msg_read_sts().
> + * @msg_clear_sts:	See ntb_msg_clear_sts().
> + * @msg_set_mask:	See ntb_msg_set_mask().
> + * @msg_clear_mask:	See ntb_msg_clear_mask().
> + * @msg_read:		See ntb_msg_read().
> + * @msg_write:		See ntb_msg_write().
>   */
>  struct ntb_dev_ops {
>  	int (*port_number)(struct ntb_dev *ntb);
> @@ -263,6 +275,16 @@ struct ntb_dev_ops {
>  			      phys_addr_t *spad_addr);
>  	u32 (*peer_spad_read)(struct ntb_dev *ntb, int idx);
>  	int (*peer_spad_write)(struct ntb_dev *ntb, int idx, u32 val);
> +
> +	int (*msg_count)(struct ntb_dev *ntb);
> +	u64 (*msg_inbits)(struct ntb_dev *ntb);
> +	u64 (*msg_outbits)(struct ntb_dev *ntb);
> +	u64 (*msg_read_sts)(struct ntb_dev *ntb);
> +	int (*msg_clear_sts)(struct ntb_dev *ntb, u64 sts_bits);
> +	int (*msg_set_mask)(struct ntb_dev *ntb, u64 mask_bits);
> +	int (*msg_clear_mask)(struct ntb_dev *ntb, u64 mask_bits);
> +	int (*msg_read)(struct ntb_dev *ntb, int midx, int *pidx, u32 *msg);
> +	int (*msg_write)(struct ntb_dev *ntb, int midx, int pidx, u32 msg);
>  };
> 
>  static inline int ntb_dev_ops_is_valid(const struct ntb_dev_ops *ops)
> @@ -304,13 +326,22 @@ static inline int ntb_dev_ops_is_valid(const struct ntb_dev_ops
> *ops)
>  		/* ops->peer_db_read_mask		&& */
>  		/* ops->peer_db_set_mask		&& */
>  		/* ops->peer_db_clear_mask		&& */
> -		/* ops->spad_is_unsafe			&& */
> -		ops->spad_count				&&
> -		ops->spad_read				&&
> -		ops->spad_write				&&
> -		/* ops->peer_spad_addr			&& */
> -		/* ops->peer_spad_read			&& */
> -		ops->peer_spad_write			&&
> +		((/* ops->spad_is_unsafe		&& */
> +		  ops->spad_count			&&
> +		  ops->spad_read			&&
> +		  ops->spad_write			&&
> +		  /* ops->peer_spad_addr		&& */
> +		  /* ops->peer_spad_read		&& */
> +		  ops->peer_spad_write)			||
> +		 (ops->msg_count			&&
> +		  ops->msg_inbits			&&
> +		  ops->msg_outbits			&&
> +		  ops->msg_read_sts			&&
> +		  ops->msg_clear_sts			&&
> +		  /* ops->msg_set_mask			&& */
> +		  /* ops->msg_clear_mask		&& */
> +		  ops->msg_read				&&
> +		  ops->msg_write))			&&

Don't enforce "must have spad or msg" here, leave it to application to check spad_count != 0 or msg_count != 0 else fail.  If an ntb doesn't have either, it may be rather limited, but let's not prevent the driver to register that device.

As written above has a subtle bug.  We should say, if spad is implemented at all, then the basic spad api is fully implemented; likewise if msg is implemented at all, then the basic msg api is fully implemented.

As written below, the required basic api of spad ops must have the same truth-value of spad_count (and likewise for msg_count).

		/* !ops->spad_is_unsafe	== !ops->spad_count && */
		!ops->spad_read			== !ops->spad_count &&
		!ops->spad_write		== !ops->spad_count &&
		/* !ops->peer_spad_addr	== !ops->spad_count && */
		/* !ops->peer_spad_read	== !ops->spad_count && */
		!ops->peer_spad_write 	== !ops->spad_count &&

		!ops->msg_inbits		== !ops->msg_count &&
		!ops->msg_outbits		== !ops->msg_count &&
		!ops->msg_read_sts		== !ops->msg_count &&
		!ops->msg_clear_sts		== !ops->msg_count &&
		/* !ops->msg_set_mask		== !ops->msg_count && */
		/* !ops->msg_clear_mask	== !ops->msg_count && */
		!ops->msg_read			== !ops->msg_count &&
		!ops->msg_write			== !ops->msg_count &&

>  		1;
>  }
> 
> @@ -456,6 +487,18 @@ void ntb_link_event(struct ntb_dev *ntb);
>  void ntb_db_event(struct ntb_dev *ntb, int vector);
> 
>  /**
> + * ntb_msg_event() - notify driver context of a message event
> + * @ntb:	NTB device context.
> + *
> + * Notify the driver context of a message event.  If hardware supports
> + * message registers, this event indicates, that a new message arrived in
> + * some incoming message register or last sent message couldn't be delivered.
> + * The events can be masked/unmasked by the methods ntb_msg_set_mask() and
> + * ntb_msg_clear_mask().
> + */
> +void ntb_msg_event(struct ntb_dev *ntb);
> +
> +/**
>   * ntb_port_number() - get the local port number
>   * @ntb:	NTB device context.
>   *
> @@ -1154,7 +1197,7 @@ static inline int ntb_spad_is_unsafe(struct ntb_dev *ntb)
>  }
> 
>  /**
> - * ntb_mw_count() - get the number of scratchpads
> + * ntb_spad_count() - get the number of scratchpads
>   * @ntb:	NTB device context.
>   *
>   * Hardware and topology may support a different number of scratchpads.
> @@ -1163,6 +1206,9 @@ static inline int ntb_spad_is_unsafe(struct ntb_dev *ntb)
>   */
>  static inline int ntb_spad_count(struct ntb_dev *ntb)
>  {
> +	if (!ntb->ops->spad_count)
> +		return 0;
> +
>  	return ntb->ops->spad_count(ntb);
>  }
> 
> @@ -1177,6 +1223,9 @@ static inline int ntb_spad_count(struct ntb_dev *ntb)
>   */
>  static inline u32 ntb_spad_read(struct ntb_dev *ntb, int idx)
>  {
> +	if (!ntb->ops->spad_read)
> +		return ~(u32)0;
> +
>  	return ntb->ops->spad_read(ntb, idx);
>  }
> 
> @@ -1192,6 +1241,9 @@ static inline u32 ntb_spad_read(struct ntb_dev *ntb, int idx)
>   */
>  static inline int ntb_spad_write(struct ntb_dev *ntb, int idx, u32 val)
>  {
> +	if (!ntb->ops->spad_write)
> +		return -EINVAL;
> +
>  	return ntb->ops->spad_write(ntb, idx, val);
>  }
> 
> @@ -1226,6 +1278,9 @@ static inline int ntb_peer_spad_addr(struct ntb_dev *ntb, int idx,
>   */
>  static inline u32 ntb_peer_spad_read(struct ntb_dev *ntb, int idx)
>  {
> +	if (!ntb->ops->peer_spad_read)
> +		return ~(u32)0;
> +
>  	return ntb->ops->peer_spad_read(ntb, idx);
>  }
> 
> @@ -1241,7 +1296,172 @@ static inline u32 ntb_peer_spad_read(struct ntb_dev *ntb, int idx)
>   */
>  static inline int ntb_peer_spad_write(struct ntb_dev *ntb, int idx, u32 val)
>  {
> +	if (!ntb->ops->peer_spad_write)
> +		return -EINVAL;
> +
>  	return ntb->ops->peer_spad_write(ntb, idx, val);
>  }
> 
> +/**
> + * ntb_msg_count() - get the number of message registers
> + * @ntb:	NTB device context.
> + *
> + * Hardware may support a different number of messge registers.
> + *
> + * Return: the number of message registers.
> + */
> +static inline int ntb_msg_count(struct ntb_dev *ntb)
> +{
> +	if (!ntb->ops->msg_count)
> +		return 0;
> +
> +	return ntb->ops->msg_count(ntb);
> +}
> +
> +/**
> + * ntb_msg_inbits() - get a bitsfield of inbound message registers status
> + * @ntb:	NTB device context.
> + *
> + * The method returns the bitsfield of status and mask registers, which related
> + * to inbound message registers.
> + *
> + * Return: bitsfield of inbound message registers.
> + */
> +static inline u64 ntb_msg_inbits(struct ntb_dev *ntb)
> +{
> +	if (!ntb->ops->msg_inbits)
> +		return 0;
> +
> +	return ntb->ops->msg_inbits(ntb);
> +}
> +
> +/**
> + * ntb_msg_outbits() - get a bitsfield of outbound message registers status
> + * @ntb:	NTB device context.
> + *
> + * The method returns the bitsfield of status and mask registers, which related
> + * to outbound message registers.
> + *
> + * Return: bitsfield of outbound message registers.
> + */
> +static inline u64 ntb_msg_outbits(struct ntb_dev *ntb)
> +{
> +	if (!ntb->ops->msg_outbits)
> +		return 0;
> +
> +	return ntb->ops->msg_outbits(ntb);
> +}
> +
> +/**
> + * ntb_msg_read_sts() - read the message registers status
> + * @ntb:	NTB device context.
> + *
> + * Read the status of message register. Inbound and outbound message registers
> + * related bits can be filetered by masks retrieved from ntb_msg_inbits() and
> + * ntb_msg_outbits().
> + *
> + * Return: status bits of message registers
> + */
> +static inline u64 ntb_msg_read_sts(struct ntb_dev *ntb)
> +{
> +	if (!ntb->ops->msg_read_sts)
> +		return 0;
> +
> +	return ntb->ops->msg_read_sts(ntb);
> +}
> +
> +/**
> + * ntb_msg_clear_sts() - clear status bits of message registers
> + * @ntb:	NTB device context.
> + * @sts_bits:	Status bits to clear.
> + *
> + * Clear bits in the status register.
> + *
> + * Return: Zero on success, otherwise a negative error number.
> + */
> +static inline int ntb_msg_clear_sts(struct ntb_dev *ntb, u64 sts_bits)
> +{
> +	if (!ntb->ops->msg_clear_sts)
> +		return -EINVAL;
> +
> +	return ntb->ops->msg_clear_sts(ntb, sts_bits);
> +}
> +
> +/**
> + * ntb_msg_set_mask() - set mask of message register status bits
> + * @ntb:	NTB device context.
> + * @mask_bits:	Mask bits.
> + *
> + * Mask the message registers status bits from raising the message event.
> + *
> + * Return: Zero on success, otherwise a negative error number.
> + */
> +static inline int ntb_msg_set_mask(struct ntb_dev *ntb, u64 mask_bits)
> +{
> +	if (!ntb->ops->msg_set_mask)
> +		return -EINVAL;
> +
> +	return ntb->ops->msg_set_mask(ntb, mask_bits);
> +}
> +
> +/**
> + * ntb_msg_clear_mask() - clear message registers mask
> + * @ntb:	NTB device context.
> + * @mask_bits:	Mask bits to clear.
> + *
> + * Clear bits in the message events mask register.
> + *
> + * Return: Zero on success, otherwise a negative error number.
> + */
> +static inline int ntb_msg_clear_mask(struct ntb_dev *ntb, u64 mask_bits)
> +{
> +	if (!ntb->ops->msg_clear_mask)
> +		return -EINVAL;
> +
> +	return ntb->ops->msg_clear_mask(ntb, mask_bits);
> +}
> +
> +/**
> + * ntb_msg_read() - read message register with specified index
> + * @ntb:	NTB device context.
> + * @midx:	Message register index
> + * @pidx:	OUT - Port index of peer device a message retrieved from
> + * @msg:	OUT - Data
> + *
> + * Read data from the specified message register. Source port index of a
> + * message is retrieved as well.
> + *
> + * Return: Zero on success, otherwise a negative error number.
> + */
> +static inline int ntb_msg_read(struct ntb_dev *ntb, int midx, int *pidx,
> +			       u32 *msg)
> +{
> +	if (!ntb->ops->msg_read)
> +		return -EINVAL;
> +
> +	return ntb->ops->msg_read(ntb, midx, pidx, msg);
> +}
> +
> +/**
> + * ntb_msg_write() - write data to the specified message register
> + * @ntb:	NTB device context.
> + * @midx:	Message register index
> + * @pidx:	Port index of peer device a message being sent to
> + * @msg:	Data to send
> + *
> + * Send data to a specified peer device using the defined message register.
> + * Message event can be raised if the midx registers isn't empty while
> + * calling this method and the corresponding interrupt isn't masked.
> + *
> + * Return: Zero on success, otherwise a negative error number.
> + */
> +static inline int ntb_msg_write(struct ntb_dev *ntb, int midx, int pidx,
> +				u32 msg)
> +{
> +	if (!ntb->ops->msg_write)
> +		return -EINVAL;
> +
> +	return ntb->ops->msg_write(ntb, midx, pidx, msg);
> +}
> +
>  #endif
> --
> 2.6.6


