Return-Path: <lsgunthorpe@gmail.com>
Received: from mail-io0-x231.google.com (mail-io0-x231.google.com. [2607:f8b0:4001:c06::231])
        by gmr-mx.google.com with ESMTPS id r130si426086ywh.26.2017.10.11.11.45.00
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Oct 2017 11:45:00 -0700 (PDT)
Received: by mail-io0-x231.google.com with SMTP id 189so2808106iow.10
        for <linux-ntb@googlegroups.com>; Wed, 11 Oct 2017 11:45:00 -0700 (PDT)
Return-Path: <lsgunthorpe@gmail.com>
Subject: Re: Is the Scratchpad Implementation Using a LUT Standard?
References: <9aa73260-8b02-4e86-b7d4-9bc3afd745a6@googlegroups.com>
 <000001d341d2$87574f20$9605ed60$@dell.com>
 <6107eb07-3889-4f1a-ad50-264256772dae@googlegroups.com>
 <38ffd174-b66f-4077-8cdc-679e412242fc@googlegroups.com>
 <20171011174114.GA25306@mobilestation>
 <CA+GK6enDdDJvqJZ=+PE=HMGuuenKqbS5LWKxFbGDHXzY6TdRSw@mail.gmail.com>
From: Logan Gunthorpe <lsgunthorpe@gmail.com>
Message-ID: <4e0e466e-9cb8-4fbb-db84-eb5b8dd012c3@gmail.com>
Date: Wed, 11 Oct 2017 12:44:58 -0600
MIME-Version: 1.0
In-Reply-To: <CA+GK6enDdDJvqJZ=+PE=HMGuuenKqbS5LWKxFbGDHXzY6TdRSw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
To: D Meyer <dmeyer@gigaio.com>, Serge Semin <fancer.lancer@gmail.com>
Cc: linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

On 11/10/17 12:23 PM, D Meyer wrote:
> Regarding Switchtec, the 96xG3 part has 512 LUTs per Stack and a stack
> can have up to eight NTBs. So for that chip, if I'm starting to grasp
> this stuff, a machine with 48 NTBs would mean that on a single Stack,
> 8 (hosts) x 47 (peers) = 376 LUTs would be used up for each of the 8
> to have a shared_mw in its own LUT.
Yes, there are a bunch of annoying restrictions like that, but your 
example looks correct.
There are lots of LUTs to play around with. The bigger restriction is 
the direct windows, of
which you only have 2 per port. Creating a network in ntb_transport (et 
al) to communicate across
48 partitions is going to be a very hard problem to solve.
> Also, the current hard-coded LUT size is 64 KiB, but that can't remain
> that way to have flexibility. If the LUTs were, say 16 MiB, then the
> shred_mw LUTs use up a massive part of the BAR space.
Yes, all LUTs must be the same size. Plus the LUT space comes before the 
direct
window space in the BAR. So the alignment (and therefore maximum size) 
of the direct window space
depends on the size and the number of LUTs. I believe I chose 32 64k 
luts so that the
direct window aligns to 2MB. I originally had the size set to 4k, but 
this limited the alignment
of the direct window.

So the tradeoffs are: if you increase it you waste memory for LUTs that 
don't need the extra space,
and if you decrease it you limit the size of the direct window.
> Oh... A quick side question: For swithtec, I see that the number of
> available LUTs for a BAR is read out of the chip and then rounded down
> to a power of two... I'm curious why it's rounded down?
This has to do with the alignment I mentioned above. If the number of 
LUTs is not a power of two,
the direct window won't be nicely aligned and you get some annoying 
restrictions on it's size.

Logan
