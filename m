Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794299119;
	b=IK9LVAzfnXwIS5dcXndUlt4lVH/vYcn8ZQ2CBTQwqUU30o9BESCFrDBRz5cFprbRsylt
	 UHOuUg+IojGiffxT5/pq5TAoUUhXLK3vctbU939XOShJNjB5bbSfeua9s1kLnpnmJVdDi
	 jTku//DbfA0XV2cpV+MHgO0hf4ZrGzKg5+hUZfBLHGsiS1KYQwONdnTe8vCfYkWoyKycz
	 +U/8bGFHtbdzKicUeBG5odTKvN/4TGV5ox8XSCwM7J3FS5My5xbdIx5zdm+rBJcxzaK7p
	 n8L13sF8szU7RCMf/grFO/xC6oz49ftFD4JMD0FAVVhW3LYBgF+3sAqOXCD4UE8ccwg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794299119;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=0JxnXxsdDOCQ5X7fsTDL9blOkSm7vm7HriFQkF0JTNE=;
	b=3F+5T/Vk3P4p2K7QUnjQfs7Dz+rPufUVa6OcKl4gw0dzluSN5Yj9Uy/JR8ZHiw/1awOY
	 EUkkDCfziEKCcbKLMnDChYnn9mClI5YSLj7IUFHpl+5GWKhJbTY7B38+YwY4IT4YD2gB9
	 wJvnwZmlSGfY+87IKTpJgs3ZJFa/MJDdgXlXCAwHkSGvIHkshc50AhKuUcxgUkSLWrZR6
	 zI0o23GVlUWvWbmFWSwrfaHKCqcb3I0+8yTNjGNJY/rfbe6I0YBHEaRqvwNH/B5ey0aY1
	 W1q72XXH/Smvsv9PN07BChHLEtTKsX4qWrnaDEI9wOkrtaeDNWpTtV2hIxoys1imQKw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=QRAvYqwc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.77
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021077.outbound.protection.outlook.com [52.101.125.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286BC606A332
	for <ntb@lists.linux.dev>; Tue, 10 Nov 2026 08:25:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 286BC606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=QRAvYqwc
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UAdnlILCMMWtQDhmoBblifQgr0Iavhh15c1WId13HlXxJTVTx6xWNO5RpJ/cKxuo8YB9Yt3Bp1mkryNM8EZeJUy3oW6iZ7FDnZrdETZMVKWzHw5ZqnKoCP1/RGjgsjIFO7uYx4zgygjVnbqTv7oB09t3fpNgGh4ST9UNo8IxANAgoVIwr/iqJxRGkf9JzgiSnJlzJGh9U3OGn2M/EaXfMOTMfLDpMvsW38VguW+zYx9XkmgPN24zZZJCdUr6S9l6hV4h76jXez1wWuT6245Yq/r2N8KzZQRZJg5xMi7u/I4Hsh+YS+Qbt1VLLvY5ts40hJAHEncaoHnRBumpNpEmbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0JxnXxsdDOCQ5X7fsTDL9blOkSm7vm7HriFQkF0JTNE=;
 b=iZvinIvSJbg1eORc5Cn6d4kzzxvMC4auZkS8ZXPmtQm0PT/8nzLELm3gKa83uP/3u2rwst/BVrvp0RkU5KdhD6q6TYSVvuiF4sM/vOiYGBI2VBiaY8cSV7Ozenb+H+NEKgAPlT5LR8lr7g6OCGpOd1/FwAjE6qQ1R6pIETpaMfeKE4/owwwYFhhJhKlvgUwd+CxIpGlCs9aYv1v3nZVLbj9yVY4cr96uByUiwwG5znzsFOw09dTprl4pr4wj4aIznpZGESy3HqjISI1rTlkbUifrcedQdBk0r9lcSUX9SWo+ZVvACoNKbjizey5H/2S3IYcjRWYNnW23Vu2HNv3Lqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0JxnXxsdDOCQ5X7fsTDL9blOkSm7vm7HriFQkF0JTNE=;
 b=QRAvYqwc/8q3wnf3SinsXzqlM4hfCW52J6E1SP1sbxALHXt/Dm3ECEC39edgy2pLUIae66Dcp9wtv9RVUJx6duKtPTQgMkm2Y9iOijB8PRdkvHsHWQgUP2hTbqo1Eh251fumDZEtlMoiVcXUvF5+BHWPp31bw0AxYbsDmTFawiM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TY7P286MB375520.JPNP286.PROD.OUTLOOK.COM (2603:1096:403:402::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 08:25:15 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 08:25:15 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: [PATCH v9 10/10] NTB: ntb_hw_epf: Support DMA and MW sharing a BAR
Date: Tue, 10 Nov 2026 17:24:59 +0900
Message-ID: <20261110082459.1798763-11-den@valinux.co.jp>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261110082459.1798763-1-den@valinux.co.jp>
References: <20261110082459.1798763-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0048.jpnprd01.prod.outlook.com
 (2603:1096:405:372::13) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Post: <mailto:ntb@lists.linux.dev>
List-Help: <mailto:ntb+help@lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
List-Owner: <mailto:ntb+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TY7P286MB375520:EE_
X-MS-Office365-Filtering-Correlation-Id: bf984ac2-6c75-4a8a-8fba-08df3f042565
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|23010399003|376014|366016|1800799024|56012099006|261021123027099003|261021121427099003|261026140227099003|261009223027099003|261028144727099003|261026121527099003|261022105027099003|261102123227099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	nQbFOSzbmjSOP7fnY5NcJ9ilA1gz2IMV2MesJKLsuxfzgABBqva/6RCXHu85iFapvW4Ci43cE4VkEb00xim4Q+Y2otiXM0oXLDOIeb/RaH7AUUbD9CtWd3Mkw6z2QfjIxmg9cI5afw3Ic3GErlVKloGUunKNHiygGfA5/dVWIh0bXJqhOg2E6NAjSFquFXObLfTGF66ilqNheFycvI9RF+E47IzfeC9uR/SU6p4IP4F+y/XnpN5uhZhnP69d0Zxppb1N2Y8So25j+LfAk2NduHCyE0p2d6dsQ5X1GN34IkqKCTj9CH2Ws6ja0Neab/GAHGdmAtRuPXIqZY1dmdljOq0T46nToK6CjIesz7L0PlM+UCN0/9iPZ/m2FfPsH/QXDdyy+UefhfcqSEfDFvTc0odJj5LaxbNrbL9nHWgYaZdY7uBkl7vujQP5oCfnXyEYIQrlRjT5Z6/LKFRpR5hAdKKnOnr9G6HuKBiOo9MMwe0KTxD64Tk4cR6hSIaEnRAgJNQER0fLvvy109/jleze53lcXhLt9kCuCufqzL5nA13qZgjT0BLC35mW60u7/D5DhrL8GEuaW2LiLDdoLj4MrzWq5962S7mQVpSu1VEhWiJif8Iczctzg6g2VS/ramwdKtN4buZouot8PZrWILZslazyZPMKUjEp5Wa2GQtyl34=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(23010399003)(376014)(366016)(1800799024)(56012099006)(261021123027099003)(261021121427099003)(261026140227099003)(261009223027099003)(261028144727099003)(261026121527099003)(261022105027099003)(261102123227099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ij48duPQ1/3KCUS71wHCf8KHruHGQSifErdzX+GCpMAs4rHyaKsmOCeT9bq1?=
 =?us-ascii?Q?RBLZKO9WeWZE6bDm4XRnvAKrjZXUvEo/0GDgCQFEKW/tiUEJhhmgHFiJSvzG?=
 =?us-ascii?Q?5medlbDyU4c5PvjHvf6lPIRv7EQtEljdWJzRyynqeE2HLfcndjHpBEoKPj1D?=
 =?us-ascii?Q?ZDeMcxIa8xPwnbadDBASILeHYR9ZXOnqnD1qMXyUVDc8X1P3FGB8WJoCZ7NF?=
 =?us-ascii?Q?Sp749Y+U2TRrjBr7/Fpayblbdv5Fs3q4NbB836bi+2qw+6eykxohsrL4dKTN?=
 =?us-ascii?Q?hDH30P/cYYAdFBltAD9kGpD6YXBD83K7tIP0KxsWt92LrevWxPH8uWshHHWJ?=
 =?us-ascii?Q?AyP68x2vBN5Kfc2BA3QU8uPb2aVIfyzktMTpYZhg9MW0BKZYtsLXWe3TQiw3?=
 =?us-ascii?Q?FvznGzqsJrMy+HPR5G+pY8mgr95w9HV2P0GskHKONyHTEaE2uv4WnGkqjMiL?=
 =?us-ascii?Q?HKYME02c9W+XejsNBOGsYdAsl4oixo8NLppZgE0huG+6PKr3jC3ZhGWpLatE?=
 =?us-ascii?Q?Qojlm1dy/GAHwkKpdFqSNlxzJF+bj7ixW5Bj/EM6b8kN5MzQvhhmjkT+XZIa?=
 =?us-ascii?Q?hMnSqgq80F1wuY/3tNWDSBUX3Ju46MjXvzyWyH0cXA75LsXKHl5q/T+KQlcv?=
 =?us-ascii?Q?8ba4/Jd4iGc6Dxzi8LX844S0r3sI+2kK68xh1625npRW8ey00hKL/x2mnE50?=
 =?us-ascii?Q?2Jv+uZNPrlMX5S3ctelBXSxWuDW/3ntCh2w6f4smgGAai4sp3glnsCVjusVL?=
 =?us-ascii?Q?98ZJsuNF68JWtOf9H1+JfUCC9Q+KLNleQNZxtncstKcPbPCU2UytHOjmivKE?=
 =?us-ascii?Q?OOz6m6bjNS0uR8Trr2wrbYnr+8DSODuLI1I99xMQJUt6cii2f75QcOqxO97o?=
 =?us-ascii?Q?zID+XYegbxs9pwzFlqvfHzyMhyDII59WSxBtOQLUr7rnYtOw0ePka/uxlWDj?=
 =?us-ascii?Q?FPvQWWuorUwMYtH/xqY15wKV+JrHIA493MV2YzMwTEFj/cuHpY1XOh9Il18N?=
 =?us-ascii?Q?3vaJjMZBJLR+7hfTMIbRTDUfPUl5zMlvuw9K8O4UPkKfNBtH99ne8B7mcurs?=
 =?us-ascii?Q?58ei44HUAqZt6lyOJz19+6/ynzkQA5Bsp3mH9gSzhZbRe0utV1/2vEDAju75?=
 =?us-ascii?Q?QWc8y0kfEp+wumE9U0/5zVmYfHrCvEIRSeP/Q7Fla0RPNPNIqz6O+7fP+OEn?=
 =?us-ascii?Q?TSqlZArBEyTKnsGp9uGB8MBBRRDn89CkpwhGEuHAWVCJjJgY49lXN+jJpIOZ?=
 =?us-ascii?Q?X7v9yhvbefo4jmD64p2Y5YcGxuiOLOdmGWQG3aYxcLJt4yaIUlIjVDR9C2fO?=
 =?us-ascii?Q?kEWJ52EqJgj+AcZ+wD5UmwFujW9HyFO9ZjwYlBfZMQWNyKL2Y3U4p8MYcM6l?=
 =?us-ascii?Q?1c/6WVfoC0bBaUdsvFvpI7rIYnOiLZdyJlfSTWS+v2XQxPNTp+fdLpR6A6UQ?=
 =?us-ascii?Q?vkkCXjkFrnxET0oGkWCi0GvBUAoIJBFoVC6nc78FjrP/kX5ketgsJJL6q6xX?=
 =?us-ascii?Q?Kld+nEpSq1sKQa43irsU/D8VPVvufdIEkzYVsJrSYT21rWQfKVKifOBnhVZ4?=
 =?us-ascii?Q?Z5/gCYB3QMFgrgc/VTmMd+LO3XUaoXTWGmuG2KZBVI6MJsQGXJfDxj3and6B?=
 =?us-ascii?Q?zwB9ckkIYqFegQkXGywg4UPMoxXCsjAPpmechZT9ZDkeroCAKnCiBAm8S7BY?=
 =?us-ascii?Q?7hxs5sYvG39iIR+CN56XZWAL8XmOCE3wOzXtY9/bL2JGIMsMq22dJIP2BagV?=
 =?us-ascii?Q?H7fQIIku60sr4lviH3eyMoFplCbhkolxd5kwfDr8jhStOD18sVKG?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: bf984ac2-6c75-4a8a-8fba-08df3f042565
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 08:25:15.0672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ku8Kat1s2VFw6AAC+6fDdobgZqSLxoDF7vXas+rs9tIwN0c2r8ake4QYN4DbgjcbsN3JSP/KujhvtpUD20QwBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB375520

A vNTB endpoint can place DMA resources after an MW in the same BAR.
Limit the MW to the advertised boundary so clients cannot overwrite
those resources.

Advertise this support in LINK_UP, including when DMA is unavailable.
Older endpoints ignore the argument.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v9:
  - No changes.

 drivers/ntb/hw/epf/ntb_hw_epf.c | 46 +++++++++++++++++++++++++++------
 1 file changed, 38 insertions(+), 8 deletions(-)

diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
index e0016128b95c..56185870cba9 100644
--- a/drivers/ntb/hw/epf/ntb_hw_epf.c
+++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
@@ -382,6 +382,23 @@ static int ntb_epf_mw_to_bar(struct ntb_epf_dev *ndev, int idx)
 	return ndev->barno_map[BAR_MW1 + idx];
 }
 
+static resource_size_t ntb_epf_mw_offset(struct ntb_epf_dev *ndev, int idx)
+{
+	return !idx ? readl(ndev->ctrl_reg + NTB_EPF_CTRL(mw1_offset)) : 0;
+}
+
+static resource_size_t ntb_epf_mw_size(struct ntb_epf_dev *ndev, int bar)
+{
+	resource_size_t end;
+
+	end = pci_resource_len(ndev->ntb.pdev, bar);
+	/* The DMA submap offset marks the end of an MW sharing this BAR. */
+	if (ndev->dma.submap.size && ndev->dma.submap.bar == bar)
+		end = min(end, ndev->dma.submap.offset);
+
+	return end;
+}
+
 static int ntb_epf_mw_count(struct ntb_dev *ntb, int pidx)
 {
 	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
@@ -420,7 +437,7 @@ static int ntb_epf_mw_get_align(struct ntb_dev *ntb, int pidx, int idx,
 		*size_align = 1;
 
 	if (size_max)
-		*size_max = pci_resource_len(ndev->ntb.pdev, bar);
+		*size_max = ntb_epf_mw_size(ndev, bar);
 
 	return 0;
 }
@@ -524,7 +541,8 @@ static int ntb_epf_link_enable(struct ntb_dev *ntb,
 	struct device *dev = ndev->dev;
 	int ret;
 
-	ret = ntb_epf_send_command(ndev, EPF_NTB_COMMAND_LINK_UP, 0);
+	ret = ntb_epf_send_command(ndev, EPF_NTB_COMMAND_LINK_UP,
+				   EPF_NTB_LINK_UP_DMA_MW_SUPPORTED);
 	if (ret) {
 		dev_err(dev, "Fail to enable link\n");
 		return ret;
@@ -707,7 +725,7 @@ static int ntb_epf_mw_set_trans(struct ntb_dev *ntb, int pidx, int idx,
 	if (bar < 0)
 		return bar;
 
-	mw_size = pci_resource_len(ntb->pdev, bar);
+	mw_size = ntb_epf_mw_size(ndev, bar);
 
 	if (size > mw_size) {
 		dev_err(dev, "Size:%pa is greater than the MW size %pa\n",
@@ -739,21 +757,20 @@ static int ntb_epf_peer_mw_get_addr(struct ntb_dev *ntb, int idx,
 				    phys_addr_t *base, resource_size_t *size)
 {
 	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
-	u32 offset = 0;
+	resource_size_t offset;
 	int bar;
 
-	if (idx == 0)
-		offset = readl(ndev->ctrl_reg + NTB_EPF_CTRL(mw1_offset));
-
 	bar = ntb_epf_mw_to_bar(ndev, idx);
 	if (bar < 0)
 		return bar;
 
+	offset = ntb_epf_mw_offset(ndev, idx);
+
 	if (base)
 		*base = pci_resource_start(ndev->ntb.pdev, bar) + offset;
 
 	if (size)
-		*size = pci_resource_len(ndev->ntb.pdev, bar) - offset;
+		*size = ntb_epf_mw_size(ndev, bar) - offset;
 
 	return 0;
 }
@@ -851,6 +868,7 @@ static int ntb_epf_init_dev(struct ntb_epf_dev *ndev)
 {
 	struct device *dev = ndev->dev;
 	int ret;
+	int i;
 
 	ndev->mw_count = readl(ndev->ctrl_reg + NTB_EPF_CTRL(num_mws));
 	if (ndev->mw_count > NTB_EPF_MAX_MW_COUNT) {
@@ -862,6 +880,18 @@ static int ntb_epf_init_dev(struct ntb_epf_dev *ndev)
 		dev_err(dev, "Invalid endpoint DMA layout\n");
 		return ret;
 	}
+	if (ndev->dma.submap.size) {
+		for (i = 0; i < ndev->mw_count; i++) {
+			int bar = ntb_epf_mw_to_bar(ndev, i);
+
+			if (bar == ndev->dma.submap.bar &&
+			    ntb_epf_mw_size(ndev, bar) <=
+			    ntb_epf_mw_offset(ndev, i)) {
+				dev_err(dev, "Invalid DMA/MW boundary\n");
+				return -EINVAL;
+			}
+		}
+	}
 
 	/* One Link interrupt and rest doorbell interrupt */
 	ret = ntb_epf_init_isr(ndev, NTB_EPF_MIN_DB_COUNT + 1,
-- 
2.54.0

