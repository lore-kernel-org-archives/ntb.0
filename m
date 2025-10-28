Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010020.outbound.protection.outlook.com [52.101.229.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FE7171CD
	for <ntb@lists.linux.dev>; Tue, 28 Oct 2025 01:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761614702; cv=fail; b=TQcSpj2yPdmUNzw3eRNvPLXzBujiaF4z+Akh3jX0VM0bxmxqOZvP8Qy03hbt0z91m076aP++CzZf8n2HAAOeOE+P76G0J1FcrhYXsgGc9kfW6ovm46Uzdi8cx5otut+StGAOYvDEKo5Q4Fyzh+hfueVNIJrUUJ5v66otMyKbjUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761614702; c=relaxed/simple;
	bh=Fqu+aYHCQfBnHNDeONjF8sGsFARvszdERbGppccSYjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=I/V9lDwBWAqOZ8S+qZkWS2qM8D2xhClQko8pZ1ZlV2unjPZVkUoSxUapz+HwnL4PaBo0FY6XfsQkxIcGv7GL1pJZVx5Yh+Nixpzi5MhTvpsCxDnfORK6DIjc6+/KzBim9Biw5dEr++P2sn/viaOSFuFiSDb75niOJDw4zAEfqG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=UN/FYJqe; arc=fail smtp.client-ip=52.101.229.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="UN/FYJqe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FwWeswAytU2RynmUT/VN6QV/fIAjcKPsTJQa6ALLbFY5LQyylYJ17GcAOXoeC058e2Mpsg/pA16YfgP4hr6HP+wvk3EWWXtfeE50rmDHcTG2P8Z6hqNwwLELromYL8bRwlEDc2vooKfcP6R0d4ye+8zouOrF6qCK7tz0s2ymhQEPT/pFMXOlQX40R2cZO6IK8sZ4OVNjJVZRE2xQxrNZ5QVD0OoBHyeVegz/WHZHJUY+RdGh6SxI9aahKt7JvM7weB/PE+tNU9IaKb6gr3Kvd84ShmBH2TGY5K2jM8yGtgq1TMdBC/eHdWKyc2Z9HYAzT+wTIoM83y6NMGpyPDZHKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vpFluH5No747ys+zR8Hmm/J8MZ1E2EKCn1hj9eGOCEM=;
 b=SPvGOkeayNzfpKG4C7OQ+X4PoJlgtqFICYZSG3mZT8RkYxO9k+4zM5VYbzT7BOzP9QshSSxWGkp8ESMrOuUtXtpBBPanGvv9Iy6HTNLyF2EvhjFpGb73DlXqbB2KXWfb27oXDZbbYLg6ENrTqPDJUoF9ukJvtS7K5DyN84is2mgNA+oaP80aJNHI26fvxvxcQ0Kiuh6M07LI1d21AKTElpdI4MkSWhWEHq510zZ6/t6ua8Di2Ws8HMZPctgPemUaQFFZWK8BYIXwh/KrqWqZEZLY/VS+qFKP9Ia2iEQYWsDk1AayhEFgWsEOInltTDn9c086s810H8b2XhbI7BKQVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vpFluH5No747ys+zR8Hmm/J8MZ1E2EKCn1hj9eGOCEM=;
 b=UN/FYJqejiVWCVwbArkYHrUPc9EqdHKFLVZDm3u61SGHIMJaoDchJiPf+flGzzeUvaXNR22gyUgZz6jaLV+4Bd/9RAXl8f0+cek3kWD7aQAd5eI35gOlb2aZinDQjOKiCrGAUZ8IWnfx6kpLkMOEGPXE6OVwiiMOhK7I+SO6cLk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:10d::7)
 by TYRP286MB5091.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:142::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 01:24:57 +0000
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a]) by OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a%5]) with mapi id 15.20.9253.018; Tue, 28 Oct 2025
 01:24:57 +0000
Date: Tue, 28 Oct 2025 10:24:56 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: ntb@lists.linux.dev, linux-kernel@vger.kernel.org, jdmason@kudzu.us, 
	dave.jiang@intel.com, allenbh@gmail.com
Subject: Re: [PATCH 1/4] NTB: ntb_transport: Handle remapped contiguous
 region in vmalloc space
Message-ID: <sakuovp57hzcth52lyms2t3tmn4vxop5565jhwewv4ucwjiubs@nvrdvq6cfmv4>
References: <20251027004331.562345-1-den@valinux.co.jp>
 <20251027004331.562345-2-den@valinux.co.jp>
 <030a4195-ed20-4f5f-8841-ea5385bb4a8c@deltatee.com>
 <b527bouvdp3a54jkvwiqhfe62nlllsbxrkvstrea3lem5c46ab@bdn67yrw3yen>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b527bouvdp3a54jkvwiqhfe62nlllsbxrkvstrea3lem5c46ab@bdn67yrw3yen>
X-ClientProxiedBy: TY4P301CA0074.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36f::17) To OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:10d::7)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB0979:EE_|TYRP286MB5091:EE_
X-MS-Office365-Filtering-Correlation-Id: 8528eefc-7170-4627-ccf6-08de15c0ce49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1i0UPZ722rwXWEgOj3idjQxdG3KYP30IFNTxLSEjuUHv9P1MocSqWUmlMUqk?=
 =?us-ascii?Q?aYkDPhlf/qGaFv6L45ZXhrt6PPu1PzyB3XQwvNAWHX5nXtbSseYQEBGDher4?=
 =?us-ascii?Q?n3i0P2wVSadg/YnX7b0+sL/t1D1qXWp8XlLxQ4425+atuoNsTiu69Lc7hG/8?=
 =?us-ascii?Q?elX57zHA8e6+XqCiRgTK2bXyk1UA1xhGF0kukgTab52TZI5K1uVFmceTMxTd?=
 =?us-ascii?Q?YFSCOpgjJLmqMkgwT1Ej0fnvylbla6JJOlLmCf33p/mEevSm7naCJQuWjlqx?=
 =?us-ascii?Q?f6wxJ2sPqUPL+8w7B8z86ZGLPcyjDnq9xCM/0UTcx3Tc5mB6e9Dv4vii1jpv?=
 =?us-ascii?Q?p1I+n6JZ9Qh6Quq+Qhsu/KYUVs1nPMamejnw5+kS97bYjHGlce9bgvA+2rUe?=
 =?us-ascii?Q?za5JAkp0kCkIQP1AiPO7zMs081sCItygc+gLtk9lWJqdJy2bf+TqaRctvmkG?=
 =?us-ascii?Q?Q4O66MQSvGKfOX91D0JH+15bIy0Tewk9VVyBBl20IE39Y4nIvpPQ+z4jJjrI?=
 =?us-ascii?Q?LFEe+itrKuENQzBnf8lR1v6+xD6jJ5c/CAEJg0/p7aGg+UVjWTqHVU4yY+/c?=
 =?us-ascii?Q?Vw8/EoivLpGvSzkx/u4dI7clgfMILgdL7tB3BzFLU2WOH6jqtcUSRPYDvH1v?=
 =?us-ascii?Q?mbLC/EWpfScOLR8gPiw8nTBmmU0gevVfl8n0I0gqv7gfgOySuOS3Qk4AHRcK?=
 =?us-ascii?Q?ETZkDtqzLzNwFYViQ7zZFuwJZTmuwxUlMlZ157MA0oQOLlyDqdcBFkC+1cdh?=
 =?us-ascii?Q?0qzcOCLvdQm+xFg/6eMt40Hdv3wjO27DEUQGLkULOUeBjKpTpMJ9mPVOhhe2?=
 =?us-ascii?Q?bqt2SCbXXvPOyloyTx71n/uvBNV+z3nspb7Dsk+myP4QDjF2vF7Y4/Dd04OU?=
 =?us-ascii?Q?e89ZgzvnJkepnbAP39IeKUL3eyFVjSBTYZDOwPzKozWVW+xA77qyK4ixZHuA?=
 =?us-ascii?Q?8IE50UMxF00ioHDnioGMHq9pBnw8gTCM5VKqeBU+9kdPk6vKATTEZVidu1+l?=
 =?us-ascii?Q?T1EWc9lkCmOl+zkZRyG3FgZh7naHv/I37HQOTyL3GDZkbCBNvoE4cnGtSPuB?=
 =?us-ascii?Q?VLqnfhre+KSqd9xXNaB+zK4RaibFqPpKKIpqfCcJgkD1hP1RqGv0je4l1AKH?=
 =?us-ascii?Q?5JDM6P+XYp2wqGVpjqbgf2JXLlMMPgrzudaoe4wLY+CZ0wiQIMkT3rT/gBbd?=
 =?us-ascii?Q?zA3etgp8dqtcvM3zRt9hwT0Cp+dLrMQmDm0GrkHuAA1hkbtAB3AukOoDcibs?=
 =?us-ascii?Q?H+5U62XirPYo6pe3gGFM3BoTa5vzIa4YIlyl23DvXz1om0IJrcdJeZVqY0DZ?=
 =?us-ascii?Q?3K4Ag6EpPx//jJfBx6bHOEHr684JiufGtz0Ah2wlObwhBUvn82wIQSbphUcQ?=
 =?us-ascii?Q?NCi38AbICLQiqVufYsR+9iTzJp/S/gYX+DE2gK/9nxMh7KT2+SHLY0h18B8w?=
 =?us-ascii?Q?8beIXSLPwAdPWDkADEqrUHNzv8JLeiYr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?suge8bLQTesmeBuWRWykZU6WqkjrcJPJlXFp3OczqtMzojoSQujB0zf2IjnL?=
 =?us-ascii?Q?hDZNRva0ZT4LrgzsORE25+1PDgOh5CSraxdM1sDg1RwjguN+Efwf/KMU/5gV?=
 =?us-ascii?Q?M+TuNb5ChDmIsuPeUg6dOjsSlN/a2g8ox51oX+TvlSYIFwSvHAQNdQ4yRV7J?=
 =?us-ascii?Q?sE+7jyvz7VSwmkp3hDt0JtwnOzyXf+TBEMWAlgv70kTvuHUEhYQh3niW0+cG?=
 =?us-ascii?Q?GWcS894Gz5xk+7ssZRkaQhtXz8oTWl4cdJXbnJ8wxdr38d5Tb6Deh+ZB78dc?=
 =?us-ascii?Q?yVjKydkvePRNsdOCSrzeUPJUApuG9QIHy7v52FbJkb9GBS2kSGJCSW6ojVRl?=
 =?us-ascii?Q?kNhG+/Kgx0hs6iQGp9HjQ4nvyCz4qnJt5+wpZlTEAddksBmBdfj8dPrM1b81?=
 =?us-ascii?Q?SeIjlj3J3IXcFcOh2/sTwhUD3fCJYZfu/zELj8sb2utPDTpsYzi4s7Ua53uA?=
 =?us-ascii?Q?U8UxK2Pq7MKDBvMcKpnXuBNcGJPXVUpgtkWwAyQXS4UHtkGsjqJIVuJoMuO/?=
 =?us-ascii?Q?Ff79s0GwJVzGUffWfUed28H9rSq2UiQCSl4hMhmwsmdq35QyrEeTWV5kXZ/x?=
 =?us-ascii?Q?LIghp5Atr9/yLsEA9nxZ7uTMDOJUU8FM3Ll4legVBlIRQ6uyBiv3iEh+bwps?=
 =?us-ascii?Q?Kx7V24uNgzizf3P4ND4BMZER/YvFI4t82znnigucZ9E9sOBwubiUfFOttYE4?=
 =?us-ascii?Q?GUglKM7FUFPNx9IjJczXV6PmdeSwt2eOpYxTMTWh8+HWVtQuHp2sTcCGOPsu?=
 =?us-ascii?Q?qmes4bHRWBc3vhIOmCBp+/SdDShfJbLP5XBPeqojp5fTlQPvPp/gzCU+xXL2?=
 =?us-ascii?Q?AaOcvwywiW/THvDu6HxblwAFadI/evVhsQG+yihKebVN37FWbCRu5cD13yY+?=
 =?us-ascii?Q?76D8CcYR+TnDUE2AIr/VHBRtpH7SYl0+gs+yb1zs2ATEFx9Hm2rLiBzm1hPc?=
 =?us-ascii?Q?sw0/Dyzfu27KXDurB2RB3itIgVzYhMzvr6HV7D1aynvf1JEFJSgAkrVlLaMR?=
 =?us-ascii?Q?ERc154CAYaPlOrtYKSofINtpqBWP76B0ddIrsZOmag3UJhcjUm6c3g+4+muh?=
 =?us-ascii?Q?hwDAYejGSS4h4GXhM4DrskCXqdvyyRs7c6cXbYLk+TTYn58ucc6etPYKUg+F?=
 =?us-ascii?Q?wDse/7XwilNA+DQa9+TmHnKVc6FsAam5Gq7g8GZyyeUkVGl8hwaLww5WMqGX?=
 =?us-ascii?Q?ef3B65rOKPDFsx0dVNmDGP5heZ6qOFQ00Hg4cQRr8RFDxkIJjW8rsNGY2VGr?=
 =?us-ascii?Q?z6lq0OfFiSfDnaB0OZwtmNQK9Js69s5NnSVX/gPTik3nN7tEEvVDrvpqkwwN?=
 =?us-ascii?Q?nhA8Z9OaL6JMyCCKt0KX4zgQkM4DD5mWORTjvReHZ+Au3YCDyfpahcAbATei?=
 =?us-ascii?Q?naLWNKAfNyotO/jRHokwP6fWfkDMRaVhpY3wSb/uZkfyyfS+tuaRF7Hc+hx4?=
 =?us-ascii?Q?aKTJ+iW98OLtixSege5XIh3pxvPmw2BcV8or61FKyzcbllYvCqCPcnThOeHJ?=
 =?us-ascii?Q?e8+tD2xIb5zkPmTPHZfRzLVGZZp0M9iP/Rlmk/eWkErzE1I7IJa7fDJisKMH?=
 =?us-ascii?Q?CKvjeGhybXUcNqkW4FYqnTpSJzuIEfAcgOe1+LhQ341f9uaSIsGx4ftdgJDZ?=
 =?us-ascii?Q?fVs57fQen1ezo9L04w4ijmQ=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 8528eefc-7170-4627-ccf6-08de15c0ce49
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 01:24:57.3212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QzY9AtbiQ9aljY+pQLWPnOQhZGKAA5XiIY/jX67hzIe3j+B6K/DvOZbtFaBAfdbsR4XSmIms+/At8XMHhIMxfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB5091

On Tue, Oct 28, 2025 at 10:14:00AM +0900, Koichiro Den wrote:
> On Mon, Oct 27, 2025 at 10:30:52AM -0600, Logan Gunthorpe wrote:
> > 
> > 
> > On 2025-10-26 18:43, Koichiro Den wrote:
> > > The RX buffer virtual address may reside in vmalloc space depending on
> > > the allocation path, where virt_to_page() is invalid.
> > > 
> > > Use a helper that chooses vmalloc_to_page() or virt_to_page() as
> > > appropriate. This is safe since the buffer is guaranteed to be
> > > physically contiguous.
> > 
> > I think this statement needs some explanation.
> > 
> > vmalloc memory is generally not contiguous and using vmalloc_to_page()
> > like this seems very questionable.
> 
> Yes generally it is, which is why I wrote the last sentence "... since the
s/generally it is/generally it is non-contiguous/
Sorry for the confusion

-Koichiro

> buffer is guaranteed to be physically contiguous."
> 
> > 
> > I did a very quick look and found that "offset" may come from
> > dma_alloc_attrs() which can also return coherent memory that would be in
> > vmalloc space and would be contiguous.
> > 
> > However, in my cursory look, it appears that the kernel address returned
> > by dma_alloc_attrs() is eventually passed to dma_map_page() in order to
> > obtain the dma address a second time. This is really ugly, and almost
> > certainly not expected by the dma layer.
> > 
> > This requires a bit of a change, but it seems to me that if
> > dma_alloc_attrs() is used, the dma address it returns should be used
> > directly and a second map should be avoided completely. Then we wouldn't
> > need the unusual use of vmalloc_to_page().
> 
> I agree there's room for improvement around this "double" mapping.
> I'll think about a follow-up patch to clean this up.
> 
> > 
> > At the very least, I think these issues need to be mentioned in the
> > commit message.
> 
> As for the commit message, I think adding one more line like:
> "See relevant commit 061a785a114f ("ntb: Force physically contiguous allocation of rx ring buffers")"
> should be sufficient. What do you think?
> 
> Thanks for reviewing.
> 
> -Koichiro
> 
> > 
> > Logan
