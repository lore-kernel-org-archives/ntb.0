Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020107.outbound.protection.outlook.com [52.101.229.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1AF1A4F2F
	for <ntb@lists.linux.dev>; Tue, 17 Mar 2026 03:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773716499; cv=fail; b=rt9T8rJ0usszJX2+zKwbHKb4HoMzqERwdgnO8EVrXjMyHma3JpFWRrgZZdVMH8jYnPtcK981laf+RxaBG9J/pVp0Lqf4g2U9VSnFmaHOdXyzjy4J3YrnF0egNIuBX+vnKE7E44Q6rSPnivTU0dOD5c2KsXpT6PojZkI7s1JLk94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773716499; c=relaxed/simple;
	bh=yNDMUUvKxy2tpURU1z8kH9ealyLd1KzaPh/DKGc8ah4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ST30pUbLSomcWDUO7jIEHSyOS/h7dqOlKa6PfsBo5pd4ZQJJM1GotShynDC6C1w4tmqKK/PuT37kD/AxYuAEP94M1ldChltncXe0QsdT+340AaaNFOYr3j71wIbdGxKffhFmWu+5t9trbHcRFBSICRylLdQ2B1MOYy3BWo1Rds0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=l4AY0lPo; arc=fail smtp.client-ip=52.101.229.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="l4AY0lPo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B+xdLsGNWU/An+l0lHYHLN9aCPCAGUefGEnLsK3wpJW7xJMjPOOVrDAY4jto8Q8G2gurmm9uCYIviDgp65IH16I/I+vgSzVx7zbMQUZ1MR7CwhEc9MWTciN1/Or5+hcD2ZckO2rpUXDPnlP9c6SBh9XaSody8Lby7oXCpvzboChUfTYXVM90qMdY+aSzVqmAYxa8UXX2ilnvqPRBsHdHMOypxyP+2KAvoR0Q2OW2hk9Hw3laHoJfBJZnm1V6L9vDjcEsNAS478J99v2CP50OnVbsTggCsd86w4c5+voMD6TmxiHWlfgOXxHOAFyqFF/6uVCzR24/xQpD51JKOHyFaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5y4BMCyGrHqkDelsVbBWccWWxH6m3o5YKRtJ0rUNqh4=;
 b=XATOpfDSsIhYaRuTQR8p0ugHOf8PMPPWHm4LzqZCB5N9IntNnM1nVEfEqIaqRa2wGqyUPEkwrjn5XCe9143eRTNGqiKaTGivrLvVsfA/h1EJRfM2pWjPzOUsIyhUiJCvehBMgJwovQOUIum62aHfDaVZarhHp+L8AL+WTKaorwbrK9yWU3hmmhAYQyLVeDp9itlGtK49ZCUJApjyzrwf3+qDrpuAGlYqLc/0x25p7wftdBMAvRVfLLqAbyZuS3OjdMFh6pUJSvEP5wymbbSuCPH0FuFYeihNkZ0Kj0ZrbCObOuAH4UuJ6zjdRgRdP8ACT8hTkPlgVzX6/vR56jy3xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5y4BMCyGrHqkDelsVbBWccWWxH6m3o5YKRtJ0rUNqh4=;
 b=l4AY0lPoEI62q/xN6ea+BsE2RkPIBHwtFEBka5Q1UbyWvFq6z5p8K0wLmDrTHa+CqLDvTv3R+pZ9ciFLkHB9zerUQrVODjsSFcygntG2S5SG8GQ3rM1u5daULGIw5pxQFZ3hNvldSxTyxcYYECBlIc5KxCCOoAZATPKY+ubOInE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB5424.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:385::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.27; Tue, 17 Mar
 2026 03:01:35 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9700.021; Tue, 17 Mar 2026
 03:01:35 +0000
Date: Tue, 17 Mar 2026 12:01:34 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Frank Li <Frank.Li@nxp.com>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: ntb@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] NTB: epf: Fix ntb_hw_epf ISR issues
Message-ID: <wzv676qh2bahuptnzhhyywt2ihuz7xn2j7mcm6heqoweqz564v@mx66vyni2vyd>
References: <20260304083028.1391068-1-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304083028.1391068-1-den@valinux.co.jp>
X-ClientProxiedBy: TYCP286CA0254.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::8) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB5424:EE_
X-MS-Office365-Filtering-Correlation-Id: 0faf481e-9d15-4677-867c-08de83d18037
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|7416014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Vi/0QL5eOtH5RVc27SlLE7x8WtFwFaui9RfbjAMsh2p/NOYoq8fynrgoIbag9wG9IC+d0B/waD4a5GGbc6y/5mL7jBhJp8UiSpIEZIyxoI2qjeqSVQ51/PDS3Nvf3Gjz68kb1ltZYm78VdmIwmKNy1jqpJ+fPAnI8GKt3YxNDW2L54kalBIOJ0zWlgUJLDLBBCKLimW3ZBd3V0rHQ/qrTPb3kqv2GV8f6wjCV0xp0M7uMRFEth8aFEqTz6IPTBIibwP6VFzOA5lxi2/b9ZF/RIPWpZ/R+ZXOOxz5iytraD046dGWVlnD6s9Uvio5bxsfc0NI8Tuum9mbYR4Iq9JG2pmyr8ttFMsx2xk3QTNfggvMAnjwYXCdZHsM0RjZH/rLtuXCt74nhxlG8knVPrN8fUTWZbHywaHpfFSS2ibm5Fz2dXU57QNZcWJx1GT2XHTtAUp28umOBM+vE6ejPlCKdOhqEszjwpa4rSa+rrVbDTaInq5wnLNePxQ6Vl0jzGpjrcEY3ThcG1N5FC9FeM8qXtndc0hWB3pUb7uHanVsX24UT0S3HQVqyh1yogSEGQClodgQcJH2VgGUxBvbbQUPHLWYMhZnhWzplZgRizRjGFRD0BenNLQ78JLsthq6NxS0uO1N6OV4m+gPEhX2w/J3NuIihyYP+k02xaK9fz8dqdVwouBN+BW1Ewjx027h5uMMlZVMrG5oS1zEgJqanPpkb3tTaHJkKXns6LJ9IUp5CTc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(7416014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IjnC6krSuiwR/NFRaGh5a9fu/NKgC6yjYnnRSAjL8RB+EabFLzNnHbw+lu12?=
 =?us-ascii?Q?HK9HBHuYePP+S7Am7LP4lM08lMZVO4ksYqblHFiv6Xt2R3bQWhU6wMZ0rAkn?=
 =?us-ascii?Q?CJTzHcfsyn/x8wRwJE3+97XdPbhiN9wFvZzmvShVnC7UARhw8eQwQkDtZfrw?=
 =?us-ascii?Q?pwqThm1jgPVkh/cuZuxBZjMu3tVx34ZyxQr78XF6S0ZDVq/SuI2BymQDG1Xc?=
 =?us-ascii?Q?Pg967MlFpXFKTaIU66qGmPMRgXhO3yDV+w4li14nHAs/8MpYxf/f0DUFQMCU?=
 =?us-ascii?Q?2wLqsNJDRieia4VOLhhGf0gOONHnHiT0JQvK377HRZfiFjW7G+kQN//d3ATJ?=
 =?us-ascii?Q?smyn12TXDYEMOT2jlmf0R39RpEtDfsexPi4VA0ImWo6d8uyTEzhm8mzecx38?=
 =?us-ascii?Q?ZXn961DGgmOytaHkxS1afumcXh7kQSV2uALaqsSUpo30OEQjia5a4qLS8I2K?=
 =?us-ascii?Q?RT37Ca8WDytQO83MYUdnsCpW31wwq0U9q7/0RwTbGAt9y/MKvPgHRt1TyARY?=
 =?us-ascii?Q?M5O2HYmsS6oy6zpPaVn1I0D5IR88H8ZIIm/TKlu7Mcw1rodidBAthFbdQlw0?=
 =?us-ascii?Q?nujHqH85kJAiW92imaODQSBCCTY7opzVZEDYgk1ABVF3kJ3kcQIxaGhx1+EZ?=
 =?us-ascii?Q?GujQpC4SUekIUC/fRO7YyNNQZKpbXJNmy96cgJWmRcSCPU3SxhEYfPDrbUpq?=
 =?us-ascii?Q?b02A3qYw+LnKYl8CwncAGMSsk7WeKKTidCxEX2jnuqBVIQ+MqBH2OoN0WZpl?=
 =?us-ascii?Q?c6WsSJzRQIHJzoqn9gq5XpYHkvKoJurWOsyQNxo3AMipRLwoYk2zTs3xnwqG?=
 =?us-ascii?Q?+UoPLVw9SaOwVwF8tKdw5ZcPfoXX0PnpttlkXYF8vOCU29pVRMspDdEJhggf?=
 =?us-ascii?Q?Pc2iwva2dW4DANPBvogMWDl2+m4XightUcuKBMY+a3bOCPjyW9sYYv9ysz0l?=
 =?us-ascii?Q?kvghqVvNvm/MwjktbKBejFidNrgpKKWiScV07yEASsIHAI22Q/I22q1/UQcf?=
 =?us-ascii?Q?G5jVPXwdPSIfT7SARR+0tReP0CqSVC9o0BMfc0HzfjVTysq/4Kjkx2TwNvWl?=
 =?us-ascii?Q?+itPIzf/EbaiiLWcheIzNmp+Luad1ThZQAAILEK5fPxZpT/vZ5aIxeGroqyE?=
 =?us-ascii?Q?U9X/6rYgCJPDDAXj1gqRfewJiTxr6Mq64QTacn9EWlM2oh1gVaftbPlAXwSC?=
 =?us-ascii?Q?qST29+hMAVeWe7C6JI5210nKcglwA4FKJD/yEzVhrbu5ssIjTgAFzcyA3dOp?=
 =?us-ascii?Q?4WaNJM80fntA5LX1NzWW+A8aNduqXvxNuJH6vW0/U9MHkuwNlhpKqgmmDpm0?=
 =?us-ascii?Q?0hCYqiT17ihfS3pl6h/b7yDNPl+t3DhATYpJJ+nWsVQ4yWtt3DWdUzeSZwMp?=
 =?us-ascii?Q?cAZqW0UYHz4x4SMuLuE5Oe7uZunh9W0woFv6qjVy4rb2vwTIvdswQ7dXLhj/?=
 =?us-ascii?Q?OfeU7fCc9x0AnqfLB0TX2pBuMrQCcodFB1Gkcz/tcTZni2yX02CafhSWYHfN?=
 =?us-ascii?Q?tfR4zKETkEjPXhmdwOZBCf1ECGtu8lI0A6X4ihBPbNS4x9g8LR8YSvGlsYyC?=
 =?us-ascii?Q?l8wds+1d+MK/9cb0CfiQT6A9hD7NB+urua4aTk1r4ntsAoP836xIhLU0XgoE?=
 =?us-ascii?Q?mKGFbjyi/pE17BJpCIzZtCzejQdDDv98w1Nemlda4xOPsZu53VHy1aoAe7aU?=
 =?us-ascii?Q?JLyC9ZHSk6vCcpY9eENqmMDV6XLwL6cI3ezF2MWqQALgpyT8t3NIkudo0hm8?=
 =?us-ascii?Q?klI5sPHLGqJ96MuC5stWm+Z5XadH1yNYqH3U8Fh8q3XgkeptjinQ?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 0faf481e-9d15-4677-867c-08de83d18037
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 03:01:35.6333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WOLcZP4iuyoai6DSG5ASEfwvpWvJ3aAejJ+qgckoFNvcrRjsGrrov75ES4uVWeFnWVcWOP+aBgZ+i9t7cbAp1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB5424

On Wed, Mar 04, 2026 at 05:30:26PM +0900, Koichiro Den wrote:
> ntb_hw_epf handles doorbell interrupts using multiple MSI/MSI-X vectors.
> This small patch series is to address two issues in the interrupt
> setup/handler path:
> 
>  1) ntb_epf_init_isr() does not unwind already requested IRQs when
>     request_irq() fails part-way through the vector loop.
> 
>  2) ntb_epf_vec_isr() calls pci_irq_vector() in hardirq context to
>     derive the vector number. pci_irq_vector() performs an MSI domain
>     lookup (msi_get_virq()) that takes a mutex, which can trigger
>     "scheduling while atomic" splats.
> 
> Patch 1 fixes the request_irq() unwind path.
> Patch 2 caches the Linux IRQ number for vector 0 and uses it as a base in
> the ISR, avoiding pci_irq_vector() from hardirq context.
> 
> Both patches are Cc'd to stable (v5.12+).
> 
> Best regards,
> Koichiro
> 
> Koichiro Den (2):
>   NTB: epf: Fix request_irq() unwind in ntb_epf_init_isr()
>   NTB: epf: Avoid pci_irq_vector() from hardirq context

Jon or Dave,

Gentle ping on this series.
I would appreciate it if you could take a look when you have a chance.

Best regards,
Koichiro

> 
>  drivers/ntb/hw/epf/ntb_hw_epf.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> -- 
> 2.51.0
> 
> 
