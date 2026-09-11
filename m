Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013002.outbound.protection.outlook.com [52.101.83.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A3D310645
	for <ntb@lists.linux.dev>; Fri, 11 Sep 2026 16:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789145632; cv=fail; b=JgUqx/1VzCsiHc3tvHvAJ1Dz6yIGxAvNHc4LfxRrBV3A5Z435Jxai1zOqOJ+CPZzOWDP+F9PG3abRbOVD0B/kiPxH4uH3/iDt+Ja0DEVwutwXJVRmmGL7qouNqmWDuZDgFellLZ0gi/f8+iIJJQQ6H+jrUFtM1b2ExWw/p/a+58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789145632; c=relaxed/simple;
	bh=xRWHsyZoaix4AZMBPE5A8XBP7lE9MMyJVoNuwFJXsDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Pofgr/Ks33goOpHAAy5lAgvJXs9LvMutl0YjtypwG5kWij0MrkyoT2Ejurwwv8izodLbIn7mFTGEEYESQweGnNnZyl9zocViOiI4/FFLNVwC0gUft5/QyPfI6dDC85fuoYBkCmEmGOqFqV9Ci8N3FeGe6YLmeiQwtm/6zAC/pYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=sI2KviGl; arc=fail smtp.client-ip=52.101.83.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="sI2KviGl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=APIwzsQ5JcTD3fg6n/2wV7TSNTwjQSEN0BH7cWG2rSCJ8bxxePEqf/NHoOnSQY9ScSitaHO8NDTsoWqr0oS2MQJ9J1CF7ZqqLK9DPuICesVYlg0i1fI4zQfqZNX7gIvup1Afu66gTvq61l1NsVQLoMOeusyr01Rdd43Xcqxh55ZMsc7zQI950wFQW42mIuZCmKiWbCb4ZzsNnl0EY6QKYPA3ASzG4RFBk+RJkVgy5e1XpHWKf5yaulxwKqf3YlYBkPBsT0v0FSxp3354JXZSouEIeuA9QsroGI4OKbieSV48dD5YhmihaH+Quo+is6k0Gs4HZQs2zO+UEllOpdSEcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l7qmCFMK2POkGTmrOSbVANOP9d+0hi13CcGb2e1e8rE=;
 b=MXWZ/qvsSGsPQPoq13vXoZOq8/XqEn0evLH+mP4IvSSwmHis4EfCQcH6y1pws0SxdQhGXvBhhsDa0StoftbzWqWbGlR/RpsoTK6KrjaVEaDT9G3Vw10rfeJ+wz/ghXVOR0+bwhdoxv8VmuQTMXVT7i02guXzEP9CbGQ6t7pKgTf6ZhQpJTa2MrNNa7tYfijuIUIjJOiRYVoMvJeIgcx3HGQ0GLOZBnAQF7tAEqdNLi/zmQ3uPYj0CIuU4jdL51t2xQXW+92/KdLDK1mURhIm+xI1Bhd3TULv83HcQmr5vQpcixG5w1XpVUzITqwZGIOJ/Vx6ePiAmC9+kA0I9+9wZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l7qmCFMK2POkGTmrOSbVANOP9d+0hi13CcGb2e1e8rE=;
 b=sI2KviGldxMlwSE4fBOXPqXTTE48P3DAQAYOAxvjwkqGlgaFFBjBlCzmBtTEgRwcFXl9NO7KA9TUqpf2Qi8SFJbUuROlqsMdr2jqokBMeeAaDX1RyeYRHH3u3BrnQ+DcZoRRzYJdtJtd/oow+LhBcTAiW5dHnLW8BHbeVL4gXKw6aGzDLh2KhSY1HQPHvYx3/DLlf50Wy6eiFxRoIHidSAN0MrA+LO9YveL5Euk2R3i9PHnbTyd7Ukr0qu/5tCjSEbi78swEUdWYARVrQZxBBTx4y+Od4rxgNhfDCqCk8RCMRADfyuxLaJhqAzh5dQW0qep4KxbVcXhBTcbtLd3uIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by MI3PR04MB12439.eurprd04.prod.outlook.com (2603:10a6:290:74::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 16:53:46 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 16:53:46 +0000
Date: Fri, 11 Sep 2026 11:53:37 -0500
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
Subject: Re: [PATCH v2 05/14] NTB: ntb_transport: Avoid losing QP link-up
 requests
Message-ID: <aqQyEbLbABhhvFTO@SMW015318>
References: <20260910040836.3792333-1-den@valinux.co.jp>
 <20260910040836.3792333-6-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910040836.3792333-6-den@valinux.co.jp>
X-ClientProxiedBy: PH7PR17CA0029.namprd17.prod.outlook.com
 (2603:10b6:510:323::23) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|MI3PR04MB12439:EE_
X-MS-Office365-Filtering-Correlation-Id: 772ace9a-fc13-41d9-3aba-08df10253e8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|23010399003|7416014|376014|10067099003|6133799003|18002099003|22082099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	3DJ87ACp6GECNoNSZc+/R5lc/WWDhv5mBqvdFewzxoNl92JvCNnQR2RPoCjCHn4NUHYUIRK0K0mGqA5t2nAl93hZfgp3Pe8OD6tqlqPEllSzfV8TA7/phLT8xVPJfBZmUItxGVci37IgEauIYbIR8Mbi/qtaQOLaoJO6fEjWXFgmS/kxtIUdobii92gtmlu3udhWIdQoKbipT3fz50423HuGf2Rfkcye8bivZ02uQ3TvpcPe9gA1DH8Oany5vfewWg1JWJG6crF8JB5bIFtNIUbY/bfclKRy77y0DlZ+9uqUgeQ7ZmeU5aPeIoOJnLkjLqfS/HWKBQgbW8doUTJ7mbDQ9qhEr7lpnCPMdEZ/OoAX/vqQwcNmhJHrtJTQc7B4K4PV2TaUteOEAZL/0yltXvQ/lDWTehdwbOr7g+0j7fYArhq4P7eHruCXaPI3F6X8MoenzVsRZ6cLhjNTd+++yFRagcUONF2cBQf8sBoVi65BGHQKBUMD8Pcj7RuMZ4PLm7M1U1Se7vTRFKjdWG0eqY1HH9nNHcVl1QFcSEalSW3Ioo8ir72siOEsYISWhrljZbNaqICB8owUUkgNrsxnPPniHN4dLgCTNXGGWxH9Im6zzZSqae3EM08BaY9uNfqD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(23010399003)(7416014)(376014)(10067099003)(6133799003)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xhTTv2YsLOqWAb2JNqLeI8zy49YcW59OC1B9784EweTZopPCQp62SYRaz5Er?=
 =?us-ascii?Q?26YXtHOlRriRw0+nsCLaXkIwsr2SdXSz+Z51WepwoLYDXV+GuVVI6qVpivDB?=
 =?us-ascii?Q?ZGR+Koznz2Fl+JdsCnLW3RFXjUj3u20FhoUcWWtuNGiW6BjbmfPXr/NDWqHI?=
 =?us-ascii?Q?p30wW6u4HkBs/vMntjC99QX6/3mTnPINPWhp7dAdRt+LfDEAdt3ZG5MlHnQD?=
 =?us-ascii?Q?eLXBINdOixS0Z3lSiHBfBk0EA5vIHSUknQfTLJkRCdpolLe8IX2HdEdQbn8k?=
 =?us-ascii?Q?AF4MD03CpCBCKfXYyotLxRGCwxq3dK8TrLFEw7NB5Ar7fTX9Uyw2xrbuLVZ8?=
 =?us-ascii?Q?k48ETYjrGFHtcPexc6LvNngXsUeCtlxWizo+W3G6ZPcKLWDeMigJRylmQFej?=
 =?us-ascii?Q?VnEeH4cQwPouzJ9TLeaRDHk2JtpGQCmC21UBzBSmCostp15V22Ex8DEb3xW9?=
 =?us-ascii?Q?o9RmdGitFE6h/EoUBHn5rqnu/Htg36CHXxjV3VyE/lDaQ66F2rYBl1gEcdDL?=
 =?us-ascii?Q?JgMAqvOE3OAznGxmOAc0rrVsVUxBDXMZ4zfPhiimd0gnKYEfGCKv+Og5kjij?=
 =?us-ascii?Q?vfBwIw+6WNXcTIAhkgbuu3w50MDZudFgFN+nbKqaMjIdZNFFxtvytjo81+pl?=
 =?us-ascii?Q?ozg7HKWvTwHB4k04PAntN2XgqHPS8H23s2mfpoSyueexxsQZqZD16WHS4MTQ?=
 =?us-ascii?Q?dXkKguZU8+66MAQv6tvuaLfSINvbbTig0S3MFjefJO8OfVJJ4O3eDMA/cnK6?=
 =?us-ascii?Q?KSG/TSeom1NTRpgiNxQ4btfQNYFk9kMv+aKGNHlxkZhORv9TdlGvDYwVDCqB?=
 =?us-ascii?Q?5/27/pat9cQjOsL5ZF2SNEhU6bNSOmUIvvpTcyLHzf1Ew1Vm8f+guUU4WZ/F?=
 =?us-ascii?Q?+ow5ydXjgKG5Y3Dr/W/QWxFp+u59Twg9ZbtJwFPEUbQZP2bHqQgzAFJMSBpE?=
 =?us-ascii?Q?LYiQD41Ta6BWozWAvO8Jen2K6rg2A4Z5l7COj7nDTkco191z3iVzBHIoaA0W?=
 =?us-ascii?Q?ozoCD8kwFC6Y3svYxDZfb7pckQxSxY00pdhdqlYXXUdPcQqFvI9D0jlQpgsx?=
 =?us-ascii?Q?t5KII/EUUL81AzFBwOPXtAmF0gs9v9mn9Ap7zmpMbTGiJdecFe+VcrC3l+SY?=
 =?us-ascii?Q?TAtDv+eq25s6ACIwtIieRJSEPYx/wVpDzwdkD/M+pWrgkcd5Vvz5nsHEiDTl?=
 =?us-ascii?Q?AmNdIh7qAlhDr3eolMz/5XBuYBwYx/D967/vzsx6yLihP284/J4VeAGwR/kx?=
 =?us-ascii?Q?jG457RqNtu46Tfe3MjFoFmsRDGb62tT+veu5ryCGyp+8K06T44pvgxCZzfAs?=
 =?us-ascii?Q?Fyo7uSg6AqDzbM6BBE5epQxpTQ+0BCZvIqiqeC+vwTylYdYflXPyW7i2cN/j?=
 =?us-ascii?Q?5rfCnDkazhCy56ke72URr4jGqOWvTu05Vdk7t0q8YgjJOIyDSxrGkmz+kcho?=
 =?us-ascii?Q?FBkUDxql8UkK4I7FE9zH1q7G28hcQ+ytOr3ceAZKzKdvD6HpQdQG2feDXdOg?=
 =?us-ascii?Q?fnpGU3uz/EN1Yrob05Atd6ACN2kA63b6OWFrsln3KcIUX5ZG81J7LqbX6g6r?=
 =?us-ascii?Q?6yBW6gRAjgtgq2Bb9C2azhP27CcgqAXdpRDXblooiCnKDBvSFOwexSotrDOy?=
 =?us-ascii?Q?sFogflBj8LzjSUfKC3lU4zEBaIx1euQNrVdDOVEpCzU9a+C04lXmvfJUgMVc?=
 =?us-ascii?Q?vRgpT4GfceQTTQdcFSfm/TnEmgPlrFihj4QspE+uwXWJLiBvIXv5SDO6tV3u?=
 =?us-ascii?Q?S5OxR1vx5XbnEpCzWjgnN9ncSb5UwEJcsg3sHdzLBw5TFPSUfH/8?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 772ace9a-fc13-41d9-3aba-08df10253e8e
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 16:53:46.1371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H8Tc/GByo/L7Th+UB9ENlW9KQufvfsMH6WFGgAWBkZWZppeRmF/WIme788+uewq69WKjFyA4exK/ihZdZ25TFkXiRQExepJ38FEJVqKpZriu0Zg/tg2kkYonrc0PwCL/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI3PR04MB12439

On Thu, Sep 10, 2026 at 01:08:27PM +0900, Koichiro Den wrote:
> ntb_netdev_open() can call ntb_transport_link_up() while the transport
> worker is completing setup on another CPU. Concurrent transport setup
> and a client link-up request can both read the other's flag as false and
> leave QP link work unqueued. The QP then stays down until another link
> event or client link-up request.
>
> This is the store-buffering pattern described in
> tools/memory-model/Documentation/recipes.txt ("Store buffering").
>
> Add a full barrier between the store and load on each side, and
> mark the client_ready accesses with READ_ONCE()/WRITE_ONCE().
>
> Fixes: fce8a7bb5b4b ("PCI-Express Non-Transparent Bridge Support")
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://lore.kernel.org/r/20260907144701.702E41F00A3A@smtp.kernel.org/
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
> Changes in v2:
>   - New patch (Sashiko)
>
>  drivers/ntb/ntb_transport.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 75d4a2e021f4..1332d53bcfe7 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -1104,10 +1104,16 @@ static void ntb_transport_link_work(struct work_struct *work)
>  	/* Publish the link only after every QP has been set up. */
>  	smp_store_release(&nt->link_is_up, true);
>
> +	/*
> +	 * Prevent both sides from missing each other's flag. Pairs with
> +	 * the barrier in ntb_transport_link_up().
> +	 */
> +	smp_mb();
> +
>  	for (i = 0; i < nt->qp_count; i++) {
>  		struct ntb_transport_qp *qp = &nt->qp_vec[i];
>
> -		if (qp->client_ready)
> +		if (READ_ONCE(qp->client_ready))

I think it'd better change to use atomic variable for client_ready to avoid
manual handle smp sync.

Frank

>  			ntb_transport_schedule_qp_link(qp, 0);
>  	}
>
> @@ -2401,7 +2407,10 @@ void ntb_transport_link_up(struct ntb_transport_qp *qp)
>  	if (!qp)
>  		return;
>
> -	qp->client_ready = true;
> +	WRITE_ONCE(qp->client_ready, true);
> +
> +	/* Pairs with the barrier in ntb_transport_link_work(). */
> +	smp_mb();
>
>  	ntb_transport_schedule_qp_link(qp, 0);
>  }
> --
> 2.51.0
>
