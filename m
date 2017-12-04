Return-Path: <Allen.Hubbe@dell.com>
Received: from esa7.dell-outbound.iphmx.com (esa7.dell-outbound.iphmx.com. [68.232.153.96])
        by gmr-mx.google.com with ESMTPS id j134si67740ita.0.2017.12.04.12.10.39
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Dec 2017 12:10:40 -0800 (PST)
From: "Allen Hubbe" <Allen.Hubbe@dell.com>
References: <20171203191736.3399-1-fancer.lancer@gmail.com>
In-Reply-To: <20171203191736.3399-1-fancer.lancer@gmail.com>
Subject: RE: [PATCH v2 00/15] NTB: Add full multi-port API support to the test drivers
Date: Mon, 4 Dec 2017 15:10:20 -0500
Message-ID: <000001d36d3b$e9f211d0$bdd63570$@dell.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-us
To: 'Serge Semin' <fancer.lancer@gmail.com>, jdmason@kudzu.us, dave.jiang@intel.com, Shyam-sundar.S-k@amd.com, Xiangliang.Yu@amd.com, gary.hook@amd.com
Cc: Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

From: Serge Semin
> The multi-port NTB API was introduced in kernel 4.13 as well as the
> first driver for the true multi-port devices of IDT PCIe-switches
> series. But the test drivers still were left almost unchanged. Yes,
> they didn't fail being used with new NTB API, but they only worked
> with two-ports NTB devices. This patchset is intended to fix the
> issue, by amending the NTB test drivers and script so they would be
> fully compatible with multi-port NTB API.
>=20
> Additionally I found a few NTB subsystem issues while developing the
> submitted patches. So they are also fixed in this patchset

Thanks for bringing the multiport support to the ntb tools and tests, =
and getting it all tested with help of @pallam.  I wondered about =
setting the dma mask on the ntb device object, and it is better now that =
you have done that.  In addition to the contact information to the file =
comments, MODULE_AUTHOR can also be specified more than once per module.

As Logan said, some of the renaming was not really necessary and made =
those patches more noisy than the needed to be.  I am not as much =
bothered by it, but it is a valid criticism.

I can't find an earlier comment I thought I had made regarding the =
changes in ntb_tool.  Maybe it was only on IRC.  I think the use of the =
anonymous unions tool_mw is confusing.  It seems to require the reader =
to first understand how local and peer mw setup works, and then see that =
the anonymous unions are accessed by the proper member names depending =
on the situation.  In my review, the use of those members appears to be =
correct in your code.  Since these drivers are also intended to be =
example code, I would have preferred distinct types instead of a common =
type with anonymous union members.  Distinct types would make type =
checking by the compiler more effective at catching improper use, and I =
think it would make the code more clear in its use as an example ntb =
driver.  Also, there might be some confusion in the naming of members =
"mw", since it might refer to a tool_mw or a tool_mw_wrap, and the name =
alone doesn't disclose the type, that requires reading and understanding =
the surrounding context in the code.

I am satisfied with these patches.  This is important for getting the =
multiport support established, and other than some comments about style =
and presentation of the patch set, nothing looks obviously wrong.  You =
should probably also seek Dave's ack on at least ntb_perf.

Acked-by: Allen Hubbe <Allen.Hubbe@dell.com>

> Serge Semin (15):
>   NTB: Rename NTB messaging API methods
>   NTB: Set dma mask and dma coherent mask to NTB devices
>   NTB: Fix UB/bug in ntb_mw_get_align()
>   NTB: ntb_pp: Add full multi-port NTB API support
>   NTB: ntb_tool: Add full multi-port NTB API support
>   NTB: ntb_perf: Add full multi-port NTB API support
>   NTB: ntb_test: Safely use paths with whitespace
>   NTB: ntb_test: Add ntb_tool port tests
>   NTB: ntb_test: Update ntb_tool link tests
>   NTB: ntb_test: Update ntb_tool DB tests
>   NTB: ntb_test: Update ntb_tool Scratchpad tests
>   NTB: ntb_test: Add ntb_tool Message tests
>   NTB: ntb_test: Update ntb_tool MW tests
>   NTB: ntb_test: Update ntb_perf tests
>   NTB: ntb_hw_idt: Set NTB_TOPO_SWITCH topology
>=20
>  drivers/ntb/hw/amd/ntb_hw_amd.c         |    4 +
>  drivers/ntb/hw/idt/ntb_hw_idt.c         |   37 +-
>  drivers/ntb/hw/intel/ntb_hw_intel.c     |    4 +
>  drivers/ntb/ntb.c                       |    1 -
>  drivers/ntb/test/ntb_perf.c             | 1826 =
+++++++++++++++++++++----------
>  drivers/ntb/test/ntb_pingpong.c         |  450 +++++---
>  drivers/ntb/test/ntb_tool.c             | 1805 =
++++++++++++++++++++----------
>  include/linux/ntb.h                     |   36 +-
>  tools/testing/selftests/ntb/ntb_test.sh |  307 ++++--
>  9 files changed, 3013 insertions(+), 1457 deletions(-)
>=20
> --
> 2.12.0

