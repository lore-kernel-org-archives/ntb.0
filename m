Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf0-x22b.google.com (mail-lf0-x22b.google.com. [2a00:1450:4010:c07::22b])
        by gmr-mx.google.com with ESMTPS id b17-v6si1365813lfa.2.2018.05.31.15.27.36
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 May 2018 15:27:36 -0700 (PDT)
Received: by mail-lf0-x22b.google.com with SMTP id t134-v6so11984671lff.6
        for <linux-ntb@googlegroups.com>; Thu, 31 May 2018 15:27:36 -0700 (PDT)
Return-Path: <fancer.lancer@gmail.com>
Date: Fri, 1 Jun 2018 01:27:45 +0300
From: Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH v2 2/4] NTB : Add message library NTB API
Message-ID: <20180531222745.GA23739@mobilestation>
References: <1525634420-19370-1-git-send-email-araut@codeaurora.org>
 <1525634420-19370-3-git-send-email-araut@codeaurora.org>
 <20180511224401.GA5458@mobilestation>
 <CAJ80sav37tU2XhmuUN6NAA9LK9i2frPK7K87O+Tpqf6=J9gpeA@mail.gmail.com>
 <20180514231622.GE24717@mobilestation>
 <CAJ80savnoT=OPOA+oEb2_5BErPjAUsvWuwLPwVWGfEnO88Osiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ80savnoT=OPOA+oEb2_5BErPjAUsvWuwLPwVWGfEnO88Osiw@mail.gmail.com>
To: Allen Hubbe <allenbh@gmail.com>
Cc: Atul Raut <araut@codeaurora.org>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On Tue, May 15, 2018 at 07:21:08AM -0700, Allen Hubbe <allenbh@gmail.com> wrote:
> On Mon, May 14, 2018 at 4:16 PM, Serge Semin <fancer.lancer@gmail.com> wrote:
> > Emmm, why is it so complicated? As for me, it is easier to have just one status
> > bit: 0 - buffer is free to send a data to a peer (can be cleared by the peer only,
> > when it is done with reading the data), 1 - buffer contains new data for peer
> > (can be set by the local side only when it's done with writing the data).
> > So to speak 0->1 event would mean a new data is available and can be read,
> > 1->0 event would mean the data has been read and the next portion can be sent.
> 
> That can work with shared memory, like a single shared spad.
> But using single spad will require a read across the bus when there
> are two ntbs.
> 
> Would you explain how you intend it to work when two spads are used,
> one in each direction?
> 
> Node A wants to send the next message, so A writes the message and "1"
> to B's spads.
> A immediately reads B's response in A's spads, and what if the current
> value there is "0"?
> 
> Did B read the message and respond "0", or does "0" still mean the
> /previous/ message was read?
> A can have an incorrect model of B's momentary state (and vice versa).
> 
> 
> With seq/ack bits:
> 
> A wants to send the next message, so A writes the message and flips
> the seq bit in B's spads.
> A immediately reads B's reponse in A's spads, but the ack bit is the
> same as the previous ack.
> 
> Did B read the message: Maybe!
> Because the state is distributed, A can't know the momentary state of B.
> 
> Eventually, the message will leave node A, and eventually the seq bit
> will change in node B's spad, and eventually node B will observe that
> change.  The moment that node B acutally observes the change is the
> moment the message is received. Node A will not directly observe the
> moment that the message is received by B.
> 
> Did A receive acknowledgement from B: No.
> A can directly observe its own state, and its state is that it did not
> observe the ack bit flip.
> 
> Eventually, node B will receive the message, and eventually node B
> will acknowledge it, and eventually the ack bit will change in node
> A's spad, and finally node A will observe that change.  The moment
> node A actually observes that change is the moment when the ack is
> received.
> 

Alright, I saw your point when you explained why the read operation is preferable:
>> allen: read on older platforms, if the remote side crashed and didn't respond
>> to the read, resulted in nmi bringing down the second node too.
We'd better stick with your edition of the sync algo.

> > If send_cmd() method is used by a dedicated kernel work-thread (according to
> > the design it will be since you've used schedule_delayed_work() method to
> > submit the handler), then we don't need to have the lock here, since the
> > system work-queues aren't reentrant by default. It means this method will be
> > executed by only one CPU at a time, so we won't have the race-condition here
> > as we do in current Atul code (my code in the ntb_perf also used a dedicated
> > non-reentrant kernel work-thread for service work).
> 
> The lock is mainly for send_cmd() and send_ack().
> 
> The cmd_val is updated in a nonatmoic way, and the updates need to be
> written to the peer spad in-order.
> 

Yep, spin-lock is necessary since the command scratchpad register is used
for sequence bit and data retrieval acknowledgement. But we don't need to
use it for the whole set of Scratchpads.

> > I would also have discarded the peer_db_set() method usage here and created
> > a dedicated kernel-thread, which would have polled the status bit of the
> > cmd_spad looking for the status bit change from zero to one. It would increase the
> > latency of the handler reaction, but would also set the Doorbell resource free
> > from using by the library. This is what I meant when said about the polling design.
> 
> The msg register behavior is to interrupt the peer.
> 

Yes it is, but the interruption is done by means of Message registers internals,
without Doorbells usage. If we wanna have the library being more portable without
making any limitation on Doorbells usage while the lib activated, in case of
scratchpads it's better to have just a thread, which would check the status
of inbound status byte.

> >> void send_ack(void)
> >> {
> >>         spin_lock(cmd_lock);
> >>         cmd_val ^= CMD_ACK_BIT;
> >>         spad_write(cmd_spad, cmd_val);
> 
> This is where send_ack() would race with post_msg(), if no lock.
> 

You meant peer_spad_write() right? Otherwise we'd get a race condition.

> >   ntb_lib_exch_send_sync(ntb_dev, pidx, len, data),
> >   ntb_lib_exch_send_async(ntb_dev, pidx, len, data, callback).
> 
> Requiring a callback for completion complicates the interface if the
> client would rather simply post a message and be done with it.
> 
> > They can only be implemented either by using the ring-buffer or the
> > messages list design. Synchronous method can sleep waiting for the
> > transfer completed.
> 
> The ack is so that one message is sent at a time, not to clobber a
> previously sent message.
> 
> If a response to a message is required for some application, that
> could be accomplished by sending a message in the other direction.
> 
> > IMHO I'd prefer to have the messages list, since we'd need to save
> > the outbound data/length, the "task_struct pointer/completion
> > variable and return value of the operation" so to wake up
> > the corresponding thread when the transfer completed/failed.
> 
> If there is a failure in communication with the peer, that should be a
> link event or port/peer event.  It's impossible to know if the message
> was delivered or received by the peer after a failure.  Maybe the
> message was received, but the ack was lost.
> 
> Failure of post_msg() should mean that the message really was not sent
> and will not be sent.  Eg, failure to allocate memory for a list
> element, or invalid parameter.  If the message was sent, or could be
> sent later, then the result of post_send() is success, although the
> fate of the message is not determined.
>

I meant to use a completion variable to notify the caller if the message
successfully written to the peer inbound scratchpads/message registers.
I didn't want to create the whole communication protocol. Anyway lets make
the library as simple as possible in this matter for now. The knowledge
of data just written to the peer registers doesn't give much of useful
info. The completion notification of ack retrieval would be much more useful
though, but we can leave it for future development.

I think such long discussion is caused just by misunderstanding. My idea
doesn't differ much from yours, but with a bit different details of 
implementation. For instance, I wouldn't recommend to flip the acknowledge
bit, but just copy the retrieved data sequence bit back to the place of the
ack-bit as acknowledgement. Otherwise on start we'd need to know the initial
value the peer scratchpad ack-bit, which means to read it across the link.
See the pseudo code in the end of this e-mail.

In addition I'd recommend to have an individual list of outbound messages
for each peer port index, since peers are asynchronous domains, which means
they handle the messages independent from each other and got non-intersecting
communication hardware.

> > Using spin_lock and then wait_event()-like method doesn't seem right...
> 
> wait_event_interruptible_locked()
> wake_up_locked()
> 
> this is just pseudocode, not a patch.  in an actual patch, I would hope that:
> - cmd_val is not just some global var
> - api needs to specify ntb device, peer, etc...
> - check error conditions (rc == -EINTR for example)
> - actually tested, etc
> 
> > As I said I'd prefer to have the messages list. It seems much simpler
> > and more convenient to implement the sync and async send-methods.
> > As for me the design doesn't eliminate the need of the retry counter.
> > I think we need to have a stop-condition when the cmd_work() gives up
> > sending a message, sets the -EBUSY return status of the message and
> > wakes the corresponding task up. It might be pretty big value occupying
> > 5 or even 10 seconds of CPU, but still it would prevent the work-thread
> > from being infinitely rescheduled.
> 
> Eventually, it should either send the message, or a peer/link event
> will indicate a failure in communication with the peer.  The peer/link
> event should be sufficient to indicate the failure.  No need for
> individual status for each message after it is posted.
> 
> I don't think infinite retries is likely.  I'm more concerned with the
> retries up to 1sec in a context that can't afford to wait that long.
> In any case, infinite retries with a delayed work struct won't hang
> the os.

Do you suggest to make the library usable only when link is up? If
so we'd need to empty the queues on the link down event and at the
time the library got disabled. Additionally we need to allow the client
to send/recv data only when the link is up.

Here is my pseudo code of possible library interface implementation
(without modifications concerning the link events limitations and
cleanups).

struct msg {
    data;
    list;
}

rwlock_t cmd_lock;
cmd_cache;

init() {
    rwlock_init(cmd_lock);

    cmd = spad_read(CMD_SPAD = 0);

    cmd_cache = ack_to_seq(cmd);
}

/* Use in non-reentrant context (like kernel work-threads) */
send_msg(ntb, pidx, msg)
{
    status = 0;

    cmd = spad_read(ntb, pidx, CMD_SPAD = 0);

    read_lock(cmd_lock);

    if (get_seq(cmd_cache) != get_ack(cmd))
        status = -EAGAIN;

    read_unlock(cmd_lock);

    if (status)
        return status;

    peer_spad_write(ntb, pidx, 1, to_u32(msg->data[3]));
    peer_spad_write(ntb, pidx, 2, to_u32(msg->data[3 + 4]));
    ...

    write_lock(cmd_lock);
    cmd_cache = seq_invert_clear_data(cmd_cache) | three_bytes_to_u32(msg->data);
    peer_spad_write(ntb, pidx, CMD_SPAD, cmd_cache);
    write_unlock(cmd_lock);

    /* If you wanna use Doorbells for peer notification otherwise sequence
     * number inversion can be used as an event for polling thread */
    peer_db_set(CMD_DB);

    return 0;
}

/* Use in non-reentrant context (like DB/Message event handler) */
recv_msg(ntb, pidx, msg)
{
    msg->data[3] = spad_read(ntb, pidx, 1);
    msg->data[3 + 4] = spad_read(ntb, pidx, 2);
    ...
    cmd = spad_read(ntb, pidx, CMD_SPAD);
    msg->data[0] = to_array(cmd);

    /* Following is like Allen's send_ack */
    write_lock(cmd_lock);
    cmd_cache = seq_to_ack(cmd) | clear_ack(cmd_cache);
    peer_spad_write(ntb, pidx, CMD_SPAD, cmd_cache);
    write_unlock(cmd_lock);
}

post_msg(ntb, pidx, data, size, can_wait, callback)
{

    if (size > msg_max_size() || pidx > max_pidx)
        return -EINVAL;

    msg = alloc_and_init_msg(data, size);

    spin_lock(queue(ntb, pidx).lock);
    enqueue(ntb, pidx, msg);
    spin_unlock(queue(ntb, pidx).lock);

    schedule_delayed_work(deliver_work, 0);

    return 0;
}

deliver_work()
{
    for_each_port_index(pidx) {
        for_each_msg_safe(ntb, pidx, msg) {
            spin_lock(queue(ntb, pidx).lock);
            dequeue(ntb, pidx, msg);
            spin_unlock(queue(ntb, pidx).lock);

            rc = send_msg(ntb, pidx, msg);
            if (!rc) {
                free(msg);
            } else {
                spin_lock(queue(ntb, pidx).lock);
                enqueue(ntb, pidx, msg);
                spin_unlock(queue(ntb, pidx).lock);
            }
        }
    }

    if (queues aren't empty)
        schedule_delayed_work(deliver_work, CMD_DELAY);
}

-Sergey
