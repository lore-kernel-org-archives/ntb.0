Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021112.outbound.protection.outlook.com [40.107.74.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229873AE1A8
	for <ntb@lists.linux.dev>; Mon,  7 Sep 2026 14:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788791097; cv=fail; b=MJabrHnAdYPKsZfF5/AsZaINifCHvzS11pWgcp6UhVwl+ddBJzvb3baxSqgQdM+ifjvrM/SlKx8CUEMFX541VEGqo0Gp/j2imQ8eH+6NO1DY6F0vcIvczKsQZd3oXL09W494QCwhvqnr9hiT90ZRDCqrtKYt8TLfyCBh8pDPGpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788791097; c=relaxed/simple;
	bh=z1Yuo4hcwNO2EsRlKnqmDipw3Nqy8qoJbltdQt1imDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HA/ZMOTAXPfP9IfVMjRQGYoamzXkO8HOXwJtJRUbExalTooRmndujtAZw+Yq2wogk6uijqitWqWYvXu+Jl8Wm0DSSadGCSSCh5HJ2leE1wYrLufL1gXBgOD/q5fwgV1xcHko95WH9BZuWVQvc69WEjFv0VXVPLGOw7BjZ2lTMs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=XLSd1MUk; arc=fail smtp.client-ip=40.107.74.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="XLSd1MUk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TVPRwriicbibNZp/vpOWD14yxFcUo33s3knmcoq0eqsy9v7QMowRhCT2+9ExBmrdHCA+M9Nax2mQtRfqXxu59RpVjl8NGxi3qSwLc6SImeALKec5VA55kC2kQLUZAh9Czvw+72t4xNZv111K/atjiptS3azBzZUumJNCAxoV+orfBqHsIl01RwVNu8mxKXizgHxrG5iNi0iit/MyLBVEys/EO24hnAca8sPHQgIiBHCcDOMszl2iXLhDzUN/MlGBVEHpplZAkUTBHEtSufZWaUvQ4SKm2GQNpRpFUe6+6QjMpA3arIo+Q2NEi16zAyPIfiPCe8IdKTj4FY5pMvCA3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YUYIWPWARrAc40wLbFNbctx0a31GeVXymBTzuXqumkw=;
 b=nqJQL7qCWKrPt/rIg4XBVLmxGgsly1+PBrwcOSQ41FweKjKlIPJzGAx2PTDvqPJ+EnpsmW7k8RMCEhmFSkfK231Egk6zSKjhwTdLzjXy4xPCPEGkCtus5UoapMyIjHVzN5tvTn/TKpuiC7kNek2CizX5tUlvusDfrVwv4SenSDhw01aZ/A1L9jc+NYIW3TX23+ZntTVbMLEdh05m7QTPQoBNi3pap/AOyvgmC/wwmmXRKRBlGnmTfskpR97/+m5MDZ4ZIw3S8nk7ohPMAsFcpX7ctxnO1bAeNcG3IDOOMQWi3L3qwous4nKFADcqArSsFkjwDiNigFIOMRp33KY4dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YUYIWPWARrAc40wLbFNbctx0a31GeVXymBTzuXqumkw=;
 b=XLSd1MUkXLleHVfMn0CE/nlBB0H0HdBPCtRg1XrGl6JesccljSQs9OKO6mh7jM7KLu8He+J6Dz7Pc7hjVg7QCuFIl43F2/0U0VPzficFLCB11GDy5Ev4Iy4eyf3dHTeA2J8WBLP/E1dv0PRjsceUUsI1CEI5CnZ2Zb+c5mFoBxc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY4P286MB7581.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:34e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 14:24:50 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 14:24:49 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>
Cc: Frank Li <Frank.Li@kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>,
	fuyuanli <fuyuanli0722@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nicholas Bellinger <nab@linux-iscsi.org>,
	Joey Zhang <joey.zhang@microchip.com>,
	ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/11] NTB: ntb_transport: Stop QP work before freeing a queue
Date: Mon,  7 Sep 2026 23:24:27 +0900
Message-ID: <20260907142429.951930-10-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260907142429.951930-1-den@valinux.co.jp>
References: <20260907142429.951930-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0117.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::15) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY4P286MB7581:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d1a016d-7555-41dc-39be-08df0cebc69a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|10070799003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ME8G+uArudK+65Skj8aLOrBW3c8tmZmIrFYE4uJZvkiieyY9WRA0kbKH66MKFG5K81K+MFMOZ+wEjk8u6ehMqqDbKgPh5/V7qcWM8s6dlcZAI//rnF/sGBXeA3tKb8avtTArvBCRZnLVNko0WcapMd90tGpPNAyVTdFAfb6cH4bV8SAiFyARAJtxVSQHwWXZW7jpfrAbPls6P1LX5wqjytvyJ9MzC57Mnk13g1SdYlO8Hoq9UVieCZ+EEGekSAN1PO1HTVhZwPuKogHaHeKT2AyVYg1BQZAQ399zIUaI6s+luBgCqRRzWqSkT41RzE5KX8DVwM71iVq0K7IslqLgQkrD3sjRMsRE6f+WKFmIQVw9IusDf70iwOpSKonDFswXdIun5qcQglU004FLePLplS1NsHz8x0EMZvwUKf0l+h12KYWMOZGKxnSj5ckwr1gvuuShjrd6T8XdRCoon0khX1hhiQub2M2ntK+50vxd68w98oSRn7Wl9aeqJXoOTjY2mP4y5WecUaqKL9rnb5WIwT9KIH1ArI9rX0q592j3V60PfwV3riafznbenyoMhllBmDFSjK7sA7d6hDb7GSNXWAQUjllsCP4K2IEXnKoQecsaY8OOcial2W/el2jV+a8h
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(10070799003)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NnrOXcBABh0+VnDllTmU0WMKvvbGNcGsPcHtPcAR1WuRh4ElhuLQvPE4xT7F?=
 =?us-ascii?Q?+gwtBAeGyJU3k/ahKI1RQIOZ7B6apdBCOZ2IDfSdTDRCLUIUZ72a71kS3MMh?=
 =?us-ascii?Q?O79GUcptT6YNhAmrJOoNRBfe/CT7Cv4saNOKyachCacHzfAjc1qO/8JnPCzN?=
 =?us-ascii?Q?+nF1+XdQzzFMFa2Qre9B7ljZ+QQy15+iFVFlrJ4fIF6U1M+pVX1vtDsI+3XS?=
 =?us-ascii?Q?tTnGk0Fg9kq6XiangsWibIuvFqY1Y9hQMXxlxH+32qrnNA1hu2a2yfIUEPQC?=
 =?us-ascii?Q?3hjDb6L7x0ExtrlDpL1Aud5tLtJ1vnP65JOFJpJ3vXKV2HFmVsxb0Ntc4K1T?=
 =?us-ascii?Q?Ihq/Tn/2bqWVM3P+kVcN0cCOm11Trf7j7Zk9cbM8iPjTsXwoIVAi9AtkXEvm?=
 =?us-ascii?Q?I/5TUiWy6t2O9iE+wtMM0uRzadMcw9TT8ZK++P68jUX9TM8T0uMIJF7+ibll?=
 =?us-ascii?Q?h6AV+WJ8571l6zIUBTeLqo/ikHv44P246RxHuaNAw/o7E/3cSh2cOPZ9Yfnw?=
 =?us-ascii?Q?vv7Cm3g6RzoeBi2wSHpw4CMamzEyh8FgdMXkXFZ5eoli1uovrC66rCdF3qeL?=
 =?us-ascii?Q?iOiT4NMsqRhbsP5SahPhnk1FcTtOP2bGtWZ1ydeEsX+bGfoBxyh6PhFdf7hw?=
 =?us-ascii?Q?mwKV9i3w1c3jn218o/13+LlammQZJUkrA5/LnoALEiihXk5gi4HjQpV8UfmZ?=
 =?us-ascii?Q?CIN2vunjAhNXBoDNFgS5k2bkrX1EVcDADoOgd4UUb5PiCA5NX6scVVjwPTLX?=
 =?us-ascii?Q?AMwFWL9OQVtNxehxrHDCyaa3w4wihDTQb0cguay5yGp9va8AWZF6PqeCJE4n?=
 =?us-ascii?Q?9QbiKXzfjHbsCfKTjGFWv4vp0aV4NOy6dZVPWG/aKy7lDHrGsLNDBVpKh7vg?=
 =?us-ascii?Q?fnOwkXsxzVKouCrSWMd6wtlmACmjhc98Pzoh9X6mtdboCBEBIvj/DkI+HSma?=
 =?us-ascii?Q?kTcCryBlk7R9s++Kt2Zrop9sa4GHMRFnZkO3SpFsPNqag4VBWG4KzYxoEIAt?=
 =?us-ascii?Q?pPxVK3h06SNa+J81QGXiwuEUaYzgYBF3Xls5yHvWjBBnIWxbMQ1w3LMS843w?=
 =?us-ascii?Q?5eMaALJhXLxh1V3dlVCHqz3PJCM0iY9PZdAsUj1q7/xx6Fub0i15tFeOUk4/?=
 =?us-ascii?Q?wRs7XYuUhsQso7nYYxX/hlTLMqCRaN6yobS9Ben1wBFhQ+EI9K1b8SMrw/2F?=
 =?us-ascii?Q?OsyvOaEZsZs1s6HKUGaZF0Ag2rKluat5ULmcrjyLjVsnGOAyZXv/68t1Aob6?=
 =?us-ascii?Q?ynSjkcX7oLnYE/s8ZaRlXSoKzzO8gMgTXLD5t/Ym6zE94Z9ja1PmlNqIR6yG?=
 =?us-ascii?Q?3mmPhwbOxFMfigfS0siXPNb6rFk+CX0xgbvK0K6TrWHSwCyPnFm73m775wPO?=
 =?us-ascii?Q?1RZ6NRMIgW/iRvpDfW2DgrgBhBUTF8sFYG9peoyTGGuXxZDFJbtfAnzHeHmE?=
 =?us-ascii?Q?/BuWOvpxOqwE2cGnB94J91UjQTIHWvj65XB2dHI3+8+wh6kOjWYumwhHjCQG?=
 =?us-ascii?Q?oKfJ9qK56Jmoxcfud3/vdGgYE3tQK5nDGRifb7YOpD9XWe+9AVpliB7/GkqN?=
 =?us-ascii?Q?5sFAFOoE9VL9jl4vxWJrYQw+Lddfw1WF4U8fHlQotFHxDgY5jcXh/99p/d4j?=
 =?us-ascii?Q?ZzV6aRLtI1PqP4hp2m4gYSSlQcdY+eUabkZmg2FOyPJVrcvaaV+hyo/NOrNr?=
 =?us-ascii?Q?2lYGAJwLAhNd+m0i189UMSmuyAHXDr4OQY6GEEjAsJ7p3bGLLErdrODhtVaz?=
 =?us-ascii?Q?wZMzbR/ioRY+nC1ZZXptt5M9hqmKAnkzgViA4Pt1ZMoLwr3NhtKy?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d1a016d-7555-41dc-39be-08df0cebc69a
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 14:24:49.9231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +IVeCtIQHOqrAchjaMpy3PzhwWwssuJ0JDWUY7HIOilptzkiReVMWLNdRdQAp468FuS9Nqp/HvUOVjkN9yXmoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB7581

ntb_transport_free_queue() cancels qp->link_work but not qp->link_cleanup.
A peer link-down message can queue cleanup while ntb_netdev is freeing
the QP. Cleanup can then requeue link work after the queue resources
have been freed.

Disable and wait for cleanup, then link work, before freeing resources.
Unlike cancel, disable also prevents the RX tasklet and transport link
setup from queuing more work. Enable the works only after queue creation
succeeds.

Clear client_ready first so RX completions and transport link setup see
that the client is no longer ready. Clear link_is_up and active after
the workers stop, since link work can set both back to true.

Fixes: 7b4f2d3c3b82 ("NTB: No sleeping in interrupt context")
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Reworked from the corresponding patch in the direct TX/RX series v1:
https://lore.kernel.org/r/20260810165136.2292436-5-den@valinux.co.jp/

 drivers/ntb/ntb_transport.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index a902fce4ba60..d009bb5bb54b 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -1251,6 +1251,8 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
 
 	INIT_DELAYED_WORK(&qp->link_work, ntb_qp_link_work);
 	INIT_WORK(&qp->link_cleanup, ntb_qp_link_cleanup_work);
+	disable_delayed_work(&qp->link_work);
+	disable_work(&qp->link_cleanup);
 
 	spin_lock_init(&qp->ntb_rx_q_lock);
 	spin_lock_init(&qp->ntb_tx_free_q_lock);
@@ -2164,6 +2166,9 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
 		}
 	}
 
+	enable_work(&qp->link_cleanup);
+	enable_delayed_work(&qp->link_work);
+
 	ntb_db_clear(qp->ndev, qp_bit);
 	ntb_db_clear_mask(qp->ndev, qp_bit);
 
@@ -2209,6 +2214,10 @@ void ntb_transport_free_queue(struct ntb_transport_qp *qp)
 
 	pdev = qp->ndev->pdev;
 
+	qp->client_ready = false;
+	disable_work_sync(&qp->link_cleanup);
+	disable_delayed_work_sync(&qp->link_work);
+	qp->link_is_up = false;
 	qp->active = false;
 
 	if (qp->tx_offload_thread) {
@@ -2256,8 +2265,6 @@ void ntb_transport_free_queue(struct ntb_transport_qp *qp)
 	ntb_db_set_mask(qp->ndev, qp_bit);
 	tasklet_kill(&qp->rxc_db_work);
 
-	cancel_delayed_work_sync(&qp->link_work);
-
 	qp->cb_data = NULL;
 	qp->rx_handler = NULL;
 	qp->tx_handler = NULL;
-- 
2.51.0

