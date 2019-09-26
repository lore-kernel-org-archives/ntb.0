Return-Path: <ludwig.petrosyan@desy.de>
Received: from smtp-o-1.desy.de (smtp-o-1.desy.de. [2001:638:700:1038::1:9a])
        by gmr-mx.google.com with ESMTPS id 5si503573wmf.1.2019.09.26.04.45.28
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 04:45:28 -0700 (PDT)
Received: from smtp-buf-1.desy.de (smtp-buf-1.desy.de [IPv6:2001:638:700:1038::1:a4])
	by smtp-o-1.desy.de (Postfix) with ESMTP id 9AB63E01F9
	for <linux-ntb@googlegroups.com>; Thu, 26 Sep 2019 13:45:27 +0200 (CEST)
Subject: Re: [RFC PATCH 19/21] PCI: Add TI J721E device to pci ids
References: <20190926112933.8922-1-kishon@ti.com>
 <20190926112933.8922-20-kishon@ti.com>
From: Ludwig Petrosyan <ludwig.petrosyan@desy.de>
Message-ID: <4832a387-c18a-8c04-98a0-cfc46db09243@desy.de>
Date: Thu, 26 Sep 2019 13:45:27 +0200
MIME-Version: 1.0
In-Reply-To: <20190926112933.8922-20-kishon@ti.com>
Content-Type: multipart/alternative;
 boundary="------------8D4AF1803FC2630C605144F9"
Content-Language: en-GB
To: Kishon Vijay Abraham I <kishon@ti.com>, Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

This is a multi-part message in MIME format.
--------------8D4AF1803FC2630C605144F9
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit

Dear Linux kernel group

We are using MTCA systems with Ubuntu Linux and PCIe as a central bus

We got some problem:

some times the memories of the PCIe endpoints not mapped and the lspci 
gives strange otput:

uname -a : Linux mcscpudev6 4.15.0-45-generic #48~16.04.1-Ubuntu SMP Tue 
Jan 29 18:03:48 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux


/lspci  -vvvv -s 05:00.0//
//05:00.0 Signal processing controller: Xilinx Corporation Device 0088//
//    Subsystem: Device 3300:0088//
//    Physical Slot: 4//
//    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B- DisINTx+//
//    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-//
//    Latency: 0, Cache Line Size: 64 bytes//
//    Interrupt: pin A routed to IRQ 223//
//_Region 0: Memory at <ignored> (32-bit, non-prefetchable)_/_/
/__/    Region 1: Memory at <ignored> (32-bit, non-prefetchable)/__/
/__/    Region 2: Memory at <ignored> (32-bit, non-prefetchable)/_/
//    Expansion ROM at 71c00000 [disabled] [size=1M]//
//    Capabilities: [40] Power Management version 3//
//        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)//
//        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-//
//    Capabilities: [48] MSI: Enable+ Count=1/1 Maskable- 64bit+//
//        Address: 00000000fee00ef8  Data: 0000//
//    Capabilities: [60] Express (v1) Endpoint, MSI 00//
//        DevCap:    MaxPayload 512 bytes, PhantFunc 1, Latency L0s 
unlimited, L1 unlimited//
//            ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-//
//        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-//
//            RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+//
//            MaxPayload 256 bytes, MaxReadReq 512 bytes//
//        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- 
TransPend-//
//        LnkCap:    Port #0, Speed 2.5GT/s, Width x4, ASPM L0s, Exit 
Latency L0s unlimited, L1 unlimited//
//            ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-//
//        LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- CommClk-//
//            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-//
//        LnkSta:    Speed 2.5GT/s, Width x4, TrErr- Train- SlotClk+ 
DLActive- BWMgmt- ABWMgmt-//
//    Capabilities: [100 v1] Device Serial Number 00-00-00-00-00-00-00-00//
//    Kernel driver in use: pciedev//
//    Kernel modules: pciedev//

/

but lspci with -H1:

/lspci -H1 -vvvv -s 05:00.0//
//05:00.0 Signal processing controller: Xilinx Corporation Device 0088//
//    Subsystem: Device 3300:0088//
//    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B- DisINTx+//
//    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-//
//    Latency: 0, Cache Line Size: 64 bytes//
//    Interrupt: pin A routed to IRQ 10//
////_Region 0: Memory at d8000000 (32-bit, non-prefetchable)_//_
_//_    Region 1: Memory at d4000000 (32-bit, non-prefetchable)_//_
_//_    Region 2: Memory at dc000000 (32-bit, non-prefetchable)_//
//    Expansion ROM at dd000000 [disabled]//
//    Capabilities: [40] Power Management version 3//
//        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)//
//        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-//
//    Capabilities: [48] MSI: Enable+ Count=1/1 Maskable- 64bit+//
//        Address: 00000000fee00ef8  Data: 0000//
//    Capabilities: [60] Express (v1) Endpoint, MSI 00//
//        DevCap:    MaxPayload 512 bytes, PhantFunc 1, Latency L0s 
unlimited, L1 unlimited//
//            ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-//
//        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-//
//            RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+//
//            MaxPayload 256 bytes, MaxReadReq 512 bytes//
//        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- 
TransPend-//
//        LnkCap:    Port #0, Speed 2.5GT/s, Width x4, ASPM L0s, Exit 
Latency L0s unlimited, L1 unlimited//
//            ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-//
//        LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- CommClk-//
//            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-//
//        LnkSta:    Speed 2.5GT/s, Width x4, TrErr- Train- SlotClk+ 
DLActive- BWMgmt- ABWMgmt-/

adding pci=realloc=off solves with problem.

Is it in general a good idea to use "pci=realloc=off"?

And what the problem? Would some body so kinde to explane what the problem?!


with best regards

Ludwig Petrosyan


On 9/26/19 1:29 PM, Kishon Vijay Abraham I wrote:
> Add TI J721E device to the pci id database. Since this device has
> a configurable PCIe endpoint, it could be used with different
> drivers.
>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>   include/linux/pci_ids.h | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index d157983b84cf..b2820a834a5e 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -868,6 +868,7 @@
>   #define PCI_DEVICE_ID_TI_X620		0xac8d
>   #define PCI_DEVICE_ID_TI_X420		0xac8e
>   #define PCI_DEVICE_ID_TI_XX20_FM	0xac8f
> +#define PCI_DEVICE_ID_TI_J721E		0xb00d
>   #define PCI_DEVICE_ID_TI_DRA74x		0xb500
>   #define PCI_DEVICE_ID_TI_DRA72x		0xb501
>   

--------------8D4AF1803FC2630C605144F9
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-text-html" lang="x-unicode">
      <p>Dear Linux kernel group</p>
      <p>We are using MTCA systems with Ubuntu Linux and PCIe as a
        central bus</p>
      <p>We got some problem:</p>
      <p>some times the memories of the PCIe endpoints not mapped and
        the lspci gives strange otput:</p>
      <p>uname -a : Linux mcscpudev6 4.15.0-45-generic
        #48~16.04.1-Ubuntu SMP Tue Jan 29 18:03:48 UTC 2019 x86_64
        x86_64 x86_64 GNU/Linux</p>
      <p><br>
      </p>
      <p><i>lspci  -vvvv -s 05:00.0</i><i><br>
        </i><i>05:00.0 Signal processing controller: Xilinx Corporation
          Device 0088</i><i><br>
        </i><i>    Subsystem: Device 3300:0088</i><i><br>
        </i><i>    Physical Slot: 4</i><i><br>
        </i><i>    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-
          VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+</i><i><br>
        </i><i>    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast
          &gt;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR- INTx-</i><i><br>
        </i><i>    Latency: 0, Cache Line Size: 64 bytes</i><i><br>
        </i><i>    Interrupt: pin A routed to IRQ 223</i><i><br>
        </i><i>    <u>Region 0: Memory at &lt;ignored&gt; (32-bit,
            non-prefetchable)</u></i><u><i><br>
          </i></u><u><i>    Region 1: Memory at &lt;ignored&gt; (32-bit,
            non-prefetchable)</i></u><u><i><br>
          </i></u><u><i>    Region 2: Memory at &lt;ignored&gt; (32-bit,
            non-prefetchable)</i></u><i><br>
        </i><i>    Expansion ROM at 71c00000 [disabled] [size=1M]</i><i><br>
        </i><i>    Capabilities: [40] Power Management version 3</i><i><br>
        </i><i>        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
          PME(D0-,D1-,D2-,D3hot-,D3cold-)</i><i><br>
        </i><i>        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0
          PME-</i><i><br>
        </i><i>    Capabilities: [48] MSI: Enable+ Count=1/1 Maskable-
          64bit+</i><i><br>
        </i><i>        Address: 00000000fee00ef8  Data: 0000</i><i><br>
        </i><i>    Capabilities: [60] Express (v1) Endpoint, MSI 00</i><i><br>
        </i><i>        DevCap:    MaxPayload 512 bytes, PhantFunc 1,
          Latency L0s unlimited, L1 unlimited</i><i><br>
        </i><i>            ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+
          FLReset-</i><i><br>
        </i><i>        DevCtl:    Report errors: Correctable- Non-Fatal-
          Fatal- Unsupported-</i><i><br>
        </i><i>            RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+</i><i><br>
        </i><i>            MaxPayload 256 bytes, MaxReadReq 512 bytes</i><i><br>
        </i><i>        DevSta:    CorrErr- UncorrErr- FatalErr-
          UnsuppReq- AuxPwr- TransPend-</i><i><br>
        </i><i>        LnkCap:    Port #0, Speed 2.5GT/s, Width x4, ASPM
          L0s, Exit Latency L0s unlimited, L1 unlimited</i><i><br>
        </i><i>            ClockPM- Surprise- LLActRep- BwNot-
          ASPMOptComp-</i><i><br>
        </i><i>        LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled-
          CommClk-</i><i><br>
        </i><i>            ExtSynch- ClockPM- AutWidDis- BWInt-
          AutBWInt-</i><i><br>
        </i><i>        LnkSta:    Speed 2.5GT/s, Width x4, TrErr- Train-
          SlotClk+ DLActive- BWMgmt- ABWMgmt-</i><i><br>
        </i><i>    Capabilities: [100 v1] Device Serial Number
          00-00-00-00-00-00-00-00</i><i><br>
        </i><i>    Kernel driver in use: pciedev</i><i><br>
        </i><i>    Kernel modules: pciedev</i><i><br>
          <br>
        </i></p>
      <p>but lspci with -H1:</p>
      <p><i>lspci -H1 -vvvv -s 05:00.0</i><i><br>
        </i><i>05:00.0 Signal processing controller: Xilinx Corporation
          Device 0088</i><i><br>
        </i><i>    Subsystem: Device 3300:0088</i><i><br>
        </i><i>    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-
          VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+</i><i><br>
        </i><i>    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast
          &gt;TAbort- &lt;TAbort- &lt;MAbort- &gt;SERR- &lt;PERR- INTx-</i><i><br>
        </i><i>    Latency: 0, Cache Line Size: 64 bytes</i><i><br>
        </i><i>    Interrupt: pin A routed to IRQ 10</i><i><br>
        </i><i>    </i><i><u>Region 0: Memory at d8000000 (32-bit,
            non-prefetchable)</u></i><i><u><br>
          </u></i><i><u>    Region 1: Memory at d4000000 (32-bit,
            non-prefetchable)</u></i><i><u><br>
          </u></i><i><u>    Region 2: Memory at dc000000 (32-bit,
            non-prefetchable)</u></i><i><br>
        </i><i>    Expansion ROM at dd000000 [disabled]</i><i><br>
        </i><i>    Capabilities: [40] Power Management version 3</i><i><br>
        </i><i>        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
          PME(D0-,D1-,D2-,D3hot-,D3cold-)</i><i><br>
        </i><i>        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0
          PME-</i><i><br>
        </i><i>    Capabilities: [48] MSI: Enable+ Count=1/1 Maskable-
          64bit+</i><i><br>
        </i><i>        Address: 00000000fee00ef8  Data: 0000</i><i><br>
        </i><i>    Capabilities: [60] Express (v1) Endpoint, MSI 00</i><i><br>
        </i><i>        DevCap:    MaxPayload 512 bytes, PhantFunc 1,
          Latency L0s unlimited, L1 unlimited</i><i><br>
        </i><i>            ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+
          FLReset-</i><i><br>
        </i><i>        DevCtl:    Report errors: Correctable- Non-Fatal-
          Fatal- Unsupported-</i><i><br>
        </i><i>            RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+</i><i><br>
        </i><i>            MaxPayload 256 bytes, MaxReadReq 512 bytes</i><i><br>
        </i><i>        DevSta:    CorrErr- UncorrErr- FatalErr-
          UnsuppReq- AuxPwr- TransPend-</i><i><br>
        </i><i>        LnkCap:    Port #0, Speed 2.5GT/s, Width x4, ASPM
          L0s, Exit Latency L0s unlimited, L1 unlimited</i><i><br>
        </i><i>            ClockPM- Surprise- LLActRep- BwNot-
          ASPMOptComp-</i><i><br>
        </i><i>        LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled-
          CommClk-</i><i><br>
        </i><i>            ExtSynch- ClockPM- AutWidDis- BWInt-
          AutBWInt-</i><i><br>
        </i><i>        LnkSta:    Speed 2.5GT/s, Width x4, TrErr- Train-
          SlotClk+ DLActive- BWMgmt- ABWMgmt-</i><br>
        <br>
        adding pci=realloc=off solves with problem.</p>
      <p>Is it in general a good idea to use "pci=realloc=off"?</p>
      <p>And what the problem? Would some body so kinde to explane what
        the problem?!</p>
      <p><br>
      </p>
      <p>with best regards</p>
      <p>Ludwig Petrosyan<br>
      </p>
      <p><br>
      </p>
    </div>
    <div class="moz-cite-prefix">On 9/26/19 1:29 PM, Kishon Vijay
      Abraham I wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20190926112933.8922-20-kishon@ti.com">
      <pre class="moz-quote-pre" wrap="">Add TI J721E device to the pci id database. Since this device has
a configurable PCIe endpoint, it could be used with different
drivers.

Signed-off-by: Kishon Vijay Abraham I <a class="moz-txt-link-rfc2396E" href="mailto:kishon@ti.com">&lt;kishon@ti.com&gt;</a>
---
 include/linux/pci_ids.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index d157983b84cf..b2820a834a5e 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -868,6 +868,7 @@
 #define PCI_DEVICE_ID_TI_X620		0xac8d
 #define PCI_DEVICE_ID_TI_X420		0xac8e
 #define PCI_DEVICE_ID_TI_XX20_FM	0xac8f
+#define PCI_DEVICE_ID_TI_J721E		0xb00d
 #define PCI_DEVICE_ID_TI_DRA74x		0xb500
 #define PCI_DEVICE_ID_TI_DRA72x		0xb501
 
</pre>
    </blockquote>
  </body>
</html>

--------------8D4AF1803FC2630C605144F9--
