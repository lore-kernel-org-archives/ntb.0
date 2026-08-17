Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020078.outbound.protection.outlook.com [52.101.228.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4E638DC5F
	for <ntb@lists.linux.dev>; Mon, 17 Aug 2026 05:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786944929; cv=fail; b=A4Wa3mTUqoV1k5XAW2g1mwvLjq5CPiqn8tb+kmL74IZo39jfZFB66GXr/gtlXkrXhdasJ9TKk+SAIxu0wCdBL1X8HEEgTCi6TrYoc7PtKC0LbbwgfB8EtvCyW3a55f1m2BcrcO0c0HEkceyLndtKMUrich9QneMKI1A2uAbXndE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786944929; c=relaxed/simple;
	bh=JcUPJKopW7W0+HKWZtiB9UODi2Z+xCZpn4AtRd1RJFc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=bbQrRgYOgbJodAK7zNvACZd3tcdqsMi0rXKT6GK09u4y4uDtyOQ2QI8s9Oy1u0Gag0lmBV40B68VmNrFq806oVDn8L5FCptUGvuvt/RYBvnRs5tP4uuDt7rFJgYiwObYQGzVTs2PiF1IkfcbDZ6p5QYP9e5HupIjoUwqLZI7fc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=JGwaEONj; arc=fail smtp.client-ip=52.101.228.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="JGwaEONj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F0p4LdMkL5NMO1zbzABl9V5bH2qEjIa155EcJHjIB0RuIN4dLhVxjXanaoteyI/WBpaNbf/QmQQHFwlTpXPmo7i+JRfugO7sPnlqH73H4HVmpIyMg8+BTBTB0dA8dDzKQRMCAeXoGOo1hRnBfmHq+GtkaZzYX715LL22ZXmWlWy7WA9LGSYuEznVgis/RAUpMUq5yTVldvLMAkNgmNMAbgQmZ+M55fW+IQLexC8ta2K4p1+ivGu/nMaw8x2ay0//MSSb7oYIAHvXesJCz7Btgyo+xO5WjoCwY+vtYJXz8JiS7o5UociddW8iGZHL0qKqQeomsjRWQPuT4vqaNNMTeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4QqtBxpZQYzv+1s6CTP54+PEElH1wJ0jxl/4rIQwsbI=;
 b=dZrHRaszhtKXASNVnWNAKQN3lHXiY0NQpfGM0g5h40Yo3KzHcwIcoiXYgiVwBCZOUAJW2NfStPccp6caj5o0arXG9ZSUt2uWtdMNTNa+meVdHo0U6U9q/ta7FaHgCBe1XF0kgJV0VqEyqa56lgHQpkj0Xmtbl5Tct3Npp3NHvxHxp3UfhvA6Tsd1t6guaGIFYAmzFYX3oFkKn1LvEj70YEidxmigD1siuFNtk7qOk6uFVPu1kvzGzvBmZGoMEiaqO/Jc573Kd3be01VLhattPYO4XfIWF+wjDTEiPPlfWxvCc0qUj0VxD6CGVCb5sr2wlZtTZ00v8sUwiRzsieWXpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4QqtBxpZQYzv+1s6CTP54+PEElH1wJ0jxl/4rIQwsbI=;
 b=JGwaEONjHqJNtiGSMZf6X5/8OFN8ZN65DiLsD+t1FAsR7qENxzOpYIreN5ioWTI9AYMPNi2y57XJAuwbDMDYx6hwDsriXqPutR5E0UsnYzM6+S0PprG2JgDAjVD+GVpYaupcZ+6dvnyronBuGGJnAotTL/2fpau6r6rY582G6lA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYYP286MB2996.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:30a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 05:35:22 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 05:35:22 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: ntb@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 0/4] net: ntb_netdev: Fix TX completion and error handling
Date: Mon, 17 Aug 2026 14:35:15 +0900
Message-ID: <20260817053519.4135287-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0156.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::16) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYYP286MB2996:EE_
X-MS-Office365-Filtering-Correlation-Id: 7eeab863-977d-4258-7783-08defc2154b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|1800799024|366016|23010399003|18002099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	gcoSTJqwyZJzgfeG+zyEIEOH4B5CzPlnzSoFaGhpOFTP4kxVY0wlmhHL0Yf8Irja4TbJcpnN9LGhd0neS2NMUpKFnOUC5wkjKMl9TeeMRqx1a5JoCBhhK+QZ6Z9kPNWBmLIU3IH9GXeP9Ow4hddyPN9oi+MZzkDvvBSnLsHMbs/DLlaQ2fhiWqGc2CsUmVo3K7SD954hm4cAUmHM5DhmwtJ2FDMxsFDAeGqR6p2mdqNhgQ/dmr3L5fnbbjhUiwGGWdC9UdamvMwv/EcaugO7cJUhgPjYUwYz0ZmGco9jAxYzkCWPdMk9dNUG9jWVfKVb8RDniUKhAsM+2y224mHJnvFMytdmPH/FkiWeghpDNhSV6eigwNXUs9fbmCI9htm+/mH1hNFhwAkDG4AOtv5cPCD1oNh2SzASrBkCNfL+7iEcN3B0UvgdXjUD0dszQmeD2xeoKxGTkt6RHNxhgWvuX+/Dn8yBIJtWDUbQrGwKfD4N6quxfguEUtBmzIWtCIwRELSTazK4yRiTEXkjthZxmjpZ8iXTOnARUeyfY0S3qZlvVnax8371PmKqdXIbobeA0pO5gbCw/hv7hLj2nRmOGgRzIB2GPy4iwVs+Ss7Yy5NCjyns+9RuCS/Yddhexj7kVx+qgq8PEOzIicLO0PMG9EaNNpU89uSD0W9xeANoL8E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(1800799024)(366016)(23010399003)(18002099003)(56012099006)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QqU7ZuJ1nz0BxYdNp8jaaG2503bWf2EVFsqWqAjhQM8p+VrtP+X96BFxbg86?=
 =?us-ascii?Q?VxJETRfjgklbwkGeHqDhwRPBlqLoc8wQXs71/PMhqto+n5s4O7iXR9Qg0MrE?=
 =?us-ascii?Q?+h3xNhi7nApCuOJ93y3ek8Jche4XlZONs9uVXSyq0IWBk3HaWmcty6QK4MMX?=
 =?us-ascii?Q?LXWcEXyIj2fm5RS/GgRNOJRadRIJkZ8FVoNoZ9mnxnTQo3lkp2t2pjjev31G?=
 =?us-ascii?Q?Zo2HtzC7aUvZVSU9Wr1aymwXJ/4I7IaR3Ray28TEBJw3knbmXWakJtaKU2UU?=
 =?us-ascii?Q?s+IMlsUdx09loGHYtkXe8Gfj9GDEWuw49pmRhvbHtxQ/TOAlIRa+YIMq2sVw?=
 =?us-ascii?Q?x/Q/80UJVFDL2+WK0VQSjFgfGaxuM1ivr//pgPfTRGho0u12bF1Quf6vr82M?=
 =?us-ascii?Q?MExYPFSqtjziMeqUrWr3rY1QnxMpQYdD1MhzSaYvrKTPrkA7UPsza4FMWNnJ?=
 =?us-ascii?Q?WY6WZGRkSYwHLTtgE8w5dw/ygGpH0K04AjoCDK2ZgeqYD6N3/8r86gkPDFkl?=
 =?us-ascii?Q?S7l2Lk9JJUmyPVgcIoJJws9jJWzuB2497Z+lL6AdHRh2Y3AoNU94T/9Q+8dl?=
 =?us-ascii?Q?rbr6zPHDQe6SdHSbrStKgz9TIvzog/Z6InFkgjGyA2t7bIga/SjU5n2zAvwh?=
 =?us-ascii?Q?u5w4atR9zqrIHIu5S2KjXJM2TMiML9DqUa/lz/xxBdqrXXsA7F5ISsr6Dwzp?=
 =?us-ascii?Q?TXUBq0vKxwDoCjZduBG9Loxos8N91D0qEOdwY9koyqVZxxTVfA7KhaYUiKyL?=
 =?us-ascii?Q?zCFq7cEPAK51136P1CtOI6MSD5FYWx4f0NarXoUaCstHVsVqFvLUWCX/7OD+?=
 =?us-ascii?Q?/cd/jhUJT7djrBcGEur0+ekoKTK+CINO9Zah8X8LZTtBGwIqLF18BaVkHkWO?=
 =?us-ascii?Q?iM/yJGEqFRzTr8BltKyiHg/m5XRx3S+g5CCgQrdCekdVX7yLZSM4l6+YiRGL?=
 =?us-ascii?Q?HihU+Au2QPuZebcsetek9RhFCWobF+/pKVTXmQXdmui9xHSdOTpHdpfzXICe?=
 =?us-ascii?Q?sZSaMyx/D7nR6YtJfFer++P3Do8ZdlSx2oCTNlWQ9u8t07ptUYKehQhyUkVv?=
 =?us-ascii?Q?YXSZ5uW8iGZxgxmW5HGC2VL7NOCfJPJ+aY48Ffl8yyT2NVB5VjXq75iyZ9vH?=
 =?us-ascii?Q?JcE9I1tPnByV8vzDd9PUt10/zEQJHBCcS++rDbUh7L5wOz6f1YQiVmzaB/Tg?=
 =?us-ascii?Q?gtPW7gOVhvXCq4zLf5JhqUUSzIS2Qha4kHPcpEG6HORBTOaZ1jW8qEhZOwDP?=
 =?us-ascii?Q?v5XIfkmoKkQxhEsWsQ61OaN8yIE/IboGZlblt7OwDhHoO4Ig+HwH6Z9WvCcY?=
 =?us-ascii?Q?Nj+hAKSLebsOGMMgIat1eh8Z62ThejEIls6rIt2rN8rHlvCJb9ZDrKRpJJio?=
 =?us-ascii?Q?uuySHMBcra/ffb25+L0c4AdvT4ncfNCKI7bSyQdRY9SsEfaDHQPperaTjpMb?=
 =?us-ascii?Q?Wr2+4O8vgyUH0F7LWGaFOaA5np/fN/u6/YLZd4zjlqX+jNyMAqJvuFzSEKqg?=
 =?us-ascii?Q?58LKTzCeOIVatPnARXte1o9DA7oruusFJ1yEfkUnWT7gRicvVVY0N5PDV3bg?=
 =?us-ascii?Q?/79h0DIzTQWqEzahbiLOrhUUmNhZ09wnfL2S8xVOgZg22ze7xKC/2Z0isC+8?=
 =?us-ascii?Q?L1edDnnjktOo1Wc/Gzc8c8wzVImQvraIrIKJ46qjR+nNkGhEK/TV8ArMlYY8?=
 =?us-ascii?Q?Bn60h1fh3J5MzqwNG+i/Oge97RY0JjEmrVYqyZz5BkdIntXeZJBHmIyZdzzR?=
 =?us-ascii?Q?Qz+6j7RimGCM1Dm/zlqteNEQpdRixXOU+C2YiA8CSVVkFnPX7/j1?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eeab863-977d-4258-7783-08defc2154b0
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 05:35:21.9471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gxXKDLCY4v+dVMMPsGYIYF1VI8TJKXcTabavN2+Bktdj5aSTnXQVzp/PfuqsujqPry+yG39rrPIqte9ToSv5HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB2996

Hi,

This small series fixes several TX buffer ownership and queue handling
bugs in ntb_netdev and ntb_transport.

Patch 4 first appeared in my "NTB: Add direct TX/RX using PCI endpoint
DMA" series. Sashiko later reported the same pre-existing leak while
reviewing another series, so I moved the fix here. See:
https://lore.kernel.org/r/20260815032932.151F11F000E9@smtp.kernel.org/

The ntb_transport fixes affect buffer ownership and queue handling in
ntb_netdev, the only in-tree ntb_transport_client implementation, so the
patches need to go in together. I am targeting the net tree for the
series.

Dave and other NTB maintainers, I would appreciate your review of the
ntb_transport-specific changes.

Best regards,
Koichiro


Koichiro Den (4):
  NTB: ntb_transport: Recycle TX entries before client callbacks
  net: ntb_netdev: Fix TX busy and drop handling
  NTB: ntb_transport: Fail TX enqueue when the QP link is down
  NTB: ntb_transport: Reject oversized TX buffers

 drivers/net/ntb_netdev.c    | 27 ++++++++++++++++++--------
 drivers/ntb/ntb_transport.c | 38 ++++++++++++++++++-------------------
 2 files changed, 37 insertions(+), 28 deletions(-)

base-commit: 24ef02f934eeb48830cff6b739abc3c62b1d107b
-- 
2.51.0

