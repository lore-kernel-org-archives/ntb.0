Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011021.outbound.protection.outlook.com [52.101.70.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157A149B202
	for <ntb@lists.linux.dev>; Fri, 11 Sep 2026 16:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789143717; cv=fail; b=OvyBzy4f5hzkZ8tmwjYgZKuKKSKk0HwkdjBhKKmXlG7rZz1NxxkiEihd/FcMaoh8g/8nBlsmhuL4DA/o/Ai48yGG44PUGBC7E79iTHUlCNyG0LzD0lTOq4SfNv9C7oxvYtRS26bPK9gFXGuHQevXYeVSt2ei4NSOdV61yja8AAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789143717; c=relaxed/simple;
	bh=E0j/4Pd+FaZTEA/1Il2jjEbrToGYlumSoWGZnoPi+yI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ktOwUGGGnEM9FtrAMpbOVm3p3yF/7BgK3CBDXg1Dbvaq7TlYPQCdAqt8qNv4b9lj2+Mwq4cCpZDm4KyX/9jW2lBwQ6w2KTRGDtd0+JNITnGEW490JVEroWYdBp82iLCsKQoI2ZUVK1ve/8W1hGyW8zaUURrRM8dxK8nJFBaRSKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Y6jBjbSa; arc=fail smtp.client-ip=52.101.70.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Y6jBjbSa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GF7gUVMREUCerJnTr3rYfbG12n1hZv5m3XqVRK45ESb1b/uDDCOaK4ke6Aa/SniJZ8hYsYdp9N1uvt2AFoOYVHWPm28jiifxlwl74KcK7o9CnTSwnqAXjv6tK8wZmB4WJd2FYdmU2GBQC7wCuHAZ5a+ya6bxo4hNfSddmuHn//4+YbbCGiv8aVjdEiMUc/5d3WJ8YkGDIXmD4ykfLiOOuwgXcddsYiJ+r0m346ldqnvCC7Vp0KHV9Ee/lbYle8t45cClAn4AvDhlBHJFeaccwkURTWMes38y+95uSyIJtqA8KDvAk+rBknWKQ5P0Ep274wggykDdAHye+ZZzJpfsbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vLOBAPN4UU58VICp6QEugscY3LfieRY4vP5ZzxJKma4=;
 b=UoXDXWDjZE3kxValydTg+PzqkjOyU7agydMt5BwZWN7E2BAZvL2SmFicgRMKoHvgtDmegXioKL1CYuq5GLkKWaNDf/1ncbdA3EKjWDS5IwyvEz57TefU4HKki8SA8O0BJID9oRZSkjzMb1US/I3QMSUaBVbS96pHwqQEbm/YylM7BUNQTHotIpxdh0ik4Os3fl5lWxyA4T17AlV183mbag15Bk/JH5KrxsKNPIjoFeBREtDU1c3QJs4NmBzXHn8eOygxbh0H6YjwTPRm36tJubkdiUQYAIDhRYqJlw1omGRtZZ22dVoJAF5rSYglbhxMOX3Docf8Wvq/bN3RJdMobw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLOBAPN4UU58VICp6QEugscY3LfieRY4vP5ZzxJKma4=;
 b=Y6jBjbSaQAkxmOunC75WfzMxxgyL4hW1mSkBHQjiTvxZBXRCALz79VHXPLOY+2ENsLvvych3FZkJADyFXteHFYuPNsAf+d6mjmWA72sPYgpYsJqoL+lTCrBxORqFx3gK1Fcs13zLQHzuqv95BnkEt2QfdItAW/5E5hD2eb6H9TmXB+/oIhXjnkPvsUxqQW756AGlF8eTl9kxqQiTvjz/7GyQFsDJt5H0cUCuTkm3v8B7OnEtJaio6ShuSx1p+mxBZGsivGv3ND+bd2gkLgKN5douv610p9SLmA3kQL7FehxVwvPr5ebjIYhRwIkwKsfVMk4j5AwKhe/AqXp6R+vf/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA4PR04MB7904.eurprd04.prod.outlook.com (2603:10a6:102:c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Fri, 11 Sep
 2026 16:21:52 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 16:21:51 +0000
Date: Fri, 11 Sep 2026 11:21:43 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>, Frank Li <Frank.Li@kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>,
	fuyuanli <fuyuanli0722@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nicholas Bellinger <nab@linux-iscsi.org>,
	Joey Zhang <joey.zhang@microchip.com>, ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/14] NTB: ntb_transport: Avoid deadlock when
 cancelling link work
Message-ID: <aqQql6oOVIITjr82@SMW015318>
References: <20260910040836.3792333-1-den@valinux.co.jp>
 <20260910040836.3792333-4-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910040836.3792333-4-den@valinux.co.jp>
X-ClientProxiedBy: CY8PR19CA0023.namprd19.prod.outlook.com
 (2603:10b6:930:44::9) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA4PR04MB7904:EE_
X-MS-Office365-Filtering-Correlation-Id: 41fb2bbd-964d-4100-c9be-08df1020c995
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|1800799024|366016|23010399003|7416014|6133799003|4143699003|10067099003|56012099006|18002099003|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info:
	tg9mebEPZz6kxCB8kBqTQqxlvXCgPuvZbg0an74dkHB968zto5Q/wGR3/4zj6sPdXQQIxyw2zatXBLmAQlMEdKHAaC0tJD0AEwqvd50xmuuRgVdafwNK+6fgobCL6Yp/Ut32r+e8qK7d9yGeQAlk1s/pW3D4nh4ycrDUmhCw+09+rgZ/2whdsXrY9w0nYfzSLt6RcBl/GbrSaVxXEGBybk7MpC5O7KVtreIxbb6MulPobZXnRCcN3yr+GgAxrnhd0BSXl0GLqYeUHIBC8V1ogASn699bs9YGoQNW7wvs7oL8n1USUonU1m220O+/n3xTxRtCwUEznxj0CyNlaiUvUsogiKvY13MiSMQ45xQ46lQOqjGH4ljs9kLpdpsBubG7YcxLmWnorYAAZOWJ8FCh5Dwbv/DqegvHKQ2kIrGz0ZZYvXRQ37bxJUtR/BGrOPkEk//YUYh8GQyft6G3VT6qopNrUjlrjDHmgDz881gTCAY4SKP9rweKUffjt+sB2LgkoTtN+T4KB7tSf8nqIV4jjydXkdbB8LuVgSijoTUr89QVs5Jgx0Ry7C/4HHifinbWepqIU6MzR9JRJl0DcJL7rUyGRvk/YKl5rHJQaEnpfcSK/LwMkZRqZoqfMBCgZ1BI3dY2jq2O0aQQRxMVgk7Dmwgzd/3vH1Zjy3ImBgdGUio=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(1800799024)(366016)(23010399003)(7416014)(6133799003)(4143699003)(10067099003)(56012099006)(18002099003)(11063799006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XFIpFFDs81k/q2rG2o5Cr6cBaCOL8Ac15KGbApyyClSJlGMJhsom6zauOUv9?=
 =?us-ascii?Q?C5stMnHBC9diM7jwuJDZ8AWlIne5inMiTzliQg3a8rUYQ57EheDpIXr0qmdU?=
 =?us-ascii?Q?1nPytSRwszCiqX8Vozh+PABUct7kFafHgemjpjt94BUFGkpVQs2VcKi/Yeb+?=
 =?us-ascii?Q?DU/58YASiSiJrW41xEqFLx2ROmYPmd+HvGOdldViWuDXP6ESfLMrSkLCe/gU?=
 =?us-ascii?Q?a6/Qlt0a8rzEPkeScEveI8fCjkn1VyTjZCIXGqppBEkwOF0XMHydZvgwWf0y?=
 =?us-ascii?Q?AX7JsXgC0ebaCc/a3ZoS/2Y9bmt8du/6A6bP9CvO4Ig+HF9yGPLwyl5hD0HJ?=
 =?us-ascii?Q?lUzANrH0ekpBHkmiy1ngZfxMJQJF2WgbdNTmcUJKPdJIOvNw6BaGf0HdKoG3?=
 =?us-ascii?Q?EEE9G9dYlbAQH/q3IJWRKDaaYnCEvMBnf6uDKgqKnFqMFLAwO5E7wW+23UHS?=
 =?us-ascii?Q?VnnjktYKT1DlFHqGVtSBLXdaLbrUhA2tl0SCXToMl5sbyM5ePlkCeDbGrAHU?=
 =?us-ascii?Q?sc5JMfCU5eSQHWKHmLwSmyKeEUUeAw1ejpNvWVHXUnVFdrB0MsUt282c/vQR?=
 =?us-ascii?Q?LsEg3zslr5NzKoOGY6ijKAKA9ZsTaF0KkPTvxa1Dmgqz6LWkTaGoe9k679wi?=
 =?us-ascii?Q?vhYZ2v7Aymd8TWYVW4/Q7abQRZqtcxCXwuB0pP+dqD1JnE0enngE4e/eSmSB?=
 =?us-ascii?Q?1eEykgGYVrN5w5VAHugyoeizAkHJZaDwpP1cpfpDdi4OfB7sXRgqkUJmxfJn?=
 =?us-ascii?Q?XGV5pwcXQbTQUkCrYdxNjMGVITUdxJTGszfoGFhIPbzsHwBglDbRDk0eD31h?=
 =?us-ascii?Q?ugJgIv1MNjFdHN+qaZdw/a9RymzmY3zdDuTFZ5CQner5mcBlucapD0EJ0gha?=
 =?us-ascii?Q?DHxmYUEltfuViE/FX0e2t/0+YUEkcCYw02LHApPC9IUn8PrvDrTUiTnY3slA?=
 =?us-ascii?Q?WfrrCdIxEilZIGCYDFsA+rtoPwMPDDs9AKs9S6IaYstDc+xSdvraEzFMHMCi?=
 =?us-ascii?Q?7wmO/zwiTJQ8cu5RAksWjGr+x2uKSjiLkOjuyhK5gf/B2B0l/CUJUi6TuZyY?=
 =?us-ascii?Q?8AqD24ZqM7wGk5GycjU7wBnwQXzXM/mI0F11M8qr6toeerDMAsUsW7yT00Nk?=
 =?us-ascii?Q?Kwi725A4kBPTk8gUfet7mpRFiFbQL/DjYqSjFF4ggacuNhAw0KwP0wY0j9jo?=
 =?us-ascii?Q?MAolwI/cEpGavkrc9juR2DlK3WiPzTV0MSZ+v1vxvurtW1LE/l+aCocn18zf?=
 =?us-ascii?Q?fubZh4ArQDD46264CZDQj2y53AdMRUil5J7E6eAX4gIAi0I8UeqKMJ0FVyx8?=
 =?us-ascii?Q?c2vzrE/usxg0ddEsuOB0EM8K9P6kNpa6yTmz0lh3ttHCenJPDIAkqZlVqVSp?=
 =?us-ascii?Q?9SUdRmMarxOYByZjBfVootYSrtfjak5M5UKd0lQHvNJLyz3inYIagatWVIQf?=
 =?us-ascii?Q?pTwlaHBkEwRKldME/ZlyFutoXcIA3ImpMhxFxZWLf1PUwRB+lINe1L/Zf8/R?=
 =?us-ascii?Q?irvaHBoXvlitJVYNtuaofg5Cu++3GDC59iUqjo9pt3uv5ZjKh1ROL9ormoE2?=
 =?us-ascii?Q?2qYUds8Lul09/9h7n/DJcc9O1CCyB/7GLJx9lHSVUT0UCb9rf8PNgVcxOhYH?=
 =?us-ascii?Q?YYPLx3SiXPT7bZmJNJl4miVfowo2EHt+0eprNjmxXffTYSX+JgsRHCs0UsDH?=
 =?us-ascii?Q?ebO5wZKR6HEEJ51Hz0f7cYI4z5Z+ya9tvhAaaOaJV6744HaDGTir8vcV6QCM?=
 =?us-ascii?Q?S5AOHjUZbvFBi0ezE0ECKAXZF442lWlozkYg6vUD5XyJfoaHQidF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41fb2bbd-964d-4100-c9be-08df1020c995
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 16:21:51.8917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CTSuHZ1Diw3oXqOu/w7Iatk5Gi3o7rY4ecLaJ+MQtjqc2bjFhTPTCwk7+i7MIGnHiOLtS5Or3vBi35HifIfqTJtiNGUylqtrYqUv5s6A322rBt8WT8E8ciFbMRGvd/Gx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7904

On Thu, Sep 10, 2026 at 01:08:25PM +0900, Koichiro Den wrote:
> During initial link setup, ntb_transport_link_work() can retry with
> nt->link_is_up still false. A retry can block on link_event_lock
> while cleanup holds it and waits in cancel_delayed_work_sync(),
> leading to deadlock.
>
> Move the conditional cancellation outside link_event_lock, before
> QP cleanup. Keep QP cleanup and MW release under the lock so link
> work cannot restart QPs between them. Put the locking in
> ntb_transport_link_cleanup() to cover both worker and remove paths.
>
> Fixes: 3db835dd8f9a ("ntb: Add mutex to make link_event_callback executed linearly.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
> Changes in v2:
>   - No changes.
>
>  drivers/ntb/ntb_transport.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 55a20ae9a85e..c77b173dca01 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -960,6 +960,15 @@ static void ntb_transport_link_cleanup(struct ntb_transport_ctx *nt)
>  	struct ntb_transport_qp *qp;
>  	u64 qp_bitmap_alloc;
>  	unsigned int i, count;
> +	bool cancel_link_work;
> +
> +	scoped_guard(mutex, &nt->link_event_lock)
> +		cancel_link_work = !nt->link_is_up;
> +
> +	if (cancel_link_work)
> +		cancel_delayed_work_sync(&nt->link_work);

what happen if schedule new work here?

Frank
> +
> +	guard(mutex)(&nt->link_event_lock);
>
>  	qp_bitmap_alloc = nt->qp_bitmap & ~nt->qp_bitmap_free;
>
> @@ -972,9 +981,6 @@ static void ntb_transport_link_cleanup(struct ntb_transport_ctx *nt)
>  			cancel_delayed_work_sync(&qp->link_work);
>  		}
>
> -	if (!nt->link_is_up)
> -		cancel_delayed_work_sync(&nt->link_work);
> -
>  	for (i = 0; i < nt->mw_count; i++)
>  		ntb_free_mw(nt, i);
>
> @@ -992,7 +998,6 @@ static void ntb_transport_link_cleanup_work(struct work_struct *work)
>  	struct ntb_transport_ctx *nt =
>  		container_of(work, struct ntb_transport_ctx, link_cleanup);
>
> -	guard(mutex)(&nt->link_event_lock);
>  	ntb_transport_link_cleanup(nt);
>  }
>
> --
> 2.51.0
>
