Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020099.outbound.protection.outlook.com [52.101.229.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7D63B52FF
	for <ntb@lists.linux.dev>; Fri,  9 Oct 2026 05:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791522652; cv=fail; b=lyg5od/NAOqNM1mgUlrYovpgRZ7dFCv0px+PGz56vWqFLKFCyR/ZlJIIT6jS6zsT0auDEfIyH9m+itixj18cqq0/Z74GHmo4oQtIaNOW5WDhSsK+8rj7FkYzML6VDZmc0lMRiyq98ZqBVUeqvSmtSPWSYYuIXG9dKjRJrSt8BPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791522652; c=relaxed/simple;
	bh=I/3vB9hG4N0/tDJrNnhSOFkuX2L4u6EFEc66CUJdKoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gGJ9d/mc77+w+0HIVNY0dIE4EXrU0t/dFAJPTPw/N2ZnGPiJzE7u7Jv8wK4O5tgy6JSCxCK4c0EFhhdhgTOYfihiITUmp+S8PuSZdgYkx2zLu8eQ4QJ2/OZKHlASFuwKn5B0+OZ/8b6R4WW/GFZ0eRuAIySp2fhpVylxgunNDpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=EPRpQ4xs; arc=fail smtp.client-ip=52.101.229.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="EPRpQ4xs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KkUfU8yFlA+UKRPyIxAA9djtOSrk0x1pkRI3gVtA6BwrjRQdpGiriALOtRkvRScbuwGnUEAwzGHpt1RUr2BM5lIBAU1UW7M4uxN7OcsUnC6xHwmHnzo/ItUVWXuz7uxgVV5z5tYVaUT3HS+fFuDKv0EgSjqGpJF2u1+iJJGJFycWS8vb4gaywE4x1UVMJCg3FIaaz0FMLmx71+UHME5CmWvzYy1vwEHQY9P3SqwgBcU4PQNYcHw5t0LVHXNE5v8hZzN2EzPU4pX0N1x54zU298m5L4NpXJ3nyQd5GUzqvqu7BMkz8cO2RsdsX7igRwNKC7oHIW5tHhZHluhVPAz9Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0KAeD4nSxpxsIIXzgu5FcSInM1QBAhyB2jkDMjz2aWk=;
 b=SxCX1pS3FW+peSMw0zP2c8SvJ2z2LNBt0Wz49hqOiFFUP8kLSaqwq3w6plRbh7a9mY2A50QCMP8VNiWdPwqPb9+5NtIrBai4ARaat954icbc9d6nriCf6thH0UH4zO8xyDoXPimTkD2gI0KYHXIqL2K6mYfCkuBlFFZsMbEYomu6hlk0Pu79GzYrNyolPDI3jCBL+J43ddp1PORWUPPW41AQGKyx7WwFh6U7xAhXx2787fxJfWACvZqjvLdKZwu8QOl+HDKnVzY2uiy0HREY3dlnZ75r7uMMc6BTIq2qevqGkS5ru+RyeDIPLLF+0ZYv8zST/IWjv2BUQZ0dtfpeog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0KAeD4nSxpxsIIXzgu5FcSInM1QBAhyB2jkDMjz2aWk=;
 b=EPRpQ4xs1KZCiLQ5cMLpb38RNy9oLSB+mk6lMIsz4srf6M1tj/GBnFZ8Z1MzAEXN7dNLfXEGML85+rDJp+naVxSFnE/8EUMWtffYwgBVWJjr+RrqwpPT0/bGPBOHrEsaoMj3vq7WE17PH9AqIlLH32czmlsYf+tc9TFZ4vuK1+o=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS7P286MB6603.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:42c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 05:10:45 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 05:10:45 +0000
Date: Fri, 9 Oct 2026 14:10:44 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: ntb@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 00/10] net: ntb_netdev: Preserve checksum
 offload across NTB
Message-ID: <uqnpraei5manox6ceeytwt6asphqipjc3cpt4f2hf25kxnwqal@6wyk4bbpaboe>
References: <20260914084838.2158249-1-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914084838.2158249-1-den@valinux.co.jp>
X-ClientProxiedBy: TY4P301CA0029.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::12) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OS7P286MB6603:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e0c62f9-f161-4fe0-1fbe-08df25c3ac85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|23010399003|376014|10070799003|6133799003|22082099003|18002099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	p0M2cqpr4TVw/mlJCDnwre+oRTc2siYaAd0vMoL3N/k8VqbeXxfrj9EqaUcrtdPdxMCqNmJj+5TGdOIpv3J6gWomjQqicb3BRFTDvWKK1y4EGcW2vU1rWAWNUAjcURdDEF5UTFsuCpX3RZYkn2SHWuOb8GATdS4GrF9JmXBX7Q/0I/prCDeGeoM7TYw0xJ1dsmdO+1IXYQWHVo52Yn0/hmDiWIMOD7OV4xeihsrH4qkisiM5eeTNM6syCvW+xsr1Es7q46oC6ofdXamTjLms3CttaRh4fUesHOOvTBkCnUo4vefY+Bc0t5ZP4UZLAXGrpYS4NMqsbS1O76cmBDcLomsJE96kL50Cz9I5jKY9Q5dnq0U7gQ46RVqojKUgsa0XApXpMr8UlrNdHBNIU59V8yMGGtjIy486YZkr+AGDkOsrNlgDe7xKjQJkhDuua+1rJM3b+qV54mgNA3vJhI3qww79tONT+f50Lqif+kK+A6LHVuBbJVoZOi6i8uMbthacMO+cGYFL1EdrQQIpWYXWp3pE414ukO4erFTC2kYbgOjiZue6uoY+0WtxOXYZDH6t84A+2hRAwvAT4Z8KyUUySCee28MHXrjddsaoJQxscrNeNjNBoAF9hjnE0uXsUz0g
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(23010399003)(376014)(10070799003)(6133799003)(22082099003)(18002099003)(10067099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EsOPQzDzqhYfhu8iwgl7Zp+WMRJE93aOGVX1pReYb+AN/74odSa7nJwoPwuV?=
 =?us-ascii?Q?xTmlCgmYQUwP0LSfC3AQY4m+Ptht0maEaxiSGjx6vwe4iJiuMHSGKIu7Jj/W?=
 =?us-ascii?Q?V/L9elVBaSi7CnIwMc+4zCKNru5T61I7be5fVh22KJHH0F/kEalYcJlnpACg?=
 =?us-ascii?Q?b7ckQZ9X3WSH99trJyoYbY+7BOd0XjZ4c0QTzE2p1mw8/Qh8OkQ3QprauEcV?=
 =?us-ascii?Q?G5vPwktEMoXdwRSQiqHB6NFw4EGFlOdEMfSBZ2s6z8//hUhqwoahzkFdJQH8?=
 =?us-ascii?Q?6OP5ZGAGhOE6u6jyiOn6lIZbBgfhnKARTKecYb6GKDe8P9N7JwC5Qd3c2U8x?=
 =?us-ascii?Q?bFc0UWw/ky06cjQQqAs1m/ZoDEg+5L61gT1mO4bI4zrvNxIto+ElsL4jwOg/?=
 =?us-ascii?Q?AlomkBNAUJ+7SgE7XL2424HWQXM5S94sOSaDWyv6UVUGG2gAlNMz+Cn79spx?=
 =?us-ascii?Q?HaUEpsJHzoAvemohoBa5O9UjlqEzafi+nmRaaAD4cs9LrrYrLOo/Ez2/clWx?=
 =?us-ascii?Q?qTj2grmaCG2Rjdn3XMTUGDaIhSg+/jdvXMFCz/+FlI8+nWkuJTJbsZSDqwqi?=
 =?us-ascii?Q?LvzfstHUM3uPzeqNRu6EsH89flLKz3yat8mLe6ABsOoPrR8cIzce0x4ULNZW?=
 =?us-ascii?Q?uTiXpvfbBKBup8iTrxt1azkbd6GVQAIUGcPXszKlSeG/iOeoX6doZuVItIzZ?=
 =?us-ascii?Q?P46TYo1qnIrEISGtkLt57zOKdK0xWev3ffQ9m8sAMmG4cjCbuvtdbwLSC66T?=
 =?us-ascii?Q?jmscXK2kk642vwS0Jnnzg6SuF5W4lMU4Pw+MiMyqpj8JTzvV4Tf4pQW9erto?=
 =?us-ascii?Q?7IIzWVLvjvLeNdAHIvQlT2hMhFcp0Yn677Zi83EZh86AmiImUKO3RwUqD5rh?=
 =?us-ascii?Q?/Q8SCcjpco2SRGVs/33fReTL9lYroxU56mkGFC4xSAdGzZtMHymxx0n55evI?=
 =?us-ascii?Q?0zkx8K2vpVM3rjpdjDjsivAsPTQ1MbkYdir5hVJgm80rj+j0Lfan1e0I3Y6d?=
 =?us-ascii?Q?Zb769rYpHMxSGBB6aw+VSC4aJMR27m5w1UvH9LtIjNg0gj719s1q4C7MhYDB?=
 =?us-ascii?Q?bHQPu2Nx7NtIj0RwdfWiQrmXbQkxQigX5OcnDRJvqHNN19kXsOprzdrVjbX8?=
 =?us-ascii?Q?T+n/DvM9wVr77VNKgdw99W7Qbi4axQr6OAcrQTUrEVKVLIbdcOrkF83Co3FR?=
 =?us-ascii?Q?I4w54kwasLjZXQkyI6KFO1SNUXKq0/pyL23EPkt2PhMvUCst9w23vfAZuIfc?=
 =?us-ascii?Q?5SqDt+dReFAteNu4M/5inINL04iJvPVI3vbI9koEnSa30MZ2tuKR/t8ZuCWb?=
 =?us-ascii?Q?i2jlkw6XMaM5nFPlryjoNUh7du00+tHmfOIQy+8jCM7U/4BKa6D5r515UPCs?=
 =?us-ascii?Q?Zzwgs7vRFZTudIW7J/E4AQnIqUfGFqll1LuiPfSGcnjsLQ5ZaUozMlzzXvcA?=
 =?us-ascii?Q?4omp0fGe9MaAaqjVjEyUn3xZT8FfgvMGGbLEIl8dIUV9jZVmosDt+/DI178w?=
 =?us-ascii?Q?/JxtT3nL0Vale8fOmHkjXmMeSElcFnTM9yMmDoU9RmifGj7l2W6U5uavjmKX?=
 =?us-ascii?Q?yVKHXxm+EoNmNLTIelNYLVQJuu6CVh8xX6pnFyQUHYA1yfBsKiRTEezKj9QQ?=
 =?us-ascii?Q?N8aI4K971PEkZjXk2fVznqdqSvnRCBt3QviAj6rJ67qAYGhBVxSYZYWNUvNu?=
 =?us-ascii?Q?1b9dVoEYdDbQeF/7L7t+AxOyjWVMBFr+afo0CY8yKEl98SiqrQYqNJS7soZi?=
 =?us-ascii?Q?kRwBY2mvQaospbSGch2c7+YhFgTLJyv1d1ZwZOKcviH9WoYko5fT?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e0c62f9-f161-4fe0-1fbe-08df25c3ac85
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 05:10:45.4330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HlAYvpzrhCNXQFzCWxaH1SooktE5K6zi0FjprFDD1qB8VhGbq6vO3XsU/IoU9pCamOEtyhsrFO08h18jiUBOWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB6603

On Mon, Sep 14, 2026 at 05:48:28PM +0900, Koichiro Den wrote:
> Hi,
> 
> ntb_netdev may be used on embedded systems, where CPU resources are
> often limited. L4 checksum calculation can therefore become a bottleneck
> even when traffic stays within a trusted PCIe fabric.
> 
> This series carries CHECKSUM_PARTIAL across NTB in an ntb_netdev header.
> A per-payload metadata bit in ntb_transport marks its presence. Receive
> support is exchanged at QP link-up through scratchpads. Peers without
> capability exchange continue to use software checksumming. The feature
> remains disabled by default and must be enabled explicitly on trusted
> links. RX checksum offload settings stay unchanged while the interface
> is up.

Thanks to Joe (and Sashiko) for reviewing v4.

It's been a few weeks (almost one month) since v4, so just just a quick update:
I plan to send v5 once the NTB transport fixes below reach net-next.

  [PATCH v3 00/15] NTB: ntb_transport: Miscellaneous fixes
  https://lore.kernel.org/r/20260928152550.3354675-1-den@valinux.co.jp/

Best regards,
Koichiro Den

> 
> Best regards,
> Koichiro
> ---
> Changes in v4:
>   - Move offload metadata into an ntb_netdev header (Jakub)
>   - Add an RX entry completion ordering fix (Sashiko)
>   - Learn checksum support from link events, not RX callbacks, and keep
>     it per QP (Sashiko)
>     https://lore.kernel.org/r/xsaocp32a6siggahziu4jqbwgmdasmp6v64pd5aujfkoxhiqws@n5luestlntzc/
>   - Advertise receive support only with RXCSUM enabled. Drop
>     partial-checksum frames when it is disabled (Sashiko)
>   - Keep local QP link requests separate from peer readiness
>   - Reject short RX frames before parsing them
>   - Factor out RX packet and byte accounting
>   - Add a transport API to exchange client capabilities at QP link-up
>   - Keep NETIF_F_RXCSUM unchanged while the interface is up
> 
> Changes in v3:
>   - Rebase after the related ntb_netdev fixes landed in net-next
>   - Avoid counting RX checksum failures as both errors and drops (Jakub)
>   - Reject csum_start below ETH_HLEN on RX and fall back to software on
>     TX (Jakub)
>   - Use READ_ONCE() for hdr->ver and hdr->len (Sashiko)
> 
> Changes in v2:
>   - Reset peer checksum capability on every link event (Sashiko)
>   - Add prerequisite fixes for RX ordering and shared field endianness
>     (Sashiko)
> 
> v3: https://lore.kernel.org/r/20260904052134.2970111-1-den@valinux.co.jp/
> v2: https://lore.kernel.org/r/20260817064916.13278-1-den@valinux.co.jp/
> v1: https://lore.kernel.org/r/20260814032913.3558500-1-den@valinux.co.jp/
> 
> 
> Koichiro Den (10):
>   NTB: ntb_transport: Order RX descriptor reads after completion
>   NTB: ntb_transport: Use little-endian shared fields
>   NTB: ntb_transport: Order RX entry completion
>   NTB: ntb_transport: Keep local QP link requests separate
>   NTB: ntb_transport: Exchange client capabilities at link-up
>   NTB: ntb_transport: Add per-payload client metadata
>   net: ntb_netdev: Reject short RX frames
>   net: ntb_netdev: Factor out RX statistics update
>   net: ntb_netdev: Introduce an optional packet header, ntb_netdev_hdr
>   net: ntb_netdev: Preserve CHECKSUM_PARTIAL across NTB
> 
>  drivers/net/ntb_netdev.c      | 191 ++++++++++++++++++++++++++++------
>  drivers/ntb/ntb_transport.c   | 177 +++++++++++++++++++++++--------
>  include/linux/ntb_transport.h |  12 ++-
>  3 files changed, 303 insertions(+), 77 deletions(-)
> 
> 
> base-commit: 879e280b8486d4612ad1aa050d6fada2dd80cf1c
> prerequisite-patch-id: 0000000000000000000000000000000000000000
> -- 
> 2.51.0
> 
