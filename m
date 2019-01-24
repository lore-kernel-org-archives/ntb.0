Date: Thu, 24 Jan 2019 05:14:37 -0800 (PST)
From: lravich@gmail.com
Message-Id: <5a9a65df-6092-4b6e-93d6-2653c33de38f@googlegroups.com>
In-Reply-To: <56554767-0ed2-cda0-716b-c4050717a45a@deltatee.com>
References: <8e9bb3cc-b238-47e7-b206-ccaf673a8fb6@googlegroups.com>
 <56554767-0ed2-cda0-716b-c4050717a45a@deltatee.com>
Subject: Re: [PATCH] Missing functionality of ntb_peer_db_addr() API
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_277_1801468710.1548335677482"
To: linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

------=_Part_277_1801468710.1548335677482
Content-Type: multipart/alternative; 
	boundary="----=_Part_278_499841877.1548335677482"

------=_Part_278_499841877.1548335677482
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Thanks, Logan

Actually I am using this API as part of NTRDMA project , 
you are right I will update the ntb_hw_switchtec implementation .

Leonid 

On Wednesday, January 23, 2019 at 7:30:29 PM UTC+2, Logan Gunthorpe wrote:
>
>
>
> On 2019-01-23 2:28 a.m., lra...@gmail.com <javascript:> wrote: 
> >         .spad_count             = intel_ntb_spad_count, 
> > diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c 
> > b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c 
> > index 5ee5f40..af01222 100644 
> > --- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c 
> > +++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c 
> > @@ -707,7 +707,9 @@ static u64 switchtec_ntb_db_read_mask(struct ntb_dev 
> > *ntb) 
> >   
> >  static int switchtec_ntb_peer_db_addr(struct ntb_dev *ntb, 
> >                                       phys_addr_t *db_addr, 
> > -                                     resource_size_t *db_size) 
> > +                                     resource_size_t *db_size, 
> > +                                     u64 *db_data, 
> > +                                     int db_bit) 
> >  { 
>
>
> The semantics of this interface are not clear because there are no users 
> in the kernel. But doesn't a correct implementation require you to set 
> db_data here? 
>
> Logan 
>

------=_Part_278_499841877.1548335677482
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks, Logan<div><br><div>Actually I am using this API as=
 part of NTRDMA project ,=C2=A0</div><div>you are right I will update the n=
tb_hw_<wbr>switchtec implementation .</div><div><br></div><div>Leonid=C2=A0=
<br><br>On Wednesday, January 23, 2019 at 7:30:29 PM UTC+2, Logan Gunthorpe=
 wrote:<blockquote class=3D"gmail_quote" style=3D"margin: 0;margin-left: 0.=
8ex;border-left: 1px #ccc solid;padding-left: 1ex;">
<br>
<br>On 2019-01-23 2:28 a.m., <a href=3D"javascript:" target=3D"_blank" gdf-=
obfuscated-mailto=3D"roFgAY29BgAJ" rel=3D"nofollow" onmousedown=3D"this.hre=
f=3D&#39;javascript:&#39;;return true;" onclick=3D"this.href=3D&#39;javascr=
ipt:&#39;;return true;">lra...@gmail.com</a> wrote:
<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 .spad_count =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =3D intel_ntb_spad_count,
<br>&gt; diff --git a/drivers/ntb/hw/mscc/ntb_hw_<wbr>switchtec.c=20
<br>&gt; b/drivers/ntb/hw/mscc/ntb_hw_<wbr>switchtec.c
<br>&gt; index 5ee5f40..af01222 100644
<br>&gt; --- a/drivers/ntb/hw/mscc/ntb_hw_<wbr>switchtec.c
<br>&gt; +++ b/drivers/ntb/hw/mscc/ntb_hw_<wbr>switchtec.c
<br>&gt; @@ -707,7 +707,9 @@ static u64 switchtec_ntb_db_read_mask(<wbr>str=
uct ntb_dev=20
<br>&gt; *ntb)
<br>&gt; =C2=A0
<br>&gt; =C2=A0static int switchtec_ntb_peer_db_addr(<wbr>struct ntb_dev *n=
tb,
<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 phys_add=
r_t *db_addr,
<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 resource_siz=
e_t *db_size)
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 resource_siz=
e_t *db_size,
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u64 *db_data=
,
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int db_bit)
<br>&gt; =C2=A0{
<br>
<br>
<br>The semantics of this interface are not clear because there are no user=
s
<br>in the kernel. But doesn&#39;t a correct implementation require you to =
set
<br>db_data here?
<br>
<br>Logan
<br></blockquote></div></div></div>
------=_Part_278_499841877.1548335677482--

------=_Part_277_1801468710.1548335677482--
