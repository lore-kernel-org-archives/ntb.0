Return-Path: <jdmason@kudzu.us>
Received: from mail-ua0-x235.google.com (mail-ua0-x235.google.com. [2607:f8b0:400c:c08::235])
        by gmr-mx.google.com with ESMTPS id h1si38632qkj.5.2017.12.05.10.21.27
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Dec 2017 10:21:27 -0800 (PST)
Received: by mail-ua0-x235.google.com with SMTP id i4so922746uab.5
        for <linux-ntb@googlegroups.com>; Tue, 05 Dec 2017 10:21:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171203191736.3399-7-fancer.lancer@gmail.com>
References: <20171203191736.3399-1-fancer.lancer@gmail.com> <20171203191736.3399-7-fancer.lancer@gmail.com>
From: Jon Mason <jdmason@kudzu.us>
Date: Tue, 5 Dec 2017 13:21:24 -0500
Message-ID: <CAPoiz9zcwvjV+BEiWGLNtM64YehwO1MAjwKyhgYPqwY4tYE=ig@mail.gmail.com>
Subject: Re: [PATCH v2 06/15] NTB: ntb_perf: Add full multi-port NTB API support
Content-Type: text/plain; charset="UTF-8"
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Dave Jiang <dave.jiang@intel.com>, "Hubbe, Allen" <Allen.Hubbe@emc.com>, "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>, "Yu, Xiangliang" <Xiangliang.Yu@amd.com>, Gary R Hook <gary.hook@amd.com>, Sergey.Semin@t-platforms.ru, linux-ntb <linux-ntb@googlegroups.com>, linux-kernel <linux-kernel@vger.kernel.org>
List-ID: <linux-ntb.googlegroups.com>

On Sun, Dec 3, 2017 at 2:17 PM, Serge Semin <fancer.lancer@gmail.com> wrote:
> NTB API has been updated to support multi-port devices like IDT
> 89HPESx series or Microsemi Switchtec. Message registers
> functionality has also been added to new API. In order to keep
> the new hardware and corresponding capabilities well tested, NTB
> performance driver is accordingly altered.
>
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> ---
>
> Changelog v1:
> - Alter interface in compliance with multi-port API
> - Create Scratchpads and Message compliant NTB link init process
> - Simplify memcpy and DMA-based tests process
> - Limit DebugFS access methods to prevent the driver failure
>
> Changelog v2:
> - Remove driver Author/Description/License macros
> - Replace magic numbers with macros
> - Fix global index calc error for devices with highest port index
> - Fix invalid scratchpad selection in send_msg algorithm
> - Fix bytes order translation in message recv method
> - Use local global index to select an inbound MW
> - Add commands send/recv/exec debug prints
> - Call ntb_mw_get_align when link is supposed to be up
>
>  drivers/ntb/test/ntb_perf.c | 1826 +++++++++++++++++++++++++++++--------------
>  1 file changed, 1222 insertions(+), 604 deletions(-)
>
> diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
> index 427112cf101a..5ca5cc6f9687 100644
> --- a/drivers/ntb/test/ntb_perf.c
> +++ b/drivers/ntb/test/ntb_perf.c
> @@ -5,6 +5,7 @@
>   *   GPL LICENSE SUMMARY
>   *
>   *   Copyright(c) 2015 Intel Corporation. All rights reserved.
> + *   Copyright(c) 2017 T-Platforms. All Rights Reserved.
>   *
>   *   This program is free software; you can redistribute it and/or modify
>   *   it under the terms of version 2 of the GNU General Public License as
> @@ -13,6 +14,7 @@
>   *   BSD LICENSE
>   *
>   *   Copyright(c) 2015 Intel Corporation. All rights reserved.
> + *   Copyright(c) 2017 T-Platforms. All Rights Reserved.
>   *
>   *   Redistribution and use in source and binary forms, with or without
>   *   modification, are permitted provided that the following conditions
> @@ -40,860 +42,1476 @@
>   *   (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
>   *   OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
>   *
> - *   PCIe NTB Perf Linux driver
> + * PCIe NTB Perf Linux driver
> + *
> + * Contact Information:
> + * Dave Jiang <dave.jiang@intel.com>
> + * Serge Semin <fancer.lancer@gmail.com>, <Sergey.Semin@t-platforms.ru>
> + */
> +
> +/*
> + * How to use this tool, by example.
> + *
> + * Assuming $DBG_DIR is something like:
> + * '/sys/kernel/debug/ntb_perf/0000:00:03.0'
> + * Suppose aside from local device there is at least one remote device
> + * connected to NTB with index 0.
> + *-----------------------------------------------------------------------------
> + * Eg: install driver with specified chunk/total orders and dma-enabled flag
> + *
> + * root@self# insmod ntb_perf.ko chunk_order=19 total_order=28 use_dma
> + *-----------------------------------------------------------------------------
> + * Eg: check NTB ports (index) and MW mapping information
> + *
> + * root@self# cat $DBG_DIR/info
> + *-----------------------------------------------------------------------------
> + * Eg: start performance test with peer (index 0) and get the test metrics
> + *
> + * root@self# echo 0 > $DBG_DIR/run
> + * root@self# cat $DBG_DIR/run
>   */
>
>  #include <linux/init.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> -#include <linux/kthread.h>
> -#include <linux/time.h>
> -#include <linux/timer.h>
> +#include <linux/sched.h>
> +#include <linux/wait.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/dmaengine.h>
>  #include <linux/pci.h>
> +#include <linux/ktime.h>
>  #include <linux/slab.h>
> -#include <linux/spinlock.h>
> -#include <linux/debugfs.h>
> -#include <linux/dmaengine.h>
>  #include <linux/delay.h>
>  #include <linux/sizes.h>
> +#include <linux/workqueue.h>
> +#include <linux/debugfs.h>
> +#include <linux/random.h>
>  #include <linux/ntb.h>
> -#include <linux/mutex.h>
>
>  #define DRIVER_NAME            "ntb_perf"
> -#define DRIVER_DESCRIPTION     "PCIe NTB Performance Measurement Tool"
> -
> -#define DRIVER_LICENSE         "Dual BSD/GPL"
> -#define DRIVER_VERSION         "1.0"
> -#define DRIVER_AUTHOR          "Dave Jiang <dave.jiang@intel.com>"
> -
> -#define PERF_LINK_DOWN_TIMEOUT 10
> -#define PERF_VERSION           0xffff0001
> -#define MAX_THREADS            32
> -#define MAX_TEST_SIZE          SZ_1M
> -#define MAX_SRCS               32
> -#define DMA_OUT_RESOURCE_TO    msecs_to_jiffies(50)
> -#define DMA_RETRIES            20
> -#define SZ_4G                  (1ULL << 32)
> -#define MAX_SEG_ORDER          20 /* no larger than 1M for kmalloc buffer */
> -#define PIDX                   NTB_DEF_PEER_IDX
> -
> -MODULE_LICENSE(DRIVER_LICENSE);
> +#define DRIVER_VERSION         "2.0"
> +
> +MODULE_LICENSE("Dual BSD/GPL");
>  MODULE_VERSION(DRIVER_VERSION);
> -MODULE_AUTHOR(DRIVER_AUTHOR);
> -MODULE_DESCRIPTION(DRIVER_DESCRIPTION);
> +MODULE_AUTHOR("Dave Jiang <dave.jiang@intel.com>");
> +MODULE_DESCRIPTION("PCIe NTB Performance Measurement Tool");
>
> -static struct dentry *perf_debugfs_dir;
> +#define MAX_THREADS_CNT                32
> +#define DEF_THREADS_CNT                1
> +#define MAX_CHUNK_SIZE         SZ_1M
> +#define MAX_CHUNK_ORDER                20 /* no larger than 1M */
> +
> +#define DMA_TRIES              100
> +#define DMA_MDELAY             10
> +
> +#define MSG_TRIES              500
> +#define MSG_UDELAY_LOW         1000
> +#define MSG_UDELAY_HIGH                2000
>
>  static unsigned long max_mw_size;
>  module_param(max_mw_size, ulong, 0644);
> -MODULE_PARM_DESC(max_mw_size, "Limit size of large memory windows");
> +MODULE_PARM_DESC(max_mw_size, "Upper limit of memory window size");
>
> -static unsigned int seg_order = 19; /* 512K */
> -module_param(seg_order, uint, 0644);
> -MODULE_PARM_DESC(seg_order, "size order [2^n] of buffer segment for testing");
> +static unsigned char chunk_order = 19; /* 512K */
> +module_param(chunk_order, byte, 0644);
> +MODULE_PARM_DESC(chunk_order, "Data chunk order [2^n] to transfer");
>
> -static unsigned int run_order = 32; /* 4G */
> -module_param(run_order, uint, 0644);
> -MODULE_PARM_DESC(run_order, "size order [2^n] of total data to transfer");
> +static unsigned char total_order = 30; /* 1G */
> +module_param(total_order, byte, 0644);
> +MODULE_PARM_DESC(total_order, "Total data order [2^n] to transfer");
>
>  static bool use_dma; /* default to 0 */
>  module_param(use_dma, bool, 0644);
> -MODULE_PARM_DESC(use_dma, "Using DMA engine to measure performance");
> -
> -static bool on_node = true; /* default to 1 */
> -module_param(on_node, bool, 0644);
> -MODULE_PARM_DESC(on_node, "Run threads only on NTB device node (default: true)");
> -
> -struct perf_mw {
> -       phys_addr_t     phys_addr;
> -       resource_size_t phys_size;
> -       void __iomem    *vbase;
> -       size_t          xlat_size;
> -       size_t          buf_size;
> -       void            *virt_addr;
> -       dma_addr_t      dma_addr;
> +MODULE_PARM_DESC(use_dma, "Use DMA engine to measure performance");
> +
> +/*==============================================================================
> + *                         Perf driver data definition
> + *==============================================================================
> + */
> +
> +enum perf_cmd {
> +       PERF_CMD_INVAL = -1,/* invalid spad command */
> +       PERF_CMD_SSIZE = 0, /* send out buffer size */
> +       PERF_CMD_RSIZE = 1, /* recv in  buffer size */
> +       PERF_CMD_SXLAT = 2, /* send in  buffer xlat */
> +       PERF_CMD_RXLAT = 3, /* recv out buffer xlat */
> +       PERF_CMD_CLEAR = 4, /* clear allocated memory */
> +       PERF_STS_DONE  = 5, /* init is done */
> +       PERF_STS_LNKUP = 6, /* link up state flag */
>  };
>
>  struct perf_ctx;
>
> -struct pthr_ctx {
> -       struct task_struct      *thread;
> -       struct perf_ctx         *perf;
> -       atomic_t                dma_sync;
> -       struct dma_chan         *dma_chan;
> -       int                     dma_prep_err;
> -       int                     src_idx;
> -       void                    *srcs[MAX_SRCS];
> -       wait_queue_head_t       *wq;
> -       int                     status;
> -       u64                     copied;
> -       u64                     diff_us;
> +struct perf_peer {
> +       struct perf_ctx *perf;
> +       int pidx;
> +       int gidx;
> +
> +       /* Outbound MW params */
> +       u64 outbuf_xlat;
> +       resource_size_t outbuf_size;
> +       void __iomem *outbuf;
> +
> +       /* Inbound MW params */
> +       dma_addr_t inbuf_xlat;
> +       resource_size_t inbuf_size;
> +       void            *inbuf;
> +
> +       /* NTB connection setup service */
> +       struct work_struct      service;
> +       unsigned long           sts;
>  };
> +#define to_peer_service(__work) \
> +       container_of(__work, struct perf_peer, service)
>
> -struct perf_ctx {
> -       struct ntb_dev          *ntb;
> -       spinlock_t              db_lock;
> -       struct perf_mw          mw;
> -       bool                    link_is_up;
> -       struct delayed_work     link_work;
> -       wait_queue_head_t       link_wq;
> -       u8                      perf_threads;
> -       /* mutex ensures only one set of threads run at once */
> -       struct mutex            run_mutex;
> -       struct pthr_ctx         pthr_ctx[MAX_THREADS];
> -       atomic_t                tsync;
> -       atomic_t                tdone;
> +struct perf_thread {
> +       struct perf_ctx *perf;
> +       int tidx;
> +
> +       /* DMA-based test sync parameters */
> +       atomic_t dma_sync;
> +       wait_queue_head_t dma_wait;
> +       struct dma_chan *dma_chan;
> +
> +       /* Data source and measured statistics */
> +       void *src;
> +       u64 copied;
> +       ktime_t duration;
> +       int status;
> +       struct work_struct work;
>  };
> +#define to_thread_work(__work) \
> +       container_of(__work, struct perf_thread, work)
>
> -enum {
> -       VERSION = 0,
> -       MW_SZ_HIGH,
> -       MW_SZ_LOW,
> -       MAX_SPAD
> +struct perf_ctx {
> +       struct ntb_dev *ntb;
> +
> +       /* Global device index and peers descriptors */
> +       int gidx;
> +       int pcnt;
> +       struct perf_peer *peers;
> +
> +       /* Performance measuring work-threads interface */
> +       unsigned long busy_flag;
> +       wait_queue_head_t twait;
> +       atomic_t tsync;
> +       u8 tcnt;
> +       struct perf_peer *test_peer;
> +       struct perf_thread threads[MAX_THREADS_CNT];
> +
> +       /* Scratchpad/Message IO operations */
> +       int (*cmd_send)(struct perf_peer *peer, enum perf_cmd cmd, u64 data);
> +       int (*cmd_recv)(struct perf_ctx *perf, int *pidx, enum perf_cmd *cmd,
> +                       u64 *data);
> +
> +       struct dentry *dbgfs_dir;
>  };
>
> +/*
> + * Scratchpads-base commands interface
> + */
> +#define PERF_SPAD_CNT(_pcnt) \
> +       (3*((_pcnt) + 1))
> +#define PERF_SPAD_CMD(_gidx) \
> +       (3*(_gidx))
> +#define PERF_SPAD_LDATA(_gidx) \
> +       (3*(_gidx) + 1)
> +#define PERF_SPAD_HDATA(_gidx) \
> +       (3*(_gidx) + 2)
> +#define PERF_SPAD_NOTIFY(_gidx) \
> +       (BIT_ULL(_gidx))
> +
> +/*
> + * Messages-base commands interface
> + */
> +#define PERF_MSG_CNT           3
> +#define PERF_MSG_CMD           0
> +#define PERF_MSG_LDATA         1
> +#define PERF_MSG_HDATA         2
> +
> +/*==============================================================================
> + *                           Static data declarations
> + *==============================================================================
> + */
> +
> +static struct dentry *perf_dbgfs_topdir;
> +
> +static struct workqueue_struct *perf_wq __read_mostly;
> +
> +/*==============================================================================
> + *                  NTB cross-link commands execution service
> + *==============================================================================
> + */
> +
> +static void perf_terminate_test(struct perf_ctx *perf);
> +
> +static inline bool perf_link_is_up(struct perf_peer *peer)
> +{
> +       u64 link;
> +
> +       link = ntb_link_is_up(peer->perf->ntb, NULL, NULL);
> +       return !!(link & BIT_ULL_MASK(peer->pidx));
> +}
> +
> +static int perf_spad_cmd_send(struct perf_peer *peer, enum perf_cmd cmd,
> +                             u64 data)
> +{
> +       struct perf_ctx *perf = peer->perf;
> +       int try;
> +       u32 sts;
> +
> +       dev_dbg(&perf->ntb->dev, "CMD send: %d 0x%llx\n", cmd, data);
> +
> +       /*
> +        * Perform predefined number of attempts before give up.
> +        * We are sending the data to the port specific scratchpad, so
> +        * to prevent a multi-port access race-condition. Additionally
> +        * there is no need in local locking since only thread-safe
> +        * service work is using this method.
> +        */
> +       for (try = 0; try < MSG_TRIES; try++) {
> +               if (!perf_link_is_up(peer))
> +                       return -ENOLINK;
> +
> +               sts = ntb_peer_spad_read(perf->ntb, peer->pidx,
> +                                        PERF_SPAD_CMD(perf->gidx));
> +               if (le32_to_cpu(sts) != PERF_CMD_INVAL) {
> +                       usleep_range(MSG_UDELAY_LOW, MSG_UDELAY_HIGH);
> +                       continue;
> +               }
> +
> +               ntb_peer_spad_write(perf->ntb, peer->pidx,
> +                                   PERF_SPAD_LDATA(perf->gidx),
> +                                   cpu_to_le32(lower_32_bits(data)));
> +               ntb_peer_spad_write(perf->ntb, peer->pidx,
> +                                   PERF_SPAD_HDATA(perf->gidx),
> +                                   cpu_to_le32(upper_32_bits(data)));
> +               mmiowb();
> +               ntb_peer_spad_write(perf->ntb, peer->pidx,
> +                                   PERF_SPAD_CMD(perf->gidx),
> +                                   cpu_to_le32(cmd));
> +               mmiowb();
> +               ntb_peer_db_set(perf->ntb, PERF_SPAD_NOTIFY(peer->gidx));
> +
> +               dev_dbg(&perf->ntb->dev, "DB ring peer %#llx\n",
> +                       PERF_SPAD_NOTIFY(peer->gidx));
> +
> +               break;
> +       }
> +
> +       return try < MSG_TRIES ? 0 : -EAGAIN;
> +}
> +
> +static int perf_spad_cmd_recv(struct perf_ctx *perf, int *pidx,
> +                             enum perf_cmd *cmd, u64 *data)
> +{
> +       struct perf_peer *peer;
> +       u32 val;
> +
> +       ntb_db_clear(perf->ntb, PERF_SPAD_NOTIFY(perf->gidx));
> +
> +       /*
> +        * We start scanning all over, since cleared DB may have been set
> +        * by any peer. Yes, it makes peer with smaller index being
> +        * serviced with greater priority, but it's convenient for spad
> +        * and message code unification and simplicity.
> +        */
> +       for (*pidx = 0; *pidx < perf->pcnt; (*pidx)++) {
> +               peer = &perf->peers[*pidx];
> +
> +               if (!perf_link_is_up(peer))
> +                       continue;
> +
> +               val = ntb_spad_read(perf->ntb, PERF_SPAD_CMD(peer->gidx));
> +               val = le32_to_cpu(val);
> +               if (val == PERF_CMD_INVAL)
> +                       continue;
> +
> +               *cmd = val;
> +
> +               val = ntb_spad_read(perf->ntb, PERF_SPAD_LDATA(peer->gidx));
> +               *data = le32_to_cpu(val);
> +
> +               val = ntb_spad_read(perf->ntb, PERF_SPAD_HDATA(peer->gidx));
> +               *data |= (u64)le32_to_cpu(val) << 32;
> +
> +               /* Next command can be retrieved from now */
> +               ntb_spad_write(perf->ntb, PERF_SPAD_CMD(peer->gidx),
> +                              cpu_to_le32(PERF_CMD_INVAL));
> +
> +               dev_dbg(&perf->ntb->dev, "CMD recv: %d 0x%llx\n", *cmd, *data);
> +
> +               return 0;
> +       }
> +
> +       return -ENODATA;
> +}
> +
> +static int perf_msg_cmd_send(struct perf_peer *peer, enum perf_cmd cmd,
> +                            u64 data)
> +{
> +       struct perf_ctx *perf = peer->perf;
> +       int try, ret;
> +       u64 outbits;
> +
> +       dev_dbg(&perf->ntb->dev, "CMD send: %d 0x%llx\n", cmd, data);
> +
> +       /*
> +        * Perform predefined number of attempts before give up. Message
> +        * registers are free of race-condition problem when accessed
> +        * from different ports, so we don't need splitting registers
> +        * by global device index. We also won't have local locking,
> +        * since the method is used from service work only.
> +        */
> +       outbits = ntb_msg_outbits(perf->ntb);
> +       for (try = 0; try < MSG_TRIES; try++) {
> +               if (!perf_link_is_up(peer))
> +                       return -ENOLINK;
> +
> +               ret = ntb_msg_clear_sts(perf->ntb, outbits);
> +               if (ret)
> +                       return ret;
> +
> +               ntb_peer_msg_write(perf->ntb, peer->pidx, PERF_MSG_LDATA,
> +                             cpu_to_le32(lower_32_bits(data)));
> +
> +               if (ntb_msg_read_sts(perf->ntb) & outbits) {
> +                       usleep_range(MSG_UDELAY_LOW, MSG_UDELAY_HIGH);
> +                       continue;
> +               }
> +
> +               ntb_peer_msg_write(perf->ntb, peer->pidx, PERF_MSG_HDATA,
> +                             cpu_to_le32(upper_32_bits(data)));
> +               mmiowb();
> +
> +               /* This call shall trigger peer message event */
> +               ntb_peer_msg_write(perf->ntb, peer->pidx, PERF_MSG_CMD,
> +                             cpu_to_le32(cmd));
> +
> +               break;
> +       }
> +
> +       return try < MSG_TRIES ? 0 : -EAGAIN;
> +}
> +
> +static int perf_msg_cmd_recv(struct perf_ctx *perf, int *pidx,
> +                            enum perf_cmd *cmd, u64 *data)
> +{
> +       u64 inbits;
> +       u32 val;
> +
> +       inbits = ntb_msg_inbits(perf->ntb);
> +
> +       if (hweight64(ntb_msg_read_sts(perf->ntb) & inbits) < 3)
> +               return -ENODATA;
> +
> +       val = ntb_msg_read(perf->ntb, pidx, PERF_MSG_CMD);
> +       *cmd = le32_to_cpu(val);
> +
> +       val = ntb_msg_read(perf->ntb, pidx, PERF_MSG_LDATA);
> +       *data = le32_to_cpu(val);
> +
> +       val = ntb_msg_read(perf->ntb, pidx, PERF_MSG_HDATA);
> +       *data |= (u64)le32_to_cpu(val) << 32;
> +
> +       /* Next command can be retrieved from now */
> +       ntb_msg_clear_sts(perf->ntb, inbits);
> +
> +       dev_dbg(&perf->ntb->dev, "CMD recv: %d 0x%llx\n", *cmd, *data);
> +
> +       return 0;
> +}
> +
> +static int perf_cmd_send(struct perf_peer *peer, enum perf_cmd cmd, u64 data)
> +{
> +       struct perf_ctx *perf = peer->perf;
> +
> +       if (cmd == PERF_CMD_SSIZE || cmd == PERF_CMD_SXLAT)
> +               return perf->cmd_send(peer, cmd, data);
> +
> +       dev_err(&perf->ntb->dev, "Send invalid command\n");
> +       return -EINVAL;
> +}
> +
> +static int perf_cmd_exec(struct perf_peer *peer, enum perf_cmd cmd)
> +{
> +       switch (cmd) {
> +       case PERF_CMD_SSIZE:
> +       case PERF_CMD_RSIZE:
> +       case PERF_CMD_SXLAT:
> +       case PERF_CMD_RXLAT:
> +       case PERF_CMD_CLEAR:
> +               break;
> +       default:
> +               dev_err(&peer->perf->ntb->dev, "Exec invalid command\n");
> +               return -EINVAL;
> +       }
> +
> +       /* No need of memory barrier, since bit ops have invernal lock */
> +       set_bit(cmd, &peer->sts);
> +
> +       dev_dbg(&peer->perf->ntb->dev, "CMD exec: %d\n", cmd);
> +
> +       (void)queue_work(system_highpri_wq, &peer->service);

Seems like this should be the return value of this function, isntead
of using a cast to ignore it.  Am I missing something?

> +
> +       return 0;
> +}
> +
> +static int perf_cmd_recv(struct perf_ctx *perf)
> +{
> +       struct perf_peer *peer;
> +       int ret, pidx, cmd;
> +       u64 data;
> +
> +       while (!(ret = perf->cmd_recv(perf, &pidx, &cmd, &data))) {
> +               peer = &perf->peers[pidx];
> +
> +               switch (cmd) {
> +               case PERF_CMD_SSIZE:
> +                       peer->inbuf_size = data;
> +                       return perf_cmd_exec(peer, PERF_CMD_RSIZE);
> +               case PERF_CMD_SXLAT:
> +                       peer->outbuf_xlat = data;
> +                       return perf_cmd_exec(peer, PERF_CMD_RXLAT);
> +               default:
> +                       dev_err(&perf->ntb->dev, "Recv invalid command\n");
> +                       return -EINVAL;
> +               }
> +       }
> +
> +       return ret == -ENODATA ? 0 : ret;

Add a comment here explaining that no data came in, and that's ok :)
Otherwise you'll have someone staring at it for 5 mins unnecessarily

> +}
> +
>  static void perf_link_event(void *ctx)
>  {
>         struct perf_ctx *perf = ctx;
> +       struct perf_peer *peer;
> +       bool lnk_up;
> +       int pidx;
>
> -       if (ntb_link_is_up(perf->ntb, NULL, NULL) == 1) {
> -               schedule_delayed_work(&perf->link_work, 2*HZ);
> -       } else {
> -               dev_dbg(&perf->ntb->pdev->dev, "link down\n");
> +       for (pidx = 0; pidx < perf->pcnt; pidx++) {
> +               peer = &perf->peers[pidx];
>
> -               if (!perf->link_is_up)
> -                       cancel_delayed_work_sync(&perf->link_work);
> +               lnk_up = perf_link_is_up(peer);
>
> -               perf->link_is_up = false;
> +               if (lnk_up &&
> +                   !test_and_set_bit(PERF_STS_LNKUP, &peer->sts)) {
> +                       perf_cmd_exec(peer, PERF_CMD_SSIZE);
> +               } else if (!lnk_up &&
> +                          test_and_clear_bit(PERF_STS_LNKUP, &peer->sts)) {
> +                       perf_cmd_exec(peer, PERF_CMD_CLEAR);
> +               }
>         }
>  }
>
>  static void perf_db_event(void *ctx, int vec)
>  {
>         struct perf_ctx *perf = ctx;
> -       u64 db_bits, db_mask;
>
> -       db_mask = ntb_db_vector_mask(perf->ntb, vec);
> -       db_bits = ntb_db_read(perf->ntb);
> +       dev_dbg(&perf->ntb->dev, "DB vec %d mask %#llx bits %#llx\n", vec,
> +               ntb_db_vector_mask(perf->ntb, vec), ntb_db_read(perf->ntb));
>
> -       dev_dbg(&perf->ntb->dev, "doorbell vec %d mask %#llx bits %#llx\n",
> -               vec, db_mask, db_bits);
> +       /* Just receive all available commands */
> +       (void)perf_cmd_recv(perf);

Is this throwing an error if not cast?  If so, can't we just make this
a return type of void?
Same for all casts below too

> +}
> +
> +static void perf_msg_event(void *ctx)
> +{
> +       struct perf_ctx *perf = ctx;
> +
> +       dev_dbg(&perf->ntb->dev, "Msg status bits %#llx\n",
> +               ntb_msg_read_sts(perf->ntb));
> +
> +       /* Messages are only sent one-by-one */
> +       (void)perf_cmd_recv(perf);
>  }
>
>  static const struct ntb_ctx_ops perf_ops = {
>         .link_event = perf_link_event,
>         .db_event = perf_db_event,
> +       .msg_event = perf_msg_event
>  };
>
> -static void perf_copy_callback(void *data)
> +static void perf_free_outbuf(struct perf_peer *peer)
> +{
> +       (void)ntb_peer_mw_clear_trans(peer->perf->ntb, peer->pidx, peer->gidx);
> +}
> +
> +static int perf_setup_outbuf(struct perf_peer *peer)
>  {
> -       struct pthr_ctx *pctx = data;
> +       struct perf_ctx *perf = peer->perf;
> +       int ret;
> +
> +       /* Outbuf size can be unaligned due to custom max_mw_size */
> +       ret = ntb_peer_mw_set_trans(perf->ntb, peer->pidx, peer->gidx,
> +                                   peer->outbuf_xlat, peer->outbuf_size);
> +       if (ret) {
> +               dev_err(&perf->ntb->dev, "Failed to set outbuf translation\n");
> +               return ret;
> +       }
> +
> +       /* Initialization is finally done */
> +       set_bit(PERF_STS_DONE, &peer->sts);
>
> -       atomic_dec(&pctx->dma_sync);
> +       return 0;
>  }
>
> -static ssize_t perf_copy(struct pthr_ctx *pctx, char __iomem *dst,
> -                        char *src, size_t size)
> +static void perf_free_inbuf(struct perf_peer *peer)
>  {
> -       struct perf_ctx *perf = pctx->perf;
> -       struct dma_async_tx_descriptor *txd;
> -       struct dma_chan *chan = pctx->dma_chan;
> -       struct dma_device *device;
> -       struct dmaengine_unmap_data *unmap;
> -       dma_cookie_t cookie;
> -       size_t src_off, dst_off;
> -       struct perf_mw *mw = &perf->mw;
> -       void __iomem *vbase;
> -       void __iomem *dst_vaddr;
> -       dma_addr_t dst_phys;
> -       int retries = 0;
> +       if (!peer->inbuf)
> +               return;
>
> -       if (!use_dma) {
> -               memcpy_toio(dst, src, size);
> -               return size;
> +       (void)ntb_mw_clear_trans(peer->perf->ntb, peer->pidx, peer->gidx);
> +       dma_free_coherent(&peer->perf->ntb->dev, peer->inbuf_size,
> +                         peer->inbuf, peer->inbuf_xlat);
> +       peer->inbuf = NULL;
> +}
> +
> +static int perf_setup_inbuf(struct perf_peer *peer)
> +{
> +       resource_size_t xlat_align, size_align, size_max;
> +       struct perf_ctx *perf = peer->perf;
> +       int ret;
> +
> +       /* Get inbound MW parameters */
> +       ret = ntb_mw_get_align(perf->ntb, peer->pidx, perf->gidx,
> +                              &xlat_align, &size_align, &size_max);
> +       if (ret) {
> +               dev_err(&perf->ntb->dev, "Couldn't get inbuf restrictions\n");
> +               return ret;
>         }
>
> -       if (!chan) {
> -               dev_err(&perf->ntb->dev, "DMA engine does not exist\n");
> +       if (peer->inbuf_size > size_max) {
> +               dev_err(&perf->ntb->dev, "Too big inbuf size %pa > %pa\n",
> +                       &peer->inbuf_size, &size_max);
>                 return -EINVAL;
>         }
>
> -       device = chan->device;
> -       src_off = (uintptr_t)src & ~PAGE_MASK;
> -       dst_off = (uintptr_t __force)dst & ~PAGE_MASK;
> +       peer->inbuf_size = round_up(peer->inbuf_size, size_align);
>
> -       if (!is_dma_copy_aligned(device, src_off, dst_off, size))
> -               return -ENODEV;
> -
> -       vbase = mw->vbase;
> -       dst_vaddr = dst;
> -       dst_phys = mw->phys_addr + (dst_vaddr - vbase);
> +       perf_free_inbuf(peer);
>
> -       unmap = dmaengine_get_unmap_data(device->dev, 1, GFP_NOWAIT);
> -       if (!unmap)
> +       peer->inbuf = dma_alloc_coherent(&perf->ntb->dev, peer->inbuf_size,
> +                                        &peer->inbuf_xlat, GFP_KERNEL);
> +       if (!peer->inbuf) {
> +               dev_err(&perf->ntb->dev, "Failed to alloc inbuf of %pa\n",
> +                       &peer->inbuf_size);
>                 return -ENOMEM;
> +       }
> +       if (!IS_ALIGNED(peer->inbuf_xlat, xlat_align)) {
> +               dev_err(&perf->ntb->dev, "Unaligned inbuf allocated\n");
> +               goto err_free_inbuf;
> +       }
>
> -       unmap->len = size;
> -       unmap->addr[0] = dma_map_page(device->dev, virt_to_page(src),
> -                                     src_off, size, DMA_TO_DEVICE);
> -       if (dma_mapping_error(device->dev, unmap->addr[0]))
> -               goto err_get_unmap;
> +       ret = ntb_mw_set_trans(perf->ntb, peer->pidx, peer->gidx,
> +                              peer->inbuf_xlat, peer->inbuf_size);
> +       if (ret) {
> +               dev_err(&perf->ntb->dev, "Failed to set inbuf translation\n");
> +               goto err_free_inbuf;
> +       }
>
> -       unmap->to_cnt = 1;
> +       /*
> +        * We submit inbuf xlat transmission cmd for execution here to follow
> +        * the code architecture, even though this method is called from service
> +        * work itself so the command will be executed right after it returns.
> +        */
> +       (void)perf_cmd_exec(peer, PERF_CMD_SXLAT);
>
> -       do {
> -               txd = device->device_prep_dma_memcpy(chan, dst_phys,
> -                                                    unmap->addr[0],
> -                                                    size, DMA_PREP_INTERRUPT);
> -               if (!txd) {
> -                       set_current_state(TASK_INTERRUPTIBLE);
> -                       schedule_timeout(DMA_OUT_RESOURCE_TO);
> -               }
> -       } while (!txd && (++retries < DMA_RETRIES));
> +       return 0;
>
> -       if (!txd) {
> -               pctx->dma_prep_err++;
> -               goto err_get_unmap;
> -       }
> +err_free_inbuf:
> +       perf_free_inbuf(peer);
>
> -       txd->callback = perf_copy_callback;
> -       txd->callback_param = pctx;
> -       dma_set_unmap(txd, unmap);
> +       return ret;
> +}
>
> -       cookie = dmaengine_submit(txd);
> -       if (dma_submit_error(cookie))
> -               goto err_set_unmap;
> +static void perf_service_work(struct work_struct *work)
> +{
> +       struct perf_peer *peer = to_peer_service(work);
>
> -       dmaengine_unmap_put(unmap);
> +       if (test_and_clear_bit(PERF_CMD_SSIZE, &peer->sts))
> +               perf_cmd_send(peer, PERF_CMD_SSIZE, peer->outbuf_size);
>
> -       atomic_inc(&pctx->dma_sync);
> -       dma_async_issue_pending(chan);
> +       if (test_and_clear_bit(PERF_CMD_RSIZE, &peer->sts))
> +               perf_setup_inbuf(peer);
>
> -       return size;
> +       if (test_and_clear_bit(PERF_CMD_SXLAT, &peer->sts))
> +               perf_cmd_send(peer, PERF_CMD_SXLAT, peer->inbuf_xlat);
>
> -err_set_unmap:
> -       dmaengine_unmap_put(unmap);
> -err_get_unmap:
> -       dmaengine_unmap_put(unmap);
> -       return 0;
> -}
> +       if (test_and_clear_bit(PERF_CMD_RXLAT, &peer->sts))
> +               perf_setup_outbuf(peer);
>
> -static int perf_move_data(struct pthr_ctx *pctx, char __iomem *dst, char *src,
> -                         u64 buf_size, u64 win_size, u64 total)
> -{
> -       int chunks, total_chunks, i;
> -       int copied_chunks = 0;
> -       u64 copied = 0, result;
> -       char __iomem *tmp = dst;
> -       u64 perf, diff_us;
> -       ktime_t kstart, kstop, kdiff;
> -       unsigned long last_sleep = jiffies;
> -
> -       chunks = div64_u64(win_size, buf_size);
> -       total_chunks = div64_u64(total, buf_size);
> -       kstart = ktime_get();
> -
> -       for (i = 0; i < total_chunks; i++) {
> -               result = perf_copy(pctx, tmp, src, buf_size);
> -               copied += result;
> -               copied_chunks++;
> -               if (copied_chunks == chunks) {
> -                       tmp = dst;
> -                       copied_chunks = 0;
> -               } else
> -                       tmp += buf_size;
> -
> -               /* Probably should schedule every 5s to prevent soft hang. */
> -               if (unlikely((jiffies - last_sleep) > 5 * HZ)) {
> -                       last_sleep = jiffies;
> -                       set_current_state(TASK_INTERRUPTIBLE);
> -                       schedule_timeout(1);
> +       if (test_and_clear_bit(PERF_CMD_CLEAR, &peer->sts)) {
> +               clear_bit(PERF_STS_DONE, &peer->sts);
> +               if (test_bit(0, &peer->perf->busy_flag) &&
> +                   peer == peer->perf->test_peer) {
> +                       dev_warn(&peer->perf->ntb->dev,
> +                               "Freeing while test on-fly\n");
> +                       perf_terminate_test(peer->perf);
>                 }
> +               perf_free_outbuf(peer);
> +               perf_free_inbuf(peer);
> +       }
> +}
>
> -               if (unlikely(kthread_should_stop()))
> -                       break;
> +static int perf_init_service(struct perf_ctx *perf)
> +{
> +       u64 mask;
> +
> +       if (ntb_peer_mw_count(perf->ntb) < perf->pcnt + 1) {
> +               dev_err(&perf->ntb->dev, "Not enough memory windows\n");
> +               return -EINVAL;
>         }
>
> -       if (use_dma) {
> -               pr_debug("%s: All DMA descriptors submitted\n", current->comm);
> -               while (atomic_read(&pctx->dma_sync) != 0) {
> -                       if (kthread_should_stop())
> -                               break;
> -                       msleep(20);
> -               }
> +       if (ntb_msg_count(perf->ntb) >= PERF_MSG_CNT) {
> +               perf->cmd_send = perf_msg_cmd_send;
> +               perf->cmd_recv = perf_msg_cmd_recv;
> +
> +               dev_dbg(&perf->ntb->dev, "Message service initialized\n");
> +
> +               return 0;
>         }
>
> -       kstop = ktime_get();
> -       kdiff = ktime_sub(kstop, kstart);
> -       diff_us = ktime_to_us(kdiff);
> +       dev_dbg(&perf->ntb->dev, "Message service unsupported\n");
>
> -       pr_debug("%s: copied %llu bytes\n", current->comm, copied);
> +       mask = GENMASK_ULL(perf->pcnt, 0);
> +       if (ntb_spad_count(perf->ntb) >= PERF_SPAD_CNT(perf->pcnt) &&
> +           (ntb_db_valid_mask(perf->ntb) & mask) == mask) {
> +               perf->cmd_send = perf_spad_cmd_send;
> +               perf->cmd_recv = perf_spad_cmd_recv;
>
> -       pr_debug("%s: lasted %llu usecs\n", current->comm, diff_us);
> +               dev_dbg(&perf->ntb->dev, "Scratchpad service initialized\n");
>
> -       perf = div64_u64(copied, diff_us);
> +               return 0;
> +       }
>
> -       pr_debug("%s: MBytes/s: %llu\n", current->comm, perf);
> +       dev_dbg(&perf->ntb->dev, "Scratchpad service unsupported\n");
>
> -       pctx->copied = copied;
> -       pctx->diff_us = diff_us;
> +       dev_err(&perf->ntb->dev, "Command services unsupported\n");
>
> -       return 0;
> +       return -EINVAL;
>  }
>
> -static bool perf_dma_filter_fn(struct dma_chan *chan, void *node)
> +static int perf_enable_service(struct perf_ctx *perf)
>  {
> -       /* Is the channel required to be on the same node as the device? */
> -       if (!on_node)
> -               return true;
> +       u64 mask, incmd_bit;
> +       int ret, sidx, scnt;
>
> -       return dev_to_node(&chan->dev->device) == (int)(unsigned long)node;
> -}
> +       mask = ntb_db_valid_mask(perf->ntb);
> +       (void)ntb_db_set_mask(perf->ntb, mask);
>
> -static int ntb_perf_thread(void *data)
> -{
> -       struct pthr_ctx *pctx = data;
> -       struct perf_ctx *perf = pctx->perf;
> -       struct pci_dev *pdev = perf->ntb->pdev;
> -       struct perf_mw *mw = &perf->mw;
> -       char __iomem *dst;
> -       u64 win_size, buf_size, total;
> -       void *src;
> -       int rc, node, i;
> -       struct dma_chan *dma_chan = NULL;
> +       ret = ntb_set_ctx(perf->ntb, perf, &perf_ops);
> +       if (ret)
> +               return ret;
>
> -       pr_debug("kthread %s starting...\n", current->comm);
> +       if (perf->cmd_send == perf_msg_cmd_send) {
> +               u64 inbits, outbits;
>
> -       node = on_node ? dev_to_node(&pdev->dev) : NUMA_NO_NODE;
> +               inbits = ntb_msg_inbits(perf->ntb);
> +               outbits = ntb_msg_outbits(perf->ntb);
> +               (void)ntb_msg_set_mask(perf->ntb, inbits | outbits);
>
> -       if (use_dma && !pctx->dma_chan) {
> -               dma_cap_mask_t dma_mask;
> +               incmd_bit = BIT_ULL(__ffs64(inbits));
> +               ret = ntb_msg_clear_mask(perf->ntb, incmd_bit);
>
> -               dma_cap_zero(dma_mask);
> -               dma_cap_set(DMA_MEMCPY, dma_mask);
> -               dma_chan = dma_request_channel(dma_mask, perf_dma_filter_fn,
> -                                              (void *)(unsigned long)node);
> -               if (!dma_chan) {
> -                       pr_warn("%s: cannot acquire DMA channel, quitting\n",
> -                               current->comm);
> -                       return -ENODEV;
> -               }
> -               pctx->dma_chan = dma_chan;
> +               dev_dbg(&perf->ntb->dev, "MSG sts unmasked %#llx\n", incmd_bit);
> +       } else {
> +               scnt = ntb_spad_count(perf->ntb);
> +               for (sidx = 0; sidx < scnt; sidx++)
> +                       ntb_spad_write(perf->ntb, sidx, PERF_CMD_INVAL);
> +               incmd_bit = PERF_SPAD_NOTIFY(perf->gidx);
> +               ret = ntb_db_clear_mask(perf->ntb, incmd_bit);
> +
> +               dev_dbg(&perf->ntb->dev, "DB bits unmasked %#llx\n", incmd_bit);
> +       }
> +       if (ret) {
> +               ntb_clear_ctx(perf->ntb);
> +               return ret;
>         }
>
> -       for (i = 0; i < MAX_SRCS; i++) {
> -               pctx->srcs[i] = kmalloc_node(MAX_TEST_SIZE, GFP_KERNEL, node);
> -               if (!pctx->srcs[i]) {
> -                       rc = -ENOMEM;
> -                       goto err;
> -               }
> +       ntb_link_enable(perf->ntb, NTB_SPEED_AUTO, NTB_WIDTH_AUTO);
> +       /* Might be not necessary */
> +       ntb_link_event(perf->ntb);
> +
> +       return 0;
> +}
> +
> +static void perf_disable_service(struct perf_ctx *perf)
> +{
> +       int pidx;
> +
> +       ntb_link_disable(perf->ntb);
> +
> +       if (perf->cmd_send == perf_msg_cmd_send) {
> +               u64 inbits;
> +
> +               inbits = ntb_msg_inbits(perf->ntb);
> +               (void)ntb_msg_set_mask(perf->ntb, inbits);
> +       } else {
> +               (void)ntb_db_set_mask(perf->ntb, PERF_SPAD_NOTIFY(perf->gidx));
>         }
>
> -       win_size = mw->phys_size;
> -       buf_size = 1ULL << seg_order;
> -       total = 1ULL << run_order;
> +       ntb_clear_ctx(perf->ntb);
>
> -       if (buf_size > MAX_TEST_SIZE)
> -               buf_size = MAX_TEST_SIZE;
> +       for (pidx = 0; pidx < perf->pcnt; pidx++)
> +               perf_cmd_exec(&perf->peers[pidx], PERF_CMD_CLEAR);
>
> -       dst = (char __iomem *)mw->vbase;
> +       for (pidx = 0; pidx < perf->pcnt; pidx++)
> +               flush_work(&perf->peers[pidx].service);
> +}
>
> -       atomic_inc(&perf->tsync);
> -       while (atomic_read(&perf->tsync) != perf->perf_threads)
> -               schedule();
> +/*==============================================================================
> + *                      Performance measuring work-thread
> + *==============================================================================
> + */
>
> -       src = pctx->srcs[pctx->src_idx];
> -       pctx->src_idx = (pctx->src_idx + 1) & (MAX_SRCS - 1);
> +static void perf_dma_copy_callback(void *data)
> +{
> +       struct perf_thread *pthr = data;
>
> -       rc = perf_move_data(pctx, dst, src, buf_size, win_size, total);
> +       atomic_dec(&pthr->dma_sync);
> +       wake_up(&pthr->dma_wait);
> +}
>
> -       atomic_dec(&perf->tsync);
> +static int perf_copy_chunk(struct perf_thread *pthr,
> +                          void __iomem *dst, void *src, size_t len)
> +{
> +       struct dma_async_tx_descriptor *tx;
> +       struct dmaengine_unmap_data *unmap;
> +       struct device *dma_dev;
> +       int try, ret = 0;
>
> -       if (rc < 0) {
> -               pr_err("%s: failed\n", current->comm);
> -               rc = -ENXIO;
> -               goto err;
> +       if (!use_dma) {
> +               memcpy_toio(dst, src, len);
> +               goto ret_check_tsync;
>         }
>
> -       for (i = 0; i < MAX_SRCS; i++) {
> -               kfree(pctx->srcs[i]);
> -               pctx->srcs[i] = NULL;
> +       dma_dev = pthr->dma_chan->device->dev;
> +
> +       if (!is_dma_copy_aligned(pthr->dma_chan->device, offset_in_page(src),
> +                                offset_in_page(dst), len))
> +               return -EIO;
> +
> +       unmap = dmaengine_get_unmap_data(dma_dev, 2, GFP_NOWAIT);
> +       if (!unmap)
> +               return -ENOMEM;
> +
> +       unmap->len = len;
> +       unmap->addr[0] = dma_map_page(dma_dev, virt_to_page(src),
> +               offset_in_page(src), len, DMA_TO_DEVICE);
> +       if (dma_mapping_error(dma_dev, unmap->addr[0])) {
> +               ret = -EIO;
> +               goto err_free_resource;
>         }
> +       unmap->to_cnt = 1;
>
> -       atomic_inc(&perf->tdone);
> -       wake_up(pctx->wq);
> -       rc = 0;
> -       goto done;
> +       unmap->addr[1] = dma_map_page(dma_dev, virt_to_page(dst),
> +               offset_in_page(dst), len, DMA_FROM_DEVICE);
> +       if (dma_mapping_error(dma_dev, unmap->addr[1])) {
> +               ret = -EIO;
> +               goto err_free_resource;
> +       }
> +       unmap->from_cnt = 1;
>
> -err:
> -       for (i = 0; i < MAX_SRCS; i++) {
> -               kfree(pctx->srcs[i]);
> -               pctx->srcs[i] = NULL;
> +       do {
> +               tx = dmaengine_prep_dma_memcpy(pthr->dma_chan, unmap->addr[1],
> +                       unmap->addr[0], len, DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
> +               if (!tx)
> +                       msleep(DMA_MDELAY);
> +       } while (!tx && (try++ < DMA_TRIES));
> +
> +       if (!tx) {
> +               ret = -EIO;
> +               goto err_free_resource;
>         }
>
> -       if (dma_chan) {
> -               dma_release_channel(dma_chan);
> -               pctx->dma_chan = NULL;
> +       tx->callback = perf_dma_copy_callback;
> +       tx->callback_param = pthr;
> +       dma_set_unmap(tx, unmap);
> +
> +       if (dma_submit_error(dmaengine_submit(tx))) {
> +               dmaengine_unmap_put(unmap);
> +               goto err_free_resource;
>         }
>
> -done:
> -       /* Wait until we are told to stop */
> -       for (;;) {
> -               set_current_state(TASK_INTERRUPTIBLE);
> -               if (kthread_should_stop())
> -                       break;
> -               schedule();
> +       dmaengine_unmap_put(unmap);
> +
> +       atomic_inc(&pthr->dma_sync);
> +       dma_async_issue_pending(pthr->dma_chan);
> +
> +ret_check_tsync:
> +       return likely(atomic_read(&pthr->perf->tsync) > 0) ? 0 : -EINTR;
> +
> +err_free_resource:
> +       dmaengine_unmap_put(unmap);
> +
> +       return ret;
> +}
> +
> +static bool perf_dma_filter(struct dma_chan *chan, void *data)
> +{
> +       struct perf_ctx *perf = data;
> +       int node;
> +
> +       node = dev_to_node(&perf->ntb->dev);
> +
> +       return node == NUMA_NO_NODE || node == dev_to_node(chan->device->dev);
> +}
> +
> +static int perf_init_test(struct perf_thread *pthr)
> +{
> +       struct perf_ctx *perf = pthr->perf;
> +       dma_cap_mask_t dma_mask;
> +
> +       pthr->src = kmalloc_node(perf->test_peer->outbuf_size, GFP_KERNEL,
> +                                dev_to_node(&perf->ntb->dev));
> +       if (!pthr->src)
> +               return -ENOMEM;
> +
> +       get_random_bytes(pthr->src, perf->test_peer->outbuf_size);
> +
> +       if (!use_dma)
> +               return 0;
> +
> +       dma_cap_zero(dma_mask);
> +       dma_cap_set(DMA_MEMCPY, dma_mask);
> +       pthr->dma_chan = dma_request_channel(dma_mask, perf_dma_filter, perf);
> +       if (!pthr->dma_chan) {
> +               dev_err(&perf->ntb->dev, "%d: Failed to get DMA channel\n",
> +                       pthr->tidx);
> +               atomic_dec(&perf->tsync);
> +               wake_up(&perf->twait);
> +               kfree(pthr->src);
> +               return -ENODEV;
>         }
> -       __set_current_state(TASK_RUNNING);
>
> -       return rc;
> +       atomic_set(&pthr->dma_sync, 0);
> +
> +       return 0;
>  }
>
> -static void perf_free_mw(struct perf_ctx *perf)
> +static int perf_run_test(struct perf_thread *pthr)
>  {
> -       struct perf_mw *mw = &perf->mw;
> -       struct pci_dev *pdev = perf->ntb->pdev;
> +       struct perf_peer *peer = pthr->perf->test_peer;
> +       struct perf_ctx *perf = pthr->perf;
> +       void __iomem *flt_dst, *bnd_dst;
> +       u64 total_size, chunk_size;
> +       void *flt_src;
> +       int ret = 0;
> +
> +       total_size = 1ULL << total_order;
> +       chunk_size = 1ULL << chunk_order;
> +       chunk_size = min_t(u64, peer->outbuf_size, chunk_size);
> +
> +       flt_src = pthr->src;
> +       bnd_dst = peer->outbuf + peer->outbuf_size;
> +       flt_dst = peer->outbuf;
> +
> +       pthr->duration = ktime_get();
> +
> +       /* Copied field is cleared on test launch stage */
> +       while (pthr->copied < total_size) {
> +               ret = perf_copy_chunk(pthr, flt_dst, flt_src, chunk_size);
> +               if (ret) {
> +                       dev_err(&perf->ntb->dev, "%d: Got error %d on test\n",
> +                               pthr->tidx, ret);
> +                       return ret;
> +               }
>
> -       if (!mw->virt_addr)
> -               return;
> +               pthr->copied += chunk_size;
>
> -       ntb_mw_clear_trans(perf->ntb, PIDX, 0);
> -       dma_free_coherent(&pdev->dev, mw->buf_size,
> -                         mw->virt_addr, mw->dma_addr);
> -       mw->xlat_size = 0;
> -       mw->buf_size = 0;
> -       mw->virt_addr = NULL;
> +               flt_dst += chunk_size;
> +               flt_src += chunk_size;
> +               if (flt_dst >= bnd_dst || flt_dst < peer->outbuf) {
> +                       flt_dst = peer->outbuf;
> +                       flt_src = pthr->src;
> +               }
> +
> +               /* Give up CPU to give a chance for other threads to use it */
> +               schedule();
> +       }
> +
> +       return 0;
>  }
>
> -static int perf_set_mw(struct perf_ctx *perf, resource_size_t size)
> +static int perf_sync_test(struct perf_thread *pthr)
>  {
> -       struct perf_mw *mw = &perf->mw;
> -       size_t xlat_size, buf_size;
> -       resource_size_t xlat_align;
> -       resource_size_t xlat_align_size;
> -       int rc;
> +       struct perf_ctx *perf = pthr->perf;
>
> -       if (!size)
> -               return -EINVAL;
> +       if (!use_dma)
> +               goto no_dma_ret;
>
> -       rc = ntb_mw_get_align(perf->ntb, PIDX, 0, &xlat_align,
> -                             &xlat_align_size, NULL);
> -       if (rc)
> -               return rc;
> +       wait_event(pthr->dma_wait,
> +                  (atomic_read(&pthr->dma_sync) == 0 ||
> +                   atomic_read(&perf->tsync) < 0));
>
> -       xlat_size = round_up(size, xlat_align_size);
> -       buf_size = round_up(size, xlat_align);
> +       if (atomic_read(&perf->tsync) < 0)
> +               return -EINTR;
>
> -       if (mw->xlat_size == xlat_size)
> -               return 0;
> +no_dma_ret:
> +       pthr->duration = ktime_sub(ktime_get(), pthr->duration);
> +
> +       dev_dbg(&perf->ntb->dev, "%d: copied %llu bytes\n",
> +               pthr->tidx, pthr->copied);
>
> -       if (mw->buf_size)
> -               perf_free_mw(perf);
> +       dev_dbg(&perf->ntb->dev, "%d: lasted %llu usecs\n",
> +               pthr->tidx, ktime_to_us(pthr->duration));
>
> -       mw->xlat_size = xlat_size;
> -       mw->buf_size = buf_size;
> +       dev_dbg(&perf->ntb->dev, "%d: %llu MBytes/s\n", pthr->tidx,
> +               div64_u64(pthr->copied, ktime_to_us(pthr->duration)));
>
> -       mw->virt_addr = dma_alloc_coherent(&perf->ntb->pdev->dev, buf_size,
> -                                          &mw->dma_addr, GFP_KERNEL);
> -       if (!mw->virt_addr) {
> -               mw->xlat_size = 0;
> -               mw->buf_size = 0;
> +       return 0;
> +}
> +
> +static void perf_clear_test(struct perf_thread *pthr)
> +{
> +       struct perf_ctx *perf = pthr->perf;
> +
> +       if (!use_dma)
> +               goto no_dma_notify;
> +
> +       /*
> +        * If test finished without errors, termination isn't needed.
> +        * We call it anyway just to be sure of the transfers completion.
> +        */
> +       (void)dmaengine_terminate_sync(pthr->dma_chan);
> +
> +       dma_release_channel(pthr->dma_chan);
> +
> +no_dma_notify:
> +       atomic_dec(&perf->tsync);
> +       wake_up(&perf->twait);
> +       kfree(pthr->src);
> +}
> +
> +static void perf_thread_work(struct work_struct *work)
> +{
> +       struct perf_thread *pthr = to_thread_work(work);
> +       int ret;
> +
> +       /*
> +        * Perform stages in compliance with use_dma flag value.
> +        * Test status is changed only if error happened, otherwise
> +        * status -ENODATA is kept while test is on-fly. Results
> +        * synchronization is performed only if test fininshed
> +        * without an error or interruption.
> +        */
> +       ret = perf_init_test(pthr);
> +       if (ret) {
> +               pthr->status = ret;
> +               return;
>         }
>
> -       rc = ntb_mw_set_trans(perf->ntb, PIDX, 0, mw->dma_addr, mw->xlat_size);
> -       if (rc) {
> -               dev_err(&perf->ntb->dev, "Unable to set mw0 translation\n");
> -               perf_free_mw(perf);
> -               return -EIO;
> +       ret = perf_run_test(pthr);
> +       if (ret) {
> +               pthr->status = ret;
> +               goto err_clear_test;
>         }
>
> -       return 0;
> +       pthr->status = perf_sync_test(pthr);
> +
> +err_clear_test:
> +       perf_clear_test(pthr);
>  }
>
> -static void perf_link_work(struct work_struct *work)
> +static int perf_set_tcnt(struct perf_ctx *perf, u8 tcnt)
>  {
> -       struct perf_ctx *perf =
> -               container_of(work, struct perf_ctx, link_work.work);
> -       struct ntb_dev *ndev = perf->ntb;
> -       struct pci_dev *pdev = ndev->pdev;
> -       u32 val;
> -       u64 size;
> -       int rc;
> +       if (tcnt == 0 || tcnt > MAX_THREADS_CNT)
> +               return -EINVAL;
>
> -       dev_dbg(&perf->ntb->pdev->dev, "%s called\n", __func__);
> +       if (test_and_set_bit_lock(0, &perf->busy_flag))
> +               return -EBUSY;
>
> -       size = perf->mw.phys_size;
> +       perf->tcnt = tcnt;
>
> -       if (max_mw_size && size > max_mw_size)
> -               size = max_mw_size;
> +       clear_bit_unlock(0, &perf->busy_flag);
>
> -       ntb_peer_spad_write(ndev, PIDX, MW_SZ_HIGH, upper_32_bits(size));
> -       ntb_peer_spad_write(ndev, PIDX, MW_SZ_LOW, lower_32_bits(size));
> -       ntb_peer_spad_write(ndev, PIDX, VERSION, PERF_VERSION);
> +       return 0;
> +}
> +
> +static void perf_terminate_test(struct perf_ctx *perf)
> +{
> +       int tidx;
> +
> +       atomic_set(&perf->tsync, -1);
> +       wake_up(&perf->twait);
>
> -       /* now read what peer wrote */
> -       val = ntb_spad_read(ndev, VERSION);
> -       if (val != PERF_VERSION) {
> -               dev_dbg(&pdev->dev, "Remote version = %#x\n", val);
> -               goto out;
> +       for (tidx = 0; tidx < MAX_THREADS_CNT; tidx++) {
> +               wake_up(&perf->threads[tidx].dma_wait);
> +               cancel_work_sync(&perf->threads[tidx].work);
>         }
> +}
>
> -       val = ntb_spad_read(ndev, MW_SZ_HIGH);
> -       size = (u64)val << 32;
> +static int perf_submit_test(struct perf_peer *peer)
> +{
> +       struct perf_ctx *perf = peer->perf;
> +       struct perf_thread *pthr;
> +       int tidx, ret;
> +
> +       if (!test_bit(PERF_STS_DONE, &peer->sts))
> +               return -ENOLINK;
>
> -       val = ntb_spad_read(ndev, MW_SZ_LOW);
> -       size |= val;
> +       if (test_and_set_bit_lock(0, &perf->busy_flag))
> +               return -EBUSY;
>
> -       dev_dbg(&pdev->dev, "Remote MW size = %#llx\n", size);
> +       perf->test_peer = peer;
> +       atomic_set(&perf->tsync, perf->tcnt);
>
> -       rc = perf_set_mw(perf, size);
> -       if (rc)
> -               goto out1;
> +       for (tidx = 0; tidx < MAX_THREADS_CNT; tidx++) {
> +               pthr = &perf->threads[tidx];
>
> -       perf->link_is_up = true;
> -       wake_up(&perf->link_wq);
> +               pthr->status = -ENODATA;
> +               pthr->copied = 0;
> +               pthr->duration = ktime_set(0, 0);
> +               if (tidx < perf->tcnt)
> +                       (void)queue_work(perf_wq, &pthr->work);
> +       }
>
> -       return;
> +       ret = wait_event_interruptible(perf->twait,
> +                                      atomic_read(&perf->tsync) <= 0);
> +       if (ret == -ERESTARTSYS) {
> +               perf_terminate_test(perf);
> +               ret = -EINTR;
> +       }
>
> -out1:
> -       perf_free_mw(perf);
> +       clear_bit_unlock(0, &perf->busy_flag);
>
> -out:
> -       if (ntb_link_is_up(ndev, NULL, NULL) == 1)
> -               schedule_delayed_work(&perf->link_work,
> -                                     msecs_to_jiffies(PERF_LINK_DOWN_TIMEOUT));
> +       return ret;
>  }
>
> -static int perf_setup_mw(struct ntb_dev *ntb, struct perf_ctx *perf)
> +static int perf_read_stats(struct perf_ctx *perf, char *buf,
> +                          size_t size, ssize_t *pos)
>  {
> -       struct perf_mw *mw;
> -       int rc;
> +       struct perf_thread *pthr;
> +       int tidx;
>
> -       mw = &perf->mw;
> +       if (test_and_set_bit_lock(0, &perf->busy_flag))
> +               return -EBUSY;
>
> -       rc = ntb_peer_mw_get_addr(ntb, 0, &mw->phys_addr, &mw->phys_size);
> -       if (rc)
> -               return rc;
> +       (*pos) += scnprintf(buf + *pos, size - *pos,
> +               "    Peer %d test statistics:\n", perf->test_peer->pidx);
>
> -       perf->mw.vbase = ioremap_wc(mw->phys_addr, mw->phys_size);
> -       if (!mw->vbase)
> -               return -ENOMEM;
> +       for (tidx = 0; tidx < MAX_THREADS_CNT; tidx++) {
> +               pthr = &perf->threads[tidx];
> +
> +               if (pthr->status == -ENODATA)
> +                       continue;
> +
> +               if (pthr->status) {
> +                       (*pos) += scnprintf(buf + *pos, size - *pos,
> +                               "%d: error status %d\n", tidx, pthr->status);
> +                       continue;
> +               }
> +
> +               (*pos) += scnprintf(buf + *pos, size - *pos,
> +                       "%d: copied %llu bytes in %llu usecs, %llu MBytes/s\n",
> +                       tidx, pthr->copied, ktime_to_us(pthr->duration),
> +                       div64_u64(pthr->copied, ktime_to_us(pthr->duration)));
> +       }
> +
> +       clear_bit_unlock(0, &perf->busy_flag);
>
>         return 0;
>  }
>
> -static ssize_t debugfs_run_read(struct file *filp, char __user *ubuf,
> -                               size_t count, loff_t *offp)
> +static void perf_init_threads(struct perf_ctx *perf)
> +{
> +       struct perf_thread *pthr;
> +       int tidx;
> +
> +       perf->tcnt = DEF_THREADS_CNT;
> +       perf->test_peer = &perf->peers[0];
> +       init_waitqueue_head(&perf->twait);
> +
> +       for (tidx = 0; tidx < MAX_THREADS_CNT; tidx++) {
> +               pthr = &perf->threads[tidx];
> +
> +               pthr->perf = perf;
> +               pthr->tidx = tidx;
> +               pthr->status = -ENODATA;
> +               init_waitqueue_head(&pthr->dma_wait);
> +               INIT_WORK(&pthr->work, perf_thread_work);
> +       }
> +}
> +
> +static void perf_clear_threads(struct perf_ctx *perf)
>  {
> -       struct perf_ctx *perf = filp->private_data;
> +       perf_terminate_test(perf);
> +}
> +
> +/*==============================================================================
> + *                               DebugFS nodes
> + *==============================================================================
> + */
> +
> +static ssize_t perf_dbgfs_read_info(struct file *filep, char __user *ubuf,
> +                                   size_t size, loff_t *offp)
> +{
> +       struct perf_ctx *perf = filep->private_data;
> +       struct perf_peer *peer;
> +       size_t buf_size;
> +       ssize_t pos = 0;
> +       int ret, pidx;
>         char *buf;
> -       ssize_t ret, out_off = 0;
> -       struct pthr_ctx *pctx;
> -       int i;
> -       u64 rate;
>
> -       if (!perf)
> -               return 0;
> +       buf_size = min_t(size_t, size, 0x1000U);
>
> -       buf = kmalloc(1024, GFP_KERNEL);
> +       buf = kmalloc(buf_size, GFP_KERNEL);
>         if (!buf)
>                 return -ENOMEM;
>
> -       if (mutex_is_locked(&perf->run_mutex)) {
> -               out_off = scnprintf(buf, 64, "running\n");
> -               goto read_from_buf;
> +       pos += scnprintf(buf + pos, buf_size - pos,
> +               "    Performance measuring tool info:\n\n");
> +
> +       pos += scnprintf(buf + pos, buf_size - pos,
> +               "Local port %d, Global index %d\n", ntb_port_number(perf->ntb),
> +               perf->gidx);
> +       pos += scnprintf(buf + pos, buf_size - pos, "Test status: ");
> +       if (test_bit(0, &perf->busy_flag)) {
> +               pos += scnprintf(buf + pos, buf_size - pos,
> +                       "on-fly with port %d (%d)\n",
> +                       ntb_peer_port_number(perf->ntb, perf->test_peer->pidx),
> +                       perf->test_peer->pidx);
> +       } else {
> +               pos += scnprintf(buf + pos, buf_size - pos, "idle\n");
>         }
>
> -       for (i = 0; i < MAX_THREADS; i++) {
> -               pctx = &perf->pthr_ctx[i];
> +       for (pidx = 0; pidx < perf->pcnt; pidx++) {
> +               peer = &perf->peers[pidx];
> +
> +               pos += scnprintf(buf + pos, buf_size - pos,
> +                       "Port %d (%d), Global index %d:\n",
> +                       ntb_peer_port_number(perf->ntb, peer->pidx), peer->pidx,
> +                       peer->gidx);
> +
> +               pos += scnprintf(buf + pos, buf_size - pos,
> +                       "\tLink status: %s\n",
> +                       test_bit(PERF_STS_LNKUP, &peer->sts) ? "up" : "down");
> +
> +               pos += scnprintf(buf + pos, buf_size - pos,
> +                       "\tOut buffer addr 0x%pK\n", peer->outbuf);
>
> -               if (pctx->status == -ENODATA)
> -                       break;
> +               pos += scnprintf(buf + pos, buf_size - pos,
> +                       "\tOut buffer size %pa\n", &peer->outbuf_size);
>
> -               if (pctx->status) {
> -                       out_off += scnprintf(buf + out_off, 1024 - out_off,
> -                                           "%d: error %d\n", i,
> -                                           pctx->status);
> +               pos += scnprintf(buf + pos, buf_size - pos,
> +                       "\tOut buffer xlat 0x%016llx[p]\n", peer->outbuf_xlat);
> +
> +               if (!peer->inbuf) {
> +                       pos += scnprintf(buf + pos, buf_size - pos,
> +                               "\tIn buffer addr: unallocated\n");
>                         continue;
>                 }
>
> -               rate = div64_u64(pctx->copied, pctx->diff_us);
> -               out_off += scnprintf(buf + out_off, 1024 - out_off,
> -                       "%d: copied %llu bytes in %llu usecs, %llu MBytes/s\n",
> -                       i, pctx->copied, pctx->diff_us, rate);
> +               pos += scnprintf(buf + pos, buf_size - pos,
> +                       "\tIn buffer addr 0x%pK\n", peer->inbuf);
> +
> +               pos += scnprintf(buf + pos, buf_size - pos,
> +                       "\tIn buffer size %pa\n", &peer->inbuf_size);
> +
> +               pos += scnprintf(buf + pos, buf_size - pos,
> +                       "\tIn buffer xlat %pad[p]\n", &peer->inbuf_xlat);
>         }
>
> -read_from_buf:
> -       ret = simple_read_from_buffer(ubuf, count, offp, buf, out_off);
> +       ret = simple_read_from_buffer(ubuf, size, offp, buf, pos);
>         kfree(buf);
>
>         return ret;
>  }
>
> -static void threads_cleanup(struct perf_ctx *perf)
> +static const struct file_operations perf_dbgfs_info = {
> +       .open = simple_open,
> +       .read = perf_dbgfs_read_info
> +};
> +
> +static ssize_t perf_dbgfs_read_run(struct file *filep, char __user *ubuf,
> +                                  size_t size, loff_t *offp)
>  {
> -       struct pthr_ctx *pctx;
> -       int i;
> +       struct perf_ctx *perf = filep->private_data;
> +       ssize_t ret, pos = 0;
> +       char *buf;
>
> -       for (i = 0; i < MAX_THREADS; i++) {
> -               pctx = &perf->pthr_ctx[i];
> -               if (pctx->thread) {
> -                       pctx->status = kthread_stop(pctx->thread);
> -                       pctx->thread = NULL;
> -               }
> -       }
> -}
> +       buf = kmalloc(1024, GFP_KERNEL);

This size seems arbitrary.  Either make it a #define or reference the
actual size of what you are wanting.

> +       if (!buf)
> +               return -ENOMEM;
>
> -static void perf_clear_thread_status(struct perf_ctx *perf)
> -{
> -       int i;
> +       ret = perf_read_stats(perf, buf, 1024, &pos);
> +       if (ret)
> +               goto err_free;
> +
> +       ret = simple_read_from_buffer(ubuf, size, offp, buf, pos);
> +err_free:
> +       kfree(buf);
>
> -       for (i = 0; i < MAX_THREADS; i++)
> -               perf->pthr_ctx[i].status = -ENODATA;
> +       return ret;
>  }
>
> -static ssize_t debugfs_run_write(struct file *filp, const char __user *ubuf,
> -                                size_t count, loff_t *offp)
> +static ssize_t perf_dbgfs_write_run(struct file *filep, const char __user *ubuf,
> +                                   size_t size, loff_t *offp)
>  {
> -       struct perf_ctx *perf = filp->private_data;
> -       int node, i;
> -       DECLARE_WAIT_QUEUE_HEAD(wq);
> +       struct perf_ctx *perf = filep->private_data;
> +       struct perf_peer *peer;
> +       int pidx, ret;
>
> -       if (wait_event_interruptible(perf->link_wq, perf->link_is_up))
> -               return -ENOLINK;
> +       ret = kstrtoint_from_user(ubuf, size, 0, &pidx);
> +       if (ret)
> +               return ret;
>
> -       if (perf->perf_threads == 0)
> +       if (pidx < 0 || pidx >= perf->pcnt)
>                 return -EINVAL;
>
> -       if (!mutex_trylock(&perf->run_mutex))
> -               return -EBUSY;
> +       peer = &perf->peers[pidx];
>
> -       perf_clear_thread_status(perf);
> +       ret = perf_submit_test(peer);
> +       if (ret)
> +               return ret;
>
> -       if (perf->perf_threads > MAX_THREADS) {
> -               perf->perf_threads = MAX_THREADS;
> -               pr_info("Reset total threads to: %u\n", MAX_THREADS);
> -       }
> +       return size;
> +}
>
> -       /* no greater than 1M */
> -       if (seg_order > MAX_SEG_ORDER) {
> -               seg_order = MAX_SEG_ORDER;
> -               pr_info("Fix seg_order to %u\n", seg_order);
> -       }
> +static const struct file_operations perf_dbgfs_run = {
> +       .open = simple_open,
> +       .read = perf_dbgfs_read_run,
> +       .write = perf_dbgfs_write_run
> +};
>
> -       if (run_order < seg_order) {
> -               run_order = seg_order;
> -               pr_info("Fix run_order to %u\n", run_order);
> -       }
> +static ssize_t perf_dbgfs_read_tcnt(struct file *filep, char __user *ubuf,
> +                                   size_t size, loff_t *offp)
> +{
> +       struct perf_ctx *perf = filep->private_data;
> +       char buf[8];
> +       ssize_t pos;
>
> -       node = on_node ? dev_to_node(&perf->ntb->pdev->dev)
> -                      : NUMA_NO_NODE;
> -       atomic_set(&perf->tdone, 0);
> +       pos = scnprintf(buf, sizeof(buf), "%hhu\n", perf->tcnt);
>
> -       /* launch kernel thread */
> -       for (i = 0; i < perf->perf_threads; i++) {
> -               struct pthr_ctx *pctx;
> +       return simple_read_from_buffer(ubuf, size, offp, buf, pos);
> +}
>
> -               pctx = &perf->pthr_ctx[i];
> -               atomic_set(&pctx->dma_sync, 0);
> -               pctx->perf = perf;
> -               pctx->wq = &wq;
> -               pctx->thread =
> -                       kthread_create_on_node(ntb_perf_thread,
> -                                              (void *)pctx,
> -                                              node, "ntb_perf %d", i);
> -               if (IS_ERR(pctx->thread)) {
> -                       pctx->thread = NULL;
> -                       goto err;
> -               } else {
> -                       wake_up_process(pctx->thread);
> -               }
> -       }
> +static ssize_t perf_dbgfs_write_tcnt(struct file *filep,
> +                                    const char __user *ubuf,
> +                                    size_t size, loff_t *offp)
> +{
> +       struct perf_ctx *perf = filep->private_data;
> +       int ret;
> +       u8 val;
>
> -       wait_event_interruptible(wq,
> -               atomic_read(&perf->tdone) == perf->perf_threads);
> +       ret = kstrtou8_from_user(ubuf, size, 0, &val);
> +       if (ret)
> +               return ret;
>
> -       threads_cleanup(perf);
> -       mutex_unlock(&perf->run_mutex);
> -       return count;
> +       ret = perf_set_tcnt(perf, val);
> +       if (ret)
> +               return ret;
>
> -err:
> -       threads_cleanup(perf);
> -       mutex_unlock(&perf->run_mutex);
> -       return -ENXIO;
> +       return size;
>  }
>
> -static const struct file_operations ntb_perf_debugfs_run = {
> -       .owner = THIS_MODULE,
> +static const struct file_operations perf_dbgfs_tcnt = {
>         .open = simple_open,
> -       .read = debugfs_run_read,
> -       .write = debugfs_run_write,
> +       .read = perf_dbgfs_read_tcnt,
> +       .write = perf_dbgfs_write_tcnt
>  };
>
> -static int perf_debugfs_setup(struct perf_ctx *perf)
> +static void perf_setup_dbgfs(struct perf_ctx *perf)
>  {
>         struct pci_dev *pdev = perf->ntb->pdev;
> -       struct dentry *debugfs_node_dir;
> -       struct dentry *debugfs_run;
> -       struct dentry *debugfs_threads;
> -       struct dentry *debugfs_seg_order;
> -       struct dentry *debugfs_run_order;
> -       struct dentry *debugfs_use_dma;
> -       struct dentry *debugfs_on_node;
> -
> -       if (!debugfs_initialized())
> -               return -ENODEV;
>
> -       /* Assumpion: only one NTB device in the system */
> -       if (!perf_debugfs_dir) {
> -               perf_debugfs_dir = debugfs_create_dir(KBUILD_MODNAME, NULL);
> -               if (!perf_debugfs_dir)
> -                       return -ENODEV;
> -       }
> -
> -       debugfs_node_dir = debugfs_create_dir(pci_name(pdev),
> -                                             perf_debugfs_dir);
> -       if (!debugfs_node_dir)
> -               goto err;
> -
> -       debugfs_run = debugfs_create_file("run", S_IRUSR | S_IWUSR,
> -                                         debugfs_node_dir, perf,
> -                                         &ntb_perf_debugfs_run);
> -       if (!debugfs_run)
> -               goto err;
> -
> -       debugfs_threads = debugfs_create_u8("threads", S_IRUSR | S_IWUSR,
> -                                           debugfs_node_dir,
> -                                           &perf->perf_threads);
> -       if (!debugfs_threads)
> -               goto err;
> -
> -       debugfs_seg_order = debugfs_create_u32("seg_order", 0600,
> -                                              debugfs_node_dir,
> -                                              &seg_order);
> -       if (!debugfs_seg_order)
> -               goto err;
> -
> -       debugfs_run_order = debugfs_create_u32("run_order", 0600,
> -                                              debugfs_node_dir,
> -                                              &run_order);
> -       if (!debugfs_run_order)
> -               goto err;
> -
> -       debugfs_use_dma = debugfs_create_bool("use_dma", 0600,
> -                                              debugfs_node_dir,
> -                                              &use_dma);
> -       if (!debugfs_use_dma)
> -               goto err;
> -
> -       debugfs_on_node = debugfs_create_bool("on_node", 0600,
> -                                             debugfs_node_dir,
> -                                             &on_node);
> -       if (!debugfs_on_node)
> -               goto err;
> +       perf->dbgfs_dir = debugfs_create_dir(pci_name(pdev), perf_dbgfs_topdir);
> +       if (!perf->dbgfs_dir) {
> +               dev_warn(&perf->ntb->dev, "DebugFS unsupported\n");
> +               return;
> +       }
> +
> +       debugfs_create_file("info", 0600, perf->dbgfs_dir, perf,
> +                           &perf_dbgfs_info);
>
> -       return 0;
> +       debugfs_create_file("run", 0600, perf->dbgfs_dir, perf,
> +                           &perf_dbgfs_run);
>
> -err:
> -       debugfs_remove_recursive(perf_debugfs_dir);
> -       perf_debugfs_dir = NULL;
> -       return -ENODEV;
> +       debugfs_create_file("threads_count", 0600, perf->dbgfs_dir, perf,
> +                           &perf_dbgfs_tcnt);
> +
> +       /* They are made read-only for test exec safety and integrity */
> +       debugfs_create_u8("chunk_order", 0500, perf->dbgfs_dir, &chunk_order);
> +
> +       debugfs_create_u8("total_order", 0500, perf->dbgfs_dir, &total_order);
> +
> +       debugfs_create_bool("use_dma", 0500, perf->dbgfs_dir, &use_dma);
>  }
>
> -static int perf_probe(struct ntb_client *client, struct ntb_dev *ntb)
> +static void perf_clear_dbgfs(struct perf_ctx *perf)
> +{
> +       debugfs_remove_recursive(perf->dbgfs_dir);
> +}
> +
> +/*==============================================================================
> + *                        Basic driver initialization
> + *==============================================================================
> + */
> +
> +static struct perf_ctx *perf_create_data(struct ntb_dev *ntb)
>  {
> -       struct pci_dev *pdev = ntb->pdev;
>         struct perf_ctx *perf;
> -       int node;
> -       int rc = 0;
>
> -       if (ntb_spad_count(ntb) < MAX_SPAD) {
> -               dev_err(&ntb->dev, "Not enough scratch pad registers for %s",
> -                       DRIVER_NAME);
> -               return -EIO;
> -       }
> +       perf = devm_kzalloc(&ntb->dev, sizeof(*perf), GFP_KERNEL);
> +       if (!perf)
> +               return ERR_PTR(-ENOMEM);
>
> -       if (!ntb->ops->mw_set_trans) {
> -               dev_err(&ntb->dev, "Need inbound MW based NTB API\n");
> -               return -EINVAL;
> +       perf->pcnt = ntb_peer_port_count(ntb);
> +       perf->peers = devm_kcalloc(&ntb->dev, perf->pcnt, sizeof(*perf->peers),
> +                                 GFP_KERNEL);
> +       if (!perf->peers)
> +               return ERR_PTR(-ENOMEM);
> +
> +       perf->ntb = ntb;
> +
> +       return perf;
> +}
> +
> +static int perf_setup_peer_mw(struct perf_peer *peer)
> +{
> +       struct perf_ctx *perf = peer->perf;
> +       phys_addr_t phys_addr;
> +       int ret;
> +
> +       /* Get outbound MW parameters and map it */
> +       ret = ntb_peer_mw_get_addr(perf->ntb, peer->gidx, &phys_addr,
> +                                  &peer->outbuf_size);
> +       if (ret)
> +               return ret;
> +
> +       peer->outbuf = devm_ioremap_wc(&perf->ntb->dev, phys_addr,
> +                                       peer->outbuf_size);
> +       if (!peer->outbuf)
> +               return -ENOMEM;
> +
> +       if (max_mw_size && peer->outbuf_size > max_mw_size) {
> +               peer->outbuf_size = max_mw_size;
> +               dev_warn(&peer->perf->ntb->dev,
> +                       "Peer %d outbuf reduced to %#llx\n", peer->pidx,
> +                       peer->outbuf_size);
>         }
>
> -       if (ntb_peer_port_count(ntb) != NTB_DEF_PEER_CNT)
> -               dev_warn(&ntb->dev, "Multi-port NTB devices unsupported\n");
> +       return 0;
> +}
>
> -       node = on_node ? dev_to_node(&pdev->dev) : NUMA_NO_NODE;
> -       perf = kzalloc_node(sizeof(*perf), GFP_KERNEL, node);
> -       if (!perf) {
> -               rc = -ENOMEM;
> -               goto err_perf;
> +static int perf_init_peers(struct perf_ctx *perf)
> +{
> +       struct perf_peer *peer;
> +       int pidx, lport, ret;
> +
> +       lport = ntb_port_number(perf->ntb);
> +       perf->gidx = -1;
> +       for (pidx = 0; pidx < perf->pcnt; pidx++) {
> +               peer = &perf->peers[pidx];
> +
> +               peer->perf = perf;
> +               peer->pidx = pidx;
> +               if (lport < ntb_peer_port_number(perf->ntb, pidx)) {
> +                       if (perf->gidx == -1)
> +                               perf->gidx = pidx;
> +                       peer->gidx = pidx + 1;
> +               } else {
> +                       peer->gidx = pidx;
> +               }
> +               INIT_WORK(&peer->service, perf_service_work);
>         }
> +       if (perf->gidx == -1)
> +               perf->gidx = pidx;
>
> -       perf->ntb = ntb;
> -       perf->perf_threads = 1;
> -       atomic_set(&perf->tsync, 0);
> -       mutex_init(&perf->run_mutex);
> -       spin_lock_init(&perf->db_lock);
> -       perf_setup_mw(ntb, perf);
> -       init_waitqueue_head(&perf->link_wq);
> -       INIT_DELAYED_WORK(&perf->link_work, perf_link_work);
> +       for (pidx = 0; pidx < perf->pcnt; pidx++) {
> +               ret = perf_setup_peer_mw(&perf->peers[pidx]);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       dev_dbg(&perf->ntb->dev, "Global port index %d\n", perf->gidx);
> +
> +       return 0;
> +}
>
> -       rc = ntb_set_ctx(ntb, perf, &perf_ops);
> -       if (rc)
> -               goto err_ctx;
> +static int perf_probe(struct ntb_client *client, struct ntb_dev *ntb)
> +{
> +       struct perf_ctx *perf;
> +       int ret;
>
> -       perf->link_is_up = false;
> -       ntb_link_enable(ntb, NTB_SPEED_AUTO, NTB_WIDTH_AUTO);
> -       ntb_link_event(ntb);
> +       perf = perf_create_data(ntb);
> +       if (IS_ERR(perf))
> +               return PTR_ERR(perf);
>
> -       rc = perf_debugfs_setup(perf);
> -       if (rc)
> -               goto err_ctx;
> +       ret = perf_init_peers(perf);
> +       if (ret)
> +               return ret;
>
> -       perf_clear_thread_status(perf);
> +       perf_init_threads(perf);
>
> -       return 0;
> +       ret = perf_init_service(perf);
> +       if (ret)
> +               return ret;
>
> -err_ctx:
> -       cancel_delayed_work_sync(&perf->link_work);
> -       kfree(perf);
> -err_perf:
> -       return rc;
> +       ret = perf_enable_service(perf);
> +       if (ret)
> +               return ret;
> +
> +       perf_setup_dbgfs(perf);
> +
> +       return 0;
>  }
>
>  static void perf_remove(struct ntb_client *client, struct ntb_dev *ntb)
>  {
>         struct perf_ctx *perf = ntb->ctx;
> -       int i;
>
> -       dev_dbg(&perf->ntb->dev, "%s called\n", __func__);
> +       perf_clear_dbgfs(perf);
>
> -       mutex_lock(&perf->run_mutex);
> +       perf_disable_service(perf);
>
> -       cancel_delayed_work_sync(&perf->link_work);
> +       perf_clear_threads(perf);
> +}
>
> -       ntb_clear_ctx(ntb);
> -       ntb_link_disable(ntb);
> +static struct ntb_client perf_client = {
> +       .ops = {
> +               .probe = perf_probe,
> +               .remove = perf_remove
> +       }
> +};
>
> -       debugfs_remove_recursive(perf_debugfs_dir);
> -       perf_debugfs_dir = NULL;
> +static int __init perf_init(void)
> +{
> +       int ret;
>
> -       if (use_dma) {
> -               for (i = 0; i < MAX_THREADS; i++) {
> -                       struct pthr_ctx *pctx = &perf->pthr_ctx[i];
> +       if (chunk_order > MAX_CHUNK_ORDER) {
> +               chunk_order = MAX_CHUNK_ORDER;
> +               pr_info("Chunk order reduced to %hhu\n", chunk_order);
> +       }
>
> -                       if (pctx->dma_chan)
> -                               dma_release_channel(pctx->dma_chan);
> -               }
> +       if (total_order < chunk_order) {
> +               total_order = chunk_order;
> +               pr_info("Total data order reduced to %hhu\n", total_order);
>         }
>
> -       kfree(perf);
> +       perf_wq = alloc_workqueue("perf_wq", WQ_UNBOUND | WQ_SYSFS, 0);
> +       if (!perf_wq)
> +               return -ENOMEM;
> +
> +       if (debugfs_initialized())
> +               perf_dbgfs_topdir = debugfs_create_dir(KBUILD_MODNAME, NULL);
> +
> +       ret = ntb_register_client(&perf_client);
> +       if (ret) {
> +               debugfs_remove_recursive(perf_dbgfs_topdir);
> +               destroy_workqueue(perf_wq);
> +       }
> +
> +       return ret;
>  }
> +module_init(perf_init);
> +
> +static void __exit perf_exit(void)
> +{
> +       ntb_unregister_client(&perf_client);
> +       debugfs_remove_recursive(perf_dbgfs_topdir);
> +       destroy_workqueue(perf_wq);
> +}
> +module_exit(perf_exit);
>
> -static struct ntb_client perf_client = {
> -       .ops = {
> -               .probe = perf_probe,
> -               .remove = perf_remove,
> -       },
> -};
> -module_ntb_client(perf_client);
> --
> 2.12.0
>
