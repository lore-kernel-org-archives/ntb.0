Return-Path: <jdmason@kudzu.us>
Received: from mail-wm0-x233.google.com (mail-wm0-x233.google.com. [2a00:1450:400c:c09::233])
        by gmr-mx.google.com with ESMTPS id 5si252847wmm.2.2016.01.06.09.48.03
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jan 2016 09:48:03 -0800 (PST)
Received: by mail-wm0-x233.google.com with SMTP id u188so68964652wmu.1
        for <linux-ntb@googlegroups.com>; Wed, 06 Jan 2016 09:48:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <40F65EF2B5E2254199711F58E3ACB84D99EF72E1@MX104CL02.corp.emc.com>
References: <1450878175-9300-1-git-send-email-Xiangliang.Yu@amd.com>
	<CAPoiz9znO1QT9Fphtmf4Wp2Tkvm1H-thy2=SrPi_dT9uQ4HoMQ@mail.gmail.com>
	<40F65EF2B5E2254199711F58E3ACB84D99EF72E1@MX104CL02.corp.emc.com>
Date: Wed, 6 Jan 2016 12:48:03 -0500
Message-ID: <CAPoiz9y3j8=kMzZzRVrBy+0txpLgRYeq5Es51KPPau6vKv1pxA@mail.gmail.com>
Subject: Re: [PATCH V2 1/3] NTB: Add AMD PCI-Express NTB driver
From: Jon Mason <jdmason@kudzu.us>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: "Hubbe, Allen" <Allen.Hubbe@emc.com>
Cc: Xiangliang Yu <Xiangliang.Yu@amd.com>, Dave Jiang <dave.jiang@intel.com>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>, linux-kernel <linux-kernel@vger.kernel.org>, "SPG_Linux_Kernel@amd.com" <SPG_Linux_Kernel@amd.com>
List-ID: <linux-ntb.googlegroups.com>

On Wed, Jan 6, 2016 at 11:52 AM, Hubbe, Allen <Allen.Hubbe@emc.com> wrote:
> From: Jon Mason <jdmason@kudzu.us>:
>> On Wed, Dec 23, 2015 at 8:42 AM, Xiangliang Yu <Xiangliang.Yu@amd.com>
>> wrote:
>
>> > +#define ndev_pdev(ndev) ((ndev)->ntb.pdev)
>> > +#define ndev_name(ndev) pci_name(ndev_pdev(ndev))
>> > +#define ndev_dev(ndev) (&ndev_pdev(ndev)->dev)
>> > +#define ntb_ndev(ntb) container_of(ntb, struct amd_ntb_dev, ntb)
>> > +#define hb_ndev(work) container_of(work, struct amd_ntb_dev,
>> hb_timer.work)
>> > +#define ntb_hotplug_ndev(context) (container_of((context),     \
>> > +                       struct ntb_acpi_hotplug_context, hp)->ndev)
>>
>> Seems like these are hiding things too.  Please use them directly (or
>> at least put them in the C file and not the header file).
>
> I like these macros for up/down casting.  Putting them close to the struc=
ture definition seems appropriate to me, too.  I would rather see them move=
d to right below the definition of struct amd_ntb_dev, instead of to the c =
file.  That is my opinion, but Jon can make the final decision on it.

My opinion wasn't super strong on these.  If Allen is fine with them,
then good enough for me :)


> However, these in particular are buggy:
>
>> > +#define ntb_ndev(ntb) container_of(ntb, struct amd_ntb_dev, ntb)
>> > +#define hb_ndev(work) container_of(work, struct amd_ntb_dev,
>> hb_timer.work)
>
> Note: "ntb" will be replaced in all occurrences to the right.  This only =
works if the name "ntb" is passed as the argument.  If the argument is name=
d "foo", it will either fail at compile time to find the member "foo" in st=
ruct amd_ntb_dev, or worse, it will hide a bug accessing the wrong member o=
f the struct.
>
> Rename the macro parameter __ntb.

Good call.  Please make the necessary mods Xiangliang.

Thanks,
Jon


> Allen
>
> --
> You received this message because you are subscribed to the Google Groups=
 "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/linux-ntb/40F65EF2B5E2254199711F58E3ACB84D99EF72E1%40MX104CL02.corp.emc.c=
om.
> For more options, visit https://groups.google.com/d/optout.
