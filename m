Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010059.outbound.protection.outlook.com [52.101.229.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D7C34D913
	for <ntb@lists.linux.dev>; Wed, 17 Dec 2025 16:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765990314; cv=fail; b=IZNh6YZBWKbhDKItstBUv0kH/1GzHjse7R2UWGT0FVYCKY8Yi042G50zjTYA5Ge/5zabz2uh51oUIZhIK6C7DNNUkVLIaN8pMSOyiTvZcnMMNqqCmoaHb2Lxl3R53DB4l8SwNxABaZnYOqz+8gVikJy9WeJDbrVIYn7SfLWSBZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765990314; c=relaxed/simple;
	bh=+CYox9c41Gv586t58+9Ml/KFAqaaQYn2z11ny3NnvMc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=jRyFdWJnYKSR9psi+YAztjtDPppShhuaJBpODGYZympKwWzuMFPzq7T4ejPdDruLBmnDZRVdIvyE8gG1a0X9ySjKrHmYqOgKiD7unUx5OfpMSzfTiEyMLJ0Bh4Ynzgn2yiKU8dtRc5gyooP5pOIDzL/cp1Zz9Gsn0spH3JMWrsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=XBxNZa5P; arc=fail smtp.client-ip=52.101.229.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="XBxNZa5P"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hHpAoRFZjzjPQpKDIuZtKW2JtOgJ1mw5klYsnbsytbfqS8WCkYdBy+oH8ZVrdgY4BH/R82YBJjrEd5X7T1Nq64U/DbTYiIWAu9dOOnJIdU6WVtvJQ5c3q6MUmkPBOHLnd0DcYIGTRD45pqbi7xI+2RyCRjy5in6AnYmzE+Q4biosLc1wuq+VBj3UyagqJoiFRABmcZLoqUFpS2a4SAYsXAUo1EmrLAzPJ80Gj8IFOjBB3fyu7n/QEcruAutRLJLz7UawltQAKfZtoShxlBVnB3QkCfmktaWHy8i6RHRca5uHwiZ3mbwRS6ESLlI/mt3Wfo351Xxy9T98vqCL7lrztw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y5IlQB4Jmg3VEM3uSGYdgQ4i6qsNEB/z2PL1Jrmq54s=;
 b=Fcm1nN+Ts1H+1AMedn5MD5TQq+PzeKPmmKBIqoDnteuYLRguUliCt24JBpQswbjW+U+sO/ShHfsI50icLBws87vX7kpYnS/EONvyiVxH3pll9KkdKpTn0iYCGKbS4/qgAvz7pcWIFlHGYrWgNkHfvxB5Z15FyLoLV831cANvfcaQ9/q7rnqstAJdWAqkpNvOWIZswxJCeugynKR3rI/mltbQmtmDFOD4HqWPDe58wOkH//HPTEeu5MenZFhXxOnKFPWKkg2S0Wb0JFa9OqVh9XN6GWHpYBXLz6Bc/QWnh7ciuPCv9t+utHvj6AX/SV0o/jWlW9ySTjUVuBMckKkGEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y5IlQB4Jmg3VEM3uSGYdgQ4i6qsNEB/z2PL1Jrmq54s=;
 b=XBxNZa5PpoidYg/1S4ThSiY1MY9+sOXLOsjjlLMoSU2dRPqLyDfMQI00ronrdUikFUlrLAXpEJdT77sMRWbTSbMWRmw+2C2AmrtEAtVT8v28NpaRhLpOnQgbZib9DULKG9TE1iUk0YPqtZHxw9wl5NfYljtDY6C0h3EnzjnLeAw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by TY4P286MB5643.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:28a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 14:18:08 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 14:18:08 +0000
From: Koichiro Den <den@valinux.co.jp>
To: ntb@lists.linux.dev
Cc: jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	Frank.Li@nxp.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] NTB: ntb_transport: Use seq_file for QP stats debugfs
Date: Wed, 17 Dec 2025 23:18:01 +0900
Message-ID: <20251217141801.3157143-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0067.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::9) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|TY4P286MB5643:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ccd5bf1-ba25-42cb-4af8-08de3d7719f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|10070799003|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L2KTK0r+CQnaAX8m5GmMdogI3MGOXjCbAidBfRa8G1WBiy7fRc8DyK6FjD3k?=
 =?us-ascii?Q?uU9DvGT7btpUOZCFEzpiRcgiJx+lv5LjTusxM2ulEu17k7yDZhTL/gT40tjO?=
 =?us-ascii?Q?wwxHyZNwVBHKqyUHEqdK0EhHfnBIvvKeXpnpwRVfkPADn3bFhDmw2McTcpaA?=
 =?us-ascii?Q?fYmzTWHxGqXxt09htIFlCx2zvDjTxKXoPlE9EHFhfmoQoE18cQGJV/GnqBbj?=
 =?us-ascii?Q?r3PND7pXNJWjSu4HJEmhgwEkMTPAzSZ+X1+K4jJ0LBM7u4ZN3o4cNouUWGHc?=
 =?us-ascii?Q?eBGeLtecOGbnTpG+ZQ9xDkiVC4e761G6RkxUwiYHcx1/abq9zEyLrR2VDoJf?=
 =?us-ascii?Q?BuvoV5V/lpwyR4THC89jS9fPZqUayAzMvbpnLbfe2DwAQ+IfWK1zc6ISsxzI?=
 =?us-ascii?Q?46+mUylmmqPiZ+YXs7ExcLnGJKN64iDq2/y9rH8+3jtVflDRmZaDaX/vE8Kh?=
 =?us-ascii?Q?86xVAU03AuWp11f9psfkgu1YXZFlcA8CQNrE4MrIO+B9GAQEsWZEi0f3PLqk?=
 =?us-ascii?Q?VlxvqPgfJ2OUVYq+2hZbqjZsbTtTIPbV2xS9mCOBQs2TQZz+s80Bx1LD3Zj2?=
 =?us-ascii?Q?XBjqqx8qtQ9+8uFwvRiGCM9Vnj4zIa5Z4QwcszsX+q3j9BD4RooHZssgga6M?=
 =?us-ascii?Q?OPNifz36vWRGZ7aLKAkzo0oIEbdTbz2BpYjviowRd0RR2P7pgi+6CpXU9sJ8?=
 =?us-ascii?Q?CzMkaSxc8YJTJN10mYEqgLX+TdnonzDunVAGWtjY8Xb+hIgaU3Y6cfF+HjDq?=
 =?us-ascii?Q?m5J/GFBKJngcKlYXLt8/qtWu97v+La4PhicZc1Rcy3ukgrb+l0vCizHhlVNi?=
 =?us-ascii?Q?eQKS/nZVEz53JtSP7UIaQBVH6gqE0cRCLLm7WpWnvlPC8bjtbn6ZtjrQm+qo?=
 =?us-ascii?Q?PUCO6+7/iArK7As+yhskICfF3n74iVl1tcJ5+d7TkOyYgot2g5nldMzTt2k7?=
 =?us-ascii?Q?RNo8UcYCIL0jQwKZMefGTNHItyBFQaly8x3cxyMqid9KBZunf0TnWDcfISeh?=
 =?us-ascii?Q?qrZT1zpMwOrNXv6iXW2s49dp62rl7JhqSHw4Rg+cAc30LIw/vzt8+8wOqujh?=
 =?us-ascii?Q?vGHCEfQeAf/EjqGc3aJZNJNRTnnqyGGoTB1izTL7NzCJakeTBt9qnV4XXzGp?=
 =?us-ascii?Q?Wiq5lzkuX/ODkdZo52coeWoHP/3Jp3Fk4cGVynete6N72xRrbbpD/9Y5sfqz?=
 =?us-ascii?Q?RReRIN7QuNpOdqRLUeA4sxI2Sfk8/oIK2BcX+KyrzACmiqu03xDynAewMTrk?=
 =?us-ascii?Q?qJOclzCB5jbVss5Fug0WhqH/Xpv3EYnL6lbkfnWx+0IjnkTclHtcW7usidcd?=
 =?us-ascii?Q?nR52ljoi78OW0/xO6xyD9GNtMi2V14xstLJeR8x1lLR020nKK956Q7BpnzbF?=
 =?us-ascii?Q?6vT9wqYPf3JKng0dI8GJeRQthztgrAiaORM8EBszTjcFOqvcNRYlYfWx7NsF?=
 =?us-ascii?Q?0HGNWEGNdkYjajy/mAf2N+4s4oKmWM9ntaD4eBplgMH4ZdRLEV3QOA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zBunC5be2eCqDZV2MnxG3Q9VABpkyxJ16Dq1tUi5z6MFrFB4HH+S3jMmdI9O?=
 =?us-ascii?Q?fDGVoVVrvR+soUf6TSFnm6i6egIA5rnX6x+Uus8q9jYSSjBCtZ8mg0okqSf+?=
 =?us-ascii?Q?XgOHjCU4RC+kH8ppyjXMRhObvVy7z2hgqWV/bdqdJ4LW7ee6JO6srFFN2hp4?=
 =?us-ascii?Q?V2p06fmM6LiDyFddO00td1Oq5quekgv/KdSgWoeu51Xc2UKPs3JgYrw+nU71?=
 =?us-ascii?Q?xjgkYfjkJm6c793obfRtYncT8kmoA8gKBKgXfbao2VTVa2k1p7buzE8ym3bs?=
 =?us-ascii?Q?1z284sfxICcbf07uyoeeypHuCpy6OKoM5FBtWFsfgySWrak6/4cN02CI+mRI?=
 =?us-ascii?Q?sDhEMWzX5F2SYU9IwFvWkC/nAxRkd/MV67ZduCMRCqc2yhP9KBFW5Q4I5q07?=
 =?us-ascii?Q?JmkVXh5OMnwA4Fw1IvL+5WExevfb6Wz2ciAZEEnrGXZl+ClB+Pd/5lxmR4Ac?=
 =?us-ascii?Q?qGqlKLRA5UmhfyaIX1J/FHdg4Jq1zyEj7afA34gT1ahBlRGFuTQLAF7W/6GH?=
 =?us-ascii?Q?lVvBZi4oo6RzTMG8SAVoyOVUNuG/i6eoKBd1GEAkgX9IV1QcuyIcuuPSdNgE?=
 =?us-ascii?Q?XdRbKGnwILTEiQWFZn8VKa9MXcv+0qH5+M2L930+gxAuCQVmIxd2orrty7rg?=
 =?us-ascii?Q?Vc4BhMPrmsozCMbmVaLoUsCGWv4F4iY3paMA1itWlqhHjO+ks5cSLQgqEfbX?=
 =?us-ascii?Q?jbhvkixFdze6iZ5Go6Rr0vaARHzcV0S7PI3pPk7kCQRbHYxp83CWqosblonh?=
 =?us-ascii?Q?nKpGlfA0VbaLElKf6tavQI69qsFRw7xAhX+rHuLqFcZy/OwmpHSyZUCmQoOv?=
 =?us-ascii?Q?fwPjVPtv4YCVDR0H1unoghQpKSQ8AfWZ+sEIVOVdORJfmCYARBpd1k6mUzvh?=
 =?us-ascii?Q?P9/f3JrzQO1bzNSrCPHchRbCGt2b9ZTva8JxiFoD2WQGzvwVAHiRxtM+kPxU?=
 =?us-ascii?Q?S7J/oSDNqJ9ALmyc2adRhUwnR/p1D/AKtm7EoEbJXjDAspF19aHgyrZggyn+?=
 =?us-ascii?Q?oj/pjiNVsJEQT3hinjlC+VW/cxNc1WcwP+ClbwqodPusGzNvvB83Jx1re64L?=
 =?us-ascii?Q?yqendYQ26VLQPkMSQz2P+2onw/ws0hBAViEbf/s2pnNLaKUzM3Lb6bveqxNy?=
 =?us-ascii?Q?i43eNsN38Kqckc8PiNPWZC/yD/G6uKia+xOPd8EXwb0+AuspQVqMQ/Yz8BmS?=
 =?us-ascii?Q?qKSFdaRbxiiAnSLEZFzXXE2gfkM8CMix0iR5T73zlpgEMQOTjxtKvM4riKDK?=
 =?us-ascii?Q?1FexuEj4Y+JXb3ndNqQBLW3dJRDcTcaFg5VtxFauNuUz1vuJpK1ZnBJe+gzo?=
 =?us-ascii?Q?FkCMSQdO0nZ5SBN07mTq5tyUh4Ow9q//LLtj25Ra/gfwo9hBVQGJ7rSuJ+Dc?=
 =?us-ascii?Q?yBCb/ukWnfKHcYMWh9TCi7GjfGf1FkNqr78Isu7M89ff6QOlMu/v+KonrCwt?=
 =?us-ascii?Q?1mdHaZmE9bMmufTD2jszp/62A76+T7MXoaQ6owp9w/7n/UMhkcGN5pjZX60z?=
 =?us-ascii?Q?XS5z/RAxWr+0GzLpZi469pdWfJeeB4XlzBT108nnhNPiFpMGtxkVHaFi36cI?=
 =?us-ascii?Q?+kdiKr34R/XlhwUryKwWsJN0nnsWPX8RLWE69iCImyNB5WojYS8SKOcKx+ql?=
 =?us-ascii?Q?k35w9bgM5dU1vprodeqjoP8=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ccd5bf1-ba25-42cb-4af8-08de3d7719f1
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 14:18:08.0006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sDZmXsTXVnOpjH+Q5kAuIm9HFhjSOI5yvpDgzuvQSBRIybiASSJAGWSBNLZyS2aDpv8oE7lzZrHPUi8BLQbubw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB5643

The ./qp*/stats debugfs file for each NTB transport QP is currently
implemented with a hand-crafted kmalloc() buffer and a series of
scnprintf() calls. This is a pre-seq_file style pattern and makes future
extensions easy to truncate.

Convert the stats file to use the seq_file helpers via
DEFINE_SHOW_ATTRIBUTE(), which simplifies the code and lets the seq_file
core handle buffering and partial reads.

While touching this area, fix a bug in the per-QP debugfs directory
naming: the buffer used for "qp%d" was only 4 bytes, which truncates
names like "qp10" to "qp1" and causes multiple queues to share the same
directory. Enlarge the buffer and use sizeof() to avoid truncation.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Note: This patch is split out from the following series, where it was
originally included as a preparatory change (refactor + small fix):
https://lore.kernel.org/all/aS3xe0CNHeIMUu7P@lizhi-Precision-Tower-5810/

 drivers/ntb/ntb_transport.c | 136 +++++++++++-------------------------
 1 file changed, 41 insertions(+), 95 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index eb875e3db2e3..d5a544bf8fd6 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -57,6 +57,7 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
+#include <linux/seq_file.h>
 #include <linux/types.h>
 #include <linux/uaccess.h>
 #include <linux/mutex.h>
@@ -466,104 +467,49 @@ void ntb_transport_unregister_client(struct ntb_transport_client *drv)
 }
 EXPORT_SYMBOL_GPL(ntb_transport_unregister_client);
 
-static ssize_t debugfs_read(struct file *filp, char __user *ubuf, size_t count,
-			    loff_t *offp)
+static int ntb_qp_debugfs_stats_show(struct seq_file *s, void *v)
 {
-	struct ntb_transport_qp *qp;
-	char *buf;
-	ssize_t ret, out_offset, out_count;
-
-	qp = filp->private_data;
+	struct ntb_transport_qp *qp = s->private;
 
 	if (!qp || !qp->link_is_up)
 		return 0;
 
-	out_count = 1000;
-
-	buf = kmalloc(out_count, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
+	seq_puts(s, "\nNTB QP stats:\n\n");
+
+	seq_printf(s, "rx_bytes - \t%llu\n", qp->rx_bytes);
+	seq_printf(s, "rx_pkts - \t%llu\n", qp->rx_pkts);
+	seq_printf(s, "rx_memcpy - \t%llu\n", qp->rx_memcpy);
+	seq_printf(s, "rx_async - \t%llu\n", qp->rx_async);
+	seq_printf(s, "rx_ring_empty - %llu\n", qp->rx_ring_empty);
+	seq_printf(s, "rx_err_no_buf - %llu\n", qp->rx_err_no_buf);
+	seq_printf(s, "rx_err_oflow - \t%llu\n", qp->rx_err_oflow);
+	seq_printf(s, "rx_err_ver - \t%llu\n", qp->rx_err_ver);
+	seq_printf(s, "rx_buff - \t0x%p\n", qp->rx_buff);
+	seq_printf(s, "rx_index - \t%u\n", qp->rx_index);
+	seq_printf(s, "rx_max_entry - \t%u\n", qp->rx_max_entry);
+	seq_printf(s, "rx_alloc_entry - \t%u\n\n", qp->rx_alloc_entry);
+
+	seq_printf(s, "tx_bytes - \t%llu\n", qp->tx_bytes);
+	seq_printf(s, "tx_pkts - \t%llu\n", qp->tx_pkts);
+	seq_printf(s, "tx_memcpy - \t%llu\n", qp->tx_memcpy);
+	seq_printf(s, "tx_async - \t%llu\n", qp->tx_async);
+	seq_printf(s, "tx_ring_full - \t%llu\n", qp->tx_ring_full);
+	seq_printf(s, "tx_err_no_buf - %llu\n", qp->tx_err_no_buf);
+	seq_printf(s, "tx_mw - \t0x%p\n", qp->tx_mw);
+	seq_printf(s, "tx_index (H) - \t%u\n", qp->tx_index);
+	seq_printf(s, "RRI (T) - \t%u\n", qp->remote_rx_info->entry);
+	seq_printf(s, "tx_max_entry - \t%u\n", qp->tx_max_entry);
+	seq_printf(s, "free tx - \t%u\n", ntb_transport_tx_free_entry(qp));
+	seq_putc(s, '\n');
+
+	seq_printf(s, "Using TX DMA - \t%s\n", qp->tx_dma_chan ? "Yes" : "No");
+	seq_printf(s, "Using RX DMA - \t%s\n", qp->rx_dma_chan ? "Yes" : "No");
+	seq_printf(s, "QP Link - \t%s\n", qp->link_is_up ? "Up" : "Down");
+	seq_putc(s, '\n');
 
-	out_offset = 0;
-	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
-			       "\nNTB QP stats:\n\n");
-	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
-			       "rx_bytes - \t%llu\n", qp->rx_bytes);
-	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
-			       "rx_pkts - \t%llu\n", qp->rx_pkts);
-	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
-			       "rx_memcpy - \t%llu\n", qp->rx_memcpy);
-	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
-			       "rx_async - \t%llu\n", qp->rx_async);
-	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
-			       "rx_ring_empty - %llu\n", qp->rx_ring_empty);
-	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
-			       "rx_err_no_buf - %llu\n", qp->rx_err_no_buf);
-	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
-			       "rx_err_oflow - \t%llu\n", qp->rx_err_oflow);
-	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
-			       "rx_err_ver - \t%llu\n", qp->rx_err_ver);
-	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
-			       "rx_buff - \t0x%p\n", qp->rx_buff);
-	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
-			       "rx_index - \t%u\n", qp->rx_index);
-	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
-			       "rx_max_entry - \t%u\n", qp->rx_max_entry);
-	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
-			       "rx_alloc_entry - \t%u\n\n", qp->rx_alloc_entry);
-
-	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
-			       "tx_bytes - \t%llu\n", qp->tx_bytes);
-	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
-			       "tx_pkts - \t%llu\n", qp->tx_pkts);
-	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
-			       "tx_memcpy - \t%llu\n", qp->tx_memcpy);
-	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
-			       "tx_async - \t%llu\n", qp->tx_async);
-	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
-			       "tx_ring_full - \t%llu\n", qp->tx_ring_full);
-	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
-			       "tx_err_no_buf - %llu\n", qp->tx_err_no_buf);
-	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
-			       "tx_mw - \t0x%p\n", qp->tx_mw);
-	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
-			       "tx_index (H) - \t%u\n", qp->tx_index);
-	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
-			       "RRI (T) - \t%u\n",
-			       qp->remote_rx_info->entry);
-	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
-			       "tx_max_entry - \t%u\n", qp->tx_max_entry);
-	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
-			       "free tx - \t%u\n",
-			       ntb_transport_tx_free_entry(qp));
-
-	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
-			       "\n");
-	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
-			       "Using TX DMA - \t%s\n",
-			       qp->tx_dma_chan ? "Yes" : "No");
-	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
-			       "Using RX DMA - \t%s\n",
-			       qp->rx_dma_chan ? "Yes" : "No");
-	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
-			       "QP Link - \t%s\n",
-			       qp->link_is_up ? "Up" : "Down");
-	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
-			       "\n");
-
-	if (out_offset > out_count)
-		out_offset = out_count;
-
-	ret = simple_read_from_buffer(ubuf, count, offp, buf, out_offset);
-	kfree(buf);
-	return ret;
-}
-
-static const struct file_operations ntb_qp_debugfs_stats = {
-	.owner = THIS_MODULE,
-	.open = simple_open,
-	.read = debugfs_read,
-};
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(ntb_qp_debugfs_stats);
 
 static void ntb_list_add(spinlock_t *lock, struct list_head *entry,
 			 struct list_head *list)
@@ -1236,15 +1182,15 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
 	qp->tx_max_entry = tx_size / qp->tx_max_frame;
 
 	if (nt->debugfs_node_dir) {
-		char debugfs_name[4];
+		char debugfs_name[8];
 
-		snprintf(debugfs_name, 4, "qp%d", qp_num);
+		snprintf(debugfs_name, sizeof(debugfs_name), "qp%d", qp_num);
 		qp->debugfs_dir = debugfs_create_dir(debugfs_name,
 						     nt->debugfs_node_dir);
 
 		qp->debugfs_stats = debugfs_create_file("stats", S_IRUSR,
 							qp->debugfs_dir, qp,
-							&ntb_qp_debugfs_stats);
+							&ntb_qp_debugfs_stats_fops);
 	} else {
 		qp->debugfs_dir = NULL;
 		qp->debugfs_stats = NULL;
-- 
2.51.0

