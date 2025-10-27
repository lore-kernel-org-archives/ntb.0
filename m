Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010004.outbound.protection.outlook.com [52.101.229.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2342F30EF97
	for <ntb@lists.linux.dev>; Mon, 27 Oct 2025 00:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761525829; cv=fail; b=WR5e3FIqm3fRoTTP+qjI+0xUZSyTGn5P0mhOP5bsgtflKrdmQDQruaM22MD/GPpCKCp/RpvW3QYsm+rLMBehRbFhMD2JNwmXQZ0LO+WHjv+y+ffoqJTkEf/aWm/mOjVX4uksK+GjxrgavuuDB0dZOOTb1G5X3Logpe4sBDCEpgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761525829; c=relaxed/simple;
	bh=/nJVpHokSVj0cqTBExRjwLlBLGdVD/gzFHLqZkp/iHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A40LqH3qeVPCettxYa+oKFEGXkUD6hR4bT1VHk7AC5ids9l8i/UFv3uycQ2GtJHdygX2CSJ7mNZML9i15kL28DhL00sQIXotxFJB82ss1uTvhRcCocMBOkMMuC64BHo/hSGhGLt96KrCize/zMwVq+3WAvmcK4BuXRYTcSx67Kw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=n/0jZyRS; arc=fail smtp.client-ip=52.101.229.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="n/0jZyRS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OGrmTyN8vOQmVNezzkt1wP8JnbdEtvbevcjK6oJ7PiB4v1jdvEHEiHZhW+et2WAYPGb4nyyLKJ+FSNVh8qjF8lnGf06uXo7zz3swHWBN/e2gpiHaAQVwMTCHLPM6SFCZyamPErvwURmD5o50HoXMEO8w6tES+m0mssa9tSmAWCSLYM1+eylKblQcryXTobrhlOJRE8wMY4UOKQuF4N6qXdO9dMAnQp3VTNAq1UeR1fdocvuvZHPWmAwxG6MktdNSuYgw2YDf9+xpMdifzqV9scjwxArrZuPR6BGC7uHfRZpYOVbpwrM9rPja6I0yD+H06ysh7MJ3Zn6vuFsDJ+LQvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9yt7k7Ibn+5Y8zD76bXKJDdvZAjPBv5vIsS87eeDl9A=;
 b=lVeZm+l5UDwReGQdwp0ABfF5TUN1DwODw1etbmrBKWwQI/wKCzuY/NhKmNNh5kLjmilDEyesnF5JAyuYuiwebcJCeAm8EHoVOP7NAPEdJvq/+JfAcgkT/5ngpCkKcMfpOZOz1faKBPUZPZS9/pDrr3DlDiCafvJTv1KBCPTEuwJtWRWBeJzNfloXNGOk68UpjSPibe0E4gyUKsTyztkN5GizSLTiqJvec8BT78LXUsj6ZKOGtkrdJUJEoscgIt1eit7q0C8pijsFoMuoAiVfRiV+TFZwtQ4ccwDQLEgUGX0UW6re6lOm2DtYT0X2U2OPzjYpK8iIzmRUXIQDNcsw8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9yt7k7Ibn+5Y8zD76bXKJDdvZAjPBv5vIsS87eeDl9A=;
 b=n/0jZyRSyxPf3WSbvAdUbSqEEVd/d5Y8Ck8YyCT3RvHjv6yFlgm/byMWslxHkdmaKChvdUVdGiosZfmuE+CqeUnaSL32XLbVHFdpfS69ay2ATnqkzTwu1SjH4kMmR75NWu8CWBSNjUw0qNhgf9wUD8Ivqh1BVV3vuOL0ueBGboY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:10d::7)
 by TYTP286MB3461.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:39f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 00:43:42 +0000
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a]) by OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a%5]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 00:43:41 +0000
From: Koichiro Den <den@valinux.co.jp>
To: ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com
Subject: [PATCH 4/4] NTB: ntb_transport: Support multi-channel DMA via module parameters
Date: Mon, 27 Oct 2025 09:43:31 +0900
Message-ID: <20251027004331.562345-5-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251027004331.562345-1-den@valinux.co.jp>
References: <20251027004331.562345-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0160.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::13) To OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:10d::7)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB0979:EE_|TYTP286MB3461:EE_
X-MS-Office365-Filtering-Correlation-Id: f05d52ea-a865-490e-0c5d-08de14f1e055
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6Rfnysu2lxtunQiTilpzsDiXfnQlj4XT2j9WP1DQX0cnHhh3nc4ZsUSaxTOI?=
 =?us-ascii?Q?OJbtT5XWFe31b0v4XP3wanO83JClWlHAQQH0+xv2WzSQNTuXa+9Fe/Ep+Sgl?=
 =?us-ascii?Q?ytMtjBhKMLu+ZprapgqG96f1gOmf4dfHJbwYZjyW6+EsIGhh1Nt6NENMSNim?=
 =?us-ascii?Q?cPxectzf8hWwM5gfnlPRVVSa1RhGoux7+/Yi/f8C1bz5C+gZ9HX+g2qnWw6+?=
 =?us-ascii?Q?qmgvNg+TbVe6HxX9t1aYpcq1+gkVaJiuGsMgCEuiO5NiEaVS5goK3pp7lj/l?=
 =?us-ascii?Q?kElsO0rbwm25tGF5Gzb51ESNy0zdUhHZQkfMcZfSvjHBg2mxfM5dFPLTXway?=
 =?us-ascii?Q?k6h6punD433pHao1RbgBfp9XU1TtQPs2R5KDdL35QNOIgswDGDEFO9hgmxqy?=
 =?us-ascii?Q?Vx9tPfX8tIfaRRsjZxt0pZK8Z9HmlglecF5oM1WgIAZxnog81TKfRfXIG0pE?=
 =?us-ascii?Q?ElFBM1rCZfw6J9QkUAu1WT+BFPONCi0c4chY5cmxWEGBrOMciK9lHNBtgDcK?=
 =?us-ascii?Q?+MmIJcQuPuvOXfSMqwUUFC7IHCgjG54n1idgc+z0VOXaOIVpw418oRXBRLC6?=
 =?us-ascii?Q?y7rRW3yz2lFF6jx9zvfX/PClSqYm6JRo09iQls5ITEObkXDZsNBiufgCHgIj?=
 =?us-ascii?Q?eeUQIMhtaZ8uDnox6z3udZLHKQy59CvrvxX4pFtkPeGT9dtipnqdhXQkYk/2?=
 =?us-ascii?Q?YYAuehp+f8Yl3OMQbpKruMz8yNFxUMvxRdELioN+7GjkJZPe7P8ffkX8h8kb?=
 =?us-ascii?Q?Lw87Oaz18FFSlqho+JYFMwjbSL8BCaRlAr3F1fe0W4MGm+no4kGHGK4PSc/E?=
 =?us-ascii?Q?9qkT3oN+GYKiRVHIhpQ0C3Hl1GCRQkU6i2600sxw1+ETI3/pVx6y7zaGJpeh?=
 =?us-ascii?Q?ZSzc381xM0FXjiAibg4ry8g4BfGNvavkzsVhhQmedA36WmWDyrADy0YW4oZ2?=
 =?us-ascii?Q?RwXMuOEx/bBnaqbPl3PLegm98B2/G2G2gG5VFxvvCNC+Gtuk3SW7lsJeCj+7?=
 =?us-ascii?Q?l8ovLWbLWeG1ro4btB3vwtgibsmr47h6WYqD4tmgFhMLg6qwr3BOn2dipGvR?=
 =?us-ascii?Q?+Nl4+Ft+h+kAZkFiWDhT6dBrMyEP6z6OHlywJd7aZ6beHiObBbbD7exgcv8w?=
 =?us-ascii?Q?osHTRMVyKsgogMybm5qDv4m4Tu4kiq2y1jF2nXiDoN8F3ybkUjruJXRdUwsZ?=
 =?us-ascii?Q?JYFlPDXhiq70i4vKOj2ozrd/V7l/SRngQD3McSBCrOhXOFfCsYStNzl3XpQL?=
 =?us-ascii?Q?AEw5f8Ew4Cmr4QrHa1ie8tzaEzFfq7Xq/vjJMWRFGyb+HtFWWI1s2RV8843y?=
 =?us-ascii?Q?eWv7CamOkspha73SoXRH7bdsQppuAxBXthl7caA/qMezSkFZi/PabIhnnzNu?=
 =?us-ascii?Q?1vH6sM1FSK0YzbJEdj40O2tSXOYl66beRnQ40bp2jEgfVAOkrrYViHhK4M55?=
 =?us-ascii?Q?z2uxVHTOsKG7qJ4M+H/X2g0IHRQvP7wT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c7Ub5LYyZp2YE07bS9ktUTXqt8vn3QS7OHFTrXrP5akT1fCWtl4ZBelr+7HF?=
 =?us-ascii?Q?vWGCc4lEBfHNHhlYhEqDGux/5NAs9+aMxZXZww9o4yYuOQBiGz+9EToYCjaX?=
 =?us-ascii?Q?Z4gPKhlkE4JblQv5NUP3hv3P3JFK/Dki1T28nfzz1jd0Ja3GZ0unYMCitPDN?=
 =?us-ascii?Q?qWdcjrMZfxsLuuAr589AeM3pad+47tbDcvu2HIOiA2d7tq5g/Agmm9wK/nM5?=
 =?us-ascii?Q?wTUzc8I6HkV3uaCbJ/JurtDbfh9luymxtNqG8IMAozCLUdJ0vCYEv9heb5Ew?=
 =?us-ascii?Q?9pzkHnw3x5/E0Uvj1wfMv2sqJ9hQj4kkyZd0oigsqMqeKu5pTV3JIc8P1Lia?=
 =?us-ascii?Q?XeBSDZNAaUjKmXDzyIis6/Vhq2RV08VjRUpQrjV+GmNCqNBfiq8+sdU/pR42?=
 =?us-ascii?Q?eSOlRbEucMoI5sNAyJ+DJWKxmTdVg/BoE86GZ5nLvYAZIUIrkDDEokR2xUW+?=
 =?us-ascii?Q?Qyc7IVQevoQ8lWBaQNvivjf/PYuecq6F2O8gs0/a6DO7yamOAypG9Ke7xtwT?=
 =?us-ascii?Q?Lja2kDWMCusXyYznrmmexkbpnpi0fIgbIa48OMa70+jwj/D2XT14CL+tKBsN?=
 =?us-ascii?Q?bGt+Cd/8vhSGrsEl76kAUTGZfT/dF/gKAdXP0OWoFLHQKw/rLTYnjO2j59xf?=
 =?us-ascii?Q?WIDTm3dBrnLt/fJHJXwF82DGH3Q4HkWa2xBEHEJliMYH9pAeymmxTHHZvDS1?=
 =?us-ascii?Q?txdN9aKJMkUoqX0SworOt98+csPhNMLmm/wnEaLPK16iMJiyG5/AcCx+pMUf?=
 =?us-ascii?Q?RoCtB3nLyUMhnUgdjvORHnccbO4r1+8sb9JgRjDm6kbDIRUw7AsT7zZDzah1?=
 =?us-ascii?Q?jpuvFoMF6JxSO4mqj25a8/a8qdzyMgY8v71fNX6POffiRCFOqCaYdqE745iE?=
 =?us-ascii?Q?zf6TXErlj0G9iDN2+eGb1sZ/guGy7oQfKHvmtKhb5wfgd3mSQlHaSXjGMxRj?=
 =?us-ascii?Q?Ejuu5j4DindrVIYwGIA/RtSJD0yhwlLeDpsXXyfeZs7Xaligz8jzRJO0PVyN?=
 =?us-ascii?Q?OloB0Ow2ZPplNgWo0MBrP5/iiHtbFUKl1D731QRez98kc9UrtsMoqUK8DwGI?=
 =?us-ascii?Q?ula3qXsclltODRmoQjz6nTfJww80s95cHroHryAZYnjG/qvmEGrTVoOxW6kt?=
 =?us-ascii?Q?14ndfAMC8KF+pcS6gq2qvgRoAlDfCCleCyUk+MHSsbvq0kJAxooVvzG5m5yx?=
 =?us-ascii?Q?VyvtyqvMfP9QoEMuNi51F63YlIInOd/OGZGtPLnsjwZaa2rnS0KnPf36BENo?=
 =?us-ascii?Q?+C6aoDeUYvV/5uNw15cPv2WN/hWkM+cA1D1ym7KoLvKrMv/4grf1ZBix/iCQ?=
 =?us-ascii?Q?YkCaxyS6pSACmtIHpfXIcwSVGBsTnd2szTOe9L6mM0bg7I2sNhe2KbC43P+J?=
 =?us-ascii?Q?8vjLwJySpXhPW6/DoyXVbHmT/3TbKy/1MopG2x3sbliSlk9TcryGL89JZ+S7?=
 =?us-ascii?Q?4g0aKvwMy/dWMyVEWEHpG2Ct6V3ycnNCenrEnjC0MYQB5snXKDGp7yqemQCM?=
 =?us-ascii?Q?XtQCztmTKckKTpSQsWjHsMaODnfUN+mmKK8ZcNuKn+fP4Qzy4V4xwUC1rjpB?=
 =?us-ascii?Q?ylXkPg0rcLfQXyFNglfEAzqCJX59ypzQENzDLqNYSpeDY7rBdZSAFN5BUeHj?=
 =?us-ascii?Q?YkGoN5my70bVVWhhcU9dzn8=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: f05d52ea-a865-490e-0c5d-08de14f1e055
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 00:43:41.8942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zjyx99NyCIvAi0631Bi8LJIPq2kgqg4KKlSQrBpVK52y1Gt1HobhlvV513bwI1t3Gt5FU0QE3DC+IYiHtU4+cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYTP286MB3461

The reclamation delay of ntb_queue_entry can be a key performance
limiter and the MEMCPY portion often accounts for a large part of the
round-trip latency when DMA MEMCPY is used. Distributing work across
multiple channels can improve overall throughput on busy systems by
increasing the average service rate of the MEMCPY part, as observed on
R-Car S4.

Allow ntb_transport to use multiple DMA engine channels per queue to
better utilize hardware under load with the new module parameters:

  - num_tx_dma_chan: TX DMA channels per queue (default 1)
  - num_rx_dma_chan: RX DMA channels per queue (default 1)

Channel selection is a simple round-robin driven by an atomic counter.
A least-used policy was also tested on R-Car S4, but showed not much
benefit, so the simpler round-robin approach is chosen.

Behavior is unchanged when DMA is disabled or only one channel is used,
and the CPU memcpy fallback remains.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/ntb_transport.c | 368 ++++++++++++++++++++++++------------
 1 file changed, 252 insertions(+), 116 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index aee6793812bc..1860e15295b3 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -47,6 +47,7 @@
  * Contact Information:
  * Jon Mason <jon.mason@intel.com>
  */
+#include <linux/atomic.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/dmaengine.h>
@@ -102,6 +103,14 @@ static bool use_rx_dma;
 module_param(use_rx_dma, bool, 0644);
 MODULE_PARM_DESC(use_rx_dma, "Use DMA engine to perform large data copy on RX");
 
+static unsigned int num_tx_dma_chan = 1;
+module_param(num_tx_dma_chan, uint, 0644);
+MODULE_PARM_DESC(num_tx_dma_chan, "Number of TX DMA channels per queue (round-robin). 1 by default");
+
+static unsigned int num_rx_dma_chan = 1;
+module_param(num_rx_dma_chan, uint, 0644);
+MODULE_PARM_DESC(num_rx_dma_chan, "Number of RX DMA channels per queue (round-robin). 1 by default");
+
 static bool use_msi;
 #ifdef CONFIG_NTB_MSI
 module_param(use_msi, bool, 0644);
@@ -137,12 +146,21 @@ struct ntb_rx_info {
 	unsigned int entry;
 };
 
+struct ntb_transport_dma {
+	struct dma_chan **chan;
+	unsigned int num_chan;
+	atomic_t cur_chan;
+	/* cache for graceful teardown */
+	dma_cookie_t *last_cookie;
+};
+
 struct ntb_transport_qp {
 	struct ntb_transport_ctx *transport;
 	struct ntb_dev *ndev;
 	void *cb_data;
-	struct dma_chan *tx_dma_chan;
-	struct dma_chan *rx_dma_chan;
+
+	struct ntb_transport_dma tx_dma;
+	struct ntb_transport_dma rx_dma;
 
 	bool client_ready;
 	bool link_is_up;
@@ -161,7 +179,7 @@ struct ntb_transport_qp {
 	void __iomem *tx_mw;
 	phys_addr_t tx_mw_phys;
 	size_t tx_mw_size;
-	dma_addr_t tx_mw_dma_addr;
+	dma_addr_t *tx_mw_dma_addr;
 	unsigned int tx_index;
 	unsigned int tx_max_entry;
 	unsigned int tx_max_frame;
@@ -178,7 +196,6 @@ struct ntb_transport_qp {
 	unsigned int rx_max_entry;
 	unsigned int rx_max_frame;
 	unsigned int rx_alloc_entry;
-	dma_cookie_t last_cookie;
 	struct tasklet_struct rxc_db_work;
 
 	void (*event_handler)(void *data, int status);
@@ -549,10 +566,10 @@ static ssize_t debugfs_read(struct file *filp, char __user *ubuf, size_t count,
 			       "\n");
 	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
 			       "Using TX DMA - \t%s\n",
-			       qp->tx_dma_chan ? "Yes" : "No");
+			       qp->tx_dma.num_chan > 0 ? "Yes" : "No");
 	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
 			       "Using RX DMA - \t%s\n",
-			       qp->rx_dma_chan ? "Yes" : "No");
+			       qp->rx_dma.num_chan > 0 ? "Yes" : "No");
 	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
 			       "QP Link - \t%s\n",
 			       qp->link_is_up ? "Up" : "Down");
@@ -1559,16 +1576,43 @@ static inline struct page *ntb_vaddr_to_page(const void *addr)
 	return is_vmalloc_addr(addr) ? vmalloc_to_page(addr) : virt_to_page(addr);
 }
 
+static inline struct dma_chan *
+ntb_pick_dma_chan(struct ntb_transport_dma *dma, unsigned int *idx_out)
+{
+	unsigned int n = dma->num_chan;
+	unsigned int cur, idx;
+
+	if (unlikely(!n))
+		return NULL;
+
+	if (n == 1) {
+		if (idx_out)
+			*idx_out = 0;
+		return dma->chan[0];
+	}
+
+	cur = (unsigned int)atomic_inc_return(&dma->cur_chan) - 1;
+	idx = cur % n;
+	if (idx_out)
+		*idx_out = idx;
+	return dma->chan[idx];
+}
+
 static int ntb_async_rx_submit(struct ntb_queue_entry *entry, void *offset)
 {
-	struct dma_async_tx_descriptor *txd;
 	struct ntb_transport_qp *qp = entry->qp;
-	struct dma_chan *chan = qp->rx_dma_chan;
-	struct dma_device *device;
-	size_t pay_off, buff_off, len;
+	struct dma_async_tx_descriptor *txd;
 	struct dmaengine_unmap_data *unmap;
-	dma_cookie_t cookie;
+	size_t pay_off, buff_off, len;
+	struct dma_device *device;
 	void *buf = entry->buf;
+	struct dma_chan *chan;
+	unsigned int cidx = 0;
+	dma_cookie_t cookie;
+
+	chan = ntb_pick_dma_chan(&qp->rx_dma, &cidx);
+	if (unlikely(!chan))
+		return -ENODEV;
 
 	len = entry->len;
 	device = chan->device;
@@ -1613,7 +1657,9 @@ static int ntb_async_rx_submit(struct ntb_queue_entry *entry, void *offset)
 
 	dmaengine_unmap_put(unmap);
 
-	qp->last_cookie = cookie;
+	dma_async_issue_pending(chan);
+
+	qp->rx_dma.last_cookie[cidx] = cookie;
 
 	qp->rx_async++;
 
@@ -1630,10 +1676,9 @@ static int ntb_async_rx_submit(struct ntb_queue_entry *entry, void *offset)
 static void ntb_async_rx(struct ntb_queue_entry *entry, void *offset)
 {
 	struct ntb_transport_qp *qp = entry->qp;
-	struct dma_chan *chan = qp->rx_dma_chan;
 	int res;
 
-	if (!chan)
+	if (!qp->rx_dma.chan)
 		goto err;
 
 	if (entry->len < copy_bytes)
@@ -1742,9 +1787,6 @@ static void ntb_transport_rxc_db(unsigned long data)
 			break;
 	}
 
-	if (i && qp->rx_dma_chan)
-		dma_async_issue_pending(qp->rx_dma_chan);
-
 	if (i == qp->rx_max_entry) {
 		/* there is more work to do */
 		if (qp->active)
@@ -1842,17 +1884,22 @@ static int ntb_async_tx_submit(struct ntb_transport_qp *qp,
 			       struct ntb_queue_entry *entry)
 {
 	struct dma_async_tx_descriptor *txd;
-	struct dma_chan *chan = qp->tx_dma_chan;
+	struct dmaengine_unmap_data *unmap;
 	struct dma_device *device;
+	size_t dest_off, buff_off;
 	size_t len = entry->len;
 	void *buf = entry->buf;
-	size_t dest_off, buff_off;
-	struct dmaengine_unmap_data *unmap;
-	dma_addr_t dest;
+	struct dma_chan *chan;
+	unsigned int cidx = 0;
 	dma_cookie_t cookie;
+	dma_addr_t dest;
+
+	chan = ntb_pick_dma_chan(&qp->tx_dma, &cidx);
+	if (unlikely(!chan))
+		return -ENODEV;
 
 	device = chan->device;
-	dest = qp->tx_mw_dma_addr + qp->tx_max_frame * entry->tx_index;
+	dest = qp->tx_mw_dma_addr[cidx] + qp->tx_max_frame * entry->tx_index;
 	buff_off = (size_t)buf & ~PAGE_MASK;
 	dest_off = (size_t)dest & ~PAGE_MASK;
 
@@ -1901,7 +1948,6 @@ static void ntb_async_tx(struct ntb_transport_qp *qp,
 			 struct ntb_queue_entry *entry)
 {
 	struct ntb_payload_header __iomem *hdr;
-	struct dma_chan *chan = qp->tx_dma_chan;
 	void __iomem *offset;
 	int res;
 
@@ -1913,7 +1959,7 @@ static void ntb_async_tx(struct ntb_transport_qp *qp,
 	iowrite32(entry->len, &hdr->len);
 	iowrite32((u32)qp->tx_pkts, &hdr->ver);
 
-	if (!chan)
+	if (!qp->tx_dma.chan)
 		goto err;
 
 	if (entry->len < copy_bytes)
@@ -1999,8 +2045,99 @@ static bool ntb_dma_filter_fn(struct dma_chan *chan, void *node)
 	return dev_to_node(&chan->dev->device) == (int)(unsigned long)node;
 }
 
+static void ntb_transport_teardown_dma(struct ntb_transport_dma *dma,
+				       dma_addr_t *mem, size_t size)
+{
+	struct dma_chan *chan;
+	unsigned int i;
+
+	if (!dma)
+		return;
+
+	if (!dma->chan) {
+		kfree(dma->last_cookie);
+		dma->last_cookie = NULL;
+		return;
+	}
+
+	for (i = 0; i < dma->num_chan; i++) {
+		chan = dma->chan[i];
+		if (!chan)
+			continue;
+
+		if (dma->last_cookie)
+			/* Try to be nice and wait for any queued DMA engine
+			 * transactions to process before smashing it with a rock
+			 */
+			dma_sync_wait(chan, dma->last_cookie[i]);
+
+		dmaengine_terminate_all(chan);
+		if (mem && mem[i])
+			dma_unmap_resource(chan->device->dev, mem[i], size,
+					   DMA_FROM_DEVICE, 0);
+		dma_release_channel(chan);
+		dma->chan[i] = NULL;
+	}
+
+	kfree(dma->chan);
+	kfree(dma->last_cookie);
+	dma->chan = NULL;
+	dma->num_chan = 0;
+	dma->last_cookie = NULL;
+}
+
+static unsigned int ntb_transport_setup_dma(struct pci_dev *pdev,
+					    struct ntb_transport_dma *dma,
+					    unsigned int req, int node)
+{
+	dma_cap_mask_t dma_mask;
+	struct dma_chan *c;
+	unsigned int i = 0;
+
+	dma_cap_zero(dma_mask);
+	dma_cap_set(DMA_MEMCPY, dma_mask);
+
+	dma->last_cookie = NULL;
+	dma->num_chan = 0;
+	dma->chan = kcalloc_node(req, sizeof(*dma->chan), GFP_KERNEL, node);
+	if (!dma->chan) {
+		dev_info(&pdev->dev, "Unable to alloc DMA arrays\n");
+		return 0;
+	}
+
+	atomic_set(&dma->cur_chan, 0);
+	for (i = 0; i < req; i++) {
+		c = dma_request_channel(dma_mask, ntb_dma_filter_fn,
+					(void *)(unsigned long)node);
+		if (!c) {
+			if (!i)
+				dev_info(&pdev->dev,
+					 "Unable to allocate DMA channel(s)\n");
+			break;
+		}
+		dma->chan[i] = c;
+		dma->num_chan++;
+	}
+	if (!dma->num_chan)
+		goto err_out;
+
+	dma->last_cookie = kcalloc_node(dma->num_chan, sizeof(dma_cookie_t),
+					GFP_KERNEL, node);
+	if (!dma->last_cookie)
+		goto err_out;
+
+	return dma->num_chan;
+
+err_out:
+	for (i = 0; i < dma->num_chan; i++)
+		dma_release_channel(dma->chan[i]);
+	kfree(dma->chan);
+	dma->chan = NULL;
+	dma->num_chan = 0;
+	return 0;
+}
+
 /**
- * ntb_transport_create_queue - Create a new NTB transport layer queue
  * @data: pointer for callback data
  * @client_dev: &struct device pointer
  * @handlers: pointer to various ntb queue (callback) handlers
@@ -2024,7 +2161,8 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
 	struct ntb_transport_qp *qp;
 	u64 qp_bit;
 	unsigned int free_queue;
-	dma_cap_mask_t dma_mask;
+	struct dma_chan *c;
+	dma_addr_t mw_dma;
 	int node;
 	int i;
 
@@ -2036,7 +2174,7 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
 
 	free_queue = ffs(nt->qp_bitmap_free);
 	if (!free_queue)
-		goto err;
+		return NULL;
 
 	/* decrement free_queue to make it zero based */
 	free_queue--;
@@ -2051,54 +2189,70 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
 	qp->tx_handler = handlers->tx_handler;
 	qp->event_handler = handlers->event_handler;
 
-	dma_cap_zero(dma_mask);
-	dma_cap_set(DMA_MEMCPY, dma_mask);
-
 	if (use_dma) {
 		use_tx_dma = true;
 		use_rx_dma = true;
 	}
-	if (use_tx_dma) {
-		qp->tx_dma_chan =
-			dma_request_channel(dma_mask, ntb_dma_filter_fn,
-					    (void *)(unsigned long)node);
-		if (!qp->tx_dma_chan)
-			dev_info(&pdev->dev, "Unable to allocate TX DMA channel\n");
-	} else
-		qp->tx_dma_chan = NULL;
-
-	if (use_rx_dma) {
-		qp->rx_dma_chan =
-			dma_request_channel(dma_mask, ntb_dma_filter_fn,
-					    (void *)(unsigned long)node);
-		if (!qp->rx_dma_chan)
-			dev_info(&pdev->dev, "Unable to allocate RX DMA channel\n");
-	} else
-		qp->rx_dma_chan = NULL;
-
-	qp->tx_mw_dma_addr = 0;
-	if (qp->tx_dma_chan) {
-		qp->tx_mw_dma_addr =
-			dma_map_resource(qp->tx_dma_chan->device->dev,
-					 qp->tx_mw_phys, qp->tx_mw_size,
-					 DMA_FROM_DEVICE, 0);
-		if (dma_mapping_error(qp->tx_dma_chan->device->dev,
-				      qp->tx_mw_dma_addr)) {
-			qp->tx_mw_dma_addr = 0;
-			goto err1;
+
+	/* setup TX dma if requested */
+	qp->tx_dma.chan = NULL;
+	qp->tx_dma.num_chan = 0;
+	if (use_tx_dma)
+		ntb_transport_setup_dma(pdev, &qp->tx_dma, num_tx_dma_chan ?: 1,
+					node);
+
+	/* setup RX dma if requested */
+	qp->rx_dma.chan = NULL;
+	qp->rx_dma.num_chan = 0;
+	if (use_rx_dma)
+		ntb_transport_setup_dma(pdev, &qp->rx_dma, num_rx_dma_chan ?: 1,
+					node);
+
+	/* setup TX dma dest map */
+	if (qp->tx_dma.num_chan > 0) {
+		qp->tx_mw_dma_addr = kcalloc_node(qp->tx_dma.num_chan,
+				sizeof(*qp->tx_mw_dma_addr), GFP_KERNEL, node);
+		if (!qp->tx_mw_dma_addr)
+			/* this sets qp->tx_dma.num_chan back to 0 */
+			ntb_transport_teardown_dma(&qp->tx_dma, NULL, 0);
+
+		for (i = 0; i < qp->tx_dma.num_chan; i++) {
+			c = qp->tx_dma.chan[i];
+			mw_dma = dma_map_resource(c->device->dev,
+						  qp->tx_mw_phys,
+						  qp->tx_mw_size,
+						  DMA_FROM_DEVICE, 0);
+			if (dma_mapping_error(c->device->dev, mw_dma)) {
+				dev_info(&pdev->dev,
+					 "TX MW dma_map_resource failed for channel %u\n", i);
+				break;
+			}
+			qp->tx_mw_dma_addr[i] = mw_dma;
 		}
+		if (qp->tx_dma.num_chan > 0 && i < qp->tx_dma.num_chan)
+			/* this sets qp->tx_dma.num_chan back to 0 */
+			ntb_transport_teardown_dma(&qp->tx_dma,
+						   qp->tx_mw_dma_addr,
+						   qp->tx_mw_size);
 	}
 
-	dev_dbg(&pdev->dev, "Using %s memcpy for TX\n",
-		qp->tx_dma_chan ? "DMA" : "CPU");
+	if (qp->tx_dma.num_chan > 0)
+		dev_dbg(&pdev->dev, "Using DMA memcpy for TX (num_chan = %u)\n",
+			qp->tx_dma.num_chan);
+	else
+		dev_dbg(&pdev->dev, "Using CPU memcpy for TX\n");
 
-	dev_dbg(&pdev->dev, "Using %s memcpy for RX\n",
-		qp->rx_dma_chan ? "DMA" : "CPU");
+	if (qp->rx_dma.num_chan > 0)
+		dev_dbg(&pdev->dev, "Using DMA memcpy for RX (num_chan = %u)\n",
+			qp->rx_dma.num_chan);
+	else
+		dev_dbg(&pdev->dev, "Using CPU memcpy for RX\n");
 
+	/* alloc and link entries */
 	for (i = 0; i < NTB_QP_DEF_NUM_ENTRIES; i++) {
 		entry = kzalloc_node(sizeof(*entry), GFP_KERNEL, node);
 		if (!entry)
-			goto err1;
+			goto err;
 
 		entry->qp = qp;
 		ntb_list_add(&qp->ntb_rx_q_lock, &entry->entry,
@@ -2109,7 +2263,7 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
 	for (i = 0; i < qp->tx_max_entry; i++) {
 		entry = kzalloc_node(sizeof(*entry), GFP_KERNEL, node);
 		if (!entry)
-			goto err2;
+			goto err;
 
 		entry->qp = qp;
 		ntb_list_add(&qp->ntb_tx_free_q_lock, &entry->entry,
@@ -2123,23 +2277,20 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
 
 	return qp;
 
-err2:
+err:
 	while ((entry = ntb_list_rm(&qp->ntb_tx_free_q_lock, &qp->tx_free_q)))
 		kfree(entry);
-err1:
-	qp->rx_alloc_entry = 0;
 	while ((entry = ntb_list_rm(&qp->ntb_rx_q_lock, &qp->rx_free_q)))
 		kfree(entry);
-	if (qp->tx_mw_dma_addr)
-		dma_unmap_resource(qp->tx_dma_chan->device->dev,
-				   qp->tx_mw_dma_addr, qp->tx_mw_size,
-				   DMA_FROM_DEVICE, 0);
-	if (qp->tx_dma_chan)
-		dma_release_channel(qp->tx_dma_chan);
-	if (qp->rx_dma_chan)
-		dma_release_channel(qp->rx_dma_chan);
+	qp->rx_alloc_entry = 0;
+
+	ntb_transport_teardown_dma(&qp->rx_dma, NULL, 0);
+	ntb_transport_teardown_dma(&qp->tx_dma, qp->tx_mw_dma_addr,
+				   qp->tx_mw_size);
+	kfree(qp->tx_mw_dma_addr);
+	qp->tx_mw_dma_addr = NULL;
+
 	nt->qp_bitmap_free |= qp_bit;
-err:
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(ntb_transport_create_queue);
@@ -2163,40 +2314,11 @@ void ntb_transport_free_queue(struct ntb_transport_qp *qp)
 
 	qp->active = false;
 
-	if (qp->tx_dma_chan) {
-		struct dma_chan *chan = qp->tx_dma_chan;
-		/* Putting the dma_chan to NULL will force any new traffic to be
-		 * processed by the CPU instead of the DAM engine
-		 */
-		qp->tx_dma_chan = NULL;
-
-		/* Try to be nice and wait for any queued DMA engine
-		 * transactions to process before smashing it with a rock
-		 */
-		dma_sync_wait(chan, qp->last_cookie);
-		dmaengine_terminate_all(chan);
-
-		dma_unmap_resource(chan->device->dev,
-				   qp->tx_mw_dma_addr, qp->tx_mw_size,
-				   DMA_FROM_DEVICE, 0);
-
-		dma_release_channel(chan);
-	}
-
-	if (qp->rx_dma_chan) {
-		struct dma_chan *chan = qp->rx_dma_chan;
-		/* Putting the dma_chan to NULL will force any new traffic to be
-		 * processed by the CPU instead of the DAM engine
-		 */
-		qp->rx_dma_chan = NULL;
-
-		/* Try to be nice and wait for any queued DMA engine
-		 * transactions to process before smashing it with a rock
-		 */
-		dma_sync_wait(chan, qp->last_cookie);
-		dmaengine_terminate_all(chan);
-		dma_release_channel(chan);
-	}
+	ntb_transport_teardown_dma(&qp->rx_dma, NULL, 0);
+	ntb_transport_teardown_dma(&qp->tx_dma, qp->tx_mw_dma_addr,
+				   qp->tx_mw_size);
+	kfree(qp->tx_mw_dma_addr);
+	qp->tx_mw_dma_addr = NULL;
 
 	qp_bit = BIT_ULL(qp->qp_num);
 
@@ -2444,17 +2566,31 @@ EXPORT_SYMBOL_GPL(ntb_transport_qp_num);
 unsigned int ntb_transport_max_size(struct ntb_transport_qp *qp)
 {
 	unsigned int max_size;
-	unsigned int copy_align;
+	unsigned int copy_align = 0;
 	struct dma_chan *rx_chan, *tx_chan;
+	unsigned int i;
 
 	if (!qp)
 		return 0;
 
-	rx_chan = qp->rx_dma_chan;
-	tx_chan = qp->tx_dma_chan;
-
-	copy_align = max(rx_chan ? rx_chan->device->copy_align : 0,
-			 tx_chan ? tx_chan->device->copy_align : 0);
+	if (qp->rx_dma.chan) {
+		for (i = 0; i < qp->rx_dma.num_chan; i++) {
+			rx_chan = qp->rx_dma.chan[i];
+			if (!rx_chan)
+				continue;
+			copy_align = max(copy_align,
+					 rx_chan->device->copy_align);
+		}
+	}
+	if (qp->tx_dma.chan) {
+		for (i = 0; i < qp->tx_dma.num_chan; i++) {
+			tx_chan = qp->tx_dma.chan[i];
+			if (!tx_chan)
+				continue;
+			copy_align = max(copy_align,
+					 tx_chan->device->copy_align);
+		}
+	}
 
 	/* If DMA engine usage is possible, try to find the max size for that */
 	max_size = qp->tx_max_frame - sizeof(struct ntb_payload_header);
-- 
2.48.1

