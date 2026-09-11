Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020072.outbound.protection.outlook.com [52.101.228.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D22749E14F
	for <ntb@lists.linux.dev>; Fri, 11 Sep 2026 05:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789105754; cv=fail; b=qQFxuosmJaotvd39YhILZKHEoye6nTwlQtagzjH/wgdSYlh97iUnEqlCrgOSTkl7BDtNC+bh1UpYILbGHcwW98f90DIbI33nHuMvhvRZROvCyORxkwG4wDD+Ofb/QONUKCgHl35J3YAuFRfq1NtJBbiA+0TDbdEgcKVm6vl2g7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789105754; c=relaxed/simple;
	bh=cKS3TyRIfQTIrJENzneyM/5E/2O9KfTNtEku+HP0Jlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TXXambPWi/FdE3CMgcpUGiMWtGewOwfT8BYWnY4lAR+m9UFi3I0J7pQp77sqoRhZElRaGUrgzrWQjMONImxkeTJfhNO1ZIgYVKEHdjR6XpiWW5Ir1DR6FakoqD//NsfdbZT6hMVEvEdENjAfo6TYgs+klqd+sfYbiPKGoIPHg94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=DGK1imvg; arc=fail smtp.client-ip=52.101.228.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="DGK1imvg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KZa8IZr7IiWPmi0FMKQzTgVZHzAoWW+nayNX2L8RrMAv6l7APpJMYmWAg09FFHIyhQONPTq40o2cFC68lB8Jkc6VC4xbuv8VBVdSY+TMHe/LALTmBFeby6bu1h7a0xG9Q7AU2NtqdJ4zvTXX0r8LghffmLA+niDUMymSqpxkjYav2zJQehpxc+Sm5z3RHAOdOjjYrcEUMeWbDRFjWVBBetNvgbyOLtzbgKXEuN+HfwKqSVwHI1JxL3X0N7yiJRgFlPaakX85aYYsjC+D99II3+eFmFdudagHl6//2h+e7BRVxDW63QveYmqmyWXsM18N/QeijTVKhSgpIV3dnaLEGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kc+XR7uFN9hNxifgbVW6PP6iu0F6hEekZDJmpVwaWFw=;
 b=vcxm9+fOxocV9X86LKuEj6VTQkWxkiMSvWj7BBBqY0mRU24sqeKTSKkdvTVn2PH/fMoP07w+SDnqEheFRBZvP6LI1b/5+TN9g2o59lALlPQi9Jrv8lISXkttbCnq1P+196rRtig+wew/UYeg2hc+WW7C2ryf92XF5BmtTjplfMHQmbfjOJPSiVNohPuC7xwAtfNBej11pEPTss6+nuO6CHCXHR7oAmMS147ZNyWDTt6ayb0J/FtmB24LUKAMl/kChmmNneJt98H7K1eC9bJu19af6h3ZaB4EBS1BjY4KKFB9/B/a75hvwgAqgvJQqqTuAVSDP/r+PnAanGOt7Wm0Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kc+XR7uFN9hNxifgbVW6PP6iu0F6hEekZDJmpVwaWFw=;
 b=DGK1imvgbC7FofyaDabyeHXlga4DTyQe87iZiwOSRgSOkw9FyMJXxFNQWYzx0Gn/1u90EKxK8SHbf379wZjmFu8kzksNDoDrINzwkzJA+s70m/yoawPysoC4s4KxQyXqSKTHW6chdBZAgpjXxM+yFV0JNco8Q+HcGyT2YoSFUxA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY7P286MB6946.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:324::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 05:49:06 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 05:49:06 +0000
Date: Fri, 11 Sep 2026 14:49:06 +0900
From: Koichiro Den <den@valinux.co.jp>
To: netdev-bot+sashiko@kernel.org
Cc: kuba@kernel.org, jdmason@kudzu.us, dave.jiang@intel.com, 
	allenbh@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, ntb@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 4/4] net: ntb_netdev: Preserve
 CHECKSUM_PARTIAL across NTB
Message-ID: <xsaocp32a6siggahziu4jqbwgmdasmp6v64pd5aujfkoxhiqws@n5luestlntzc>
References: <20260904052134.2970111-5-den@valinux.co.jp>
 <178898548878.219967.14452142614850430350@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <178898548878.219967.14452142614850430350@kernel.org>
X-ClientProxiedBy: TY6P286CA0036.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b7::10) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY7P286MB6946:EE_
X-MS-Office365-Filtering-Correlation-Id: 49e38491-580a-4e88-2821-08df0fc864c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|7416014|376014|366016|1800799024|10067099003|6133799003|3023799007|18002099003|22082099003|5023799004|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	yd2OT9yqx5gLBnpHSGcTM7v3WWK8vSmTQkERUafuji8FM6HwmftPoXVzRKFEE44MSEPjcbXjnEFqbaWF1pn3btCDUZ4IF5HTODSJAoX0lnKL/o6b1iOjIl+KN2XGM2cCEllGNQ4quSI23A0gw/Zg3O3HqNHDyu3zYWWQ3ydPkqh/Olr5BNEEiMc5XH4wZ8EryiqDzUoCNo+qhdM7PA+V4qmtkqiO4PfHGnbdfhq4pQN9JTnN6m8GHPwxAjPuhCyuUk17LXz8yrvs3Y6Mo4p1hKhWmN+mBJJ7wfGK+EopnzkdK362Sh1PxjUloXREXQPeIZgkVLuYDK+6qfuxEbqftxIS1LkB+PwWj5OubugIhbQO/iacO6c04ai8hk3o32XkdYwLI8WLht7IskgHM6334Z7zudvrLH1AUSHVUpmSAw1pQN52v4Q9JmcL7RNwMl+LrTb7DJGKxDAupBcbdyVRYYqyAAMWgsy7SCVvek4aymdybzYAoyWlZXz9QzQicV16CTgrlcs9TXODgFjVss4uZNRi/+VKWD5fv9ty1JBpmpzsBCxzj9DKrHZoNWqhegzwFU4MFiIjmgJe+jAfkkETj63r8HDfumg8028W5bZZ2c89DxfMZQGvFj8XmTCrJSzZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(7416014)(376014)(366016)(1800799024)(10067099003)(6133799003)(3023799007)(18002099003)(22082099003)(5023799004)(4143699003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cHU1OXlxYmRwamlSN21wcllzUER0Q3JiZ1puRFJ2eVA4cVVPOFBoTllpQjNu?=
 =?utf-8?B?QWtxU1g2YUROZ25EWXZmVGFkQ1BVQU4vblhKQVg1TDZOZjB4Rzd3Z1N5N0gy?=
 =?utf-8?B?cWhJZlhLMm1jME5xNGxRNmdkUGRRV1J3VVl2RWRLazlNWXZNSFh1V1NaM2ls?=
 =?utf-8?B?SG9FQloxeUV2bitZakpsc0g3cVBLMmJISURRckp0WTdlOGsxSDNNVlVramJY?=
 =?utf-8?B?NWJraE9jZldDdENaV3Z3YWdFTGVNM3MxdHZxbVVkSlMzcDhEeW15YmU1YjI3?=
 =?utf-8?B?K05MY2t6bGFVOFQ2ZzlMcHJHeFFTU3A2YUdSWDU3ODh3Q1g1N1A2MXVHWHUy?=
 =?utf-8?B?RnRPSGhTZXJ0bVJoYkE1Mi95ZGNKNzRrandEWEVPUW9jNFRZRkhYVzh5YWRP?=
 =?utf-8?B?a2VINWFFeWF1RU8rV1I3SVlBWTA2TXl5TWdyaTRCV1g2YnE2eHVUR3lKeTFV?=
 =?utf-8?B?dHdZcGFEM3o0MWhXamRzNGlzSkhoZUp4eEVjRlQrYThVTktid2thRTNlRkc2?=
 =?utf-8?B?bUI3SkdHN2dSOUIyTmdxY1F6U0cxWGpWZ01Gd2Nia0Z3MGpxZmVUampBRFgx?=
 =?utf-8?B?UTJiSGZsL2JxTDZGYVFtTzYvYVFXZ3VnZytJUFVLK2hDQ2UwSXpqTEEvL3Vq?=
 =?utf-8?B?ZjhYSnR3TTltZTVmYU1RdTc5c09vN0JNTHJEMXdlNDMyT0tEcTIvVDRraXU2?=
 =?utf-8?B?cTJTaEl1Z0hmU0o2UUR3VU1SdWJzaTNwZ2tkNHExVG9VSkJIa25nTVRoM2FI?=
 =?utf-8?B?a21EQ05ldnVXaXNsaytrOElyQXd1R3ptcjJMSm1PTk8vVVBBbnJsZTRqbm1h?=
 =?utf-8?B?clF6SCs2Z0Z6NDJIbEpVMDRVWW50WmZFc1lsY3ptSnA0cVM4Ui9iNThqVzBr?=
 =?utf-8?B?RE9ubUlEeGJWRWlBVTNlUEc0dHF5Tzh6U2tkeXIvRWN2aHFma0ltZWRFMk16?=
 =?utf-8?B?QU5mKzdyMFpOL2xLaytQQWxDdkUrVVdsL0doSnE4YWNBdnlYOGdETmhLcTRE?=
 =?utf-8?B?TTViZllQU2Q1THNrdGRZU0Rud05Gakc3L01Lc0hvUkw5ZHdKRktTSUpSNkx0?=
 =?utf-8?B?VmtOV0xySTR3VERVVllxTzRSU0tvNUE4ck5lQTdLVXJQWEF1Z1cvNHRib2ov?=
 =?utf-8?B?aTA2akJkOVNIK0VuN3RXMWJpVlFNa2p4ckwrTENjVHJZUmM2a2pXa0VpblRu?=
 =?utf-8?B?T2dKb2lYV2MvSExOS2d1ZzdzMUxybXZRQTAyRUQweWtzT3dJclhoNEJqVkpG?=
 =?utf-8?B?bSthSEtzeUs5NG1keTdrMWE5eEZqL3MwTzB5UnRsU0pKdVEyaFFRNmtDdGg3?=
 =?utf-8?B?eTd0a3g4NjgyS1JmQzNtaDRyMWlEOWorS3YzTVBlWFZBeDhvUUVUQUtFV2Vz?=
 =?utf-8?B?WlBsR3B1eWlrb095Tjk5dGlOUUV6UVh5c2IwZVNaTVJJa0xhM0xpQXdEQUZp?=
 =?utf-8?B?RDg2Njh4M3FGN0ZhbjUyOEZpcHVxcG1yTDlmMmFSK1ovc1hac2J1bnc1eVJw?=
 =?utf-8?B?VnFLdlpsQmZuYktSVGpsTHRFOW5LSmdkeXVIRENtd2Y3dnVkb0dTU3VqV1lS?=
 =?utf-8?B?eU85OHRGM01helFjdUllTTdBVGxNK01iZjBYbkt0RTRFdlJwalZ2aUdQbDEx?=
 =?utf-8?B?d1ZpVVlBRTR3ZkxoUDZzdUVBaXhjdzdjWUhjVHdVRThVTUFZaEVia2dwQXRE?=
 =?utf-8?B?eFZuSTJvSzdEb0tBT1FDT0I4V3pNVmxFdzdoSGtzbVFOZXQra3VLZU5CL0hs?=
 =?utf-8?B?TDdPY05id2F4NXd6d05tWk0wM3kydURmcTYzWmdEaFRsL2R3MHNuWitneVBp?=
 =?utf-8?B?NjIxZTZkUW9kcVU5RHF4ZXZ3ekUrUXJXTDAwenNvWlQwc09DNWFjdzQzUGFP?=
 =?utf-8?B?NkVhQ0w5VC9DVTNINHpBbXdnRG50dHZYSWhpYkFtYU1jT0toUHhGQWY5ZkVv?=
 =?utf-8?B?WTJ1ZlAxM3FQZ3VyclNEOWh6dEFqdG9PRUNOWWxRdW1pMXcwdElLTUNHMS9t?=
 =?utf-8?B?L25BaEdvdml1L05aRG1GYjJBa1JlSlM4RDNpMlJMVkZRa2xacW0xTXVwMFB6?=
 =?utf-8?B?VGdpUCs2OVJvVUdDL2drZU9zeEE0V2tJaWtWZUp2OXBaT2tNSElxUVZmb2VO?=
 =?utf-8?B?TnRxcXRjeElxSmxEN2pBVTlLQkk4bVRzUXloek05eWdNTHpTSENDRzQzMjNN?=
 =?utf-8?B?UDlPR01pbEhsc3IweGxZclE3SG9oNDVRMG5acHE3dEQ3OEtyQTVGWENVUHlE?=
 =?utf-8?B?ZmpVTUlYZm4xOC9HSDlkb1FTNzN6U0plb0VSNXB5Tlh5RjF6Q1RCYUdRSExx?=
 =?utf-8?B?M3ZzS0RFWGxsSTBmQmxqWTBLU0JWajNlQnBNWWViV0phMnJOV3BieTk3MDB3?=
 =?utf-8?Q?1ZtM/VqCkLOr1cvx054Hm3qfytWnqp07PCQUd?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 49e38491-580a-4e88-2821-08df0fc864c0
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 05:49:06.9010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F3vAwJvCWswqVXeIxD8ZfSNYSd47Xjg1Zc9ms/HpIMF1Gx5YyKdlR5SxN9OX3ymPqeOkv4aYZsdCOBJ8Qmo5HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB6946

On Wed, Sep 09, 2026 at 08:24:48PM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider:
> 
> Critical: 0 · High: 1 · Medium: 1 · Low: 1
> 
> - [High] ntb_netdev_start_xmit() unconditionally seeds `meta =
>   NTB_NETDEV_META_CAP_CSUM` (drivers/net/ntb_netdev.c:317), so the…
> - [Medium] dev->peer_csum is a device-wide lockless bool written from two
>   unsynchronised contexts: ntb_netdev_event_handler() clears it…
> - [Low] ntb_netdev_rx_handler() performs an unconditional
>   `WRITE_ONCE(dev->peer_csum, true)` for every received frame carrying…
> 
> --
> 
> net: ntb_netdev: Preserve CHECKSUM_PARTIAL across NTB
> 
> This carries CHECKSUM_PARTIAL, csum_start and csum_offset across the NTB
> link in the transport meta field, advertising the capability on every frame
> and falling back to software checksumming until the peer capability is
> observed.  TX and RX checksum offload are added to hw_features but left
> disabled by default.
> 
> > diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
> > index d03cbda1637d9..de8c4f320614d 100644
> > --- a/drivers/net/ntb_netdev.c
> > +++ b/drivers/net/ntb_netdev.c
> 
> [ ... ]
> 
> > @@ -29,6 +30,21 @@ static unsigned int tx_stop = 5;
> >  #define NTB_NETDEV_MAX_QUEUES		64
> >  #define NTB_NETDEV_DEFAULT_QUEUES	1
> >  
> > +/*
> > + * Checksum metadata layout:
> > + *   bit 23     capability, advertised on every packet
> > + *   bit 22     per-packet CHECKSUM_PARTIAL flag
> > + *   bit 21..6  skb_checksum_start_offset() (16 bits)
> > + *   bit 5..0   skb->csum_offset (6 bits)
> > + *
> > + * Until the capability is observed, complete partial checksums in software.
> > + * Six offset bits cover TCP/UDP. Larger offsets use software checksumming.
> > + */
> > +#define NTB_NETDEV_META_CAP_CSUM		BIT(23)
> > +#define NTB_NETDEV_META_CSUM			BIT(22)
> > +#define NTB_NETDEV_META_CSUM_START_SHIFT	6
> > +#define NTB_NETDEV_META_CSUM_OFFSET_MASK	GENMASK(5, 0)
> > +
> >  struct ntb_netdev;
> >  
> >  struct ntb_netdev_queue {
> > @@ -44,6 +60,7 @@ struct ntb_netdev {
> >  	struct net_device *ndev;
> >  	unsigned int num_queues;
> >  	struct ntb_netdev_queue *queues;
> > +	bool peer_csum;
> >  };
> >  
> >  #define	NTB_TX_TIMEOUT_MS	1000
> > @@ -108,6 +125,7 @@ static void ntb_netdev_event_handler(void *data, int link_is_up)
> >  	struct net_device *ndev;
> >  
> >  	ndev = dev->ndev;
> > +	WRITE_ONCE(dev->peer_csum, false);
> 
> [Severity: Medium]
> Can this clear of peer_csum be lost?  ntb_netdev_event_handler() runs in
> workqueue/process context out of the transport, while
> ntb_netdev_rx_handler() sets the same field from the qp rxc_db tasklet or
> from an RX DMA completion (ntb_rx_copy_callback() -> ntb_complete_rxc()).

Thanks for the catch.

You're absolutely right. ntb_complete_rxc() returns the entry to rx_free_q
before calling rx_handler. An empty rx_post_q therefore doesn't mean all client
callbacks have returned. An old callback can still set peer_csum after a link
reset.

We could count in-flight callbacks and wait for them during link cleanup, but
I'd rather not add that dependency (or, to put it another way, ad-hoc unclean
code) just for capability exchange. I put NTB_NETDEV_META_CAP_CSUM bit in the
in-band metadata to keep the transport changes as small as possible, but fixing
these races would complicate the implementation after all..

Thus, for v4 I'm now considering:

  - Exchange opaque per-QP capabilities using spare SPADs after the existing MW
    size and MSI information.
  - Extend the link-up API and client event callback like:

    void ntb_transport_link_up(struct ntb_transport_qp *qp, u32 local_caps);
    void (*event_handler)(void *data, int status, u32 peer_caps);

    Clients pass local_caps at link-up and receive peer_caps with the link-up
    event after the exchange. Both stay opaque to ntb_transport.

Legacy peers, or QPs without enough spare SPADs, would fall back to zero peer
capabilities.

This removes NTB_NETDEV_META_CAP_CSUM from in-band packet metadata. Capability
is learned at link-up, with no updates from RX callbacks.

This needs agreement on the NTB API (+ new SPAD use) change, but I think it's
cleaner long-term.
Dave, I'd appreciate your thoughts on this.

Best regards,
Koichiro

> 
> Looking at ntb_qp_link_cleanup() in drivers/ntb/ntb_transport.c, the
> event handler is invoked without stopping the rxc_db tasklet or draining
> outstanding RX DMA completions:
> 
> 	cancel_delayed_work_sync(&qp->link_work);
> 	ntb_qp_link_down_reset(qp);
> 
> 	if (qp->event_handler)
> 		qp->event_handler(qp->cb_data, qp->link_is_up);
> 
> and ntb_complete_rxc() still calls into the driver because transport link
> loss does not clear client_ready:
> 
> 		if (qp->rx_handler && qp->client_ready)
> 			qp->rx_handler(qp, qp->cb_data, cb_data, len, meta);
> 
> So a completion belonging to the previous link generation can run
> WRITE_ONCE(dev->peer_csum, true) after the link-down clear, and after the
> following link-up clear too.  If the peer that comes back does not
> implement the capability (for example it rebooted into a pre-patch
> kernel), ntb_netdev_start_xmit() then sees peer_csum == true, sets
> NTB_NETDEV_META_CSUM and skips skb_checksum_help(), and the old peer marks
> those frames CHECKSUM_NONE with only the pseudo-header sum in place.
> Wouldn't that silently break TCP/UDP over the link until it is bounced
> again?  READ_ONCE()/WRITE_ONCE() only prevent torn access here.
> 
> A related question: peer_csum is device-wide while the event handler is
> per-queue, and multi-queue is reachable through the driver's ethtool
> set_channels.  Should one queue's link event clobber capability state
> learned on the other queues that are still up?
> 
> >  
> >  	netdev_dbg(ndev, "Event %x, Link %x, qp %u\n", link_is_up,
> >  		   ntb_transport_link_query(q->qp), q->qid);
> 
> [ ... ]
> 
> > @@ -146,21 +174,32 @@ static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
> >  		goto enqueue_again;
> >  	}
> >  
> > -	tstats = this_cpu_ptr(ndev->tstats);
> > -	flags = u64_stats_update_begin_irqsave(&tstats->syncp);
> > -	u64_stats_inc(&tstats->rx_packets);
> > -	u64_stats_add(&tstats->rx_bytes, len);
> > -	u64_stats_update_end_irqrestore(&tstats->syncp, flags);
> > -
> >  	new_skb = netdev_alloc_skb(ndev, ndev->mtu + ETH_HLEN);
> >  	if (!new_skb) {
> > +		ntb_netdev_rx_stats_add(ndev, len);
> >  		DEV_STATS_INC(ndev, rx_dropped);
> >  		goto enqueue_again;
> >  	}
> >  
> >  	skb_put(skb, len);
> > +	if (meta & NTB_NETDEV_META_CAP_CSUM)
> > +		WRITE_ONCE(dev->peer_csum, true);
> 
> [Severity: Low]
> This isn't a bug, but does this need to store on every frame?  peer_csum
> only ever goes false -> true within a link session, and it sits in the
> shared struct ntb_netdev next to ndev/num_queues/queues, which
> ntb_netdev_start_xmit() reads once per transmitted packet:
> 
> 	q = &dev->queues[qid];
> 	...
> 		if (READ_ONCE(dev->peer_csum))
> 
> Every received frame therefore dirties a cacheline that each TX queue
> reads per packet, possibly from another CPU (more so with multiple queues
> via set_channels).  Would a test before the store, or per-queue state,
> avoid that?
> 
> 	if (!READ_ONCE(dev->peer_csum))
> 		WRITE_ONCE(dev->peer_csum, true);
> 
> > +
> > +	if (meta & NTB_NETDEV_META_CSUM) {
> > +		u16 csum_start = (meta >> NTB_NETDEV_META_CSUM_START_SHIFT) & U16_MAX;
> > +		u16 csum_offset = meta & NTB_NETDEV_META_CSUM_OFFSET_MASK;
> > +
> > +		if (csum_start < ETH_HLEN ||
> > +		    !skb_partial_csum_set(skb, csum_start, csum_offset))
> > +			goto rx_drop;
> > +
> > +		if (!(ndev->features & NETIF_F_RXCSUM) &&
> > +		    skb_checksum_help(skb))
> > +			goto rx_drop;
> > +	}
> 
> [Severity: High]
> With rx-checksumming off, does this path still end up trusting the peer?
> 
> The frame is not rejected: skb_partial_csum_set() applies the
> peer-supplied csum_start/csum_offset, then skb_checksum_help() in
> net/core/dev.c computes the sum over the bytes that were just received and
> writes it into the packet:
> 
> 	offset = skb_checksum_start_offset(skb);
> 	...
> 	csum = skb_checksum(skb, offset, skb->len - offset, 0);
> 
> 	offset += skb->csum_offset;
> 	...
> 	*(__sum16 *)(skb->data + offset) = csum_fold(csum) ?: CSUM_MANGLED_0;
> out_set_summed:
> 	skb->ip_summed = CHECKSUM_NONE;
> 
> So the L4 checksum the stack later validates is one the receiver itself
> generated.  Doesn't that mean corruption introduced anywhere on the NTB
> path (bad DMA or memcpy, a misbehaving peer, a wrong csum_start) is turned
> into an apparently valid checksum, in both feature states?  In the RXCSUM
> on case skb_csum_unnecessary() treats CHECKSUM_PARTIAL with a valid
> csum_start as needing no verification, and in the off case the sum is
> recomputed locally, so the knob appears to select who spends the CPU
> rather than whether the frame is trusted.
> 
> Together with the unconditional advertisement in ntb_netdev_start_xmit():
> 
> 	unsigned int meta = NTB_NETDEV_META_CAP_CSUM;
> 
> the capability bit is sent on every frame with no reference to the local
> ndev->features & NETIF_F_RXCSUM, and the peer latches it above.  The only
> place peer_csum is cleared is a qp link event in
> ntb_netdev_event_handler(), so once a peer has latched it there is no
> negative advertisement, timeout or renegotiation short of bouncing the
> link.
> 
> The commit message says:
> 
>     Leave the TX and RX checksum features disabled by default. Users can
>     just enable them explicitly for links they trust for lower CPU usage
>     and/or higher throughput.
> 
> Is that accurate for the receive direction, given the receive-side
> decision is made entirely by the transmitting peer?  Would gating
> NTB_NETDEV_META_CAP_CSUM on the local NETIF_F_RXCSUM state, and dropping
> plus counting META_CSUM frames that arrive while RXCSUM is off instead of
> repairing them, match the described behaviour better?
> 
> Also, in the off case a full software checksum over every payload now runs
> in the RX tasklet at the remote peer's discretion, which is the opposite
> of the CPU saving the change is aiming for.
> 
> > +
> > +	ntb_netdev_rx_stats_add(ndev, len);
> >  	skb->protocol = eth_type_trans(skb, ndev);
> > -	skb->ip_summed = CHECKSUM_NONE;
> >  	skb_record_rx_queue(skb, q->qid);
> >  
> >  	netif_rx(skb);
> 
> [ ... ]
> 
> > @@ -268,6 +314,7 @@ static const struct ntb_queue_handlers ntb_netdev_handlers = {
> >  static netdev_tx_t ntb_netdev_start_xmit(struct sk_buff *skb,
> >  					 struct net_device *ndev)
> >  {
> > +	unsigned int meta = NTB_NETDEV_META_CAP_CSUM;
> >  	struct ntb_netdev *dev = netdev_priv(ndev);
> >  	u16 qid = skb_get_queue_mapping(skb);
> >  	struct ntb_netdev_queue *q;
> > @@ -278,7 +325,17 @@ static netdev_tx_t ntb_netdev_start_xmit(struct sk_buff *skb,
> >  	if (unlikely(ntb_netdev_maybe_stop_tx(ndev, q, tx_stop)))
> >  		return NETDEV_TX_BUSY;
> >  
> > -	rc = ntb_transport_tx_enqueue(q->qp, skb, skb->data, skb->len, 0);
> > +	if (skb->ip_summed == CHECKSUM_PARTIAL) {
> > +		if (READ_ONCE(dev->peer_csum))
> > +			meta |= NTB_NETDEV_META_CSUM |
> > +				(skb_checksum_start_offset(skb) <<
> > +				 NTB_NETDEV_META_CSUM_START_SHIFT) |
> > +				skb->csum_offset;
> > +		else if (skb_checksum_help(skb))
> > +			goto drop;
> > +	}
> > +
> > +	rc = ntb_transport_tx_enqueue(q->qp, skb, skb->data, skb->len, meta);
> 
> [ ... ]
> 
> > @@ -671,7 +741,8 @@ static int ntb_netdev_probe(struct device *client_dev)
> >  
> >  	ndev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
> >  
> > -	ndev->hw_features = ndev->features;
> > +	/* Checksum bypass assumes a trusted NTB link, so keep it opt-in. */
> > +	ndev->hw_features = ndev->features | NETIF_F_HW_CSUM | NETIF_F_RXCSUM;
> 
> This is where NETIF_F_RXCSUM becomes a user-visible knob, and the comment
> states the bypass is opt-in.  Given the receive path above accepts and
> repairs offloaded frames when the bit is clear, does turning
> rx-checksumming off actually keep the bypass out of the picture?
> 
> >  	ndev->watchdog_timeo = msecs_to_jiffies(NTB_TX_TIMEOUT_MS);
> >  
> >  	eth_random_addr(ndev->perm_addr);
> 
> -- 
> Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260904052134.2970111-1-den%40valinux.co.jp
