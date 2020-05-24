Date: Sun, 24 May 2020 14:37:45 -0700 (PDT)
From: Anubhav Guleria <anubhav.nitsri.it@gmail.com>
Message-Id: <ca1ae048-bb3d-4aec-8d89-17178734f097@googlegroups.com>
Subject: Using NTRDMA with Intel Skylake in b2b configuration
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_1290_300045457.1590356265525"
To: linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

------=_Part_1290_300045457.1590356265525
Content-Type: multipart/alternative; 
	boundary="----=_Part_1291_770982628.1590356265525"

------=_Part_1291_770982628.1590356265525
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


Hi, 
I am trying to setup ntrdma(https://github.com/ntrdma/ntrdma-ext) with 
Intel Skylake b2b configuration and Linux 4.14.178. 
Following is how my memory windows are setup:
1) MW[0] (BAR23): dma_alloc_coherent 
2) MW[1] (BAR45): memremap

Further, what I understand that in case of MR registering there are 2 
steps[ntrdma_reg_user_mr()]:

1) Call ib_umem_get() to Pin and DMA Map userspace Memory.
2) Then, prepare a memory buffer in a NTB window, by ntc_mr_buf_map_dma(..).

The doubt that I have is that is it necessary to have the dma_addr from 
step 1 to be within the limits of NTB window, in this case MW[0] ?
And if so, is there some specific configuration that needs to be made?

Also, is above configuration of MWs correct?

Thanks in advance.

------=_Part_1291_770982628.1590356265525
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div>Hi,=C2=A0</div><div>I am trying to setup ntrdma(h=
ttps://github.com/ntrdma/ntrdma-ext) with Intel Skylake b2b configuration a=
nd Linux 4.14.178.=C2=A0</div><div>Following is how my memory windows are s=
etup:</div><div>1) MW[0] (BAR23): dma_alloc_coherent=C2=A0</div><div>2) MW[=
1] (BAR45): memremap</div><div><br></div><div>Further, what I understand th=
at in case of MR registering there are 2 steps[ntrdma_reg_user_mr()]:</div>=
<div><br></div><div>1) Call ib_umem_get() to Pin and DMA Map userspace Memo=
ry.</div><div>2) Then, prepare a memory buffer in a NTB window, by ntc_mr_b=
uf_map_dma(..).</div><div><br></div><div>The doubt that I have is that is i=
t necessary to have the dma_addr from step 1 to be within the limits of NTB=
 window, in this case MW[0] ?</div><div>And if so, is there some specific c=
onfiguration that needs to be made?</div><div><br></div><div>Also, is above=
 configuration of MWs correct?</div><div><br></div><div>Thanks in advance.<=
/div></div>
------=_Part_1291_770982628.1590356265525--

------=_Part_1290_300045457.1590356265525--
