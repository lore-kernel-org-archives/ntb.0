Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011057.outbound.protection.outlook.com [52.101.125.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C1F2D4B5A
	for <ntb@lists.linux.dev>; Mon, 27 Oct 2025 03:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761535248; cv=fail; b=bLhqBPcYlMOtthleOfWwV29GeN8bhvT988meyQ3xq0CUur2t8R1e2s23wKBHLssAYXQEpauRVhftfBbeiH9Rwmep0fttJ9KoP3LUaOjTvYmBy76ysM++AKxN0M4GUNTICBiXkgPz1hJrVD9J6cVPe0Qs9hHfG+AC7Y5+Sk4YZ7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761535248; c=relaxed/simple;
	bh=lWOCnfl2BqQQphhclJA2k4SvZ8HlGFH0TeRxWMB42Z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=M2Fd58BGw+HTm10gJkEookJzril+OjIgFjXksTIA5oFwPpkqYDuMhRWaf2vepleQ2rUbpyTB8dKHdmiH7pcpSitwS/4PYsb5YabL2DMB+I1bxiZWbfdbKivjF72Afjzdybc8f7esFIHGT+VuXkn0jualOa1D4WPw85jPz+eY9zQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=uA8mPwdt; arc=fail smtp.client-ip=52.101.125.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="uA8mPwdt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OPYI+/mqner4NF3M3KoG2i49EeMhvbaUc8Jwhu8nilPGit/bVlGy7Ri9MHiL6Lni2xH3bADlG2P/dp73xXOWzZ78EE/QMJ0BM1VTjx8D68aBIR7jExzoNTZy2hXXxOGuA4SHotshxIoWhaEccbIjBlGVldVWzJZh9hjERZ3w/kSOKK9vUjFN4vJTp6coZRZi/xNKaE5GS2ad7PUMJ7ta8fFLiO+LkBbwrf1sJuxWdI7E8pMoOUDvykeFirtC6GZ1v/DsR/JPJ8mmkJr/q8Y/zPCEcEOnIobmpRynMyGSFEKMzVCr/NTajhJGnANOm2dvXM6TbqNPpzKHv7JMxTnBQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xG9F2K6uxarK12vaKoq64d3puQO3b62GjuCc2R7mal4=;
 b=t0Um2w9wmZ9oPazhFwf2NZlv9doFs62RTBhXpPnfI0Y6xfg03UeZF0lTqBlwSjlYJQFbi/mBaliREc3oJG/RDZNr2hC3pXlELZFnlhd6sbW/GBecH6aXDJMngfaCraoL7wgN3xr9kvB7EOo4nfyjUS0uYbKIF4AQfqyGxX+LSzn8Ijz+qunZZAndS3x3uF9oe6LuMLYQnAidN/uE2/SMJE+nATEYpRid3BOvfyZL4a0Pk5yL0WFb+mWn1Tz5wqYti3qiPNCfS5Ow9lWty02dV7buzf3V/G6jtulLEUhOEtEKSuQMyrJ6BYN7KUamD2MCAQq6ScDAHBNfphoWdQRsgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xG9F2K6uxarK12vaKoq64d3puQO3b62GjuCc2R7mal4=;
 b=uA8mPwdt6EM72fGQHX9tMCPLhUJw+MK9UaoV9IGvKc9F7Cdcto4pEdFbaCEsqqefTYXyE2/nnIgSYwmjg5XKJaUXXdnaBaODbGhvUtAL6Rz85PXs891DLLQCezzwNc7EknhAHjYOtRGY45St3Kf7POetTCj1rkB+M5A0XslTep0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:10d::7)
 by TY7P286MB6414.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:32b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.17; Mon, 27 Oct
 2025 03:20:42 +0000
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a]) by OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a%5]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 03:20:42 +0000
Date: Mon, 27 Oct 2025 12:20:40 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Dave Jiang <dave.jiang@intel.com>
Cc: ntb@lists.linux.dev, linux-kernel@vger.kernel.org, jdmason@kudzu.us, 
	allenbh@gmail.com
Subject: Re: [PATCH 2/2] NTB: ntb_transport: Add 'tx_memcpy_offload' module
 option
Message-ID: <6uvhioekx3s7iijlqh2rnmecp6d7bixghsuay6aueuo4mndidf@mkuz5nrdbyys>
References: <20251023072105.901707-1-den@valinux.co.jp>
 <20251023072105.901707-3-den@valinux.co.jp>
 <b7a5ed5e-f4ca-4045-a956-73594a286fee@intel.com>
 <t4u73ozmucboxkml5p3xss44aafvr23hisewq3qvpgp7lbpx5y@f2haptgd2wzu>
 <0ba47a4d-3fc8-4812-b80b-b3ccb7e7a251@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ba47a4d-3fc8-4812-b80b-b3ccb7e7a251@intel.com>
X-ClientProxiedBy: TYCP286CA0081.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::7) To OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:10d::7)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB0979:EE_|TY7P286MB6414:EE_
X-MS-Office365-Filtering-Correlation-Id: 66ead5d2-822c-4d3f-d456-08de1507cf43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lHvdHCNdtN+TY3SeJN+dnVPvxpF18VxpQhCpq7c+ytfA96HBvYizfj0OkQPY?=
 =?us-ascii?Q?FH37J8YGjM4Io33Ykgj2fRa8uEUoQsXx5MM9XOhovMMNWORfL6Y5EJGld1mI?=
 =?us-ascii?Q?Rb8TliOzupj8rfjU7DD2I7HSgdWOVV+nGq2CTRhmd3IzRRaUZKIPBe/p+TlK?=
 =?us-ascii?Q?P8HpvpZz17Mw9ZXMpqMqDm9Kq62tjk4TD4gOrjIYdpEfUzNkHx9COzEjVjWb?=
 =?us-ascii?Q?DuUuPvJeDCtIKtcS4GbXlx6Hr0yRfxG9ncOQihAhkaZKv9rkFUQvo5RZ7xFG?=
 =?us-ascii?Q?EQXIEZCumjiXjqa+Y7qavXdJmyul7+syddg1JnYs0lS+R7ClqHMXEN4pJpbx?=
 =?us-ascii?Q?OQpeZsiCvcgGxMZDZqcGeagxr+LOmTeVsDViotDUBMpVnqj9cX/Sgv22mDVo?=
 =?us-ascii?Q?gLt6awRFCQvBjGcVHnHDSjJHsBhYPlFT8mhiOu9zzjtXb9hVol2Sv+5gCKVR?=
 =?us-ascii?Q?McEyrux2rhNYZHmXXGs+rEutDosShuAFVsgXqdTbphY7zQ1j01pa4E/cA4H9?=
 =?us-ascii?Q?BO3nYMI4c0yd7GwIJXRl5Pspvq9T8qpf+5odinS/fLigquE5MIIxc9F6ql2Z?=
 =?us-ascii?Q?st9nG46wsRqApcnrT4337TZ7X9zXSOkAHgdr24NpK/tIuYn1Hjs8lk9ltvCX?=
 =?us-ascii?Q?kR0DShM676jOCpddkq4uF7rUTNzt7kQyqnjKLfAt8KtOVN7cNiQdu1ahBuVG?=
 =?us-ascii?Q?3IvyU/0QEocuJVmRDZ6/VWMQ+DFJObPjxP2ummc3yhwdvC1Dy7dsc7yxFloO?=
 =?us-ascii?Q?bpdbP7o9Yl6MOwmtOehObHYB7WWPVq6oMII8geBZrjqZYPrvMt90CflLPGZI?=
 =?us-ascii?Q?MdiPGXaP2BMfEU6lN9nL+0zUBc+u6BJMhd/qoiYxdJNeg4s67Dwx4x/lSX+E?=
 =?us-ascii?Q?8w7CFYD5SmruqXRtnkTDryKp6MLYzdgPgFFem0ZzJQWMnYSP85VY9mANCAAc?=
 =?us-ascii?Q?PCEwI072EXNSjqL1NwRZD+NgSk5QVno9zSs9uM0h9o5KGNjKSc744zuk7Gw+?=
 =?us-ascii?Q?PKmrNFuHzeD0ed4MbJ987BGQz+HxEdNtve+lGkD5DxUf+s8EtuT9iTY2+nNT?=
 =?us-ascii?Q?ZicDTIukz7KV6ImcO8GiiYf8ktZFD0rgGUU619qAqEc0VQjH+exWbkv1Tode?=
 =?us-ascii?Q?rpMveD/OXdtJszXdcq+9C/PwXw0e91Lb1m9DBQAS8SbGAKmPcXKZ5vvHhUCJ?=
 =?us-ascii?Q?seyZbuyK9trLobva9iX7WVX1Je/V3nP29iqEtLbrRYhjzZw7zV25LjSNaNpK?=
 =?us-ascii?Q?nNv1tbXkNOYuCooLQ+7wpEBcWwEXPzt8kmWEGjmsLYUamD/Iz5bvBpI1OOEQ?=
 =?us-ascii?Q?91t6r0I5i7ISR9QQam9qpYILlxnyJbFC8WcAOMruNRMNHzARnSL2dwxaXW0j?=
 =?us-ascii?Q?XEhXSY0R5YLA6r4Sh2lGaJim+FbA2dV/lhGiz0Eg1GfBJix7avgC1lv+Q1VK?=
 =?us-ascii?Q?EfUJGNRAad9Q60jzmBLytY/Kusv0Eg5f?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?km9e0RitOZ1hXO7uJRrB50v2BDRRc9k+F9A4G0cX7xr0RRb7hf8MrRXIu5CI?=
 =?us-ascii?Q?7aA3rEwXaSEWRml8ChiaJAdsn8u4EF5xB/tRB+QxCz5n9GiRfGp7k+s8nitV?=
 =?us-ascii?Q?8XxQ2s1UOQQ0RX7Z8XTHxdXPuOREwlsVGi7Rz3w2eO9Yfz1OD7yG8Oqa3fX/?=
 =?us-ascii?Q?cheqdtosLSZVOcgo4/snvDo0ttmFtKod7pwzGqkNtapy4I7kl4xqplqYrweY?=
 =?us-ascii?Q?nJiHQCAq8J0P2Opi8sn3mQv8+1GT3mkrTg7vQx3ICARIurqgkuBrFLPG1SEw?=
 =?us-ascii?Q?iOZkwuDgYvNdBaLXc23JULlDkzSUCqSDvFrK46ohDGaNj3QiZpwwITCGJQ25?=
 =?us-ascii?Q?esCx5KysRpY8b09wt9uPhB+n8536e9wvvGJcFNwqX2NGmMeRo5mKMfTvSwbi?=
 =?us-ascii?Q?g9ZTLjZoLTJjOrVCykmCvaErYON+XR5QJzUoAQhDM3qSYO5EatqZC60/ChyU?=
 =?us-ascii?Q?ZmIpkJ9sjKpZlyOM1b9qcXqsk2vyyX+6YZAlO1okfiGwLW8TMp8qsz5BtExB?=
 =?us-ascii?Q?BMcm8Ph2Zjfd4raQW46zV+yFZ48jn7nEjD/EXHvdXe1w/lYBn7JTtyYjrih4?=
 =?us-ascii?Q?f/Ii11ttdW3fAcaMszbNC8H8ghHmlXdsesxyIkL3sChLfN98eUwZ89to652v?=
 =?us-ascii?Q?Jw5J/0mQMDR2/0aP0JlFMuvNa9C0nvXL9d9lIfd+G+rixfqyBNR0/vbhS+3r?=
 =?us-ascii?Q?EmV5aquu0EDkLlXPlcnW/kHWdUXkjH0UzdlvbdklDZzYXVOUI/gCGzQeIZPl?=
 =?us-ascii?Q?wtioGkHfLRUR/a7EOyaxAPMl4vVAhrc1d3Oh03uFrmmjmpftXxyko4F+9WWB?=
 =?us-ascii?Q?RCklS7y0vMTcp1AE1p5JGT9IFpe5aCfytNCdQPTUEzPkcCgBFxgUQgOtK1+T?=
 =?us-ascii?Q?toKWQo2HJYRpGKUrDl2POCFXpC+9W9p/ypok2ZA0y3G/AW71MIAPsYpnyVbC?=
 =?us-ascii?Q?Q0JFQF4ume+NofT9+647wztkK6LEeosVzpoRzQLCTaNnL27YTHr6OSjHidDv?=
 =?us-ascii?Q?RlFTqIp/i4bO4ZX2Aiat6aFZKNjGud+MHQpCJUkUPdqi0Fe6b1p9mCHWgJHO?=
 =?us-ascii?Q?9rwNBeJwYO3Vwn7Lug2/uQp8dyX1uQ0TUyge21s23c7BZPyM0DhIZoPN6+W3?=
 =?us-ascii?Q?ABK7wdomPv++PhZC5uAEne43HabdNxc8fW6L1EDV+PwUcNTE+vNeYwEFu9iE?=
 =?us-ascii?Q?sadKusSS1GucF8mZMOApIxX/GVhy0/6Ttq3f1rMY0w9X9Tu3uzGj8Ri5QNaw?=
 =?us-ascii?Q?fHw08+QCuMV0uIeONptWwMGr+0g2BkVMnX43JYRmGl/JBdWWJYrc+EenfeTa?=
 =?us-ascii?Q?7VV5MDuAkLHR1gSvrlXhRtzxI3Ik5oHkvZgUciS7mtJLgj2y2g89Sz/Z07oz?=
 =?us-ascii?Q?1X4nTcKRVD5jqu+j4OI/7cchqLO/ic1OTwOtfmi4SC0wRrfZ4dP3/lJeBHjX?=
 =?us-ascii?Q?RM6U2R4RC+1c3H66mSdAESUlduL1x4ImYFMTonbHlJJg5W1H/mBX16eFToVZ?=
 =?us-ascii?Q?JXxL+GB1PMF87YKk5yBuUtW39YSXrBi9dLC4cL50M65tgrHV7iFIMX8P+fhP?=
 =?us-ascii?Q?k4dqYroNvagGPgTM406ht4VumJVII+6DQLurnizDLvslsVt3gus+j3PmBIrO?=
 =?us-ascii?Q?riZtBWmGBc4ZyRsIh2mjknc=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 66ead5d2-822c-4d3f-d456-08de1507cf43
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 03:20:42.2099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FrX2u0lup1MItSI8AvgguoPlXltMKK9AaVg0b4QQkPN0vExe78jdXYYYpPfza0j0wG94ySL8ZQaHvCU/aw2mZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB6414

On Fri, Oct 24, 2025 at 10:05:00AM -0700, Dave Jiang wrote:
> 
> 
> On 10/24/25 9:41 AM, Koichiro Den wrote:
> > On Thu, Oct 23, 2025 at 08:18:07AM -0700, Dave Jiang wrote:
> >>
> >>
> >> On 10/23/25 12:21 AM, Koichiro Den wrote:
> >>> Some platforms (e.g. R-Car S4) do not gain from using a DMAC on TX path
> >>> in ntb_transport and end up CPU-bound on memcpy_toio(). Add a module
> >>> parameter 'tx_memcpy_offload' that moves the TX memcpy_toio() and
> >>> descriptor writes to a per-QP kernel thread. It is disabled by default.
> >>
> >> please add comments by the module parameter that if this is set, tx DMA is disabled (right?).> 
> >>> This change also fixes a rare ordering hazard in ntb_tx_copy_callback(),
> >>> that was observed on R-Car S4 once throughput improved with the new
> >>> module parameter: the DONE flag write to the peer MW, which is WC
> >>> mapped, could be observed after the DB/MSI trigger. Both operations are
> >>> posted PCIe MWr (often via different OB iATUs), so WC buffering and
> >>> bridges may reorder visibility. Insert dma_mb() to enforce store->load
> >>> ordering and then read back hdr->flags to flush the posted write before
> >>> ringing the doorbell / issuing MSI.
> >>
> >> Can you please split out the fix to this issue so it can be backported to stable?
> > 
> > Thanks for the review, and I got it.
> > 
> >>
> >>>
> >>> While at it, update tx_index with WRITE_ONCE() at the earlier possible
> >>> location to make ntb_transport_tx_free_entry() robust.
> >>
> >> Please also split out this change if the intention is to address an existing issue and accompany with appropriate justification.
> > 
> > This can be omitted (as far as I remember the part did not lead to any
> > severe issues) so maybe I'll drop the change at the moment, thanks.
> > 
> >>
> >>>
> >>> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> >>> ---
> >>>  drivers/ntb/ntb_transport.c | 104 ++++++++++++++++++++++++++++++++++--
> >>>  1 file changed, 100 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> >>> index 39b2398b95a6..f4ed616c6ab8 100644
> >>> --- a/drivers/ntb/ntb_transport.c
> >>> +++ b/drivers/ntb/ntb_transport.c
> >>> @@ -54,12 +54,14 @@
> >>>  #include <linux/errno.h>
> >>>  #include <linux/export.h>
> >>>  #include <linux/interrupt.h>
> >>> +#include <linux/kthread.h>
> >>>  #include <linux/module.h>
> >>>  #include <linux/pci.h>
> >>>  #include <linux/slab.h>
> >>>  #include <linux/types.h>
> >>>  #include <linux/uaccess.h>
> >>>  #include <linux/mutex.h>
> >>> +#include <linux/wait.h>
> >>>  #include "linux/ntb.h"
> >>>  #include "linux/ntb_transport.h"
> >>>  
> >>> @@ -100,6 +102,10 @@ module_param(use_msi, bool, 0644);
> >>>  MODULE_PARM_DESC(use_msi, "Use MSI interrupts instead of doorbells");
> >>>  #endif
> >>>  
> >>> +static bool tx_memcpy_offload;
> >>> +module_param(tx_memcpy_offload, bool, 0644);
> >>> +MODULE_PARM_DESC(tx_memcpy_offload, "Offload TX memcpy_toio() to a kernel thread");
> >>
> >> Offload typically points to moving an operation to an independent piece of hardware like DMA engine. The naming can cause confusion. May I suggest something like 'tx_threaded_copy' instead to make it more clearer?
> > 
> > This really makes sense, 'tx_threaded_copy' sounds really fit. Thank you!
> > 
> >>
> >> Also to make it easier for people to understand what this parameter is used for, please include a comment block explaining why this parameter is needed.
> > 
> > Got it, I'll do so.
> > 
> >>
> >>> +
> >>>  static struct dentry *nt_debugfs_dir;
> >>>  
> >>>  /* Only two-ports NTB devices are supported */
> >>> @@ -148,7 +154,9 @@ struct ntb_transport_qp {
> >>>  	void (*tx_handler)(struct ntb_transport_qp *qp, void *qp_data,
> >>>  			   void *data, int len);
> >>>  	struct list_head tx_free_q;
> >>> +	struct list_head tx_offl_q;
> >>>  	spinlock_t ntb_tx_free_q_lock;
> >>> +	spinlock_t ntb_tx_offl_q_lock;
> >>>  	void __iomem *tx_mw;
> >>>  	phys_addr_t tx_mw_phys;
> >>>  	size_t tx_mw_size;
> >>> @@ -199,6 +207,9 @@ struct ntb_transport_qp {
> >>>  	int msi_irq;
> >>>  	struct ntb_msi_desc msi_desc;
> >>>  	struct ntb_msi_desc peer_msi_desc;
> >>> +
> >>> +	struct task_struct *tx_offload_thread;
> >>> +	wait_queue_head_t tx_offload_wq;
> >>>  };
> >>>  
> >>>  struct ntb_transport_mw {
> >>> @@ -284,7 +295,13 @@ static int ntb_async_tx_submit(struct ntb_transport_qp *qp,
> >>>  static void ntb_memcpy_tx(struct ntb_queue_entry *entry, void __iomem *offset);
> >>>  static int ntb_async_rx_submit(struct ntb_queue_entry *entry, void *offset);
> >>>  static void ntb_memcpy_rx(struct ntb_queue_entry *entry, void *offset);
> >>> +static int ntb_tx_memcpy_kthread(void *data);
> >>> +
> >>>  
> >>> +static inline bool ntb_tx_offload_enabled(struct ntb_transport_qp *qp)
> >>> +{
> >>> +	return tx_memcpy_offload && qp && qp->tx_offload_thread;
> >>> +}
> >>>  
> >>>  static int ntb_transport_bus_match(struct device *dev,
> >>>  				   const struct device_driver *drv)
> >>> @@ -1254,11 +1271,13 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
> >>>  
> >>>  	spin_lock_init(&qp->ntb_rx_q_lock);
> >>>  	spin_lock_init(&qp->ntb_tx_free_q_lock);
> >>> +	spin_lock_init(&qp->ntb_tx_offl_q_lock);
> >>>  
> >>>  	INIT_LIST_HEAD(&qp->rx_post_q);
> >>>  	INIT_LIST_HEAD(&qp->rx_pend_q);
> >>>  	INIT_LIST_HEAD(&qp->rx_free_q);
> >>>  	INIT_LIST_HEAD(&qp->tx_free_q);
> >>> +	INIT_LIST_HEAD(&qp->tx_offl_q);
> >>>  
> >>>  	tasklet_init(&qp->rxc_db_work, ntb_transport_rxc_db,
> >>>  		     (unsigned long)qp);
> >>> @@ -1784,6 +1803,13 @@ static void ntb_tx_copy_callback(void *data,
> >>>  
> >>>  	iowrite32(entry->flags | DESC_DONE_FLAG, &hdr->flags);
> >>>  
> >>> +	/*
> >>> +	 * Make DONE flag visible before DB/MSI. WC + posted MWr may reorder
> >>> +	 * across iATU/bridge (platform-dependent). Order and flush here.
> >>> +	 */
> >>> +	dma_mb();
> >>> +	ioread32(&hdr->flags);
> >>
> >> Is dma_mb() needed if you are also doing an mmio read? Read can't pass write with PCI ordering rule and the ioread32() alone should be sufficient that the data has reached the destination host.
> > 
> > I experimented with (1). ioread32() only, (2). wmb()+ioread32() and (3).
> > dma_wmb()+ioread32() on R-Car S4 Spider boards, and none eliminated the
> > issue. Only dma_mb()+ioread32() did.
> > 
> > So this suggests the problem is in the pre-PCIe domain. The DONE write
> > goes to a WC-mapped MMIO, so the CPU/interconnect may still hold or merge
> > it while the subsequent MMIO read gets issued first. In that case the
> > MRd/CplD does not imply the earlier store has even reached the PCIe core
> > yet. dma_mb() orders and drains the CPU/WC side (store->load), ensuring the
> > write is at least at the PCIe core. ioread32() then performs the PCIe-level
> > flush. Please correct me if my understanding here is off.
> 
> I see. Then please leave a sufficient comment explaining what's going on here so in the future there is a reference for future code readers (and maintainers). Thanks! I do wonder what is the general performance hit of having an MMIO read in the I/O flow. But having the doorbell write go before the data write is definitely not something we want.

I'll add an independent commit for this in v2 and add more comments.

As for the potential performance hit, yes I was also wondering whether this
could be an issue. Maybe it could be an option to make the whole barrier
stuff platform-dependent, or introducing optional interrupt coalescing on
its user side (I believe ntb_netdev is one of the major users). On the
other hand, at the moment there are many performance bottlenecks, which I'm
working on in several patch series, and this barrier hardening are trivial
compared to them. So at this point I believe it's better safe than sorry.

Thanks for the review.

-Koichiro

> 
> DJ
> 
> > 
> > -Koichiro
> > 
> >>
> >> DJ
> >>
> >>> +
> >>>  	if (qp->use_msi)
> >>>  		ntb_msi_peer_trigger(qp->ndev, PIDX, &qp->peer_msi_desc);
> >>>  	else
> >>> @@ -1804,7 +1830,7 @@ static void ntb_tx_copy_callback(void *data,
> >>>  	ntb_list_add(&qp->ntb_tx_free_q_lock, &entry->entry, &qp->tx_free_q);
> >>>  }
> >>>  
> >>> -static void ntb_memcpy_tx(struct ntb_queue_entry *entry, void __iomem *offset)
> >>> +static void ntb_memcpy_tx_on_stack(struct ntb_queue_entry *entry, void __iomem *offset)
> >>>  {
> >>>  #ifdef ARCH_HAS_NOCACHE_UACCESS
> >>>  	/*
> >>> @@ -1822,6 +1848,54 @@ static void ntb_memcpy_tx(struct ntb_queue_entry *entry, void __iomem *offset)
> >>>  	ntb_tx_copy_callback(entry, NULL);
> >>>  }
> >>>  
> >>> +static int ntb_tx_memcpy_kthread(void *data)
> >>> +{
> >>> +	struct ntb_transport_qp *qp = data;
> >>> +	struct ntb_queue_entry *entry, *tmp;
> >>> +	const int resched_nr = 64;
> >>> +	LIST_HEAD(local_list);
> >>> +	void __iomem *offset;
> >>> +	int processed = 0;
> >>> +
> >>> +	while (!kthread_should_stop()) {
> >>> +		spin_lock_irq(&qp->ntb_tx_offl_q_lock);
> >>> +		wait_event_interruptible_lock_irq_timeout(qp->tx_offload_wq,
> >>> +				kthread_should_stop() ||
> >>> +				!list_empty(&qp->tx_offl_q),
> >>> +				qp->ntb_tx_offl_q_lock, 5*HZ);
> >>> +		list_splice_tail_init(&qp->tx_offl_q, &local_list);
> >>> +		spin_unlock_irq(&qp->ntb_tx_offl_q_lock);
> >>> +
> >>> +		list_for_each_entry_safe(entry, tmp, &local_list, entry) {
> >>> +			list_del(&entry->entry);
> >>> +			offset = qp->tx_mw + qp->tx_max_frame * entry->tx_index;
> >>> +			ntb_memcpy_tx_on_stack(entry, offset);
> >>> +			if (++processed >= resched_nr) {
> >>> +				cond_resched();
> >>> +				processed = 0;
> >>> +			}
> >>> +		}
> >>> +		cond_resched();
> >>> +	}
> >>> +
> >>> +	return 0;
> >>> +}
> >>> +
> >>> +static void ntb_memcpy_tx(struct ntb_queue_entry *entry, void __iomem *offset)
> >>> +{
> >>> +	struct ntb_transport_qp *qp = entry->qp;
> >>> +
> >>> +	if (WARN_ON_ONCE(!qp))
> >>> +		return;
> >>> +
> >>> +	if (ntb_tx_offload_enabled(qp)) {
> >>> +		ntb_list_add(&qp->ntb_tx_offl_q_lock, &entry->entry,
> >>> +			     &qp->tx_offl_q);
> >>> +		wake_up(&qp->tx_offload_wq);
> >>> +	} else
> >>> +		ntb_memcpy_tx_on_stack(entry, offset);
> >>> +}
> >>> +
> >>>  static int ntb_async_tx_submit(struct ntb_transport_qp *qp,
> >>>  			       struct ntb_queue_entry *entry)
> >>>  {
> >>> @@ -1894,6 +1968,9 @@ static void ntb_async_tx(struct ntb_transport_qp *qp,
> >>>  	hdr = offset + qp->tx_max_frame - sizeof(struct ntb_payload_header);
> >>>  	entry->tx_hdr = hdr;
> >>>  
> >>> +	WARN_ON_ONCE(!ntb_transport_tx_free_entry(qp));
> >>> +	WRITE_ONCE(qp->tx_index, (qp->tx_index + 1) % qp->tx_max_entry);
> >>> +
> >>>  	iowrite32(entry->len, &hdr->len);
> >>>  	iowrite32((u32)qp->tx_pkts, &hdr->ver);
> >>>  
> >>> @@ -1934,9 +2011,6 @@ static int ntb_process_tx(struct ntb_transport_qp *qp,
> >>>  
> >>>  	ntb_async_tx(qp, entry);
> >>>  
> >>> -	qp->tx_index++;
> >>> -	qp->tx_index %= qp->tx_max_entry;
> >>> -
> >>>  	qp->tx_pkts++;
> >>>  
> >>>  	return 0;
> >>> @@ -2033,6 +2107,20 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
> >>>  	qp->tx_handler = handlers->tx_handler;
> >>>  	qp->event_handler = handlers->event_handler;
> >>>  
> >>> +	init_waitqueue_head(&qp->tx_offload_wq);
> >>> +	if (tx_memcpy_offload) {
> >>> +		qp->tx_offload_thread = kthread_run(ntb_tx_memcpy_kthread, qp,
> >>> +						    "ntb-txcpy/%s/%u",
> >>> +						    pci_name(ndev->pdev), qp->qp_num);
> >>> +		if (IS_ERR(qp->tx_offload_thread)) {
> >>> +			dev_warn(&nt->ndev->dev,
> >>> +				 "tx memcpy offload thread creation failed: %ld; falling back to inline copy\n",
> >>> +				 PTR_ERR(qp->tx_offload_thread));
> >>> +			qp->tx_offload_thread = NULL;
> >>> +		}
> >>> +	} else
> >>> +		qp->tx_offload_thread = NULL;
> >>> +
> >>>  	dma_cap_zero(dma_mask);
> >>>  	dma_cap_set(DMA_MEMCPY, dma_mask);
> >>>  
> >>> @@ -2140,6 +2228,11 @@ void ntb_transport_free_queue(struct ntb_transport_qp *qp)
> >>>  
> >>>  	qp->active = false;
> >>>  
> >>> +	if (qp->tx_offload_thread) {
> >>> +		kthread_stop(qp->tx_offload_thread);
> >>> +		qp->tx_offload_thread = NULL;
> >>> +	}
> >>> +
> >>>  	if (qp->tx_dma_chan) {
> >>>  		struct dma_chan *chan = qp->tx_dma_chan;
> >>>  		/* Putting the dma_chan to NULL will force any new traffic to be
> >>> @@ -2203,6 +2296,9 @@ void ntb_transport_free_queue(struct ntb_transport_qp *qp)
> >>>  	while ((entry = ntb_list_rm(&qp->ntb_tx_free_q_lock, &qp->tx_free_q)))
> >>>  		kfree(entry);
> >>>  
> >>> +	while ((entry = ntb_list_rm(&qp->ntb_tx_offl_q_lock, &qp->tx_offl_q)))
> >>> +		kfree(entry);
> >>> +
> >>>  	qp->transport->qp_bitmap_free |= qp_bit;
> >>>  
> >>>  	dev_info(&pdev->dev, "NTB Transport QP %d freed\n", qp->qp_num);
> >>
> 
> 
