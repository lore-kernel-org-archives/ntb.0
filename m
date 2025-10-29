Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011064.outbound.protection.outlook.com [40.107.74.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3A330C358
	for <ntb@lists.linux.dev>; Wed, 29 Oct 2025 07:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761722051; cv=fail; b=a8zIgBWSvSvDh5n7Wz4z/ZwLNjqhGLUdcMT/Vlm4e5QtoKSHQ0zN/KEOOwdL5jdfjbCUdrpiH2rKwOfYBeW27pscM/INkmGlqul686+BXcRS0K4YswVpDDAq9OEoIQevIeRP8R4BGsNuu2O0bYgcMxzpnKhGOC+AcI+0rqh9DAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761722051; c=relaxed/simple;
	bh=J0AizDeUVlE5c/lBa7dNmv4z8OSym+BkR3COlTXwouE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=r4x+iLd6qf9hn5J4anjjt2L8DvCV+FdxFEg/JIu8Lq8QtUuMy2dTurCtoUoZFPGbHtlbvXTPueLjgRtJoo9r0R51+gkyNLaRFoVAvt/MjcE4wDHq/5iPBOXWhmKMWXEKUZJrDWiaE1ZpIwvbJALAQzCe2MFjd5gsgJKEPkp9XMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=I/pbkzwk; arc=fail smtp.client-ip=40.107.74.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="I/pbkzwk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D4cLh/L4Mdl4S152fhT1Qi4GJL0Q3LGVeqmgI+XAd9O3U3GKzVdcYaCI+jgTk+MVx05D/XbnUBeQr7IhHqDPDfkf6zChjAGVQIo/4PGW8Ux7y4lz6FzvKcChxmDKOck0+ZBJyIkt1VjPnYjwM+htyX5N0ZzZCjjv6ONQv1DraL08XvMCuhqXpLlZ9WPOHM0mBenqzC30mg/FdfxdBz+s01KIjoa0rdPqlk0joYkAZW5vEkiaU22UGOnp/y0RKuo39DJYbYLX4r7K6eMg9ZfKm83Oa3ugJ/he0bsrj+PoOF/xm2GRAAokAG73OuOY7GXilRJ9TOKR/aHW1qSeFNNgpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c73h98DbO4rgY+BmIN2t//bsLtqzI6s4vigjuEAFBUc=;
 b=iqrBM0pJQ/OHFM/JzWbOm5VnWeMvK5Y1BoZctEeDL+mSq85VyxqEs27eEnrXvJW/pML/wi+iVgx+EYmHVe7j5X9tuHIT5xBIMpoDmQAZ1NchkIhvXDCcj/z8csh6iQrAPhrbdgjRobRFqk/m7qZuTSVaCEuzjrFWjHZ2WgQSTOFs6Xh0Vt+y0rlrPra+6oo/V6RKgozsaNb1GR6ks1WWH3Fp9/nPhnyCMebUQdT16LXAQjVzKnRwF7IKffp+e3By7r0lIsPUDsRbeifrbrj+1AEUEt2O1n63RrxX6Tz38LhUuUSIG9iCYuRiGcOaWTcgxVg0jhKsBbWMmBTKzelCtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c73h98DbO4rgY+BmIN2t//bsLtqzI6s4vigjuEAFBUc=;
 b=I/pbkzwkjTLseluXla8a0XPnMi3WiTwa23BbZqZmIGNCpzGc90iR1l0JNK1c1cilCNOQmup1sKR6J5yZHLv5LBfzU0BrtGV/qX1CEIk4O9JOoHLmoNVpPR5FHJSrc6by1kLlmIaFhctWJdcZn38gIWwLX4uQMP0Ok6rSwgnNnnQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:10d::7)
 by OS3P286MB2391.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:17e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 07:14:04 +0000
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a]) by OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a%5]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 07:14:04 +0000
Date: Wed, 29 Oct 2025 16:14:03 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: ntb@lists.linux.dev, linux-kernel@vger.kernel.org, jdmason@kudzu.us, 
	dave.jiang@intel.com, allenbh@gmail.com
Subject: Re: [PATCH 1/4] NTB: ntb_transport: Handle remapped contiguous
 region in vmalloc space
Message-ID: <gyvhwl4rr2xt2alxap2x4fwkvseaiie75ovaf26fpxng7b47tz@emshhyrkhjl3>
References: <20251027004331.562345-1-den@valinux.co.jp>
 <20251027004331.562345-2-den@valinux.co.jp>
 <030a4195-ed20-4f5f-8841-ea5385bb4a8c@deltatee.com>
 <b527bouvdp3a54jkvwiqhfe62nlllsbxrkvstrea3lem5c46ab@bdn67yrw3yen>
 <f32278ea-a1e0-4ef3-b611-da4d68b2658d@deltatee.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f32278ea-a1e0-4ef3-b611-da4d68b2658d@deltatee.com>
X-ClientProxiedBy: TYCP286CA0007.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::12) To OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:10d::7)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB0979:EE_|OS3P286MB2391:EE_
X-MS-Office365-Filtering-Correlation-Id: e037ee04-12d6-433c-1fa0-08de16babe14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7CwWDAc1n84abe7HH6QLy539A1E9AmKPuupuw6dYEACUvZnC6TszTYTv1Fu6?=
 =?us-ascii?Q?+P+aRkL29lIiUXgMYxumv3JVjlDBwC1Hz9XWoxFNA1/4ywSnGmeL0kproSMf?=
 =?us-ascii?Q?hdTPEmxjhcwzFkcZWLiLlBXcNwy2LhzGj4AlTgZWNSLdkMFhL56chneGSNMV?=
 =?us-ascii?Q?fnpeKNAiRoALGU726jmiRhG4yviPgGw+r0uVOXUee5dQN2FBKc4Ea/koAVMu?=
 =?us-ascii?Q?rGRSsZmLlB8noyYmf6LEgINqkiyGEMwzNYgJfu+Kev2355at0UXFcrvgd/C4?=
 =?us-ascii?Q?XzW4AYf8/UqztoYg51ISHocrH45PVtYzE6RLX3Tl50IDtu28TA0nILbtIDE6?=
 =?us-ascii?Q?jDAA4pMFhsXbYHdHyjg1JDoK/aotf9TSpfb2aSzE+ztfuJM8ogSDRUHEZGr/?=
 =?us-ascii?Q?l+JMqmHi/yS55LnBCamNKj/WWjUQXDM1B2N7NeS0bDLj72f6WbuPi049HFOX?=
 =?us-ascii?Q?7woUAqKkY4b3bbw3pFEZGIu+ynurVtkNfW/DsMpjbhh5BXOfDNRXyu1sq+lD?=
 =?us-ascii?Q?z9ERwFmdvo703rZ+Am5vdUUHwly5zVXoS9DgawdeCr5XdKvIKx9Yv9xjWAel?=
 =?us-ascii?Q?CfEY8w/w8FwzN+IXcq3pIooA37lby/yGrRGmil48QCbV1ZX+E87OH8RMjgsS?=
 =?us-ascii?Q?izrlisP7GvxWCcpmaNaWLFvLKZZaOcwPvrLtTI4xmmaBNV8cGuEUAWfuoksc?=
 =?us-ascii?Q?0pFjNBqejYFQL+Yu0qn3shGlDHov5GFrn2Jnvt2TxuWGSgwcWgTNGK4QXiCM?=
 =?us-ascii?Q?jzGiqmRp1ahT2r7eMpYSJV2GqZJd/L1ZYmCrTm4QBRA+DbVrKB+P5WpXdPxd?=
 =?us-ascii?Q?34lakfeuvGbBjA+/CbKp7Ly90enaAwG0HHcrgCnFLjyWqR/O/3MdQMgitV66?=
 =?us-ascii?Q?Ldh11FS85kX61WRv3ScGx6bmd+kSEJkC8tv5rvcvZvZ2EG7jRrX2YNLq2EqF?=
 =?us-ascii?Q?rC877T80jVIoZhrN3h5P39YTZv03X33fCdAAGULXFOI3Drc+mswU0SfS3Goy?=
 =?us-ascii?Q?NKwPiqEQsXi0CdvEBw85K2VRA9aosoyy0lh1V5hhYkBmvxVJK57E/QB9LQ1a?=
 =?us-ascii?Q?VnYNVI8ERcGfIkxVPbAPucBRGeJDjYWTQysaaGqqveqVFipf8e3EkWbzR68J?=
 =?us-ascii?Q?hY/YekfJ6NiwTj2ft9chhCfbsOG/adMmpufcCwp0IgRZBlnN/bs/JzvYJpeY?=
 =?us-ascii?Q?b7DcEXLokLGzp0iUsIgEaGV5YRsAdhtCQExvRTIOJ1JjvgNycqiOIOcW284M?=
 =?us-ascii?Q?gqxF9n4s8cFxpbfI5ASOeScMc8qSdGFqir/1V6h1q61CHGtQKxeyBvPBgwWp?=
 =?us-ascii?Q?x8eD4vZ2WN4zOAlwh+Ag+sQgNdrfYFJH9u+8UUALCm9OkTrRpboZiVa0/C7Z?=
 =?us-ascii?Q?ZeYN0gW4ccRmaA4EwHE3kRVwvLUWX0u3ke3kemqQHs+QUF5oZJv8+hSCiw+o?=
 =?us-ascii?Q?3MGv5xuopjTR2OoL0tfdM4Sf7U528iX5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q3DdyTiV4qbcBPDf4w3pbp/X/z+S8Wy0rMLXpFoNf1aML6YHY26MlnYShRUT?=
 =?us-ascii?Q?rv+NXvf18o/U+/4TVX0GrQdg8UJ3f+FD9TLgD3hhE07OLkMFEGznfoVdd+KM?=
 =?us-ascii?Q?FLsM+hjWMHJZD5qWmdt7bA/espxsF37HeauAc5vrg2ZAdc18owb9Buq1Ek5h?=
 =?us-ascii?Q?DXMG8U+Zh/0rm+s4aF5KRaxwmrJRQI8p7/D3wjs35+S/lHzuc0S/Q0NlYP8I?=
 =?us-ascii?Q?KP4JEV47aT7t7CtXeJJFlk73H2Rpk7rvBgV6cfc+mIKPD0FIXBBoxz4UAUTU?=
 =?us-ascii?Q?VLlSMIV1qletNB9keL6dLwTVFic18fb2O7okvd4tdfus0EG0svaLNaz80vsH?=
 =?us-ascii?Q?DEq8YEj/s/0TXtsxtvqWEFaF8t6rn+BnwLhMRkdoWGasC3ZLrSQFC6lsF8Ow?=
 =?us-ascii?Q?sR3y7+N+xWsmjGID14U9gySTzPpLKvXNFZwRZ7qvhI/dJvVupikcmSWQZzwT?=
 =?us-ascii?Q?iE+tf4X6HuPFdE1QL47hIfOmkybnhYLLvbuVGX1nZoHBVgcS6tBzUkD77M7J?=
 =?us-ascii?Q?HtjAQmKFa192FjCXeCHUfpzmDbKUn9b+1/NSOaBvAQFOwokXcftHSrsTUPx7?=
 =?us-ascii?Q?8FhBkT0xsGXUJq0thtdFjF8H6tqSgviOZAnXhExRrtVIp0WnUX1I4Uoy6HpY?=
 =?us-ascii?Q?nkd22ZwCv+MS6iGVOEYZ/3GykC3gKOMVQWkZz/rmSOSnAWyyq1p6J6Kigp58?=
 =?us-ascii?Q?yrfmvzFoq5LEJd+3AmT7zEtxYN4ALEcB00Ua8ailTaEKLOH/jguRBnMxJzzR?=
 =?us-ascii?Q?1lff2tMOoHvPTwdNlekdQqkNTt6yrxXAZHLslEW+MulByN/BZsGhI/Bn/42K?=
 =?us-ascii?Q?ZTvCKyAFjZcDBn3c4vw3vJ2mAXwKIvosj8I4NvRtacwkwUcJo9xmLgrsjoOu?=
 =?us-ascii?Q?CDIooirzl70yZo9rbM29ezVho08QzK35F3/CgN1NqGPhww0rDX6kX0Or6Fhz?=
 =?us-ascii?Q?J7/wtp8XjRC+9SaoqLw6vbCwe+OydMjlsk9Cr7VCB6tMiTzwfEwlEHnTpfVv?=
 =?us-ascii?Q?kxli6gcRcAc9TSgD48LVSldWifUCSIzr7J+gfyOcIQ+q8XjdcDZWACLjqeH1?=
 =?us-ascii?Q?QEJxAvyUu0iC52arjAC/xPaZ2bVhz7A99WJ470Fw+w9FHJiPOZxT39YjPofg?=
 =?us-ascii?Q?XSnBKB/nzJ6h12uMTKx6ss0b+U6GMgX7AvQ/AXJrWHoic0uJoS5paCkvfhQW?=
 =?us-ascii?Q?+8fuvcME1MJZ0et5bXKj3W0XMe37lyyakLiy7D8ynutcewCsBqE7Zz/rFIOI?=
 =?us-ascii?Q?h3Tc71wpRFrI8deL9zpP0A+asYFcfh/uvRbHiRXb29/wglWNoH2s8PiMVSx0?=
 =?us-ascii?Q?+jg55sTHtQ1hhxmglIw6gkFYWyG8Ki+aY9PPpjPqX1dvKfwjb6cnQ8bSIqxW?=
 =?us-ascii?Q?bwjneDYLITdtFO1lm6CF8nrt/Q4LDP0LQwKAY8O8QdJB22G4kmy0OHVS4tR4?=
 =?us-ascii?Q?nAIqGFhM+tg2+VxWqO6ciy148AUKO9lqk7odf+rYFUhGgkHnOFHy1/apKT4H?=
 =?us-ascii?Q?7bQN8MlqoRCMME2Hs/GUSwy3CK7SZSlr5MOpeWJtzMpYyG+jeHbPA5wScHw4?=
 =?us-ascii?Q?IB7kp2DPq0anLOngLzhPOaLRVLW6G+yCaj9cm46F0Pl4L3FMjdjaa5viMGo3?=
 =?us-ascii?Q?1r8LryfkN3Qp2ypJhijfB5g=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: e037ee04-12d6-433c-1fa0-08de16babe14
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 07:14:04.3748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JZswssOQfvzZDNqxxPQ0gIjXTxd0CS8dDYk0D1TOZNIQ6K+coLxR88XRMoHjU7DF5drSoovdUv8fqFJjbl5f7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB2391

On Tue, Oct 28, 2025 at 09:45:30AM -0600, Logan Gunthorpe wrote:
> 
> 
> On 2025-10-27 19:14, Koichiro Den wrote:
> > 
> > I agree there's room for improvement around this "double" mapping.
> > I'll think about a follow-up patch to clean this up.
> > 
> >>
> >> At the very least, I think these issues need to be mentioned in the
> >> commit message.
> > 
> > As for the commit message, I think adding one more line like:
> > "See relevant commit 061a785a114f ("ntb: Force physically contiguous allocation of rx ring buffers")"
> > should be sufficient. What do you think?
> 
> Ah, I see why that is now. Thanks for the explanation.
> 
> Adding the link helps, but I still think the commit message needs to
> mention why the memory is guaranteed to be physically contiguous.

That makes sense, I'll do so. Thanks for the review!

-Koichiro

> 
> Thanks,
> 
> Logan
