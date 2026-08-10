Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021142.outbound.protection.outlook.com [40.107.74.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40703430CFD
	for <ntb@lists.linux.dev>; Mon, 10 Aug 2026 16:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786380724; cv=fail; b=coZlQCPdMYSZuBP5erBtTa58W74mHmG51AM2idPD0duggKb8MshMUINqsYI22aKiOolCismjZlvaFYBPDsHObVZ1UjKWdpcmw74/vnM5cmpi32JzqVsrfT1gJgpJ1CSIpZKN0GMMhVcgpIj4ITjXh7cpAMahVAhqDNOy/qJ8RDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786380724; c=relaxed/simple;
	bh=Lmsd6IFhS5ADDhb1U/WzbzhiblRZIkoHT5VIU+ClpVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PVbRkU8SSxn29w7Y9LOQ/4E8Sb7tg4KsBN6Ufe25mDeDCprBbmTnbkoGPXagdCe/+sKWR2MmITNfKlpm6VmSA71gDSrCILWXwwTbJuN3Ax8TjbWgHMM4SFMLDfTcOXFf+drUm+XGtu3iGPPKkFG/s41A1uVjFTJcAljZq/bC9f0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=tsaFgxEd; arc=fail smtp.client-ip=40.107.74.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="tsaFgxEd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hXLa5eUaf9qO7RyyUefQ3Ua5yyU5e/xkq6PRchLfnNYNNVIwyF5FS9OOij9BfASNGRf7WHGg6yXxtfCovz8fbLRjh7Nu/fBbjmx8XPFeyNtUvLMi15BRIaMyi8SYGm0bb/aghbnrGqYLImz5V3fvNypvfJDeXmn8fr6o4sQm/qlikJcm6ccvM+tokGCmyia9GOvESsZ4IlnK7m+FwoSeROlQV1R5a2YLP6FKe2LQiiKmmWBqUfZmHk7EOUnhc53Hrb7f89z0iq1HT4TnGm4Mh0wXDryccf1wlMle3li9dSipYN48LTPx3T2Xjo6QIIwZuTKgc0jVXIPTWhqpnp6lew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vmltISzTcli3Hk2+SGcFUEALTn0sjGGhUgWxWL+FRF4=;
 b=CPnN0cpF0hJMpzvLYOjd273u5VT1gSYSqelrBuKZJcL1zWtUiwfl4+Rv0U7xZ6i6WQaQVpaaHCLaEl4EWvWf8IfEt+OAvlw5M6/P/fTUUJ5fbB4cFmJL+9QmD5Yrxz8+gRO6Is+xGFciQ4yFKuSX6gOmGaq4Fawwljnb5scR6Lu+6EhIROqHt7RJ2TtlWHwkVWJcCedr6PTfhDxVhU0pyzCU20Qhjdmr2C2ObHOOUtP7xU3s92FajOpct3bILD10e1e8ogQqRuH4/aSaaFBQQ8ZqiMRIK1IVzaBDWCAJXroTbR6f3qrsy0Dvw83OWzPTOp4qG5qU+QmYcLMbe1H/1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmltISzTcli3Hk2+SGcFUEALTn0sjGGhUgWxWL+FRF4=;
 b=tsaFgxEdkVnOtKmeUQfxogjYofuwNp3lqWCg7eK8yBiucogHuz4juyDoZ6G4RnHqigQoFPYSkdKk72argk354ntHT2ZrishfWgKqjTQcF0ME2D+kBxEmYZpZzX4evmUQ5ocNHWndc9KduZvQwt5bFVJ7nFLp9/hdFot5LTMTN3E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB6729.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:42d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 16:51:52 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 16:51:52 +0000
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
Subject: [PATCH 11/16] NTB: ntb_transport: Implement direct-DMA RX buffer publication
Date: Tue, 11 Aug 2026 01:51:30 +0900
Message-ID: <20260810165136.2292436-12-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260810165136.2292436-1-den@valinux.co.jp>
References: <20260810165136.2292436-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0120.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::20) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB6729:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e6b7f58-577b-4154-1721-08def6ffadba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|23010399003|376014|1800799024|366016|5023799004|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	RWMuFxD6OcTRpVC/QDchp9V+ExSrvU9nTaMKyClWcr2b8MdO4k7TdHkCvycEbHs5gZhIpZqg/Ugtg89ygdwZWHohaMEFxgEs9fDvRfdjp82ckYm2PtSImeXh2K1L4fxqT769CtNctBzR83GpjrnK2reQC6GSZ2gylPJ33YkUo7rac/EDWKAmaOVQIOPqNPRm/dLxkMK0zj+SkurEilolvxEgsteX5aFfH50xUOAn2O2MIa4h9n+MRVF5Xx8/WYlxUhPJ7lF6W71U8QtysNjY9i4l/jc5OpnGyythMI0+D11Bb4NNdln2zSZiun+R3wKUIXOa9fymbarhBO7raSuChEj0aeSFCa30D9L6QoGBosCfyTsZRWXeM3G+jo68rVyrsFwqLAnxT37wCon6QUhkuuST0bGgl7Raf5+g4jz7Dh3IqvfZyEVa7lujO+LkmUGu2WoX/dNpZK1TNjpcmrgfoPwwfGP2uAzC+uuPOHMuFzqrrkYpiT9dA97xJXIeIYyjq/7HA6bMgOIux5658dJNhXOl+P/ACzqC2n4ro8M7bxZLQC8zDXRIRj5N+Jf2AekqvZhJ+lfPzzhe4y6BbyXloRM6fCJw6dYgq24sBGbNMKgThNTy75kUx4n/K5KvlQl3uGz4Rs9p5eAkZSFp9bS4rKoeNd9muFgDecBYWmxrgtQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(23010399003)(376014)(1800799024)(366016)(5023799004)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zuYG3y4V66ofEUhjEyS5Hhnw7a8Pl2eLoU9HJiRsWYsV06xh0qwkiVQcg8QA?=
 =?us-ascii?Q?W7ziXGvyMGVmXbtX6PY3m/c3lL1W3UUAIJB0r4J/PoONbzs7RC2WhGkoV1RQ?=
 =?us-ascii?Q?GiIRccAWBY4xQMNr0A921+slp9a90KQGZRyGmtKn+pjY6bLF9vvd4MGf6bWD?=
 =?us-ascii?Q?jXTDXT/iCtU/9zD46lsBQKBolB4RekOda7Cji+rmX51yDaPJngTbwJsCJJMm?=
 =?us-ascii?Q?AZgPxOKTpR5GrWHRod0jktQyVgaW5BOF0W2VRAfX14pETm0gJd/7E3bFAS49?=
 =?us-ascii?Q?XhBzS/srgACokjWkTaWUaxNyT572fqg/ttSNg4nF+FzalELWFpbni0G0yWaq?=
 =?us-ascii?Q?YQ4sWNDg0ztXLYmEETOW/Oeu+y1XOSIxDg2oM4hfj+lNTyWjrDCWGY09jXN2?=
 =?us-ascii?Q?XsoUpImL7uAfyb3zdysN1scj7xYzPAAvu3VTBAozVpntBF1pOxb7XSKYlGYL?=
 =?us-ascii?Q?2E6XCDu5AGXuveGWWNUyUKMEIpmqJKzzgeyG08jNrL3iS08OYW4mZhmOCMio?=
 =?us-ascii?Q?XmgcjXqfJcWWhlm7InJli3aHtTrrxH9+Kv1wuKDvg1U035zHBoL9NQttYwy8?=
 =?us-ascii?Q?Z2qHPZ+UkB/4rlOmNdkDEnKzF5eA7vZflnmo0pG5VjNg+DjABKk4unFbgKm0?=
 =?us-ascii?Q?T7XrUUXI56wXQVjXdS+F9HkO+xd4/xEXJB/i4Bl0VQRIPVYsRBZIolSpHg/V?=
 =?us-ascii?Q?20pJCsuqxKzmunoc4U4wXK53xaAyNAUbJCU/JtAEb+DwUs963SGx4mFU1I4C?=
 =?us-ascii?Q?ibMedAP2zYPlkU8Q8UtS647ce48+eBzGsjxQJFROANNkSlna9uIHri9WpELz?=
 =?us-ascii?Q?B+u1n9oGQr/ysNhLvCqu/B7xoMm/MkqbeCv7s3RVbsEP9dPKo2mMDUqKGQiA?=
 =?us-ascii?Q?RaB6xRLiFJav3XSTMETFai2jP28k6UHiW9HyjzFQECtqWqcwoK2ENXaX4/dP?=
 =?us-ascii?Q?SpLJPFhgdInbYv6D8+w1TzBugDxNgWxWsWid2w1PSl/kS7tOcX5HJrkrYzTw?=
 =?us-ascii?Q?32vxNTjKWzqFQWP9e6QmKtjlahHDHZdKJYNNW2uZjMDFLFNoli0kU83ujx8B?=
 =?us-ascii?Q?4K8OlDw8cRAgpaDFVrGx1YQ0NCByYzg77HE5YJlFGn1YgoCoQs2DA/pdtEPN?=
 =?us-ascii?Q?BNo0HfhOAbmiBG/aqoIfvyRM/kEUbP+YZlMV4aR10n/soVRhURujkw17WKC6?=
 =?us-ascii?Q?XOCuPoJPcQvfixGb9QkrFHrv0XS7uO6iZSlRiDVUYYpQ2G4ytCB4Hpw4OD+V?=
 =?us-ascii?Q?A5CH3SLXV+h6lhr/tkOyoo2z4nHssTUM2vyIiFhV4iHAMxdIvUYD5mYqUqbo?=
 =?us-ascii?Q?7Kn+GBl6PTuUwKOXdnLgNdftA5dGumua0PdClvyGtBZ/JPFTA0ZdcGY04KoS?=
 =?us-ascii?Q?wc2UCzdF0mxaxt48hIdh0SPm96G5wze6OVX6gm80fJ/L2M7JJXz0pF85iQI+?=
 =?us-ascii?Q?Od1fBkSsRnQzqWH+GQDd99FYpAvwktyO+FdfjG27zo6T1tOdM0u916xUpcwg?=
 =?us-ascii?Q?h8xXlNr5c6C+3neON/tJKfDpiigVswGKHkWjtfIAIzv2wjertE7E2kzB8mKC?=
 =?us-ascii?Q?esWrdLVKrDiBNXMqD3B/HD51E5jkJbUiKvv0Hbw0pM2xn2YPzo85TJx4YQJd?=
 =?us-ascii?Q?NLzKG+ZcKeIqeTVIl8NnIb2pklSMgIWnOZVqtEqHe+Y1v6ndnQ/RzqTh0Ppq?=
 =?us-ascii?Q?L1EbUD485oicr5S3a2NAUWtlXlWt9OYHTAqNYrKCqm4HgJWaQMNt9GeTijol?=
 =?us-ascii?Q?ruSsO50iavoa5OziqwzgsIMfkiVBrWh6TYGTejLXtpjV2OqWnGb2?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e6b7f58-577b-4154-1721-08def6ffadba
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 16:51:52.5401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yXOrC/YZoISkfsg8WtTnL+RXePh5uepa7KSFvqg73r1RaUV7CP3d2OIYIYfKNpXyXdNv8jJkHUVpL1JC/g/QJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB6729

A direct-DMA sender needs the peer's RX buffer addresses, but reading a
peer-owned ring would add a non-posted PCIe round trip to the TX path.

Have the receiver map posted buffers and write each address and length
into the sender's local publication ring. Keep each mapping until its
completion is consumed, then unmap it before invoking the client
callback.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/ntb_transport.c | 219 ++++++++++++++++++++++++++++++++++++
 1 file changed, 219 insertions(+)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index ca08cb690311..152400feb6d6 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -206,6 +206,11 @@ struct ntb_transport_qp {
 	unsigned int direct_ring_entries;
 	/* Serialize direct session, TX ring, and RX publication state. */
 	spinlock_t direct_lock;
+	/*
+	 * rxc_db_work owns the direct RX queue and counters while active; teardown
+	 * accesses them only after cancel_work_sync().
+	 */
+	struct list_head direct_rx_q;
 	u32 *direct_rx_cpl;
 	dma_addr_t direct_rx_cpl_dma;
 	u32 *direct_tx_cpl;
@@ -224,6 +229,7 @@ struct ntb_transport_qp {
 	unsigned int rx_alloc_entry;
 	dma_cookie_t last_cookie;
 	struct work_struct rxc_db_work;
+	struct delayed_work direct_rx_retry;
 
 	void (*event_handler)(void *data, int status);
 	struct delayed_work link_work;
@@ -524,6 +530,7 @@ static bool ntb_direct_layout(struct ntb_transport_ctx *nt)
 #define NTB_QP_DEF_NUM_ENTRIES	100
 #define NTB_LINK_DOWN_TIMEOUT	10
 #define NTB_DIRECT_TEARDOWN_RETRY_INTERVAL_MS	10
+#define NTB_DIRECT_RX_RETRY_INTERVAL_MS	10
 
 static bool ntb_direct_rx_mode(struct ntb_transport_qp *qp)
 {
@@ -764,6 +771,8 @@ unsigned int ntb_transport_rx_queue_size(struct ntb_transport_qp *qp)
 EXPORT_SYMBOL_GPL(ntb_transport_rx_queue_size);
 
 static void ntb_transport_rxc_db(struct work_struct *work);
+static void ntb_direct_rx_retry_work(struct work_struct *work);
+static void ntb_direct_rx_reclaim(struct ntb_transport_qp *qp);
 static const struct ntb_ctx_ops ntb_transport_ops;
 static struct ntb_client ntb_transport_client;
 static int ntb_async_tx_submit(struct ntb_transport_qp *qp,
@@ -1447,6 +1456,15 @@ static void ntb_qp_link_context_reset(struct ntb_transport_qp *qp)
 
 static void ntb_qp_link_down_reset(struct ntb_transport_qp *qp)
 {
+	if (ntb_direct_link_capable(qp)) {
+		qp->active = false;
+		cancel_delayed_work_sync(&qp->direct_rx_retry);
+		cancel_work_sync(&qp->rxc_db_work);
+		/* Catch a retry armed while draining RX work. */
+		cancel_delayed_work_sync(&qp->direct_rx_retry);
+		ntb_direct_rx_reclaim(qp);
+	}
+
 	ntb_qp_link_context_reset(qp);
 	if (qp->remote_rx_info)
 		qp->remote_rx_info->entry = qp->rx_max_entry - 1;
@@ -1811,8 +1829,10 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
 	INIT_LIST_HEAD(&qp->rx_free_q);
 	INIT_LIST_HEAD(&qp->tx_free_q);
 	INIT_LIST_HEAD(&qp->tx_offl_q);
+	INIT_LIST_HEAD(&qp->direct_rx_q);
 
 	INIT_WORK(&qp->rxc_db_work, ntb_transport_rxc_db);
+	INIT_DELAYED_WORK(&qp->direct_rx_retry, ntb_direct_rx_retry_work);
 
 	return 0;
 }
@@ -2219,6 +2239,195 @@ static void ntb_async_rx(struct ntb_queue_entry *entry, void *offset)
 	qp->rx_memcpy++;
 }
 
+static bool ntb_direct_rx_enabled(struct ntb_transport_qp *qp)
+{
+	return READ_ONCE(qp->direct_state) == NTB_DIRECT_ACTIVE &&
+	       ntb_direct_rx_mode(qp);
+}
+
+static bool ntb_direct_rx_can_complete(struct ntb_transport_qp *qp)
+{
+	enum ntb_direct_state state = READ_ONCE(qp->direct_state);
+
+	return (state == NTB_DIRECT_ACTIVE || state == NTB_DIRECT_QUIESCING) &&
+	       ntb_direct_rx_mode(qp);
+}
+
+static int ntb_direct_rx_publish(struct ntb_transport_qp *qp,
+				 struct ntb_queue_entry *entry)
+{
+	struct ntb_direct_pub __iomem *pub;
+	struct device *dma_dev;
+	dma_addr_t dma_addr;
+	u32 head, idx;
+	int rc = 0;
+
+	dma_dev = qp->transport->direct_dma_dev;
+	dma_addr = dma_map_single(dma_dev, entry->buf, entry->len,
+				  DMA_FROM_DEVICE);
+	if (dma_mapping_error(dma_dev, dma_addr))
+		return -EIO;
+
+	scoped_guard(spinlock_bh, &qp->direct_lock) {
+		if (!ntb_direct_rx_enabled(qp)) {
+			rc = -EOPNOTSUPP;
+			goto unmap;
+		}
+
+		head = qp->direct_rx_prod;
+		if (ntb_direct_ring_used(head, qp->direct_rx_cons) >=
+		    qp->direct_ring_entries - 1) {
+			rc = -ENOSPC;
+			goto unmap;
+		}
+
+		idx = ntb_direct_ring_idx(qp, head);
+		entry->direct_dma_addr = dma_addr;
+		list_add_tail(&entry->entry, &qp->direct_rx_q);
+
+		WRITE_ONCE(qp->direct_rx_cpl[idx], 0);
+		/* Publish the slot only after its completion target is clear. */
+		dma_wmb();
+		pub = &qp->peer_direct_shared->pub[idx];
+		iowrite32(lower_32_bits(dma_addr), &pub->addr_lo);
+		iowrite32(upper_32_bits(dma_addr), &pub->addr_hi);
+		iowrite32(entry->len, &pub->len);
+		iowrite32(head + 1, &qp->peer_direct_shared->pub_head);
+		WRITE_ONCE(qp->direct_rx_prod, head + 1);
+	}
+
+	return 0;
+
+unmap:
+	dma_unmap_single(dma_dev, dma_addr, entry->len, DMA_FROM_DEVICE);
+
+	return rc;
+}
+
+static void ntb_direct_rx_retry_work(struct work_struct *work)
+{
+	struct ntb_transport_qp *qp =
+		container_of(to_delayed_work(work), struct ntb_transport_qp,
+			     direct_rx_retry);
+
+	queue_work(system_dfl_wq, &qp->rxc_db_work);
+}
+
+static void ntb_direct_rx_replenish(struct ntb_transport_qp *qp)
+{
+	struct ntb_queue_entry *entry;
+	int rc;
+
+	while ((entry = ntb_list_rm(&qp->ntb_rx_q_lock, &qp->rx_pend_q))) {
+		rc = ntb_direct_rx_publish(qp, entry);
+		if (!rc)
+			continue;
+
+		ntb_list_add(&qp->ntb_rx_q_lock, &entry->entry,
+			     &qp->rx_pend_q);
+		if (rc == -EIO) {
+			dev_warn_ratelimited(&qp->ndev->pdev->dev,
+					     "qp %d: failed to map direct RX buffer; retrying\n",
+					     qp->qp_num);
+			/* Avoid hot-looping rxc_db_work on a persistent failure. */
+			mod_delayed_work(system_dfl_wq, &qp->direct_rx_retry,
+					 msecs_to_jiffies(NTB_DIRECT_RX_RETRY_INTERVAL_MS));
+		}
+		break;
+	}
+}
+
+static u32 ntb_direct_rx_completion_word(struct ntb_transport_qp *qp)
+{
+	u32 cons, prod, idx;
+
+	cons = READ_ONCE(qp->direct_rx_cons);
+	prod = READ_ONCE(qp->direct_rx_prod);
+	if (!ntb_direct_ring_used(prod, cons))
+		return 0;
+
+	idx = ntb_direct_ring_idx(qp, cons);
+	return READ_ONCE(qp->direct_rx_cpl[idx]);
+}
+
+static bool ntb_direct_rx_complete_one(struct ntb_transport_qp *qp)
+{
+	struct ntb_queue_entry *entry;
+	struct device *dma_dev;
+	void *cb_data;
+	bool notify;
+	int cb_len;
+	u32 word;
+
+	word = ntb_direct_rx_completion_word(qp);
+	if (!word)
+		return false;
+
+	entry = list_first_entry_or_null(&qp->direct_rx_q,
+					 struct ntb_queue_entry, entry);
+	if (WARN_ON_ONCE(!entry))
+		return false;
+
+	/* The completion DMA follows the payload on the same channel. */
+	dma_rmb();
+	list_del(&entry->entry);
+	WRITE_ONCE(qp->direct_rx_cons, READ_ONCE(qp->direct_rx_cons) + 1);
+
+	dma_dev = qp->transport->direct_dma_dev;
+	dma_unmap_single(dma_dev, entry->direct_dma_addr, entry->len,
+			 DMA_FROM_DEVICE);
+	cb_data = entry->cb_data;
+
+	if (word == NTB_DIRECT_CPL_ERROR) {
+		cb_len = -EIO;
+	} else if (word > INT_MAX || word > entry->len) {
+		qp->rx_err_oflow++;
+		cb_len = -EIO;
+	} else {
+		qp->rx_bytes += word;
+		qp->rx_pkts++;
+		cb_len = word;
+	}
+
+	notify = qp->client_ready && qp->rx_handler;
+	if (notify)
+		ntb_list_add(&qp->ntb_rx_q_lock, &entry->entry, &qp->rx_free_q);
+	else
+		ntb_list_add(&qp->ntb_rx_q_lock, &entry->entry, &qp->rx_pend_q);
+
+	if (notify)
+		qp->rx_handler(qp, qp->cb_data, cb_data, cb_len);
+
+	return true;
+}
+
+static void ntb_direct_rx_complete(struct ntb_transport_qp *qp)
+{
+	unsigned int count;
+
+	for (count = 0; count < qp->direct_ring_entries; count++)
+		if (!ntb_direct_rx_complete_one(qp))
+			break;
+}
+
+static void ntb_direct_rx_reclaim(struct ntb_transport_qp *qp)
+{
+	struct ntb_queue_entry *entry;
+	struct device *dma_dev;
+	LIST_HEAD(reclaim);
+
+	dma_dev = qp->transport->direct_dma_dev;
+	list_splice_init(&qp->direct_rx_q, &reclaim);
+
+	list_for_each_entry(entry, &reclaim, entry) {
+		dma_unmap_single(dma_dev, entry->direct_dma_addr, entry->len,
+				 DMA_FROM_DEVICE);
+	}
+
+	guard(spinlock_irqsave)(&qp->ntb_rx_q_lock);
+	list_splice_tail(&reclaim, &qp->rx_pend_q);
+}
+
 static int ntb_process_rxc(struct ntb_transport_qp *qp)
 {
 	struct ntb_payload_header *hdr;
@@ -2304,6 +2513,12 @@ static void ntb_transport_rxc_db(struct work_struct *work)
 		ntb_direct_control_progress(qp);
 	if (!qp->active)
 		goto clear_db;
+	if (ntb_direct_rx_can_complete(qp)) {
+		ntb_direct_rx_complete(qp);
+		if (ntb_direct_rx_enabled(qp))
+			ntb_direct_rx_replenish(qp);
+		goto clear_db;
+	}
 
 	/* Limit the number of packets processed in a single interrupt to
 	 * provide fairness to others
@@ -2886,11 +3101,15 @@ void ntb_transport_free_queue(struct ntb_transport_qp *qp)
 	qp_bit = BIT_ULL(qp->qp_num);
 
 	ntb_db_set_mask(qp->ndev, qp_bit);
+	cancel_delayed_work_sync(&qp->direct_rx_retry);
 	cancel_work_sync(&qp->rxc_db_work);
+	/* Catch a retry armed while draining RX work. */
+	cancel_delayed_work_sync(&qp->direct_rx_retry);
 
 	/* Catch cleanup queued while draining RX processing. */
 	cancel_work_sync(&qp->link_cleanup);
 	cancel_delayed_work_sync(&qp->link_work);
+	ntb_direct_rx_reclaim(qp);
 	ntb_qp_link_context_reset(qp);
 
 	qp->cb_data = NULL;
-- 
2.51.0

