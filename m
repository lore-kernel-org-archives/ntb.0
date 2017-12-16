Date: Fri, 15 Dec 2017 20:05:33 -0800 (PST)
From: Frank Huang <tigerinxm@gmail.com>
Message-Id: <86e878a1-f5b1-4f90-ab0f-3d33cccac0fb@googlegroups.com>
Subject: ntb user space driver
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_63_1409399174.1513397133401"
To: linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

------=_Part_63_1409399174.1513397133401
Content-Type: multipart/alternative; 
	boundary="----=_Part_64_1488875320.1513397133401"

------=_Part_64_1488875320.1513397133401
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, all

I plan to develop a user space ntb driver. I choose the uio_pci_generic 
driver framework. Now I have some questions

1. Does the ntb driver compact with uio_pci_generic?

2. Does the ntb configurations  aslo place on BAR0 ?

3. When do the unbind from kernel and rebind to UIO, do I need to do the 
probe initialization for specific hardware on the userspace?

Thank,
Frank

------=_Part_64_1488875320.1513397133401
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi, all<div><br></div><div>I plan to develop a user space =
ntb driver. I choose the uio_pci_generic driver framework. Now I have some =
questions</div><div><br></div><div>1. Does the ntb driver compact with uio_=
pci_generic?</div><div><br></div><div>2. Does the ntb configurations=C2=A0 =
aslo place on BAR0 ?</div><div><br></div><div>3. When do the unbind from ke=
rnel and rebind to UIO, do I need to do the probe initialization for specif=
ic hardware on the userspace?</div><div><br></div><div>Thank,</div><div>Fra=
nk</div></div>
------=_Part_64_1488875320.1513397133401--

------=_Part_63_1409399174.1513397133401--
