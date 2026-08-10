Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020079.outbound.protection.outlook.com [52.101.229.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61619430789
	for <ntb@lists.linux.dev>; Mon, 10 Aug 2026 16:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786380720; cv=fail; b=tWfOPbKXEx/UnglLU/DlrmDuhUxQZ7HbayL16/GvspFLNkZbSHGE2dOFLYZlinE4xUP+iXV8Kixowf7kxTvBWLbXavZ1C1ft9OnyWs4TGP0WikFQYiRJZeuk2IrqmHsCaYSqinIySx8QwbjMQF5K5G3+EWay/VcdKXpSwnRXdtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786380720; c=relaxed/simple;
	bh=oDUF+fpP+SBxcoaeoTCs0rE7V+AEjm0uy0WfmCpjsPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mzhifo6hKHdQevp1yodThnJwjYzmVXqDvC+zlsLuXGPz6GpuNwK8mnGEcPP7j8PDuZ5AueEaxfI30/9yQs8jVKgh4a3JSZT4nU6HutzIssos6VXuJN19ckMBbvEaAP/CmZMAn+YTBzwh4tajvwKfdwXnUOIhd3bVur4QzczR/rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=kWm+Tt3h; arc=fail smtp.client-ip=52.101.229.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="kWm+Tt3h"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A7sKXPanU2Y/OxmIwY/IR0zaSS0LDbEN5inZwM5YTfKxVDLWCC/Y9LMfvB5SCn8z8Zuda5V/rWLG9wnT1A2lQyU7GGcASe3m8yAK+XSAbamN9pe2XuHhVaaL6lqiIeoo9XZqr9dZ53i80GMxTxVpI3vU3xcphh9+Vz0ykxQd7mqkAwPwhl4PP8DdV5v+3h4VHO8sJU52huoiwkvYK959tsLlNHuBOdoaTTOcIC0w19KSgeN1DtU3x8g/SZKnyfzUlTDbgewMhDTSs/1XLgbyaAahpy2PVxfPTXtIqgS8DzymoKBjqE91rSog52EgQllqMUDNS6rT1erJrp3Rk77VNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pxIamREPtHvIVIJOLW1rHGaPlQFWNNwauMnL526pIDU=;
 b=suMdLUyBcxIA5N1JK3K/w0RXyW50gzCtmYkUKboBmT0A5tjpDs6J1T3PUPCZO/IjAJHQ6ZjHWRJTcGHUJDW/VVV1DLI5eVq4dTY/GuPPMd7k6wRJlKQcYzTfMwmBHhFNbx/gYb1apR4MXxV8BdmcPsG6f1xru1qk3F8+9ZBY8JlapFow/mJVgx8ZPGKeldICJUWwc8NHeOv0qmM0Ie/TmsCmOAZ/VjFREMRMB+gq4hduJ4CACO53OZElEM7iRH9YAs30aiwPHaIiz8G70WnhzAyX9jGA/4UdfdJBNnZhJHfxU4K173oBtaAXyN72gIh+22fYlP/KIOLnTjtWytPDIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pxIamREPtHvIVIJOLW1rHGaPlQFWNNwauMnL526pIDU=;
 b=kWm+Tt3hHPZ8QL4zZFWF5/qNF0G4Nu/UQUMcrI6TOoaqj9Pyry9TNhwnOS3qKNf/KUZsDUUC9Lor6Tn+xuuFgZBkvXoSW4Ny+ZMkOd8DgNSpYJd5/dzY6+PuA60yj2ZAjMM6bd1hAXM8C/GaZqkZUfQxWrwiM5m5NpNj6lfyrMs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB6729.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:42d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 16:51:50 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 16:51:50 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Frank Li <Frank.Li@kernel.org>,
	Allen Hubbe <allenbh@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Niklas Cassel <cassel@kernel.org>,
	Nicholas Bellinger <nab@linux-iscsi.org>
Cc: ntb@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/16] NTB: ntb_transport: Add opt-in direct-DMA channel reservation
Date: Tue, 11 Aug 2026 01:51:27 +0900
Message-ID: <20260810165136.2292436-9-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260810165136.2292436-1-den@valinux.co.jp>
References: <20260810165136.2292436-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0129.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::17) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB6729:EE_
X-MS-Office365-Filtering-Correlation-Id: b6246149-fab5-4eb5-402f-08def6ffac55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|23010399003|376014|1800799024|366016|6133799003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	SWBGY4DJuWtiPnECQJqKdiJ5l+lF/AsCIHr5Md97++pYLJkdVvuPpXmgwD1JfLpozfoNcSuBrzuwZTT8Hkga3nEyCykRgV3NV3T35n1pG1yYGLyaX7Iy0TafcCJ2pURQL7C6kDTXBWv4IWPo5mfdeQzvFyA52nBQi2242WKDygPU+ouFZZo8CDTNsC/kHfJCpkogOY5l1TW5TmID/EsJTz0nuO6t7VGzItrmPe/+Aup8iW4X2fXt1lTu16wqv2sjvt3cTWHZ0XlHSpjkHuDNMrFKQRoYnAGqJvrhFQlFI97dvfN96HfheshH/R4BOIHKJGqUjrfZ45YYwcOtQyuVoLaX/REcPWmKTeb46n1SwORe7vnKoJXkjgrIb39LuhYnxNdHqnMw8an1iUI1JwDMvc+ilAiLfpmTq7ULC9DkNRPaCQE8937GL1pEBAkITlQ/YCbpdvPBrQ3F5RFXwsMPpLPPhSn7+jXdnVTJBOJ0teUoWyDNmkIwZCOb8iWr6KsYoAU9rtViREsMVmYqYaPCrqotDIX1mPY9zXn2LOClogd2SFOjSvp0VfoQYxRfen5ysAvaNijKkXBg0LdhCRW/1Pz7BI1ekf03RaDVqUMlkT5wz6RmFeql2JhobltPAa4bi8EBSATGe8fBA0jRCSB/xOIZH3tHpW4fIlwI64aDsAw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(23010399003)(376014)(1800799024)(366016)(6133799003)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R7DoMEw0iSFSHqiV10GMcZEtxK4VHNYNFZOBvqLitxkjs5TJKaiy9NGgqCK3?=
 =?us-ascii?Q?FYnkeS12ZKxRB2SA5iVK94ubDWss7R550JFRhXJ27nG6ThY1UiOAGPYlYCYy?=
 =?us-ascii?Q?FCZUr/xKo+vvP7wqe924XrXt42NLWNpMxEed6UXo8Gh+ZO2SG6z8m9CqyrLh?=
 =?us-ascii?Q?tczwtT3COPO4BSyYz96HKjC3AsILbkl9YjSWLV4MIIVNpJfPWKrzmAZ66nsk?=
 =?us-ascii?Q?bIcQmpMptTRapcPNtpqqrSya4bstPoss58JuNIL+HemjBRT/b4NceIUX9zoB?=
 =?us-ascii?Q?PlP9wH1FGUN9uQKORRtGBJXqkPOs0dn5YyO3cPRadgFHAWIRmJ6zzEPI3gkB?=
 =?us-ascii?Q?Oh1phe5GHt3jI+xkPLhlsOCSVn2WfakPbIXBcGbqkWof6eL+KyDMZ2NHGT/d?=
 =?us-ascii?Q?R+e8S9SXrwOb3qUXr6Udxi6sxSgOw1YUQ95KX05y+CajoiRP7ecdbn/NnKaT?=
 =?us-ascii?Q?xdBbCaYHN4mfoL6YFgYOYdaPSDGTGtWkUHo9o4VGHDNlxAqPARHDp55C4ato?=
 =?us-ascii?Q?ShUa6aMfLAqmbuTqvSrHiY+6cJ9YQBIpC9CP41OK6KiN/l0YToiHzXO5Lc8u?=
 =?us-ascii?Q?pq0RRQVhPLkCxJXsywJcBCSvO+4JwCMbtSS2q2N0HDojFuj6ZhLGp3Z5kbQC?=
 =?us-ascii?Q?jQ4VnWWI4qGXLGSpjXgN2YShjvc0LXTUun/eLChZLrESMcfj/DjDsGPWL2Sf?=
 =?us-ascii?Q?MpBpkytuVOIIRclcnW2DB2CQumMPjY7CD2ctUZAiSKC/6g6cqyEqxsT7dg9S?=
 =?us-ascii?Q?HdpniBJ+I62EwEybFcpZoYg5Vt+F6IbP2fE7a9MKzcj4E24QUokFuXrvZFhj?=
 =?us-ascii?Q?JcqClEnwp01IWTIp/uMWGXuQcztpW58f/85yBlzJca//N1gA13+eVE3BRO6A?=
 =?us-ascii?Q?7x0lae00VGoqzCIdNfTRQs/fmyLyjK3yaLEzVpwMFRY3OyG928U2jOFLER/V?=
 =?us-ascii?Q?f/X+jWyAj1u7vv65WcltatHyVfnzfTKbuoic1EVO1OFjUfFjS8R4ihkBgYu2?=
 =?us-ascii?Q?uADHP876Z8krdIOAZZkfgbfAOI5h5jmLfFnLRAAicidqR9kqdPiylFZMc+08?=
 =?us-ascii?Q?2L8EFM5C9uXNKP+O10UYJVOuEjYBd2vqzM2e3/5msynNbeifcI5ysKe4XhqC?=
 =?us-ascii?Q?InCA+RG9exQCygM+gr1QKpLz4RrBAmmzIL9lbbRFdhpjmyRR1LUHDz/rx1Om?=
 =?us-ascii?Q?by2iT5qcK9knlUANeiP4Jge9PyvYcLS9JGhby6kYU/0Jy2FhwbmLlGUXr9o9?=
 =?us-ascii?Q?hRohgmW4dEjT2z0fuR+GeD/6yRdk18/uwIC602PxpDUrZXqP/LNe5zhkPlKp?=
 =?us-ascii?Q?ZrE1kXp/iuN3UHh0ySQPeVjtutqu/ZDJ8Xyzd/NbuDZTIJpQErv+vWozoUjq?=
 =?us-ascii?Q?V+loFEJWZVdJIwXz/YNKwtnP7ZVDNXrXcutYUff83kJrZ9ElQL3HXonleAZ+?=
 =?us-ascii?Q?ZLIDotvcYT67y4U8QPyZ0jFFJwi8Tx+9yzC45yibweCyLXpY70AzHU9cZuo3?=
 =?us-ascii?Q?ItTPEmbAX4ii5RuQeqRUMcVqsWhMREdg1OmqJmQt0f3+fA2VN5961xxZpkiy?=
 =?us-ascii?Q?1SoDM9wFYXrHKeKIW4h7OTjruU/mkR/iiHSGq3YnnDCvgAGOcHFezb9BkHCr?=
 =?us-ascii?Q?QNvDVxaSAZ2/HuLqP75TrAKREXLVvRwUFx/9soinWJ9dszuKerQHphyqzPSo?=
 =?us-ascii?Q?qrgf2t1x/UZ2v7O47yK1bOAj5jKCTBVcf6VOInjG7+t1IaxZUFf3YxfgC1sc?=
 =?us-ascii?Q?WTDQxwtSqlEurxa11rGNZ23WZZUC2pQmATaV/cs7U5bWo60cN6Ef?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: b6246149-fab5-4eb5-402f-08def6ffac55
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 16:51:50.1994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y40m8rRLVdjBA16LQmr6Pz0+qb6b0Vv/MOzKrwxXy14Tl8zqknI8XsiHt1uJ1yiPJ7jczIiqg3Wbl7x+sIOFRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB6729

Direct DMA is opt-in. Add 'use_direct_dma' module parameter to request
it. Some endpoint integrations expose NTB and DMA through sibling PCI
functions, so add direct_dma_func to select the DMA function when the
NTB device cannot return the DMA device directly.

When use_direct_dma is set and negotiation scratchpads are available,
locate the DMA device and reserve one suitable channel for every QP
before registering clients. This avoids negotiating direct TX before a
later-created QP discovers that no channel is available. If the full set
is unavailable, leave direct TX disabled. Note that direct RX does not
require these channels.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/ntb_transport.c | 120 ++++++++++++++++++++++++++++++++++++
 1 file changed, 120 insertions(+)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index f873eacd532b..6051d8abfc0d 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -98,6 +98,16 @@ static bool use_dma;
 module_param(use_dma, bool, 0644);
 MODULE_PARM_DESC(use_dma, "Use DMA engine to perform large data copy");
 
+static bool use_direct_dma;
+module_param(use_direct_dma, bool, 0644);
+MODULE_PARM_DESC(use_direct_dma,
+		 "Use PCI endpoint DMA to transfer directly to peer RX buffers");
+
+static unsigned int direct_dma_func;
+module_param(direct_dma_func, uint, 0644);
+MODULE_PARM_DESC(direct_dma_func,
+		 "PCI function number of a sibling endpoint DMA function");
+
 static unsigned int direct_dma_ring_entries = 64;
 module_param(direct_dma_ring_entries, uint, 0644);
 MODULE_PARM_DESC(direct_dma_ring_entries,
@@ -147,6 +157,7 @@ struct ntb_transport_qp {
 	void *cb_data;
 	struct dma_chan *tx_dma_chan;
 	struct dma_chan *rx_dma_chan;
+	struct dma_chan *direct_dma_chan;
 
 	bool client_ready;
 	bool link_is_up;
@@ -269,6 +280,7 @@ struct ntb_transport_ctx {
 	struct work_struct link_cleanup;
 
 	struct dentry *debugfs_node_dir;
+	struct device *direct_dma_dev;
 	u32 direct_features;
 	u32 peer_direct_features;
 	unsigned int direct_ring_entries;
@@ -352,6 +364,97 @@ static inline u32 ntb_direct_ring_used(u32 head, u32 tail)
 	return head - tail;
 }
 
+static bool ntb_direct_dma_filter_fn(struct dma_chan *chan, void *data)
+{
+	struct dma_slave_caps caps;
+
+	if (chan->device->dev != data || dma_get_slave_caps(chan, &caps))
+		return false;
+
+	/* Payload and completion descriptors must complete in order. */
+	return caps.cmd_terminate &&
+	       !dma_has_cap(DMA_COMPLETION_NO_ORDER, chan->device->cap_mask) &&
+	       (caps.directions & BIT(DMA_MEM_TO_DEV));
+}
+
+static struct device *ntb_direct_get_dma_dev(struct ntb_dev *ndev)
+{
+	struct pci_dev *pdev = ndev->pdev;
+	struct pci_dev *dma_pdev;
+	struct device *dev;
+
+	if (ndev->ops->get_dma_dev) {
+		dev = ntb_get_dma_dev(ndev);
+		return dev ? get_device(dev) : ERR_PTR(-ENODEV);
+	}
+
+	if (!pdev || !pdev->bus || direct_dma_func > 7)
+		return ERR_PTR(-ENODEV);
+
+	dma_pdev = pci_get_domain_bus_and_slot(pci_domain_nr(pdev->bus),
+					       pdev->bus->number,
+					       PCI_DEVFN(PCI_SLOT(pdev->devfn),
+							 direct_dma_func));
+	if (!dma_pdev)
+		return ERR_PTR(-ENODEV);
+
+	return &dma_pdev->dev;
+}
+
+static void ntb_direct_dma_release_channels(struct ntb_transport_ctx *nt)
+{
+	unsigned int i;
+
+	for (i = 0; i < nt->qp_count; i++) {
+		if (!nt->qp_vec[i].direct_dma_chan)
+			continue;
+
+		dma_release_channel(nt->qp_vec[i].direct_dma_chan);
+		nt->qp_vec[i].direct_dma_chan = NULL;
+	}
+}
+
+static void ntb_direct_dma_release(struct ntb_transport_ctx *nt)
+{
+	ntb_direct_dma_release_channels(nt);
+	if (nt->direct_dma_dev) {
+		put_device(nt->direct_dma_dev);
+		nt->direct_dma_dev = NULL;
+	}
+}
+
+static void ntb_direct_dma_init(struct ntb_transport_ctx *nt)
+{
+	dma_cap_mask_t mask;
+	unsigned int i;
+
+	if (!use_direct_dma)
+		return;
+
+	nt->direct_dma_dev = ntb_direct_get_dma_dev(nt->ndev);
+	if (IS_ERR(nt->direct_dma_dev)) {
+		dev_info(&nt->ndev->dev, "direct DMA device unavailable: %pe\n",
+			 nt->direct_dma_dev);
+		nt->direct_dma_dev = NULL;
+		return;
+	}
+
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
+
+	for (i = 0; i < nt->qp_count; i++) {
+		nt->qp_vec[i].direct_dma_chan =
+			dma_request_channel(mask, ntb_direct_dma_filter_fn,
+					    nt->direct_dma_dev);
+		if (!nt->qp_vec[i].direct_dma_chan) {
+			dev_info(&nt->ndev->dev,
+				 "not enough direct DMA channels for all QPs\n");
+			ntb_direct_dma_release_channels(nt);
+			return;
+		}
+	}
+}
+
 struct ntb_payload_header {
 	unsigned int ver;
 	unsigned int len;
@@ -1476,6 +1579,16 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
 		return -ENOMEM;
 
 	nt->ndev = ndev;
+	if (use_direct_dma &&
+	    (direct_dma_ring_entries < 2 ||
+	     direct_dma_ring_entries > NTB_DIRECT_MAX_RING_ENTRIES ||
+	     !is_power_of_2(direct_dma_ring_entries))) {
+		dev_err(&ndev->dev,
+			"direct DMA ring entries must be a power of two between 2 and %u\n",
+			NTB_DIRECT_MAX_RING_ENTRIES);
+		rc = -EINVAL;
+		goto err;
+	}
 	nt->direct_ring_entries = direct_dma_ring_entries;
 
 	/*
@@ -1582,6 +1695,11 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
 		if (rc)
 			goto err2;
 	}
+	if (ntb_direct_spads_available(nt))
+		ntb_direct_dma_init(nt);
+	else if (use_direct_dma)
+		dev_info(&ndev->dev,
+			 "not enough scratchpads for direct DMA negotiation\n");
 
 	mutex_init(&nt->link_event_lock);
 	INIT_DELAYED_WORK(&nt->link_work, ntb_transport_link_work);
@@ -1605,6 +1723,7 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
 err3:
 	ntb_clear_ctx(ndev);
 err2:
+	ntb_direct_dma_release(nt);
 	kfree(nt->qp_vec);
 err1:
 	while (i--) {
@@ -1648,6 +1767,7 @@ static void ntb_transport_free(struct ntb_client *self, struct ntb_dev *ndev)
 		iounmap(nt->mw_vec[i].vbase);
 	}
 
+	ntb_direct_dma_release(nt);
 	kfree(nt->qp_vec);
 	kfree(nt->mw_vec);
 	kfree(nt);
-- 
2.51.0

