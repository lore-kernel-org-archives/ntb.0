Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021111.outbound.protection.outlook.com [52.101.125.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A822F42CB09
	for <ntb@lists.linux.dev>; Mon, 10 Aug 2026 16:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786380722; cv=fail; b=tXwFAMY1tKfpP8ZYIgjfIwM/N9NZ8esxOJroMQTSW/jZdAX01s6EEFvLFv/3BFCtRtMupdVX9L3YTJPZ7Zoi/hprTHvMNPCwlu48WnHyJDmoruv+9NV5RU852qsXYCIeDKs0CgnSRUxhdYA55s/3A1//Et1Pus36ueybLBFYYRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786380722; c=relaxed/simple;
	bh=0CrQv01CmptK0tXHhyjzoZ2LXem1si2q+3iArIzCef4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aaig/h43bHzTtLVjIAT01lTu3tPueYPxiTTTwLcBrtPIMLgB80ZsBARrCgxMAc8Z8TNzATkf6Kd6mpSINRFP8lttpOtyuCku9A2CpyrfRnXHi0gpTUQ/opP/nc2ybSoKtAjuqMgjVWhvDm/X+R8NvcpoF2iJXnN/Cq55mYmqlwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=f3HXxnRF; arc=fail smtp.client-ip=52.101.125.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="f3HXxnRF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=syZIhblXLirA2TOEZ7T9bt7c+eulHvR1uIxk5WvuO/qbCc+yBaCLps8h+E7HciD4myjj3z1MmE1DDR7RarO2jgl/OFGNl/Yh6ln3nIozahD4hxEQ/X13/cv1oe2oyue7/BYL8GKKlIBlWAEcA7GWAhUUt4fth/eanzDXHBhaX8mFmC6ICybL1eJ0rPA6zVEiHnPPOBYltO6zqS36sHWhFNv7N8bMT2WnM1i9hRa4Ryj/TbCooR3WsJTo1JUCRrJ0KZOVIJNKt788TdWmpOrzsXBiwRJ4w9ME8nZctkY/LaLptePyqAE6XqUAWmf+2QIjtw21JvlyF0H2hHFsoIjmmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lp6ioj2wPWXkqFLJOwgadldjUN4GHwIp4dBLeY3eXNQ=;
 b=bu2bI3DZjBekAt7cN4dHudOoFxfBeXyDPEhxT0PE1CLotE5Dkkdozk0f6n6vr53pLUhki608TAXW4Kb3/ePiU7OmccxBBT2l86LpJ6NomDBjt/DTolpc1ezRCYeYEEas+tZfQb02YOnWE5yUkfihVmNlVvbaAjfue4M91jubCykwHH+RyYZqqg+ksepgi87WnJy9A1pKR5AZcoRx2fC21XgJ9kpFtcePFK+a5MEUuqApRSJ69mSult9FzllXnBZM8pl/oqGMAQ/ZnslTYhxv/UZq9kr5Doale5nt2Yo91JoRr7JuTprLZWjWgXOImIa5dRI/11yo61VL5KoAJuWqXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lp6ioj2wPWXkqFLJOwgadldjUN4GHwIp4dBLeY3eXNQ=;
 b=f3HXxnRFILzQbnMr1pCG5G0AjvwF0O4OyZjlEibxFuRoEAkAF+gcy1pCqgvElDHg3i+Oi1KhaVMaVmADaEQF0bKwwOo3i43rj6HjmTkx364lHEQIuCa2WPcv3TNSx+Xqg7vwLXLPVBDWaT9CtBQcL8IBByOJXsbwUehQ19rahm4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB6729.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:42d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 16:51:49 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 16:51:49 +0000
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
Subject: [PATCH 07/16] NTB: ntb_transport: Negotiate direct-DMA queue layout
Date: Tue, 11 Aug 2026 01:51:26 +0900
Message-ID: <20260810165136.2292436-8-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260810165136.2292436-1-den@valinux.co.jp>
References: <20260810165136.2292436-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0210.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::19) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB6729:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f6af79f-9a57-48b5-f3b9-08def6ffabe3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|23010399003|376014|1800799024|366016|6133799003|3023799007|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	iuZ+kQ3WrozGF9mzXw7WjfT0Pp6LUyP8TX0h+A6Uu8yzEx1CUN28OPE3D5KY//c/nmbtqwBQxw6X348SztKzEPF8qz5Z95qOi43nq5rNNQArcFmFd2cx8GG5nAYVWKTemRwrOnE1AyGUCTIzIWQdaSs9pOUzf+qyvKXpYNteoRo6qFHMS27qrIDPR4G4XlJYhi6sgQKWyM/EffX82tHDHqVIuKrrYnYB07ItZsxCkLySlBETr8enVvhyaJ2GCC/RXt1xcX1EJrFxLxNb1EafFcR+3i2MJ5AmJTJ69sBb64hX0fgPj9w9vJHUM0bD5jcUNMw6rRmnqvSvRX0FXpJ4G8AZGiwyLBsURp8HV7kB0ZMTx4yFl7tliib3If6jH3cXUBXFpdJtFibpbTl/FPqrOuYSdXj6VgINZJFEL9gp9Qv5DgGGM0sGVbdYi/CPdJX6wCym0NZOFX+jeBSD/NsAfLcipshta5MibKbjXO2xpIVGyO2BUqZCmVUr4VD76Ay/uB3uwxnctapvTbIet0OboPeOGFow4OLNmCli5f14kwmJWt5CNX2fihbr4ZiD+iPpxJvjdRMX+8sdjkzjNYkRjvwGTvazWMLM1SSG2yz4hzl3L7EbpNSrIkx/E19ETtvYhBTEbV11pUiHi2B0CUKttLIEUrrgZ71TEaN6XLaoSdg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(23010399003)(376014)(1800799024)(366016)(6133799003)(3023799007)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5yCGaYg2fGBMqI/SFCAYWUs4zJhaegLYB6AVUgLtsMp3O2DAcnel8RuXwaXw?=
 =?us-ascii?Q?6zC8Uhw+G4l2QE93PEJ6bQ3wwTf5+ME9F+TA0vF1ts4rBU3OKBEACj08hWJI?=
 =?us-ascii?Q?1qD12sOjb39mM5ZyiprlzRsdw5oM92r2fbyQpfuYOKmQXg7gQczCIYCs1YNq?=
 =?us-ascii?Q?VbA7RmxL8sO6cwHgVbRsD/7VI5IQEUPiqV8GH/zS7s5AUqJ0Uexml+EVPBby?=
 =?us-ascii?Q?/xO0G8sL1ThHKTBkZ2BIOUyPH8rP8wnXy2OAc/wGIeb6Uhh5NBSPcD/1u6DX?=
 =?us-ascii?Q?oGennel7SLuWth0qS4lYVsp7+JW7Xa7IxoV5UFUua7YjrAfjwT8GIk7sU1Yb?=
 =?us-ascii?Q?MVC8vgNi3ibR5hu7GUOX8SV0HYMLvMBOzPALmPR6Q1GhqBqIpxuN8Wm4pN6t?=
 =?us-ascii?Q?JsgzNmJOREsZaopNG8LXiXgr6NetH4wLEtQPsFFMyoNWbC2GS74HxN3lAwhA?=
 =?us-ascii?Q?2Sxrs12rIcfCHG1i/Utvpe3lQSRj+lHTFYZev5IZ2DmpO/2L7qFsD6EUUlZq?=
 =?us-ascii?Q?X1JwnVIOFRKPP7k2EEkbCatQph1YwmOAhfGW/W5wBgDWtK3QWiX+V2Ag44Q2?=
 =?us-ascii?Q?d1jOx5bAz3EEFS73lM4nEnfG7sWxUwb4H2PmN6EkppTP/mMBoRv0zOG95g1y?=
 =?us-ascii?Q?eXXUYYXlsOD7VBx7jg7nfscS+JbnEDbthnmzAvA345IRAk+oOwacTrawoFKX?=
 =?us-ascii?Q?F2P+as9TczGG1AC5jJleJPXPB1P4EUHviGrFgwbVApm68dphWr+usOv7OSJV?=
 =?us-ascii?Q?RaGhqlUHIU9jrJUcryaUpMVwqBqFRMsGm4ow29j6jtCWxtC81lZdj/jubxka?=
 =?us-ascii?Q?js0pwHzZueJb+7+DyjmT9Q2wjNc/qt562R5IFouPwhMfrc1bTXskuIi30Aoc?=
 =?us-ascii?Q?CV7f4SK+s4aE8HGna4rP9NNwoMtElUcDhb64SmT6A0ljQGRAQD3ix2ZZ3njg?=
 =?us-ascii?Q?Bno+Pl74hECWxA2nJHQrqasJxt0BThHJIUREObVRmORXyxfV30il34v22Bsb?=
 =?us-ascii?Q?LxAw3dYfxCmk72yga/4Y8DrV3lUQ76ALW9OBBSWq9+ygi0q4cr/5STE+afYt?=
 =?us-ascii?Q?unDLDy+xwbPwwv9ffEGc0QpwXtOT7gGerNfKzx4O0e7bq+h36XZoMG+2lIJv?=
 =?us-ascii?Q?LjmUT5yJ2pOk7hFJgp3AFQEkASpsMgE1Z9s1mNJ59QbPYfLfbGZHroqpBYfV?=
 =?us-ascii?Q?8r5JhlFnxe7dRaDctka4pFcNzQCw50901FpfXRWSeqglK2sNgs89T6YHJ2gb?=
 =?us-ascii?Q?SSRscaJUubegs/m3ZaalPdw9oZxfudZix2W7wHtT4BKaWRTBju43lvoGVbHj?=
 =?us-ascii?Q?/oZbo+0nVA7Ux5vX6lZ4HN/dis4Ean/A+Y5ZM3jT5kW2b6u0GLo5iplqAEIf?=
 =?us-ascii?Q?0MGCJwqLKfceMNb7mklhmimn/U5BNlG6rOX07hRZWX0pExfXrwZTD7b4XA35?=
 =?us-ascii?Q?jnts/7ejLObRPAUtgWCBNvKwU4XwFCYY5zkzzKqs4oOoHaE8RURvyhsSILoR?=
 =?us-ascii?Q?wPunW5CwBbO99y+ujQJH1ChuzQe8cLZqAcTfZN/YDQBlpTpJkqOEUloytxEv?=
 =?us-ascii?Q?+R7QUq5FJ7elc56kl7XSw3TlPLa6u2hwlHEMhXN8lOYaoeogFAwFqOQMnrjy?=
 =?us-ascii?Q?DlEHCB6KOcNK4BGxkT+ofCinb9525rMYz2miZ1Chus6SOy1Gftg+WHzFk/oM?=
 =?us-ascii?Q?KNmump7qc+H2xUM10jTcNOpy8XRRzyPdiyLTGqTimj+uA6VVEexr/NBHjsZO?=
 =?us-ascii?Q?miboEmuaigjCg9Lit23fWEl41WMt599tp/NHz+8thiTP7/zw1VFU?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f6af79f-9a57-48b5-f3b9-08def6ffabe3
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 16:51:49.4565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rLsqIFpbNpXWZE2oYeeo8+a+HEVoag0UegNBOyXgYQaddtWidQ58vHx5feYvzYYrmM4NW4UbXe4nc6kJsRQimQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB6729

The direct-DMA shared area occupies part of each QP memory-window slice,
so both peers must agree on its size and placement. Exchange direct-DMA
capabilities and ring depth in spare scratchpads, and reserve the area
only when both peers advertise compatible settings. Otherwise retain the
protocol v4 copy layout.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/ntb_transport.c | 170 ++++++++++++++++++++++++++++++++++--
 1 file changed, 161 insertions(+), 9 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 44957c11d1c8..f873eacd532b 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -98,6 +98,11 @@ static bool use_dma;
 module_param(use_dma, bool, 0644);
 MODULE_PARM_DESC(use_dma, "Use DMA engine to perform large data copy");
 
+static unsigned int direct_dma_ring_entries = 64;
+module_param(direct_dma_ring_entries, uint, 0644);
+MODULE_PARM_DESC(direct_dma_ring_entries,
+		 "Number of entries in each direct-DMA queue");
+
 static bool use_msi;
 #ifdef CONFIG_NTB_MSI
 module_param(use_msi, bool, 0644);
@@ -174,6 +179,15 @@ struct ntb_transport_qp {
 	struct list_head rx_free_q;
 	/* ntb_rx_q_lock: synchronize access to rx_XXXX_q */
 	spinlock_t ntb_rx_q_lock;
+	struct ntb_direct_shared *direct_shared;
+	struct ntb_direct_shared __iomem *peer_direct_shared;
+	unsigned int direct_ring_entries;
+	u32 *direct_tx_cpl;
+	dma_addr_t direct_tx_cpl_dma;
+	u32 direct_rx_prod;
+	u32 direct_rx_cons;
+	u32 direct_tx_issue;
+	u32 direct_tx_cons;
 	void *rx_buff;
 	unsigned int rx_index;
 	unsigned int rx_max_entry;
@@ -255,6 +269,9 @@ struct ntb_transport_ctx {
 	struct work_struct link_cleanup;
 
 	struct dentry *debugfs_node_dir;
+	u32 direct_features;
+	u32 peer_direct_features;
+	unsigned int direct_ring_entries;
 
 	/* Make sure workq of link event be executed serially */
 	struct mutex link_event_lock;
@@ -315,11 +332,26 @@ struct ntb_direct_shared {
 /* Zero is pending, U32_MAX is an error, and other values are lengths. */
 #define NTB_DIRECT_CPL_ERROR		U32_MAX
 
+enum {
+	NTB_DIRECT_FEAT_RX = BIT(0),
+	NTB_DIRECT_FEAT_TX = BIT(1),
+};
+
 static inline size_t ntb_direct_shared_size(unsigned int entries)
 {
 	return struct_size_t(struct ntb_direct_shared, pub, entries);
 }
 
+static inline u32 ntb_direct_ring_idx(struct ntb_transport_qp *qp, u32 val)
+{
+	return val & (qp->direct_ring_entries - 1);
+}
+
+static inline u32 ntb_direct_ring_used(u32 head, u32 tail)
+{
+	return head - tail;
+}
+
 struct ntb_payload_header {
 	unsigned int ver;
 	unsigned int len;
@@ -335,6 +367,32 @@ enum {
 	MW0_SZ_LOW,
 };
 
+enum {
+	DIRECT_SPAD_FEATURES,
+	DIRECT_SPAD_RING_ENTRIES,
+	DIRECT_SPAD_COUNT,
+};
+
+static unsigned int ntb_direct_spad_offset(struct ntb_transport_ctx *nt)
+{
+	/* Skip two SPADs per QP reserved for optional v4 MSI descriptors. */
+	return nt->msi_spad_offset + nt->qp_count * 2;
+}
+
+static bool ntb_direct_spads_available(struct ntb_transport_ctx *nt)
+{
+	return ntb_direct_spad_offset(nt) + DIRECT_SPAD_COUNT <=
+		ntb_spad_count(nt->ndev);
+}
+
+static bool ntb_direct_layout(struct ntb_transport_ctx *nt)
+{
+	return ((nt->direct_features & NTB_DIRECT_FEAT_RX) &&
+		(nt->peer_direct_features & NTB_DIRECT_FEAT_TX)) ||
+	       ((nt->direct_features & NTB_DIRECT_FEAT_TX) &&
+		(nt->peer_direct_features & NTB_DIRECT_FEAT_RX));
+}
+
 #define dev_client_dev(__dev) \
 	container_of((__dev), struct ntb_transport_client_dev, dev)
 
@@ -635,6 +693,38 @@ static struct ntb_queue_entry *ntb_list_mv(spinlock_t *lock,
 	return entry;
 }
 
+/*
+ * Protocol v4 uses the whole area before rx_info for copy slots. Reserve the
+ * tail for direct state only when both peers negotiated a direct direction.
+ */
+static int ntb_transport_setup_qp_tx_layout(struct ntb_transport_qp *qp)
+{
+	unsigned int tx_size = qp->tx_mw_size;
+	size_t direct_size = 0;
+
+	if (ntb_direct_layout(qp->transport))
+		direct_size = ntb_direct_shared_size(qp->direct_ring_entries);
+	if (direct_size &&
+	    tx_size < direct_size + sizeof(struct ntb_rx_info) +
+		      2 * sizeof(struct ntb_payload_header))
+		return -ENOSPC;
+
+	qp->rx_info = qp->tx_mw + tx_size - sizeof(struct ntb_rx_info);
+	tx_size -= sizeof(struct ntb_rx_info);
+	if (direct_size) {
+		tx_size -= direct_size;
+		qp->peer_direct_shared = qp->tx_mw + tx_size;
+	} else {
+		qp->peer_direct_shared = NULL;
+	}
+
+	/* Ring housekeeping requires at least two buffers. */
+	qp->tx_max_frame = min(transport_mtu, tx_size / 2);
+	qp->tx_max_entry = tx_size / qp->tx_max_frame;
+
+	return 0;
+}
+
 static int ntb_transport_setup_qp_mw(struct ntb_transport_ctx *nt,
 				     unsigned int qp_num)
 {
@@ -644,6 +734,8 @@ static int ntb_transport_setup_qp_mw(struct ntb_transport_ctx *nt,
 	struct ntb_queue_entry *entry;
 	unsigned int rx_size, num_qps_mw;
 	unsigned int mw_num, mw_count, qp_count;
+	size_t direct_size = 0;
+	void *rx_base;
 	unsigned int i;
 	int node;
 
@@ -662,10 +754,24 @@ static int ntb_transport_setup_qp_mw(struct ntb_transport_ctx *nt,
 		num_qps_mw = qp_count / mw_count;
 
 	rx_size = (unsigned int)mw->xlat_size / num_qps_mw;
-	qp->rx_buff = mw->virt_addr + rx_size * (qp_num / mw_count);
+	rx_base = mw->virt_addr + rx_size * (qp_num / mw_count);
+	if (ntb_direct_layout(nt))
+		direct_size = ntb_direct_shared_size(qp->direct_ring_entries);
+	if (direct_size &&
+	    rx_size < direct_size + sizeof(struct ntb_rx_info) +
+		      2 * sizeof(struct ntb_payload_header))
+		return -ENOSPC;
+
+	qp->rx_buff = rx_base;
 	rx_size -= sizeof(struct ntb_rx_info);
-
 	qp->remote_rx_info = qp->rx_buff + rx_size;
+	if (direct_size) {
+		rx_size -= direct_size;
+		qp->direct_shared = qp->rx_buff + rx_size;
+		memset(qp->direct_shared, 0, direct_size);
+	} else {
+		qp->direct_shared = NULL;
+	}
 
 	/* Due to housekeeping, there must be atleast 2 buffs */
 	qp->rx_max_frame = min(transport_mtu, rx_size / 2);
@@ -1070,6 +1176,7 @@ static void ntb_transport_link_work(struct work_struct *work)
 	struct ntb_dev *ndev = nt->ndev;
 	struct pci_dev *pdev = ndev->pdev;
 	resource_size_t size;
+	unsigned int direct_spad;
 	u32 val;
 	int rc = 0, i, spad;
 
@@ -1106,6 +1213,15 @@ static void ntb_transport_link_work(struct work_struct *work)
 	ntb_peer_spad_write(ndev, PIDX, NUM_MWS, nt->mw_count);
 
 	ntb_peer_spad_write(ndev, PIDX, NUM_QPS, nt->qp_count);
+	if (ntb_direct_spads_available(nt)) {
+		direct_spad = ntb_direct_spad_offset(nt);
+		ntb_peer_spad_write(ndev, PIDX,
+				    direct_spad + DIRECT_SPAD_FEATURES,
+				    nt->direct_features);
+		ntb_peer_spad_write(ndev, PIDX,
+				    direct_spad + DIRECT_SPAD_RING_ENTRIES,
+				    nt->direct_ring_entries);
+	}
 
 	ntb_peer_spad_write(ndev, PIDX, VERSION, NTB_TRANSPORT_VERSION);
 
@@ -1125,6 +1241,26 @@ static void ntb_transport_link_work(struct work_struct *work)
 	if (val != nt->mw_count)
 		goto out;
 
+	nt->peer_direct_features = 0;
+	if (ntb_direct_spads_available(nt)) {
+		direct_spad = ntb_direct_spad_offset(nt);
+		val = ntb_spad_read(ndev,
+				    direct_spad + DIRECT_SPAD_FEATURES);
+		val &= NTB_DIRECT_FEAT_RX | NTB_DIRECT_FEAT_TX;
+		if (val) {
+			u32 entries;
+
+			entries = ntb_spad_read(ndev,
+						direct_spad +
+						DIRECT_SPAD_RING_ENTRIES);
+			dev_dbg(&pdev->dev,
+				"Remote direct DMA features = %#x, ring entries = %u\n",
+				val, entries);
+			if (entries == nt->direct_ring_entries)
+				nt->peer_direct_features = val;
+		}
+	}
+
 	for (i = 0; i < nt->mw_count; i++) {
 		u64 val64;
 
@@ -1143,6 +1279,9 @@ static void ntb_transport_link_work(struct work_struct *work)
 
 	nt->link_is_up = false;
 	for (i = 0; i < nt->qp_count; i++) {
+		rc = ntb_transport_setup_qp_tx_layout(&nt->qp_vec[i]);
+		if (rc)
+			goto out1;
 		rc = ntb_transport_setup_qp_mw(nt, i);
 		if (rc)
 			goto out1;
@@ -1164,6 +1303,8 @@ static void ntb_transport_link_work(struct work_struct *work)
 	for (i = 0; i < nt->qp_count; i++) {
 		struct ntb_transport_qp *qp = &nt->qp_vec[i];
 
+		qp->direct_shared = NULL;
+		qp->peer_direct_shared = NULL;
 		qp->rx_buff = NULL;
 		qp->remote_rx_info = NULL;
 	}
@@ -1254,22 +1395,20 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
 
 	tx_size = (unsigned int)mw_size / num_qps_mw;
 	qp_offset = tx_size * (qp_num / mw_count);
+	mw_base += qp_offset;
 
+	qp->direct_ring_entries = nt->direct_ring_entries;
 	qp->tx_mw_size = tx_size;
 	qp->tx_mw = nt->mw_vec[mw_num].vbase + qp_offset;
 	if (!qp->tx_mw)
 		return -EINVAL;
 
-	qp->tx_mw_phys = mw_base + qp_offset;
+	qp->tx_mw_phys = mw_base;
 	if (!qp->tx_mw_phys)
 		return -EINVAL;
 
-	tx_size -= sizeof(struct ntb_rx_info);
-	qp->rx_info = qp->tx_mw + tx_size;
-
-	/* Due to housekeeping, there must be atleast 2 buffs */
-	qp->tx_max_frame = min(transport_mtu, tx_size / 2);
-	qp->tx_max_entry = tx_size / qp->tx_max_frame;
+	if (ntb_transport_setup_qp_tx_layout(qp))
+		return -ENOSPC;
 
 	if (nt->debugfs_node_dir) {
 		char debugfs_name[8];
@@ -1337,6 +1476,7 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
 		return -ENOMEM;
 
 	nt->ndev = ndev;
+	nt->direct_ring_entries = direct_dma_ring_entries;
 
 	/*
 	 * If we are using MSI, and have at least one extra memory window,
@@ -1412,6 +1552,18 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
 	nt->qp_bitmap = qp_bitmap;
 	nt->qp_bitmap_free = qp_bitmap;
 
+	if (ntb_direct_spads_available(nt)) {
+		unsigned int spad = ntb_direct_spad_offset(nt);
+
+		/* Old v4 peers do not overwrite stale extension SPADs. */
+		rc = ntb_spad_write(ndev, spad + DIRECT_SPAD_FEATURES, 0);
+		if (rc)
+			goto err1;
+		rc = ntb_spad_write(ndev, spad + DIRECT_SPAD_RING_ENTRIES, 0);
+		if (rc)
+			goto err1;
+	}
+
 	nt->qp_vec = kcalloc_node(qp_count, sizeof(*nt->qp_vec),
 				  GFP_KERNEL, node);
 	if (!nt->qp_vec) {
-- 
2.51.0

