Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020079.outbound.protection.outlook.com [52.101.229.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4E042CB03
	for <ntb@lists.linux.dev>; Mon, 10 Aug 2026 16:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786380716; cv=fail; b=fxHVrfldTTM7ZgtiedpbxPPb1AdJdl3oYAZw9QoIN45vUuYdJKcOeYDz1oytpEp+mZLKB3xV9M8SCAE7dVJSjqOEhXRVHeE3H5Bb3Zaimrq7XsMJlwan0O2O97nlShDi7ppw1GZ00QfvpVt93uxSd5g8rJNwux9MN0Q3mHbGHoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786380716; c=relaxed/simple;
	bh=Yj21SGWMj2H4HV0i8pUgoljyRCR7X0EEFeQ+PIQZXAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MwFQYk32VLsBNthE2U+lIVlxPIIYEnhNQP4VuxKZhAZnYNaJc8guOXFUVyDrVL3cg/3rRHkHfR2ZrQVbYZJnj+c9tUcWvWyizBRHkzddcbz1/cGO4N/FwpYWRFaFS8nrThPWwzimDpZcmCj2Nh1yM7tpGs31ijqay/F/VM0XRsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=NnzhqbgI; arc=fail smtp.client-ip=52.101.229.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="NnzhqbgI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=btjryQ/LPAnaV2Suj3FMGzWcW7/O0vf1TKHFdSy9lcGIrSbnWbquhcCsdQMTZkrP10HFsmd3YXmvYr6BoPGpwFbyG7BRwDpXHZxde2Fhd27FSODfS+kfh8nzkuiN//Ese/PLYYp7E32cifR0Zpe5uWX/DMo2ZV7NUIYqoXTYGLbRN7KP16wlyfbTNg+1gtHDWqK3zps/W+I/V6hnJAitnR0GycokHm6C1Izdr0MmdLAPuhed4p7wXVpAMuDX1hrjjnVODO4nv0K778QK6ob/YwhPkgoDNs34lZPyZjW8zhkHjU0SKVqY3UI2ftkmZRjQX7cK88U+9FDPWOJX/MYQlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bCfFNPEkNOk3fkXrmLSeSLp1wEFaJjnqIWgBRfLAvS0=;
 b=wKvjCpsPFmKjWJGdYbLs5TtC00bnrvedcTt90LJqDs/At4RbXrQIo16hPQq/ThQ66IjqViu3tAGlgovL+Nj+GfKEpJ0e6RF9ObMtaBNAw6wlzBfahcZkYZ0TCL3XNwcsXuI+oHUFxW1CohFJz2wafTHszBWR3nf9p+SF/4Rug3slsoAVDWxjQeh0MpXfL2ZIdQqxgroB1gteaCu2aqdCA+ZunFHKMK/rnbvkzOB7wghidz+kqjO11IZq7tdI3NYXu8ZsKpBcj8lV1xtvPr6R3Et92+kKug4smvdEc4FRTxne1G1ydgmm+HU4cV1kQMTh+EcIuhZ17I5VpAFX1U8IHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bCfFNPEkNOk3fkXrmLSeSLp1wEFaJjnqIWgBRfLAvS0=;
 b=NnzhqbgI8CjRLC6B+vrzH4jNF69uNmFBl9iVgGq0JSUJr04xJSC2YD+HdVdB9I6q4PWPIVClSomJbSCo+tloLXlktWzGzRFIENo6xuaghudU1K0GP123Qt+lTAwXISRA6aaeYpGJuEIFtZ92w9C765oovRjs2X46xVpmE9C4ryw=
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
Subject: [PATCH 04/16] NTB: ntb_transport: Stop QP work before freeing a queue
Date: Tue, 11 Aug 2026 01:51:23 +0900
Message-ID: <20260810165136.2292436-5-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260810165136.2292436-1-den@valinux.co.jp>
References: <20260810165136.2292436-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0208.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::18) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB6729:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ec169b7-3d87-427e-f2b9-08def6ffaa63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|23010399003|376014|1800799024|366016|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	DjeI/t34tpYuUBxCW9AGQlgcAcTobVBbS5wdvSaVeIb8LIjnRjvTMoEb89jYpcmWSirdSIoKZ2ZIhHwwr8uryZ7w6NBxy7bLt9fVZ9gkfJS+Oz+ntCC33Frw7/ix7Gnb5xf3fZbkV9N/2ZhMcgi85x/cFz+q2SKRznK1CkreAvCWjaxR2+5zQwQC6w+1r68RJwBhSCHie85gsyOMshd/JGTJ7vlVOp2XGXiWcJrmWTHbw3WvpnhR0t9jGAA/FdmmF1EqJ0mCh1EBJ0Q223lrDmREdVnSTWzMce0j+JNBPmh/xHb6H4jQv/ZfbB993wp8wvO78Rs1/YI2jTztdcTL8OykvrYkaaGWmSluHnI8Zez1+PEf6874D8IYXP1h7b5bPZMSCwo0VKSA6zvmfLt//8HX375hvRYiu0T6yvbVWgETyi8WD1HCVtyJgKLhXo1c93uYW+Iu7xfYDXSrTiHOyiWhY1IIwLIT7pWu9n9O8VnACeMFmeiOIpKvR/F4R+jESaE7zOCuKEkgWIvYReYO57ZsjT96hMRuCyYmcnPExbIJXlr20p23EGJuIFpuE2aDsmPBvyOjHbEgFHZRXv7uobKgFjcknpHSSaIuN6YCVUQ3iGaOnKbbj7C3Zfm9Indne5+n3+cEWz+pH87uQ4rniA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(23010399003)(376014)(1800799024)(366016)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w/jwhdzG0F9NPVc9vO8N+HT4I2/gfs8RdhwzEin78OTxzXB9F4/+lgU2RVVU?=
 =?us-ascii?Q?CGKDZI5TfDn/8dY/jUJ5Mo3+gR/sf0AxuihDRgw3xcKyGe4VGZg4h65zUzhT?=
 =?us-ascii?Q?h0Zub/MfVDot6V+sLhS7102Im/rtTvP5CdUnrub8N9iTuI67wwNGzjMVcjct?=
 =?us-ascii?Q?MIzaLuOfBFuWPD9MSeE7uGKQI3lvL34QnFypdzpB5tDqPCPVrc+4lA8ZZkb1?=
 =?us-ascii?Q?BNb2vZVZzz7c3NOLGS9+Co1pw+hCOqH9aEVtbZCzSYFjJbWIj30z6pvg6u22?=
 =?us-ascii?Q?U/JjabHsq51D8EauOKVFHLwicExm0gu0R8w7ipMTOlYCW00M9xlXdLHGzNJj?=
 =?us-ascii?Q?Xo8rQfaTmO0oy3pn7iWkKNPlw96LXZkYpOWp76MBikHGQFMdVgFMb6LgVzRC?=
 =?us-ascii?Q?IHVTrhNfBQJIsq/6cTcY/X+gdxwzSkLaOV9U21Lv4bXle0EmOmprL0aNYEq6?=
 =?us-ascii?Q?6IrjG3DI8ziPDUU2VOlKjjp2cZUh5geATXq+aKIaDUGHLiBmOuUCVGr61vH9?=
 =?us-ascii?Q?xLa4y05XmmJktbEf2KG0ptlacMj3vcl+cSGUAcBitbgQsbXA6oeVuUiG0nUY?=
 =?us-ascii?Q?J1k+Y9spnfvFRBc4lsf8MEBQA9zvZwDgqv7H1dBaEHIm/rIqi6vkQGKbeQ1Q?=
 =?us-ascii?Q?R/VWPi3wuked8rrene8d7uSRjUe0eL8rppWEfig+os2AK6Fli8LqHG7ecTSC?=
 =?us-ascii?Q?b9mlpDJLSLiOlXVRASgxuq5KK/FedMjrsmKed6bqNrgGbjC9iEM/mHaFAgN2?=
 =?us-ascii?Q?EeOaYIR0TbzJiVdVcWSP90u2X5dxVMwgNM9k6WhpB3TyF90W5bBQPo3ulqp4?=
 =?us-ascii?Q?+S/YtzYDW3jRLiMMotXp4Ks7R/eIInMALnpNALHy5wDLhRdHPBv6cT/SVm50?=
 =?us-ascii?Q?LH0jAskuzvrV9kNkGGbNxJm54C/0mZJqiMOWc4EnlInHPCZsoi+vCQFBE4L/?=
 =?us-ascii?Q?ysecSMcQWnaChotbF9zp6USP/f0BPGNJnCBYolgDrqZgbcC2kN9hU27L9cPR?=
 =?us-ascii?Q?OgzSG/lOub5YSKK/bxictjTob2A+XGUFhV/ggnIBUW5IAriHb74hb0gVFGpA?=
 =?us-ascii?Q?VxmfC16veLYMypGwEr77daYLUNGWzMS5jXh1QNVttoFnQ8HoqdPpxnvLduiA?=
 =?us-ascii?Q?88RhoBQhQZTGCeirKh/Jt2xOtS4XcTB+Bqc1XuCmfeURWd3r+i62u97oSGeF?=
 =?us-ascii?Q?OM6p6/fkPN8QYK6JJBF0uhsCtTTQ8fIOoSRnY9sa4gXk4vlYvJ6ngZhv8e/F?=
 =?us-ascii?Q?63CCq8C7Q7Y4CpngkJBCzAofv/niuSE3n9FALY4a35mUCAvIPu1pys/CZn+T?=
 =?us-ascii?Q?sJ+1IqTVlvWE4mob/Stmc5/jk/5iZWGkEyg+e68UkS9ViLA7dNNmcjp1mFdM?=
 =?us-ascii?Q?rDzKMM5s7/dFvFUuTCLBDXqPfK/v9Tvum7+Ezd6MWI7MQgY06HEHCuxOO5K0?=
 =?us-ascii?Q?wLRIB9A+PL2p0Dv7r9je822KkZ7eV7aJPhpVPzhZ+rMKrzDmR4GQ7oc2kLhF?=
 =?us-ascii?Q?hSjtPvV3nbLjsJpRaE+VwoZfQlLLK2jsu07TRCGbAWgSkamWsZKUVvo9vGXG?=
 =?us-ascii?Q?ySl8ohTJSX+k5F3oAoGQyJ+UwfQ4HmfTKs/VgIv+6EMTVPRVtlhP819RYE4O?=
 =?us-ascii?Q?X/0znWg2QOUT49CIap3ywY1UxTVeXHYtDSDA5h4jWZIOBHVjU6O/G/Chyubj?=
 =?us-ascii?Q?nPSUJNIlQ5qNp2xMF1O7Tx8REM9T/3uTGb6OW1zw6NDelfIbmq3AmcDnDLyX?=
 =?us-ascii?Q?wqdABeUXv8c1xtUmLoLQwrvmWCzTzOYN3lyso2Z466gwhVodx2rb?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ec169b7-3d87-427e-f2b9-08def6ffaa63
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 16:51:46.9670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +WzlLMw6lUpI5cTpYnAFsxCeOKQZhuaT6a6AjsMmj4dzch3+dVYipXSDGVHEO3L0JFYVRNHjTMICa6JKb681aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB6729

ntb_transport_link_down() clears client_ready, but asynchronous QP work
can outlive that transition. This leaves three teardown races:

  1. Queued link_work can mark the QP active again and schedule RX
     processing.
  2. A per-QP MSI can schedule RX processing after client link-down.
  3. link_cleanup can run while ntb_transport_free_queue() releases queue
     state and can rearm link_work. RX processing can also queue another
     cleanup while it is being drained.

Gate link_work and the MSI handler with client_ready. Before releasing
queue resources, drain link_cleanup and link_work. After stopping RX
processing, drain link_cleanup once more, then link_work because cleanup
can rearm it.

Fixes: fce8a7bb5b4b ("PCI-Express Non-Transparent Bridge Support")
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/ntb_transport.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 044d8b5747fc..4afad4489772 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -653,7 +653,8 @@ static irqreturn_t ntb_transport_isr(int irq, void *dev)
 {
 	struct ntb_transport_qp *qp = dev;
 
-	tasklet_schedule(&qp->rxc_db_work);
+	if (qp->client_ready)
+		tasklet_schedule(&qp->rxc_db_work);
 
 	return IRQ_HANDLED;
 }
@@ -1133,6 +1134,9 @@ static void ntb_qp_link_work(struct work_struct *work)
 	struct ntb_transport_ctx *nt = qp->transport;
 	int val;
 
+	if (!qp->client_ready)
+		return;
+
 	WARN_ON(!nt->link_is_up);
 
 	val = ntb_spad_read(nt->ndev, QP_LINKS);
@@ -2182,6 +2186,8 @@ void ntb_transport_free_queue(struct ntb_transport_qp *qp)
 
 	pdev = qp->ndev->pdev;
 
+	cancel_work_sync(&qp->link_cleanup);
+	cancel_delayed_work_sync(&qp->link_work);
 	qp->active = false;
 
 	if (qp->tx_offload_thread) {
@@ -2229,6 +2235,8 @@ void ntb_transport_free_queue(struct ntb_transport_qp *qp)
 	ntb_db_set_mask(qp->ndev, qp_bit);
 	tasklet_kill(&qp->rxc_db_work);
 
+	/* Catch cleanup queued while draining RX processing. */
+	cancel_work_sync(&qp->link_cleanup);
 	cancel_delayed_work_sync(&qp->link_work);
 
 	qp->cb_data = NULL;
-- 
2.51.0

