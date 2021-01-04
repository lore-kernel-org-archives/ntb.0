Return-Path: <kishon@ti.com>
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com. [198.47.19.142])
        by gmr-mx.google.com with ESMTPS id u2si5940216otg.1.2021.01.04.05.13.10
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Jan 2021 05:13:10 -0800 (PST)
From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v8 11/18] PCI: cadence: Implement ->msi_map_irq() ops
References: <20201111153559.19050-1-kishon@ti.com>
 <20201111153559.19050-12-kishon@ti.com>
 <CAL_Jsq+iUU0aR950fvQ7+uenBT5MVbCEU9cDg+vfyO=VugpTZA@mail.gmail.com>
Message-ID: <992b5423-89a2-a03b-539d-a9b2822f598a@ti.com>
Date: Mon, 4 Jan 2021 18:42:55 +0530
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+iUU0aR950fvQ7+uenBT5MVbCEU9cDg+vfyO=VugpTZA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Tom Joseph <tjoseph@cadence.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, PCI <linux-pci@vger.kernel.org>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

Hi Rob,

On 15/12/20 9:31 pm, Rob Herring wrote:
> On Wed, Nov 11, 2020 at 9:37 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>>
>> Implement ->msi_map_irq() ops in order to map physical address to
>> MSI address and return MSI data.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  .../pci/controller/cadence/pcie-cadence-ep.c  | 53 +++++++++++++++++++
>>  1 file changed, 53 insertions(+)
>>
>> diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
>> index 84cc58dc8512..1fe6b8baca97 100644
>> --- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
>> +++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
>> @@ -382,6 +382,57 @@ static int cdns_pcie_ep_send_msi_irq(struct cdns_pcie_ep *ep, u8 fn,
>>         return 0;
>>  }
>>
>> +static int cdns_pcie_ep_map_msi_irq(struct pci_epc *epc, u8 fn,
>> +                                   phys_addr_t addr, u8 interrupt_num,
>> +                                   u32 entry_size, u32 *msi_data,
>> +                                   u32 *msi_addr_offset)
>> +{
>> +       struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
>> +       u32 cap = CDNS_PCIE_EP_FUNC_MSI_CAP_OFFSET;
>> +       struct cdns_pcie *pcie = &ep->pcie;
>> +       u64 pci_addr, pci_addr_mask = 0xff;
>> +       u16 flags, mme, data, data_mask;
>> +       u8 msi_count;
>> +       int ret;
>> +       int i;
>> +
> 
> 
>> +       /* Check whether the MSI feature has been enabled by the PCI host. */
>> +       flags = cdns_pcie_ep_fn_readw(pcie, fn, cap + PCI_MSI_FLAGS);
>> +       if (!(flags & PCI_MSI_FLAGS_ENABLE))
>> +               return -EINVAL;
>> +
>> +       /* Get the number of enabled MSIs */
>> +       mme = (flags & PCI_MSI_FLAGS_QSIZE) >> 4;
>> +       msi_count = 1 << mme;
>> +       if (!interrupt_num || interrupt_num > msi_count)
>> +               return -EINVAL;
>> +
>> +       /* Compute the data value to be written. */
>> +       data_mask = msi_count - 1;
>> +       data = cdns_pcie_ep_fn_readw(pcie, fn, cap + PCI_MSI_DATA_64);
>> +       data = data & ~data_mask;
>> +
>> +       /* Get the PCI address where to write the data into. */
>> +       pci_addr = cdns_pcie_ep_fn_readl(pcie, fn, cap + PCI_MSI_ADDRESS_HI);
>> +       pci_addr <<= 32;
>> +       pci_addr |= cdns_pcie_ep_fn_readl(pcie, fn, cap + PCI_MSI_ADDRESS_LO);
>> +       pci_addr &= GENMASK_ULL(63, 2);
> 
> Wouldn't all of the above be the same code for any endpoint driver? We
> just need endpoint config space accessors for the same 32-bit only
> access issues. Not asking for that in this series, but if that's the
> direction we should go.

Do you mean "endpoint" variant of pci_generic_config_read() which takes
function number and capability offset? That could be done but we have to
add support to traverse the linked list of capabilities though the
capabilities are going to be at a fixed location for a given IP.

Also in some cases, the writes are to a different register than the
configuration space registers like vendor_id in Cadence EP should be
written to Local Management register instead of the configuration space
register.

Thank You,
Kishon
