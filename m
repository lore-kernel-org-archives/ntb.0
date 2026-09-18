Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013037.outbound.protection.outlook.com [40.107.159.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F01E282F3F;
	Fri, 18 Sep 2026 21:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789765598; cv=fail; b=sIF5BG71QUnu1i7TsTFgamdvC0fpfenj9bSTN8qkbYn51zuK/K9OObLVl1vO5kawYZGHHDPou7rkAsKqYMX186cqkFCn1VguQtOXyO4Jo1gkTpp/WjElVIYZBI7z8PoO5n0pmabE9kpT1VtUfUcCQSdzKAKM9+198/czbDNSEhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789765598; c=relaxed/simple;
	bh=Y/5jB9MDbBn8naoE4xdqdUXXuq8WToyN66iNSdFvAEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CoaXM4mjGyuAGPP8zArci4WsCnxWbiqEdgQTgCNFbQAijHRzPPstx29ch3TrD1snCYsh3GhENra+HT8omrMMGWtk32jbJPemf6fbCN+5P1YnqkMAtQCrgZ+50L9MJQ/C57xcVPWvtGt/R00yy416hM7Rf36srqPVIh4uzi8ovYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=fail (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Sd6Ejupl reason="signature verification failed"; arc=fail smtp.client-ip=40.107.159.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Sd6Ejupl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DjKJbVXzldQ+vdgulCcFNzYv0dT7Fn0If5U09CtcAu4IoCPjQL8fUZZDr79YfSjdfVn0jyj7FyOL/564Qp4kD6sfuljRuzklbqXnVRygosNVx0xLtiHOoWamieVf3igdeHUAgXrrZZ4jCdb3GiaZlUPHdEgBVe581/W+YjGso8ue7fVe2pPHx2eOmkoBhn2dLBwTiAQdPao3RtM4OmSFX6wmSl74bSlvpACt54cD2OMBk+1QQB3Y2/Ov4tW6zpdRPRH040TVsl8vvQT5tFBIBZTcbS/JLqfmWTQlIEObDdYXqWPVAXByHt8LxVksUlXIfpgRWn1YZjcgZ3qOBdBXpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VPCfvR16/Yu7Htelf8aooSGaPdjDLxOupNbsuW2vTPA=;
 b=q3dMMw+se1Zap6Dv4TXprGhaQMsHqtte+/9X4VAe4m1S0ASIoQ6f7dX8IGg/EyfFAiX6uCEiFCMzcHh3OftB3SSpwhQnXU1E+Xd4yMtQJrAnxx6vZnoO8AW+AvKfAVbdHOFm7Y2hkPPKyhkcyThD+EuIr3QszLBdfOMmgWJes2dVCMJipG9JoIW811LoCkp0nbkrJZiQBI6ENMGapj3wRWpM385w16cHDmmyp00xFHypbu5kSW0mPM3QXUdPmrJ+jveGr7oFRkryYd90RdVMP+NxEY9g/tA7mrdt4SPT+dnFiAt/c3w/OM8RRKB41uyWwvlFvWaLGxMITytHOfQFRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VPCfvR16/Yu7Htelf8aooSGaPdjDLxOupNbsuW2vTPA=;
 b=Sd6EjuplKx9UmTQPEKtvSPVaGXwsQLrnpGcTESXca/6dsEMMtYfSxZS8HH5IKmjoNjfiv+0mogafwcIy8S3TWyE77quIbrigjInZy/md5Fo/orxxJMr1NxBqqEvyr0SVpHRy4cT1A9SEEs8AkO+ObjrKx82kIH11REQop4+N8CrQ8KEobsXOEGMV7hZxse7Zrubd3IzNU7MhZd3/kZ5+xDaD9NfHlW2YDoa2czTPubmDURqYDjOcceEucXNSDQtdtJiV0f38uHIWxFEN+2i5E5xpqcXKnHTBfkkVrW7vqpgYhuXVSdOY0FzgDme+jhkON/9aXI48Slgqa6IITXBGPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PAXPR04MB8240.eurprd04.prod.outlook.com (2603:10a6:102:1c5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.16; Fri, 18 Sep
 2026 21:06:32 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 21:06:32 +0000
Date: Fri, 18 Sep 2026 16:06:24 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: sashiko-reviews@lists.linux.dev
Cc: imx@lists.linux.dev, Frank.Li@kernel.org, ntb@lists.linux.dev
Subject: Re: [PATCH 1/1] ntb: use dmaengine_get_dma_device() instead of
 chan->device->dev
Message-ID: <aq2n0JLhTJucd0kt@SMW015318>
References: <20260918204152.2364336-1-Frank.Li@oss.nxp.com>
 <20260918205324.3CC7D1F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260918205324.3CC7D1F000FF@smtp.kernel.org>
X-ClientProxiedBy: PH1PEPF000132E6.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:518:1::26) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PAXPR04MB8240:EE_
X-MS-Office365-Filtering-Correlation-Id: 11ef9fad-cd7f-4a54-d9cf-08df15c8b770
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|19092799006|366016|23010399003|22082099003|18002099003|56012099006|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	Iwid0n8AQ4l3r/O7n/mJSJqNbd9Q5tBNtqip6icjsDwGOm2WkzECJN6LfihGap8ZQjaVLogfPS/9F7+/nROcRjoaVhpSdfwwV1jKgvPXrwAqpKC5Bzwy/Vamz/KuM5pq8IrBUmbWqOQgsI3MBj+neH/yviINcspNCf3nkvvjHDVWwISSNIee/HK2H4ihTwvjU/T4G9uZPtWVaB8YtklRlmOi8ghe++vqbsOPSvQ3Ih+k06hvx4MoCrdzhl66KypKQMwl8AG8UjXmhBNyGbyeNTVB/FtV8AI2MVcApxYBqpkbd7a2zEdIw/ridYdzBFnD5l1k5QrSYdedNxmOP8Q2Hl07Ky/TljLhjsxSTNRQVgfMfOpjT3u9CLPRGl0SunMrm/Pm6rAb843o+OzkACBKd2wD2Z698wSqalroMSDZWMqf6YlekK9dCzP+I54+cQdP5DtObhPsJ/pR7/N9amVIMU/Tv6HdApDSpP1IMvv/JS7stOSifZ9akYs++uHZjPdnHQtHq5HlaC4/uSf60+2zC8y6Mxqs9XLkDCb5ksDdixjBf3HKlo3mkLImKzKTGZn7gZlNOaqYLPdjhByjHZ4TwhuB/qKbWcoLaKZeOwJVYFc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(19092799006)(366016)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?r+0OjlBj0mzgGtGifsjskcG7DwWbtyf9cfyjbhl2/Jye1spXacLfxBh70t?=
 =?iso-8859-1?Q?3kIxtNl0QGTg2H5uDEzqTH7g45g0MibjbhByyFPkT42ACvne9u57h/bzuz?=
 =?iso-8859-1?Q?x3cZcJlDuFGXDey92A6RT0H5pcW/qjKBnH8wPQbKhDXaNz8+TnnF4ziX1L?=
 =?iso-8859-1?Q?r0SjNBgFgSw8+RE/ppZSsKTm6fpGMr0KMfn2n4JyL+Reu9Pe/21KkgYqVt?=
 =?iso-8859-1?Q?/U0NhPHVy9PRTDGV3PMM9//3gmsLFFTKwy34jBIMDmeryncaghHFvNzo6Q?=
 =?iso-8859-1?Q?8By7XUZoZ3wvLmFeENRp4K+BNPrneqq5hiDG8FABK/Rv5dbD1DQH7jMndx?=
 =?iso-8859-1?Q?Pr6d8qk3UH7HHkRtm5t4tL8NQ5sIjX/9fa1hPyZcEjjjkByBA6zjjn4Ppc?=
 =?iso-8859-1?Q?uBczTAglviUBKBuRqp7+Eh2pX/mWJDMoH5aTDV9dmQyiGByD5P0YrXpcUP?=
 =?iso-8859-1?Q?YJjb4WyGwT1Q3pDIhu2vH61SckChYgcaUhX36rdXlmQCyV84If16X3Wzir?=
 =?iso-8859-1?Q?/6/RmPwAYu3kjXOKScebfK9yDNknlZboqcJ48tWbrqlbcNaP+Pf0M1mrX6?=
 =?iso-8859-1?Q?8RXYfiyAzIAbJK11SqPuZgqMviaTZ6PiX4I+/nAztXRY+TKC+PFmei9UE9?=
 =?iso-8859-1?Q?nDtl9KCXS5Gw5Xs2fTvwRqOrbZ2UfuP1uKDxJV2LOFypazRM20UF1CViE5?=
 =?iso-8859-1?Q?Jz9tps9tbRmHRSNo/UzMbEQasHOvWXzJo7EgGMpmigHEeIRcLsN9ZbCHT0?=
 =?iso-8859-1?Q?4MTzdtyv0XewAdvw5NwnK9rQIQ8FgIFZigY+8RxOdhKlFVNCXAstaHFiRF?=
 =?iso-8859-1?Q?2Tk7FY9n2G6za7x02kVz670WWXDj1s/inattaPUdS19ogdHj9/SalCscvI?=
 =?iso-8859-1?Q?1lRGixQcCFiUoM6JgP8YrWDU5ux1DsQkck4mLbG7Lwf8HWI5Ssj8d3nMgv?=
 =?iso-8859-1?Q?GJBXpT8Jsg/9e/y3fl1oXu7Tjo1xEyQrCokZ1BnoTWZUl9grtX11pPIWPB?=
 =?iso-8859-1?Q?o3jGCcFEmu1Ilsgadnj1aWJ2afjVN632Ejml4goMLY/8dN1AmrAkbAREth?=
 =?iso-8859-1?Q?L1j0a4SfgsJUiKCrSvK/WgLnwaDuX2Yv1H6U6NrErLAO7N+AcYV1sR6lQE?=
 =?iso-8859-1?Q?RpaFFYfuhtQK3M4dmf4bHnQDh7oFNbnKQ/fQjoczXc3eRDukAyLjRSdRJZ?=
 =?iso-8859-1?Q?JUaHapbsV/A2oHePeMrAQoYeqISLU5fVvPRVoWw3eCk3zXX0WAGqyNQk+O?=
 =?iso-8859-1?Q?XWQt6IqCtv3ghhYU0RfQtL1VzpPOHRyJ2/bS8E/F1BmdZ+dw/aYrIUorLS?=
 =?iso-8859-1?Q?jtfKDOXY9O9iUL7K1xP9dFeNufV5bRI1hstTytafhLO5m0D0S2JdatbZ5q?=
 =?iso-8859-1?Q?lo1hT9z0kaff4X6TbUEExVi5bPAp2BtJSCshMx0GfQJ+XWGxoBkyj9gB6u?=
 =?iso-8859-1?Q?+2GrqlC2wCnAZFuhNPl0XPvdi/9103hd2ZWlgB4Zr2HHICnBoQZ43YR0AQ?=
 =?iso-8859-1?Q?lLFc2kewNIjS+JCgl4oBhtOdp5IAvVlJcouZWl3PIMUh6SAh2UZJJhofSV?=
 =?iso-8859-1?Q?YunvpqaJqfkPa6egmZxPXzt4TP3Q2wVYgNcwKjBTHZruSKcjI/cmDaYNTx?=
 =?iso-8859-1?Q?jtnjQsfHdIdEJABB6ZEkdqcwLtYuPuNWj9bMuw8TsiuQ8PYOm0fCXUocNS?=
 =?iso-8859-1?Q?EFKNV/8w1If8eQO9gB7p+sZKdgskg24WobVsrVUGPd49mpLYRY6W2xWsLz?=
 =?iso-8859-1?Q?8KJoQZ/7Mrvpd++7JXZH+m1b0SPePE0J4wQEiH3LUtrOcIth7EGN7e/S7O?=
 =?iso-8859-1?Q?8G3Ns3lf2mOisWA+3Ul53IEm6gPveu5US9T6kTreyWeKcPhvglU2?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11ef9fad-cd7f-4a54-d9cf-08df15c8b770
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 21:06:32.7948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 28Unmot9DkOhcBFRu/JVA0UI6wpIZnvXZ3TJUKL2igU3uGMiUkvI66Cq0pXJYZaHawMC9otWCduWPy0VSHrtsVAkBKvAiag8kNgoE1QYsxQAlVbFz9W6YnSkCL/XnG8H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8240

On Fri, Sep 18, 2026 at 08:53:23PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] ntb: missed replacing chan->device->dev in perf_dma_filter()
> - [Low] ntb: commit message incorrectly mentions IIO instead of NTB
> --
>
> commit 00ad86ab4ff3c677b79412d332638c7a5186dbbe
> Author: Frank Li <Frank.Li@nxp.com>
>
> ntb: use dmaengine_get_dma_device() instead of chan->device->dev
>
> This commit replaces direct chan->device->dev access with the proper
> dmaengine_get_dma_device() accessor in NTB DMA consumers. It prepares
> for making the DMA engine provider data structures private.
>
> >     Replace direct dma_chan::device::dev access with the proper
> >     dmaengine_get_dma_device() accessor in IIO DMA consumers.
>
> [Severity: Low]
> This isn't a bug, but the commit message incorrectly mentions IIO DMA
> consumers instead of NTB DMA consumers.
>
> > diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
> > index dfd175f79e8f0..b936f15079df2 100644
> > --- a/drivers/ntb/test/ntb_perf.c
> > +++ b/drivers/ntb/test/ntb_perf.c
> [ ... ]
> > @@ -869,6 +869,7 @@ static bool perf_dma_filter(struct dma_chan *chan, void *data)
> >  static int perf_init_test(struct perf_thread *pthr)
> >  {
> >  	struct perf_ctx *perf = pthr->perf;
> > +	struct device *dma_dev;
>
> [Severity: Medium]
> Does this patch miss a replacement in perf_dma_filter()?
>
> Right above this hunk, perf_dma_filter() still accesses chan->device->dev
> directly:
>
> drivers/ntb/test/ntb_perf.c:perf_dma_filter() {
>     ...
>     return node == NUMA_NO_NODE || node == dev_to_node(chan->device->dev);
> }

Can't simple replace it here. Following patch will handle it by add
new DMA Engine API.

which require dma provider device to get dma channel. if return per channel
device, will fail to get dma chan.

Frank

>
> Since the goal is to prepare for making DMA engine structures private by
> abstracting chan->device->dev behind dmaengine_get_dma_device(chan), will
> leaving this direct access cause a build failure once the structure is made
> private?
>
> --
> Sashiko AI review · https://sashiko.dev/#/patchset/20260918204152.2364336-1-Frank.Li@oss.nxp.com?part=1
