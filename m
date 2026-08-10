Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021142.outbound.protection.outlook.com [40.107.74.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573F0433046
	for <ntb@lists.linux.dev>; Mon, 10 Aug 2026 16:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786380734; cv=fail; b=SsvQ0MpVhW3MEdq08zwdsi2be01oO3O3jUxCT8eNsxLLkjO94x7ZyfgjN725OZHlkz7+xuw6Kns6C1AZv8rE8QxtBoAAD+3wxSTFQ8rz73pU6tIfi02u+KUqYi2Hdm5tJtUQ5PB2VCnJ9wjhcF36rlo0Emzf9w2w5awoKkxmXSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786380734; c=relaxed/simple;
	bh=tW793DDP2yB8gAENdR2zsXfYjasOUkAHRxE1HmnlY50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LPcBhcCTUdDvSMGcpIm4RP3OHBl2DUkboXaf7X98X8kvzIsrS/GTVkN61e1LloA+Nl8tKS5O50Vr4ph/SLl915JzHd/muWSwZf2mrW7R+sgEuzgrQIHgAJUG5T5eLSghs/33EEPU3DhnR5bd/3BvXwdNp1II3VzPlSiNbgjAADA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=VeDwRPfq; arc=fail smtp.client-ip=40.107.74.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="VeDwRPfq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HkxJaeVII8TffP9F8Fthm3TvCnVwaCjBKA1OPu8aJLDTiKX+zx7wAKPMq0YWLuUsyCgC18GvFORTR4jhrFMiaekhh5GN6x2oK9C6LJenEpJWgImVlyS4cEX5fsoSgIAUSqfo1WqAPV34KCL2elYj2oYyEfIBUdrumxSAiJ132YP5wwn0TNTYOZHMJus9SZmr2hhAPgmV5WZmcQe6EI8n2liEzPDsdg6EPX4vdYBabzFMJZoqLeEw6/ri2sptYQgIZ3FkXbpvlO5nS3rx+0mdDNqoO39kW8tRx93/LokJOpRCME12C8jUqWQJGDKJfyMXQt40RAnkxDW27dkFIr1XtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zNTM/hnEVqi3ooNEbhEBOauvl7Lj6Frz6VO5wdHcyeY=;
 b=lhRfyJnUlwD3CiQpxEZB+H29Lb6WdU0hDRuDWWxUlhTOUlfjPOQe++dS8u9bstSQOeWH3Q8fmP/nBHfSReb6luG/3P4LnT2JC+QodPZ8Pl2Ak5VQMj+EqJ+6gwrySXRfT1hpYAI0uiTp7mPbKwIzL/HKd+P3A1V8xrdwgcrpaaVnWTGMw7j8/Q37H3PlKMUx7S7C3Pijp41NB9ms45V9469f40z43QKjmo1cu3RosiIiuy7isorpsUfD8TJ2CYYG/GH9Ga0zqqgxCLSRp4PtrbBI97HBH8zVFrfvA6TyQXt8GzJCWIPEq6um5VlQYD0XGSfwr6cgOJ+0qqHOAX2bMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zNTM/hnEVqi3ooNEbhEBOauvl7Lj6Frz6VO5wdHcyeY=;
 b=VeDwRPfqa3XKefKTP/hiOrWvJOpcTIDGMHm1o4Llzfkt3zFIY/jeYh9o7qFtx+rpaBbCEwimj2gi27bW9AQcPyNHL7MGyv08qA+usdOK01RHQAHPLvhGMgMbF4Rw2pTEYn/YnjsR22L9eLbZQvmhv30ArtTt7TL8XzuXEn0PcWQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB6729.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:42d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 16:51:54 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 16:51:54 +0000
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
Subject: [PATCH 13/16] NTB: ntb_transport: Implement safe direct-DMA teardown
Date: Tue, 11 Aug 2026 01:51:32 +0900
Message-ID: <20260810165136.2292436-14-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260810165136.2292436-1-den@valinux.co.jp>
References: <20260810165136.2292436-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0135.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::19) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB6729:EE_
X-MS-Office365-Filtering-Correlation-Id: 60990c79-3d94-4b41-57e1-08def6ffaea7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|23010399003|376014|1800799024|366016|6133799003|5023799004|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	cI2Wp5cPlHw45lmNB2zbnGJPfROyvLhzsVuE2mJoJ/TAkhfMiA9iovW9M4BhcFKzmkmHkco8Ql3HYSJ68vX5nE7TIRF0CFfl9PyLmfeDWxOjkIp3lgpPMzWKQmsPD/PD+lyiww2bTgqeL5yWfcBwEa9zDiDnFWvvVoTHgenaZvfvy442liLHX2U5QTE1PkGr6FaIIQ52hMy+zfEj2YlcDi3IfY7s9Foqh3hTvEyfW8MDVwKdEtN+Bcr5p9uiRR6dBtFD//0k1XPNpO+mZwYVyiJXBf20i/98Gs6K2RYczTeBS0HAmeQiIG0GqM6mM/+Bn/2a380tpdG9LxZIK1aqwuIhCP37rgPk1i7m++EmgE9ch4dzjkoa+qpW1698zmbYf9sfVJKVGes9qf2L7OrQN2njcCIZvrBr81TDwjeuWSGkfoB1PYMeE7u3rfqaXfdm04YtXkDT86VXukI4eMK3lIBu/P3yRGjDU56SYnh4ympl2zwVIBKVM033ex1NaYV8+pjlzJgfKfzxzJ/vJVABwviCwJas2bdpauMY0IJPVul4bSGo0gIEU9sW29GdYRUq002cN/FETI5LTzm/IE7MaGqm4GH4zreuHgHALy6rNgiabqMsFqBA7X9xKO0LiWs6fXJ44BR7bkPfaNLhjbq0t0gR933cSQfYIGf49AxRIgM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(23010399003)(376014)(1800799024)(366016)(6133799003)(5023799004)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7Sai/8+RaIxVp6mTWdZX5FgVlOFaEbAydfOsIPd7g2o/05pIgIXwNxZDTHYY?=
 =?us-ascii?Q?M6u0ND3BfvqgHpv/CJ8Zyb2+QDlO1TGuTxtprkXgmjNGyGik8i9lYHKPXzJt?=
 =?us-ascii?Q?ANkgRq3+KyjudnnPS0YhTpAcHk8BGSoMT/8qkYCTmG3V6K6kYRcoFIoX/VuU?=
 =?us-ascii?Q?di8Huib7WzQeK0aYJ7SM3FG78GB/TkvXxG9FmlJT/M/A+qPdPaPIhAXsd8RX?=
 =?us-ascii?Q?+yyLHs8AQBwS57rAcafT//jW+3l/RY36zBwmXNLDN1qeM2hdnCb8qXaCLB8U?=
 =?us-ascii?Q?2k3521s95Hz7FWhN9zLi9nbzAILrxf7GdALJywD4crdWto3LmgnjxyuHYPio?=
 =?us-ascii?Q?1Pv45QPXny21OAo8buNi7uTsBmphu0GKC+QsoH/w9Hd7LWPtFVByLphuXgwm?=
 =?us-ascii?Q?+1+Q5nfux6ccrt34eQsxPLN7w4BPW2lx1cSnOaZNG+KHKtmzUGWxzkBi+Ceo?=
 =?us-ascii?Q?W22pAN4BY+6azKcM5Uiz4vaTpmcDgga45hCVarRvtQF2ThGzA78pV33fhsF3?=
 =?us-ascii?Q?N1jpletr7gf3CyqC8AuzR1/HbZmF2idk5E+f6WAQbc2DCF8FdSaEp9sktBce?=
 =?us-ascii?Q?9c4zJAnpKRFZkpcLLIwXMiUaMRgdJKIbNJkA4oXVFrPeN8q+7IdGsUZ5dGqq?=
 =?us-ascii?Q?5lmicpIGTrm5JpSDJ2lNwkzwTh93bj0tQ24ViDkw7DPl2dxtUBZ8VMGUyMPk?=
 =?us-ascii?Q?pNaEN6C4M2pH2I7Sj9xBIKLX+0IcimizEmPoPyXisn3XDs6oVsiKYfY1BJ+1?=
 =?us-ascii?Q?N2T6aOeHM1Zy7fP64I/CSK6E9CtFL1qzNbQ3MN0zSaayL/+9eDocyNiyW2DB?=
 =?us-ascii?Q?1BnczM/pHBjhP2a5USm73KDKmi78gy2NSUF94xuaIZ0UAu86aUGo0D4yVjDy?=
 =?us-ascii?Q?OvCLWTl1GsDazkTugBXH8RFDlK5htQRZcfG2RwqBJA83c/iSSd/S350g+bsA?=
 =?us-ascii?Q?bSzBhehualzf4l9iSc0HUJ4btFZSzYmtVvQgDNwftudZUxmTPLTaqT6c6SeU?=
 =?us-ascii?Q?ylSScYPDOi7BCnVEyhm+CaFdv227YoUfRIcT7QjzV15p0NfD2U013rRDe7FV?=
 =?us-ascii?Q?BfJbLz9+Gbkv42iOlQ3Pztg+b60mHO5uYfGPcrXuLxXTKnLuC1sh9lwA3Uzg?=
 =?us-ascii?Q?jvpQphTCzJ0fKv94PPeCdJkwaxWFbVPqJDRTM3FmiuI/+c4b/QRdXaldfHil?=
 =?us-ascii?Q?jkXoSAHmynNylEVbKZR2iqO7fT/B/KuPbgNxsHCgmUvNeDlXOiilpfIW6Pje?=
 =?us-ascii?Q?8dAJ0jaMxmUyQES6Nc35Y0qdNGDoorC997vFpO84kfQx9zdCkeFerzWvk/Ff?=
 =?us-ascii?Q?RlDkht1H61ZyDDop4k/1W7i6V/flUl4RWA0LXjJIIBAql12Vqp4qon9ZoonT?=
 =?us-ascii?Q?oRnXMvyU+hDQP0VhxEuiXH7XSTNkbFFcTCeJoTmzSQSV0Vrr8vKPkcTCjvlQ?=
 =?us-ascii?Q?1AsIuC+jMUPxpiwAygvh6XYtEROUXTQ7F1JlvFW0o9nPzOmTOCjFj8qtYk14?=
 =?us-ascii?Q?cGrZw3wuIAMwh0yoaJFsCqcYxcdMHUh/wNf6Z26BBbWD5ZxSJEof1XMcORLr?=
 =?us-ascii?Q?unrRpHorFoAs+DEHPKmUeciFSB9TsQtbXfwPrtJt0lGH/QtrqdxvwGFOVe9M?=
 =?us-ascii?Q?ubWJL8j+mlabyC/4SbanSMiulvl0c6iyEDaauDTIZd4/6ff/mWoUOGsxGjHx?=
 =?us-ascii?Q?/I/KQG6CS/nnnjJQ06qUsdYdDpdeE+0B/Q3dH7Ut1xFCCyQZDY+SPnGJ7o2o?=
 =?us-ascii?Q?zafZtV4ZPUnxM3zPvCxllsxOEF5CVSsYlwjh5jyRrBHoWOIHigX3?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 60990c79-3d94-4b41-57e1-08def6ffaea7
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 16:51:54.0968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XBVfS4ksqnqRzIYTKp5htkusGfI9IYhePD7p4KVFV0IgIku/tiZYauvunXJ24t1nqkQW5q+gZB9Y8qRZzgWwzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB6729

A logical link-down does not prove that local DMA or the peer has
stopped using direct mappings. Releasing them can therefore allow DMA
access after unmapping.

Serialize quiesce and keep mappings until both directions reach their
final issued boundaries. On DMA failure or physical link loss, stop and
synchronize the local channel first. If the link remains usable, send
error completions on that channel before releasing outstanding mappings.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/ntb_transport.c | 205 ++++++++++++++++++++++++++++++++++--
 1 file changed, 198 insertions(+), 7 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 4c4741b8f9b1..f2fa145994b9 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -225,6 +225,7 @@ struct ntb_transport_qp {
 	u32 direct_peer_session;
 	enum ntb_direct_state direct_state;
 	bool direct_tx_failed;
+	struct mutex direct_quiesce_lock; /* Serialize direct teardown */
 	void *rx_buff;
 	unsigned int rx_index;
 	unsigned int rx_max_entry;
@@ -569,6 +570,19 @@ static bool ntb_direct_tx_idle(struct ntb_transport_qp *qp)
 	return qp->direct_tx_issue == qp->direct_tx_cons;
 }
 
+static bool ntb_direct_peer_restarted(struct ntb_transport_qp *qp)
+{
+	struct ntb_direct_shared *shared = qp->direct_shared;
+	u32 peer_session = qp->direct_peer_session;
+	u32 session;
+
+	if (!shared || !peer_session)
+		return false;
+
+	session = READ_ONCE(shared->session);
+	return session && session != peer_session;
+}
+
 static bool ntb_direct_rx_drained(struct ntb_transport_qp *qp)
 {
 	struct ntb_direct_shared *shared = qp->direct_shared;
@@ -611,6 +625,8 @@ static bool ntb_direct_control_pending(struct ntb_transport_qp *qp)
 	       READ_ONCE(shared->quiesce) == session;
 }
 
+static void ntb_direct_tx_terminate(struct ntb_transport_qp *qp);
+
 static void ntb_direct_control_publish_locked(struct ntb_transport_qp *qp)
 {
 	struct ntb_direct_shared __iomem *peer = qp->peer_direct_shared;
@@ -664,9 +680,13 @@ static bool ntb_direct_control_progress(struct ntb_transport_qp *qp)
 
 		if (qp->direct_state == NTB_DIRECT_HANDSHAKE && peer_session) {
 			qp->direct_peer_session = peer_session;
-		} else if (qp->direct_state == NTB_DIRECT_ACTIVE && peer_session &&
+		} else if ((qp->direct_state == NTB_DIRECT_ACTIVE ||
+			    qp->direct_state == NTB_DIRECT_QUIESCING) &&
+			   peer_session &&
 			   peer_session != qp->direct_peer_session) {
 			qp->direct_state = NTB_DIRECT_QUIESCING;
+			cleanup = qp->client_ready;
+			goto out;
 		}
 
 		if (quiesce == qp->direct_session &&
@@ -714,13 +734,28 @@ static void ntb_direct_session_start(struct ntb_transport_qp *qp)
 	qp->direct_state = NTB_DIRECT_HANDSHAKE;
 }
 
+static void ntb_direct_begin_quiesce(struct ntb_transport_qp *qp)
+{
+	if (!ntb_direct_link_capable(qp))
+		return;
+
+	guard(spinlock_bh)(&qp->direct_lock);
+	if (qp->direct_state == NTB_DIRECT_HANDSHAKE)
+		qp->direct_state = qp->direct_peer_session ?
+			NTB_DIRECT_QUIESCING : NTB_DIRECT_QUIESCED;
+	else if (qp->direct_state == NTB_DIRECT_ACTIVE)
+		qp->direct_state = NTB_DIRECT_QUIESCING;
+}
+
 static void ntb_direct_quiesce(struct ntb_transport_qp *qp)
 {
-	bool done;
+	bool link_down, peer_reset, terminate, done;
 
 	if (!ntb_direct_link_capable(qp))
 		return;
 
+	guard(mutex)(&qp->direct_quiesce_lock);
+
 	scoped_guard(spinlock_bh, &qp->direct_lock) {
 		if (qp->direct_state == NTB_DIRECT_DOWN ||
 		    qp->direct_state == NTB_DIRECT_QUIESCED)
@@ -734,7 +769,16 @@ static void ntb_direct_quiesce(struct ntb_transport_qp *qp)
 			return;
 		}
 		qp->direct_state = NTB_DIRECT_QUIESCING;
+		link_down = ntb_link_is_up(qp->ndev, NULL, NULL) != 1;
+		peer_reset = ntb_direct_peer_restarted(qp);
+		terminate = qp->direct_tx_failed || link_down || peer_reset;
 	}
+	if (terminate)
+		ntb_direct_tx_terminate(qp);
+
+	/* A peer starts a new session only after draining the old boundary. */
+	if (link_down || peer_reset)
+		goto quiesced;
 
 	/*
 	 * Keep the mappings until the peer acknowledges the final boundaries,
@@ -743,16 +787,31 @@ static void ntb_direct_quiesce(struct ntb_transport_qp *qp)
 	for (;;) {
 		ntb_direct_control_progress(qp);
 
-		scoped_guard(spinlock_bh, &qp->direct_lock)
+		scoped_guard(spinlock_bh, &qp->direct_lock) {
+			peer_reset = ntb_direct_peer_restarted(qp);
+			terminate = qp->direct_tx_failed || peer_reset;
 			done = ntb_direct_tx_idle(qp) &&
 			       ntb_direct_tx_acked(qp) &&
 			       ntb_direct_rx_drained(qp);
-		if (done || ntb_link_is_up(qp->ndev, NULL, NULL) != 1)
+		}
+
+		if (terminate) {
+			ntb_direct_tx_terminate(qp);
+			if (peer_reset)
+				goto quiesced;
+			continue;
+		}
+		if (ntb_link_is_up(qp->ndev, NULL, NULL) != 1) {
+			ntb_direct_tx_terminate(qp);
+			break;
+		}
+		if (done)
 			break;
 
 		msleep(NTB_DIRECT_TEARDOWN_RETRY_INTERVAL_MS);
 	}
 
+quiesced:
 	guard(spinlock_bh)(&qp->direct_lock);
 	qp->direct_state = NTB_DIRECT_QUIESCED;
 }
@@ -1521,6 +1580,7 @@ static void ntb_transport_link_cleanup(struct ntb_transport_ctx *nt)
 	for (i = 0; i < nt->qp_count; i++)
 		if (qp_bitmap_alloc & BIT_ULL(i)) {
 			qp = &nt->qp_vec[i];
+			ntb_direct_begin_quiesce(qp);
 			ntb_qp_link_cleanup(qp);
 			cancel_work_sync(&qp->link_cleanup);
 			cancel_delayed_work_sync(&qp->link_work);
@@ -1828,6 +1888,7 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
 	spin_lock_init(&qp->ntb_tx_free_q_lock);
 	spin_lock_init(&qp->ntb_tx_offl_q_lock);
 	spin_lock_init(&qp->direct_lock);
+	mutex_init(&qp->direct_quiesce_lock);
 
 	INIT_LIST_HEAD(&qp->rx_post_q);
 	INIT_LIST_HEAD(&qp->rx_pend_q);
@@ -3007,6 +3068,118 @@ static int ntb_direct_tx_submit(struct ntb_transport_qp *qp,
 	return rc;
 }
 
+static void ntb_direct_tx_stop(struct ntb_transport_qp *qp)
+{
+	struct dma_chan *chan = qp->direct_dma_chan;
+	int rc;
+
+	/* Do not release mappings until the DMA channel is confirmed stopped. */
+	do {
+		rc = dmaengine_terminate_sync(chan);
+		if (rc) {
+			dev_err_ratelimited(&qp->ndev->dev,
+					    "QP%u direct DMA termination failed: %d\n",
+					    qp->qp_num, rc);
+			msleep(NTB_DIRECT_TEARDOWN_RETRY_INTERVAL_MS);
+		}
+	} while (rc);
+}
+
+/*
+ * A CPU MMIO completion could pass an earlier DMA payload. Once the failed
+ * channel is stopped, publish terminal completions through that channel too.
+ */
+static bool ntb_direct_tx_publish_error(struct ntb_transport_qp *qp,
+					struct ntb_queue_entry *entry,
+					u32 idx)
+{
+	struct dma_async_tx_descriptor *completion;
+	struct dma_slave_config config = {
+		.direction = DMA_MEM_TO_DEV,
+		.dst_addr = entry->direct_cpl_addr,
+	};
+	struct dma_chan *chan = qp->direct_dma_chan;
+	dma_cookie_t cookie;
+	enum dma_status status;
+	dma_addr_t src;
+
+	qp->direct_tx_cpl[idx] = NTB_DIRECT_CPL_ERROR;
+	dma_wmb();
+	src = qp->direct_tx_cpl_dma + idx * sizeof(u32);
+
+	while (!ntb_direct_peer_restarted(qp) &&
+	       ntb_link_is_up(qp->ndev, NULL, NULL) == 1) {
+		completion = dmaengine_prep_config_single_safe(chan, src, sizeof(u32),
+							       DMA_MEM_TO_DEV,
+							       DMA_CTRL_ACK |
+							       DMA_PREP_INTERRUPT,
+							       &config);
+		if (completion) {
+			cookie = dmaengine_submit(completion);
+			if (!dma_submit_error(cookie)) {
+				dma_async_issue_pending(chan);
+				status = dma_sync_wait(chan, cookie);
+				if (status == DMA_COMPLETE)
+					return true;
+			}
+		}
+
+		ntb_direct_tx_stop(qp);
+		dev_err_ratelimited(&qp->ndev->dev,
+				    "QP%u direct DMA error completion failed; retrying\n",
+				    qp->qp_num);
+		msleep(NTB_DIRECT_TEARDOWN_RETRY_INTERVAL_MS);
+	}
+
+	return false;
+}
+
+static void ntb_direct_tx_terminate(struct ntb_transport_qp *qp)
+{
+	struct dma_chan *chan = qp->direct_dma_chan;
+	struct ntb_queue_entry *entry;
+	struct device *dma_dev;
+	bool notify = false;
+	u32 idx;
+
+	lockdep_assert_held(&qp->direct_quiesce_lock);
+	WARN_ON_ONCE(ntb_direct_tx_enabled(qp));
+
+	if (!chan)
+		return;
+
+	dma_dev = dmaengine_get_dma_device(chan);
+	ntb_direct_tx_stop(qp);
+
+	/*
+	 * QUIESCING blocks new submissions, and terminate_sync() has drained all
+	 * callbacks, so this function exclusively owns the issued queue.
+	 * Therefore, qp->direct_lock is not needed while draining it.
+	 */
+	while (!ntb_direct_tx_idle(qp)) {
+		idx = ntb_direct_ring_idx(qp, qp->direct_tx_cons);
+		entry = list_first_entry(&qp->direct_tx_q,
+					 struct ntb_queue_entry, entry);
+
+		notify |= ntb_direct_tx_publish_error(qp, entry, idx);
+
+		list_del(&entry->entry);
+		qp->direct_tx_cons++;
+
+		dma_unmap_single(dma_dev, entry->direct_dma_addr, entry->len,
+				 DMA_TO_DEVICE);
+		entry->errors++;
+		if (qp->tx_handler)
+			qp->tx_handler(qp, qp->cb_data, entry->cb_data, -EIO);
+		ntb_list_add(&qp->ntb_tx_free_q_lock, &entry->entry,
+			     &qp->tx_free_q);
+	}
+	qp->direct_tx_failed = false;
+
+	if (notify && ntb_link_is_up(qp->ndev, NULL, NULL) == 1)
+		ntb_transport_notify_peer(qp);
+}
+
 static int ntb_process_tx(struct ntb_transport_qp *qp,
 			  struct ntb_queue_entry *entry)
 {
@@ -3287,9 +3460,12 @@ void ntb_transport_free_queue(struct ntb_transport_qp *qp)
 
 	pdev = qp->ndev->pdev;
 
+	ntb_direct_begin_quiesce(qp);
 	cancel_work_sync(&qp->link_cleanup);
 	cancel_delayed_work_sync(&qp->link_work);
 	ntb_direct_quiesce(qp);
+	if (qp->direct_dma_chan)
+		dmaengine_synchronize(qp->direct_dma_chan);
 	qp->active = false;
 
 	if (qp->tx_offload_thread) {
@@ -3525,22 +3701,37 @@ EXPORT_SYMBOL_GPL(ntb_transport_link_up);
  */
 void ntb_transport_link_down(struct ntb_transport_qp *qp)
 {
+	bool direct;
 	int val;
 
 	if (!qp)
 		return;
 
 	qp->client_ready = false;
+	direct = ntb_direct_link_capable(qp);
+	if (direct) {
+		ntb_direct_begin_quiesce(qp);
+		disable_work_sync(&qp->link_cleanup);
+		cancel_delayed_work_sync(&qp->link_work);
+	}
 	ntb_direct_quiesce(qp);
 
 	val = ntb_spad_read(qp->ndev, QP_LINKS);
 
 	ntb_peer_spad_write(qp->ndev, PIDX, QP_LINKS, val & ~BIT(qp->qp_num));
 
-	if (qp->link_is_up)
-		ntb_send_link_down(qp);
-	else
+	if (qp->link_is_up) {
+		/* An established direct session uses QUIESCE as link-down. */
+		if (direct && ntb_direct_tx_acked(qp))
+			ntb_qp_link_down_reset(qp);
+		else
+			ntb_send_link_down(qp);
+	} else {
 		cancel_delayed_work_sync(&qp->link_work);
+	}
+
+	if (direct)
+		enable_work(&qp->link_cleanup);
 }
 EXPORT_SYMBOL_GPL(ntb_transport_link_down);
 
-- 
2.51.0

