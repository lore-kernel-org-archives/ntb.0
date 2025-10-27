Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011017.outbound.protection.outlook.com [40.107.74.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB941BC4E
	for <ntb@lists.linux.dev>; Mon, 27 Oct 2025 00:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761525823; cv=fail; b=Ysp4PF5i4JvXLri4OB6JEgYSz3lx7C8q91AwMl0AHmhEtMNB4TaTJ8AKf6pYs9zQjY9zEUX7kh1XVFSLENH9diHF8iogNZTWERy0sWY/kRngeenja7Vpr+sjgHC2Bjdifyt+91f8NND4hCvNuo5WHme2a5144RvLPVo9bh+d4uI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761525823; c=relaxed/simple;
	bh=f1DcVD4FVGgEc67x2e7AiFEuJMuqJQAwHbMFLxCKrls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JRk5DE9mHE3pJlqfbyDPW9Izn3AdWma8EGoPoa2+ovWwl25uOvOfSbqwORi1lqWQQssLCXHYxcGtqv83QFj5hL4GEoWFLOSkKJ21ZiFVxAvlisEDX2EVBzkkgtrUR4nw90fPWuou/moHE02ha5EN3Sy9ng8b53dI03gJSuwJMv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=C/sDx4Vv; arc=fail smtp.client-ip=40.107.74.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="C/sDx4Vv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EHfq7iAWV+PrdoGNuaJKOSI9lAl4z57NbEgCGE5IrnIMOQxlbW5GmX51iypYSfXRlBw1bKMGl2+mePm19G0ef4v8tBm5TTScsM4yFdOGVwAOh1bTWRz8npYpjz83jfBy5lzfG4r1174Fmg6Wlg1l/r1VXP9MtIUXwWfRkaS4a/KnYYy5AJjLRsOh7FnGuJtMZUtYN1KTyLGsutEMKEBq79f4ATVaLoMa//rGv/17saYeOkomiZBSVCK1wc/8wC+gsSCY95dLtdUbdU5sOnw5IHCcqMeiMglVlKG8F81ZCGZsRzY3p5VCjnlwEpeUbg7oAkJiI7F70+JGbQJ+uFQXZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bqmBZ0b0KEzsxlw7JhqwVDPbN773yjB0HnGZDg42r54=;
 b=IzLmZy9YttAyB/Hi8pt+tJrGPkWLQO9oiBpGFsX26JienIC6RQ2Od05wr8ceTULFd6z5Fn2MZr5BCM06V/NBdsLr+AlmW9zaNuFF3jbIbKCtMkE/gi00yXjFsKavX6hjoHg/hhkqGvrR10XuZZWYaAYx4iAwW3OnfUMSzzGG0LlKEzJ0aWdEGj86fvg3yaX8QAf74MxLgfncB9n1yyydGQCC3iTKuIVhDH5/j4IpoqlSj7WQ5s4z1oZzA+EwctJ3A2EotdZm/0A40hlEg5+sqGSJekKtMukoUSsMTl5+3dhzYcFXFdoUPJrWrRmxVXPat5umGvwtfYxF+N/4upietg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bqmBZ0b0KEzsxlw7JhqwVDPbN773yjB0HnGZDg42r54=;
 b=C/sDx4Vv3ks+DB+j9zWU+ychFrfGwGOgCvUrP3+kMgXVFe1NcSny0TUiEsN4ltKYBCKUsH1wiLGgVhDxzJqDsCE8xHN2ha9TSWsDl+Oc/zvYu96aE9Y5YDizCvsLAd0EHihMz8AmR5+BpASUnRkOoYRLNgJLgGTL80lpKrSTfEI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:10d::7)
 by TYCP286MB1588.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:185::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.17; Mon, 27 Oct
 2025 00:43:37 +0000
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a]) by OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a%5]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 00:43:37 +0000
From: Koichiro Den <den@valinux.co.jp>
To: ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com
Subject: [PATCH 1/4] NTB: ntb_transport: Handle remapped contiguous region in vmalloc space
Date: Mon, 27 Oct 2025 09:43:28 +0900
Message-ID: <20251027004331.562345-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251027004331.562345-1-den@valinux.co.jp>
References: <20251027004331.562345-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0026.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2b1::6) To OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:10d::7)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB0979:EE_|TYCP286MB1588:EE_
X-MS-Office365-Filtering-Correlation-Id: e130982f-e37f-47f2-a7ca-08de14f1dd75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BrbwlFtQzYLeFXln96xLRsOMDxpu8yRhOG5JBNydJnLcaXWl1w+RzT4jwwcm?=
 =?us-ascii?Q?GMX1GBNxYb0xTDImBocQ25ru/uk5QYvtsWtnOIg8bTXhZy/n4hsKlKcRh+FW?=
 =?us-ascii?Q?7idI/unMqkOZM8Ys3yyrp2Aa6sqHGX3XUThp7QISqKKk/ZCcfs4rJLt33EiF?=
 =?us-ascii?Q?9OcK/PuF52EkcY3vnHZKitt9bx600CXkjodfZnlyJ4S22g4KiPVwuoR5b7d7?=
 =?us-ascii?Q?e/m/IlS1nVzzEz6hzcEd4L1jfr63VyD5+ca8suzXodDVwdghMSJzHNsjfOZx?=
 =?us-ascii?Q?dJz/2+1OPXX7TW0zfhOTABU3iQcGiL3va6gf0hI/Dlu8R3K+VGMRGWhFzZXj?=
 =?us-ascii?Q?B8WhhH8zdjq/ZwEH5cDpLXz/urtIk93xOaF41jgFKywr6VL6xcbwrD04TGNz?=
 =?us-ascii?Q?/diLSe+Co9n1lQuseAPEZBbUPM+ZmhkV1e0xZ5U7vzKwnRWwv9NIvwslYW1K?=
 =?us-ascii?Q?xq7ICqxq7djLl4AzxoNb/dBEY33xOEOlirYDNIX9UuiFIvyGWoRo/WwWu8IC?=
 =?us-ascii?Q?NhBGPopZ0pL+VQPAYK+ExhI+D8pZVgY5hfdWQoAEjwAS8q1NVHhqZd8cImmf?=
 =?us-ascii?Q?KLcr6SQWJ12cjDl898pXrX5FDVQAXeBGy67vWrkhdKnmOvR+FvSJO+QpVQ5c?=
 =?us-ascii?Q?cHw8REZ4TUs1R4y6Ho/IJ1xciOqtc6UuOb9eeKQptMSdw8OAApNQAusMbWzA?=
 =?us-ascii?Q?QmtnP7fCgzsW/KfSTpL2kf28OY0BVJie2tq0hann9+B2x6zPqZF6AJpcOqYm?=
 =?us-ascii?Q?a1f1GEXEmzz9qLadHZdQbUjLZxUdupOW4OCZ7gqG10QT7Tg+DHEwQpqdhKWC?=
 =?us-ascii?Q?8yYYE8+0KLsPhRsPtjG+AmtxQvbKf0EErbssKEwVR3aLAqDgPoa0/OrfYj/p?=
 =?us-ascii?Q?XVmKYSP8E0LmnSU828Dd+Y5inHGniV0UN0MIN2StqhpKXdN6VV3D6UhA0PdN?=
 =?us-ascii?Q?RAZoEbZ9xaXzTpQi2EicMiqXDoO2gfPhJQNkVRHLgmBiwvV827bdbscij6+w?=
 =?us-ascii?Q?8TP2NG23aQxRi62mpa4BKSLOt5RBQ139iVcoQAM1L6Wql2d0mDyCI+BrRGHe?=
 =?us-ascii?Q?KAN0g/k67nowRCRwkpgDeuQEtBXQc4k82NRgLWWYg6VJINHyFvm/P/3A41Jc?=
 =?us-ascii?Q?e3nQtS2/24bQjDYT7IPFo9qc71TlljeNrXmAQ63KMGqpdY9OSQqbTgqt8n92?=
 =?us-ascii?Q?ew4tR4hd1KezRza0i74tFQsZM6OmgivxryqkIglcSQFAjrenq8515PcXj3+Y?=
 =?us-ascii?Q?DIA3YgCy07leMXwA+uN6xrfDvI5aLa88n/6gRgHmWU+Slpcr169+YTYHarfl?=
 =?us-ascii?Q?xlthVIiQDI/8NvvmMi+v8fFtJiMjlz5obcUDpefZ+BkoioiNHqsBnXN5MLLu?=
 =?us-ascii?Q?Vk+/+d59Y22iZPAW3Zy17a9PHpMC5keq+1v9+Wc3ZPKUrcfOifMsimy4mBZF?=
 =?us-ascii?Q?jFkuvjz3NDy9wmPZALHpC3eJJcJp3fqK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p6wcjgpbm+lgfR13hFJsKGpQpOyBspMpn8RAt0olwDVc8B+4mXbsLz+kghqq?=
 =?us-ascii?Q?8oWjnqBT6bUPNiBz4Wdh9tIw/oM6HINBqwijQ4Jfc032RjN7xdlZPeyrddX/?=
 =?us-ascii?Q?HutIX0vMc14qYkwPT5ZaorFytsQr3ko3hWRa5LytjVhA6EoWFoP+xeTHjOXW?=
 =?us-ascii?Q?8rgQdXguIAwzv1/pwz328vhDzo3TpAaT4pFGRyV3M7prA4c4rymSHAOPJ/Hx?=
 =?us-ascii?Q?nAA7nVdq1hTXeJRyagvAhCWONMSSJUyq47AnPuRo9hcuaemXj7ek3N+cfYkI?=
 =?us-ascii?Q?M3DHtghaiEg1L7vuq6i3NVrNOTQYLdQ8nnADetTmPkk+GDrE5lIen26OtQl2?=
 =?us-ascii?Q?eC5tN3TE9aLpUmIyS4Bpy3+Xfg5tS1FCOQYuURzn1l8ZRNcP4hqfjj3lIM8u?=
 =?us-ascii?Q?5DahL53WIOqw5m7rQlrWg+hAcXinXiE+YChpW20Ycm1P7J+V8q/aoVL4S8a4?=
 =?us-ascii?Q?/3G9qkEt3Qv77Ri+sDkamLAX0FHDh/ezFVedJU1tBzeEAQqRqUiUCOv9EFzs?=
 =?us-ascii?Q?73rEUzlrNfJSAt7YapJAmYAXEY4uu2F2CuKkjMdQalBcrG38fxlOCvO3pYVi?=
 =?us-ascii?Q?Pi0zMzGyITDazAS1xquDIsHK19BzSVCo46dHV28lf3YkGo9RW9hC2BAfc241?=
 =?us-ascii?Q?Lvw9cyy+sWsYOYm7eH++JCk58kMMipU3NgQLNobKvz/IIwA1Ga9k9vjOmKtj?=
 =?us-ascii?Q?LOGQ3fNNvRB7vD1wLvUiTrwiQxT50lqoTvarH6/zynOlL9MboT1HYzZjipUL?=
 =?us-ascii?Q?tpt5+SprEwzJx1C0HxIQuBBs9lJwZozGBBA+wuzGW+2R3tPsIH9aMpe7FAe3?=
 =?us-ascii?Q?Vr/WKSn1izh14wBDWt1DpKcfbC61+nJQaYHlYA5/90DoCgkiiB/hbVe2zIPu?=
 =?us-ascii?Q?uYFOwoqPbyMX6mIKtz31m7u0RnWy171knk3nZ6TP4XbdA/NqeBOK8TDfIZu3?=
 =?us-ascii?Q?tyBPwuVozZpb3AepNY0TLWb/Yn8Q7SKkg9h2A8ZkJocFoHy/oVn6oIoN5LKP?=
 =?us-ascii?Q?72OeZ5zdD+rkm6HJiDJPkNtCjtYlUhNAoV1JgiwNwfURx0MBAkbn7KLV8q3s?=
 =?us-ascii?Q?gc0oP54+XZVakVNcXaQoFB9giw5u0nlIZe9Nz6wkhGfUaQ3FfyHOHdjAirJI?=
 =?us-ascii?Q?s4kp4awW0Yu3RWTuycBE+EDRIV10Ou5hR7o0e4AXm3VKGRiAAUquBOIhdxQQ?=
 =?us-ascii?Q?7ujdxtU0liPvEt1mwOD3uky6Ue5tTGIS3inWbrQ4HRzhppMBoq1g0Tjs9Q7W?=
 =?us-ascii?Q?iipbc86zgZfZ+JSD8lA36/HAhv9HLE+1Sr3MX8X2Uafym6aGStw9WrylUXvn?=
 =?us-ascii?Q?DVzL3XOwMrzscLrp7UjbVvVoz4FFp+yFUQHBDz5Ps/lphzx7L5UrgEf3RN4h?=
 =?us-ascii?Q?o6QKD6cXZYiKjJtJ4IGGVg7l3g5TlnuM+UlVx8u/Nj6ko3gKxHsfSehso3qk?=
 =?us-ascii?Q?1vb7R+//YDxk3guu1E4zfuSBEcOJgXniwGJAUM85OJm2T+vk8260aVgryQ8A?=
 =?us-ascii?Q?S+4u0Ax5GEUowjREgSrO8HLlVTKmq6UG01dRnXRQyleqnjx2CR03nhYunjAC?=
 =?us-ascii?Q?yQ8Gx/lDAF7njOAvHSqocdgdC/KGhk9R/JUNJRl0BDQz4uhPSMaQ7xHxmpc/?=
 =?us-ascii?Q?6U/gsaYuSOBS1R1pGsugSMk=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: e130982f-e37f-47f2-a7ca-08de14f1dd75
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 00:43:37.3377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EV9K8K7sXYitaHMjdlo1gumm/A+c72jXBknfp+1x5SpzG/7y/dikhNPa5qdpi0jeU6TmpUSW+HeE07AKoA3Bkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB1588

The RX buffer virtual address may reside in vmalloc space depending on
the allocation path, where virt_to_page() is invalid.

Use a helper that chooses vmalloc_to_page() or virt_to_page() as
appropriate. This is safe since the buffer is guaranteed to be
physically contiguous.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/ntb_transport.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index eb875e3db2e3..b9f9d2e0feb3 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -1546,6 +1546,11 @@ static void ntb_memcpy_rx(struct ntb_queue_entry *entry, void *offset)
 	ntb_rx_copy_callback(entry, NULL);
 }
 
+static inline struct page *ntb_vaddr_to_page(const void *addr)
+{
+	return is_vmalloc_addr(addr) ? vmalloc_to_page(addr) : virt_to_page(addr);
+}
+
 static int ntb_async_rx_submit(struct ntb_queue_entry *entry, void *offset)
 {
 	struct dma_async_tx_descriptor *txd;
@@ -1570,7 +1575,7 @@ static int ntb_async_rx_submit(struct ntb_queue_entry *entry, void *offset)
 		goto err;
 
 	unmap->len = len;
-	unmap->addr[0] = dma_map_page(device->dev, virt_to_page(offset),
+	unmap->addr[0] = dma_map_page(device->dev, ntb_vaddr_to_page(offset),
 				      pay_off, len, DMA_TO_DEVICE);
 	if (dma_mapping_error(device->dev, unmap->addr[0]))
 		goto err_get_unmap;
-- 
2.48.1

