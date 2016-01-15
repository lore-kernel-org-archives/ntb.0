Return-Path: <Allen.Hubbe@emc.com>
Received: from mailuogwhop.emc.com (mailuogwhop.emc.com. [168.159.213.141])
        by gmr-mx.google.com with ESMTPS id ui7si1388916pab.0.2016.01.15.09.13.37
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jan 2016 09:13:38 -0800 (PST)
From: "Allen Hubbe" <Allen.Hubbe@emc.com>
References: <1452771847-16949-1-git-send-email-Xiangliang.Yu@amd.com> <000101d14ee4$25f72940$71e57bc0$@emc.com> <BLUPR12MB0420561A08B56E89F12139B8EBCD0@BLUPR12MB0420.namprd12.prod.outlook.com>
In-Reply-To: <BLUPR12MB0420561A08B56E89F12139B8EBCD0@BLUPR12MB0420.namprd12.prod.outlook.com>
Subject: RE: [PATCH V3 1/2] NTB: Add AMD PCI-Express NTB driver
Date: Fri, 15 Jan 2016 12:13:18 -0500
Message-ID: <000101d14fb8$086db7c0$19492740$@emc.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-us
To: "'Yu, Xiangliang'" <Xiangliang.Yu@amd.com>, jdmason@kudzu.us, dave.jiang@intel.com, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
Cc: 'SPG_Linux_Kernel' <SPG_Linux_Kernel@amd.com>
List-ID: <linux-ntb.googlegroups.com>

> From: Yu, Xiangliang <Xiangliang.Yu@amd.com>
>=20
> Sorry, let me clarify it: one 16-bit doorbell is for primary side and
> the other is be used
> By secondary side. The #3 should be is that two 16-bit doorbell
> registers.

Thanks!  I think I understand now.

> In here, i list all features AMD NTB support, not patch. Please see my
> word again.

This is the commit message for this patch.  It would be confusing to =
have features mentioned in the commit message not implemented, and no =
explanation why not.

> > What is SMU?
>=20
> System management unit, please reference AMD manual.

Thanks, but it is your responsibility to support this driver, and =
respond to questions like this.  I didn't write it, I can't test it, and =
I don't have a hardware manual.

If this is an ack for the system management unit, is it acknowledging a =
watchdog on the SMU?  Does this ack have to do with the flush or power =
management functions?  If it is a watchdog, what implications are there =
for unloading your driver - does the watchdog just time out, and then =
what, reset the device?  I'm speculating (guessing) again, but that's =
really the best I can do without your authoritative answers, or a =
hardware manual.

Where can the hardware manual be found?  Has it been published, or is it =
AMD confidential?

http://search.amd.com/en-us/Pages/results-all.aspx#k=3Dzeppelin
http://search.amd.com/en-us/Pages/results-all.aspx#k=3Dntb

"Nothing here matches your search"

> > I would prefer to see #define, but this works... There are good
> arguments to
> > be made for compiler constants vs the preprocessor.  My preference
> just
> > comes from what I've observed about how other drivers are written, =
and
> > #define for this stuff seems to be the convention.
>=20
> I have lots of SATA/Block layer experience, this following AHCI coding
> style.
> Compiler will check enum variable, not for macro.
> Actually, there are lots of similar definition in kernel, such as =
block
> layer code.

Thanks.  I'm ok with this.

> > It's unusual, sometimes dangerous, to use the static keyword in a .h
> file
>=20
> Actually, I put it in .c file in first version, I think it make code
> clear if moving it to
> .h file. Yes, I can remove all these definitions by rearranging .c =
file.
>=20
> And please speak out all your concern in this time, you know, I had
> spent lots of time
>  On these patches.

You're right.  I didn't notice this change from v1 to v2.  It would have =
been a more efficient code review had I made these comments in v2.

My comments this time around, as I said, were minor.  Each version of =
this patch series has been an improvement.  Maybe this version is even =
good enough, but there are /always/ comments to be made about code.  =
It's not unusual to see patches on the kernel mailing list with double =
digit reroll counts (I saw one at v12 today).  Sure, it can be =
frustrating.   Please don't take offense.  Thank you for your efforts.

The bad news:  I have two more comments.

Please run scritps/checkpatch.pl --strict with your patch.  There are =
some formatting issues.

Please add your name to the MAINTANERS file.  Add a section, NTB AMD =
DRIVER.  The checkpatch script also mentions this, but it's especially =
important.  You are the only one who can test this driver, with the =
simulator.

The good news:

I'm inclined to say yes to this patch.  It looks ok, and I'll take your =
word that it has been tested.  Ultimately, the patch has to be accepted =
by Jon and Linus.  By adding my comments, I'm just trying to help.

Do you think you can email v4 by tomorrow?  I'll be sure to respond =
quickly if you do, so it has the best chance to meet the deadline for =
the merge window.  It's getting close to the deadline, and I'll take =
some of the blame for that.

Allen

