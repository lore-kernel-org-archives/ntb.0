Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010042.outbound.protection.outlook.com [52.101.84.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0049C224B12
	for <ntb@lists.linux.dev>; Tue, 24 Jun 2025 20:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750795330; cv=fail; b=qzPNkc6kP7P6lEuK9uS1dq3FvxIoNZtJf5IlsRcMgMSbtBQvtYOW4HcC5EVlTkmkhXsbjtllmnzz4Xiey/1uIdFJBcDTf0ogVzkDorf1amukgR565J1CMNry6rPZxhnXUoad3rLwJWvXQisjK6fhAXJa9Zc3eTNTChAAzZEiEuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750795330; c=relaxed/simple;
	bh=pBtUkRoDKPAtgkhvCAokBlFJl8JSLehobFVXXiWXOxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Bgo4xemBNUvQsXn68PBiQJT+BKAjgKkAl8se1UDcX2zHrhvoPNKBqfo1AJYNXph8zyTHf2+5Z33oav66wxYJKl9JT1in78cdQ2d+KhnsBYVO7bGjQX0iaGtol0TsXsdvmuVUP+UBUpUvZ9RZKgn1hnD1hfqzYPGNJxwgIgByOR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QnWUK/SB; arc=fail smtp.client-ip=52.101.84.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QnWUK/SB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AE9lRno/D4pvEquaJADRdIRF31wn5Wcl9293LFTJa+Y2LU/xnq3C2ylDHiWLhCWdg9LowU/oaQkwk9O2FZmvhOaHEWBnpJxtrVZl6QS24pf0cMpMTLzkAkggxuf1qvb4p4datIP59VXBdiBy9fdoGYlqbx4AtipBFqbpBmS/kmTAGEmv4Qq/51tuouD1RAayVI5qdwB2b99yMwtTDL0FcVVHFOOQAS082FaYpxPr0iBJ4j9c7f+C6K44X58SOHkNYFKXyQEooz4cWELo86klX2gvlZ4k8hDtZh6yOjqpl/2TXRbMZnqsaxMcRcPoOZv/fD/7TFc9NeC57GJK02oz1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HUQ2lQRRRh+5b1+J6wOJ0Iv+rm7olslfpAXeLAkLRds=;
 b=xf6/VakiNcaOl8umk0+y8zhXltz+6gW72usW4c6Atr/3qmkOoXSW89h9E8a26B5mv18HU+DUp0Ctj1K6sAIDRNXc8AKtYAxfRk8hpNRwdjCJFFQOqa9cRIsu01+IUo9kKm+/EkxQK9hLJ0N9t6s7zx4xkpEeJx6JIqdLdBUMLSWrxZEyIKnJAJe+2KTcKbI8Ydd2cCYDqn/nqpVg9jd8kl8YwM1nKRMn3y0EGCT3qJeu1e+2dTIoMQhfdGISCUl4Xk8DuV5qkblRIFh3x0+m5Vh/PPHVePjccU/rjeYYWefhZV6Z0qA83xrBduw4hUmk+H8tM/UyvHv2qlIjbZAViw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUQ2lQRRRh+5b1+J6wOJ0Iv+rm7olslfpAXeLAkLRds=;
 b=QnWUK/SB6pMCBigL84JAq/luNH9jrdTt9badC0347+f5kHMEBCg/tLoM6ifVrCbPj0yzCNd45eWLrgM16nAusiB5NNtpDaoJItoGyohuLa263Gznkcl007iXGWuYw3yqAW+VN1EOzdVbQQTTCJk/XVRaKNIGHHl2yt4NnmpN4N086I9ZRvxpbBP0vPo64EaVw7kBfNNlfzMkKSn3x+UxoV+WCzhtQUOklLCQFw/1HaKzFtdx/fsK1FDXwWHzOmi3gxKX0ZJacCm7swwIxCjCh2sjHG4zhVVIHTN0nbVUMcnLVoooXPCx+C2nIJ7u01TbvHQDGnmzsyeLoo6XpDPlWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7899.eurprd04.prod.outlook.com (2603:10a6:10:1e1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Tue, 24 Jun
 2025 20:02:06 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8880.015; Tue, 24 Jun 2025
 20:02:06 +0000
Date: Tue, 24 Jun 2025 16:02:02 -0400
From: Frank Li <Frank.li@nxp.com>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>, ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
Subject: Re: [PATCH v2 2/2] NTB: epf: Add Renesas rcar support
Message-ID: <aFsEOl83Abw9kVAA@lizhi-Precision-Tower-5810>
References: <20250624-ntb-rcar-support-v2-0-8c0e5cf69c4d@baylibre.com>
 <20250624-ntb-rcar-support-v2-2-8c0e5cf69c4d@baylibre.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624-ntb-rcar-support-v2-2-8c0e5cf69c4d@baylibre.com>
X-ClientProxiedBy: AM0PR04CA0093.eurprd04.prod.outlook.com
 (2603:10a6:208:be::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7899:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bdb56ef-4db2-464a-4edd-08ddb359fec0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4GyW7HXkW8EGAWIsdDa7brwLASzlLEUalhQqK/6LsFisj/e89iJOvG/NOZOf?=
 =?us-ascii?Q?RRVkTdaiNNgeI0ojhyNidulPiSofVlCfXMiNOkLgcnGnsqWiIz/asmue0rw0?=
 =?us-ascii?Q?e33a7NSXEzORqiLIUXW5trnJrjx62QGN8a2i8xucd1I66GcbSWOlefqPX29c?=
 =?us-ascii?Q?LqTJSv1cwBi0ajwOqXrtQ9h/RCU4ZGhl09LOtcVi5DJrig+vFV05AYvOqKD+?=
 =?us-ascii?Q?dalDkqJxhk4EDTFW243IRbIiaMAIU0tFkVRgYhZ1xr+beZvLLieJYy7vHuE6?=
 =?us-ascii?Q?fN3PfMlHvTpP9FwsSIdNXTM+NZVrwCrLM8Uj1K+rB2Vs5XZ4pYor1K++QgFH?=
 =?us-ascii?Q?l83q0jmMpD8i8EY1Hnji5266JV4Ys6LGq0S5zXwVdXKXzh0idqMbev1bIuTv?=
 =?us-ascii?Q?aWTCP2mG+m0CvXQRCKKJTZ8xoHDlrSNrU22hHNCGB9AqkVsI2u6921eVF137?=
 =?us-ascii?Q?RDRv5E6I21/3VVC+o/o6pNPrDuc0fZgMBoUp5xbPvNGukQdKcv78d6GXGf/Z?=
 =?us-ascii?Q?6gxAeSUtKUsTWcgEMd+UpzyIoj8nPAw6NqL9UchkI/1hT/aSUu8biBrF3elP?=
 =?us-ascii?Q?k14MojAUHawO62IMoJUK/m8G3VDAWg6EibN7+8dugKZDqdKuSYQt2rcyBTY7?=
 =?us-ascii?Q?ay6edk4WWn0aXXBTawrZgOSIQtbvA+41oK+fCHi8IqL4j0FHP28T8HIDcKQX?=
 =?us-ascii?Q?66kxukAVnH+qoymkTrZPXco2v++ekRNz/0qh4xWxMJUG3JcBF8g73Cvhzpr/?=
 =?us-ascii?Q?PWCzhsoGXncnjcYP+zRBv5Jz2sUlBdixGzhSDPQBBPrrL+KOQUXD53RdCNuP?=
 =?us-ascii?Q?wqhPGKyVkQzPPXf6GAmdyn9woSEQ3vhdetSFC/YgcPN0U0iJgORJswJww8ZR?=
 =?us-ascii?Q?chEYkJuNkJ95U5Ig0vJbxMd+oX32XkS0qLzluIhA/wSClmvKlhVguFv3pl+C?=
 =?us-ascii?Q?AO+fizK/kJjULgzym//wZQT2Wqv5yE8U7LKZ25Xkosvh+qUJ9iFe/+H8/8si?=
 =?us-ascii?Q?0udb/2GRSioP6C26y2WocXj53zk8fn4bPqPa6UlrdJrdvkrgeQZw29rlOFoD?=
 =?us-ascii?Q?NFyPP59K6xn17GEujaniJTANGgB+YZyXEnppRRe1pHpOhawMhCqA2Hyd6ziM?=
 =?us-ascii?Q?09X6fZ55r0erftMMcr+dQQYYvBk/GHBFD0kyCfxccalBVfUbFGqTUlz2Y3+v?=
 =?us-ascii?Q?bCiQXVvnuIJLPmMajoO4CmZ/00v+AjDy45Bz7cGVtYc2Od0GmvIbcg/hBttb?=
 =?us-ascii?Q?tJF8kKYJcc4BCEXZMhv7pJ44iiEXgMJ6yFlxp0uPFevx9Di68v0iFMggwrpg?=
 =?us-ascii?Q?1ROn6gfszMRNa5Ubes2EgDsGMJJTP9mm0yGPSbW/ZDKp1cJPXExtAhnNQYBH?=
 =?us-ascii?Q?aSEk2uWsuxhLEMS7cRfs391pso0meMrc2AFb8un/NhV9XYBO3FORKGLOM62V?=
 =?us-ascii?Q?bF0FuY8JRa/lDEnQ5rAPb1yMhcZ1J5ogXN2ExovF8gtO87Ha6xbPLQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EDI2GB7Jsb4jucFnjHa0fLZ76I0LM1+8pwaqH42vTT5sGiWpWL18u4bSEIPd?=
 =?us-ascii?Q?efcE+TnvEU7cp2UIO1HzWr3VE6Zh6KY1HcE5GJLYSSmksSD00xoUitthq1O/?=
 =?us-ascii?Q?Ci2Qn//QFEUM9mlLOrvoctrvT1F6iKMjkxiw3BkIPgQl/M7+4K5ckuXEbjBb?=
 =?us-ascii?Q?yFBV6+TKAMETg/ZwDX7vQobjnLXNB0qGh6DK51GhyQOKPlUc0BZD141Q2vb8?=
 =?us-ascii?Q?DUMY5T9c9zKWYpGsBonItPCluaOeMVPCBnOl6Hz6rvs3xdyqy5KUjpSI3YTG?=
 =?us-ascii?Q?8PHYMTRbjZx/MZaRRdBp/YegBOlKdY/4axFH5ZtDXcj3BzUCt0VaNjIurGwb?=
 =?us-ascii?Q?4nJFURbWn7WufG6rgt/R27nMqDFMZ87rdMSzpYqB0lNszQbN1Cc+griqWRym?=
 =?us-ascii?Q?eiI2Qb+w7bUn5iPqdJ5aRglgclmcgkgCUiaaH9Ez2aQtwTgHBdbrJcozSQnB?=
 =?us-ascii?Q?oaSyIsEeRSxdkCo7HHEptrG9pf5XnExDlemZqUmVF8MuPayDBJk6kxgzLrHk?=
 =?us-ascii?Q?6oidH318JbC7ePxOIhZujFxM+0W3/rc0AyyU6+ymfgul2BmPHEvW3LOMyDfl?=
 =?us-ascii?Q?+YDjtNdj4e3Eg03TcmSUTOfuBksL+qykqVClMA0Y+LS/m+7nmDjiQW32VS+w?=
 =?us-ascii?Q?pF+fC+yt6Ee7S8JfmqdAz3CYT6CUwVnF/RL7MeTX4zGAp/7vPBqaQpO9oidm?=
 =?us-ascii?Q?7JzVJd+lC3upc7iDPxPrIOwS4eselcDgn7iBt4ShlSpBx2G5zpGH5yQaU6Qn?=
 =?us-ascii?Q?Lht+0yDM+0mSMEOQLeiE+b5ZNaKie4rVCJpffCxZByjKZ06VRG1pP9VEb36j?=
 =?us-ascii?Q?vLpCDbKKD9WxHRkS3bNmI7RNH5fSI1Cpq4M80LDDniaqlBOlyVob+S7jG0Sq?=
 =?us-ascii?Q?wkUGMdBN8T9Ae9c1kzVDeQCJWCBcw5nBLlPo8u8luNiGRNoy+W3oaAQNbAKQ?=
 =?us-ascii?Q?FJqGw8GcnryOvEFUwgj0pU3eVzfLpLbIR7busTI3qRFZfsfphudl2BbyDspm?=
 =?us-ascii?Q?AMzKoMktZjdpmmOvv3emnll03oqRf57tcz13GkKdQa2629EcoMqJFXlSdp4s?=
 =?us-ascii?Q?EJCCZjv6+3NqXxDojjmOPmifYmfDk3S2H0DmZ7ZJmkeB9oh7EU40UZ2qGwQ8?=
 =?us-ascii?Q?dsm2S6QlRv+Q89v8uOsyIB3Ria4HVbcvfyrDm7/sz+5R5Dd69ylzQKbfxyI5?=
 =?us-ascii?Q?5jlwgMDn9TPrS5HcssmrXfBT0zzgJzBOfjNtTHpkc7Nri1I7ol672OBQienl?=
 =?us-ascii?Q?8Znu9+yXkiwHvJFwR4o8o96W7JwLVpPypDyupegIoYDcr2DZkiMUnHYhmC2W?=
 =?us-ascii?Q?C11Ir8HzkOOhtH8GGIGh3h4fY/7l/Pht3j7VJpVk6iIkkWGrKCbbz7B9ecBZ?=
 =?us-ascii?Q?d50cfEyzbGJ3pmLndovC9TdBmzkIZ48qVUvWaRpqfOZTuAKOWZVKKkYh7UYL?=
 =?us-ascii?Q?HMedL7qfoaN5OqIzdCTZf5RBuFleEzjqnOPA9DgElPciU/A3KTrn0tjuFXpt?=
 =?us-ascii?Q?20S1WcA9F7BnUv8AIwXxcAmflv8wWxm5sznAoV6g0Bmi05VMdyE/BQoS8O5T?=
 =?us-ascii?Q?/nKuObpA52uhDwwaZQQRYVnt2nmd5tpr8zVLZAzt?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bdb56ef-4db2-464a-4edd-08ddb359fec0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 20:02:06.5183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TpY+Qv7zs/UXqmhIPmYRkUzMUfAkRXlFoxtn7196qjgq/9iBDSBLJSO4vRClFGF2gDMNXBgMuu3HRYu3Jayxnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7899

On Tue, Jun 24, 2025 at 06:06:17PM +0200, Jerome Brunet wrote:
> Add virtual non-transparent bridge support for Renesas rcar platform
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/ntb/hw/epf/ntb_hw_epf.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
> index e8eb3adc6cecd2d52235a3f0b6b5a59ec58f1d73..97c9ed7e4dc27dabd21d3f083cc70d55bb280df8 100644
> --- a/drivers/ntb/hw/epf/ntb_hw_epf.c
> +++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
> @@ -747,6 +747,16 @@ static const enum pci_barno mx8_map[NTB_BAR_NUM] = {
>  	[BAR_MW4]	= NO_BAR
>  };
>
> +static const enum pci_barno rcar_barno[NTB_BAR_NUM] = {

Nit: suppose neend't NTB_BAR_NUM.

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> +	[BAR_CONFIG]	= BAR_0,
> +	[BAR_PEER_SPAD]	= BAR_0,
> +	[BAR_DB]	= BAR_4,
> +	[BAR_MW1]	= BAR_2,
> +	[BAR_MW2]	= NO_BAR,
> +	[BAR_MW3]	= NO_BAR,
> +	[BAR_MW4]	= NO_BAR,
> +};
> +
>  static const struct pci_device_id ntb_epf_pci_tbl[] = {
>  	{
>  		PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_J721E),
> @@ -758,6 +768,11 @@ static const struct pci_device_id ntb_epf_pci_tbl[] = {
>  		.class = PCI_CLASS_MEMORY_RAM << 8, .class_mask = 0xffff00,
>  		.driver_data = (kernel_ulong_t)mx8_map,
>  	},
> +	{
> +		PCI_DEVICE(PCI_VENDOR_ID_RENESAS, 0x0030),
> +		.class = PCI_CLASS_MEMORY_RAM << 8, .class_mask = 0xffff00,
> +		.driver_data = (kernel_ulong_t)rcar_barno,
> +	},
>  	{ },
>  };
>
>
> --
> 2.47.2
>
