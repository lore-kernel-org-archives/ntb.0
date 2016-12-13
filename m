Return-Path: <Allen.Hubbe@dell.com>
Received: from esa4.dell-outbound.iphmx.com (esa4.dell-outbound.iphmx.com. [68.232.149.214])
        by gmr-mx.google.com with ESMTPS id i9si3919690ywc.0.2016.12.12.20.12.27
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Dec 2016 20:12:27 -0800 (PST)
From: "Allen Hubbe" <Allen.Hubbe@dell.com>
Subject: RE: [PATCH v2 3/9] NTB: Alter link-state API to support multi-port devices
Date: Mon, 12 Dec 2016 23:12:14 -0500
Message-ID: <000201d254f7$171b0df0$455129d0$@dell.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
To: 'Serge Semin' <fancer.lancer@gmail.com>, jdmason@kudzu.us, dave.jiang@intel.com, Xiangliang.Yu@amd.com
Cc: Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

From: Serge Semin
> Multi-port devices permit the NTB connections between multiple domains,
> so a local device can have NTB link being up with one peer and being
> down with another. NTB link-state API is appropriately altered to return
> a bitfield of the link-states between the local device and possible peers.
> 
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

Acked-by: Allen Hubbe <Allen.Hubbe@dell.com>

> 
> ---
>  drivers/ntb/hw/amd/ntb_hw_amd.c     |  2 +-
>  drivers/ntb/hw/intel/ntb_hw_intel.c |  2 +-
>  include/linux/ntb.h                 | 31 ++++++++++++++++---------------
>  3 files changed, 18 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
> index 0b767ef..b6a4291 100644
> --- a/drivers/ntb/hw/amd/ntb_hw_amd.c
> +++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
> @@ -133,7 +133,7 @@ static int amd_link_is_up(struct amd_ntb_dev *ndev)
>  	return 0;
>  }
> 
> -static int amd_ntb_link_is_up(struct ntb_dev *ntb,
> +static u64 amd_ntb_link_is_up(struct ntb_dev *ntb,
>  			      enum ntb_speed *speed,
>  			      enum ntb_width *width)
>  {
> diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.c b/drivers/ntb/hw/intel/ntb_hw_intel.c
> index 7e44dc3..f37b6fb 100644
> --- a/drivers/ntb/hw/intel/ntb_hw_intel.c
> +++ b/drivers/ntb/hw/intel/ntb_hw_intel.c
> @@ -1078,7 +1078,7 @@ static int intel_ntb_peer_port_idx(struct ntb_dev *ntb, int port)
>  	return 0;
>  }
> 
> -static int intel_ntb_link_is_up(struct ntb_dev *ntb,
> +static u64 intel_ntb_link_is_up(struct ntb_dev *ntb,
>  				enum ntb_speed *speed,
>  				enum ntb_width *width)
>  {
> diff --git a/include/linux/ntb.h b/include/linux/ntb.h
> index 3216689..47ec611 100644
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
> @@ -522,25 +522,26 @@ static inline int ntb_peer_port_idx(struct ntb_dev *ntb, int port)
>   * state once after every link event.  It is safe to query the link state in
>   * the context of the link event callback.
>   *
> - * Return: One if the link is up, zero if the link is down, otherwise a
> - *		negative value indicating the error number.
> + * Return: bitfield of indexed ports link state: bit is set/cleared if the
> + *         link is up/down respectively.
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
> + * ntb_link_enable() - enable the local port ntb connection
>   * @ntb:	NTB device context.
>   * @max_speed:	The maximum link speed expressed as PCIe generation number.
>   * @max_width:	The maximum link width expressed as the number of PCIe lanes.
>   *
> - * Enable the link on the secondary side of the ntb.  This can only be done
> - * from the primary side of the ntb in primary or b2b topology.  The ntb device
> - * should train the link to its maximum speed and width, or the requested speed
> - * and width, whichever is smaller, if supported.
> + * Enable the NTB/PCIe link on the local or remote (for bridge-to-bridge
> + * topology) side of the bridge. If it's supported the ntb device should train
> + * the link to its maximum speed and width, or the requested speed and width,
> + * whichever is smaller. Some hardware doesn't support PCIe link training, so
> + * the last two arguments will be ignored then.
>   *
>   * Return: Zero on success, otherwise an error number.
>   */
> @@ -552,14 +553,14 @@ static inline int ntb_link_enable(struct ntb_dev *ntb,
>  }
> 
>  /**
> - * ntb_link_disable() - disable the link on the secondary side of the ntb
> + * ntb_link_disable() - disable the local port ntb connection
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
> 
> --
> You received this message because you are subscribed to the Google Groups "linux-ntb"
> group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-
> ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-
> ntb/1481576902-21091-4-git-send-email-fancer.lancer%40gmail.com.
> For more options, visit https://groups.google.com/d/optout.

