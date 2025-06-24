Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011018.outbound.protection.outlook.com [40.107.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B27E78F58
	for <ntb@lists.linux.dev>; Tue, 24 Jun 2025 20:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750795250; cv=fail; b=jwS7+e1llNlP1rSFT0KGCZ1gO6Pnz0K8sutJ7FLoq5LN50ISfXX1Jq9pVfIRKVOdyOw2K8LGDKr+C5MOIzFtEIcBsC16RrgegLhnxW0DjMMeMmEV6Th3wSpE4iuuHZJ5jDrLzEX/D4ebmJyv7Cp4LxTBY6WTnT5R0Jz2GHpk3gY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750795250; c=relaxed/simple;
	bh=nXlIH9ndnW4ixOkY4E1oSw8BSALPQrTCrwojb8b32qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HHx5JAhILO8DX2uUs7PoeCQriUssggKE1PsOdiG9XBKpZcv39ofK9Q4ytHSejJj0U7/7cR08JRATpumBiAtAId2VgAjuYkPRxx0ScAQ18lrE7K/5ExUGcggleYGNwdgAGXzQRcPlFGio31JkOdWQrUHKXJ60MHwWdkQZ401b67I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MKWEznJ+; arc=fail smtp.client-ip=40.107.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MKWEznJ+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wemzw9FIvL9z1/zq7h6Kbh3mHaipoc+TTEjKwqJPuWDfWX6Zz42QTuRD9A9Gp3sKP3DrDYoo0mkC+8SaSVkavyySg/PUT+ZDXHpeRVAW9YI3IygRh0H4wzoY8aJoLtjzkbx1aRLWXDonHFu0nx9gJnKbst6gbB7/+L434KyFK5DuIGpH/sqngiq0erDcdKr2+q3gNfhJEO4jYe6GIhRjS+GKSobFQo//BLMlGNh3Wi+xYySOhq3FDNbSHJikeS4JokPfd8dTpiSRR87w/1ztKKzk0sEq9xZXXUTalUWqh/UEiKn1v6x/0feb4IjXlIkL1BslBatOaKYmC/P2TmI+nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFQNOkUlHZFy/Rwa1QRXNum9tjSDFPyd/BYNatuDoKA=;
 b=zCHoxp5Sk3D75CnFcOgBUUWmh+ZkcKNCBsyjBkoIm6XKCYnupHpKLYc7CAAOjQ3ohHrTx/GZIaJesSPB0mLjSRFQPA9hAI/sXzTMnAxERhoUM+xjMny2FnSzLqYarLWz5O29P8NHCqdDRfhavdu0GMliUyFsvp0wlnMDYdxpvlF9k3EyPVEWpAYgZV6UFwVOexkF1OehvJzjv7XWQ0fh3eCLuhzFX3vR32u7DRq1rAZ6hAmi8Drxfq0jcS5LccykQ1vUpVPlli/+NWAiHuXmeZ0B1fWzaBjP5G0cb3DHFPBCBwJNip7hN8TSuFJX72TJrHQtwdEut4nKsCBsGrBgUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KFQNOkUlHZFy/Rwa1QRXNum9tjSDFPyd/BYNatuDoKA=;
 b=MKWEznJ+v4H6Tj0vpMRLeaUFczWOZ2VwOaUs4fnWMCtCvtMah8Xysd9QuufLXzAleAukMVNFA6BkXL0Y2acPD3SP9U30xDcOvtO8NPjjGNn/R2IMCYOtPSkv8N8shg+nowRkMzOscSV+e0xvONB8tMSrPNYhrNZsKdxXbbii3jPExR7SvyEbx6hlh9EF3CWM902vYOnJLUKfum1PfxP+jmz7qZNyYagDWay/YO5cNY4rmRw9JlnTnp7N+fmt4x7S4jZAybmCv0kpbkZvcDG+IbKb5/e18MtuGfT48dHgTVOubfodiDSEoQWl0QowiwXQmCUY/Anx1dhjgLcqwDTmCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7899.eurprd04.prod.outlook.com (2603:10a6:10:1e1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Tue, 24 Jun
 2025 20:00:44 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8880.015; Tue, 24 Jun 2025
 20:00:44 +0000
Date: Tue, 24 Jun 2025 16:00:40 -0400
From: Frank Li <Frank.li@nxp.com>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>, ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
Subject: Re: [PATCH v2 1/2] NTB: epf: Allow arbitrary BAR mapping
Message-ID: <aFsD6PSapZB5wjQv@lizhi-Precision-Tower-5810>
References: <20250624-ntb-rcar-support-v2-0-8c0e5cf69c4d@baylibre.com>
 <20250624-ntb-rcar-support-v2-1-8c0e5cf69c4d@baylibre.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624-ntb-rcar-support-v2-1-8c0e5cf69c4d@baylibre.com>
X-ClientProxiedBy: AM0P190CA0026.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::36) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7899:EE_
X-MS-Office365-Filtering-Correlation-Id: 19c3abdb-9689-4a96-61a3-08ddb359cded
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PWXa+LBQzvfQxlC4TtIJQnQehd94IdP/qR1GJPdP8tBqEV8PmMPnUvoBARtD?=
 =?us-ascii?Q?HqfGPvX2NC+wuVu4slRtDJ2uevjhONhT5ntkuPrDTQ+SXTnBgIsjXaGBRvj9?=
 =?us-ascii?Q?944Ft60vGSVg3WjaF43gMFOlbq6WPKHrPBBgeVDkl48Dfvntk98xaQ0yr94L?=
 =?us-ascii?Q?qc7pCcGXQvp5nMkUSqJspGt/OGgmUhSmbubI0KBdGnbX4Nv6M326VciufT6g?=
 =?us-ascii?Q?Cr278XuVQxuQamaIqFoMD78/H2rr8w3zMnvugSeRHs2g87Y3O9EuLo3HdL0x?=
 =?us-ascii?Q?evU49ZuyBNB4oJWscQIFFxQ6ywdQGWXrsALhUKXKbOQxlE9QSW7sOiby3jlZ?=
 =?us-ascii?Q?ibrPUsYDjckUyJsrCQbkZmaWUIbz8kxRwG9KdQs4p3wFBPIUh25pclyU10bG?=
 =?us-ascii?Q?5TISzoCbjk97JaawvLO9FDtjui2PGCsU8KXzKP9FOC5tke+WtFCUAyghBmpn?=
 =?us-ascii?Q?IywoVU6nUZrlBJC6Ji2uM0qb7WcmFd8KaT7KwtMsTL/Z4/j1hH4i+cU5AIUU?=
 =?us-ascii?Q?BpSVfDUat+hGyN0LrAFzyWZpt8DIIbQFIyhnPBuIzhorSDeMDVpD/5GN1nG4?=
 =?us-ascii?Q?31Q+dXbzz6vfDdyaVU/25QjGbjLiDjCnoA2Kq7x+6M6E1IQ0JPVYCNu72i4A?=
 =?us-ascii?Q?6O3j+Qat8t5CrJgSCs/W4h2fBOD890o/fE+qByI+QmBySXYSC1oq9QIVCJYN?=
 =?us-ascii?Q?2D9lgrPBb55J2wURPje9b0CoQqVTPBv9c39Wbm3p+UTyopxZiYcGiZitCHqT?=
 =?us-ascii?Q?OcQc/yX7b/mnqF5UhiOL7boh69YpNQkejiO0XdeHGS24W0DCoR02MluJeDAv?=
 =?us-ascii?Q?QHWW7YGD/pMeXqE90cpA9fDhZJaeReyoEz9zW7lHONkd4Mfqsh3HvoPwEw0g?=
 =?us-ascii?Q?dLx3J8SsB2bnGuwD6A/4Y9i0fBVilmM+n8USyfpmSqJva9xzenYfRNV2THw4?=
 =?us-ascii?Q?jDuTCvJx9oTNBD+aOZgEuFYbIwanp1PKL4X1wFexfSiA1AuQ0eIF1cZ2INSF?=
 =?us-ascii?Q?TuQzWLuFPqR1lCTjtQ255IvaNsqEX+KMU+IcYy44su/nC9kcF5AxO7SQt8Or?=
 =?us-ascii?Q?7cKu02P2DWt74cWZSxtxzqurkCp/U9FRngQx3yd2QQSpx0umBkpyDV4Cj9zm?=
 =?us-ascii?Q?KNSWChpmMoBG6UK596W/k/Cds3mDdWkuW45Q3QRJzKo2Eny3APUpXMROwquy?=
 =?us-ascii?Q?iXKnn/H4TloG2dfk/Pkn5IrAUWe7yuI8UiDqb528qFAUyN7ye1EeFB27Vk5s?=
 =?us-ascii?Q?geHJ71GM/JOWCqPpSqo2BUoj/pM5mvkOQ/S5ACRpOyYAEHbqHM2+s1JWi6tg?=
 =?us-ascii?Q?kJJ0fd0meAqH8U/L5WJSU3Ur0C386g/LuP/KzBPJvkA3/meKFq/mF31MgiEx?=
 =?us-ascii?Q?qC+3YcU57D9kLkU5Uvaw2bLhwimkXT+BJhj3H8g1rxieHW0JvZkMzpviXdda?=
 =?us-ascii?Q?Ze86R7eoG9eT9eaNrekMB92RSVeQliVx0Hdps09dpxd35dik0ifkyg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F7RsOF16tILKh6ygjydHsxP/ZWJAtPM5/w1nTBACyADNek7F7WEFcjM3C+Q/?=
 =?us-ascii?Q?8ev9MTZlJagTW3kmA8Hab+6VRA/tCzd5mkNjFmTiVvlMZgh453gdeFZy7/Js?=
 =?us-ascii?Q?O2yOKj4IiZyzzcAPYyJqy/DCex7ShK8IvK0R0F1I0b35IrW/53T6SI+1GNvK?=
 =?us-ascii?Q?m/HtrzNSpyjoi05LHj8XAOVnEQjGirh+sJ86Zvr9VMDdoiCjUSryj2cEE9gd?=
 =?us-ascii?Q?nRjyhEZVE6XMEMp61gxXh5kG5NKx9ZvwklTHtlZtHyL+5N1+ViTzO+FjyLbP?=
 =?us-ascii?Q?VO9/gIW8t5k28CTt07IgI25GtKm2LUG/IYGbYhJqStJa0IdAVcqLeHOHoQoe?=
 =?us-ascii?Q?gA6QH0RupTXwPasS9oTk4HeDEe9foa+Z0ypAnB93Jks0YRhAICGGwxgnJBka?=
 =?us-ascii?Q?wcQSGN8w5T0h5QdSZ/EAu4pvLaCwT/DVN1inC9lkfOFvA0SFBQcqbuQJP8w1?=
 =?us-ascii?Q?1hbWa4i6y7QucAnUjK4eU50pzPKtcjGwmwI8PU0+x0lpgs17TVrg5W6MTVLY?=
 =?us-ascii?Q?/PnsGBZQmGUg8rlMBgA0xhJM0+HfLlNifl81Mgb6YRrr4ss5ufVrxt6Y8WMz?=
 =?us-ascii?Q?WviZyvgPeQA/qh8Wr3+MSkWO/QjSAE3wLHUzuVZKcOSjNJgedQZUGaYRjHl6?=
 =?us-ascii?Q?MDJa7gqlY7Xoz/9rg61BpiD+Buf+i7WPanrtHcFaQI+XYyHKyhyL8PE3+fqi?=
 =?us-ascii?Q?Nu4OSZCvMTdtb0Lc3tnOSeDIZWBUPY07N3ktQGo6xAaYfqhSRfuJgdzoLWPR?=
 =?us-ascii?Q?4G3+xjYaiQvkIPSeKS3YyblkTU+dCp6ktf0Z2FLLPtD3I2Lyu9CrzrIKCylO?=
 =?us-ascii?Q?eq2+HHeVr6IsNpxyJelMNr8enQdAV54sHI0/h4G4O3tWBgN//p+zrJK14PL0?=
 =?us-ascii?Q?2cT5yOPsMvtcPwwOGL3DBkA0i0gveg6d6BooiObX4z+8xfHu5OMwbog5jsWW?=
 =?us-ascii?Q?J5n7vSd7RgoOW9hPFsqTEJ9GzRZxLsCeUNFoBbuYQ0XjkZo410JTa8jcGQP2?=
 =?us-ascii?Q?SwSUyJIJu6Qbe1Ji08rzewwd5xRJLNtnBg/7BvbMyI44l2CEeBdqrJxiiu8/?=
 =?us-ascii?Q?ERLIgwOudU7/ppgWYHUIihl5btK+b2BayrQP+XLQGsRUByBUOADXcgspzuF6?=
 =?us-ascii?Q?6BsBnScSFgd5YLYwFLMlz6vGyU29g+8m0QHomsdhNNf2T6YjO/NLtKyalozQ?=
 =?us-ascii?Q?O0c1mtD9VnjhE37CKLFBxnwTmuTTD/RanSI+PSASOPNgWkrkCOieVsfxyDI4?=
 =?us-ascii?Q?Z2zassO/YtKsHdeISh8QtEmtml7zc2ny/mFcHcH/Fa919rTaiF6rc5kgIxA3?=
 =?us-ascii?Q?BxmTMDP2/ujDrm1wBDbtPOxJv4VMOSyIT2621dlEeKojSXwi8KXG0opcBePq?=
 =?us-ascii?Q?fslN57wsxj6ItuUxZIexSz43B5bIs+vhPcUOYNFi3IpByojhevW72LmCFfCo?=
 =?us-ascii?Q?sKil/b2zLGHxFs68W5P+pNOfW9riLtN/llSPrfzoGmMKABKo5+vC5h4KG7wP?=
 =?us-ascii?Q?Yqw2gNP6Dr+WjeOLz9mQkCtbt5PjjeQE8VTCVNqWU8AzdpmXcnK6TDWdAWLm?=
 =?us-ascii?Q?v0y0lrFCiDnEskZyWeQy9pSDbjsGGegmqz3Zk+7a?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19c3abdb-9689-4a96-61a3-08ddb359cded
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 20:00:44.7619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GiPCG4uQ9sAQ4fW68ZKfL9S0W0TPFQ2eRZ+JI9GwUi2l+CTjG5AyonbpmT3VphpiaE7Zn1kXfDTABJrc3MuUwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7899

On Tue, Jun 24, 2025 at 06:06:16PM +0200, Jerome Brunet wrote:
> The NTB epf host driver assumes the BAR number associated with a memory
> window is just incremented from the BAR number associated with MW1. This
> seems to have been enough so far but this is not really how the endpoint
> side work and the two could easily become mis-aligned.
>
> ntb_epf_mw_to_bar() even assumes that the BAR number is the memory window
> index + 2, which means the function only returns a proper result if BAR_2
> is associated with MW1.
>
> Instead, fully describe and allow arbitrary NTB BAR mapping.
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/ntb/hw/epf/ntb_hw_epf.c | 105 +++++++++++++++++++++-------------------
>  1 file changed, 54 insertions(+), 51 deletions(-)
>
> diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
> index 00f0e78f685bf7917b02dd8a52b5b35f68d5bb64..e8eb3adc6cecd2d52235a3f0b6b5a59ec58f1d73 100644
> --- a/drivers/ntb/hw/epf/ntb_hw_epf.c
> +++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
> @@ -49,6 +49,7 @@
>  #define NTB_EPF_COMMAND_TIMEOUT	1000 /* 1 Sec */
>
>  enum pci_barno {
> +	NO_BAR = -1,
>  	BAR_0,
>  	BAR_1,
>  	BAR_2,
> @@ -57,16 +58,26 @@ enum pci_barno {
>  	BAR_5,
>  };
>
> +enum epf_ntb_bar {
> +	BAR_CONFIG,
> +	BAR_PEER_SPAD,
> +	BAR_DB,
> +	BAR_MW1,
> +	BAR_MW2,
> +	BAR_MW3,
> +	BAR_MW4,
> +	NTB_BAR_NUM,
> +};
> +
> +#define NTB_EPF_MAX_MW_COUNT	(NTB_BAR_NUM - BAR_MW1)
> +
>  struct ntb_epf_dev {
>  	struct ntb_dev ntb;
>  	struct device *dev;
>  	/* Mutex to protect providing commands to NTB EPF */
>  	struct mutex cmd_lock;
>
> -	enum pci_barno ctrl_reg_bar;
> -	enum pci_barno peer_spad_reg_bar;
> -	enum pci_barno db_reg_bar;
> -	enum pci_barno mw_bar;
> +	const enum pci_barno *barno_map;
>
>  	unsigned int mw_count;
>  	unsigned int spad_count;
> @@ -85,17 +96,6 @@ struct ntb_epf_dev {
>
>  #define ntb_ndev(__ntb) container_of(__ntb, struct ntb_epf_dev, ntb)
>
> -struct ntb_epf_data {
> -	/* BAR that contains both control region and self spad region */
> -	enum pci_barno ctrl_reg_bar;
> -	/* BAR that contains peer spad region */
> -	enum pci_barno peer_spad_reg_bar;
> -	/* BAR that contains Doorbell region and Memory window '1' */
> -	enum pci_barno db_reg_bar;
> -	/* BAR that contains memory windows*/
> -	enum pci_barno mw_bar;
> -};
> -
>  static int ntb_epf_send_command(struct ntb_epf_dev *ndev, u32 command,
>  				u32 argument)
>  {
> @@ -144,7 +144,7 @@ static int ntb_epf_mw_to_bar(struct ntb_epf_dev *ndev, int idx)
>  		return -EINVAL;
>  	}
>
> -	return idx + 2;
> +	return ndev->barno_map[BAR_MW1 + idx];
>  }
>
>  static int ntb_epf_mw_count(struct ntb_dev *ntb, int pidx)
> @@ -413,7 +413,9 @@ static int ntb_epf_mw_set_trans(struct ntb_dev *ntb, int pidx, int idx,
>  		return -EINVAL;
>  	}
>
> -	bar = idx + ndev->mw_bar;
> +	bar = ntb_epf_mw_to_bar(ndev, idx);
> +	if (bar < 0)
> +		return bar;
>
>  	mw_size = pci_resource_len(ntb->pdev, bar);
>
> @@ -455,7 +457,9 @@ static int ntb_epf_peer_mw_get_addr(struct ntb_dev *ntb, int idx,
>  	if (idx == 0)
>  		offset = readl(ndev->ctrl_reg + NTB_EPF_MW1_OFFSET);
>
> -	bar = idx + ndev->mw_bar;
> +	bar = ntb_epf_mw_to_bar(ndev, idx);
> +	if (bar < 0)
> +		return bar;
>
>  	if (base)
>  		*base = pci_resource_start(ndev->ntb.pdev, bar) + offset;
> @@ -557,8 +561,13 @@ static int ntb_epf_init_dev(struct ntb_epf_dev *ndev)
>  	}
>
>  	ndev->db_valid_mask = BIT_ULL(ndev->db_count) - 1;
> -	ndev->mw_count = readl(ndev->ctrl_reg + NTB_EPF_MW_COUNT);
>  	ndev->spad_count = readl(ndev->ctrl_reg + NTB_EPF_SPAD_COUNT);
> +	ndev->mw_count = readl(ndev->ctrl_reg + NTB_EPF_MW_COUNT);

This looks like just move readl() pos, not related this patch.

Frank
> +
> +	if (ndev->mw_count > NTB_EPF_MAX_MW_COUNT) {
> +		dev_err(dev, "Unsupported MW count: %u\n", ndev->mw_count);
> +		return -EINVAL;
> +	}
>
>  	return 0;
>  }
> @@ -596,14 +605,15 @@ static int ntb_epf_init_pci(struct ntb_epf_dev *ndev,
>  		dev_warn(&pdev->dev, "Cannot DMA highmem\n");
>  	}
>
> -	ndev->ctrl_reg = pci_iomap(pdev, ndev->ctrl_reg_bar, 0);
> +	ndev->ctrl_reg = pci_iomap(pdev, ndev->barno_map[BAR_CONFIG], 0);
>  	if (!ndev->ctrl_reg) {
>  		ret = -EIO;
>  		goto err_pci_regions;
>  	}
>
> -	if (ndev->peer_spad_reg_bar) {
> -		ndev->peer_spad_reg = pci_iomap(pdev, ndev->peer_spad_reg_bar, 0);
> +	if (ndev->barno_map[BAR_PEER_SPAD] != ndev->barno_map[BAR_CONFIG]) {
> +		ndev->peer_spad_reg = pci_iomap(pdev,
> +						ndev->barno_map[BAR_PEER_SPAD], 0);
>  		if (!ndev->peer_spad_reg) {
>  			ret = -EIO;
>  			goto err_pci_regions;
> @@ -614,7 +624,7 @@ static int ntb_epf_init_pci(struct ntb_epf_dev *ndev,
>  		ndev->peer_spad_reg = ndev->ctrl_reg + spad_off  + spad_sz;
>  	}
>
> -	ndev->db_reg = pci_iomap(pdev, ndev->db_reg_bar, 0);
> +	ndev->db_reg = pci_iomap(pdev, ndev->barno_map[BAR_DB], 0);
>  	if (!ndev->db_reg) {
>  		ret = -EIO;
>  		goto err_pci_regions;
> @@ -659,12 +669,7 @@ static void ntb_epf_cleanup_isr(struct ntb_epf_dev *ndev)
>  static int ntb_epf_pci_probe(struct pci_dev *pdev,
>  			     const struct pci_device_id *id)
>  {
> -	enum pci_barno peer_spad_reg_bar = BAR_1;
> -	enum pci_barno ctrl_reg_bar = BAR_0;
> -	enum pci_barno db_reg_bar = BAR_2;
> -	enum pci_barno mw_bar = BAR_2;
>  	struct device *dev = &pdev->dev;
> -	struct ntb_epf_data *data;
>  	struct ntb_epf_dev *ndev;
>  	int ret;
>
> @@ -675,18 +680,10 @@ static int ntb_epf_pci_probe(struct pci_dev *pdev,
>  	if (!ndev)
>  		return -ENOMEM;
>
> -	data = (struct ntb_epf_data *)id->driver_data;
> -	if (data) {
> -		peer_spad_reg_bar = data->peer_spad_reg_bar;
> -		ctrl_reg_bar = data->ctrl_reg_bar;
> -		db_reg_bar = data->db_reg_bar;
> -		mw_bar = data->mw_bar;
> -	}
> +	ndev->barno_map = (const enum pci_barno *)id->driver_data;
> +	if (!ndev->barno_map)
> +		return -EINVAL;
>
> -	ndev->peer_spad_reg_bar = peer_spad_reg_bar;
> -	ndev->ctrl_reg_bar = ctrl_reg_bar;
> -	ndev->db_reg_bar = db_reg_bar;
> -	ndev->mw_bar = mw_bar;
>  	ndev->dev = dev;
>
>  	ntb_epf_init_struct(ndev, pdev);
> @@ -730,30 +727,36 @@ static void ntb_epf_pci_remove(struct pci_dev *pdev)
>  	ntb_epf_deinit_pci(ndev);
>  }
>
> -static const struct ntb_epf_data j721e_data = {
> -	.ctrl_reg_bar = BAR_0,
> -	.peer_spad_reg_bar = BAR_1,
> -	.db_reg_bar = BAR_2,
> -	.mw_bar = BAR_2,
> +static const enum pci_barno j721e_map[NTB_BAR_NUM] = {
> +	[BAR_CONFIG]	= BAR_0,
> +	[BAR_PEER_SPAD]	= BAR_1,
> +	[BAR_DB]	= BAR_2,
> +	[BAR_MW1]	= BAR_2,
> +	[BAR_MW2]	= BAR_3,
> +	[BAR_MW3]	= BAR_4,
> +	[BAR_MW4]	= BAR_5
>  };
>
> -static const struct ntb_epf_data mx8_data = {
> -	.ctrl_reg_bar = BAR_0,
> -	.peer_spad_reg_bar = BAR_0,
> -	.db_reg_bar = BAR_2,
> -	.mw_bar = BAR_4,
> +static const enum pci_barno mx8_map[NTB_BAR_NUM] = {
> +	[BAR_CONFIG]	= BAR_0,
> +	[BAR_PEER_SPAD]	= BAR_0,
> +	[BAR_DB]	= BAR_2,
> +	[BAR_MW1]	= BAR_4,
> +	[BAR_MW2]	= BAR_5,
> +	[BAR_MW3]	= NO_BAR,
> +	[BAR_MW4]	= NO_BAR
>  };
>
>  static const struct pci_device_id ntb_epf_pci_tbl[] = {
>  	{
>  		PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_J721E),
>  		.class = PCI_CLASS_MEMORY_RAM << 8, .class_mask = 0xffff00,
> -		.driver_data = (kernel_ulong_t)&j721e_data,
> +		.driver_data = (kernel_ulong_t)j721e_map,
>  	},
>  	{
>  		PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, 0x0809),
>  		.class = PCI_CLASS_MEMORY_RAM << 8, .class_mask = 0xffff00,
> -		.driver_data = (kernel_ulong_t)&mx8_data,
> +		.driver_data = (kernel_ulong_t)mx8_map,
>  	},
>  	{ },
>  };
>
> --
> 2.47.2
>
