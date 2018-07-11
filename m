Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com. [2a00:1450:4864:20::241])
        by gmr-mx.google.com with ESMTPS id z74-v6si665468lff.3.2018.07.11.09.31.48
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 09:31:48 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id y17-v6so15065445ljy.8
        for <linux-ntb@googlegroups.com>; Wed, 11 Jul 2018 09:31:48 -0700 (PDT)
Return-Path: <fancer.lancer@gmail.com>
From: Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH] ntb: idt: Set PCIe bus address to BARLIMITx
Date: Wed, 11 Jul 2018 19:32:24 +0300
Message-Id: <20180711163224.30892-1-fancer.lancer@gmail.com>
To: jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com
Cc: Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

IDT NTB driver sets the upper limit of actual translation address
being set to the corresponding memory window. It is achieved by
BARLIMITx register initialization. Needless to say, that the register
works within PCIe bus address space.

In general CPU and PCIe address spaces are different. It means,
that addresses used for Memory TLPs routine can be different from
CPU addresses. While in most of cases they are the same, there are
exceptions when the proper mapping must be performed to have the
portable driver code. There used to be a virt_to_bus()/bus_to_virt()
interface for this purpose. But it's deprecated now. It was also a
mistake to use pci_resource_start() since the return address of the
method is at the CPU address space. In order to achieve the desired
purpose we need to use pcibios_resource_to_bus(). This method shall
return a PCIe bus address region of the corresponding BAR resources.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/ntb/hw/idt/ntb_hw_idt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
index dbe72f116017..0f4f5e7e4ff8 100644
--- a/drivers/ntb/hw/idt/ntb_hw_idt.c
+++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
@@ -1311,6 +1311,7 @@ static int idt_ntb_peer_mw_set_trans(struct ntb_dev *ntb, int pidx, int widx,
 	/* DIR and LUT based translations are initialized differently */
 	if (mw_cfg->type == IDT_MW_DIR) {
 		const struct idt_ntb_bar *bar = &ntdata_tbl.bars[mw_cfg->bar];
+		struct pci_bus_region region;
 		u64 limit;
 		/* Set destination partition of translation */
 		data = idt_nt_read(ndev, bar->setup);
@@ -1320,7 +1321,9 @@ static int idt_ntb_peer_mw_set_trans(struct ntb_dev *ntb, int pidx, int widx,
 		idt_nt_write(ndev, bar->ltbase, (u32)addr);
 		idt_nt_write(ndev, bar->utbase, (u32)(addr >> 32));
 		/* Set the custom BAR aperture limit */
-		limit = pci_resource_start(ntb->pdev, mw_cfg->bar) + size;
+		pcibios_resource_to_bus(ntb->pdev->bus, &region,
+					&ntb->pdev->resource[mw_cfg->bar]);
+		limit = region.start + size;
 		idt_nt_write(ndev, bar->limit, (u32)limit);
 		if (IS_FLD_SET(BARSETUP_TYPE, data, 64))
 			idt_nt_write(ndev, (bar + 1)->limit, (limit >> 32));
-- 
2.12.0

