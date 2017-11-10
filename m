Date: Fri, 10 Nov 2017 03:27:24 -0800 (PST)
From: cruisethai@gmail.com
Message-Id: <c182eb3e-a866-4510-b344-de249734f15a@googlegroups.com>
In-Reply-To: <20170718160409.6493-1-logang@deltatee.com>
References: <20170718160409.6493-1-logang@deltatee.com>
Subject: Re: [PATCH v2 00/16] Switchtec NTB Support
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_1547_902866243.1510313244921"
To: linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

------=_Part_1547_902866243.1510313244921
Content-Type: multipart/alternative; 
	boundary="----=_Part_1548_1106844851.1510313244921"

------=_Part_1548_1106844851.1510313244921
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Dear Logan and all,

I am working with Switchtec-NTB from Microsemi.
The driver is working fine, but if one side computer recovers from a crash 
due to another reason, they will lost connection, and the other side need 
to reload the drivers in order to reconnect to the other side.

Have you ever gotten this problem before ?

Thanks a lot !

On Wednesday, 19 July 2017 00:04:24 UTC+8, Logan Gunthorpe wrote:
>
> Changes since v1: 
>
> - Rebased onto latest ntb-next branch (with v4.13-rc1) 
> - Reworked ntb_mw_count() function so that it can be called all the 
>   time (per discussion with Allen) 
> - Various spelling and formatting cleanups from Bjorn 
> - Added request_module() call such that the NTB module is automatically 
>   loaded when appropriate hardware exists. 
>
> -- 
>
> Changes since the rfc: 
>
> - Rebased on ntb-next 
> - Switched ntb_part_op to use sleep instead of delay 
> - Dropped a number of useless dbg __func__ prints 
> - Went back to the dynamic instead of the static class 
> - Swapped the notifier block for a simple callback 
> - Modified the new ntb api so that a couple functions with pidx 
>   now must be called after link up. Per our discussion on the list. 
>
> -- 
>
> This patchset implements Non-Transparent Bridge (NTB) support for the 
> Microsemi Switchtec series of switches. We're looking for some 
> review from the community at this point but hope to get it upstreamed 
> for v4.14. 
>
> Switchtec NTB support is configured over the same function and bar 
> as the management endpoint. Thus, the new driver hooks into the 
> management driver which we had merged in v4.12. We use the class 
> interface API to register an NTB device for every switchtec device 
> which supports NTB (not all do). 
>
> The Switchtec hardware supports doorbells, memory windows and messages. 
> Seeing there is no native scratchpad support, 128 spads are emulated 
> through the use of a pre-setup memory window. The switch has 64 
> doorbells which are shared between the two partitions and a 
> configurable set of memory windows. While the hardware supports more 
> than 2 partitions, this driver only supports the first two seeing 
> the current NTB API only supports two hosts. 
>
> The driver has been tested with ntb_netdev and fully passes the 
> ntb_test script. 
>
> This patchset is based off of ntb-next and can be found in this 
> git repo: 
>
> https://github.com/sbates130272/linux-p2pmem.git switchtec_ntb_v2 
>
> Logan Gunthorpe (16): 
>   switchtec: move structure definitions into a common header 
>   switchtec: export class symbol for use in upper layer driver 
>   switchtec: add NTB hardware register definitions 
>   switchtec: add link event notifier callback 
>   ntb: ensure ntb_mw_get_align() is only called when the link is up 
>   ntb: add check and comment for link up to mw_count() and 
>     mw_get_align() 
>   ntb: ntb_test: ensure the link is up before trying to configure the 
>     mws 
>   switchtec_ntb: introduce initial NTB driver 
>   switchtec_ntb: initialize hardware for memory windows 
>   switchtec_ntb: initialize hardware for doorbells and messages 
>   switchtec_ntb: add skeleton NTB driver 
>   switchtec_ntb: add link management 
>   switchtec_ntb: implement doorbell registers 
>   switchtec_ntb: implement scratchpad registers 
>   switchtec_ntb: add memory window support 
>   switchtec_ntb: update switchtec documentation with notes for NTB 
>
>  Documentation/switchtec.txt             |   12 + 
>  MAINTAINERS                             |    2 + 
>  drivers/ntb/hw/Kconfig                  |    1 + 
>  drivers/ntb/hw/Makefile                 |    1 + 
>  drivers/ntb/hw/mscc/Kconfig             |    9 + 
>  drivers/ntb/hw/mscc/Makefile            |    1 + 
>  drivers/ntb/hw/mscc/switchtec_ntb.c     | 1213 
> +++++++++++++++++++++++++++++++ 
>  drivers/ntb/ntb_transport.c             |   20 +- 
>  drivers/ntb/test/ntb_perf.c             |   18 +- 
>  drivers/ntb/test/ntb_tool.c             |    6 +- 
>  drivers/pci/switch/switchtec.c          |  316 ++------ 
>  include/linux/ntb.h                     |   11 +- 
>  include/linux/switchtec.h               |  373 ++++++++++ 
>  tools/testing/selftests/ntb/ntb_test.sh |    4 + 
>  14 files changed, 1704 insertions(+), 283 deletions(-) 
>  create mode 100644 drivers/ntb/hw/mscc/Kconfig 
>  create mode 100644 drivers/ntb/hw/mscc/Makefile 
>  create mode 100644 drivers/ntb/hw/mscc/switchtec_ntb.c 
>  create mode 100644 include/linux/switchtec.h 
>
> -- 
> 2.11.0 
>

------=_Part_1548_1106844851.1510313244921
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Dear Logan and all,<div><br></div><div>I am working with S=
witchtec-NTB from Microsemi.</div><div>The driver is working fine, but if o=
ne side computer recovers from a crash due to another reason, they will los=
t connection, and the other side need to reload the drivers in order to rec=
onnect to the other side.<br><br>Have you ever gotten this problem before ?=
</div><div><br></div><div>Thanks a lot !<br><br>On Wednesday, 19 July 2017 =
00:04:24 UTC+8, Logan Gunthorpe  wrote:<blockquote class=3D"gmail_quote" st=
yle=3D"margin: 0;margin-left: 0.8ex;border-left: 1px #ccc solid;padding-lef=
t: 1ex;">Changes since v1:
<br>
<br>- Rebased onto latest ntb-next branch (with v4.13-rc1)
<br>- Reworked ntb_mw_count() function so that it can be called all the
<br>=C2=A0 time (per discussion with Allen)
<br>- Various spelling and formatting cleanups from Bjorn
<br>- Added request_module() call such that the NTB module is automatically
<br>=C2=A0 loaded when appropriate hardware exists.
<br>
<br>--
<br>
<br>Changes since the rfc:
<br>
<br>- Rebased on ntb-next
<br>- Switched ntb_part_op to use sleep instead of delay
<br>- Dropped a number of useless dbg __func__ prints
<br>- Went back to the dynamic instead of the static class
<br>- Swapped the notifier block for a simple callback
<br>- Modified the new ntb api so that a couple functions with pidx
<br>=C2=A0 now must be called after link up. Per our discussion on the list=
.
<br>
<br>--
<br>
<br>This patchset implements Non-Transparent Bridge (NTB) support for the
<br>Microsemi Switchtec series of switches. We&#39;re looking for some
<br>review from the community at this point but hope to get it upstreamed
<br>for v4.14.
<br>
<br>Switchtec NTB support is configured over the same function and bar
<br>as the management endpoint. Thus, the new driver hooks into the
<br>management driver which we had merged in v4.12. We use the class
<br>interface API to register an NTB device for every switchtec device
<br>which supports NTB (not all do).
<br>
<br>The Switchtec hardware supports doorbells, memory windows and messages.
<br>Seeing there is no native scratchpad support, 128 spads are emulated
<br>through the use of a pre-setup memory window. The switch has 64
<br>doorbells which are shared between the two partitions and a
<br>configurable set of memory windows. While the hardware supports more
<br>than 2 partitions, this driver only supports the first two seeing
<br>the current NTB API only supports two hosts.
<br>
<br>The driver has been tested with ntb_netdev and fully passes the
<br>ntb_test script.
<br>
<br>This patchset is based off of ntb-next and can be found in this
<br>git repo:
<br>
<br><a href=3D"https://github.com/sbates130272/linux-p2pmem.git" target=3D"=
_blank" rel=3D"nofollow" onmousedown=3D"this.href=3D&#39;https://www.google=
.com/url?q\x3dhttps%3A%2F%2Fgithub.com%2Fsbates130272%2Flinux-p2pmem.git\x2=
6sa\x3dD\x26sntz\x3d1\x26usg\x3dAFQjCNFcm4BPc53SU912iChz8na-KBFNtw&#39;;ret=
urn true;" onclick=3D"this.href=3D&#39;https://www.google.com/url?q\x3dhttp=
s%3A%2F%2Fgithub.com%2Fsbates130272%2Flinux-p2pmem.git\x26sa\x3dD\x26sntz\x=
3d1\x26usg\x3dAFQjCNFcm4BPc53SU912iChz8na-KBFNtw&#39;;return true;">https:/=
/github.com/<wbr>sbates130272/linux-p2pmem.git</a> switchtec_ntb_v2
<br>
<br>Logan Gunthorpe (16):
<br>=C2=A0 switchtec: move structure definitions into a common header
<br>=C2=A0 switchtec: export class symbol for use in upper layer driver
<br>=C2=A0 switchtec: add NTB hardware register definitions
<br>=C2=A0 switchtec: add link event notifier callback
<br>=C2=A0 ntb: ensure ntb_mw_get_align() is only called when the link is u=
p
<br>=C2=A0 ntb: add check and comment for link up to mw_count() and
<br>=C2=A0 =C2=A0 mw_get_align()
<br>=C2=A0 ntb: ntb_test: ensure the link is up before trying to configure =
the
<br>=C2=A0 =C2=A0 mws
<br>=C2=A0 switchtec_ntb: introduce initial NTB driver
<br>=C2=A0 switchtec_ntb: initialize hardware for memory windows
<br>=C2=A0 switchtec_ntb: initialize hardware for doorbells and messages
<br>=C2=A0 switchtec_ntb: add skeleton NTB driver
<br>=C2=A0 switchtec_ntb: add link management
<br>=C2=A0 switchtec_ntb: implement doorbell registers
<br>=C2=A0 switchtec_ntb: implement scratchpad registers
<br>=C2=A0 switchtec_ntb: add memory window support
<br>=C2=A0 switchtec_ntb: update switchtec documentation with notes for NTB
<br>
<br>=C2=A0Documentation/switchtec.txt =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | =C2=A0 12 +
<br>=C2=A0MAINTAINERS =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A02 +
<br>=C2=A0drivers/ntb/hw/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A01 +
<br>=C2=A0drivers/ntb/hw/Makefile =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 | =C2=A0 =C2=A01 +
<br>=C2=A0drivers/ntb/hw/mscc/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | =C2=A0 =C2=A09 +
<br>=C2=A0drivers/ntb/hw/mscc/Makefile =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| =C2=A0 =C2=A01 +
<br>=C2=A0drivers/ntb/hw/mscc/<wbr>switchtec_ntb.c =C2=A0 =C2=A0 | 1213 +++=
+++++++++++++++++++++++++++<wbr>+
<br>=C2=A0drivers/ntb/ntb_transport.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | =C2=A0 20 +-
<br>=C2=A0drivers/ntb/test/ntb_perf.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | =C2=A0 18 +-
<br>=C2=A0drivers/ntb/test/ntb_tool.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | =C2=A0 =C2=A06 +-
<br>=C2=A0drivers/pci/switch/switchtec.<wbr>c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| =C2=A0316 ++------
<br>=C2=A0include/linux/ntb.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 11 +-
<br>=C2=A0include/linux/switchtec.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | =C2=A0373 ++++++++++
<br>=C2=A0tools/testing/selftests/ntb/<wbr>ntb_test.sh | =C2=A0 =C2=A04 +
<br>=C2=A014 files changed, 1704 insertions(+), 283 deletions(-)
<br>=C2=A0create mode 100644 drivers/ntb/hw/mscc/Kconfig
<br>=C2=A0create mode 100644 drivers/ntb/hw/mscc/Makefile
<br>=C2=A0create mode 100644 drivers/ntb/hw/mscc/switchtec_<wbr>ntb.c
<br>=C2=A0create mode 100644 include/linux/switchtec.h
<br>
<br>--
<br>2.11.0
<br></blockquote></div></div>
------=_Part_1548_1106844851.1510313244921--

------=_Part_1547_902866243.1510313244921--
