Return-Path: <Allen.Hubbe@dell.com>
Received: from esa8.dell-outbound.iphmx.com (esa8.dell-outbound.iphmx.com. [68.232.149.218])
        by gmr-mx.google.com with ESMTPS id j10si1220074pfj.7.2017.10.10.07.17.57
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Oct 2017 07:17:57 -0700 (PDT)
From: "Allen Hubbe" <Allen.Hubbe@dell.com>
References: <9aa73260-8b02-4e86-b7d4-9bc3afd745a6@googlegroups.com>
In-Reply-To: <9aa73260-8b02-4e86-b7d4-9bc3afd745a6@googlegroups.com>
Subject: RE: Is the Scratchpad Implementation Using a LUT Standard?
Date: Tue, 10 Oct 2017 10:17:38 -0400
Message-ID: <000001d341d2$87574f20$9605ed60$@dell.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-us
To: 'Doug Meyer' <dmeyer@gigaio.com>, 'linux-ntb' <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

From: Doug Meyer
> Gents,
>=20
> As I continue to gain understanding about the NTB code, I am wondering =
about the use and requirements
> surrounding scratchpads, at least as I see things in the Switchtec =
code.
>=20
> In there, I see that a LUT (LUT0) is used, the size of the LUTs =
apparently being hard-coded to 64 KiB,
> for a shared memory window (struct shared_mw) which contains an array =
of 128 u32 for the scratchpad.
> Also, it appears that this is what is used both to determine link =
status and to pass memory
> address/size information between hosts (ports, peers). I apologize if =
I have that wrong. Please
> correct me.

The struct shared_mw is unique to the Switchtec driver, and your =
interpretation of its mechanism matches my understanding.

Other drivers determine link state from the hardware, and only expose =
scratchpads if they are implemented in hardware.

> The goal here is just to gain understanding... learn about required =
APIs vs philosophical decisions vs
> convenience, etc.
>=20
> My questions are whether this is a fixture of the NTB architecture, or =
if this is a convenience to
> support something else (the latter being a requirement)?
>=20
> In particular,
>=20
> But most importantly, I'm wondering about struct shared_mw. Could the =
Switchtec message registers have
> been used?

About a year ago when Serge joined the team, we spent a while trying to =
unify the message and scratchpad api.  At the same time, there is a =
preference to keep ntb.h very light and expose the hardware =
functionality as directly as possible.  We decided to split the apis for =
scratchpads and message registers.  For hardware that supports message =
registers, it should expose those via the message api.

What this currently implies is that the next layer up driver needs to =
work with either scratchpads or message registers.  If a driver only =
works with spads, then it is not portable.  I would like there to be =
some library code added to the common ntb bus driver to help with that.  =
Serge is currently making changes to the ntb_transport driver to support =
multi-port and message registers on IDT.  It may only work for the =
transport driver at first, but I have some hope that it could be =
transformed into library code.

> What do people think about how this technique scales when there are =
more than two peers? Obviously

That limitation was stated upfront with that driver submission.  The =
Switchtec driver only works with two nodes for now.

> LUTs are a precious resource, and a LUT per peer shared_mw is =
expensive. A LUT broken up into many
> shared_mw is a possibility, though there is always risk of trashing =
stuff.
> Also, if the LUTs need to be much larger (for application use), then a =
large chunk of the BAR space
> could be used for a relatively small structure.
> I'd love to hear anyone's thoughts on this.
>=20
> As an aside, I'm curious why the LUT size is 64 KiB? Was this just a =
nice number as a starting point?
>=20
> Thanks again, folks.
>=20
> Blessings,
> Doug

