Return-Path: <sridhar.lochu@gmail.com>
Received: from mail-oi0-x236.google.com (mail-oi0-x236.google.com. [2607:f8b0:4003:c06::236])
        by gmr-mx.google.com with ESMTPS id pn4si1183898igb.3.2016.05.09.02.23.20
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 May 2016 02:23:20 -0700 (PDT)
Received: by mail-oi0-x236.google.com with SMTP id k142so203608186oib.1
        for <linux-ntb@googlegroups.com>; Mon, 09 May 2016 02:23:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <000001d1a798$08a195d0$19e4c170$@emc.com>
References: <CAO+9SsOojQ2NoRqUKCgJexBtCA=rB0JThw2q70svPAaY04-UJw@mail.gmail.com>
	<000001d1a798$08a195d0$19e4c170$@emc.com>
Date: Mon, 9 May 2016 14:53:19 +0530
Message-ID: <CAO+9SsM2z8QW_RVBaw3g7=nOehppq98zQ_1Zw10a7gofiBBgFA@mail.gmail.com>
Subject: Re: Need information about understanding PCIE non-transparent bridge
From: sridhar T S <sridhar.lochu@gmail.com>
Content-Type: multipart/alternative; boundary=001a11473492fbbb240532655b5c
To: Allen Hubbe <Allen.Hubbe@emc.com>
Cc: linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

--001a11473492fbbb240532655b5c
Content-Type: text/plain; charset=UTF-8

hi Allen,

yes, am interested in testing the ntb functionality using Linux mainly our
test OS will be Ubuntu.
i would welcome your suggestions and ideas upon the system configuration,
tools/applications, server setup between the primary and secondary machines.

below is my queries:

1. Can you let me know how to use the tools ntb_tool and ntb_pingpong to
test the ntb connection.
2. NTB setup configuration i.e how to configure the two systems for NTB
data access
            a. which file system server to create for testing between
platforms.
            b. third party tools to verify the ntb bandwidth
3. How to access non bar0 data transactions between ntb machines?
            a. can you suggest any tools or applications that can be used
to verfiy from operating system perspective
4. how can we initiate data transfer using the system DMA?

i will keep you posted on any more queries in this thread

regards,
Sridhar

On Fri, May 6, 2016 at 6:35 PM, Allen Hubbe <Allen.Hubbe@emc.com> wrote:

> Hi Sridhar,
>
> If you have NTB hardware already physically connected and
> configured in your BIOS, then you can build and load the
> linux ntb modules.
>
> Here is the documentation on linux ntb modules.  It says
> what the modules do, and how to use them.
>
> http://lxr.free-electrons.com/source/Documentation/ntb.txt
>
> If you are interested in testing or demonstrating basic NTB
> functionality, try ntb_tool and ntb_pingpong.  There is
> also a network device over NTB supported by ntb_transport
> and ntb_netdev together.
>
> Please let me know if you have any questions not answered in
> the documentation.  I am happy to help.
>
> Allen
>
> From: sridhar T S
> >
> > Hi allen,
> >
> > myself sridhar, working as senior software engineer.
> > i wanted to understand about PCIE non-transparent bridge.
> >
> > i will be testing the linux device driver for NTB, for now
> > i have a very fair understanding about the architecture.
> >
> > need some ideas about how to test the NTB device driver
> > across NTB systems for proper system operations with
> > respect to NTB device driver for linux
> >
> > your inputs and information will be helpful.
> >
> > thanks in advance.
> >
> > regards,
> > Sridhar
>
>
>
>

--001a11473492fbbb240532655b5c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">hi Allen,<div><br></div><div>yes, am interested in testing=
 the ntb functionality using Linux mainly our test OS will be Ubuntu.</div>=
<div>i would welcome your suggestions and ideas upon the system configurati=
on, tools/applications, server setup between the primary and secondary mach=
ines.</div><div><br></div><div>below is my queries:</div><div><br></div><di=
v>1. Can you let me know how to use the tools=C2=A0<span style=3D"font-size=
:12.8px">ntb_tool and ntb_pingpong to test the ntb connection.</span></div>=
<div><span style=3D"font-size:12.8px">2. NTB setup configuration i.e how to=
 configure the two systems for NTB data access</span></div><div><span style=
=3D"font-size:12.8px">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 a. which fi=
le system server to create for testing between platforms.</span></div><div>=
<span style=3D"font-size:12.8px">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
b. third party tools to verify the ntb bandwidth=C2=A0</span></div><div><sp=
an style=3D"font-size:12.8px">3. How to access non bar0 data transactions b=
etween ntb machines?=C2=A0</span></div><div><span style=3D"font-size:12.8px=
">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 a. can you suggest any tools or=
 applications that can be used to verfiy from operating system perspective<=
/span></div><div><span style=3D"font-size:12.8px">4. how can we initiate da=
ta transfer using the system DMA</span><font color=3D"#1f497d" face=3D"Cali=
bri, sans-serif"><span style=3D"font-size:14.6667px">?</span></font><br></d=
iv><div><font color=3D"#1f497d" face=3D"Calibri, sans-serif"><span style=3D=
"font-size:14.6667px"><br></span></font></div><div><span style=3D"font-size=
:12.8px">i will keep you posted on any more queries in this thread</span><b=
r></div><div><span style=3D"font-size:12.8px"><br></span></div><div><span s=
tyle=3D"font-size:12.8px">regards,</span></div><div><span style=3D"font-siz=
e:12.8px">Sridhar=C2=A0</span></div></div><div class=3D"gmail_extra"><br><d=
iv class=3D"gmail_quote">On Fri, May 6, 2016 at 6:35 PM, Allen Hubbe <span =
dir=3D"ltr">&lt;<a href=3D"mailto:Allen.Hubbe@emc.com" target=3D"_blank">Al=
len.Hubbe@emc.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote=
" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">H=
i Sridhar,<br>
<br>
If you have NTB hardware already physically connected and<br>
configured in your BIOS, then you can build and load the<br>
linux ntb modules.<br>
<br>
Here is the documentation on linux ntb modules.=C2=A0 It says<br>
what the modules do, and how to use them.<br>
<br>
<a href=3D"http://lxr.free-electrons.com/source/Documentation/ntb.txt" rel=
=3D"noreferrer" target=3D"_blank">http://lxr.free-electrons.com/source/Docu=
mentation/ntb.txt</a><br>
<br>
If you are interested in testing or demonstrating basic NTB<br>
functionality, try ntb_tool and ntb_pingpong.=C2=A0 There is<br>
also a network device over NTB supported by ntb_transport<br>
and ntb_netdev together.<br>
<br>
Please let me know if you have any questions not answered in<br>
the documentation.=C2=A0 I am happy to help.<br>
<br>
Allen<br>
<br>
From: sridhar T S<br>
<div class=3D"HOEnZb"><div class=3D"h5">&gt;<br>
&gt; Hi allen,<br>
&gt;<br>
&gt; myself sridhar, working as senior software engineer.<br>
&gt; i wanted to understand about PCIE non-transparent bridge.<br>
&gt;<br>
&gt; i will be testing the linux device driver for NTB, for now<br>
&gt; i have a very fair understanding about the architecture.<br>
&gt;<br>
&gt; need some ideas about how to test the NTB device driver<br>
&gt; across NTB systems for proper system operations with<br>
&gt; respect to NTB device driver for linux<br>
&gt;<br>
&gt; your inputs and information will be helpful.<br>
&gt;<br>
&gt; thanks in advance.<br>
&gt;<br>
&gt; regards,<br>
&gt; Sridhar<br>
<br>
<br>
<br>
</div></div></blockquote></div><br></div>

--001a11473492fbbb240532655b5c--
