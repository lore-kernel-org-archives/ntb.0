Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021142.outbound.protection.outlook.com [40.107.74.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDF242F6E3
	for <ntb@lists.linux.dev>; Mon, 10 Aug 2026 16:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786380716; cv=fail; b=HxBuVyzZsIiBdM9ndB3EcmxvQ/nXTGDYNImTo6V+U7sxEYd8g5D8O6YtWCpYxCbtlWENfNq1CLa9icxXSPVGvyGH1ZQWmVHG0GN/e4ccfE5RsGBhJZmRGlfDDg4A3W2ZsuzVRt6ZT3EIMuQLAbenVnKtfNLvib0xWK0NHN87938=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786380716; c=relaxed/simple;
	bh=yzRzlzK2DjjlFhTJhG4hZBDCZvszZFoTK//BCOBzQ5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F2UhKdtSSJYcqitBY1mT9jEtHlh5wnxrjhYyHxMh/SjEXM+/tNJH8vgigamH7Dcqhh4dzvbwk3zyx+0Vt3Y7acw2qPy8Zd3On8UbsLztg1ONNR13LUFa57AlOKwpOuT9mIC/Sq7TJU9i1mIcdMtHSvhAAxp3Cyon2sCOeatSvrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=pkJrVudB; arc=fail smtp.client-ip=40.107.74.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="pkJrVudB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SXyVKevwAOjOmFEf671cZ//ecS3dh5wOJW/UhpDrBhBjz0R2LTWRqb6hTVqdQgCcuio1kTiQFhjzYE+cWh+nMr9KiMMEj4V/5byWmu53FjOomTZNIB/plwlBXugBbi95nSIBLaezO0dXbqxFszWfMWYNnfjmKInTYEOjmUkd+Iv4bzXD3zZ1CD1KifjjAHV8nhnNE4ri4JT+PRDOpHmdYFcxM5/KmWHvhrCyvUdslgHwVA3GmkJnrLZiXr867aMuEOgcCkAyJFpI4/yVtWAMWD+E9BtdSMgMCC8RgiHOI8VWjpkz1YYzFUoS+mMQ38NOS0SvQQRQn1IEcIswvaI7Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a2EyxkuvnQE89mL49Lcb9hNiu6n9I4cMG7q5Q5jMJZ0=;
 b=qwRHMuKHbcc5lqZUcTFQ/rqPfNZLLys95TKp07dfKEoLZA2JTXd00QSIMuvHaJmgADDSfDCIePHwvAZHgd1zMwJ4veUJUxE1ztf5asJWqonZnluuIH4iCvPv0YcHtrK89o4WCwtiz9zOQ8yb5r+x34ztbNAUP++fFTFH+Y1fuFR+rM/sLCBCoJnF1c+jXi6ZcUtJAQWsgAErl7WQfgFjeEJ0IcTdCu0x74sShcgkDNYr1L05Sr09XyoH08tRRLNJuQhFO7Dt0RxGMJJ61wi1Q+UQKNF5YisdcdKn8SG7eksDNeBPpQQhQPjbCm4nloJlGg4fuStbASSTIPG6kg4NwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2EyxkuvnQE89mL49Lcb9hNiu6n9I4cMG7q5Q5jMJZ0=;
 b=pkJrVudBZwDvEWs9lF+MW107MMh7MhdDXQAri5S1ajrzwtT4zydAdXoVFcalH0GID3o/rtgGBJOVT0yFpaXs8uN86JuzvcBXz9rG/muRXs+2HeK3ACmampWTiennxwUJItBx9YpfsaScjtg43DM1400t5MoqjUV5JYaQVW1PeOA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB6729.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:42d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 16:51:46 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 16:51:46 +0000
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
Subject: [PATCH 03/16] NTB: ntb_transport: Start TX offload thread after queue setup
Date: Tue, 11 Aug 2026 01:51:22 +0900
Message-ID: <20260810165136.2292436-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260810165136.2292436-1-den@valinux.co.jp>
References: <20260810165136.2292436-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0112.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:380::11) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB6729:EE_
X-MS-Office365-Filtering-Correlation-Id: fddaf236-6e7b-458b-910e-08def6ffa9da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|23010399003|376014|1800799024|366016|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	FenIFwDzZfH8OtdhE34GdxeIP99E8B3OFZG3e/PpkLCxbxsdNUMkyodGLvRyj8cFSvlB2LiUG5mjvf6/s9IU1FAZLnjv+ZRGkExu8XsZRhvOX+n9KpuF1OxKCSd9f+mK7UQBfSmZnngLLj1IZ8PhZM3BZWMUXKnlYQQzTJCaJaC9ZDS2ScE7mB9zlSthYZ7dP+rFE9rsC24ME0QNDsMgdmywyD3lHJzmkmkans52JsSYDovxLB03cxnjnOj4HQRv9u3YuoewuVbU8SCtJipdmsfEBBzQ5XJjfeStsdp0aT2fMAF0HOjc0GRwgYYKRYSATNSyS0JHSw0L1BCs2HPE7yyG8eFxnD770iIjodTVdsjLkLjbdzj6HZ1xUl0gCR6nWJIgFDI71M672XpUUvQGsBPOXl3DiKCoR+hgkjzMr88VghgjVwEKTcdqavC+h6DzDNRUigO4CGtAC2IsWjkff7yzaUWzCGmPnFpwwAII7O2TQzViJRSQF0bQBhVWBTv/pEUcWfgM3Wca5FnyOxWEH9NoCaTTByzIwUjEM9cm07xV0iUHkGs8GuiF8lW0NCDfplNWM/wIDbnT+/lCNMC0Qj7BrKF35iYZWFXjsfrr13gznUb6gHBFOn1AIXXlnFmBllfh1STO/2SIvVdWtLdR4k8sej+UkhdaRRqWG5lV2nM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(23010399003)(376014)(1800799024)(366016)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DoE24R5uMMehiMzBQyebYV8xRUVIIf+pY25ju5EfX2oC0d9dtGKzI+Hw3ppx?=
 =?us-ascii?Q?2CNQ6ZVAnGxM8zOYW4RXrupUA28xW9iqQU6rfPVdajIgX5I2dtC1eAdJXYTA?=
 =?us-ascii?Q?Rui+M27HLMVDy1padP/lH5VgF0JnldtvW0k4aGeDcd8rulYCviL9L4jxEwaV?=
 =?us-ascii?Q?udEY7Xx+GoXNI8J4pYWIIemdEYJiYXbEAsOPnG90Knrx1RsmmFKlRgX05Z/q?=
 =?us-ascii?Q?pq+PHGSNNz+4HUDMoJxbZ+l+E1+kZAgXeb3/qxUpjWWQY2x3JWstR8QtMaKV?=
 =?us-ascii?Q?YiXumKx8ZLsk8XYGD2IJ4pjSWhIZWDBSzlqumzCgctEZhPps4OnfYgCSNYap?=
 =?us-ascii?Q?d/iMW8+Ph5dwzlSxXHtWm4cDpJRdkx6fBrWNYKmpecTPTZ2IiERGN1giAuJq?=
 =?us-ascii?Q?Mkp2UM5aWzV/nmWNK+pvCZFiO93wuGhvAcJKUCHdDI8BGv+v0KaRaSvBHhzN?=
 =?us-ascii?Q?qKbCr32EzBgUIq8fTSUM7p85et4+BdnICaN/8QY09lVCNgOzqbl3D0f4MUAd?=
 =?us-ascii?Q?+ljQisUNvliHWi3iIeLN8N2SMGpLBVVjvYVbQVeFIH2h7x/qI5H+AcFPpHJu?=
 =?us-ascii?Q?7WLEj9yXfE0sCvMFCOdpwNEAXKHSjUGAZYd/NThd0a96Yxyy7UlNdTC3nJ0F?=
 =?us-ascii?Q?HYYuZ6uWB42f+wMbVc4XC3JOLjZRmQ054WOBXgiqhWlwH4zCFVuci3+5bEAS?=
 =?us-ascii?Q?90a5yGR3ailX5NwP45Pvb2/VpurgbcxS0kQ/xOroB+l8LVh0uoclcu4yOZKo?=
 =?us-ascii?Q?+yNEtnJwPQr2O1eV5q8+2OwYSdAYQvjqtxZc4Mbt/E2hWZJknpi+GGoCb/I2?=
 =?us-ascii?Q?EVvPERm/ygw4TV5on5cl+ci4nNobmAs67TLyLEqvo/YDtTCuAVhtirmvGucu?=
 =?us-ascii?Q?LIRXRkddpbAPzrmxfnsjyi0a4L5W4U++BomoYu553o8EAXH0CKADeCAMZ3Q/?=
 =?us-ascii?Q?GJCwDoZsHKsjKO69KQfnPzFa2yB6MqKI5oSP1S2fBHHua/FghlPEcWTBnsnw?=
 =?us-ascii?Q?wFiRSQJU7rUNxENo16ZT+SJ6+2MQ9xNrGkIach+ydRDDlUk6Bb+/NGBTgwhp?=
 =?us-ascii?Q?pg1p8vbXc7fsKmyQ9wP1umrBkSYMeRiSXDoHhcXMshHQvmGwOcq4TWq1aLeg?=
 =?us-ascii?Q?C+7KGy7b1OL5k+uOkrVhXx/iQqIMryjrdgQ8lfNUWXr8KrKqDUpDoNy/SO5n?=
 =?us-ascii?Q?15H4a94cegckKF8QwZiiOfPCtJqUNLsoj5F2RqQLqao84cZKI2pJc5ZqFW85?=
 =?us-ascii?Q?aB95E9db0CxRNkloNW6tLPnHtti/NMt2/136XzydAGIBDbcNPoU+G8l5oXmM?=
 =?us-ascii?Q?PVAEF1ddozrNChieWi0XQhR1E8eZwVLYt/1Utc2xWpYotJ61/uX83ocRoAOb?=
 =?us-ascii?Q?Puchl7uA8/g8JVkVbbj3dhFxAQl3KS7a5Nsl7ZgFoM0YWdzqgWFL4U3cbLh5?=
 =?us-ascii?Q?6bkOfyOPA27Viyw53TuY9JhoPZsXDdPyopNtD/Sk4h4dPrSby1//zFBXHd1F?=
 =?us-ascii?Q?xl9lTJTDxDDbIPSt3GdmLEWuB/EAcTG8rm2iDgREg+su1CKWEdqwzSNC3TgI?=
 =?us-ascii?Q?T8cE+OndSGC0LYIykOiQWJ9W4ufjtItncHVUi6SMF+VNoy66vAxRJf23Is5d?=
 =?us-ascii?Q?L1BQ27Atoi21kx/9zfvrjDfVBZerAZgRYn0h7oGP4ddZdQAMio9kVqNojyqS?=
 =?us-ascii?Q?KoSpVViyj+mRHlgB0BKTNSnXDD82WyWVMXrfv777YkSCtTOZwmr7eRMP7w6A?=
 =?us-ascii?Q?XUlHJDKnMWeQSOITnjcfMqAAPvRPTxIOnkv1laxueQ97ME8EaZ6i?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: fddaf236-6e7b-458b-910e-08def6ffa9da
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 16:51:46.0528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CtO2UulhExvtBKSlPDcYXFv9kktWTTW3mGyfPobYwT0Z9t4Cy/xEgNBX6cEMA26Vao2AAWVnBCB9IrpaKbJdcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB6729

ntb_transport_create_queue() starts the per-QP TX offload thread before
DMA mappings and queue entries are allocated. If later setup fails, the
error path returns the QP to the free bitmap without stopping the
thread. A retry can then reinitialize its waitqueue while the old thread
is still waiting on it.

Start the thread only after all fallible queue setup has completed.
Thread creation failure itself remains non-fatal and falls back to
inline copy as before.

Fixes: 322617a06c97 ("NTB: ntb_transport: Add 'tx_memcpy_offload' module option")
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/ntb_transport.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 3a9635faad9e..044d8b5747fc 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -2063,20 +2063,6 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
 	qp->tx_handler = handlers->tx_handler;
 	qp->event_handler = handlers->event_handler;
 
-	init_waitqueue_head(&qp->tx_offload_wq);
-	if (tx_memcpy_offload) {
-		qp->tx_offload_thread = kthread_run(ntb_tx_memcpy_kthread, qp,
-						    "ntb-txcpy/%s/%u",
-						    pci_name(ndev->pdev), qp->qp_num);
-		if (IS_ERR(qp->tx_offload_thread)) {
-			dev_warn(&nt->ndev->dev,
-				 "tx memcpy offload thread creation failed: %ld; falling back to inline copy\n",
-				 PTR_ERR(qp->tx_offload_thread));
-			qp->tx_offload_thread = NULL;
-		}
-	} else
-		qp->tx_offload_thread = NULL;
-
 	dma_cap_zero(dma_mask);
 	dma_cap_set(DMA_MEMCPY, dma_mask);
 
@@ -2137,6 +2123,20 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
 			     &qp->tx_free_q);
 	}
 
+	init_waitqueue_head(&qp->tx_offload_wq);
+	qp->tx_offload_thread = NULL;
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
+	}
+
 	ntb_db_clear(qp->ndev, qp_bit);
 	ntb_db_clear_mask(qp->ndev, qp_bit);
 
-- 
2.51.0

