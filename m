Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020098.outbound.protection.outlook.com [52.101.228.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C492336C5B4;
	Thu, 10 Sep 2026 08:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789030142; cv=fail; b=iJcHTVk3eZK56wACnGaTDBRNazX+TbUAaYcrPOoNH8D8UEEHP7t8OGXrCgO9lwKJwfcy+XwjlOGYyVomqYGC1HQZOGdRpKW1bsPSPZXnhXkJd9a1l/l+BiuOIab+kHFCJXsY0k3v6su5kc51XMpL0KqX781X5YxDnSEI1U2cUbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789030142; c=relaxed/simple;
	bh=DZRJjbZmNQoG4nIFQVYLspT5haXq9DAN41Uj+HXZTJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YYF7JnvLtW8bAff2nN82zllWQXK/Uix4Kn9ll/9O9QE8Cp+FmIXlRKo5zm8PZKMTOXvpeyoo7FfodYlSEBfgAssrdBsQmElXdHDEIN+SnYCAVdE9SWMsdnTLgwV00cprAXID204lUer3v/R6nSBO/yL8bAL5npWIjOoumWIERek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=fail (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=XUo8iG8q reason="signature verification failed"; arc=fail smtp.client-ip=52.101.228.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="XUo8iG8q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EQ/UQ/VQ/+TDuetqKRiossmBnV1DfEpBxt+zN/BVqmZCf9s9SlYSWBtEItGwk2fEqDb7WpCaEy0mqiZd2WkVCNVXv3Q8ERkAKKqzkT7b1BzNPrbR6X9vHij//sod4HhxHyxZYYGGW4tOzI+rs/Gs28NV2i34KtJ20uY7EGvP3NR0IPVHEhXN3aBEWsNDTI466CsfqE6WdI/DLY8hgrQyaSgJiF2KeGXM92GMzqM5T3h8UfcAkrTdoy9mY7sne7NrXPpV3GWmd1R/usZx35A67zCh+8zTP07bBX+puolmMx/9j2LeytFTA60yIsxDd6H/meR3t8RmJ0/kzZywGP3Emw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KE49ehzQHIzbV0MMnQfSesylAf+2pDG48m333y4WNiY=;
 b=Q6egos3dT5lg6WvLNDFHfkZqbEtkV18yDgAFWBu4Lu5P+CyBBvGI8cA8y5BxQQP2K8nxJZ3+1xghNSXRFGhCcGMQnhkcxHhbcRs9TCzg1Iffr8qVdu7JYHJqUTgkLIvwebLJvXmqbJwZ6nS0+Kg2/PU1uQwfBjsQ0EjOmey/mpAMJTHWQDqoVqK9nmsn2MuCC5t9VgY0g0WmLXfOJRQjx+de0gJzoYwOU+iBpSo4ufTPxMD97Um/K28QiJ+FTrFDvpYq9M5H1Ua8kqN2uGxtnXTKY9X2ZGiEnMctgxtAJL/XdR9fINjSR2KDjHI8nGo6odOLYP7Bp+MMOx9ghLZPEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KE49ehzQHIzbV0MMnQfSesylAf+2pDG48m333y4WNiY=;
 b=XUo8iG8qTG1MX9nowna3DYyiZXGpNJxW5+AhkYaG+z/CO4torz+3nopbc1c8KlW58Oj1zbk4BRs5X0UT62KPo7rUrvwTQKdD1lk5IsOAlTIDpfxwrMEBt0i1MCNnsnAaLEttEH7Wunj0FKZrXuRYsyKur7+Qayn8CWm578e3GDs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY4P286MB5472.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:262::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 08:48:49 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 08:48:48 +0000
Date: Thu, 10 Sep 2026 17:48:47 +0900
From: Koichiro Den <den@valinux.co.jp>
To: sashiko-reviews@lists.linux.dev
Cc: ntb@lists.linux.dev
Subject: Re: [PATCH v2 14/14] NTB: ntb_transport: Remove clients before
 freeing transport resources
Message-ID: <pao67m2xtpetoj2mpqzuvftzdojoj65kqpbg6alqsdqrwozm2t@hdojuk4dsh5k>
References: <20260910040836.3792333-1-den@valinux.co.jp>
 <20260910040836.3792333-15-den@valinux.co.jp>
 <20260910043613.CE8FD1F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260910043613.CE8FD1F000FF@smtp.kernel.org>
X-ClientProxiedBy: TYCP286CA0087.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::18) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY4P286MB5472:EE_
X-MS-Office365-Filtering-Correlation-Id: c7127c79-093e-412e-0386-08df0f1854ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|366016|1800799024|376014|4143699003|10067099003|6133799003|3023799007|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	7aZ669Fk8fCAkmRu0rdAX6aC7AC+73aaa/XZjVwEo6p5o+5HjfDGbt658An6YPRwsSIFH2Org5TkaBZc0ZZt52lLBRNbJyiteA4JLBdhsDlnjI1RbyAOGrvGB9b1HIevBg2pmJ1QRIu287TtwWuaPWDEFjH4eXfk+eDrUJI+fM4I5I1XyXoq1lu2eIJqlxn2TdwJ0Px0okHCwdjiVhAbOaUzrRoc3Gsn+WwS21+jhzy1izgJuPzMx9htUPyrg2qAMpucJIYQZNml1rk1sKfYqOhwZlayEcRhQAv7Pwtt9gXQEl09I6+rKN0YvLTy+ZgQbPUuIkH94Bf0BSvlKHZI7knA05tsRTsNm+kMqMeCNi0DSI32r1iekE/nI66t3HcFrRibpO3coWOyK3alw2Js7PATNAsXFxziRkOAfnUps3LGaMPZ1GCZKybeo3LywkTPToSKfqXxs4r8n9HsVuBDX+GGTDyvI7YOK2ue1bDKE4527k/ykd17e+iCJRGFsTnUT/jlvFPQLPWqyIpx5TZicb0UQgvhMU5ElYfqccOgZ/rkOzxby66X3bJ5vRwdxD8Ztd8hW6QjJFBeojlmmaxu3VbwM8gS9PjqPpG2W+fivAw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(366016)(1800799024)(376014)(4143699003)(10067099003)(6133799003)(3023799007)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?dgA39v/NUbcVO86BWDiuRJaSmUuc74KabaMoEwsS6zWMPwnB5ObtnT32Fv?=
 =?iso-8859-1?Q?ydNPdfGLRgKm0qBfFN3L9zcw8oiWV72X9/uNOAav87su7YbYWEDwT4b2dW?=
 =?iso-8859-1?Q?5Sg/oCqEplITAOqrw5dkS8vXwI8ycfVKiv2cIuKADghzBj634MsjaqpHxI?=
 =?iso-8859-1?Q?ijlfP9Hjk7w+8og/onVB3D6CzR0N12OngRh1Wt6GGQRFIHG0sBMvpnk/4l?=
 =?iso-8859-1?Q?uzc/6lLeV+kW3k+OYjXBidS7303u0usdJNd/n6H3NDzgloWvEVfbY1EBu4?=
 =?iso-8859-1?Q?qhS3jp2VmLWecErYUDV9N9ZsFhgojLtZMAxecz9OfaXQwvIZg/674xnDVC?=
 =?iso-8859-1?Q?yHrb/ZgJwwHVgbzjKSmZR2Wk/5nQl2g06F4WrnKoT2l3m81Vy6r2qLsexr?=
 =?iso-8859-1?Q?HUZq2lFBy6axWqReuc+MRI71SZKQWTwebNQ29OjiwPIqIScL/7SWTpoHxW?=
 =?iso-8859-1?Q?0L7TFX6r8NXx31JVBmXiDkgc9lCRdxQt+5fgy8lDkN9OGxQCvvbJiuKvaH?=
 =?iso-8859-1?Q?ncXqZBVlT4SWhFuqg4C8wODitKLVQRzWyJ4q3gRTPyoN/JO+re9Wf/27QB?=
 =?iso-8859-1?Q?LKsIuuXP+xhYMWd6QaxXZgZj/oO/QZTK35rh5U072hVnt6YPFTLDBc+QOE?=
 =?iso-8859-1?Q?USza/eCEnKbjYBDzNAGb8QyAgbq050mCPEIPQ1veUdhcsHJ9n05fuwps7u?=
 =?iso-8859-1?Q?BPQKu6V9xuHm9dQEn3zBUuYCRp9Vs62rZoBTRpoxKwYqSXOok/nlPBMlht?=
 =?iso-8859-1?Q?YTjgkMpUY+YNgMBwzLuy0nMAxionfneRWMZTJzdCNuKRx6gMKqmfcbONyU?=
 =?iso-8859-1?Q?o6acZAAWLOex2M3raOFu/OBtcaNsBKRn0lBLUJDeONccHgutN2aArEsIAl?=
 =?iso-8859-1?Q?cb5J8Z5DpJ3xX4+7bqJhz6zRhT97LpMjVXu6b0neVH6i6aPvQtlKF1v9uF?=
 =?iso-8859-1?Q?k3DwzdGkCMwOzAL/4nKE0Jadz/uvyRw69fgOVdPnjHo1NoHd6lylnw7mEk?=
 =?iso-8859-1?Q?hmoHwXydn4JQqo4sLpQONvQeGLvGu23UidjJ80Igk67iEemepN+zLUaWmy?=
 =?iso-8859-1?Q?22QdSlXnW3qRdylODUFjD4JepLgqD/i4iGbc0tf94OqZQQltos+fsA7w1S?=
 =?iso-8859-1?Q?rBdTEL6YgmgiAm63E6/pTgpolLR/5LQ9ZIV2iht15w8nYvYPsXxc7y7U+d?=
 =?iso-8859-1?Q?WQ4j9aeS1dhDu7jSc5BWJkyXm6WObYhbOg8elP/dxlPzz2jK7hr+NpBWk3?=
 =?iso-8859-1?Q?QhlWNEzPgW9yPeX8qkWLoNNFiVFBG1WvcP9EDQCWLiVwRAt0xHXZAwwysU?=
 =?iso-8859-1?Q?RAB+m4qBT0GujxtAVvdj64/Fyez2BH65ch3x3M4Bdf/KU0OJubEoHn3A6B?=
 =?iso-8859-1?Q?LgaxkZkjX2DEbQ60mPL01Ic9pEg6z1bzpDqlY7BGyfEDsMFEW+7+rdZY+j?=
 =?iso-8859-1?Q?aziJoGowDgR+a6ar4QzrYL0SiEzcyeV0Eo/bxBxmsNRx25PHT6OAiLiKbU?=
 =?iso-8859-1?Q?MgDwwbfvnKNZmoj1huiG+1rDQwLvwiaNobfInVBwl3eR1/MxQUlywaQ+3P?=
 =?iso-8859-1?Q?KioQTfXRlalWmKNBNrXD/ndDN70twBioranY1d6ZQb0PQsWMZ6tWpbshv0?=
 =?iso-8859-1?Q?ZXE8ws5rO1WKPbDqY8P5rzAZIOhSEMc6WqA/P7BVEc73G9pexG0Maf2+zK?=
 =?iso-8859-1?Q?aeFnfG5tXCdJcO4bhNy7AiUFpveNMv3iVkxV5ddw1vO8UToAN5bv3ZmFcP?=
 =?iso-8859-1?Q?lxiTQKwO45IZs0IZSpMjrAjZOTK92SsFMIAy8Ikt2XtBhyftvRc9OXERzG?=
 =?iso-8859-1?Q?Tmn222VGq9Uq2YiskUaCOar76t/1VD6tDJZ0CylwQNlI9y0kuX0K?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: c7127c79-093e-412e-0386-08df0f1854ea
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 08:48:48.8977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w/zJt/3DKEVH0hh8sVBXLHDD8bisyJlCeRW2EStE87BhyaNegcrWidm36H6YdSGKkS1XY+zRwb/M4f5H4ITZxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB5472

On Thu, Sep 10, 2026 at 04:36:13AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> New issues:
> - [Critical] Skipping ntb_qp_link_cleanup() during transport teardown fails to drain rx_post_q, causing freed memory to be accessed by in-flight IOAT DMA.

I believe this is a false positive. See my inline comment below.

> 
> Pre-existing issues:
> - [Critical] Double-fetch of `hdr->len` from shared memory allows buffer overflow via TOCTOU race.
> - [High] Racy read-modify-write of `qp_bitmap_free` bitmask allows queue state corruption.
> --
> 
> commit 68ca6cad9a88600dd4607f3c4ccd6bd32385b0e7
> Author: Koichiro Den <den@valinux.co.jp>
> Subject: NTB: ntb_transport: Remove clients before freeing transport resources
> 
> Unbinding ntb_transport can call ntb_transport_free() while ntb_netdev
> is still bound. This patch reorders the teardown process to unregister
> clients before freeing resources, intending to fix unsafe memory accesses
> during intensive TX loads.
> 
> > diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> > index c1e3a077c45ec..f24555b38d1b5 100644
> > --- a/drivers/ntb/ntb_transport.c
> > +++ b/drivers/ntb/ntb_transport.c
> > @@ -1487,9 +1487,11 @@ static void ntb_transport_free(struct ntb_client *self, struct ntb_dev *ndev)
> >  
> >  	debugfs_remove_recursive(nt->debugfs_node_dir);
> >  
> > -	ntb_transport_link_cleanup(nt);
> > -	cancel_work_sync(&nt->link_cleanup);
> > -	cancel_delayed_work_sync(&nt->link_work);
> > +	/* Stop transport work before clients release their QPs. */
> > +	disable_delayed_work_sync(&nt->link_work);
> > +	disable_work_sync(&nt->link_cleanup);
> > +
> > +	ntb_bus_remove(nt);
> 
> [Severity: Critical]
> By moving ntb_bus_remove() before ntb_transport_link_cleanup(), does this
> introduce a DMA use-after-free regression?
> 
> Calling ntb_bus_remove() first prompts client drivers to free their QPs via
> ntb_transport_free_queue(), which blindly frees all entries in rx_post_q
> without polling:
> 
> drivers/ntb/ntb_transport.c:ntb_transport_free_queue() {
>     ...
> 	while ((entry = ntb_list_rm(&qp->ntb_rx_q_lock, &qp->rx_post_q))) {
> 		dev_warn(&pdev->dev, "Freeing item from non-empty rx_post_q\n");
> 		kfree(entry);
> 	}
>     ...
> }

Yes, but ntb_transport_free_queue() calls dma_release_channel() before freeing
those entries. For IOAT, this goes through ioat_free_chan_resources(), which
calls ioat_stop() and ioat_reset_hw() to synchronize callbacks and stop the DMA
channel.

I believe Jon and Dave know IOAT well too, so I'd appreciate any comments from
them. I guess the mention on IOAT in an earlier patch in this series prompted
Sashiko to focus on it here.

Best regards,
Koichiro

> 
> Because IOAT DMA engines could still be actively copying into those buffers,
> freeing them allows the hardware DMA engine to write to freed kernel memory.
> Furthermore, the DMA drain wait in ntb_qp_link_cleanup() is subsequently
> skipped entirely because qp_bitmap_alloc evaluates to 0 during the later
> call to ntb_transport_link_cleanup().
> 
> [ ... ]
> 
> > @@ -1736,17 +1736,17 @@ static void ntb_process_rxc(struct ntb_transport_qp *qp)
> >  
> >  	if (hdr->len > entry->len) {
> >  		dev_dbg(&qp->ndev->pdev->dev,
> >  			"receive buffer overflow! Wanted %d got %d\n",
> >  			hdr->len, entry->len);
> >  		qp->rx_err_oflow++;
> >  
> >  		entry->len = -EIO;
> >  		entry->flags |= DESC_DONE_FLAG;
> >  
> >  		ntb_complete_rxc(qp);
> >  	} else {
> >  		dev_dbg(&qp->ndev->pdev->dev,
> >  			"RX OK index %u ver %u size %d into buf size %d\n",
> >  			qp->rx_index, hdr->ver, hdr->len, entry->len);
> >  
> >  		qp->rx_bytes += hdr->len;
> >  		qp->rx_pkts++;
> >  
> >  		entry->len = hdr->len;
> 
> [Severity: Critical]
> This is a pre-existing issue, but is there a time-of-check to time-of-use
> race condition in this bounds check on hdr->len?
> 
> Since hdr points to a payload header located inside a memory window writable
> by the remote NTB peer (shared memory), hdr->len is read directly from
> shared memory twice (once for the bounds check, once for the assignment).
> 
> Can a remote peer swap hdr->len to a much larger value immediately after
> the bounds check but before the assignment, bypassing the bounds check and
> causing a buffer overflow when copied?
> 
> [ ... ]
> 
> > @@ -2130,7 +2130,7 @@ struct ntb_transport_qp *
> >  ntb_transport_create_queue(void *data, struct device *client_dev,
> >  			   const struct ntb_queue_handlers *handlers)
> >  {
> [ ... ]
> >  	free_queue--;
> >  
> >  	qp = &nt->qp_vec[free_queue];
> >  	qp_bit = BIT_ULL(qp->qp_num);
> >  
> >  	nt->qp_bitmap_free &= ~qp_bit;
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but could this read-modify-write
> of nt->qp_bitmap_free lead to queue state corruption?
> 
> The qp_bitmap_free bitmask is modified here using non-atomic bitwise
> operations without holding any lock. It is also modified concurrently during
> driver unbind:
> 
> drivers/ntb/ntb_transport.c:ntb_transport_free_queue() {
>     ...
> 	qp->transport->qp_bitmap_free |= qp_bit;
>     ...
> }
> 
> Since these are exported functions called by NTB client drivers, could
> concurrent probe and remove operations race and lose bit updates, leading
> to a leaked queue or two clients being assigned the same queue?
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260910040836.3792333-1-den@valinux.co.jp?part=14
