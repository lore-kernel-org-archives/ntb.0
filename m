Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021091.outbound.protection.outlook.com [40.107.74.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6323BB57;
	Mon, 14 Sep 2026 04:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789360066; cv=fail; b=Dzq9hvi/e/pfSHdSCRQPNUjWLg1qxYhiLvYxW17Fsit/xzaBrCmvWls99d9Up7aa4yvTcqeqcd8M/ivYjEWtJMVF+YWB64Ltf8jR0zJ60YzA+Vx8OKhWvIeaS4gTHJFe4tl4JVK4RLIu0+Kq7FUmJRuRgwlkhlbSsz1swrC/VU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789360066; c=relaxed/simple;
	bh=cW0HzYEsXipVlSUau6vxFSGZfWo2ahmBt4Nz6aPmFb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AMOad2eJw/ZxEF6itaTebHYDs+JG0j/tqUaib8nxPbS7/mWm0rDP8itYh76btZep4kxLt4dH5U1wr4g1Ey41uq3g5CQPd7NuEfPpfv3PrhzT3FiU5c1HP4ImdYD8Y64311eKqm8G4juyAcFVr20qCnz3UkDwN7cvdUU08E1hvSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=fail (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=a656QcVg reason="signature verification failed"; arc=fail smtp.client-ip=40.107.74.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="a656QcVg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HH9c6C+/pq5zVM/A/FqnkXjB9TOTeBaLpZz7zzQbTngLqvBpJAu0MefNkjP9BeO4r7kmHbTZr1jC6/jksJmwg/1Y/8cGhiawX+TCSN91XBSbVNVr1g7+eUBs2OQb1XpZLPOWJAO18cRx77JWIDgkY0cqiwX82hTd/s2GTNzbQJx9gcqsrDJkWqpaA2yXsV1h6QrPF3dQ0yj9joa0UT8ZIENBXWq5dgU4+0dWddyepT4r6H/+ZOQNjGn6+695+o26EQhNVJ8dKXmLJWWsq3XsRTreF86Dqvzez1AOu88PMkX6Goa6Erra/fu2uwV9S3A7vBwiGAfCACmb3WmGfGvBMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2IdNYR7/gUPhhW/u9yN7+CYWRfBIYx6NK39yXCMdcQA=;
 b=ym9xHFgFkzaR7aCNJKGTTWtnWIdguU9Z40jz4geXFK0xg11JAQYg4txQp2EDP0oDQP7jr5j2dDO5xTA6fwWQROqy5vxL1EyVGk4wNezoPoD9HnMOzZxOOW47qyuLOlxJiueJMGT7T+4xo+R5aBRSgGqp9xcAO+BXQqPyymPCmPvIf2nAJchO6JclRa3QY4hQ7HD+Fm8Ub4t74KltUlHlMrTQJIO+0hnNLPDwkqSjNf8ClSWPegyH7RChhMx5q/HJLj/rss5BNP6RwMCJvT4NOx9l+qB+7UHh47NciWFo+Vet21ovSTUwgUCStA1fMccbG9Gqr24K/6af7QxszmUVDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2IdNYR7/gUPhhW/u9yN7+CYWRfBIYx6NK39yXCMdcQA=;
 b=a656QcVg0GRqKsM9G6VdGPyAV+1cMiabnEvRgYPsy25RNXML2i6+h40s2ZvCmXt5HSwkq6Ud15aUsnM6p9rpn9C8jObdf2RSWjZktqWePYyZB3Ti66U+MnEaN8Fus41Jzs5sZgHHho5xttf5dbOCu2wsyxZujkXi9bh+wAneV+Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:468::22)
 by OSCP286MB4903.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:344::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 04:27:38 +0000
Received: from OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b7ab:6af2:d18e:4a71]) by OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b7ab:6af2:d18e:4a71%4]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 04:27:38 +0000
Date: Mon, 14 Sep 2026 13:27:36 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Dave Jiang <dave.jiang@intel.com>
Cc: sashiko-reviews@lists.linux.dev, ntb@lists.linux.dev
Subject: Re: [PATCH v2 14/14] NTB: ntb_transport: Remove clients before
 freeing transport resources
Message-ID: <rtc2lb2iic42wuqtcjxqqvvyxcl535x4iv7uxhvkk55o3q5ire@lq7eukkl4aaj>
References: <20260910040836.3792333-1-den@valinux.co.jp>
 <20260910040836.3792333-15-den@valinux.co.jp>
 <20260910043613.CE8FD1F000FF@smtp.kernel.org>
 <pao67m2xtpetoj2mpqzuvftzdojoj65kqpbg6alqsdqrwozm2t@hdojuk4dsh5k>
 <b90a302d-8ad4-480f-9794-2b62e273a6be@intel.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b90a302d-8ad4-480f-9794-2b62e273a6be@intel.com>
X-ClientProxiedBy: TYCP286CA0176.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::8) To OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:468::22)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOP286MB7730:EE_|OSCP286MB4903:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fba0765-b22d-4fa1-a1e4-08df12188223
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|10070799003|23010399003|366016|3023799007|6133799003|56012099006|5023799004|4143699003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	HXSwEYt25O+xJYG+W/2tlxHKFvqPc8Y5UrwqbdaDKaqjAfJdyEwvtWDbJaCf9p2VtSJum1K6UDisZ4Y6LILQiKZHY81f3EUnVhi/+0a8Ewq9ktuEQhjLEyc1uC8qJD5Iy2+5RJ1WDdFGB91kj6z9lTuCIPqXA0dz9ZBEjdGQbKxDBFjKyhEpq3npN1CgppKwV+K+TF8LasaNlBXFdKp+Aer+HL1JxjW9kF72XIuU9juHhhsdD7a1riNsL+ABMSJFw/0huRN5Ty1QCIRc7rgU/ACgxlV5hl5LdkSv1Ms3KCT4BPz1OjIYiwPtZQo6++5P7P4h3pOiFobCN+pDCfiaiG5bYPOzwpAJfeK7SDZtSCNKD5lZiaImlNo96B6qDqR3LZxwV/1uYoLx58gNOHlD4jQu5W2nPLk2f6puVdlfwFNZqVz/dPEbiTXJYOCAh5Tn0RS5MfVcOqsfWh9j4S33xuHVtf47/E8eOro2CR6I6SCfCMIDt3+88NrKM0FZCsVs382K9gmHwGat5qa5fcMt0z5iC2n9a8tRRGsd0gqziioAdbSR6CuS4gfxI7cEIenWmcfGVfThacNFIL45hWd47eJnuCjfymenp13Qhzaxr0M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(23010399003)(366016)(3023799007)(6133799003)(56012099006)(5023799004)(4143699003)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?wLttl2AXsAyzRjiFcqDL83p7GMBUGOW1vSiHGbqL2ZL3FkXkmR+KML2aWE?=
 =?iso-8859-1?Q?1uxBvukeb84Yu66+bb6bMZ64vYCBmX/mJ2eErhMZgCNXvVVJK20Ubf/jHb?=
 =?iso-8859-1?Q?+tFHJ1lAXqJ8WeeNW4nCt5amvDSG6OzbqnrjilvFQ2tQL7k1npWj46p/+n?=
 =?iso-8859-1?Q?E3ssbeLQrIyStDhNLTqVnpgYzXRk0R7T/5SM5pMwP4pDfrvCoy7XYLdmKc?=
 =?iso-8859-1?Q?cEIo0WTmh9mez33CbrgVk9Aq1rS5rfsovrJ/Hc3hNkmO31OS+Ma3Kg0CrO?=
 =?iso-8859-1?Q?sSdnQ0G//ZBRUOGoIdbeZkJ8LKwDHdEgpfLoc5W5IGUt27rKHo29si1bKI?=
 =?iso-8859-1?Q?Yv6dyD/Fze9/vc/rGX5aMHLSDQcfhil7fK667E/kIjT1lClZy5omJx21zH?=
 =?iso-8859-1?Q?EhdnSJ21cBxVkPURYSoOYpnNsiS0YZeEgVkA+vxy8a5Har8jicMZwJOqV9?=
 =?iso-8859-1?Q?Tbt54A2GYwzOAvWtsQSb5lW7HFbxaO6BrVjahe7SZQdfbBa9T2S4ZpOn/+?=
 =?iso-8859-1?Q?5Go01OVn45BZdfLWtxMucEjZTYMWxexgQ8fFKa0yLErjM4kA4Bo+04uQ3P?=
 =?iso-8859-1?Q?mKwxESPQgkf4ew/8jK0IWGBQJJvnARv6gRHoRrlu2amkJgrkT6iz8wOZL6?=
 =?iso-8859-1?Q?FuCp+OKTJDZ1QMfkziTmxju8VKNPXueoR0S41gvWmQ5TUrDFIwnHxOLW32?=
 =?iso-8859-1?Q?NFWCIcdaPD0saqAxW9ZF/7ictT2sHiNTSfNlDDhHVUsW+B8fvC/+NNqhXu?=
 =?iso-8859-1?Q?NkAQRWKbyKnbtmizHkMqBjPIPjcGTY8KBK+8KyMc//ma4Oa90ioNhmCnLR?=
 =?iso-8859-1?Q?i3uEjeaQoRUEgDvpC0AHJ4yK04LYtG0zc/YY9CAswDIM3c0FcJ8K4Pmrvj?=
 =?iso-8859-1?Q?n+gkCMXfEl78KciBUjmTD6Al6cuiMi5I68iq/DzqjZ1pE/3vxLE8Hruyrc?=
 =?iso-8859-1?Q?cERvrKjkZrpfjGRn/YljSoDRnMERfBRNRrZu84qA86r6tUA0IrpwN07Bd/?=
 =?iso-8859-1?Q?0XtKvcyugK6sULpdPi9wu8Po0THXfojPKG43G3ryFMGQxBx7xRx2mtibbV?=
 =?iso-8859-1?Q?Uzw7Ac0GseoOjIUd2CiXd4Ii+zyRRtqDIQ1quX8U/Rs08RmO0xVaofMasQ?=
 =?iso-8859-1?Q?hpr6388cnnc/w9Vn9QL/miCkI4fc2K35srZ8A+ze3JJGVyLSyEsuuEX+e/?=
 =?iso-8859-1?Q?ztP2pjNtt8yzDzocivyEHAre8heBs6rqzPZ0b6CaNW0WyNAePX+7j/YXow?=
 =?iso-8859-1?Q?O6+4qpnFMChFp5oX6/uCXHEM1jjc2+N1MqHaYKPHgWjKYellgHItSKNrFp?=
 =?iso-8859-1?Q?+lNh6QVLTkHVQNbIbA0K9QHsfjmUlzzIihjKphNO2igeMxytPQo9coKgOE?=
 =?iso-8859-1?Q?nM8iZojECIsHju1noSV2b0LGj8EI3/EPA/6VGoWtJcejRERIfpfCnzY5qb?=
 =?iso-8859-1?Q?WlBT2VO42xrYodoC2N259CFnyLiFSbDbST9d8KlX8FidXeJqe/veC/eHAK?=
 =?iso-8859-1?Q?GWkAjlWgH72Q5Quj1c9U1KMflpGuHcQq2gL9INRq8WQik0mIW4kFK1R3hH?=
 =?iso-8859-1?Q?lnqDQQPY/iD1a8STmGmcQDnW/zFLZHnDSlp1VVHP1NxP7iJamWH6ii//6A?=
 =?iso-8859-1?Q?BgjL5O5Kr1Z5cmHG5Iurn9KZSXBHxCZf3pEPDtY2+WUq69TaIkkeenaO71?=
 =?iso-8859-1?Q?6KMfvv9OzlfIKm3ul+jFpuVtvgdt1gDxZw0Of34SdyXBPaclzZ+WmsEHH5?=
 =?iso-8859-1?Q?7uPW1QyrOSQSqvZTVqzVzGdsaMs45SaM2jx7Rv5RhCDdLXtlz97oXlxYXk?=
 =?iso-8859-1?Q?QOWObM+rzlUOAXQPpIMkuNroia/xGB78ejeDj1uFAIAJAvgl+rTi?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fba0765-b22d-4fa1-a1e4-08df12188223
X-MS-Exchange-CrossTenant-AuthSource: OSOP286MB7730.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 04:27:38.2693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: alFHlW8gYfvbZPlil6HghwqYwIr4MqDck/rNSH4ShFEcewxGfJdkpkJXl0NcMnCXL/HycCdBYD5uKsw449uZTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB4903

On Fri, Sep 11, 2026 at 08:49:40AM -0700, Dave Jiang wrote:
> 
> 
> On 9/10/26 1:48 AM, Koichiro Den wrote:
> > On Thu, Sep 10, 2026 at 04:36:13AM +0000, sashiko-bot@kernel.org wrote:
> >> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> >>
> >> New issues:
> >> - [Critical] Skipping ntb_qp_link_cleanup() during transport teardown fails to drain rx_post_q, causing freed memory to be accessed by in-flight IOAT DMA.
> > 
> > I believe this is a false positive. See my inline comment below.
> > 
> >>
> >> Pre-existing issues:
> >> - [Critical] Double-fetch of `hdr->len` from shared memory allows buffer overflow via TOCTOU race.
> >> - [High] Racy read-modify-write of `qp_bitmap_free` bitmask allows queue state corruption.
> >> --
> >>
> >> commit 68ca6cad9a88600dd4607f3c4ccd6bd32385b0e7
> >> Author: Koichiro Den <den@valinux.co.jp>
> >> Subject: NTB: ntb_transport: Remove clients before freeing transport resources
> >>
> >> Unbinding ntb_transport can call ntb_transport_free() while ntb_netdev
> >> is still bound. This patch reorders the teardown process to unregister
> >> clients before freeing resources, intending to fix unsafe memory accesses
> >> during intensive TX loads.
> >>
> >>> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> >>> index c1e3a077c45ec..f24555b38d1b5 100644
> >>> --- a/drivers/ntb/ntb_transport.c
> >>> +++ b/drivers/ntb/ntb_transport.c
> >>> @@ -1487,9 +1487,11 @@ static void ntb_transport_free(struct ntb_client *self, struct ntb_dev *ndev)
> >>>  
> >>>  	debugfs_remove_recursive(nt->debugfs_node_dir);
> >>>  
> >>> -	ntb_transport_link_cleanup(nt);
> >>> -	cancel_work_sync(&nt->link_cleanup);
> >>> -	cancel_delayed_work_sync(&nt->link_work);
> >>> +	/* Stop transport work before clients release their QPs. */
> >>> +	disable_delayed_work_sync(&nt->link_work);
> >>> +	disable_work_sync(&nt->link_cleanup);
> >>> +
> >>> +	ntb_bus_remove(nt);
> >>
> >> [Severity: Critical]
> >> By moving ntb_bus_remove() before ntb_transport_link_cleanup(), does this
> >> introduce a DMA use-after-free regression?
> >>
> >> Calling ntb_bus_remove() first prompts client drivers to free their QPs via
> >> ntb_transport_free_queue(), which blindly frees all entries in rx_post_q
> >> without polling:
> >>
> >> drivers/ntb/ntb_transport.c:ntb_transport_free_queue() {
> >>     ...
> >> 	while ((entry = ntb_list_rm(&qp->ntb_rx_q_lock, &qp->rx_post_q))) {
> >> 		dev_warn(&pdev->dev, "Freeing item from non-empty rx_post_q\n");
> >> 		kfree(entry);
> >> 	}
> >>     ...
> >> }
> > 
> > Yes, but ntb_transport_free_queue() calls dma_release_channel() before freeing
> > those entries. For IOAT, this goes through ioat_free_chan_resources(), which
> > calls ioat_stop() and ioat_reset_hw() to synchronize callbacks and stop the DMA
> > channel.
> 
> The refute looks reasonable to me for ioat. Any concerns for other host DMA engines? 

Sorry for the late reply. I've been looking into the other engines and
scratching my head a bit.. and

Yes, I found some concerns.

AFAICT:
- IDXD: device_synchronize() does not fully synchronize callbacks.
- AMD PTDMA/AE4DMA: device_synchronize() does not wait for their actual
  callback paths.
- DesignWare DMAC (not dw-edma): device_synchronize() is missing.

These appear to be existing driver issues, but Patch 14 could expose them in
transport teardown. Leaving the patch out does not fix the original crash
described in its commit message either.

For now, I would drop this patch 14(/14) from this series and work on:
(a) Seeing whether an NTB-side rework can fix the original issue without
    depending on the missing callback synchronization.
(b) Fixing callback synchronization in the DMA drivers.

I'm not very familiar with these engines and don't have hardware to verify this
though, so please take this with a pinch of salt. Just my source-level
assessment.

A few details:

- IDXD

  idxd_dma_synchronize() drains the hardware WQ, but idxd_wq_thread() can
  already have moved a completed descriptor to its local flist. It invokes
  the client callback after dropping list_lock.

  The WQ drain does not wait for that callback to finish, contrary to [1].
  idxd_dma_free_chan_resources() does not provide a compensating wait either,
  unlike IOAT's channel teardown.

- AMD PTDMA / AE4DMA

  pt_synchronize() only calls vchan_synchronize(), but these drivers invoke
  callbacks outside the virt-dma tasklet: through status processing in PTDMA and
  ae4_pending_work in AE4DMA. pt_free_chan_resources() does not wait for those
  callbacks either.

  Synchronization needs to cover those actual callback paths.
  ldma_synchronize() might be an example of waiting for driver-specific work as
  well as the virt-dma tasklet, though the details would differ here. The
  ordering of descriptor freeing would also need checking.

- DesignWare DMAC

  The legacy DW driver still lacks device_synchronize(), although its tasklet
  can drop the channel lock before invoking the client callback.  Channel
  resource release does not wait for that tasklet either.

  Adding callback synchronization might be a right direction here. This looks
  like the kind of race the termination synchronization API was introduced to
  address:
  https://lore.kernel.org/r/1445334391-12272-1-git-send-email-lars@metafoo.de/

[1] Documentation/driver-api/dmaengine/provider.rst, device_synchronize:
    > Must make sure that all complete callbacks for previously
    > submitted descriptors have finished running and none are
    > scheduled to run.

Best regards,
Koichiro

> 
> DJ
> 
> > 
> > I believe Jon and Dave know IOAT well too, so I'd appreciate any comments from
> > them. I guess the mention on IOAT in an earlier patch in this series prompted
> > Sashiko to focus on it here.
> > 
> > Best regards,
> > Koichiro
> > 
> >>
> >> Because IOAT DMA engines could still be actively copying into those buffers,
> >> freeing them allows the hardware DMA engine to write to freed kernel memory.
> >> Furthermore, the DMA drain wait in ntb_qp_link_cleanup() is subsequently
> >> skipped entirely because qp_bitmap_alloc evaluates to 0 during the later
> >> call to ntb_transport_link_cleanup().
> >>
> >> [ ... ]
> >>
> >>> @@ -1736,17 +1736,17 @@ static void ntb_process_rxc(struct ntb_transport_qp *qp)
> >>>  
> >>>  	if (hdr->len > entry->len) {
> >>>  		dev_dbg(&qp->ndev->pdev->dev,
> >>>  			"receive buffer overflow! Wanted %d got %d\n",
> >>>  			hdr->len, entry->len);
> >>>  		qp->rx_err_oflow++;
> >>>  
> >>>  		entry->len = -EIO;
> >>>  		entry->flags |= DESC_DONE_FLAG;
> >>>  
> >>>  		ntb_complete_rxc(qp);
> >>>  	} else {
> >>>  		dev_dbg(&qp->ndev->pdev->dev,
> >>>  			"RX OK index %u ver %u size %d into buf size %d\n",
> >>>  			qp->rx_index, hdr->ver, hdr->len, entry->len);
> >>>  
> >>>  		qp->rx_bytes += hdr->len;
> >>>  		qp->rx_pkts++;
> >>>  
> >>>  		entry->len = hdr->len;
> >>
> >> [Severity: Critical]
> >> This is a pre-existing issue, but is there a time-of-check to time-of-use
> >> race condition in this bounds check on hdr->len?
> >>
> >> Since hdr points to a payload header located inside a memory window writable
> >> by the remote NTB peer (shared memory), hdr->len is read directly from
> >> shared memory twice (once for the bounds check, once for the assignment).
> >>
> >> Can a remote peer swap hdr->len to a much larger value immediately after
> >> the bounds check but before the assignment, bypassing the bounds check and
> >> causing a buffer overflow when copied?
> >>
> >> [ ... ]
> >>
> >>> @@ -2130,7 +2130,7 @@ struct ntb_transport_qp *
> >>>  ntb_transport_create_queue(void *data, struct device *client_dev,
> >>>  			   const struct ntb_queue_handlers *handlers)
> >>>  {
> >> [ ... ]
> >>>  	free_queue--;
> >>>  
> >>>  	qp = &nt->qp_vec[free_queue];
> >>>  	qp_bit = BIT_ULL(qp->qp_num);
> >>>  
> >>>  	nt->qp_bitmap_free &= ~qp_bit;
> >>
> >> [Severity: High]
> >> This isn't a bug introduced by this patch, but could this read-modify-write
> >> of nt->qp_bitmap_free lead to queue state corruption?
> >>
> >> The qp_bitmap_free bitmask is modified here using non-atomic bitwise
> >> operations without holding any lock. It is also modified concurrently during
> >> driver unbind:
> >>
> >> drivers/ntb/ntb_transport.c:ntb_transport_free_queue() {
> >>     ...
> >> 	qp->transport->qp_bitmap_free |= qp_bit;
> >>     ...
> >> }
> >>
> >> Since these are exported functions called by NTB client drivers, could
> >> concurrent probe and remove operations race and lose bit updates, leading
> >> to a leaked queue or two clients being assigned the same queue?
> >>
> >> -- 
> >> Sashiko AI review · https://sashiko.dev/#/patchset/20260910040836.3792333-1-den@valinux.co.jp?part=14
> > 
> 
