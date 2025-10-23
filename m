Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011036.outbound.protection.outlook.com [40.107.74.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540312E2F1A
	for <ntb@lists.linux.dev>; Thu, 23 Oct 2025 07:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761204080; cv=fail; b=mGuM6yH+8cASuI48b9h2N9nxZ5jKR513lrHfXzlIcsVsDyPoj1af+/UBTsa+xsDvWl80MizbIOkVIjjA3F2YiZfE5yGKS7ecnIijqJwMxTrqiQ9dY8cS2ecS7c6jSt4thcrWeZmBPQrC+ox+LrIw7r4JfmdsVGvKANYEVqUSWCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761204080; c=relaxed/simple;
	bh=S8A1G+FZbiNFQnCj3WPHDH27l1ELIcOu1L55zaOvxg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aMtbJYs9mfSARtxUFpqnCKAuu9mcmWd4zrn7WVzC7gDuufFwC/A1icDcuvc9ipjgV+xnbGecZ1Z5r1inpfVN/3l6GVlO0hDsezfQDcZ9o8urrz+RxHcF0BoFRM9t+Xcj7RJn1b+Ucsf6SegLs09Qp91xP3CiZFwMnmPJwXFrgUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=ULICoEhO; arc=fail smtp.client-ip=40.107.74.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="ULICoEhO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cO+9khdq4QcDeDrN69m3NIcWEe0KgLDRkL9ay2CBK0Z27HIHwbREyooDXrIK7N6fm5Xl7z95ylc9HQxOWH7faarAEJ3Ufv2ZyrNbE7yC2lEy4zU6Q+wYC/fDZYoC7H5hSPQPApfVaXfkKikbi2g5A1GoDSIQvd2EFNuUAidBYxmVf5+fEHayWo/+O/2UwMMLYtRP84PIfEA+tzaARK7nN2B2FTwvOpoBQGnYlp3zHED+dFGeIQmlU0ZGpkDd7alW8r9ghAqCyUKYuXnZuN/EYhdEH8PZrGKRsL77qw6ZaiiKBlIcbxmLCnGOi98rQeNnN/1nfgvU6oZqxqpppLmyQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lnyxGvV49oAOws+yZpz1074x60qxvFwVxHI59rl1yQ4=;
 b=TzEQ/2gkiJ15eaD19QNLJWFDYxTJUDsSR2JfkH7Hf7qPg0AJ9TZU22vmqKp+PclGC/69HDmGXp5xaqVkmdkXs8lAudHQ0lnpdTqV6InWviE6l1Jsr8dT6H3m2tTUDpu75ijHTNgv0e2Uz2uezPFTYooeBuMlf9ufEen29BtR5LAxLEam5RySGdHv3ndSdZmUmGSgBIJDe7T40mJw2CA1st/pKgTzHZWILvr9MN73hv25RP+7zQKXPBcRff4QfAkEUaskWC67nNU5EqrgwFjI16ZO3iTliLkrTF5GJgX07p6KYQ9GEt2SX/zUGi5UOg2M7DZF7Jl2vpRErBQbmP0Qzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lnyxGvV49oAOws+yZpz1074x60qxvFwVxHI59rl1yQ4=;
 b=ULICoEhOdTIshTd3eX842nbu0TNh4Up7EkoEUfNes7W7r3SdPrRmYzl1hEyDDQJKAZI/wXORQN7I5yB5pmWFP83CN2GsA1z3BCkdB+59X+TPmJ1+DEJOERSA+r22kyNQknNal9HvHzIWSVIwWycuC4AkYcPuLCFrtUKhdf1uZFU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:10d::7)
 by TYRP286MB4555.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:1b0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 07:21:12 +0000
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a]) by OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a%5]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 07:21:12 +0000
From: Koichiro Den <den@valinux.co.jp>
To: ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com
Subject: [PATCH 2/2] NTB: ntb_transport: Add 'tx_memcpy_offload' module option
Date: Thu, 23 Oct 2025 16:21:05 +0900
Message-ID: <20251023072105.901707-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251023072105.901707-1-den@valinux.co.jp>
References: <20251023072105.901707-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0185.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::11) To OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:10d::7)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB0979:EE_|TYRP286MB4555:EE_
X-MS-Office365-Filtering-Correlation-Id: 095023e4-67a3-41b7-4352-08de1204beb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|10070799003|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YHPfKLkYuXi020DFoD91+mHeibg1bZ/sX5sPBk6RXft+9x4302vRMZvhL22q?=
 =?us-ascii?Q?VAX4lLWKs4pLMv+DzaGkwWWOjSB/rkZLXlYeBKjaeybV7Lrj2MNszQ2anv0Y?=
 =?us-ascii?Q?1UUYTAZy+6Zm1BiSt9hLnFXIRi66FlxIbjnTwYx4ZcWazUjMs6rTqBYBHd6H?=
 =?us-ascii?Q?aczhOw+QqlU5mo67iy6lGlnVQyBmdumowlJhkdzdIvO+X+TyhcGPGndFg4Jl?=
 =?us-ascii?Q?IaBc5K+gnt8q/KxW8DzZ8p0ma27Vvy3ptoZZZ55h6tvJj3NRrgH1jOsSSn2a?=
 =?us-ascii?Q?RcC1WKtxHNo4G8/H7B3P/BvAzjeLuVzCDHhwy7bxFY5fw5p9ukFBsdvfudS7?=
 =?us-ascii?Q?x7RytLvlULFlphcBkhpayGD7SUIcQUE8dL6mrUOnszS9IS/qp8yXCzxirsUB?=
 =?us-ascii?Q?jsbgO+sz8dXwEBe74md/IZ3VhPV1Tycv5qV4IgpGKZ8gpHaMtw49NRy8WBjZ?=
 =?us-ascii?Q?txNZAHZ1SQlo0uO/3h6/Ce5JqRp5IfVm4XFEkav32ELKFEN+8nQTrEfSMepT?=
 =?us-ascii?Q?nfh1tt7WZYomqvZbvm0zrlRa6d1swOW8EgbSNnut0fzn11ZIe5oXCOXLJSIP?=
 =?us-ascii?Q?Naf45/tNaxJvouD+8eo4H+SeGCbcLlJYVOkai5qZ4+KSIUwFv8Y+X4UyFpGt?=
 =?us-ascii?Q?YjrUMojhPm8xZqlrJcwUYntvgxwAWoxvFVY/OArUNQUw3sLN9oA0eHwQDBA+?=
 =?us-ascii?Q?nxR4YfRI9vziLguyXI1EyiR6sN4qytx83TE4hIhMspi76crjq/go90OHQvP8?=
 =?us-ascii?Q?ks5M8MOVvMevCbjNln9XX5ehqvo+jyezNUA2/Ir/uzKvD7oQcd/UkAymldA4?=
 =?us-ascii?Q?iqM5h6EGP/dla7aH2yj7ZwijhzBzX7ryMnF9K8VeedJM8viv+OhqeW8C5ptg?=
 =?us-ascii?Q?I0PxZl82aFsneG6wc/ZRSSFNSBx9rvBCxevB1+WOQyzBjZnG7Pj0SDHq+qNg?=
 =?us-ascii?Q?26NPQ+/L7tEr8rQ7fGQ/OiILyqP4CvbYKjTO2/JszECndHigvfMnvpyRSdya?=
 =?us-ascii?Q?27vqVKWA9RiEUf7+WcZ7H4WkqgU6pqHJ2qebNSFp3yWqzOOdd5ncK1FhpNLt?=
 =?us-ascii?Q?Zh51fYmy71rPf8kX/EvXANm4zNaEnZbe5rM1Wi+0qbLvC9NSvRzrQRL++B7Y?=
 =?us-ascii?Q?l39ZOtJ7si42vcMjO0JtcutQIG3CzIARdwPxM8RPPkW5Fhjp5Vur6G2Aj12K?=
 =?us-ascii?Q?cv3ICWqIeAstBnyyU8bNNLcKzX1GOL+Kk7ZiRgyU7qvzpjPOtdzARQLpoF0A?=
 =?us-ascii?Q?xIsVL/+6WjVMMRqSmO50uyxyUL5ZI6UBjY07lAJVkyz8RDHsvFRPbjpmaGxR?=
 =?us-ascii?Q?X8u9mKZ06fUbbkAYnS4rsdPsSy7AY3xigBfKRduzAD8WNxW1Bp6KtQ7y8TYM?=
 =?us-ascii?Q?p/MW2tmOo7Q4qXqAAqLiwCnE07Nc6Ovbe4a0XOCSrE+poNir4q3i54woCkLP?=
 =?us-ascii?Q?s1Fu4Puwfu8vPao+BP29/Zfcf54zivVx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LxTemL92UlzNEuA6YVI+BDWZlUYW9YT3pxc3or1p61IexBI/1zSoBGd3ILdC?=
 =?us-ascii?Q?YtMmPInPdXxHI0XPcjp7wLdWuksG2ynD8yXgi/Xa9aP8ocOXJrfi5/12S7SU?=
 =?us-ascii?Q?FZA8PVZB6IOzcJh72348b+07jVJ/xauPDUgNwuMwmQmyz62JilVbtwZjgbTN?=
 =?us-ascii?Q?/iqML8OLMr9oynPyXZXyGS5fOrFnv4xqUq4TgQmwgFOIboWnx4D5EV5WjVfY?=
 =?us-ascii?Q?jJdFGfqdQdr7UAEiD2Au7vpHYWuY1GlLsp2XFoTeKY7BS+xqFwiHGZx6WF6M?=
 =?us-ascii?Q?ibHI5QFXOXM6cX7seCiM26XgO70kFVHDH97KJc5BS1wB/Pa3IuPZKPjv+zGq?=
 =?us-ascii?Q?bCZntyg4MASFik3mS9AnWtw7/qn0SO2lCpSMDA1aQn3hp42bdQIkkJRQ2OYM?=
 =?us-ascii?Q?GY6NWFYf66oj+hp4TFsP+/3BrQJWu3ql37eIeLs8NMA/cViLEHFYM9Gwqa/S?=
 =?us-ascii?Q?PMr3M+J2WDXzj0BtuBLrKSICk/jKe2hUhfRmzJh+ykh2LaSNZvwjxszxRiC0?=
 =?us-ascii?Q?D6YPSdqeClr7AdvePUrYunsBJEB9UztS/aDJBBwsxje9J1uqolu6ntDyBatZ?=
 =?us-ascii?Q?Rj1t9qEiOmNYjXX7Sxwnu1F2JVTKXb1osZlnXwV8WV9pUc9/TL3j6gpY2n1s?=
 =?us-ascii?Q?ePV/VMGoZsq67oVLEdWyWNUtff/mmhCXmmwHdsfWif05RuWnZGowlUKbXlfM?=
 =?us-ascii?Q?rAClE89FBa+exiru7Uzdosx9eHvhknoSBs9Z6PgjvrfFQp4/RAfN8yB6O8dT?=
 =?us-ascii?Q?mpVjL4lQVAu92FGlZaXDdb6AUMs+7XN6nqAP/2XieS7MbArpssSMQPs/bw/P?=
 =?us-ascii?Q?yy1kHYtM8aYKlZWN/X6w93djNHPjKSjs16PthbbWWadylLiGVhWh5pu+GNl/?=
 =?us-ascii?Q?o8b9mrXAwYRVzKl3P0CQawScRUTgVH3SrRJrr0u1ObsTXmrMv5SqxIwdCa0v?=
 =?us-ascii?Q?+CMNNYuHo7x+R8Y9AX4cZMe+cF4ecgd0V1GPYegh8UXPPco9jklWT3h4pRdK?=
 =?us-ascii?Q?tmYsAdzz0MUIDGFX1dJJXZiYyFF73jFmzsRH35dUPVX8LoroCdtrVb98GBLD?=
 =?us-ascii?Q?CiXOrpkDkoWeuM5k1NfG8HMfTD9WoP1NT5JCGjlqHqBLdnQCewOns9TlKlaA?=
 =?us-ascii?Q?ou+/UPQOJwD3rDsOMvrZyiJgOK5dmpYagjcNWYGULkphhgmEtxmzsJTQI498?=
 =?us-ascii?Q?MVe2Wq+HzNhkWJ1ZHTSH0/Zs3ttvFO3acu6HZ6La350vlXikyV3BRy1of6jz?=
 =?us-ascii?Q?Jxx0dpFw7dl8GT8b+qbAInNkmHQq3Xw/+MCHOLlKAc2doKC0K3mm66W6Mo7B?=
 =?us-ascii?Q?vje0zWd4jdqpVKhLxvIMnxWD/LvweK6vK3y86r+MC8dijqsZRBNyoSX+z1jl?=
 =?us-ascii?Q?L4nFYkNzhf/sEy9kI71ob6Guc7Ctc48HZR32E6VBwNCFz4wx2XP7HSQXEsWW?=
 =?us-ascii?Q?S8N/BtQrVQQb/P1ZlKj9/kGSeW1XveA5h53o/NgV8EwD8z73I1bRLaUUh8b0?=
 =?us-ascii?Q?KxP6dggaOrhJpX7x81kFnsGBuZncos+Hm5PD9gf0pAQaAg3qv4LW5ifRqqYm?=
 =?us-ascii?Q?83ItLPxTssgB1dklTjyBWfjZmi70+Rmml850my2OD+zStFEnj/zqYmOrdAKS?=
 =?us-ascii?Q?3AznJEk75XhXlJBL9XgNVjE=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 095023e4-67a3-41b7-4352-08de1204beb7
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 07:21:12.2981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YfMPuD/duJyEYYSwTdJ4TY3Ec+7tlK5WbrcETqlge7c7FkcZmgS/68zJBTyz5Yu28+hzPaVdTnx4hkDC3N69fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB4555

Some platforms (e.g. R-Car S4) do not gain from using a DMAC on TX path
in ntb_transport and end up CPU-bound on memcpy_toio(). Add a module
parameter 'tx_memcpy_offload' that moves the TX memcpy_toio() and
descriptor writes to a per-QP kernel thread. It is disabled by default.

This change also fixes a rare ordering hazard in ntb_tx_copy_callback(),
that was observed on R-Car S4 once throughput improved with the new
module parameter: the DONE flag write to the peer MW, which is WC
mapped, could be observed after the DB/MSI trigger. Both operations are
posted PCIe MWr (often via different OB iATUs), so WC buffering and
bridges may reorder visibility. Insert dma_mb() to enforce store->load
ordering and then read back hdr->flags to flush the posted write before
ringing the doorbell / issuing MSI.

While at it, update tx_index with WRITE_ONCE() at the earlier possible
location to make ntb_transport_tx_free_entry() robust.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/ntb_transport.c | 104 ++++++++++++++++++++++++++++++++++--
 1 file changed, 100 insertions(+), 4 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 39b2398b95a6..f4ed616c6ab8 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -54,12 +54,14 @@
 #include <linux/errno.h>
 #include <linux/export.h>
 #include <linux/interrupt.h>
+#include <linux/kthread.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/uaccess.h>
 #include <linux/mutex.h>
+#include <linux/wait.h>
 #include "linux/ntb.h"
 #include "linux/ntb_transport.h"
 
@@ -100,6 +102,10 @@ module_param(use_msi, bool, 0644);
 MODULE_PARM_DESC(use_msi, "Use MSI interrupts instead of doorbells");
 #endif
 
+static bool tx_memcpy_offload;
+module_param(tx_memcpy_offload, bool, 0644);
+MODULE_PARM_DESC(tx_memcpy_offload, "Offload TX memcpy_toio() to a kernel thread");
+
 static struct dentry *nt_debugfs_dir;
 
 /* Only two-ports NTB devices are supported */
@@ -148,7 +154,9 @@ struct ntb_transport_qp {
 	void (*tx_handler)(struct ntb_transport_qp *qp, void *qp_data,
 			   void *data, int len);
 	struct list_head tx_free_q;
+	struct list_head tx_offl_q;
 	spinlock_t ntb_tx_free_q_lock;
+	spinlock_t ntb_tx_offl_q_lock;
 	void __iomem *tx_mw;
 	phys_addr_t tx_mw_phys;
 	size_t tx_mw_size;
@@ -199,6 +207,9 @@ struct ntb_transport_qp {
 	int msi_irq;
 	struct ntb_msi_desc msi_desc;
 	struct ntb_msi_desc peer_msi_desc;
+
+	struct task_struct *tx_offload_thread;
+	wait_queue_head_t tx_offload_wq;
 };
 
 struct ntb_transport_mw {
@@ -284,7 +295,13 @@ static int ntb_async_tx_submit(struct ntb_transport_qp *qp,
 static void ntb_memcpy_tx(struct ntb_queue_entry *entry, void __iomem *offset);
 static int ntb_async_rx_submit(struct ntb_queue_entry *entry, void *offset);
 static void ntb_memcpy_rx(struct ntb_queue_entry *entry, void *offset);
+static int ntb_tx_memcpy_kthread(void *data);
+
 
+static inline bool ntb_tx_offload_enabled(struct ntb_transport_qp *qp)
+{
+	return tx_memcpy_offload && qp && qp->tx_offload_thread;
+}
 
 static int ntb_transport_bus_match(struct device *dev,
 				   const struct device_driver *drv)
@@ -1254,11 +1271,13 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
 
 	spin_lock_init(&qp->ntb_rx_q_lock);
 	spin_lock_init(&qp->ntb_tx_free_q_lock);
+	spin_lock_init(&qp->ntb_tx_offl_q_lock);
 
 	INIT_LIST_HEAD(&qp->rx_post_q);
 	INIT_LIST_HEAD(&qp->rx_pend_q);
 	INIT_LIST_HEAD(&qp->rx_free_q);
 	INIT_LIST_HEAD(&qp->tx_free_q);
+	INIT_LIST_HEAD(&qp->tx_offl_q);
 
 	tasklet_init(&qp->rxc_db_work, ntb_transport_rxc_db,
 		     (unsigned long)qp);
@@ -1784,6 +1803,13 @@ static void ntb_tx_copy_callback(void *data,
 
 	iowrite32(entry->flags | DESC_DONE_FLAG, &hdr->flags);
 
+	/*
+	 * Make DONE flag visible before DB/MSI. WC + posted MWr may reorder
+	 * across iATU/bridge (platform-dependent). Order and flush here.
+	 */
+	dma_mb();
+	ioread32(&hdr->flags);
+
 	if (qp->use_msi)
 		ntb_msi_peer_trigger(qp->ndev, PIDX, &qp->peer_msi_desc);
 	else
@@ -1804,7 +1830,7 @@ static void ntb_tx_copy_callback(void *data,
 	ntb_list_add(&qp->ntb_tx_free_q_lock, &entry->entry, &qp->tx_free_q);
 }
 
-static void ntb_memcpy_tx(struct ntb_queue_entry *entry, void __iomem *offset)
+static void ntb_memcpy_tx_on_stack(struct ntb_queue_entry *entry, void __iomem *offset)
 {
 #ifdef ARCH_HAS_NOCACHE_UACCESS
 	/*
@@ -1822,6 +1848,54 @@ static void ntb_memcpy_tx(struct ntb_queue_entry *entry, void __iomem *offset)
 	ntb_tx_copy_callback(entry, NULL);
 }
 
+static int ntb_tx_memcpy_kthread(void *data)
+{
+	struct ntb_transport_qp *qp = data;
+	struct ntb_queue_entry *entry, *tmp;
+	const int resched_nr = 64;
+	LIST_HEAD(local_list);
+	void __iomem *offset;
+	int processed = 0;
+
+	while (!kthread_should_stop()) {
+		spin_lock_irq(&qp->ntb_tx_offl_q_lock);
+		wait_event_interruptible_lock_irq_timeout(qp->tx_offload_wq,
+				kthread_should_stop() ||
+				!list_empty(&qp->tx_offl_q),
+				qp->ntb_tx_offl_q_lock, 5*HZ);
+		list_splice_tail_init(&qp->tx_offl_q, &local_list);
+		spin_unlock_irq(&qp->ntb_tx_offl_q_lock);
+
+		list_for_each_entry_safe(entry, tmp, &local_list, entry) {
+			list_del(&entry->entry);
+			offset = qp->tx_mw + qp->tx_max_frame * entry->tx_index;
+			ntb_memcpy_tx_on_stack(entry, offset);
+			if (++processed >= resched_nr) {
+				cond_resched();
+				processed = 0;
+			}
+		}
+		cond_resched();
+	}
+
+	return 0;
+}
+
+static void ntb_memcpy_tx(struct ntb_queue_entry *entry, void __iomem *offset)
+{
+	struct ntb_transport_qp *qp = entry->qp;
+
+	if (WARN_ON_ONCE(!qp))
+		return;
+
+	if (ntb_tx_offload_enabled(qp)) {
+		ntb_list_add(&qp->ntb_tx_offl_q_lock, &entry->entry,
+			     &qp->tx_offl_q);
+		wake_up(&qp->tx_offload_wq);
+	} else
+		ntb_memcpy_tx_on_stack(entry, offset);
+}
+
 static int ntb_async_tx_submit(struct ntb_transport_qp *qp,
 			       struct ntb_queue_entry *entry)
 {
@@ -1894,6 +1968,9 @@ static void ntb_async_tx(struct ntb_transport_qp *qp,
 	hdr = offset + qp->tx_max_frame - sizeof(struct ntb_payload_header);
 	entry->tx_hdr = hdr;
 
+	WARN_ON_ONCE(!ntb_transport_tx_free_entry(qp));
+	WRITE_ONCE(qp->tx_index, (qp->tx_index + 1) % qp->tx_max_entry);
+
 	iowrite32(entry->len, &hdr->len);
 	iowrite32((u32)qp->tx_pkts, &hdr->ver);
 
@@ -1934,9 +2011,6 @@ static int ntb_process_tx(struct ntb_transport_qp *qp,
 
 	ntb_async_tx(qp, entry);
 
-	qp->tx_index++;
-	qp->tx_index %= qp->tx_max_entry;
-
 	qp->tx_pkts++;
 
 	return 0;
@@ -2033,6 +2107,20 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
 	qp->tx_handler = handlers->tx_handler;
 	qp->event_handler = handlers->event_handler;
 
+	init_waitqueue_head(&qp->tx_offload_wq);
+	if (tx_memcpy_offload) {
+		qp->tx_offload_thread = kthread_run(ntb_tx_memcpy_kthread, qp,
+						    "ntb-txcpy/%s/%u",
+						    pci_name(ndev->pdev), qp->qp_num);
+		if (IS_ERR(qp->tx_offload_thread)) {
+			dev_warn(&nt->ndev->dev,
+				 "tx memcpy offload thread creation failed: %ld; falling back to inline copy\n",
+				 PTR_ERR(qp->tx_offload_thread));
+			qp->tx_offload_thread = NULL;
+		}
+	} else
+		qp->tx_offload_thread = NULL;
+
 	dma_cap_zero(dma_mask);
 	dma_cap_set(DMA_MEMCPY, dma_mask);
 
@@ -2140,6 +2228,11 @@ void ntb_transport_free_queue(struct ntb_transport_qp *qp)
 
 	qp->active = false;
 
+	if (qp->tx_offload_thread) {
+		kthread_stop(qp->tx_offload_thread);
+		qp->tx_offload_thread = NULL;
+	}
+
 	if (qp->tx_dma_chan) {
 		struct dma_chan *chan = qp->tx_dma_chan;
 		/* Putting the dma_chan to NULL will force any new traffic to be
@@ -2203,6 +2296,9 @@ void ntb_transport_free_queue(struct ntb_transport_qp *qp)
 	while ((entry = ntb_list_rm(&qp->ntb_tx_free_q_lock, &qp->tx_free_q)))
 		kfree(entry);
 
+	while ((entry = ntb_list_rm(&qp->ntb_tx_offl_q_lock, &qp->tx_offl_q)))
+		kfree(entry);
+
 	qp->transport->qp_bitmap_free |= qp_bit;
 
 	dev_info(&pdev->dev, "NTB Transport QP %d freed\n", qp->qp_num);
-- 
2.48.1

