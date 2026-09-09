Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020082.outbound.protection.outlook.com [52.101.228.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71A935C6BF;
	Wed,  9 Sep 2026 04:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788929882; cv=fail; b=oYGScdprCjUWru7N5lH5Ns74pxEAJAYASdcpkhHdX3v1hpLTEtKvJXeT6+bekzA86boIBBD8MQKiGTyfLp3eZTsX8zrrky1bXxIWwDJp8NV1IAs0ZdTvgmZnV8AZwjZpNOp5X2kNAt+isMuNh1ailrnQQty36BB+RrYiOLTKu/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788929882; c=relaxed/simple;
	bh=ESxhtPuMHyVUlVfxPUz4Tnk5hC4y6IAbkZ5a2WdhcwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Gkpj8jZt2bRkcFrU8sJ6eOHqieXSNjGQF4zBBeZa0cuqOW4OUyhH4kXcLjCWM5vvwiHnwoE7hkBGNWlyt50uQYCLP+1SCzRqhue8H3nyeIsnHpKH8db4F7Gerghm+a3ItzQS9kfW5703FcAPpGVSHaXGzDgWcJLAL+DN5HXlTkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=fail (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=QfaDL8fk reason="signature verification failed"; arc=fail smtp.client-ip=52.101.228.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="QfaDL8fk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yuAtbHtIF0bZX8CeLDaKWEAqI+yq2NbH0IItmxK41UTqckRSOErnAwTq1lh1i1HwVHLr5l/mabsp4HgdUoYbKjYDd3r4FmAYiRDOC49giir55DdSQlEZoE0bIBgxM2prk0mFuVMzWjCOi8e5z63vSjSxmNQOP7KZAugLR8Uhb6un76Mp7WMM6JBzMu9/HnQqOS8+evGp7C5RGko1BpNWwM91M7aC0ykV5omU0eDXgGiwBhAXSpAUQ3MiPvmrDT/luTL+6Xfonian52owh9WI+P/gOGQo4iRBxMcOqpKVyrazeYObR9L4gZ6+/rDI55gykbqc4sGu/NGUjwUtspig1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+hf3+rjq8YRzDPCu+foPmHud5FYKLVcunT7J2tfqPbE=;
 b=C2PcG79qvqkIc0Se8NcOByDJWaU/uTmnv49qvQvBWLA9ZVSgZlN4AMCK4CoQehURgU25X8kmZwuk26Z4IGyRPDxSCsvwx9Fis0zPspbBNcV+hqJFYK6sOmHDcm+w6PsAjViU+Re3NgFbZjl1QFd0535947SP2onAiNy02Ib+omWr+VjWa9DxmbCc86oN8q4QGtRKNaCzn+/sdp4eYcJIByPoHwKus1JGPWTGqVIED95rNMKHswSSNbOiPy61N4xnZ3fjUfPNtq4affH6Gv8eENf9+7TgqeJyBCYw91Rn4M64HX/itwsmbwARkq6KeJBx3NvoK53rE/eJXI9/HWecVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+hf3+rjq8YRzDPCu+foPmHud5FYKLVcunT7J2tfqPbE=;
 b=QfaDL8fkWz8weg51vqwv9gszF/I/rkrzDEHoUj2tPznxoXjkwoBE4k0FaBP4wvZldKa+2PSl5RqLG1OtHWPbgLgWQIGpSuOiQgXed8enX4IYK9EfIFmoDdeSMdDy0jfBoE/VhyQC453HoTNy2NNpiFiORwiw9vhRph9Cl4uLBk0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYWP286MB3589.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:398::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 04:57:52 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 04:57:52 +0000
Date: Wed, 9 Sep 2026 13:57:51 +0900
From: Koichiro Den <den@valinux.co.jp>
To: sashiko-reviews@lists.linux.dev
Cc: ntb@lists.linux.dev
Subject: Re: [PATCH 04/11] NTB: ntb_transport: Clear QP pointers when freeing
 an MW
Message-ID: <2k76wx2alhbgpoiao7jtwykbwyhyuqy23evkcqb34r74j45xae@qakpjue5lgvm>
References: <20260907142429.951930-1-den@valinux.co.jp>
 <20260907142429.951930-5-den@valinux.co.jp>
 <20260907144257.767281F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260907144257.767281F00A3A@smtp.kernel.org>
X-ClientProxiedBy: TYCP286CA0143.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::19) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYWP286MB3589:EE_
X-MS-Office365-Filtering-Correlation-Id: f1c38996-6a5d-42da-ed9e-08df0e2ee74a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|10070799003|366016|3023799007|10067099003|4143699003|56012099006|6133799003|22082099003|18002099003|20046099003;
X-Microsoft-Antispam-Message-Info:
	mWAXebgJA7FD6p9vT5j105yS+wxGJpRgDmlMlZXW2ORdAPFyHjzhYTs51m1yfZGnGkkVJ7Mvxu2E98eE0bPyA45WHDwqAYUDMr+a9R5fJJ5Lz7npLEFWhDtGxijoiypJcgOuSaTymxqK7XeWjr71Ktw/LAbQ6juLgyYL5geEXJLBAAZAIVRHEdnUtjuSA2QHIAKOvVh8/6W7Lqe3PNC/zU802yhsjPIZv6ghJUk89t7s09anJxmfK7D8c0AuvXDDzGqxwIgXNmtB/2EL8OBsnV1K/I9eTTEvLrsNOYf3FhX0MsmQickk6xNSsH7tPJc7Y4xXKJjlsMaF3jL7+3aO55k3NUqidO5l5d0P0MXX6q41DJ1Y5SzF3XR+1aXkL2xQpNv6U8GmOoIcINS20YJxX1+ZdDcTlDpt/evwmHmZutBTVKUKe69JntSaROK/z5joM4hdGYOTzk+luISnI1GPR/50Jpr9d4HX+41U0BkS6xsiKPcA2fswnTzM3gL+V3cZuX7+KqoXDex1ElJpdlIiRnK3yqpVa0d0PhhtQTyMj5nnUYde+QqYKwoAluZnWicXhl5I7KyU4UxLqiSXgWv2FnL77Tm+zeEJFZMYZTH6g9E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(10070799003)(366016)(3023799007)(10067099003)(4143699003)(56012099006)(6133799003)(22082099003)(18002099003)(20046099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?ROTTfJirCY8I9mdd63Kr7KtI4bt9MD9vRo5Rw9wJlCy7XnMDUy8hHwqp/4?=
 =?iso-8859-1?Q?ATQaUTqxjJtvRakYzPFarAEnz7hfAPRLUSyzGOIBuH1fmCNXgObSXgYzlY?=
 =?iso-8859-1?Q?iXTPv4yaiXxJQRMH6Rl//5HxUogSyS/qtFdLNuu5a5JmxkmxiPqGLrA8+D?=
 =?iso-8859-1?Q?L790qF1s3uE/4Sl/IonhGoMneSdya5WArg47dnVmtezxmWlq8EWFix14Y/?=
 =?iso-8859-1?Q?DxMPFDdII1PBprRIpt/qcKi6b3vm5eWvMkn6FmJyIGMjVMyb86KAhGmaFm?=
 =?iso-8859-1?Q?qfka7LbhIDapkHuMTtDFxSl5KewgzHYmkZz1isSLkrTgUVwMD/g8KWY7LX?=
 =?iso-8859-1?Q?AFLssIvhvj6czmVoKMk470l09NGFCAUljtSmK7p3TPMiDgKXeXHl9r21p4?=
 =?iso-8859-1?Q?Y3tWwwfw52p1nhb1RNlqjxZTg8FiI/40JqhrsqruJSRUarbl1J7woI9Gt8?=
 =?iso-8859-1?Q?6M+kvbsviB/IQ6FEA22jEiAyAVwl1WxXgwI+NE215txHlMQfPBVF+NQFc/?=
 =?iso-8859-1?Q?gR6tWm3j5oMTK6IO7eRUyM3IhtoIW1l8Whq2FB9R4/z9SSNPJyRqLGvVB9?=
 =?iso-8859-1?Q?mEfjVqIG3dbTAgGGgL0fUGDunsKn5dXE/2naNZVCB75sCI3V6sTiHHiCJy?=
 =?iso-8859-1?Q?PunV0kOWkSiI+Jde5l2wUgc1h6W8UxVnNkBOcnZBAmFnV7SVHbFV3o9bFT?=
 =?iso-8859-1?Q?10ckKjrYrPp3eNQpdQS/1MpZ24un5MDy+HiWj1RVVVGng0rZ7aWUZfnLc1?=
 =?iso-8859-1?Q?kDXtQQHQzqplA9xNueHu8T6ftPmCeJ3G1hO8gqfCxgm8eIlUIfD/5J+qIS?=
 =?iso-8859-1?Q?2/DDokfJh+nYssM+c/dS5XJhWxswcMTbvjKtmFdW5bEJoNUNxY+oerJm5Q?=
 =?iso-8859-1?Q?0HtWoY89QAxQddsYEW6trT8mFA2U0nMS++zKpemJkb5PRmg1s4dOgQZD6G?=
 =?iso-8859-1?Q?aYseUUJmqzwdhIGm12MhWwCbEoPEMK6/tzf1dv7q1fWtej0C+V4Cur8OMJ?=
 =?iso-8859-1?Q?SAhVhP/OryRSd8DHgD6A1RKeUTI43VCNAu1etzF0mRUHG9UZHxCR4ZlZbX?=
 =?iso-8859-1?Q?UMeKZUH+dmoLlJBtmsSrWTe9+6lBmP4Z4sSxCon3rezUPihBBYyTo6SO+5?=
 =?iso-8859-1?Q?FQnVrT8wvYq5dGvRC3Fi67lbN2ixt/T4s8OaV3NxuVjs1Bpv2zDdJX9WCw?=
 =?iso-8859-1?Q?bDiu3Oc+mK/A9Fg00Ggjk2vhhJlOkIkAzpGcjEcHMWEi1JGjrjE/Fy6Jnu?=
 =?iso-8859-1?Q?ILEMRT9fiGduY5H+lQDSL5KKRLaPScZO24ozY57YdMuornSS91E2yxPxdg?=
 =?iso-8859-1?Q?2mlSTF+WBX7tU8NQk8+tF/yr+IOZVFazI+VK8/EbZ1+DPIn9qPGakHZRn/?=
 =?iso-8859-1?Q?q2BCRsh6Bec4wsjwaFeZFZ6q9zGdOQyocAaD5yjjSYZ8q2yFAO+Zy1Dj4a?=
 =?iso-8859-1?Q?9O8HoGHiVSf0f/8upxlq/fSuFB70iNLzCF/4now3Sk5yGg4+jjGYdTx+dY?=
 =?iso-8859-1?Q?RL3msFwlpy1LXoS/fjG+SP7FxdTIb3VOspX72F2iAdv7rLqs6+iwRsPHgf?=
 =?iso-8859-1?Q?6A1Bb/4Y9+WCFrBVzQSOcIhf4/j9PzegXb2XW9cALKzeBhiXgR5tIoZwUE?=
 =?iso-8859-1?Q?GbYjHCbn9gU0reCX3FbiL++idRDzfwjR6q+XLiDtOhZsIrWFix4NcrBuos?=
 =?iso-8859-1?Q?J2i6HqvQ5/kuoGuXf2JdT3pRcDU3TW8vEgjAL+JRDB+r+thzcqzOXgFYE4?=
 =?iso-8859-1?Q?cRNggRRx5GtAKf+OP56Iw9DShzrLr6CXBLT8NjtJ+HZTnVvTaOWUUfuPBj?=
 =?iso-8859-1?Q?PKGU3IDB+gyR8HTUuuOvJG2u+fs9e+V9Rm56JQssn3edd1G3V/Cm?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: f1c38996-6a5d-42da-ed9e-08df0e2ee74a
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 04:57:52.2418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l3cd5izImUfWE+hMmcnCCToQsWOfJP4KkmCGmc8nJyNkHcmLdzAMx+l1giPok0yKD4iKdQm+xnatkC/PA9tItw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB3589

On Mon, Sep 07, 2026 at 02:42:57PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential issue(s) to consider:
> 
> New issues:
> - [High] Unsynchronized nullification of `qp->rx_buff` introduces a deterministic NULL pointer dereference in the asynchronous DMA callback.

In my opinion, the underlying RX DMA lifetime issue is pre-existing, although
clearing rx_buff introduces a new NULL pointer dereference path in the RX DMA
error fallback.

I was aware of this but I thought it would require a large restructuring, so I
thought it was better to fix the issue separately when needed, otherwise this
series would blow up in size. My patch 11's commit message says:

  This does not drain RX DMA transfers or their completion callbacks.

which is somewhat relevant. But as I said above, the possible NULL pointer
dereference can be seen as a regression, so now I'm planning to include the fix
in v2..

Best regards,
Koichiro

> 
> Pre-existing issues:
> - [High] The memory window (MW) DMA buffer is freed without terminating active RX DMA engine transactions.
> - [High] Incomplete fix: The nullification of `qp->remote_rx_info` is inherently racy, leaving a Use-After-Free vulnerability unresolved.
> - [High] If `max_num_clients` is specified and the peer NTB device has 0 memory windows, `ntb_transport_probe()` will crash with a division by zero.
> - [High] `ntb_transport_free()` manually frees `nt->qp_vec` before the `devm`-managed MSI IRQ handler is unregistered, leading to a severe Use-After-Free.
> --
> 
> commit 53bf2d568bcd99aba1ed7af64d8882df388ff574
> Author: Koichiro Den <den@valinux.co.jp>
> Subject: NTB: ntb_transport: Clear QP pointers when freeing an MW
> 
> The commit updates ntb_free_mw() to clear rx_buff and remote_rx_info pointers
> for all QPs using a memory window when it is freed. This is intended to
> prevent a use-after-free scenario where link-down reset routines write to
> freed memory through stale remote_rx_info pointers.
> 
> > diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> > index 944d38c7efd3f..763e4bb175a3a 100644
> > --- a/drivers/ntb/ntb_transport.c
> > +++ b/drivers/ntb/ntb_transport.c
> > @@ -764,10 +764,17 @@ static void ntb_free_mw(struct ntb_transport_ctx *nt, int num_mw)
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
> 
> [Severity: High]
> Does this code race with asynchronous DMA callbacks?
> If ntb_rx_copy_callback() executes concurrently for a completed or aborted
> DMA transfer, it appears to unconditionally use rx_buff without a null
> check. Could this lead to a null pointer dereference in ntb_memcpy_rx() when
> it calculates the offset from this newly cleared pointer?
> 
> > +		WRITE_ONCE(nt->qp_vec[i].remote_rx_info, NULL);
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does nullifying this
> pointer leave a Time-of-Check to Time-of-Use race unresolved?
> 
> If a concurrent thread in ntb_transport_tx_free_entry() locklessly
> reads remote_rx_info and checks it for null, could this thread be
> preempted, allowing ntb_free_mw() to nullify the pointer and free the
> memory?
> 
> Would the preempted thread then dereference the freed pointer
> when it resumes?
> 
> > +	}
> > +
> >  	ntb_mw_clear_trans(nt->ndev, PIDX, num_mw);
> >  	dma_free_attrs(dma_dev, mw->alloc_size, mw->alloc_addr,
> >  		       mw->original_dma_addr, DMA_ATTR_FORCE_CONTIGUOUS);
> 
> [Severity: High]
> This is a pre-existing issue, but is the memory window DMA buffer freed
> here without stopping active RX DMA engine transactions?
> 
> If the link goes down and ntb_transport_link_cleanup() calls ntb_free_mw(),
> the active DMA engine is neither paused nor terminated. Could this
> allow the hardware to continue reading from or writing to the physical
> pages after they've been returned to the system allocator?
> 
> [ ... ]
> 
> Looking at ntb_transport_probe():
> 
> > 	if (max_num_clients && max_num_clients < qp_count)
> > 		qp_count = max_num_clients;
> > 	else if (nt->mw_count < qp_count)
> > 		qp_count = nt->mw_count;
> 
> [Severity: High]
> This is a pre-existing issue, but if the peer NTB device provides 0 memory
> windows (so nt->mw_count is 0), and max_num_clients is specified, does
> this override qp_count and bypass the safety check against nt->mw_count?
> 
> Since ntb_transport_init_queue() uses the QP_TO_MW macro:
> 
> > #define QP_TO_MW(nt, qp)	((qp) % nt->mw_count)
> 
> Could this result in a deterministic division by zero during module probe?
> 
> Looking at ntb_transport_free():
> 
> > 	kfree(nt->qp_vec);
> > 	kfree(nt->mw_vec);
> > 	kfree(nt);
> 
> [Severity: High]
> This is a pre-existing issue, but does ntb_transport_free() manually free
> nt->qp_vec before the devm-managed MSI IRQ handler is unregistered?
> 
> Since ntb_transport_setup_qp_msi() allocates the IRQ using a devm-managed
> function tied to the parent device:
> 
> > 		qp->msi_irq = ntbm_msi_request_irq(qp->ndev, ntb_transport_isr,
> > 						   KBUILD_MODNAME, qp,
> > 						   &qp->msi_desc);
> 
> Could an interrupt fire after kfree(nt->qp_vec) is executed during unbind,
> causing ntb_transport_isr() to access freed memory and corrupt the tasklet
> list when scheduling qp->rxc_db_work?
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260907142429.951930-1-den@valinux.co.jp?part=4
