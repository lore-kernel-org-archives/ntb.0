Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020135.outbound.protection.outlook.com [52.101.228.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFF23A6EEC
	for <ntb@lists.linux.dev>; Thu, 10 Sep 2026 04:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789013336; cv=fail; b=pfEufofF43iGL1SQgY93t2FiShHFw4AxWFzNlqhb/GGGKU78DQf2oBTVbspcq5/+yN9LYxQM/tyNobvn86dA2Zxqonw/fVTZfgiJOP6WJP7YdRm8UDYxiVlU2/WqatkzEbZFyAnQeYSUUB+fdjlxiLPlfYOd9jE3G3sAR1P169E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789013336; c=relaxed/simple;
	bh=t7I8fVnpB5Wc0xlzCYA58hqpSkGrBihJSuIxLM9nCcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NQNr6h2fGyCprDav0Mt6Xghdiy4teUorGvaumz+iVTVtZDOtfyOF1c8jYPkTHQ6s1p1W4jRlyyrDevOFzApswbVYc1x3ApOsvSTsCRV9bWdV2Ymg386QUCWTZMzleQKaUHbN3oc1K5u/Hz1CE+3CYZ5KR2GZBPpJ6EeHE+T+fTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=rQqTVU0H; arc=fail smtp.client-ip=52.101.228.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="rQqTVU0H"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BubfPSHOjKnRsTdXRGp3I+ykD0LmPV18mJAvwZOUZSGgykUuKnB1VwAAPRX1xRoCwaYjMcARs7lPYC7NX88DjsQFavTxumptfSNkW5Xa9MbWQCzJuMdN8amr5M+QPRlp3V+dRZz7Dc6mcmbsASUZbZDbVIMFH/a+yUWrPQ+YABo41LKeufkUlG1ZgGT0Jw4+kxijM58yoN5gdfl+JnA4zSpb8w5YWFMdVAv86xylvu+mlIM5NXR6EJ3LVxw2Ocp8rA4/fFAPkyrXAjjsZR8VKoefUW6gD9HNS0a3i2BXzaS8Ow4C1zvKEX1hiyYaXUqCB8XJ2OXFDtcIm3KLhJNmbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YTfUZPGfiTJ+CcOybKp5r0lSkC7KQRZjUSlfLYpgGvk=;
 b=Dq+z8tAihz2y8986Bv9wrxAlgxEECjK3sbw55h1oJDL3XW5IjvJvhvCiB/y1N5L97QLGov280eJoDAriesQn2f8NSRj36rCP5L5IIiPPNFzuQtD1Dr8jQY6UnnRn9bix7SbUqXSiE/adWZ4SjMGP+IdbB5nmm/nreVpl2tHYn+YAoovMlYdAhCZLeqt6fm/JD3oKvkF6SxSsTCFlxqdrtzSoIeFotFPbQy8yMj1lkpcrlOFSOTDBDZgLHPdQfEDYRP6mBZxVETTzao/A7c94sn2HfwR+E/kwr4ED3L7RXJvY3rQzlSeXlA7Gon8h+L8j/4vLAEQPWtf/1mi2xDBX0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YTfUZPGfiTJ+CcOybKp5r0lSkC7KQRZjUSlfLYpgGvk=;
 b=rQqTVU0H6ijohbrKOFr0mDllpiDhEZhwXlbMhKTSuDPJu16wb6RGW2DbBEsOCaTtudrkdn8vs38dnUCaJgAxnQga/6CroeUPAZfcf6QOjk+h8EXcty/fXuWtwwJfBN0dQI+kmxPCUuzG7g3kwytTZGWyaFcDlbgffotGUPAmN7k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYWP286MB2220.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:13f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Thu, 10 Sep
 2026 04:08:45 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 04:08:45 +0000
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
Subject: [PATCH v2 04/14] NTB: ntb_transport: Publish link state after QP setup
Date: Thu, 10 Sep 2026 13:08:26 +0900
Message-ID: <20260910040836.3792333-5-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260910040836.3792333-1-den@valinux.co.jp>
References: <20260910040836.3792333-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0179.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::7) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYWP286MB2220:EE_
X-MS-Office365-Filtering-Correlation-Id: d9e478c4-1d3b-4bd4-639d-08df0ef134ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|7416014|366016|10070799003|22082099003|18002099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	5kn9GivdlWKBXiumFRTgL55xPzAtW+Ge0J6vZep7PGfeGKVTHSFVlL0bOA3pl1SQ6Rm2eaMiFAUHTvt7v9O8BbiT7weqs+C/os2/8BYwc2FVe10dbkKzl7eA9Tfpw/IVHOo42R7XZLqUcslUIzqK47uNGX6njbBAwmYGphcRXXo2QusBE18lF6jiCrVWQg1TP6RdyWcuptFDnvfgW6Mm0EeJUFooRKrPImjfaDdSBSP2562ofbIMsr3rrjoh7a/lG5Guxt/zuZU4ycpnUmsudhAU7m93V1KxCSWbWzNVurLUt4A6Qi5/naIE1xmuVP8zV7LTx6E/tBXQp3dCdgVg2HoVe4m0GHDNQ8aMCTcMM8j7ALUk34c4NjSQyH2puwJsccFaVUnK0yn+IP2oS5LqR9KH+P7pFBe1jWPkJpABcLt3sOwHFSSGswHCO5EyQUqrmbB4XkO/OnVrqHkb7JtWB8qktje4XYo8hA3SlCR8LH+bIAgz0aFPYGho39S7eoxRQmURB9qrYoaw741ohejY2LNI0stpdvUA7irpEIriuXUuaU/l7HI0SAIDzN5FJY6HEjv1sFh9QeoDSQu7AhPOCz/AI8FaqvLUEG7seHZaWPWFP6ix6De2Y9nCc9uKdrz72X/mojWVMLeWmmXtIJMriMdZGIv7GEBpzwgHbWRtfCI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(7416014)(366016)(10070799003)(22082099003)(18002099003)(10067099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5WhcQXvhb0hcWgw5JMEHdn/nqgJrZrQJZF2MRwrSyRK4j8Prv3arDX4Z5+Cc?=
 =?us-ascii?Q?FVictRSz6cwiEEtokU/PbAmNE6Y+SK6ItD9ewmPX0tJjcmH5x9wbCah3vK0W?=
 =?us-ascii?Q?8kJ+hdCiD4Azv4nF4MU9O81wX+C2yVIiJmL8Cdscp4LJ0o5kFBnOBsx4UMcl?=
 =?us-ascii?Q?nVgv+huaiRq7BPA5C0t173EwX+YZNv73z8B06hAFAcnqo49LsQG2V2y8RR7D?=
 =?us-ascii?Q?C+ajXyUJN+zY550KWy6WZYMtjz/dzvL2oIGd6E/5tw+TX3x/igdCuIdJ/5Y8?=
 =?us-ascii?Q?vJoQARP6nD01H0c6DsgzuRLuPi2xhStI3uUTjg2g1XCFn/XSsPSchIEqYSJC?=
 =?us-ascii?Q?MlZvVaU79pHa887tRU3l1d3pjDZLvKkUm6Wg8b65Mwm08oY6iKy5dWKolQ5X?=
 =?us-ascii?Q?pXoTfmuZ5rDOxmS5lYjBIu8h+2e7FfQKmq66ZlSA4u40mzN36bP4yc1IdIz6?=
 =?us-ascii?Q?dEKY0F2dksSmcOQv1gNXG1LfjjqH/FEyouP5mF2MhEFIWSHqtz1YLXrEsMEX?=
 =?us-ascii?Q?NqYCiDH0+zvCrNYGRoWVk/pm7Gt6OM3RYeqqsrgVVeWe0YbGDsrW+Kd05sO3?=
 =?us-ascii?Q?cO7F5LWYxmGcjjgZkhg1+astp94EXokVrEwEJWK8pkZe0LDbGB/Lqx/YiD/H?=
 =?us-ascii?Q?h2yqo22aWL20nI3UeE6P/N7vk0haLuTYketHcNsallduE/wQdJQVR9OuzjzA?=
 =?us-ascii?Q?zRDaXQXSooDcttVAPUif9gpoHzVHKqULrxoAy7YGlSJrVYPnpV9Oc3zlwos+?=
 =?us-ascii?Q?qRh2gDnUIlNI7p2dItDpavQ1O4UMQT4eTUi84401PXVWfMhdV53SYXBZic6A?=
 =?us-ascii?Q?Z5I9hG/ArmnyRMg1pN+Cx5OsSPKngM3Kj5CwWf1s42+ezQij9y+RzQxLKi1q?=
 =?us-ascii?Q?a1JOtZm6xKuBy2la+vNpcnF4KNzxCMtmOxsI7mqFwb33p/T9XejV+QvpScfr?=
 =?us-ascii?Q?nO3+bSpZvQ8CJVrSG/qsAMfG5dWUYWZmSpDymOvbn2+XhzmoQcLxWRId1EBk?=
 =?us-ascii?Q?gm5KvIfJK2sfVdrFRcNMaXaQ+VtrGdYPaT9gnkefb1/w5q3zDoW6tc7wZ4pf?=
 =?us-ascii?Q?m/JOqvSe80dneUxS1Z+88JKSkahpcW+eYg6QV69Z9jmMAxwi6Ts9pgC2teI6?=
 =?us-ascii?Q?jV0mj17F0EzNZiyNLKRyexwsyTEKYQFt0IIqKq3nlpMRT3AY+1DbMLa/Ry85?=
 =?us-ascii?Q?y22r/ejHXNlZOBbCVFGu6GR2zduI7ZtS5qEh7Yy2AyP8wcgrqPpTjFxKSrC4?=
 =?us-ascii?Q?TA2HpxLWdqzyCKG6Y6FgyJFUMtpqtDmKtWJ9D/8HsJ0DVQ/cssREuNtCjqHr?=
 =?us-ascii?Q?laPix3jWX1rxt5htaAXLg1bvITv2OsTzRez5TS1WxVMs3Js9ATh77gv4kyph?=
 =?us-ascii?Q?ki9y7cpEzV4eLeWMzSDe6l66QN4eB5bFeM49dMCwjbxa3a95/8P8zvMuhkQo?=
 =?us-ascii?Q?CFUummPw5pnlaJeADh3NwambORwJjlzlXqjeNmPBa1XFI2KWKkep1PG3vSOE?=
 =?us-ascii?Q?RTTamFf0sjL+jSJvhlf4ihoBUrPhn7zsmu4pWA22NdoWdSrbeIG5dTX93o3m?=
 =?us-ascii?Q?US4xZ4Ljk7A295mUrMcYyNFNDZmOKU6x+ooxl7uMAWzEV70diJw2tAVqfiTo?=
 =?us-ascii?Q?Sgs1LrDSrlg93PSPjSbY9Y/oRaqI6MKjlscVsLeYyhMry9IHK6xHQzaAkEHx?=
 =?us-ascii?Q?+p1T8zmFrN7mcTx57gyaw6MvrXKaTmYCCOnC4SwZy0M77msuBV7ePga2OgXh?=
 =?us-ascii?Q?7tEvtved0+WZSSMLz49qRBl9zn28wa6pS5Papu2G6o5BzOckg1eU?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: d9e478c4-1d3b-4bd4-639d-08df0ef134ff
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 04:08:44.9785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ZTcdc6VTjHs1YI8qQ8h2PFutXULvQ6L3B5jD963ZN4QfAH04JThu6KuJEgGpiEt2qlvDevFVcIGynS9wQzsPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2220

ntb_transport_link_work() marks the transport link up before setting
up the QPs' MW and peer MSI state. A concurrent ntb_transport_link_up()
can then queue QP link work, which may enable RX and notify the client
before setup finishes.

Publish link_is_up with a release store after setting up all QPs,
and use acquire loads before queuing QP link work.

Fixes: fce8a7bb5b4b ("PCI-Express Non-Transparent Bridge Support")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/anyKbq3mpLG4y7rb@SMW015318
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v2:
  - No changes.

 drivers/ntb/ntb_transport.c | 40 +++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index c77b173dca01..75d4a2e021f4 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -922,6 +922,16 @@ static void ntb_qp_link_down_reset(struct ntb_transport_qp *qp)
 		qp->remote_rx_info->entry = qp->rx_max_entry - 1;
 }
 
+static void ntb_transport_schedule_qp_link(struct ntb_transport_qp *qp,
+					   unsigned long delay)
+{
+	struct ntb_transport_ctx *nt = qp->transport;
+
+	/* Pair with the link publication in ntb_transport_link_work(). */
+	if (smp_load_acquire(&nt->link_is_up))
+		schedule_delayed_work(&qp->link_work, delay);
+}
+
 static void ntb_qp_link_cleanup(struct ntb_transport_qp *qp)
 {
 	struct ntb_transport_ctx *nt = qp->transport;
@@ -941,13 +951,10 @@ static void ntb_qp_link_cleanup_work(struct work_struct *work)
 	struct ntb_transport_qp *qp = container_of(work,
 						   struct ntb_transport_qp,
 						   link_cleanup);
-	struct ntb_transport_ctx *nt = qp->transport;
 
 	ntb_qp_link_cleanup(qp);
-
-	if (nt->link_is_up)
-		schedule_delayed_work(&qp->link_work,
-				      msecs_to_jiffies(NTB_LINK_DOWN_TIMEOUT));
+	ntb_transport_schedule_qp_link(qp,
+				       msecs_to_jiffies(NTB_LINK_DOWN_TIMEOUT));
 }
 
 static void ntb_qp_link_down(struct ntb_transport_qp *qp)
@@ -1089,16 +1096,19 @@ static void ntb_transport_link_work(struct work_struct *work)
 			goto out1;
 	}
 
-	nt->link_is_up = true;
-
 	for (i = 0; i < nt->qp_count; i++) {
-		struct ntb_transport_qp *qp = &nt->qp_vec[i];
-
 		ntb_transport_setup_qp_mw(nt, i);
 		ntb_transport_setup_qp_peer_msi(nt, i);
+	}
+
+	/* Publish the link only after every QP has been set up. */
+	smp_store_release(&nt->link_is_up, true);
+
+	for (i = 0; i < nt->qp_count; i++) {
+		struct ntb_transport_qp *qp = &nt->qp_vec[i];
 
 		if (qp->client_ready)
-			schedule_delayed_work(&qp->link_work, 0);
+			ntb_transport_schedule_qp_link(qp, 0);
 	}
 
 	return;
@@ -1146,9 +1156,10 @@ static void ntb_qp_link_work(struct work_struct *work)
 
 		if (qp->active)
 			tasklet_schedule(&qp->rxc_db_work);
-	} else if (nt->link_is_up)
-		schedule_delayed_work(&qp->link_work,
-				      msecs_to_jiffies(NTB_LINK_DOWN_TIMEOUT));
+	} else {
+		ntb_transport_schedule_qp_link(qp,
+					       msecs_to_jiffies(NTB_LINK_DOWN_TIMEOUT));
+	}
 }
 
 static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
@@ -2392,8 +2403,7 @@ void ntb_transport_link_up(struct ntb_transport_qp *qp)
 
 	qp->client_ready = true;
 
-	if (qp->transport->link_is_up)
-		schedule_delayed_work(&qp->link_work, 0);
+	ntb_transport_schedule_qp_link(qp, 0);
 }
 EXPORT_SYMBOL_GPL(ntb_transport_link_up);
 
-- 
2.51.0

