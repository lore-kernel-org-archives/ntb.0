Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.116
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793548391;
	b=rtj8ixNShOP9Uee1Tpsf827zCpIinYB3W0G6qLkVjS+Lgm2nm3hrjipBJWvDqICTJ6c9
	 qrK4RrDPszM5YRgjcFV2ar+TRudQRsRHOXGL7dzOiz6zgy29Ci1cBBDLWXHLHtMDgG/vQ
	 i9BE01bk3TIRJy/NT9zjgLd6gTyfWyqycHabVOyzoMgZmhQCkZYXO2Veua548F+UUABo4
	 wRy8euE6vL6Gsh6OiWKjGUjasLrSxO2vIPg/sv39c8x24yQr2a0fU5oVvJCsH6skW7pvf
	 w1sqFkCTC77QM9U7CdqYOD1fBshbOFrCwR+Bd0Awo/X6KoSRDNju1NAt9RXLZA/nK9w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793548391;
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
	bh=SvIzipj9NDM+Qu79Ax9OQzf1OHDMMvrAXAiRhPhywSk=;
	b=ghZSNdABSRfGVH8Qs5kvySOHZbjVLIhQL47TLpGum1ymU879Fs6lxb5J6yOs0s1WTzqE
	 S6ve4stZp054im2fVXVqwUsuXp37yfPtgfwR7mPoZbBz4QmsRhgjmD4CGqZKYmZOiQYsZ
	 MX1Pry2VpYC2S9l/MlxkQNJrCowddGMQ1HPcPq8PJYDDuasf4/lvvGM8WNDv/o8SM5gbM
	 Rwl/CslHkpzU3iY11d2aqqh6Vbivm/m3bIQiEb8hbKH8xma53zTrT57ptpWFOeEckU1pA
	 9BaACbHbZJxek7hqUvlCSdxpEEoSf5n3m16YkZRdJDT123pBONhOfQt7AR9+52oQBzA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=NRayFw3S;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.116
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021116.outbound.protection.outlook.com [52.101.125.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF9A606A325
	for <ntb@lists.linux.dev>; Sun,  1 Nov 2026 15:53:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CF9A606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=NRayFw3S
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=is+I9j9P2AHkC5tFMAsZ1qvVw/uFfm4HAnUbhh4JuU/g8T7ExATE2Ax3xJECDun879wWOEhma1WcU1T2aO6XyiU7O406KXJ7ZcgD6fsjhn6tyn12zuD++ZvSnCSImhCCP1JQOaB/S4oB664oj6XtDm3/iRlvbk1gAOoYGVYt5kty19GWJDRkaZDiNucuZKT0KkvHgIGHVrCok65nZa10mT3u9JnG1YRbtjD7uenoxg5UdQBqdCAjLLQ4qh7jWnueF9HFV4CMQUaP5QtfA1AsbuJ5Pq7Nh3AHQ0lyN0BxJdCO3SDEqagwBJGB+YqhlYCHkfrlWMcx3b394joyO+mvoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SvIzipj9NDM+Qu79Ax9OQzf1OHDMMvrAXAiRhPhywSk=;
 b=ox1Uhw/vd0JDLK5/SvQSROQk7tSevUc+bfI/almsdJZhXSlA3G20BPcETDbTcsch265lidlYxYP0ITHi44vX/ddPRYXcHDV7wxU+jiuq2/L3KkRIMsgbw+imDwUSSkcoEB6GxBbRRodxR/JTRBboBWsaGbwN2dcQ5zik5SwScUZvMCUls+hyNENNB+3BczB2LZS3hv7NobxepB6jZZbOGen/rul5nv+gm602HT5MxCNSKE6E/gh4+2HrUwwQMD9lp9zMZfZVosdyjwvK0fNkcvnRGpcIkewoIx9+iDrUVakmBgoYZGggZgnIGIFTqv6ceDpo0sFqfNKSy3FGmHyBuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SvIzipj9NDM+Qu79Ax9OQzf1OHDMMvrAXAiRhPhywSk=;
 b=NRayFw3SjEctvD2Zq5qycpLhots9o0vmacADK1w6XEWhyNMlgeHezLuKn2wvocRgsQFGkujj/FRnkeo0ME3mzYC3IZqfeI0rxRE70HF5wDoDbYE5gowS82orwXbBYUFdq3Wz204Iyb2vtj6CbUOrb80H1QQV8j1PQBKUUXlKLZs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS7P286MB6586.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:42d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Sun, 1 Nov
 2026 15:53:06 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0569.011; Sun, 1 Nov 2026
 15:53:05 +0000
Date: Mon, 2 Nov 2026 00:53:04 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Avi Weiss <thnkslprpt@gmail.com>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, Frank Li <Frank.Li@nxp.com>, ntb@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] NTB: epf: serialize memory window parameter writes
Message-ID: <y7wl4wp3my2vwkyolstz2qndurn2idm2jkxfdcmpao2pydll6u@45sh5nckkxjx>
References: <cover.1793540847.git.thnkslprpt@gmail.com>
 <eeb0cfec451d748b2f997c16a0a3a2afb56569e9.1793540847.git.thnkslprpt@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eeb0cfec451d748b2f997c16a0a3a2afb56569e9.1793540847.git.thnkslprpt@gmail.com>
X-ClientProxiedBy: TY4P286CA0058.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:371::16) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OS7P286MB6586:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cc458e7-3729-480b-792f-08df383037dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|10070799003|366016|4143699003|56012099006|261009223027099003|261028144727099003|261021121427099003|261021123027099003|261026121527099003|261026140227099003|261022105027099003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	Spk5BWHHLW+fTK1I0Fba70R+0sr8XYVpAGmZZeD3QuGEgDQbxCe+8kTGjinZw/8E3j6AkaCzPHgy53SrEPs3XKD9kRe5ax1rIK2qCtkmwd2bbvjBvncusoxgrq1NVIEOy4XWSowvPmc/MGl4KrUjbZnMx3gFaULq2rIn8CJTXITVSWBhYSJD39+E47R8phpP/sSGuFFb6qlQJl6I5sA4mKJpX9CJD2FnpLIQrrgl3uftoQ70DNHJBwo83Gafk6IqJ1XbyChXsx7aO+3sLxhdJx5hVMX4HJF0QW86kmHvCdWq62jA1/XXfzw0cwaCCAJKXfeS+6hfV20Zbg1EeqaEeHMsjeqoWnbm07+s05VgaqzbuQhKiizCKLVGaQtHvHFlBr7VYf++EWBkUuXi/aUMFcaB7lUhurUFi7tURrQn1D8JYBvVmQXi94xMYuhfPf6CTVnv5lUq54blu9cBiRv63aouSKwOv5UGM7meXxZihwloIuQ3FZ0wY65JR714wZzVY2kNpWxfKZKE8d0SBULGEUtzVa65Xulk+ZlrqtqXn/P8ali9XLZn+gs0aKqBkUQqdBIt0vDP5crfx24ZgFshUyqUdQEFJNTY5xH0yguGYUUMYukPHk7cjXk6qtclfZPluppRMMHpY81MdrsX8omwCcx6Pp69qvuiNFr1nuFwMyA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(10070799003)(366016)(4143699003)(56012099006)(261009223027099003)(261028144727099003)(261021121427099003)(261021123027099003)(261026121527099003)(261026140227099003)(261022105027099003)(10067099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UFmq6COQLnwZ8i51iOjkbTJQWnij60kIyTVc50UKXOjtrz1oSlywbauHfgoa?=
 =?us-ascii?Q?5cGPQLV/w/VPwfoVz+KI5gfZcEv5hhwci0ylaCAJDFAeuGJDQpam6c+6GV/w?=
 =?us-ascii?Q?FmXeSDl7xjkYFPuC3HJziWm5qOdv8dZl0ABu0Q5a+S576w6UXsQgByMVngZR?=
 =?us-ascii?Q?KOoK9+O8swx2/RQHY2tlovPAsPIUKZqMZBlfFlBYawYEODZGLBqz0p18bIhN?=
 =?us-ascii?Q?L0L94savAi7uinL8a4/ngD5zSrX1Q1sISPPfsXkNuoDzkTzQsk3GqmAV+tS0?=
 =?us-ascii?Q?wexD1S36hfbS8wwkk9e+rm9U+yIACLrQR7d3lj20HVo5809eXgKitaHCvgLC?=
 =?us-ascii?Q?HFaSS9033yQAOi7YuMsYRH1am9pZEn5raJ6aNCkHKGbI9q9GKpsVsc8wgOTx?=
 =?us-ascii?Q?UvGPjuc0sC8+Kgqa53Pf1gYIN5c8t5dei4A0p3iHCDBARHEsES4D3SDVXpuY?=
 =?us-ascii?Q?3dfsw65A74yj9CsN7IzBbSMvCds6e45OdvYDOLdoY4fry1nlZnB0/Ud7Qagh?=
 =?us-ascii?Q?PhWZmDSsOQq4EbpG85k5IBTjanzZBnpP4wvewtGOjHZsh3xUxlhJjujcBRnp?=
 =?us-ascii?Q?s9fhHzCVcKF2wLq99SUB8jcJsvRYZwlk1DXuY+tMEunJL+l/BPdm4YfhYq9h?=
 =?us-ascii?Q?DdGFe08KBtqGP9oCSei/VucvLLKCzMflReBWXo3emebRsdIQR6whBkjvCV5B?=
 =?us-ascii?Q?7+poHvYhf326i2SGlzB8T6QolpckT6siH0hJKgG0zWHYfii1cuVb3uKhV/mX?=
 =?us-ascii?Q?xKwDGO+cfwDAkDUFIbl7NhRE/GBQx6WgfQJgZsNlBwzwiFIg53bVaDkcM24q?=
 =?us-ascii?Q?0Lg+Lh9AHiteMTqcB5bbJnKl/dkVYauCglWDoE9WsS8Iflpx7y3tcUruBKHt?=
 =?us-ascii?Q?NAYr2HKXiFvfnR/KkZ5v79AqFAm/bybmtPy/xB3NRn59E7oblFnaKtQ03O2c?=
 =?us-ascii?Q?qIkAAjvkICH7p5NaPj7wqvxPH+JSO+LChxxXfbGl/l3yVd9dys093c7xP/kw?=
 =?us-ascii?Q?pn/rR4lovsXIflH2yCztmHlRtoOGOESoGZ6FjTwZz/o3/kCfoLt67Rtm65Aj?=
 =?us-ascii?Q?QD3mbnrQbGJAHrS6KhiZHowdPAc5cSqbqqR5UADOZfF5mgJafYMbQxbqBjS1?=
 =?us-ascii?Q?RvTB2fTMP1Mf14FFOJ3OJyA2oW+pz8Lj/tsku8zqLVmKpmwWGj6V/6BoZu0G?=
 =?us-ascii?Q?JdzfU7FcsqYaynHYYKoQET08IBJYX3F9++4q8kGyDYeKtBPx1kONJoiMdue+?=
 =?us-ascii?Q?TDZyu137eOeWpC5JdvK7EVlYbEEwVh9PjBsbic9Fi7ZOL6FmgGwePHiHKBqj?=
 =?us-ascii?Q?NV5bTNp3KISRqTuIvKSZXH33isw7Mal6ADmOPX63iFJIZy4KCxcBTkxe3xdR?=
 =?us-ascii?Q?cyCSh21zkrLklFKLMvLkq4PRgM9KGLu05k0C+/gLqLKgwR8ROpxNvKMa2IhT?=
 =?us-ascii?Q?4lK51JYSNrdWvJuM4JQ6Tj5bSrUX+KXYDEnAzBKtQOZFCdYhG8P2avc5oP8e?=
 =?us-ascii?Q?j5vo4HWqhdgtPPgcgL4n5lm7iLW0sr3HHyJ99mvgoDhgX8IvEqOA51HsQ7Aj?=
 =?us-ascii?Q?ZOjyyFJDhk94n2WLKdljfK06KbZgcYBqmJiXdUdfQtl62qYXW7z/33d9kLgG?=
 =?us-ascii?Q?0Xf3/GwyIiJLCG3wf82sYQ6K1ECDl2RyObXSgZz+1rZdD+LlfKLEwln/JxZ4?=
 =?us-ascii?Q?3PxZNHIMs44GOb4o1Nu80yNtXVXkEGz0UY62/jQOT3oeDN0DnRnkqphK+829?=
 =?us-ascii?Q?OlMD4FvmPXjL7Oe51gtBoSX7Z0GYaE2gJDGzYaVOgVsL8/+gDuJV?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cc458e7-3729-480b-792f-08df383037dd
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2026 15:53:05.8487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F267kOIf8dLMpPKrmLoTvdXThlHF4Mztye3QPFzlKR4BIJSUnbges5eVJWmVRVC1yzJSq0xMR+uK6eSHimu9DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB6586

On Sun, Nov 01, 2026 at 03:57:05PM +0200, Avi Weiss wrote:
> ntb_epf_mw_set_trans() writes the address and size to shared control
> registers before ntb_epf_send_command() acquires cmd_lock. Concurrent
> memory window setup requests can overwrite each other's parameters,
> causing one window to use another's DMA address.
> 
> Hold cmd_lock across the parameter writes and command submission.
> Use a locked command helper to preserve the existing serialization
> for other command callers.
> 
> Fixes: 812ce2f8d14e ("NTB: Add support for EPF PCI Non-Transparent Bridge")
> Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>

Reviewed-by: Koichiro Den <den@valinux.co.jp>

> ---
>  drivers/ntb/hw/epf/ntb_hw_epf.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
> index c47607d4f8a7f..da7fbe1800656 100644
> --- a/drivers/ntb/hw/epf/ntb_hw_epf.c
> +++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
> @@ -123,15 +123,14 @@ struct ntb_epf_dev {
>  
>  #define ntb_ndev(__ntb) container_of(__ntb, struct ntb_epf_dev, ntb)
>  
> -static int ntb_epf_send_command(struct ntb_epf_dev *ndev, u32 command,
> -				u32 argument)
> +static int ntb_epf_send_command_locked(struct ntb_epf_dev *ndev, u32 command,
> +				       u32 argument)
>  {
>  	ktime_t timeout;
>  	bool timedout;
>  	int ret = 0;
>  	u32 status;
>  
> -	mutex_lock(&ndev->cmd_lock);
>  	writel(argument, ndev->ctrl_reg + NTB_EPF_ARGUMENT);
>  	writel(command, ndev->ctrl_reg + NTB_EPF_COMMAND);
>  
> @@ -157,6 +156,17 @@ static int ntb_epf_send_command(struct ntb_epf_dev *ndev, u32 command,
>  	}
>  
>  	writew(0, ndev->ctrl_reg + NTB_EPF_CMD_STATUS);
> +
> +	return ret;
> +}
> +
> +static int ntb_epf_send_command(struct ntb_epf_dev *ndev, u32 command,
> +				u32 argument)
> +{
> +	int ret;
> +
> +	mutex_lock(&ndev->cmd_lock);
> +	ret = ntb_epf_send_command_locked(ndev, command, argument);
>  	mutex_unlock(&ndev->cmd_lock);
>  
>  	return ret;
> @@ -494,11 +504,13 @@ static int ntb_epf_mw_set_trans(struct ntb_dev *ntb, int pidx, int idx,
>  		return -EINVAL;
>  	}
>  
> +	mutex_lock(&ndev->cmd_lock);
>  	writel(lower_32_bits(addr), ndev->ctrl_reg + NTB_EPF_LOWER_ADDR);
>  	writel(upper_32_bits(addr), ndev->ctrl_reg + NTB_EPF_UPPER_ADDR);
>  	writel(lower_32_bits(size), ndev->ctrl_reg + NTB_EPF_LOWER_SIZE);
>  	writel(upper_32_bits(size), ndev->ctrl_reg + NTB_EPF_UPPER_SIZE);
> -	ntb_epf_send_command(ndev, CMD_CONFIGURE_MW, idx);
> +	ntb_epf_send_command_locked(ndev, CMD_CONFIGURE_MW, idx);
> +	mutex_unlock(&ndev->cmd_lock);
>  
>  	return 0;
>  }
> -- 
> 2.43.0
> 
