Date: Tue, 1 May 2018 06:07:48 -0700 (PDT)
From: Boris Glimcher <glimchb@gmail.com>
Message-Id: <9d068d57-9f92-439e-b102-05d08faa9c0b@googlegroups.com>
In-Reply-To: <86e878a1-f5b1-4f90-ab0f-3d33cccac0fb@googlegroups.com>
References: <86e878a1-f5b1-4f90-ab0f-3d33cccac0fb@googlegroups.com>
Subject: Re: ntb user space driver
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_24523_959519475.1525180069042"
To: linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

------=_Part_24523_959519475.1525180069042
Content-Type: multipart/alternative; 
	boundary="----=_Part_24524_2099004733.1525180069042"

------=_Part_24524_2099004733.1525180069042
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

Did you end up developing it? I'm also interested in using user-space ntb 
driver.

Thanks, 
Boris

On Saturday, December 16, 2017 at 6:05:33 AM UTC+2, Frank Huang wrote:
>
> Hi, all
>
> I plan to develop a user space ntb driver. I choose the uio_pci_generic 
> driver framework. Now I have some questions
>
> 1. Does the ntb driver compact with uio_pci_generic?
>
> 2. Does the ntb configurations  aslo place on BAR0 ?
>
> 3. When do the unbind from kernel and rebind to UIO, do I need to do the 
> probe initialization for specific hardware on the userspace?
>
> Thank,
> Frank
>

------=_Part_24524_2099004733.1525180069042
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>Did you end up developing it? I&#39=
;m also interested in using user-space ntb driver.</div><div><br></div><div=
>Thanks,=C2=A0</div><div>Boris<br><br>On Saturday, December 16, 2017 at 6:0=
5:33 AM UTC+2, Frank Huang wrote:<blockquote class=3D"gmail_quote" style=3D=
"margin: 0;margin-left: 0.8ex;border-left: 1px #ccc solid;padding-left: 1ex=
;"><div dir=3D"ltr">Hi, all<div><br></div><div>I plan to develop a user spa=
ce ntb driver. I choose the uio_pci_generic driver framework. Now I have so=
me questions</div><div><br></div><div>1. Does the ntb driver compact with u=
io_pci_generic?</div><div><br></div><div>2. Does the ntb configurations=C2=
=A0 aslo place on BAR0 ?</div><div><br></div><div>3. When do the unbind fro=
m kernel and rebind to UIO, do I need to do the probe initialization for sp=
ecific hardware on the userspace?</div><div><br></div><div>Thank,</div><div=
>Frank</div></div></blockquote></div></div>
------=_Part_24524_2099004733.1525180069042--

------=_Part_24523_959519475.1525180069042--
