Return-Path: <jdmason@kudzu.us>
Received: from mail-yk0-x241.google.com (mail-yk0-x241.google.com. [2607:f8b0:4002:c07::241])
        by gmr-mx.google.com with ESMTPS id i204si1667018ywc.3.2016.01.17.20.16.00
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jan 2016 20:16:00 -0800 (PST)
Received: by mail-yk0-x241.google.com with SMTP id y10so36008683ykf.0
        for <linux-ntb@googlegroups.com>; Sun, 17 Jan 2016 20:16:00 -0800 (PST)
Return-Path: <jdmason@kudzu.us>
Date: Sun, 17 Jan 2016 23:14:43 -0500
From: Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH V3 2/2] NTB: Add support for flush request interface
Message-ID: <20160118041441.GE11303@kudzu.us>
References: <1452771861-16990-1-git-send-email-Xiangliang.Yu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1452771861-16990-1-git-send-email-Xiangliang.Yu@amd.com>
To: Xiangliang Yu <Xiangliang.Yu@amd.com>
Cc: dave.jiang@intel.com, Allen.Hubbe@emc.com, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, SPG_Linux_Kernel@amd.com
List-ID: <linux-ntb.googlegroups.com>

On Thu, Jan 14, 2016 at 07:44:21PM +0800, Xiangliang Yu wrote:
> AMD NTB support flush pending requests feature in some cases,
> like as device remove or suspend.
> 
> This patch add one interface to support the feature. When flushing
> request, AMD LLD driver use similar method of SATA or block device
> to waiting for completion of flush event.
 
If you want this part of the patch series (or, preferrably the whole
patch series) reviewed by the Linux Power Management people, you need
to have the mailing list Cc'ed.  I believe you want
linux-pm@vger.kernel.org

Thanks,
Jon


> Signed-off-by: Xiangliang Yu <Xiangliang.Yu@amd.com>
> ---
>  drivers/ntb/hw/amd/ntb_hw_amd.c | 36 +++++++++++++++++++++++++++++++++++-
>  drivers/ntb/hw/amd/ntb_hw_amd.h |  3 +++
>  include/linux/ntb.h             | 22 ++++++++++++++++++++++
>  3 files changed, 60 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
> index 8df6d7b..344fbcd 100644
> --- a/drivers/ntb/hw/amd/ntb_hw_amd.c
> +++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
> @@ -93,6 +93,7 @@ static const struct ntb_dev_ops amd_ntb_ops = {
>  	.peer_spad_addr		= amd_ntb_peer_spad_addr,
>  	.peer_spad_read		= amd_ntb_peer_spad_read,
>  	.peer_spad_write	= amd_ntb_peer_spad_write,
> +	.flush_req		= amd_ntb_flush_req,
>  };
>  
>  static int ndev_mw_to_bar(struct amd_ntb_dev *ndev, int idx)
> @@ -492,6 +493,37 @@ static void amd_ack_SMU(struct amd_ntb_dev *ndev, u32 bit)
>  	ndev->peer_sta |= bit;
>  }
>  
> +/*
> + * flush the requests to peer side
> + */
> +static int amd_flush_peer_requests(struct amd_ntb_dev *ndev)
> +{
> +	void __iomem *mmio = ndev->self_mmio;
> +	u32 reg;
> +
> +	if (!amd_link_is_up(ndev)) {
> +		dev_err(ndev_dev(ndev), "link is down.\n");
> +		return -EINVAL;
> +	}
> +
> +	reg = readl(mmio + AMD_FLUSHTRIG_OFFSET);
> +	reg |= 0x1;
> +	writel(reg, mmio + AMD_FLUSHTRIG_OFFSET);
> +
> +	wait_for_completion(&ndev->flush_cmpl);
> +
> +	reinit_completion(&ndev->flush_cmpl);
> +
> +	return 0;
> +}
> +
> +static int amd_ntb_flush_req(struct ntb_dev *ntb)
> +{
> +	struct amd_ntb_dev *ndev = ntb_ndev(ntb);
> +
> +	return amd_flush_peer_requests(ndev);
> +}
> +
>  static void amd_handle_event(struct amd_ntb_dev *ndev, int vec)
>  {
>  	void __iomem *mmio = ndev->self_mmio;
> @@ -506,7 +538,8 @@ static void amd_handle_event(struct amd_ntb_dev *ndev, int vec)
>  	status &= AMD_EVENT_INTMASK;
>  	switch (status) {
>  	case AMD_PEER_FLUSH_EVENT:
> -		dev_info(ndev_dev(ndev), "Flush is done.\n");
> +		dev_dbg(ndev_dev(ndev), "Flush is done.\n");
> +		complete(&ndev->flush_cmpl);
>  		break;
>  	case AMD_PEER_RESET_EVENT:
>  		amd_ack_SMU(ndev, AMD_PEER_RESET_EVENT);
> @@ -832,6 +865,7 @@ static inline void ndev_init_struct(struct amd_ntb_dev *ndev,
>  	ndev->ntb.topo = NTB_TOPO_NONE;
>  	ndev->ntb.ops = &amd_ntb_ops;
>  	ndev->int_mask = AMD_EVENT_INTMASK;
> +	init_completion(&ndev->flush_cmpl);
>  	spin_lock_init(&ndev->db_mask_lock);
>  }
>  
> diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.h b/drivers/ntb/hw/amd/ntb_hw_amd.h
> index 31021c0..1054299 100644
> --- a/drivers/ntb/hw/amd/ntb_hw_amd.h
> +++ b/drivers/ntb/hw/amd/ntb_hw_amd.h
> @@ -200,6 +200,8 @@ struct amd_ntb_dev {
>  	unsigned int self_spad;
>  	unsigned int peer_spad;
>  
> +	struct completion flush_cmpl;
> +
>  	struct delayed_work hb_timer;
>  
>  	struct dentry *debugfs_dir;
> @@ -243,4 +245,5 @@ static int amd_ntb_peer_spad_addr(struct ntb_dev *ntb, int idx,
>  					phys_addr_t *spad_addr);
>  static u32 amd_ntb_peer_spad_read(struct ntb_dev *ntb, int idx);
>  static int amd_ntb_peer_spad_write(struct ntb_dev *ntb, int idx, u32 val);
> +static int amd_ntb_flush_req(struct ntb_dev *ntb);
>  #endif
> diff --git a/include/linux/ntb.h b/include/linux/ntb.h
> index f798e2a..6d443f4 100644
> --- a/include/linux/ntb.h
> +++ b/include/linux/ntb.h
> @@ -210,6 +210,7 @@ static inline int ntb_ctx_ops_is_valid(const struct ntb_ctx_ops *ops)
>   * @peer_spad_addr:	See ntb_peer_spad_addr().
>   * @peer_spad_read:	See ntb_peer_spad_read().
>   * @peer_spad_write:	See ntb_peer_spad_write().
> + * @flush_req:		See ntb_flush_request().
>   */
>  struct ntb_dev_ops {
>  	int (*mw_count)(struct ntb_dev *ntb);
> @@ -259,6 +260,8 @@ struct ntb_dev_ops {
>  			      phys_addr_t *spad_addr);
>  	u32 (*peer_spad_read)(struct ntb_dev *ntb, int idx);
>  	int (*peer_spad_write)(struct ntb_dev *ntb, int idx, u32 val);
> +
> +	int (*flush_req)(struct ntb_dev *ntb);
>  };
>  
>  static inline int ntb_dev_ops_is_valid(const struct ntb_dev_ops *ops)
> @@ -980,4 +983,23 @@ static inline int ntb_peer_spad_write(struct ntb_dev *ntb, int idx, u32 val)
>  	return ntb->ops->peer_spad_write(ntb, idx, val);
>  }
>  
> +/**
> + * ntb_flush_requests() - flush all pending requests
> + * @ntb:	NTB device context.
> + *
> + * For some usage, one side of NTB need to first make sure that all previous
> + * requests have been completed and then execute next step such as power down,
> + * or device removed.
> + * NOTE: This function may go to sleep, so can't call it in interrupt context.
> + *
> + * Return: Zero on success, otherwise an error number.
> + */
> +static inline int ntb_flush_requests(struct ntb_dev *ntb)
> +{
> +	if (!ntb->ops->flush_req)
> +		return 0;
> +
> +	return ntb->ops->flush_req(ntb);
> +}
> +
>  #endif
> -- 
> 1.9.1
> 
