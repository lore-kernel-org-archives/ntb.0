Date: Wed, 11 Jan 2017 02:08:48 -0800 (PST)
From: shlemisto@gmail.com
Message-Id: <c18c3dc2-d242-4352-946e-931ff13e1d28@googlegroups.com>
In-Reply-To: <7784bee8-663d-bd89-2d2b-ef47081153d1@intel.com>
References: <360341483979222@web10o.yandex.ru>
 <CAPoiz9zYa19b1fHVJFvmM-qrNigXkxDTvV3Hrjc81H0tfaMPKA@mail.gmail.com>
 <7784bee8-663d-bd89-2d2b-ef47081153d1@intel.com>
Subject: Re: Problem with ntb_transport + ntb_netdev
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_1781_1836570804.1484129328817"
To: linux-ntb <linux-ntb@googlegroups.com>
Cc: jdmason@kudzu.us, perplexus@ya.ru
List-ID: <linux-ntb.googlegroups.com>

------=_Part_1781_1836570804.1484129328817
Content-Type: multipart/alternative; 
	boundary="----=_Part_1782_1658438205.1484129328817"

------=_Part_1782_1658438205.1484129328817
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

> Do pings in the other direction work?=20
Similarly
>How are the NTBs connected?
B2B
>And which distro are you running?
Ubuntu 16.10 with kernel 4.10.0-rc1 from git
>  Sometimes=20
Network Manager will yank the IP for no reason if you don't configure it=20
correctly and thus your interface can't route.
I stop network-manager service before load the modules and set IP manually.

> Also can you dump the stats in debugfs?
ntb_hw_intel_info_1 <http://pastebin.com/eyMZzSik> - one side
ntb_hw_intel_info_2 <http://pastebin.com/vF94zLBk> - second side
ntb_transport_info_1 <http://pastebin.com/Ktq1yAqa> - one side
ntb_transport_info_2 <http://pastebin.com/w8r08ezB> - second side

=D1=81=D1=80=D0=B5=D0=B4=D0=B0, 11 =D1=8F=D0=BD=D0=B2=D0=B0=D1=80=D1=8F 201=
7 =D0=B3., 1:24:17 UTC+3 =D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=D0=BE=D0=B2=D0=B0=
=D1=82=D0=B5=D0=BB=D1=8C dave.jiang =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=
=BB:
>
> On 01/10/2017 03:03 PM, Jon Mason wrote:=20
> > Adding the NTB mailing list=20
> >=20
> > On Mon, Jan 9, 2017 at 11:27 AM, perplexus <perp...@ya.ru <javascript:>=
>=20
> wrote:=20
> >> Hello.=20
> >>=20
> >> I'm working with NTB (kernel version 4.10) on Xeon D-1527 CPU and have=
=20
> a problem with couple ntb_transport + ntb_netdev.=20
> >>=20
> >> On the local side I run:=20
> >> sudo /etc/init.d/irqbalance stop=20
> >> sudo modprobe ntb_transport dyndbg=3D+p=20
> >> sudo modprobe ntb_netdev dyndbg=3D+p=20
> >> sudo ifconfig eth0 192.168.1.1 up=20
> >>=20
> >> On the remote side I run:=20
> >> sudo /etc/init.d/irqbalance stop=20
> >> sudo modprobe ntb_transport dyndbg=3D+p=20
> >> sudo modprobe ntb_netdev dyndbg=3D+p=20
> >> sudo ifconfig eth0 192.168.1.2 up=20
> >>=20
> >> Along with these steps I run ping 192.168.1.2 and get about 2-3=20
> successfull transmitted/received packets then get 'Destination host=20
> unreacheble'.=20
> >>=20
> >=20
> > Do pings in the other direction work?=20
> >=20
> How are the NTBs connected? Where did the get the hardware? Also can you=
=20
> dump the stats in debugfs? And which distro are you running? Sometimes=20
> Network Manager will yank the IP for no reason if you don't configure it=
=20
> correctly and thus your interface can't route.=20
>

------=_Part_1782_1658438205.1484129328817
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>&gt; Do pings in the other direction work?=C2=A0</div=
><div>Similarly</div><div>&gt;How are the NTBs connected?</div><div>B2B</di=
v><div>&gt;And which distro are you running?</div><div>Ubuntu 16.10 with ke=
rnel 4.10.0-rc1 from git</div><div>&gt; =C2=A0Sometimes=C2=A0</div><div>Net=
work Manager will yank the IP for no reason if you don&#39;t configure it=
=C2=A0</div><div>correctly and thus your interface can&#39;t route.</div><d=
iv>I stop network-manager service before load the modules and set IP manual=
ly.</div><div><br></div><div>&gt; Also can you dump the stats in debugfs?</=
div><div><a href=3D"http://pastebin.com/eyMZzSik">ntb_hw_intel_info_1</a>=
=C2=A0- one side<br></div><div><a href=3D"http://pastebin.com/vF94zLBk">ntb=
_hw_intel_info_2</a>=C2=A0- second side<br></div><div><a href=3D"http://pas=
tebin.com/Ktq1yAqa">ntb_transport_info_1</a>=C2=A0- one side<br></div><div>=
<a href=3D"http://pastebin.com/w8r08ezB">ntb_transport_info_2</a>=C2=A0- se=
cond side<br></div><br>=D1=81=D1=80=D0=B5=D0=B4=D0=B0, 11 =D1=8F=D0=BD=D0=
=B2=D0=B0=D1=80=D1=8F 2017 =D0=B3., 1:24:17 UTC+3 =D0=BF=D0=BE=D0=BB=D1=8C=
=D0=B7=D0=BE=D0=B2=D0=B0=D1=82=D0=B5=D0=BB=D1=8C dave.jiang =D0=BD=D0=B0=D0=
=BF=D0=B8=D1=81=D0=B0=D0=BB:<blockquote class=3D"gmail_quote" style=3D"marg=
in: 0;margin-left: 0.8ex;border-left: 1px #ccc solid;padding-left: 1ex;">On=
 01/10/2017 03:03 PM, Jon Mason wrote:
<br>&gt; Adding the NTB mailing list
<br>&gt;=20
<br>&gt; On Mon, Jan 9, 2017 at 11:27 AM, perplexus &lt;<a href=3D"javascri=
pt:" target=3D"_blank" gdf-obfuscated-mailto=3D"tVD7aFX8FAAJ" rel=3D"nofoll=
ow" onmousedown=3D"this.href=3D&#39;javascript:&#39;;return true;" onclick=
=3D"this.href=3D&#39;javascript:&#39;;return true;">perp...@ya.ru</a>&gt; w=
rote:
<br>&gt;&gt; Hello.
<br>&gt;&gt;
<br>&gt;&gt; I&#39;m working with NTB (kernel version 4.10) on Xeon D-1527 =
CPU and have a problem with couple ntb_transport + ntb_netdev.
<br>&gt;&gt;
<br>&gt;&gt; On the local side I run:
<br>&gt;&gt; sudo /etc/init.d/irqbalance stop
<br>&gt;&gt; sudo modprobe ntb_transport dyndbg=3D+p
<br>&gt;&gt; sudo modprobe ntb_netdev dyndbg=3D+p
<br>&gt;&gt; sudo ifconfig eth0 192.168.1.1 up
<br>&gt;&gt;
<br>&gt;&gt; On the remote side I run:
<br>&gt;&gt; sudo /etc/init.d/irqbalance stop
<br>&gt;&gt; sudo modprobe ntb_transport dyndbg=3D+p
<br>&gt;&gt; sudo modprobe ntb_netdev dyndbg=3D+p
<br>&gt;&gt; sudo ifconfig eth0 192.168.1.2 up
<br>&gt;&gt;
<br>&gt;&gt; Along with these steps I run ping 192.168.1.2 and get about 2-=
3 successfull transmitted/received packets then get &#39;Destination host u=
nreacheble&#39;.
<br>&gt;&gt;
<br>&gt;=20
<br>&gt; Do pings in the other direction work?
<br>&gt;=20
<br>How are the NTBs connected? Where did the get the hardware? Also can yo=
u
<br>dump the stats in debugfs? And which distro are you running? Sometimes
<br>Network Manager will yank the IP for no reason if you don&#39;t configu=
re it
<br>correctly and thus your interface can&#39;t route.
<br></blockquote></div>
------=_Part_1782_1658438205.1484129328817--

------=_Part_1781_1836570804.1484129328817--
