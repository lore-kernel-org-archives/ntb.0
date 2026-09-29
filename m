Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021143.outbound.protection.outlook.com [40.107.74.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5EB25771;
	Tue, 29 Sep 2026 01:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790644805; cv=fail; b=Oh1wRU6Q5DUXHSI4u2xoB9FzYdBYpi2L0/zml/OH5Tu15/Gjs/dbsGS4ByIasXtdxkg9/3XGo8lPiT8GEdNrVJG/Zttg8gzIhibDnY248QeUyvUsC22uCY3+v487DaMIk3i2hHQDuDgxoqoG78szyl61m00HVv2xcz9w9shR2wU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790644805; c=relaxed/simple;
	bh=gShpg0wkebfzltvJnNg8bDqb8RxhNgcGAgjIqf/EJck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NNV45vNdO753S/ZZcsPv2fOusUbe5BCHmoaKS398qXWhEXbfU3o4SULJzIVV2luk2PAIV7Z5mVR6jKNHy2QhVZlkt0HXZy8bZ/jyWnTw+rQ1T2hiugLyqjR3iibAlqqESGzoqmf6WSIbGwNrFpXHabRcVwUy34NZy4AqjmsDUYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=fail (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=JZ13gOSK reason="signature verification failed"; arc=fail smtp.client-ip=40.107.74.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="JZ13gOSK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MS90gka3yHnZ0HixdwXQO+xHMbE62n17dO5EW4HxlV3dQscJYNGFBMNAyVIznw8FMtBlK/1OJ2IttQv5YAvs7v+vquaU57DpOBUroRXZGvXTv9+4YSE/ZP0AUh8eMR1sDCGjpA3uJfxhRyDpNTSv6UDQtFavdlXPhJcc9zAKW/vQ+uFol1xUtnnoClDJhQWNjjGykTqv51btCyY4TT1oQTGZOPd7HZJ8c4tsgRr820Or3K7fQENyrN0KtsbNQMnaruOVNOK45qHIKgBk2aZkI8fhnPNpOjWXKEXV0TkTTeaWjsKK8TnFczfsLx3NNtUD4ntRsr2+1KBjA35k3cBf7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M1pdPbf9SGQNtVyYhH5Ef8I+sqRYgjdxvka4tYS490c=;
 b=LHrUOM768hjDq19LF8YG4zpz1vqPgbBad26PaJSMvyPeoYnCAaJqCK0MxlDi0QKXyS4esny04QMpZMroZAQRPW0aEQtgQXQtkPC3fLad71Bc2xvQTB49HOW3JBGPFjVH+OLS/m8IWvts15rJum0JBtCXLr39B4xMyoq4qDpVCvlCr0peyt8uQFXC87gHSI2qdIckkRQIaHBI4ynkq2PVoyufagl4IOg+QMltUHzLLHkuH4+15vBoM59JVfAHURg0Ub9nvNRHlIB2u/6VHHSvnUsG9/W6fiufdQzUWCL8h2T+3XQrmpsqI/Lbdlcp2/jnXdgBapFtVJF4D788vtG0/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M1pdPbf9SGQNtVyYhH5Ef8I+sqRYgjdxvka4tYS490c=;
 b=JZ13gOSKIfHyAkYdhblZCDotZWromaPXwI3nrf1Ej249WOC1BdwYhnALFIYMCbtcbnGHPOdtpWG1It9EovTgY0ZFuZAwQvC8DntP7H8lwpbj1IWK1WNSfiDopgp4/uaMRypi7mYIMOKytXsd4brundpHTYsgLUZWppP/Pksft8Q=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS9P286MB7839.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:46b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 01:19:58 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 01:19:58 +0000
Date: Tue, 29 Sep 2026 10:19:57 +0900
From: Koichiro Den <den@valinux.co.jp>
To: sashiko-reviews@lists.linux.dev
Cc: ntb@lists.linux.dev
Subject: Re: [PATCH v3 04/15] NTB: ntb_transport: Avoid deadlock when
 cancelling link work
Message-ID: <o6fymoslepqiu6jrcqwumhf5mlzzkw5jwzl4s6quhio3g4scwb@7xghdgcvtil2>
References: <20260928152550.3354675-1-den@valinux.co.jp>
 <20260928152550.3354675-5-den@valinux.co.jp>
 <20260928154306.C352F1F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260928154306.C352F1F000FF@smtp.kernel.org>
X-ClientProxiedBy: TY4P286CA0017.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::19) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OS9P286MB7839:EE_
X-MS-Office365-Filtering-Correlation-Id: 29e0ff2d-bb17-4777-dc17-08df1dc7c6ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|23010399003|376014|22082099003|18002099003|4143699003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	JoIdliM/oG5dumWJFjDi6rVAWHrc2e7PWZftijse0OE0NrwrSx6uYVudoHBecDiWUD0tblroc8rtEZZTL+Ws2fH0QoKF8bkqptxWGehKeUwF0siIIm7gTIjckBaPr82CqCA0483ITbE14U7+Oj9f7FpYpcCPRNVnaCb1c40LSjUmsKRLOznhYOO6F+Q6GRII4T3R84O5x4imydWsZw25Co8kCFQzJHrBKRraGv8uPHB0IL6nZ9oocZ2DXNayqu299ElohWcN97L++i1Ww+uqLdO9qO+k3170foXmzTeTiv1M3I8avndSlGSVhd21RfOMX+7eyz0ZLeJUPlS6pCvyxJ5RnDuH9zqrpnjcBbt4oy2EQlqKX2OEov20QQAoqzl+7iSaSwLJsfyV1N/J84GONoPgKDRXwfsU434xRkSH6I2DImcuQ89rIAsBUIsxIi23WIghfuyb7oOaz66SOmx32VGkXr07v26Z0p8D69skdg7Slm955pN8ofbQ7GTc9eNluYIM3yB61EZWzIAi/LuVMJGTnK2xBcwGP5gToiPM/2vQZsCiBXyJpwnNm7zOlvQGdPW0mn6yC0MPwX34pmn722jUm8VoCok2sn2oNBdAatg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(23010399003)(376014)(22082099003)(18002099003)(4143699003)(56012099006)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?/nkYFq9rbsZ2k/xcbwhY5KTRWJpKjDgAy3ZC1unnb87DsYmEc033uNt+PJ?=
 =?iso-8859-1?Q?FtD5vAxYztPKTVdqOeM9Rj2UvfUU7fRlCFjagUKmAw8lXO/3dMRKZ7ZKgy?=
 =?iso-8859-1?Q?X1R35VoIL2bjnvG8yBN2CXfpwhcgCvzT0ZDJOg+pNa/HcQezTvVq7LbSMW?=
 =?iso-8859-1?Q?ZH2D1gns4hhGmiRZ2xMcyMvfz0zRjBijtqB82FG7/UI4ctZFI5QByr4sH+?=
 =?iso-8859-1?Q?L7MmhI0h0Bp645IB7J2R85rePn6gZfWdLNAKWOGmalIuK5b0rd960wL88r?=
 =?iso-8859-1?Q?z0F9oW9rBiK/GCmzBF73IgCk2JhOYTDYmLljipIOi+p1wJtB26QlN1sl+Y?=
 =?iso-8859-1?Q?MPMx5xKvV2e8rgHy6A9UiboKtZh1XQZMrVhmAnbbhUzAK+zjtQBshs7wgU?=
 =?iso-8859-1?Q?lw6LET99u3Zpi2F7yFdAQcqEVt7HbH0DQoH8W/cvlFEbcz+xNBHSJbnD8M?=
 =?iso-8859-1?Q?teolsTHONsoiFtQueccxUcb19gAbRx3treC6/1tqxOgkY/OoX9F9U5CBbI?=
 =?iso-8859-1?Q?LL51AA+ZwJo7T3CEY1QMjak9T9d6aMN+F2FhMB539WGF2oGcDM6jOiAKck?=
 =?iso-8859-1?Q?e+6Jh0lPQ55tDCCksn8pH4tHswiusSDPRJPzmj2xoWbqrpP7x9TSWDnwnP?=
 =?iso-8859-1?Q?+LQqkY+ipm0B45EqzL+Wk2z+HRjHB3qklSjkSTGgbOvvJ+CQ5f+0gfSQkK?=
 =?iso-8859-1?Q?q7JobQkP6mFyAlvQ3/aIOk3wV9IyLfYUISwzFEY6Fhf+zWS3JBbFmT5G5n?=
 =?iso-8859-1?Q?sODC0BK1QVfFGWZ5VGnEjk64E73Au2XNGHIuGBXw0X87nI/YaOtdX68Y4+?=
 =?iso-8859-1?Q?D4h9eljIY9qPVepcJ+++3+GcS69ck1hup/fbdXHqPC+E002oNVoeynzYFT?=
 =?iso-8859-1?Q?hLDvi69gChaLXVHlFCdGVHXGxTmYW5VCW8EKsGM+a2sEq8J14F8L4eVbgR?=
 =?iso-8859-1?Q?8EMkhSO3p5CAbZNtWY+WIK8NEo/qKi/IIIxoDssAbFJG+SETmx0y+pPfKJ?=
 =?iso-8859-1?Q?DtuCP2YosRYM8r11hdAPQ+dtIBhjEj/CUy6F5+0E5fYnoVaAmIoSOWLekm?=
 =?iso-8859-1?Q?1UhSPQPBMagmgcQJE5kj5aNLyAb5SaIygRDc7wBv8zQP6YMMx7DrJaKKZH?=
 =?iso-8859-1?Q?GS1PiBmgOSIeichc6etoJozXlEy725e3/NAgnfgIpr5xUSV/oW2W7DoC+/?=
 =?iso-8859-1?Q?xNL5UxJ5lBJRZqzbtLHL14jaTWyobFa6Ubz8op5I6NCXBS2GTIiYzBJPFe?=
 =?iso-8859-1?Q?uIxUSvDF9pYe/53G3UBtCGZv+uC00vThnsAFXIxHJ68MyY6Td3qu7NGmEO?=
 =?iso-8859-1?Q?MSUivtSewXjHupdALKhn388gXeOxVNYY2a35CFEUJLqC2PLaJw2QRqAMqr?=
 =?iso-8859-1?Q?nZu23IbS8fBOTU7I7Az+VSn67D5ZUJd6OKbHrHrGpp631qX/+YZ/dqozE+?=
 =?iso-8859-1?Q?qz0D3H2xhxpq4BeFaNMXXJ4VJYZsGdy0ryc+qCaJ9gIeOS+hHudla0quz3?=
 =?iso-8859-1?Q?+DXhGU6LhouQglzu77A07eil4wQAbvakWxsBgTj31MV19M3GpRObZBv2tS?=
 =?iso-8859-1?Q?lM/aK71G3f6dMK8dKiICL7x6b7bsgWE8k7fm4dhkbPq+5S0ZbKap14h80r?=
 =?iso-8859-1?Q?spaI7ylfLgOtia2cYNp+njM+xFCMBk1IgopyyMavQcAVyr2kL3wi4Xhd7X?=
 =?iso-8859-1?Q?qLqak2wvpoeVZNcI+iPgOC6Y/89mgPyhKJc2KWryv7g/jD0pvxTrJcM1DJ?=
 =?iso-8859-1?Q?roPHCxs+8R4ccDFhCLd5A5JAZb5rXwcxjpNKIH+kwnIcFN4MWRMP4vnLrV?=
 =?iso-8859-1?Q?wvh1c/v/NkAGTAAvOANuIwuOtIH/8pw3fqlc+9V1M/EntDQ5azLJ?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 29e0ff2d-bb17-4777-dc17-08df1dc7c6ea
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 01:19:58.4627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i48qaFLIykDrpnZWSl/A76r0emgtrwj8AKIanSHb7I3gS5b30SxznVPYcccCcnfRM/nTmfALg8KYuS1bugyE7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB7839

On Mon, Sep 28, 2026 at 03:43:06PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] ntb: TOCTOU race in link cleanup permanently breaks link
> --
> 
> commit 8d90bddbec3eab6d6adeb7ec37e857cc536bb4d5
> Author: Koichiro Den <den@valinux.co.jp>
> 
> NTB: ntb_transport: Avoid deadlock when cancelling link work
> 
> This patch moves the conditional cancellation of the link work outside of
> the link_event_lock to avoid a deadlock when ntb_transport_link_work()
> retries. QP cleanup and MW release are kept under the lock.
> 
> > diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> > --- a/drivers/ntb/ntb_transport.c
> > +++ b/drivers/ntb/ntb_transport.c
> > @@ -962,6 +962,11 @@ static void ntb_transport_link_cleanup(struct ntb_transport_ctx *nt)
> >  	u64 qp_bitmap_alloc;
> >  	unsigned int i, count;
> >  
> > +	if (!atomic_read(&nt->link_is_up))
> > +		cancel_delayed_work_sync(&nt->link_work);
> > +
> > +	guard(mutex)(&nt->link_event_lock);
> 
> [Severity: High]
> Does moving the lock to after the cancellation check create a race condition
> where the link state can become permanently broken?
> 
> If the hardware link flaps quickly, ntb_transport_link_cleanup() can be
> queued, followed by ntb_transport_link_work(). When
> ntb_transport_link_cleanup() evaluates the condition here, it might skip
> cancellation or cancel an old work item, and then wait for the mutex.
> 
> The newly queued ntb_transport_link_work() could then win the lock,
> establish the link, and drop the lock. Afterward,
> ntb_transport_link_cleanup() acquires the lock and unconditionally tears
> down the newly established QPs. Because the hardware link is already up,
> no further interrupts will arrive to restart the software link, leaving
> it unresponsive.

Same ordering issue as discussed in v2:

  https://lore.kernel.org/r/k2dsuf5c6ld7xdovnaavk5semqsujcrfrbihguyoagjtfr3lyu@vka7awtbihpe/
  [...]
  - If link_work wins and completes setup, cleanup can tear the link down again.
    The old code also allowed setup to run before a pending cleanup though. In
    that sense, although Sashiko flagged it as a new issue, I believe the ordering
    issue itself is pre-existing.

Best regards,
Koichiro

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260928152550.3354675-1-den@valinux.co.jp?part=4
