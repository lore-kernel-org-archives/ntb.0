Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf0-x241.google.com (mail-lf0-x241.google.com. [2a00:1450:4010:c07::241])
        by gmr-mx.google.com with ESMTPS id o10si194466wme.0.2016.07.26.12.51.06
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jul 2016 12:51:06 -0700 (PDT)
Received: by mail-lf0-x241.google.com with SMTP id f93so938875lfi.0
        for <linux-ntb@googlegroups.com>; Tue, 26 Jul 2016 12:51:06 -0700 (PDT)
Return-Path: <fancer.lancer@gmail.com>
From: Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH 1/3] ntb: Add asynchronous devices support to NTB-bus interface
Date: Tue, 26 Jul 2016 22:50:17 +0300
Message-Id: <1469562619-21705-2-git-send-email-fancer.lancer@gmail.com>
In-Reply-To: <1469562619-21705-1-git-send-email-fancer.lancer@gmail.com>
References: <1469562619-21705-1-git-send-email-fancer.lancer@gmail.com>
To: jdmason@kudzu.us
Cc: dave.jiang@intel.com, Allen.Hubbe@emc.com, Xiangliang.Yu@amd.com, Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

Currently supported AMD and Intel Non-transparent PCIe-bridges are synchronous
devices, so translated base address of memory windows can be direcly written
to peer registers. But there are some IDT PCIe-switches which implement
complex interfaces using Lookup Tables of translation addresses. Due to
the way the table is accessed, it can not be done synchronously from different
RCs, that's why the asynchronous interface should be developed.

For these purpose the Memory Window related interface is correspondingly split
as it is for Doorbell and Scratchpad registers. The definition of Memory Window
is following: "It is a virtual memory region, which locally reflects a physical
memory of peer device." So to speak the "ntb_peer_mw_"-prefixed methods control
the peers memory windows, "ntb_mw_"-prefixed functions work with the local
memory windows.
Here is the description of the Memory Window related NTB-bus callback
functions:
 - ntb_mw_count() - number of local memory windows.
 - ntb_mw_get_maprsc() - get the physical address and size of the local memory
                         window to map.
 - ntb_mw_set_trans() - set translation address of local memory window (this
                        address should be somehow retrieved from a peer).
 - ntb_mw_get_trans() - get translation address of local memory window.
 - ntb_mw_get_align() - get alignment of translated base address and size of
                        local memory window. Additionally one can get the
                        upper size limit of the memory window.
 - ntb_peer_mw_count() - number of peer memory windows (it can differ from the
                         local number).
 - ntb_peer_mw_set_trans() - set translation address of peer memory window
 - ntb_peer_mw_get_trans() - get translation address of peer memory window
 - ntb_peer_mw_get_align() - get alignment of translated base address and size
                             of peer memory window.Additionally one can get the
                             upper size limit of the memory window.

As one can see current AMD and Intel NTB drivers mostly implement the
"ntb_peer_mw_"-prefixed methods. So this patch correspondingly renames the
driver functions. IDT NTB driver mostly expose "ntb_nw_"-prefixed methods,
since it doesn't have convenient access to the peer Lookup Table.

In order to pass information from one RC to another NTB functions of IDT
PCIe-switch implement Messaging subsystem. They currently support four message
registers to transfer DWORD sized data to a specified peer. So there are two
new callback methods are introduced:
 - ntb_msg_size() - get the number of DWORDs supported by NTB function to send
                    and receive messages
 - ntb_msg_post() - send message of size retrieved from ntb_msg_size()
                    to a peer
Additionally there is a new event function:
 - ntb_msg_event() - it is invoked when either a new message was retrieved
                     (NTB_MSG_NEW), or last message was successfully sent
                     (NTB_MSG_SENT), or the last message failed to be sent
                     (NTB_MSG_FAIL).

The last change concerns the IDs (practically names) of NTB-devices on the
NTB-bus. It is not good to have the devices with same names in the system
and it brakes my IDT NTB driver from being loaded =) So I developed a simple
algorithm of NTB devices naming. Particulary it generates names "ntbS{N}" for
synchronous devices, "ntbA{N}" for asynchronous devices, and "ntbAS{N}" for
devices supporting both interfaces.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---
 drivers/ntb/Kconfig                 |   4 +-
 drivers/ntb/hw/amd/ntb_hw_amd.c     |  49 ++-
 drivers/ntb/hw/intel/ntb_hw_intel.c |  59 +++-
 drivers/ntb/ntb.c                   |  86 +++++-
 drivers/ntb/ntb_transport.c         |  19 +-
 drivers/ntb/test/ntb_perf.c         |  16 +-
 drivers/ntb/test/ntb_pingpong.c     |   5 +
 drivers/ntb/test/ntb_tool.c         |  25 +-
 include/linux/ntb.h                 | 600 +++++++++++++++++++++++++++++-------
 9 files changed, 701 insertions(+), 162 deletions(-)

diff --git a/drivers/ntb/Kconfig b/drivers/ntb/Kconfig
index 95944e5..67d80c4 100644
--- a/drivers/ntb/Kconfig
+++ b/drivers/ntb/Kconfig
@@ -14,8 +14,6 @@ if NTB
 
 source "drivers/ntb/hw/Kconfig"
 
-source "drivers/ntb/test/Kconfig"
-
 config NTB_TRANSPORT
 	tristate "NTB Transport Client"
 	help
@@ -25,4 +23,6 @@ config NTB_TRANSPORT
 
 	 If unsure, say N.
 
+source "drivers/ntb/test/Kconfig"
+
 endif # NTB
diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index 6ccba0d..ab6f353 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -55,6 +55,7 @@
 #include <linux/pci.h>
 #include <linux/random.h>
 #include <linux/slab.h>
+#include <linux/sizes.h>
 #include <linux/ntb.h>
 
 #include "ntb_hw_amd.h"
@@ -84,11 +85,8 @@ static int amd_ntb_mw_count(struct ntb_dev *ntb)
 	return ntb_ndev(ntb)->mw_count;
 }
 
-static int amd_ntb_mw_get_range(struct ntb_dev *ntb, int idx,
-				phys_addr_t *base,
-				resource_size_t *size,
-				resource_size_t *align,
-				resource_size_t *align_size)
+static int amd_ntb_mw_get_maprsc(struct ntb_dev *ntb, int idx,
+				 phys_addr_t *base, resource_size_t *size)
 {
 	struct amd_ntb_dev *ndev = ntb_ndev(ntb);
 	int bar;
@@ -103,17 +101,40 @@ static int amd_ntb_mw_get_range(struct ntb_dev *ntb, int idx,
 	if (size)
 		*size = pci_resource_len(ndev->ntb.pdev, bar);
 
-	if (align)
-		*align = SZ_4K;
+	return 0;
+}
+
+static int amd_ntb_peer_mw_count(struct ntb_dev *ntb)
+{
+	return ntb_ndev(ntb)->mw_count;
+}
+
+static int amd_ntb_peer_mw_get_align(struct ntb_dev *ntb, int idx,
+				     resource_size_t *addr_align,
+				     resource_size_t *size_align,
+				     resource_size_t *size_max)
+{
+	struct amd_ntb_dev *ndev = ntb_ndev(ntb);
+	int bar;
+
+	bar = ndev_mw_to_bar(ndev, idx);
+	if (bar < 0)
+		return bar;
+
+	if (addr_align)
+		*addr_align = SZ_4K;
+
+	if (size_align)
+		*size_align = 1;
 
-	if (align_size)
-		*align_size = 1;
+	if (size_max)
+		*size_max = pci_resource_len(ndev->ntb.pdev, bar);
 
 	return 0;
 }
 
-static int amd_ntb_mw_set_trans(struct ntb_dev *ntb, int idx,
-				dma_addr_t addr, resource_size_t size)
+static int amd_ntb_peer_mw_set_trans(struct ntb_dev *ntb, int idx,
+				     dma_addr_t addr, resource_size_t size)
 {
 	struct amd_ntb_dev *ndev = ntb_ndev(ntb);
 	unsigned long xlat_reg, limit_reg = 0;
@@ -432,8 +453,10 @@ static int amd_ntb_peer_spad_write(struct ntb_dev *ntb,
 
 static const struct ntb_dev_ops amd_ntb_ops = {
 	.mw_count		= amd_ntb_mw_count,
-	.mw_get_range		= amd_ntb_mw_get_range,
-	.mw_set_trans		= amd_ntb_mw_set_trans,
+	.mw_get_maprsc		= amd_ntb_mw_get_maprsc,
+	.peer_mw_count		= amd_ntb_peer_mw_count,
+	.peer_mw_get_align	= amd_ntb_peer_mw_get_align,
+	.peer_mw_set_trans	= amd_ntb_peer_mw_set_trans,
 	.link_is_up		= amd_ntb_link_is_up,
 	.link_enable		= amd_ntb_link_enable,
 	.link_disable		= amd_ntb_link_disable,
diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.c b/drivers/ntb/hw/intel/ntb_hw_intel.c
index 40d04ef..fdb2838 100644
--- a/drivers/ntb/hw/intel/ntb_hw_intel.c
+++ b/drivers/ntb/hw/intel/ntb_hw_intel.c
@@ -804,11 +804,8 @@ static int intel_ntb_mw_count(struct ntb_dev *ntb)
 	return ntb_ndev(ntb)->mw_count;
 }
 
-static int intel_ntb_mw_get_range(struct ntb_dev *ntb, int idx,
-				  phys_addr_t *base,
-				  resource_size_t *size,
-				  resource_size_t *align,
-				  resource_size_t *align_size)
+static int intel_ntb_mw_get_maprsc(struct ntb_dev *ntb, int idx,
+				   phys_addr_t *base, resource_size_t *size)
 {
 	struct intel_ntb_dev *ndev = ntb_ndev(ntb);
 	int bar;
@@ -828,17 +825,51 @@ static int intel_ntb_mw_get_range(struct ntb_dev *ntb, int idx,
 		*size = pci_resource_len(ndev->ntb.pdev, bar) -
 			(idx == ndev->b2b_idx ? ndev->b2b_off : 0);
 
-	if (align)
-		*align = pci_resource_len(ndev->ntb.pdev, bar);
+	return 0;
+}
+
+static int intel_ntb_peer_mw_count(struct ntb_dev *ntb)
+{
+	return ntb_ndev(ntb)->mw_count;
+}
+
+static int intel_ntb_peer_mw_get_align(struct ntb_dev *ntb, int idx,
+				       resource_size_t *addr_align,
+				       resource_size_t *size_align,
+				       resource_size_t *size_max)
+{
+	struct intel_ntb_dev *ndev = ntb_ndev(ntb);
+	resource_size_t bar_size, mw_size;
+	int bar;
+
+	if (idx >= ndev->b2b_idx && !ndev->b2b_off)
+		idx += 1;
+
+	bar = ndev_mw_to_bar(ndev, idx);
+	if (bar < 0)
+		return bar;
+
+	bar_size = pci_resource_len(ndev->ntb.pdev, bar);
+
+	if (idx == ndev->b2b_idx)
+		mw_size = bar_size - ndev->b2b_off;
+	else
+		mw_size = bar_size;
+
+	if (addr_align)
+		*addr_align = bar_size;
+
+	if (size_align)
+		*size_align = 1;
 
-	if (align_size)
-		*align_size = 1;
+	if (size_max)
+		*size_max = mw_size;
 
 	return 0;
 }
 
-static int intel_ntb_mw_set_trans(struct ntb_dev *ntb, int idx,
-				  dma_addr_t addr, resource_size_t size)
+static int intel_ntb_peer_mw_set_trans(struct ntb_dev *ntb, int idx,
+				       dma_addr_t addr, resource_size_t size)
 {
 	struct intel_ntb_dev *ndev = ntb_ndev(ntb);
 	unsigned long base_reg, xlat_reg, limit_reg;
@@ -2220,8 +2251,10 @@ static struct intel_b2b_addr xeon_b2b_dsd_addr = {
 /* operations for primary side of local ntb */
 static const struct ntb_dev_ops intel_ntb_ops = {
 	.mw_count		= intel_ntb_mw_count,
-	.mw_get_range		= intel_ntb_mw_get_range,
-	.mw_set_trans		= intel_ntb_mw_set_trans,
+	.mw_get_maprsc		= intel_ntb_mw_get_maprsc,
+	.peer_mw_count		= intel_ntb_peer_mw_count,
+	.peer_mw_get_align	= intel_ntb_peer_mw_get_align,
+	.peer_mw_set_trans	= intel_ntb_peer_mw_set_trans,
 	.link_is_up		= intel_ntb_link_is_up,
 	.link_enable		= intel_ntb_link_enable,
 	.link_disable		= intel_ntb_link_disable,
diff --git a/drivers/ntb/ntb.c b/drivers/ntb/ntb.c
index 2e25307..37c3b36 100644
--- a/drivers/ntb/ntb.c
+++ b/drivers/ntb/ntb.c
@@ -54,6 +54,7 @@
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/atomic.h>
 
 #include <linux/ntb.h>
 #include <linux/pci.h>
@@ -72,8 +73,62 @@ MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESCRIPTION);
 
 static struct bus_type ntb_bus;
+static struct ntb_bus_data ntb_data;
 static void ntb_dev_release(struct device *dev);
 
+static int ntb_gen_devid(struct ntb_dev *ntb)
+{
+	const char *name;
+	unsigned long *mask;
+	int id;
+
+	if (ntb_valid_sync_dev_ops(ntb) && ntb_valid_async_dev_ops(ntb)) {
+		name = "ntbAS%d";
+		mask = ntb_data.both_msk;
+	} else if (ntb_valid_sync_dev_ops(ntb)) {
+		name = "ntbS%d";
+		mask = ntb_data.sync_msk;
+	} else if (ntb_valid_async_dev_ops(ntb)) {
+		name = "ntbA%d";
+		mask = ntb_data.async_msk;
+	} else {
+		return -EINVAL;
+	}
+
+	for (id = 0; NTB_MAX_DEVID > id; id++) {
+		if (0 == test_and_set_bit(id, mask)) {
+			ntb->id = id;
+			break;
+		}
+	}
+
+	if (NTB_MAX_DEVID > id) {
+		dev_set_name(&ntb->dev, name, ntb->id);
+	} else {
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static void ntb_free_devid(struct ntb_dev *ntb)
+{
+	unsigned long *mask;
+
+	if (ntb_valid_sync_dev_ops(ntb) && ntb_valid_async_dev_ops(ntb)) {
+		mask = ntb_data.both_msk;
+	} else if (ntb_valid_sync_dev_ops(ntb)) {
+		mask = ntb_data.sync_msk;
+	} else if (ntb_valid_async_dev_ops(ntb)) {
+		mask = ntb_data.async_msk;
+	} else {
+		/* It's impossible */
+		BUG();
+	}
+
+	clear_bit(ntb->id, mask);
+}
+
 int __ntb_register_client(struct ntb_client *client, struct module *mod,
 			  const char *mod_name)
 {
@@ -99,13 +154,15 @@ EXPORT_SYMBOL(ntb_unregister_client);
 
 int ntb_register_device(struct ntb_dev *ntb)
 {
+	int ret;
+
 	if (!ntb)
 		return -EINVAL;
 	if (!ntb->pdev)
 		return -EINVAL;
 	if (!ntb->ops)
 		return -EINVAL;
-	if (!ntb_dev_ops_is_valid(ntb->ops))
+	if (!ntb_valid_sync_dev_ops(ntb) && !ntb_valid_async_dev_ops(ntb))
 		return -EINVAL;
 
 	init_completion(&ntb->released);
@@ -114,13 +171,21 @@ int ntb_register_device(struct ntb_dev *ntb)
 	ntb->dev.bus = &ntb_bus;
 	ntb->dev.parent = &ntb->pdev->dev;
 	ntb->dev.release = ntb_dev_release;
-	dev_set_name(&ntb->dev, "%s", pci_name(ntb->pdev));
 
 	ntb->ctx = NULL;
 	ntb->ctx_ops = NULL;
 	spin_lock_init(&ntb->ctx_lock);
 
-	return device_register(&ntb->dev);
+	/* No need to wait for completion if failed */
+	ret = ntb_gen_devid(ntb);
+	if (ret)
+		return ret;
+
+	ret = device_register(&ntb->dev);
+	if (ret)
+		ntb_free_devid(ntb);
+
+	return ret;
 }
 EXPORT_SYMBOL(ntb_register_device);
 
@@ -128,6 +193,7 @@ void ntb_unregister_device(struct ntb_dev *ntb)
 {
 	device_unregister(&ntb->dev);
 	wait_for_completion(&ntb->released);
+	ntb_free_devid(ntb);
 }
 EXPORT_SYMBOL(ntb_unregister_device);
 
@@ -191,6 +257,20 @@ void ntb_db_event(struct ntb_dev *ntb, int vector)
 }
 EXPORT_SYMBOL(ntb_db_event);
 
+void ntb_msg_event(struct ntb_dev *ntb, enum NTB_MSG_EVENT ev,
+		   struct ntb_msg *msg)
+{
+	unsigned long irqflags;
+
+	spin_lock_irqsave(&ntb->ctx_lock, irqflags);
+	{
+		if (ntb->ctx_ops && ntb->ctx_ops->msg_event)
+			ntb->ctx_ops->msg_event(ntb->ctx, ev, msg);
+	}
+	spin_unlock_irqrestore(&ntb->ctx_lock, irqflags);
+}
+EXPORT_SYMBOL(ntb_msg_event);
+
 static int ntb_probe(struct device *dev)
 {
 	struct ntb_dev *ntb;
diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index d5c5894..2626ba0 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -673,7 +673,7 @@ static void ntb_free_mw(struct ntb_transport_ctx *nt, int num_mw)
 	if (!mw->virt_addr)
 		return;
 
-	ntb_mw_clear_trans(nt->ndev, num_mw);
+	ntb_peer_mw_set_trans(nt->ndev, num_mw, 0, 0);
 	dma_free_coherent(&pdev->dev, mw->buff_size,
 			  mw->virt_addr, mw->dma_addr);
 	mw->xlat_size = 0;
@@ -730,7 +730,8 @@ static int ntb_set_mw(struct ntb_transport_ctx *nt, int num_mw,
 	}
 
 	/* Notify HW the memory location of the receive buffer */
-	rc = ntb_mw_set_trans(nt->ndev, num_mw, mw->dma_addr, mw->xlat_size);
+	rc = ntb_peer_mw_set_trans(nt->ndev, num_mw, mw->dma_addr,
+				   mw->xlat_size);
 	if (rc) {
 		dev_err(&pdev->dev, "Unable to set mw%d translation", num_mw);
 		ntb_free_mw(nt, num_mw);
@@ -1060,7 +1061,11 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
 	int node;
 	int rc, i;
 
-	mw_count = ntb_mw_count(ndev);
+	/* Synchronous hardware is only supported */
+	if (!ntb_valid_sync_dev_ops(ndev))
+		return -EINVAL;
+
+	mw_count = ntb_peer_mw_count(ndev);
 	if (ntb_spad_count(ndev) < (NUM_MWS + 1 + mw_count * 2)) {
 		dev_err(&ndev->dev, "Not enough scratch pad registers for %s",
 			NTB_TRANSPORT_NAME);
@@ -1094,8 +1099,12 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
 	for (i = 0; i < mw_count; i++) {
 		mw = &nt->mw_vec[i];
 
-		rc = ntb_mw_get_range(ndev, i, &mw->phys_addr, &mw->phys_size,
-				      &mw->xlat_align, &mw->xlat_align_size);
+		rc = ntb_mw_get_maprsc(ndev, i, &mw->phys_addr, &mw->phys_size);
+		if (rc)
+			goto err1;
+
+		rc = ntb_peer_mw_get_align(ndev, i, &mw->xlat_align,
+					   &mw->xlat_align_size, NULL);
 		if (rc)
 			goto err1;
 
diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index 6a50f20..f2952f7 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -452,7 +452,7 @@ static void perf_free_mw(struct perf_ctx *perf)
 	if (!mw->virt_addr)
 		return;
 
-	ntb_mw_clear_trans(perf->ntb, 0);
+	ntb_peer_mw_set_trans(perf->ntb, 0, 0, 0);
 	dma_free_coherent(&pdev->dev, mw->buf_size,
 			  mw->virt_addr, mw->dma_addr);
 	mw->xlat_size = 0;
@@ -488,7 +488,7 @@ static int perf_set_mw(struct perf_ctx *perf, resource_size_t size)
 		mw->buf_size = 0;
 	}
 
-	rc = ntb_mw_set_trans(perf->ntb, 0, mw->dma_addr, mw->xlat_size);
+	rc = ntb_peer_mw_set_trans(perf->ntb, 0, mw->dma_addr, mw->xlat_size);
 	if (rc) {
 		dev_err(&perf->ntb->dev, "Unable to set mw0 translation\n");
 		perf_free_mw(perf);
@@ -559,8 +559,12 @@ static int perf_setup_mw(struct ntb_dev *ntb, struct perf_ctx *perf)
 
 	mw = &perf->mw;
 
-	rc = ntb_mw_get_range(ntb, 0, &mw->phys_addr, &mw->phys_size,
-			      &mw->xlat_align, &mw->xlat_align_size);
+	rc = ntb_mw_get_maprsc(ntb, 0, &mw->phys_addr, &mw->phys_size);
+	if (rc)
+		return rc;
+
+	rc = ntb_peer_mw_get_align(ntb, 0, &mw->xlat_align,
+				   &mw->xlat_align_size, NULL);
 	if (rc)
 		return rc;
 
@@ -758,6 +762,10 @@ static int perf_probe(struct ntb_client *client, struct ntb_dev *ntb)
 	int node;
 	int rc = 0;
 
+	/* Synchronous hardware is only supported */
+	if (!ntb_valid_sync_dev_ops(ntb))
+		return -EINVAL;
+
 	if (ntb_spad_count(ntb) < MAX_SPAD) {
 		dev_err(&ntb->dev, "Not enough scratch pad registers for %s",
 			DRIVER_NAME);
diff --git a/drivers/ntb/test/ntb_pingpong.c b/drivers/ntb/test/ntb_pingpong.c
index 7d31179..e833649 100644
--- a/drivers/ntb/test/ntb_pingpong.c
+++ b/drivers/ntb/test/ntb_pingpong.c
@@ -214,6 +214,11 @@ static int pp_probe(struct ntb_client *client,
 	struct pp_ctx *pp;
 	int rc;
 
+	/* Synchronous hardware is only supported */
+	if (!ntb_valid_sync_dev_ops(ntb)) {
+		return -EINVAL;
+	}
+
 	if (ntb_db_is_unsafe(ntb)) {
 		dev_dbg(&ntb->dev, "doorbell is unsafe\n");
 		if (!unsafe) {
diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c
index 61bf2ef..5dfe12f 100644
--- a/drivers/ntb/test/ntb_tool.c
+++ b/drivers/ntb/test/ntb_tool.c
@@ -675,8 +675,11 @@ static int tool_setup_mw(struct tool_ctx *tc, int idx, size_t req_size)
 	if (mw->peer)
 		return 0;
 
-	rc = ntb_mw_get_range(tc->ntb, idx, &base, &size, &align,
-			      &align_size);
+	rc = ntb_mw_get_maprsc(tc->ntb, idx, &base, &size);
+	if (rc)
+		return rc;
+
+	rc = ntb_peer_mw_get_align(tc->ntb, idx, &align, &align_size, NULL);
 	if (rc)
 		return rc;
 
@@ -689,7 +692,7 @@ static int tool_setup_mw(struct tool_ctx *tc, int idx, size_t req_size)
 	if (!mw->peer)
 		return -ENOMEM;
 
-	rc = ntb_mw_set_trans(tc->ntb, idx, mw->peer_dma, mw->size);
+	rc = ntb_peer_mw_set_trans(tc->ntb, idx, mw->peer_dma, mw->size);
 	if (rc)
 		goto err_free_dma;
 
@@ -716,7 +719,7 @@ static void tool_free_mw(struct tool_ctx *tc, int idx)
 	struct tool_mw *mw = &tc->mws[idx];
 
 	if (mw->peer) {
-		ntb_mw_clear_trans(tc->ntb, idx);
+		ntb_peer_mw_set_trans(tc->ntb, idx, 0, 0);
 		dma_free_coherent(&tc->ntb->pdev->dev, mw->size,
 				  mw->peer,
 				  mw->peer_dma);
@@ -751,8 +754,8 @@ static ssize_t tool_peer_mw_trans_read(struct file *filep,
 	if (!buf)
 		return -ENOMEM;
 
-	ntb_mw_get_range(mw->tc->ntb, mw->idx,
-			 &base, &mw_size, &align, &align_size);
+	ntb_mw_get_maprsc(mw->tc->ntb, mw->idx, &base, &mw_size);
+	ntb_peer_mw_get_align(mw->tc->ntb, mw->idx, &align, &align_size, NULL);
 
 	off += scnprintf(buf + off, buf_size - off,
 			 "Peer MW %d Information:\n", mw->idx);
@@ -827,8 +830,7 @@ static int tool_init_mw(struct tool_ctx *tc, int idx)
 	phys_addr_t base;
 	int rc;
 
-	rc = ntb_mw_get_range(tc->ntb, idx, &base, &mw->win_size,
-			      NULL, NULL);
+	rc = ntb_mw_get_maprsc(tc->ntb, idx, &base, &mw->win_size);
 	if (rc)
 		return rc;
 
@@ -913,6 +915,11 @@ static int tool_probe(struct ntb_client *self, struct ntb_dev *ntb)
 	int rc;
 	int i;
 
+	/* Synchronous hardware is only supported */
+	if (!ntb_valid_sync_dev_ops(ntb)) {
+		return -EINVAL;
+	}
+
 	if (ntb_db_is_unsafe(ntb))
 		dev_dbg(&ntb->dev, "doorbell is unsafe\n");
 
@@ -928,7 +935,7 @@ static int tool_probe(struct ntb_client *self, struct ntb_dev *ntb)
 	tc->ntb = ntb;
 	init_waitqueue_head(&tc->link_wq);
 
-	tc->mw_count = min(ntb_mw_count(tc->ntb), MAX_MWS);
+	tc->mw_count = min(ntb_peer_mw_count(tc->ntb), MAX_MWS);
 	for (i = 0; i < tc->mw_count; i++) {
 		rc = tool_init_mw(tc, i);
 		if (rc)
diff --git a/include/linux/ntb.h b/include/linux/ntb.h
index 6f47562..d1937d3 100644
--- a/include/linux/ntb.h
+++ b/include/linux/ntb.h
@@ -159,13 +159,44 @@ static inline int ntb_client_ops_is_valid(const struct ntb_client_ops *ops)
 }
 
 /**
+ * struct ntb_msg - ntb driver message structure
+ * @type:	Message type.
+ * @payload:	Payload data to send to a peer
+ * @data:	Array of u32 data to send (size might be hw dependent)
+ */
+#define NTB_MAX_MSGSIZE 4
+struct ntb_msg {
+	union {
+		struct {
+			u32 type;
+			u32 payload[NTB_MAX_MSGSIZE - 1];
+		};
+		u32 data[NTB_MAX_MSGSIZE];
+	};
+};
+
+/**
+ * enum NTB_MSG_EVENT - message event types
+ * @NTB_MSG_NEW:	New message just arrived and passed to the handler
+ * @NTB_MSG_SENT:	Posted message has just been successfully sent
+ * @NTB_MSG_FAIL:	Posted message failed to be sent
+ */
+enum NTB_MSG_EVENT {
+	NTB_MSG_NEW,
+	NTB_MSG_SENT,
+	NTB_MSG_FAIL
+};
+
+/**
  * struct ntb_ctx_ops - ntb driver context operations
  * @link_event:		See ntb_link_event().
  * @db_event:		See ntb_db_event().
+ * @msg_event:		See ntb_msg_event().
  */
 struct ntb_ctx_ops {
 	void (*link_event)(void *ctx);
 	void (*db_event)(void *ctx, int db_vector);
+	void (*msg_event)(void *ctx, enum NTB_MSG_EVENT ev, struct ntb_msg *msg);
 };
 
 static inline int ntb_ctx_ops_is_valid(const struct ntb_ctx_ops *ops)
@@ -174,18 +205,24 @@ static inline int ntb_ctx_ops_is_valid(const struct ntb_ctx_ops *ops)
 	return
 		/* ops->link_event		&& */
 		/* ops->db_event		&& */
+		/* ops->msg_event		&& */
 		1;
 }
 
 /**
  * struct ntb_ctx_ops - ntb device operations
- * @mw_count:		See ntb_mw_count().
- * @mw_get_range:	See ntb_mw_get_range().
- * @mw_set_trans:	See ntb_mw_set_trans().
- * @mw_clear_trans:	See ntb_mw_clear_trans().
  * @link_is_up:		See ntb_link_is_up().
  * @link_enable:	See ntb_link_enable().
  * @link_disable:	See ntb_link_disable().
+ * @mw_count:		See ntb_mw_count().
+ * @mw_get_maprsc:	See ntb_mw_get_maprsc().
+ * @mw_set_trans:	See ntb_mw_set_trans().
+ * @mw_get_trans:	See ntb_mw_get_trans().
+ * @mw_get_align:	See ntb_mw_get_align().
+ * @peer_mw_count:	See ntb_peer_mw_count().
+ * @peer_mw_set_trans:	See ntb_peer_mw_set_trans().
+ * @peer_mw_get_trans:	See ntb_peer_mw_get_trans().
+ * @peer_mw_get_align:	See ntb_peer_mw_get_align().
  * @db_is_unsafe:	See ntb_db_is_unsafe().
  * @db_valid_mask:	See ntb_db_valid_mask().
  * @db_vector_count:	See ntb_db_vector_count().
@@ -210,22 +247,38 @@ static inline int ntb_ctx_ops_is_valid(const struct ntb_ctx_ops *ops)
  * @peer_spad_addr:	See ntb_peer_spad_addr().
  * @peer_spad_read:	See ntb_peer_spad_read().
  * @peer_spad_write:	See ntb_peer_spad_write().
+ * @msg_post:		See ntb_msg_post().
+ * @msg_size:		See ntb_msg_size().
  */
 struct ntb_dev_ops {
-	int (*mw_count)(struct ntb_dev *ntb);
-	int (*mw_get_range)(struct ntb_dev *ntb, int idx,
-			    phys_addr_t *base, resource_size_t *size,
-			resource_size_t *align, resource_size_t *align_size);
-	int (*mw_set_trans)(struct ntb_dev *ntb, int idx,
-			    dma_addr_t addr, resource_size_t size);
-	int (*mw_clear_trans)(struct ntb_dev *ntb, int idx);
-
 	int (*link_is_up)(struct ntb_dev *ntb,
 			  enum ntb_speed *speed, enum ntb_width *width);
 	int (*link_enable)(struct ntb_dev *ntb,
 			   enum ntb_speed max_speed, enum ntb_width max_width);
 	int (*link_disable)(struct ntb_dev *ntb);
 
+	int (*mw_count)(struct ntb_dev *ntb);
+	int (*mw_get_maprsc)(struct ntb_dev *ntb, int idx,
+			     phys_addr_t *base, resource_size_t *size);
+	int (*mw_get_align)(struct ntb_dev *ntb, int idx,
+			    resource_size_t *addr_align,
+			    resource_size_t *size_align,
+			    resource_size_t *size_max);
+	int (*mw_set_trans)(struct ntb_dev *ntb, int idx,
+			    dma_addr_t addr, resource_size_t size);
+	int (*mw_get_trans)(struct ntb_dev *ntb, int idx,
+			    dma_addr_t *addr, resource_size_t *size);
+
+	int (*peer_mw_count)(struct ntb_dev *ntb);
+	int (*peer_mw_get_align)(struct ntb_dev *ntb, int idx,
+				 resource_size_t *addr_align,
+				 resource_size_t *size_align,
+				 resource_size_t *size_max);
+	int (*peer_mw_set_trans)(struct ntb_dev *ntb, int idx,
+				 dma_addr_t addr, resource_size_t size);
+	int (*peer_mw_get_trans)(struct ntb_dev *ntb, int idx,
+				 dma_addr_t *addr, resource_size_t *size);
+
 	int (*db_is_unsafe)(struct ntb_dev *ntb);
 	u64 (*db_valid_mask)(struct ntb_dev *ntb);
 	int (*db_vector_count)(struct ntb_dev *ntb);
@@ -259,47 +312,10 @@ struct ntb_dev_ops {
 			      phys_addr_t *spad_addr);
 	u32 (*peer_spad_read)(struct ntb_dev *ntb, int idx);
 	int (*peer_spad_write)(struct ntb_dev *ntb, int idx, u32 val);
-};
-
-static inline int ntb_dev_ops_is_valid(const struct ntb_dev_ops *ops)
-{
-	/* commented callbacks are not required: */
-	return
-		ops->mw_count				&&
-		ops->mw_get_range			&&
-		ops->mw_set_trans			&&
-		/* ops->mw_clear_trans			&& */
-		ops->link_is_up				&&
-		ops->link_enable			&&
-		ops->link_disable			&&
-		/* ops->db_is_unsafe			&& */
-		ops->db_valid_mask			&&
 
-		/* both set, or both unset */
-		(!ops->db_vector_count == !ops->db_vector_mask) &&
-
-		ops->db_read				&&
-		/* ops->db_set				&& */
-		ops->db_clear				&&
-		/* ops->db_read_mask			&& */
-		ops->db_set_mask			&&
-		ops->db_clear_mask			&&
-		/* ops->peer_db_addr			&& */
-		/* ops->peer_db_read			&& */
-		ops->peer_db_set			&&
-		/* ops->peer_db_clear			&& */
-		/* ops->peer_db_read_mask		&& */
-		/* ops->peer_db_set_mask		&& */
-		/* ops->peer_db_clear_mask		&& */
-		/* ops->spad_is_unsafe			&& */
-		ops->spad_count				&&
-		ops->spad_read				&&
-		ops->spad_write				&&
-		/* ops->peer_spad_addr			&& */
-		/* ops->peer_spad_read			&& */
-		ops->peer_spad_write			&&
-		1;
-}
+	int (*msg_post)(struct ntb_dev *ntb, struct ntb_msg *msg);
+	int (*msg_size)(struct ntb_dev *ntb);
+};
 
 /**
  * struct ntb_client - client interested in ntb devices
@@ -310,10 +326,22 @@ struct ntb_client {
 	struct device_driver		drv;
 	const struct ntb_client_ops	ops;
 };
-
 #define drv_ntb_client(__drv) container_of((__drv), struct ntb_client, drv)
 
 /**
+ * struct ntb_bus_data - NTB bus data
+ * @sync_msk:	Synchroous devices mask
+ * @async_msk:	Asynchronous devices mask
+ * @both_msk:	Both sync and async devices mask
+ */
+#define NTB_MAX_DEVID (8*BITS_PER_LONG)
+struct ntb_bus_data {
+	unsigned long sync_msk[8];
+	unsigned long async_msk[8];
+	unsigned long both_msk[8];
+};
+
+/**
  * struct ntb_device - ntb device
  * @dev:		Linux device object.
  * @pdev:		Pci device entry of the ntb.
@@ -332,15 +360,151 @@ struct ntb_dev {
 
 	/* private: */
 
+	/* device id */
+	int id;
 	/* synchronize setting, clearing, and calling ctx_ops */
 	spinlock_t			ctx_lock;
 	/* block unregister until device is fully released */
 	struct completion		released;
 };
-
 #define dev_ntb(__dev) container_of((__dev), struct ntb_dev, dev)
 
 /**
+ * ntb_valid_sync_dev_ops() - valid operations for synchronous hardware setup
+ * @ntb:	NTB device
+ *
+ * There might be two types of NTB hardware differed by the way of the settings
+ * configuration. The synchronous chips allows to set the memory windows by
+ * directly writing to the peer registers. Additionally there can be shared
+ * Scratchpad registers for synchronous information exchange. Client drivers
+ * should call this function to make sure the hardware supports the proper
+ * functionality.
+ */
+static inline int ntb_valid_sync_dev_ops(const struct ntb_dev *ntb)
+{
+	const struct ntb_dev_ops *ops = ntb->ops;
+
+	/* Commented callbacks are not required, but might be developed */
+	return	/* NTB link status ops */
+		ops->link_is_up					&&
+		ops->link_enable				&&
+		ops->link_disable				&&
+
+		/* Synchronous memory windows ops */
+		ops->mw_count					&&
+		ops->mw_get_maprsc				&&
+		/* ops->mw_get_align				&& */
+		/* ops->mw_set_trans				&& */
+		/* ops->mw_get_trans				&& */
+		ops->peer_mw_count				&&
+		ops->peer_mw_get_align				&&
+		ops->peer_mw_set_trans				&&
+		/* ops->peer_mw_get_trans			&& */
+
+		/* Doorbell ops */
+		/* ops->db_is_unsafe				&& */
+		ops->db_valid_mask				&&
+		/* both set, or both unset */
+		(!ops->db_vector_count == !ops->db_vector_mask)	&&
+		ops->db_read					&&
+		/* ops->db_set					&& */
+		ops->db_clear					&&
+		/* ops->db_read_mask				&& */
+		ops->db_set_mask				&&
+		ops->db_clear_mask				&&
+		/* ops->peer_db_addr				&& */
+		/* ops->peer_db_read				&& */
+		ops->peer_db_set				&&
+		/* ops->peer_db_clear				&& */
+		/* ops->peer_db_read_mask			&& */
+		/* ops->peer_db_set_mask			&& */
+		/* ops->peer_db_clear_mask			&& */
+
+		/* Scratchpad ops */
+		/* ops->spad_is_unsafe				&& */
+		ops->spad_count					&&
+		ops->spad_read					&&
+		ops->spad_write					&&
+		/* ops->peer_spad_addr				&& */
+		/* ops->peer_spad_read				&& */
+		ops->peer_spad_write				&&
+
+		/* Messages IO ops */
+		/* ops->msg_post				&& */
+		/* ops->msg_size				&& */
+		1;
+}
+
+/**
+ * ntb_valid_async_dev_ops() - valid operations for asynchronous hardware setup
+ * @ntb:	NTB device
+ *
+ * There might be two types of NTB hardware differed by the way of the settings
+ * configuration. The asynchronous chips does not allow to set the memory
+ * windows by directly writing to the peer registers. Instead it implements
+ * the additional method to communinicate between NTB nodes like messages.
+ * Scratchpad registers aren't likely supported by such hardware. Client
+ * drivers should call this function to make sure the hardware supports
+ * the proper functionality.
+ */
+static inline int ntb_valid_async_dev_ops(const struct ntb_dev *ntb)
+{
+	const struct ntb_dev_ops *ops = ntb->ops;
+
+	/* Commented callbacks are not required, but might be developed */
+	return	/* NTB link status ops */
+		ops->link_is_up					&&
+		ops->link_enable				&&
+		ops->link_disable				&&
+
+		/* Asynchronous memory windows ops */
+		ops->mw_count					&&
+		ops->mw_get_maprsc				&&
+		ops->mw_get_align				&&
+		ops->mw_set_trans				&&
+		/* ops->mw_get_trans				&& */
+		ops->peer_mw_count				&&
+		ops->peer_mw_get_align				&&
+		/* ops->peer_mw_set_trans			&& */
+		/* ops->peer_mw_get_trans			&& */
+
+		/* Doorbell ops */
+		/* ops->db_is_unsafe				&& */
+		ops->db_valid_mask				&&
+		/* both set, or both unset */
+		(!ops->db_vector_count == !ops->db_vector_mask)	&&
+		ops->db_read					&&
+		/* ops->db_set					&& */
+		ops->db_clear					&&
+		/* ops->db_read_mask				&& */
+		ops->db_set_mask				&&
+		ops->db_clear_mask				&&
+		/* ops->peer_db_addr				&& */
+		/* ops->peer_db_read				&& */
+		ops->peer_db_set				&&
+		/* ops->peer_db_clear				&& */
+		/* ops->peer_db_read_mask			&& */
+		/* ops->peer_db_set_mask			&& */
+		/* ops->peer_db_clear_mask			&& */
+
+		/* Scratchpad ops */
+		/* ops->spad_is_unsafe				&& */
+		/* ops->spad_count				&& */
+		/* ops->spad_read				&& */
+		/* ops->spad_write				&& */
+		/* ops->peer_spad_addr				&& */
+		/* ops->peer_spad_read				&& */
+		/* ops->peer_spad_write				&& */
+
+		/* Messages IO ops */
+		ops->msg_post					&&
+		ops->msg_size					&&
+		1;
+}
+
+
+
+/**
  * ntb_register_client() - register a client for interest in ntb devices
  * @client:	Client context.
  *
@@ -441,10 +605,84 @@ void ntb_link_event(struct ntb_dev *ntb);
 void ntb_db_event(struct ntb_dev *ntb, int vector);
 
 /**
- * ntb_mw_count() - get the number of memory windows
+ * ntb_msg_event() - notify driver context of event in messaging subsystem
  * @ntb:	NTB device context.
+ * @ev:		Event type caused the handler invocation
+ * @msg:	Message related to the event
+ *
+ * Notify the driver context that there is some event happaned in the event
+ * subsystem. If NTB_MSG_NEW is emitted then the new message has just arrived.
+ * NTB_MSG_SENT is rised if some message has just been successfully sent to a
+ * peer. If a message failed to be sent then NTB_MSG_FAIL is emitted. The very
+ * last argument is used to pass the event related message. It discarded right
+ * after the handler returns.
+ */
+void ntb_msg_event(struct ntb_dev *ntb, enum NTB_MSG_EVENT ev,
+		   struct ntb_msg *msg);
+
+/**
+ * ntb_link_is_up() - get the current ntb link state
+ * @ntb:	NTB device context.
+ * @speed:	OUT - The link speed expressed as PCIe generation number.
+ * @width:	OUT - The link width expressed as the number of PCIe lanes.
+ *
+ * Get the current state of the ntb link.  It is recommended to query the link
+ * state once after every link event.  It is safe to query the link state in
+ * the context of the link event callback.
+ *
+ * Return: One if the link is up, zero if the link is down, otherwise a
+ *		negative value indicating the error number.
+ */
+static inline int ntb_link_is_up(struct ntb_dev *ntb,
+				 enum ntb_speed *speed, enum ntb_width *width)
+{
+	return ntb->ops->link_is_up(ntb, speed, width);
+}
+
+/**
+ * ntb_link_enable() - enable the link on the secondary side of the ntb
+ * @ntb:	NTB device context.
+ * @max_speed:	The maximum link speed expressed as PCIe generation number.
+ * @max_width:	The maximum link width expressed as the number of PCIe lanes.
  *
- * Hardware and topology may support a different number of memory windows.
+ * Enable the link on the secondary side of the ntb.  This can only be done
+ * from only one (primary or secondary) side of the ntb in primary or b2b
+ * topology.  The ntb device should train the link to its maximum speed and
+ * width, or the requested speed and width, whichever is smaller, if supported.
+ *
+ * Return: Zero on success, otherwise an error number.
+ */
+static inline int ntb_link_enable(struct ntb_dev *ntb,
+				  enum ntb_speed max_speed,
+				  enum ntb_width max_width)
+{
+	return ntb->ops->link_enable(ntb, max_speed, max_width);
+}
+
+/**
+ * ntb_link_disable() - disable the link on the secondary side of the ntb
+ * @ntb:	NTB device context.
+ *
+ * Disable the link on the secondary side of the ntb.  This can only be
+ * done from only one (primary or secondary) side of the ntb in primary or b2b
+ * topology.  The ntb device should disable the link.  Returning from this call
+ * must indicate that a barrier has passed, though with no more writes may pass
+ * in either direction across the link, except if this call returns an error
+ * number.
+ *
+ * Return: Zero on success, otherwise an error number.
+ */
+static inline int ntb_link_disable(struct ntb_dev *ntb)
+{
+	return ntb->ops->link_disable(ntb);
+}
+
+/**
+ * ntb_mw_count() - get the number of local memory windows
+ * @ntb:	NTB device context.
+ *
+ * Hardware and topology may support a different number of memory windows at
+ * local and remote devices
  *
  * Return: the number of memory windows.
  */
@@ -454,122 +692,186 @@ static inline int ntb_mw_count(struct ntb_dev *ntb)
 }
 
 /**
- * ntb_mw_get_range() - get the range of a memory window
+ * ntb_mw_get_maprsc() - get the range of a memory window to map
  * @ntb:	NTB device context.
  * @idx:	Memory window number.
  * @base:	OUT - the base address for mapping the memory window
  * @size:	OUT - the size for mapping the memory window
- * @align:	OUT - the base alignment for translating the memory window
- * @align_size:	OUT - the size alignment for translating the memory window
  *
- * Get the range of a memory window.  NULL may be given for any output
- * parameter if the value is not needed.  The base and size may be used for
- * mapping the memory window, to access the peer memory.  The alignment and
- * size may be used for translating the memory window, for the peer to access
- * memory on the local system.
+ * Get the map range of a memory window. The base and size may be used for
+ * mapping the memory window to access the peer memory.
  *
  * Return: Zero on success, otherwise an error number.
  */
-static inline int ntb_mw_get_range(struct ntb_dev *ntb, int idx,
-				   phys_addr_t *base, resource_size_t *size,
-		resource_size_t *align, resource_size_t *align_size)
+static inline int ntb_mw_get_maprsc(struct ntb_dev *ntb, int idx,
+				    phys_addr_t *base, resource_size_t *size)
 {
-	return ntb->ops->mw_get_range(ntb, idx, base, size,
-			align, align_size);
+	return ntb->ops->mw_get_maprsc(ntb, idx, base, size);
+}
+
+/**
+ * ntb_mw_get_align() - get memory window alignment of the local node
+ * @ntb:	NTB device context.
+ * @idx:	Memory window number.
+ * @addr_align:	OUT - the translated base address alignment of the memory window
+ * @size_align:	OUT - the translated memory size alignment of the memory window
+ * @size_max:	OUT - the translated memory maximum size
+ *
+ * Get the alignment parameters to allocate the proper memory window. NULL may
+ * be given for any output parameter if the value is not needed.
+ *
+ * Drivers of synchronous hardware don't have to support it.
+ *
+ * Return: Zero on success, otherwise an error number.
+ */
+static inline int ntb_mw_get_align(struct ntb_dev *ntb, int idx,
+				   resource_size_t *addr_align,
+				   resource_size_t *size_align,
+				   resource_size_t *size_max)
+{
+	if (!ntb->ops->mw_get_align)
+		return -EINVAL;
+
+	return ntb->ops->mw_get_align(ntb, idx, addr_align, size_align, size_max);
 }
 
 /**
- * ntb_mw_set_trans() - set the translation of a memory window
+ * ntb_mw_set_trans() - set the translated base address of a peer memory window
  * @ntb:	NTB device context.
  * @idx:	Memory window number.
- * @addr:	The dma address local memory to expose to the peer.
- * @size:	The size of the local memory to expose to the peer.
+ * @addr:	DMA memory address exposed by the peer.
+ * @size:	Size of the memory exposed by the peer.
+ *
+ * Set the translated base address of a memory window. The peer preliminary
+ * allocates a memory, then someway passes the address to the remote node, that
+ * finally sets up the memory window at the address, up to the size. The address
+ * and size must be aligned to the parameters specified by ntb_mw_get_align() of
+ * the local node and ntb_peer_mw_get_align() of the peer, which must return the
+ * same values. Zero size effectively disables the memory window.
  *
- * Set the translation of a memory window.  The peer may access local memory
- * through the window starting at the address, up to the size.  The address
- * must be aligned to the alignment specified by ntb_mw_get_range().  The size
- * must be aligned to the size alignment specified by ntb_mw_get_range().
+ * Drivers of synchronous hardware don't have to support it.
  *
  * Return: Zero on success, otherwise an error number.
  */
 static inline int ntb_mw_set_trans(struct ntb_dev *ntb, int idx,
 				   dma_addr_t addr, resource_size_t size)
 {
+	if (!ntb->ops->mw_set_trans)
+		return -EINVAL;
+
 	return ntb->ops->mw_set_trans(ntb, idx, addr, size);
 }
 
 /**
- * ntb_mw_clear_trans() - clear the translation of a memory window
+ * ntb_mw_get_trans() - get the translated base address of a memory window
  * @ntb:	NTB device context.
  * @idx:	Memory window number.
+ * @addr:	The dma memory address exposed by the peer.
+ * @size:	The size of the memory exposed by the peer.
  *
- * Clear the translation of a memory window.  The peer may no longer access
- * local memory through the window.
+ * Get the translated base address of a memory window spicified for the local
+ * hardware and allocated by the peer. If the addr and size are zero, the
+ * memory window is effectively disabled.
  *
  * Return: Zero on success, otherwise an error number.
  */
-static inline int ntb_mw_clear_trans(struct ntb_dev *ntb, int idx)
+static inline int ntb_mw_get_trans(struct ntb_dev *ntb, int idx,
+				   dma_addr_t *addr, resource_size_t *size)
 {
-	if (!ntb->ops->mw_clear_trans)
-		return ntb->ops->mw_set_trans(ntb, idx, 0, 0);
+	if (!ntb->ops->mw_get_trans)
+		return -EINVAL;
 
-	return ntb->ops->mw_clear_trans(ntb, idx);
+	return ntb->ops->mw_get_trans(ntb, idx, addr, size);
 }
 
 /**
- * ntb_link_is_up() - get the current ntb link state
+ * ntb_peer_mw_count() - get the number of peer memory windows
  * @ntb:	NTB device context.
- * @speed:	OUT - The link speed expressed as PCIe generation number.
- * @width:	OUT - The link width expressed as the number of PCIe lanes.
  *
- * Get the current state of the ntb link.  It is recommended to query the link
- * state once after every link event.  It is safe to query the link state in
- * the context of the link event callback.
+ * Hardware and topology may support a different number of memory windows at
+ * local and remote nodes.
  *
- * Return: One if the link is up, zero if the link is down, otherwise a
- *		negative value indicating the error number.
+ * Return: the number of memory windows.
  */
-static inline int ntb_link_is_up(struct ntb_dev *ntb,
-				 enum ntb_speed *speed, enum ntb_width *width)
+static inline int ntb_peer_mw_count(struct ntb_dev *ntb)
 {
-	return ntb->ops->link_is_up(ntb, speed, width);
+	return ntb->ops->peer_mw_count(ntb);
 }
 
 /**
- * ntb_link_enable() - enable the link on the secondary side of the ntb
+ * ntb_peer_mw_get_align() - get memory window alignment of the peer
  * @ntb:	NTB device context.
- * @max_speed:	The maximum link speed expressed as PCIe generation number.
- * @max_width:	The maximum link width expressed as the number of PCIe lanes.
+ * @idx:	Memory window number.
+ * @addr_align:	OUT - the translated base address alignment of the memory window
+ * @size_align:	OUT - the translated memory size alignment of the memory window
+ * @size_max:	OUT - the translated memory maximum size
  *
- * Enable the link on the secondary side of the ntb.  This can only be done
- * from the primary side of the ntb in primary or b2b topology.  The ntb device
- * should train the link to its maximum speed and width, or the requested speed
- * and width, whichever is smaller, if supported.
+ * Get the alignment parameters to allocate the proper memory window for the
+ * peer. NULL may be given for any output parameter if the value is not needed.
  *
  * Return: Zero on success, otherwise an error number.
  */
-static inline int ntb_link_enable(struct ntb_dev *ntb,
-				  enum ntb_speed max_speed,
-				  enum ntb_width max_width)
+static inline int ntb_peer_mw_get_align(struct ntb_dev *ntb, int idx,
+					resource_size_t *addr_align,
+					resource_size_t *size_align,
+					resource_size_t *size_max)
 {
-	return ntb->ops->link_enable(ntb, max_speed, max_width);
+	if (!ntb->ops->peer_mw_get_align)
+		return -EINVAL;
+
+	return ntb->ops->peer_mw_get_align(ntb, idx, addr_align, size_align,
+					   size_max);
 }
 
 /**
- * ntb_link_disable() - disable the link on the secondary side of the ntb
+ * ntb_peer_mw_set_trans() - set the translated base address of a peer
+ *			     memory window
  * @ntb:	NTB device context.
+ * @idx:	Memory window number.
+ * @addr:	Local DMA memory address exposed to the peer.
+ * @size:	Size of the memory exposed to the peer.
  *
- * Disable the link on the secondary side of the ntb.  This can only be
- * done from the primary side of the ntb in primary or b2b topology.  The ntb
- * device should disable the link.  Returning from this call must indicate that
- * a barrier has passed, though with no more writes may pass in either
- * direction across the link, except if this call returns an error number.
+ * Set the translated base address of a memory window exposed to the peer.
+ * The local node preliminary allocates the window, then directly writes the
+ * address and size to the peer control registers. The address and size must
+ * be aligned to the parameters specified by ntb_peer_mw_get_align() of
+ * the local node and ntb_mw_get_align() of the peer, which must return the
+ * same values. Zero size effectively disables the memory window.
+ *
+ * Drivers of synchronous hardware must support it.
  *
  * Return: Zero on success, otherwise an error number.
  */
-static inline int ntb_link_disable(struct ntb_dev *ntb)
+static inline int ntb_peer_mw_set_trans(struct ntb_dev *ntb, int idx,
+					dma_addr_t addr, resource_size_t size)
 {
-	return ntb->ops->link_disable(ntb);
+	if (!ntb->ops->peer_mw_set_trans)
+		return -EINVAL;
+
+	return ntb->ops->peer_mw_set_trans(ntb, idx, addr, size);
+}
+
+/**
+ * ntb_peer_mw_get_trans() - get the translated base address of a peer
+ *			     memory window
+ * @ntb:	NTB device context.
+ * @idx:	Memory window number.
+ * @addr:	Local dma memory address exposed to the peer.
+ * @size:	Size of the memory exposed to the peer.
+ *
+ * Get the translated base address of a memory window spicified for the peer
+ * hardware. If the addr and size are zero then the memory window is effectively
+ * disabled.
+ *
+ * Return: Zero on success, otherwise an error number.
+ */
+static inline int ntb_peer_mw_get_trans(struct ntb_dev *ntb, int idx,
+					dma_addr_t *addr, resource_size_t *size)
+{
+	if (!ntb->ops->peer_mw_get_trans)
+		return -EINVAL;
+
+	return ntb->ops->peer_mw_get_trans(ntb, idx, addr, size);
 }
 
 /**
@@ -751,6 +1053,8 @@ static inline int ntb_db_clear_mask(struct ntb_dev *ntb, u64 db_bits)
  * append one additional dma memory copy with the doorbell register as the
  * destination, after the memory copy operations.
  *
+ * This is unusual, and hardware may not be suitable to implement it.
+ *
  * Return: Zero on success, otherwise an error number.
  */
 static inline int ntb_peer_db_addr(struct ntb_dev *ntb,
@@ -901,10 +1205,15 @@ static inline int ntb_spad_is_unsafe(struct ntb_dev *ntb)
  *
  * Hardware and topology may support a different number of scratchpads.
  *
+ * Asynchronous hardware may not support it.
+ *
  * Return: the number of scratchpads.
  */
 static inline int ntb_spad_count(struct ntb_dev *ntb)
 {
+	if (!ntb->ops->spad_count)
+		return -EINVAL;
+
 	return ntb->ops->spad_count(ntb);
 }
 
@@ -915,10 +1224,15 @@ static inline int ntb_spad_count(struct ntb_dev *ntb)
  *
  * Read the local scratchpad register, and return the value.
  *
+ * Asynchronous hardware may not support it.
+ *
  * Return: The value of the local scratchpad register.
  */
 static inline u32 ntb_spad_read(struct ntb_dev *ntb, int idx)
 {
+	if (!ntb->ops->spad_read)
+		return 0;
+
 	return ntb->ops->spad_read(ntb, idx);
 }
 
@@ -930,10 +1244,15 @@ static inline u32 ntb_spad_read(struct ntb_dev *ntb, int idx)
  *
  * Write the value to the local scratchpad register.
  *
+ * Asynchronous hardware may not support it.
+ *
  * Return: Zero on success, otherwise an error number.
  */
 static inline int ntb_spad_write(struct ntb_dev *ntb, int idx, u32 val)
 {
+	if (!ntb->ops->spad_write)
+		return -EINVAL;
+
 	return ntb->ops->spad_write(ntb, idx, val);
 }
 
@@ -946,6 +1265,8 @@ static inline int ntb_spad_write(struct ntb_dev *ntb, int idx, u32 val)
  * Return the address of the peer doorbell register.  This may be used, for
  * example, by drivers that offload memory copy operations to a dma engine.
  *
+ * Asynchronous hardware may not support it.
+ *
  * Return: Zero on success, otherwise an error number.
  */
 static inline int ntb_peer_spad_addr(struct ntb_dev *ntb, int idx,
@@ -964,10 +1285,15 @@ static inline int ntb_peer_spad_addr(struct ntb_dev *ntb, int idx,
  *
  * Read the peer scratchpad register, and return the value.
  *
+ * Asynchronous hardware may not support it.
+ *
  * Return: The value of the local scratchpad register.
  */
 static inline u32 ntb_peer_spad_read(struct ntb_dev *ntb, int idx)
 {
+	if (!ntb->ops->peer_spad_read)
+		return 0;
+
 	return ntb->ops->peer_spad_read(ntb, idx);
 }
 
@@ -979,11 +1305,59 @@ static inline u32 ntb_peer_spad_read(struct ntb_dev *ntb, int idx)
  *
  * Write the value to the peer scratchpad register.
  *
+ * Asynchronous hardware may not support it.
+ *
  * Return: Zero on success, otherwise an error number.
  */
 static inline int ntb_peer_spad_write(struct ntb_dev *ntb, int idx, u32 val)
 {
+	if (!ntb->ops->peer_spad_write)
+		return -EINVAL;
+
 	return ntb->ops->peer_spad_write(ntb, idx, val);
 }
 
+/**
+ * ntb_msg_post() - post the message to the peer
+ * @ntb:	NTB device context.
+ * @msg:	Message
+ *
+ * Post the message to a peer. It shall be delivered to the peer by the
+ * corresponding hardware method. The peer should be notified about the new
+ * message by calling the ntb_msg_event() handler of NTB_MSG_NEW event type.
+ * If delivery is fails for some reasong the local node will get NTB_MSG_FAIL
+ * event. Otherwise the NTB_MSG_SENT is emitted.
+ *
+ * Synchronous hardware may not support it.
+ *
+ * Return: Zero on success, otherwise an error number.
+ */
+static inline int ntb_msg_post(struct ntb_dev *ntb, struct ntb_msg *msg)
+{
+	if (!ntb->ops->msg_post)
+		return -EINVAL;
+
+	return ntb->ops->msg_post(ntb, msg);
+}
+
+/**
+ * ntb_msg_size() - size of the message data
+ * @ntb:	NTB device context.
+ *
+ * Different hardware may support different number of message registers. This
+ * callback shall return the number of those used for data sending and
+ * receiving including the type field.
+ *
+ * Synchronous hardware may not support it.
+ *
+ * Return: Zero on success, otherwise an error number.
+ */
+static inline int ntb_msg_size(struct ntb_dev *ntb)
+{
+	if (!ntb->ops->msg_size)
+		return 0;
+
+	return ntb->ops->msg_size(ntb);
+}
+
 #endif
-- 
2.6.6

