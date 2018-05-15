Return-Path: <allenbh@gmail.com>
Received: from mail-wr0-x236.google.com (mail-wr0-x236.google.com. [2a00:1450:400c:c0c::236])
        by gmr-mx.google.com with ESMTPS id z2-v6si21913edq.2.2018.05.15.07.21.10
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 May 2018 07:21:10 -0700 (PDT)
Received: by mail-wr0-x236.google.com with SMTP id o4-v6so359167wrm.0
        for <linux-ntb@googlegroups.com>; Tue, 15 May 2018 07:21:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180514231622.GE24717@mobilestation>
References: <1525634420-19370-1-git-send-email-araut@codeaurora.org>
 <1525634420-19370-3-git-send-email-araut@codeaurora.org> <20180511224401.GA5458@mobilestation>
 <CAJ80sav37tU2XhmuUN6NAA9LK9i2frPK7K87O+Tpqf6=J9gpeA@mail.gmail.com> <20180514231622.GE24717@mobilestation>
From: Allen Hubbe <allenbh@gmail.com>
Date: Tue, 15 May 2018 07:21:08 -0700
Message-ID: <CAJ80savnoT=OPOA+oEb2_5BErPjAUsvWuwLPwVWGfEnO88Osiw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] NTB : Add message library NTB API
Content-Type: text/plain; charset="UTF-8"
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Atul Raut <araut@codeaurora.org>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On Mon, May 14, 2018 at 4:16 PM, Serge Semin <fancer.lancer@gmail.com> wrote:
> Emmm, why is it so complicated? As for me, it is easier to have just one status
> bit: 0 - buffer is free to send a data to a peer (can be cleared by the peer only,
> when it is done with reading the data), 1 - buffer contains new data for peer
> (can be set by the local side only when it's done with writing the data).
> So to speak 0->1 event would mean a new data is available and can be read,
> 1->0 event would mean the data has been read and the next portion can be sent.

That can work with shared memory, like a single shared spad.
But using single spad will require a read across the bus when there
are two ntbs.

Would you explain how you intend it to work when two spads are used,
one in each direction?

Node A wants to send the next message, so A writes the message and "1"
to B's spads.
A immediately reads B's response in A's spads, and what if the current
value there is "0"?

Did B read the message and respond "0", or does "0" still mean the
/previous/ message was read?
A can have an incorrect model of B's momentary state (and vice versa).


With seq/ack bits:

A wants to send the next message, so A writes the message and flips
the seq bit in B's spads.
A immediately reads B's reponse in A's spads, but the ack bit is the
same as the previous ack.

Did B read the message: Maybe!
Because the state is distributed, A can't know the momentary state of B.

Eventually, the message will leave node A, and eventually the seq bit
will change in node B's spad, and eventually node B will observe that
change.  The moment that node B acutally observes the change is the
moment the message is received. Node A will not directly observe the
moment that the message is received by B.

Did A receive acknowledgement from B: No.
A can directly observe its own state, and its state is that it did not
observe the ack bit flip.

Eventually, node B will receive the message, and eventually node B
will acknowledge it, and eventually the ack bit will change in node
A's spad, and finally node A will observe that change.  The moment
node A actually observes that change is the moment when the ack is
received.

> If send_cmd() method is used by a dedicated kernel work-thread (according to
> the design it will be since you've used schedule_delayed_work() method to
> submit the handler), then we don't need to have the lock here, since the
> system work-queues aren't reentrant by default. It means this method will be
> executed by only one CPU at a time, so we won't have the race-condition here
> as we do in current Atul code (my code in the ntb_perf also used a dedicated
> non-reentrant kernel work-thread for service work).

The lock is mainly for send_cmd() and send_ack().

The cmd_val is updated in a nonatmoic way, and the updates need to be
written to the peer spad in-order.

> I would also have discarded the peer_db_set() method usage here and created
> a dedicated kernel-thread, which would have polled the status bit of the
> cmd_spad looking for the status bit change from zero to one. It would increase the
> latency of the handler reaction, but would also set the Doorbell resource free
> from using by the library. This is what I meant when said about the polling design.

The msg register behavior is to interrupt the peer.

>> void send_ack(void)
>> {
>>         spin_lock(cmd_lock);
>>         cmd_val ^= CMD_ACK_BIT;
>>         spad_write(cmd_spad, cmd_val);

This is where send_ack() would race with post_msg(), if no lock.

>   ntb_lib_exch_send_sync(ntb_dev, pidx, len, data),
>   ntb_lib_exch_send_async(ntb_dev, pidx, len, data, callback).

Requiring a callback for completion complicates the interface if the
client would rather simply post a message and be done with it.

> They can only be implemented either by using the ring-buffer or the
> messages list design. Synchronous method can sleep waiting for the
> transfer completed.

The ack is so that one message is sent at a time, not to clobber a
previously sent message.

If a response to a message is required for some application, that
could be accomplished by sending a message in the other direction.

> IMHO I'd prefer to have the messages list, since we'd need to save
> the outbound data/length, the "task_struct pointer/completion
> variable and return value of the operation" so to wake up
> the corresponding thread when the transfer completed/failed.

If there is a failure in communication with the peer, that should be a
link event or port/peer event.  It's impossible to know if the message
was delivered or received by the peer after a failure.  Maybe the
message was received, but the ack was lost.

Failure of post_msg() should mean that the message really was not sent
and will not be sent.  Eg, failure to allocate memory for a list
element, or invalid parameter.  If the message was sent, or could be
sent later, then the result of post_send() is success, although the
fate of the message is not determined.

> Using spin_lock and then wait_event()-like method doesn't seem right...

wait_event_interruptible_locked()
wake_up_locked()

this is just pseudocode, not a patch.  in an actual patch, I would hope that:
- cmd_val is not just some global var
- api needs to specify ntb device, peer, etc...
- check error conditions (rc == -EINTR for example)
- actually tested, etc

> As I said I'd prefer to have the messages list. It seems much simpler
> and more convenient to implement the sync and async send-methods.
> As for me the design doesn't eliminate the need of the retry counter.
> I think we need to have a stop-condition when the cmd_work() gives up
> sending a message, sets the -EBUSY return status of the message and
> wakes the corresponding task up. It might be pretty big value occupying
> 5 or even 10 seconds of CPU, but still it would prevent the work-thread
> from being infinitely rescheduled.

Eventually, it should either send the message, or a peer/link event
will indicate a failure in communication with the peer.  The peer/link
event should be sufficient to indicate the failure.  No need for
individual status for each message after it is posted.

I don't think infinite retries is likely.  I'm more concerned with the
retries up to 1sec in a context that can't afford to wait that long.
In any case, infinite retries with a delayed work struct won't hang
the os.
