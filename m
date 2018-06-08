Date: Fri, 8 Jun 2018 02:23:17 -0700 (PDT)
From: vk en <yato.iacs@gmail.com>
Message-Id: <5f6f69df-378d-4fd8-84b0-f0fff08c7575@googlegroups.com>
In-Reply-To: <d87bda21-29a6-4ce2-678a-79d07220a089@intel.com>
References: <e46a0926-7118-4009-886f-c1252cb93d62@googlegroups.com>
 <CAJ80sasPx7HFT2wgD7tMpmEVKPraHg+oQJ-zoUkNyRpnB8to+Q@mail.gmail.com>
 <62e8a338-e07b-4174-927c-f4f70a54949b@googlegroups.com>
 <CAJ80sauCYYOUak+1sQ=3kx_mK10pvL3pLCs_hEq-MPUaNgSD-g@mail.gmail.com>
 <32bfb787-223c-41c1-9df6-3cf57045f918@googlegroups.com>
 <1ed5452b-678e-4881-a82c-182413c12954@googlegroups.com>
 <CAJ80sav0RepYOu+C5-hzVdsKYpzrZuHP0M_Q=h+2P-L1LeUDbA@mail.gmail.com>
 <b05ac043-38ab-7439-1ede-7348f1b7e3bd@intel.com>
 <9058dedf-ec3a-42d4-9eaa-40d95740fcc0@googlegroups.com>
 <0fe77341-d309-479f-177c-c18b0193926e@intel.com>
 <b6723ca5-2f8b-4fcf-812e-20c4f40c73c2@googlegroups.com>
 <d87bda21-29a6-4ce2-678a-79d07220a089@intel.com>
Subject: Re: Problem with the connection status (Link-status) after loading
 the driver ntb_hw_intel
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_10354_1375871543.1528449797710"
To: linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

------=_Part_10354_1375871543.1528449797710
Content-Type: multipart/alternative; 
	boundary="----=_Part_10355_1688199958.1528449797710"

------=_Part_10355_1688199958.1528449797710
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hey.

1. I changed the system to a new one
it has 2 controllers with 2 processors each.  (before 2 controllers one 
processor each)

2. I successfully created ntrdma device, without any errors.

Problems:
1. If only 1 controller works, then the Status link in ntb_hw_intel still 
shows UP. 
So it should not be, since I need to connect 2 controllers. (On the first 
system, this worked correctly, if I turned off one controller or switched 
off (ntb_transport), then the link had the status of DOWN)
Why is this so?

2. I successfully created the device, but I did not manage to connect the 
clusters with each other.
NTRDMA also created an interface, but after their configuration, there is 
no ping between clusters.

What have I done wrong? or can I be something I forgot to do?

------=_Part_10355_1688199958.1528449797710
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hey.</div><div><br></div><div>1. I changed the system=
 to a new one</div><div>it has 2 controllers with 2 processors each.=C2=A0=
=C2=A0(before 2 controllers one processor each)</div><div><br></div><div>2.=
 I successfully created ntrdma device, without any errors.</div><div><br></=
div><div>Problems:</div><div>1. If only 1 controller works, then the Status=
 link in ntb_hw_intel still shows UP.=C2=A0</div><div>So it should not be, =
since I need to connect 2 controllers. (On the first system, this worked co=
rrectly, if I turned off one controller or switched off (ntb_transport), th=
en the link had the status of DOWN)</div><div>Why is this so?<br><br></div>=
<div>2. I successfully created the device, but I did not manage to connect =
the clusters with each other.</div><div>NTRDMA also created an interface, b=
ut after their configuration, there is no ping between clusters.<br><br>Wha=
t have I done wrong? or can I be something I forgot to do?<br></div></div>
------=_Part_10355_1688199958.1528449797710--

------=_Part_10354_1375871543.1528449797710--
