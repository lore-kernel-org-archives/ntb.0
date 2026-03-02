Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021129.outbound.protection.outlook.com [40.107.74.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6351D0DEE
	for <ntb@lists.linux.dev>; Mon,  2 Mar 2026 14:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772462743; cv=fail; b=SbiQdzfiCH0nU+bHOGC6tjgJWH6hhTQoJRN0eIgb+zYP8//LPPhWpGLAUmrLvKCGcKJUT3WqbPJDzJa6J+BXxSSaD3nDxdfyCsGVN4Y8ivPGoxBs16pQTT3mIWVdgGvuguh3bwK3cCIZH9vzNY/j+GMKusKLf8dYq8eunS/iQ4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772462743; c=relaxed/simple;
	bh=6W9eAwv7JL9SIBTmoSKAMVIx6d+AklrbOxZdv1ioRU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IHivHWc8LaBZ17KOrOTJB4ePVWPSdxy40mlxolAEHRjw1QPE6lkBPyjPt+F1dj5+/lqEOvLcvNIvfpqrERi6Jzt2OL0Mx6KFwucXgo4mNC0WgSR3cLQpJbjSFi5PwCDOo6A7isImWaYAgz1Im4IgO3jTi+fftXJp5IEZgrcE+xY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=n/kT+yEi; arc=fail smtp.client-ip=40.107.74.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="n/kT+yEi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z4PEkidLdQVLrUJcZAQ0tLWgz+Z3qwfAsSEf72DOGOS4t+r6SFtxpucwIcOYjwkClmLspcKaXJwbbpQkp4K50UIBZljJhRiJKijjFd1rjwOFG53H5fnSJbHK9wbtS+nJyMaQIe97BngFMN/mUH6inVBO/hOokS6vNhtsPDYIqbxZmPFLMoy13DpYa1z5gLCC8XXlws8NylvAE2Ti63iFXnICRKu/+VOlbtDk/yfi88b24SDi40c+EAicckPZ8XG0tC7dtEHnQkOFlS9s9EXxdm0XmBBH11yypUooz5xP9RwTxW/KZ0ALAI+CTBF9gKfJuJCDFUc0NPRu00n+utKeGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PHJlKD1TJZ7dqmu8A7RGGigAkD9aNSLdAcn6wv5UkeA=;
 b=TamMAW+n8OfMsS+AOwjdEI6xJb16+ii/EBnHcQnmyQlUIW5a8Lgws6CrR3gXmrAbAu5ZXRiDmrgBz2g3di8u4lj7O3b4MVxf9g1qiRaa0WoCZFsrbCf/TTI4pURzCQKHFj7DCZP1M+66IZN9nAF9WUZ6TNgjJosG4BQDQr9GlXnQnT1fIn/wyfsAEdTlzyIixOUtP+WvO0BFt2BSp0T6FFUsc2eLkQRsYWsF7eGI9gsu09yznUbp6GOOjkCH851pskkZraMUXqLdl1bf2b65dyBJvxtLc1ncs2zKlAHZTiOLXMSTLl+iZGwcNVEBJYSH/vVeDFGj8O36wcwc8f8f2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PHJlKD1TJZ7dqmu8A7RGGigAkD9aNSLdAcn6wv5UkeA=;
 b=n/kT+yEiSFjNncEFm5ixftDQYSXlIsDGhrzR9VtVIm3CVO3NkTL6S2Srwzi40qE/s8P+8YQY324Fn1yUTjbbbWLufJIXwmlgR+yBi/ml0ImdnQAck5IezGnUMIpVx1nV0F5NNIVnGXAPM+iPomEg7kI4fMtHsHew3yBqT3XQdx0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB4192.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 14:45:36 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9654.015; Mon, 2 Mar 2026
 14:45:36 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Frank Li <Frank.Li@nxp.com>
Cc: Niklas Cassel <cassel@kernel.org>,
	ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] NTB: core: Add .get_dma_dev() callback to ntb_dev_ops
Date: Mon,  2 Mar 2026 23:45:21 +0900
Message-ID: <20260302144522.750620-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260302144522.750620-1-den@valinux.co.jp>
References: <20260302144522.750620-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0004.jpnprd01.prod.outlook.com (2603:1096:405::16)
 To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB4192:EE_
X-MS-Office365-Filtering-Correlation-Id: 26610aec-0962-4b1d-488f-08de786a5d22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	n7NRLzM8bboYcmuYCH9ZEzcDB76Isl2B0PlzyPGpBExKvMOPvjFtb1I18gd8HGqtS38qCwjb6c48LImKuI/P07spfYi7ut+lT6h537uMIrl2Mbl3w0nxutBlnmxjLPvWD4q2z4Vzki+kIZj8eF6UNkXgI4TA/iMN9CXnAk84Fa+qTaqlG3R3kSZKCqEtS10agjOjwZLxHRAVDkq7ZunfwfuVB1d8fOrFxWPr8E0pW0/1ImsHFKFIiJcwLdgmejz563LuU6Sqi+l2RMQdkO/jfPh+QYc0FSR47l/zZCHGXodlRhKx7kuUIC8Ybq5/xPQD/LUBPqn8G+1CQOBWO+FN5LQpbnWg3kEGKsOSVFI/TuICyoME78sQtpvaFS9ogEZX1Aq4vrO+iVMQ9JBZm94j3JajzPlRA8G6uapmDrWbGqNxNYolV4FplP3bClk2NjK/Gsu/JVriNstJTR4QBH4p8APsdp52+SYnDQg/3EXMTMQrNHhpnZvlJe82zPlhAInFrd7x1KDyEbnqAEN/aL3RDDa15qbwMO6tFWkpvmAw3OS6qFssKRTd+3IiQmVPZEmnCdmW7yesh91zPoBbyZ2KsBhjrjLxled++LeAGyM553KZVB9yEtU0g0ETeeccK9xB7XQfStjN/i2TV9IDQuH3k3hhV+r/7TGG4kBYJ4BNKeNkDdnroQfhzWYzIZ7DFMlHY5Yq9x9O0wpmqpjIZRm8HiMIX57THSgKxUQRGL6qKMI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vT6Qa3421JwKWUa5m/t9YUv/HAlDto7jrFqeLH+d2dtypK1gMtlrlTZ8T39O?=
 =?us-ascii?Q?WSKWEXAbnsI40RsH6lzNEYVbajkTzXBCfMJxuag1tIiTUnRoiuaMuNodMA/t?=
 =?us-ascii?Q?JbPLLj3VL5x3O5CoLM9tWy5Hd8LR6uHc+h3Pa676t2pD8Tjr7QhNjKDTkZVe?=
 =?us-ascii?Q?cWKeIQ1vtthzs62GYHt6DmWMhBrxph0+ykmIq1C2cSlMT1xoDyP0zJI8Ah+8?=
 =?us-ascii?Q?EacePtwfFmharoJK/hM4SEqLiZJRQ197p+DympHlza/ReeJkBlGFT4Su2r+B?=
 =?us-ascii?Q?W01s3CnvjPYNMJvH9moGOpoHoV1R3POlgXJCHEO5zcVf2WE20ZAOQNtjUfZj?=
 =?us-ascii?Q?dYFtAcc2MhAMl55FIKXWMzs3UMtouOTh7nuDf4NK+4nxH3VsD0cAMWNFNxPO?=
 =?us-ascii?Q?D/KGM7bu2cK6Dbgw/00hsmhpisQAdzdeUyRtMmg5ZwYc6j8VxTBflD9RmprV?=
 =?us-ascii?Q?rxaZs3oWeU8VG46EtdxsNvZFkqn6VcVqe5RhZcl6cSLTA7cQINfIY7ekIQ4h?=
 =?us-ascii?Q?v+r2OZepPNyN8tdXVoyYljlQ6for9PRRLdKFxOzvfX4CNR+q1S92VXJQ2O6I?=
 =?us-ascii?Q?Dwx2c41vGPgQL2aXsB2WM6Pg5SJbIwgrY3FTfJaPB9M9PuzPRiN/dhfXuj6A?=
 =?us-ascii?Q?YYTFtfD1f3gStSnBEKuDlKo9sLoCuxvMstRPw8S/oNAznzxngZ5XMbJPBSFN?=
 =?us-ascii?Q?muSuoA3/Vsr5LG7L5HyUvDkscUZo324SG3QLldIgwVJaWQjhTYplMt2n6QE0?=
 =?us-ascii?Q?CHMX6/dS8NSRQ6swjPwDfK/jEBeynXAeES8G7fsLS8I6dFs0jM04Yx+dq4Te?=
 =?us-ascii?Q?sQuOBbEtK+Y/UMYnozy199psgflDlg4ao8NI7ov2SQiP90pSFVb9UIzkp9PP?=
 =?us-ascii?Q?U/UrzvB2e2myukFTrzDPZPzMwqBYpEEOTG3eHjRF/ZGJqOHnrPd5Ko+GhiG0?=
 =?us-ascii?Q?20LZUszbeR/nAuylXZkP3qzH+V6vzCXXECedMk8ZQPa2d2rMxbXbCsNxEvDP?=
 =?us-ascii?Q?fkFzcy6Zve1gapLzflVxmAsxvAYALpKaYDymFUaqA7NjiiGoj3/0WNDHEDEg?=
 =?us-ascii?Q?6sL0dy4MDagulRGRvEpu+tkaWePoEGdDe0Y1+m0fzL0RE9ffL/ui+wf/LPn0?=
 =?us-ascii?Q?g4bYb4r3leJUavegbJdKgXqurCFYGs3M58xeyP828ObjaLaCoJYtOQSiIBme?=
 =?us-ascii?Q?SNCoxsK4v0neOTb9cHDl5cb7L7SfXlbLTpv43wNB7YoCvEA937gL6KiHIJRh?=
 =?us-ascii?Q?zRkBjQOl/WvCCDLthSqkn9ccOYFcOSOlOkkYRJyP70xyJXzz25RL8N9MnupS?=
 =?us-ascii?Q?z/Cg2zdbswBiA4JXPlsyJ6jrD2kofjufiyYqIpOz0GLy5etj48rku/k8wnQZ?=
 =?us-ascii?Q?KD74GHFQxruycu/b/zhcvTmtxvAoJLE3uLv2XWoKljEHPjwNih0F9oOo8p99?=
 =?us-ascii?Q?LIjhv9DRsOEIJraU/Wa++hG+SHrzh5u/QS7PZZKkbuRklKfII9rb9gSRQLGY?=
 =?us-ascii?Q?QWyVjtZzky8GZ+9QrrQKAkCcaWv3LNtmvp6dX+u8TE9ORAda1LRrj9DFX79E?=
 =?us-ascii?Q?KZyQJ/UcvC5MZsOL1/TbM8qmaJLfiTy6FxT5ar12nUG6ypqOCm9kt1issr3g?=
 =?us-ascii?Q?ctB6Q77DtbwFd9kegnKAFNc56m1Bw5Wrcdh7oCXYpZpWGdrKLXBnsbp5TVQV?=
 =?us-ascii?Q?FqPd+w4UnrGalUu8g24LWvUrYmXhiyARimE68gtoMDWGYlALAL/Fvba8RWPy?=
 =?us-ascii?Q?JlmeCTiWvsYpwWbBH+m6mI+ptf8t2Z9SuMm7ZeHOKVe1qCQZPYlL?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 26610aec-0962-4b1d-488f-08de786a5d22
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 14:45:35.8054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 08jQTInV0Z7KWzWmjcDMQxxMHGucFe3VrcNeh4zuXjQxTZVUVYV5B5IiS6k3bOoiIwl+yRzORxEgThJ1/CO7lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB4192

Some NTB implementations are backed by a PCI funnction that is not the
right struct device to use with DMA API helpers (e.g. due to IOMMU
topology, or because the NTB device is virtual).

Add an optional .get_dma_dev() callback to struct ntb_dev_ops and
provide a helper, ntb_get_dma_dev(), so NTB clients can use the
appropriate struct device for DMA allocations and mappings.

If the callback is not implemented, ntb_get_dma_dev() returns the
current default (ntb->dev.parent). Drivers that implement .get_dma_dev()
must return a non-NULL device.

Suggested-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 include/linux/ntb.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/linux/ntb.h b/include/linux/ntb.h
index 8ff9d663096b..99209f957eb9 100644
--- a/include/linux/ntb.h
+++ b/include/linux/ntb.h
@@ -256,6 +256,7 @@ static inline int ntb_ctx_ops_is_valid(const struct ntb_ctx_ops *ops)
  * @msg_clear_mask:	See ntb_msg_clear_mask().
  * @msg_read:		See ntb_msg_read().
  * @peer_msg_write:	See ntb_peer_msg_write().
+ * @get_dma_dev:	See ntb_get_dma_dev().
  */
 struct ntb_dev_ops {
 	int (*port_number)(struct ntb_dev *ntb);
@@ -329,6 +330,7 @@ struct ntb_dev_ops {
 	int (*msg_clear_mask)(struct ntb_dev *ntb, u64 mask_bits);
 	u32 (*msg_read)(struct ntb_dev *ntb, int *pidx, int midx);
 	int (*peer_msg_write)(struct ntb_dev *ntb, int pidx, int midx, u32 msg);
+	struct device *(*get_dma_dev)(struct ntb_dev *ntb);
 };
 
 static inline int ntb_dev_ops_is_valid(const struct ntb_dev_ops *ops)
@@ -391,6 +393,8 @@ static inline int ntb_dev_ops_is_valid(const struct ntb_dev_ops *ops)
 		/* !ops->msg_clear_mask == !ops->msg_count	&& */
 		!ops->msg_read == !ops->msg_count		&&
 		!ops->peer_msg_write == !ops->msg_count		&&
+
+		/* ops->get_dma_dev is optional */
 		1;
 }
 
@@ -1563,6 +1567,25 @@ static inline int ntb_peer_msg_write(struct ntb_dev *ntb, int pidx, int midx,
 	return ntb->ops->peer_msg_write(ntb, pidx, midx, msg);
 }
 
+/**
+ * ntb_get_dma_dev() - get the device to use for DMA allocations/mappings
+ * @ntb:	NTB device context.
+ *
+ * Return a struct device suitable for DMA API allocations and mappings.
+ * This is typically the parent of the NTB device, but may be overridden by a
+ * driver by implementing .get_dma_dev().
+ * Drivers that implement .get_dma_dev() must return a non-NULL pointer.
+ *
+ * Return: device pointer to use for DMA operations.
+ */
+static inline struct device *ntb_get_dma_dev(struct ntb_dev *ntb)
+{
+	if (!ntb->ops->get_dma_dev)
+		return ntb->dev.parent;
+
+	return ntb->ops->get_dma_dev(ntb);
+}
+
 /**
  * ntb_peer_resource_idx() - get a resource index for a given peer idx
  * @ntb:	NTB device context.
-- 
2.51.0

