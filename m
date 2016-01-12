Return-Path: <dave.jiang@intel.com>
Received: from mga14.intel.com (mga14.intel.com. [192.55.52.115])
        by gmr-mx.google.com with ESMTP id jj4si12452253pac.2.2016.01.12.06.31.09
        for <linux-ntb@googlegroups.com>;
        Tue, 12 Jan 2016 06:31:09 -0800 (PST)
From: "Jiang, Dave" <dave.jiang@intel.com>
Subject: Re: [PATCH v4] ntb: ntb perf tool
Date: Tue, 12 Jan 2016 14:31:08 +0000
Message-ID: <C10BF57A-A977-456E-93AA-790B89C0BBFB@intel.com>
References: <20160111233327.125643.22314.stgit@djiang5-desk3.ch.intel.com>,<40F65EF2B5E2254199711F58E3ACB84D99F07704@MX104CL02.corp.emc.com>
In-Reply-To: <40F65EF2B5E2254199711F58E3ACB84D99F07704@MX104CL02.corp.emc.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Return-Path: dave.jiang@intel.com
To: "Hubbe, Allen" <Allen.Hubbe@emc.com>
Cc: "jdmason@kudzu.us" <jdmason@kudzu.us>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>



> On Jan 12, 2016, at 7:08 AM, Hubbe, Allen <Allen.Hubbe@emc.com> wrote:
>=20
> From: Dave Jiang
>> Providing raw performance data via a tool that directly access data from
>=20
>> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
>> index 60654d5..45583e6 100644
>> --- a/drivers/ntb/ntb_transport.c
>> +++ b/drivers/ntb/ntb_transport.c
>> @@ -177,6 +177,7 @@ struct ntb_transport_qp {
>> @@ -486,6 +487,8 @@ static ssize_t debugfs_read(struct file *filp, char
>> @@ -726,6 +729,7 @@ static void ntb_qp_link_down_reset(struct
>> @@ -1499,6 +1503,8 @@ static void ntb_async_tx(struct ntb_transport_qp
>=20
> Git am failed on some of these hunks.
>=20
> Why are there are ntb_tranport changes in the ntb_perf patch?

There shouldn't be. Stack git must've messed up something.=20

>=20
> Allen
>=20
> --=20
> You received this message because you are subscribed to the Google Groups=
 "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/linux-ntb/40F65EF2B5E2254199711F58E3ACB84D99F07704%40MX104CL02.corp.emc.c=
om.
> For more options, visit https://groups.google.com/d/optout.
