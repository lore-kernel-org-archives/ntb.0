Return-Path: <Sanju.Mehta@amd.com>
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (mail-eopbgr750058.outbound.protection.outlook.com. [40.107.75.58])
        by gmr-mx.google.com with ESMTPS id 144si374197oii.2.2019.11.26.05.10.24
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Nov 2019 05:10:24 -0800 (PST)
Subject: Re: Fwd: [PATCH] NTB: Fix an error in get link status
References: <1573119336-107732-1-git-send-email-linjiasen@hygon.cn>
 <CAPoiz9wAJz=Hqb6Os=9AHHv_NGpZ8uCaAuOC=aUTkASKdfs9WQ@mail.gmail.com>
 <933f74c7-7249-618c-13dc-9e4e47ad75d7@hygon.cn>
 <11b355a8-0fe0-f256-c510-ddf106017703@hygon.cn>
 <CAADLhr7bpb-F0eF1UFXy7AcN=z061mno_QsqGE8z-mvWKvUyCQ@mail.gmail.com>
 <04b4d1ed-ea47-819e-a7e4-b729fa463506@amd.com>
 <5c3155b5-6eed-d955-b18b-59b0cb1c513b@hygon.cn>
 <740bb924-b258-8dda-6469-bc1bee90291f@hygon.cn>
From: Sanjay R Mehta <sanmehta@amd.com>
Message-ID: <c5adca66-024f-8d37-3187-ffba73102ac4@amd.com>
Date: Tue, 26 Nov 2019 18:40:08 +0530
In-Reply-To: <740bb924-b258-8dda-6469-bc1bee90291f@hygon.cn>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Return-Path: sanmehta@amd.com
MIME-Version: 1.0
To: Jiasen Lin <linjiasen@hygon.cn>
Cc: "S-k, Shyam-sundar <Shyam-sundar.S-k@amd.com> Dave Jiang" <dave.jiang@intel.com>, Arindam Nath <arindam.nath@amd.com>, Allen Hubbe <allenbh@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-ntb <linux-ntb@googlegroups.com>, linjiasen007@gmail.com
List-ID: <linux-ntb.googlegroups.com>


> Hi Sanjay R Mehta
>
> In more complex topology, read the Link Status and Control register of
> RP is also wrong. Suppose that a PCIe switch bridge to the Secondary RP,
> and Secondary internal SW.ds is a child device for switch's downstream
> port as illustrated in the following topology.
>
> In secondary PCI domain:
> Secondary RP--Switch UP--Switch DP--Secondary internal SW.us--Secondary
> internal SW.ds--Secondary NTB
>
> pci_rp = pci_find_pcie_root_port(ndev->ntb.pdev) will return the
> Secondary RP, and pcie_capability_read_dword(pci_rp,
> PCI_EXP_LNKCTL,&stat) will get the link status between Secondary RP and
> Switch UP. Maybe, read the Link Status and control register of Secondary
> internal SW.us is appropriate.
>
Hi Jiansen Lin,

I modified the code as per your suggestion and is working fine.
Adding Arindam for comments who was the co-author of the patch I was about to send for upstream review.

Thanks,
Sanjay Mehta
> struct pci_dev *pci_up = NULL;
> struct pci_dev *pci_dp = NULL;
>
> if (ndev->ntb.topo == NTB_TOPO_SEC) {
>     /* Locate the pointer to Secondary up for this device */
>     pci_dp = pci_upstream_bridge(ndev->ntb.pdev);
>     /* Read the PCIe Link Control and Status register */
>     if (pci_dp) {
>        pci_up = pci_upstream_bridge(pci_dp);
>        if (pci_up) {
>                rc = pcie_capability_read_dword(pci_up, PCI_EXP_LNKCTL,
>                         &stat);
>                if (rc)
>                        return 0;
>                }
>        }
> }
>
> Thanks,
> Jiansen Lin
>
>> I have modified the code according to your suggestion and tested it
>> on Dhyana platform, it works well, expect to receice your patch.
>>
>> Before modify the code, read the Link Status and control register of the
>> secondary NTB device to get link status.
>>
>> cat /sys/kernel/debug/ntb_hw_amd/0000\:43\:00.1/info
>> NTB Device Information:
>> Connection Topology -   NTB_TOPO_SEC
>> LNK STA -               0x11030042
>> Link Status -           Up
>> Link Speed -            PCI-E Gen 3
>> Link Width -            x16
>>
>> After modify the code, read the Link Status and control register of the
>> secondary RP to get link status.
>>
>> cat /sys/kernel/debug/ntb_hw_amd/0000\:43\:00.1/info
>> NTB Device Information:
>> Connection Topology -   NTB_TOPO_SEC
>> LNK STA -               0x70830042
>> Link Status -           Up
>> Link Speed -            PCI-E Gen 3
>> Link Width -            x8
>>
>> Thanks,
>> Jiasen Lin
>>
>>> ---
>>>   drivers/ntb/hw/amd/ntb_hw_amd.c | 27 +++++++++++++++++++++++----
>>>   drivers/ntb/hw/amd/ntb_hw_amd.h |  1 -
>>>   2 files changed, 23 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c
>>> b/drivers/ntb/hw/amd/ntb_hw_amd.c
>>> index 14ad69c..91e1966 100644
>>> --- a/drivers/ntb/hw/amd/ntb_hw_amd.c
>>> +++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
>>> @@ -842,6 +842,8 @@ static inline void ndev_init_struct(struct
>>> amd_ntb_dev *ndev,
>>>   static int amd_poll_link(struct amd_ntb_dev *ndev)
>>>   {
>>>       void __iomem *mmio = ndev->peer_mmio;
>>> +    struct pci_dev *pci_rp = NULL;
>>> +    struct pci_dev *pdev = NULL;
>>>       u32 reg, stat;
>>>       int rc;
>>> @@ -855,10 +857,27 @@ static int amd_poll_link(struct amd_ntb_dev *ndev)
>>>       ndev->cntl_sta = reg;
>>> -    rc = pci_read_config_dword(ndev->ntb.pdev,
>>> -                   AMD_LINK_STATUS_OFFSET, &stat);
>>> -    if (rc)
>>> -        return 0;
>>> +    if (ndev->ntb.topo == NTB_TOPO_SEC) {
>>> +        /* Locate the pointer to PCIe Root Port for this device */
>>> +        pci_rp = pci_find_pcie_root_port(ndev->ntb.pdev);
>>> +        /* Read the PCIe Link Control and Status register */
>>> +        if (pci_rp) {
>>> +            rc = pcie_capability_read_dword(pci_rp, PCI_EXP_LNKCTL,
>>> +                            &stat);
>>> +            if (rc)
>>> +                return 0;
>>> +        }
>>> +    } else if (ndev->ntb.topo == NTB_TOPO_PRI) {
>>> +        /*
>>> +         * For NTB primary, we simply read the Link Status and control
>>> +         * register of the NTB device itself.
>>> +         */
>>> +        pdev = ndev->ntb.pdev;
>>> +        rc = pcie_capability_read_dword(pdev, PCI_EXP_LNKCTL, &stat);
>>> +        if (rc)
>>> +            return 0;
>>> +    }
>>> +
>>>       ndev->lnk_sta = stat;
>>>       return 1;
>>> diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.h
>>> b/drivers/ntb/hw/amd/ntb_hw_amd.h
>>> index 139a307..39e5d18 100644
>>> --- a/drivers/ntb/hw/amd/ntb_hw_amd.h
>>> +++ b/drivers/ntb/hw/amd/ntb_hw_amd.h
>>> @@ -53,7 +53,6 @@
>>>   #include <linux/pci.h>
>>>   #define AMD_LINK_HB_TIMEOUT    msecs_to_jiffies(1000)
>>> -#define AMD_LINK_STATUS_OFFSET    0x68
>>>   #define NTB_LIN_STA_ACTIVE_BIT    0x00000002
>>>   #define NTB_LNK_STA_SPEED_MASK    0x000F0000
>>>   #define NTB_LNK_STA_WIDTH_MASK    0x03F00000
>>>
