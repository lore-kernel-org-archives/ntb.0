Date: Mon, 2 Dec 2019 07:23:23 -0800 (PST)
From: lravich@gmail.com
Message-Id: <e71c7a5d-ad80-46c4-b76c-7a6fba4fe666@googlegroups.com>
Subject: Physical continues memory for NTB
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_4163_1075273769.1575300203965"
To: linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

------=_Part_4163_1075273769.1575300203965
Content-Type: multipart/alternative; 
	boundary="----=_Part_4164_479213502.1575300203965"

------=_Part_4164_479213502.1575300203965
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi guys , 

I would like to get your opinion regarding NTB memory windows usage in a 
production , 
most of my experience is on Intel Skylake NTB which is limited to 2 NTB 
memory windows and has hard  restrictions

the naive way to use NTB is to set translate windows to all the physical 
memory rage, this way entire physical memory will be exposed to peer node , 
call me a paranoid but I not feeling this is the way to go , 
the other way is to expose only relevant part of memory  but such memory 
should be physical continues memory  (trying to avoid going to IOMMU 
direction) to get such physical continues memory I cant use 
kmalloc  or other slob friends because they are limited in max size and 
anyway the chance to get such a big chunk after init is low, so the only 
way I see is to reserve the memory on kernel init , 

currently known to me technics to go this way:
1) "out of kernel memory" (memmap boot parameter) , this is the easiest way 
to go but we getting out of kernel memory , which has its disadvantages ex: 
there is many flows in kernel based on pining memory with get_user_pages 
which will fail with  "out of kernel memory" 
2)  CMA -  this feature support only generic memory region allocation with 
boot parameters  which will be shared by all dma allocs in kernel (at least 
for Intel) , anyway looks like overkill for my simple requirements.

love to hear your opinion guys , 

Thanks
Leonid 

------=_Part_4164_479213502.1575300203965
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi guys ,=C2=A0<div><br></div><div>I would like to get you=
r opinion regarding NTB memory windows usage in a production ,=C2=A0</div><=
div>most of my experience is on Intel Skylake NTB which is limited to 2 NTB=
 memory windows and has hard=C2=A0 <span style=3D"color: rgb(51, 51, 51); f=
ont-family: Assistant; font-size: 14px;">restrictions</span></div><div><br>=
</div><div>the naive way to use NTB is to set translate windows to all the =
physical memory rage, this way entire physical memory will be exposed to pe=
er node , call me a paranoid but I not feeling this is the way to go ,=C2=
=A0</div><div>the other way is to expose only relevant part of memory=C2=A0=
 but such memory should be physical continues memory=C2=A0 (trying to avoid=
 going to IOMMU direction) to get such physical continues memory I cant use=
=C2=A0</div><div>kmalloc=C2=A0 or other slob friends because they are limit=
ed in max size and anyway the chance to get such a big chunk after init is =
low, so the only way I see is to reserve the memory on kernel init ,=C2=A0<=
/div><div><br></div><div>currently known to me technics to go this way:</di=
v><div>1) &quot;out of kernel memory&quot; (memmap boot parameter) , this i=
s the easiest way to go but we getting out of kernel memory , which has its=
 disadvantages ex: there is many flows in kernel based on pining memory wit=
h get_user_pages which will fail with=C2=A0 &quot;out of kernel memory&quot=
;=C2=A0</div><div>2)=C2=A0 CMA -=C2=A0 this feature support only generic me=
mory region allocation with boot parameters=C2=A0 which will be shared by a=
ll dma allocs in kernel (at least for Intel) , anyway looks like overkill f=
or my simple requirements.</div><div><br></div><div>love to hear your opini=
on guys ,=C2=A0</div><div><br></div><div>Thanks</div><div>Leonid=C2=A0</div=
></div>
------=_Part_4164_479213502.1575300203965--

------=_Part_4163_1075273769.1575300203965--
