Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020079.outbound.protection.outlook.com [52.101.229.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB8542FCB8
	for <ntb@lists.linux.dev>; Mon, 10 Aug 2026 16:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786380718; cv=fail; b=GOjskTEJqAdd8yDUYDeeCj9/S+1klo6KpOeD/qppCNQlNntrR2Fdw+bt1BFRzE8diF6u04CnqsJWTrC0lCTMzFNOyMUq9c2C5He0d9FbtCcW1p9I8j6p+qwYNRzpeDrKDhBl3cxIG0ELDudvIno9XE2XSHvj0UqXOvYoatr85xM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786380718; c=relaxed/simple;
	bh=VWpqa1iqPF6KjtEP8eeGzTTtf6MQLFQBZGmQgu2P87s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hUl0MQQe4bbredO3/GuMno6viK4kAp1aW6muy5ILpeWVfVXxzLMp4Oqcg7hYqSL4zzvfAdzHfWeIwMBZMdDipPBKT5qZ1d4gRJzpIFHGInj9jCkSGtRHbE3KI1wgEFMwp7XiBfzZtyx09/I/obOlHi2+FTt4oR1Ot/hHntJJRmE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=jvAZsTVN; arc=fail smtp.client-ip=52.101.229.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="jvAZsTVN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qx4J4CMlc4ujIJv78a5/GLS7Ga01wkXT9ytFM4d9cEH2cK3/Zm3O9pQw4HhVcWz3kxeiLz0uHV4Hub7MglDzm2MzAMqisDssWNa3hIKKvL9inrROjmEZRE0VKIE/pKObgPuA6oZdmUt8GW+2WgrmSPmqENfFub3p5B8kBOsO4h+vc0XIRGIlxhq3YK7PoVPBrRSDkjQJ3YbEEDmYS7dcIkAMdDr6Xl3Qw7HRksuEa0N0wfRoaoIZCMqddxFsMFbxSRv/jUxxgL1dMh8fpCni7j76Tgm2Xdt8ogHGlHQ3PYzFf7TVqTGMTTszjxeW9/yVjidmSCWcjG+vlUctXJx0Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OKedhe3CLfWsfvsgwmDkkvZu+AqTtfS0Rqy7HdOnyEA=;
 b=Roc/v7R3cVYyxrJEjej+mcNaustN+6isLrKFqd+0HuG4BE3Cr6USnSfo4x+Q7sYnIBFgNt54QmPMqidSRkv0eqIf1DGxc2GjZ3O/lcXWnWzKF++jITiIAr8NvpSSZHe282GbjdriGUfNl0FcHK3tXpXpK3ZaoVmRPRXxedQ/CzjNBt4wjKezuMW9z8p4G75hbu37b38USik/nyl99sA8/F/MZEQzgO3t8XvVkZcgc/YeBvNp9gwYST/h3gFWyEny6xrqMUti2oYMIMDlbec9qViRUyhcKbISfFtYamE7IOPHhKkVpg1fOsVxvLtS339pMLJ1pssd0Xk6qrzjzrRuNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKedhe3CLfWsfvsgwmDkkvZu+AqTtfS0Rqy7HdOnyEA=;
 b=jvAZsTVNpR10wGxsAA0Z0c/X6ei2zM60di722gMrGWUi+ti79BgplB03vLNoS0WEoYnMnJvRINqO6JTdJkmSyLCrZw4TKs2lqSyh85fp+tX9iHjhS73eQhR+as8YTwXS27KkGuTfqrMu/LdVx4MNHuI59knbRp5A1As+edpHraM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB6729.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:42d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 16:51:47 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 16:51:47 +0000
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
Subject: [PATCH 05/16] NTB: ntb_transport: Run RX processing on system workqueue
Date: Tue, 11 Aug 2026 01:51:24 +0900
Message-ID: <20260810165136.2292436-6-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260810165136.2292436-1-den@valinux.co.jp>
References: <20260810165136.2292436-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0050.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36b::9) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB6729:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c50301b-7cbf-4b7b-6e38-08def6ffaaec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|23010399003|376014|1800799024|366016|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	z1orIkTAnAAHo+R/rMlqm5bDsFZPRdETXeyCwxqJVppN/yJgIeKObjpLtML4NzbtEGY46AOpjQNkw86jgW7hIpaVLGq0SVSopoLXVt8oA4wbB59sRevH0wPAX9WtGjBh9z2dKq2pQCUaCSpglWIMMoJXZ4w8OcMk/zoZgaV+4AzvTwl6ovnxAm6G3LLq314xuykzZ26TeyTOFHaPFNV6a3FAcAOozW0RcHofU+RvImJf4ME1hI/OULwdX1zTRsv5KpAZAjDLZi5YC7sVn2w5OQMzRAbudNtrxS69uRgZxOFHlli1GT5TpzGLHWo9BdDkZWFPLuPI89AdCBc1nFR+aFaOjeTMm+wzPSeOsq2iRhehIOABbujIo7K4RuSqrxyt+cdr88+UVQkatvL/ZjMXwXh4SX9vlC8RJfK7/V+4j/6E0SjfXOz5Swhx0bleLah78oGm8X00hkPMUUCRoeqqWGVx0mhpwAB0LVGv7rC3KFngsawUTCr0+dWU0gP29HwF8h8Xgd3GJCwhIFXXOSLtB+72Ok7Symjq9Glw+GPzUgMg/kxdPP7Ff5CuToFThPlb7tnfi1YHdG2s6s/k4jm95ZSuAGPDNyvkTNn8lBB2B5yAgquhFC1lHUB1QzbjJnlqRNY2V1hnyOgwcTKJKJbG7WKN0dlxyE6vbqKfVDydMys=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(23010399003)(376014)(1800799024)(366016)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SZozdUASTtWPta/0Fx/KmAc6RlALvvMOUayiu6uACaZBPog5g2gKP2iskTrp?=
 =?us-ascii?Q?n145TQDcHnH1ePUYbzm72GvFIJ0f8sHPB2dG79Q+dG/186AELM9WeQCK8xuX?=
 =?us-ascii?Q?krdcQ+Abq5RTCQbyB1uo7adon+Tp8m35lL3l5adoXLZaoB+TWF9Dnko3PHRt?=
 =?us-ascii?Q?S2S5jcG8mzfgMEem3ORwbB87UKsFiMycgmByEnEnRVYXQaWtk12OkqWWztl6?=
 =?us-ascii?Q?QUjbqyz8uiH9LDALnrVRLd10fITeRbwcXb42JCyqGb8WQPRQG+heQi/VBAZg?=
 =?us-ascii?Q?RLY/OcyE1POP9KxOZVtPC+y+lKaVxkognrzkMThNZ79y2V+aaI+PtEf8kSRh?=
 =?us-ascii?Q?4FhjyNQj01KyuAjW95unT9tIC1guHtnNHKiPOUDEuyEuB6fkes0xhwnjxEsC?=
 =?us-ascii?Q?DWB3KUXAfXCvU3phQ7Ies9it21BKCBsZPUe9KznquKE+ByVZQyx7VwbGIMg3?=
 =?us-ascii?Q?vNMVWB6jwRL3JsxTrsrl+GHhQjf1aHgMUVyd8JfOyqPQQE/tgjjCBMTOz5tx?=
 =?us-ascii?Q?yffyebjlGzQWRx1G/uuDAhw8X3OCULPsf8Tnz0ge96i9aLn6LkDwx0FnY5C+?=
 =?us-ascii?Q?U7nceIMNGpKtpNS3yPTYtLXzCsfrkvWVjzK3aNTEPAXDnIEVn6qocEt+bY/+?=
 =?us-ascii?Q?VHWrodQp3/R6d8O0cOStLogc6dR2xki3Lqbk4pFJpZuFQ5+3Pg/fuWeJ90aF?=
 =?us-ascii?Q?amb+ULTb4GAlPjT2N3zgzTQ92sJrYDDBL/ADvhGxCkJ2daUMouzwsCNiCe2a?=
 =?us-ascii?Q?Mew/zDYel7pfl2Quc3KIFiW6jP9Z/gwcKeRsZrnorZVpPth8Fkqln4Awog7f?=
 =?us-ascii?Q?Louf31k6WfxCqCoC9jDGRm/wItuWcpC37qAweml62e3iPHrCZGx+J7VxzbyU?=
 =?us-ascii?Q?DxgCyM8HkyJM7jHkdDlpOHuespb5qSNw8BGrqYKZ1kwZxlan6H8uZLNoLhJG?=
 =?us-ascii?Q?UQA1drIJUTUMSdJdqAG323c0sGpfHYhVKAeI9Bvt/6Kur0TtKMmrj1IYK73P?=
 =?us-ascii?Q?BjBugtLuQocakfXZnf3v64g25j+QXkZ6lI79BudZF1K+JMfK8Qkp/WxEa/LZ?=
 =?us-ascii?Q?0JEQ2sczgIitYkQY/SBTM3vQ0Iay2jLDFm4viiXfsuPyMXvTz55DMZaDLdKl?=
 =?us-ascii?Q?V/OakLo2k00X0+IflBlKlKjXsYgOMwgjJ1O61IMFbYejZuR5jbIr7wGMiukc?=
 =?us-ascii?Q?n/Absk3628yqqw89xqOSePdtDV+hQ60E2Z05BeIIZWFqyhbzDo9zAafHK8BO?=
 =?us-ascii?Q?zMLvK45UOoAF+KpDsUQrwjkRYy+h0u+IsNAZRIgaU+dW4CybMdayAPp3JYCv?=
 =?us-ascii?Q?rzksalZgSpyDkmj5P83wZHq4Nk263eG2JaeW51+w7m2HxYsyBz6Aoj8FMccN?=
 =?us-ascii?Q?qcGHzbeo2MKAuCzJQ0doXc/Hp62sAUwDv4g19Q9SL2bbBEMcgfR0RO2G80CO?=
 =?us-ascii?Q?k4j5Vu2NfyybKJcZDTNhR5Jy8KTxT2Qr8bVMHgWG3qYlErHlM1A5a4cUG5Cx?=
 =?us-ascii?Q?Ojh7I5419wterlyYwhsTLrTP8XySSXHRKVSWvd1a6kVUoMwQzvNtLjZTXCqk?=
 =?us-ascii?Q?CGdTig4MekEN7/UkYZ4LvnBGbTuXPgFz3piX2DHDywQCmh4a4OE6HgIROGJL?=
 =?us-ascii?Q?humcgjvlrd6/EstFQw63Z93qhmHg6KqZeKxvy4thIvbr1qSEa00OukBE8//p?=
 =?us-ascii?Q?Q5VQgq7svB876FkSGjuVO9p0Uwn6rgktWXhwVbpqUmySCOSnOVKuuYS6WZbQ?=
 =?us-ascii?Q?/xvG2O7IkOjJ5as22X1isPZfJkddgO47qnihECFI/5Nw+Z0AkQo3?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c50301b-7cbf-4b7b-6e38-08def6ffaaec
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 16:51:47.8542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XPy4y01kpyrQUp+P94erTYcO0dLhRVZyfVzPIIemmfhh2Oi3dvSh9U3oFP/B0DGEY5R/F0ydo9Pb7uwX8ItCRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB6729

Doorbell interrupts run every QP's RX tasklet on the IRQ CPU. With
several queues, completion and replenishment work piles up there and DMA
channels can run dry.

Run per-QP RX processing on system_dfl_wq. The hard IRQ only queues
work, and independent QPs can run on different CPUs.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/ntb_transport.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 4afad4489772..463ee6f17fcb 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -179,7 +179,7 @@ struct ntb_transport_qp {
 	unsigned int rx_max_frame;
 	unsigned int rx_alloc_entry;
 	dma_cookie_t last_cookie;
-	struct tasklet_struct rxc_db_work;
+	struct work_struct rxc_db_work;
 
 	void (*event_handler)(void *data, int status);
 	struct delayed_work link_work;
@@ -289,7 +289,7 @@ enum {
 #define NTB_QP_DEF_NUM_ENTRIES	100
 #define NTB_LINK_DOWN_TIMEOUT	10
 
-static void ntb_transport_rxc_db(unsigned long data);
+static void ntb_transport_rxc_db(struct work_struct *work);
 static const struct ntb_ctx_ops ntb_transport_ops;
 static struct ntb_client ntb_transport_client;
 static int ntb_async_tx_submit(struct ntb_transport_qp *qp,
@@ -654,7 +654,7 @@ static irqreturn_t ntb_transport_isr(int irq, void *dev)
 	struct ntb_transport_qp *qp = dev;
 
 	if (qp->client_ready)
-		tasklet_schedule(&qp->rxc_db_work);
+		queue_work(system_dfl_wq, &qp->rxc_db_work);
 
 	return IRQ_HANDLED;
 }
@@ -1156,7 +1156,7 @@ static void ntb_qp_link_work(struct work_struct *work)
 			qp->event_handler(qp->cb_data, qp->link_is_up);
 
 		if (qp->active)
-			tasklet_schedule(&qp->rxc_db_work);
+			queue_work(system_dfl_wq, &qp->rxc_db_work);
 	} else if (nt->link_is_up)
 		schedule_delayed_work(&qp->link_work,
 				      msecs_to_jiffies(NTB_LINK_DOWN_TIMEOUT));
@@ -1243,8 +1243,7 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
 	INIT_LIST_HEAD(&qp->tx_free_q);
 	INIT_LIST_HEAD(&qp->tx_offl_q);
 
-	tasklet_init(&qp->rxc_db_work, ntb_transport_rxc_db,
-		     (unsigned long)qp);
+	INIT_WORK(&qp->rxc_db_work, ntb_transport_rxc_db);
 
 	return 0;
 }
@@ -1693,9 +1692,10 @@ static int ntb_process_rxc(struct ntb_transport_qp *qp)
 	return 0;
 }
 
-static void ntb_transport_rxc_db(unsigned long data)
+static void ntb_transport_rxc_db(struct work_struct *work)
 {
-	struct ntb_transport_qp *qp = (void *)data;
+	struct ntb_transport_qp *qp =
+		container_of(work, struct ntb_transport_qp, rxc_db_work);
 	int rc, i;
 
 	dev_dbg(&qp->ndev->pdev->dev, "%s: doorbell %d received\n",
@@ -1716,7 +1716,7 @@ static void ntb_transport_rxc_db(unsigned long data)
 	if (i == qp->rx_max_entry) {
 		/* there is more work to do */
 		if (qp->active)
-			tasklet_schedule(&qp->rxc_db_work);
+			queue_work(system_dfl_wq, &qp->rxc_db_work);
 	} else if (ntb_db_read(qp->ndev) & BIT_ULL(qp->qp_num)) {
 		/* the doorbell bit is set: clear it */
 		ntb_db_clear(qp->ndev, BIT_ULL(qp->qp_num));
@@ -1728,7 +1728,7 @@ static void ntb_transport_rxc_db(unsigned long data)
 		 * there might be some more work to do.
 		 */
 		if (qp->active)
-			tasklet_schedule(&qp->rxc_db_work);
+			queue_work(system_dfl_wq, &qp->rxc_db_work);
 	}
 }
 
@@ -2233,7 +2233,7 @@ void ntb_transport_free_queue(struct ntb_transport_qp *qp)
 	qp_bit = BIT_ULL(qp->qp_num);
 
 	ntb_db_set_mask(qp->ndev, qp_bit);
-	tasklet_kill(&qp->rxc_db_work);
+	cancel_work_sync(&qp->rxc_db_work);
 
 	/* Catch cleanup queued while draining RX processing. */
 	cancel_work_sync(&qp->link_cleanup);
@@ -2334,7 +2334,7 @@ int ntb_transport_rx_enqueue(struct ntb_transport_qp *qp, void *cb, void *data,
 	ntb_list_add(&qp->ntb_rx_q_lock, &entry->entry, &qp->rx_pend_q);
 
 	if (qp->active)
-		tasklet_schedule(&qp->rxc_db_work);
+		queue_work(system_dfl_wq, &qp->rxc_db_work);
 
 	return 0;
 }
@@ -2528,7 +2528,7 @@ static void ntb_transport_doorbell_callback(void *data, int vector)
 		qp = &nt->qp_vec[qp_num];
 
 		if (qp->active)
-			tasklet_schedule(&qp->rxc_db_work);
+			queue_work(system_dfl_wq, &qp->rxc_db_work);
 
 		db_bits &= ~BIT_ULL(qp_num);
 	}
-- 
2.51.0

