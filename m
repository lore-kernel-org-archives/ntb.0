Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011004.outbound.protection.outlook.com [40.107.74.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1623B27C84E
	for <ntb@lists.linux.dev>; Fri, 24 Oct 2025 16:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761324099; cv=fail; b=nUPW8ShHxhrCTs8UK17HhWs1ewXHeDsA4SOzWrLujTlm0MrHqdQxWF4v8Nll0CqPArJ3dfDBL+1MrJKBSW0q8c7L2AB9DJZUOkqyk6/Lpwj86IVXFuXYOZa7vDMxw9j8NF7spA1Js4ZmBQ9o8XCLwyKtYM2EySZcgMsqqluHBDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761324099; c=relaxed/simple;
	bh=i1zCE14S8uZXBR0/k7LBzBKJ0AO+UZ39qbitj1874nU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ViyyX9EhATVlpJbPCPFSPBpBogKq2gIdqxX+UqKogZQomvitlTLID+vMavyKgsh2VAhYGAJgXKW163qqKJQ/6k8FYcsWX7/V2RndQ+wB/GLbpsAsaNat/Szc4FjNAxz15MTpTg2zaFb7tO+S4p8vwIb0z2yOPtIjSf+kGW6RJog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=NuIgeArG; arc=fail smtp.client-ip=40.107.74.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="NuIgeArG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fdG9B3HWCmpuT+SPPkHhhpc5OtG/e6xlYBs2a69Xe6bEoqMclFpCQFBfvgHbNpFdKJFiQjUDLI+8nhV2IAA3INaN+zRapHy267W4HWb/t251YCyzpgAFbjmTSdMWi0WprB+IUdWp2zxIylWifagFfIUs727Z1/jJSxEz79LCTbdGxf4aN7amGpCr67bb4Ab9dGAarsAnZhSTwmH+LFEEShgoa/dQzX5Cgi9i6XEnavMBaxsKdtJtOSoUkeBhRdygQ+NhG6fZNduv1jfrv2IvnlX+EKgr/7P379qjRViZV0Dw0f5TDOWcC2+kgxG6+gqgkDXSmOtE9JGRJHXGdngabg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QEpksJx1eztG6v2sM7aDSeSuqob48CVk5ErPhKIZ8JI=;
 b=uKWq6j1FOP9UtQqhYfaYDkh3wQROMcCUu4/yjfHKH/FXfg6dyRQFttfyykZOBoSU0AjSj/oKK8lYLfi8PfldbogmfNN/9bvp5CWfV54y0n0nrN2PelD8Q96BuDR9Y+BlXVg4WhhhXqYfahLGwKgUspaata3NEL/6QNxXjeuK0U1URtATUJpaMh++ivOG31IyBDXjESjWNhfMovU8Oi4CBBsMvIsBtI0jjwwupkEbNTDfS/LLM1gCw8beKy/l91UuOLpQzAxoeZxa5i14pmz0anZZQ8pGum8OgE1J6AhHKr2yFOoTqsz3r4crgf93X++v6Ny8c3mn9fuabRUOfj73jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QEpksJx1eztG6v2sM7aDSeSuqob48CVk5ErPhKIZ8JI=;
 b=NuIgeArG2fa/Y3RkFgEwyrQBmCNWb8NYTkkPTSNVku6fNWhTktiHUBhATBsKxV+cvjiHsNHx2EqmR0quMaWmb1sfOMkZnOLMvtZDcpiqK9HOjWhV0F1iCma1ro5wlav8K/woXQCnTJwKUsWwnAwERiT4xaiLx10HgIrPsvOZG48=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:10d::7)
 by OS7P286MB6237.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:422::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 16:41:33 +0000
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a]) by OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a%5]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 16:41:33 +0000
Date: Sat, 25 Oct 2025 01:41:31 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Dave Jiang <dave.jiang@intel.com>
Cc: ntb@lists.linux.dev, linux-kernel@vger.kernel.org, jdmason@kudzu.us, 
	allenbh@gmail.com
Subject: Re: [PATCH 2/2] NTB: ntb_transport: Add 'tx_memcpy_offload' module
 option
Message-ID: <t4u73ozmucboxkml5p3xss44aafvr23hisewq3qvpgp7lbpx5y@f2haptgd2wzu>
References: <20251023072105.901707-1-den@valinux.co.jp>
 <20251023072105.901707-3-den@valinux.co.jp>
 <b7a5ed5e-f4ca-4045-a956-73594a286fee@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7a5ed5e-f4ca-4045-a956-73594a286fee@intel.com>
X-ClientProxiedBy: TY4P301CA0088.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37a::9) To OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:10d::7)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB0979:EE_|OS7P286MB6237:EE_
X-MS-Office365-Filtering-Correlation-Id: da3f7898-70e3-40b6-77ed-08de131c3096
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f1uXQrtJXDrq5iLvGW0HThxhPur927SdTlT1vTH49VnO34+qMx+YPOoF8GOc?=
 =?us-ascii?Q?FxW0GlAPtPamMEr+uM2tvtG8dr/6dTf8RO5LW6SsTFtk+l64W3PTxuPGnr/B?=
 =?us-ascii?Q?y/KsB5hdM/KCpslSeQentZWxCrYvvKAcGdSouZ7khxw7yP9J+TfmhBBWLx0q?=
 =?us-ascii?Q?Nz4KzHw6+8jnfrz3n8Gv9Ln3Gr9MkRyal0lpw0YjtnMnUgh9rFp+FsWoeJ0u?=
 =?us-ascii?Q?PY1UWabac8cuZvffuqulpbCLsFQ7sBF5uedS5rpEBmthIoSGJf6NdmxVA5kY?=
 =?us-ascii?Q?5uIY3wvlY6I/wyAkBTIBlLSIwLMXps/p735rboTss1gDeFuSxFZCYMhinuE4?=
 =?us-ascii?Q?LC6NX5Iwjhj0vSCuuuHzxlwLKMtmQjRjUF8sfRQer60/sWZb2h+jAqAtJrw6?=
 =?us-ascii?Q?clkAa8grIDL2i/YfnCOeoOlScObyjmlYIvT+1Bs/5oxvlMR2JLbUrAP/VWh4?=
 =?us-ascii?Q?omkjbgu14D7ODVmyokGD2h1twuUDh5mVVzcf2YA4SKhkFo/8CQQnf/0+6swA?=
 =?us-ascii?Q?8mof1ega6YKwvCXDLMp2j6BM7fV2AIKgMFdpAZuyCzjFB8LIbBvYVCX2LpDW?=
 =?us-ascii?Q?AJZnfCilAo1tS7kHABv7zDajL4kniN9cVrOt25ODGPwn7d6OCMdLYeBc8uEc?=
 =?us-ascii?Q?uMpuqShwOvc9XQiIqjc7c1cfuOteh3NPF8tE/J5bmGRX7Bje8Eexp07b8Vn0?=
 =?us-ascii?Q?/OZOrvRnAcs3L1mayJggcC72q+EBdP2B0Y72mIqnjOoCg1vs26feAT9SLH/a?=
 =?us-ascii?Q?Sd5EcO1cqZ6uLVfNdav1LENsPXblrIQC1tQIHNgRrcuMqIY34vxvam0WUdUX?=
 =?us-ascii?Q?gdLG8AsF4AFS30wWmcuz0o2LRRIUwM/2vDZAQLMElSOG0tmHMxqahvEVahDs?=
 =?us-ascii?Q?LpL2T1730p7FUwVloZywlQ1i2aTTerFUIgQIOFXsRtlffvEU2VOpogvZ+fz3?=
 =?us-ascii?Q?lFSTpTiE41koA34rIrVU9eBQ1IO2gDcBzWipYIVs3diksgPXEOi5tCq0XC+2?=
 =?us-ascii?Q?XjvYBbpoV7sbXgOHqrdA/WGy+8y3pKzmJ3audFCm0zqjtT+YkVDhWericZCV?=
 =?us-ascii?Q?v9crgJHwnimH+Rc4OBBbUwXYy67gQPIIjjqvu9hCFUcffXdbhicYqulQPcuV?=
 =?us-ascii?Q?1I2G2xjEhirM9xHSZyb62lKZ3EBWdgtPJkHRbQs/VAFm2WivFNszCZljo1yN?=
 =?us-ascii?Q?aDCq1TuhJBKVlCMEIHa3faOES3H6FGPZSTLULrS/hmLC2o77EV9ONU3ZfQYg?=
 =?us-ascii?Q?cV/7pfmHRCGqMUSg3f3DbHhSzKf8y5Yr+g59l/s08O5MxJxBn7cFllgJGCHU?=
 =?us-ascii?Q?MoCAqWwiTB/YmGEmO2T6lGjRqwzJdOFTf7faB8escNux40A4lUz3sMBfTHaH?=
 =?us-ascii?Q?Z0nV12plpjPOoGj5u1kFVOrRXdBcV9m1CJHK+ZuwbspCmBev5DVe9nJIXc+7?=
 =?us-ascii?Q?Pms1TQ3+C82H2MfhGMlgvnoiHNo0IaJC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8KUMiMZ999wOLdZOevTJCN89g1FNPP0btmtjDjpV6EE2dL8dqZtPCK7wiJR0?=
 =?us-ascii?Q?l/Lv46CsbeXH96buOhvJnB8SUZdVTNi+gsn/7N2RpzgwlyCy8YR5s5wwH+tC?=
 =?us-ascii?Q?dC7IeebW9Fbx+5pU9yQGhNFumP4OCTycFp04RKrb5pVnxkMgV+xk5UsT6QGk?=
 =?us-ascii?Q?iT7LJp0zfKdymqFf+Fgx0Qte2MUwN3BVzJYlRhoYYfsvm0MzR4oViYE+4YYn?=
 =?us-ascii?Q?iCI4OA/lfqN5dFSi8giU29H5VrWWXcW/2Bj7t2WhKdIFIFD+zqGXJ0S8Ba6y?=
 =?us-ascii?Q?43xG5FKJH2uu3lHXH9IwHejWhdlVR43rxwtun/oHQp0LGMLdqcht0G2pmVPI?=
 =?us-ascii?Q?H1LhSkbJbcLOXqCdCxmCWS01TuNYmoGSPsKTr2cJXyqE7xhP7T14QtkuYSG/?=
 =?us-ascii?Q?NwcQ3yL6/VBuUNhhSmbhHxeuKF+uXuTFdrXq4RKVuuAEiTZeSx7uRfyaRdXw?=
 =?us-ascii?Q?KWz1nWmXXL4Tyo2r6DM0kwRLyp4HiQ59JbfHC1ZCZLCMtrWI1LcXa/u910QG?=
 =?us-ascii?Q?Sn+SusBwnzj4u1r4N+gtu9F3dg2ARTJYq635xuHm0bnOiPQhz/xU52PborpT?=
 =?us-ascii?Q?ES5hPD40nE/AtKbESs+4d1FDxchXF/m2rlcp1cUltB+3kQoBwXGXNqbeFb3F?=
 =?us-ascii?Q?FCoZtMNaJoTZav44bK1nnOVRlGIDz1KfgU+1XX0o8WQGmrZMwpDPeXC7eLuP?=
 =?us-ascii?Q?dY0G27z1xQAt9IUQd46Dcb7ckY/YUVmSppJDSjISojdNCd2CCv261T+pYzCR?=
 =?us-ascii?Q?XlZqXx/6ZsudgSpeRgBjD/ZUjd9arPGsqlwwbu6ab60uf4z8COeCPTSaaw18?=
 =?us-ascii?Q?OdCuz/RyveqcyCRA4gQdk2y4Uj1ZKpYRU5NcYN+oTMgaVYuw0Pm7O72GDe7u?=
 =?us-ascii?Q?uaqGlBkp7f6P4deM6kPvJruto8uyYmc2tsX7w4keKjQAL//Hmy74tIzPqm/l?=
 =?us-ascii?Q?dTr4iBdt+1V0QbqBTO+q+0cwuoq6262Vs5X5sUxkJoVZtUJU1F8b2B3Xm9oU?=
 =?us-ascii?Q?L2U8NEv2ihSvX6YRgM1qTO4vBf/YF4095M+YmAGlcdjStIWZRYPWzY1hYoTc?=
 =?us-ascii?Q?E2r/xC+G/sJ05z70DYWMYDA6NMn8HRGHAI6Ter21ZOnIuH+qZX8+dXWXFr4A?=
 =?us-ascii?Q?EKpoHCmszJ8S+tFqclXQxf9dqdsut/06NBbj8lqJMq67YFVVb88cumyQgvxd?=
 =?us-ascii?Q?lgcztQZhjKAtWINXy7UUVcS6tAJhdcDTdarBNUHfdeHcZGMCZwsQ4n1sroN2?=
 =?us-ascii?Q?k77gEcJqQ/ddXmG6+zefrvaE/FwUbYLCOL2F9A0jsSI4nG6CekeFv3bH3MPn?=
 =?us-ascii?Q?APUpy6qjNiRjTepLuyEpWT4ZMrV1mlgF9frmKEhs+9hbsHkj7KLXMVQH3xyV?=
 =?us-ascii?Q?YA0RBBAzegAbkm2BEIzTY+Jurt0CEH4GtbYZyqPlUWTZkGdHV51YVrboNxFU?=
 =?us-ascii?Q?JLboTSXSErJXEZ47mN7Y7/oD36qNdIc/hna+8oYznlnTHV+1VmXiSZ7dJXQ2?=
 =?us-ascii?Q?ijkiBNFJHyqDV0hZ32fDKwAst40YI+spOPBrv2Gd67gG+bbeZ2Iw+iA9ZD/p?=
 =?us-ascii?Q?p6KwLyqFRorqzSr22WHHTTVgVP3hBz7RiXxqaWCKAm+woQR4sofD8yvIWr8o?=
 =?us-ascii?Q?r09a1CBL1rEWR+AsYEVPaiU=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: da3f7898-70e3-40b6-77ed-08de131c3096
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 16:41:32.9762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F9dzZ/ZDDzVEENzdakclwFZzQQobLaI+SmCxMHGb4qjJbIij6FBVat5Eh4zKmJbIhE/PR3Ys57bI063Zvo3Cng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB6237

On Thu, Oct 23, 2025 at 08:18:07AM -0700, Dave Jiang wrote:
> 
> 
> On 10/23/25 12:21 AM, Koichiro Den wrote:
> > Some platforms (e.g. R-Car S4) do not gain from using a DMAC on TX path
> > in ntb_transport and end up CPU-bound on memcpy_toio(). Add a module
> > parameter 'tx_memcpy_offload' that moves the TX memcpy_toio() and
> > descriptor writes to a per-QP kernel thread. It is disabled by default.
> 
> please add comments by the module parameter that if this is set, tx DMA is disabled (right?).> 
> > This change also fixes a rare ordering hazard in ntb_tx_copy_callback(),
> > that was observed on R-Car S4 once throughput improved with the new
> > module parameter: the DONE flag write to the peer MW, which is WC
> > mapped, could be observed after the DB/MSI trigger. Both operations are
> > posted PCIe MWr (often via different OB iATUs), so WC buffering and
> > bridges may reorder visibility. Insert dma_mb() to enforce store->load
> > ordering and then read back hdr->flags to flush the posted write before
> > ringing the doorbell / issuing MSI.
> 
> Can you please split out the fix to this issue so it can be backported to stable?

Thanks for the review, and I got it.

> 
> > 
> > While at it, update tx_index with WRITE_ONCE() at the earlier possible
> > location to make ntb_transport_tx_free_entry() robust.
> 
> Please also split out this change if the intention is to address an existing issue and accompany with appropriate justification.

This can be omitted (as far as I remember the part did not lead to any
severe issues) so maybe I'll drop the change at the moment, thanks.

> 
> > 
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> >  drivers/ntb/ntb_transport.c | 104 ++++++++++++++++++++++++++++++++++--
> >  1 file changed, 100 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> > index 39b2398b95a6..f4ed616c6ab8 100644
> > --- a/drivers/ntb/ntb_transport.c
> > +++ b/drivers/ntb/ntb_transport.c
> > @@ -54,12 +54,14 @@
> >  #include <linux/errno.h>
> >  #include <linux/export.h>
> >  #include <linux/interrupt.h>
> > +#include <linux/kthread.h>
> >  #include <linux/module.h>
> >  #include <linux/pci.h>
> >  #include <linux/slab.h>
> >  #include <linux/types.h>
> >  #include <linux/uaccess.h>
> >  #include <linux/mutex.h>
> > +#include <linux/wait.h>
> >  #include "linux/ntb.h"
> >  #include "linux/ntb_transport.h"
> >  
> > @@ -100,6 +102,10 @@ module_param(use_msi, bool, 0644);
> >  MODULE_PARM_DESC(use_msi, "Use MSI interrupts instead of doorbells");
> >  #endif
> >  
> > +static bool tx_memcpy_offload;
> > +module_param(tx_memcpy_offload, bool, 0644);
> > +MODULE_PARM_DESC(tx_memcpy_offload, "Offload TX memcpy_toio() to a kernel thread");
> 
> Offload typically points to moving an operation to an independent piece of hardware like DMA engine. The naming can cause confusion. May I suggest something like 'tx_threaded_copy' instead to make it more clearer?

This really makes sense, 'tx_threaded_copy' sounds really fit. Thank you!

> 
> Also to make it easier for people to understand what this parameter is used for, please include a comment block explaining why this parameter is needed.

Got it, I'll do so.

> 
> > +
> >  static struct dentry *nt_debugfs_dir;
> >  
> >  /* Only two-ports NTB devices are supported */
> > @@ -148,7 +154,9 @@ struct ntb_transport_qp {
> >  	void (*tx_handler)(struct ntb_transport_qp *qp, void *qp_data,
> >  			   void *data, int len);
> >  	struct list_head tx_free_q;
> > +	struct list_head tx_offl_q;
> >  	spinlock_t ntb_tx_free_q_lock;
> > +	spinlock_t ntb_tx_offl_q_lock;
> >  	void __iomem *tx_mw;
> >  	phys_addr_t tx_mw_phys;
> >  	size_t tx_mw_size;
> > @@ -199,6 +207,9 @@ struct ntb_transport_qp {
> >  	int msi_irq;
> >  	struct ntb_msi_desc msi_desc;
> >  	struct ntb_msi_desc peer_msi_desc;
> > +
> > +	struct task_struct *tx_offload_thread;
> > +	wait_queue_head_t tx_offload_wq;
> >  };
> >  
> >  struct ntb_transport_mw {
> > @@ -284,7 +295,13 @@ static int ntb_async_tx_submit(struct ntb_transport_qp *qp,
> >  static void ntb_memcpy_tx(struct ntb_queue_entry *entry, void __iomem *offset);
> >  static int ntb_async_rx_submit(struct ntb_queue_entry *entry, void *offset);
> >  static void ntb_memcpy_rx(struct ntb_queue_entry *entry, void *offset);
> > +static int ntb_tx_memcpy_kthread(void *data);
> > +
> >  
> > +static inline bool ntb_tx_offload_enabled(struct ntb_transport_qp *qp)
> > +{
> > +	return tx_memcpy_offload && qp && qp->tx_offload_thread;
> > +}
> >  
> >  static int ntb_transport_bus_match(struct device *dev,
> >  				   const struct device_driver *drv)
> > @@ -1254,11 +1271,13 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
> >  
> >  	spin_lock_init(&qp->ntb_rx_q_lock);
> >  	spin_lock_init(&qp->ntb_tx_free_q_lock);
> > +	spin_lock_init(&qp->ntb_tx_offl_q_lock);
> >  
> >  	INIT_LIST_HEAD(&qp->rx_post_q);
> >  	INIT_LIST_HEAD(&qp->rx_pend_q);
> >  	INIT_LIST_HEAD(&qp->rx_free_q);
> >  	INIT_LIST_HEAD(&qp->tx_free_q);
> > +	INIT_LIST_HEAD(&qp->tx_offl_q);
> >  
> >  	tasklet_init(&qp->rxc_db_work, ntb_transport_rxc_db,
> >  		     (unsigned long)qp);
> > @@ -1784,6 +1803,13 @@ static void ntb_tx_copy_callback(void *data,
> >  
> >  	iowrite32(entry->flags | DESC_DONE_FLAG, &hdr->flags);
> >  
> > +	/*
> > +	 * Make DONE flag visible before DB/MSI. WC + posted MWr may reorder
> > +	 * across iATU/bridge (platform-dependent). Order and flush here.
> > +	 */
> > +	dma_mb();
> > +	ioread32(&hdr->flags);
> 
> Is dma_mb() needed if you are also doing an mmio read? Read can't pass write with PCI ordering rule and the ioread32() alone should be sufficient that the data has reached the destination host.

I experimented with (1). ioread32() only, (2). wmb()+ioread32() and (3).
dma_wmb()+ioread32() on R-Car S4 Spider boards, and none eliminated the
issue. Only dma_mb()+ioread32() did.

So this suggests the problem is in the pre-PCIe domain. The DONE write
goes to a WC-mapped MMIO, so the CPU/interconnect may still hold or merge
it while the subsequent MMIO read gets issued first. In that case the
MRd/CplD does not imply the earlier store has even reached the PCIe core
yet. dma_mb() orders and drains the CPU/WC side (store->load), ensuring the
write is at least at the PCIe core. ioread32() then performs the PCIe-level
flush. Please correct me if my understanding here is off.

-Koichiro

> 
> DJ
> 
> > +
> >  	if (qp->use_msi)
> >  		ntb_msi_peer_trigger(qp->ndev, PIDX, &qp->peer_msi_desc);
> >  	else
> > @@ -1804,7 +1830,7 @@ static void ntb_tx_copy_callback(void *data,
> >  	ntb_list_add(&qp->ntb_tx_free_q_lock, &entry->entry, &qp->tx_free_q);
> >  }
> >  
> > -static void ntb_memcpy_tx(struct ntb_queue_entry *entry, void __iomem *offset)
> > +static void ntb_memcpy_tx_on_stack(struct ntb_queue_entry *entry, void __iomem *offset)
> >  {
> >  #ifdef ARCH_HAS_NOCACHE_UACCESS
> >  	/*
> > @@ -1822,6 +1848,54 @@ static void ntb_memcpy_tx(struct ntb_queue_entry *entry, void __iomem *offset)
> >  	ntb_tx_copy_callback(entry, NULL);
> >  }
> >  
> > +static int ntb_tx_memcpy_kthread(void *data)
> > +{
> > +	struct ntb_transport_qp *qp = data;
> > +	struct ntb_queue_entry *entry, *tmp;
> > +	const int resched_nr = 64;
> > +	LIST_HEAD(local_list);
> > +	void __iomem *offset;
> > +	int processed = 0;
> > +
> > +	while (!kthread_should_stop()) {
> > +		spin_lock_irq(&qp->ntb_tx_offl_q_lock);
> > +		wait_event_interruptible_lock_irq_timeout(qp->tx_offload_wq,
> > +				kthread_should_stop() ||
> > +				!list_empty(&qp->tx_offl_q),
> > +				qp->ntb_tx_offl_q_lock, 5*HZ);
> > +		list_splice_tail_init(&qp->tx_offl_q, &local_list);
> > +		spin_unlock_irq(&qp->ntb_tx_offl_q_lock);
> > +
> > +		list_for_each_entry_safe(entry, tmp, &local_list, entry) {
> > +			list_del(&entry->entry);
> > +			offset = qp->tx_mw + qp->tx_max_frame * entry->tx_index;
> > +			ntb_memcpy_tx_on_stack(entry, offset);
> > +			if (++processed >= resched_nr) {
> > +				cond_resched();
> > +				processed = 0;
> > +			}
> > +		}
> > +		cond_resched();
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static void ntb_memcpy_tx(struct ntb_queue_entry *entry, void __iomem *offset)
> > +{
> > +	struct ntb_transport_qp *qp = entry->qp;
> > +
> > +	if (WARN_ON_ONCE(!qp))
> > +		return;
> > +
> > +	if (ntb_tx_offload_enabled(qp)) {
> > +		ntb_list_add(&qp->ntb_tx_offl_q_lock, &entry->entry,
> > +			     &qp->tx_offl_q);
> > +		wake_up(&qp->tx_offload_wq);
> > +	} else
> > +		ntb_memcpy_tx_on_stack(entry, offset);
> > +}
> > +
> >  static int ntb_async_tx_submit(struct ntb_transport_qp *qp,
> >  			       struct ntb_queue_entry *entry)
> >  {
> > @@ -1894,6 +1968,9 @@ static void ntb_async_tx(struct ntb_transport_qp *qp,
> >  	hdr = offset + qp->tx_max_frame - sizeof(struct ntb_payload_header);
> >  	entry->tx_hdr = hdr;
> >  
> > +	WARN_ON_ONCE(!ntb_transport_tx_free_entry(qp));
> > +	WRITE_ONCE(qp->tx_index, (qp->tx_index + 1) % qp->tx_max_entry);
> > +
> >  	iowrite32(entry->len, &hdr->len);
> >  	iowrite32((u32)qp->tx_pkts, &hdr->ver);
> >  
> > @@ -1934,9 +2011,6 @@ static int ntb_process_tx(struct ntb_transport_qp *qp,
> >  
> >  	ntb_async_tx(qp, entry);
> >  
> > -	qp->tx_index++;
> > -	qp->tx_index %= qp->tx_max_entry;
> > -
> >  	qp->tx_pkts++;
> >  
> >  	return 0;
> > @@ -2033,6 +2107,20 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
> >  	qp->tx_handler = handlers->tx_handler;
> >  	qp->event_handler = handlers->event_handler;
> >  
> > +	init_waitqueue_head(&qp->tx_offload_wq);
> > +	if (tx_memcpy_offload) {
> > +		qp->tx_offload_thread = kthread_run(ntb_tx_memcpy_kthread, qp,
> > +						    "ntb-txcpy/%s/%u",
> > +						    pci_name(ndev->pdev), qp->qp_num);
> > +		if (IS_ERR(qp->tx_offload_thread)) {
> > +			dev_warn(&nt->ndev->dev,
> > +				 "tx memcpy offload thread creation failed: %ld; falling back to inline copy\n",
> > +				 PTR_ERR(qp->tx_offload_thread));
> > +			qp->tx_offload_thread = NULL;
> > +		}
> > +	} else
> > +		qp->tx_offload_thread = NULL;
> > +
> >  	dma_cap_zero(dma_mask);
> >  	dma_cap_set(DMA_MEMCPY, dma_mask);
> >  
> > @@ -2140,6 +2228,11 @@ void ntb_transport_free_queue(struct ntb_transport_qp *qp)
> >  
> >  	qp->active = false;
> >  
> > +	if (qp->tx_offload_thread) {
> > +		kthread_stop(qp->tx_offload_thread);
> > +		qp->tx_offload_thread = NULL;
> > +	}
> > +
> >  	if (qp->tx_dma_chan) {
> >  		struct dma_chan *chan = qp->tx_dma_chan;
> >  		/* Putting the dma_chan to NULL will force any new traffic to be
> > @@ -2203,6 +2296,9 @@ void ntb_transport_free_queue(struct ntb_transport_qp *qp)
> >  	while ((entry = ntb_list_rm(&qp->ntb_tx_free_q_lock, &qp->tx_free_q)))
> >  		kfree(entry);
> >  
> > +	while ((entry = ntb_list_rm(&qp->ntb_tx_offl_q_lock, &qp->tx_offl_q)))
> > +		kfree(entry);
> > +
> >  	qp->transport->qp_bitmap_free |= qp_bit;
> >  
> >  	dev_info(&pdev->dev, "NTB Transport QP %d freed\n", qp->qp_num);
> 
