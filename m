Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020079.outbound.protection.outlook.com [52.101.229.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7725642E000
	for <ntb@lists.linux.dev>; Mon, 10 Aug 2026 16:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786380714; cv=fail; b=LGDUjCIDLDxVtLVNKy0oiHfioss7IwEY/prXj0l53rGmuPalsMuB7yjJn0uNdZp7uAycFVzH/8w9Q8MTWSmADd4+7NEZhGti5ebs7IU8bMRXgITQBy3tuKrM04v4lAEZ+hws7gbn/k5Ykboug4pd5dqVvQWjcEx3jGvVMyQ2Igk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786380714; c=relaxed/simple;
	bh=8HoHlyjJw/abpgQHx6+KGxw8xwTh14U6+VU9mSxDTeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GpRMVNt9mWOtz49+qd1+VHdoI6EKRwp2nQGkc4OGwCmxZlp1gzVKPutBhYbkuk4PNVniQkBMHib94JAsDDewrV2khVhdigi7FrwB1VhlAV7o0mD6HsDXgHoVMggZUiO3qCPKrIHKKEwBIBMJ4nLk9fMQSXOeYro8TueY728sd2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Lcm/K+4H; arc=fail smtp.client-ip=52.101.229.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Lcm/K+4H"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K8zUukTrk/k0lTUeW5nd7YzTt5SahDZxnk/pqj7bouVrqJ4ZH8QOS3XT7IjVVMJmU+qDagIN3nHWozzgtejAA5V7EAeUJ4PNBUz+kNpJftzLxa3JrKJVf951VPfzQJfyWUK0HMyaCaAS+DMopDzn4yNUrZ57Ymqj9Lllb50QXRH4qcHVnDgrP+Bhnpu9dhGTJX3Sef0EFcafsCAeMIqxfQytO9Mw2hPxy7MMRcZPN3c5uIsEu2Ur86obRlRWrZ6MUWY8fbq/9olcTwY7xpTnJSrsFK6lVWxHaOPd5iHPFbUNzpvsBYwpYkweqEuT0w3gfPerAEI6nJXIzVUmus4H+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yoReE5FHhjZuVCvSjXyVxvoqFOwhnVRm3HZAkjAxzrQ=;
 b=ee62OHgpAUBgnVgNEAhVrg87TzKKBVvSBJuDuEPeJXOAgZWakQyjvQBUdld9sXm5BBBsmIP4FIV9ndbjKd1zyEDoPdzGF1DFotWxJouuA1tWkHjAm6IpUkE24KF/4NQvNoFB5lgVJDwHdN61FToe/eRrSXB12tv/M8wZ8vFPbQb2/8SvbB/jVxoUfKSftQFvibA1gkdIdOLhBY1ltlPfNqLgvGuhzOrzC2p647WaPXA6yhdbCfkxej8OVTqsHmnCY5cuER8DE1tIANERcLxOdWuAv/zi+9+zbbqwFf3qOsHCiOUzIEqG0GffEOgv4t+6cHnGAS5AniGTbOimV9oQxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yoReE5FHhjZuVCvSjXyVxvoqFOwhnVRm3HZAkjAxzrQ=;
 b=Lcm/K+4H91eJhxDnVOxAWWAoK2l7AvL4j89rnWaUD+BJcUY853fqH88dOkbtRnRWeOp+oJbnx9sSyrYYWNKf6S2qRCKvTOhJ9RMDeoc8r8pMYoG0Lzc1iORYvkwQ4BpC3xBhyrjVQQWJbyKB44UxIO4OrzA2LHUxwLw3q14S338=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB6729.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:42d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 16:51:45 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 16:51:45 +0000
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
Subject: [PATCH 02/16] NTB: ntb_transport: Reject oversized TX buffers
Date: Tue, 11 Aug 2026 01:51:21 +0900
Message-ID: <20260810165136.2292436-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260810165136.2292436-1-den@valinux.co.jp>
References: <20260810165136.2292436-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0089.jpnprd01.prod.outlook.com
 (2603:1096:405:37d::16) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB6729:EE_
X-MS-Office365-Filtering-Correlation-Id: ac66f36b-05a6-4fbd-10c9-08def6ffa96a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|23010399003|376014|1800799024|366016|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	TGR2/kAlMJpr3IQMhb9G6xMNfVqKdNfHlzfBxzvgdeRLbYah98QX3waFDEoPGKdQ5J8ZPqmM2dEsFRS48W0G4JJUE6nxkzVLbcSHlRo35gXyh+fzHVXyVCAb/rjlgvmXOeg5P1DMDHtgTz8B1ih8pg7cIjqjkC1EEkqoWWJCxGC/Rp3dxGiGHNpML/9/qJK/I98mOB477dQkRM7lxSoNTD7PQJrCrYFpY4ntRoRQvJHKrH0AX9yHhb5NyTl8IFN6nYKQ6jsgjJq3YSODrz5fVH0ma9bCM2ezNZG+vGZVxp0M5v0js7W42loTSWRYe6JL/5Rl4jYkLBGd8k5qwpt5Ww3T37o7x+qN6aTljK7GlluA0k7X4jtqAGBHYTwzbG2Kx0ROciWpWbWdEhVZWlBpXvJCgXj7N+ZLWSG92Wk7oxSgLeIpc7IVU2ugdF1V0t+wayYEILr2nUK6KMGMjv0dUdANp0rf+CzpkssfinCEPMokkwpDT9Pb+4j/1RE5YrLPVpOTsICeG6aHkex+CeCvbyV1v+L9hhagxAmQFKVnLRLlIkerR4cotuJpLK2lA4SLA5m9P/F21/a4M29TK0Ff04FDnqzkhM74L77KiQ6K4zSokdVFN9pQdUbFbh5iIIh9lW+2J4oB8qK5RyQBL+U1L4I2alZvvuVkJJ91TAA5KFg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(23010399003)(376014)(1800799024)(366016)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tPHsp8i64jkxxuCpjcfk+ktBIxf2me5/pTkbM08oNaqgl4N8cxw4WluD5Sb7?=
 =?us-ascii?Q?b5EkCagTJwK1ZR9myT1s3qCYpOjmeVft0ewiAjM/OzRtbYffjtARGYGEWCJ1?=
 =?us-ascii?Q?6I25GxlpcxdxkZGibCy/m3amMsPrB0o3NaJXoy+bik9EUm/jS989JTEo5yEj?=
 =?us-ascii?Q?QIRzlpPfIrLdFohJKcaOFjpekCbTAUDbA2oyQpXFtZ1ToogX4Cbg5R0DRP4Y?=
 =?us-ascii?Q?r7CDBFcIdEamiDetSMD1nQgyowETDTyjVkNVH+1d4auSNXEA+2Vo1Nui2gzp?=
 =?us-ascii?Q?C2OmwhS7wHObPnUGvJoFTDRujsjLMpoEGbkSk0EY6IqPfpKOAgZXMbYNKHx+?=
 =?us-ascii?Q?P83gQ1KlZoSxH8djtuNF0V+lMYkXLhuatZ1klVlztfPRpqQ2mNGXQIDlXgj5?=
 =?us-ascii?Q?hhzl63FgaMurszUAQBfllYoaDt0ROp+HgZHPl5PJvtm2XftkvwHsuSfLGwwe?=
 =?us-ascii?Q?C3WCG7R/Radl6NoX8IphCJGYWTbokdgBQBRVWFqjrybKtTe3Hj3Vnmj1aKzT?=
 =?us-ascii?Q?76APe9IsKuGdy7P+RpZLf/yT3zZoAFtQgJX0x1wJlbQ11WqgE7D6Amc8/4gR?=
 =?us-ascii?Q?j3UGNIO4fYjwitOPuGV2Yl6obldC5D4+vzkR5CFUn6QoXDpH268pBhr0AsCd?=
 =?us-ascii?Q?lxSghvkjLSYQERAxr9gxPJIicEnxedOmK8jit5YgNBH6yNJEt74SkoEzSZs0?=
 =?us-ascii?Q?k+w8CkWzncF/pgKN9mnM9GSjkDIx9fW6jR2BBUyIdzm1jKmC29/3zrtilg3G?=
 =?us-ascii?Q?dzcF/lVVuLEtUCKyzKq2WZH87+Koyo6IUnajC4AQgOnZtP6UY7vFX3Y/dVP2?=
 =?us-ascii?Q?/XRpjtdczk6tdiSb03vOs/7xVoyXkVAQA17w9AgjG6n/EU5MJa1TYyIHHVYv?=
 =?us-ascii?Q?tadZv1Rs+aZbEZrlyFiO8eZJ2pPuIekAWEISAMKFCc6QKDE/z2L5On+TSN5k?=
 =?us-ascii?Q?BWcctdSjAdXOwbZuwyjxj24IKPc3EXsOJn5DR6/PD9nCb7PQRiqRp+o7rio2?=
 =?us-ascii?Q?Psnf9DuqJ+dIhITy6nuf3NA/i7gKPfe4GVh5kpFZJVolBSGz8teafans0VQA?=
 =?us-ascii?Q?RljIt5+uutdu0K/SrpiJMIDf4Cx8BsM6S9rRTN+PpFronAhA69V1S2e03sy8?=
 =?us-ascii?Q?HnK5AhxM1dyn6F56aTpKmo6TpEzJ0r/FGc4HEtP29IDm7vkCtVSGCjL73S8K?=
 =?us-ascii?Q?p8itHF79kpHrio/EbE0qx9mreNzkOkEy719QpfyQsgal4TbPf2P8Yi2Vvc9O?=
 =?us-ascii?Q?sgqlq9Jo3AEsiFqbi291dKIIzvrdzYIs55DJROrKhV3Y+upd/QstjZ2TmwtU?=
 =?us-ascii?Q?0XNCDEq9wkNklXuIgthZh9hTf/sGXNIGa226mrDKXToUZPmdQNu/wHuveeq/?=
 =?us-ascii?Q?dlMnydcDFBgY06XVghAP1vY7hoFmcBJ6ODxrbvvRALt7CObx9fqU1cxgdODD?=
 =?us-ascii?Q?+hm0r1kKNR1yRKltTaqAGUO2mJ1OQE/gAv6XLxZaR5LQc/1O3SPCqebiYtx5?=
 =?us-ascii?Q?wdwX56TDzk/uV7/wwm3PuvP2QoEXyhqxd1zXQsJJ45QUlLDe0vtmcm52W3ta?=
 =?us-ascii?Q?6N/x4SnXbGRkXoUsma96nhYryKM6+4HwVYd7WL6sHKbn58754hGtR/SieEDM?=
 =?us-ascii?Q?/cwaqZaHJ66EvpIDY9wePCx53hIxX1q7UzA904lu0/EUXPa80gOkdCrEp5hB?=
 =?us-ascii?Q?A4ibj3iPWHCl7vzH9kfBnRTwiPoBev+hR/u0svmuNlyc68mYBGzB4gX1uTRP?=
 =?us-ascii?Q?ZjSG8DuOCLkGY6KTi/Wxu4zo+3KM3b5T/aKTqBIEL/T5A0UV8scn?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: ac66f36b-05a6-4fbd-10c9-08def6ffa96a
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 16:51:45.2969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ShHscyISZFLPZbV5kT5WvMo1amAWY7STuFQvQcVimxMSneIIbStVJaPY80vosKZ/4XPSKK0BUs7N47s9PoOEUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB6729

ntb_process_tx() handles an oversized buffer by calling tx_handler()
with a NULL data pointer, returning the queue entry to tx_free_q, and
returning success. ntb_netdev therefore neither frees the skb from the
callback nor takes its enqueue error path, leaking it.

Return -EMSGSIZE instead. ntb_transport_tx_enqueue() puts the acquired
queue entry back on tx_free_q when ntb_process_tx() fails, while the
caller retains ownership of the rejected buffer.

Fixes: fce8a7bb5b4b ("PCI-Express Non-Transparent Bridge Support")
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/ntb_transport.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 3efc50955253..3a9635faad9e 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -1962,14 +1962,8 @@ static int ntb_process_tx(struct ntb_transport_qp *qp,
 		return -EAGAIN;
 	}
 
-	if (entry->len > qp->tx_max_frame - sizeof(struct ntb_payload_header)) {
-		if (qp->tx_handler)
-			qp->tx_handler(qp, qp->cb_data, NULL, -EIO);
-
-		ntb_list_add(&qp->ntb_tx_free_q_lock, &entry->entry,
-			     &qp->tx_free_q);
-		return 0;
-	}
+	if (entry->len > qp->tx_max_frame - sizeof(struct ntb_payload_header))
+		return -EMSGSIZE;
 
 	ntb_async_tx(qp, entry);
 
-- 
2.51.0

