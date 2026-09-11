Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020096.outbound.protection.outlook.com [52.101.228.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23D138BF72
	for <ntb@lists.linux.dev>; Fri, 11 Sep 2026 05:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789105304; cv=fail; b=t1RWOVwz5ulDO6sZ1Ns+aQSaOVXb/zIgMXWaOOHoa3oOFeHcMJ+TOhWUzFzECb5sI3wtHP9AN+uUaCNmitIHKCy2oKuq07TzhyYjSOVGsusbUXe3DQpMiqgr8sfjXnnETk4AIITRn+eM6TSaqFhiSbNQOs8afNdpaUQHHOb7Jek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789105304; c=relaxed/simple;
	bh=MaSDfbUS6SL81ioaHFv7WyZKCyahKFNSayu0yG8Fu0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hSaVGGgJQq/cihBzQpSfyw77YgWybzBUyfsLk0AVB3eo+XtJX2vbGseBgsesOYaUoUlXNlASiH4V2r89Ebub81DvzDKMXw/sLv/xG+xvkyAZPOt/BZGz9NsjBQWpLK4h/AzAfGekU3zU1ghtoofXEoQvgyaYSbvA4cL/9leDmmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=PB9Ut7Y2; arc=fail smtp.client-ip=52.101.228.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="PB9Ut7Y2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YnJP5ANQi2isvLkzwl0QAnCfxuEYUlWWzYd5BeSeogdlX2S5rDJ7eh9iLUN7EObtiRI1VKm0a8zuo0eEJu1Ht8r1VD2BKioHekqI/BthO6ZyaGYW0n1BtJ16j9HoaNF1uM3R7ZXgxhwhXc043RZ0l5MipNzs6WvavdlXJRPfkwZrhMv5N4JWxE6Ut+/DGKdkMWethwh0hCAqLAIvWOnPRlDfA0EiFFOUOOmPPVWJwYnRocXQQii1n1zdwKoQm2Iq2D6/Uis6lLu9aCvNZHlanRBP8reAkSio+dV7XrSujMxrFbfyzW1wZ6vTQeqBfwaQnvRS5wmGvVftMyRhhPIviw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p15ABz57oXJ9iOO6MBpt2C58npso+WRTIHa6hHaxDTY=;
 b=gdgwgijkRfiyEhCsvAdfW2vno1ROM8IYjUwOdfoicOqQNSauxvz9v9sO+Gu6a1N8x5lgf3xH0K7azFWFVupcNNDoRwRIoNwQ1aLdJQTMRW67DNjeoHd9jfETJg2HHMk4da/dyMY3c8l7r3mlqGH7LRPDs9ciU3aXTdJKQ7larVy8Qi8ymmlyen8F+JMbxhsughHOvdQdIVBKQEdcR18hZDg9VHO9kRT+f6FvD4rolilPCZoGZtOLwnaK1oJNZ8mztkI8++U65nh4+/7mk+FBFibJiSPuVI8iahG73DcCfnCguq+6Ul7OCbS3tBCDJ2s4OZl474BpqGc9lLm4GxG5eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p15ABz57oXJ9iOO6MBpt2C58npso+WRTIHa6hHaxDTY=;
 b=PB9Ut7Y2RcgrUOBJEP+BClQqPBDk0f80hgImk3TyVbTcI7JdlMNtQmgfWPoTWQYiLoJ34Ts+RM4zvfT5Cj0rwBobcwT+yV8YZH4u0lRbhNs4pqjbs2+goo7RfSJI9cU6BW2EzHhy/LDt6A7oC8eLSXtdIvKzHr9jb1wr0RbURrk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYWP286MB3735.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3ff::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 05:41:36 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 05:41:36 +0000
Date: Fri, 11 Sep 2026 14:41:35 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, ntb@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 4/4] net: ntb_netdev: Preserve
 CHECKSUM_PARTIAL across NTB
Message-ID: <fdcgcdcqbq32e3evcvpd3qu6dlrulkvbzkcug7omvfttdf4tc7@2wznkntscntd>
References: <20260904052134.2970111-1-den@valinux.co.jp>
 <20260904052134.2970111-5-den@valinux.co.jp>
 <20260910172047.167225eb@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910172047.167225eb@kernel.org>
X-ClientProxiedBy: TY4P301CA0002.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:26f::15) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYWP286MB3735:EE_
X-MS-Office365-Filtering-Correlation-Id: d054bc2f-e4c8-4aef-a5b8-08df0fc7583d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|10070799003|10067099003|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	oZEi2hsRmjN2ymuSRGHyByE9UQMdzflgoFAX2k1HEjwNw/qkjfZ3DWRSsCVmIwUSgBhx3pwolk3wU4GqZa2dA1YOuBNJK1HXIM1WR/0ll40/a9znEcfo3TSU4F7KWlRvBQO96srOzalarm4+xuoO+vjkaxxPCuFpqwHstf0bPRIV1omLvS41fX1M4rUcPBptwupj70KS9WGVbelZxVsBMiNAv1VVfiabD9W7VIORhH+toOdiI5GpBAoXP7qVvtqA7t0cOWDC95oiHYPULOLEEREdnaR9zLfoBudJ+4fm6m7YhVni7HMfkQUcZ1Nax9WUF7P6BuUMKjyrQwgvbYYPns4GaEbGpPtnFxJy1A/xwkQQtK+v7O87Jjzz/6Zv+YO1s2bo66fZIPv3xLvAwLH05gAgpDPKGih/w/DlXmb2diRxxEBIIsOynYKMkgxOxRE66B9xpHDwZjyhylJ+orh+xmeO35gjQCn1tO7CqCIZe8e2HF+v1eA4uagKp7q5bYLDiibmT+/K0U4xiwMCOIrEQHj/0TB8CLqiv3e2CGVsUrZOkZgN2nN8M3OvaxhPn1GEGHaByo3dBLYx+GvcN7QDuVk4JMBYPgFqmX4lfHlEznRjlKVJPEeEnSPIl323EWo/tl6aDUgkYESYivOmy7JSDFVp6e5QPxZtblHu4o5U/h4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(10070799003)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?35UqkvmWN6LoJEZUZpFVYAhR6gKgb1B7upu1r/lhR1Vo5mKbn9ZCHeV4eKUU?=
 =?us-ascii?Q?Lsynat3eVeUcIcM8jCxYlNSvBSox1FVtpopynbNF7R5YPB2dBiuxlog+2QLC?=
 =?us-ascii?Q?JM88XnYf970lcElkv1C5/DLOYpkWzgzJ5GlfThr4Um7qweowmYEOS3tHHfzE?=
 =?us-ascii?Q?rTrlsrw+d06lD6x3NK9VgfFt8iI+g5GAMwsBN1DBMLU/fcMermtAJ3O+HUaj?=
 =?us-ascii?Q?84CcZMLBcXzl3bBZ88wu4sHrEivwa9Mm+J4wNYHOH1re3vZQFsgLl8c3Kzyz?=
 =?us-ascii?Q?mqDjMTQ4/EsrPuDJXo/MQV/wxjQWnqi+UIIUfuZdFEv3FeDAZwjNbM/gDepP?=
 =?us-ascii?Q?iS68cx47bbKP0jx+76UTzVwY3MWyyy/3UdZhv++j4UVdt52y/c6KXXl6j+b8?=
 =?us-ascii?Q?u4uhfC+U02VWxHHC3ucR6AoF3Dz8n+ZlAr3+Vr3Id5ZUFYxm/GVsYwzbyecY?=
 =?us-ascii?Q?+Y73XhTxhOKiUGgbXAXDc/3KorMpn9lmP4trYbBi4NE76cOr0ul7/hVSkaLd?=
 =?us-ascii?Q?7NDRTWtH2mNFINxX/fElBRtsithq3hRpVU7gQnRj/1TWQn6fONWowoPFemd9?=
 =?us-ascii?Q?3Zn8+loQz+6fM5amPWMz+Tadn2J+xToCZYM25OpKscz7Mz+ZSD8DHq5TIuIZ?=
 =?us-ascii?Q?fGypPmBGw1/FcfWmduozAhkDG1ICfV0Tf1JHBQgiLqwdQBZj+MgRJEc3Ok+Z?=
 =?us-ascii?Q?ZTSk9GbXjjJOacSRvJAN04JXKhcuavGGsdFvpuJfdVBSxfUHz2EekyoHKcF/?=
 =?us-ascii?Q?aM/kPgBwajBjaklkTurDWbdmAh/0c1AOp3D395VQ2FDdeHWLOZIqfdqPpphp?=
 =?us-ascii?Q?BKS0J/dL+Uha0nfKbVsyDm02q80NMDFArnuw2K+n3+s6dODOoX3M4Pzy61Q+?=
 =?us-ascii?Q?qTgKPHf/4lQJppSfxMSjLPnKBpWwlUXq/sXsaHN5HiUuUyZYJr9Tig41GEvU?=
 =?us-ascii?Q?h753Up0a4DAflniCibJzFHEIf9axbiLVbmFyOIgT15P2qUTGlAgzbI/Xm5MB?=
 =?us-ascii?Q?n+ZoYfFKDeaA0pZywlFmHi4a7bxdC6pqo3lmBrKgSnyOSW21xSUFW2rxBVn2?=
 =?us-ascii?Q?kLl42At6CeOhni8RbYKl+fkYYadVu/HBwiEZypVMo9/a7nlsM8th90XxeWI2?=
 =?us-ascii?Q?e5FOVsBtjvoz3CGZlE/R+WmmK1iaYojC1vPnOTU2R5VJsQJiQSRQ/x8m50+0?=
 =?us-ascii?Q?u5sZHCVBa6Kw2p5lpguo6WhjQdGmQomiN/TIt5amDoGXtuw+3a7AgYK2pATX?=
 =?us-ascii?Q?GAZQ6BSL8mgrg5dnFqq7bOihKmB8ck0B0zeT8uiKOmU5mU5QRCvJN9upRr5l?=
 =?us-ascii?Q?zVrJoBlZmfh8oc9umLOyeoUmT48pJsMbJevYQVNNlxEzPpW3u7RWbWEMP2gA?=
 =?us-ascii?Q?XMtEUX458ds4Uh4DQwYekWcTkbPlpPrjdG0BmOAnrMGDb3FqlZb3pI0IWsgR?=
 =?us-ascii?Q?Cq1/9UkYDZT25UXPVeC9bQzEdbKA81d/rcJpG3Q328by4zd/HHLkdsR7pkTL?=
 =?us-ascii?Q?Ghebzy81gjg0JY8UGmjP8+Etkwo4ShyHleTJ6zDyP8/MTwVC4nDKJ/3ppDJG?=
 =?us-ascii?Q?PincsCQdLS9SZEiYolLibUW6Rod2Bhq9WTPDFEitY6gmzql9CWALcj1T4sh5?=
 =?us-ascii?Q?BPq1h1Ima9tP9jNhAcWRr9fp/PvBgQeAPYpP4e1t6pYvme9Afrd7KZxJc64o?=
 =?us-ascii?Q?RZ30wlaF9+TdqmwlO9v146oNJesF5rg0qxVaMMs7j5ucQYB0OYeu2Mc5RBST?=
 =?us-ascii?Q?GOWOVzir+ONS84AaxXreBVRLMSCyo/xKtCwU7UfQnu/oiwqnVcjq?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: d054bc2f-e4c8-4aef-a5b8-08df0fc7583d
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 05:41:36.4482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FRzzgAv8gO0NS1NrpNJFnxfDcFWa0SSCYPZ35SfHziwmukfnK06Dqh85rTmJJLvch3JBkacgp78i7NyMJ0TbYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB3735

On Thu, Sep 10, 2026 at 05:20:47PM -0700, Jakub Kicinski wrote:
> On Fri,  4 Sep 2026 14:21:34 +0900 Koichiro Den wrote:
> > Calculating L4 checksums can limit ntb_netdev throughput especially on
> > embedded systems, where CPU resources are often limited. A trusted PCIe
> > fabric can avoid that work.
> 
> Would it make more sense to prepend something like a virtio_net_hdr
> to the data so you can cheaply express more offloads?

Thanks for the suggestion. Yes, packing offload metadata into
ntb_payload_header::flags could become limiting in the future. We could prepend
a header like virtio_net_hdr to each packet and use one metadata bit to indicate
its presence.
(BTW, GSO hasn't been the focus here, given the large MTUs NTB can support, but
leaving room for it makes sense.)

Best regards,
Koichiro
