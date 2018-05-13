Return-Path: <allenbh@gmail.com>
Received: from mail-yb0-x233.google.com (mail-yb0-x233.google.com. [2607:f8b0:4002:c09::233])
        by gmr-mx.google.com with ESMTPS id h10-v6si1021688plr.3.2018.05.12.17.25.52
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 May 2018 17:25:52 -0700 (PDT)
Received: by mail-yb0-x233.google.com with SMTP id 140-v6so3036413ybc.9
        for <linux-ntb@googlegroups.com>; Sat, 12 May 2018 17:25:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180511224401.GA5458@mobilestation>
References: <1525634420-19370-1-git-send-email-araut@codeaurora.org>
 <1525634420-19370-3-git-send-email-araut@codeaurora.org> <20180511224401.GA5458@mobilestation>
From: Allen Hubbe <allenbh@gmail.com>
Date: Sat, 12 May 2018 20:25:50 -0400
Message-ID: <CAJ80sav37tU2XhmuUN6NAA9LK9i2frPK7K87O+Tpqf6=J9gpeA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] NTB : Add message library NTB API
Content-Type: text/plain; charset="UTF-8"
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Atul Raut <araut@codeaurora.org>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On Fri, May 11, 2018 at 6:44 PM, Serge Semin <fancer.lancer@gmail.com> wrote:
> On Sun, May 06, 2018 at 12:20:18PM -0700, Atul Raut <araut@codeaurora.org> wrote:
>>> Allen Hubbe
>>> Maybe one try, or msg_tries is a parameter instead of constant.
>
> Allen, there can't be just one try. Imagine you've sent some data to a peer and made it
> being notified of incoming data pending in the scratchpad/message registers. Then
> the peer handler starts fetching the data from the registers while you or some
> other peer tries to send data there before the peer finished the retrieval operation.
> In this case you'd need to perform several retries before giving up and return
> something like -EAGAIN. As I suggested before, it might be better to move number
> of retries parameter definition to the kernel menuconfig.

Making it configurable just seems like a convenient way to blame the
user if there is a problem.  It returned -EAGAIN?  You didn't
configure the wait long enough.  It hung your os and spewed warnings
to dmesg?  Configured the wait to be too long.

>
>> +             if (!ntb_link_is_up(ntb, NULL, NULL))
>> +                     return -ENOLINK;
>> +
>> +             sts = ntb_peer_spad_read(ntb, pidx,
>> +                                      NT_SPAD_CMD(gidx));
>
>>> Allen Hubbe
>>> Can it be done without reading peer spads?
>
> Alas, it can't within the current communication layer design. We need to check
> the status of the sent data. When the peer marked it as read, only then we can
> send a next portion of pending outbound data.

Just trying to avoid a read across the bus between two NTBs.  I get
that the peer needs to ack the message before the spads can be
overwritten.

Focusing on the command spad, will any use case really have 2^32
commands?  Can we spare two bits?  Let one bit be the command sequence
number (zero or one), and the other bit be the remote command ack
number (zero or one).

Sending a command: flip the sequence number bit from the previous
command, leave the ack bit alone, and write the command number in the
rest of the bits.

Receiving a command: did the sequence number bit change?  If so,
service the command, and then acknowledge.  Acknowledge is like
sending a command because the write destination is the command spad,
but flip the ack bit only: leave the current sequence bit and command
number alone.

Following is an imagined implementation for spads.  For msg registers,
instead of seq/ack bits, it would check the status register after
trying to send the first data.  For send_ack(), msg registers would
clear the status.  To make it work for both msg and spads, just
require that cmd_num never have seq/ack bits set.

spinlock_t cmd_lock;
u32 cmd_val;

enum {
        CMD_SEQ_BIT = BIT(30),
        CMD_ACK_BIT = BIT(31),
        CMD_NUM_MASK = ~CMD_SEQ_BIT & ~CMD_ACK_BIT
};

int send_cmd(u32 cmd_num, void *data, size_t size)
{
        u32 ack_val;
        int rc;

        if (WARN_ON(cmd_num & ~CMD_NUM_MASK))
                return -EINVAL;

        spin_lock(cmd_lock);

        ack_val = spad_read(cmd_spad);

        rc = -EAGAIN;
        if (!(ack_val & CMD_ACK_BIT) == !(cmd_val & CMD_SEQ_BIT))
                goto out;

        cmd_val ^= CMD_SEQ_BIT;
        cmd_val &= ~CMD_NUM_MASK;
        cmd_val |= CMD_NUM_MASK & cmd_num;

        peer_spad_write(data_spad_0, cmd_data);
        peer_spad_write(data_spad_1, cmd_data + 4);
        ... and so on ...

        peer_spad_write(cmd_spad, cmd_val);
        peer_db_set(cmd_doorbell_bit);

        rc = 0;

out:
        spin_unlock(cmd_lock);

        return rc;
}

void send_ack(void)
{
        spin_lock(cmd_lock);
        cmd_val ^= CMD_ACK_BIT;
        spad_write(cmd_spad, cmd_val);
        spin_unlock(cmd_lock);
}

>
>> +             if (sts != NT_CMD_INVAL) {
>> +                     usleep_range(MSG_UDELAY_LOW, MSG_UDELAY_HIGH);
>
>>> Allen Hubbe
>>> Even though it doesn't sleep, the delay limits what context this can
>>> reasonably be called in.  Imagine if any kind of interrupts were
>>> disabled in the caller (eg rcu_read_lock or spin_lock_bh), and then
>>> the call in the ntb api delays the caller for 1s, that's not very
>>> nice.
>>> How bad would it be to take out the retries, or would it just stop working.
>>> If taking out the retries breaks it, is there a better way to design
>>> the whole thing to be less fragile with respect to timing?  Or maybe
>>> schedule_timeout_interruptible would be ok, and just require the
>>> caller to be in a context where that is allowed.
>
> Allen, since we have just one channel of communication and have to wait while
> a peer reads the data from inbound registers, I don't see other choice but
> either to use the status polling design or specifically allocate some Doorbell
> bits for notifications (Message registers case doesn't need it). I'd rather
> stay with polling case, since it is simpler, consumes less hardware resources,
> and well fits both Scratchpad and Message registers hardware. See the comment
> in the cover letter with the design suggestion.

Since my main issue with this is the retry, it's rightly on me to
suggest an alternative approach.

Instead, write the message to a ring buffer of messages to send, then
schedule some delayed work struct to actually send the message.  Let
the work struct be rescheduled with some delay, as long as the buffer
is not empty.  Each retry may or may not send the message, depending
on the ack or availability of the msg register.  If it doesn't send,
just reschedule the work until it does.

size_t msg_max_size()
{
        // depends on how many spads / msg registers the device has
that are not in use for some other purpose like link management.
}

int post_msg(u32 cmd_num, void *data, size_t size, bool can_wait)
{
        int rc;

        if (cmd_num & ~CMD_NUM_MASK)
                return -EINVAL;

        if (size > msg_max_size())
                return -EINVAL;

        spin_lock(waitq.lock);

        rc = -EAGAIN;
        if (can_wait)
                wait_event_interruptible(waitq, queue is not full);
        else if (queue is full)
                goto out;

        enqueue(the command and data);
        schedule_delayed_work(cmd_ws, 0);

        rc = 0;

out:
        spin_unlock(waitq.lock);

        return rc;
}

void cmd_work(ws)
{
        int rc;

        spin_lock(waitq.lock);

        if (queue is empty)
                goto out;

        rc = send_cmd(next in the queue);
        if (!rc) {
                advance(the queue);
                wake_up(waitq);
        } else if (rc != -EAGAIN) {
                goto out;
        }

        if (! queue is empty)
                schedule_delayed_work(cmd_ws, CMD_DELAY);

out:
        spin_unlock(waitq.lock);
}

No need to make the delay configurable, just pick something
reasonable.  If anything is configurable, let it be the size of the
ring buffer.  Or let the caller provide some msg stucture that we can
add to a list, instead of a ring buffer.
