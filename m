Return-Path: <Allen.Hubbe@emc.com>
Received: from mailuogwdur.emc.com (mailuogwdur.emc.com. [128.221.224.79])
        by gmr-mx.google.com with ESMTPS id o63si2905591ywd.1.2016.01.06.08.37.40
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jan 2016 08:37:40 -0800 (PST)
From: "Allen Hubbe" <Allen.Hubbe@emc.com>
References: <20160105233732.148863.67802.stgit@djiang5-desk3.ch.intel.com> <CAPoiz9xsYBxFb1pLEYa4xtOF4roD2F_CwJMBsoQDg1ZCSVRBnA@mail.gmail.com>
In-Reply-To: <CAPoiz9xsYBxFb1pLEYa4xtOF4roD2F_CwJMBsoQDg1ZCSVRBnA@mail.gmail.com>
Subject: RE: [PATCH] ntb: ntb perf tool
Date: Wed, 6 Jan 2016 11:37:21 -0500
Message-ID: <000001d148a0$84a18480$8de48d80$@emc.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-us
To: 'Jon Mason' <jdmason@kudzu.us>, 'Dave Jiang' <dave.jiang@intel.com>
Cc: linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

Jon Mason <jdmason@kudzu.us>:
> On Tue, Jan 5, 2016 at 6:37 PM, Dave Jiang <dave.jiang@intel.com> =
wrote:

> > +static void perf_link_event(void *ctx)
> > +{
> > +       struct perf_ctx *perf =3D ctx;
> > +
> > +       if (ntb_link_is_up(perf->ntb, NULL, NULL) =3D=3D 1)
>=20
> The comparison to one seems unnecessary
>=20

It api doc says it returns one, zero, or negative to indicate an error.  =
The Intel NTB driver does not return an error.  Would you prefer to =
change the api, to make the return simply a boolean, and have some other =
mechanism to query an error?

> > +       if (!perf->link_is_up)
> > +               cancel_delayed_work_sync(&perf->link_work);
> > +
> > +       for (i =3D 0; i < MAX_SPAD; i++)
>=20
> Complete aside here, but we might need to add logic to the core NTB
> code to query the number of available SPADs and error out of we try to
> get more than that.

Use ntb_spad_count(), and the count does vary.  For example, there are =
half the number of spads in RP/TB topology than B2B.


