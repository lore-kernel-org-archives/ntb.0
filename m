Return-Path: <Allen.Hubbe@dell.com>
Received: from esa7.dell-outbound.iphmx.com (esa7.dell-outbound.iphmx.com. [68.232.153.96])
        by gmr-mx.google.com with ESMTPS id i9si4379219ywc.0.2016.12.13.23.08.05
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Dec 2016 23:08:05 -0800 (PST)
From: "Allen Hubbe" <Allen.Hubbe@dell.com>
References: <1481576902-21091-1-git-send-email-fancer.lancer@gmail.com> <1481672961-10753-1-git-send-email-fancer.lancer@gmail.com> <1481672961-10753-3-git-send-email-fancer.lancer@gmail.com>
In-Reply-To: <1481672961-10753-3-git-send-email-fancer.lancer@gmail.com>
Subject: RE: [PATCH v3 2/9] NTB: Add indexed ports NTB API
Date: Wed, 14 Dec 2016 02:07:45 -0500
Message-ID: <000701d255d8$c6ed40e0$54c7c2a0$@dell.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
To: 'Serge Semin' <fancer.lancer@gmail.com>, jdmason@kudzu.us, dave.jiang@intel.com, Xiangliang.Yu@amd.com
Cc: Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

From: Serge Semin
> There is some NTB hardware, which can combine more than just two domains
> over NTB. For instance, some IDT PCIe-switches can have NTB-functions
> activated on more than two-ports. The different domains are distinguished
> by ports they are connected to. So the new port-related methods are added to
> the NTB API:
>  ntb_port_number() - return local port
>  ntb_peer_port_count() - return number of peers local port can connect to
>  ntb_peer_port_number(pdix) - return port number by it index
>  ntb_peer_port_idx(port) - return port index by it number
> 
> Current test-drivers aren't changed much. They still support two-ports devices
> for the time being while multi-ports hardware drivers aren't added.
> 
> By default port-related API is declared for two-ports hardware.
> So corresponding hardware drivers won't need to implement it.
> 
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

Acked-by: Allen Hubbe <Allen.Hubbe@dell.com>

> ---
>  drivers/ntb/ntb.c               |  54 ++++++++++++++
>  drivers/ntb/ntb_transport.c     |   6 ++
>  drivers/ntb/test/ntb_perf.c     |   4 ++
>  drivers/ntb/test/ntb_pingpong.c |   6 ++
>  drivers/ntb/test/ntb_tool.c     |   5 ++
>  include/linux/ntb.h             | 156 ++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 231 insertions(+)
> 
> diff --git a/drivers/ntb/ntb.c b/drivers/ntb/ntb.c
> index 2e25307..1e92e52 100644
> --- a/drivers/ntb/ntb.c
> +++ b/drivers/ntb/ntb.c
> @@ -191,6 +191,60 @@ void ntb_db_event(struct ntb_dev *ntb, int vector)
>  }
>  EXPORT_SYMBOL(ntb_db_event);
> 
> +int ntb_default_port_number(struct ntb_dev *ntb)
> +{
> +	switch (ntb->topo) {
> +	case NTB_TOPO_PRI:
> +	case NTB_TOPO_B2B_USD:
> +		return NTB_PORT_PRI_USD;
> +	case NTB_TOPO_SEC:
> +	case NTB_TOPO_B2B_DSD:
> +		return NTB_PORT_SEC_DSD;
> +	default:
> +		break;
> +	}
> +
> +	return -EINVAL;
> +}
> +EXPORT_SYMBOL(ntb_default_port_number);
> +
> +int ntb_default_peer_port_count(struct ntb_dev *ntb)
> +{
> +	return NTB_DEF_PEER_CNT;
> +}
> +EXPORT_SYMBOL(ntb_default_peer_port_count);
> +
> +int ntb_default_peer_port_number(struct ntb_dev *ntb, int pidx)
> +{
> +	if (pidx != NTB_DEF_PEER_IDX)
> +		return -EINVAL;
> +
> +	switch (ntb->topo) {
> +	case NTB_TOPO_PRI:
> +	case NTB_TOPO_B2B_USD:
> +		return NTB_PORT_SEC_DSD;
> +	case NTB_TOPO_SEC:
> +	case NTB_TOPO_B2B_DSD:
> +		return NTB_PORT_PRI_USD;
> +	default:
> +		break;
> +	}
> +
> +	return -EINVAL;
> +}
> +EXPORT_SYMBOL(ntb_default_peer_port_number);
> +
> +int ntb_default_peer_port_idx(struct ntb_dev *ntb, int port)
> +{
> +	int peer_port = ntb_default_peer_port_number(ntb, NTB_DEF_PEER_IDX);
> +
> +	if (peer_port == -EINVAL || port != peer_port)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(ntb_default_peer_port_idx);
> +
>  static int ntb_probe(struct device *dev)
>  {
>  	struct ntb_dev *ntb;
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 4eb8adb..10518b7 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -94,6 +94,9 @@ MODULE_PARM_DESC(use_dma, "Use DMA engine to perform large data copy");
> 
>  static struct dentry *nt_debugfs_dir;
> 
> +/* Only two-ports NTB devices are supported */
> +#define PIDX		NTB_DEF_PEER_IDX
> +
>  struct ntb_queue_entry {
>  	/* ntb_queue list reference */
>  	struct list_head entry;
> @@ -1083,6 +1086,9 @@ static int ntb_transport_probe(struct ntb_client *self, struct
> ntb_dev *ndev)
>  		dev_dbg(&ndev->dev,
>  			"scratchpad is unsafe, proceed anyway...\n");
> 
> +	if (ntb_peer_port_count(ndev) != NTB_DEF_PEER_CNT)
> +		dev_warn(&ndev->dev, "Multi-port NTB devices unsupported\n");
> +
>  	node = dev_to_node(&ndev->dev);
> 
>  	nt = kzalloc_node(sizeof(*nt), GFP_KERNEL, node);
> diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
> index e75d4fd..c908b3a 100644
> --- a/drivers/ntb/test/ntb_perf.c
> +++ b/drivers/ntb/test/ntb_perf.c
> @@ -76,6 +76,7 @@
>  #define DMA_RETRIES		20
>  #define SZ_4G			(1ULL << 32)
>  #define MAX_SEG_ORDER		20 /* no larger than 1M for kmalloc buffer */
> +#define PIDX			NTB_DEF_PEER_IDX
> 
>  MODULE_LICENSE(DRIVER_LICENSE);
>  MODULE_VERSION(DRIVER_VERSION);
> @@ -764,6 +765,9 @@ static int perf_probe(struct ntb_client *client, struct ntb_dev *ntb)
>  		return -EIO;
>  	}
> 
> +	if (ntb_peer_port_count(ntb) != NTB_DEF_PEER_CNT)
> +		dev_warn(&ntb->dev, "Multi-port NTB devices unsupported\n");
> +
>  	node = dev_to_node(&pdev->dev);
> 
>  	perf = kzalloc_node(sizeof(*perf), GFP_KERNEL, node);
> diff --git a/drivers/ntb/test/ntb_pingpong.c b/drivers/ntb/test/ntb_pingpong.c
> index 4358611..12f8b40 100644
> --- a/drivers/ntb/test/ntb_pingpong.c
> +++ b/drivers/ntb/test/ntb_pingpong.c
> @@ -90,6 +90,9 @@ static unsigned long db_init = 0x7;
>  module_param(db_init, ulong, 0644);
>  MODULE_PARM_DESC(db_init, "Initial doorbell bits to ring on the peer");
> 
> +/* Only two-ports NTB devices are supported */
> +#define PIDX		NTB_DEF_PEER_IDX
> +
>  struct pp_ctx {
>  	struct ntb_dev			*ntb;
>  	u64				db_bits;
> @@ -230,6 +233,9 @@ static int pp_probe(struct ntb_client *client,
>  		}
>  	}
> 
> +	if (ntb_peer_port_count(ntb) != NTB_DEF_PEER_CNT)
> +		dev_warn(&ntb->dev, "multi-port NTB is unsupported\n");
> +
>  	pp = kmalloc(sizeof(*pp), GFP_KERNEL);
>  	if (!pp) {
>  		rc = -ENOMEM;
> diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c
> index 61bf2ef..690862d 100644
> --- a/drivers/ntb/test/ntb_tool.c
> +++ b/drivers/ntb/test/ntb_tool.c
> @@ -120,6 +120,8 @@ MODULE_AUTHOR(DRIVER_AUTHOR);
>  MODULE_DESCRIPTION(DRIVER_DESCRIPTION);
> 
>  #define MAX_MWS 16
> +/* Only two-ports devices are supported */
> +#define PIDX	NTB_DEF_PEER_IDX
> 
>  static struct dentry *tool_dbgfs;
> 
> @@ -919,6 +921,9 @@ static int tool_probe(struct ntb_client *self, struct ntb_dev *ntb)
>  	if (ntb_spad_is_unsafe(ntb))
>  		dev_dbg(&ntb->dev, "scratchpad is unsafe\n");
> 
> +	if (ntb_peer_port_count(ntb) != NTB_DEF_PEER_CNT)
> +		dev_warn(&ntb->dev, "multi-port NTB is unsupported\n");
> +
>  	tc = kzalloc(sizeof(*tc), GFP_KERNEL);
>  	if (!tc) {
>  		rc = -ENOMEM;
> diff --git a/include/linux/ntb.h b/include/linux/ntb.h
> index 5d1f260..fe175c7 100644
> --- a/include/linux/ntb.h
> +++ b/include/linux/ntb.h
> @@ -140,6 +140,20 @@ enum ntb_width {
>  };
> 
>  /**
> + * enum ntb_default_port - NTB default port number
> + * @NTB_PORT_PRI_USD:	Default port of the NTB_TOPO_PRI/NTB_TOPO_B2B_USD
> + *			topologies
> + * @NTB_PORT_SEC_DSD:	Default port of the NTB_TOPO_SEC/NTB_TOPO_B2B_DSD
> + *			topologies
> + */
> +enum ntb_default_port {
> +	NTB_PORT_PRI_USD,
> +	NTB_PORT_SEC_DSD
> +};
> +#define NTB_DEF_PEER_CNT	(1)
> +#define NTB_DEF_PEER_IDX	(0)
> +
> +/**
>   * struct ntb_client_ops - ntb client operations
>   * @probe:		Notify client of a new device.
>   * @remove:		Notify client to remove a device.
> @@ -179,6 +193,10 @@ static inline int ntb_ctx_ops_is_valid(const struct ntb_ctx_ops *ops)
> 
>  /**
>   * struct ntb_ctx_ops - ntb device operations
> + * @port_number:	See ntb_port_number().
> + * @peer_port_count:	See ntb_peer_port_count().
> + * @peer_port_number:	See ntb_peer_port_number().
> + * @peer_port_idx:	See ntb_peer_port_idx().
>   * @link_is_up:		See ntb_link_is_up().
>   * @link_enable:	See ntb_link_enable().
>   * @link_disable:	See ntb_link_disable().
> @@ -212,6 +230,11 @@ static inline int ntb_ctx_ops_is_valid(const struct ntb_ctx_ops *ops)
>   * @peer_spad_write:	See ntb_peer_spad_write().
>   */
>  struct ntb_dev_ops {
> +	int (*port_number)(struct ntb_dev *ntb);
> +	int (*peer_port_count)(struct ntb_dev *ntb);
> +	int (*peer_port_number)(struct ntb_dev *ntb, int pidx);
> +	int (*peer_port_idx)(struct ntb_dev *ntb, int port);
> +
>  	int (*link_is_up)(struct ntb_dev *ntb,
>  			  enum ntb_speed *speed, enum ntb_width *width);
>  	int (*link_enable)(struct ntb_dev *ntb,
> @@ -265,6 +288,9 @@ static inline int ntb_dev_ops_is_valid(const struct ntb_dev_ops *ops)
>  {
>  	/* commented callbacks are not required: */
>  	return
> +		!ops->peer_port_count == !ops->port_number	&&
> +		!ops->peer_port_number == !ops->port_number	&&
> +		!ops->peer_port_idx == !ops->port_number	&&
>  		ops->link_is_up				&&
>  		ops->link_enable			&&
>  		ops->link_disable			&&
> @@ -442,6 +468,136 @@ void ntb_link_event(struct ntb_dev *ntb);
>  void ntb_db_event(struct ntb_dev *ntb, int vector);
> 
>  /**
> + * ntb_default_port_number() - get the default local port number
> + * @ntb:	NTB device context.
> + *
> + * If hardware driver doesn't specify port_number() callback method, the NTB
> + * is considered with just two ports. So this method returns default local
> + * port number in compliance with topology.
> + *
> + * NOTE Don't call this method directly. The ntb_port_number() function should
> + * be used instead.
> + *
> + * Return: the default local port number
> + */
> +int ntb_default_port_number(struct ntb_dev *ntb);
> +
> +/**
> + * ntb_default_port_count() - get the default number of peer device ports
> + * @ntb:	NTB device context.
> + *
> + * By default hardware driver supports just one peer device.
> + *
> + * NOTE Don't call this method directly. The ntb_peer_port_count() function
> + * should be used instead.
> + *
> + * Return: the default number of peer ports
> + */
> +int ntb_default_peer_port_count(struct ntb_dev *ntb);
> +
> +/**
> + * ntb_default_peer_port_number() - get the default peer port by given index
> + * @ntb:	NTB device context.
> + * @idx:	Peer port index (should not differ from zero).
> + *
> + * By default hardware driver supports just one peer device, so this method
> + * shall return the corresponding value from enum ntb_default_port.
> + *
> + * NOTE Don't call this method directly. The ntb_peer_port_number() function
> + * should be used instead.
> + *
> + * Return: the peer device port or negative value indicating an error
> + */
> +int ntb_default_peer_port_number(struct ntb_dev *ntb, int pidx);
> +
> +/**
> + * ntb_default_peer_port_idx() - get the default peer device port index by
> + *				 given port number
> + * @ntb:	NTB device context.
> + * @port:	Peer port number (should be one of enum ntb_default_port).
> + *
> + * By default hardware driver supports just one peer device, so while
> + * specified port-argument indicates peer port from enum ntb_default_port,
> + * the return value shall be zero.
> + *
> + * NOTE Don't call this method directly. The ntb_peer_port_idx() function
> + * should be used instead.
> + *
> + * Return: the peer port index or negative value indicating an error
> + */
> +int ntb_default_peer_port_idx(struct ntb_dev *ntb, int port);
> +
> +/**
> + * ntb_port_number() - get the local port number
> + * @ntb:	NTB device context.
> + *
> + * Hardware must support at least simple two-ports ntb connection
> + *
> + * Return: the local port number
> + */
> +static inline int ntb_port_number(struct ntb_dev *ntb)
> +{
> +	if (!ntb->ops->port_number)
> +		return ntb_default_port_number(ntb);
> +
> +	return ntb->ops->port_number(ntb);
> +}
> +
> +/**
> + * ntb_peer_port_count() - get the number of peer device ports
> + * @ntb:	NTB device context.
> + *
> + * Hardware may support an access to memory of several remote domains
> + * over multi-port NTB devices. This method returns the number of peers,
> + * local device can have shared memory with.
> + *
> + * Return: the number of peer ports
> + */
> +static inline int ntb_peer_port_count(struct ntb_dev *ntb)
> +{
> +	if (!ntb->ops->peer_port_count)
> +		return ntb_default_peer_port_count(ntb);
> +
> +	return ntb->ops->peer_port_count(ntb);
> +}
> +
> +/**
> + * ntb_peer_port_number() - get the peer port by given index
> + * @ntb:	NTB device context.
> + * @pidx:	Peer port index.
> + *
> + * Peer ports are continuously enumerated by NTB API logic, so this method
> + * lets to retrieve port real number by its index.
> + *
> + * Return: the peer device port or negative value indicating an error
> + */
> +static inline int ntb_peer_port_number(struct ntb_dev *ntb, int pidx)
> +{
> +	if (!ntb->ops->peer_port_number)
> +		return ntb_default_peer_port_number(ntb, pidx);
> +
> +	return ntb->ops->peer_port_number(ntb, pidx);
> +}
> +
> +/**
> + * ntb_peer_port_idx() - get the peer device port index by given port number
> + * @ntb:	NTB device context.
> + * @port:	Peer port number.
> + *
> + * Inverse operation of ntb_peer_port_number(), so one can get port index
> + * by specified port number.
> + *
> + * Return: the peer port index or negative value indicating an error
> + */
> +static inline int ntb_peer_port_idx(struct ntb_dev *ntb, int port)
> +{
> +	if (!ntb->ops->peer_port_idx)
> +		return ntb_default_peer_port_idx(ntb, port);
> +
> +	return ntb->ops->peer_port_idx(ntb, port);
> +}
> +
> +/**
>   * ntb_link_is_up() - get the current ntb link state
>   * @ntb:	NTB device context.
>   * @speed:	OUT - The link speed expressed as PCIe generation number.
> --
> 2.6.6

