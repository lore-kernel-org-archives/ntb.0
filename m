Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021125.outbound.protection.outlook.com [40.107.74.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7F524677A
	for <ntb@lists.linux.dev>; Wed,  7 Jan 2026 04:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767759910; cv=fail; b=oX5qxswemnZcC0+VQdj60/5IZqnvj6ZPMUnpYYGrz6feEUqll3nZnhQv77og6fZaTw2z7qLGmUVW6kLzmfIeu7CCeSCxD9Wltb1GU2utyyUkgd6T7hl8N1j+jlaYLYC8GVdVX3WMhrWdgBcikeoR/jazcRV8rLwc+VUxVGpoOVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767759910; c=relaxed/simple;
	bh=j3j8uLQX7wGurFNkmEyPhmpAG0fv6h58NCDWmNEDJpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=khK2zZIUwlNgdoz64PznsoW/YA13kTaeQOUhDoxfpsrGCD5mVPqy84XMwk0u2Do87aqSEdOm8oMTlfDqncwV2Yox/RmkQrO/OqQBzK+99nUpW247XH6sTYPhiEPVOM+AaDsTQ7SdnkCicEesHUDs2/zJXjj7jjUnApSXEV/VUMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=iYeUYOgM; arc=fail smtp.client-ip=40.107.74.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="iYeUYOgM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YcUsWpDs1eN3O+a6SRG9sVg7GG6VyHgCJ5NZl9ddAG7Z32MJNXCqyuI9mgApLHbHjoc9mjkFQQjrRqyTEqvJRDEmLzSaoCuK5syLBoWVSrFEOdMx/wp0ji8Jir7WwdV9VH9z/bix1vfDRHgD6gthi3P+DQidS27lKAdD3PkJ/oxJoCP+5RTCSsiL25+K6nwRFl5PTmfLrbkc9++UZqrkKDeXVHi0PKuhr48xmXwFj5g6ALYC38UlUQ+9BFCo4Z2M6hoaAEKTndsKVw2lqshGl5i9mgZwsBNcU/GU89ZSmctOZ0TVXcsqvHNoGTp0QWzmMiPZd/B1H6dVTkbcPgr16A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HrBKk5cMlp0hwbiizrNGXW/wH9vzIufpRrOJNFxMzrk=;
 b=XBt/rbXC8w2NoC2doO9Vp8+VBB84K4M6cFcfkFSuo7FNChDsEKjbVw525OVxmY7vx0iLxP6LCq3fL6uvYR2mGDRRyxLp1IHbYNdIbxIVsC0FPoYUxMs7iyHzc/GaMN1PhV4kLD5Bd3LwaX8b/nKUZ2CKHV+AeF6wdetzGk31s9bIS6fAj7mYhQKPjAtF8bx0b4v7qDW8jEKSZ2MUVMfFKAEIHaQ6aAT2sFDczVZj08MjzR5XAfRYV/zerJ0tjp/ilTX8zDDZjIIVRi1lR3nW9FeDej31FeY/rWtq/8eK2U8v9eglpm4pwOb253HqWWtaBxgeA9nbl1IWQhrb3tkdDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HrBKk5cMlp0hwbiizrNGXW/wH9vzIufpRrOJNFxMzrk=;
 b=iYeUYOgMPWb614nIvtUQCsxwT0xN/2JyLHwmK4hEcMPLXgRzn0YttJbPsn66wvvvfIPxU+HZG3Q+Mg5ctIGdLtzeTa7RyqYcEKNz70Qf0O3M8/kNw9qyJ0+wJF/fapvdPihBPc1DKSgXuYIcT/8XWQ2Dhw3hFIVxwmonleuBjp4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB6892.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:42c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 04:25:02 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 04:25:02 +0000
From: Koichiro Den <den@valinux.co.jp>
To: ntb@lists.linux.dev
Cc: jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	Frank.Li@nxp.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] NTB: ntb_transport: Use seq_file for QP stats debugfs
Date: Wed,  7 Jan 2026 13:24:58 +0900
Message-ID: <20260107042458.1987818-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260107042458.1987818-1-den@valinux.co.jp>
References: <20260107042458.1987818-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0114.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::12) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB6892:EE_
X-MS-Office365-Filtering-Correlation-Id: e08525b9-cccc-4054-12b3-08de4da4ba43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gA2c1F8HJiSyX/HDQbm3FNXeidGYkgbDInDFCd+iihqIQgOvfoMe2Jzc5Kki?=
 =?us-ascii?Q?Nj6YlsYOaMi1tZMM6XUcWs0OA66keF9PvMJaZfByVdz4kcU3zOqY7ntGwv5e?=
 =?us-ascii?Q?wYslz0NSx//g8RNQASv3jRZaCGD20auKLF125fYJiSSIy7Uu5nm6BvIADtOB?=
 =?us-ascii?Q?qZ+bU5Z9Px/6aFyQfAWTA3A4kHwUx5o0s7fcUAS+1vrS6xpBiqZ8jYROVfaW?=
 =?us-ascii?Q?QiuGt5OAUHyM9osltCHZgBnP0z/ghnRK91B7wlo6ryr56fJv9btaxXc2gWRf?=
 =?us-ascii?Q?RBksUaW054lxo1ATW54B1GeuVzmJI7ER75b2D0R7hwJ6YtE2xKJUP0aXcgC5?=
 =?us-ascii?Q?nOZ8vfHymRFFwfb4ZD/sJso0q2gFy6+ZPFBS/YnNA+TfhworGFQqwZRm+b1V?=
 =?us-ascii?Q?504Te1jQk64gKexXCqHJ3U8AE/6BH8/b6BdI9pTOv2WTQyNMzSYrGM2rgPRF?=
 =?us-ascii?Q?OdADyOyKJUcKYqWoFVjK9VAAD6J/hiug8wmNQMHP19SrSaolFLmv++9+lTeV?=
 =?us-ascii?Q?Kkk5maPidRQAGMGJHGs1OyUb2NHgHtwy//zOpArTg0W0Wg3TIOQzkpwwhdau?=
 =?us-ascii?Q?j6uWrDK83ly0XdImnkFRYHz06UN6TG6+v7LGUd1N2JP73OLO4znUqvK6WA1l?=
 =?us-ascii?Q?0zRwYeV90uU140hOOvFeowxUw2bJ7R2SViKEeCOZ+/VBe1Lh8IYBxEhgLwAQ?=
 =?us-ascii?Q?Rg35l1YE9UV2LzC05l8kk06b7WGeXjcmKjUm/fFTWfkfhrjoFz9qlr4sqXLp?=
 =?us-ascii?Q?LfgL/Jr4JkA+zoluyEEtB86DW8h8eC/WDCv0qIyxkWqfRMQN4/HeEtokLsaH?=
 =?us-ascii?Q?6DXg8UUWirlot837fvEfkOrArcaUR1szAC2xZhSU955c8b0oi4rtNTRLysTp?=
 =?us-ascii?Q?ytr31p1oBlslYM4jXHuU5COHX+G3WOkNdEQURK5b05gtk/nZTyV4x8oOywxD?=
 =?us-ascii?Q?iTPtUTLap30Bk6p9a6Ii4Dq5O6sDyagpUMy4tI2CTe8z5gNxUV5LCU2ecy+X?=
 =?us-ascii?Q?uR6AKm7WoyUzCcBivZauuZozs5tp3hTndtbJcYzAhkVrtl0Mij4+rd/i2ADA?=
 =?us-ascii?Q?jJuZcDC1g/8XZCQWVQGvfO7rJBKYPmpeW0ixNKVmkBd6TW7O2zGRDIq4D26k?=
 =?us-ascii?Q?DlPl0HMOT032YBZ7E3c250s6IMQmjqIoqc9FRtbp5FySRbvPsqwbdwfA5QKC?=
 =?us-ascii?Q?tyMGj4kyJh2RkDcplH9Hzi/oTHRiyBbjhGQZnthMLzBBvc8tI2h+AjGRIRSW?=
 =?us-ascii?Q?MxQlL7xKDTEgJ3sMvDAnGTNHa4G2RFUI0f2reB0w4WdeQsvnyBnESFiBxaPn?=
 =?us-ascii?Q?NW7pqJHHdMdGH/TLvgIrUYXXOpCyE6BnxfEfZuWepuOyuW5ySaISp8V9q1yl?=
 =?us-ascii?Q?TDIkvWGKkwAzwps4Yq5/+icwcSgXe8vO4N1fwCBgHesoxfMUB/D+IY3+6Wsc?=
 =?us-ascii?Q?2J8/0fxj8wDOqe9EvgruuAHrV+IwwXgk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?exaIcR3OIn/GoNieQsaAbLCIDF+HzO6WJgEznxhLj7C5ijx14riLy1EEFmet?=
 =?us-ascii?Q?ShKVGgKnfKW2dPo4kqOPscGwf84lVjWDB2sg5yd1FacvpOhPVTFvA4B6kAIW?=
 =?us-ascii?Q?OuP9ZJzFT6b49K6YyElAazkF3YCgsyp3tOo7sKzldcXQ4SvF2LxeKhKPZS/5?=
 =?us-ascii?Q?aXedu0EukNs14rMofGzbDDLMHudQpAqQ8YmhpBl+2Vo7jn4yj3atW6ZLNzYQ?=
 =?us-ascii?Q?4FyKLWLe9hf9QgA3Tixuo44usn2LqJUaZuI48lYjlRVz68ocq9S6BnGuc2Aj?=
 =?us-ascii?Q?V2Y+S/X8W8b8XGokqck4+y150LCMuX1U6g7rm4A2Vp9/wAGbraazzEr4i0BW?=
 =?us-ascii?Q?PUQDiy6B/YvCHia4LMe2mcpQ2ZpZQSSoNt1CcA6Q4HJMNyguwNa9gFIqZiA3?=
 =?us-ascii?Q?DELvy6hnOQOm4isMtsesREVQOlGfO+E8t+Cm2tW4gqxJBX4dxgUV0O2MKZLG?=
 =?us-ascii?Q?XsxBnf32iEfo3ue3NfVQ/od0sJiMMst2m2oArDkPsszqojh8DMX9upiKfXXT?=
 =?us-ascii?Q?se7l44PF5eFdXZRoH1ARDJJQQMy9/sCMFAP2fw2M52irYL4UOQ6QzHoFdgyc?=
 =?us-ascii?Q?L+ZL+6mGkRl4epWdtQhGqrj3PBONWn79PjK8UCb8Ij2oqWPsFOubu6b82k1X?=
 =?us-ascii?Q?xVeeenX+Br6AL0HEZYVnMVsCekjijypUxF2+g5U7LH+NFj+jYsHq6jgnfSKt?=
 =?us-ascii?Q?c13kTn+zMaQB3TeYKjOcySWUMF0TWmvX3OW2DFBvvQgnyKF+UiffWgHb4K8y?=
 =?us-ascii?Q?LbwA0r3uoqZRuIrNcHWD9ya1cXwEjcnR6Nys/mUjJLXqYDo1Gjl99AJQ1GvR?=
 =?us-ascii?Q?Dnh/BqpEHNPMSAYIuj2ysQ6TpUSJ/jYz79zb1ds0dRFQBKDAkOEFpDLw7N3A?=
 =?us-ascii?Q?3j4zwOZdAqtA4zL0W0f0xUdMaOQx+mIGwrjstiY9iJT4C7Y2J6fDC/oFJZ7g?=
 =?us-ascii?Q?YXWPH5PbOHE6c3eAEzE7uhXKDfn54/VsSGlZkk8d0E/cFTu1x1nH1qu9YL7P?=
 =?us-ascii?Q?Gn0Qh7gczEJb5Kd/mGVdmav3lPFYZJxLS9YwzSGaodvEwx9nbSX2krHlMVU/?=
 =?us-ascii?Q?uEyICV9X4cbZRwgt9txJPS06FKBH37G3lubtJCXFQ1osoSZZImd9jDBpz0tP?=
 =?us-ascii?Q?tU29Ujxz5k3dwY2mwh40l4eGU8xAGgDfexi8DS5UbDrW42t+mWISSvMIU/rY?=
 =?us-ascii?Q?OXE+k7M6R5uWHA3cqqKbHXPgVDQ7cqX2yKmTnw6znB00O1YrFLVx4TcMcc3b?=
 =?us-ascii?Q?fkROkW095dO0/VKx2JT3JmqsIGU+FPAENzRBiyxl6/nv9izMatDdk02/0P5x?=
 =?us-ascii?Q?9J9WSH+bWPLPoTVsPkniqhy2dqBhnXGlFu5XwkvsSg6AQaqMybLt84FYBXqb?=
 =?us-ascii?Q?5hqmV8fBkQqlodUiIk7QLWOcRsIpQ/+42am+ya3prECL3o5R3nNbtxlnqDrL?=
 =?us-ascii?Q?1twEjuYty02Ma/e+jpqbuOZEEkk36cN9Z/2G+6fpRJtngq5CHy1CK12Ls8wc?=
 =?us-ascii?Q?ikwd3WjojUswPaohkxuUEfuW9BOjHWeYH0tSlpJz1fl7VjB6ux/ydTOBxomQ?=
 =?us-ascii?Q?r6iLylxaildPqi3B0H16R5fpCFPUvk9R8BOz28yhUTx8zgmupRNzlpcZois6?=
 =?us-ascii?Q?g8WL3cVDfE6pqwF8vUCoVsG1l3OEUMfxMU+3ur4KUJ/yHZY5AOYCbCzDQQU1?=
 =?us-ascii?Q?OCyTKIzT8M/Fnpeas6kS9DtqggKyb9Bsgr8jBwop+rKAjeLAqVNa/TmGRhEr?=
 =?us-ascii?Q?GHCsz/kTgwGQ+JSkDz/IHrj+IIKG5wehNKBYH5WQP+5VurQQOqm0?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: e08525b9-cccc-4054-12b3-08de4da4ba43
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 04:25:02.8655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v6VRyM+Cv/g/50EzlsTDqdC7GoF0ZSg2MZTuGHtLmGXenxVzIsR/r+j2yYLUNgEz6Br79WWJxELkoV+kMOxa1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB6892

The ./qp*/stats debugfs file for each NTB transport QP is currently
implemented with a hand-crafted kmalloc() buffer and a series of
scnprintf() calls. This is a pre-seq_file style pattern and makes future
extensions easy to truncate.

Convert the stats file to use the seq_file helpers via
DEFINE_SHOW_ATTRIBUTE(), which simplifies the code and lets the seq_file
core handle buffering and partial reads.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/ntb_transport.c | 132 +++++++++++-------------------------
 1 file changed, 39 insertions(+), 93 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 857c845bfbe8..d5a544bf8fd6 100644
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
@@ -1244,7 +1190,7 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
 
 		qp->debugfs_stats = debugfs_create_file("stats", S_IRUSR,
 							qp->debugfs_dir, qp,
-							&ntb_qp_debugfs_stats);
+							&ntb_qp_debugfs_stats_fops);
 	} else {
 		qp->debugfs_dir = NULL;
 		qp->debugfs_stats = NULL;
-- 
2.51.0

