Return-Path: <lsgunthorpe@gmail.com>
Received: from mail-io0-x22d.google.com (mail-io0-x22d.google.com. [2607:f8b0:4001:c06::22d])
        by gmr-mx.google.com with ESMTPS id f30si257719qtg.5.2017.10.12.11.34.00
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Oct 2017 11:34:00 -0700 (PDT)
Received: by mail-io0-x22d.google.com with SMTP id n137so6481676iod.6
        for <linux-ntb@googlegroups.com>; Thu, 12 Oct 2017 11:34:00 -0700 (PDT)
Return-Path: <lsgunthorpe@gmail.com>
Subject: Re: Is the Scratchpad Implementation Using a LUT Standard?
References: <9aa73260-8b02-4e86-b7d4-9bc3afd745a6@googlegroups.com>
 <000001d341d2$87574f20$9605ed60$@dell.com>
 <6107eb07-3889-4f1a-ad50-264256772dae@googlegroups.com>
 <38ffd174-b66f-4077-8cdc-679e412242fc@googlegroups.com>
 <20171011174114.GA25306@mobilestation>
 <CA+GK6enDdDJvqJZ=+PE=HMGuuenKqbS5LWKxFbGDHXzY6TdRSw@mail.gmail.com>
 <4e0e466e-9cb8-4fbb-db84-eb5b8dd012c3@gmail.com>
 <CA+GK6ekepJqXOQ0SA1tTiySPj0QL_dWwXk+EJMuCKpbVuQbt9g@mail.gmail.com>
From: Logan Gunthorpe <lsgunthorpe@gmail.com>
Message-ID: <bc553b2c-0f02-5750-dd49-f6c74803e04e@gmail.com>
Date: Thu, 12 Oct 2017 12:33:57 -0600
MIME-Version: 1.0
In-Reply-To: <CA+GK6ekepJqXOQ0SA1tTiySPj0QL_dWwXk+EJMuCKpbVuQbt9g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
To: D Meyer <dmeyer@gigaio.com>
Cc: Serge Semin <fancer.lancer@gmail.com>, linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

On 12/10/17 12:05 PM, D Meyer wrote:
> Regarding your comment about using direct windows for ntb_transport, I
> don't understand why ntb_transport has to use a direct window.
> Couldn't it (or some other client) use one or more LUTs? I don't see a
> restriction/difference in the Switchtec specification that would
> prevent that from being done.
Yes, true. Though for performance then you'd need the LUT windows to be 
larger.
> It looks like the current default max direct memory window size is 2
> MiB, which could be a LUT (If that was the LUT size). Having a LUT
> size of 2 MiB doesn't seem like any sort of reach at all... in
> previous hardware that I worked with, we had BARs that were very, very
> large. Having 32 LUTs * 2 MiB isn't big when you consider that GPCPU
> configurations are using BARs larger than 4 GiB.
True. You just get tripped up slightly with all the LUTs having to be 
the same size.

> Imagine the case where many different clients are using different
> capabilities in the fabric. NVMe, GPUs, ntb_transport and it's kin,
> etc. As far as I can tell, LUTs are a great way to be able to allocate
> chunks of BAR space and set up mappings on an as-needed basis.
Yeah, we are a _long_ way off from having multiple clients use the 
resources.
Also, you'll find most kernel developers (especially the big names) will 
argue
against making decisions on an imagined future. Your presumptions will
more than likely be wrong and you'll have wasted everyone's time. Code 
should
be written for today's needs and if someone comes up with some crazy use for
NTB it's their responsibility to figure out how to change the code to 
handle it and
justify the extra complexities to the community.

> Also, as far as I understand the Switchtec part, I can reconfigure the
> LUT number and size as well as the direct window size (as long as
> nothing is currently using them). That's nice too, though it would be
> awesome to eventually have a switch that supports richer features that
> give greater flexibility as well as dynamic reconfiguration of memory
> windows (ya gotta dream!).

Yeah, I also ran up against a bunch of gotchas when dealing with LUT 
configuration.
There are a number of things that could make it nicer on software 
developers but
I wouldn't hold my breath for them happening.

Logan
> Yeah,

