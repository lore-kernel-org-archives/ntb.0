Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021129.outbound.protection.outlook.com [40.107.74.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBA01D0DEE
	for <ntb@lists.linux.dev>; Mon,  2 Mar 2026 14:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772462741; cv=fail; b=TZOY0gzAvyYQJ7PfAsUtlVdYamzQwnQ/bqOZyRlhlm/llJOYRP5+jG9/EgMjA2ANqy/dn1MzCJh0A+9d2EgVMBxF1wMpqSuEuJXg5LNI0SAAjwlHyunYDup9WzUaj1+kBQmwh06nBIMBYj0PqPZucM5KrLjx+Au1O1XOG7zfv9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772462741; c=relaxed/simple;
	bh=d4fds1DOD6i6oF3Z0z3Ql/lsHANqYA8p5xzN2+WdF1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dZ467XWEiUz9oHmXa6QZR53GGx0sitsejVi8ag+P2nL4XeCle8V8xajgRygPu39paBhiSwtfaSX6yLNeDnPOrwxy3G8vFXjc5czHVXeSDBGADofjNRGfh/Fl4dSYgACNo5+HfmV4mGrRy/GdiSE6zU5TT5Mo9T+8LVGMv4fcZgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=EpGlINIk; arc=fail smtp.client-ip=40.107.74.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="EpGlINIk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z3HgZVfCL3xt+G4Zk7bnc5e0HQ68NlL4GJjx/3fmvWEVNYTbdgiKCVe+FDz1lJaWjzuFYKva+xZHkkDHhDehU98RhiErglKBPG/E2ft1ZSPQbtgIQ0ALROw99hnUtMRZU7GFAoGka2XnWjWkWnRrbqBFJ02awipjPMvdQGOjhukAckl8++OfSwczrH62k5ysWZKfSQyc0B0fzDmWjDilB7kb2k14pGL5ZMsCxV3ed9Xmdoi6HX6prbjESoxTqOOxyIUiJ++Vo3snQvUVOY+gK+z4+FIwrPXqtp48G/sdMYtv7VA/YfYsmtlovSZ+j1O5VfJcxBgXVk5yYQQxLtjC6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e+hdTwlmwloAQ1J0jhDF0MjbKF3/nLmDBQIL4Ym+q8Q=;
 b=LPz8SKN1OVwZnkQdYE644Wd/mJBCYnwi3RMUQEwx9l2nv7pLBtRA8fLZaCqne5FLuq38VkvrffP4zfaSAziiVKLH+b+9qmoCJ0JmswPe79a35IOi1JxkKSZKFjgAkeldv5LUK8PV3oSe7mV040TJYBCoTp7nDc7lL7r+1/Vl713kUM0FGnpkG61DmglgPNteUDum6mHiuFfYVYJSpQNN6jV9pXdAHqJtszt+HKimAk5INe3Mx6Ipcud12u0J2qfMtu0XO1WJfSZZK+wtz5SEyqzixr92zQMvuy9tPc1xmO0E1emOTgGiFfc4DwvGOhufHsqPdH4qKW6XewvU1zUOcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e+hdTwlmwloAQ1J0jhDF0MjbKF3/nLmDBQIL4Ym+q8Q=;
 b=EpGlINIkcFpxdFHSZQJYbYonT6qiCzFQewaDne3QmIdCZIDcUp6WvHDXGnOCaXHmLtYv+TZ9obDgA+MnNTepyI3T+0sRycugrFTOwGgPbrv9QOS7hET+1umK0odBbwsFWaaPoeIEvvwVuwVVV02YsUlhhQMhi9AnSXHna8vlpDE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB4192.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 14:45:37 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9654.015; Mon, 2 Mar 2026
 14:45:37 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Frank Li <Frank.Li@nxp.com>
Cc: Niklas Cassel <cassel@kernel.org>,
	ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] NTB: ntb_transport: Use ntb_get_dma_dev() for DMA buffers
Date: Mon,  2 Mar 2026 23:45:22 +0900
Message-ID: <20260302144522.750620-3-den@valinux.co.jp>
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
X-MS-Office365-Filtering-Correlation-Id: 54f549ff-9d54-4ebb-1582-08de786a5da1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	sgGwwZ6CG2JJiLGp1Cd3yH5/Ng1q4h3jqd176TzA6RD98J+kYnaJtcdk0EHnV+3gx/46kTPrSgDpSXXo3w78g9v5/vTfBgDe8tBuiYO6viYsHvv/DkzEPDh2Zpe1DQu798wU5W4JtQIoWnmUEjPpcZ+8w+qvJWSi+9i1ekeBuTLAnGyGJuSO61tquGyV9Or8RmqfMURUOqMYiOkx7MO09we2QXwP4pK41hoJz0/1UJixpjASpYs3Lspa+QKgDhBWlyoorkVQC1MbO5Nrqn9ZWWMLAMeXcxoyr/YMueh4Azj4ei+OLTCZvK5QK5syikS3GQa4+nwPDzWOifso2mGRdaTKPVh1OK+URy7Mfxq/QRnfQvx1ZDPQ4eOV+jc8swcNyZTpKd7ioOo+cblV13+IVtvPRWWVHbwjfjvQdxADHKdwRP0nfpP8DhXMgo7J0/SrI8UIv1Gyh5TsoOfU3bHuvBDe4B0aKm9ZMHGTCONYIB3aFqwEoZk+y1/+blq7798GYT+TEfDBOgZn14pY1JXdwnaEIYDcHu+KlEfMXXZWq7dAPxQrKYU3XH3To7GkRDNv04Y7TjNj45hmXrhHA7HNAbcjD52l7fZ/jnPhank9iXb0QXO3AvgotsJhWXrXLgqO2QpmoDPwAf7DLW5GTfBo9vCqnrQxtA/RcZJ+g5Bb4/YB+ugV5hXD5zlpRN03ws56u+k0UDy9lu4pd4GjpfC9XrjlvM0Ahym3tq0I1GXeWlc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ea5TIXQJ79lAbk3l4iof0iKHitp6AlxdZGXjMmZPRB3coLqCCUO+4EUZIfUu?=
 =?us-ascii?Q?L6RnNWrCAIyXD98NpFtM4S84JGzZLIkr94aZQ0FGq5QNuVqiI4NDrVYsD3bf?=
 =?us-ascii?Q?pQhE/lBKCMdkjE3p9Mr1yGpcfVV5kCcC4siW6JH5jlmdT7suenmRXA+6YKTx?=
 =?us-ascii?Q?dH5Li4KPa8rDr1vHMBlypFciStxlZ3FwDkWG7LEImU0Ss8cbGaR2dlu+szIa?=
 =?us-ascii?Q?Y9UxPSfuGKcKplYspQz+K5hWzbffKmyDNw1+B7Mu146HAxKqqIorh/qZxl8a?=
 =?us-ascii?Q?cR7jaq2Xe1gugNJ4izYx2+EDnud2NIQZk0mka/VDXEz74DoFZnhSU2mtieic?=
 =?us-ascii?Q?rXPhyF6ojZoRvF0IQSxkSL8kWwJnlbQA6SKbPba1LgDl6EZdxy7T4+kI2ASA?=
 =?us-ascii?Q?YMBWuvRJ5fxa2oHj6sGefGwc+JMu8HWi0yp/EiZ5+k1A5vcCuGISay2oJPvY?=
 =?us-ascii?Q?WztBDjsLpc68y4WOXfGjz8n72KSVTWu1iJw8U/SjPh9HtgI13STYFWHl3IWl?=
 =?us-ascii?Q?8ML4+5lZ4Mhvdfj/rArfLPON+aa+7/LEal1r9A99Yik1RWw+hdM8n+yRMsiW?=
 =?us-ascii?Q?fkhwF6A0+DMhStphYc80HtIFZsQ8nqOhld3XgSWn+5qga3/9RIhIKZCGBurV?=
 =?us-ascii?Q?+SeHoC8BJ7acy77HlyTuxpWMljsQybw3bUpIpLLqjWV21tFi3bNpBTJVG2Ce?=
 =?us-ascii?Q?qxP388cG8ciz+wmkhY+1s4uUxvzU1xfOHcc+jgP9fVg0/Pw0LHSCFvTLsHHU?=
 =?us-ascii?Q?EFtW2HdeB5uiTjU+zXgqFs9seLCY/EKh9bmdXDUkYK3PHqEuQU/Nbcnpmjxo?=
 =?us-ascii?Q?G1JUdjNw5B3v4jFyec7UD3SL7dB/jccK7EICjKyOIvFujWcg/cRfn1oiodbK?=
 =?us-ascii?Q?neI7KMHFFjyOuwa5gTnq+lvakMiTtzqG68aKDffaUzbX/+AkhsjDHMAK9KIg?=
 =?us-ascii?Q?hffMPwAuKfERpDuCgnrOJBtYxQJV62I7FgaDYFSjRGYsGNjFu9XHlRBOkhIK?=
 =?us-ascii?Q?CaZ51MtUBKKRX5VLcYeN/BkOQ2sAVHoh4LJOoSqqQEnUxRVe/BaELD+gy7i1?=
 =?us-ascii?Q?zle1jZ485oM8XhSwcz4XkVYkCewnvN4rlnPwFe6vjC2LskafvsBKIIPztyYa?=
 =?us-ascii?Q?vlJl4d4eysaAqTRMeVd/asCCkc65Jkd7SB8Mx8TpaHJ+OILIW6dDVhzCqOp/?=
 =?us-ascii?Q?ItG0XHV0OKNWhfq3nYLryXbJuoSZTEb4Ww1GWrnv5u3B++YCcZvbamcyFvxs?=
 =?us-ascii?Q?9mKB664zIKck23bOCXz1gvrzO8HiX2T/lXvR4PNUtQ8FGvtwdCGQZoJE3czg?=
 =?us-ascii?Q?mdMeMmmM/fF/t6Zkwx8wUZro527kJoemXvlpz+qzpMDicJptrTs0RLeAn5/n?=
 =?us-ascii?Q?m9Mb+HdDRLKpFzzjpHq0gwcDA8Gg9w2qUkqJ0Rdky+MtADXqjwH6Nwmbgr9S?=
 =?us-ascii?Q?X2WJg/oJZtuAvi70zp9EEAEqsQvnJX/Rqyr838htnDJ6sZuRKxBq1ufkJBkK?=
 =?us-ascii?Q?/KhAw3WgYtfwwU0ByfShdVnT3CvsBWpPBVOMozYumwqAEU8yzbTvPuLOopIg?=
 =?us-ascii?Q?mSddevDETtzIidtl8egQJGhcDNXy2cUfvVCyOEZysW6vQdoLWl9pZOMfVUfy?=
 =?us-ascii?Q?DGRQbshlIBoMi/4/M3vT/tylLk3VI6tKDq539PAZFJPVUyh24pAqxcbBvaYE?=
 =?us-ascii?Q?vEwOgoz7FOQbadPsuu1VgnXNbHRJs+sDA8CR3qtlV5BLOGG7BsVnn5WZDQdr?=
 =?us-ascii?Q?Exw/0O5Uceh7lxqo6g5DjvBRIfxAOntLgRUs+HUOSRhZjHUP8AMM?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 54f549ff-9d54-4ebb-1582-08de786a5da1
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 14:45:36.6333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jFYj2ef55p5FZcl/arF8uD6JBDS0NevgCnJxxEBCGfzwRpxV3lQSYpd42+oWIdGCGcFZtQ5POTc49L7IhXwmrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB4192

ntb_transport currently uses ndev->pdev->dev for coherent allocations
and frees.

Switch the coherent buffer allocation/free paths to use
ntb_get_dma_dev(), so ntb_transport can work with NTB implementations
where the NTB PCI function is not the right device to use for DMA
mappings.

Suggested-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/ntb_transport.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 78e02fe6caba..a67cc26e47b9 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -759,13 +759,13 @@ static void ntb_transport_msi_desc_changed(void *data)
 static void ntb_free_mw(struct ntb_transport_ctx *nt, int num_mw)
 {
 	struct ntb_transport_mw *mw = &nt->mw_vec[num_mw];
-	struct pci_dev *pdev = nt->ndev->pdev;
+	struct device *dma_dev = ntb_get_dma_dev(nt->ndev);
 
 	if (!mw->virt_addr)
 		return;
 
 	ntb_mw_clear_trans(nt->ndev, PIDX, num_mw);
-	dma_free_coherent(&pdev->dev, mw->alloc_size,
+	dma_free_coherent(dma_dev, mw->alloc_size,
 			  mw->alloc_addr, mw->dma_addr);
 	mw->xlat_size = 0;
 	mw->buff_size = 0;
@@ -835,7 +835,7 @@ static int ntb_set_mw(struct ntb_transport_ctx *nt, int num_mw,
 		      resource_size_t size)
 {
 	struct ntb_transport_mw *mw = &nt->mw_vec[num_mw];
-	struct pci_dev *pdev = nt->ndev->pdev;
+	struct device *dma_dev = ntb_get_dma_dev(nt->ndev);
 	size_t xlat_size, buff_size;
 	resource_size_t xlat_align;
 	resource_size_t xlat_align_size;
@@ -864,12 +864,12 @@ static int ntb_set_mw(struct ntb_transport_ctx *nt, int num_mw,
 	mw->buff_size = buff_size;
 	mw->alloc_size = buff_size;
 
-	rc = ntb_alloc_mw_buffer(mw, &pdev->dev, xlat_align);
+	rc = ntb_alloc_mw_buffer(mw, dma_dev, xlat_align);
 	if (rc) {
 		mw->alloc_size *= 2;
-		rc = ntb_alloc_mw_buffer(mw, &pdev->dev, xlat_align);
+		rc = ntb_alloc_mw_buffer(mw, dma_dev, xlat_align);
 		if (rc) {
-			dev_err(&pdev->dev,
+			dev_err(dma_dev,
 				"Unable to alloc aligned MW buff\n");
 			mw->xlat_size = 0;
 			mw->buff_size = 0;
@@ -882,7 +882,7 @@ static int ntb_set_mw(struct ntb_transport_ctx *nt, int num_mw,
 	rc = ntb_mw_set_trans(nt->ndev, PIDX, num_mw, mw->dma_addr,
 			      mw->xlat_size);
 	if (rc) {
-		dev_err(&pdev->dev, "Unable to set mw%d translation", num_mw);
+		dev_err(dma_dev, "Unable to set mw%d translation", num_mw);
 		ntb_free_mw(nt, num_mw);
 		return -EIO;
 	}
-- 
2.51.0

