Return-Path: <allenbh@gmail.com>
Received: from mail-yw0-x242.google.com (mail-yw0-x242.google.com. [2607:f8b0:4002:c05::242])
        by gmr-mx.google.com with ESMTPS id m78si948956ywd.4.2016.06.10.19.46.06
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Jun 2016 19:46:06 -0700 (PDT)
Received: by mail-yw0-x242.google.com with SMTP id j74so10554944ywg.1
        for <linux-ntb@googlegroups.com>; Fri, 10 Jun 2016 19:46:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <a326e5cfecc9c780e97d9ce1665d13474b7367c3.1465598632.git.logang@deltatee.com>
References: <cover.1465598632.git.logang@deltatee.com> <a326e5cfecc9c780e97d9ce1665d13474b7367c3.1465598632.git.logang@deltatee.com>
From: Allen Hubbe <allenbh@gmail.com>
Date: Fri, 10 Jun 2016 22:46:06 -0400
Message-ID: <CAJ80savOTsXePsDQqhaXDuXFx7jBMACkUbztzHnkCEDrpLWXjw@mail.gmail.com>
Subject: Re: [PATCH 7/8] ntb_pingpong: Add a debugfs file to get the ping count
Content-Type: text/plain; charset=UTF-8
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Shuah Khan <shuahkh@osg.samsung.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, linux-kselftest@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

On Fri, Jun 10, 2016 at 6:54 PM, Logan Gunthorpe <logang@deltatee.com> wrote:
> This commit adds a debugfs 'count' file to ntb_pingpong. This is so
> testing with ntb_pingpong can be automated beyond just checking the
> logs for pong messages.
>
> The count file returns a number which increments every pong. The
> counter can be cleared by writing a zero.
>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  drivers/ntb/test/ntb_pingpong.c | 68 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 67 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/ntb/test/ntb_pingpong.c b/drivers/ntb/test/ntb_pingpong.c
> index fe16005..34bbf5a 100644
> --- a/drivers/ntb/test/ntb_pingpong.c
> +++ b/drivers/ntb/test/ntb_pingpong.c
> @@ -61,6 +61,7 @@
>  #include <linux/pci.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
> +#include <linux/debugfs.h>
>
>  #include <linux/ntb.h>
>
> @@ -96,8 +97,13 @@ struct pp_ctx {
>         spinlock_t                      db_lock;
>         struct timer_list               db_timer;
>         unsigned long                   db_delay;
> +       struct dentry                   *debugfs_node_dir;
> +       struct dentry                   *debugfs_count;
> +       atomic_t                        count;
>  };
>
> +static struct dentry *pp_debugfs_dir;
> +
>  static void pp_ping(unsigned long ctx)
>  {
>         struct pp_ctx *pp = (void *)ctx;
> @@ -171,10 +177,38 @@ static void pp_db_event(void *ctx, int vec)
>                 dev_dbg(&pp->ntb->dev,
>                         "Pong vec %d bits %#llx\n",
>                         vec, db_bits);
> +               atomic_inc(&pp->count);
>         }
>         spin_unlock_irqrestore(&pp->db_lock, irqflags);
>  }
>
> +static int pp_debugfs_setup(struct pp_ctx *pp)
> +{
> +       struct pci_dev *pdev = pp->ntb->pdev;
> +
> +       if (!debugfs_initialized())
> +               return -ENODEV;
> +
> +       if (!pp_debugfs_dir) {
> +               pp_debugfs_dir = debugfs_create_dir(KBUILD_MODNAME, NULL);

The pp_debugfs_dir is already initialized by the module init function.
If it doesn't exist here, I think we should just return instead of
trying again.  It's also worth noting, though it is probably no harm,
the code here does not check debugfs_initialized().

> +               if (!pp_debugfs_dir)
> +                       return -ENODEV;
> +       }
> +
> +       pp->debugfs_node_dir = debugfs_create_dir(pci_name(pdev),
> +                                                 pp_debugfs_dir);
> +       if (!pp->debugfs_node_dir)
> +               return -ENODEV;
> +
> +       pp->debugfs_count = debugfs_create_atomic_t("count", S_IRUSR | S_IWUSR,
> +                                                   pp->debugfs_node_dir,
> +                                                   &pp->count);
> +       if (!pp->debugfs_count)
> +               return -ENODEV;
> +
> +       return 0;
> +}
> +
>  static const struct ntb_ctx_ops pp_ops = {
>         .link_event = pp_link_event,
>         .db_event = pp_db_event,
> @@ -210,6 +244,7 @@ static int pp_probe(struct ntb_client *client,
>
>         pp->ntb = ntb;
>         pp->db_bits = 0;
> +       atomic_set(&pp->count, 0);
>         spin_lock_init(&pp->db_lock);
>         setup_timer(&pp->db_timer, pp_ping, (unsigned long)pp);
>         pp->db_delay = msecs_to_jiffies(delay_ms);
> @@ -218,6 +253,10 @@ static int pp_probe(struct ntb_client *client,
>         if (rc)
>                 goto err_ctx;
>
> +       rc = pp_debugfs_setup(pp);
> +       if (rc)
> +               goto err_ctx;
> +
>         ntb_link_enable(ntb, NTB_SPEED_AUTO, NTB_WIDTH_AUTO);
>         ntb_link_event(ntb);
>
> @@ -234,6 +273,8 @@ static void pp_remove(struct ntb_client *client,
>  {
>         struct pp_ctx *pp = ntb->ctx;
>
> +       debugfs_remove_recursive(pp->debugfs_node_dir);
> +
>         ntb_clear_ctx(ntb);
>         del_timer_sync(&pp->db_timer);
>         ntb_link_disable(ntb);
> @@ -247,4 +288,29 @@ static struct ntb_client pp_client = {
>                 .remove = pp_remove,
>         },
>  };
> -module_ntb_client(pp_client);
> +
> +static int __init tool_init(void)

This should be pp_init() not tool_init().

> +{
> +       int rc;
> +
> +       if (debugfs_initialized())
> +               pp_debugfs_dir = debugfs_create_dir(KBUILD_MODNAME, NULL);
> +
> +       rc = ntb_register_client(&pp_client);
> +       if (rc)
> +               goto err_client;
> +
> +       return 0;
> +
> +err_client:
> +       debugfs_remove_recursive(pp_debugfs_dir);
> +       return rc;
> +}
> +module_init(tool_init);
> +
> +static void __exit tool_exit(void)
> +{
> +       ntb_unregister_client(&pp_client);
> +       debugfs_remove_recursive(pp_debugfs_dir);
> +}
> +module_exit(tool_exit);
