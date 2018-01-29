Return-Path: <dave.jiang@intel.com>
Received: from mga09.intel.com (mga09.intel.com. [134.134.136.24])
        by gmr-mx.google.com with ESMTPS id n14si634222ith.1.2018.01.29.12.22.31
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jan 2018 12:22:31 -0800 (PST)
Subject: [PATCH 3/3] ntb: intel: change references of skx to gen3
From: Dave Jiang <dave.jiang@intel.com>
Date: Mon, 29 Jan 2018 13:22:30 -0700
Message-ID: <151725735051.65678.4803760718571397607.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <151725733854.65678.1151737836673124738.stgit@djiang5-desk3.ch.intel.com>
References: <151725733854.65678.1151737836673124738.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: allenbh@gmail.com, jdmason@kudzu.us
Cc: linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

Change all references to skx to gen3 NTB.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/ntb/hw/intel/ntb_hw_gen1.c  |   19 ++---
 drivers/ntb/hw/intel/ntb_hw_gen3.c  |  144 ++++++++++++++++++-----------------
 drivers/ntb/hw/intel/ntb_hw_gen3.h  |   89 +++++++++++-----------
 drivers/ntb/hw/intel/ntb_hw_intel.h |    4 -
 4 files changed, 126 insertions(+), 130 deletions(-)

diff --git a/drivers/ntb/hw/intel/ntb_hw_gen1.c b/drivers/ntb/hw/intel/ntb_hw_gen1.c
index f2554ac8afac..ffdee98e8ece 100644
--- a/drivers/ntb/hw/intel/ntb_hw_gen1.c
+++ b/drivers/ntb/hw/intel/ntb_hw_gen1.c
@@ -45,9 +45,6 @@
  *   OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
  * Intel PCIe NTB Linux driver
- *
- * Contact Information:
- * Jon Mason <jon.mason@intel.com>
  */
 
 #include <linux/debugfs.h>
@@ -651,7 +648,7 @@ static ssize_t ndev_ntb_debugfs_read(struct file *filp, char __user *ubuf,
 				 "LMT45 -\t\t\t%#018llx\n", u.v64);
 	}
 
-	if (pdev_is_xeon(pdev)) {
+	if (pdev_is_gen1(pdev)) {
 		if (ntb_topo_is_b2b(ndev->ntb.topo)) {
 			off += scnprintf(buf + off, buf_size - off,
 					 "\nNTB Outgoing B2B XLAT:\n");
@@ -763,9 +760,9 @@ static ssize_t ndev_debugfs_read(struct file *filp, char __user *ubuf,
 {
 	struct intel_ntb_dev *ndev = filp->private_data;
 
-	if (pdev_is_xeon(ndev->ntb.pdev))
+	if (pdev_is_gen1(ndev->ntb.pdev))
 		return ndev_ntb_debugfs_read(filp, ubuf, count, offp);
-	else if (pdev_is_skx_xeon(ndev->ntb.pdev))
+	else if (pdev_is_gen3(ndev->ntb.pdev))
 		return ndev_ntb3_debugfs_read(filp, ubuf, count, offp);
 
 	return -ENXIO;
@@ -1849,7 +1846,7 @@ static int intel_ntb_pci_probe(struct pci_dev *pdev,
 
 	node = dev_to_node(&pdev->dev);
 
-	if (pdev_is_xeon(pdev)) {
+	if (pdev_is_gen1(pdev)) {
 		ndev = kzalloc_node(sizeof(*ndev), GFP_KERNEL, node);
 		if (!ndev) {
 			rc = -ENOMEM;
@@ -1866,7 +1863,7 @@ static int intel_ntb_pci_probe(struct pci_dev *pdev,
 		if (rc)
 			goto err_init_dev;
 
-	} else if (pdev_is_skx_xeon(pdev)) {
+	} else if (pdev_is_gen3(pdev)) {
 		ndev = kzalloc_node(sizeof(*ndev), GFP_KERNEL, node);
 		if (!ndev) {
 			rc = -ENOMEM;
@@ -1880,7 +1877,7 @@ static int intel_ntb_pci_probe(struct pci_dev *pdev,
 		if (rc)
 			goto err_init_pci;
 
-		rc = skx_init_dev(ndev);
+		rc = gen3_init_dev(ndev);
 		if (rc)
 			goto err_init_dev;
 
@@ -1905,7 +1902,7 @@ static int intel_ntb_pci_probe(struct pci_dev *pdev,
 
 err_register:
 	ndev_deinit_debugfs(ndev);
-	if (pdev_is_xeon(pdev) || pdev_is_skx_xeon(pdev))
+	if (pdev_is_gen1(pdev) || pdev_is_gen3(pdev))
 		xeon_deinit_dev(ndev);
 err_init_dev:
 	intel_ntb_deinit_pci(ndev);
@@ -1921,7 +1918,7 @@ static void intel_ntb_pci_remove(struct pci_dev *pdev)
 
 	ntb_unregister_device(&ndev->ntb);
 	ndev_deinit_debugfs(ndev);
-	if (pdev_is_xeon(pdev) || pdev_is_skx_xeon(pdev))
+	if (pdev_is_gen1(pdev) || pdev_is_gen3(pdev))
 		xeon_deinit_dev(ndev);
 	intel_ntb_deinit_pci(ndev);
 	kfree(ndev);
diff --git a/drivers/ntb/hw/intel/ntb_hw_gen3.c b/drivers/ntb/hw/intel/ntb_hw_gen3.c
index 52cd8cdf7697..b3fa24778f94 100644
--- a/drivers/ntb/hw/intel/ntb_hw_gen3.c
+++ b/drivers/ntb/hw/intel/ntb_hw_gen3.c
@@ -40,10 +40,8 @@
  *   (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
  *   OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
- * Intel PCIe NTB Linux driver
+ * Intel PCIe GEN3 NTB Linux driver
  *
- * Contact Information:
- * Jon Mason <jon.mason@intel.com>
  */
 
 #include <linux/debugfs.h>
@@ -60,37 +58,39 @@
 #include "ntb_hw_gen1.h"
 #include "ntb_hw_gen3.h"
 
-static const struct intel_ntb_reg skx_reg = {
-	.poll_link		= skx_poll_link,
+static int gen3_poll_link(struct intel_ntb_dev *ndev);
+
+static const struct intel_ntb_reg gen3_reg = {
+	.poll_link		= gen3_poll_link,
 	.link_is_up		= xeon_link_is_up,
-	.db_ioread		= skx_db_ioread,
-	.db_iowrite		= skx_db_iowrite,
+	.db_ioread		= gen3_db_ioread,
+	.db_iowrite		= gen3_db_iowrite,
 	.db_size		= sizeof(u32),
-	.ntb_ctl		= SKX_NTBCNTL_OFFSET,
+	.ntb_ctl		= GEN3_NTBCNTL_OFFSET,
 	.mw_bar			= {2, 4},
 };
 
-static const struct intel_ntb_alt_reg skx_pri_reg = {
-	.db_bell		= SKX_EM_DOORBELL_OFFSET,
-	.db_clear		= SKX_IM_INT_STATUS_OFFSET,
-	.db_mask		= SKX_IM_INT_DISABLE_OFFSET,
-	.spad			= SKX_IM_SPAD_OFFSET,
+static const struct intel_ntb_alt_reg gen3_pri_reg = {
+	.db_bell		= GEN3_EM_DOORBELL_OFFSET,
+	.db_clear		= GEN3_IM_INT_STATUS_OFFSET,
+	.db_mask		= GEN3_IM_INT_DISABLE_OFFSET,
+	.spad			= GEN3_IM_SPAD_OFFSET,
 };
 
-static const struct intel_ntb_alt_reg skx_b2b_reg = {
-	.db_bell		= SKX_IM_DOORBELL_OFFSET,
-	.db_clear		= SKX_EM_INT_STATUS_OFFSET,
-	.db_mask		= SKX_EM_INT_DISABLE_OFFSET,
-	.spad			= SKX_B2B_SPAD_OFFSET,
+static const struct intel_ntb_alt_reg gen3_b2b_reg = {
+	.db_bell		= GEN3_IM_DOORBELL_OFFSET,
+	.db_clear		= GEN3_EM_INT_STATUS_OFFSET,
+	.db_mask		= GEN3_EM_INT_DISABLE_OFFSET,
+	.spad			= GEN3_B2B_SPAD_OFFSET,
 };
 
-static const struct intel_ntb_xlat_reg skx_sec_xlat = {
-/*	.bar0_base		= SKX_EMBAR0_OFFSET, */
-	.bar2_limit		= SKX_IMBAR1XLMT_OFFSET,
-	.bar2_xlat		= SKX_IMBAR1XBASE_OFFSET,
+static const struct intel_ntb_xlat_reg gen3_sec_xlat = {
+/*	.bar0_base		= GEN3_EMBAR0_OFFSET, */
+	.bar2_limit		= GEN3_IMBAR1XLMT_OFFSET,
+	.bar2_xlat		= GEN3_IMBAR1XBASE_OFFSET,
 };
 
-int skx_poll_link(struct intel_ntb_dev *ndev)
+static int gen3_poll_link(struct intel_ntb_dev *ndev)
 {
 	u16 reg_val;
 	int rc;
@@ -100,7 +100,7 @@ int skx_poll_link(struct intel_ntb_dev *ndev)
 			      ndev->self_reg->db_clear);
 
 	rc = pci_read_config_word(ndev->ntb.pdev,
-				  SKX_LINK_STATUS_OFFSET, &reg_val);
+				  GEN3_LINK_STATUS_OFFSET, &reg_val);
 	if (rc)
 		return 0;
 
@@ -112,7 +112,7 @@ int skx_poll_link(struct intel_ntb_dev *ndev)
 	return 1;
 }
 
-static int skx_init_isr(struct intel_ntb_dev *ndev)
+static int gen3_init_isr(struct intel_ntb_dev *ndev)
 {
 	int i;
 
@@ -123,23 +123,23 @@ static int skx_init_isr(struct intel_ntb_dev *ndev)
 	 * The vectors at reset is 1-32,0. We need to reprogram to 0-32.
 	 */
 
-	for (i = 0; i < SKX_DB_MSIX_VECTOR_COUNT; i++)
-		iowrite8(i, ndev->self_mmio + SKX_INTVEC_OFFSET + i);
+	for (i = 0; i < GEN3_DB_MSIX_VECTOR_COUNT; i++)
+		iowrite8(i, ndev->self_mmio + GEN3_INTVEC_OFFSET + i);
 
 	/* move link status down one as workaround */
 	if (ndev->hwerr_flags & NTB_HWERR_MSIX_VECTOR32_BAD) {
-		iowrite8(SKX_DB_MSIX_VECTOR_COUNT - 2,
-			 ndev->self_mmio + SKX_INTVEC_OFFSET +
-			 (SKX_DB_MSIX_VECTOR_COUNT - 1));
+		iowrite8(GEN3_DB_MSIX_VECTOR_COUNT - 2,
+			 ndev->self_mmio + GEN3_INTVEC_OFFSET +
+			 (GEN3_DB_MSIX_VECTOR_COUNT - 1));
 	}
 
-	return ndev_init_isr(ndev, SKX_DB_MSIX_VECTOR_COUNT,
-			     SKX_DB_MSIX_VECTOR_COUNT,
-			     SKX_DB_MSIX_VECTOR_SHIFT,
-			     SKX_DB_TOTAL_SHIFT);
+	return ndev_init_isr(ndev, GEN3_DB_MSIX_VECTOR_COUNT,
+			     GEN3_DB_MSIX_VECTOR_COUNT,
+			     GEN3_DB_MSIX_VECTOR_SHIFT,
+			     GEN3_DB_TOTAL_SHIFT);
 }
 
-static int skx_setup_b2b_mw(struct intel_ntb_dev *ndev,
+static int gen3_setup_b2b_mw(struct intel_ntb_dev *ndev,
 			    const struct intel_b2b_addr *addr,
 			    const struct intel_b2b_addr *peer_addr)
 {
@@ -152,33 +152,33 @@ static int skx_setup_b2b_mw(struct intel_ntb_dev *ndev,
 
 	/* setup incoming bar limits == base addrs (zero length windows) */
 	bar_addr = addr->bar2_addr64;
-	iowrite64(bar_addr, mmio + SKX_IMBAR1XLMT_OFFSET);
-	bar_addr = ioread64(mmio + SKX_IMBAR1XLMT_OFFSET);
+	iowrite64(bar_addr, mmio + GEN3_IMBAR1XLMT_OFFSET);
+	bar_addr = ioread64(mmio + GEN3_IMBAR1XLMT_OFFSET);
 	dev_dbg(&pdev->dev, "IMBAR1XLMT %#018llx\n", bar_addr);
 
 	bar_addr = addr->bar4_addr64;
-	iowrite64(bar_addr, mmio + SKX_IMBAR2XLMT_OFFSET);
-	bar_addr = ioread64(mmio + SKX_IMBAR2XLMT_OFFSET);
+	iowrite64(bar_addr, mmio + GEN3_IMBAR2XLMT_OFFSET);
+	bar_addr = ioread64(mmio + GEN3_IMBAR2XLMT_OFFSET);
 	dev_dbg(&pdev->dev, "IMBAR2XLMT %#018llx\n", bar_addr);
 
 	/* zero incoming translation addrs */
-	iowrite64(0, mmio + SKX_IMBAR1XBASE_OFFSET);
-	iowrite64(0, mmio + SKX_IMBAR2XBASE_OFFSET);
+	iowrite64(0, mmio + GEN3_IMBAR1XBASE_OFFSET);
+	iowrite64(0, mmio + GEN3_IMBAR2XBASE_OFFSET);
 
 	ndev->peer_mmio = ndev->self_mmio;
 
 	return 0;
 }
 
-static int skx_init_ntb(struct intel_ntb_dev *ndev)
+static int gen3_init_ntb(struct intel_ntb_dev *ndev)
 {
 	int rc;
 
 
 	ndev->mw_count = XEON_MW_COUNT;
-	ndev->spad_count = SKX_SPAD_COUNT;
-	ndev->db_count = SKX_DB_COUNT;
-	ndev->db_link_mask = SKX_DB_LINK_BIT;
+	ndev->spad_count = GEN3_SPAD_COUNT;
+	ndev->db_count = GEN3_DB_COUNT;
+	ndev->db_link_mask = GEN3_DB_LINK_BIT;
 
 	/* DB fixup for using 31 right now */
 	if (ndev->hwerr_flags & NTB_HWERR_MSIX_VECTOR32_BAD)
@@ -187,16 +187,16 @@ static int skx_init_ntb(struct intel_ntb_dev *ndev)
 	switch (ndev->ntb.topo) {
 	case NTB_TOPO_B2B_USD:
 	case NTB_TOPO_B2B_DSD:
-		ndev->self_reg = &skx_pri_reg;
-		ndev->peer_reg = &skx_b2b_reg;
-		ndev->xlat_reg = &skx_sec_xlat;
+		ndev->self_reg = &gen3_pri_reg;
+		ndev->peer_reg = &gen3_b2b_reg;
+		ndev->xlat_reg = &gen3_sec_xlat;
 
 		if (ndev->ntb.topo == NTB_TOPO_B2B_USD) {
-			rc = skx_setup_b2b_mw(ndev,
+			rc = gen3_setup_b2b_mw(ndev,
 					      &xeon_b2b_dsd_addr,
 					      &xeon_b2b_usd_addr);
 		} else {
-			rc = skx_setup_b2b_mw(ndev,
+			rc = gen3_setup_b2b_mw(ndev,
 					      &xeon_b2b_usd_addr,
 					      &xeon_b2b_dsd_addr);
 		}
@@ -206,7 +206,7 @@ static int skx_init_ntb(struct intel_ntb_dev *ndev)
 
 		/* Enable Bus Master and Memory Space on the secondary side */
 		iowrite16(PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER,
-			  ndev->self_mmio + SKX_SPCICMD_OFFSET);
+			  ndev->self_mmio + GEN3_SPCICMD_OFFSET);
 
 		break;
 
@@ -223,7 +223,7 @@ static int skx_init_ntb(struct intel_ntb_dev *ndev)
 	return 0;
 }
 
-int skx_init_dev(struct intel_ntb_dev *ndev)
+int gen3_init_dev(struct intel_ntb_dev *ndev)
 {
 	struct pci_dev *pdev;
 	u8 ppd;
@@ -231,7 +231,7 @@ int skx_init_dev(struct intel_ntb_dev *ndev)
 
 	pdev = ndev->ntb.pdev;
 
-	ndev->reg = &skx_reg;
+	ndev->reg = &gen3_reg;
 
 	rc = pci_read_config_byte(pdev, XEON_PPD_OFFSET, &ppd);
 	if (rc)
@@ -245,11 +245,11 @@ int skx_init_dev(struct intel_ntb_dev *ndev)
 
 	ndev->hwerr_flags |= NTB_HWERR_MSIX_VECTOR32_BAD;
 
-	rc = skx_init_ntb(ndev);
+	rc = gen3_init_ntb(ndev);
 	if (rc)
 		return rc;
 
-	return skx_init_isr(ndev);
+	return gen3_init_isr(ndev);
 }
 
 ssize_t ndev_ntb3_debugfs_read(struct file *filp, char __user *ubuf,
@@ -328,19 +328,19 @@ ssize_t ndev_ntb3_debugfs_read(struct file *filp, char __user *ubuf,
 	off += scnprintf(buf + off, buf_size - off,
 			 "\nNTB Incoming XLAT:\n");
 
-	u.v64 = ioread64(mmio + SKX_IMBAR1XBASE_OFFSET);
+	u.v64 = ioread64(mmio + GEN3_IMBAR1XBASE_OFFSET);
 	off += scnprintf(buf + off, buf_size - off,
 			 "IMBAR1XBASE -\t\t%#018llx\n", u.v64);
 
-	u.v64 = ioread64(mmio + SKX_IMBAR2XBASE_OFFSET);
+	u.v64 = ioread64(mmio + GEN3_IMBAR2XBASE_OFFSET);
 	off += scnprintf(buf + off, buf_size - off,
 			 "IMBAR2XBASE -\t\t%#018llx\n", u.v64);
 
-	u.v64 = ioread64(mmio + SKX_IMBAR1XLMT_OFFSET);
+	u.v64 = ioread64(mmio + GEN3_IMBAR1XLMT_OFFSET);
 	off += scnprintf(buf + off, buf_size - off,
 			 "IMBAR1XLMT -\t\t\t%#018llx\n", u.v64);
 
-	u.v64 = ioread64(mmio + SKX_IMBAR2XLMT_OFFSET);
+	u.v64 = ioread64(mmio + GEN3_IMBAR2XLMT_OFFSET);
 	off += scnprintf(buf + off, buf_size - off,
 			 "IMBAR2XLMT -\t\t\t%#018llx\n", u.v64);
 
@@ -348,34 +348,34 @@ ssize_t ndev_ntb3_debugfs_read(struct file *filp, char __user *ubuf,
 		off += scnprintf(buf + off, buf_size - off,
 				 "\nNTB Outgoing B2B XLAT:\n");
 
-		u.v64 = ioread64(mmio + SKX_EMBAR1XBASE_OFFSET);
+		u.v64 = ioread64(mmio + GEN3_EMBAR1XBASE_OFFSET);
 		off += scnprintf(buf + off, buf_size - off,
 				 "EMBAR1XBASE -\t\t%#018llx\n", u.v64);
 
-		u.v64 = ioread64(mmio + SKX_EMBAR2XBASE_OFFSET);
+		u.v64 = ioread64(mmio + GEN3_EMBAR2XBASE_OFFSET);
 		off += scnprintf(buf + off, buf_size - off,
 				 "EMBAR2XBASE -\t\t%#018llx\n", u.v64);
 
-		u.v64 = ioread64(mmio + SKX_EMBAR1XLMT_OFFSET);
+		u.v64 = ioread64(mmio + GEN3_EMBAR1XLMT_OFFSET);
 		off += scnprintf(buf + off, buf_size - off,
 				 "EMBAR1XLMT -\t\t%#018llx\n", u.v64);
 
-		u.v64 = ioread64(mmio + SKX_EMBAR2XLMT_OFFSET);
+		u.v64 = ioread64(mmio + GEN3_EMBAR2XLMT_OFFSET);
 		off += scnprintf(buf + off, buf_size - off,
 				 "EMBAR2XLMT -\t\t%#018llx\n", u.v64);
 
 		off += scnprintf(buf + off, buf_size - off,
 				 "\nNTB Secondary BAR:\n");
 
-		u.v64 = ioread64(mmio + SKX_EMBAR0_OFFSET);
+		u.v64 = ioread64(mmio + GEN3_EMBAR0_OFFSET);
 		off += scnprintf(buf + off, buf_size - off,
 				 "EMBAR0 -\t\t%#018llx\n", u.v64);
 
-		u.v64 = ioread64(mmio + SKX_EMBAR1_OFFSET);
+		u.v64 = ioread64(mmio + GEN3_EMBAR1_OFFSET);
 		off += scnprintf(buf + off, buf_size - off,
 				 "EMBAR1 -\t\t%#018llx\n", u.v64);
 
-		u.v64 = ioread64(mmio + SKX_EMBAR2_OFFSET);
+		u.v64 = ioread64(mmio + GEN3_EMBAR2_OFFSET);
 		off += scnprintf(buf + off, buf_size - off,
 				 "EMBAR2 -\t\t%#018llx\n", u.v64);
 	}
@@ -383,7 +383,7 @@ ssize_t ndev_ntb3_debugfs_read(struct file *filp, char __user *ubuf,
 	off += scnprintf(buf + off, buf_size - off,
 			 "\nNTB Statistics:\n");
 
-	u.v16 = ioread16(mmio + SKX_USMEMMISS_OFFSET);
+	u.v16 = ioread16(mmio + GEN3_USMEMMISS_OFFSET);
 	off += scnprintf(buf + off, buf_size - off,
 			 "Upstream Memory Miss -\t%u\n", u.v16);
 
@@ -391,22 +391,22 @@ ssize_t ndev_ntb3_debugfs_read(struct file *filp, char __user *ubuf,
 			 "\nNTB Hardware Errors:\n");
 
 	if (!pci_read_config_word(ndev->ntb.pdev,
-				  SKX_DEVSTS_OFFSET, &u.v16))
+				  GEN3_DEVSTS_OFFSET, &u.v16))
 		off += scnprintf(buf + off, buf_size - off,
 				 "DEVSTS -\t\t%#06x\n", u.v16);
 
 	if (!pci_read_config_word(ndev->ntb.pdev,
-				  SKX_LINK_STATUS_OFFSET, &u.v16))
+				  GEN3_LINK_STATUS_OFFSET, &u.v16))
 		off += scnprintf(buf + off, buf_size - off,
 				 "LNKSTS -\t\t%#06x\n", u.v16);
 
 	if (!pci_read_config_dword(ndev->ntb.pdev,
-				   SKX_UNCERRSTS_OFFSET, &u.v32))
+				   GEN3_UNCERRSTS_OFFSET, &u.v32))
 		off += scnprintf(buf + off, buf_size - off,
 				 "UNCERRSTS -\t\t%#06x\n", u.v32);
 
 	if (!pci_read_config_dword(ndev->ntb.pdev,
-				   SKX_CORERRSTS_OFFSET, &u.v32))
+				   GEN3_CORERRSTS_OFFSET, &u.v32))
 		off += scnprintf(buf + off, buf_size - off,
 				 "CORERRSTS -\t\t%#06x\n", u.v32);
 
@@ -510,7 +510,7 @@ static int intel_ntb3_mw_set_trans(struct ntb_dev *ntb, int pidx, int idx,
 
 	/* setup the EP */
 	limit_reg = ndev->xlat_reg->bar2_limit + (idx * 0x10) + 0x4000;
-	base = ioread64(mmio + SKX_EMBAR1_OFFSET + (8 * idx));
+	base = ioread64(mmio + GEN3_EMBAR1_OFFSET + (8 * idx));
 	base &= ~0xf;
 
 	if (limit_reg && size != mw_size)
diff --git a/drivers/ntb/hw/intel/ntb_hw_gen3.h b/drivers/ntb/hw/intel/ntb_hw_gen3.h
index 09fd1d3e6b5b..75fb86ca27bb 100644
--- a/drivers/ntb/hw/intel/ntb_hw_gen3.h
+++ b/drivers/ntb/hw/intel/ntb_hw_gen3.h
@@ -47,64 +47,63 @@
 #include "ntb_hw_intel.h"
 
 /* Intel Skylake Xeon hardware */
-#define SKX_IMBAR1SZ_OFFSET		0x00d0
-#define SKX_IMBAR2SZ_OFFSET		0x00d1
-#define SKX_EMBAR1SZ_OFFSET		0x00d2
-#define SKX_EMBAR2SZ_OFFSET		0x00d3
-#define SKX_DEVCTRL_OFFSET		0x0098
-#define SKX_DEVSTS_OFFSET		0x009a
-#define SKX_UNCERRSTS_OFFSET		0x014c
-#define SKX_CORERRSTS_OFFSET		0x0158
-#define SKX_LINK_STATUS_OFFSET		0x01a2
+#define GEN3_IMBAR1SZ_OFFSET		0x00d0
+#define GEN3_IMBAR2SZ_OFFSET		0x00d1
+#define GEN3_EMBAR1SZ_OFFSET		0x00d2
+#define GEN3_EMBAR2SZ_OFFSET		0x00d3
+#define GEN3_DEVCTRL_OFFSET		0x0098
+#define GEN3_DEVSTS_OFFSET		0x009a
+#define GEN3_UNCERRSTS_OFFSET		0x014c
+#define GEN3_CORERRSTS_OFFSET		0x0158
+#define GEN3_LINK_STATUS_OFFSET		0x01a2
 
-#define SKX_NTBCNTL_OFFSET		0x0000
-#define SKX_IMBAR1XBASE_OFFSET		0x0010		/* SBAR2XLAT */
-#define SKX_IMBAR1XLMT_OFFSET		0x0018		/* SBAR2LMT */
-#define SKX_IMBAR2XBASE_OFFSET		0x0020		/* SBAR4XLAT */
-#define SKX_IMBAR2XLMT_OFFSET		0x0028		/* SBAR4LMT */
-#define SKX_IM_INT_STATUS_OFFSET	0x0040
-#define SKX_IM_INT_DISABLE_OFFSET	0x0048
-#define SKX_IM_SPAD_OFFSET		0x0080		/* SPAD */
-#define SKX_USMEMMISS_OFFSET		0x0070
-#define SKX_INTVEC_OFFSET		0x00d0
-#define SKX_IM_DOORBELL_OFFSET		0x0100		/* SDOORBELL0 */
-#define SKX_B2B_SPAD_OFFSET		0x0180		/* B2B SPAD */
-#define SKX_EMBAR0XBASE_OFFSET		0x4008		/* B2B_XLAT */
-#define SKX_EMBAR1XBASE_OFFSET		0x4010		/* PBAR2XLAT */
-#define SKX_EMBAR1XLMT_OFFSET		0x4018		/* PBAR2LMT */
-#define SKX_EMBAR2XBASE_OFFSET		0x4020		/* PBAR4XLAT */
-#define SKX_EMBAR2XLMT_OFFSET		0x4028		/* PBAR4LMT */
-#define SKX_EM_INT_STATUS_OFFSET	0x4040
-#define SKX_EM_INT_DISABLE_OFFSET	0x4048
-#define SKX_EM_SPAD_OFFSET		0x4080		/* remote SPAD */
-#define SKX_EM_DOORBELL_OFFSET		0x4100		/* PDOORBELL0 */
-#define SKX_SPCICMD_OFFSET		0x4504		/* SPCICMD */
-#define SKX_EMBAR0_OFFSET		0x4510		/* SBAR0BASE */
-#define SKX_EMBAR1_OFFSET		0x4518		/* SBAR23BASE */
-#define SKX_EMBAR2_OFFSET		0x4520		/* SBAR45BASE */
+#define GEN3_NTBCNTL_OFFSET		0x0000
+#define GEN3_IMBAR1XBASE_OFFSET		0x0010		/* SBAR2XLAT */
+#define GEN3_IMBAR1XLMT_OFFSET		0x0018		/* SBAR2LMT */
+#define GEN3_IMBAR2XBASE_OFFSET		0x0020		/* SBAR4XLAT */
+#define GEN3_IMBAR2XLMT_OFFSET		0x0028		/* SBAR4LMT */
+#define GEN3_IM_INT_STATUS_OFFSET	0x0040
+#define GEN3_IM_INT_DISABLE_OFFSET	0x0048
+#define GEN3_IM_SPAD_OFFSET		0x0080		/* SPAD */
+#define GEN3_USMEMMISS_OFFSET		0x0070
+#define GEN3_INTVEC_OFFSET		0x00d0
+#define GEN3_IM_DOORBELL_OFFSET		0x0100		/* SDOORBELL0 */
+#define GEN3_B2B_SPAD_OFFSET		0x0180		/* B2B SPAD */
+#define GEN3_EMBAR0XBASE_OFFSET		0x4008		/* B2B_XLAT */
+#define GEN3_EMBAR1XBASE_OFFSET		0x4010		/* PBAR2XLAT */
+#define GEN3_EMBAR1XLMT_OFFSET		0x4018		/* PBAR2LMT */
+#define GEN3_EMBAR2XBASE_OFFSET		0x4020		/* PBAR4XLAT */
+#define GEN3_EMBAR2XLMT_OFFSET		0x4028		/* PBAR4LMT */
+#define GEN3_EM_INT_STATUS_OFFSET	0x4040
+#define GEN3_EM_INT_DISABLE_OFFSET	0x4048
+#define GEN3_EM_SPAD_OFFSET		0x4080		/* remote SPAD */
+#define GEN3_EM_DOORBELL_OFFSET		0x4100		/* PDOORBELL0 */
+#define GEN3_SPCICMD_OFFSET		0x4504		/* SPCICMD */
+#define GEN3_EMBAR0_OFFSET		0x4510		/* SBAR0BASE */
+#define GEN3_EMBAR1_OFFSET		0x4518		/* SBAR23BASE */
+#define GEN3_EMBAR2_OFFSET		0x4520		/* SBAR45BASE */
 
-#define SKX_DB_COUNT			32
-#define SKX_DB_LINK			32
-#define SKX_DB_LINK_BIT			BIT_ULL(SKX_DB_LINK)
-#define SKX_DB_MSIX_VECTOR_COUNT	33
-#define SKX_DB_MSIX_VECTOR_SHIFT	1
-#define SKX_DB_TOTAL_SHIFT		33
-#define SKX_SPAD_COUNT			16
+#define GEN3_DB_COUNT			32
+#define GEN3_DB_LINK			32
+#define GEN3_DB_LINK_BIT		BIT_ULL(GEN3_DB_LINK)
+#define GEN3_DB_MSIX_VECTOR_COUNT	33
+#define GEN3_DB_MSIX_VECTOR_SHIFT	1
+#define GEN3_DB_TOTAL_SHIFT		33
+#define GEN3_SPAD_COUNT			16
 
-static inline u64 skx_db_ioread(void __iomem *mmio)
+static inline u64 gen3_db_ioread(void __iomem *mmio)
 {
 	return ioread64(mmio);
 }
 
-static inline void skx_db_iowrite(u64 bits, void __iomem *mmio)
+static inline void gen3_db_iowrite(u64 bits, void __iomem *mmio)
 {
 	iowrite64(bits, mmio);
 }
 
 ssize_t ndev_ntb3_debugfs_read(struct file *filp, char __user *ubuf,
 				      size_t count, loff_t *offp);
-int skx_init_dev(struct intel_ntb_dev *ndev);
-int skx_poll_link(struct intel_ntb_dev *ndev);
+int gen3_init_dev(struct intel_ntb_dev *ndev);
 
 extern const struct ntb_dev_ops intel_ntb3_ops;
 
diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.h b/drivers/ntb/hw/intel/ntb_hw_intel.h
index 46d757c3850e..c49ff8970ce3 100644
--- a/drivers/ntb/hw/intel/ntb_hw_intel.h
+++ b/drivers/ntb/hw/intel/ntb_hw_intel.h
@@ -187,7 +187,7 @@ struct intel_ntb_dev {
 #define hb_ndev(__work) container_of(__work, struct intel_ntb_dev, \
 				     hb_timer.work)
 
-static inline int pdev_is_xeon(struct pci_dev *pdev)
+static inline int pdev_is_gen1(struct pci_dev *pdev)
 {
 	switch (pdev->device) {
 	case PCI_DEVICE_ID_INTEL_NTB_SS_JSF:
@@ -210,7 +210,7 @@ static inline int pdev_is_xeon(struct pci_dev *pdev)
 	return 0;
 }
 
-static inline int pdev_is_skx_xeon(struct pci_dev *pdev)
+static inline int pdev_is_gen3(struct pci_dev *pdev)
 {
 	if (pdev->device == PCI_DEVICE_ID_INTEL_NTB_B2B_SKX)
 		return 1;

