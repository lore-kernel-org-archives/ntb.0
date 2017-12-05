Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf0-x229.google.com (mail-lf0-x229.google.com. [2a00:1450:4010:c07::229])
        by gmr-mx.google.com with ESMTPS id w21si177198edl.5.2017.12.05.11.53.29
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Dec 2017 11:53:29 -0800 (PST)
Received: by mail-lf0-x229.google.com with SMTP id f13so1644903lff.12
        for <linux-ntb@googlegroups.com>; Tue, 05 Dec 2017 11:53:29 -0800 (PST)
Return-Path: <fancer.lancer@gmail.com>
Date: Tue, 5 Dec 2017 22:53:35 +0300
From: Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH v2 04/15] NTB: ntb_pp: Add full multi-port NTB API support
Message-ID: <20171205195335.GE1701@mobilestation>
References: <20171203191736.3399-1-fancer.lancer@gmail.com>
 <20171203191736.3399-5-fancer.lancer@gmail.com>
 <CAPoiz9zGoa53FEpG6yZMK_GowN9hh70xWiLOeLtczv6-P4gQ0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAPoiz9zGoa53FEpG6yZMK_GowN9hh70xWiLOeLtczv6-P4gQ0g@mail.gmail.com>
To: Jon Mason <jdmason@kudzu.us>
Cc: Dave Jiang <dave.jiang@intel.com>, "Hubbe, Allen" <Allen.Hubbe@emc.com>, "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>, "Yu, Xiangliang" <Xiangliang.Yu@amd.com>, Gary R Hook <gary.hook@amd.com>, Sergey.Semin@t-platforms.ru, linux-ntb <linux-ntb@googlegroups.com>, linux-kernel <linux-kernel@vger.kernel.org>
List-ID: <linux-ntb.googlegroups.com>

On Tue, Dec 05, 2017 at 12:02:13PM -0500, Jon Mason <jdmason@kudzu.us> wrot=
e:
> On Sun, Dec 3, 2017 at 2:17 PM, Serge Semin <fancer.lancer@gmail.com> wro=
te:
> > NTB API has been updated to support multi-port devices like IDT
> > 89HPESx series or Microsemi Switchtec. Message registers
> > functionality has also been added to new API. In order to keep
> > the new hardware and corresponding capabilities well tested, NTB
> > pingpong driver is accordingly altered.
> >
> > Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> > ---
> >
> > Changelog v1:
> > - Add Multi-port API support
> > - Ping-pong now works like cyclic ping around all the peers
> >
> > Changelog v2:
> > - Remove driver Author/Description/Version macros
> >
> >  drivers/ntb/test/ntb_pingpong.c | 450 +++++++++++++++++++++++++-------=
--------
> >  1 file changed, 286 insertions(+), 164 deletions(-)
> >
> > diff --git a/drivers/ntb/test/ntb_pingpong.c b/drivers/ntb/test/ntb_pin=
gpong.c
> > index 3f5a92bae6f8..3e4a35a856cc 100644
> > --- a/drivers/ntb/test/ntb_pingpong.c
> > +++ b/drivers/ntb/test/ntb_pingpong.c
> > @@ -1,10 +1,11 @@
> >  /*
> > - * This file is provided under a dual BSD/GPLv2 license.  When using or
> > + *   This file is provided under a dual BSD/GPLv2 license.  When using=
 or
> >   *   redistributing this file, you may do so under either license.
> >   *
> >   *   GPL LICENSE SUMMARY
> >   *
> >   *   Copyright (C) 2015 EMC Corporation. All Rights Reserved.
> > + *   Copyright (C) 2017 T-Platforms. All Rights Reserved.
> >   *
> >   *   This program is free software; you can redistribute it and/or mod=
ify
> >   *   it under the terms of version 2 of the GNU General Public License=
 as
> > @@ -18,6 +19,7 @@
> >   *   BSD LICENSE
> >   *
> >   *   Copyright (C) 2015 EMC Corporation. All Rights Reserved.
> > + *   Copyright (C) 2017 T-Platforms. All Rights Reserved.
> >   *
> >   *   Redistribution and use in source and binary forms, with or without
> >   *   modification, are permitted provided that the following conditions
> > @@ -49,34 +51,46 @@
> >   *
> >   * Contact Information:
> >   * Allen Hubbe <Allen.Hubbe@emc.com>
> > + * Serge Semin <fancer.lancer@gmail.com>, <Sergey.Semin@t-platforms.ru>
>=20
> 2 emails seems unnecessary.  Just add whichever you want kernel emails on.
>=20

I'd prefer gmail one, but we agreed to completely remove the contacts info =
from
the drivers anyway. So these lines will be discarded in v3.

> >   */
> >
> > -/* Note: load this module with option 'dyndbg=3D+p' */
> > +/*
> > + * How to use this tool, by example.
> > + *
> > + * Assuming $DBG_DIR is something like:
> > + * '/sys/kernel/debug/ntb_perf/0000:00:03.0'
> > + * Suppose aside from local device there is at least one remote device
> > + * connected to NTB with index 0.
> > + *--------------------------------------------------------------------=
---------
> > + * Eg: install driver with specified delay between doorbell event and =
response
> > + *
> > + * root@self# insmod ntb_pingpong.ko delay_ms=3D1000
> > + *--------------------------------------------------------------------=
---------
> > + * Eg: get number of ping-pong cycles performed
> > + *
> > + * root@self# cat $DBG_DIR/count
> > + */
> >
> >  #include <linux/init.h>
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> > +#include <linux/device.h>
> > +#include <linux/bitops.h>
> >
> > -#include <linux/dma-mapping.h>
> >  #include <linux/pci.h>
> >  #include <linux/slab.h>
> > -#include <linux/spinlock.h>
> > +#include <linux/hrtimer.h>
> >  #include <linux/debugfs.h>
> >
> >  #include <linux/ntb.h>
> >
> > -#define DRIVER_NAME                    "ntb_pingpong"
> > -#define DRIVER_DESCRIPTION             "PCIe NTB Simple Pingpong Clien=
t"
> > -
> > -#define DRIVER_LICENSE                 "Dual BSD/GPL"
> > -#define DRIVER_VERSION                 "1.0"
> > -#define DRIVER_RELDATE                 "24 March 2015"
> > -#define DRIVER_AUTHOR                  "Allen Hubbe <Allen.Hubbe@emc.c=
om>"
> > +#define DRIVER_NAME            "ntb_pingpong"
> > +#define DRIVER_VERSION         "2.0"
> >
> > -MODULE_LICENSE(DRIVER_LICENSE);
> > +MODULE_LICENSE("Dual BSD/GPL");
> >  MODULE_VERSION(DRIVER_VERSION);
> > -MODULE_AUTHOR(DRIVER_AUTHOR);
> > -MODULE_DESCRIPTION(DRIVER_DESCRIPTION);
> > +MODULE_AUTHOR("Allen Hubbe <Allen.Hubbe@emc.com>");
> > +MODULE_DESCRIPTION("PCIe NTB Simple Pingpong Client");
>=20
> The changes above seem like unrelated, unnecessary cleanup.  If so,
> break it out into a separate patch.  Otherwise, code changes might get
> lost in the mess.
>=20

Is it really necessary to have all of this info defined in macro? We don't =
use
them anywhere in the source below. I add this change here due to the last G=
reg
patch, where he removed DRIVER_LICENSE from the code. He said, that the lic=
ense
check tool needs it to be directly defined in the MODULE_LICENSE. The rest =
of=20
macro aren't used by any tool, but still there might be some utility in fut=
ure
to collect all the driver authors or descriptions. Still if you think it is
unnecessary and it's ok to still have the macro left here, I'll get them ba=
ck
to the drivers code.

> >
> >  static unsigned int unsafe;
> >  module_param(unsafe, uint, 0644);
> > @@ -86,237 +100,345 @@ static unsigned int delay_ms =3D 1000;
> >  module_param(delay_ms, uint, 0644);
> >  MODULE_PARM_DESC(delay_ms, "Milliseconds to delay the response to peer=
");
> >
> > -static unsigned long db_init =3D 0x7;
> > -module_param(db_init, ulong, 0644);
> > -MODULE_PARM_DESC(db_init, "Initial doorbell bits to ring on the peer");
> > -
> > -/* Only two-ports NTB devices are supported */
> > -#define PIDX           NTB_DEF_PEER_IDX
> > -
> >  struct pp_ctx {
> > -       struct ntb_dev                  *ntb;
> > -       u64                             db_bits;
> > -       /* synchronize access to db_bits by ping and pong */
> > -       spinlock_t                      db_lock;
> > -       struct timer_list               db_timer;
> > -       unsigned long                   db_delay;
> > -       struct dentry                   *debugfs_node_dir;
> > -       struct dentry                   *debugfs_count;
> > -       atomic_t                        count;
> > +       struct ntb_dev *ntb;
> > +       struct hrtimer timer;
> > +       u64 in_db;
> > +       u64 out_db;
> > +       int out_pidx;
> > +       u64 nmask;
> > +       u64 pmask;
> > +       atomic_t count;
> > +       spinlock_t lock;
> > +       struct dentry *dbgfs_dir;
> >  };
> > +#define to_pp_timer(__timer) \
> > +       container_of(__timer, struct pp_ctx, timer)
> >
> > -static struct dentry *pp_debugfs_dir;
> > +static struct dentry *pp_dbgfs_topdir;
> >
> > -static void pp_ping(struct timer_list *t)
> > +static int pp_find_next_peer(struct pp_ctx *pp)
> >  {
> > -       struct pp_ctx *pp =3D from_timer(pp, t, db_timer);
> > -       unsigned long irqflags;
> > -       u64 db_bits, db_mask;
> > -       u32 spad_rd, spad_wr;
> > +       u64 link, out_db;
> > +       int pidx;
> > +
> > +       link =3D ntb_link_is_up(pp->ntb, NULL, NULL);
> > +
> > +       /* Find next available peer */
> > +       if (link & pp->nmask) {
> > +               pidx =3D __ffs64(link & pp->nmask);
> > +               out_db =3D BIT_ULL(pidx + 1);
> > +       } else if (link & pp->pmask) {
> > +               pidx =3D __ffs64(link & pp->pmask);
> > +               out_db =3D BIT_ULL(pidx);
> > +       } else {
> > +               return -ENODEV;
> > +       }
> >
> > -       spin_lock_irqsave(&pp->db_lock, irqflags);
> > -       {
> > -               db_mask =3D ntb_db_valid_mask(pp->ntb);
> > -               db_bits =3D ntb_db_read(pp->ntb);
> > +       spin_lock(&pp->lock);
> > +       pp->out_pidx =3D pidx;
> > +       pp->out_db =3D out_db;
> > +       spin_unlock(&pp->lock);
> >
> > -               if (db_bits) {
> > -                       dev_dbg(&pp->ntb->dev,
> > -                               "Masked pongs %#llx\n",
> > -                               db_bits);
> > -                       ntb_db_clear(pp->ntb, db_bits);
> > -               }
> > +       return 0;
> > +}
> >
> > -               db_bits =3D ((pp->db_bits | db_bits) << 1) & db_mask;
> > +static void pp_setup(struct pp_ctx *pp)
> > +{
> > +       int ret;
> >
> > -               if (!db_bits)
> > -                       db_bits =3D db_init;
> > +       ntb_db_set_mask(pp->ntb, pp->in_db);
> >
> > -               spad_rd =3D ntb_spad_read(pp->ntb, 0);
> > -               spad_wr =3D spad_rd + 1;
> > +       hrtimer_cancel(&pp->timer);
> >
> > -               dev_dbg(&pp->ntb->dev,
> > -                       "Ping bits %#llx read %#x write %#x\n",
> > -                       db_bits, spad_rd, spad_wr);
> > +       ret =3D pp_find_next_peer(pp);
> > +       if (ret =3D=3D -ENODEV) {
>=20
> I would suggest any error (thus < 0)
>=20

pp_find_next_peer() doesn't return any error except -ENODEV, so technically
it is ok to leave it as is. Additionally the definite value check can be se=
en
as some kind of code documentation. The only problem which I see here can h=
appen
only if somebody changes the function definition, so it would return another
errors. I'd leave it as is for now, since positive sides seem to me more
valuable.

> > +               dev_dbg(&pp->ntb->dev, "Got no peers, so cancel\n");
> > +               return;
> > +       }
> >
> > -               ntb_peer_spad_write(pp->ntb, PIDX, 0, spad_wr);
> > -               ntb_peer_db_set(pp->ntb, db_bits);
> > -               ntb_db_clear_mask(pp->ntb, db_mask);
> > +       spin_lock(&pp->lock);
> > +       dev_dbg(&pp->ntb->dev, "Ping-pong started with port %d, db %#ll=
x\n",
> > +               ntb_peer_port_number(pp->ntb, pp->out_pidx), pp->out_db=
);
> > +       spin_unlock(&pp->lock);
>=20
> Ugh, I don't like this.  You are adding a side effect of the lock
> being potentially grabbed by someone else just for debugging that
> might not be enabled.
>=20

Fair enough. I'll discard the lock/unlock.

> >
> > -               pp->db_bits =3D 0;
> > -       }
> > -       spin_unlock_irqrestore(&pp->db_lock, irqflags);
> > +       hrtimer_start(&pp->timer, ms_to_ktime(delay_ms), HRTIMER_MODE_R=
EL);
> >  }
> >
> > -static void pp_link_event(void *ctx)
> > +static void pp_clear(struct pp_ctx *pp)
> >  {
> > -       struct pp_ctx *pp =3D ctx;
> > +       hrtimer_cancel(&pp->timer);
> >
> > -       if (ntb_link_is_up(pp->ntb, NULL, NULL) =3D=3D 1) {
> > -               dev_dbg(&pp->ntb->dev, "link is up\n");
> > -               pp_ping(&pp->db_timer);
> > -       } else {
> > -               dev_dbg(&pp->ntb->dev, "link is down\n");
> > -               del_timer(&pp->db_timer);
> > -       }
> > +       ntb_db_set_mask(pp->ntb, pp->in_db);
> > +
> > +       dev_dbg(&pp->ntb->dev, "Ping-pong cancelled\n");
> >  }
> >
> > -static void pp_db_event(void *ctx, int vec)
> > +static void pp_ping(struct pp_ctx *pp)
> >  {
> > -       struct pp_ctx *pp =3D ctx;
> > -       u64 db_bits, db_mask;
> > -       unsigned long irqflags;
> > +       u32 count;
> >
> > -       spin_lock_irqsave(&pp->db_lock, irqflags);
> > -       {
> > -               db_mask =3D ntb_db_vector_mask(pp->ntb, vec);
> > -               db_bits =3D db_mask & ntb_db_read(pp->ntb);
> > -               ntb_db_set_mask(pp->ntb, db_mask);
> > -               ntb_db_clear(pp->ntb, db_bits);
> > +       count =3D atomic_read(&pp->count);
> >
> > -               pp->db_bits |=3D db_bits;
> > +       spin_lock(&pp->lock);
> > +       ntb_peer_spad_write(pp->ntb, pp->out_pidx, 0, count);
> > +       ntb_peer_msg_write(pp->ntb, pp->out_pidx, 0, count);
> >
> > -               mod_timer(&pp->db_timer, jiffies + pp->db_delay);
> > +       dev_dbg(&pp->ntb->dev, "Ping port %d spad %#x, msg %#x\n",
> > +               ntb_peer_port_number(pp->ntb, pp->out_pidx), count, cou=
nt);
> >
> > -               dev_dbg(&pp->ntb->dev,
> > -                       "Pong vec %d bits %#llx\n",
> > -                       vec, db_bits);
> > -               atomic_inc(&pp->count);
> > -       }
> > -       spin_unlock_irqrestore(&pp->db_lock, irqflags);
> > +       ntb_peer_db_set(pp->ntb, pp->out_db);
> > +       ntb_db_clear_mask(pp->ntb, pp->in_db);
> > +       spin_unlock(&pp->lock);
> >  }
> >
> > -static int pp_debugfs_setup(struct pp_ctx *pp)
> > +static void pp_pong(struct pp_ctx *pp)
> >  {
> > -       struct pci_dev *pdev =3D pp->ntb->pdev;
> > +       u32 msg_data =3D -1, spad_data =3D -1;
> > +       int pidx =3D 0;
> >
> > -       if (!pp_debugfs_dir)
> > -               return -ENODEV;
> > +       /* Read pong data */
> > +       spad_data =3D ntb_spad_read(pp->ntb, 0);
> > +       msg_data =3D ntb_msg_read(pp->ntb, &pidx, 0);
> > +       ntb_msg_clear_sts(pp->ntb, -1);
> >
> > -       pp->debugfs_node_dir =3D debugfs_create_dir(pci_name(pdev),
> > -                                                 pp_debugfs_dir);
> > -       if (!pp->debugfs_node_dir)
> > -               return -ENODEV;
> > +       /*
> > +        * Scratchpad and message data may differ, since message regist=
er can't
> > +        * be rewritten unless status is cleared. Additionally either o=
f them
> > +        * might be unsupported
> > +        */
> > +       dev_dbg(&pp->ntb->dev, "Pong spad %#x, msg %#x (port %d)\n",
> > +               spad_data, msg_data, ntb_peer_port_number(pp->ntb, pidx=
));
> >
> > -       pp->debugfs_count =3D debugfs_create_atomic_t("count", S_IRUSR =
| S_IWUSR,
> > -                                                   pp->debugfs_node_di=
r,
> > -                                                   &pp->count);
> > -       if (!pp->debugfs_count)
> > -               return -ENODEV;
> > +       atomic_inc(&pp->count);
> >
> > -       return 0;
> > +       ntb_db_set_mask(pp->ntb, pp->in_db);
> > +       ntb_db_clear(pp->ntb, pp->in_db);
> > +
> > +       hrtimer_start(&pp->timer, ms_to_ktime(delay_ms), HRTIMER_MODE_R=
EL);
> > +}
> > +
> > +static enum hrtimer_restart pp_timer_func(struct hrtimer *t)
> > +{
> > +       struct pp_ctx *pp =3D to_pp_timer(t);
> > +
> > +       pp_ping(pp);
> > +
> > +       return HRTIMER_NORESTART;
> > +}
> > +
> > +static void pp_link_event(void *ctx)
> > +{
> > +       struct pp_ctx *pp =3D ctx;
> > +
> > +       pp_setup(pp);
> > +}
> > +
> > +static void pp_db_event(void *ctx, int vec)
> > +{
> > +       struct pp_ctx *pp =3D ctx;
> > +
> > +       pp_pong(pp);
> >  }
> >
> >  static const struct ntb_ctx_ops pp_ops =3D {
> >         .link_event =3D pp_link_event,
> > -       .db_event =3D pp_db_event,
> > +       .db_event =3D pp_db_event
> >  };
> >
> > -static int pp_probe(struct ntb_client *client,
> > -                   struct ntb_dev *ntb)
> > +static int pp_check_ntb(struct ntb_dev *ntb)
> >  {
> > -       struct pp_ctx *pp;
> > -       int rc;
> > +       u64 pmask;
> >
> >         if (ntb_db_is_unsafe(ntb)) {
> > -               dev_dbg(&ntb->dev, "doorbell is unsafe\n");
> > -               if (!unsafe) {
> > -                       rc =3D -EINVAL;
> > -                       goto err_pp;
> > -               }
> > -       }
> > -
> > -       if (ntb_spad_count(ntb) < 1) {
> > -               dev_dbg(&ntb->dev, "no enough scratchpads\n");
> > -               rc =3D -EINVAL;
> > -               goto err_pp;
> > +               dev_dbg(&ntb->dev, "Doorbell is unsafe\n");
> > +               if (!unsafe)
> > +                       return -EINVAL;
> >         }
> >
> >         if (ntb_spad_is_unsafe(ntb)) {
> > -               dev_dbg(&ntb->dev, "scratchpad is unsafe\n");
> > -               if (!unsafe) {
> > -                       rc =3D -EINVAL;
> > -                       goto err_pp;
> > -               }
> > +               dev_dbg(&ntb->dev, "Scratchpad is unsafe\n");
> > +               if (!unsafe)
> > +                       return -EINVAL;
> >         }
> >
> > -       if (ntb_peer_port_count(ntb) !=3D NTB_DEF_PEER_CNT)
> > -               dev_warn(&ntb->dev, "multi-port NTB is unsupported\n");
> > +       pmask =3D GENMASK_ULL(ntb_peer_port_count(ntb), 0);
> > +       if ((ntb_db_valid_mask(ntb) & pmask) !=3D pmask) {
> > +               dev_err(&ntb->dev, "Unsupported DB configuration\n");
> > +               return -EINVAL;
> > +       }
> >
> > -       pp =3D kmalloc(sizeof(*pp), GFP_KERNEL);
> > -       if (!pp) {
> > -               rc =3D -ENOMEM;
> > -               goto err_pp;
> > +       if (ntb_spad_count(ntb) < 1 && ntb_msg_count(ntb) < 1) {
> > +               dev_dbg(&ntb->dev, "Scratchpads and messages unsupporte=
d\n");
> > +               return -EINVAL;
> > +       } else if (ntb_spad_count(ntb) < 1) {
> > +               dev_dbg(&ntb->dev, "Scratchpads unsupported\n");
> > +       } else if (ntb_msg_count(ntb) < 1) {
> > +               dev_dbg(&ntb->dev, "Messages unsupported\n");
>=20
> Should these be warnings or errors?
>=20

The last two should be debug prints. It's ok if one of them unsupported,
some of NTB devices can provides Messages only, some work with Scratchpads.
As far as I know there is only one NTB device, which supports both of them
on hardware level. It's IDT=EF=BF=BD 89HPES8NT2, 89HPES16NT2, 89HPES16NT2, =
89HPES12NT3,
89HPES24NT3 series, which isn't supported by the current IDT driver, since
I don't have it.
But it's bug if neither of the registers supported. NTB API even doesn't al=
low
such devices registration. In this case we should print an error. I'll repl=
ace
the first dev_dbg with dev_err then.

> >         }
> >
> > +       return 0;
> > +}
> > +
> > +static struct pp_ctx *pp_create_data(struct ntb_dev *ntb)
> > +{
> > +       struct pp_ctx *pp;
> > +
> > +       pp =3D devm_kzalloc(&ntb->dev, sizeof(*pp), GFP_KERNEL);
> > +       if (!pp)
> > +               return ERR_PTR(-ENOMEM);
> > +
> >         pp->ntb =3D ntb;
> > -       pp->db_bits =3D 0;
> >         atomic_set(&pp->count, 0);
> > -       spin_lock_init(&pp->db_lock);
> > -       timer_setup(&pp->db_timer, pp_ping, 0);
> > -       pp->db_delay =3D msecs_to_jiffies(delay_ms);
> > +       spin_lock_init(&pp->lock);
> > +       hrtimer_init(&pp->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> > +       pp->timer.function =3D pp_timer_func;
> >
> > -       rc =3D ntb_set_ctx(ntb, pp, &pp_ops);
> > -       if (rc)
> > -               goto err_ctx;
> > +       return pp;
> > +}
> > +
> > +static void pp_init_flds(struct pp_ctx *pp)
> > +{
> > +       int pidx, lport, pcnt;
> > +
> > +       /* Find global port index */
> > +       lport =3D ntb_port_number(pp->ntb);
> > +       pcnt =3D ntb_peer_port_count(pp->ntb);
> > +       for (pidx =3D 0; pidx < pcnt; pidx++) {
> > +               if (lport < ntb_peer_port_number(pp->ntb, pidx))
> > +                       break;
> > +       }
> >
> > -       rc =3D pp_debugfs_setup(pp);
> > -       if (rc)
> > -               goto err_ctx;
> > +       pp->in_db =3D BIT_ULL(pidx);
> > +       pp->pmask =3D GENMASK_ULL(pidx, 0) >> 1;
> > +       pp->nmask =3D GENMASK_ULL(pcnt - 1, pidx);
> >
> > -       ntb_link_enable(ntb, NTB_SPEED_AUTO, NTB_WIDTH_AUTO);
> > -       ntb_link_event(ntb);
> > +       dev_dbg(&pp->ntb->dev, "Inbound db %#llx, prev %#llx, next %#ll=
x\n",
> > +               pp->in_db, pp->pmask, pp->nmask);
> > +}
> > +
> > +static int pp_mask_events(struct pp_ctx *pp)
> > +{
> > +       u64 db_mask, msg_mask;
> > +       int ret;
> > +
> > +       db_mask =3D ntb_db_valid_mask(pp->ntb);
> > +       ret =3D ntb_db_set_mask(pp->ntb, db_mask);
> > +       if (ret)
> > +               return ret;
> > +
> > +       /* Skip message events masking if unsupported */
> > +       if (ntb_msg_count(pp->ntb) < 1)
> > +               return 0;
> > +
> > +       msg_mask =3D ntb_msg_outbits(pp->ntb) | ntb_msg_inbits(pp->ntb);
> > +       return ntb_msg_set_mask(pp->ntb, msg_mask);
> > +}
> > +
> > +static int pp_setup_ctx(struct pp_ctx *pp)
> > +{
> > +       int ret;
> > +
> > +       ret =3D ntb_set_ctx(pp->ntb, pp, &pp_ops);
> > +       if (ret)
> > +               return ret;
> > +
> > +       ntb_link_enable(pp->ntb, NTB_SPEED_AUTO, NTB_WIDTH_AUTO);
> > +       /* Might be not necessary */
> > +       ntb_link_event(pp->ntb);
> >
> >         return 0;
> > +}
> > +
> > +static void pp_clear_ctx(struct pp_ctx *pp)
> > +{
> > +       ntb_link_disable(pp->ntb);
> >
> > -err_ctx:
> > -       kfree(pp);
> > -err_pp:
> > -       return rc;
> > +       ntb_clear_ctx(pp->ntb);
> >  }
> >
> > -static void pp_remove(struct ntb_client *client,
> > -                     struct ntb_dev *ntb)
> > +static void pp_setup_dbgfs(struct pp_ctx *pp)
> > +{
> > +       struct pci_dev *pdev =3D pp->ntb->pdev;
> > +       void *ret;
> > +
> > +       pp->dbgfs_dir =3D debugfs_create_dir(pci_name(pdev), pp_dbgfs_t=
opdir);
> > +
> > +       ret =3D debugfs_create_atomic_t("count", 0600, pp->dbgfs_dir, &=
pp->count);
> > +       if (!ret)
> > +               dev_warn(&pp->ntb->dev, "DebugFS unsupported\n");
>=20
> Shouldn't this be fatal?
>=20

If only I had the record of all the comments I have got on the DebugFS
initialization code.) Everyone had different opinion on this.
Last time I submitted a patch to driver/misc subsystem, where Grag K-H is
reviewer. He said, that DebugFS got just one purpose - for debugging. A dri=
ver
isn't supposed to fail in case if the FS isn't available in the kernel. I h=
ad to
rewrite the code in the same way he said. I assume the Ping-Pong driver sha=
ll
still work if DebugFS isn't available, but the user won't be able to see how
many pings have been made. For such circumstances I added the warning to in=
form
the user about this. So lets leave the code as is. Although I'd accept such=
 the
comment on ntb_tool/ntb_perf drivers, since they get to be useless without
DebugFS support in the kernel.

> > +}
> > +
> > +static void pp_clear_dbgfs(struct pp_ctx *pp)
> > +{
> > +       debugfs_remove_recursive(pp->dbgfs_dir);
> > +}
> > +
> > +static int pp_probe(struct ntb_client *client, struct ntb_dev *ntb)
> > +{
> > +       struct pp_ctx *pp;
> > +       int ret;
> > +
> > +       ret =3D pp_check_ntb(ntb);
> > +       if (ret)
> > +               return ret;
> > +
> > +       pp =3D pp_create_data(ntb);
> > +       if (IS_ERR(pp))
> > +               return PTR_ERR(pp);
> > +
> > +       pp_init_flds(pp);
> > +
> > +       ret =3D pp_mask_events(pp);
> > +       if (ret)
> > +               return ret;
> > +
> > +       ret =3D pp_setup_ctx(pp);
> > +       if (ret)
> > +               return ret;
> > +
> > +       pp_setup_dbgfs(pp);
> > +
> > +       return 0;
> > +}
> > +
> > +static void pp_remove(struct ntb_client *client, struct ntb_dev *ntb)
> >  {
> >         struct pp_ctx *pp =3D ntb->ctx;
> >
> > -       debugfs_remove_recursive(pp->debugfs_node_dir);
> > +       pp_clear_dbgfs(pp);
> >
> > -       ntb_clear_ctx(ntb);
> > -       del_timer_sync(&pp->db_timer);
> > -       ntb_link_disable(ntb);
> > +       pp_clear_ctx(pp);
> >
> > -       kfree(pp);
> > +       pp_clear(pp);
> >  }
> >
> >  static struct ntb_client pp_client =3D {
> >         .ops =3D {
> >                 .probe =3D pp_probe,
> > -               .remove =3D pp_remove,
> > -       },
> > +               .remove =3D pp_remove
> > +       }
> >  };
> >
> >  static int __init pp_init(void)
> >  {
> > -       int rc;
> > +       int ret;
> >
> >         if (debugfs_initialized())
> > -               pp_debugfs_dir =3D debugfs_create_dir(KBUILD_MODNAME, N=
ULL);
> > +               pp_dbgfs_topdir =3D debugfs_create_dir(KBUILD_MODNAME, =
NULL);
> >
> > -       rc =3D ntb_register_client(&pp_client);
> > -       if (rc)
> > -               goto err_client;
> > +       ret =3D ntb_register_client(&pp_client);
> > +       if (ret)
> > +               debugfs_remove_recursive(pp_dbgfs_topdir);
> >
> > -       return 0;
> > -
> > -err_client:
> > -       debugfs_remove_recursive(pp_debugfs_dir);
> > -       return rc;
> > +       return ret;
> >  }
> >  module_init(pp_init);
> >
> >  static void __exit pp_exit(void)
> >  {
> >         ntb_unregister_client(&pp_client);
> > -       debugfs_remove_recursive(pp_debugfs_dir);
> > +       debugfs_remove_recursive(pp_dbgfs_topdir);
> >  }
> >  module_exit(pp_exit);
> > +
> > --
> > 2.12.0
> >
