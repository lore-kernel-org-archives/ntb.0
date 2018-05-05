Return-Path: <araut@codeaurora.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org. [198.145.29.96])
        by gmr-mx.google.com with ESMTPS id r17si166417uak.1.2018.05.04.19.57.21
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 May 2018 19:57:21 -0700 (PDT)
Subject: [PATCH 4/4] NTB : Add support to message registers based devices
References: <20180410004822.GA6040@codeaurora.org>
 <CAJ80sauVAeFLfMMQxqnCThUZnYJ1A7Kvy=UogPMe_kWCu_Dw9w@mail.gmail.com>
 <c4d81c97-71f3-a832-2b6b-52c84b9854ac@codeaurora.org>
 <3dbf0543-8a0c-5493-54d3-116514a55a1b@intel.com>
From: Atul Raut <araut@codeaurora.org>
Message-ID: <9eaa5215-ff9a-90ab-dc0f-eae7e0f2921d@codeaurora.org>
Date: Fri, 4 May 2018 19:57:18 -0700
MIME-Version: 1.0
In-Reply-To: <3dbf0543-8a0c-5493-54d3-116514a55a1b@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>
Cc: linux-ntb@googlegroups.com, fancer.lancer@gmail.com, Jon Mason <jdmason@kudzu.us>, atulraut17@gmail.com, rauji.raut@gmail.com
List-ID: <linux-ntb.googlegroups.com>

Hi All,

This is last patch of four series patches.
This modify ntb_transport layer to add support
to message register based devices.
Please ignore other patch.

Regards,
AtulFrom 9f607fbd2d51ed7c58641a18f7924a03824ca83b Mon Sep 17 00:00:00 2001
From: Atul Raut <araut@codeaurora.org>
Date: Fri, 4 May 2018 19:32:20 -0700
Subject: [PATCH 4/4] NTB : Add support to message registers based devices

ntb_transport driver works only with Scartchpads based devices.
This patch add support to devices which uses Message registers
for data exchange.

Signed-off-by: Atul Raut <araut@codeaurora.org>
---
 drivers/ntb/ntb_transport.c | 357 ++++++++++++++++++++++++++++++++------------
 1 file changed, 260 insertions(+), 97 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 9878c48..b8dcd29 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -47,8 +47,8 @@
  * Contact Information:
  * Jon Mason <jon.mason@intel.com>
  */
+
 #include <linux/debugfs.h>
-#include <linux/delay.h>
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
 #include <linux/errno.h>
@@ -189,6 +189,7 @@ struct ntb_transport_qp {
 };
 
 struct ntb_transport_mw {
+	u64 outbuf_xlat;
 	phys_addr_t phys_addr;
 	resource_size_t phys_size;
 	void __iomem *vbase;
@@ -222,6 +223,16 @@ struct ntb_transport_ctx {
 	struct work_struct link_cleanup;
 
 	struct dentry *debugfs_node_dir;
+	struct msg_type handle;
+
+	unsigned int peer_mw_count;
+	unsigned int peer_qp_count;
+	unsigned int peer_qp_links;
+	u32 peer_ntb_version;
+
+	/* NTB connection setup service */
+	struct work_struct	service;
+	unsigned long	sts;
 };
 
 enum {
@@ -254,6 +265,9 @@ enum {
 #define NTB_QP_DEF_NUM_ENTRIES	100
 #define NTB_LINK_DOWN_TIMEOUT	10
 
+#define to_ntb_transport_service(__work) \
+	container_of(__work, struct ntb_transport_ctx, service)
+
 static void ntb_transport_rxc_db(unsigned long data);
 static const struct ntb_ctx_ops ntb_transport_ops;
 static struct ntb_client ntb_transport_client;
@@ -263,7 +277,6 @@ static int ntb_async_tx_submit(struct ntb_transport_qp *qp,
 static int ntb_async_rx_submit(struct ntb_queue_entry *entry, void *offset);
 static void ntb_memcpy_rx(struct ntb_queue_entry *entry, void *offset);
 
-
 static int ntb_transport_bus_match(struct device *dev,
 				   struct device_driver *drv)
 {
@@ -679,19 +692,50 @@ static void ntb_free_mw(struct ntb_transport_ctx *nt, int num_mw)
 	mw->virt_addr = NULL;
 }
 
-static int ntb_set_mw(struct ntb_transport_ctx *nt, int num_mw,
-		      resource_size_t size)
+static int ntb_transport_cmd_exec(struct ntb_transport_ctx *nt, enum nt_cmd cmd)
+{
+	struct pci_dev *pdev = nt->ndev->pdev;
+
+	switch (cmd) {
+	case NT_CMD_SSIZE:
+	case NT_CMD_RSIZE:
+	case NT_CMD_SXLAT:
+	case NT_CMD_RXLAT:
+	case NT_CMD_CLEAR:
+	case NT_CMD_NUM_MWS:
+	case NT_CMD_NUM_QPS:
+	case NT_CMD_NTB_VERSION:
+		break;
+	default:
+		dev_err(&pdev->dev, "Exec invalid command\n");
+		return -EINVAL;
+	}
+
+	/* No need of memory barrier, since bit ops have invernal lock */
+	set_bit(cmd, &nt->sts);
+
+	dev_dbg(&pdev->dev, "CMD exec: %d\n", cmd);
+
+	(void)queue_work(system_highpri_wq, &nt->service);
+
+	return 0;
+}
+
+static int ntb_set_mw(struct ntb_transport_ctx *nt, int num_mw)
 {
 	struct ntb_transport_mw *mw = &nt->mw_vec[num_mw];
 	struct pci_dev *pdev = nt->ndev->pdev;
 	size_t xlat_size, buff_size;
 	resource_size_t xlat_align;
 	resource_size_t xlat_align_size;
+	resource_size_t size;
 	int rc;
 
+	size = mw->buff_size;
 	if (!size)
 		return -EINVAL;
 
+	/* Get inbound MW parameters */
 	rc = ntb_mw_get_align(nt->ndev, PIDX, num_mw, &xlat_align,
 			      &xlat_align_size, NULL);
 	if (rc)
@@ -743,9 +787,72 @@ static int ntb_set_mw(struct ntb_transport_ctx *nt, int num_mw,
 		return -EIO;
 	}
 
+	if (num_mw ==  (nt->mw_count-1)) {
+		set_bit(NT_STS_DONE, &nt->sts);
+		dev_dbg(&pdev->dev, " NT_STS_DONE sts = %d\n", nt->sts);
+		(void)ntb_transport_cmd_exec(nt, NT_CMD_SXLAT);
+	}
+
 	return 0;
 }
 
+static int ntb_transport_cmd_send(struct ntb_transport_ctx *nt, enum nt_cmd cmd,
+		int cmd_wid, u64 data)
+{
+	struct pci_dev *pdev = nt->ndev->pdev;
+	struct ntb_dev *ndev = nt->ndev;
+
+	if (cmd == NT_CMD_SSIZE || cmd == NT_CMD_SXLAT || cmd == NT_CMD_NUM_MWS
+		|| cmd == NT_CMD_NUM_QPS || cmd == NT_CMD_NTB_VERSION
+		|| cmd == NT_QP_LINKS)
+		return nt->handle.cmd_send(ndev, PIDX, cmd, cmd_wid, data);
+
+	dev_err(&pdev->dev, "Send invalid command\n");
+	return -EINVAL;
+}
+
+static int ntb_transport_cmd_recv(struct ntb_transport_ctx *nt)
+{
+	struct pci_dev *pdev = nt->ndev->pdev;
+	struct ntb_dev *ndev = nt->ndev;
+	int ret, pidx, cmd, cmd_wid;
+	u64 data;
+
+	while (!(ret = nt->handle.cmd_recv(ndev, &pidx, &cmd, &cmd_wid,
+			&data))) {
+		switch (cmd) {
+		case NT_CMD_SSIZE:
+			nt->mw_vec[cmd_wid].buff_size = data;
+			return ntb_transport_cmd_exec(nt, NT_CMD_RSIZE);
+		case NT_CMD_SXLAT:
+			nt->mw_vec[cmd_wid].outbuf_xlat = data;
+			if (cmd_wid ==  (nt->mw_count-1))
+				return ntb_transport_cmd_exec(nt, NT_CMD_RXLAT);
+			break;
+		case NT_CMD_NUM_MWS:
+			nt->peer_mw_count = data;
+			break;
+		case NT_CMD_NUM_QPS:
+			nt->peer_qp_count = data;
+			break;
+		case NT_CMD_NTB_VERSION:
+			if (data == NTB_TRANSPORT_VERSION)
+				nt->peer_ntb_version  = data;
+			break;
+		case NT_QP_LINKS:
+			nt->peer_qp_links = data;
+			break;
+		default:
+			dev_dbg(&pdev->dev, "[%s] Recv invalid command cmd-> %d\n",
+				__func__, cmd);
+			return -EINVAL;
+		}
+	}
+
+	/* Return 0 if no data left to process, otherwise an error */
+	return ret == -ENODATA ? 0 : ret;
+}
+
 static void ntb_qp_link_down_reset(struct ntb_transport_qp *qp)
 {
 	qp->link_is_up = false;
@@ -839,6 +946,94 @@ static void ntb_transport_link_cleanup_work(struct work_struct *work)
 	ntb_transport_link_cleanup(nt);
 }
 
+static int ntb_transport_setup_outbuf(struct ntb_transport_ctx *nt, int num_mw)
+{
+	struct ntb_dev *ndev = nt->ndev;
+	int ret;
+
+	/* Outbuf size can be unaligned due to custom max_mw_size */
+	ret = ntb_peer_mw_set_trans(nt->ndev, PIDX, num_mw,
+		nt->mw_vec[num_mw].outbuf_xlat, nt->mw_vec[num_mw].phys_size);
+	if (ret) {
+		dev_err(&ndev->dev, "Failed to set outbuf translation\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static void ntb_qp_link_work(struct work_struct *work)
+{
+	struct ntb_transport_qp *qp = container_of(work,
+						   struct ntb_transport_qp,
+						   link_work.work);
+	struct pci_dev *pdev = qp->ndev->pdev;
+	struct ntb_transport_ctx *nt = qp->transport;
+	u64 qp_bitmap_alloc;
+	int val = -1;
+
+	WARN_ON(!nt->link_is_up);
+
+	qp_bitmap_alloc = (nt->qp_bitmap & ~nt->qp_bitmap_free);
+	ntb_transport_cmd_send(nt, NT_QP_LINKS, 0, qp_bitmap_alloc);
+	if (nt->peer_qp_links)
+		val = nt->peer_qp_links;
+
+	/* See if the remote side is up */
+	if (val & BIT(qp->qp_num)) {
+		dev_info(&pdev->dev, "qp %d: Link Up\n", qp->qp_num);
+		qp->link_is_up = true;
+		qp->active = true;
+
+		if (qp->event_handler)
+			qp->event_handler(qp->cb_data, qp->link_is_up);
+
+		if (qp->active)
+			tasklet_schedule(&qp->rxc_db_work);
+	} else if (nt->link_is_up)
+		schedule_delayed_work(&qp->link_work,
+				      msecs_to_jiffies(NTB_LINK_DOWN_TIMEOUT));
+}
+
+static void ntb_transport_service_work(struct work_struct *work)
+{
+	struct ntb_transport_ctx *nt = to_ntb_transport_service(work);
+	resource_size_t size;
+	int i;
+
+	if (test_and_clear_bit(NT_CMD_SSIZE, &nt->sts)) {
+		for (i = 0; i < nt->mw_count; i++) {
+			size = nt->mw_vec[i].phys_size;
+			if (max_mw_size && size > max_mw_size)
+				size = max_mw_size;
+			ntb_transport_cmd_send(nt, NT_CMD_SSIZE, i, size);
+		}
+	}
+
+	if (test_and_clear_bit(NT_CMD_RSIZE, &nt->sts))
+		for (i = 0; i < nt->mw_count; i++)
+			ntb_set_mw(nt, i);
+
+	if (test_and_clear_bit(NT_CMD_SXLAT, &nt->sts))
+		for (i = 0; i < nt->mw_count; i++)
+			ntb_transport_cmd_send(nt, NT_CMD_SXLAT, i,
+				nt->mw_vec[i].dma_addr);
+
+	if (test_and_clear_bit(NT_CMD_RXLAT, &nt->sts))
+		for (i = 0; i < nt->mw_count; i++)
+			ntb_transport_setup_outbuf(nt, i);
+
+	if (test_and_clear_bit(NT_CMD_NUM_MWS, &nt->sts))
+		ntb_transport_cmd_send(nt, NT_CMD_NUM_MWS, 0, nt->mw_count);
+
+	if (test_and_clear_bit(NT_CMD_NUM_QPS, &nt->sts))
+		ntb_transport_cmd_send(nt, NT_CMD_NUM_QPS, 0,  nt->qp_count);
+
+	if (test_and_clear_bit(NT_CMD_NTB_VERSION, &nt->sts))
+		ntb_transport_cmd_send(nt, NT_CMD_NTB_VERSION, 0,
+			NTB_TRANSPORT_VERSION);
+}
+
 static void ntb_transport_event_callback(void *data)
 {
 	struct ntb_transport_ctx *nt = data;
@@ -855,72 +1050,43 @@ static void ntb_transport_link_work(struct work_struct *work)
 		container_of(work, struct ntb_transport_ctx, link_work.work);
 	struct ntb_dev *ndev = nt->ndev;
 	struct pci_dev *pdev = ndev->pdev;
-	resource_size_t size;
-	u32 val;
-	int rc = 0, i, spad;
+	int rc = 0, i;
 
 	/* send the local info, in the opposite order of the way we read it */
-	for (i = 0; i < nt->mw_count; i++) {
-		size = nt->mw_vec[i].phys_size;
-
-		if (max_mw_size && size > max_mw_size)
-			size = max_mw_size;
-
-		spad = MW0_SZ_HIGH + (i * 2);
-		ntb_peer_spad_write(ndev, PIDX, spad, upper_32_bits(size));
-
-		spad = MW0_SZ_LOW + (i * 2);
-		ntb_peer_spad_write(ndev, PIDX, spad, lower_32_bits(size));
-	}
-
-	ntb_peer_spad_write(ndev, PIDX, NUM_MWS, nt->mw_count);
-
-	ntb_peer_spad_write(ndev, PIDX, NUM_QPS, nt->qp_count);
-
-	ntb_peer_spad_write(ndev, PIDX, VERSION, NTB_TRANSPORT_VERSION);
+	ntb_transport_cmd_exec(nt, NT_CMD_SSIZE);
+	ntb_transport_cmd_exec(nt, NT_CMD_NUM_MWS);
+	ntb_transport_cmd_exec(nt, NT_CMD_NUM_QPS);
+	ntb_transport_cmd_exec(nt, NT_CMD_NTB_VERSION);
 
 	/* Query the remote side for its info */
-	val = ntb_spad_read(ndev, VERSION);
-	dev_dbg(&pdev->dev, "Remote version = %d\n", val);
-	if (val != NTB_TRANSPORT_VERSION)
+	dev_dbg(&pdev->dev, "Remote version = %d\n", nt->peer_ntb_version);
+	if (nt->peer_ntb_version != NTB_TRANSPORT_VERSION)
 		goto out;
 
-	val = ntb_spad_read(ndev, NUM_QPS);
-	dev_dbg(&pdev->dev, "Remote max number of qps = %d\n", val);
-	if (val != nt->qp_count)
+	dev_dbg(&pdev->dev, "Remote max number of qps = %d\n",
+	nt->peer_qp_count);
+	if (nt->peer_qp_count != nt->qp_count)
 		goto out;
 
-	val = ntb_spad_read(ndev, NUM_MWS);
-	dev_dbg(&pdev->dev, "Remote number of mws = %d\n", val);
-	if (val != nt->mw_count)
+	dev_dbg(&pdev->dev, "Remote number of mws = %d\n", nt->peer_mw_count);
+	if (nt->peer_mw_count != nt->mw_count)
 		goto out;
 
-	for (i = 0; i < nt->mw_count; i++) {
-		u64 val64;
+	if (test_and_clear_bit(NT_STS_DONE, &nt->sts)) {
+		nt->link_is_up = true;
 
-		val = ntb_spad_read(ndev, MW0_SZ_HIGH + (i * 2));
-		val64 = (u64)val << 32;
+		for (i = 0; i < nt->qp_count; i++) {
+			struct ntb_transport_qp *qp = &nt->qp_vec[i];
 
-		val = ntb_spad_read(ndev, MW0_SZ_LOW + (i * 2));
-		val64 |= val;
-
-		dev_dbg(&pdev->dev, "Remote MW%d size = %#llx\n", i, val64);
-
-		rc = ntb_set_mw(nt, i, val64);
+		rc = ntb_transport_setup_qp_mw(nt, i);
 		if (rc)
 			goto out1;
-	}
-
-	nt->link_is_up = true;
-
-	for (i = 0; i < nt->qp_count; i++) {
-		struct ntb_transport_qp *qp = &nt->qp_vec[i];
-
-		ntb_transport_setup_qp_mw(nt, i);
 
 		if (qp->client_ready)
 			schedule_delayed_work(&qp->link_work, 0);
-	}
+		}
+	} else
+		goto out;
 
 	return;
 
@@ -938,40 +1104,6 @@ static void ntb_transport_link_work(struct work_struct *work)
 				      msecs_to_jiffies(NTB_LINK_DOWN_TIMEOUT));
 }
 
-static void ntb_qp_link_work(struct work_struct *work)
-{
-	struct ntb_transport_qp *qp = container_of(work,
-						   struct ntb_transport_qp,
-						   link_work.work);
-	struct pci_dev *pdev = qp->ndev->pdev;
-	struct ntb_transport_ctx *nt = qp->transport;
-	int val;
-
-	WARN_ON(!nt->link_is_up);
-
-	val = ntb_spad_read(nt->ndev, QP_LINKS);
-
-	ntb_peer_spad_write(nt->ndev, PIDX, QP_LINKS, val | BIT(qp->qp_num));
-
-	/* query remote spad for qp ready bits */
-	dev_dbg_ratelimited(&pdev->dev, "Remote QP link status = %x\n", val);
-
-	/* See if the remote side is up */
-	if (val & BIT(qp->qp_num)) {
-		dev_info(&pdev->dev, "qp %d: Link Up\n", qp->qp_num);
-		qp->link_is_up = true;
-		qp->active = true;
-
-		if (qp->event_handler)
-			qp->event_handler(qp->cb_data, qp->link_is_up);
-
-		if (qp->active)
-			tasklet_schedule(&qp->rxc_db_work);
-	} else if (nt->link_is_up)
-		schedule_delayed_work(&qp->link_work,
-				      msecs_to_jiffies(NTB_LINK_DOWN_TIMEOUT));
-}
-
 static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
 				    unsigned int qp_num)
 {
@@ -1060,14 +1192,14 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
 {
 	struct ntb_transport_ctx *nt;
 	struct ntb_transport_mw *mw;
-	unsigned int mw_count, qp_count, spad_count, max_mw_count_for_spads;
+	unsigned int mw_count, qp_count, msg_count, max_mw_count_for_spads;
 	u64 qp_bitmap;
 	int node;
 	int rc, i;
 
 	mw_count = ntb_peer_mw_count(ndev);
 
-	if (!ndev->ops->mw_set_trans) {
+	if (!ndev->ops->mw_set_trans && !ndev->ops->peer_mw_set_trans) {
 		dev_err(&ndev->dev, "Inbound MW based NTB API is required\n");
 		return -EINVAL;
 	}
@@ -1089,18 +1221,25 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
 		return -ENOMEM;
 
 	nt->ndev = ndev;
-	spad_count = ntb_spad_count(ndev);
+	if (ntb_msg_count(ndev) >= NT_MSG_CNT)
+		msg_count = ntb_msg_count(ndev);
+	else
+		msg_count = ntb_spad_count(ndev);
 
 	/* Limit the MW's based on the availability of scratchpads */
 
-	if (spad_count < NTB_TRANSPORT_MIN_SPADS) {
+	if (msg_count < NTB_TRANSPORT_MIN_SPADS && msg_count < NT_MSG_CNT) {
 		nt->mw_count = 0;
 		rc = -EINVAL;
 		goto err;
 	}
 
-	max_mw_count_for_spads = (spad_count - MW0_SZ_HIGH) / 2;
-	nt->mw_count = min(mw_count, max_mw_count_for_spads);
+	if (ntb_msg_count(ndev)) {
+		nt->mw_count = msg_count;
+	} else {
+		max_mw_count_for_spads = (msg_count - MW0_SZ_HIGH) / 2;
+		nt->mw_count = min(mw_count, max_mw_count_for_spads);
+	}
 
 	nt->mw_vec = kzalloc_node(mw_count * sizeof(*nt->mw_vec),
 				  GFP_KERNEL, node);
@@ -1128,6 +1267,7 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
 		mw->virt_addr = NULL;
 		mw->dma_addr = 0;
 	}
+	INIT_WORK(&nt->service, ntb_transport_service_work);
 
 	qp_bitmap = ntb_db_valid_mask(ndev);
 
@@ -1142,6 +1282,7 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
 	nt->qp_count = qp_count;
 	nt->qp_bitmap = qp_bitmap;
 	nt->qp_bitmap_free = qp_bitmap;
+	nt->peer_qp_links = -1;
 
 	nt->qp_vec = kzalloc_node(qp_count * sizeof(*nt->qp_vec),
 				  GFP_KERNEL, node);
@@ -1169,6 +1310,15 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
 	if (rc)
 		goto err2;
 
+	/* Enable Messaging */
+	rc = nt_init_messaging(ndev, &nt->handle);
+	if (rc)
+		goto err2;
+
+	rc = nt_enable_messaging(ndev, ntb_port_number(ndev));
+	if (rc)
+		goto err2;
+
 	INIT_LIST_HEAD(&nt->client_devs);
 	rc = ntb_bus_init(nt);
 	if (rc)
@@ -1217,6 +1367,7 @@ static void ntb_transport_free(struct ntb_client *self, struct ntb_dev *ndev)
 	}
 
 	ntb_link_disable(ndev);
+	nt_disable_messaging(ndev, ntb_port_number(ndev));
 	ntb_clear_ctx(ndev);
 
 	ntb_bus_remove(nt);
@@ -2100,16 +2251,16 @@ void ntb_transport_link_up(struct ntb_transport_qp *qp)
  */
 void ntb_transport_link_down(struct ntb_transport_qp *qp)
 {
-	int val;
+	u64 qp_bitmap_alloc;
 
 	if (!qp)
 		return;
+	struct ntb_transport_ctx *nt = qp->transport;
 
 	qp->client_ready = false;
 
-	val = ntb_spad_read(qp->ndev, QP_LINKS);
-
-	ntb_peer_spad_write(qp->ndev, PIDX, QP_LINKS, val & ~BIT(qp->qp_num));
+	qp_bitmap_alloc = (nt->qp_bitmap & ~nt->qp_bitmap_free);
+	ntb_transport_cmd_send(nt, NT_QP_LINKS, 0, qp_bitmap_alloc);
 
 	if (qp->link_is_up)
 		ntb_send_link_down(qp);
@@ -2213,9 +2364,21 @@ static void ntb_transport_doorbell_callback(void *data, int vector)
 	}
 }
 
+static void ntb_transport_msg_event_callback(void *data)
+{
+	struct ntb_transport_ctx *nt = data;
+
+	dev_dbg(&nt->ndev->dev, "Msg status bits %#llx\n",
+		ntb_msg_read_sts(nt->ndev));
+
+	/* Messages are only sent one-by-one */
+	(void)ntb_transport_cmd_recv(nt);
+}
+
 static const struct ntb_ctx_ops ntb_transport_ops = {
 	.link_event = ntb_transport_event_callback,
 	.db_event = ntb_transport_doorbell_callback,
+	.msg_event = ntb_transport_msg_event_callback,
 };
 
 static struct ntb_client ntb_transport_client = {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

