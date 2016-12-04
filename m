Return-Path: <Allen.Hubbe@dell.com>
Received: from esa1.dell-outbound.iphmx.com (esa1.dell-outbound.iphmx.com. [68.232.153.90])
        by gmr-mx.google.com with ESMTPS id i9si881735ywc.0.2016.12.03.16.06.01
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Dec 2016 16:06:01 -0800 (PST)
From: "Allen Hubbe" <Allen.Hubbe@dell.com>
Subject: RE: [PATCH 06/22] NTB: Slightly alter link state NTB API
Date: Sat, 3 Dec 2016 19:05:42 -0500
Message-ID: <004101d24dc2$27bbf7f0$7733e7d0$@dell.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
To: 'Serge Semin' <fancer.lancer@gmail.com>, jdmason@kudzu.us, dave.jiang@intel.com, Xiangliang.Yu@amd.com
Cc: Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

From: Serge Semin 
> Some minor changes of link state NTB API. Particularly link_is_up()
> method from now shall return a bitfield of link states for all accessible
> port indexes.

Looks good.  I plan to ack.

See comment on ntb_link_enable.

> 
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> 
> ---
>  include/linux/ntb.h | 31 ++++++++++++++++---------------
>  1 file changed, 16 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/ntb.h b/include/linux/ntb.h
> index fc9d034..a59a155 100644
> --- a/include/linux/ntb.h
> +++ b/include/linux/ntb.h
> @@ -221,7 +221,7 @@ struct ntb_dev_ops {
>  	int (*peer_port_number)(struct ntb_dev *ntb, int pidx);
>  	int (*peer_port_idx)(struct ntb_dev *ntb, int port);
> 
> -	int (*link_is_up)(struct ntb_dev *ntb,
> +	u64 (*link_is_up)(struct ntb_dev *ntb,
>  			  enum ntb_speed *speed, enum ntb_width *width);
>  	int (*link_enable)(struct ntb_dev *ntb,
>  			   enum ntb_speed max_speed, enum ntb_width max_width);
> @@ -567,25 +567,26 @@ static inline int ntb_peer_port_idx(struct ntb_dev *ntb, int port)
>   * state once after every link event.  It is safe to query the link state in
>   * the context of the link event callback.
>   *
> - * Return: One if the link is up, zero if the link is down, otherwise a
> - *		negative value indicating the error number.
> + * Return: bitfield of indexed ports link state: bit is set/cleared if the
> + *         link is up/down respectively, otherwise a negative value indicating
> + *         an error number.
>   */
> -static inline int ntb_link_is_up(struct ntb_dev *ntb,
> +static inline u64 ntb_link_is_up(struct ntb_dev *ntb,
>  				 enum ntb_speed *speed, enum ntb_width *width)
>  {
>  	return ntb->ops->link_is_up(ntb, speed, width);
>  }
> 
>  /**
> - * ntb_link_enable() - enable the link on the secondary side of the ntb
> + * ntb_link_enable() - enable the link of the ntb

Maybe: enable the local port ntb connection.  The description that follows is good for B2B topology, but the description including "link training" might not be accurate for multi-port devices.

>   * @ntb:	NTB device context.
>   * @max_speed:	The maximum link speed expressed as PCIe generation number.
>   * @max_width:	The maximum link width expressed as the number of PCIe lanes.
>   *
> - * Enable the link on the secondary side of the ntb.  This can only be done
> - * from the primary side of the ntb in primary or b2b topology.  The ntb device
> - * should train the link to its maximum speed and width, or the requested speed
> - * and width, whichever is smaller, if supported.
> + * Enable the NTB/PCIe link on the local or remote (for bridge-to-bridge
> + * topology) side of the bridge. The ntb device should train the link to its
> + * maximum speed and width, or the requested speed and width, whichever is
> + * smaller, if supported.
>   *
>   * Return: Zero on success, otherwise an error number.
>   */
> @@ -597,14 +598,14 @@ static inline int ntb_link_enable(struct ntb_dev *ntb,
>  }
> 
>  /**
> - * ntb_link_disable() - disable the link on the secondary side of the ntb
> + * ntb_link_disable() - disable the link of the ntb
>   * @ntb:	NTB device context.
>   *
> - * Disable the link on the secondary side of the ntb.  This can only be
> - * done from the primary side of the ntb in primary or b2b topology.  The ntb
> - * device should disable the link.  Returning from this call must indicate that
> - * a barrier has passed, though with no more writes may pass in either
> - * direction across the link, except if this call returns an error number.
> + * Disable the link on the local or remote (for b2b topology) of the ntb.
> + * The ntb device should disable the link.  Returning from this call must
> + * indicate that a barrier has passed, though with no more writes may pass in
> + * either direction across the link, except if this call returns an error
> + * number.
>   *
>   * Return: Zero on success, otherwise an error number.
>   */
> --
> 2.6.6


