Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020108.outbound.protection.outlook.com [52.101.228.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D4D233933;
	Sat, 19 Sep 2026 12:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789822270; cv=fail; b=gWE9pAcx8Iyv0YPfBg9BoCpetAHfZlyk+42xlM4ZKvYm4YKDWOtFSaiFl+4Q9dNvyTwVBD/FutlRoHaL8eDCKEIS42nso9jMBK/CnADwdWVCRwBM+lqOQgcytH6uaQH6ZzmaQliZBgDQPXibZDK5d8S3B2SPzSUNvPdVf3uNo3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789822270; c=relaxed/simple;
	bh=6xxujpfpjRta340+bEXTMisdw3JY9ql3DnSsRh6bE5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ucy3HUXSfcHKTfKPez9AmoWKdlSKfckr4LWGn0T1VFGiZJDHbk7aXKr5H89X9TirX7qChhfhi2zrSLIMbw3/CGyXMic2mZVDrCWKHpcaXkl/lWRe4Zwya+wXm6fIc6uwA00g1WtDf6nKncAxLI6RpJRvKllpwArBWWkUFAGaH/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=fail (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=ZnMfnJ2Q reason="signature verification failed"; arc=fail smtp.client-ip=52.101.228.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="ZnMfnJ2Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sQKKE8/JR86zGwtWPtRGKBWKccSQRfhyAsipDXokJGCS8ZCYvGdSZv35fEcgqOyMcSqVrd1kGtYcnUaZEfmsguTYdf779wyKVMYhXA4JHmRB8LdofZ1sFE7aFLetyfNtFfeSKfdpezjAYNUbEhbBRz3TljKavqIUKuO+OkK+hj5dZfjoq+pBTKwQIJsfk63oskvNAfywuMyT0d6PS2YPlR93DsutgIoUgsCYmtqjUAmeblAPLXqykzCYQceQuaIeoKq+WsTpW6eAdsxCuV0oil2UgLNUk0J1s5mZhUbC7WNWm7T+nn6S6n01eKICp+2yqzB4puyIx8Fec8I6pnU6tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Py5nC3/YUu2B0vDEtO1WY4puJ7uorZiQ/dBZ6b4icCQ=;
 b=hswZ02VNj9oeXwodl2LKSXfp9as6nJKTQXCtcYMiFTC2YdyE/CwIApnhaukpIr1TrBgp4l7L0KlwtHUY+krhTjX1+hn6eXk41P7XYSrmcwEJkM68zE+UP61cBsNBxSbjm4d6ARD2FkW3TMTlq0UCX9wn8yVdY1e1yO8bPAiJ5F2KtQvliALWb+fVeP9vQ6VEADA/SVJ6LqxBlI6T7MgJOEDwd3XJrMd2bkNXptHYUSi03BtKRiIsZ/pvg/fGBjgNnVsxvXrd9wvb2SW23HRqRKUNPcddvhMiTEPrgu60g2PEqhnXwax2jtr+4msBZ76act+inXO/E7lTvf8xjb0WvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Py5nC3/YUu2B0vDEtO1WY4puJ7uorZiQ/dBZ6b4icCQ=;
 b=ZnMfnJ2Qc9kDcmi7/o6E8tirN4f0+/iGC86dwUteMwe5essDRqp0KUxKkDqut9Kk8CMPLUCI9ewOH5G+9/QImLdSkcTZthrcRcOkt4tl2aYvXru39MpQjKGwe4lJye6jVrXgW33+jAJIyc5o3Bitel9kasKV+5XF41xjy2PTTaQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYWP286MB2971.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2ff::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Sat, 19 Sep
 2026 12:51:02 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0428.014; Sat, 19 Sep 2026
 12:51:02 +0000
Date: Sat, 19 Sep 2026 21:51:01 +0900
From: Koichiro Den <den@valinux.co.jp>
To: sashiko-reviews@lists.linux.dev
Cc: ntb@lists.linux.dev
Subject: Re: [PATCH net-next v4 05/10] NTB: ntb_transport: Exchange client
 capabilities at link-up
Message-ID: <76ns7kmss2xx75mjttbfxrme5m2g3x2dqx4g36ruufm7x3iz5p@ntu2glqjbjiy>
References: <20260914084838.2158249-1-den@valinux.co.jp>
 <20260914084838.2158249-6-den@valinux.co.jp>
 <20260915085012.E9C8E1F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260915085012.E9C8E1F000FF@smtp.kernel.org>
X-ClientProxiedBy: TYCP286CA0160.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::7) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYWP286MB2971:EE_
X-MS-Office365-Filtering-Correlation-Id: ac300232-318b-4c4c-39bc-08df164ca932
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|10070799003|1800799024|3023799007|4143699003|10067099003|6133799003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	hAASUwsoQZHX636vznXLAC85ZmaBiE8TAXgTWSMtooEc3IKbqV+NkVcC1C7ZpqZUkALtZ+FsFoFYcDpml69lLApP/T9wXjUio2oSafOwjtTefkwDgXVz7iwsEhjL6Db1IChI9stuor1xk8JC8/u8+vysoB9sZdcorV4CnhPz50Ugpl4wwjn9a9HgFT9NwmedaJ6q6123gJQ8VjiCEHqYKniF7BpRoKCsWr4+kFXOyFdeT3tSgxfHEGwBXOZJ84k9GkSHqBLqzu2QkvbQh4o6w01zvAUwcdjNbKPeXTmDNnp1nrMjpYFbiXeWecnzsOQ2yt4Y8R3CP6tHKUFF5HH1zzEe26ih3CKHUSeYW0S4aQ8zWrhlGHGDvaMPgSGkbS9cf30xMZ4Pi8whYaqRelY4fuXsnRCsYHZ1kosGTzKXEeDcgfy4uq+92otgw1RITtjM+BvZ8iqJQ+gUnUo8iMrvNhk8PzEZiAXZjIc6LRu2V0uHmYhhCmnp8SzuRKuJGcCxLqiYq90q88PeQEfT9b32WwmIhdtqY29FrgOxZ5HoSEzf8rzcRT+D2dxPCCLQ3umBE0zLtmhS3Y4RDLXglEk0WWXJtje07xbEk/ahh6LycdY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(10070799003)(1800799024)(3023799007)(4143699003)(10067099003)(6133799003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?+fqxaQeQeTn4vjGEHlvhq1JPjFl+hHrEgRDOyJvdsEEc90GCIYPMptZOPv?=
 =?iso-8859-1?Q?W2/jP5oGjm80M4DNq2f2SBYGDYLg8m8HskTWIJ3ctcQk8cAHNbFixKb3kS?=
 =?iso-8859-1?Q?U8WZIMEQZGgt80EjHjWPP1Bl9N2y2n1SuMgOogmOQSIIYHR25ToNdGiHUB?=
 =?iso-8859-1?Q?MzQb00v4PfZZz170J7EbLCmED002CdscZa2RrxA0N4IN1pelOhmdp4SG3A?=
 =?iso-8859-1?Q?VBeWkN7rsB37H4caTU7F7qjXmUzOr4wU0f9UcmEjjQEu2rDoHp43Z8welS?=
 =?iso-8859-1?Q?0fG5DoHtSC2iJhMzeXg/AsmSG2hvsPFjsn7hP0oLp6YGgAcMMIwnDifYdg?=
 =?iso-8859-1?Q?RyF+63fmk0JlzMFNlnW7317VhOzGzm0Onfvvqef3OMUxV81tS0Wyywf7KL?=
 =?iso-8859-1?Q?Vvv1WapWOcZc3UCdHO+JOItaaXttmOu/8Lyyvqkw4wSzcL4CHCwD7Ohdfw?=
 =?iso-8859-1?Q?hO934GpM9iJv3BRcIz7TSmIweX3+j+IO/yWKSg5QFN7YOp133CY+VpsQFz?=
 =?iso-8859-1?Q?aGwUrLc/JkTEj39cmd+NSJo+gZs/Xz1Pq5YFhLOZGPoIPUv1FUsr+hcX40?=
 =?iso-8859-1?Q?d7lofh52bSOyXJJuXpLEnWuWEsBwdmfBnvMGjNHWcetgdYAxqpoSnogIHg?=
 =?iso-8859-1?Q?rOvhiuuT8o0r2LFBprW9LOCYZxLgC0b4p/P0zVznCyDAmFQ2iqK63hn8Bv?=
 =?iso-8859-1?Q?97pqtWmGEz040kxGbNoX952l9gnWlanE+kmU5DaUy2dbUZaqEbUPk3N261?=
 =?iso-8859-1?Q?ltlqlDas8+HBhkqPvHAlXGnDK8q4MNXyWu7zEG2XBO/xmBvHkzfln968q5?=
 =?iso-8859-1?Q?l1hmWq/PhizPNYfTM8tJdw+vOMT6UOr2/rQz5cjOED2PPHqMZiGKWLHqxy?=
 =?iso-8859-1?Q?caqqetK9jLwWwLLgV8GCrYwbfW7gEONuoFoGdqCXlI1lvj7iDj/IGxgAkq?=
 =?iso-8859-1?Q?PVCPEYRM1UFyGuUy7t/7SVHer+02WcXga/CYQ27hP4bW4TbDgleVeBVCJF?=
 =?iso-8859-1?Q?CSCex+jx/2ksW4vREOQ4aDefactjSCzWU72CauEcXc01/P20f/dK7blTAX?=
 =?iso-8859-1?Q?05mAeStStTduZjfDwWstedRPtzbv1oMF3hzzGazGUHjjjaeQ3RsKC7e13F?=
 =?iso-8859-1?Q?U6CmnXiQjwRx4rNjaD1lA4mJPbYG1pxSvRINX5SWuIWnrKVUPzn1hko3Ge?=
 =?iso-8859-1?Q?OvKDQPfzA+L3P9ERwhEa+ynh33ignmtzAfLFpsPgOFLU6diLJELAanwQcR?=
 =?iso-8859-1?Q?kOknsN4u1itQPjT6C7oXJopbSbhqTUC1Vex4sTOXSvaxXzKlk8AlVzsObP?=
 =?iso-8859-1?Q?b6zoarUXIWJQS//F2kH2Eg+UNLp/3JKv6/TkXSHpzUQwVbGeyclHdQA5Ad?=
 =?iso-8859-1?Q?9nmVMx+C83u/vbhX9QRaF8fA1muRxfx99dXCwj2ry52WglP8rU66XNO6I7?=
 =?iso-8859-1?Q?aTGFn6HIk8Jiy+xksrkQZpKdCpJH2dzPqvY6cDNWiI0gYymHc8ZCs5EsMY?=
 =?iso-8859-1?Q?Phrmxmp9BvslJaYLk9dKkWCHoFuk9j6V7xDB+svVDncbRUWrzYSGk1GKuK?=
 =?iso-8859-1?Q?YcPllM++Z6sawHa2yaTjHwVUmxqF83kC1BYilFrI1p03nOj0MFWJ4BXwIU?=
 =?iso-8859-1?Q?ZpneCMG0+axk4hbceCS3BArH90Hv5PzvA48NmMnyOzCv6T+qyhQMHQqA/t?=
 =?iso-8859-1?Q?+c2osccUlkFFFbJMgD0Sq933zL6XAFCrwHiT+a4bR318+t6DbUpZqoFNHE?=
 =?iso-8859-1?Q?FjvzC5XIyXc14URqBFBn3t0PiNA3OkrLk8dP4hNS+IW7/nd1HNf7Pv94AT?=
 =?iso-8859-1?Q?jSzzWKFcYvfQEvUB4JzOnvk9oJAfxPLo0eMTjCjc0383+ckL6x53?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: ac300232-318b-4c4c-39bc-08df164ca932
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2026 12:51:02.3022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UKmf0NnhdlSS2f5ikq5yH62F8a4y2yIocvVduqYNAiWvYcM9b6yY9VXN1JllQ1cTKXES/G/0EKaqdxXra4DgMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2971

On Tue, Sep 15, 2026 at 08:50:12AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Missing write memory barrier (dma_wmb) between writing capabilities and advertising QP readiness leads to a race condition on weakly-ordered architectures.
> --
> 
> commit b1a0deb57c0951e9f08d12fad27aa18c65b97771
> Author: Koichiro Den <den@valinux.co.jp>
> 
> NTB: ntb_transport: Exchange client capabilities at link-up
> 
> This commit updates the NTB transport to exchange 31-bit opaque 
> capabilities during QP link setup using scratchpads. The capabilities
> are passed to the client along with the link-up event.
> 
> Link: https://lore.kernel.org/r/xsaocp32a6siggahziu4jqbwgmdasmp6v64pd5aujfkoxhiqws@n5luestlntzc/
> 
> > diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> > index 0b47285ef48b6..ea89eb336472a 100644
> > --- a/drivers/ntb/ntb_transport.c
> > +++ b/drivers/ntb/ntb_transport.c
> > @@ -937,7 +942,7 @@ static void ntb_qp_link_cleanup(struct ntb_transport_qp *qp)
> >  	ntb_qp_link_down_reset(qp);
> >  
> >  	if (qp->event_handler)
> > -		qp->event_handler(qp->cb_data, qp->link_is_up);
> > +		qp->event_handler(qp->cb_data, qp->link_is_up, 0);
> >  }
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does this cleanup path
> contain a deadlock?
> 
> The transport cleanup work ntb_transport_link_cleanup_work() acquires
> nt->link_event_lock and calls ntb_transport_link_cleanup(). That function
> synchronously waits for nt->link_work via cancel_delayed_work_sync().
> However, if ntb_transport_link_work() executes concurrently, its very first
> action is to attempt to acquire nt->link_event_lock. This lock inversion
> can deadlock the workqueues and hang the subsystem.
> 
> [Severity: High]
> This is also a pre-existing issue, but is there a use-after-free risk
> when a queue is freed?
> 
> If a client frees a queue using ntb_transport_free_queue(), the
> qp->link_cleanup work is never cancelled. If the transport is subsequently
> removed, ntb_transport_link_cleanup() only cancels works for currently
> allocated QPs, skipping the one the client already freed. When the
> transport then frees the nt->qp_vec array, the workqueue subsystem might
> subsequently attempt to execute the pending link_cleanup work for the
> freed queue, causing a use-after-free crash.
> 
> [ ... ]
> 
> > @@ -1141,10 +1146,19 @@ static void ntb_qp_link_work(struct work_struct *work)
> >  						   link_work.work);
> >  	struct pci_dev *pdev = qp->ndev->pdev;
> >  	struct ntb_transport_ctx *nt = qp->transport;
> > +	u32 peer_caps = 0;
> >  	int val;
> >  
> >  	WARN_ON(!nt->link_is_up);
> >  
> > +	/* Pair with the release store in ntb_transport_link_up(). */
> > +	if (!smp_load_acquire(&qp->client_ready))
> > +		return;
> > +
> > +	/* Publish capabilities before QP readiness. */
> > +	if (qp->caps_spad)
> > +		ntb_peer_spad_write(nt->ndev, PIDX, qp->caps_spad,
> > +				    READ_ONCE(qp->local_caps) | QP_CAPS_VALID);
> >  	val = ntb_spad_read(nt->ndev, QP_LINKS);
> >  
> >  	ntb_qp_up_request(qp, true);
> 
> [Severity: High]
> Is a write memory barrier needed here between writing capabilities and
> advertising QP readiness?
> 
> On weakly ordered architectures, the CPU or interconnect can reorder
> consecutive memory writes. Without a barrier like dma_wmb(), the peer
> might observe the readiness bit from ntb_qp_up_request() before the
> capabilities land in memory-backed SPADs. The read side has a dma_rmb(),
> but shouldn't the write side also need a dma_wmb() to guarantee order?

If we need a barrier here, the existing handshake has the same problem. E.g.
ntb_transport's link_work writes VERSION last, assuming the peer won't see it
before the MW sizes and queue counts.

With normal I/O mappings, writel()/iowrite32() in .peer_spad_write
implementations already gives us that ordering, even with posted writes.

But pci-epf-vntb isn't writing MMIO. It casts local coherent RAM to __iomem and
uses writel() on it. That might be ok on arm64, where writel() includes
dma_wmb(), but not necessarily on other architectures.

In short, I think what we really need to do is not to add a barrier here as
Sashiko is suggesting, but to fix pci-epf-vntb's SPAD callbacks. With that fixed
in pci-epf-vntb, I think this patch can stay as-is.

Best regards,
Koichiro

> 
> [ ... ]
> 
> > @@ -2439,12 +2480,17 @@ void ntb_transport_link_down(struct ntb_transport_qp *qp)
> >  
> >  	qp->client_ready = false;
> >  
> > +	if (!qp->link_is_up)
> > +		cancel_delayed_work_sync(&qp->link_work);
> > +
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does skipping work
> cancellation here create a race condition?
> 
> If qp->link_is_up is true, we skip cancel_delayed_work_sync(). If
> ntb_qp_link_work() happens to be executing concurrently and gets preempted
> right after successfully checking client_ready, the concurrent link_down
> will set client_ready to false and clear the SPADs. When ntb_qp_link_work()
> later resumes, it will overwrite the cleared SPADs with valid capabilities,
> corrupting the teardown state.
> 
> > +	/* Stop advertising capabilities before withdrawing QP readiness. */
> > +	if (qp->caps_spad)
> > +		ntb_peer_spad_write(qp->ndev, PIDX, qp->caps_spad, 0);
> > +
> >  	ntb_qp_up_request(qp, false);
> 
> [Severity: High]
> Similar to the link-up path, is a dma_wmb() needed here?
> 
> Without a write barrier, the peer could observe the withdrawal of QP
> readiness before the capabilities are actually zeroed out in the SPADs.
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260914084838.2158249-1-den@valinux.co.jp?part=5
