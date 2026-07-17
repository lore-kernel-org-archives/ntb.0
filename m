Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021085.outbound.protection.outlook.com [40.107.74.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69262DCC13
	for <ntb@lists.linux.dev>; Fri, 17 Jul 2026 16:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784307224; cv=fail; b=jH6Sg98Ao0hEZX05NsNHM5FsUM0RaEiawfPMjFnY4DZ3+86VDfdnPaQyF39z8ro5DO6pyeCFVDO6H9T8GS8wIZ7q9teycS1lTGO9hZKdt1mwE8opw/RILmOPjS9oih5tJTJSoiXIOAMmYyd/LR5VcwaXXDfaiMsZ3N1Buszv1xs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784307224; c=relaxed/simple;
	bh=hQCd5np/GNjSed0zQNbdzuC5in1Tv9v71G5IuCaltJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mVCtyykwSPFvUGB8ChkUn5kqMYWdo8XHRgoyhRi+HiSyVeIBPMIbcJ8SI4KamcR48gf4PQis68gFuwQ1WUXpELe4futYGx1wKnM2RXTKLpRKIrRDtSMVtZe1JGmb6wGysFJOJeFxx5J3lWurxkKmbI/dfisrR/l6HxGF0TZtLyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=KF5onI1I; arc=fail smtp.client-ip=40.107.74.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="KF5onI1I"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I2/n5CVeGToMR1/Z1/pu0TIuFPii/Wx/ybWvWq6QFwcXUkiLX0zKwG9nit0hOcbs7q4ybc6mXumIi/n2A4XOnklbZDDQcmSeXbXVaBBuxuh/2ZMjsQSkAqh7Y4JW9rqM0CDFB3A3Ck19Y0zp25/ugqfHuNCCAOsg3KifGebQ6qYUXxBp8XALPKr5zYZoDwNCKZA0CcFquixFck0qUA4+fsIP8FH5n9Ar/ZnjOC+GgpArL5QlHUQWFyuvXdu2GwWr/y4LoteLBjY4OdxaRbji0n7AaNeDCbiDwGjiQpKubqHkXKyiPXFdYZrK4W36/QO50IBeelKGucJNVB00L1KyjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mLLAPeNnGh3w/tmxF4pGAf8H6cxf1yZeztFYXmIH7Zk=;
 b=MtemXIxoZfGek42d122Z0GarvpokbK/iuMzPpWOpg3/Qn9ouyPhMchljZgnMEtd8elU7dIBLL3T385LSTiD+NMsBt305j5wSTXtJ0yzJ6zhdV/7vn4BB0ymMau1ZREQh52orj2DzFKl74zPh2YcHB3qp9GLO2/X/6YkqeNDxPvME+onLt9AOQpE8F2Mbg8kG8YMjeFidF88WOXMDvtLx/GHRJScG7NLv9+nI+ZJN3JyZkW+BPSdC4NSUROUk3FUp6ZeCgjOd/pu3m6JOgVLEl9KuAqbiTfd1F8cpdi0Klp/VASvhLGNq7ggjnPFeL1x0+lsBRDbI8y7D4XMmTeVgBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mLLAPeNnGh3w/tmxF4pGAf8H6cxf1yZeztFYXmIH7Zk=;
 b=KF5onI1I/n3zAPOX2rZ/HzCEZvBInngNkNv7Qa/F+wDk7NXb3+yzQNuwsoF3EVOsTRyulFHMmFjXBLVARWNPIH8fk/20O1qWkV461eU+EO4TzrMrQu6GoEmtJYXioZ46W5PZomjLJrEtr1VTHW7DVrhf+cf1KdQoMaDHbf0zU2g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB5317.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:383::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 16:53:38 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0223.008; Fri, 17 Jul 2026
 16:53:38 +0000
Date: Sat, 18 Jul 2026 01:53:37 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>
Cc: ntb@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NTB: ntb_transport: Mark the transport link down on
 cleanup
Message-ID: <gjfwieupwcfbqueec2sbipepz4nofkcocouswweelby7bo5ycx@hsbdini4xazu>
References: <20260717061223.2203863-1-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717061223.2203863-1-den@valinux.co.jp>
X-ClientProxiedBy: TY6P286CA0010.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b8::10) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB5317:EE_
X-MS-Office365-Filtering-Correlation-Id: c6c7038b-b63e-49d8-0141-08dee423f30a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|10070799003|22082099003|18002099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	KpgUsVbsLFiLVsyIBFn7dveBwgCI3By9VYyOgAlNtUOD7viodOuW7XoJdzPFFBg5aDkhypRmpeH9HRZc+sm+aDE+9BNNjnQIff/Yi23YD60AS9IlB6Ol02jEkhN1xXjhcxGxlTm5ynNpJBRuuPha4OM1h2QnvEl3o7u+fuMV3zI5sJZJhn2QGFg1WPsy+AMLVcIwBz3/18v6hohUJFMUAkmVt4faOtLLVlGjnjiW9RTLuLuiJffcJo8Or1QekG5GETM9blYWKh80xztA6DNHhi2x450i7j1YB3dfa9QacmlrJRxlDYoTlRTw27fA4kMK0NxNfLmez8vyg+fQcMytSZKLtWRMnujIh09DrP36KYzXWkKicIGf7z2I8BuNNejGJNT98Pz5Jx+VJz+R4SqxHemI9xD1EqtbbY/Rfhjpq87NcwWdquIegubTy8hA+2t5A6Wgswrrn2qDDFEh4wQ+Kx/COYfRN3bZw5+YCjufPZZmXOhSzHdobumpc8Bb2Ei/u+5HGe1jREaeW+VEPDDNsCPnR8DqZYct+f+x7Q6/3ezwnLaUByE2DJdWelzSjFAicPmI2SkHvnWn6089iEAayBdKs9onBgoVSI2M6yyKVoXu9pusJelFWW5l5XTv4FTycNBzwRPwyaf/TOyCr6/zqXQnbi9Vkv+NoM9n5NgGvyc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(10070799003)(22082099003)(18002099003)(10067099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uDdOgMnZnjvcq3RpLOeNcbkJQZWQcGe/9eHvcCVxmho3JcOcTtJJmLsye/uK?=
 =?us-ascii?Q?sAefSYXmCZrdsatS/qg1SyJ7gJUThAJ8gy4vAMefYA7ZRsFXJ4U+Wkq5gOV2?=
 =?us-ascii?Q?gBPL0/XsxJrN2pG4N+pK6ukrqHtXyVv20lau0V6dy11e9+uDtvC1ovMBA9Fz?=
 =?us-ascii?Q?i1J7COcOhAHGGfGnbOqhuen+ZwiOfSnmrgQCdKcnFq4RXIYjKPm6UrCDo0ee?=
 =?us-ascii?Q?rTbaIIlTvOB11DwAofJQVtiD8vlnfK3MbpblpyVslkMYgvEQwooK4zU3iaji?=
 =?us-ascii?Q?SaKl9cotMg2jGOmTdsCmy2bDu7NRdnwIHo7VDfEUUZTZgugNzIHM5KbezQIP?=
 =?us-ascii?Q?rNwL9qtwRWvIxanKkaEbKsuwGjCkLf7p123ujp4gLCRyOvRKaKBCBJ/hsyOc?=
 =?us-ascii?Q?0tlc5MRk2Lut3dpD6Eegq7MrgTzNPWsYgC4u4YTemhjOTUIq3BDTuGGdu4i7?=
 =?us-ascii?Q?EsW16fVbAVDHHMls1WvImsTZns1grGsGAfFkFSVWpV4iz8g8myxJXAEW9tJR?=
 =?us-ascii?Q?6tJCTCX6O4erAhEwGR+aNBTZVFoUVffRoqRtcCcEgtbBfGyZbJs9JnTQ9b18?=
 =?us-ascii?Q?6mfBfYPFf8+0zrN6KZZUhIC+lhzsvYhRacTt9t3jNvQfiXKEH+R6mMNanK/l?=
 =?us-ascii?Q?0ys8RiSZdzlnL5p393IXC1pqki/w4pMg11AIr6XDyOQoUtLiMfejQTZoj67n?=
 =?us-ascii?Q?nJTAblJ+NBzYjia7vxZjDCutZQWkfZcCDWqhM4ncxt1C/Ss15M4NCdfkwUhT?=
 =?us-ascii?Q?HJ3iyFI0yX9cA1oTyOYGeI3SdIFpBvtf7ONZpCl6cCdzyX5uhO5FVPZPnHRC?=
 =?us-ascii?Q?inGpA4taccdxD+OxSaAiORR5qSzqZqc652YFBsSd6dypx2xfXFa6k8PJtn5m?=
 =?us-ascii?Q?AS/gd4J4rQyeTLNTU++G9WKI0MK35Lo3twae+vcykQQmboE99wrKwSRI78zm?=
 =?us-ascii?Q?TxXba2ALS9WOOQmqzntrSJH39NNBCjxwFaUlTP+mMxLcCOJO3qKdYvpzdepv?=
 =?us-ascii?Q?gppPuw7SKKbEt3fUyFu36Mi8LnC7Y3k99u9RaZdhwdkCZp0iyS0oWzeyWtCD?=
 =?us-ascii?Q?g5r8jON2f5Xs/rWZuyg+5BQ418ICD7mhsjuf+NzaPdLaAKfh+CI0AZ7IXJ3V?=
 =?us-ascii?Q?A4t0RPtpO3TJ9OvPKlYmSDFLjaavjePGTo0Yla7+PTE4vawM10YGziZqKeVJ?=
 =?us-ascii?Q?y7vzJM5B0CmJyYbMPfTnISa+lj+MlxHIf0NwCly3jOeURbG0jyCV0U1oX5Bh?=
 =?us-ascii?Q?2WdYvGttaBIxYJre410yHxzJiJFYGDJJU6Q/3sPyJx31rmMM6dzCXb0xf0tl?=
 =?us-ascii?Q?L9tJmtNpxiWlFaFmR3uKCSkPF0k4aCiH0Yvk88OTrzxRk+NPPhUctWNxBvyc?=
 =?us-ascii?Q?CE/ZgjeIQw7h+rT8av2Eh578dA+kf8G1NSf/9Exekgi+d8D/ntlyjRq9w6Bq?=
 =?us-ascii?Q?qVXx5czJIyPCnkOH1Kf7OqYff0L7rnCdfIxzVshPTT5oMFFf6KWZJLJkZEP9?=
 =?us-ascii?Q?5rAM6H+beKMao8DRJx7zdXAsoNR9UvCAK6zHWUV56ZP0rzd966OKD6bI77cv?=
 =?us-ascii?Q?1rxPQoS5dIj5QYyfA6/AbZrRdTfiMGhCzX8zVjXMw1l5t0vKrDAtfBvWgOqZ?=
 =?us-ascii?Q?v91hvRsmazJ+b5l/Iy0TTWL0hwvxk/kJfwgENboR2lGUUiHSHvDVca9wQqxP?=
 =?us-ascii?Q?i36nfAi7Tzr9CuRJ4eugj2uh+6deLr8ssYziyEioiFrgjNN+ded1ZSNmB0Sa?=
 =?us-ascii?Q?PblonDk3nC0fkiLi1GwUzGnoFv0kSc//kYAibGBWcVoCT6Rv3OTy?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: c6c7038b-b63e-49d8-0141-08dee423f30a
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 16:53:38.6532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a/oMXvDuMetQ7mkA8EPKoQirubdoeEEfF/aaQ1EXopFi1pnfmbGMpAoaitbeHlkbPTo+Luc6UiGc/XWhZxykfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB5317

On Fri, Jul 17, 2026 at 03:12:23PM +0900, Koichiro Den wrote:
> Before the NTB hardware and transport drivers were split,
> ntb_transport_link_cleanup() changed the transport link state to down on
> the first cleanup and cancelled pending link work on repeated cleanup.
> 
> The conversion to struct ntb_transport_ctx retained the repeated-cleanup
> branch but dropped the state transition. Once a link has come up,
> nt->link_is_up consequently remains true across link-down cleanup, allowing
> QP cleanup workers to retry the handshake against a peer that is down.
> 
> Restore the missing transition.
> 
> Fixes: e26a5843f7f5 ("NTB: Split ntb_hw_intel and ntb_transport drivers")
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

I thought this was worth posting as a standalone patch, but after another look,
now I don't think it stands on its own.

Keeping nt->link_is_up set after clean-up, and letting the link work keep
retrying as a result, might be odd. But at least with current mainline, I
couldn't find a convincing user-visible problem caused by that.

So, please disregard this submission. Sorry for the noise.

P.S. regarding what Sashiko pointed out as "New issues":

> 
> New issues:
> - [High] Calling cancel_delayed_work_sync(&nt->link_work) while holding the nt->link_event_lock mutex causes an AB-BA deadlock.
> - [Medium] Leaving nt->link_work pending when transitioning nt->link_is_up to false allows a race condition that incorrectly re-establishes the link.

Both look real to me.

IIUC, the first one is not entirely new, although this patch makes it easier to
hit. Fixing it would be a small change, but that would be a separate fix and
doesn't justify keeping this patch. The second one, on the other hand, is
introduced by this patch. I simply missed that.

> ---
>  drivers/ntb/ntb_transport.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index f59f926d4bfa..5b9fccd1383d 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -974,6 +974,8 @@ static void ntb_transport_link_cleanup(struct ntb_transport_ctx *nt)
>  
>  	if (!nt->link_is_up)
>  		cancel_delayed_work_sync(&nt->link_work);
> +	else
> +		nt->link_is_up = false;
>  
>  	for (i = 0; i < nt->mw_count; i++)
>  		ntb_free_mw(nt, i);
> -- 
> 2.51.0
> 
> 
