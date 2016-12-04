Return-Path: <Allen.Hubbe@dell.com>
Received: from esa1.dell-outbound.iphmx.com (esa1.dell-outbound.iphmx.com. [68.232.153.90])
        by gmr-mx.google.com with ESMTPS id z137si884329ywd.7.2016.12.03.16.04.52
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Dec 2016 16:04:52 -0800 (PST)
From: "Allen Hubbe" <Allen.Hubbe@dell.com>
Subject: RE: [PATCH 02/22] NTB: Add peer indexed ports NTB API
Date: Sat, 3 Dec 2016 19:04:18 -0500
Message-ID: <003d01d24dc1$f5ba4d60$e12ee820$@dell.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
To: 'Serge Semin' <fancer.lancer@gmail.com>, jdmason@kudzu.us, dave.jiang@intel.com, Xiangliang.Yu@amd.com
Cc: Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

From: Serge Semin
> Add new port-index NTB API. Additionally lets get rid of Primary and
> Secondary topologies, since port-number can be effectively used instead.

Split into two patches please.

I see no harm to the TOPO changes, though I wonder if they are necessary.

> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> 
> ---
>  include/linux/ntb.h | 101 ++++++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 79 insertions(+), 22 deletions(-)
> 
> diff --git a/include/linux/ntb.h b/include/linux/ntb.h
> index 5d1f260..0941a43 100644
> --- a/include/linux/ntb.h
> +++ b/include/linux/ntb.h
> @@ -64,37 +64,21 @@ struct pci_dev;
>  /**
>   * enum ntb_topo - NTB connection topology
>   * @NTB_TOPO_NONE:	Topology is unknown or invalid.
> - * @NTB_TOPO_PRI:	On primary side of local ntb.
> - * @NTB_TOPO_SEC:	On secondary side of remote ntb.
> - * @NTB_TOPO_B2B_USD:	On primary side of local ntb upstream of remote ntb.
> - * @NTB_TOPO_B2B_DSD:	On primary side of local ntb downstream of remote ntb.
> + * @NTB_TOPO_P2P:	Simple port-to-port NTB topology
> + * @NTB_TOPO_B2B:	Bridge-to-bridge NTB topology
>   */
>  enum ntb_topo {
>  	NTB_TOPO_NONE = -1,
> -	NTB_TOPO_PRI,
> -	NTB_TOPO_SEC,
> -	NTB_TOPO_B2B_USD,
> -	NTB_TOPO_B2B_DSD,
> +	NTB_TOPO_P2P,
> +	NTB_TOPO_B2B
>  };
> 
> -static inline int ntb_topo_is_b2b(enum ntb_topo topo)
> -{
> -	switch ((int)topo) {
> -	case NTB_TOPO_B2B_USD:
> -	case NTB_TOPO_B2B_DSD:
> -		return 1;
> -	}
> -	return 0;
> -}
> -
>  static inline char *ntb_topo_string(enum ntb_topo topo)
>  {
>  	switch (topo) {
>  	case NTB_TOPO_NONE:	return "NTB_TOPO_NONE";
> -	case NTB_TOPO_PRI:	return "NTB_TOPO_PRI";
> -	case NTB_TOPO_SEC:	return "NTB_TOPO_SEC";
> -	case NTB_TOPO_B2B_USD:	return "NTB_TOPO_B2B_USD";
> -	case NTB_TOPO_B2B_DSD:	return "NTB_TOPO_B2B_DSD";
> +	case NTB_TOPO_P2P:	return "NTB_TOPO_P2P";
> +	case NTB_TOPO_B2B:	return "NTB_TOPO_B2B";
>  	}
>  	return "NTB_TOPO_INVALID";
>  }
> @@ -179,6 +163,10 @@ static inline int ntb_ctx_ops_is_valid(const struct ntb_ctx_ops *ops)
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
> @@ -212,6 +200,11 @@ static inline int ntb_ctx_ops_is_valid(const struct ntb_ctx_ops *ops)
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
> @@ -265,6 +258,10 @@ static inline int ntb_dev_ops_is_valid(const struct ntb_dev_ops *ops)
>  {
>  	/* commented callbacks are not required: */
>  	return
> +		ops->port_number			&&
> +		ops->peer_port_count			&&
> +		ops->peer_port_number			&&
> +		ops->peer_port_idx			&&
>  		ops->link_is_up				&&
>  		ops->link_enable			&&
>  		ops->link_disable			&&
> @@ -319,6 +316,7 @@ struct ntb_client {
>   * @dev:		Linux device object.
>   * @pdev:		Pci device entry of the ntb.
>   * @topo:		Detected topology of the ntb.
> + * @port:		Local port of the ntb.
>   * @ops:		See &ntb_dev_ops.
>   * @ctx:		See &ntb_ctx_ops.
>   * @ctx_ops:		See &ntb_ctx_ops.
> @@ -327,6 +325,7 @@ struct ntb_dev {
>  	struct device			dev;
>  	struct pci_dev			*pdev;
>  	enum ntb_topo			topo;
> +	int				port;
>  	const struct ntb_dev_ops	*ops;
>  	void				*ctx;
>  	const struct ntb_ctx_ops	*ctx_ops;
> @@ -442,6 +441,64 @@ void ntb_link_event(struct ntb_dev *ntb);
>  void ntb_db_event(struct ntb_dev *ntb, int vector);
> 
>  /**
> + * ntb_port_number() - get the local port number
> + * @ntb:	NTB device context.
> + *
> + * Hardware must support at least simple two-ports topology
> + *
> + * Return: the local port number
> + */
> +static inline int ntb_port_number(struct ntb_dev *ntb)
> +{
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
> + * by its port number.
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


