Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf0-x242.google.com (mail-lf0-x242.google.com. [2a00:1450:4010:c07::242])
        by gmr-mx.google.com with ESMTPS id a22si218105wmg.0.2017.12.05.12.53.56
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Dec 2017 12:53:56 -0800 (PST)
Received: by mail-lf0-x242.google.com with SMTP id e137so1858387lfg.5
        for <linux-ntb@googlegroups.com>; Tue, 05 Dec 2017 12:53:56 -0800 (PST)
Return-Path: <fancer.lancer@gmail.com>
Date: Tue, 5 Dec 2017 23:54:02 +0300
From: Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH v2 01/15] NTB: Rename NTB messaging API methods
Message-ID: <20171205205402.GJ1701@mobilestation>
References: <20171203191736.3399-1-fancer.lancer@gmail.com>
 <20171203191736.3399-2-fancer.lancer@gmail.com>
 <CAPoiz9xTRToABuuop77j7GcsLaZjYWD1Ght9kGc-Bo9A0w5ddw@mail.gmail.com>
 <20171205173154.GB1701@mobilestation>
 <CAPoiz9zcDS6Au4xSTAxgC7v3ghWX6WX+6AV5=zd78q4q2Fqovw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPoiz9zcDS6Au4xSTAxgC7v3ghWX6WX+6AV5=zd78q4q2Fqovw@mail.gmail.com>
To: Jon Mason <jdmason@kudzu.us>
Cc: Dave Jiang <dave.jiang@intel.com>, "Hubbe, Allen" <Allen.Hubbe@emc.com>, "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>, "Yu, Xiangliang" <Xiangliang.Yu@amd.com>, Gary R Hook <gary.hook@amd.com>, Sergey.Semin@t-platforms.ru, linux-ntb <linux-ntb@googlegroups.com>, linux-kernel <linux-kernel@vger.kernel.org>
List-ID: <linux-ntb.googlegroups.com>

On Tue, Dec 05, 2017 at 01:07:26PM -0500, Jon Mason <jdmason@kudzu.us> wrote:
> On Tue, Dec 5, 2017 at 12:31 PM, Serge Semin <fancer.lancer@gmail.com> wrote:
> > On Tue, Dec 05, 2017 at 11:49:10AM -0500, Jon Mason <jdmason@kudzu.us> wrote:
> >> On Sun, Dec 3, 2017 at 2:17 PM, Serge Semin <fancer.lancer@gmail.com> wrote:
> >> > There is a common methods signature form used over all the NTB API
> >> > like functions naming scheme, arguments names and order, etc.
> >> > Recently added NTB messaging API IO callbacks were named a bit
> >> > different so should be renamed to be in compliance with the rest
> >> > of the API. The changes are made in a way so the developers won't
> >> > be able to compile their code without being informed by the compiler.
> >> >
> >> > Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> >> > ---
> >> >  drivers/ntb/hw/idt/ntb_hw_idt.c | 27 ++++++++++++---------------
> >> >  include/linux/ntb.h             | 34 ++++++++++++++++------------------
> >> >  2 files changed, 28 insertions(+), 33 deletions(-)
> >> >
> >> > diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
> >> > index 0cd79f367f7c..6fb87c0f0d97 100644
> >> > --- a/drivers/ntb/hw/idt/ntb_hw_idt.c
> >> > +++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
> >> > @@ -1744,20 +1744,19 @@ static int idt_ntb_msg_clear_mask(struct ntb_dev *ntb, u64 mask_bits)
> >> >   * idt_ntb_msg_read() - read message register with specified index
> >> >   *                     (NTB API callback)
> >> >   * @ntb:       NTB device context.
> >> > - * @midx:      Message register index
> >> >   * @pidx:      OUT - Port index of peer device a message retrieved from
> >> > - * @msg:       OUT - Data
> >> > + * @midx:      Message register index
> >> >   *
> >> >   * Read data from the specified message register and source register.
> >> >   *
> >> > - * Return: zero on success, negative error if invalid argument passed.
> >> > + * Return: inbound message register value.
> >> >   */
> >> > -static int idt_ntb_msg_read(struct ntb_dev *ntb, int midx, int *pidx, u32 *msg)
> >> > +static u32 idt_ntb_msg_read(struct ntb_dev *ntb, int *pidx, int midx)
> >> >  {
> >> >         struct idt_ntb_dev *ndev = to_ndev_ntb(ntb);
> >> >
> >> >         if (midx < 0 || IDT_MSG_CNT <= midx)
> >> > -               return -EINVAL;
> >> > +               return (u32)-1;
> >>
> >> Please don't do this.  If this is an error return standard error
> >> number.  And why are we casting to an unsigned int now?
> >>
> >
> > We discussed these changes on the v1 series. Additionally I asked similar
> > question sometime ago even before the patchset was introduced.
> > This patch is made to provide the Message interface similar to the Scratchpad
> > one. I didn't introduce anything new or unjustified. As you can see the
> > spad_read/peer_spad_read methods return u32 type too. As well as the
> > Intel/AMD callbacks. The functions are intentionally made to return FFs
> > in case if some of the passed arguments get out from the allowed limits.
> > In such circumstances the return value emulates a situation like if user would
> > reference an invalid PCIe MMIO address. Since the 32-bits register can in general
> > have any value including -errno ones, then returning an error within the NTB API
> > would be incorrect. I remember Allen described it this way.
> > Nobody argued about it last time. If you think it's incorrect, then it should be
> > changed in both Scratchpad and Message register interfaces.
> 
> Just because no one said anything before, doesn't mean it's
> acceptable.  I think that is the official Linux code review mantra ;-)
> 
> Okay, if we are going to do it this way, then return ~0 instead.  At
> least that way there is no ugly cast.
> 

Ok. I'll replace it with ~(u32)0.

> >
> >> >
> >> >         /* Retrieve source port index of the message */
> >> >         if (pidx != NULL) {
> >> > @@ -1772,18 +1771,15 @@ static int idt_ntb_msg_read(struct ntb_dev *ntb, int midx, int *pidx, u32 *msg)
> >> >         }
> >> >
> >> >         /* Retrieve data of the corresponding message register */
> >> > -       if (msg != NULL)
> >> > -               *msg = idt_nt_read(ndev, ntdata_tbl.msgs[midx].in);
> >> > -
> >> > -       return 0;
> >> > +       return idt_nt_read(ndev, ntdata_tbl.msgs[midx].in);
> >> >  }
> >> >
> >> >  /*
> >> > - * idt_ntb_msg_write() - write data to the specified message register
> >> > - *                      (NTB API callback)
> >> > + * idt_ntb_peer_msg_write() - write data to the specified message register
> >> > + *                           (NTB API callback)
> >> >   * @ntb:       NTB device context.
> >> > - * @midx:      Message register index
> >> >   * @pidx:      Port index of peer device a message being sent to
> >> > + * @midx:      Message register index
> >> >   * @msg:       Data to send
> >> >   *
> >> >   * Just try to send data to a peer. Message status register should be
> >> > @@ -1791,7 +1787,8 @@ static int idt_ntb_msg_read(struct ntb_dev *ntb, int midx, int *pidx, u32 *msg)
> >> >   *
> >> >   * Return: zero on success, negative error if invalid argument passed.
> >> >   */
> >> > -static int idt_ntb_msg_write(struct ntb_dev *ntb, int midx, int pidx, u32 msg)
> >> > +static int idt_ntb_peer_msg_write(struct ntb_dev *ntb, int pidx, int midx,
> >> > +                                 u32 msg)
> >> >  {
> >> >         struct idt_ntb_dev *ndev = to_ndev_ntb(ntb);
> >> >         unsigned long irqflags;
> >> > @@ -2058,7 +2055,7 @@ static const struct ntb_dev_ops idt_ntb_ops = {
> >> >         .msg_set_mask           = idt_ntb_msg_set_mask,
> >> >         .msg_clear_mask         = idt_ntb_msg_clear_mask,
> >> >         .msg_read               = idt_ntb_msg_read,
> >> > -       .msg_write              = idt_ntb_msg_write
> >> > +       .peer_msg_write         = idt_ntb_peer_msg_write
> >> >  };
> >> >
> >> >  /*
> >> > @@ -2269,7 +2266,7 @@ static ssize_t idt_dbgfs_info_read(struct file *filp, char __user *ubuf,
> >> >                  "Message data:\n");
> >> >         for (idx = 0; idx < IDT_MSG_CNT; idx++) {
> >> >                 int src;
> >> > -               (void)idt_ntb_msg_read(&ndev->ntb, idx, &src, &data);
> >> > +               data = idt_ntb_msg_read(&ndev->ntb, &src, idx);
> >> >                 off += scnprintf(strbuf + off, size - off,
> >> >                         "\t%hhu. 0x%08x from peer %hhu (Port %hhu)\n",
> >> >                         idx, data, src, ndev->peers[src].port);
> >> > diff --git a/include/linux/ntb.h b/include/linux/ntb.h
> >> > index c308964777eb..c1646f2c6344 100644
> >> > --- a/include/linux/ntb.h
> >> > +++ b/include/linux/ntb.h
> >> > @@ -250,7 +250,7 @@ static inline int ntb_ctx_ops_is_valid(const struct ntb_ctx_ops *ops)
> >> >   * @msg_set_mask:      See ntb_msg_set_mask().
> >> >   * @msg_clear_mask:    See ntb_msg_clear_mask().
> >> >   * @msg_read:          See ntb_msg_read().
> >> > - * @msg_write:         See ntb_msg_write().
> >> > + * @peer_msg_write:    See ntb_peer_msg_write().
> >> >   */
> >> >  struct ntb_dev_ops {
> >> >         int (*port_number)(struct ntb_dev *ntb);
> >> > @@ -321,8 +321,8 @@ struct ntb_dev_ops {
> >> >         int (*msg_clear_sts)(struct ntb_dev *ntb, u64 sts_bits);
> >> >         int (*msg_set_mask)(struct ntb_dev *ntb, u64 mask_bits);
> >> >         int (*msg_clear_mask)(struct ntb_dev *ntb, u64 mask_bits);
> >> > -       int (*msg_read)(struct ntb_dev *ntb, int midx, int *pidx, u32 *msg);
> >> > -       int (*msg_write)(struct ntb_dev *ntb, int midx, int pidx, u32 msg);
> >> > +       u32 (*msg_read)(struct ntb_dev *ntb, int *pidx, int midx);
> >> > +       int (*peer_msg_write)(struct ntb_dev *ntb, int pidx, int midx, u32 msg);
> >> >  };
> >> >
> >> >  static inline int ntb_dev_ops_is_valid(const struct ntb_dev_ops *ops)
> >> > @@ -384,7 +384,7 @@ static inline int ntb_dev_ops_is_valid(const struct ntb_dev_ops *ops)
> >> >                 /* !ops->msg_set_mask == !ops->msg_count        && */
> >> >                 /* !ops->msg_clear_mask == !ops->msg_count      && */
> >> >                 !ops->msg_read == !ops->msg_count               &&
> >> > -               !ops->msg_write == !ops->msg_count              &&
> >> > +               !ops->peer_msg_write == !ops->msg_count         &&
> >> >                 1;
> >> >  }
> >> >
> >> > @@ -1459,31 +1459,29 @@ static inline int ntb_msg_clear_mask(struct ntb_dev *ntb, u64 mask_bits)
> >> >  }
> >> >
> >> >  /**
> >> > - * ntb_msg_read() - read message register with specified index
> >> > + * ntb_msg_read() - read inbound message register with specified index
> >> >   * @ntb:       NTB device context.
> >> > - * @midx:      Message register index
> >> >   * @pidx:      OUT - Port index of peer device a message retrieved from
> >> > - * @msg:       OUT - Data
> >> > + * @midx:      Message register index
> >> >   *
> >> >   * Read data from the specified message register. Source port index of a
> >> >   * message is retrieved as well.
> >> >   *
> >> > - * Return: Zero on success, otherwise a negative error number.
> >> > + * Return: The value of the inbound message register.
> >> >   */
> >> > -static inline int ntb_msg_read(struct ntb_dev *ntb, int midx, int *pidx,
> >> > -                              u32 *msg)
> >> > +static inline u32 ntb_msg_read(struct ntb_dev *ntb, int *pidx, int midx)
> >> >  {
> >> >         if (!ntb->ops->msg_read)
> >> > -               return -EINVAL;
> >> > +               return ~(u32)0;
> >>
> >> Same here but in a different way.  Please revert this.
> >>
> >
> > Please see the comment above.
> >
> >> >
> >> > -       return ntb->ops->msg_read(ntb, midx, pidx, msg);
> >> > +       return ntb->ops->msg_read(ntb, pidx, midx);
> >> >  }
> >> >
> >> >  /**
> >> > - * ntb_msg_write() - write data to the specified message register
> >> > + * ntb_peer_msg_write() - write data to the specified peer message register
> >> >   * @ntb:       NTB device context.
> >> > - * @midx:      Message register index
> >> >   * @pidx:      Port index of peer device a message being sent to
> >> > + * @midx:      Message register index
> >> >   * @msg:       Data to send
> >> >   *
> >> >   * Send data to a specified peer device using the defined message register.
> >> > @@ -1492,13 +1490,13 @@ static inline int ntb_msg_read(struct ntb_dev *ntb, int midx, int *pidx,
> >> >   *
> >> >   * Return: Zero on success, otherwise a negative error number.
> >> >   */
> >> > -static inline int ntb_msg_write(struct ntb_dev *ntb, int midx, int pidx,
> >> > -                               u32 msg)
> >> > +static inline int ntb_peer_msg_write(struct ntb_dev *ntb, int pidx, int midx,
> >> > +                                    u32 msg)
> >> >  {
> >> > -       if (!ntb->ops->msg_write)
> >> > +       if (!ntb->ops->peer_msg_write)
> >> >                 return -EINVAL;
> >> >
> >> > -       return ntb->ops->msg_write(ntb, midx, pidx, msg);
> >> > +       return ntb->ops->peer_msg_write(ntb, pidx, midx, msg);
> >> >  }
> >> >
> >> >  #endif
> >> > --
> >> > 2.12.0
> >> >
> >>
> >> --
> >> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> >> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> >> To post to this group, send email to linux-ntb@googlegroups.com.
> >> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/CAPoiz9xTRToABuuop77j7GcsLaZjYWD1Ght9kGc-Bo9A0w5ddw%40mail.gmail.com.
> >> For more options, visit https://groups.google.com/d/optout.
