Return-Path: <Allen.Hubbe@emc.com>
Received: from mailuogwhop.emc.com (mailuogwhop.emc.com. [168.159.213.141])
        by gmr-mx.google.com with ESMTPS id y199si6231714ywd.5.2016.01.12.07.05.48
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jan 2016 07:05:48 -0800 (PST)
From: "Allen Hubbe" <Allen.Hubbe@emc.com>
References: <20160111233327.125643.22314.stgit@djiang5-desk3.ch.intel.com>,<40F65EF2B5E2254199711F58E3ACB84D99F07704@MX104CL02.corp.emc.com> <C10BF57A-A977-456E-93AA-790B89C0BBFB@intel.com>
In-Reply-To: <C10BF57A-A977-456E-93AA-790B89C0BBFB@intel.com>
Subject: RE: [PATCH v4] ntb: ntb perf tool
Date: Tue, 12 Jan 2016 10:05:36 -0500
Message-ID: <000001d14d4a$b145df00$13d19d00$@emc.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-us
To: "'Jiang, Dave'" <dave.jiang@intel.com>
Cc: jdmason@kudzu.us, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

From: Jiang, Dave <dave.jiang@intel.com>
> > On Jan 12, 2016, at 7:08 AM, Hubbe, Allen <Allen.Hubbe@emc.com> =
wrote:
> > From: Dave Jiang
> >> Providing raw performance data via a tool that directly access data
> from
> >
> >> diff --git a/drivers/ntb/ntb_transport.c
> b/drivers/ntb/ntb_transport.c
> >> index 60654d5..45583e6 100644
> >> --- a/drivers/ntb/ntb_transport.c
> >> +++ b/drivers/ntb/ntb_transport.c
> >> @@ -177,6 +177,7 @@ struct ntb_transport_qp {
> >> @@ -486,6 +487,8 @@ static ssize_t debugfs_read(struct file *filp,
> char
> >> @@ -726,6 +729,7 @@ static void ntb_qp_link_down_reset(struct
> >> @@ -1499,6 +1503,8 @@ static void ntb_async_tx(struct
> ntb_transport_qp
> >
> > Git am failed on some of these hunks.
> >
> > Why are there are ntb_tranport changes in the ntb_perf patch?
>=20
> There shouldn't be. Stack git must've messed up something.

I applied the patch without the ntb_transport changes.  They are already =
provided by the patch, NTB: Address out of DMA descriptor issue with =
NTB.

With just the perf_tool changes, this v4 works for me, for cpu and dma.

It may still need some performance tuning.  The numbers are much lower =
than I expected.  Maybe I just need to run it with different parameters, =
or maybe there's some numa issue.  It would be convenient to change the =
test parameters without reloading the modules.

There might also be a race in link-up.  I got stuck with a lot of this, =
once, and no link related messages on the other side:
[60025.597128] ntb_perf: ntb_hw_intel 0000:00:03.0: Remote version =3D =
0x0
[60025.607119] ntb_perf: ntb_hw_intel 0000:00:03.0: perf_link_work =
called
[60025.607122] ntb_perf: ntb_hw_intel 0000:00:03.0: Remote version =3D =
0x0
[60025.617122] ntb_perf: ntb_hw_intel 0000:00:03.0: perf_link_work =
called
[60025.617127] ntb_perf: ntb_hw_intel 0000:00:03.0: Remote version =3D =
0x0
[60025.627133] ntb_perf: ntb_hw_intel 0000:00:03.0: perf_link_work =
called
[60025.627136] ntb_perf: ntb_hw_intel 0000:00:03.0: Remote version =3D =
0x0
[60025.637118] ntb_perf: ntb_hw_intel 0000:00:03.0: perf_link_work =
called
[60025.637121] ntb_perf: ntb_hw_intel 0000:00:03.0: Remote version =3D =
0x0
[60025.647123] ntb_perf: ntb_hw_intel 0000:00:03.0: perf_link_work =
called
[60025.647127] ntb_perf: ntb_hw_intel 0000:00:03.0: Remote version =3D =
0x0
[60025.657115] ntb_perf: ntb_hw_intel 0000:00:03.0: perf_link_work =
called

On my dual-ntb system, I see both ntb are used by ntb_perf:
[60124.223795] ntb_perf: ntb_hw_intel 0000:00:03.0: perf_link_cleanup =
called
[60124.226942] ntb_perf: ntb_hw_intel 0000:00:03.0: perf_link_work =
called
[60124.226947] ntb_perf: ntb_hw_intel 0000:00:03.0: Remote MW size =3D =
0x100000
[60124.246408] ntb_perf: ntb_hw_intel 0000:80:03.0: perf_link_cleanup =
called
[60124.257389] ntb_perf: ntb_hw_intel 0000:80:03.0: perf_link_work =
called
[60124.264699] ntb_perf: ntb_hw_intel 0000:80:03.0: Remote MW size =3D =
0x100000

Only one of these ntb is in the debugfs dir, so the other one can't be =
tested:
root@HYR:/sys/kernel/debug/ntb_perf# ls
0000:00:03.0

> +static int perf_probe(struct ntb_client *client, struct ntb_dev *ntb)
> +{
...
> +	if (debugfs_initialized() && !perf_debugfs_dir) {
> +		perf_debugfs_dir =3D debugfs_create_dir(KBUILD_MODNAME, NULL);
> +		if (!perf_debugfs_dir)
> +			goto err_ctx;
> +
> +		rc =3D perf_debugfs_setup(perf);
> +		if (rc)
> +			goto err_ctx;
> +	}

I think the problem is here.  Should perf_debugfs_setup be outside of =
the if?  It looks like the per-device setup is only done if the top =
level dir didn't already exist.  If the top level dir already exists, =
per-device setup isn't called.

Allen

