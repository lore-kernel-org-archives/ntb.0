Return-Path: <jdmason@kudzu.us>
Received: from mail-ua0-x244.google.com (mail-ua0-x244.google.com. [2607:f8b0:400c:c08::244])
        by gmr-mx.google.com with ESMTPS id s206si1405956vka.2.2017.02.01.12.01.55
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Feb 2017 12:01:55 -0800 (PST)
Received: by mail-ua0-x244.google.com with SMTP id f2so36878890uaf.3
        for <linux-ntb@googlegroups.com>; Wed, 01 Feb 2017 12:01:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1484093600-4428-1-git-send-email-fancer.lancer@gmail.com>
References: <1481672961-10753-6-git-send-email-fancer.lancer@gmail.com> <1484093600-4428-1-git-send-email-fancer.lancer@gmail.com>
From: Jon Mason <jdmason@kudzu.us>
Date: Wed, 1 Feb 2017 15:01:53 -0500
Message-ID: <CAPoiz9ybKGr1Khyuk97nmKgTyxN181oQDZyA54oTjEPnU65qaA@mail.gmail.com>
Subject: Re: [PATCH v3 5/9] NTB: Alter Scratchpads API to support multi-ports devices
Content-Type: text/plain; charset=UTF-8
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Dave Jiang <dave.jiang@intel.com>, "Hubbe, Allen" <Allen.Hubbe@emc.com>, "Yu, Xiangliang" <Xiangliang.Yu@amd.com>, Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel <linux-kernel@vger.kernel.org>
List-ID: <linux-ntb.googlegroups.com>

On Tue, Jan 10, 2017 at 7:13 PM, Serge Semin <fancer.lancer@gmail.com> wrote:
> Even though there is no any real NTB hardware, which would have both more
> than two ports and Scratchpad registers, it is logically correct to have
> Scratchpad API accepting a peer port index as well. Intel/AMD drivers utilize
> Primary and Secondary topology to split Scratchpad between connected root
> devices. Since port-index API introduced, Intel/AMD NTB hardware drivers can
> use device port to determine which Scratchpad registers actually belong to
> local and peer devices. The same approach can be used if some potential
> hardware in future will be multi-port and have some set of Scratchpads.
> Here are the brief of changes in the API:
>  ntb_spad_count() - return number of Scratchpads per each port
>  ntb_peer_spad_addr(pidx, sidx) - address of Scratchpad register of the
> peer device with pidx-index
>  ntb_peer_spad_read(pidx, sidx) - read specified Scratchpad register of the
> peer with pidx-index
>  ntb_peer_spad_write(pidx, sidx) - write data to Scratchpad register of the
> peer with pidx-index
>
> Since there is hardware which doesn't support Scratchpad registers, the
> corresponding API methods are now made optional.
>
> Acked-by: Allen Hubbe <Allen.Hubbe@dell.com>
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

The series has been applied to my ntb-next branch.

Thanks,
Jon


> ---
>  drivers/ntb/hw/amd/ntb_hw_amd.c     | 14 +++----
>  drivers/ntb/hw/intel/ntb_hw_intel.c | 14 +++----
>  drivers/ntb/ntb_transport.c         | 17 ++++-----
>  drivers/ntb/test/ntb_perf.c         |  6 +--
>  drivers/ntb/test/ntb_pingpong.c     |  8 +++-
>  drivers/ntb/test/ntb_tool.c         | 21 ++++++++--
>  include/linux/ntb.h                 | 76 +++++++++++++++++++++++--------------
>  7 files changed, 98 insertions(+), 58 deletions(-)
>
> diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
> index 6a41c38..bc537aa 100644
> --- a/drivers/ntb/hw/amd/ntb_hw_amd.c
> +++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
> @@ -433,30 +433,30 @@ static int amd_ntb_spad_write(struct ntb_dev *ntb,
>         return 0;
>  }
>
> -static u32 amd_ntb_peer_spad_read(struct ntb_dev *ntb, int idx)
> +static u32 amd_ntb_peer_spad_read(struct ntb_dev *ntb, int pidx, int sidx)
>  {
>         struct amd_ntb_dev *ndev = ntb_ndev(ntb);
>         void __iomem *mmio = ndev->self_mmio;
>         u32 offset;
>
> -       if (idx < 0 || idx >= ndev->spad_count)
> +       if (sidx < 0 || sidx >= ndev->spad_count)
>                 return -EINVAL;
>
> -       offset = ndev->peer_spad + (idx << 2);
> +       offset = ndev->peer_spad + (sidx << 2);
>         return readl(mmio + AMD_SPAD_OFFSET + offset);
>  }
>
> -static int amd_ntb_peer_spad_write(struct ntb_dev *ntb,
> -                                  int idx, u32 val)
> +static int amd_ntb_peer_spad_write(struct ntb_dev *ntb, int pidx,
> +                                  int sidx, u32 val)
>  {
>         struct amd_ntb_dev *ndev = ntb_ndev(ntb);
>         void __iomem *mmio = ndev->self_mmio;
>         u32 offset;
>
> -       if (idx < 0 || idx >= ndev->spad_count)
> +       if (sidx < 0 || sidx >= ndev->spad_count)
>                 return -EINVAL;
>
> -       offset = ndev->peer_spad + (idx << 2);
> +       offset = ndev->peer_spad + (sidx << 2);
>         writel(val, mmio + AMD_SPAD_OFFSET + offset);
>
>         return 0;
> diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.c b/drivers/ntb/hw/intel/ntb_hw_intel.c
> index 4b84012..7bb14cb 100644
> --- a/drivers/ntb/hw/intel/ntb_hw_intel.c
> +++ b/drivers/ntb/hw/intel/ntb_hw_intel.c
> @@ -1409,30 +1409,30 @@ static int intel_ntb_spad_write(struct ntb_dev *ntb,
>                                ndev->self_reg->spad);
>  }
>
> -static int intel_ntb_peer_spad_addr(struct ntb_dev *ntb, int idx,
> +static int intel_ntb_peer_spad_addr(struct ntb_dev *ntb, int pidx, int sidx,
>                                     phys_addr_t *spad_addr)
>  {
>         struct intel_ntb_dev *ndev = ntb_ndev(ntb);
>
> -       return ndev_spad_addr(ndev, idx, spad_addr, ndev->peer_addr,
> +       return ndev_spad_addr(ndev, sidx, spad_addr, ndev->peer_addr,
>                               ndev->peer_reg->spad);
>  }
>
> -static u32 intel_ntb_peer_spad_read(struct ntb_dev *ntb, int idx)
> +static u32 intel_ntb_peer_spad_read(struct ntb_dev *ntb, int pidx, int sidx)
>  {
>         struct intel_ntb_dev *ndev = ntb_ndev(ntb);
>
> -       return ndev_spad_read(ndev, idx,
> +       return ndev_spad_read(ndev, sidx,
>                               ndev->peer_mmio +
>                               ndev->peer_reg->spad);
>  }
>
> -static int intel_ntb_peer_spad_write(struct ntb_dev *ntb,
> -                                    int idx, u32 val)
> +static int intel_ntb_peer_spad_write(struct ntb_dev *ntb, int pidx,
> +                                    int sidx, u32 val)
>  {
>         struct intel_ntb_dev *ndev = ntb_ndev(ntb);
>
> -       return ndev_spad_write(ndev, idx, val,
> +       return ndev_spad_write(ndev, sidx, val,
>                                ndev->peer_mmio +
>                                ndev->peer_reg->spad);
>  }
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 4d5b160..28aaba3 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -875,17 +875,17 @@ static void ntb_transport_link_work(struct work_struct *work)
>                         size = max_mw_size;
>
>                 spad = MW0_SZ_HIGH + (i * 2);
> -               ntb_peer_spad_write(ndev, spad, upper_32_bits(size));
> +               ntb_peer_spad_write(ndev, PIDX, spad, upper_32_bits(size));
>
>                 spad = MW0_SZ_LOW + (i * 2);
> -               ntb_peer_spad_write(ndev, spad, lower_32_bits(size));
> +               ntb_peer_spad_write(ndev, PIDX, spad, lower_32_bits(size));
>         }
>
> -       ntb_peer_spad_write(ndev, NUM_MWS, nt->mw_count);
> +       ntb_peer_spad_write(ndev, PIDX, NUM_MWS, nt->mw_count);
>
> -       ntb_peer_spad_write(ndev, NUM_QPS, nt->qp_count);
> +       ntb_peer_spad_write(ndev, PIDX, NUM_QPS, nt->qp_count);
>
> -       ntb_peer_spad_write(ndev, VERSION, NTB_TRANSPORT_VERSION);
> +       ntb_peer_spad_write(ndev, PIDX, VERSION, NTB_TRANSPORT_VERSION);
>
>         /* Query the remote side for its info */
>         val = ntb_spad_read(ndev, VERSION);
> @@ -961,7 +961,7 @@ static void ntb_qp_link_work(struct work_struct *work)
>
>         val = ntb_spad_read(nt->ndev, QP_LINKS);
>
> -       ntb_peer_spad_write(nt->ndev, QP_LINKS, val | BIT(qp->qp_num));
> +       ntb_peer_spad_write(nt->ndev, PIDX, QP_LINKS, val | BIT(qp->qp_num));
>
>         /* query remote spad for qp ready bits */
>         dev_dbg_ratelimited(&pdev->dev, "Remote QP link status = %x\n", val);
> @@ -2141,8 +2141,7 @@ void ntb_transport_link_down(struct ntb_transport_qp *qp)
>
>         val = ntb_spad_read(qp->ndev, QP_LINKS);
>
> -       ntb_peer_spad_write(qp->ndev, QP_LINKS,
> -                           val & ~BIT(qp->qp_num));
> +       ntb_peer_spad_write(qp->ndev, PIDX, QP_LINKS, val & ~BIT(qp->qp_num));
>
>         if (qp->link_is_up)
>                 ntb_send_link_down(qp);
> diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
> index cbff0b4..0a493ba 100644
> --- a/drivers/ntb/test/ntb_perf.c
> +++ b/drivers/ntb/test/ntb_perf.c
> @@ -516,9 +516,9 @@ static void perf_link_work(struct work_struct *work)
>         if (max_mw_size && size > max_mw_size)
>                 size = max_mw_size;
>
> -       ntb_peer_spad_write(ndev, MW_SZ_HIGH, upper_32_bits(size));
> -       ntb_peer_spad_write(ndev, MW_SZ_LOW, lower_32_bits(size));
> -       ntb_peer_spad_write(ndev, VERSION, PERF_VERSION);
> +       ntb_peer_spad_write(ndev, PIDX, MW_SZ_HIGH, upper_32_bits(size));
> +       ntb_peer_spad_write(ndev, PIDX, MW_SZ_LOW, lower_32_bits(size));
> +       ntb_peer_spad_write(ndev, PIDX, VERSION, PERF_VERSION);
>
>         /* now read what peer wrote */
>         val = ntb_spad_read(ndev, VERSION);
> diff --git a/drivers/ntb/test/ntb_pingpong.c b/drivers/ntb/test/ntb_pingpong.c
> index 12f8b40..938a18b 100644
> --- a/drivers/ntb/test/ntb_pingpong.c
> +++ b/drivers/ntb/test/ntb_pingpong.c
> @@ -138,7 +138,7 @@ static void pp_ping(unsigned long ctx)
>                         "Ping bits %#llx read %#x write %#x\n",
>                         db_bits, spad_rd, spad_wr);
>
> -               ntb_peer_spad_write(pp->ntb, 0, spad_wr);
> +               ntb_peer_spad_write(pp->ntb, PIDX, 0, spad_wr);
>                 ntb_peer_db_set(pp->ntb, db_bits);
>                 ntb_db_clear_mask(pp->ntb, db_mask);
>
> @@ -225,6 +225,12 @@ static int pp_probe(struct ntb_client *client,
>                 }
>         }
>
> +       if (ntb_spad_count(ntb) < 1) {
> +               dev_dbg(&ntb->dev, "no enough scratchpads\n");
> +               rc = -EINVAL;
> +               goto err_pp;
> +       }
> +
>         if (ntb_spad_is_unsafe(ntb)) {
>                 dev_dbg(&ntb->dev, "scratchpad is unsafe\n");
>                 if (!unsafe) {
> diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c
> index cb69247..f002bf4 100644
> --- a/drivers/ntb/test/ntb_tool.c
> +++ b/drivers/ntb/test/ntb_tool.c
> @@ -462,13 +462,22 @@ static TOOL_FOPS_RDWR(tool_spad_fops,
>                       tool_spad_read,
>                       tool_spad_write);
>
> +static u32 ntb_tool_peer_spad_read(struct ntb_dev *ntb, int sidx)
> +{
> +       return ntb_peer_spad_read(ntb, PIDX, sidx);
> +}
> +
>  static ssize_t tool_peer_spad_read(struct file *filep, char __user *ubuf,
>                                    size_t size, loff_t *offp)
>  {
>         struct tool_ctx *tc = filep->private_data;
>
> -       return tool_spadfn_read(tc, ubuf, size, offp,
> -                               tc->ntb->ops->peer_spad_read);
> +       return tool_spadfn_read(tc, ubuf, size, offp, ntb_tool_peer_spad_read);
> +}
> +
> +static int ntb_tool_peer_spad_write(struct ntb_dev *ntb, int sidx, u32 val)
> +{
> +       return ntb_peer_spad_write(ntb, PIDX, sidx, val);
>  }
>
>  static ssize_t tool_peer_spad_write(struct file *filep, const char __user *ubuf,
> @@ -477,7 +486,7 @@ static ssize_t tool_peer_spad_write(struct file *filep, const char __user *ubuf,
>         struct tool_ctx *tc = filep->private_data;
>
>         return tool_spadfn_write(tc, ubuf, size, offp,
> -                                tc->ntb->ops->peer_spad_write);
> +                                ntb_tool_peer_spad_write);
>  }
>
>  static TOOL_FOPS_RDWR(tool_peer_spad_fops,
> @@ -926,6 +935,12 @@ static int tool_probe(struct ntb_client *self, struct ntb_dev *ntb)
>                 goto err_tc;
>         }
>
> +       if (ntb_spad_count(ntb) < 1) {
> +               dev_dbg(&ntb->dev, "no enough scratchpads\n");
> +               rc = -EINVAL;
> +               goto err_tc;
> +       }
> +
>         if (ntb_db_is_unsafe(ntb))
>                 dev_dbg(&ntb->dev, "doorbell is unsafe\n");
>
> diff --git a/include/linux/ntb.h b/include/linux/ntb.h
> index f6ec88f..a54e2be 100644
> --- a/include/linux/ntb.h
> +++ b/include/linux/ntb.h
> @@ -288,13 +288,14 @@ struct ntb_dev_ops {
>         int (*spad_is_unsafe)(struct ntb_dev *ntb);
>         int (*spad_count)(struct ntb_dev *ntb);
>
> -       u32 (*spad_read)(struct ntb_dev *ntb, int idx);
> -       int (*spad_write)(struct ntb_dev *ntb, int idx, u32 val);
> +       u32 (*spad_read)(struct ntb_dev *ntb, int sidx);
> +       int (*spad_write)(struct ntb_dev *ntb, int sidx, u32 val);
>
> -       int (*peer_spad_addr)(struct ntb_dev *ntb, int idx,
> +       int (*peer_spad_addr)(struct ntb_dev *ntb, int pidx, int sidx,
>                               phys_addr_t *spad_addr);
> -       u32 (*peer_spad_read)(struct ntb_dev *ntb, int idx);
> -       int (*peer_spad_write)(struct ntb_dev *ntb, int idx, u32 val);
> +       u32 (*peer_spad_read)(struct ntb_dev *ntb, int pidx, int sidx);
> +       int (*peer_spad_write)(struct ntb_dev *ntb, int pidx, int sidx,
> +                              u32 val);
>  };
>
>  static inline int ntb_dev_ops_is_valid(const struct ntb_dev_ops *ops)
> @@ -335,13 +336,12 @@ static inline int ntb_dev_ops_is_valid(const struct ntb_dev_ops *ops)
>                 /* ops->peer_db_read_mask               && */
>                 /* ops->peer_db_set_mask                && */
>                 /* ops->peer_db_clear_mask              && */
> -               /* ops->spad_is_unsafe                  && */
> -               ops->spad_count                         &&
> -               ops->spad_read                          &&
> -               ops->spad_write                         &&
> -               /* ops->peer_spad_addr                  && */
> -               /* ops->peer_spad_read                  && */
> -               ops->peer_spad_write                    &&
> +               /* !ops->spad_is_unsafe == !ops->spad_count     && */
> +               !ops->spad_read == !ops->spad_count             &&
> +               !ops->spad_write == !ops->spad_count            &&
> +               /* !ops->peer_spad_addr == !ops->spad_count     && */
> +               /* !ops->peer_spad_read == !ops->spad_count     && */
> +               !ops->peer_spad_write == !ops->spad_count       &&
>                 1;
>  }
>
> @@ -1172,47 +1172,58 @@ static inline int ntb_spad_is_unsafe(struct ntb_dev *ntb)
>   * @ntb:       NTB device context.
>   *
>   * Hardware and topology may support a different number of scratchpads.
> + * Although it must be the same for all ports per NTB device.
>   *
>   * Return: the number of scratchpads.
>   */
>  static inline int ntb_spad_count(struct ntb_dev *ntb)
>  {
> +       if (!ntb->ops->spad_count)
> +               return 0;
> +
>         return ntb->ops->spad_count(ntb);
>  }
>
>  /**
>   * ntb_spad_read() - read the local scratchpad register
>   * @ntb:       NTB device context.
> - * @idx:       Scratchpad index.
> + * @sidx:      Scratchpad index.
>   *
>   * Read the local scratchpad register, and return the value.
>   *
>   * Return: The value of the local scratchpad register.
>   */
> -static inline u32 ntb_spad_read(struct ntb_dev *ntb, int idx)
> +static inline u32 ntb_spad_read(struct ntb_dev *ntb, int sidx)
>  {
> -       return ntb->ops->spad_read(ntb, idx);
> +       if (!ntb->ops->spad_read)
> +               return ~(u32)0;
> +
> +       return ntb->ops->spad_read(ntb, sidx);
>  }
>
>  /**
>   * ntb_spad_write() - write the local scratchpad register
>   * @ntb:       NTB device context.
> - * @idx:       Scratchpad index.
> + * @sidx:      Scratchpad index.
>   * @val:       Scratchpad value.
>   *
>   * Write the value to the local scratchpad register.
>   *
>   * Return: Zero on success, otherwise an error number.
>   */
> -static inline int ntb_spad_write(struct ntb_dev *ntb, int idx, u32 val)
> +static inline int ntb_spad_write(struct ntb_dev *ntb, int sidx, u32 val)
>  {
> -       return ntb->ops->spad_write(ntb, idx, val);
> +       if (!ntb->ops->spad_write)
> +               return -EINVAL;
> +
> +       return ntb->ops->spad_write(ntb, sidx, val);
>  }
>
>  /**
>   * ntb_peer_spad_addr() - address of the peer scratchpad register
>   * @ntb:       NTB device context.
> - * @idx:       Scratchpad index.
> + * @pidx:      Port index of peer device.
> + * @sidx:      Scratchpad index.
>   * @spad_addr: OUT - The address of the peer scratchpad register.
>   *
>   * Return the address of the peer doorbell register.  This may be used, for
> @@ -1224,45 +1235,51 @@ static inline int ntb_spad_write(struct ntb_dev *ntb, int idx, u32 val)
>   *
>   * Return: Zero on success, otherwise an error number.
>   */
> -static inline int ntb_peer_spad_addr(struct ntb_dev *ntb, int idx,
> +static inline int ntb_peer_spad_addr(struct ntb_dev *ntb, int pidx, int sidx,
>                                      phys_addr_t *spad_addr)
>  {
>         if (!ntb->ops->peer_spad_addr)
>                 return -EINVAL;
>
> -       return ntb->ops->peer_spad_addr(ntb, idx, spad_addr);
> +       return ntb->ops->peer_spad_addr(ntb, pidx, sidx, spad_addr);
>  }
>
>  /**
>   * ntb_peer_spad_read() - read the peer scratchpad register
>   * @ntb:       NTB device context.
> - * @idx:       Scratchpad index.
> + * @pidx:      Port index of peer device.
> + * @sidx:      Scratchpad index.
>   *
>   * Read the peer scratchpad register, and return the value.
>   *
>   * Return: The value of the local scratchpad register.
>   */
> -static inline u32 ntb_peer_spad_read(struct ntb_dev *ntb, int idx)
> +static inline u32 ntb_peer_spad_read(struct ntb_dev *ntb, int pidx, int sidx)
>  {
> -       if (!ntb->ops->peer_spad_read)
> -               return 0;
> -
> -       return ntb->ops->peer_spad_read(ntb, idx);
> +       if (!ntb->ops->peer_spad_read)
> +               return ~(u32)0;
> +
> +       return ntb->ops->peer_spad_read(ntb, pidx, sidx);
>  }
>
>  /**
>   * ntb_peer_spad_write() - write the peer scratchpad register
>   * @ntb:       NTB device context.
> - * @idx:       Scratchpad index.
> + * @pidx:      Port index of peer device.
> + * @sidx:      Scratchpad index.
>   * @val:       Scratchpad value.
>   *
>   * Write the value to the peer scratchpad register.
>   *
>   * Return: Zero on success, otherwise an error number.
>   */
> -static inline int ntb_peer_spad_write(struct ntb_dev *ntb, int idx, u32 val)
> +static inline int ntb_peer_spad_write(struct ntb_dev *ntb, int pidx, int sidx,
> +                                     u32 val)
>  {
> -       return ntb->ops->peer_spad_write(ntb, idx, val);
> +       if (!ntb->ops->peer_spad_write)
> +               return -EINVAL;
> +
> +       return ntb->ops->peer_spad_write(ntb, pidx, sidx, val);
>  }
>
>  #endif
> --
> 2.6.6
>
