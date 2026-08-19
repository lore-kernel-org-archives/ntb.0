Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020088.outbound.protection.outlook.com [52.101.229.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7CA2641C6
	for <ntb@lists.linux.dev>; Wed, 19 Aug 2026 02:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787104897; cv=fail; b=fQrrRvjgKpkumTeFrbxvc+3HxC4RLLdKR5h0Wv7uzmx0RE7cGsnvD5MAVqYs2/yPARg0L2i80SupTgVNcUiGL8qMzd3ateV9N0Zy2yYyHGaQLcmpNaLIEGS2ixjBfUo7s5NrwHVtVkMCWOlsRBRJeLoUOyusRWbR5BZw+qSdeMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787104897; c=relaxed/simple;
	bh=+XDK/dkfxBdhhwgJ/3lJ94K0QCAYmAAvx0C3pONcm20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qC4tocq1MAkiBRsYyvwOtmC/W9pts9y1IQQbfuVuDdjOHIllgiooY+hXwGcu90KlgVictPGCLuy/ASAFpiT3+IgQzfPswwd9mWT8lnBhZEB5VPgueHKOCcy/jHiWGH29qjMM6X2WfVl/eJInczMw3RqKUNxVHyiRamnqIBVKfsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=fd2fXkgv; arc=fail smtp.client-ip=52.101.229.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="fd2fXkgv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MArbJ4Tese6+6o6MCdM/GuzZGV5JP6+QzTRBiwG9L8KnBrzDq0nzPWVu9fep0sGF+9csVmG3ObntKCBgrCudW471OZnbYN1TCh61hKuqkQ88tW80Voh6W1r7BVn27w9mIcmtow7xL48i+bhOALtoCFQ4n/k6FF1FppTwi4vJOw/KU1Pp+OGJDLSkYQVsc0bhVrTihT3/NPwXxMpHENjI6y53W8DaGFMLJvi82ZE5rw9RfdzXikxK8g7kkF5eZk8BeE3YswvQ0j59pfd4wSuXRTpUUztd2a7/KvyXgRh5mq8hr7JlIh9kK9HqL+PdiEQRWGdx/IDLjBZgDSuV+NPEBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WHyDByujyzCpUXZGk2s2SfpBR4RfJ/lewTRhirjBPEg=;
 b=KhjOWOV+N8IQdJlxNok6b0C98SbWzMgUPKJjTH13DMik+v1qndk6PNIOS3MfoDL9LBlE+pKkKuFsMmOqbdUjIWyETRfxUvxz+nFZlXfJsCwREP2tNZll0JXVzMYnabXNMOfKe2LOsNNx2Xn1C9j+COtk6xmLWNykpRnQiQP0l5oGyjeZliNmoqrWTk+kvJrPFXV3GY6VJB1N2zefQ3V9soJAYIjxEni1joCeGDDMbjzdRER46xE0oZJE3Cgq108gYJAPmcET+VO4gJ6efajojXktcw3Ce7+pjPfi2Wrh4CSkuYpWHqY/gHXC5IpjlrinpLIPLND0/8SiWc6Pyq9v7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHyDByujyzCpUXZGk2s2SfpBR4RfJ/lewTRhirjBPEg=;
 b=fd2fXkgvSU7Y/S8dmw95kn9PWg2yrHrHTi9FSWsZb90R7f9IGxv47QOSfqYOMr3bADp1ZgyXVLm8wn8jWu39uWxdAB0R0rrPOMViuE0clB28dA2O9iIXcVKd7TuzXXYNYRSEtz1AWZAVYxgVEWqYIevH8GJGf0nKwCJOzD9vOV0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB5724.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:3d5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 02:01:32 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0315.016; Wed, 19 Aug 2026
 02:01:32 +0000
Date: Wed, 19 Aug 2026 11:01:31 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, ntb@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: ntb_netdev: Preserve CHECKSUM_PARTIAL
 across NTB
Message-ID: <22flcbfyvllwize3usztpd6sm2n5xxdxvzylalhwm5pet7qinc@drrsy6kxjma4>
References: <20260814032913.3558500-1-den@valinux.co.jp>
 <20260814032913.3558500-3-den@valinux.co.jp>
 <20260818092938.4121c220@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818092938.4121c220@kernel.org>
X-ClientProxiedBy: TY4PR01CA0116.jpnprd01.prod.outlook.com
 (2603:1096:405:379::16) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB5724:EE_
X-MS-Office365-Filtering-Correlation-Id: 4caba010-126f-4fcb-0f32-08defd95cab5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|10070799003|7416014|376014|56012099006|10067099003|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	qLqIr42Vgh1SBlIbLDGHqn9Tej/KtjdBj1te7UgVXe5lQZdBzkGerqGpmg3o2KVnYB72uruzS3IEQtdIQaeC03mRci7PpLVx3fo645/0jFpcb8+KGmbDsxzJgFGEjOfacHENauWab8S5UB9Uxgl0r4AWQv7hYIM/U+CVZ1gTVZsQJoLiv+QOGXBDf1fYWfRaEHfOQw4BE7CNNS0EbPBIQf6DZXyZkB7JusxONDWvFBl+Ltt0vEaaayw61ggnFK1PAbd6hJrdKN5gA0kUqroux55/dRyyGlXs02nj/1tP4FjLMbGj3o5n5uwz1RN2VUeFvufNHZvkyXef5AOB+qYesFuTZJoBUv+lhnZTmNy9jjS/W3t+DLu2pCx9NZuWLFjoV56+nKOwQ01EIMDEKwkVzkU9ydaRSzTuopG9ZQ05sRgaSnjX5uRm6HxeXsgPK02dG0dl0vMWrEMwxttzIkuLJAFtp07cEpP5pUDVLYdKGj5zhTcOMiVDw/UCSwBTlYlMxzjtXwVcONFvUFnsb6xYTWqvmElXOwFuHj2CWV5Q98S+nbOh+AGRYBZovPub3Oxd5n9d5SYMxNTKn4ezquBHlD5UOv8lndjnHfU7jQFLAx19skkTazxOHgJQx17eJlygMkTe+8hZYwEkM3F1mnWG4GEUVTs3EHkYEGTakqH2mFE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(10070799003)(7416014)(376014)(56012099006)(10067099003)(18002099003)(22082099003)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?81f4mVb1QUKjDDiMqCosZq2QEJ7MqO9pYYuhr3Ffa+ryXvGE8+a4G2bQGGYU?=
 =?us-ascii?Q?9Ic2U8WwLHhpI3HJ8teX4C7HzAFnf2GE7PzLeKVgTxu4dIOu93AzCHw/yvRU?=
 =?us-ascii?Q?pAv2z0SrqiL+ih9KdPoXWMKJjQyWJ/kKI+54Ayy1ztBsGI8g8w2pzlP/6B81?=
 =?us-ascii?Q?43LY5v+j+Epq4yrl/KLUCvqulRnOyHSJ8lxoZK7Qo5VekThwKvekBmrYhGjV?=
 =?us-ascii?Q?xMpbAzSBZQSW3hxrros8kiXCooNJtywuOWwT7trNwY4S9lZWwnZrdCdPQQht?=
 =?us-ascii?Q?EcXb/m/jIMRKgHjXfqUx+6VqXdxDI56ZJa4xTF1IRbdprFDY8P0iOsfysbJH?=
 =?us-ascii?Q?a9rm2vUfS5Yp8vftuvMtAfpoLkU4RA7gKTVl94MwYv7GHVfudx07yiJCLKpr?=
 =?us-ascii?Q?SHiwbuZTcuH72PfVzhMzDHu9Y/6r/CReX0SyqDU2GMBbHM3xlZIEcLE5HUVu?=
 =?us-ascii?Q?K9T8RzMctNtNqbuigfvbXb0fFTyS7/3mnZLiIqlS0lLfRBCFIAU+LnIln+jy?=
 =?us-ascii?Q?qZH3zmWyY2HjSSfTL1hZoKt+xpH8nMJZoGhtvHuCRv9yStjXEFCo1No3i9nX?=
 =?us-ascii?Q?e2nD8UQvdVvD9IiVAdxgWgPqQrklu07/lyXnUuQyBtl96oxGVtE35mP1rxiR?=
 =?us-ascii?Q?m3SxPw1pP5ih9NPagcenAfqUIQwfHRQMZ8E6u0tXN5B9wgag74nWC0Fxsakr?=
 =?us-ascii?Q?PpH1+zbjyIqyRmaUsI6XmCrwltWGhWIq+6/ecqDunT6Zja4xKwUwfKPKYNp9?=
 =?us-ascii?Q?RPUIUVrpjXId2Y59P7Zg4t6MgqkMbKFl/r3eXBHSZlyNAa8Pwxqti1vAJa4a?=
 =?us-ascii?Q?ID+E52SOZzvG1k7LkB2jRWRXDfxQYUWEwbn216kfjeSaftzY2eIGZkdXvXyy?=
 =?us-ascii?Q?uFZBrSqh10liGFvVwvKBtuhbYdHv/eoQAi2eLuoQ1Sf39X9p3biXu1FnRacm?=
 =?us-ascii?Q?ycACqlWyCWvO33E8geY5KKHeioBdHyHBV6z1cUh27VKjWkQkR1A82zWinZT3?=
 =?us-ascii?Q?mFWnkC3Nf61R+SeObNYz4/Hwe9nFSbVUfJzAAu2Uo1NYOLwAWrZGM7pWNKYT?=
 =?us-ascii?Q?04BcJ3Nb7lgVCaPB05wo6HAbAPdNKEtXPwXjGg6CCie10Yfr0IIDSWLFxvgk?=
 =?us-ascii?Q?bg96TRgkRprKjlsUsxPgFUCsLGPzAnPnMIjiW45S0hExvuTlTDBJKUXAnyED?=
 =?us-ascii?Q?bbKaLBpyh/R8aGt34/mwdOZRTSCxSrVwLyd5bx2Xkyo56UviCXIa+dnAOH/z?=
 =?us-ascii?Q?QVtSBlH9swzfsI3Q4lXasdJ7uxfXOCCOyDyGS3Lz3KYD8f45gg70peDwD4yd?=
 =?us-ascii?Q?Zs5t0z+uvWjd3O6GC+PaZVJr4+HGn17Db7/huONSaHM1VeiDOmGNI1PUrY0z?=
 =?us-ascii?Q?AG8NOh+mMpg4CNqDbY3fZlkUk/38apmgC/B8ZlkEL3zTlg63nocAClvKdmTX?=
 =?us-ascii?Q?lFvSk40eC0FEfNaAxlrR93QzUqTm6yQoa4GKIw6F+6pqdWnUYnaRZoQFyfkQ?=
 =?us-ascii?Q?c1Da3CnKZU5V1sWUEtjIKn+3TH2WYfr2xhkNv8lu8Bg+uT9/L1xi1nW1JbY0?=
 =?us-ascii?Q?oysMc/oi5MFBXrkyYRnx54F799+lbV55Nwdj/GZoQS7RlMgu4HaSw/NPSpOI?=
 =?us-ascii?Q?zuxqpSdG9ztZSm01ptFt89CzsAg+bDaOiuh8mziAbVATZ67I4jJmHZElyRH0?=
 =?us-ascii?Q?PTHXDzE4R4x4BFkU16oBkc2JMdCa4a1qpVXPViJsgSF2JVx/1aiu+hDr00F8?=
 =?us-ascii?Q?Wiuz+Y1uNiicR8T24vAH1A1vKTMUMIlj+Yj/cqiGnJ+5SGVXJtsB?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 4caba010-126f-4fcb-0f32-08defd95cab5
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 02:01:32.6901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kluxqosxIO2+OshHhH8RRWy6i2DwE2BgZo5d3nsUL0Iz5oV4G4YNmrOPbFoq7TdbUGdXmhvTCJTv9kMTVV6siw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB5724

On Tue, Aug 18, 2026 at 09:29:38AM -0700, Jakub Kicinski wrote:
> On Fri, 14 Aug 2026 12:29:13 +0900 Koichiro Den wrote:
> > +rx_drop:
> > +	ndev->stats.rx_errors++;
> > +	ndev->stats.rx_dropped++;
> 
> Error implies that the packet was dropped. Could you first
> iron out the double counting this driver is doing?
> Please see the kdoc on struct rtnl_link_stats64

You're right. I'll send the accounting fix to net first.
Also, apologies again for sending v2 while net-next was closed.

Best regards,
Koichiro
