Date: Thu, 12 Jan 2017 07:29:58 -0800 (PST)
From: shlemisto@gmail.com
Message-Id: <1d63eddd-e9b2-4023-8e0c-6bc658633b9a@googlegroups.com>
In-Reply-To: <422f314a-de5e-06a0-33cd-a6d894db1d61@intel.com>
References: <360341483979222@web10o.yandex.ru>
 <CAPoiz9zYa19b1fHVJFvmM-qrNigXkxDTvV3Hrjc81H0tfaMPKA@mail.gmail.com>
 <7784bee8-663d-bd89-2d2b-ef47081153d1@intel.com>
 <c18c3dc2-d242-4352-946e-931ff13e1d28@googlegroups.com>
 <6664bf72-a4bb-4081-0fb9-13c66adbec4e@intel.com>
 <422f314a-de5e-06a0-33cd-a6d894db1d61@intel.com>
Subject: Re: Problem with ntb_transport + ntb_netdev
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_233_1731089330.1484234999032"
To: linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

------=_Part_233_1731089330.1484234999032
Content-Type: multipart/alternative; 
	boundary="----=_Part_234_1144932586.1484234999033"

------=_Part_234_1144932586.1484234999033
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

I built this kernel.
Unfortunately link doesn't train.

ntb_hw_intel_1 <http://pastebin.com/ZvCK9yu5> - 1'st side
ntb_hw_intel_2 <http://pastebin.com/p8BJ83pv> - 2'nd side

=D1=81=D1=80=D0=B5=D0=B4=D0=B0, 11 =D1=8F=D0=BD=D0=B2=D0=B0=D1=80=D1=8F 201=
7 =D0=B3., 19:45:05 UTC+3 =D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=D0=BE=D0=B2=D0=B0=
=D1=82=D0=B5=D0=BB=D1=8C dave.jiang =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=
=BB:
>
>
>
> On 01/11/2017 09:42 AM, Dave Jiang wrote:=20
> >=20
> >=20
> > On 01/11/2017 03:08 AM, shle...@gmail.com <javascript:> wrote:=20
> >>> Do pings in the other direction work?=20
> >> Similarly=20
> >>> How are the NTBs connected?=20
> >> B2B=20
> >>> And which distro are you running?=20
> >> Ubuntu 16.10 with kernel 4.10.0-rc1 from git=20
> >>>  Sometimes=20
> >> Network Manager will yank the IP for no reason if you don't configure=
=20
> it=20
> >> correctly and thus your interface can't route.=20
> >> I stop network-manager service before load the modules and set IP=20
> manually.=20
> >>=20
> >>> Also can you dump the stats in debugfs?=20
> >> ntb_hw_intel_info_1 <http://pastebin.com/eyMZzSik> - one side=20
> >> ntb_hw_intel_info_2 <http://pastebin.com/vF94zLBk> - second side=20
> >> ntb_transport_info_1 <http://pastebin.com/Ktq1yAqa> - one side=20
> >> ntb_transport_info_2 <http://pastebin.com/w8r08ezB> - second side=20
> >=20
> > Your secondary BAR2 size is not the same as your primary. They both nee=
d=20
> > to be 22. Also all the upstream memory miss is concerning. You should=
=20
> > have none. You may have signal integrity issues. But fix the bar size=
=20
> > first and see if that helps.=20
>
> Also, if you are using Broadwell Xeon D, you should use the kernel from=
=20
> here and not upstream.=20
> https://github.com/davejiang/linux=20
> branch: davejiang/ntb=20
>
>
>
> >=20
> >>=20
> >> =D1=81=D1=80=D0=B5=D0=B4=D0=B0, 11 =D1=8F=D0=BD=D0=B2=D0=B0=D1=80=D1=
=8F 2017 =D0=B3., 1:24:17 UTC+3 =D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=D0=BE=D0=B2=
=D0=B0=D1=82=D0=B5=D0=BB=D1=8C dave.jiang=20
> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB:=20
> >>=20
> >>     On 01/10/2017 03:03 PM, Jon Mason wrote:=20
> >>     > Adding the NTB mailing list=20
> >>     >=20
> >>     > On Mon, Jan 9, 2017 at 11:27 AM, perplexus <perp...@ya.ru=20
> >>     <javascript:>> wrote:=20
> >>     >> Hello.=20
> >>     >>=20
> >>     >> I'm working with NTB (kernel version 4.10) on Xeon D-1527 CPU=
=20
> and=20
> >>     have a problem with couple ntb_transport + ntb_netdev.=20
> >>     >>=20
> >>     >> On the local side I run:=20
> >>     >> sudo /etc/init.d/irqbalance stop=20
> >>     >> sudo modprobe ntb_transport dyndbg=3D+p=20
> >>     >> sudo modprobe ntb_netdev dyndbg=3D+p=20
> >>     >> sudo ifconfig eth0 192.168.1.1 up=20
> >>     >>=20
> >>     >> On the remote side I run:=20
> >>     >> sudo /etc/init.d/irqbalance stop=20
> >>     >> sudo modprobe ntb_transport dyndbg=3D+p=20
> >>     >> sudo modprobe ntb_netdev dyndbg=3D+p=20
> >>     >> sudo ifconfig eth0 192.168.1.2 up=20
> >>     >>=20
> >>     >> Along with these steps I run ping 192.168.1.2 and get about 2-3=
=20
> >>     successfull transmitted/received packets then get 'Destination hos=
t=20
> >>     unreacheble'.=20
> >>     >>=20
> >>     >=20
> >>     > Do pings in the other direction work?=20
> >>     >=20
> >>     How are the NTBs connected? Where did the get the hardware? Also=
=20
> can=20
> >>     you=20
> >>     dump the stats in debugfs? And which distro are you running?=20
> Sometimes=20
> >>     Network Manager will yank the IP for no reason if you don't=20
> >>     configure it=20
> >>     correctly and thus your interface can't route.=20
> >>=20
> >> --=20
> >> You received this message because you are subscribed to the Google=20
> >> Groups "linux-ntb" group.=20
> >> To unsubscribe from this group and stop receiving emails from it, send=
=20
> >> an email to linux-ntb+...@googlegroups.com <javascript:>=20
> >> <mailto:linux-ntb+...@googlegroups.com <javascript:>>.=20
> >> To post to this group, send email to linu...@googlegroups.com=20
> <javascript:>=20
> >> <mailto:linu...@googlegroups.com <javascript:>>.=20
> >> To view this discussion on the web visit=20
> >>=20
> https://groups.google.com/d/msgid/linux-ntb/c18c3dc2-d242-4352-946e-931ff=
13e1d28%40googlegroups.com=20
> >> <
> https://groups.google.com/d/msgid/linux-ntb/c18c3dc2-d242-4352-946e-931ff=
13e1d28%40googlegroups.com?utm_medium=3Demail&utm_source=3Dfooter>.=20
>
> >> For more options, visit https://groups.google.com/d/optout.=20
> >=20
>

------=_Part_234_1144932586.1484234999033
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I built this kernel.<div>Unfortunately link doesn&#39;t tr=
ain.<br><div><div><div><br><a href=3D"http://pastebin.com/ZvCK9yu5">ntb_hw_=
intel_1</a>=C2=A0- 1&#39;st side</div><div><a href=3D"http://pastebin.com/p=
8BJ83pv">ntb_hw_intel_2</a>=C2=A0- 2&#39;nd side<br></div><div><br>=D1=81=
=D1=80=D0=B5=D0=B4=D0=B0, 11 =D1=8F=D0=BD=D0=B2=D0=B0=D1=80=D1=8F 2017 =D0=
=B3., 19:45:05 UTC+3 =D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=D0=BE=D0=B2=D0=B0=D1=82=
=D0=B5=D0=BB=D1=8C dave.jiang =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB:<b=
lockquote class=3D"gmail_quote" style=3D"margin: 0;margin-left: 0.8ex;borde=
r-left: 1px #ccc solid;padding-left: 1ex;">
<br>
<br>On 01/11/2017 09:42 AM, Dave Jiang wrote:
<br>&gt;=20
<br>&gt;=20
<br>&gt; On 01/11/2017 03:08 AM, <a href=3D"javascript:" target=3D"_blank" =
gdf-obfuscated-mailto=3D"BfQaf2c4FQAJ" rel=3D"nofollow" onmousedown=3D"this=
.href=3D&#39;javascript:&#39;;return true;" onclick=3D"this.href=3D&#39;jav=
ascript:&#39;;return true;">shle...@gmail.com</a> wrote:
<br>&gt;&gt;&gt; Do pings in the other direction work?=20
<br>&gt;&gt; Similarly
<br>&gt;&gt;&gt; How are the NTBs connected?
<br>&gt;&gt; B2B
<br>&gt;&gt;&gt; And which distro are you running?
<br>&gt;&gt; Ubuntu 16.10 with kernel 4.10.0-rc1 from git
<br>&gt;&gt;&gt; =C2=A0Sometimes=20
<br>&gt;&gt; Network Manager will yank the IP for no reason if you don&#39;=
t configure it=20
<br>&gt;&gt; correctly and thus your interface can&#39;t route.
<br>&gt;&gt; I stop network-manager service before load the modules and set=
 IP manually.
<br>&gt;&gt;
<br>&gt;&gt;&gt; Also can you dump the stats in debugfs?
<br>&gt;&gt; ntb_hw_intel_info_1 &lt;<a href=3D"http://pastebin.com/eyMZzSi=
k" target=3D"_blank" rel=3D"nofollow" onmousedown=3D"this.href=3D&#39;http:=
//www.google.com/url?q\x3dhttp%3A%2F%2Fpastebin.com%2FeyMZzSik\x26sa\x3dD\x=
26sntz\x3d1\x26usg\x3dAFQjCNEuUf2n5YqH1UUuemQzTb6N35gHuA&#39;;return true;"=
 onclick=3D"this.href=3D&#39;http://www.google.com/url?q\x3dhttp%3A%2F%2Fpa=
stebin.com%2FeyMZzSik\x26sa\x3dD\x26sntz\x3d1\x26usg\x3dAFQjCNEuUf2n5YqH1UU=
uemQzTb6N35gHuA&#39;;return true;">http://pastebin.com/eyMZzSik</a>&gt; - o=
ne side
<br>&gt;&gt; ntb_hw_intel_info_2 &lt;<a href=3D"http://pastebin.com/vF94zLB=
k" target=3D"_blank" rel=3D"nofollow" onmousedown=3D"this.href=3D&#39;http:=
//www.google.com/url?q\x3dhttp%3A%2F%2Fpastebin.com%2FvF94zLBk\x26sa\x3dD\x=
26sntz\x3d1\x26usg\x3dAFQjCNF4ELEk6RyRY3eHJwcvx0f6HszEwQ&#39;;return true;"=
 onclick=3D"this.href=3D&#39;http://www.google.com/url?q\x3dhttp%3A%2F%2Fpa=
stebin.com%2FvF94zLBk\x26sa\x3dD\x26sntz\x3d1\x26usg\x3dAFQjCNF4ELEk6RyRY3e=
HJwcvx0f6HszEwQ&#39;;return true;">http://pastebin.com/vF94zLBk</a>&gt; - s=
econd side
<br>&gt;&gt; ntb_transport_info_1 &lt;<a href=3D"http://pastebin.com/Ktq1yA=
qa" target=3D"_blank" rel=3D"nofollow" onmousedown=3D"this.href=3D&#39;http=
://www.google.com/url?q\x3dhttp%3A%2F%2Fpastebin.com%2FKtq1yAqa\x26sa\x3dD\=
x26sntz\x3d1\x26usg\x3dAFQjCNFtRKh4STqIbx7y5C9AyhjNI77sAA&#39;;return true;=
" onclick=3D"this.href=3D&#39;http://www.google.com/url?q\x3dhttp%3A%2F%2Fp=
astebin.com%2FKtq1yAqa\x26sa\x3dD\x26sntz\x3d1\x26usg\x3dAFQjCNFtRKh4STqIbx=
7y5C9AyhjNI77sAA&#39;;return true;">http://pastebin.com/Ktq1yAqa</a>&gt; - =
one side
<br>&gt;&gt; ntb_transport_info_2 &lt;<a href=3D"http://pastebin.com/w8r08e=
zB" target=3D"_blank" rel=3D"nofollow" onmousedown=3D"this.href=3D&#39;http=
://www.google.com/url?q\x3dhttp%3A%2F%2Fpastebin.com%2Fw8r08ezB\x26sa\x3dD\=
x26sntz\x3d1\x26usg\x3dAFQjCNFEzsGDOKro9GnN8q4uqnyE8VAi9A&#39;;return true;=
" onclick=3D"this.href=3D&#39;http://www.google.com/url?q\x3dhttp%3A%2F%2Fp=
astebin.com%2Fw8r08ezB\x26sa\x3dD\x26sntz\x3d1\x26usg\x3dAFQjCNFEzsGDOKro9G=
nN8q4uqnyE8VAi9A&#39;;return true;">http://pastebin.com/w8r08ezB</a>&gt; - =
second side
<br>&gt;=20
<br>&gt; Your secondary BAR2 size is not the same as your primary. They bot=
h need
<br>&gt; to be 22. Also all the upstream memory miss is concerning. You sho=
uld
<br>&gt; have none. You may have signal integrity issues. But fix the bar s=
ize
<br>&gt; first and see if that helps.
<br>
<br>Also, if you are using Broadwell Xeon D, you should use the kernel from
<br>here and not upstream.
<br><a href=3D"https://github.com/davejiang/linux" target=3D"_blank" rel=3D=
"nofollow" onmousedown=3D"this.href=3D&#39;https://www.google.com/url?q\x3d=
https%3A%2F%2Fgithub.com%2Fdavejiang%2Flinux\x26sa\x3dD\x26sntz\x3d1\x26usg=
\x3dAFQjCNE0b4BAqhdI1xAcXM_GkRacbJ0R_w&#39;;return true;" onclick=3D"this.h=
ref=3D&#39;https://www.google.com/url?q\x3dhttps%3A%2F%2Fgithub.com%2Fdavej=
iang%2Flinux\x26sa\x3dD\x26sntz\x3d1\x26usg\x3dAFQjCNE0b4BAqhdI1xAcXM_GkRac=
bJ0R_w&#39;;return true;">https://github.com/davejiang/<wbr>linux</a>
<br>branch: davejiang/ntb
<br>
<br>
<br>
<br>&gt;=20
<br>&gt;&gt;
<br>&gt;&gt; =D1=81=D1=80=D0=B5=D0=B4=D0=B0, 11 =D1=8F=D0=BD=D0=B2=D0=B0=D1=
=80=D1=8F 2017 =D0=B3., 1:24:17 UTC+3 =D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=D0=BE=
=D0=B2=D0=B0=D1=82=D0=B5=D0=BB=D1=8C dave.jiang =D0=BD=D0=B0=D0=BF=D0=B8=D1=
=81=D0=B0=D0=BB:
<br>&gt;&gt;
<br>&gt;&gt; =C2=A0 =C2=A0 On 01/10/2017 03:03 PM, Jon Mason wrote:
<br>&gt;&gt; =C2=A0 =C2=A0 &gt; Adding the NTB mailing list
<br>&gt;&gt; =C2=A0 =C2=A0 &gt;
<br>&gt;&gt; =C2=A0 =C2=A0 &gt; On Mon, Jan 9, 2017 at 11:27 AM, perplexus =
&lt;<a>perp...@ya.ru</a>
<br>&gt;&gt; =C2=A0 =C2=A0 &lt;javascript:&gt;&gt; wrote:
<br>&gt;&gt; =C2=A0 =C2=A0 &gt;&gt; Hello.
<br>&gt;&gt; =C2=A0 =C2=A0 &gt;&gt;
<br>&gt;&gt; =C2=A0 =C2=A0 &gt;&gt; I&#39;m working with NTB (kernel versio=
n 4.10) on Xeon D-1527 CPU and
<br>&gt;&gt; =C2=A0 =C2=A0 have a problem with couple ntb_transport + ntb_n=
etdev.
<br>&gt;&gt; =C2=A0 =C2=A0 &gt;&gt;
<br>&gt;&gt; =C2=A0 =C2=A0 &gt;&gt; On the local side I run:
<br>&gt;&gt; =C2=A0 =C2=A0 &gt;&gt; sudo /etc/init.d/irqbalance stop
<br>&gt;&gt; =C2=A0 =C2=A0 &gt;&gt; sudo modprobe ntb_transport dyndbg=3D+p
<br>&gt;&gt; =C2=A0 =C2=A0 &gt;&gt; sudo modprobe ntb_netdev dyndbg=3D+p
<br>&gt;&gt; =C2=A0 =C2=A0 &gt;&gt; sudo ifconfig eth0 192.168.1.1 up
<br>&gt;&gt; =C2=A0 =C2=A0 &gt;&gt;
<br>&gt;&gt; =C2=A0 =C2=A0 &gt;&gt; On the remote side I run:
<br>&gt;&gt; =C2=A0 =C2=A0 &gt;&gt; sudo /etc/init.d/irqbalance stop
<br>&gt;&gt; =C2=A0 =C2=A0 &gt;&gt; sudo modprobe ntb_transport dyndbg=3D+p
<br>&gt;&gt; =C2=A0 =C2=A0 &gt;&gt; sudo modprobe ntb_netdev dyndbg=3D+p
<br>&gt;&gt; =C2=A0 =C2=A0 &gt;&gt; sudo ifconfig eth0 192.168.1.2 up
<br>&gt;&gt; =C2=A0 =C2=A0 &gt;&gt;
<br>&gt;&gt; =C2=A0 =C2=A0 &gt;&gt; Along with these steps I run ping 192.1=
68.1.2 and get about 2-3
<br>&gt;&gt; =C2=A0 =C2=A0 successfull transmitted/received packets then ge=
t &#39;Destination host
<br>&gt;&gt; =C2=A0 =C2=A0 unreacheble&#39;.
<br>&gt;&gt; =C2=A0 =C2=A0 &gt;&gt;
<br>&gt;&gt; =C2=A0 =C2=A0 &gt;
<br>&gt;&gt; =C2=A0 =C2=A0 &gt; Do pings in the other direction work?
<br>&gt;&gt; =C2=A0 =C2=A0 &gt;
<br>&gt;&gt; =C2=A0 =C2=A0 How are the NTBs connected? Where did the get th=
e hardware? Also can
<br>&gt;&gt; =C2=A0 =C2=A0 you
<br>&gt;&gt; =C2=A0 =C2=A0 dump the stats in debugfs? And which distro are =
you running? Sometimes
<br>&gt;&gt; =C2=A0 =C2=A0 Network Manager will yank the IP for no reason i=
f you don&#39;t
<br>&gt;&gt; =C2=A0 =C2=A0 configure it
<br>&gt;&gt; =C2=A0 =C2=A0 correctly and thus your interface can&#39;t rout=
e.
<br>&gt;&gt;
<br>&gt;&gt; --=20
<br>&gt;&gt; You received this message because you are subscribed to the Go=
ogle
<br>&gt;&gt; Groups &quot;linux-ntb&quot; group.
<br>&gt;&gt; To unsubscribe from this group and stop receiving emails from =
it, send
<br>&gt;&gt; an email to <a href=3D"javascript:" target=3D"_blank" gdf-obfu=
scated-mailto=3D"BfQaf2c4FQAJ" rel=3D"nofollow" onmousedown=3D"this.href=3D=
&#39;javascript:&#39;;return true;" onclick=3D"this.href=3D&#39;javascript:=
&#39;;return true;">linux-ntb+...@<wbr>googlegroups.com</a>
<br>&gt;&gt; &lt;mailto:<a href=3D"javascript:" target=3D"_blank" gdf-obfus=
cated-mailto=3D"BfQaf2c4FQAJ" rel=3D"nofollow" onmousedown=3D"this.href=3D&=
#39;javascript:&#39;;return true;" onclick=3D"this.href=3D&#39;javascript:&=
#39;;return true;">linux-ntb+...@<wbr>googlegroups.com</a>&gt;.
<br>&gt;&gt; To post to this group, send email to <a href=3D"javascript:" t=
arget=3D"_blank" gdf-obfuscated-mailto=3D"BfQaf2c4FQAJ" rel=3D"nofollow" on=
mousedown=3D"this.href=3D&#39;javascript:&#39;;return true;" onclick=3D"thi=
s.href=3D&#39;javascript:&#39;;return true;">linu...@googlegroups.com</a>
<br>&gt;&gt; &lt;mailto:<a href=3D"javascript:" target=3D"_blank" gdf-obfus=
cated-mailto=3D"BfQaf2c4FQAJ" rel=3D"nofollow" onmousedown=3D"this.href=3D&=
#39;javascript:&#39;;return true;" onclick=3D"this.href=3D&#39;javascript:&=
#39;;return true;">linu...@<wbr>googlegroups.com</a>&gt;.
<br>&gt;&gt; To view this discussion on the web visit
<br>&gt;&gt; <a href=3D"https://groups.google.com/d/msgid/linux-ntb/c18c3dc=
2-d242-4352-946e-931ff13e1d28%40googlegroups.com" target=3D"_blank" rel=3D"=
nofollow" onmousedown=3D"this.href=3D&#39;https://groups.google.com/d/msgid=
/linux-ntb/c18c3dc2-d242-4352-946e-931ff13e1d28%40googlegroups.com&#39;;ret=
urn true;" onclick=3D"this.href=3D&#39;https://groups.google.com/d/msgid/li=
nux-ntb/c18c3dc2-d242-4352-946e-931ff13e1d28%40googlegroups.com&#39;;return=
 true;">https://groups.google.com/d/<wbr>msgid/linux-ntb/c18c3dc2-d242-<wbr=
>4352-946e-931ff13e1d28%<wbr>40googlegroups.com</a>
<br>&gt;&gt; &lt;<a href=3D"https://groups.google.com/d/msgid/linux-ntb/c18=
c3dc2-d242-4352-946e-931ff13e1d28%40googlegroups.com?utm_medium=3Demail&amp=
;utm_source=3Dfooter" target=3D"_blank" rel=3D"nofollow" onmousedown=3D"thi=
s.href=3D&#39;https://groups.google.com/d/msgid/linux-ntb/c18c3dc2-d242-435=
2-946e-931ff13e1d28%40googlegroups.com?utm_medium\x3demail\x26utm_source\x3=
dfooter&#39;;return true;" onclick=3D"this.href=3D&#39;https://groups.googl=
e.com/d/msgid/linux-ntb/c18c3dc2-d242-4352-946e-931ff13e1d28%40googlegroups=
.com?utm_medium\x3demail\x26utm_source\x3dfooter&#39;;return true;">https:/=
/groups.google.com/d/<wbr>msgid/linux-ntb/c18c3dc2-d242-<wbr>4352-946e-931f=
f13e1d28%<wbr>40googlegroups.com?utm_medium=3D<wbr>email&amp;utm_source=3Df=
ooter</a>&gt;.
<br>&gt;&gt; For more options, visit <a href=3D"https://groups.google.com/d=
/optout" target=3D"_blank" rel=3D"nofollow" onmousedown=3D"this.href=3D&#39=
;https://groups.google.com/d/optout&#39;;return true;" onclick=3D"this.href=
=3D&#39;https://groups.google.com/d/optout&#39;;return true;">https://group=
s.google.com/d/<wbr>optout</a>.
<br>&gt;=20
<br></blockquote></div></div></div></div></div>
------=_Part_234_1144932586.1484234999033--

------=_Part_233_1731089330.1484234999032--
