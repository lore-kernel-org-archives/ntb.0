Return-Path: <paboyle@ph.ed.ac.uk>
Received: from loire.is.ed.ac.uk (loire.is.ed.ac.uk. [129.215.16.10])
        by gmr-mx.google.com with ESMTP id f140si3426521wme.4.2017.06.30.16.46.22
        for <linux-ntb@googlegroups.com>;
        Fri, 30 Jun 2017 16:46:22 -0700 (PDT)
Received: from lmtp1.ucs.ed.ac.uk (lmtp1.ucs.ed.ac.uk [129.215.149.64])
	by loire.is.ed.ac.uk (8.14.7/8.14.6) with ESMTP id v5UNkLJM001473
	for <linux-ntb@googlegroups.com>; Sat, 1 Jul 2017 00:46:21 +0100
Received: from [192.168.1.6] (cpc104832-sgyl39-2-0-cust180.18-2.cable.virginm.net [77.99.169.181])
	(authenticated user=paboyle mech=PLAIN bits=0)
	by lmtp1.ucs.ed.ac.uk (8.13.8/8.13.7) with ESMTP id v5UNkKcV018655
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <linux-ntb@googlegroups.com>; Sat, 1 Jul 2017 00:46:21 +0100 (BST)
From: Peter Boyle <paboyle@ph.ed.ac.uk>
Content-Type: multipart/mixed; boundary="----------=_1498866381-11319-156"
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: NTB query
Message-Id: <4CE1E1EA-7A1C-4DC0-80E1-8F738C7179EF@ph.ed.ac.uk>
Date: Sat, 1 Jul 2017 00:46:20 +0100
Content-Transfer-Encoding: binary
To: linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

This is a multi-part message in MIME format...

------------=_1498866381-11319-156
Received: from [192.168.1.6] (cpc104832-sgyl39-2-0-cust180.18-2.cable.virginm.net [77.99.169.181])
	(authenticated user=paboyle mech=PLAIN bits=0)
	by lmtp1.ucs.ed.ac.uk (8.13.8/8.13.7) with ESMTP id v5UNkKcV018655
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <linux-ntb@googlegroups.com>; Sat, 1 Jul 2017 00:46:21 +0100 (BST)
From: Peter Boyle <paboyle@ph.ed.ac.uk>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_C215662D-9611-48FB-B541-63A54416B3E1"
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: NTB query
Message-Id: <4CE1E1EA-7A1C-4DC0-80E1-8F738C7179EF@ph.ed.ac.uk>
Date: Sat, 1 Jul 2017 00:46:20 +0100
To: linux-ntb@googlegroups.com
X-Mailer: Apple Mail (2.3273)
X-Scanned-By: MIMEDefang 2.52 on 129.215.149.64


--Apple-Mail=_C215662D-9611-48FB-B541-63A54416B3E1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


Hi,

sorry for cold emailing you; I=E2=80=99m interested in the possibility to s=
et up an ugly home
grown, domain specific HPC approach.

We=E2=80=99ve built cartesian grid machines (e.g. 3d) in the past with only=
 nearest neighbour
communication and no routing. Our QCDOC computer is an example:

https://web.archive.org/web/20081007081750/http://www.bnl.gov/lqcd/linkable=
_files/pdf/pap231.pdf <https://web.archive.org/web/20081007081750/http://ww=
w.bnl.gov/lqcd/linkable_files/pdf/pap231.pdf>

An earlier version QCDSP won the Gordon Bell Prize (I wasn=E2=80=99t part o=
f the team at that time).

I=E2=80=99m curious whether NTB or similar can be used to direct connect a =
single CPU with PCIe Root complex
to 6 neighbours, and out of this build a  3d mesh where the neighbours can =
RDMA each others memory.

I=E2=80=99m well aware it would really be very painful, but I don=E2=80=99t=
 have sufficient documentation on the root complexes of=20
current CPU=E2=80=99s that integrate them to know whether the hardware in p=
rinciple out there would
let me do this. I=E2=80=99m also not saying I=E2=80=99m planning on doing t=
his; just presently researching if it would in principle
be possible.

My dream is that the power, price performance of lower end chips is great, =
but the cost of
high end interconnected is killing and driving to high end nodes.

e.g. I get 100GF/s on a quad core costing $400, but only 400 GF/s on a dual=
 socket Xeon costin $7000.

- I=E2=80=99d rather expect $1600 and connect four quad-cores; but the $400=
0 of OPA cards, cables and switch required is crippling.

NTB is in principle THE  solution for this.

Ideally, we=E2=80=99d build custom boards, racks, backplanes like our QCDOC=
 design and pull something like 8 links at x 4 lanes
out of each chip and build a =E2=80=9Cfree=E2=80=9D but restricted intercon=
nect where the only extra parts are copper traces costing only a few=20
extra dollars per node.

Thanks for any information,

Peter=

--Apple-Mail=_C215662D-9611-48FB-B541-63A54416B3E1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html charset=
=3Dutf-8"></head><body style=3D"word-wrap: break-word; -webkit-nbsp-mode: s=
pace; -webkit-line-break: after-white-space;" class=3D""><div class=3D""><b=
r class=3D""></div><div class=3D"">Hi,</div><div class=3D""><br class=3D"">=
</div><div class=3D"">sorry for cold emailing you; I=E2=80=99m interested i=
n the possibility to set up an ugly home</div><div class=3D"">grown, domain=
 specific HPC approach.</div><div class=3D""><br class=3D""></div><div clas=
s=3D"">We=E2=80=99ve built cartesian grid machines (e.g. 3d) in the past wi=
th only nearest neighbour</div><div class=3D"">communication and no routing=
. Our QCDOC computer is an example:</div><div class=3D""><br class=3D""></d=
iv><div class=3D""><a href=3D"https://web.archive.org/web/20081007081750/ht=
tp://www.bnl.gov/lqcd/linkable_files/pdf/pap231.pdf" class=3D"">https://web=
.archive.org/web/20081007081750/http://www.bnl.gov/lqcd/linkable_files/pdf/=
pap231.pdf</a></div><div class=3D""><br class=3D""></div><div class=3D"">An=
 earlier version QCDSP won the Gordon Bell Prize (I wasn=E2=80=99t part of =
the team at that time).</div><div class=3D""><br class=3D""></div><div clas=
s=3D"">I=E2=80=99m curious whether NTB or similar can be used to direct con=
nect a single CPU with PCIe Root complex</div><div class=3D"">to 6 neighbou=
rs, and out of this build a &nbsp;3d mesh where the neighbours can RDMA eac=
h others memory.</div><div class=3D""><br class=3D""></div><div class=3D"">=
I=E2=80=99m well aware it would really be very painful, but I don=E2=80=99t=
 have sufficient documentation on the root complexes of&nbsp;</div><div cla=
ss=3D"">current CPU=E2=80=99s that integrate them to know whether the hardw=
are in principle out there would</div><div class=3D"">let me do this. I=E2=
=80=99m also not saying I=E2=80=99m planning on doing this; just presently =
researching if it would in principle</div><div class=3D"">be possible.</div=
><div class=3D""><br class=3D""></div><div class=3D"">My dream is that the =
power, price performance of lower end chips is great, but the cost of</div>=
<div class=3D"">high end interconnected is killing and driving to high end =
nodes.</div><div class=3D""><br class=3D""></div><div class=3D"">e.g. I get=
 100GF/s on a quad core costing $400, but only 400 GF/s on a dual socket Xe=
on costin $7000.</div><div class=3D""><br class=3D""></div><div class=3D"">=
- I=E2=80=99d rather expect $1600 and connect four quad-cores; but the $400=
0 of OPA cards, cables and switch required is crippling.</div><div class=3D=
""><br class=3D""></div><div class=3D"">NTB is in principle THE &nbsp;solut=
ion for this.</div><div class=3D""><br class=3D""></div><div class=3D"">Ide=
ally, we=E2=80=99d build custom boards, racks, backplanes like our QCDOC de=
sign and pull something like 8 links at x 4 lanes</div><div class=3D"">out =
of each chip and build a =E2=80=9Cfree=E2=80=9D but restricted interconnect=
 where the only extra parts are copper traces costing only a few&nbsp;</div=
><div class=3D"">extra dollars per node.</div><div class=3D""><br class=3D"=
"></div><div class=3D"">Thanks for any information,</div><div class=3D""><b=
r class=3D""></div><div class=3D"">Peter</div></body></html>=

--Apple-Mail=_C215662D-9611-48FB-B541-63A54416B3E1--

------------=_1498866381-11319-156
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Content-Description: Edinburgh University charitable status

The University of Edinburgh is a charitable body, registered in
Scotland, with registration number SC005336.

------------=_1498866381-11319-156--
