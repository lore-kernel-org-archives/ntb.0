Return-Path: <dmeyer@gigaio.com>
Received: from mail-ua0-x22d.google.com (mail-ua0-x22d.google.com. [2607:f8b0:400c:c08::22d])
        by gmr-mx.google.com with ESMTPS id n4si13724itg.2.2017.10.12.11.05.35
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Oct 2017 11:05:35 -0700 (PDT)
Received: by mail-ua0-x22d.google.com with SMTP id n38so3613709uai.11
        for <linux-ntb@googlegroups.com>; Thu, 12 Oct 2017 11:05:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4e0e466e-9cb8-4fbb-db84-eb5b8dd012c3@gmail.com>
References: <9aa73260-8b02-4e86-b7d4-9bc3afd745a6@googlegroups.com>
 <000001d341d2$87574f20$9605ed60$@dell.com> <6107eb07-3889-4f1a-ad50-264256772dae@googlegroups.com>
 <38ffd174-b66f-4077-8cdc-679e412242fc@googlegroups.com> <20171011174114.GA25306@mobilestation>
 <CA+GK6enDdDJvqJZ=+PE=HMGuuenKqbS5LWKxFbGDHXzY6TdRSw@mail.gmail.com> <4e0e466e-9cb8-4fbb-db84-eb5b8dd012c3@gmail.com>
From: D Meyer <dmeyer@gigaio.com>
Date: Thu, 12 Oct 2017 11:05:30 -0700
Message-ID: <CA+GK6ekepJqXOQ0SA1tTiySPj0QL_dWwXk+EJMuCKpbVuQbt9g@mail.gmail.com>
Subject: Re: Is the Scratchpad Implementation Using a LUT Standard?
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Logan Gunthorpe <lsgunthorpe@gmail.com>
Cc: Serge Semin <fancer.lancer@gmail.com>, linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

Dear Logan,

Thanks so much for the very, very helpful reply!

On Wed, Oct 11, 2017 at 11:44 AM, Logan Gunthorpe <lsgunthorpe@gmail.com> w=
rote:
> On 11/10/17 12:23 PM, D Meyer wrote:
>>
>> Regarding Switchtec, the 96xG3 part has 512 LUTs per Stack and a stack
>> can have up to eight NTBs. So for that chip, if I'm starting to grasp
>> this stuff, a machine with 48 NTBs would mean that on a single Stack,
>> 8 (hosts) x 47 (peers) =3D 376 LUTs would be used up for each of the 8
>> to have a shared_mw in its own LUT.
>
> Yes, there are a bunch of annoying restrictions like that, but your examp=
le
> looks correct.
> There are lots of LUTs to play around with. The bigger restriction is the
> direct windows, of
> which you only have 2 per port. Creating a network in ntb_transport (et a=
l)
> to communicate across
> 48 partitions is going to be a very hard problem to solve.

Regarding your comment about using direct windows for ntb_transport, I
don't understand why ntb_transport has to use a direct window.
Couldn't it (or some other client) use one or more LUTs? I don't see a
restriction/difference in the Switchtec specification that would
prevent that from being done.

It looks like the current default max direct memory window size is 2
MiB, which could be a LUT (If that was the LUT size). Having a LUT
size of 2 MiB doesn't seem like any sort of reach at all... in
previous hardware that I worked with, we had BARs that were very, very
large. Having 32 LUTs * 2 MiB isn't big when you consider that GPCPU
configurations are using BARs larger than 4 GiB.

Over a year ago, PCI-SIG proposed changing the BAR maximum to 2^63 to
permit complete access the entire space, they noted:
> Currently, limiting the resizable BARs to 512 GB means resources are eith=
er: a) simply not allocated and left out of the system,
> or b) forced to report a smaller aperture in order to be allocated, but t=
hat aperture size is not optimal in all uses of the product
> and may cause software to need to =E2=80=9Cbank=E2=80=9D or otherwise mov=
e the aperture at runtime.

Imagine the case where many different clients are using different
capabilities in the fabric. NVMe, GPUs, ntb_transport and it's kin,
etc. As far as I can tell, LUTs are a great way to be able to allocate
chunks of BAR space and set up mappings on an as-needed basis.

Also, as far as I understand the Switchtec part, I can reconfigure the
LUT number and size as well as the direct window size (as long as
nothing is currently using them). That's nice too, though it would be
awesome to eventually have a switch that supports richer features that
give greater flexibility as well as dynamic reconfiguration of memory
windows (ya gotta dream!).

Blessings,
Doug
