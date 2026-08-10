Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011009.outbound.protection.outlook.com [52.101.70.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE19433BBC
	for <ntb@lists.linux.dev>; Mon, 10 Aug 2026 18:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786387334; cv=fail; b=jAIv5QLs4X9DE0/MUzwSN9XMcA11V/ZHaY91NBEDKcEPE6PJRjr8WsLanOym714VKV8L1kwFfOSh0X6gs/rPVMSUU8bpD6UGIqu251nLaHDll5yznXB/ZPHT84/EKldlesXLRnLR+g0K1ugD5wnZK8XUj6gV/YqOPLT/bGu6Zik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786387334; c=relaxed/simple;
	bh=+5kOxmZ/AMHMWQ3aRE/d6rm7LbMEIIyjJiwGmjG0Lxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=b1duOkTDvB6IxBQmSXAgcJDb4rxWQv/zDuPY2KNwIpB/Eh/UGiQwrQxNxHMXfAw9ear3/UilUm/ND1pMUoyeVsr2hIH6vE3hl/UpLm+ahQQ9+L3HdsMfwdnzvqCj2WwoKJfHEAXRWQbD+0LUjqTko+wb3rdyRqWOb/H26NAnef0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=jfQSeCtm; arc=fail smtp.client-ip=52.101.70.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="jfQSeCtm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C3uuG7c0+uG+DXGiGkp6l97iPHXg5MpSYoELwrnbY1/TRa01CYKzrLZAflmHCrYg8gYuPcuqAD10+K4L8IvHXiX/oeijD+iaJ9SMoUpCEeVVp1mx8fuNpw4dSIICczFENbt9nSm9X5wBnxTCFT26RkdI30+IJ/PqX0erR5SWcADu2k8OMTUp/BXJV57+ccMUYPAPBUCV9oPir5Ah/JwAe7aqBNAU6d9pNFYEDz4RUuHMmKmJo570/LvZGKuOjq8eubiUsv4ioZOgx/r0fhDcyFeAulHk+8hrB+9/mCZ7Bo+EsNKOCbNMRuF08+wsgAEpkQNEhDenBT+gPMz6lK/aFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5YOE5Y+OiUf+V+o//Zx8S2Hw9KsU6MHMsMEJtfSEAAs=;
 b=lIH6HQbOhUq8suA90kEHBdCGQQHig3YFsfCzIz0TrDXgrcwjZkOIVGK1ZulL1r8mHdd4/e6jDYE3ma6hbVWzBw2Drzd7lI6dahcmJrrN+N5VcwUmZSwS9RhsVZLFnjVphpU1HFQvwAPDCKCCecmr1LpwHPahSWxFdPc54g7A3+RirqIVq29J5Fsg5scDHT2Wm1Qg0aDHVUbwA3o9kiSYmEWKf50lIlVjJG3ubszmEuXsdML5JJw1CuQJfbrlgRnFwcQaUp+8hb05wYAhbzozR7fuYyROKfETrXNCskEXcNZe2PDTI/X44PGCvw/lyqaWlpbvpXdmWXn8Ysi2pzBkQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5YOE5Y+OiUf+V+o//Zx8S2Hw9KsU6MHMsMEJtfSEAAs=;
 b=jfQSeCtmQ9LfiAy6Gw5vbdlcTRuNECjElcnX5nYhDOQGYPuqQYzFkIkZ7cwv686IPnM59yTg0EO0t/S53gkmlWskbG5aUivPvLXhDLv1TB5NOpM1M0Ssd8DA/BVlA3seGycjqh4O+ujgmL3JW2XWDICiHlfGQqskhTCwSAdupkgBPVRJtB1IoSmfIGjQNYEG6tCgMhhdoX0mYRDhLxEM3AYGG9Mah4PryO45xtgmRSHf6J2g/HXfq7jZOh/XXHqaWc/DmD/8OjeciABkSZIqCWrmsPOAwmlB8sMCwDDsMtK3qdnz48J6GsaO9ojy+RdN2fYVPU3OZbIyr8PneEzsDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DB9PR04MB8463.eurprd04.prod.outlook.com (2603:10a6:10:2c0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 18:42:09 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 18:42:09 +0000
Date: Mon, 10 Aug 2026 13:41:59 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Frank Li <Frank.Li@kernel.org>, Allen Hubbe <allenbh@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Niklas Cassel <cassel@kernel.org>,
	Nicholas Bellinger <nab@linux-iscsi.org>, ntb@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/16] NTB: ntb_transport: Abort link setup on QP MW
 allocation failure
Message-ID: <anobdz2EDP1UiLbA@SMW015318>
References: <20260810165136.2292436-1-den@valinux.co.jp>
 <20260810165136.2292436-2-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810165136.2292436-2-den@valinux.co.jp>
X-ClientProxiedBy: SA0PR11CA0058.namprd11.prod.outlook.com
 (2603:10b6:806:d0::33) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DB9PR04MB8463:EE_
X-MS-Office365-Filtering-Correlation-Id: ec5c7f83-6bf2-436c-beca-08def70f1546
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|7416014|376014|23010399003|18002099003|22082099003|4143699003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	dSZ5QfY2FIg8BaZJeWauDxetWD5yOuqEwDucliPteSFno3DnimojAKB6ATzUQLiYbFyBTl9oxwKqY9VhbSMDOV/GEYlwJKrqZOf8zotuqFi38cBTQx3zKbxxp/S1Zcn6SLV37pYK5DqXepoHF3wjfjzx3bEXY2nz/7mQJQkMnP8xm1XKupi51KQGqwgm1SkU8/Yx+O07BqYCV2jvtDW8m/lsSikX9pjqUYTQdV9VAd/uARmaJjSbFZ/aQ5cyWc8jLf7lMPAyumkKGU0PgHWSdyaq3XY2WlYDQLtHENq8nbS76yS+Qh/CXVR2t6zul96ZZUbVjHj7m1lGuKoGDL6m1TPzWApwxgqsaOWvrus8qBwRG0PaUf6M3FRvtwah/hiCnmFp5CU1B/GSSkeyXERvAxDkbWuqAQkWvN7Pf8pIIP1mv6tJw/p+qtNTAOfQMODwfQQZw6opQvFfZ/18TuAKAzwJYBPSRNPLgEztnXIiXvmQSETZ/6pP8Tgwta29I0DuurR/IpcnF97PCZ1nkcvWToG9FKv3AJz97Zmqr8jAWlwRRRuHo4x1Gwif4+nGUldj97b081tmj2AdAcbFl1W5n79OCzaLchZPvHJ2P8E4Qz5QzU4JTC9TL7uMHoV375DFmdQqsLrEq936n4vhij2mi9J6QuhC6VskmESe5siiWQY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(7416014)(376014)(23010399003)(18002099003)(22082099003)(4143699003)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vtC8wAneRDPxJLnlZ9bXj0o2UEmjha5Bno1MyCXZ/u8lcF6Prx5asKbkKonz?=
 =?us-ascii?Q?H7KdBL2d6w50c871dQgPjv8VxapKAhu5MUnVYfkd6jO1rwkLjBfGzxTWQxW+?=
 =?us-ascii?Q?7txFkSX4Ujmx2ZWwbEX6DarWOCHF0BmbzNBWYXTYF3b5PDzJHHJPyYNlhgvk?=
 =?us-ascii?Q?IIUaFm94Z9xXZk6qP+hAjtphCsBvcAv/nejVJTA1RhNZe+vsVi7a1RBuy5u7?=
 =?us-ascii?Q?hn/bB7fwyy4l9T9FPLh3Hqf38XKReKXKLZGnHp0Pcww99y0gvRGC1UMmtHC0?=
 =?us-ascii?Q?ul7IlAV5WiQc8zjN6v4PccqTfKXx/cScSoUM/+3kTa81aS70Hf03+MvrWvYt?=
 =?us-ascii?Q?xOLf++gXi/I5Dfa8jzT2dvXF1XhDy1M1eLXcY91D33AhKa0rGDMWh8b6chzK?=
 =?us-ascii?Q?DYWIpVKFAtutrUFRiYkNFKkCGcDl1AKl+YPPClRQFPDb8zmlGSn3CzYLOBPP?=
 =?us-ascii?Q?wji3ye/MU+atjkA0msmlfBu5Yn7j13fkxNrYCG9mGxqkqBT+kcPbod0kXyhi?=
 =?us-ascii?Q?lKjK/3CNJKfgbxF58aVFPuwzkbtTkwAtQ/3U7SEx5tt8Qt/WoH1nu7N29IRc?=
 =?us-ascii?Q?sonVWx/riOBJdaJ0+P2N5EFSGUo7O+FqpgcBPT+hvhza2XxGM6xDKQdbB04s?=
 =?us-ascii?Q?SxQshWt7j4RBCxRs+yxqJXwn4WDALm3EciSsRr+SRW0t2P8vfiuwVZahM2F3?=
 =?us-ascii?Q?QrfgOZ5WLB1GgdfrVr8ZsekvDTlVPyzjVyaoFzr0B5eTuGxvrg/Ol72G98tH?=
 =?us-ascii?Q?muYywG8Ucew8XbbO9ZiZljFw1c5dQ7v8hXv8bkjsY53VH+9zrJ9EjhygSpTU?=
 =?us-ascii?Q?4lBcE+t4vhjZVBys6FEY9RybE/ximS43jkSiZ+eVetwJ8XZCE3W9je9rooE6?=
 =?us-ascii?Q?lsIQkgwkocAD4DqpBHNezGA9jDZ/VCOLJBpfNAFnV8KIbE5UQgQ2tsgIygfk?=
 =?us-ascii?Q?+oH4K4L/C7ND7511wCFnw6YlH4ijC8jjiWifun/HfMOa5vK5t77dIZv/6gc6?=
 =?us-ascii?Q?hHMzYodOjQrz1Rx0LzXGnlB6DNMRoaAYVbU7IWdRY2ks3+F8wcsqyOVvoSB7?=
 =?us-ascii?Q?AyJFk2x3MMiW3Y93misp2KEbC8ls/14Taf4j4vBSMnJ5TJAbe3A6pUc0MGrt?=
 =?us-ascii?Q?iCLYgMT+f1gCnYNe3CTYrExrkIWOZxqrUR8pt6HLCelLvtBuf7UlyUthONNf?=
 =?us-ascii?Q?6i/175BY3wEdb9cQY1qRz5TGa+0YHNIQIK5YiGXYC+AtdDcBh2wdYb5uhYaj?=
 =?us-ascii?Q?Dg0MInmrL8lyGS80xKh41nOCW4LetII9Uai1l90q70zHZ3sje1MrWrgiJmQx?=
 =?us-ascii?Q?Y0u1nvmfRqqPm3O8DduVfcV3snR1a61umwZBopPZNynWshGD6siG8QVXpZyr?=
 =?us-ascii?Q?kifyssRdY3lkaXGW11JzcquM64/hRXneMCOK7FgTHwQ1WQRJwO27bAMwxZgp?=
 =?us-ascii?Q?hGWczB+bYYijRQzhDeYf2FsK5TW7Jfo/mJbGyaAICasnRGdq7L5aXTXw489K?=
 =?us-ascii?Q?CMSwCB4c9T5SZ2BaNvEl83bLvp1QOL3wXctU3dsOEAabB+FSxpPIn0m9Vvl2?=
 =?us-ascii?Q?tzuLpjHai9C1UdmjeUVm7AiqIhiCC2FIX8onQpMrr/UC4mpuUP7ScKwQe+QW?=
 =?us-ascii?Q?2YKTpXGXhnUroo2lOOdtZprArc1coyJAibmLwxDMtOcJNCweUmLN1ycyx6Vl?=
 =?us-ascii?Q?rcqN1EGy4+0HUmRhePm0RGPU5GqbLJSaWPpwbxZ1rZ2OrBfnkLoJUyN/2SDs?=
 =?us-ascii?Q?BnvP66aanBWohb8m6m7/f4RY/hbG9UrS4X8eeuqMxuD0nvj/qSAK?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec5c7f83-6bf2-436c-beca-08def70f1546
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 18:42:08.9505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7h5OtFsRbaJL5iYcSazBMOOmFetJrjNWDmYpn+FcOUwYQlwiaosx5Ne1B0PGVtv5qvCq7lRtC9Ccf9YXGPG/rJ20JOQ6xyOEcnH05UNAENe84CNdLQmB+Ul5YKNJRoAj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8463

On Tue, Aug 11, 2026 at 01:51:20AM +0900, Koichiro Den wrote:
> ntb_transport_setup_qp_mw() can fail while growing a QP's RX entry pool,
> but the link worker ignores that error. The worker can then publish a QP
> whose memory-window state is only partly initialized, and later work can
> use stale or incomplete pointers.
>
> Set up every QP memory window before publishing the transport link. On
> failure, clear the QP pointers before releasing its MW backing and leave
> the link down.
>
> Fixes: a754a8fcaf38 ("NTB: allocate number transport entries depending on size of ring size")
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  drivers/ntb/ntb_transport.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index f59f926d4bfa..3efc50955253 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -1084,14 +1084,19 @@ static void ntb_transport_link_work(struct work_struct *work)
>  			goto out1;
>  	}
>
> -	nt->link_is_up = true;
> +	nt->link_is_up = false;
> +	for (i = 0; i < nt->qp_count; i++) {
> +		rc = ntb_transport_setup_qp_mw(nt, i);
> +		if (rc)
> +			goto out1;
> +		ntb_transport_setup_qp_peer_msi(nt, i);
> +	}
>
> +	/* Publish the link only after every QP has been set up. */
> +	nt->link_is_up = true;

Not sure if need WRITE_ONCE() or other memory barrier to make sure
ntb_transport_setup_qp_mw() and ntb_transport_setup_qp_peer_msi() actually
complete before set this flag.

Frank

>  	for (i = 0; i < nt->qp_count; i++) {
>  		struct ntb_transport_qp *qp = &nt->qp_vec[i];
>
> -		ntb_transport_setup_qp_mw(nt, i);
> -		ntb_transport_setup_qp_peer_msi(nt, i);
> -
>  		if (qp->client_ready)
>  			schedule_delayed_work(&qp->link_work, 0);
>  	}
> @@ -1099,6 +1104,13 @@ static void ntb_transport_link_work(struct work_struct *work)
>  	return;
>
>  out1:
> +	for (i = 0; i < nt->qp_count; i++) {
> +		struct ntb_transport_qp *qp = &nt->qp_vec[i];
> +
> +		qp->rx_buff = NULL;
> +		qp->remote_rx_info = NULL;
> +	}
> +
>  	for (i = 0; i < nt->mw_count; i++)
>  		ntb_free_mw(nt, i);
>
> --
> 2.51.0
>
