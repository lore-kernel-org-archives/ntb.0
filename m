Return-Path: <Allen.Hubbe@dell.com>
Received: from esa1.dell-outbound.iphmx.com (esa1.dell-outbound.iphmx.com. [68.232.153.90])
        by gmr-mx.google.com with ESMTPS id u66si2686555ywg.1.2016.12.12.20.12.26
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Dec 2016 20:12:26 -0800 (PST)
From: "Allen Hubbe" <Allen.Hubbe@dell.com>
Subject: RE: [PATCH v2 2/9] NTB: Add indexed ports NTB API
Date: Mon, 12 Dec 2016 23:11:57 -0500
Message-ID: <000101d254f7$0eddadf0$2c9909d0$@dell.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
To: 'Serge Semin' <fancer.lancer@gmail.com>, jdmason@kudzu.us, dave.jiang@intel.com, Xiangliang.Yu@amd.com
Cc: Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

From: Serge Semin 
> There are some NTB hardware, which can combine more than just two domains
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

The port methods are the same for PRI/SEC drivers.  Rather than duplicating the code, multiport could be made optional in the api, and default implementations provided by ntb common code.

Some comments below.

> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> 
> ---
>  drivers/ntb/hw/amd/ntb_hw_amd.c     | 47 ++++++++++++++++++++++++
>  drivers/ntb/hw/amd/ntb_hw_amd.h     |  9 +++++
>  drivers/ntb/hw/intel/ntb_hw_intel.c | 52 ++++++++++++++++++++++++++-
>  drivers/ntb/hw/intel/ntb_hw_intel.h |  9 +++++
>  drivers/ntb/ntb_transport.c         |  6 ++++
>  drivers/ntb/test/ntb_perf.c         |  4 +++
>  drivers/ntb/test/ntb_pingpong.c     |  6 ++++
>  drivers/ntb/test/ntb_tool.c         |  5 +++
>  include/linux/ntb.h                 | 71 +++++++++++++++++++++++++++++++++++++
>  9 files changed, 208 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
> index 6704327..0b767ef 100644
> --- a/drivers/ntb/hw/amd/ntb_hw_amd.c
> +++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
> @@ -71,6 +71,49 @@ MODULE_AUTHOR("AMD Inc.");
>  static const struct file_operations amd_ntb_debugfs_info;
>  static struct dentry *debugfs_dir;
> 
> +static int amd_ntb_port_number(struct ntb_dev *ntb)
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
> +
> +static int amd_ntb_peer_port_count(struct ntb_dev *ntb)
> +{
> +	return NTB_PEER_CNT;
> +}
> +
> +static int amd_ntb_peer_port_number(struct ntb_dev *ntb, int pidx)
> +{
> +	int local_port = amd_ntb_port_number(ntb);
> +
> +	if (pidx > NTB_PIDX_MAX)
> +		return -EINVAL;

pidx may be negative.

> +
> +	return (local_port == NTB_PORT_PRI_USD ?
> +		NTB_PORT_SEC_DSD : NTB_PORT_PRI_USD);

local_port may be -EINVAL.

It may be simpler to have the same switch statement here as in amd_ntb_port_number(), with the return statements swapped.

> +}
> +
> +static int amd_ntb_peer_port_idx(struct ntb_dev *ntb, int port)
> +{
> +	int local_port = amd_ntb_port_number(ntb);
> +
> +	if ((local_port == NTB_PORT_PRI_USD && port != NTB_PORT_SEC_DSD) ||
> +	    (local_port == NTB_PORT_SEC_DSD && port != NTB_PORT_PRI_USD))
> +		return -EINVAL;
> +

How about:

peer_port = amd_ntb_peer_port_number(ntb, 0);

if (peer_port == -EINVAL || port != peer_port)
	return -EINVAL;

return 0;

> +	return 0;
> +}
> +
>  static int amd_link_is_up(struct amd_ntb_dev *ndev)
>  {
>  	if (!ndev->peer_sta)
> @@ -431,6 +474,10 @@ static int amd_ntb_peer_spad_write(struct ntb_dev *ntb,
>  }
> 
>  static const struct ntb_dev_ops amd_ntb_ops = {
> +	.port_number		= amd_ntb_port_number,
> +	.peer_port_count	= amd_ntb_peer_port_count,
> +	.peer_port_number	= amd_ntb_peer_port_number,
> +	.peer_port_idx		= amd_ntb_peer_port_idx,
>  	.link_is_up		= amd_ntb_link_is_up,
>  	.link_enable		= amd_ntb_link_enable,
>  	.link_disable		= amd_ntb_link_disable,
> diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.h b/drivers/ntb/hw/amd/ntb_hw_amd.h
> index 2eac3cd..1aeb08f 100644
> --- a/drivers/ntb/hw/amd/ntb_hw_amd.h
> +++ b/drivers/ntb/hw/amd/ntb_hw_amd.h
> @@ -62,6 +62,10 @@
>  #define NTB_LNK_STA_SPEED(x)	(((x) & NTB_LNK_STA_SPEED_MASK) >> 16)
>  #define NTB_LNK_STA_WIDTH(x)	(((x) & NTB_LNK_STA_WIDTH_MASK) >> 20)
> 
> +/* port related constants */
> +#define NTB_PEER_CNT			(1)
> +#define NTB_PIDX_MAX			(0)

Just NTB_PEER_CNT is sufficient.  Anything that checks if (pidx > NTB_PIDX_MAX) could check if (pidx >= NTB_PEER_CNT).

> +
>  #ifndef read64
>  #ifdef readq
>  #define read64 readq
> @@ -91,6 +95,11 @@ static inline void _write64(u64 val, void __iomem *mmio)
>  #endif
>  #endif
> 
> +enum amd_ntb_port {
> +	NTB_PORT_PRI_USD,
> +	NTB_PORT_SEC_DSD
> +};

This could be part of ntb.h, since it will likely be the same for any of the PRI/SEC variety of NTB devices.  Making it a part of the api will encourage other PRI/SEC drivers to assign port numbers the same way using these values.  Or, drivers may be made consistent by sharing common code.

> +
>  enum {
>  	/* AMD NTB Capability */
>  	AMD_MW_CNT		= 3,
> diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.c b/drivers/ntb/hw/intel/ntb_hw_intel.c
> index 68d9908..7e44dc3 100644
> --- a/drivers/ntb/hw/intel/ntb_hw_intel.c
> +++ b/drivers/ntb/hw/intel/ntb_hw_intel.c
> @@ -1035,6 +1035,49 @@ static void ndev_deinit_debugfs(struct intel_ntb_dev *ndev)
>  	debugfs_remove_recursive(ndev->debugfs_dir);
>  }

Apply same comments above to Intel driver.

> 
> +static int intel_ntb_port_number(struct ntb_dev *ntb)
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
> +
> +static int intel_ntb_peer_port_count(struct ntb_dev *ntb)
> +{
> +	return NTB_PEER_CNT;
> +}
> +
> +static int intel_ntb_peer_port_number(struct ntb_dev *ntb, int pidx)
> +{
> +	int local_port = intel_ntb_port_number(ntb);
> +
> +	if (pidx > NTB_PIDX_MAX)
> +		return -EINVAL;
> +
> +	return (local_port == NTB_PORT_PRI_USD ?
> +		NTB_PORT_SEC_DSD : NTB_PORT_PRI_USD);
> +}
> +
> +static int intel_ntb_peer_port_idx(struct ntb_dev *ntb, int port)
> +{
> +	int local_port = intel_ntb_port_number(ntb);
> +
> +	if ((local_port == NTB_PORT_PRI_USD && port != NTB_PORT_SEC_DSD) ||
> +	    (local_port == NTB_PORT_SEC_DSD && port != NTB_PORT_PRI_USD))
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
>  static int intel_ntb_link_is_up(struct ntb_dev *ntb,
>  				enum ntb_speed *speed,
>  				enum ntb_width *width)
> @@ -1775,7 +1818,6 @@ static int skx_init_ntb(struct intel_ntb_dev *ndev)
>  {
>  	int rc;
> 
> -
>  	ndev->mw_count = XEON_MW_COUNT;
>  	ndev->spad_count = SKX_SPAD_COUNT;
>  	ndev->db_count = SKX_DB_COUNT;
> @@ -2883,6 +2925,10 @@ static const struct intel_ntb_xlat_reg skx_sec_xlat = {
> 
>  /* operations for primary side of local ntb */
>  static const struct ntb_dev_ops intel_ntb_ops = {
> +	.port_number		= intel_ntb_port_number,
> +	.peer_port_count	= intel_ntb_peer_port_count,
> +	.peer_port_number	= intel_ntb_peer_port_number,
> +	.peer_port_idx		= intel_ntb_peer_port_idx,
>  	.link_is_up		= intel_ntb_link_is_up,
>  	.link_enable		= intel_ntb_link_enable,
>  	.link_disable		= intel_ntb_link_disable,
> @@ -2909,6 +2955,10 @@ static const struct ntb_dev_ops intel_ntb_ops = {
>  };
> 
>  static const struct ntb_dev_ops intel_ntb3_ops = {
> +	.port_number		= intel_ntb_port_number,
> +	.peer_port_count	= intel_ntb_peer_port_count,
> +	.peer_port_number	= intel_ntb_peer_port_number,
> +	.peer_port_idx		= intel_ntb_peer_port_idx,
>  	.link_is_up		= intel_ntb_link_is_up,
>  	.link_enable		= intel_ntb3_link_enable,
>  	.link_disable		= intel_ntb_link_disable,
> diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.h b/drivers/ntb/hw/intel/ntb_hw_intel.h
> index 6e8c182..f12c960 100644
> --- a/drivers/ntb/hw/intel/ntb_hw_intel.h
> +++ b/drivers/ntb/hw/intel/ntb_hw_intel.h
> @@ -295,6 +295,15 @@
>  #define NTB_BAR_MASK_64			~(0xfull)
>  #define NTB_BAR_MASK_32			~(0xfu)
> 
> +/* port related constants */
> +#define NTB_PEER_CNT			(1)
> +#define NTB_PIDX_MAX			(0)
> +
> +enum intel_ntb_port {
> +	NTB_PORT_PRI_USD,
> +	NTB_PORT_SEC_DSD
> +};
> +
>  struct intel_ntb_dev;
> 
>  struct intel_ntb_reg {
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 4eb8adb..37d428d 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -94,6 +94,9 @@ MODULE_PARM_DESC(use_dma, "Use DMA engine to perform large data copy");
> 
>  static struct dentry *nt_debugfs_dir;
> 
> +/* Only two-ports NTB devices are supported */
> +#define PIDX		0
> +
>  struct ntb_queue_entry {
>  	/* ntb_queue list reference */
>  	struct list_head entry;
> @@ -1083,6 +1086,9 @@ static int ntb_transport_probe(struct ntb_client *self, struct
> ntb_dev *ndev)
>  		dev_dbg(&ndev->dev,
>  			"scratchpad is unsafe, proceed anyway...\n");
> 
> +	if (ntb_peer_port_count(ndev) != 1)
> +		dev_warn(&ndev->dev, "Multi-port NTB devices unsupported\n");
> +
>  	node = dev_to_node(&ndev->dev);
> 
>  	nt = kzalloc_node(sizeof(*nt), GFP_KERNEL, node);
> diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
> index e75d4fd..481827a 100644
> --- a/drivers/ntb/test/ntb_perf.c
> +++ b/drivers/ntb/test/ntb_perf.c
> @@ -76,6 +76,7 @@
>  #define DMA_RETRIES		20
>  #define SZ_4G			(1ULL << 32)
>  #define MAX_SEG_ORDER		20 /* no larger than 1M for kmalloc buffer */
> +#define PIDX			0
> 
>  MODULE_LICENSE(DRIVER_LICENSE);
>  MODULE_VERSION(DRIVER_VERSION);
> @@ -764,6 +765,9 @@ static int perf_probe(struct ntb_client *client, struct ntb_dev *ntb)
>  		return -EIO;
>  	}
> 
> +	if (ntb_peer_port_count(ntb) != 1)
> +		dev_warn(&ntb->dev, "Multi-port NTB devices unsupported\n");
> +
>  	node = dev_to_node(&pdev->dev);
> 
>  	perf = kzalloc_node(sizeof(*perf), GFP_KERNEL, node);
> diff --git a/drivers/ntb/test/ntb_pingpong.c b/drivers/ntb/test/ntb_pingpong.c
> index 4358611..6dd7582 100644
> --- a/drivers/ntb/test/ntb_pingpong.c
> +++ b/drivers/ntb/test/ntb_pingpong.c
> @@ -90,6 +90,9 @@ static unsigned long db_init = 0x7;
>  module_param(db_init, ulong, 0644);
>  MODULE_PARM_DESC(db_init, "Initial doorbell bits to ring on the peer");
> 
> +/* Only two-ports NTB devices are supported */
> +#define PIDX		0
> +
>  struct pp_ctx {
>  	struct ntb_dev			*ntb;
>  	u64				db_bits;
> @@ -230,6 +233,9 @@ static int pp_probe(struct ntb_client *client,
>  		}
>  	}
> 
> +	if (ntb_peer_port_count(ntb) != 1)
> +		dev_warn(&ntb->dev, "multi-port NTB is unsupported\n");
> +
>  	pp = kmalloc(sizeof(*pp), GFP_KERNEL);
>  	if (!pp) {
>  		rc = -ENOMEM;
> diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c
> index 61bf2ef..85b6417 100644
> --- a/drivers/ntb/test/ntb_tool.c
> +++ b/drivers/ntb/test/ntb_tool.c
> @@ -120,6 +120,8 @@ MODULE_AUTHOR(DRIVER_AUTHOR);
>  MODULE_DESCRIPTION(DRIVER_DESCRIPTION);
> 
>  #define MAX_MWS 16
> +/* Only two-ports devices are supported */
> +#define PIDX	0
> 
>  static struct dentry *tool_dbgfs;
> 
> @@ -919,6 +921,9 @@ static int tool_probe(struct ntb_client *self, struct ntb_dev *ntb)
>  	if (ntb_spad_is_unsafe(ntb))
>  		dev_dbg(&ntb->dev, "scratchpad is unsafe\n");
> 
> +	if (ntb_peer_port_count(ntb) != 1)
> +		dev_warn(&ntb->dev, "multi-port NTB is unsupported\n");
> +
>  	tc = kzalloc(sizeof(*tc), GFP_KERNEL);
>  	if (!tc) {
>  		rc = -ENOMEM;
> diff --git a/include/linux/ntb.h b/include/linux/ntb.h
> index 5d1f260..3216689 100644
> --- a/include/linux/ntb.h
> +++ b/include/linux/ntb.h
> @@ -179,6 +179,10 @@ static inline int ntb_ctx_ops_is_valid(const struct ntb_ctx_ops *ops)
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
> @@ -212,6 +216,11 @@ static inline int ntb_ctx_ops_is_valid(const struct ntb_ctx_ops *ops)
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
> @@ -265,6 +274,10 @@ static inline int ntb_dev_ops_is_valid(const struct ntb_dev_ops *ops)
>  {
>  	/* commented callbacks are not required: */
>  	return
> +		ops->port_number			&&
> +		ops->peer_port_count			&&
> +		ops->peer_port_number			&&
> +		ops->peer_port_idx			&&

If these are made optional, then:

!ops->peer_port_count == !ops->port_number &&
!ops->peer_port_number == !ops->port_number &&
!ops->peer_port_idx == !ops->port_number &&

>  		ops->link_is_up				&&
>  		ops->link_enable			&&
>  		ops->link_disable			&&
> @@ -442,6 +455,64 @@ void ntb_link_event(struct ntb_dev *ntb);
>  void ntb_db_event(struct ntb_dev *ntb, int vector);
> 
>  /**
> + * ntb_port_number() - get the local port number
> + * @ntb:	NTB device context.
> + *
> + * Hardware must support at least simple two-ports ntb connection
> + *
> + * Return: the local port number
> + */
> +static inline int ntb_port_number(struct ntb_dev *ntb)
> +{

If these are made optional, then:

if (!ntb->ops->port_number)
	return ntb_default_port_number(ntb);

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
> +	return ntb->ops->peer_port_count(ntb);
> +}
> +
> +/**
> + * ntb_peer_port_number() - get the peer port by given index
> + * @ntb:	NTB device context.
> + * @pidx:	Peer port index.
> + *
> + * Peer ports are continuously enumerated by NTB API logic, so this methods
> + * lets to retrieve port real number by its index.
> + *
> + * Return: the peer device port or negative value indicating an error
> + */
> +static inline int ntb_peer_port_number(struct ntb_dev *ntb, int pidx)
> +{
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
> +	return ntb->ops->peer_port_idx(ntb, port);
> +}
> +
> +/**
>   * ntb_link_is_up() - get the current ntb link state
>   * @ntb:	NTB device context.
>   * @speed:	OUT - The link speed expressed as PCIe generation number.
> --
> 2.6.6


