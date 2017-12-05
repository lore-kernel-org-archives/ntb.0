Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf0-x234.google.com (mail-lf0-x234.google.com. [2a00:1450:4010:c07::234])
        by gmr-mx.google.com with ESMTPS id r58si101835eda.3.2017.12.05.07.54.48
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Dec 2017 07:54:48 -0800 (PST)
Received: by mail-lf0-x234.google.com with SMTP id x204so827303lfa.11
        for <linux-ntb@googlegroups.com>; Tue, 05 Dec 2017 07:54:48 -0800 (PST)
Return-Path: <fancer.lancer@gmail.com>
Date: Tue, 5 Dec 2017 18:54:54 +0300
From: Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH v2 00/15] NTB: Add full multi-port API support to the
 test drivers
Message-ID: <20171205155454.GA1701@mobilestation>
References: <20171203191736.3399-1-fancer.lancer@gmail.com>
 <000001d36d3b$e9f211d0$bdd63570$@dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <000001d36d3b$e9f211d0$bdd63570$@dell.com>
To: Allen Hubbe <Allen.Hubbe@dell.com>
Cc: jdmason@kudzu.us, dave.jiang@intel.com, Shyam-sundar.S-k@amd.com, Xiangliang.Yu@amd.com, gary.hook@amd.com, Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

On Mon, Dec 04, 2017 at 03:10:20PM -0500, Allen Hubbe <Allen.Hubbe@dell.com=
> wrote:
> From: Serge Semin
> > The multi-port NTB API was introduced in kernel 4.13 as well as the
> > first driver for the true multi-port devices of IDT PCIe-switches
> > series. But the test drivers still were left almost unchanged. Yes,
> > they didn't fail being used with new NTB API, but they only worked
> > with two-ports NTB devices. This patchset is intended to fix the
> > issue, by amending the NTB test drivers and script so they would be
> > fully compatible with multi-port NTB API.
> >=20
> > Additionally I found a few NTB subsystem issues while developing the
> > submitted patches. So they are also fixed in this patchset
>=20

Hello Allen

> Thanks for bringing the multiport support to the ntb tools and tests, and=
 getting it all tested with help of @pallam.  I wondered about setting the =
dma mask on the ntb device object, and it is better now that you have done =
that.  In addition to the contact information to the file comments, MODULE_=
AUTHOR can also be specified more than once per module.
>=20
> As Logan said, some of the renaming was not really necessary and made tho=
se patches more noisy than the needed to be.  I am not as much bothered by =
it, but it is a valid criticism.
>=20

Yeah, I know that. As I already said, it isn't usual of my patches
being so complicated. The reason why I made so many small renamings
was the code refactoring. I tried to set all the test drivers code
up to the same naming convention, so it would be easier for a code
reader to study it. Definitely, such the alterations should have
been done within a separate patch. But I started refactoring the
code and changing the logic for multi-portness all together, so it
would be too painful to unpick one from another after the work was
done. It especially concerned the ntb_tool and ntb_perf drivers. Next
time the procedures will be separately. Sorry for inconvenience and
thanks for understanding.

> I can't find an earlier comment I thought I had made regarding the change=
s in ntb_tool.  Maybe it was only on IRC.  I think the use of the anonymous=
 unions tool_mw is confusing.  It seems to require the reader to first unde=
rstand how local and peer mw setup works, and then see that the anonymous u=
nions are accessed by the proper member names depending on the situation.  =
In my review, the use of those members appears to be correct in your code. =
 Since these drivers are also intended to be example code, I would have pre=
ferred distinct types instead of a common type with anonymous union members=
=2E  Distinct types would make type checking by the compiler more effective=
 at catching improper use, and I think it would make the code more clear in=
 its use as an example ntb driver.  Also, there might be some confusion in =
the naming of members "mw", since it might refer to a tool_mw or a tool_mw_=
wrap, and the name alone doesn't disclose the type, that requires reading a=
nd understanding the surrounding context in the code.
>=20

Oops. We discussed it in the IRC. We agreed to add commentaries
around the types definition, so a reader would better understand their
purpose. I just forgot to move the change from my repo to the fork of
Jon's one. I'll do it and resend the patch.

> I am satisfied with these patches.  This is important for getting the mul=
tiport support established, and other than some comments about style and pr=
esentation of the patch set, nothing looks obviously wrong.  You should pro=
bably also seek Dave's ack on at least ntb_perf.
>=20
> Acked-by: Allen Hubbe <Allen.Hubbe@dell.com>
>=20

Thanks for your commentary and ack sign. Dave also made a great
effort in testing the ntb_perf driver. Especially in helping Ujjal
with our remote debugging procedure on the Intel platforms.) Anyway
I'll be waiting for his explicit ack under the patches he agrees on.

Thanks,
-Sergey

> > Serge Semin (15):
> >   NTB: Rename NTB messaging API methods
> >   NTB: Set dma mask and dma coherent mask to NTB devices
> >   NTB: Fix UB/bug in ntb_mw_get_align()
> >   NTB: ntb_pp: Add full multi-port NTB API support
> >   NTB: ntb_tool: Add full multi-port NTB API support
> >   NTB: ntb_perf: Add full multi-port NTB API support
> >   NTB: ntb_test: Safely use paths with whitespace
> >   NTB: ntb_test: Add ntb_tool port tests
> >   NTB: ntb_test: Update ntb_tool link tests
> >   NTB: ntb_test: Update ntb_tool DB tests
> >   NTB: ntb_test: Update ntb_tool Scratchpad tests
> >   NTB: ntb_test: Add ntb_tool Message tests
> >   NTB: ntb_test: Update ntb_tool MW tests
> >   NTB: ntb_test: Update ntb_perf tests
> >   NTB: ntb_hw_idt: Set NTB_TOPO_SWITCH topology
> >=20
> >  drivers/ntb/hw/amd/ntb_hw_amd.c         |    4 +
> >  drivers/ntb/hw/idt/ntb_hw_idt.c         |   37 +-
> >  drivers/ntb/hw/intel/ntb_hw_intel.c     |    4 +
> >  drivers/ntb/ntb.c                       |    1 -
> >  drivers/ntb/test/ntb_perf.c             | 1826 +++++++++++++++++++++--=
--------
> >  drivers/ntb/test/ntb_pingpong.c         |  450 +++++---
> >  drivers/ntb/test/ntb_tool.c             | 1805 ++++++++++++++++++++---=
-------
> >  include/linux/ntb.h                     |   36 +-
> >  tools/testing/selftests/ntb/ntb_test.sh |  307 ++++--
> >  9 files changed, 3013 insertions(+), 1457 deletions(-)
> >=20
> > --
> > 2.12.0
>=20
> --=20
> You received this message because you are subscribed to the Google Groups=
 "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/linux-ntb/000001d36d3b%24e9f211d0%24bdd63570%24%40dell.com.
> For more options, visit https://groups.google.com/d/optout.
