Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020079.outbound.protection.outlook.com [52.101.229.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFF0431A30
	for <ntb@lists.linux.dev>; Mon, 10 Aug 2026 16:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786380724; cv=fail; b=i6NxBeDmOR2AxE0U97v+Ka+qPP+Ho9F70hszhOqgKVwyT3mN0QBFZUAgrKix5Hoo4ZmLf3q3WznqKOBarVaBNb+QFENQPAxEFty5RkB7b9V7hsvQGu7LUvCAHLyw8VtlRxyVixm4+FefkLzkr6e/S6FDrkNX+eMXHEY31/f5jDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786380724; c=relaxed/simple;
	bh=CpCcjDftLHkR8gXRi+qjKOwVWnFPrHnj+m7fLqiXSpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jT2RKwGgb8WohM76ULFp+5873RMjXd8anMS03i0Qg4+i+ilEQJqX7SyMje3VDGyIT3tjskVSADWfOrfew3JNJtmhe3t2N2LoGkS7rxb/g4nzYcGOLQE7jOmgKKCjY3cvEyV4EcDI3HrCuxOrDM9TXjS4cD49yizU1CQYXgLb+8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=h/wVIh4a; arc=fail smtp.client-ip=52.101.229.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="h/wVIh4a"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nnxA6KmnR6mceidGVVEBh14gfMLptaq/Xb9iVVO1tqBDM/q0RNk9eaI7refInz3n8dheClnIoHn2eenQ0sgtbpaRra1Al5m6cGeeKS+iJflurAdCqFmp9sNTk3zCxU/EinCf3nekt5PDmmXfPeNBddPIuxy0veeVieT22Kqs9pZiyZI0ZiN3mKXxRK7rdJ6fU9fPmK/6LVqkmT1+Hr6weAOq4YPGtC/8hkzKh17cuIOgBTSBppgpIThYm/fOdPGzlY3zV1Xa5G9XaX+yUJplyzuytPeXnu2m54F8L3aJ4MZf1ue94bYK6X7qaFScoLyud6SwU6q5QaiFoXuGCOa/3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z8TX90sxUjbm0Kx5QSsr+OwW+ZNXGgEXP8nr98PWgVo=;
 b=GNC3fjen38vlRqsplAB/puJddU8TvY19IfTYUlhGTVYbPeGtDC4qjhLEy1lzH27FtYau06AjKcAkdXIgF3hDNEuLxKIoFxHZGwAGa2Ie8DeTAbfprwrFpYjDtU1pvKuHjGGBssun8wfBSmaIZZyEH2MdCwo37FZHdAVxemeOnRHuyLtQswekeB7kFmV+U1BMkXpeBmREyU0kY/JWO3W7GUfIpDO48O1OiCooiWqv//VuWx2Zo32e6skTfivBiKMctgwNhXgTosgATLWPLCMp56zntxOaacVfmUk1ptgMpgWcxvw1ySA9cevP3ZZCcRsyVyt6PqDgxeYTXL9zyXTFfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8TX90sxUjbm0Kx5QSsr+OwW+ZNXGgEXP8nr98PWgVo=;
 b=h/wVIh4aMyLSSMhg/N/awQyKuodcWVMxl891ocU4/H6/ze2lYmtRuLh/V0dLV9QADMhYGfoRUbsRgCskONkEuzDMTIxJHu1cLLojrsrveYAlI35X/VlLN6c6CuVd9SuOgE4KyLUJpMnhGdQfFAIQ6G34aQw/n98JCTYzLEOKuzE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB6729.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:42d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 16:51:51 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 16:51:51 +0000
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
Subject: [PATCH 10/16] NTB: ntb_transport: Implement direct-DMA QP session handshake
Date: Tue, 11 Aug 2026 01:51:29 +0900
Message-ID: <20260810165136.2292436-11-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260810165136.2292436-1-den@valinux.co.jp>
References: <20260810165136.2292436-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0030.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b2::8) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB6729:EE_
X-MS-Office365-Filtering-Correlation-Id: b2476440-5e33-4d7c-9a8a-08def6ffad3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|23010399003|376014|1800799024|366016|6133799003|5023799004|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	iwG/k8faGffEbrBcHtzdBYJdHC7b2G74cj0caoCKwpqa7DuZoSlTL10CeygyeS0rBZD0CwwPKbK9JMOsDSik++i1hEHUcWz8Be+IZFssC6RDCzgHjynDJxPAsLfLgjWxTzlbUQIkzG7yRY8jKWgQHQPODOLZ6uJXpi80nenaUc52kAz7hjqG2FbUHwNQeDXyWtpoK7DXmnAQ5tlBBuuOkODRM9mJsSsbxzEXlrOpiOx1WuJAE42c72LSJ1W7TPZ7S+Wp6VCEPpAd2t87DN8J0CCU2JFeUatUJtBPhWTBgndc0zCcFf3algE8FAwwVbOk5gD+7Wh9LjXwjK/GULdEt87JK0OSoiswz/mNhjJuhsP4lZDYcq+t+RRkJhH77lUNmZoiOc3v7PhRvZi2qBOpx3aowlnD+G1Dwl+LF18Aak+qILadAaskrPg0+0uSzZQuJbP+M623NEBrAM+66Im+zXfaslxODhRGvhexFul2BDFBO9hSiRdqk/KjtOqBxHoX/e9ZOYkZovXArMelUoAIjsYVvZrftI+WQrzTUWhPtJpsYoRkAZtMEz3qKICPZLDG0LLqJfBlgx6jPLP/+iJSoBHlg94HigRjKTOqyN+hxNxM6P0l+TFIhrw3acbdWW/DfhmdABQMxAumA5bOthTRpv9beLG+ZOwjj3Esya1Kh3U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(23010399003)(376014)(1800799024)(366016)(6133799003)(5023799004)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SgpkLKwtnChAHZ8dyPPJGnc0+XSdqkpq48uwVY+z33mok29s1bjsJOT5ln5j?=
 =?us-ascii?Q?UqtXkAolSZkC8XXc2s494PqHxWiPxUGXGNHkqpswdISBFM+nBTN52Gex4B0a?=
 =?us-ascii?Q?9LVrWjkZvPcrvRkIeXXZz5QylZRPxCiwVlYimH6pe6R0zOU/9gsOD4BMuEIA?=
 =?us-ascii?Q?gpG1RkgOEn3XdDz+9rpKygxfYylbnnk27vj8mg2/ReJw1xrT+z7cZWJvvW7g?=
 =?us-ascii?Q?kkJtaxdzCaruofoH9leQj18mtjH9K3gH7IpQ3YU3vdqS9isBkR5kcy1C5faA?=
 =?us-ascii?Q?8urN0T2gNIe7yEHUUgr30/epk9kQhg0pMlsX9kPqwqsdWZ2OAJCK+1lcmL0D?=
 =?us-ascii?Q?X8KkbePxbWPhum2hh++EmqY+zDo0PMr0opxprxo5rp8D3tbK+scPWrgWJ65+?=
 =?us-ascii?Q?YcouZd7fdIPubxubi4prVL+/y11lqJHPTBvQEjQCdzZpvdOhm3ra+ASrvSsE?=
 =?us-ascii?Q?j9WRZaxVhEnvV3R1gYLFZFA7Un5KBfO98eNF/GeJRD3IismCBQnA37LCdRgZ?=
 =?us-ascii?Q?B3CvWAFBpcIme74orGDmcp7oLil5dbSvaKXjsQTLds7/j0/Z35iJCTMUwc4I?=
 =?us-ascii?Q?D8XUBQgS4iBF8jxxLXQ9WGgoGrNK1mCEDOYn4FXHvBvSkl1jje36D8z5BdDR?=
 =?us-ascii?Q?b9J5QrLQCWE9ctbG/nFI53FQ2DyP0Rfp+q44EtEFenKf07XP4AGKi0WVr3kS?=
 =?us-ascii?Q?w6jL7p4k9F4d6D/VeBnr/RkuzIDCq4oaPYLmzgTiK3WCrrEW06hdChzZORcE?=
 =?us-ascii?Q?c/rofWI2LVDKNVVp93TWWcQF40wQx1NL6PjOzcEIxSK+GJpn5BEW2LpgpsII?=
 =?us-ascii?Q?Ehr9eaSxRL2Kc36MeDN8PPr/OMX7zS5fWj2J9C0CKi0WIfZj6OWYc4hnXW6I?=
 =?us-ascii?Q?bZLldW+j7u6l4jPG/nmHcb+HUjHGy2ZctTh/LSsfQ5wlUbcJYLl5cf1IuY8h?=
 =?us-ascii?Q?5A6B/Dzf3zPicVeeCvzriE6yQI7GA6H3miuB5CjRaNWoW4l2diFi/wlciISj?=
 =?us-ascii?Q?JP1oQQjxPVVq6B/ZFSxoh2DIL72mAdEXQBscKIX2LsgKEAKx/phrdzTVq73O?=
 =?us-ascii?Q?wFqcoWQJSLK1ovc0JnETFGysuZV7Uk+i7SwyGqvj4P3KApQ4ws6AuRUg6Jmv?=
 =?us-ascii?Q?vdkM0wJTvAgKaUohRioVJ5T2tJq/s6l2QjV70IQi5eMVP/ysLjpYcwYJMoTh?=
 =?us-ascii?Q?yj8950PmZK8iO+7rMBYP5Mbvmo0rDI4f40YN9vd1gIm7sm9iaReQSHWTPLES?=
 =?us-ascii?Q?JeyhLLRGCRfB+j6ZP+wAoaFR37uHCWtiZGyLbT04AAVGjWcAmf5P0Du/1PUf?=
 =?us-ascii?Q?aFB4lDd2GBqYoieMPotvQrV5QDPD0oSOAlPEaTjx99oog9jesN6auUsZOEsF?=
 =?us-ascii?Q?Pm7dltl4XWcyBKy9KaVMtQhPPlq/MYhsyimgFswfRpXbpOfIZlzlclyhHBfW?=
 =?us-ascii?Q?whS8doh5n76isdRZlNJl9txK6cVkeecpQ7+YdeK9kQRXqv9j58LULIoW40nM?=
 =?us-ascii?Q?zNYaFfvj82Qnd+yGMFWXF0zEcNMsGleYlyPTXSULGNJbBBDx/sYX2sOEQ42L?=
 =?us-ascii?Q?N+pjUI1pdmjsUj12pzu2VNpctZuLYYnGLSsdzazBDyVk3wpA0/2LJwRCTbjH?=
 =?us-ascii?Q?lCMXWgKHDBC2PhowY6+uA5qmNqduZ9fSSSPdtC7dd0yEadKBNG/RU9RSYHJw?=
 =?us-ascii?Q?PXOXKlIgTNsBPBR9Ae0fmzxAtVwtH+yTgCake1svc42lhPOhgyU/iDtu3Xg4?=
 =?us-ascii?Q?5nD9YAR1iSbD+Vm8VA0wpr1qCZpNEKukU9jyFD+fMdEAYr+9IjkO?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: b2476440-5e33-4d7c-9a8a-08def6ffad3c
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 16:51:51.7159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: akhPinwiiUfObwQ0zoYQFdKKxABSGViow8Ai31qmMZhOVkgH0WC5q0g7Wkz0Y+YjuGJvfhroMgLBN25W8cT4Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB6729

A logical QP can be reused while its shared memory still contains RX
addresses and completions from the previous instance. Without a session
ID, the new QP could accept that stale state.

Give each QP instance a fresh session ID and enable direct DMA only
after both peers acknowledge it. Teardown also exchanges the final
issued boundary so RX mappings remain valid until all outstanding
transfers have completed.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/ntb_transport.c | 275 ++++++++++++++++++++++++++++++++++--
 1 file changed, 267 insertions(+), 8 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 67044d0ea0ff..ca08cb690311 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -58,6 +58,7 @@
 #include <linux/limits.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/random.h>
 #include <linux/slab.h>
 #include <linux/seq_file.h>
 #include <linux/types.h>
@@ -153,6 +154,14 @@ struct ntb_rx_info {
 	unsigned int entry;
 };
 
+enum ntb_direct_state {
+	NTB_DIRECT_DOWN,
+	NTB_DIRECT_HANDSHAKE,
+	NTB_DIRECT_ACTIVE,
+	NTB_DIRECT_QUIESCING,
+	NTB_DIRECT_QUIESCED,
+};
+
 struct ntb_transport_qp {
 	struct ntb_transport_ctx *transport;
 	struct ntb_dev *ndev;
@@ -195,6 +204,8 @@ struct ntb_transport_qp {
 	struct ntb_direct_shared *direct_shared;
 	struct ntb_direct_shared __iomem *peer_direct_shared;
 	unsigned int direct_ring_entries;
+	/* Serialize direct session, TX ring, and RX publication state. */
+	spinlock_t direct_lock;
 	u32 *direct_rx_cpl;
 	dma_addr_t direct_rx_cpl_dma;
 	u32 *direct_tx_cpl;
@@ -203,6 +214,9 @@ struct ntb_transport_qp {
 	u32 direct_rx_cons;
 	u32 direct_tx_issue;
 	u32 direct_tx_cons;
+	u32 direct_session;
+	u32 direct_peer_session;
+	enum ntb_direct_state direct_state;
 	void *rx_buff;
 	unsigned int rx_index;
 	unsigned int rx_max_entry;
@@ -509,6 +523,228 @@ static bool ntb_direct_layout(struct ntb_transport_ctx *nt)
 #define QP_TO_MW(nt, qp)	((qp) % nt->mw_count)
 #define NTB_QP_DEF_NUM_ENTRIES	100
 #define NTB_LINK_DOWN_TIMEOUT	10
+#define NTB_DIRECT_TEARDOWN_RETRY_INTERVAL_MS	10
+
+static bool ntb_direct_rx_mode(struct ntb_transport_qp *qp)
+{
+	struct ntb_transport_ctx *nt = qp->transport;
+
+	return (nt->direct_features & NTB_DIRECT_FEAT_RX) &&
+	       (nt->peer_direct_features & NTB_DIRECT_FEAT_TX);
+}
+
+static bool ntb_direct_tx_mode(struct ntb_transport_qp *qp)
+{
+	struct ntb_transport_ctx *nt = qp->transport;
+
+	return (nt->direct_features & NTB_DIRECT_FEAT_TX) &&
+	       (nt->peer_direct_features & NTB_DIRECT_FEAT_RX);
+}
+
+static bool ntb_direct_link_capable(struct ntb_transport_qp *qp)
+{
+	return ntb_direct_rx_mode(qp) || ntb_direct_tx_mode(qp);
+}
+
+static void ntb_transport_notify_peer(struct ntb_transport_qp *qp)
+{
+	if (qp->use_msi)
+		ntb_msi_peer_trigger(qp->ndev, PIDX, &qp->peer_msi_desc);
+	else
+		ntb_peer_db_set(qp->ndev, BIT_ULL(qp->qp_num));
+}
+
+static bool ntb_direct_tx_idle(struct ntb_transport_qp *qp)
+{
+	return qp->direct_tx_issue == qp->direct_tx_cons;
+}
+
+static bool ntb_direct_rx_drained(struct ntb_transport_qp *qp)
+{
+	struct ntb_direct_shared *shared = qp->direct_shared;
+	u32 session = qp->direct_session;
+
+	if (!shared || !session || READ_ONCE(shared->quiesce) != session)
+		return false;
+
+	/* quiesce is written after its final issue boundary. */
+	dma_rmb();
+	return READ_ONCE(qp->direct_rx_cons) ==
+	       READ_ONCE(shared->quiesce_issue);
+}
+
+static bool ntb_direct_tx_acked(struct ntb_transport_qp *qp)
+{
+	struct ntb_direct_shared *shared = qp->direct_shared;
+	u32 session = qp->direct_session;
+
+	return shared && session &&
+	       READ_ONCE(shared->quiesce_ack) == session;
+}
+
+static bool ntb_direct_control_pending(struct ntb_transport_qp *qp)
+{
+	struct ntb_direct_shared *shared = qp->direct_shared;
+	enum ntb_direct_state state = READ_ONCE(qp->direct_state);
+	u32 peer_session = READ_ONCE(qp->direct_peer_session);
+	u32 session = READ_ONCE(qp->direct_session);
+
+	if (!shared)
+		return false;
+	if (state == NTB_DIRECT_HANDSHAKE)
+		return READ_ONCE(shared->session) != peer_session ||
+		       READ_ONCE(shared->session_ack) == session;
+	if (state != NTB_DIRECT_ACTIVE)
+		return false;
+
+	return READ_ONCE(shared->session) != peer_session ||
+	       READ_ONCE(shared->quiesce) == session;
+}
+
+static void ntb_direct_control_publish_locked(struct ntb_transport_qp *qp)
+{
+	struct ntb_direct_shared __iomem *peer = qp->peer_direct_shared;
+	u32 peer_session = qp->direct_peer_session;
+
+	lockdep_assert_held(&qp->direct_lock);
+
+	/* Publish the completion array address before its session. */
+	iowrite32(lower_32_bits(qp->direct_rx_cpl_dma), &peer->cpl_addr_lo);
+	iowrite32(upper_32_bits(qp->direct_rx_cpl_dma), &peer->cpl_addr_hi);
+
+	iowrite32(qp->direct_session, &peer->session);
+	if (!peer_session)
+		return;
+
+	iowrite32(peer_session, &peer->session_ack);
+	if (qp->direct_state == NTB_DIRECT_QUIESCING) {
+		/* Publish the final exclusive TX boundary before its marker. */
+		iowrite32(qp->direct_tx_issue, &peer->quiesce_issue);
+		iowrite32(peer_session, &peer->quiesce);
+	}
+	if (ntb_direct_rx_drained(qp))
+		iowrite32(peer_session, &peer->quiesce_ack);
+}
+
+/*
+ * Accept the peer session during HANDSHAKE. In ACTIVE or QUIESCING, a
+ * replacement peer session or quiesce request enters the local teardown path.
+ */
+static bool ntb_direct_control_progress(struct ntb_transport_qp *qp)
+{
+	struct ntb_direct_shared *shared = qp->direct_shared;
+	u32 peer_session, session_ack, quiesce;
+	bool published = false;
+	bool cleanup = false;
+	bool ready = false;
+
+	if (!qp->transport->link_is_up || !shared ||
+	    !qp->peer_direct_shared ||
+	    !ntb_direct_link_capable(qp) ||
+	    ntb_link_is_up(qp->ndev, NULL, NULL) != 1)
+		return true;
+
+	peer_session = READ_ONCE(shared->session);
+	session_ack = READ_ONCE(shared->session_ack);
+	quiesce = READ_ONCE(shared->quiesce);
+
+	scoped_guard(spinlock_bh, &qp->direct_lock) {
+		if (!qp->direct_session)
+			goto out;
+
+		if (qp->direct_state == NTB_DIRECT_HANDSHAKE && peer_session) {
+			qp->direct_peer_session = peer_session;
+		} else if (qp->direct_state == NTB_DIRECT_ACTIVE && peer_session &&
+			   peer_session != qp->direct_peer_session) {
+			qp->direct_state = NTB_DIRECT_QUIESCING;
+		}
+
+		if (quiesce == qp->direct_session &&
+		    (qp->direct_state == NTB_DIRECT_HANDSHAKE ||
+		     qp->direct_state == NTB_DIRECT_ACTIVE)) {
+			qp->direct_state = NTB_DIRECT_QUIESCING;
+			cleanup = qp->client_ready;
+		}
+
+		ntb_direct_control_publish_locked(qp);
+		published = true;
+		if (qp->direct_state == NTB_DIRECT_HANDSHAKE &&
+		    qp->direct_peer_session &&
+		    session_ack == qp->direct_session)
+			qp->direct_state = NTB_DIRECT_ACTIVE;
+		ready = qp->direct_state == NTB_DIRECT_ACTIVE;
+	}
+
+out:
+	if (published)
+		ntb_transport_notify_peer(qp);
+	if (cleanup)
+		schedule_work(&qp->link_cleanup);
+
+	return ready;
+}
+
+static void ntb_direct_session_start(struct ntb_transport_qp *qp)
+{
+	u32 session;
+
+	if (!ntb_direct_link_capable(qp) || !qp->direct_shared)
+		return;
+
+	session = get_random_u32_above(0);
+
+	memset(qp->direct_shared, 0, sizeof(*qp->direct_shared));
+	/* Complete local shared-state reset before publishing the new session. */
+	dma_wmb();
+
+	guard(spinlock_bh)(&qp->direct_lock);
+	qp->direct_session = session;
+	qp->direct_peer_session = 0;
+	qp->direct_state = NTB_DIRECT_HANDSHAKE;
+}
+
+static void ntb_direct_quiesce(struct ntb_transport_qp *qp)
+{
+	bool done;
+
+	if (!ntb_direct_link_capable(qp))
+		return;
+
+	scoped_guard(spinlock_bh, &qp->direct_lock) {
+		if (qp->direct_state == NTB_DIRECT_DOWN ||
+		    qp->direct_state == NTB_DIRECT_QUIESCED)
+			return;
+		if (!qp->direct_peer_session) {
+			/*
+			 * No peer session means RX publication and TX
+			 * submission never became active.
+			 */
+			qp->direct_state = NTB_DIRECT_QUIESCED;
+			return;
+		}
+		qp->direct_state = NTB_DIRECT_QUIESCING;
+	}
+
+	/*
+	 * Keep the mappings until the peer acknowledges the final boundaries,
+	 * or until the link is down or the peer starts a new session.
+	 */
+	for (;;) {
+		ntb_direct_control_progress(qp);
+
+		scoped_guard(spinlock_bh, &qp->direct_lock)
+			done = ntb_direct_tx_idle(qp) &&
+			       ntb_direct_tx_acked(qp) &&
+			       ntb_direct_rx_drained(qp);
+		if (done || ntb_link_is_up(qp->ndev, NULL, NULL) != 1)
+			break;
+
+		msleep(NTB_DIRECT_TEARDOWN_RETRY_INTERVAL_MS);
+	}
+
+	guard(spinlock_bh)(&qp->direct_lock);
+	qp->direct_state = NTB_DIRECT_QUIESCED;
+}
 
 /**
  * ntb_transport_rx_queue_size - Query the RX queue depth
@@ -1204,6 +1440,9 @@ static void ntb_qp_link_context_reset(struct ntb_transport_qp *qp)
 	qp->direct_rx_cons = 0;
 	qp->direct_tx_issue = 0;
 	qp->direct_tx_cons = 0;
+	qp->direct_session = 0;
+	qp->direct_peer_session = 0;
+	qp->direct_state = NTB_DIRECT_DOWN;
 }
 
 static void ntb_qp_link_down_reset(struct ntb_transport_qp *qp)
@@ -1221,6 +1460,7 @@ static void ntb_qp_link_cleanup(struct ntb_transport_qp *qp)
 	dev_info(&pdev->dev, "qp %d: Link Cleanup\n", qp->qp_num);
 
 	cancel_delayed_work_sync(&qp->link_work);
+	ntb_direct_quiesce(qp);
 	ntb_qp_link_down_reset(qp);
 
 	if (qp->event_handler)
@@ -1457,6 +1697,7 @@ static void ntb_qp_link_work(struct work_struct *work)
 						   link_work.work);
 	struct pci_dev *pdev = qp->ndev->pdev;
 	struct ntb_transport_ctx *nt = qp->transport;
+	bool direct_ready;
 	int val;
 
 	if (!qp->client_ready)
@@ -1466,13 +1707,17 @@ static void ntb_qp_link_work(struct work_struct *work)
 
 	val = ntb_spad_read(nt->ndev, QP_LINKS);
 
+	if (qp->direct_state == NTB_DIRECT_DOWN)
+		ntb_direct_session_start(qp);
+
 	ntb_peer_spad_write(nt->ndev, PIDX, QP_LINKS, val | BIT(qp->qp_num));
+	direct_ready = ntb_direct_control_progress(qp);
 
 	/* query remote spad for qp ready bits */
 	dev_dbg_ratelimited(&pdev->dev, "Remote QP link status = %x\n", val);
 
 	/* See if the remote side is up */
-	if (val & BIT(qp->qp_num)) {
+	if ((val & BIT(qp->qp_num)) && direct_ready) {
 		dev_info(&pdev->dev, "qp %d: Link Up\n", qp->qp_num);
 		qp->link_is_up = true;
 		qp->active = true;
@@ -1559,6 +1804,7 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
 	spin_lock_init(&qp->ntb_rx_q_lock);
 	spin_lock_init(&qp->ntb_tx_free_q_lock);
 	spin_lock_init(&qp->ntb_tx_offl_q_lock);
+	spin_lock_init(&qp->direct_lock);
 
 	INIT_LIST_HEAD(&qp->rx_post_q);
 	INIT_LIST_HEAD(&qp->rx_pend_q);
@@ -2054,6 +2300,11 @@ static void ntb_transport_rxc_db(struct work_struct *work)
 	dev_dbg(&qp->ndev->pdev->dev, "%s: doorbell %d received\n",
 		__func__, qp->qp_num);
 
+	if (ntb_direct_control_pending(qp))
+		ntb_direct_control_progress(qp);
+	if (!qp->active)
+		goto clear_db;
+
 	/* Limit the number of packets processed in a single interrupt to
 	 * provide fairness to others
 	 */
@@ -2070,7 +2321,11 @@ static void ntb_transport_rxc_db(struct work_struct *work)
 		/* there is more work to do */
 		if (qp->active)
 			queue_work(system_dfl_wq, &qp->rxc_db_work);
-	} else if (ntb_db_read(qp->ndev) & BIT_ULL(qp->qp_num)) {
+		return;
+	}
+
+clear_db:
+	if (ntb_db_read(qp->ndev) & BIT_ULL(qp->qp_num)) {
 		/* the doorbell bit is set: clear it */
 		ntb_db_clear(qp->ndev, BIT_ULL(qp->qp_num));
 		/* ntb_db_read ensures ntb_db_clear write is committed */
@@ -2080,7 +2335,9 @@ static void ntb_transport_rxc_db(struct work_struct *work)
 		 * ntb_process_rxc and clearing the doorbell bit:
 		 * there might be some more work to do.
 		 */
-		if (qp->active)
+		if (qp->active ||
+		    (qp->client_ready &&
+		     READ_ONCE(qp->direct_state) == NTB_DIRECT_HANDSHAKE))
 			queue_work(system_dfl_wq, &qp->rxc_db_work);
 	}
 }
@@ -2128,10 +2385,7 @@ static void ntb_tx_copy_callback(void *data,
 	dma_mb();
 	ioread32(&hdr->flags);
 
-	if (qp->use_msi)
-		ntb_msi_peer_trigger(qp->ndev, PIDX, &qp->peer_msi_desc);
-	else
-		ntb_peer_db_set(qp->ndev, BIT_ULL(qp->qp_num));
+	ntb_transport_notify_peer(qp);
 
 	/* The entry length can only be zero if the packet is intended to be a
 	 * "link down" or similar.  Since no payload is being sent in these
@@ -2586,6 +2840,7 @@ void ntb_transport_free_queue(struct ntb_transport_qp *qp)
 
 	cancel_work_sync(&qp->link_cleanup);
 	cancel_delayed_work_sync(&qp->link_work);
+	ntb_direct_quiesce(qp);
 	qp->active = false;
 
 	if (qp->tx_offload_thread) {
@@ -2636,6 +2891,7 @@ void ntb_transport_free_queue(struct ntb_transport_qp *qp)
 	/* Catch cleanup queued while draining RX processing. */
 	cancel_work_sync(&qp->link_cleanup);
 	cancel_delayed_work_sync(&qp->link_work);
+	ntb_qp_link_context_reset(qp);
 
 	qp->cb_data = NULL;
 	qp->rx_handler = NULL;
@@ -2822,6 +3078,7 @@ void ntb_transport_link_down(struct ntb_transport_qp *qp)
 		return;
 
 	qp->client_ready = false;
+	ntb_direct_quiesce(qp);
 
 	val = ntb_spad_read(qp->ndev, QP_LINKS);
 
@@ -2927,7 +3184,9 @@ static void ntb_transport_doorbell_callback(void *data, int vector)
 		qp_num = __ffs(db_bits);
 		qp = &nt->qp_vec[qp_num];
 
-		if (qp->active)
+		if (qp->active ||
+		    (qp->client_ready &&
+		     READ_ONCE(qp->direct_state) == NTB_DIRECT_HANDSHAKE))
 			queue_work(system_dfl_wq, &qp->rxc_db_work);
 
 		db_bits &= ~BIT_ULL(qp_num);
-- 
2.51.0

