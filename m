Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf0-x234.google.com (mail-lf0-x234.google.com. [2a00:1450:4010:c07::234])
        by gmr-mx.google.com with ESMTPS id n12-v6si87187lja.4.2018.05.11.15.39.21
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 May 2018 15:39:21 -0700 (PDT)
Received: by mail-lf0-x234.google.com with SMTP id r25-v6so10025377lfd.1
        for <linux-ntb@googlegroups.com>; Fri, 11 May 2018 15:39:21 -0700 (PDT)
Return-Path: <fancer.lancer@gmail.com>
Date: Sat, 12 May 2018 01:39:25 +0300
From: Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH v2 0/4] NTB : Introduce message library
Message-ID: <20180511223925.GB24717@mobilestation>
References: <1525634420-19370-1-git-send-email-araut@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525634420-19370-1-git-send-email-araut@codeaurora.org>
To: Atul Raut <araut@codeaurora.org>
Cc: linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

Hello Atul,
Thanks for the patchset and work you've done in the framework of it.
We really appreciate this.

First of all I'll give you a generic review of the whole library design.
The specific comments will be added within the particular code.

As I already told you in the chat, the ntb_perf driver can be used as a basis
or as a reference for the whole library:

>> [2018-03-14 04:54:10] <fancer> rauji: regarding the library. You can find the
>> reference code in the new ntb_perf driver in the section named service. At least
>> it is the basic functionality which implements the cross-interface communications.
>> [2018-03-14 04:58:00] <fancer> Regarding the whole library interface and ntb.h
>> alterations I'd strongly recommend to discuss the architecture here so to avoid
>> an excess patchets iterations and make all of us happy about the change)
>> [2018-03-14 20:34:02] <rauji> hi fancer : yes
>> [2018-03-14 20:34:10] <rauji> am using ntb_perf as reference and already implemented
>> it, right now just refactoring the code
>> [2018-03-14 20:40:11] <rauji> fancer: I am following your suggestions so there wont
>> be any issues with architectural changes,

Definitely I didn't tell you just to copy-and-paste the whole service functions
from ntb_perf. One of the ntb_perf driver purpose was to create an example of
possible cross-interface communication code, which turned to be the "service"
subsystem of the driver. My idea was to have it used as a proof of concept and
a stably working code for the future cross-iface library. The library is going
to be a part of the NTB API itself - a part of the generic interface for the
whole NTB subsystem, so I recommended to have the design discussed first, otherwise
you'd risk to face review requests which would cause a serious code refactoring.
As far as I can see, it turned out to be true.

The whole idea of the cross-iface library was to encapsulate the
scratchpad/message registers interface, so to have a generic way of data
exchange between NTB peers before NTB link is actually initialized and up for
MW usage. The main purpose, of course, was to send/receive memory-window
information across, but in general the hardware doesn't prevent it from
sending any type of data. A lot of scenario come to my mind, when the random
data exchange can be utilized before actual MW initialization. For instance
imagine if you first needed to identify a peer (by using an rsa-key or
something else) before you'd sent a pure memory region base address.

Even though this more like a "philosophic" part, but this time Logan's opinion
happens to agree with the design we discussed a while ago with the rest of the
NTB maintainers:

1) Send/receive random data by means of the library 
2) Use either Scratchpads or Message registers for data exchange. If both
types of registers are available (like in case of IDT 89HPES8NT2) it's better
to use the Message ones, since they are better suitable for the library concept.
3) Use something like the following methods as the library interface:
- ntb_lib_exch_capability(ntb_dev) - return the maximum length of the data
array, which can be sent over the NTB device (or an error).
- ntb_lib_exch_init(ntb_dev, ntb_data_recv) - initialize the Cross-Iface library of
NTB device. It initializes the library for the specified NTB-device and sets the
callback method to have the client driver notified when an incoming data is
available,
- ntb_lib_exch_clear(ntb_dev) - clear the library: discard the library descriptor,
make sure there is no data pending to send/retrieve, the callback handler can be
safely discarded,
- ntb_lib_exch_send_sync(ntb_dev, pidx, len, data) - send data array of the passed
length over the NTB device using the Cross-Iface library. The method can sleep, so
can't be used in the atomic context,
- ntb_lib_exch_send_async(ntb_dev, pidx, len, data, callback) - the same function
as before, but can be executed with IRQs disable. When data is sent, the
callback method is executed for instance to free the memory allocated for the data.
- ntb_data_recv(ntb_dev, pidx, len, data) - callback method passed to the
ntb_lib_exch_init() function and called when new data arrived from the peer with
pidx index.

* the naming is of course discussable as well as the whole design, since we
were talking about it nearly 10 months ago.

Here are some notes personally from me with a suggestion of the design specifics:
- I'd add a race-protected pointer to the Cross-Iface library descriptor
(something like struct ntb_lib_exch) in the ntb_dev structure and have it
dynamically allocated in the ntb_lib_exch_init(). This way we wouldn't waste
a memory in case if client driver didn't use the library
- I'd declare the data type being u8 instead of dword (definitely not u64).
- Despite of the ntb_perf service subsystem design, I would better use pure
Scratchpads for the library functions implementation without Doorbell
utilization. The only drawback of this is to have one byte of some
Scratchpad register being reserved to be used for full/empty status.
Additional there must be a status checking work-thread running to poll
the status.

There are also additional notes from me about the library code in general:
1) Use ntb_-prefix in all the functions/types within NTB API including the library.
It is something like an unspoken API convention, which as you can see is followed
all over the NTB API code.
2) I'd suggest to move the library code into a separate directory:
drivers/ntb/lib/exchange.c
and create a separate header file in:
include/linux/ntb_lib_exchange.h
This way we'd have a special place to put an abstractive libraries like this
one and for future ones, for instance, for possible scratchpads emulation
library and so on.

Atul, if you refactored your code, so it would have fitted something similar to
the design presented here, it would be definitely accepted (with possible minor
code alterations=)).

Regards,
-Sergey

On Sun, May 06, 2018 at 12:20:16PM -0700, Atul Raut <araut@codeaurora.org> wrote:
> Hi All,
> 
> This is v2 of cleanup series, where have enabled support to ntb_transport layer
> for message register based devices. Refactor ntb_perf module to get library
> out of it, so that the other client module can make use of it.
> 
> This cleanup addresses some of comments by Allen and Dave.
> 
> Thanks & Regards,
> Atul Raut
> 
> Atul Raut (4):
>   NTB : Introduce message library
>   NTB :  Add message library NTB API
>   NTB : Modification to ntb_perf module
>   NTB : Add support to message registers based devices
> 
>  drivers/ntb/ntb.c           | 222 +++++++++++++++++++++++++++
>  drivers/ntb/ntb_transport.c | 357 ++++++++++++++++++++++++++++++++------------
>  drivers/ntb/test/ntb_perf.c | 347 +++++-------------------------------------
>  include/linux/ntb.h         | 163 ++++++++++++++++++++
>  4 files changed, 685 insertions(+), 404 deletions(-)
> 
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/1525634420-19370-1-git-send-email-araut%40codeaurora.org.
> For more options, visit https://groups.google.com/d/optout.
