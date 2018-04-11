Return-Path: <allenbh@gmail.com>
Received: from mail-yw0-x244.google.com (mail-yw0-x244.google.com. [2607:f8b0:4002:c05::244])
        by gmr-mx.google.com with ESMTPS id q6-v6si188398oic.5.2018.04.11.16.24.41
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Apr 2018 16:24:41 -0700 (PDT)
Received: by mail-yw0-x244.google.com with SMTP id i187so1135813ywd.10
        for <linux-ntb@googlegroups.com>; Wed, 11 Apr 2018 16:24:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180410004822.GA6040@codeaurora.org>
References: <20180410004822.GA6040@codeaurora.org>
From: Allen Hubbe <allenbh@gmail.com>
Date: Wed, 11 Apr 2018 19:24:40 -0400
Message-ID: <CAJ80sauVAeFLfMMQxqnCThUZnYJ1A7Kvy=UogPMe_kWCu_Dw9w@mail.gmail.com>
Subject: Re: [PATCH] NTB: Add support to message registers based devices
Content-Type: text/plain; charset="UTF-8"
To: Atul Raut <araut@codeaurora.org>
Cc: linux-ntb@googlegroups.com, fancer.lancer@gmail.com, Jon Mason <jdmason@kudzu.us>, dave.jiang@intel.com, atulraut17@gmail.com, rauji.raut@gmail.com
List-ID: <linux-ntb.googlegroups.com>

On Mon, Apr 9, 2018 at 8:48 PM, Atul Raut <araut@codeaurora.org> wrote:
>
> Hi All,
>
> I have added the support to the ntb_transport layer for
> message registers(e.g. IDT) based devices.
> Also split ntb_perf module to get library out of it, so that
> other client can make use of it.
>
> Regard,
> Atul Raut
>
> NTB transport driver works only with Scartchpads based devices.
> This patch add support to devices which uses Message registers
> for data exchange.
> Split ntb_perf module to have common code as library which all
> clients can make used of it.
>
> Signed-off-by: Atul Raut <araut@codeaurora.org>
> ---
>  drivers/ntb/ntb_transport.c | 356 +++++++++++++++++++++++++++++-----------
>  drivers/ntb/test/ntb_perf.c | 347 +++++----------------------------------
>  include/linux/ntb.h         | 385 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 684 insertions(+), 404 deletions(-)
>

I started review with ntb.h, not looked at transport or perf yet.
Dave's suggestion to split is good.

> diff --git a/include/linux/ntb.h b/include/linux/ntb.h
> index 181d166..709b7ee 100644
> --- a/include/linux/ntb.h
> +++ b/include/linux/ntb.h
> @@ -58,6 +58,8 @@
>
>  #include <linux/completion.h>
>  #include <linux/device.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
>
>  struct ntb_client;
>  struct ntb_dev;
> @@ -163,6 +165,56 @@ enum ntb_default_port {
>  #define NTB_DEF_PEER_CNT       (1)
>  #define NTB_DEF_PEER_IDX       (0)
>
> +enum nt_cmd {
> +       NT_CMD_INVAL = -1,/* invalid spad command */
> +       NT_CMD_SSIZE = 0, /* send out buffer size */
> +       NT_CMD_RSIZE = 1, /* recv in  buffer size */
> +       NT_CMD_SXLAT = 2, /* send in  buffer xlat */
> +       NT_CMD_RXLAT = 3, /* recv out buffer xlat */
> +       NT_CMD_CLEAR = 4, /* clear allocated memory */
> +       NT_STS_DONE  = 5, /* init is done */
> +       NT_STS_LNKUP = 6, /* link up state flag */
> +       NT_QP_LINKS        = 7, /* available QP link */
> +       NT_CMD_NUM_MWS        = 8, /* number of memory windows */
> +       NT_CMD_NUM_QPS        = 9, /* number of QP */
> +       NT_CMD_NTB_VERSION    = 10, /* ntb version */
> +};
> +
> +struct msg_type {
> +/* Scratchpad/Message IO operations */
> +       int (*cmd_send)(struct ntb_dev *nt, int pidx, enum nt_cmd cmd,
> +                       int cmd_wid, u64 data);
> +       int (*cmd_recv)(struct ntb_dev *nt, int *pidx, enum nt_cmd *cmd,
> +                       int *cmd_wid, u64 *data);
> +};
> +
> +#define MSG_TRIES              500
> +#define MSG_UDELAY_LOW         1000
> +#define MSG_UDELAY_HIGH                2000

500 * 2000us = 1s is a long delay for a caller that might not have the
luxury of being able to wait.

> +
> +/**
> + * Scratchpads-base commands interface
> + */
> +#define NT_SPAD_CNT(_pcnt) \
> +       (3*((_pcnt) + 1))
> +#define NT_SPAD_CMD(_gidx) \
> +       (3*(_gidx))
> +#define NT_SPAD_LDATA(_gidx) \
> +       (3*(_gidx) + 1)
> +#define NT_SPAD_HDATA(_gidx) \
> +       (3*(_gidx) + 2)
> +#define NT_SPAD_NOTIFY(_gidx) \
> +       (BIT_ULL(_gidx))
> +
> +/**
> + * Messages-base commands interface
> + */
> +#define NT_MSG_CMD             0
> +#define NT_MSG_CMD_WID         1
> +#define NT_MSG_LDATA           2
> +#define NT_MSG_HDATA           3
> +#define NT_MSG_CNT             4
> +
>  /**
>   * struct ntb_client_ops - ntb client operations
>   * @probe:             Notify client of a new device.
> @@ -1502,4 +1554,337 @@ static inline int ntb_peer_msg_write(struct ntb_dev *ntb, int pidx, int midx,
>         return ntb->ops->peer_msg_write(ntb, pidx, midx, msg);
>  }
>
> +/**
> + * nt_spad_cmd_send() - send messages to peer using spad register.
> + * @ntb:       NTB device context.
> + * @pidx:      Port index of peer device.
> + * @cmd:       ntb commands.
> + * @cmd_gidx:  Global device index.
> + * @data:      message data.
> + *
> + * Send data to the port specific scratchpad
> + *
> + * Perform predefined number of attempts before give up.
> + * We are sending the data to the port specific scratchpad, so
> + * to prevent a multi-port access race-condition. Additionally
> + * there is no need in local locking since only thread-safe
> + * service work is using this method.
> + *
> + * Set peer db to inform data is ready.
> + *
> + * Return: Zero on success, otherwise an error number.
> + */
> +static int nt_spad_cmd_send(struct ntb_dev *ntb, int pidx, enum nt_cmd cmd,
> +                           int cmd_gidx, u64 data)
> +{
> +       int try;
> +       u32 sts;
> +       int gidx = ntb_port_number(ntb);
> +
> +       dev_dbg(&ntb->dev, "CMD send: %d 0x%llx\n", cmd, data);

vdbg, or not at all.  Probably best to just let the caller log the
message or not.

> +
> +       for (try = 0; try < MSG_TRIES; try++) {

Maybe one try, or msg_tries is a parameter instead of constant.

> +               if (ntb_link_is_up(ntb, NULL, NULL) != 1)
> +                       return -ENOLINK;
> +
> +               sts = ntb_peer_spad_read(ntb, pidx,
> +                                        NT_SPAD_CMD(gidx));

Can it be done without reading peer spads?

> +               if (sts != NT_CMD_INVAL) {
> +                       usleep_range(MSG_UDELAY_LOW, MSG_UDELAY_HIGH);

Even though it doesn't sleep, the delay limits what context this can
reasonably be called in.  Imagine if any kind of interrupts were
disabled in the caller (eg rcu_read_lock or spin_lock_bh), and then
the call in the ntb api delays the caller for 1s, that's not very
nice.

How bad would it be to take out the retries, or would it just stop working.

If taking out the retries breaks it, is there a better way to design
the whole thing to be less fragile with respect to timing?  Or maybe
schedule_timeout_interruptible would be ok, and just require the
caller to be in a context where that is allowed.

> +                       continue;
> +               }
> +
> +               ntb_peer_spad_write(ntb, pidx,
> +                                   NT_SPAD_LDATA(gidx),
> +                                   lower_32_bits(data));
> +               ntb_peer_spad_write(ntb, pidx,
> +                                   NT_SPAD_HDATA(gidx),
> +                                   upper_32_bits(data));
> +               mmiowb();

spad_write is like iowrite32, so writes are ordered without extra mmiowb.

> +               ntb_peer_spad_write(ntb, pidx,
> +                                   NT_SPAD_CMD(gidx),
> +                                   cmd);
> +               mmiowb();
> +               ntb_peer_db_set(ntb, NT_SPAD_NOTIFY(cmd_gidx));
> +
> +               dev_dbg(&ntb->dev, "DB ring peer %#llx\n",
> +                       NT_SPAD_NOTIFY(cmd_gidx));
> +
> +               break;
> +       }
> +
> +       return try < MSG_TRIES ? 0 : -EAGAIN;
> +}

These functions are complex to keep in the header file.

> +
> +/**
> + * nt_spad_cmd_recv() - Receive the messages using spad register.
> + * @ntb:       NTB device context.
> + * @pidx:      Port index of peer device a message being receive
> + * @cmd:       NTB command
> + * @cmd_wid:   Gloable device Index
> + * @data:      Received data
> + *
> + * Clear bits in the peer doorbell register, arming the bits for the next
> + * doorbell.
> + *
> + * We start scanning all over, since cleared DB may have been set
> + * by any peer. Yes, it makes peer with smaller index being
> + * serviced with greater priority, but it's convenient for spad
> + * and message code unification and simplicity.
> + *
> + * Return: Zero on success, otherwise an error number.
> + */
> +static int nt_spad_cmd_recv(struct ntb_dev *ntb, int *pidx,
> +                       enum nt_cmd *cmd, int *cmd_wid, u64 *data)
> +{
> +       u32 val;
> +       int gidx = 0;
> +       int key = ntb_port_number(ntb);
> +
> +       ntb_db_clear(ntb, NT_SPAD_NOTIFY(key));
> +
> +       for (*pidx = 0; *pidx < ntb_peer_port_count(ntb); (*pidx)++, gidx++) {

There could be fairness issues with lower pidx always checked before
higher pidx.  A chatty low-numbered peer could starve a higher
numbered peer.

> +               if ((*pidx) == key)
> +                       ++gidx;
> +
> +               if (ntb_link_is_up(ntb, NULL, NULL) != 1)
> +                       continue;

if (!ntb_link_is_up())

> +
> +               val = ntb_spad_read(ntb, NT_SPAD_CMD(gidx));
> +               if (val == NT_CMD_INVAL)
> +                       continue;
> +
> +               *cmd = val;
> +
> +               val = ntb_spad_read(ntb, NT_SPAD_LDATA(gidx));
> +               *data = val;
> +
> +               val = ntb_spad_read(ntb, NT_SPAD_HDATA(gidx));
> +               *data |= (u64)val << 32;
> +
> +               /* Next command can be retrieved from now */
> +               ntb_spad_write(ntb, NT_SPAD_CMD(gidx),
> +                       NT_CMD_INVAL);
> +
> +               dev_dbg(&ntb->dev, "CMD recv: %d 0x%llx\n", *cmd, *data);

vdbg, or not at all, leave it to the caller.

> +
> +               return 0;
> +       }
> +
> +       return -ENODATA;
> +}
> +
> +/**
> + * nt_msg_cmd_send() - send messages to peer using message register.
> + * @ntb:       NTB device context.
> + * @pidx:      Port index of peer device.
> + * @cmd:       ntb commands.
> + * @cmd_gidx:  Memory window index.
> + * @data:      message data.
> + *
> + * Perform predefined number of attempts before give up. Message
> + * registers are free of race-condition problem when accessed
> + * from different ports, so we don't need splitting registers
> + * by global device index. We also won't have local locking,
> + * since the method is used from service work only.
> + *
> + * Return: Zero on success, otherwise an error number.
> + */
> +static int nt_msg_cmd_send(struct ntb_dev *nt, int pidx, enum nt_cmd cmd,
> +int cmd_wid, u64 data)
> +{
> +       int try, ret;
> +       u64 outbits;
> +
> +       dev_dbg(&nt->dev, "CMD send: %d 0x%llx\n", cmd, data);
> +
> +       outbits = ntb_msg_outbits(nt);
> +       for (try = 0; try < MSG_TRIES; try++) {

Same comment about retry and usleep.

> +               if (ntb_link_is_up(nt, NULL, NULL) == 0)
> +                       return -ENOLINK;
> +
> +               ret = ntb_msg_clear_sts(nt, outbits);
> +               if (ret)
> +                       return ret;
> +
> +               ntb_peer_msg_write(nt, pidx, NT_MSG_LDATA,
> +                       cpu_to_le32(lower_32_bits(data)));
> +

That looks like a race.  Anything stopping two threads from racing,
both clearing sts, and then both writing/overwriting the same msg
register?

> +               if (ntb_msg_read_sts(nt) & outbits) {

And what if the other thread, racing, clears outbits just prior to the read_sts?

Should it be something like:

spin_lock
if (read_sts & outbits)
        unlock and try again;
msg_write first message
spin_unlock

msg_write rest of
msg_write message

> +                       usleep_range(MSG_UDELAY_LOW, MSG_UDELAY_HIGH);
> +                       continue;
> +               }
> +
> +               ntb_peer_msg_write(nt, pidx, NT_MSG_HDATA,
> +                       cpu_to_le32(upper_32_bits(data)));
> +               mmiowb();

msg_write should also be like iowrite imo, and not require extra mmiowb.

> +
> +               ntb_peer_msg_write(nt, pidx, NT_MSG_CMD_WID,
> +                       cpu_to_le32(cmd_wid));
> +
> +               /* This call shall trigger peer message event */
> +               ntb_peer_msg_write(nt, pidx, NT_MSG_CMD,
> +                       cpu_to_le32(cmd));
> +
> +               break;
> +       }
> +
> +       return try < MSG_TRIES ? 0 : -EAGAIN;
> +}
> +
> +/**
> + * nt_msg_cmd_recv() - Receive the messages using message register.
> + * @ntb:       NTB device context.
> + * @pidx:      Port index of peer device a message being receive
> + * @cmd:       NT command
> + * @cmd_wid:   Memory window Index
> + * @data:      Received data
> + *
> + * Get memory window index and data.
> + *
> + * Return: Zero on success, otherwise an error number.
> + */
> +static int nt_msg_cmd_recv(struct ntb_dev *nt, int *pidx,
> +                       enum nt_cmd *cmd, int *cmd_wid, u64 *data)
> +{
> +       u64 inbits;
> +       u32 val;
> +
> +       inbits = ntb_msg_inbits(nt);
> +
> +       if (hweight64(ntb_msg_read_sts(nt) & inbits) < 4)
> +               return -ENODATA;
> +
> +       val = ntb_msg_read(nt, pidx, NT_MSG_CMD);
> +       *cmd = le32_to_cpu(val);
> +
> +       val = ntb_msg_read(nt, pidx, NT_MSG_CMD_WID);
> +       *cmd_wid = le32_to_cpu(val);
> +
> +       val = ntb_msg_read(nt, pidx, NT_MSG_LDATA);
> +       *data = le32_to_cpu(val);
> +
> +       val = ntb_msg_read(nt, pidx, NT_MSG_HDATA);
> +       *data |= (u64)le32_to_cpu(val) << 32;
> +
> +       /* Next command can be retrieved from now */
> +       ntb_msg_clear_sts(nt, inbits);
> +
> +       dev_dbg(&nt->dev, "CMD recv: %d 0x%llx\n", *cmd, *data);
> +
> +       return 0;
> +}
> +
> +/**
> + * nt_enable_messaging() - Enable messaging support.
> + * @ntb:       NTB device context.
> + * @gitx:      Global device Index.
> + *
> + * Check which messaging support to enable
> + *
> + * Return: Zero on success, otherwise an error number.
> + */
> +static int nt_enable_messaging(struct ntb_dev *ndev, int gidx)
> +{
> +       u64 mask, incmd_bit;
> +       int ret, sidx, scnt;
> +
> +       mask = ntb_db_valid_mask(ndev);
> +       (void)ntb_db_set_mask(ndev, mask);
> +
> +       if (ntb_msg_count(ndev) >= NT_MSG_CNT) {
> +               u64 inbits, outbits;
> +
> +               inbits = ntb_msg_inbits(ndev);
> +               outbits = ntb_msg_outbits(ndev);
> +               (void)ntb_msg_set_mask(ndev, inbits | outbits);
> +
> +               incmd_bit = BIT_ULL(__ffs64(inbits));
> +               ret = ntb_msg_clear_mask(ndev, incmd_bit);
> +
> +               dev_dbg(&ndev->dev, "MSG sts unmasked %#llx\n", incmd_bit);
> +       } else {
> +               scnt = ntb_spad_count(ndev);
> +               for (sidx = 0; sidx < scnt; sidx++)
> +                       ntb_spad_write(ndev, sidx, NT_CMD_INVAL);
> +               incmd_bit = NT_SPAD_NOTIFY(gidx);
> +               ret = ntb_db_clear_mask(ndev, incmd_bit);
> +
> +               dev_dbg(&ndev->dev, "DB bits unmasked %#llx\n", incmd_bit);
> +       }
> +       if (ret)
> +               return ret;
> +
> +       return 0;

just return ret;

> +}
> +
> +/**
> + * nt_disable_messaging() - Disable messaging support.
> + * @ntb:       NTB device context.
> + * @gidx:      Global device Index
> + *
> + * Check message type(spad/message) and disable messaging support.
> + *
> + */
> +static void nt_disable_messaging(struct ntb_dev *ndev, int gidx)
> +{
> +       if (ntb_msg_count(ndev) >= NT_MSG_CNT) {
> +               u64 inbits;
> +
> +               inbits = ntb_msg_inbits(ndev);
> +               (void)ntb_msg_set_mask(ndev, inbits);
> +       } else {
> +               (void)ntb_db_set_mask(ndev, NT_SPAD_NOTIFY(gidx));
> +       }
> +
> +}
> +
> +/**
> + * nt_init_messaging() - Enable Messaging
> + * @ntb:       NTB device context.
> + * @msg_ptr:   Handle to function pointers Scratchpad or Message.
> + *
> + *
> + * Enable Scratchpad/Message IO operations.
> + *
> + * Return: Zero on success, otherwise an error number.
> + */
> +static int nt_init_messaging(struct ntb_dev *ndev, struct msg_type *msg_ptr)
> +{
> +       u64 mask;
> +       int pcnt = ntb_peer_port_count(ndev);
> +
> +       if (ntb_peer_mw_count(ndev) < (pcnt + 1)) {
> +               dev_err(&ndev->dev, "Not enough memory windows\n");
> +               return -EINVAL;
> +       }
> +
> +       if (ntb_msg_count(ndev) >= NT_MSG_CNT) {
> +               msg_ptr->cmd_send = nt_msg_cmd_send;
> +               msg_ptr->cmd_recv = nt_msg_cmd_recv;
> +
> +               dev_dbg(&ndev->dev, "Message service initialized\n");
> +
> +               return 0;
> +       }
> +
> +       dev_dbg(&ndev->dev, "Message service unsupported\n");
> +
> +       mask = GENMASK_ULL(pcnt, 0);
> +       if (ntb_spad_count(ndev) >= NT_SPAD_CNT(pcnt) &&
> +           (ntb_db_valid_mask(ndev) & mask) == mask) {
> +               msg_ptr->cmd_send = nt_spad_cmd_send;
> +               msg_ptr->cmd_recv = nt_spad_cmd_recv;
> +
> +               dev_dbg(&ndev->dev, "Scratchpad service initialized\n");
> +
> +               return 0;
> +       }
> +       dev_dbg(&ndev->dev, "Scratchpad service initialized\n");

This dev_dbg looks misplaced.  In general the dev_dbgs seem overkill,
because caller should handle the return value.

> +
> +       dev_err(&ndev->dev, "Command services unsupported\n");
> +
> +       return NULL;

This probably warns about NULL is not an integer.  Ignoring the
warning, NULL == zero, which means this actually returns success.

> +}
> +
>  #endif
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>
