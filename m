Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.111
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795582862;
	b=c7vFROchD5xHpDNka7KexP8c4oVvIPBEqQKpLaR7EByr4ha6QU6isrJYjGxT19iwzYnZ
	 YTD+PyrLTzMIknsWGCg2mmhbkqjRG/aUPQeSej+2li3bUBCBF9U8ZUTrOPCGcHG5JhugE
	 eA+4c26tkM4/6XoLi8VHQQ4FOQHIoKp5FP8YtVINiKRrmgM8fjxdIx3er6Ub9AJ3ruwB6
	 EjfUO/guwj2DjYJKOU/M36nrNgibq+AOEn0AhU7SN6Fqvit3A5kPDRavqrf9l8nfp+HLY
	 /BZt1NefHRVr2QEYmUqyHfMhsP9P9DKK7nxZJhePRwuiXPFju/Hz5xRaWEcAnfr7AdQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795582862;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=TqRNc5/KNjXZYfOeCFbg1q0YS9Bvvo4OXsu5kCwMnq0=;
	b=MKSqnx6dXCWFH8XICWWWPhSuAhZ8jMYgHatWpwnS3tlEbVAX4xbig23U0KY6cexXmt6M
	 /kcEWruJoTaS9ysRok1QBJQsMXHFWuAJFqTEfmrLIXyKwzBjDjEnvDL0CO0O5MQ0ocn1B
	 ONwJ9VdWE1xuKaS+sKDEwpT6TramR8pOUVDVC1CaI6CNBjH6vIosSpuCbOdD1m5SEjefs
	 7z6ickfKieqRYezt8z+LwRESesLHfLebQOiBEWACXP+15n70bvStmYM6iScSyiU7AXRQR
	 Tx+lB24m9ixJxMdVy8JL271xc6juB8PHW4teth2A+cjhclrEwADwnYpa+WY6BLdfG5Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=UGiiwenU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.111
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020111.outbound.protection.outlook.com [52.101.228.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1FF606A323
	for <ntb@lists.linux.dev>; Wed, 25 Nov 2026 05:01:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA1FF606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=UGiiwenU
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AzLlGMwM/SHFddtHnquvuz+0SOKtdSQXxaseM/lWra0u23ulaFoMYjY36RFTVp+jQb7uuHCy4Zb9YuCETAcrci9BUId2muLMkmRDZWuY7lpk8w8EI9nWe7AYNFSL3ChE+d15YcreOgA3MIV+lL6Rgc+6W/LYO6WJvL4XESFtht96nGnIf2HN3+WmWmJ4WwttGKBUIHGdzf9c9Az0lVGM9YgS5wir9JuvuHhe1u+B7KGaIC1dYcl4CjaKIqxZO1RCugHAXt5+MdaF5s/yog/Hrs20lNj7c4GZBG2TQOtHSExcwSNhFvH+Npx9tK/RLpIEEf7V5TMVPx4zMjf271QJ9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TqRNc5/KNjXZYfOeCFbg1q0YS9Bvvo4OXsu5kCwMnq0=;
 b=lQug3J8PLarLnnNP72du4pTAFDHBh2m2rvElZlxx973WSYYMdki0SdLKbmHWBvnAksWFjWj41+CDaBUuCES3eQnKRmHoe+35+LHXeMIXCn047T9163hl59tjVQOOOGjJpO3T6CwgNZtTi+/rB7Q/y1BjZSONNHEUS1frAKOhQ70Xbbc1W7hSgCmS8GleZFIau3mPB0NVLI6DrOv6Q3E0lypr7kuCXA9qF07PfJvhj34pVkhAa56/+38kLbKCv56zzG2NqaPiNQJtNuhvUTDI5XLf2nelx8Oj59lMc+84YEjI5d67wz8WIp1hz99VY9U5TVAAv3zkxlMVR7jZHeJYaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TqRNc5/KNjXZYfOeCFbg1q0YS9Bvvo4OXsu5kCwMnq0=;
 b=UGiiwenUwvDQyyGSCATTvHFDIoHKJjCvr+/MV+FyesMHHYY1w5MZsDEy1NywnaJ7mTDDSr/xO2eth5mePphUmItbZY1ngvcbsD8MQod82+O7YBPb1HvhkfiC5eyMdniQTDfLEhdg0vp+UBTTgCUg5lDyLsns6tov3jofgLkG76Y=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TY4P286MB5611.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:2d1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 05:00:57 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 05:00:57 +0000
Date: Wed, 25 Nov 2026 14:00:56 +0900
From: Koichiro Den <den@valinux.co.jp>
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
Cc: ntb@lists.linux.dev, linux@treblig.org, jdmason@kudzu.us, 
	linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: Re: [PATCH] NTB/msi: fix NULL deref when msi_first_desc() returns
 NULL
Message-ID: <awZj0FeJYoIS5_nE@z790sl>
References: <20261120083759.1887-1-zhangjiao2@cmss.chinamobile.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261120083759.1887-1-zhangjiao2@cmss.chinamobile.com>
X-ClientProxiedBy: TYCP286CA0207.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::20) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Post: <mailto:ntb@lists.linux.dev>
List-Help: <mailto:ntb+help@lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
List-Owner: <mailto:ntb+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TY4P286MB5611:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f9955a8-9fd5-4712-75b1-08df4ab11779
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|23010399003|376014|366016|22082099003|18002099003|56012099006|261028144727099003|261022105027099003|261021135927099003|261021121427099003|261102123227099003|261026121527099003|261026140227099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	suNLFHnapX6PQ6FpIuBif3wLoFlwENGjpjxtrmPp+wyNp8Byzi9/ntboHzOFoHljhNAqTVKlD45nMPyJMBxzC59DazejGxGzRxeEkxy5VAylVA7zf1Zly85TxiCpBmVD/AL+jLC7vQTkzaejfXuVnGhh6OcDD/OYzOVd/t4G3g3CrQyCP2iPNN8PlMkP46mzEarVa4X1DFGLe3nGkvGbDK7weEoEw9hQ+mW8Cmo9/lDS8DJPAjAu7wre26pP9Kg8Y3gP/VXde7RTUb71jereJTM3yM4LPb5Qp4e9Msj1LDvzcIC7KqsI05GIWT7jTyasRa8M0bNdGUd6Ed9DWUaw1ZWIgjl7zuH6QndVRjLLm1cAkCrujCvIQPKlWvFD933wjiAgLu9uODBBx+VqxTJcCbU+1juRiZN40xtapP8CiB2cMmHJas0TvLsHs1MfyqPYK3rZHnSlTCKqcWZhiyhaj1BW6aktls3pfVe2xaexrvk62N+HnYTogtAN3BQKUZB/mxuifU3o0BSFN0VzHDf1yVIeLAh5b/63DHirurDw2b6MIwpnVbmrJqpe+u+R3LicdrKd0nueUi1DpslHwXtPbVvquEqKFn4zbqw15MZdBmI2hkXQj+HANW2w0CtRN+++Ba4tlV3hUtPf+9g1N299wzmCZ/AJ30M1MsdSU5BP4Dc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(23010399003)(376014)(366016)(22082099003)(18002099003)(56012099006)(261028144727099003)(261022105027099003)(261021135927099003)(261021121427099003)(261102123227099003)(261026121527099003)(261026140227099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GiEKdxfCLn2wmo7JiOROEc0XiXpT0vmIwtcQN1kv9a7sh0t9beC/OFY08J3d?=
 =?us-ascii?Q?mzrL0VizzQW8czO5Z/M7WXNPAZBp2YjLfuJzTC0Y937FwHpM0x2DYrYfeTOF?=
 =?us-ascii?Q?l4L88EWhNO0U26zi/WqY6XA6m7RJ47Q1FGkXRQQQj8wg4Uis59nC+6H6HElR?=
 =?us-ascii?Q?yZ19snvmwC0G6aDGUjtxyTJ0Ai6qaJLs9oHqa/Qyxwn/YN6M8mhBX36BrjvR?=
 =?us-ascii?Q?dni6eDL+o0qzi9AbaoErttherQf91TCaUh4Q/H0tKEXUm6V29hUjKEL/2jMC?=
 =?us-ascii?Q?hKJgEV84ieM3VvDi4unbx21JYL90drGiexW28AV0pp1X4lt9RGxvdtiUL7j7?=
 =?us-ascii?Q?Znf+IHUE1ONbqAfeF/+XMxKPwYIVtgpzfmTSYbUCcqbAOtS/ay7cxatBJA16?=
 =?us-ascii?Q?t1hUW3an+IhLajvbJoRdjyvG56DSnVa0gXhGsF0DtPcQbFZ2qhLJAi0P7LZC?=
 =?us-ascii?Q?ghBHPGUzFJmS5sIr8LaugSW1jlBbf+3FgSf/4o5BsaevLQ39BwtxOkwuiw06?=
 =?us-ascii?Q?MlKZk8Oh1oPZyIiUlT7xQTa/uBv8NAKOj/Y0x/9DSwhikyszQN5Nmbzbn7ey?=
 =?us-ascii?Q?25OwqpZsD20IspnzRGD6rAyMIwi79ms8ULJn7C/DUlvwXW1MwG9EtaBpQv17?=
 =?us-ascii?Q?MTkTvz1x59MnBy5EV6Ag+8/shik69XPu0xMT+BdZ/9kGxTXntaj0VN7aEWU/?=
 =?us-ascii?Q?nnco2fPWr4LvV3URDA84i4U18KPXAVU+QsOBEAJyzOfNs0fY0mUcoW0As+gm?=
 =?us-ascii?Q?P51sGaYnUIdhTH9Gf9GohRkaGb85n37ju5yVvAlBcX/G6hWl4kDedSIHOn9J?=
 =?us-ascii?Q?x5zKnjgr/1VerEjiK5qho2Jaah0WOiQvYVImHqUI4SmBhkgR+/5aIS104X6R?=
 =?us-ascii?Q?fIJ9+j/v/modm7xMqjOfMbLGKGkUXRR386StrZcM/+/8QI4HVZRYF90rWXBv?=
 =?us-ascii?Q?6bOagyh3PduOak91lSlwtzOXCyyzGQlxZQXglth7Y7G9rYm/ixHGz28MXj5/?=
 =?us-ascii?Q?HuS5UYYNaMuzAFkgVp6QSAkN2Rz0eaw0yyQ6HcO2du2XpuGonru8sWX/5cfA?=
 =?us-ascii?Q?B0G0MBTJ1kBKWkcxENB6tH/G4L+zwzAk4lah0uN0sfx4uuVbAmlMimNlpp+k?=
 =?us-ascii?Q?5bf6l5no5RNY4emZI/O3wVdP9e2SSjMpkqE1+4SvcB5deelwyNZNpudaNIoR?=
 =?us-ascii?Q?AUhCk4SjRMj6O1ijsWB70ok1vG1IcQ5ylgWsF7/dDfTWgvrsSdzsu5u1y6hM?=
 =?us-ascii?Q?QVbl720VLCO26E65wElpJfpX7QhF6i91c0HkvUGVm0dJ4p4eFs5YtcLGqTBq?=
 =?us-ascii?Q?s7JoG+U8gX2JhLGxGKdXnoHtKMVk4kyG3XTsqQiLTUTGxEhicuULPYLTb71e?=
 =?us-ascii?Q?KpkdYkqszhZPHKNFHPlkIdZYm/IyYATqhpCAIOdRN6GAaNH+oPTQDAXE8dXp?=
 =?us-ascii?Q?1eDjphLDjZx2MwSv6RNsB1LQ7VLLYJzjRKQhlychnw28YCXZoHut7BtlbWuJ?=
 =?us-ascii?Q?RKqV0+PjOBRjCck7vw6yog+gigZeB/qiwlvmQW7PsC9hgetFkKjmE5q1+FON?=
 =?us-ascii?Q?mOBX2imhh0S+j1VnAsLIXAznbSc3VThZ3cU4MIRcxwN6i60XfE77j2vZjge9?=
 =?us-ascii?Q?ta/sZ+F7RfpisRW6PbiLDnYF5WiVmIRmL1XAZEziN1ocBh6q24rRQMQRprJ+?=
 =?us-ascii?Q?1tzG/vz/3zN0Wxc4DjMXdrt7YSqoPxHcHjY/XsNqjtLwlFzOqbV4LfVPTfkx?=
 =?us-ascii?Q?E+8BGlGASMBe6ZFDy0iwHaUyU2d4WnOT26bXMHxOVdrcN3FUzsnH?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f9955a8-9fd5-4712-75b1-08df4ab11779
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 05:00:57.5654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bPnBT5SmZbIBrCHQp7ZnD2WaZpwX96h4qAw1cFk5ICH+owSvFv1yYR5NoD+K/+y/Dnob2QUxTtexLpnqOIHuPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB5611

On Fri, Nov 20, 2026 at 04:37:58PM +0800, zhangjiao2 wrote:
> From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> 
> msi_first_desc() can return NULL if no MSI descriptors are found,
> but ntb_msi_setup_mws() dereferences desc->msg unconditionally
> inside the scoped_guard block. Add a NULL check and return -ENODEV
> to prevent a null pointer dereference.
> 
> Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>

Would it make more sense if we would add a pci_dev_msi_enabled(ntb->pdev) check
in the ntb_msi_init() function entry? By doing so, that fruitless and unsafe
ntb_msi_setup_mws() attempt would not run in the first place and IMO the code
base would be more readable/maintainable.

(Even so, I personally think the NULL check you are trying to add is good,
perhaps with WARN_ON, but whether such defensive programming makes sense is up
to the NTB maintainers, I suppose.)

By the way, ntb@lists.linux.dev is missing in To: or Cc:. Let me add it.

Best regards,
Koichiro Den

> ---
>  drivers/ntb/msi.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/ntb/msi.c b/drivers/ntb/msi.c
> index 13e9f52ec8cc..cfe2125b2fe0 100644
> --- a/drivers/ntb/msi.c
> +++ b/drivers/ntb/msi.c
> @@ -108,6 +108,8 @@ int ntb_msi_setup_mws(struct ntb_dev *ntb)
>  
>  	scoped_guard (msi_descs_lock, &ntb->pdev->dev) {
>  		desc = msi_first_desc(&ntb->pdev->dev, MSI_DESC_ASSOCIATED);
> +		if (!desc)
> +			return -ENODEV;
>  		addr = desc->msg.address_lo + ((uint64_t)desc->msg.address_hi << 32);
>  	}
>  
> -- 
> 2.33.0
> 
> 
> 
