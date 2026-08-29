Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021073.outbound.protection.outlook.com [52.101.125.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C147374A1B
	for <ntb@lists.linux.dev>; Sat, 29 Aug 2026 14:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788014340; cv=fail; b=K6k5C5KoUMBil8/zHcMt0KCiBR4LB2npvYPK8iuqzw7mSZpTWm8FcqObYwTBXAwCXBTk1uGs0tznqnOwKzS2dg9mHzICVNBsnwKx3THnxFnVXgQn2a0xPiA0qUskUi3c+BGrr0mCRghyEm5asvCLBso09v/rgZDPuUcHfQTwZ6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788014340; c=relaxed/simple;
	bh=Fucn6vIqm+EKDj91sPQqyiRtIva9Lr9ZwtRblrOONnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gBx1W+Dekp/XsUWOfciatABKFgPmtcEnTpzu7QoZB4S0UNQ9j4fd2rNDjhA/Z+pFnpddm8lx74g6AnvDXcMYN024mUFkzUe74PDTu6ZJOxB5l/WRqqIcFA6LvSclq2M/O+FWp8yMuwJLsQ7TQT8pBIPg+BOycIW7j/8DBfuN8vE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=juCjKVAP; arc=fail smtp.client-ip=52.101.125.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="juCjKVAP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ryyQACfXY1X6NFTN0O4RnrFoc8n0u5Cfjuv8UJD33FJa5eEDKEWn/7syagdcTJX/7YzNCM0IQQtwiyitHRGJcQ9ZQkrh0+GrxCmjRcXyf962KV1ev0VDRCRHtZXzQuUyMyrp7oUznXncl0Fmsd3ds9cvvYES9EHuHkJgupJFh8H+QSxK3RjvWRQr6mgNtxUKVTPz7dPMFA/oKRIodNRrFooNtwDzv/dDYmc2MFk5U02GHLWmqeJnDMOUPeJiiME5EOEDRQM3rrxPswpARvatOpJq67IFl1eBPTs2Per3m32mlKWQTSdfHNgb3tfhnZnR1cbTvOFcr36PoPgCuvA2pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jbnKJIY4d27LSF8JYvrxLckl+ehtRzWDr+6C32ltQGY=;
 b=XaRVXxpA6hxDoRgJjkkUeaDtHLa/26JZEcGvi6L+/g9VuYCYJEe0RZzx3QnRmn0Q1d25Mah4wD0Mq1gJL/B0i9dhHQN8ukp88oV0K9I3uN7UL00xfWpzdbe5Wd+jjVlDspYOVQ7FC4XBjIeZMHKtWyimFrMVAp0oyDx+YeDOJyI8e0zxnC45FlT0KhuCwN4du3EcD3rDB+6f26TUnUvuFyp5hjDcXclhMQbK/6mwkw84jrlMXURajpPNYa9Eab5V+Qar2GDLUpjCBqQtqA09+hOV+JFRbvC0dj8GeNNnT6Hu+u+9SqRNaOOlhSZFwu7rF2Bc05g7efxLMTHpRS7wBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jbnKJIY4d27LSF8JYvrxLckl+ehtRzWDr+6C32ltQGY=;
 b=juCjKVAPruRrICYVwCuUkhsLGnxoDzAJgO/2cJv1n7/9kcxwu+mBj3EQSe9W+sc027721tdv2A6X5yLQXL2GRlVcPU/7AacpNT8bkXzCqGZyDaAm01uqeWyk2D8vqvgcg/FoIUZbv6VAHS3y1BGGkonIEKnSCwlKzyshi69N/9U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB7244.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:455::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.12; Sat, 29 Aug
 2026 14:38:55 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0360.008; Sat, 29 Aug 2026
 14:38:54 +0000
Date: Sat, 29 Aug 2026 23:38:52 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Jon Mason <jdmason@kudzu.us>, 
	Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	ntb@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: ntb_netdev: Fix statistics races
Message-ID: <rlu5hlwm4qx36hwew3x2r5yyzh5sh2oad3lbahvkbquysidr53@slny6vshky2e>
References: <20260828154122.2643578-1-den@valinux.co.jp>
 <20260828134957.5b95472b@kernel.org>
 <20260828141048.685b9e9a@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828141048.685b9e9a@kernel.org>
X-ClientProxiedBy: TY4PR01CA0062.jpnprd01.prod.outlook.com
 (2603:1096:405:370::14) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB7244:EE_
X-MS-Office365-Filtering-Correlation-Id: ffc6403c-d1a6-413f-dc1b-08df05db401c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014|23010399003|22082099003|18002099003|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	Ce14AKfLK8pgW5zcJaGTFCYq4tnUYZNl25CVUWdF+h23Qo8C83sVJzTE7+7qouAFHAYshnyfiVpQOp7oWx4uxyvoWMOTyQ1yghaQx9on+nUQAfbItRuxi1bAvTaL1ambbAxK0cNXHVDBG4wmw2CBI52RDQaZqN4nt2StYGWdiTWfbHr8xUXhWjSdaNos0tcI3Rif4BAMu/mxiycwIusyHBYN9tuzkhaXHqxlttXTngt/DoHUajEFy70M/R2ci4PlC2uTZq+XsyqHEJgNr/qOyy0LUN6YUoDPuJ/uEDyCC+HphA6Ln4TApFTwB+w4th4XvjnsePGCsZKAPhXksyZBvwEiT30PIel3n4/3ZzqmvV9iIbnAFnpELdvDoxspwT6lQqji9+G8Ntk39yQqjSg8jvuXtfmgdANZk9s5EsgmYMm7p3upI2GDlE3z1BkNoG7OyOglLcWDyNDaotJTg7bZRC8vxh25lJmLcWWHTYENWYrwCXI89542zUgz8YPUadVp6Su6+b4G1BO2TVLZteiDDotqBJqhkfZGnTHzvoHWSM2V7oVTVSFMAH6t833XOmLK/01WwMoRhDjtAyemXJ5CICokQzfA75P9S8rxbPgP6PQ26WkIGHUtIS5SW5j1zD/808zhc8caOye6vg1icUJCOkKRyD+b7ZCq9vhwNTyMHKE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(23010399003)(22082099003)(18002099003)(56012099006)(4143699003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RS43y6Jsgzt7kuUAiL0jvv86oNcoNlMw9CSrqeTzM+YCgtqUW56NyCV//2JV?=
 =?us-ascii?Q?R7JfsrdQn9Uu3xg4fMntHRhD5jmk5VUefNOwNlG2Sky05hHQRFm+s5l15WKq?=
 =?us-ascii?Q?+ZXmT2IoYeSoHR3bXboycVTAHoifrC/w5pyDKIJkHc/Yr/Qu6rl6nsdWGQpF?=
 =?us-ascii?Q?3ckcJd0Fs+ojsFWvvA0l/oqN6A44FKBHhbbYglh0Pl/a46DjJB2eAixv5Vrm?=
 =?us-ascii?Q?qsFvFyjF9qKBI4GxfCP4lyeqID1LG9RdaBUBKJi1Dbot3Ux9ZytIm8QlNiTO?=
 =?us-ascii?Q?mNZU5Y5+Yr/EULo7rgV0/QVWeru+UqSQ8WVCu0UUInK1vg9dz3agcfK60rTc?=
 =?us-ascii?Q?UZdxCEiSkq1avuZ1mV5+hSlil1egKJpADMUfAadBEBWdI5rh9D5TOfKFRVbZ?=
 =?us-ascii?Q?/Q+hvtqlQfboD+j1HERVYJKv2RdxVa0rlWD5ZHiUml1NnqSD+SUGKqGgMZoM?=
 =?us-ascii?Q?PeHcyrXdLdHqVt1z4WMXviPlPIIAWkDA2VNqepkPBGERF/+qOLBfn9nzeF9T?=
 =?us-ascii?Q?iperZVfn0EGAdnv1JOuLib8DVV45SFc2+1HKqcvq08HDKMugqMuZ3uGX1llF?=
 =?us-ascii?Q?luon21d9xrICjSpmR9zWK6QLxZmH0hYuMjbLIGK8+bZfcJoGBnsdt2PjQsjd?=
 =?us-ascii?Q?c9xqeux70/aYAIcxwfyKwscYH2ddpvVXyhOX3ImmBpoWKJ5Sex9MhmUwBju5?=
 =?us-ascii?Q?AD7TUO4I9kaxddfsec9LQWrM+EOqlxI99ASE2SeT6Qs7AP/KZ0X00wAV+z/P?=
 =?us-ascii?Q?80wGyd1o/6Db8Qnsr6s4yKg2Sizu+6cKSgMG7q+gfqfWGfKOB8PuaGMHr5jl?=
 =?us-ascii?Q?9UxImcie+/3G86tmTMYeoa86SDlpJiqcw4Mr7gN9XUxd5UUpFvfPnUwIhXu5?=
 =?us-ascii?Q?FXfDpjnzegYjMfMjylHopc/M3r6YfkTS6/KvNI8sV41uNmiWKNnG3Usz+cbs?=
 =?us-ascii?Q?/WrZn0D6baZkcHdSym5wVbZO3ZB1i/32E6QSJIuL93m/xjSTwlR3ZkVKDN0z?=
 =?us-ascii?Q?rDys3Exe4dNN+HDEiEaNKizCISp0+v4hYrTgu1SsMSgFZ4ATnwTjyjJwVnS3?=
 =?us-ascii?Q?UhuPAQc70gSPmbWbPWwmTz+SLqLmArQLcxOMSG3dME1GrzMksTlQqNU1qLIR?=
 =?us-ascii?Q?Ug1/JhDMXnGJGYBwtTXEUGD25ORqeokMoa0ZVk6nRorVmoGe7BSSuwFH1AQ6?=
 =?us-ascii?Q?ysKADAp/5u1fMgots3ZP21mRONeCcO8fOCCTH4/v/bN3+YEqUatvTK3dii0b?=
 =?us-ascii?Q?h63kfIkFCUEasxBg+Kp+5FCVvPnbIcfQKyMZZJUDdPFDrIaJdGABPqHBJDCm?=
 =?us-ascii?Q?/8G3rBSTTmZaSKWZRU8bvrundAZoWeKP2vJ3wtsPhD+Sh8W2M7DUP5eKdEq0?=
 =?us-ascii?Q?S/7DWqVV1Qme1dxJINvbpKcacdFwDaThz0LlNEpxL2cYasIev8NXxBuo7ukn?=
 =?us-ascii?Q?Z0WQlsYDbmdJ/dbh7rOuxz0WwJHm2zjrWNhnLV3DFqsgNU3sxGPUSGPb2VAj?=
 =?us-ascii?Q?BHCpc7mRmcCjolCW8b8wqiC1moyKjbcSxcrE0cdKmDCdGoQuAPaRfwtenZJo?=
 =?us-ascii?Q?hPrr/c4EQW6iN2phwgiPBJzqaASsJu0oqEpXovQSAbKjG1F5DYQio+64CjT+?=
 =?us-ascii?Q?cYhvF4o+YwLpw4lPnlClwTdpfmBnKog0VVN73fceSI1wMS1J85LT60SwmQ5c?=
 =?us-ascii?Q?D6XxaT9Qucc8qbAXRuEpyWv678fXI/ltwhoR7UF5O8Id0JBbIApWIrH6weGQ?=
 =?us-ascii?Q?uoqV06LyKFChLoYFVagQFPD0HPVez/MCt7DkGiqe3uOiz0eSsaqp?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: ffc6403c-d1a6-413f-dc1b-08df05db401c
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2026 14:38:54.2262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d6FyL3LJgWbMZumfm4KgzoBg0UtF4tdh/9FsnoaZjbOXAioudjZmwefHb5a4lh5lt02BT6twrb1yxp3MAvLlbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB7244

On Fri, Aug 28, 2026 at 02:10:48PM -0700, Jakub Kicinski wrote:
> On Fri, 28 Aug 2026 13:49:57 -0700 Jakub Kicinski wrote:
> > On Sat, 29 Aug 2026 00:41:22 +0900 Koichiro Den wrote:
> > > Note that transport callbacks may still complete after
> > > unregister_netdev(), so tie the tstats lifetime to the client device.  
> > 
> > We shouldn't really call devm_netdev_alloc_pcpu_stats() for types
> > of stats declared by netdev core. We should set the pointer type
> > like you did in v1.

Thanks for pointing that out, I wasn't aware of that.

> > 
> > Could you instead fix the fact that the Tx callback runs on 
> > an unregistered device? Maybe just wrap the whole body of
> > ntb_netdev_tx_handler() in RCU and check 
> > 
> > 	READ_ONCE(ndev->reg_state) == NETREG_REGISTERED
> > 
> > ?
> 
> Maybe it's over-complicating. IDK.

I think the RCU approach is clean enough. RCU plus the NETREG_REGISTERED
check should address the stats lifetime issue without moving transport
teardown under RTNL.

I'll respin and let the core manage tstats by setting
NETDEV_PCPU_STAT_TSTATS, as v1 did for dstats. Late completions will still
consume the skb, but skip accounting and queue wake.

Also, looking again at the commit message paragraph you quoted, I realized
it was poorly written and confusing. What I meant was:

    Tie tstats to the client device so they remain alive until transport
    queue teardown. Moving that teardown into .ndo_uninit() would put
    potentially long DMA waits under RTNL, so leave it after
    unregister_netdev(). TX completions may therefore still update stats in
    between.

After reworking it as you suggested, the last paragraph in v3 will say:

    Let the core manage tstats while keeping transport teardown after
    unregister_netdev(), outside RTNL. RCU lets unregister wait for a
    completion already updating stats, while later completions only consume
    the skb and skip accounting and queue wake.

Best regards,
Koichiro
