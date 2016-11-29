Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf0-x243.google.com (mail-lf0-x243.google.com. [2a00:1450:4010:c07::243])
        by gmr-mx.google.com with ESMTPS id s81si354714wmf.3.2016.11.29.09.15.58
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Nov 2016 09:15:58 -0800 (PST)
Received: by mail-lf0-x243.google.com with SMTP id 98so13272887lfs.0
        for <linux-ntb@googlegroups.com>; Tue, 29 Nov 2016 09:15:58 -0800 (PST)
Return-Path: <fancer.lancer@gmail.com>
From: Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH 03/22] NTB: Alter NTB API to support both inbound and outbound MW based interfaces
Date: Tue, 29 Nov 2016 20:15:58 +0300
Message-Id: <1480439777-1080-4-git-send-email-fancer.lancer@gmail.com>
In-Reply-To: <1480439777-1080-1-git-send-email-fancer.lancer@gmail.com>
References: <1480439777-1080-1-git-send-email-fancer.lancer@gmail.com>
To: jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com, Xiangliang.Yu@amd.com
Cc: Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

Alter NTB API to support inbound and outbound MW based interfaces.
Additionally I made it supporting multi-port devices as well. Useful
infographics is added right before MW API is declared. It shall help to
better understand how the new API really works and how it can be utilized
within client drivers.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---
 include/linux/ntb.h | 290 ++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 245 insertions(+), 45 deletions(-)

diff --git a/include/linux/ntb.h b/include/linux/ntb.h
index 0941a43..4a150b5 100644
--- a/include/linux/ntb.h
+++ b/include/linux/ntb.h
@@ -171,9 +171,13 @@ static inline int ntb_ctx_ops_is_valid(const struct ntb_ctx_ops *ops)
  * @link_enable:	See ntb_link_enable().
  * @link_disable:	See ntb_link_disable().
  * @mw_count:		See ntb_mw_count().
- * @mw_get_range:	See ntb_mw_get_range().
+ * @mw_get_align:	See ntb_mw_get_align().
  * @mw_set_trans:	See ntb_mw_set_trans().
  * @mw_clear_trans:	See ntb_mw_clear_trans().
+ * @peer_mw_count:	See ntb_peer_mw_count().
+ * @peer_mw_get_addr:	See ntb_peer_mw_get_addr().
+ * @peer_mw_set_trans:	See ntb_peer_mw_set_trans().
+ * @peer_mw_clear_trans:See ntb_peer_mw_clear_trans().
  * @db_is_unsafe:	See ntb_db_is_unsafe().
  * @db_valid_mask:	See ntb_db_valid_mask().
  * @db_vector_count:	See ntb_db_vector_count().
@@ -211,13 +215,20 @@ struct ntb_dev_ops {
 			   enum ntb_speed max_speed, enum ntb_width max_width);
 	int (*link_disable)(struct ntb_dev *ntb);
 
-	int (*mw_count)(struct ntb_dev *ntb);
-	int (*mw_get_range)(struct ntb_dev *ntb, int idx,
-			    phys_addr_t *base, resource_size_t *size,
-			resource_size_t *align, resource_size_t *align_size);
-	int (*mw_set_trans)(struct ntb_dev *ntb, int idx,
+	int (*mw_count)(struct ntb_dev *ntb, int pidx);
+	int (*mw_get_align)(struct ntb_dev *ntb, int pidx, int widx,
+			    resource_size_t *addr_align,
+			    resource_size_t *size_align,
+			    resource_size_t *size_max);
+	int (*mw_set_trans)(struct ntb_dev *ntb, int pidx, int widx,
 			    dma_addr_t addr, resource_size_t size);
-	int (*mw_clear_trans)(struct ntb_dev *ntb, int idx);
+	int (*mw_clear_trans)(struct ntb_dev *ntb, int pidx, int widx);
+	int (*peer_mw_count)(struct ntb_dev *ntb);
+	int (*peer_mw_get_addr)(struct ntb_dev *ntb, int widx,
+				phys_addr_t *base, resource_size_t *size);
+	int (*peer_mw_set_trans)(struct ntb_dev *ntb, int pidx, int widx,
+				 u64 addr, resource_size_t size);
+	int (*peer_mw_clear_trans)(struct ntb_dev *ntb, int pidx, int widx);
 
 	int (*db_is_unsafe)(struct ntb_dev *ntb);
 	u64 (*db_valid_mask)(struct ntb_dev *ntb);
@@ -266,9 +277,13 @@ static inline int ntb_dev_ops_is_valid(const struct ntb_dev_ops *ops)
 		ops->link_enable			&&
 		ops->link_disable			&&
 		ops->mw_count				&&
-		ops->mw_get_range			&&
-		ops->mw_set_trans			&&
+		ops->mw_get_align			&&
+		(ops->mw_set_trans			||
+		 ops->peer_mw_set_trans)		&&
 		/* ops->mw_clear_trans			&& */
+		ops->peer_mw_count			&&
+		ops->peer_mw_get_addr			&&
+		/* ops->peer_mw_clear_trans		&& */
 
 		/* ops->db_is_unsafe			&& */
 		ops->db_valid_mask			&&
@@ -555,79 +570,264 @@ static inline int ntb_link_disable(struct ntb_dev *ntb)
 }
 
 /**
- * ntb_mw_count() - get the number of memory windows
+ *                   NTB Memory Windows description
+ *
+ * There are two types of memory window interfaces supported by the NTB API:
+ * local and peer side initialization of memory sharing. The first type is
+ * depicted on the next figure:
+ *
+ *  Local device:                         | Peer device:
+ *                           NTB config   |
+ * Physical memory (RAM)     __________   |             Memory mapped IO
+ *   ____________       +-->|   addr   |  |              _____________
+ *  |            |      |   |----------|  |             |             |
+ *  |------------|addr--+                 |             |-------------|
+ *  | Inbound MW |            PCI Express + NTB         | Outbound MW |
+ *  |            |<=====================================|             |
+ *  |------------|                                      |-------------|
+ *
+ * So typical scenario of the first type memory window initialization looks:
+ * 1) allocate a memory region, 2) put translated base address to NTB config,
+ * 3) somehow notify a peer device of performed initialization, 4) peer device
+ * maps corresponding outbound memory window so to have access to the shared
+ * memory region.
+ *
+ * The second type of interface, that implies the shared windows being
+ * initialized by a peer device, is depicted on the figure:
+ *
+ *  Local device:          | Peer device:
+ *                         |              NTB config
+ * Physical memory (RAM)   |              __________    Memory mapped IO
+ *   ____________        +-------------->|   addr   |    _____________
+ *  |            |       | |             |----------|   |             |
+ *  |------------|addr---+ |                            |-------------|
+ *  | Inbound MW |            PCI Express + NTB         | Outbound MW |
+ *  |            |<=====================================|             |
+ *  |------------|                                      |-------------|
+ *
+ * Typical scenario of the second type initialization would be:
+ * 1) allocate a memory region, 2) somehow deliver a translated base address
+ * to a peer device, 3) peer puts the translated base address to NTB config,
+ * 4) peer device maps outbound memory window so to have access to the shared
+ * memory region.
+ *
+ * As one can see the described scenarios can be combined in one portable
+ * algorithm.
+ *   Local device:
+ *     1) Allocate memory for a shared window
+ *     2) Initialize memory window by base address of the allocated region
+ *        (it may fail if local memory window initialzation is unsupported)
+ *     3) Send translated base address and memory window index to a peer device
+ *   Peer device:
+ *     1) Initialize memory window by retrieved base address of the allocated
+ *        by another device memory region (it may fail if peer memory window
+ *        initialization is unsupported)
+ *     2) Map outbound memory window
+ *     3) Done
+ * In accordance with this scenario, the NTB Memory Window API can be used as
+ * follows:
+ *  Local device:
+ *     1) ntb_mw_count(pidx) - retrieve number of memory ranges, which can
+ *        be allocated for memory windows between local device and peer device
+ *        of port with specified index.
+ *     2) ntb_get_align(pidx, midx) - retrieve parameters restricting the
+ *        shared memory region alignment and size. Then memory can be properly
+ *        allocated.
+ *     3) Allocate physically contiguous memory region in complience with
+ *        restrictions retrieved in 2).
+ *     4) ntb_mw_set_trans(pidx, midx) - try to set translation address of
+ *        the memory window with specified index for the defined peer device
+ *        (it may fail if local translated address setting is not supported)
+ *     5) Send translated base address (usually together with memory window
+ *        number) to the peer device using, for instance, scratchpad or message
+ *        registers.
+ *  Peer device:
+ *     1) ntb_peer_mw_set_trans(pidx, midx) - try to set received from other
+ *        device (related to pidx) translated base address for specified memory
+ *        window. It may fail if retrieved address, for instance, exceeds
+ *        maximum possible address or isn't properly aligned.
+ *     2) ntb_peer_mw_get_addr(widx) - retrieve MMIO address to map the memory
+ *        window so to have an access to the shared memory.
+ *
+ *  Also it is worth to note, that method ntb_mw_count(pidx) should return the
+ *  same value as ntb_peer_mw_count() of the peer with port index - pidx.
+ */
+
+/**
+ * ntb_mw_count() - get the number of inbound memory windows, which could
+ *                  be created for a specified peer device
  * @ntb:	NTB device context.
+ * @pidx:	Port index of peer device.
  *
  * Hardware and topology may support a different number of memory windows.
+ * Moreover different peer devices can support different number of memory
+ * windows. Simply speaking this method returns the number of possible inbound
+ * memory windows to share with specified peer device.
  *
  * Return: the number of memory windows.
  */
-static inline int ntb_mw_count(struct ntb_dev *ntb)
+static inline int ntb_mw_count(struct ntb_dev *ntb, int pidx)
 {
-	return ntb->ops->mw_count(ntb);
+	return ntb->ops->mw_count(ntb, pidx);
 }
 
 /**
- * ntb_mw_get_range() - get the range of a memory window
+ * ntb_mw_get_align() - get the restriction parameters of inbound memory window
  * @ntb:	NTB device context.
- * @idx:	Memory window number.
- * @base:	OUT - the base address for mapping the memory window
- * @size:	OUT - the size for mapping the memory window
- * @align:	OUT - the base alignment for translating the memory window
- * @align_size:	OUT - the size alignment for translating the memory window
- *
- * Get the range of a memory window.  NULL may be given for any output
- * parameter if the value is not needed.  The base and size may be used for
- * mapping the memory window, to access the peer memory.  The alignment and
- * size may be used for translating the memory window, for the peer to access
- * memory on the local system.
- *
- * Return: Zero on success, otherwise an error number.
+ * @pidx:	Port index of peer device.
+ * @widx:	Memory window index.
+ * @addr_align:	OUT - the base alignment for translating the memory window
+ * @size_align:	OUT - the size alignment for translating the memory window
+ * @size_max:	OUT - the maximum size of the memory window
+ *
+ * Get the alignments of an inbound memory window with specified index.
+ * NULL may be given for any output parameter if the value is not needed.
+ * The alignment and size parameters may be used for allocation of proper
+ * shared memory.
+ *
+ * Return: Zero on success, otherwise a negative error number.
  */
-static inline int ntb_mw_get_range(struct ntb_dev *ntb, int idx,
-				   phys_addr_t *base, resource_size_t *size,
-		resource_size_t *align, resource_size_t *align_size)
+static inline int ntb_mw_get_align(struct ntb_dev *ntb, int pidx, int widx,
+				   resource_size_t *addr_align,
+				   resource_size_t *size_align,
+				   resource_size_t *size_max)
 {
-	return ntb->ops->mw_get_range(ntb, idx, base, size,
-			align, align_size);
+	return ntb->ops->mw_get_align(ntb, pidx, widx, addr_align, size_align,
+				      size_max);
 }
 
 /**
- * ntb_mw_set_trans() - set the translation of a memory window
+ * ntb_mw_set_trans() - set the translation of an inbound memory window
  * @ntb:	NTB device context.
- * @idx:	Memory window number.
- * @addr:	The dma address local memory to expose to the peer.
+ * @pidx:	Port index of peer device.
+ * @widx:	Memory window index.
+ * @addr:	The dma address of local memory to expose to the peer.
  * @size:	The size of the local memory to expose to the peer.
  *
  * Set the translation of a memory window.  The peer may access local memory
  * through the window starting at the address, up to the size.  The address
- * must be aligned to the alignment specified by ntb_mw_get_range().  The size
- * must be aligned to the size alignment specified by ntb_mw_get_range().
+ * and size must be aligned in complience with restrictions of
+ * ntb_mw_get_align(). The region size should not exceed the size_max parameter
+ * of that method.
+ *
+ * This method may not be implemented due to the hardware specific memory
+ * windows interface.
  *
  * Return: Zero on success, otherwise an error number.
  */
-static inline int ntb_mw_set_trans(struct ntb_dev *ntb, int idx,
+static inline int ntb_mw_set_trans(struct ntb_dev *ntb, int pidx, int widx,
 				   dma_addr_t addr, resource_size_t size)
 {
-	return ntb->ops->mw_set_trans(ntb, idx, addr, size);
+	if (!ntb->ops->mw_set_trans)
+		return -EINVAL;
+
+	return ntb->ops->mw_set_trans(ntb, pidx, widx, addr, size);
 }
 
 /**
- * ntb_mw_clear_trans() - clear the translation of a memory window
+ * ntb_mw_clear_trans() - clear the translation address of an inbound memory
+ *                        window
  * @ntb:	NTB device context.
- * @idx:	Memory window number.
+ * @pidx:	Port index of peer device.
+ * @widx:	Memory window index.
  *
- * Clear the translation of a memory window.  The peer may no longer access
- * local memory through the window.
+ * Clear the translation of an inbound memory window.  The peer may no longer
+ * access local memory through the window.
  *
  * Return: Zero on success, otherwise an error number.
  */
-static inline int ntb_mw_clear_trans(struct ntb_dev *ntb, int idx)
+static inline int ntb_mw_clear_trans(struct ntb_dev *ntb, int pidx, int widx)
 {
 	if (!ntb->ops->mw_clear_trans)
-		return ntb->ops->mw_set_trans(ntb, idx, 0, 0);
+		return ntb_mw_set_trans(ntb, pidx, widx, 0, 0);
+
+	return ntb->ops->mw_clear_trans(ntb, pidx, widx);
+}
+
+/**
+ * ntb_peer_mw_count() - get the number of outbound memory windows, which could
+ *                       be mapped to access a shared memory
+ * @ntb:	NTB device context.
+ *
+ * Hardware and topology may support a different number of memory windows.
+ * This method returns the number of outbound memory windows supported by
+ * local device.
+ *
+ * Return: the number of memory windows.
+ */
+static inline int ntb_peer_mw_count(struct ntb_dev *ntb)
+{
+	return ntb->ops->peer_mw_count(ntb);
+}
+
+/**
+ * ntb_peer_mw_get_addr() - get map address of an outbound memory window
+ * @ntb:	NTB device context.
+ * @widx:	Memory window index (within ntb_peer_mw_count() return value).
+ * @base:	OUT - the base address of mapping region.
+ * @size:	OUT - the size of mapping region.
+ *
+ * Get base and size of memory region to map.  NULL may be given for any output
+ * parameter if the value is not needed.  The base and size may be used for
+ * mapping the memory window, to access the peer memory.
+ *
+ * Return: Zero on success, otherwise a negative error number.
+ */
+static inline int ntb_peer_mw_get_addr(struct ntb_dev *ntb, int widx,
+				      phys_addr_t *base, resource_size_t *size)
+{
+	return ntb->ops->peer_mw_get_addr(ntb, widx, base, size);
+}
+
+/**
+ * ntb_peer_mw_set_trans() - set a translation address of a memory window
+ *                           retrieved from a peer device
+ * @ntb:	NTB device context.
+ * @pidx:	Port index of peer device the translation address received from.
+ * @widx:	Memory window index.
+ * @addr:	The dma address of the shared memory to access.
+ * @size:	The size of the shared memory to access.
+ *
+ * Set the translation of an outbound memory window.  The local device may
+ * access shared memory allocated by a peer device sent the address.
+ *
+ * This method may not be implemented due to the hardware specific memory
+ * windows interface, so a translation address can be only set on the side,
+ * where shared memory (inbound memory windows) is allocated.
+ *
+ * Return: Zero on success, otherwise an error number.
+ */
+static inline int ntb_peer_mw_set_trans(struct ntb_dev *ntb, int pidx, int widx,
+					u64 addr, resource_size_t size)
+{
+	if (!ntb->ops->peer_mw_set_trans)
+		return -EINVAL;
+
+	return ntb->ops->peer_mw_set_trans(ntb, pidx, widx, addr, size);
+}
+
+/**
+ * ntb_peer_mw_clear_trans() - clear the translation address of an outbound
+ *                             memory window
+ * @ntb:	NTB device context.
+ * @pidx:	Port index of peer device.
+ * @widx:	Memory window index.
+ *
+ * Clear the translation of a outbound memory window.  The local device may no
+ * longer access a shared memory through the window.
+ *
+ * This method may not be implemented due to the hardware specific memory
+ * windows interface.
+ *
+ * Return: Zero on success, otherwise an error number.
+ */
+static inline int ntb_peer_mw_clear_trans(struct ntb_dev *ntb, int pidx,
+					  int widx)
+{
+	if (!ntb->ops->peer_mw_clear_trans)
+		return ntb_peer_mw_set_trans(ntb, pidx, widx, 0, 0);
 
-	return ntb->ops->mw_clear_trans(ntb, idx);
+	return ntb->ops->peer_mw_clear_trans(ntb, pidx, widx);
 }
 
 /**
-- 
2.6.6

