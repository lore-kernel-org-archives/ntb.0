Date: Thu, 2 Mar 2017 22:38:30 -0800 (PST)
From: lsgunthorpe@gmail.com
Message-Id: <c293fffa-d714-49d3-b0a5-4a1183b5229a@googlegroups.com>
In-Reply-To: <1488187351-12624-1-git-send-email-fancer.lancer@gmail.com>
References: <1487933348-32403-1-git-send-email-fancer.lancer@gmail.com>
 <1488187351-12624-1-git-send-email-fancer.lancer@gmail.com>
Subject: Re: [PATCH v4] NTB: Add IDT 89HPESxNTx PCIe-switches support
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_2254_2012876158.1488523110956"
To: linux-ntb <linux-ntb@googlegroups.com>
Cc: fancer.lancer@gmail.com
List-ID: <linux-ntb.googlegroups.com>

------=_Part_2254_2012876158.1488523110956
Content-Type: multipart/alternative; 
	boundary="----=_Part_2255_1045986153.1488523110956"

------=_Part_2255_1045986153.1488523110956
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit




Hi Serge,

I've done a quick review on your new driver:
 

> + * WARNING! IDT PCIe-switch registers are all Little endian. So 
> corresponding 
> + *            writel operations must have embedded endiannes conversion. 
> If local 
> + *            platform doesn't have it, the driver won't properly work. 
>

This warning seems unnecessary. As I understand it, PCI is by convention 
little 
endian and writel and friends all swap to little endian (at least their 
generic version do in include/asm-generic/io.h). 
So the driver should  already be correct on BE platforms.
  

> +        /* 
> +         * It's obvious bug to request a register exceeding the maximum 
> possible 
> +         * value as well as to have it unaligned. 
> +         */ 
> +        if (WARN_ON(reg > IDT_REG_PCI_MAX || !IS_ALIGNED(reg, 
> IDT_REG_ALIGN))) 
> +                return; 
>

IMO, This feels like a bit over kill to check this every time you access 
hardware. It's a static function where most of the calls are constants. In 
cases when
they're not constant the value should be checked ahead of time and sane 
things done instead of printing a stack trace.
 

> +        /* Just write the value to the specified register */ 
> +        writel(data, ndev->cfgspc + (ptrdiff_t)reg); 
>

writel and friends are discouraged for new code. Use iowrite32, et al. See 

http://www.makelinux.net/ldd3/chp-9-sect-4
 

> +        dev_dbg_pci(ndev, "IDT NT local port: %hhu, num of peers: 
> %hhu\n", 
> +                ndev->port, ndev->peer_cnt); 
>

Don't do this. Open code it with: dev_dbg(&ndev->ntp.dev...
 

> +        spin_lock_irqsave(&ndev->mtbl_lock, irqflags); 
> +        idt_nt_write(ndev, IDT_NT_NTMTBLADDR, ndev->part); 
> +        idt_nt_write(ndev, IDT_NT_NTMTBLDATA, mtbldata); 
> +        spin_unlock_irqrestore(&ndev->mtbl_lock, irqflags); 
>

Why do writes like these need a spin lock? What is that protecting against? 
What happens if another thread does the same two writes immediately after 
the unlock?
 

>
> +        /* Enable MSI interrupts */ 
> +        ret = pci_enable_msi(pdev); 
> +        if (ret != 0) { 
> +                dev_err_pci(ndev, "IDT failed to enable MSI interrupt"); 
> +                goto err_try_intx; 
> +        } 


pci_alloc_irq_vectors could be used to simplify your interrupt enabling. 
Instead of trying, testing and failing and retrying with INTX, this 
function does that all for you.

+        /* Request corresponding IRQ number */ 
> +        ret = request_threaded_irq(pdev->irq, NULL, idt_thread_isr, 
> +                                   IRQF_ONESHOT, NTB_IRQNAME, ndev);  


It would probably be simpler to use devm_request_threaded_irq then your 
cleanup path will be simpler.


+        /* Request all BARs resources */ 
> +        ret = pci_request_regions(pdev, NTB_NAME); 


pcim_iomap_regions_request_all can be used to combine this and the 
pcim_iompa below it.


+static void idt_pci_remove(struct pci_dev *pdev) 
> +{ 
> +        struct idt_ntb_dev *ndev = pci_get_drvdata(pdev); 
> + 
> +        /* Deinit the DebugFS node */ 
> +        idt_deinit_dbgfs(ndev); 
> + 
> +        /* Unregister NTB device */ 
> +        idt_unregister_device(ndev); 
> + 
> +        /* Stop the interrupts handling */ 
> +        idt_deinit_isr(ndev); 
> + 
> +        /* Deinitialize link event subsystem */ 
> +        idt_deinit_link(ndev); 
> + 
> +        /* Deinit basic PCI subsystem */ 
> +        idt_deinit_pci(ndev); 
> + 
> +        /* IDT PCIe-switch NTB driver is finally initialized */ 
> +        dev_info(&pdev->dev, "IDT NTB device is removed"); 
> + 
> +        /* Sayonara... */ 


I don't see where you kfree ndev the structure... (and it's not done by the 
ntb device's release code...) so this looks like a memory leak.


Logan


------=_Part_2255_1045986153.1488523110956
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><br></div><div><br></div><div><br></div><div>Hi Serge=
,</div><div><br></div><div>I&#39;ve done a quick review on your new driver:=
</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin: 0=
;margin-left: 0.8ex;border-left: 1px #ccc solid;padding-left: 1ex;">+ * WAR=
NING! IDT PCIe-switch registers are all Little endian. So corresponding
<br>+ *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 =C2=A0writel=
 operations must have embedded endiannes conversion. If local
<br>+ *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 =C2=A0platfo=
rm doesn&#39;t have it, the driver won&#39;t properly work.
<br></blockquote><div><br></div><div>This warning seems unnecessary. As I u=
nderstand it, PCI is by convention little=C2=A0</div><div>endian and writel=
 and friends all swap to little endian (at least their generic version do i=
n include/asm-generic/io.h).=C2=A0</div><div>So the driver should =C2=A0alr=
eady be correct on BE platforms.</div><div>=C2=A0=C2=A0</div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin: 0;margin-left: 0.8ex;border-left: 1px =
#ccc solid;padding-left: 1ex;">+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0/*
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * It&#39;s obvious bu=
g to request a register exceeding the maximum possible
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * value as well as to=
 have it unaligned.
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (WARN_ON(reg &gt; I=
DT_REG_PCI_MAX || !IS_ALIGNED(reg, IDT_REG_ALIGN)))
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0return;
<br></blockquote><div><br></div><div>IMO, This feels like a bit over kill t=
o check this every time you access hardware. It&#39;s a static function whe=
re most of the calls are constants. In cases when</div><div>they&#39;re not=
 constant the value should be checked ahead of time and sane things done in=
stead of printing a stack trace.</div><div>=C2=A0</div><blockquote class=3D=
"gmail_quote" style=3D"margin: 0;margin-left: 0.8ex;border-left: 1px #ccc s=
olid;padding-left: 1ex;">+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/=
* Just write the value to the specified register */
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0writel(data, ndev-&gt;=
cfgspc + (ptrdiff_t)reg);
<br></blockquote><div><br></div><div>writel and friends are discouraged for=
 new code. Use iowrite32, et al. See=C2=A0</div><div><br></div><div>http://=
www.makelinux.net/ldd3/chp-9-sect-4<br></div><div>=C2=A0</div><blockquote c=
lass=3D"gmail_quote" style=3D"margin: 0;margin-left: 0.8ex;border-left: 1px=
 #ccc solid;padding-left: 1ex;">+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0dev_dbg_pci(ndev, &quot;IDT NT local port: %hhu, num of peers: %hhu\n=
&quot;,
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0ndev-&gt;port, ndev-&gt;peer_cnt);
<br></blockquote><div><br></div><div>Don&#39;t do this. Open code it with: =
dev_dbg(&amp;ndev-&gt;ntp.dev...</div><div>=C2=A0</div><blockquote class=3D=
"gmail_quote" style=3D"margin: 0;margin-left: 0.8ex;border-left: 1px #ccc s=
olid;padding-left: 1ex;">+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0s=
pin_lock_irqsave(&amp;<wbr>ndev-&gt;mtbl_lock, irqflags);
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0idt_nt_write(ndev, IDT=
_NT_NTMTBLADDR, ndev-&gt;part);
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0idt_nt_write(ndev, IDT=
_NT_NTMTBLDATA, mtbldata);
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0spin_unlock_<wbr>irqre=
store(&amp;ndev-&gt;mtbl_lock, irqflags);
<br></blockquote><div><br></div><div>Why do writes like these need a spin l=
ock? What is that protecting against? What happens if another thread does t=
he same two writes immediately after the unlock?</div><div>=C2=A0</div><blo=
ckquote class=3D"gmail_quote" style=3D"margin: 0px 0px 0px 0.8ex; border-le=
ft: 1px solid rgb(204, 204, 204); padding-left: 1ex;"><br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0/* Enable MSI interrupts */=C2=A0<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0ret =3D pci_enable_msi(pdev);=C2=A0<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0i=
f (ret !=3D 0) {=C2=A0<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0dev_err_pci(ndev, &quot;IDT failed to enable MSI interrupt&quot;)=
;=C2=A0<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto er=
r_try_intx;=C2=A0<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}=C2=A0</blockquote><div>=
<br></div><div>pci_alloc_irq_vectors could be used to simplify your interru=
pt enabling. Instead of trying, testing and failing and retrying with INTX,=
 this function does that all for you.<br></div><div><br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin: 0px 0px 0px 0.8ex; border-left: 1px s=
olid rgb(204, 204, 204); padding-left: 1ex;">+ =C2=A0 =C2=A0 =C2=A0 =C2=A0/=
* Request corresponding IRQ number */=C2=A0<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0ret =3D request_threaded_irq(pdev-&gt;irq, NULL, idt_thread_isr,=C2=A0<b=
r>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 IRQF_ONESHOT, NTB_IRQNAME,=
 ndev); =C2=A0</blockquote><div><br></div><div>It would probably be simpler=
 to use devm_request_threaded_irq then your cleanup path will be simpler.</=
div><div><br></div><div><br></div><div><blockquote class=3D"gmail_quote" st=
yle=3D"margin: 0px 0px 0px 0.8ex; border-left: 1px solid rgb(204, 204, 204)=
; padding-left: 1ex;">+ =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Request all BARs reso=
urces */=C2=A0<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D pci_request_regions(=
pdev, NTB_NAME);=C2=A0</blockquote></div><div><br></div><div>pcim_iomap_reg=
ions_request_all can be used to combine this and the pcim_iompa below it.</=
div><div><br></div><div><br></div><div><blockquote class=3D"gmail_quote" st=
yle=3D"margin: 0px 0px 0px 0.8ex; border-left: 1px solid rgb(204, 204, 204)=
; padding-left: 1ex;">+static void idt_pci_remove(struct pci_dev *pdev)=C2=
=A0<br>+{=C2=A0<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0struct idt_ntb_dev *ndev =
=3D pci_get_drvdata(pdev);=C2=A0<br>+=C2=A0<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0/* Deinit the DebugFS node */=C2=A0<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0idt_=
deinit_dbgfs(ndev);=C2=A0<br>+=C2=A0<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Unr=
egister NTB device */=C2=A0<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0idt_unregister_=
device(ndev);=C2=A0<br>+=C2=A0<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Stop the =
interrupts handling */=C2=A0<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0idt_deinit_isr=
(ndev);=C2=A0<br>+=C2=A0<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Deinitialize li=
nk event subsystem */=C2=A0<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0idt_deinit_link=
(ndev);=C2=A0<br>+=C2=A0<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Deinit basic PC=
I subsystem */=C2=A0<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0idt_deinit_pci(ndev);=
=C2=A0<br>+=C2=A0<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0/* IDT PCIe-switch NTB dr=
iver is finally initialized */=C2=A0<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_in=
fo(&amp;pdev-&gt;dev, &quot;IDT NTB device is removed&quot;);=C2=A0<br>+=C2=
=A0<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Sayonara... */=C2=A0</blockquote></d=
iv><div><br></div><div>I don&#39;t see where you kfree ndev the structure..=
. (and it&#39;s not done by the ntb device&#39;s release code...) so this l=
ooks like a memory leak.</div><div><br></div><div><br></div><div>Logan</div=
><div><br></div></div>
------=_Part_2255_1045986153.1488523110956--

------=_Part_2254_2012876158.1488523110956--
