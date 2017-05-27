Return-Path: <eswierk@skyportsystems.com>
Received: from mail-ua0-x22d.google.com (mail-ua0-x22d.google.com. [2607:f8b0:400c:c08::22d])
        by gmr-mx.google.com with ESMTPS id i17si82001vkd.2.2017.05.26.19.01.31
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 May 2017 19:01:31 -0700 (PDT)
Received: by mail-ua0-x22d.google.com with SMTP id u10so14179256uaf.1
        for <linux-ntb@googlegroups.com>; Fri, 26 May 2017 19:01:31 -0700 (PDT)
MIME-Version: 1.0
From: Ed Swierk <eswierk@skyportsystems.com>
Date: Fri, 26 May 2017 19:00:51 -0700
Message-ID: <CAO_EM_n81HfXZY-X+OuQWX0T=0E5BYpfJJEf+WQVC1DzyyWkLA@mail.gmail.com>
Subject: Cabling for NTB between Intel Xeon E5 v4 servers
Content-Type: multipart/alternative; boundary="f40304361ebe2deda9055077d562"
To: linux-ntb@googlegroups.com
Cc: dave.jiang@intel.com
List-ID: <linux-ntb.googlegroups.com>

--f40304361ebe2deda9055077d562
Content-Type: text/plain; charset="UTF-8"

I'm trying to set up a PCIe link between Intel Xeon E5 v4 (S2600WT) servers
running Linux 4.10.17, as a testbed for performance measurements. My goal
is to evaluate feasibility NTB on a custom Xeon D-based plug-in card, but
as a first step I'm sticking with systems on which NTB is already known to
(or supposed to) work.

I read https://github.com/davejiang/linux/wiki/Intel-NTB-Startup-Guide and
every other document I could find on Intel NTB, but I'm stuck on a basic
question: what kind of cable should I use to connect the PCIe slots?

I found some card-and-cable kits at
http://www.onestopsystems.com/expansion-kits, but these are quite expensive
($thousands).

Another idea is to use so-called mini-SAS HD aka SFF-8643, which I
understand can carry PCIe x4, along with a pair of PCIe-to-SF-8643 adapters
(e.g.
https://www.startech.com/HDD/Adapters/pcie-nvme-u2-ssd-adapter~PEX4SFF8643).
The TX-to-RX wiring seems like it should work, but I have no idea about
signal integrity through such a cable.

There's also the SuperMicro AOC-SLG3-2E4R, which is similar to the StarTech
card but claims to have redriver circuitry.

What cabling have folks successfully used for NTB between Intel Xeon-based
servers?

--Ed

--f40304361ebe2deda9055077d562
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>I&#39;m trying to set up a PCIe link between Intel Xe=
on E5 v4 (S2600WT) servers running Linux 4.10.17, as a testbed for performa=
nce measurements. My goal is to evaluate feasibility NTB on a custom Xeon D=
-based plug-in card, but as a first step I&#39;m sticking with systems on w=
hich NTB is already known to (or supposed to) work.</div><div><br></div><di=
v>I read <a href=3D"https://github.com/davejiang/linux/wiki/Intel-NTB-Start=
up-Guide">https://github.com/davejiang/linux/wiki/Intel-NTB-Startup-Guide</=
a> and every other document I could find on Intel NTB, but I&#39;m stuck on=
 a basic question: what kind of cable should I use to connect the PCIe slot=
s?</div><div><br></div><div>I found some card-and-cable kits at=C2=A0<a hre=
f=3D"http://www.onestopsystems.com/expansion-kits">http://www.onestopsystem=
s.com/expansion-kits</a>, but these are quite expensive ($thousands).</div>=
<div><br></div><div>Another idea is to use so-called mini-SAS HD aka SFF-86=
43, which I understand can carry PCIe x4, along with a pair of PCIe-to-SF-8=
643 adapters (e.g.=C2=A0<a href=3D"https://www.startech.com/HDD/Adapters/pc=
ie-nvme-u2-ssd-adapter~PEX4SFF8643">https://www.startech.com/HDD/Adapters/p=
cie-nvme-u2-ssd-adapter~PEX4SFF8643</a>). The TX-to-RX wiring seems like it=
 should work, but I have no idea about signal integrity through such a cabl=
e.</div><div><br></div><div>There&#39;s also the SuperMicro AOC-SLG3-2E4R, =
which is similar to the StarTech card but claims to have redriver circuitry=
.</div><div><br></div><div>What cabling have folks successfully used for NT=
B between Intel Xeon-based servers?</div><div><br></div><div>--Ed</div><div=
><br></div></div>

--f40304361ebe2deda9055077d562--
