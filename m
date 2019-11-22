Return-Path: <linjiasen@hygon.cn>
Received: from spam1.hygon.cn ([110.188.70.11])
        by gmr-mx.google.com with ESMTPS id q1si44418qti.2.2019.11.21.17.30.36
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 17:30:36 -0800 (PST)
Subject: Re: Fwd: [PATCH] NTB: Fix an error in get link status
From: Jiasen Lin <linjiasen@hygon.cn>
References: <1573119336-107732-1-git-send-email-linjiasen@hygon.cn>
 <CAPoiz9wAJz=Hqb6Os=9AHHv_NGpZ8uCaAuOC=aUTkASKdfs9WQ@mail.gmail.com>
 <933f74c7-7249-618c-13dc-9e4e47ad75d7@hygon.cn>
 <11b355a8-0fe0-f256-c510-ddf106017703@hygon.cn>
 <CAADLhr7bpb-F0eF1UFXy7AcN=z061mno_QsqGE8z-mvWKvUyCQ@mail.gmail.com>
 <04b4d1ed-ea47-819e-a7e4-b729fa463506@amd.com>
 <5c3155b5-6eed-d955-b18b-59b0cb1c513b@hygon.cn>
Message-ID: <740bb924-b258-8dda-6469-bc1bee90291f@hygon.cn>
Date: Fri, 22 Nov 2019 09:27:56 +0800
MIME-Version: 1.0
In-Reply-To: <5c3155b5-6eed-d955-b18b-59b0cb1c513b@hygon.cn>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
To: Sanjay R Mehta <sanmehta@amd.com>
Cc: "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-ntb <linux-ntb@googlegroups.com>, linjiasen007@gmail.com
List-ID: <linux-ntb.googlegroups.com>



On 2019/11/21 21:30, Jiasen Lin wrote:
> 
> 
> On 2019/11/20 22:13, Sanjay R Mehta wrote:
>> From: *Jiasen Lin* <linjiasen@hygon.cn <mailto:linjiasen@hygon.cn>>
>>> Date: Wed, Nov 20, 2019 at 3:25 PM
>>> Subject: Re: [PATCH] NTB: Fix an error in get link status
>>> To: Jon Mason <jdmason@kudzu.us <mailto:jdmason@kudzu.us>>
>>> Cc: S-k, Shyam-sundar <Shyam-sundar.S-k@amd.com 
>>> <mailto:Shyam-sundar.S-k@amd.com>>, Dave Jiang <dave.jiang@intel.com 
>>> <mailto:dave.jiang@intel.com>>, Allen Hubbe <allenbh@gmail.com
>>> <mailto:allenbh@gmail.com>>, linux-kernel 
>>> <linux-kernel@vger.kernel.org <mailto:linux-kernel@vger.kernel.org>>, 
>>> linux-ntb <linux-ntb@googlegroups.com 
>>> <mailto:linux-ntb@googlegroups.com>>,
>>> <linjiasen007@gmail.com <mailto:linjiasen007@gmail.com>>, Jiasen Lin 
>>> <linjiasen@hygon.cn <mailto:linjiasen@hygon.cn>>
>>>
>>>
>>>
>>>
>>> On 2019/11/18 18:17, Jiasen Lin wrote:
>>>>
>>>>
>>>> On 2019/11/18 7:00, Jon Mason wrote:
>>>>> On Thu, Nov 7, 2019 at 4:37 AM Jiasen Lin <linjiasen@hygon.cn 
>>>>> <mailto:linjiasen@hygon.cn>> wrote:
>>>>>>
>>>>>> The offset of PCIe Capability Header for AMD and HYGON NTB is 0x64,
>>>>>> but the macro which named "AMD_LINK_STATUS_OFFSET" is defined as 
>>>>>> 0x68.
>>>>>> It is offset of Device Capabilities Reg rather than Link Control Reg.
>>>>>>
>>>>>> This code trigger an error in get link statsus:
>>>>>>
>>>>>>           cat /sys/kernel/debug/ntb_hw_amd/0000:43:00.1/info
>>>>>>                   LNK STA -               0x8fa1
>>>>>>                   Link Status -           Up
>>>>>>                   Link Speed -            PCI-E Gen 0
>>>>>>                   Link Width -            x0
>>>>>>
>>>>>> This patch use pcie_capability_read_dword to get link status.
>>>>>> After fix this issue, we can get link status accurately:
>>>>>>
>>>>>>           cat /sys/kernel/debug/ntb_hw_amd/0000:43:00.1/info
>>>>>>                   LNK STA -               0x11030042
>>>>>>                   Link Status -           Up
>>>>>>                   Link Speed -            PCI-E Gen 3
>>>>>>                   Link Width -            x16
>>>>>
>>>>> No response from AMD maintainers, but it looks like you are correct.
>>>>>
>>>>> This needs a "Fixes:" line here.  I took the liberty of adding one to
>>>>> this patch.
>>>>>
>>>>
>>>> Thank you for your suggestions. Yes, this patch fix the commit id:
>>>> a1b3695 ("NTB: Add support for AMD PCI-Express Non-Transparent 
>>>> Bridge").
>>>>
>>>>>> Signed-off-by: Jiasen Lin <linjiasen@hygon.cn 
>>>>>> <mailto:linjiasen@hygon.cn>>
>>>>>> ---
>>>>>>    drivers/ntb/hw/amd/ntb_hw_amd.c | 5 +++--
>>>>>>    drivers/ntb/hw/amd/ntb_hw_amd.h | 1 -
>>>>>>    2 files changed, 3 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c
>>>>>> b/drivers/ntb/hw/amd/ntb_hw_amd.c
>>>>>> index 156c2a1..ae91105 100644
>>>>>> --- a/drivers/ntb/hw/amd/ntb_hw_amd.c
>>>>>> +++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
>>>>>> @@ -855,8 +855,8 @@ static int amd_poll_link(struct amd_ntb_dev 
>>>>>> *ndev)
>>>>>>
>>>>>>           ndev->cntl_sta = reg;
>>>>>>
>>>>>> -       rc = pci_read_config_dword(ndev->ntb.pdev,
>>>>>> -                                  AMD_LINK_STATUS_OFFSET, &stat);
>>>>>> +       rc = pcie_capability_read_dword(ndev->ntb.pdev,
>>>>>> +                                  PCI_EXP_LNKCTL, &stat);
>>>>>>           if (rc)
>>>>>>                   return 0;
>>>>>>           ndev->lnk_sta = stat;
>>>>>> @@ -1139,6 +1139,7 @@ static const struct ntb_dev_data dev_data[] = {
>>>>>>    static const struct pci_device_id amd_ntb_pci_tbl[] = {
>>>>>>           { PCI_VDEVICE(AMD, 0x145b), (kernel_ulong_t)&dev_data[0] },
>>>>>>           { PCI_VDEVICE(AMD, 0x148b), (kernel_ulong_t)&dev_data[1] },
>>>>>> +       { PCI_VDEVICE(HYGON, 0x145b), (kernel_ulong_t)&dev_data[0] },
>>>>>
>>>>> This should be a separate patch.  I took the liberty of splitting it
>>>>> off into a unique patch and attributing it to you.  I've pushed them
>>>>> to the ntb-next branch on
>>>>> https://github.com/jonmason/ntb
>>>>>
>>>> Thank you for your comment. We appreciate the time and effort you have
>>>> spent to split it off, I will test it ASAP.
>>>>
>>>>> Please verify everything looks acceptable to you (given the changes I
>>>>> did above that are attributed to you).  Also, testing of the latest
>>>>> code is always appreciated.
>>>>>
>>>>> Thanks,
>>>>> Jon
>>>>>
>>>
>>> I have tested these patches that are pushed to ntb-next branch, they
>>> work well on HYGON platforms.
>>>
>>> Thanks,
>>> Jiasen Lin
>>
>> Hi Jiasen Lin,
>>
>> Apologies for my delayed response. I was on vacation.
>>
>> Your patch is a correct fix, but that would work only for primary system.
>>
>> The design of AMD NTB implementation is such that NTB primary acts as 
>> an endpoint device and NTB secondary is a PCIe Root Port (RP). 
>> Considering that,
>> the link status and control register needs to be accessed differently 
>> based on the NTB topology.
>>
>> So in the case of NTB secondary, we read the link status and control 
>> register of the PCIe RP capabilities structure and in the case of NTB 
>> primary, we read the
>> link status and control register from NTB device capabilities structure.
>>
>> The code below is the proper fix for AMD platform. I will be sending 
>> incremental change above your patch.
>>
>> would appreciate if you could test my patch and let me know whether 
>> that works for you.
>>
> 
> Dhyana CPU dones not support data transfer while both sides of PCIe link 
> are configured as NTB, in other word, Dhyana only support NTB that is 
> connected to RP rather than NT to NT.
> 
> As illustrated in the following topology, NTB consists of two PCIe 
> endpoints, a Primary NTB, and a Secondary NTB. Primary CPU can find 
> Priamry NTB, while Secondary NTB, Secondary internal SW.ds and Secondary 
> internal SW.ds are enumerated by secondary CPU.
> 
> In this topology, to remove any ambiguity, your suggestion is more 
> accurate method to get link status of NTB.
> 
> In primary PCI domain:
> Primary RP--Primary NTB----------------------------------------
> 40:04.1-------41:00.1(Pri NTB)                                |
>                                                                | In 
> secondary PCI domain:                                      |
> Secondary RP--Secondary SW.us--Secondary SW.ds--Secondary NTB--
> 40:03.1---------41:00.0---------42:00.0---------43:00.1(Sec NTB)
> 

Hi Sanjay R Mehta

In more complex topology, read the Link Status and Control register of 
RP is also wrong. Suppose that a PCIe switch bridge to the Secondary RP, 
and Secondary internal SW.ds is a child device for switch's downstream 
port as illustrated in the following topology.

In secondary PCI domain:
Secondary RP--Switch UP--Switch DP--Secondary internal SW.us--Secondary 
internal SW.ds--Secondary NTB

pci_rp = pci_find_pcie_root_port(ndev->ntb.pdev) will return the 
Secondary RP, and pcie_capability_read_dword(pci_rp, 
PCI_EXP_LNKCTL,&stat) will get the link status between Secondary RP and 
Switch UP. Maybe, read the Link Status and control register of Secondary 
internal SW.us is appropriate.

struct pci_dev *pci_up = NULL;
struct pci_dev *pci_dp = NULL;

if (ndev->ntb.topo == NTB_TOPO_SEC) {
     /* Locate the pointer to Secondary up for this device */
     pci_dp = pci_upstream_bridge(ndev->ntb.pdev);
     /* Read the PCIe Link Control and Status register */
     if (pci_dp) {
	pci_up = pci_upstream_bridge(pci_dp);
	if (pci_up) {
		rc = pcie_capability_read_dword(pci_up, PCI_EXP_LNKCTL,
                         &stat);
         	if (rc)
            		return 0;
		}	
	}
}

Thanks,
Jiansen Lin

> I have modified the code according to your suggestion and tested it
> on Dhyana platform, it works well, expect to receice your patch.
> 
> Before modify the code, read the Link Status and control register of the 
> secondary NTB device to get link status.
> 
> cat /sys/kernel/debug/ntb_hw_amd/0000\:43\:00.1/info
> NTB Device Information:
> Connection Topology -   NTB_TOPO_SEC
> LNK STA -               0x11030042
> Link Status -           Up
> Link Speed -            PCI-E Gen 3
> Link Width -            x16
> 
> After modify the code, read the Link Status and control register of the 
> secondary RP to get link status.
> 
> cat /sys/kernel/debug/ntb_hw_amd/0000\:43\:00.1/info
> NTB Device Information:
> Connection Topology -   NTB_TOPO_SEC
> LNK STA -               0x70830042
> Link Status -           Up
> Link Speed -            PCI-E Gen 3
> Link Width -            x8
> 
> Thanks,
> Jiasen Lin
> 
>> ---
>>   drivers/ntb/hw/amd/ntb_hw_amd.c | 27 +++++++++++++++++++++++----
>>   drivers/ntb/hw/amd/ntb_hw_amd.h |  1 -
>>   2 files changed, 23 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c 
>> b/drivers/ntb/hw/amd/ntb_hw_amd.c
>> index 14ad69c..91e1966 100644
>> --- a/drivers/ntb/hw/amd/ntb_hw_amd.c
>> +++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
>> @@ -842,6 +842,8 @@ static inline void ndev_init_struct(struct 
>> amd_ntb_dev *ndev,
>>   static int amd_poll_link(struct amd_ntb_dev *ndev)
>>   {
>>       void __iomem *mmio = ndev->peer_mmio;
>> +    struct pci_dev *pci_rp = NULL;
>> +    struct pci_dev *pdev = NULL;
>>       u32 reg, stat;
>>       int rc;
>> @@ -855,10 +857,27 @@ static int amd_poll_link(struct amd_ntb_dev *ndev)
>>       ndev->cntl_sta = reg;
>> -    rc = pci_read_config_dword(ndev->ntb.pdev,
>> -                   AMD_LINK_STATUS_OFFSET, &stat);
>> -    if (rc)
>> -        return 0;
>> +    if (ndev->ntb.topo == NTB_TOPO_SEC) {
>> +        /* Locate the pointer to PCIe Root Port for this device */
>> +        pci_rp = pci_find_pcie_root_port(ndev->ntb.pdev);
>> +        /* Read the PCIe Link Control and Status register */
>> +        if (pci_rp) {
>> +            rc = pcie_capability_read_dword(pci_rp, PCI_EXP_LNKCTL,
>> +                            &stat);
>> +            if (rc)
>> +                return 0;
>> +        }
>> +    } else if (ndev->ntb.topo == NTB_TOPO_PRI) {
>> +        /*
>> +         * For NTB primary, we simply read the Link Status and control
>> +         * register of the NTB device itself.
>> +         */
>> +        pdev = ndev->ntb.pdev;
>> +        rc = pcie_capability_read_dword(pdev, PCI_EXP_LNKCTL, &stat);
>> +        if (rc)
>> +            return 0;
>> +    }
>> +
>>       ndev->lnk_sta = stat;
>>       return 1;
>> diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.h 
>> b/drivers/ntb/hw/amd/ntb_hw_amd.h
>> index 139a307..39e5d18 100644
>> --- a/drivers/ntb/hw/amd/ntb_hw_amd.h
>> +++ b/drivers/ntb/hw/amd/ntb_hw_amd.h
>> @@ -53,7 +53,6 @@
>>   #include <linux/pci.h>
>>   #define AMD_LINK_HB_TIMEOUT    msecs_to_jiffies(1000)
>> -#define AMD_LINK_STATUS_OFFSET    0x68
>>   #define NTB_LIN_STA_ACTIVE_BIT    0x00000002
>>   #define NTB_LNK_STA_SPEED_MASK    0x000F0000
>>   #define NTB_LNK_STA_WIDTH_MASK    0x03F00000
>>
