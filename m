Date: Sun, 15 Jan 2017 15:33:45 -0800 (PST)
From: jmrodriguezhw88@gmail.com
Message-Id: <fda357fa-8f54-4b72-8417-925572d9cb2b@googlegroups.com>
In-Reply-To: <1484094731-15965-1-git-send-email-logang@deltatee.com>
References: <1484094731-15965-1-git-send-email-logang@deltatee.com>
Subject: Re: [PATCH 0/2] Style fixes: open code obfuscating macros
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_4321_99687317.1484523225270"
To: linux-ntb <linux-ntb@googlegroups.com>
Cc: Xiangliang.Yu@amd.com, jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com, joe@perches.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, logang@deltatee.com
List-ID: <linux-ntb.googlegroups.com>

------=_Part_4321_99687317.1484523225270
Content-Type: multipart/alternative; 
	boundary="----=_Part_4322_1055698061.1484523225271"

------=_Part_4322_1055698061.1484523225271
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On Tuesday, January 10, 2017 at 4:33:17 PM UTC-8, Logan Gunthorpe wrote:
>
> Hi, 
>
> I had copied some poor code style from the NTB drivers into an unrelated 
> driver. Upon review of my new code, I learned it was not a good idea 
> to sweep dirty things under the rug^W macro. See [1], where Gregg k-h 
> suggested I fix the problem at the source. 
>
> Thus, please merge the following two patches to improve the style of 
> the NTB drivers. 
>
> Thanks, 
>
> Logan 
>
> [1] http://www.spinics.net/lists/linux-pci/msg56904.html 
>
>
> Logan Gunthorpe (2): 
>   ntb_hw_amd: Style fixes: open code macros that just obfuscate code 
>   ntb_hw_intel: Style fixes: open code macros that just obfuscate code 
>
>  drivers/ntb/hw/amd/ntb_hw_amd.c     |  59 ++++++++------- 
>  drivers/ntb/hw/amd/ntb_hw_amd.h     |   3 - 
>  drivers/ntb/hw/intel/ntb_hw_intel.c | 145 
> ++++++++++++++++++------------------ 
>  drivers/ntb/hw/intel/ntb_hw_intel.h |   3 - 
>  4 files changed, 104 insertions(+), 106 deletions(-) 
>
> -- 
> 2.1.4 
>

On Tuesday, January 10, 2017 at 4:33:17 PM UTC-8, Logan Gunthorpe wrote:
>
> Hi, 
>
> I had copied some poor code style from the NTB drivers into an unrelated 
> driver. Upon review of my new code, I learned it was not a good idea 
> to sweep dirty things under the rug^W macro. See [1], where Gregg k-h 
> suggested I fix the problem at the source. 
>
> Thus, please merge the following two patches to improve the style of 
> the NTB drivers. 
>
> Thanks, 
>
> Logan 
>
> [1] http://www.spinics.net/lists/linux-pci/msg56904.html 
>
>
> Logan Gunthorpe (2): 
>   ntb_hw_amd: Style fixes: open code macros that just obfuscate code 
>   ntb_hw_intel: Style fixes: open code macros that just obfuscate code 
>
>  drivers/ntb/hw/amd/ntb_hw_amd.c     |  59 ++++++++------- 
>  drivers/ntb/hw/amd/ntb_hw_amd.h     |   3 - 
>  drivers/ntb/hw/intel/ntb_hw_intel.c | 145 
> ++++++++++++++++++------------------ 
>  drivers/ntb/hw/intel/ntb_hw_intel.h |   3 - 
>  4 files changed, 104 insertions(+), 106 deletions(-) 
>
> -- 
> 2.1.4 
>

------=_Part_4322_1055698061.1484523225271
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Tuesday, January 10, 2017 at 4:33:17 PM UTC-8, =
Logan Gunthorpe wrote:<blockquote class=3D"gmail_quote" style=3D"margin: 0;=
margin-left: 0.8ex;border-left: 1px #ccc solid;padding-left: 1ex;">Hi,
<br>
<br>I had copied some poor code style from the NTB drivers into an unrelate=
d
<br>driver. Upon review of my new code, I learned it was not a good idea
<br>to sweep dirty things under the rug^W macro. See [1], where Gregg k-h
<br>suggested I fix the problem at the source.
<br>
<br>Thus, please merge the following two patches to improve the style of
<br>the NTB drivers.
<br>
<br>Thanks,
<br>
<br>Logan
<br>
<br>[1] <a href=3D"http://www.spinics.net/lists/linux-pci/msg56904.html" ta=
rget=3D"_blank" rel=3D"nofollow" onmousedown=3D"this.href=3D&#39;http://www=
.google.com/url?q\x3dhttp%3A%2F%2Fwww.spinics.net%2Flists%2Flinux-pci%2Fmsg=
56904.html\x26sa\x3dD\x26sntz\x3d1\x26usg\x3dAFQjCNFndIhfDjSiJhG-hDUi5VeqN3=
9Tsg&#39;;return true;" onclick=3D"this.href=3D&#39;http://www.google.com/u=
rl?q\x3dhttp%3A%2F%2Fwww.spinics.net%2Flists%2Flinux-pci%2Fmsg56904.html\x2=
6sa\x3dD\x26sntz\x3d1\x26usg\x3dAFQjCNFndIhfDjSiJhG-hDUi5VeqN39Tsg&#39;;ret=
urn true;">http://www.spinics.net/lists/<wbr>linux-pci/msg56904.html</a>
<br>
<br>
<br>Logan Gunthorpe (2):
<br>=C2=A0 ntb_hw_amd: Style fixes: open code macros that just obfuscate co=
de
<br>=C2=A0 ntb_hw_intel: Style fixes: open code macros that just obfuscate =
code
<br>
<br>=C2=A0drivers/ntb/hw/amd/ntb_hw_<wbr>amd.c =C2=A0 =C2=A0 | =C2=A059 +++=
+++++-------
<br>=C2=A0drivers/ntb/hw/amd/ntb_hw_<wbr>amd.h =C2=A0 =C2=A0 | =C2=A0 3 -
<br>=C2=A0drivers/ntb/hw/intel/ntb_hw_<wbr>intel.c | 145 ++++++++++++++++++=
------------<wbr>------
<br>=C2=A0drivers/ntb/hw/intel/ntb_hw_<wbr>intel.h | =C2=A0 3 -
<br>=C2=A04 files changed, 104 insertions(+), 106 deletions(-)
<br>
<br>--
<br>2.1.4
<br></blockquote><br>On Tuesday, January 10, 2017 at 4:33:17 PM UTC-8, Loga=
n Gunthorpe wrote:<blockquote class=3D"gmail_quote" style=3D"margin: 0;marg=
in-left: 0.8ex;border-left: 1px #ccc solid;padding-left: 1ex;">Hi,
<br>
<br>I had copied some poor code style from the NTB drivers into an unrelate=
d
<br>driver. Upon review of my new code, I learned it was not a good idea
<br>to sweep dirty things under the rug^W macro. See [1], where Gregg k-h
<br>suggested I fix the problem at the source.
<br>
<br>Thus, please merge the following two patches to improve the style of
<br>the NTB drivers.
<br>
<br>Thanks,
<br>
<br>Logan
<br>
<br>[1] <a href=3D"http://www.spinics.net/lists/linux-pci/msg56904.html" ta=
rget=3D"_blank" rel=3D"nofollow" onmousedown=3D"this.href=3D&#39;http://www=
.google.com/url?q\x3dhttp%3A%2F%2Fwww.spinics.net%2Flists%2Flinux-pci%2Fmsg=
56904.html\x26sa\x3dD\x26sntz\x3d1\x26usg\x3dAFQjCNFndIhfDjSiJhG-hDUi5VeqN3=
9Tsg&#39;;return true;" onclick=3D"this.href=3D&#39;http://www.google.com/u=
rl?q\x3dhttp%3A%2F%2Fwww.spinics.net%2Flists%2Flinux-pci%2Fmsg56904.html\x2=
6sa\x3dD\x26sntz\x3d1\x26usg\x3dAFQjCNFndIhfDjSiJhG-hDUi5VeqN39Tsg&#39;;ret=
urn true;">http://www.spinics.net/lists/<wbr>linux-pci/msg56904.html</a>
<br>
<br>
<br>Logan Gunthorpe (2):
<br>=C2=A0 ntb_hw_amd: Style fixes: open code macros that just obfuscate co=
de
<br>=C2=A0 ntb_hw_intel: Style fixes: open code macros that just obfuscate =
code
<br>
<br>=C2=A0drivers/ntb/hw/amd/ntb_hw_<wbr>amd.c =C2=A0 =C2=A0 | =C2=A059 +++=
+++++-------
<br>=C2=A0drivers/ntb/hw/amd/ntb_hw_<wbr>amd.h =C2=A0 =C2=A0 | =C2=A0 3 -
<br>=C2=A0drivers/ntb/hw/intel/ntb_hw_<wbr>intel.c | 145 ++++++++++++++++++=
------------<wbr>------
<br>=C2=A0drivers/ntb/hw/intel/ntb_hw_<wbr>intel.h | =C2=A0 3 -
<br>=C2=A04 files changed, 104 insertions(+), 106 deletions(-)
<br>
<br>--
<br>2.1.4
<br></blockquote></div>
------=_Part_4322_1055698061.1484523225271--

------=_Part_4321_99687317.1484523225270--
