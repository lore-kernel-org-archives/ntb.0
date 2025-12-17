Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010010.outbound.protection.outlook.com [52.101.228.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5F234679A
	for <ntb@lists.linux.dev>; Wed, 17 Dec 2025 17:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765994130; cv=fail; b=KniQDpr7e+sy3ADqKfBODSzBCnt5i/6z8R2+GoP29uh50T2U0m/xCsi/CPlI2K0izrsbZWToNz1yDphhKNSSoMG6dzJ+eFopvcJNXJHQUxv1+6jRg+UVehG03JY+XOhJdZKmtrDso1eamiqT8ek6e8IVw+IElc6diSZEujNIbw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765994130; c=relaxed/simple;
	bh=jc8wjfCO3p8I/FXfHwcdk0LytYX2/tgibAas7kMKmq8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=PmeSrQwAkSaiBxtcB+E72/zPG9Oqi4MAySYvrfJKJIXuWC3eGVAAeLaWgyepqTPGLNZ1/0lESOISO0tbqmk//mLrK+KfA3gGZEAVlPO8dlmFL0n8zP/EsSGBi7z4GYvLlAWsi0wzPyU7WrO//dq5hWWjebyiJlhkdKEWAVpMu80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=NXC5HRG8; arc=fail smtp.client-ip=52.101.228.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="NXC5HRG8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FdIgzUWLLozsvWd4fQ46q2M9vM6oH8YgLOS5xeLmeVlwhUxgXBdLdk4l/q15G7Tc9M94GX0O/dvpAYglz/yxXWktCi7zTpgcfVIqOz+TE7z/Kr8+j1LpBd3m4LkpFv0A32KUh0nogyoe+H7IeKYnxPB2Iydf67b97uXFzS9qa0rBxSYUKiuLbrWm+ykEsNLUHRnNICWiWwVRUYzYMhk9npc41Pnka7dIeLkHhQSgm4tHnn1x4Mm1zNKYvR28O9ElzXt0BhksLt9/3S7CE07zPkA6e/gc817ohosSfKBSuIhGy3SIe03dc7Ew8g50vp2pzQTrKKPkETJalqhmB0eTxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q6gAe10EMAE/7Q3YxkVkQSKJrWMrOX64yraaPZMfX4E=;
 b=rN5tsRzH7BrDV81uO63FYrquYqFF9gQE9Xuq4S0JHBoXyhewGT9KoDrEb6hHa7PWOlpN7u52k0UlvALLG516kAt+ZuaeAC0c+fpl+D7G+emfYweqlUpeylnCZVc5j7zvG2heygFYKeYPDseUIvxzOwzgm0dexAifNDxPkTmXvcs6wVEdmGKKDOmmWrelWck0yPPKCntGUbJtWMaDusplkRfk+095TH7TM3WIR39CvZP3miQncx+dY9XOajYgZoA5GtXLgTkJmdqel+XJnbDLPvzz3fU/hkzH/bK8Zedd+64vDXUHk8+0XoxYXEj9HAR2NB3zj9N6QFX9ry7zKsuZfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q6gAe10EMAE/7Q3YxkVkQSKJrWMrOX64yraaPZMfX4E=;
 b=NXC5HRG8FRSIafcgGM5Ynlv1dfXnwu1cThUT/1Z8UjFDXvmOpsQUtWR1m8tNdHcCH2FOL70rRn0L+Ciw5YIoxFxSsEYKXKsnoj3axxnfYPXP0CP9Bg551iwTRfe01iFPgWiwvhaO/ax2nJ+98L2iO5qpi13c7rGlQFdLOWPp5ZY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by OS3P286MB2758.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1fe::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 08:20:04 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 08:20:03 +0000
From: Koichiro Den <den@valinux.co.jp>
To: ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	Frank.Li@nxp.com
Subject: [PATCH] NTB: ntb_transport: Use seq_file for QP stats debugfs
Date: Wed, 17 Dec 2025 17:19:55 +0900
Message-ID: <20251217081955.3137163-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0039.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::14) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|OS3P286MB2758:EE_
X-MS-Office365-Filtering-Correlation-Id: 13475fc3-6f57-4c5e-5344-08de3d451453
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|10070799003|366016|376014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?DFpQiwi1VKWOvKWDaD2gyVSJbvMr+WzMC7qCaiFMb/6VWfn/F5pTj5A21co2?=
 =?us-ascii?Q?3FRDk36YHQ+t8geg6QYpziWnz5QtH/HGcnQv383d/n6FD34IHJxHkBmFK1BQ?=
 =?us-ascii?Q?KQI+B9AsqdjK5aFGaxh1Q1e4SNHbOSpN7VYNRXqobXI+Adu25ajXJPky1zJj?=
 =?us-ascii?Q?/ZeW+bmqypXat//1/9ERNssLb0lCilx3qWiQCrsvFNKsolzrq2AtgJttmlQ1?=
 =?us-ascii?Q?ZTLRVlGElv926q9/PXWjK/ajz+YbV30TKw39/Icmf7ujT4/2xIEtU8vdtfVp?=
 =?us-ascii?Q?yU4A9QBev5nNUZYnDrHLUvw4f0cSXOpFwp0gePgKJbkNJ1aXpgSWUf0jmldW?=
 =?us-ascii?Q?0ETPW3w5nRkFTRokXRVnNHpuRX0Q+CfDfXyWelrNkTNWGvktMZM1DYIZeR2k?=
 =?us-ascii?Q?BoWq+7fUMYNjtE8tk43rzQ3frNkSEyUKUqDs+dTtND5puHm8CT1KK7qg/moP?=
 =?us-ascii?Q?SE7hy2UFzorVVjOrIHO/R8z6gKHHm+2UDHv3WljLz5Cnj6h17Zk26BAQZynU?=
 =?us-ascii?Q?DYa2zcKcXEgVPV//mBZrP4qSdQIteI2Nd4sdBGfasRUEnm8CRK8uwtd4/ck1?=
 =?us-ascii?Q?QRn+oKtx0tB+3QJpJp501t027FtqHgev4AhdFg+EoZ9gjrskqjf5hdM2qLU/?=
 =?us-ascii?Q?8ZT0uqDWaDWJAQmvjkqZ5s000vzQhOvQR91fWJetgf638nYxGJbRvQuBKVAP?=
 =?us-ascii?Q?5CsQZS6j+kBSh4Ct76rI0h3k51JI1CQRfrVBnZIoGLClgzPqzWoewa8ucL8A?=
 =?us-ascii?Q?LlQpfkZ8oOk4KIA2fLdfIp3TM4Dr1/u9tvGESZysgUCtpPnvVfDksnyvajqL?=
 =?us-ascii?Q?rZTNn9dLa1TUN+HHBkxhm9IeVBABy7ejD6zKXLzAvnBmjm4ZSR7t+uImRAdP?=
 =?us-ascii?Q?+NEwTUR1rEqR29AYdTrc0sRoGJEMRipDNcHwgms9WnKmiZTfbdqAkGn5XXGA?=
 =?us-ascii?Q?RkijYQ0BcG86Uw2VJE6006zTHmCMxMrfoOKtVJNifQRWmcondVGCY3szP7Pq?=
 =?us-ascii?Q?W77YI1Jzs84NqGsVV+/NO4E1GtTtpHoCBJ3eACn8HdmPR2XvDnJPoTuio71X?=
 =?us-ascii?Q?NIuvuRtsEy/0Y/Tg8D+0HFpfH/JP61BOeQsIPwKvmfswv+d84c8mVCo2ym2P?=
 =?us-ascii?Q?oG8NPcAKqvtP/PhZQU8QX4rlb001z9f3bhp6xAtwpElLi7rAMDv5NmofIps/?=
 =?us-ascii?Q?yNG5DC/5NojUwNZuz9l4W6WXjTq398WNHiDLCNLkO/PWnR04TPH6NY58IFqo?=
 =?us-ascii?Q?iuf9pEg6Y+IodFnzreX/O58HYiAeXe5tE7F/6yJ80cS31tp1tnoivngLKFsA?=
 =?us-ascii?Q?zwoeTA0qNxm5incLkGncJK8+ExzxAeH0g927Y8pA0NwcVptIhR7EEe9tKXJc?=
 =?us-ascii?Q?qC9K0FjjPZpB+D6OfUQjlUOgLbcLuKtL2yna2HnMp+PHTxjypDmOTOYagURt?=
 =?us-ascii?Q?luV/k5IMqaiEuPK33BXb2iBlftkh9Pk7Gbciu52I/68+wfkEwbeSfQ=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?DNWslmnrrcOLa6fkfgScmCSveWA2Od4oE7KHnEbE8Lk4SulkzILGdyKwR1AL?=
 =?us-ascii?Q?2ufoDsLVO5US4Va2dNJQ2JJjZMwDKonuln3rTUtRcEPfUILbHPRgbMqifj6q?=
 =?us-ascii?Q?PL80OXkMe0RYfy0G95u+QZzhglapC+UKnPf5h+Y8YhEHdllJwATymj/6Uu4r?=
 =?us-ascii?Q?PW+r5ky3M5HnBu96aef/pZ060CrRLP5MQdzxqucQZC/CooGKebPFUHn/NpJ0?=
 =?us-ascii?Q?wLWIihbTKyujd6YnDqSbkkuqoIc/sj88GOJ9MZYYK1d7yvJDa8xaZZ8I673M?=
 =?us-ascii?Q?C4JCIk01XuJbZCEqohF72qPqUk6pcPf/HZm/Y27iAMKbUe2BR8OnZhI+WCGK?=
 =?us-ascii?Q?+7veXPd6mdc0zySoiy4CZvPv5aPXuzkOih80ISQdzd0mNGqS28+PkxcwDliM?=
 =?us-ascii?Q?LSuqustN2PoYJoKEOK5BDhvnmGLqM2j07NkANNYEoXkHWyGLmeY5L3QbmdY/?=
 =?us-ascii?Q?lQVkLoxLErqYOAybeBI1KAlCJyCYuuZE4HiyeKG/i3Ilm+lrQZWjS7RevE8F?=
 =?us-ascii?Q?K21P0SFbHstKrROoCib/rldV9z35a9JMKQq6bAG68YoPzDSgY6QduHSLocpB?=
 =?us-ascii?Q?97b4ENm+bpM2M4DM6YeHV/rkwzy7Ne4W0SU0UKoWi2XL/MX8ErpGo0JtHf0E?=
 =?us-ascii?Q?mmzmXWBaKh0GEAOnairLXXEOWxjVDj3PFy5Iqz+oFVQgAq0Xys72WiG4PG8P?=
 =?us-ascii?Q?NmHgkyIwOPrCUxF3YokJyOiwGoYHunuyn+cHgu3CP/RLe3+WzLinSx5Hz6Ui?=
 =?us-ascii?Q?i4VoeKEl3ewxKKTqAjjnFTGU7fs7597jUQu4lOAUfUHL8e0XLUS1OUpvrZdy?=
 =?us-ascii?Q?YG/Cierh9hvbnkw9KN0K1qR2bfceEUKgW5UasjGJ0EwCvBSZgg0rywpXv/WU?=
 =?us-ascii?Q?9n//LUmLF+b0l2xNhdfWHOFHhQDZEMJ34Up8Qa5+KLjfUwMPQRvt5Glz3GzP?=
 =?us-ascii?Q?q8pNfZMk0ZdSibg6iUIYi6U/qwj0aAEGIf3HW6/F8m6OWhsTzmVK7Y4QZbKK?=
 =?us-ascii?Q?rU1sA5WDStGuXqEIwFKw/shBt3SxlgOawFNydUbSaogkSPdg+FTPI14THj1Y?=
 =?us-ascii?Q?EP9yeAn78nKeGg/k6tpoGTcrRDUtFvTW3bCjbzVJSHaIC9tFU5umrLYlz++e?=
 =?us-ascii?Q?t784bTzkYM2TpZgMQkaGv2qHGJnCNxmKOrY0BVRzdSxejH5YYOa0rfdkidf3?=
 =?us-ascii?Q?fwLdQ1wg9Uq03YynllzzKoXPi+s1kWIcspttUYymcu2ezQzjaqtF4IppkufY?=
 =?us-ascii?Q?yzamLE9FD9c89qS4jWezmirV739dmlAgh4SANATJiuB3bSRJnNKoKwJ1Drah?=
 =?us-ascii?Q?zDPOsQdtpK/akrbyd0/8KVSUH7E9Aeo9I5OJ/GSQdtmeKtJvoYrn/Bnx/dH0?=
 =?us-ascii?Q?GLx39gsEVaJ/UUJMwmyxJBy/6VGTpn+nBbXZwVioBAgGXBYDPRZvFNLKm14M?=
 =?us-ascii?Q?QqIKUgbtVOypuhQUZSspafzkp5gVXIFBTzSPw6aLclgPdMQaT3ACZS5oJxKV?=
 =?us-ascii?Q?ge8q8jcgRG8x+loMggBOh4KSjNn4+Ej+8VcfprzfNuJZbG03+zXJYsfeAWcB?=
 =?us-ascii?Q?4CGYj8YqHhM5sRNcqMIuRbAENIZdB3BFkSNu8Q18kaeE0YQ9jmdjlf4vXLkw?=
 =?us-ascii?Q?e61Yw7p3vicucYWNvWhAij8=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 13475fc3-6f57-4c5e-5344-08de3d451453
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 08:20:03.8099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q/aEFXIJrW7JL02tFG46Tvaqk6yp7I215CzHP0NcwB1+ZxpizxMJN2dghMR+OeMHwXFrJca296K15jCuZRn7tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB2758

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
---
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

