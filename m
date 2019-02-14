Date: Thu, 14 Feb 2019 05:44:40 -0800 (PST)
From: lravich@gmail.com
Message-Id: <4bddaad3-14e2-4ceb-90d0-2955ea76b442@googlegroups.com>
In-Reply-To: <20190119001001.13087-1-logang@deltatee.com>
References: <20190119001001.13087-1-logang@deltatee.com>
Subject: Re: [PATCH] NTB: ntb_transport: Ensure the destination buffer is
 mapped for TX DMA
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_301_1326305677.1550151880472"
To: linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

------=_Part_301_1326305677.1550151880472
Content-Type: multipart/alternative; 
	boundary="----=_Part_302_1173821174.1550151880472"

------=_Part_302_1173821174.1550151880472
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Logan , 
I took a look on the dma_map_resource() you used in this patch , looks 
like ops->map_resource not implemented for intel 
if I see it right, this will not fix the issue for Intel NTB .

Please let me know if I am right 

Thanks.
Leonid Ravich

On Saturday, January 19, 2019 at 2:10:12 AM UTC+2, Logan Gunthorpe wrote:
>
> Presently, when ntb_transport is used with DMA and the IOMMU turned on, 
> it fails with errors from the IOMMU such as: 
>
>   DMAR: DRHD: handling fault status reg 202 
>   DMAR: [DMA Write] Request device [00:04.0] fault addr 
>         381fc0340000 [fault reason 05] PTE Write access is not set 
>
> This is because ntb_transport does not map the BAR space with the IOMMU. 
>
> To fix this, we map the entire MW region for each QP after we assign 
> the DMA channel. This prevents needing an extra DMA map in the fast 
> path. 
>
> Link: https://lore.kernel.org/linux-pci/499934e7-3734-1aee-37dd-b42a5d2a2608@intel.com/ 
>
> Signed-off-by 
> <https://lore.kernel.org/linux-pci/499934e7-3734-1aee-37dd-b42a5d2a2608@intel.com/Signed-off-by>: 
> Logan Gunthorpe <log...@deltatee.com <javascript:>> 
> Cc: Jon Mason <jdm...@kudzu.us <javascript:>> 
> Cc: Dave Jiang <dave....@intel.com <javascript:>> 
> Cc: Allen Hubbe <all...@gmail.com <javascript:>> 
> --- 
>  drivers/ntb/ntb_transport.c | 28 ++++++++++++++++++++++++++-- 
>  1 file changed, 26 insertions(+), 2 deletions(-) 
>
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c 
> index 3bfdb4562408..526b65afc16a 100644 
> --- a/drivers/ntb/ntb_transport.c 
> +++ b/drivers/ntb/ntb_transport.c 
> @@ -144,7 +144,9 @@ struct ntb_transport_qp { 
>          struct list_head tx_free_q; 
>          spinlock_t ntb_tx_free_q_lock; 
>          void __iomem *tx_mw; 
> -        dma_addr_t tx_mw_phys; 
> +        phys_addr_t tx_mw_phys; 
> +        size_t tx_mw_size; 
> +        dma_addr_t tx_mw_dma_addr; 
>          unsigned int tx_index; 
>          unsigned int tx_max_entry; 
>          unsigned int tx_max_frame; 
> @@ -1049,6 +1051,7 @@ static int ntb_transport_init_queue(struct 
> ntb_transport_ctx *nt, 
>          tx_size = (unsigned int)mw_size / num_qps_mw; 
>          qp_offset = tx_size * (qp_num / mw_count); 
>   
> +        qp->tx_mw_size = tx_size; 
>          qp->tx_mw = nt->mw_vec[mw_num].vbase + qp_offset; 
>          if (!qp->tx_mw) 
>                  return -EINVAL; 
> @@ -1644,7 +1647,7 @@ static int ntb_async_tx_submit(struct 
> ntb_transport_qp *qp, 
>          dma_cookie_t cookie; 
>   
>          device = chan->device; 
> -        dest = qp->tx_mw_phys + qp->tx_max_frame * entry->tx_index; 
> +        dest = qp->tx_mw_dma_addr + qp->tx_max_frame * entry->tx_index; 
>          buff_off = (size_t)buf & ~PAGE_MASK; 
>          dest_off = (size_t)dest & ~PAGE_MASK; 
>   
> @@ -1863,6 +1866,18 @@ ntb_transport_create_queue(void *data, struct 
> device *client_dev, 
>                  qp->rx_dma_chan = NULL; 
>          } 
>   
> +        if (qp->tx_dma_chan) { 
> +                qp->tx_mw_dma_addr = 
> +                        dma_map_resource(qp->tx_dma_chan->device->dev, 
> +                                         qp->tx_mw_phys, qp->tx_mw_size, 
> +                                         DMA_FROM_DEVICE, 0); 
> +                if (dma_mapping_error(qp->tx_dma_chan->device->dev, 
> +                                      qp->tx_mw_dma_addr)) { 
> +                        qp->tx_mw_dma_addr = 0; 
> +                        goto err1; 
> +                } 
> +        } 
> + 
>          dev_dbg(&pdev->dev, "Using %s memcpy for TX\n", 
>                  qp->tx_dma_chan ? "DMA" : "CPU"); 
>   
> @@ -1904,6 +1919,10 @@ ntb_transport_create_queue(void *data, struct 
> device *client_dev, 
>          qp->rx_alloc_entry = 0; 
>          while ((entry = ntb_list_rm(&qp->ntb_rx_q_lock, &qp->rx_free_q))) 
>                  kfree(entry); 
> +        if (qp->tx_mw_dma_addr) 
> +                dma_unmap_resource(qp->tx_dma_chan->device->dev, 
> +                                   qp->tx_mw_dma_addr, qp->tx_mw_size, 
> +                                   DMA_FROM_DEVICE, 0); 
>          if (qp->tx_dma_chan) 
>                  dma_release_channel(qp->tx_dma_chan); 
>          if (qp->rx_dma_chan) 
> @@ -1945,6 +1964,11 @@ void ntb_transport_free_queue(struct 
> ntb_transport_qp *qp) 
>                   */ 
>                  dma_sync_wait(chan, qp->last_cookie); 
>                  dmaengine_terminate_all(chan); 
> + 
> +                dma_unmap_resource(chan->device->dev, 
> +                                   qp->tx_mw_dma_addr, qp->tx_mw_size, 
> +                                   DMA_FROM_DEVICE, 0); 
> + 
>                  dma_release_channel(chan); 
>          } 
>   
> -- 
> 2.19.0 
>
>
------=_Part_302_1173821174.1550151880472
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Logan ,=C2=A0<div>I took a look on the=C2=A0dma_map_res=
ource() you used in this patch , looks like=C2=A0ops-&gt;map_resource not i=
mplemented for intel=C2=A0</div><div>if I see it right, this will not fix t=
he issue for Intel NTB .</div><div><br></div><div>Please let me know if I a=
m right=C2=A0</div><div><br></div><div>Thanks.</div><div>Leonid Ravich<br><=
br>On Saturday, January 19, 2019 at 2:10:12 AM UTC+2, Logan Gunthorpe wrote=
:<blockquote class=3D"gmail_quote" style=3D"margin: 0;margin-left: 0.8ex;bo=
rder-left: 1px #ccc solid;padding-left: 1ex;">Presently, when ntb_transport=
 is used with DMA and the IOMMU turned on,
<br>it fails with errors from the IOMMU such as:
<br>
<br>=C2=A0 DMAR: DRHD: handling fault status reg 202
<br>=C2=A0 DMAR: [DMA Write] Request device [00:04.0] fault addr
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0381fc0340000 [fault rea=
son 05] PTE Write access is not set
<br>
<br>This is because ntb_transport does not map the BAR space with the IOMMU=
.
<br>
<br>To fix this, we map the entire MW region for each QP after we assign
<br>the DMA channel. This prevents needing an extra DMA map in the fast
<br>path.
<br>
<br>Link: <a href=3D"https://lore.kernel.org/linux-pci/499934e7-3734-1aee-3=
7dd-b42a5d2a2608@intel.com/Signed-off-by" target=3D"_blank" rel=3D"nofollow=
" onmousedown=3D"this.href=3D&#39;https://www.google.com/url?q\x3dhttps%3A%=
2F%2Flore.kernel.org%2Flinux-pci%2F499934e7-3734-1aee-37dd-b42a5d2a2608%40i=
ntel.com%2FSigned-off-by\x26sa\x3dD\x26sntz\x3d1\x26usg\x3dAFQjCNF_Ze7E7wlR=
xslwqq2w8rPw8vV72g&#39;;return true;" onclick=3D"this.href=3D&#39;https://w=
ww.google.com/url?q\x3dhttps%3A%2F%2Flore.kernel.org%2Flinux-pci%2F499934e7=
-3734-1aee-37dd-b42a5d2a2608%40intel.com%2FSigned-off-by\x26sa\x3dD\x26sntz=
\x3d1\x26usg\x3dAFQjCNF_Ze7E7wlRxslwqq2w8rPw8vV72g&#39;;return true;">https=
://lore.kernel.org/linux-<wbr>pci/499934e7-3734-1aee-37dd-<wbr>b42a5d2a2608=
@intel.com/
<br>Signed-off-by</a>: Logan Gunthorpe &lt;<a href=3D"javascript:" target=
=3D"_blank" gdf-obfuscated-mailto=3D"ekb3Qlj1CgAJ" rel=3D"nofollow" onmouse=
down=3D"this.href=3D&#39;javascript:&#39;;return true;" onclick=3D"this.hre=
f=3D&#39;javascript:&#39;;return true;">log...@deltatee.com</a>&gt;
<br>Cc: Jon Mason &lt;<a href=3D"javascript:" target=3D"_blank" gdf-obfusca=
ted-mailto=3D"ekb3Qlj1CgAJ" rel=3D"nofollow" onmousedown=3D"this.href=3D&#3=
9;javascript:&#39;;return true;" onclick=3D"this.href=3D&#39;javascript:&#3=
9;;return true;">jdm...@kudzu.us</a>&gt;
<br>Cc: Dave Jiang &lt;<a href=3D"javascript:" target=3D"_blank" gdf-obfusc=
ated-mailto=3D"ekb3Qlj1CgAJ" rel=3D"nofollow" onmousedown=3D"this.href=3D&#=
39;javascript:&#39;;return true;" onclick=3D"this.href=3D&#39;javascript:&#=
39;;return true;">dave....@intel.com</a>&gt;
<br>Cc: Allen Hubbe &lt;<a href=3D"javascript:" target=3D"_blank" gdf-obfus=
cated-mailto=3D"ekb3Qlj1CgAJ" rel=3D"nofollow" onmousedown=3D"this.href=3D&=
#39;javascript:&#39;;return true;" onclick=3D"this.href=3D&#39;javascript:&=
#39;;return true;">all...@gmail.com</a>&gt;
<br>---
<br>=C2=A0drivers/ntb/ntb_transport.c | 28 ++++++++++++++++++++++++++--
<br>=C2=A01 file changed, 26 insertions(+), 2 deletions(-)
<br>
<br>diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
<br>index 3bfdb4562408..526b65afc16a 100644
<br>--- a/drivers/ntb/ntb_transport.c
<br>+++ b/drivers/ntb/ntb_transport.c
<br>@@ -144,7 +144,9 @@ struct ntb_transport_qp {
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct list_head =
tx_free_q;
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0spinlock_t ntb_tx=
_free_q_lock;
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0void __iomem *tx_=
mw;
<br>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dma_addr_t tx_mw_phys;
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0phys_addr_t tx_mw_phys=
;
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0size_t tx_mw_size;
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dma_addr_t tx_mw_dma_a=
ddr;
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned int tx_i=
ndex;
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned int tx_m=
ax_entry;
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned int tx_m=
ax_frame;
<br>@@ -1049,6 +1051,7 @@ static int ntb_transport_init_queue(<wbr>struct n=
tb_transport_ctx *nt,
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tx_size =3D (unsi=
gned int)mw_size / num_qps_mw;
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0qp_offset =3D tx_=
size * (qp_num / mw_count);
<br>=C2=A0
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0qp-&gt;tx_mw_size =3D =
tx_size;
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0qp-&gt;tx_mw =3D =
nt-&gt;mw_vec[mw_num].vbase + qp_offset;
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!qp-&gt;tx_mw=
)
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -EINVAL;
<br>@@ -1644,7 +1647,7 @@ static int ntb_async_tx_submit(struct ntb_transpo=
rt_qp *qp,
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dma_cookie_t cook=
ie;
<br>=C2=A0
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0device =3D chan-&=
gt;device;
<br>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dest =3D qp-&gt;tx_mw_=
phys + qp-&gt;tx_max_frame * entry-&gt;tx_index;
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dest =3D qp-&gt;tx_mw_=
dma_addr + qp-&gt;tx_max_frame * entry-&gt;tx_index;
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0buff_off =3D (siz=
e_t)buf &amp; ~PAGE_MASK;
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dest_off =3D (siz=
e_t)dest &amp; ~PAGE_MASK;
<br>=C2=A0
<br>@@ -1863,6 +1866,18 @@ ntb_transport_create_queue(<wbr>void *data, stru=
ct device *client_dev,
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0qp-&gt;rx_dma_<wbr>chan =3D NULL;
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
<br>=C2=A0
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (qp-&gt;tx_dma_chan=
) {
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0qp-&gt;tx_mw_<wbr>dma_addr =3D
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
dma_<wbr>map_resource(qp-&gt;tx_dma_chan-&gt;<wbr>device-&gt;dev,
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 qp-&gt;tx_mw_phys, qp-&gt;tx_mw_size,
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 DMA_FROM_DEVICE, 0);
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0if (dma_mapping_error(qp-&gt;tx_dma_<wbr>chan-&g=
t;device-&gt;dev,
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0q=
p-&gt;tx_mw_dma_addr)) {
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
qp-&gt;<wbr>tx_mw_dma_addr =3D 0;
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
goto err1;
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0}
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
<br>+
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev_dbg(&amp;pdev=
-&gt;dev, &quot;Using %s memcpy for TX\n&quot;,
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0qp-&gt;tx_dma_<wbr>chan ? &quot;DMA&quot; =
: &quot;CPU&quot;);
<br>=C2=A0
<br>@@ -1904,6 +1919,10 @@ ntb_transport_create_queue(<wbr>void *data, stru=
ct device *client_dev,
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0qp-&gt;rx_alloc_e=
ntry =3D 0;
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0while ((entry =3D=
 ntb_list_rm(&amp;qp-&gt;ntb_rx_q_<wbr>lock, &amp;qp-&gt;rx_free_q)))
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0kfree(entry);
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (qp-&gt;tx_mw_dma_a=
ddr)
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0dma_unmap_<wbr>resource(qp-&gt;tx_dma_chan-&gt;<=
wbr>device-&gt;dev,
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=C2=A0 =C2=A0 qp-&gt;tx_mw_d=
ma_addr, qp-&gt;tx_mw_size,
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=C2=A0 =C2=A0 DMA_FROM_DEVIC=
E, 0);
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (qp-&gt;tx_dma=
_chan)
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dma_release_<wbr>channel(qp-&gt;tx_dma_cha=
n);
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (qp-&gt;rx_dma=
_chan)
<br>@@ -1945,6 +1964,11 @@ void ntb_transport_free_queue(<wbr>struct ntb_tr=
ansport_qp *qp)
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dma_sync_<wbr>wait(chan, qp-&gt;last_cooki=
e);
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dmaengine_<wbr>terminate_all(chan);
<br>+
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0dma_unmap_<wbr>resource(chan-&gt;device-&gt;dev,
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=C2=A0 =C2=A0 qp-&gt;tx_mw_d=
ma_addr, qp-&gt;tx_mw_size,
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0<wbr>=C2=A0=C2=A0=C2=A0 =C2=A0 DMA_FROM_DEVIC=
E, 0);
<br>+
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dma_release_<wbr>channel(chan);
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
<br>=C2=A0
<br>--=20
<br>2.19.0
<br>
<br></blockquote></div></div>
------=_Part_302_1173821174.1550151880472--

------=_Part_301_1326305677.1550151880472--
