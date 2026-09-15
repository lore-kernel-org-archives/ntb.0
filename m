Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020109.outbound.protection.outlook.com [52.101.228.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2E0426EB2;
	Tue, 15 Sep 2026 04:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789444927; cv=fail; b=ay4qJGUQtL3yhFcqgamHrQjDORf58ARTDygS3JyO3WnIJFecBs3xycpGeX/9x3fUnT8ZkDA0MhdKw1k21CmdPQsm0euIJBzGF/rvNbMAc9LHIt8g6fadHWpyvS9MdcMO54eOsmdLnusgN404e2/72UqUXwnaz0Q0IrNck069A3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789444927; c=relaxed/simple;
	bh=mGGn/1NZT+FGPyJ8Rr/0UYv5ieXY+Eu67F3xprX01gU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=j5dgFS2MatgT4H380qEUIZV/1K/D4QZEaB9LlWBsJ1gUCVQJe9RXfG3QhTHSl2Gn/ZdHhlAtBQSoM59CVHnGiV5forVlTo1SkKQBTvlq7oAltsZziKC6TJPKarj7GAqglhQBWNn+VcHEYxeHgDzIyFcaWUXwges7TwTDQYOkZPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=fail (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=CEByaMCZ reason="signature verification failed"; arc=fail smtp.client-ip=52.101.228.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="CEByaMCZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VrPTk4tIPh0dM0Vepzq+LbNd0L7THhQ/qh7bQL6/X9fILsitFuj98qL/ka6KSnhmGY5V0nhOCKc7kfYR6z7iO4jQfSQorvi86gvOKBSLYG3UwYtFe4s1/SQB2Lurrqa0VgdIfqHx6gXDJNoI1U+eu0cAWoLbmnO58ZSLgLVFmOwdX1sZAVZraZ7C+6aboFBiDYbtLrpZJRLjeljOz9cByS2joT1NA+ESdw/I9a4WOLxTF/4vTWJtM/Giliky4eUQzUn3GKNc1KSPw/K8QWaZzS/qNIQLzoLIuckU3sZnO4JODRpktCa2k/nwFcgQV1Vdzmhy8D2FS61FD1jsZfuWag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kyvFRKLl0XO+GRaqNY/Z6tsD5gR8MhwY0ayQ6B2oa8U=;
 b=zGoGmVkkMClNGMcxk6H9id10wfD04gPDAAjNkIPSL9jPG/f2oPKvlDG/QjsovFpgPOSUYFvNA0UkHpFZZ/EzlMx7AIRrfX/QAVwraIK3li76rNWmdoNXXw2o9jIe0khKnPTU7Yy6/d6DXhcJbq/+dzVNbk/uZxay2Em8er18G/GwXAfFOc2BXieh+3jEPFcbaGtTUCpm3Lpued1fCyPbQHwfSd1S0fiXYRDfqd7IfY2j6JQluUcvWNvH7zWqvVzJwE7tVQKyJT1AYG0lsU3FGjFPJegefNSC+OHcIG8PTmcVAcwvsYWIwCSdVnJVO1QDh4FpSyK4ZSPOS3xnLyyUXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kyvFRKLl0XO+GRaqNY/Z6tsD5gR8MhwY0ayQ6B2oa8U=;
 b=CEByaMCZivZSB2P7y9vtnca4iODN/75/v8YwtjU6R/flrEAxB4gpLe5OE42NANJRPp0bbzNuJ8MgnM7dsLV2lVspdOeoFSAYWKt4zZb4niFFT/ONc00Fm2NNbfli5BoUdJVbnSyNkHP9oiIjtnwUne294hhFoVXGBg3GcZ5Ou9Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS9P286MB4153.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2cd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.13; Tue, 15 Sep
 2026 04:01:58 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 04:01:58 +0000
Date: Tue, 15 Sep 2026 13:01:56 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Dave Jiang <dave.jiang@intel.com>
Cc: sashiko-reviews@lists.linux.dev, ntb@lists.linux.dev
Subject: Re: [PATCH v2 14/14] NTB: ntb_transport: Remove clients before
 freeing transport resources
Message-ID: <vuoc76ik5ethjsq25gu3aku5o3yvdsm4ko6dnp4n3biheiqdy2@pxxgq24tk2cy>
References: <20260910040836.3792333-1-den@valinux.co.jp>
 <20260910040836.3792333-15-den@valinux.co.jp>
 <20260910043613.CE8FD1F000FF@smtp.kernel.org>
 <pao67m2xtpetoj2mpqzuvftzdojoj65kqpbg6alqsdqrwozm2t@hdojuk4dsh5k>
 <b90a302d-8ad4-480f-9794-2b62e273a6be@intel.com>
 <rtc2lb2iic42wuqtcjxqqvvyxcl535x4iv7uxhvkk55o3q5ire@lq7eukkl4aaj>
 <016c0065-04de-41ab-b098-fac2bceb2d24@intel.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <016c0065-04de-41ab-b098-fac2bceb2d24@intel.com>
X-ClientProxiedBy: TYCP286CA0366.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::6) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OS9P286MB4153:EE_
X-MS-Office365-Filtering-Correlation-Id: 29b34b00-7edc-4f13-6f78-08df12de1684
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|10070799003|366016|56012099006|5023799004|4143699003|10067099003|6133799003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	E0WgYkiwafN/4mhw8bvve/1ErlZzPNwgwODah3M+DJXLuvtF2zhfQPfOYGZ395B3WTZ0EM/gG1PB9xqrb3IYnfK4WhPoNBaBzHmFlREohxQCTV/oI+4imab9NhpwxyZk14Q3BdhnnfHPlHerPoMs1BrkqeNUFS/g7SrKjswT99QbX0v4JKpNXmzbpLnQMuzFugIlRfhKq/rg3xwqUr7omVSwsIVvGsnC5WhHVjlKTgX1MPoKRmvV0VU54Pb8sYanu4Cp8nAlJROnVoPpp8cAxGiJ0agwGp2O8kyhPY0RX9VEK5gO5pG3TvCKhiJvQqAh4IR1mxuzOhCMPG21kxnYLoqR+ScfOdNAGQiDQupfo/76fEEV4HC3vSvlXdYp4A9lyg7ZjGm4wvEveqwgEKKMcu+R/kllMa1r5n3YaT+DheW2MUmJlr+ZCx/8k/uiCaL6rWUpTzHBquAvENuFhPUvscLSv6cGWLFrNyEYuoHhvYNMpo/BMgDYPUnu9h4mPS/+ZlhqDnkzSWtTnKU+RxMAUaGjb1yiHKStzL8avnOCLSWF2NUHyrC8J7RAr/5bT/kcvId1AfqzKSoevDTClZczE2ELilbMe3z/4EGDW7NeBus=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(10070799003)(366016)(56012099006)(5023799004)(4143699003)(10067099003)(6133799003)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?Q9oUaNmQ/KfXoE+uXkskVXeV4+PM01DxsGjliahbYcqXPLXVNR09Mhpgwk?=
 =?iso-8859-1?Q?45YyLmzlFwywjDYiOLtgV64WFqtcT10Lws2GmInek5gZOgoFupWC9B5j9c?=
 =?iso-8859-1?Q?lZ6G8WtwYNx6k8sJyHnZm5rF1UAu0e1qYjKKQ8N00W5OGdhO0lprLjiw67?=
 =?iso-8859-1?Q?zao6XFDAWR0mA4fWwYnNEwF7TI1H4dWdl/lMy8TTjWNUSEFCOGcNp9ZcBx?=
 =?iso-8859-1?Q?mHKjgzbIGD3RrmR+LWS3PznHPvIE57Bi+uazK6IqwkoG3iJmkh7i5/nbAT?=
 =?iso-8859-1?Q?Y6t7HA41wXlBlZYJRyUAwj+hqWVxJoPymGBvPox5Bh8Oh+TduyeP6vVzfS?=
 =?iso-8859-1?Q?30Jw2eVRx29FV4EZu1YBP/pNeoKL4ao97Z2IYWD7dMACvx/ISuAnjpi6c+?=
 =?iso-8859-1?Q?xE6abMj3qJQFreSQ4srWT1MQwV/5pAoRB0oHIrITf3ugtfP9SiD2xRzcqm?=
 =?iso-8859-1?Q?5wiqQXIEGYFjCs364Q+nbw9TvBI6baf9iyQ7DNymWfP6jZgVlbmra/+PJ8?=
 =?iso-8859-1?Q?F506FfudJxz7Dd94bvJ6c4qnq89F7XxcmP353Q+1VBWdajmOpsWIMTVMY4?=
 =?iso-8859-1?Q?7X7XQhlPibFvnwHRbDSchKMHxTuFikCZo+BOxOlOCTxbxvm9TKO4K+dCAz?=
 =?iso-8859-1?Q?WTv2eHXKnXCHSyswprJBTVkIa6xF9ODdvHN4mDPRaEXN3hzMPbWcel05NI?=
 =?iso-8859-1?Q?qC2+uq6EwzAAiLj69iCEmW8r9pVNRvQ9QD/5yBvCIUFJ49tajDQIGodTmC?=
 =?iso-8859-1?Q?zhPSX8SHATkfGdm2WlSPnK/zakRZYsODk36BkFIdflv6oYN1siu/LkQ7HX?=
 =?iso-8859-1?Q?rGErWJnOIDVT4H0Mhp2iC75iYs3E9+gMt4k9tD5wSaB7XmQEdsKADUFJ9H?=
 =?iso-8859-1?Q?Z6y5E57kD9Zzhq0ULG7cCr8VwUIF2BzFN/b+9iu6QvMnenpBMWumiVfAJ4?=
 =?iso-8859-1?Q?UOtA/fJnwXKqwwpIAH6bwNEGFuPYfNDWiWlUmPfqSeDHOx7+aIEx35FBMk?=
 =?iso-8859-1?Q?4FT23cVheXEO+gKsrQR7LemrHl6b59ocuorqDZQX0j+67aHp6GzQtxJrs+?=
 =?iso-8859-1?Q?UpTaPrySd+7zeKQZpFB1cpFTcierjAIsrOn0x2oVfbixINcWAFWTwOFGlb?=
 =?iso-8859-1?Q?s/Cr0NpV3OB/ThVbVjXTUqMDak0Rkt0wrTNyvGzyzggFXdnx5/Roq11S3S?=
 =?iso-8859-1?Q?xHCl13Qo4+zzXMzYCPp/0tldpiikpKzBD5f1SkoiLy8oIuIV2iWO2OtnRI?=
 =?iso-8859-1?Q?IOuYL2lLcipzIgRC3DNoldAvVesKH7rKLvUwof7b/VIRmAPtITHFdQOI/M?=
 =?iso-8859-1?Q?4lYHnrax8yO0G9xrr3hOvCEWCHlsJl9EWKEc4sTIZCQSCgcawKA95we9l9?=
 =?iso-8859-1?Q?Mxy6zC1FZNCSFMgHy5mbQb4sBDiFpY276Xb4Q1HsQflIi/4bhYh2Lk8eqO?=
 =?iso-8859-1?Q?pNgR0FVoc3jX18NurCo9clrbxyz5XMzcjJJtjEU8JYT4TqK5pEsPp35bSL?=
 =?iso-8859-1?Q?VhJQXTzmV9hK0vJtwVQu+krC23Pd1kzB1wSyvOw6Pj2eAfAgifPlgF2b26?=
 =?iso-8859-1?Q?UdfZ/X8/UAKJw334f0I0TXPLE6JcCV+hIvi/2mfH4l9ZAjGe6ChN8CdrDT?=
 =?iso-8859-1?Q?nVU6nbkRKmf63X/ng388JH69WqK2CW9Z3mkd/+mislAqqqKqT20fPx7Jp4?=
 =?iso-8859-1?Q?Rc9PoyPnPNYtKb6a6xVG9p1ckkDKnS9rtlPIfYl7Hp3MHnI/YgW6cSYit7?=
 =?iso-8859-1?Q?4fxxMKXj7917NRXSsPHRzfMwQh/okOzKEWAe6WZzIVOGIX4QqZNahqaUsv?=
 =?iso-8859-1?Q?K5JWy3v7Sxn58rkLVoNys746WEUiF2kkRPlvzLrs5Lm7Hj1dqCat?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 29b34b00-7edc-4f13-6f78-08df12de1684
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 04:01:58.1594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CnLWo+xDuiY91Wj05bNflIdryWsQANKz6LdafzHc0xm/yVDWGv7EzWdRyLBJlr/B2IaC43dzmK7+/0VvtGhqvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB4153

On Mon, Sep 14, 2026 at 02:02:05PM -0700, Dave Jiang wrote:
> 
> 
> On 9/13/26 9:27 PM, Koichiro Den wrote:
> > On Fri, Sep 11, 2026 at 08:49:40AM -0700, Dave Jiang wrote:
> >>
> >>
> >> On 9/10/26 1:48 AM, Koichiro Den wrote:
> >>> On Thu, Sep 10, 2026 at 04:36:13AM +0000, sashiko-bot@kernel.org wrote:
> >>>> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> >>>>
> >>>> New issues:
> >>>> - [Critical] Skipping ntb_qp_link_cleanup() during transport teardown fails to drain rx_post_q, causing freed memory to be accessed by in-flight IOAT DMA.
> >>>
> >>> I believe this is a false positive. See my inline comment below.
> >>>
> >>>>
> >>>> Pre-existing issues:
> >>>> - [Critical] Double-fetch of `hdr->len` from shared memory allows buffer overflow via TOCTOU race.
> >>>> - [High] Racy read-modify-write of `qp_bitmap_free` bitmask allows queue state corruption.
> >>>> --
> >>>>
> >>>> commit 68ca6cad9a88600dd4607f3c4ccd6bd32385b0e7
> >>>> Author: Koichiro Den <den@valinux.co.jp>
> >>>> Subject: NTB: ntb_transport: Remove clients before freeing transport resources
> >>>>
> >>>> Unbinding ntb_transport can call ntb_transport_free() while ntb_netdev
> >>>> is still bound. This patch reorders the teardown process to unregister
> >>>> clients before freeing resources, intending to fix unsafe memory accesses
> >>>> during intensive TX loads.
> >>>>
> >>>>> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> >>>>> index c1e3a077c45ec..f24555b38d1b5 100644
> >>>>> --- a/drivers/ntb/ntb_transport.c
> >>>>> +++ b/drivers/ntb/ntb_transport.c
> >>>>> @@ -1487,9 +1487,11 @@ static void ntb_transport_free(struct ntb_client *self, struct ntb_dev *ndev)
> >>>>>  
> >>>>>  	debugfs_remove_recursive(nt->debugfs_node_dir);
> >>>>>  
> >>>>> -	ntb_transport_link_cleanup(nt);
> >>>>> -	cancel_work_sync(&nt->link_cleanup);
> >>>>> -	cancel_delayed_work_sync(&nt->link_work);
> >>>>> +	/* Stop transport work before clients release their QPs. */
> >>>>> +	disable_delayed_work_sync(&nt->link_work);
> >>>>> +	disable_work_sync(&nt->link_cleanup);
> >>>>> +
> >>>>> +	ntb_bus_remove(nt);
> >>>>
> >>>> [Severity: Critical]
> >>>> By moving ntb_bus_remove() before ntb_transport_link_cleanup(), does this
> >>>> introduce a DMA use-after-free regression?
> >>>>
> >>>> Calling ntb_bus_remove() first prompts client drivers to free their QPs via
> >>>> ntb_transport_free_queue(), which blindly frees all entries in rx_post_q
> >>>> without polling:
> >>>>
> >>>> drivers/ntb/ntb_transport.c:ntb_transport_free_queue() {
> >>>>     ...
> >>>> 	while ((entry = ntb_list_rm(&qp->ntb_rx_q_lock, &qp->rx_post_q))) {
> >>>> 		dev_warn(&pdev->dev, "Freeing item from non-empty rx_post_q\n");
> >>>> 		kfree(entry);
> >>>> 	}
> >>>>     ...
> >>>> }
> >>>
> >>> Yes, but ntb_transport_free_queue() calls dma_release_channel() before freeing
> >>> those entries. For IOAT, this goes through ioat_free_chan_resources(), which
> >>> calls ioat_stop() and ioat_reset_hw() to synchronize callbacks and stop the DMA
> >>> channel.
> >>
> >> The refute looks reasonable to me for ioat. Any concerns for other host DMA engines? 
> > 
> > Sorry for the late reply. I've been looking into the other engines and
> > scratching my head a bit.. and
> > 
> > Yes, I found some concerns.
> > 
> > AFAICT:
> > - IDXD: device_synchronize() does not fully synchronize callbacks.
> > - AMD PTDMA/AE4DMA: device_synchronize() does not wait for their actual
> >   callback paths.
> > - DesignWare DMAC (not dw-edma): device_synchronize() is missing.
> 
> Given that different DMA drivers have different implementations, this becomes a difficult issue. Either there needs to be a standard expectation and documented in dmaengine API (which would also including fixing up every DMA driver and seems kind of unrealistic). Or we document and fix it on the NTB side in a uniform way. Thoughts?

There is already a documented requirement. Here is [1] from my previous email
again:

[1] Documentation/driver-api/dmaengine/provider.rst, device_synchronize:
    > Must make sure that all complete callbacks for previously
    > submitted descriptors have finished running and none are
    > scheduled to run.

Based on that requirement and the code I checked, AFAICT:

  - IDXD             : fixes needed
  - AMD PTDMA/AE4DMA : fixes needed
  - DesignWare DMAC  : follow-up is desired

I agree that a uniform NTB-side approach would be worth looking into. But after
some more head-scratching, I'd like to revise my conclusion:

- I'd prefer to keep Patch 14 as-is. Compared to mainline, I consider this a
  pre-existing issue, rather than a new regression. This revises my earlier plan
  to drop Patch 14 for rework. My reasoning is in [2].

- A uniform NTB-side approach can be explored separately from this series. It
  may require a larger rework than this fix.


[2] Why I consider the issue pre-existing.

    The key point of this patch 14 is to stop clients before freeing the
    resources they use.

    It relies on ntb_transport_free_queue() to stop and release QPs. This API is
    already called directly during standalone ntb_netdev removal, without prior
    transport link cleanup. It relies on the DMA driver to stop transfers and
    synchronize callbacks before resources are freed. Some drivers have gaps in
    that synchronization, allowing late callbacks to access freed resources.
    Those gaps already affect standalone netdev removal.

    Patch 10 added an RX wait before QP reset and MW release. That wait also
    covered transport removal. Patch 14 bypasses it, so compared with its
    immediate parent, it does remove some protection against the existing DMA
    driver bugs. I agree that this is a real change.

    However, that RX wait did not exist in mainline before this series, and the
    same callback-lifetime issue was already possible there. It would therefore
    be misleading to describe this as a new DMA synchronization bug or callback
    use-after-free introduced into mainline by the series.

    Relying on the DMA driver to synchronize callbacks is consistent with the
    existing dmaengine API contract. I would therefore prefer to keep Patch 14
    and address the DMA driver bugs separately, while acknowledging that Patch
    14 no longer benefits from the RX wait added earlier in the series.

Best regards,
Koichiro

> 
> DJ
> 
> > 
> > These appear to be existing driver issues, but Patch 14 could expose them in
> > transport teardown. Leaving the patch out does not fix the original crash
> > described in its commit message either.
> > 
> > For now, I would drop this patch 14(/14) from this series and work on:
> > (a) Seeing whether an NTB-side rework can fix the original issue without
> >     depending on the missing callback synchronization.
> > (b) Fixing callback synchronization in the DMA drivers.
> > 
> > I'm not very familiar with these engines and don't have hardware to verify this
> > though, so please take this with a pinch of salt. Just my source-level
> > assessment.
> > 
> > A few details:
> > 
> > - IDXD
> > 
> >   idxd_dma_synchronize() drains the hardware WQ, but idxd_wq_thread() can
> >   already have moved a completed descriptor to its local flist. It invokes
> >   the client callback after dropping list_lock.
> > 
> >   The WQ drain does not wait for that callback to finish, contrary to [1].
> >   idxd_dma_free_chan_resources() does not provide a compensating wait either,
> >   unlike IOAT's channel teardown.
> > 
> > - AMD PTDMA / AE4DMA
> > 
> >   pt_synchronize() only calls vchan_synchronize(), but these drivers invoke
> >   callbacks outside the virt-dma tasklet: through status processing in PTDMA and
> >   ae4_pending_work in AE4DMA. pt_free_chan_resources() does not wait for those
> >   callbacks either.
> > 
> >   Synchronization needs to cover those actual callback paths.
> >   ldma_synchronize() might be an example of waiting for driver-specific work as
> >   well as the virt-dma tasklet, though the details would differ here. The
> >   ordering of descriptor freeing would also need checking.
> > 
> > - DesignWare DMAC
> > 
> >   The legacy DW driver still lacks device_synchronize(), although its tasklet
> >   can drop the channel lock before invoking the client callback.  Channel
> >   resource release does not wait for that tasklet either.
> > 
> >   Adding callback synchronization might be a right direction here. This looks
> >   like the kind of race the termination synchronization API was introduced to
> >   address:
> >   https://lore.kernel.org/r/1445334391-12272-1-git-send-email-lars@metafoo.de/
> > 
> > [1] Documentation/driver-api/dmaengine/provider.rst, device_synchronize:
> >     > Must make sure that all complete callbacks for previously
> >     > submitted descriptors have finished running and none are
> >     > scheduled to run.
> > 
> > Best regards,
> > Koichiro
> > 
> >>
> >> DJ
> >>
> >>>
> >>> I believe Jon and Dave know IOAT well too, so I'd appreciate any comments from
> >>> them. I guess the mention on IOAT in an earlier patch in this series prompted
> >>> Sashiko to focus on it here.
> >>>
> >>> Best regards,
> >>> Koichiro
> >>>
> >>>>
> >>>> Because IOAT DMA engines could still be actively copying into those buffers,
> >>>> freeing them allows the hardware DMA engine to write to freed kernel memory.
> >>>> Furthermore, the DMA drain wait in ntb_qp_link_cleanup() is subsequently
> >>>> skipped entirely because qp_bitmap_alloc evaluates to 0 during the later
> >>>> call to ntb_transport_link_cleanup().
> >>>>
> >>>> [ ... ]
> >>>>
> >>>>> @@ -1736,17 +1736,17 @@ static void ntb_process_rxc(struct ntb_transport_qp *qp)
> >>>>>  
> >>>>>  	if (hdr->len > entry->len) {
> >>>>>  		dev_dbg(&qp->ndev->pdev->dev,
> >>>>>  			"receive buffer overflow! Wanted %d got %d\n",
> >>>>>  			hdr->len, entry->len);
> >>>>>  		qp->rx_err_oflow++;
> >>>>>  
> >>>>>  		entry->len = -EIO;
> >>>>>  		entry->flags |= DESC_DONE_FLAG;
> >>>>>  
> >>>>>  		ntb_complete_rxc(qp);
> >>>>>  	} else {
> >>>>>  		dev_dbg(&qp->ndev->pdev->dev,
> >>>>>  			"RX OK index %u ver %u size %d into buf size %d\n",
> >>>>>  			qp->rx_index, hdr->ver, hdr->len, entry->len);
> >>>>>  
> >>>>>  		qp->rx_bytes += hdr->len;
> >>>>>  		qp->rx_pkts++;
> >>>>>  
> >>>>>  		entry->len = hdr->len;
> >>>>
> >>>> [Severity: Critical]
> >>>> This is a pre-existing issue, but is there a time-of-check to time-of-use
> >>>> race condition in this bounds check on hdr->len?
> >>>>
> >>>> Since hdr points to a payload header located inside a memory window writable
> >>>> by the remote NTB peer (shared memory), hdr->len is read directly from
> >>>> shared memory twice (once for the bounds check, once for the assignment).
> >>>>
> >>>> Can a remote peer swap hdr->len to a much larger value immediately after
> >>>> the bounds check but before the assignment, bypassing the bounds check and
> >>>> causing a buffer overflow when copied?
> >>>>
> >>>> [ ... ]
> >>>>
> >>>>> @@ -2130,7 +2130,7 @@ struct ntb_transport_qp *
> >>>>>  ntb_transport_create_queue(void *data, struct device *client_dev,
> >>>>>  			   const struct ntb_queue_handlers *handlers)
> >>>>>  {
> >>>> [ ... ]
> >>>>>  	free_queue--;
> >>>>>  
> >>>>>  	qp = &nt->qp_vec[free_queue];
> >>>>>  	qp_bit = BIT_ULL(qp->qp_num);
> >>>>>  
> >>>>>  	nt->qp_bitmap_free &= ~qp_bit;
> >>>>
> >>>> [Severity: High]
> >>>> This isn't a bug introduced by this patch, but could this read-modify-write
> >>>> of nt->qp_bitmap_free lead to queue state corruption?
> >>>>
> >>>> The qp_bitmap_free bitmask is modified here using non-atomic bitwise
> >>>> operations without holding any lock. It is also modified concurrently during
> >>>> driver unbind:
> >>>>
> >>>> drivers/ntb/ntb_transport.c:ntb_transport_free_queue() {
> >>>>     ...
> >>>> 	qp->transport->qp_bitmap_free |= qp_bit;
> >>>>     ...
> >>>> }
> >>>>
> >>>> Since these are exported functions called by NTB client drivers, could
> >>>> concurrent probe and remove operations race and lose bit updates, leading
> >>>> to a leaked queue or two clients being assigned the same queue?
> >>>>
> >>>> -- 
> >>>> Sashiko AI review · https://sashiko.dev/#/patchset/20260910040836.3792333-1-den@valinux.co.jp?part=14
> >>>
> >>
> 
