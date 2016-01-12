Return-Path: <Allen.Hubbe@emc.com>
Received: from mailuogwhop.emc.com (mailuogwhop.emc.com. [168.159.213.141])
        by gmr-mx.google.com with ESMTPS id r2si734124pfr.0.2016.01.12.08.00.08
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jan 2016 08:00:09 -0800 (PST)
From: "Allen Hubbe" <Allen.Hubbe@emc.com>
References: <20160111233327.125643.22314.stgit@djiang5-desk3.ch.intel.com>,<40F65EF2B5E2254199711F58E3ACB84D99F07704@MX104CL02.corp.emc.com> <C10BF57A-A977-456E-93AA-790B89C0BBFB@intel.com> <000001d14d4a$b145df00$13d19d00$@emc.com>
In-Reply-To: <000001d14d4a$b145df00$13d19d00$@emc.com>
Subject: RE: [PATCH v4] ntb: ntb perf tool
Date: Tue, 12 Jan 2016 10:59:48 -0500
Message-ID: <002401d14d52$44057380$cc105a80$@emc.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-us
To: "Hubbe, Allen" <Allen.Hubbe@emc.com>, "'Jiang, Dave'" <dave.jiang@intel.com>
Cc: jdmason@kudzu.us, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

From: Allen Hubbe
> From: Jiang, Dave <dave.jiang@intel.com>
> > On Jan 12, 2016, at 7:08 AM, Hubbe, Allen <Allen.Hubbe@emc.com>
> > > From: Dave Jiang
> > >> Providing raw performance data via a tool that directly access =
data
> > from
> > >

> There might also be a race in link-up.  I got stuck with a lot of =
this,
> once, and no link related messages on the other side:
> [60025.597128] ntb_perf: ntb_hw_intel 0000:00:03.0: Remote version =3D =
0x0
> [60025.607119] ntb_perf: ntb_hw_intel 0000:00:03.0: perf_link_work

I think the race has is between clearing local spads in link cleanup, =
and the peer writing the same spads in link work.

Suppose B is already loaded, and then A is loaded.
B: link was down - link cleanup - clear spads on B.

A: modprobe ntb_perf.
A: ntb_link_enable - tells the ntb hw to enable, but link up is async.
A: ntb_link_event - trigger a link event, even if there was no link =
state change.

Race #1: is the link up fast enough on A?
A: perf_link_event - link state is down, schedule link cleanup.

A & B: perf_link_event - link state is now up, schedule link work.

Race #2: A clears good data written by B, AND B reads good data written =
by A?
B: link work - write good data to spads on A, continue below...
A: link cleanup - clear spads on A (oops!).
B: link work continued - read spads on B have good data, work is done!

Result:
A: link work - write good data to spads on B, read spads on A are zero, =
reschedule... forever.

This would be a very short window to race, so there might be something =
else, too.  I don't recall seeing link work run on B at all, and I =
missed the opportunity to save that log.  Now it's lost among all the =
others in dmesg, and I can't distinguish "no output" from "maybe these =
messages" that far back in the log.  If a banner was printed each time =
the module is loaded, that would help.

In ntrdma, I avoid this race by /not/ clearing the local registers.  To =
avoid reading bad data, the peer updates a counter as long as the data =
is valid.  Observing a change in that counter value indicates good data. =
 That avoids a race between A and B each writing the same registers.

Allen

