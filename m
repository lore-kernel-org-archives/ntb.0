Return-Path: <Allen.Hubbe@dell.com>
Received: from esa8.dell-outbound.iphmx.com (esa8.dell-outbound.iphmx.com. [68.232.149.218])
        by gmr-mx.google.com with ESMTPS id p22si2736273ywe.3.2016.12.12.20.15.02
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Dec 2016 20:15:02 -0800 (PST)
From: "Allen Hubbe" <Allen.Hubbe@dell.com>
Subject: RE: [PATCH v2 9/9] NTB: Add ntb.h comments
Date: Mon, 12 Dec 2016 23:14:41 -0500
Message-ID: <000801d254f7$6f2b2700$4d817500$@dell.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
To: 'Serge Semin' <fancer.lancer@gmail.com>, jdmason@kudzu.us, dave.jiang@intel.com, Xiangliang.Yu@amd.com
Cc: Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

From: Serge Semin
> 
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> 
> ---
>  include/linux/ntb.h | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/ntb.h b/include/linux/ntb.h
> index fe0437c..c5a369c 100644
> --- a/include/linux/ntb.h
> +++ b/include/linux/ntb.h
> @@ -312,13 +312,18 @@ static inline int ntb_dev_ops_is_valid(const struct ntb_dev_ops
> *ops)
>  {
>  	/* commented callbacks are not required: */
>  	return
> +		/* Port operations are required */

Maybe: are required for multiport devices.

>  		ops->port_number			&&
>  		ops->peer_port_count			&&
>  		ops->peer_port_number			&&
>  		ops->peer_port_idx			&&
> +
> +		/* Link operations are requiered */
>  		ops->link_is_up				&&
>  		ops->link_enable			&&
>  		ops->link_disable			&&

Wasn't the first patch in this series all about making link ops first?

> +
> +		/* One or both MW interfaces should be developed */
>  		ops->mw_count				&&
>  		ops->mw_get_align			&&
>  		(ops->mw_set_trans			||
> @@ -328,12 +333,11 @@ static inline int ntb_dev_ops_is_valid(const struct ntb_dev_ops
> *ops)
>  		ops->peer_mw_get_addr			&&
>  		/* ops->peer_mw_clear_trans		&& */
> 
> +		/* Doorbell operations are mostly required */
>  		/* ops->db_is_unsafe			&& */
>  		ops->db_valid_mask			&&
> -
>  		/* both set, or both unset */
>  		(!ops->db_vector_count == !ops->db_vector_mask) &&
> -
>  		ops->db_read				&&
>  		/* ops->db_set				&& */
>  		ops->db_clear				&&
> @@ -347,6 +351,8 @@ static inline int ntb_dev_ops_is_valid(const struct ntb_dev_ops *ops)
>  		/* ops->peer_db_read_mask		&& */
>  		/* ops->peer_db_set_mask		&& */
>  		/* ops->peer_db_clear_mask		&& */
> +
> +		/* Scrachpad interface is optional */
>  		/* !ops->spad_is_unsafe == !ops->spad_count && */
>  		!ops->spad_read == !ops->spad_count	&&
>  		!ops->spad_write == !ops->spad_count	&&
> @@ -354,6 +360,7 @@ static inline int ntb_dev_ops_is_valid(const struct ntb_dev_ops *ops)
>  		/* !ops->peer_spad_read == !ops->spad_count && */
>  		!ops->peer_spad_write == !ops->spad_count &&
> 
> +		/* Message registers interface is optional */
>  		!ops->msg_inbits == !ops->msg_count	&&
>  		!ops->msg_outbits == !ops->msg_count	&&
>  		!ops->msg_read_sts == !ops->msg_count	&&
> @@ -374,13 +381,12 @@ struct ntb_client {
>  	struct device_driver		drv;
>  	const struct ntb_client_ops	ops;
>  };
> -
>  #define drv_ntb_client(__drv) container_of((__drv), struct ntb_client, drv)
> 
>  /**
>   * struct ntb_device - ntb device
>   * @dev:		Linux device object.
> - * @pdev:		Pci device entry of the ntb.
> + * @pdev:		PCI device entry of the ntb.
>   * @topo:		Detected topology of the ntb.
>   * @ops:		See &ntb_dev_ops.
>   * @ctx:		See &ntb_ctx_ops.
> @@ -401,7 +407,6 @@ struct ntb_dev {
>  	/* block unregister until device is fully released */
>  	struct completion		released;
>  };
> -
>  #define dev_ntb(__dev) container_of((__dev), struct ntb_dev, dev)
> 
>  /**
> @@ -498,7 +503,7 @@ void ntb_link_event(struct ntb_dev *ntb);
>   * multiple interrupt vectors for doorbells, the vector number indicates which
>   * vector received the interrupt.  The vector number is relative to the first
>   * vector used for doorbells, starting at zero, and must be less than
> - ** ntb_db_vector_count().  The driver may call ntb_db_read() to check which
> + * ntb_db_vector_count().  The driver may call ntb_db_read() to check which
>   * doorbell bits need service, and ntb_db_vector_mask() to determine which of
>   * those bits are associated with the vector number.
>   */
> --
> 2.6.6


