Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021078.outbound.protection.outlook.com [52.101.125.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC92A3ACA4C
	for <ntb@lists.linux.dev>; Thu, 10 Sep 2026 04:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789013338; cv=fail; b=HU9FMclOZjyCQiyLxuKYsTfkiveTgWRIEX6svGE9PofT8n9XaqbS1bOinYRQh/QEt9z7oroQ4GnsBw3zU5L4E736LX/6mX/SgD6coS+yjtNFXpwHdcU14IKW3T87zwXDLaQjINyfzQSwEP/O5iRwAIr4t2zUiHkyv6Mmhiwt5I4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789013338; c=relaxed/simple;
	bh=v3qp/mqOPYCmQvaedyJX4zFSPhVIEobdhzICJ1AY7k0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L8iqW9vnpieOJPHVL/ZdTCOiZQYIuyTIbGdJzas24DxLeb0ma6SCdnJ4D22nup4rWFOs0Ev4Oco2OU8BQsXDcsIsseNOl8QfFUtWTEDCFj7Jo44lV/5QrRe1BqYekQaKIdp25IkGpV+b4RS+YezDpeSCyc7rF70+341HbWiDf1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=UZBdS7fV; arc=fail smtp.client-ip=52.101.125.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="UZBdS7fV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L9CUvVnVIRJmvjSykZh+JRTfwM9OoPkj54cY9Fi7HAmjvvIoqWTGKTq7ExtGsHM7zIrj/RvjWYL1k34mgYTFuU5Ydw8i7hspXjZZszjw7mKk4zrwsWEYukWReLQHPMVOlKgzhbkb71I/Pp2UHdjon7yEIa5vHBFEqOKMbCpisDXB39iDPmZmi2kB+3yroTub6LTr+sSKaeMfc75x0U5k7I4P5B5o+IEVz/f0HVDKPNrKEZlFx7GvyPkVjsUphENnMk9E1cCPNrgS52INoz0fqMpLxPHRxBSjjI3wNdVY4yOjHTviYgH8AcEPnZjysfvo9+MOfIDON77UITQpEvziOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9gsrZJj3YR2T6+HU5SFiZDt0M9j4ep4XKONvoKnESPc=;
 b=ZRWlPDw4n+UuE3isWXfu0aCaOvWgONP9e9mHGw3HHLdF4MTclZxrVICxhOmj5t321uGtJE+sveHKnA89dNHbgXSMZA8MuDaYxkVNnF+5Fa6DzEE6AJH/Lwwx5M7QnwNCY8nRhO+V5OrAxWYAui+QKlD29D9GZYFEBDSgCVi7B8NVzfYAqtPGjhw/YlpiTkNM5Z2VawOuBKoghIaF8PrDB3wVTlqcJo7VYUetZBwhYqn9THxntDCXDsfwfHJs4jaVQQtcckf9js6Oq6Tx+Nq3EechA8VG+UE+kBHDN8tBgV4+vLdve5sBJihigbCbO9c35ao3nrKumKTcDeAmMLiAeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9gsrZJj3YR2T6+HU5SFiZDt0M9j4ep4XKONvoKnESPc=;
 b=UZBdS7fVTtABeMkPyzyexLp7qgIPABOvHamdsUK+2EyLrn6mymu30NFqaSmkWz6DojGYtRCjeHnMVpuAhbGJMBpnOtOdlKVIvbn4ybZBRFxv6VQQr9NGFetXKtXyD/vV08+o7jaRY/tZFJiAAW5cZfg8GimUjttQlLAPtMwpKaE=
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
Subject: [PATCH v2 05/14] NTB: ntb_transport: Avoid losing QP link-up requests
Date: Thu, 10 Sep 2026 13:08:27 +0900
Message-ID: <20260910040836.3792333-6-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260910040836.3792333-1-den@valinux.co.jp>
References: <20260910040836.3792333-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0027.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::9) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYWP286MB2220:EE_
X-MS-Office365-Filtering-Correlation-Id: 04394cfa-ef7f-49e8-aa69-08df0ef1357c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|7416014|366016|10070799003|6133799003|22082099003|18002099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	SbimbLzX2fwMun7btUfPRYzAFev2TWoIP0oxoX1yIZMzslUYvvowsnQ9zJLmgtTkQx1M3V37OQKF6+mY3s4W+gWCi6BirYH8+VHtCKWbZIVzJywoWB6nVkrnpHsP2JWj4duluU7BJRmwrR4030TcYoVGSHxit25p23rDFnDVcJWaod9f9UUqEMUicYvEqACCC52I6Uz0uDR6VkvHV/iYtuUh2hXjHLs/CwuvN1Lq03EnNYXZOFT5M8Qw7I0qfHm7DiHp8CYc0AMPP8bcsmmLG57++jQK8lOiZkdBwdGwcZy9+FBi7ZH5E4dhFYf0n0Odv17e13FAKQAxfT/bYFGhmb2Cy/1ehb6WU3c0sEnwuUj22J/HruHxhag4Ks/JFncpPRH1i44SlXrstlH6FGOjlKv5a/t3qZIzdL7r8AMeG18KkQ16gxkTEtltOdG6Exq2yOS1noIF3g67FdRG//IXAnSQJa4d8KWmXi+0ozXufCz5KT1fsan6YuEDwA7FC+MxIJpzikX60T5HU/s6J0FjskjEJ9a8IwnM+P5dunZmcLLx6lKquQCiEDwgFXHNxq/bzpZkXwG0dIWqdTV0zi3GLdby/7lhfQs+MZ3JQUsxjCQmxvKB1jsTYK1ZnsksIS9Z
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(7416014)(366016)(10070799003)(6133799003)(22082099003)(18002099003)(10067099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i0mMVLF/NGJhW7Or9AkIQIcpq9QItjP8hnkPog7lc0XU7XHxuxC/598PEsTy?=
 =?us-ascii?Q?mdfog50X059H/fscb+LudICal5XEFkwfzbffw07t8M36WOroddVCcjgSi7kx?=
 =?us-ascii?Q?P67IAEzJsYsIrdNr2ianGVMVplFiIQP/33HhiGAfBLkxI5izYhK0t/lo1Qvq?=
 =?us-ascii?Q?PZtD3rzFSea1dIHD9kWyDqwSOv9M7SJcdbNayd3V9Jymb1gqwgnMWRoymT2h?=
 =?us-ascii?Q?C+Ffs4cZw5BeXa9vVgFesewd8Mt8YZ3I0Ad3nvH4SpwOpXwlkQTTwJqDQG5p?=
 =?us-ascii?Q?HiUMIszDQhqF8kUXqds8oIQagijNM49mpp2mbC1n57nbusRYu0UIC3kGAcd+?=
 =?us-ascii?Q?HBj9ErjixIaNpvuKZRQqjk603xvdnF/umi+S8cd1ffs49yW6MzTfPNtMW7/N?=
 =?us-ascii?Q?zH3ts6NqBLBeCEq03oaAqsTH+V58EJy4X89KolJpmNvHtIzqXaUqhF2r3hQZ?=
 =?us-ascii?Q?skuYPDBbg/5nMDix0vgjvTfC8g3brzzfwUBhciU4pFxmOgCmCQ5Hm7AMUeEQ?=
 =?us-ascii?Q?iUlUcKxE1rFZQdKZkdVUCk6TUjn2t6SF3cAyTQ/IgerEMVqKcwGHJBvqT6Sh?=
 =?us-ascii?Q?YJ83kbrGcGzkmU6H4r4las9MAOBWig71n0zxd469UKKovUlRKkJDFBpDUC8h?=
 =?us-ascii?Q?wQpK5ekPkBwCnSeq89ycIZp6ZiphjIBWBzkXvcubVVBzsKVpBwNLDQExs9qR?=
 =?us-ascii?Q?9mQrjmYxLr0yMXz2f3+DIsNdMn2IUBrypLoFa7brGRAM3w9ndkC9XTvMKA8T?=
 =?us-ascii?Q?+Tmkma9sQztToiSSfAiz+vxYyR5sfWBO+I1oKzyA3ojvl+G9TrhSVjBZ/w6b?=
 =?us-ascii?Q?LpKruJDW13nQJniUzQY12lo0xciv+IM1wRG0SpHYObS/Wx7m28LlOyPbZ+N8?=
 =?us-ascii?Q?UUnQ9LGUH/LM0LWy4SaKutdwC5+gJjyM1/kxaMEJr3BePP1qCuw0skAoQRac?=
 =?us-ascii?Q?UowXEOghnSAbHGge7qgnyaMS1HFXOu0ui1pPUmQlRYdw53LUnjriytk/NGTc?=
 =?us-ascii?Q?zyxkTwsgxVwYNcURcoRsO9sV1QtmxOX8TwWxC+0nJUjzBDHDwAMWDFNTIZaM?=
 =?us-ascii?Q?0BjJBkiVbq2Co4elzH9OlJduo0LrNd0yJvraCw1SV4i90hVu1IWXuKM6kC7n?=
 =?us-ascii?Q?RubsStXXhjvKt8Q79jEgtPPFe0oTY5kUtmH1z5DN8T4A6QbKPyVmQkggxhud?=
 =?us-ascii?Q?SdW60eQmyb5mVHvMnzkxpQI0eiEEqaOtb7JM0rl9JLdGxEk6oZsu3gQoSbP1?=
 =?us-ascii?Q?zBfr1xJciN93LxHrZm8qonkAyva0sWEkkDqOT5uiMqC8u5qc4meTZ70zldmQ?=
 =?us-ascii?Q?4s8bbC1bRvTWQc5Ts/9tq64EZlB7WnsP9REiQ8/vtG1Jknn/NzypqJJTAWHS?=
 =?us-ascii?Q?/VOQl2Ivpie/YJgqJlL5i5IqLhZpQNJr02T7Jke/fyfgdbA1xEFtQsLIwn1Q?=
 =?us-ascii?Q?mhricozxCoFP35StX/ZJpHtJ6OSpOshMBltAH5JIzaeupofrwj0Vu9ba9fxm?=
 =?us-ascii?Q?QH+6TLdufHwnsbA0J0PJVrdywo7dze9dYK9x3LVzxu4VmD2orJFro/sJRog+?=
 =?us-ascii?Q?ly0IHAQL2c5svvFKwWVWKzZRMgcuK6I22g1UWqchzdpwi8jUauol+Yb5yTgn?=
 =?us-ascii?Q?1dH3n/LF/zwaUJwq2ZC2RXdwYZq281l4WzVgulCwbJFyJEESNFcHDmBrcQOH?=
 =?us-ascii?Q?Q4q/qmBg5WoZQWWEnexwBIIuuHwd6kM5iKKXXwr6XRbwv03kbWjRhvd1xV/4?=
 =?us-ascii?Q?FxxE+lU1jgBoIS4T4D5l2D/u5CNOYCUJG6tyoal38ppkvzLCUXp+?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 04394cfa-ef7f-49e8-aa69-08df0ef1357c
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 04:08:45.8010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9qNoZSaCH45xv1ftAPwT0w2j7Cb2M+LljXRyonsrGmQAPNBkgtajN/MZS3+OXgTgWD1EhIl8A23zcgORobX/Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2220

ntb_netdev_open() can call ntb_transport_link_up() while the transport
worker is completing setup on another CPU. Concurrent transport setup
and a client link-up request can both read the other's flag as false and
leave QP link work unqueued. The QP then stays down until another link
event or client link-up request.

This is the store-buffering pattern described in
tools/memory-model/Documentation/recipes.txt ("Store buffering").

Add a full barrier between the store and load on each side, and
mark the client_ready accesses with READ_ONCE()/WRITE_ONCE().

Fixes: fce8a7bb5b4b ("PCI-Express Non-Transparent Bridge Support")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/r/20260907144701.702E41F00A3A@smtp.kernel.org/
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v2:
  - New patch (Sashiko)

 drivers/ntb/ntb_transport.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 75d4a2e021f4..1332d53bcfe7 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -1104,10 +1104,16 @@ static void ntb_transport_link_work(struct work_struct *work)
 	/* Publish the link only after every QP has been set up. */
 	smp_store_release(&nt->link_is_up, true);
 
+	/*
+	 * Prevent both sides from missing each other's flag. Pairs with
+	 * the barrier in ntb_transport_link_up().
+	 */
+	smp_mb();
+
 	for (i = 0; i < nt->qp_count; i++) {
 		struct ntb_transport_qp *qp = &nt->qp_vec[i];
 
-		if (qp->client_ready)
+		if (READ_ONCE(qp->client_ready))
 			ntb_transport_schedule_qp_link(qp, 0);
 	}
 
@@ -2401,7 +2407,10 @@ void ntb_transport_link_up(struct ntb_transport_qp *qp)
 	if (!qp)
 		return;
 
-	qp->client_ready = true;
+	WRITE_ONCE(qp->client_ready, true);
+
+	/* Pairs with the barrier in ntb_transport_link_work(). */
+	smp_mb();
 
 	ntb_transport_schedule_qp_link(qp, 0);
 }
-- 
2.51.0

