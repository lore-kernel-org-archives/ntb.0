Return-Path: <dmeyer@gigaio.com>
Received: from mail-ua0-x229.google.com (mail-ua0-x229.google.com. [2607:f8b0:400c:c08::229])
        by gmr-mx.google.com with ESMTPS id q64si815614vkg.3.2017.10.11.11.23.10
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Oct 2017 11:23:10 -0700 (PDT)
Received: by mail-ua0-x229.google.com with SMTP id f46so1637513uae.1
        for <linux-ntb@googlegroups.com>; Wed, 11 Oct 2017 11:23:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171011174114.GA25306@mobilestation>
References: <9aa73260-8b02-4e86-b7d4-9bc3afd745a6@googlegroups.com>
 <000001d341d2$87574f20$9605ed60$@dell.com> <6107eb07-3889-4f1a-ad50-264256772dae@googlegroups.com>
 <38ffd174-b66f-4077-8cdc-679e412242fc@googlegroups.com> <20171011174114.GA25306@mobilestation>
From: D Meyer <dmeyer@gigaio.com>
Date: Wed, 11 Oct 2017 11:23:08 -0700
Message-ID: <CA+GK6enDdDJvqJZ=+PE=HMGuuenKqbS5LWKxFbGDHXzY6TdRSw@mail.gmail.com>
Subject: Re: Is the Scratchpad Implementation Using a LUT Standard?
Content-Type: text/plain; charset="UTF-8"
To: Serge Semin <fancer.lancer@gmail.com>
Cc: lsgunthorpe@gmail.com, linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

On Wed, Oct 11, 2017 at 10:41 AM, Serge Semin <fancer.lancer@gmail.com> wrote:
> On Wed, Oct 11, 2017 at 09:19:20AM -0700, lsgunthorpe@gmail.com <lsgunthorpe@gmail.com> wrote:
>>
>>
>> > Obviously LUTs are a precious resource, and a LUT per peer shared_mw is
>> > expensive. A LUT broken up into many shared_mw is a possibility, though
>> > there is always risk of trashing stuff.
>>
>>
>> Well, as far as I know, switchtec is the only hardware with LUTs. But they
>> aren't that precious a resource. If I remember correctly, switchtec
>> supports up to 128 of them and up to 48 separate partitions so you could
>> easily have 2 LUTs per peer and still have plenty left over to do other
>> things with. And as far as we know now, there is no other use for LUT
>> windows. Thus, I would say, using one per peer is perfectly acceptable.
>>
>
> You are mistaken. IDT PCIe switch have LUT. There are 24 of them available at
> the current hardware for each NTB. All of them are available to be used over
> IDT NTB driver as well as all MWs with direct address translation.
> Additionally It is true to say about just one LUT entry usage per peer, only if
> you got just two NTB-ports available per device. What if you got eight or even more
> of them? In this case you'd need to have as many LUT entries reserved as there are
> peers available to have connections to. In this case reservation doesn't seem so
> inexpensive. As far as I can see from the switchtec brief documents, there can be
> up to 48 NTBs per device. So in this case we'd loose 48 MWs just to have some
> stupid scratchpads, which is, according to your words, a third part of all the LUT
> MWs available to a port.

Gents,

First, thanks to Logan and Serge for lots of great information. Y'all
manage to always remind me I'm drinking from a firehose! ;-)

Serge is thinking along the same lines as I am.

Regarding Switchtec, the 96xG3 part has 512 LUTs per Stack and a stack
can have up to eight NTBs. So for that chip, if I'm starting to grasp
this stuff, a machine with 48 NTBs would mean that on a single Stack,
8 (hosts) x 47 (peers) = 376 LUTs would be used up for each of the 8
to have a shared_mw in its own LUT.

Also, the current hard-coded LUT size is 64 KiB, but that can't remain
that way to have flexibility. If the LUTs were, say 16 MiB, then the
shred_mw LUTs use up a massive part of the BAR space.

Oh... A quick side question: For swithtec, I see that the number of
available LUTs for a BAR is read out of the chip and then rounded down
to a power of two... I'm curious why it's rounded down?

Blessings,
Doug
