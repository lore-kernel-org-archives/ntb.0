Return-Path: <eswierk@skyportsystems.com>
Received: from mail-vk0-x22d.google.com (mail-vk0-x22d.google.com. [2607:f8b0:400c:c05::22d])
        by gmr-mx.google.com with ESMTPS id i17si548518vkd.2.2017.05.31.21.47.55
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 May 2017 21:47:55 -0700 (PDT)
Received: by mail-vk0-x22d.google.com with SMTP id w1so18943080vkd.2
        for <linux-ntb@googlegroups.com>; Wed, 31 May 2017 21:47:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <657df2b1-18f5-9435-6477-98701a1aaa92@intel.com>
References: <CAO_EM_n81HfXZY-X+OuQWX0T=0E5BYpfJJEf+WQVC1DzyyWkLA@mail.gmail.com>
 <657df2b1-18f5-9435-6477-98701a1aaa92@intel.com>
From: Ed Swierk <eswierk@skyportsystems.com>
Date: Wed, 31 May 2017 21:47:14 -0700
Message-ID: <CAO_EM_m+UfMOuNKidZVEUtjaiR=ebjy4tO1=w62EqGkw7vYQvA@mail.gmail.com>
Subject: Re: Cabling for NTB between Intel Xeon E5 v4 servers
Content-Type: multipart/alternative; boundary="001a11450bf672fa0e0550debd46"
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

--001a11450bf672fa0e0550debd46
Content-Type: text/plain; charset="UTF-8"

I went ahead and connected two PCIe slots on the same system (Intel
S2600WT) in NTB B2B mode, with just an SFF-8643 cable and dumb passive
adapters, and managed to get 4 lanes at gen 2 speed. Next I'll try between
two systems.

--Ed


On Tue, May 30, 2017 at 9:34 AM, Dave Jiang <dave.jiang@intel.com> wrote:

>
>
> On 05/26/2017 07:00 PM, 'Ed Swierk' via linux-ntb wrote:
> > I'm trying to set up a PCIe link between Intel Xeon E5 v4 (S2600WT)
> > servers running Linux 4.10.17, as a testbed for performance
> > measurements. My goal is to evaluate feasibility NTB on a custom Xeon
> > D-based plug-in card, but as a first step I'm sticking with systems on
> > which NTB is already known to (or supposed to) work.
>
> So you'll need PCIe retimer cards. Not redrivers. The hw people
> recommended using iDT based card pair. Others may work but have not
> tried. I don't know what to recommend because we have an in-house
> cabling set that's not commercially available for testing. Also, make
> sure your BIOS support NTB and BAR size change and also it turns off SSC
> when NTB is on.
>
> >
> > I read https://github.com/davejiang/linux/wiki/Intel-NTB-Startup-Guide
> > and every other document I could find on Intel NTB, but I'm stuck on a
> > basic question: what kind of cable should I use to connect the PCIe
> slots?
> >
> > I found some card-and-cable kits
> > at http://www.onestopsystems.com/expansion-kits, but these are quite
> > expensive ($thousands).
> >
> > Another idea is to use so-called mini-SAS HD aka SFF-8643, which I
> > understand can carry PCIe x4, along with a pair of PCIe-to-SF-8643
> > adapters
> > (e.g. https://www.startech.com/HDD/Adapters/pcie-nvme-u2-ssd-
> adapter~PEX4SFF8643).
> > The TX-to-RX wiring seems like it should work, but I have no idea about
> > signal integrity through such a cable.
> >
> > There's also the SuperMicro AOC-SLG3-2E4R, which is similar to the
> > StarTech card but claims to have redriver circuitry.
> >
> > What cabling have folks successfully used for NTB between Intel
> > Xeon-based servers?
> >
> > --Ed
> >
> > --
> > You received this message because you are subscribed to the Google
> > Groups "linux-ntb" group.
> > To unsubscribe from this group and stop receiving emails from it, send
> > an email to linux-ntb+unsubscribe@googlegroups.com
> > <mailto:linux-ntb+unsubscribe@googlegroups.com>.
> > To post to this group, send email to linux-ntb@googlegroups.com
> > <mailto:linux-ntb@googlegroups.com>.
> > To view this discussion on the web visit
> > https://groups.google.com/d/msgid/linux-ntb/CAO_EM_n81HfXZY-X%2BOuQWX0T%
> 3D0E5BYpfJJEf%2BWQVC1DzyyWkLA%40mail.gmail.com
> > <https://groups.google.com/d/msgid/linux-ntb/CAO_EM_
> n81HfXZY-X%2BOuQWX0T%3D0E5BYpfJJEf%2BWQVC1DzyyWkLA%
> 40mail.gmail.com?utm_medium=email&utm_source=footer>.
> > For more options, visit https://groups.google.com/d/optout.
>

--001a11450bf672fa0e0550debd46
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I went ahead and connected two PCIe slots on the same syst=
em (Intel S2600WT) in NTB B2B mode, with just an SFF-8643 cable and dumb pa=
ssive adapters, and managed to get 4 lanes at gen 2 speed. Next I&#39;ll tr=
y between two systems.<div><br></div><div>--Ed</div><div><br></div></div><d=
iv class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Tue, May 30, 201=
7 at 9:34 AM, Dave Jiang <span dir=3D"ltr">&lt;<a href=3D"mailto:dave.jiang=
@intel.com" target=3D"_blank">dave.jiang@intel.com</a>&gt;</span> wrote:<br=
><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex"><span class=3D""><br>
<br>
On 05/26/2017 07:00 PM, &#39;Ed Swierk&#39; via linux-ntb wrote:<br>
&gt; I&#39;m trying to set up a PCIe link between Intel Xeon E5 v4 (S2600WT=
)<br>
&gt; servers running Linux 4.10.17, as a testbed for performance<br>
&gt; measurements. My goal is to evaluate feasibility NTB on a custom Xeon<=
br>
&gt; D-based plug-in card, but as a first step I&#39;m sticking with system=
s on<br>
&gt; which NTB is already known to (or supposed to) work.<br>
<br>
</span>So you&#39;ll need PCIe retimer cards. Not redrivers. The hw people<=
br>
recommended using iDT based card pair. Others may work but have not<br>
tried. I don&#39;t know what to recommend because we have an in-house<br>
cabling set that&#39;s not commercially available for testing. Also, make<b=
r>
sure your BIOS support NTB and BAR size change and also it turns off SSC<br=
>
when NTB is on.<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt;<br>
&gt; I read <a href=3D"https://github.com/davejiang/linux/wiki/Intel-NTB-St=
artup-Guide" rel=3D"noreferrer" target=3D"_blank">https://github.com/daveji=
ang/<wbr>linux/wiki/Intel-NTB-Startup-<wbr>Guide</a><br>
&gt; and every other document I could find on Intel NTB, but I&#39;m stuck =
on a<br>
&gt; basic question: what kind of cable should I use to connect the PCIe sl=
ots?<br>
&gt;<br>
&gt; I found some card-and-cable kits<br>
&gt; at <a href=3D"http://www.onestopsystems.com/expansion-kits" rel=3D"nor=
eferrer" target=3D"_blank">http://www.onestopsystems.com/<wbr>expansion-kit=
s</a>, but these are quite<br>
&gt; expensive ($thousands).<br>
&gt;<br>
&gt; Another idea is to use so-called mini-SAS HD aka SFF-8643, which I<br>
&gt; understand can carry PCIe x4, along with a pair of PCIe-to-SF-8643<br>
&gt; adapters<br>
&gt; (e.g. <a href=3D"https://www.startech.com/HDD/Adapters/pcie-nvme-u2-ss=
d-adapter~PEX4SFF8643" rel=3D"noreferrer" target=3D"_blank">https://www.sta=
rtech.com/HDD/<wbr>Adapters/pcie-nvme-u2-ssd-<wbr>adapter~PEX4SFF8643</a>).=
<br>
&gt; The TX-to-RX wiring seems like it should work, but I have no idea abou=
t<br>
&gt; signal integrity through such a cable.<br>
&gt;<br>
&gt; There&#39;s also the SuperMicro AOC-SLG3-2E4R, which is similar to the=
<br>
&gt; StarTech card but claims to have redriver circuitry.<br>
&gt;<br>
&gt; What cabling have folks successfully used for NTB between Intel<br>
&gt; Xeon-based servers?<br>
&gt;<br>
&gt; --Ed<br>
&gt;<br>
</div></div><span class=3D"HOEnZb"><font color=3D"#888888">&gt; --<br>
&gt; You received this message because you are subscribed to the Google<br>
&gt; Groups &quot;linux-ntb&quot; group.<br>
&gt; To unsubscribe from this group and stop receiving emails from it, send=
<br>
&gt; an email to <a href=3D"mailto:linux-ntb%2Bunsubscribe@googlegroups.com=
">linux-ntb+unsubscribe@<wbr>googlegroups.com</a><br>
&gt; &lt;mailto:<a href=3D"mailto:linux-ntb%2Bunsubscribe@googlegroups.com"=
>linux-ntb+unsubscribe@<wbr>googlegroups.com</a>&gt;.<br>
&gt; To post to this group, send email to <a href=3D"mailto:linux-ntb@googl=
egroups.com">linux-ntb@googlegroups.com</a><br>
&gt; &lt;mailto:<a href=3D"mailto:linux-ntb@googlegroups.com">linux-ntb@<wb=
r>googlegroups.com</a>&gt;.<br>
&gt; To view this discussion on the web visit<br>
&gt; <a href=3D"https://groups.google.com/d/msgid/linux-ntb/CAO_EM_n81HfXZY=
-X%2BOuQWX0T%3D0E5BYpfJJEf%2BWQVC1DzyyWkLA%40mail.gmail.com" rel=3D"norefer=
rer" target=3D"_blank">https://groups.google.com/d/<wbr>msgid/linux-ntb/CAO=
_EM_<wbr>n81HfXZY-X%2BOuQWX0T%<wbr>3D0E5BYpfJJEf%2BWQVC1DzyyWkLA%<wbr>40mai=
l.gmail.com</a><br>
&gt; &lt;<a href=3D"https://groups.google.com/d/msgid/linux-ntb/CAO_EM_n81H=
fXZY-X%2BOuQWX0T%3D0E5BYpfJJEf%2BWQVC1DzyyWkLA%40mail.gmail.com?utm_medium=
=3Demail&amp;utm_source=3Dfooter" rel=3D"noreferrer" target=3D"_blank">http=
s://groups.google.com/d/<wbr>msgid/linux-ntb/CAO_EM_<wbr>n81HfXZY-X%2BOuQWX=
0T%<wbr>3D0E5BYpfJJEf%2BWQVC1DzyyWkLA%<wbr>40mail.gmail.com?utm_medium=3D<w=
br>email&amp;utm_source=3Dfooter</a>&gt;.<br>
&gt; For more options, visit <a href=3D"https://groups.google.com/d/optout"=
 rel=3D"noreferrer" target=3D"_blank">https://groups.google.com/d/<wbr>opto=
ut</a>.<br>
</font></span></blockquote></div><br></div>

--001a11450bf672fa0e0550debd46--
