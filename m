Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020139.outbound.protection.outlook.com [52.101.229.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34AB361950
	for <ntb@lists.linux.dev>; Mon, 28 Sep 2026 05:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790573762; cv=fail; b=H+xJs5tKGyZoD0tbd5rk/idp395vEeBYgTK0UHfjKmqhk/VHkA1T27nJNCE6ty6ldHy07P70qXwrd87p1feM/FxOqWwKW4O6e2hNLLZL7Xgoqtpyy4VDObNEhkQ8K0hctiOY5EBnwwuhBQdKq278jgIRXbVkOtuvpCaDoaV4b5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790573762; c=relaxed/simple;
	bh=Ozx2Tc+OFwTiK+BEb1ZYNzG61ebCQJ8isJ7Z5M/ZFts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZmzUjjty2436swHB660uwkYRJkXbjMv4jbm/nRdRtU/ovfX3+r5xWmiJoH9XR6axIuMDn28TkBIbI6vDDt8Yol82vvrcsP2Z+ne3Z65rJgInwczlo0CmdurVFOsA4kB3G37OaBgi9BVrtAMmzztd/o502pQKCmCoz3CfiOFzm6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=qo7fOwUK; arc=fail smtp.client-ip=52.101.229.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="qo7fOwUK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dErn31aOBQiZx3DlLnHONQQHYGohAsuZ3VwDp8EnfEYXTo/9fWL4WmpQ0ViCHlXnM2Bov91fdc+91HI02GDdU8MRDte5SEb1Z1kox70QFBgYnm4seR7/gUfDKn046Ka3/JmrIUiRpOlGX+vyFFNQ4GdE2lXGlanKQstqdOXdVywwsPgJfYoKn7cCvrjqhv2XK4/PjpNPILQj8aq9nkO7MIMe5ubEL1wz1i3AqnKsVpPS+dk1t9D/pyUfN7SQYcLOFRnkVc0XVbZbdPSDFQUj/93z4ab1P61Kq/Xkz1Qe9FiQVAMVu+/1pS0MvKKgTurPFBeZQbr6YHKxMxyHoIMlXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2N7mVPqIvIp7m8g/K/37VsHx9pi5T6kdt8gCXbUPE6M=;
 b=yqAq8vyWHHTR6xpPlXIueOs60uNZkrU8p8CvIT5ITEiwn4Q/GKd4F2nxfl8luQhGnxlYKRs1+BaG+MKZbV6L+H5tw8fCeLayAmslcNuwCNX1FFuT1HPxFI/XsUSMUd5Mio+E69jvs+w63jwo5sx6by/8DyAywjr0DNGmzj9aQMu/hEUupHlc2OuFq5DyoZ08gTgKTQmKOObuLmKuSid67UoDPrz7WVPw6d9ZSVHKoCKoweaQl8Z6LZ7mpCbULlRCWPuLNyMxuXlbeCmEa2JEQzosBA5vePi2i/wJ+lnZ45VFkSqZ2nDnlQGdN67zvWB1xLnTrJYpsafYJ+F/FHvZ6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2N7mVPqIvIp7m8g/K/37VsHx9pi5T6kdt8gCXbUPE6M=;
 b=qo7fOwUKa0rW2LMker1s4Sf7SYg5pbDq0RidoiCiA1iOzNMz6PFum5CUdcsE9uPeCwwPcz7ibMyrdVsVYXPksS60tZKVU3NuPz+E1+ISnHjwm71+hs/fYOSD8bim8VlBApcZlnm0BWs1Q+AQrlFctOKYL6z2baanOQ1tdnxRryM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYYP286MB4094.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:154::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 05:35:57 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 05:35:57 +0000
Date: Mon, 28 Sep 2026 14:35:57 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>, 
	Frank Li <Frank.Li@kernel.org>, Logan Gunthorpe <logang@deltatee.com>, 
	fuyuanli <fuyuanli0722@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Nicholas Bellinger <nab@linux-iscsi.org>, Joey Zhang <joey.zhang@microchip.com>, ntb@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 12/14] NTB: ntb_transport: Clear QP pointers when
 freeing an MW
Message-ID: <vqooat7xekgls24ew4xewp5bkrw7zi7vsycn2bvz46i6xh5yf6@djsb4pvsaz7z>
References: <20260910040836.3792333-1-den@valinux.co.jp>
 <20260910040836.3792333-13-den@valinux.co.jp>
 <f1da1904-a05c-4fe0-95a2-9abdc44bfebe@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1da1904-a05c-4fe0-95a2-9abdc44bfebe@intel.com>
X-ClientProxiedBy: TYCP286CA0014.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::8) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYYP286MB4094:EE_
X-MS-Office365-Filtering-Correlation-Id: bab33e31-0019-441f-73cd-08df1d225f72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|10070799003|1800799024|7416014|376014|4143699003|56012099006|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	ZC9v6aUajwEsaHvYVsogwy1qItBx8nADllTi780Dvzl937kDKCQmNkm3W2c+0Ts6Km29Zrz08EH0gb6qZ8YFsI0GTk9yyxWN4ip1t8KdaiNr+GeCL+F8kiLyWCoL2K6yfXc11ss4lcimk/dnJmsF6ZELc300Zi8v+OvUKrNxZPcJe9fmmAZqYHlJQFNZIQqAMUv1aiqv7Wc7hBajcE3U2L4rJJ/Q32OIDixGwMbzGgDnAvyVj/BGre6+wE4V3NbiZ36q04x0TmJZGzi0Bp2B8SualVsLo8y9oNm9fD/bXErO2ZcgXlVbkwNnxRGfs7tHlT3asV39gqi0sAgaL+vZLmYoV3hY1slVSNudPiS+dwWCr0kAUv266ubBGVivgSgjdgkZRX8FmdO/jd05EpnZ8Onvj3SGtP0/ppldr6zYA16I4tI8xCjIfvZABz5pd2YC1uj5T7W3CIvWvQe1FIxsVAy/AGwR7TWF2N4MOZCZ8TXfuMK03F8erZqDSh1RS99AxFWjyopjdLEdU5UJbBEoynceaS7b6I1Nvxb5LLLnR91KhMyTkN4nyyH7MLpD+Mof88Mek4NQJNpdzXYoHAy1VMJ50pcrkqzE4x0O6SGIpjLO1E+ebUmwzKQKoKa7IqlveUWh+CFhacSRuauMMk/cOod4xbRmtmxX2DaZbj4CGh0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(10070799003)(1800799024)(7416014)(376014)(4143699003)(56012099006)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CXsGr/UffYAgqHC5gDf6VxaX0qvmhJtU0mtXacxneykkKUa0LYFPLxybicKP?=
 =?us-ascii?Q?55n+gQAHnv4WaYTdHqpZa37RVaI9U8UYXHyrXZHjTrV/FWGAyEd8ufXWsntO?=
 =?us-ascii?Q?bWkRLnyROziONpaLpQZs+tnh7vdCoPcfdFdU/GMzcbNGJQwXwrSjQD2kG+O+?=
 =?us-ascii?Q?1ptLF17J7ny8u1o+EHffOhLVc4ZPAkvhRS4FuMwgSRqhB7bko5f/nNL9nAes?=
 =?us-ascii?Q?g7twxXrwUc6MDSgYGFxNrAK55kIsgVCckfevitcEZr8wvDfxl+PU5qN3jtHU?=
 =?us-ascii?Q?oB3Wp2aIP9mbp7OzrK6o+A7kaB/Al7VeOUjvGH/IxfMaXRDTYMeREK1Ruq+g?=
 =?us-ascii?Q?LtoNFK5EPxg1pFVLEQLw1Czhy5KddRcNA2n3/92dTkiReMOL1Zh3WpOeRKll?=
 =?us-ascii?Q?06hndWJYHr+bh8dGcFVMizia64uOIwFXe4OYDICB/Sh8sgEOCgaGNwhUjSe1?=
 =?us-ascii?Q?wx+jZ4Xy88vGnqV/DzQ3LwJpp7OMQzyoiDLW7PdRrvkQPKo+cMh9s585ou6i?=
 =?us-ascii?Q?nV1NEwxpE73pADO8i6h1q3RppfZ/Yl2UTAj2tU3JsZaHEhlAoXVeh015mEfh?=
 =?us-ascii?Q?OF9f6CbXtQEqMmaFbKPnB/revTwU7vJsgpZe6wmTS2J912vSkPLw+YIvO0ew?=
 =?us-ascii?Q?yIaZ3EfYliTJfPnmzEZ2OEB1es09hjFxx3mWPGXr97loiGlzECdSLybyhQm6?=
 =?us-ascii?Q?ehI9gzm54L5WGdEcUNDFpqP/mncaKvXq0S0709UmwUvvngRAO4Sfr1vozMev?=
 =?us-ascii?Q?N4PJXbrGNX8UYDiJs/JrdaZHyeQ8WX0VOcrDHy78F+2xMqVynMaXAOv6FkqD?=
 =?us-ascii?Q?/jM4aY8m/kXxhj2QagGW16478CO4hD8w+TYAOSjU2do04MSTf/5V1O54ZSEU?=
 =?us-ascii?Q?G5ekO2VLauEXiX2D6noQMSPTCcKLSLjolOgYwLCWzgp1DuvgEvRkB34O1CWY?=
 =?us-ascii?Q?jlSkhJhbUTKQMAEMekES/gUqMocY+1u1V1DjPnlCHiNY4asVyv33533ZU4M8?=
 =?us-ascii?Q?2Zhusn4bam4er0jYMni5dnK0KsvyG+fFguVZF+NVF6jlIIIDVcDTPFN5DDXG?=
 =?us-ascii?Q?KmNFtjQGCeBdO6ZoBwNKaGaCtFqrskxeynEp0lfvVCe1aTtY2V1kZOFfDAw3?=
 =?us-ascii?Q?iuNr3ppzc3Km5Gix/s2vPHKFgSgdlozEzKe+WP0z0SJoYhBy6UOiXcFws8KD?=
 =?us-ascii?Q?X9FstxUmWPf6j/trZldIc8jc9abhG6LOwJYN/x5NGv3KLhsCl6ImakJapxFa?=
 =?us-ascii?Q?P6mIpHifdF4ScXbSVDFeFpAIpEft5/GSFiEo9v9x3ol4/ZIp2MlVGgNRtfJQ?=
 =?us-ascii?Q?QPuXtJAWy6AeosVf4A+P5RdGCoMacKYDqQVoRUb67NSFGf5pxDuqxOOfZN6y?=
 =?us-ascii?Q?pjbdImZYRCjAw6JUY3IVHMPQCawf5RLwYfQilDESkGwpb7azZgj405+gPbNf?=
 =?us-ascii?Q?gVYFHV0f8cAbXbMOXSWTP8I2VhGVD2+dtRl7J/jZsqx8C+ShAY1SZWUGnG2H?=
 =?us-ascii?Q?DZbG1rLmclAg8mseD9rrKtswhXRsGDvvYol8XjXvcqFpgDRkPDlWv12jZyIG?=
 =?us-ascii?Q?9rO2ocVwctunM6WoXCFXNmNgQRupiXBjLO90tvVaOcdkoBv/TXmaW5YP7SWV?=
 =?us-ascii?Q?mjiqfM1fPt6PuD1tdk3ByKQ/gbsEn4saoZGkm6rQUVOnn5bmkcvae1IiibDm?=
 =?us-ascii?Q?tlo08apSe8gOxRw3f33xi+jULVngmdmph5QAqrNkZAqbkzHyRo0TiwoZGZvu?=
 =?us-ascii?Q?TEIhuEtkSCjXN5xXhKOCrvQlUdlmv/xCHfC5BuRJfXBFWpWQRw2h?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: bab33e31-0019-441f-73cd-08df1d225f72
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 05:35:57.8568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5L6+nbOjrQb5uTB0K/BFM9HYToxMs3t6VkkmGmazY1R/wgPUBNHcOjpfnDZKoUdETLfPQdIxv2V8O+gstsRz1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB4094

On Thu, Sep 24, 2026 at 08:59:56AM -0700, Dave Jiang wrote:
> 
> 
> On 9/9/26 9:08 PM, Koichiro Den wrote:
> > ntb_transport_link_cleanup() frees MW buffers but leaves rx_buff and
> > remote_rx_info pointing into them. With a QP still allocated, another
> > link-down notification or transport unbind before MW setup runs again
> > can make ntb_qp_link_down_reset() write to freed memory through
> > remote_rx_info.
> > 
> > Clear both pointers in ntb_free_mw() for all QPs using that MW,
> > including those without a client. This also covers link-setup failures.
> > 
> > How to reproduce:
> > 
> >   1. Load ntb_transport and ntb_netdev on both sides and establish the
> >      transport/QP links once. Stop traffic, but leave ntb_netdev loaded
> >      on VHOST so its QPs remain allocated throughout the test.
> > 
> >   2. On HOST, unload ntb_netdev and ntb_transport, leaving ntb_hw_epf
> >      bound:
> > 
> >      modprobe -r ntb_netdev ntb_transport
> > 
> >      Transport removal sends COMMAND_LINK_DOWN to VHOST. Wait for
> >      ntb_transport_link_cleanup_work() to return on VHOST, using a
> >      function-graph trace. The "Link Cleanup" message is printed before
> >      MW release and is not sufficient to establish completion. Do not
> >      bring the link back up before the next step.
> > 
> >   3-(A). UAF via repeated link-down notification
> > 
> >      Use ntb_tool on HOST to send another link-down request:
> > 
> >      HOST# modprobe ntb_tool
> >      HOST# echo N > "/sys/kernel/debug/ntb_tool/$ntb_host_dev/link"
> > 
> >      ==================================================================
> >      BUG: KASAN: vmalloc-out-of-bounds in ntb_qp_link_down_reset+0x2c0..
> >      ...
> >      Call trace:
> >       ...
> >       __asan_report_store4_noabort+0x1c/0x28
> >       ntb_qp_link_down_reset+0x2c0/0x2e0 [ntb_transport]
> >       ntb_qp_link_cleanup+0xc4/0x148 [ntb_transport]
> >       ntb_transport_link_cleanup+0x314/0x350 [ntb_transport]
> >       ntb_transport_link_cleanup_work+0x2c/0x50 [ntb_transport]
> >       process_one_work+0x5b8/0x12f0
> >       ...
> > 
> >   3-(B). UAF via transport removal after link-down
> > 
> >      VHOST# echo "$ntb_vhost_dev" > \
> >          /sys/bus/ntb/drivers/ntb_transport/unbind
> > 
> >      ==================================================================
> >      BUG: KASAN: vmalloc-out-of-bounds in ntb_qp_link_down_reset+0x2c0..
> >      ...
> >      Call trace:
> >       ...
> >       __asan_report_store4_noabort+0x1c/0x28
> >       ntb_qp_link_down_reset+0x2c0/0x2e0 [ntb_transport]
> >       ntb_qp_link_cleanup+0xc4/0x148 [ntb_transport]
> >       ntb_transport_link_cleanup+0x314/0x350 [ntb_transport]
> >       ntb_transport_free+0x68/0x588 [ntb_transport]
> >       ntb_remove+0x5c/0xa0 [ntb]
> > 
> > Verified that neither test triggers a KASAN report with this patch.
> > 
> > Fixes: cc79bd2738c2 ("ntb: Clean up tx tail index on link down")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
> I would move the full reproduce details under ---

Sure, I'll move the reproduction steps and traces below "---" in v3.

Best regards,
Koichiro Den

> 
> > ---
> > Changes in v2:
> >   - No changes.
> > 
> >  drivers/ntb/ntb_transport.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> > index b949f36a4f2d..096be87e5ede 100644
> > --- a/drivers/ntb/ntb_transport.c
> > +++ b/drivers/ntb/ntb_transport.c
> > @@ -781,10 +781,17 @@ static void ntb_free_mw(struct ntb_transport_ctx *nt, int num_mw)
> >  {
> >  	struct ntb_transport_mw *mw = &nt->mw_vec[num_mw];
> >  	struct device *dma_dev = ntb_get_dma_dev(nt->ndev);
> > +	unsigned int i;
> >  
> >  	if (!mw->virt_addr)
> >  		return;
> >  
> > +	/* Drop references from every QP using this MW. */
> > +	for (i = num_mw; i < nt->qp_count; i += nt->mw_count) {
> > +		nt->qp_vec[i].rx_buff = NULL;
> > +		WRITE_ONCE(nt->qp_vec[i].remote_rx_info, NULL);
> > +	}
> > +
> >  	ntb_mw_clear_trans(nt->ndev, PIDX, num_mw);
> >  	dma_free_attrs(dma_dev, mw->alloc_size, mw->alloc_addr,
> >  		       mw->original_dma_addr, DMA_ATTR_FORCE_CONTIGUOUS);
> 
