Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011049.outbound.protection.outlook.com [52.101.125.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154CA20E030
	for <ntb@lists.linux.dev>; Tue, 28 Oct 2025 01:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761614050; cv=fail; b=uYcvrez1Y0npXXcdD/m3Csba5Zr9hPTTq2Xj7HYV9NZOfgogASuSb6PvUSTAemtMhg/KlS5uNIANOmMmIquJf+0eF9uamepMRAriyaxuwb1NO4JoVZZMIQjtFREZu2+DNnBbJABdRGIaFjWhA7eHsiWYVq0EeFTHkAoztPGkZGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761614050; c=relaxed/simple;
	bh=Mu3roW/ztZje0bkjxT0tb+6w44yAlEzANzFu/rmo65Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PS9fz7HuLCTqbToeSjUKXB1EGADfaJZbsjnBQ53+x6M5jEI3IHfHs0pQUd2tH1tDtuv83q0ZpH8+L3ii8Z5kJhMEu11kso68JEoeSaQHZSMzbMwALb2N0bsxDC1rQ/8vcmfguFnRSFY5LAZ1goiN/pc94ETM0BWJIrFD+9YMvHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=S6roch+F; arc=fail smtp.client-ip=52.101.125.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="S6roch+F"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A7qQxWJdixkrC/YPYnLSHkzKd5Mt8bIR5HEKmyRaUJYFavUitpGz6wP4Mv3HorOOlfGdel42jCyAr6BkB6lQB87hHZVWtbpzWJD+03w1GGtNYTaZshL4uidREb3nybWLpECwlZFKj3/tfPMLH/chAQnF5qrHh8TbcjjtV60t1yXlPqgRUei8WSP7SmGlBRiXIDx1Fnwenimfc2uUDblfCGu2YfVvmH0ix/NJRcIuD202w3ZqKJVzpRUpz1eLri7NDtfgYx7AnuW6HZnWfMtM0wLcMF9SNm8pMKW1t6C3JCXDikyb+eqK+i40cw8yxt9eYIi6IilD1C17KBYOQsP6qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FYLPfKMo/+7XFaFxYaXXcERGxtzV/ufGP/TIlhwiers=;
 b=fjRyZgZpWV9+1FDHX3JLbN7pdOj43xkDaSzPYHlqCxK+MqZL086WPG1hD0IB0o2Rg4iWjTXC0f/3MZiwdYDbrbrARPC8AMEzq4Oq7r/awUZ/gSxUiBQTv28P2orguS/FrK+j0fgcLNUbdi4anZesRF5501/j6pyiBU0od0FVqcWKF7t+1itsYzE0uWLi7FtyeJxAl4UFkPPpKfO5ADqdUUGW3CEsW4dw6ql5LiTENFgSfprngxUH9ofpChw3SLB5BsOgfF85gnObH+G3tUGim/NywPv5/xPJC0SEFtWnXnBmlxw2G2eqJNz9Fha6O1Tm3oyIlzhFEZoJZwsBGbH5Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FYLPfKMo/+7XFaFxYaXXcERGxtzV/ufGP/TIlhwiers=;
 b=S6roch+FQnieytU4Su5RiIzX2j+WeTxKlHvUJAPVzikbhpVP7n8gp7tPr9aNNtc3viDFecxL6U9Mv6x6v1IzaeQjHH9r5D9trro/S7D+33GRclcdRo2wUWJYaGVztCQyzWwRNQMffMmivOsTPicMxsots0cto1mWWaTb+uPpyNg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:10d::7)
 by TY3P286MB3029.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:310::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Tue, 28 Oct
 2025 01:14:02 +0000
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a]) by OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a%5]) with mapi id 15.20.9253.018; Tue, 28 Oct 2025
 01:14:02 +0000
Date: Tue, 28 Oct 2025 10:14:00 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: ntb@lists.linux.dev, linux-kernel@vger.kernel.org, jdmason@kudzu.us, 
	dave.jiang@intel.com, allenbh@gmail.com
Subject: Re: [PATCH 1/4] NTB: ntb_transport: Handle remapped contiguous
 region in vmalloc space
Message-ID: <b527bouvdp3a54jkvwiqhfe62nlllsbxrkvstrea3lem5c46ab@bdn67yrw3yen>
References: <20251027004331.562345-1-den@valinux.co.jp>
 <20251027004331.562345-2-den@valinux.co.jp>
 <030a4195-ed20-4f5f-8841-ea5385bb4a8c@deltatee.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <030a4195-ed20-4f5f-8841-ea5385bb4a8c@deltatee.com>
X-ClientProxiedBy: TYCP286CA0257.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455::8) To OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:10d::7)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB0979:EE_|TY3P286MB3029:EE_
X-MS-Office365-Filtering-Correlation-Id: df1e2c8f-8801-4d66-cec2-08de15bf47a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QkQdjS5jJYaxFTieqB2NCSPXIgDQAdL3UzWhXgXpl2G6cR4SEzD7jsVz1nko?=
 =?us-ascii?Q?ueJ8xrzJXecZUkmfA3u1tWCDJeO+cSnBf4s9qG2gIP9hCVpLHMp1P7bXoKZk?=
 =?us-ascii?Q?36krtvtFTVswjWaDCoTMshGBenbog2J5+yLR6j+aTCgCXeqISZoQ6IBEIfa7?=
 =?us-ascii?Q?JhTfDMxy5gYqKQGmAytC8Km0rYCy9lF6EiQP77TlkxpV3Cql7UdReZMnD1Gz?=
 =?us-ascii?Q?BAzITzjI5HC4BeTimUVgDUwchw6dU/Dc7mll09XE1Ktc+WdkrJdPKjQnpq/h?=
 =?us-ascii?Q?T5tLXjfw/ibMn4rwohRUcjHWLgPvZDNWUrK5W3ZDenETXgwIj6S8acC9nx5J?=
 =?us-ascii?Q?7HNtjN62e8xFOj26COO/5r8IYWmCAcLvJm7RqTlOg5RKgJRJWOL8yoogvx9t?=
 =?us-ascii?Q?jxeV6w+/kGc9UICSr7Z/JMQ0PFuWl6ggpKzvE3VsgFC11gJHlmCTaXyaFZxQ?=
 =?us-ascii?Q?NOj8n5IXv2cXwZaBqZOKKKYxM3g2az3lqS6pOwOzKMseclR6oaL3uKl2bEeN?=
 =?us-ascii?Q?g+bfmfPuB4rmI9Hskk4UpUb6+0SJTNOCSaTx7H5mhk0+CVkd8Pwx4MjvIZfV?=
 =?us-ascii?Q?05iB+ylfZMQwO2ltCDfabY5KlixbfXd+U7BQj1WRfEd6+KIl3Guumt5yHFsC?=
 =?us-ascii?Q?DUbssFCRAypZuNTlm0vTrW9aVoQwGbIYJ+XNI0oEsz4mvaSEJJV/QJjZDEPu?=
 =?us-ascii?Q?IZlwWllrNdv78M7KpBy5GQdT8bf8N9EmgbfuReXEeXRzYJJf0qTnoe0A8Ty5?=
 =?us-ascii?Q?dzfEwShJJElyqlvma3QnRnPCHHEU5HFKfvXMxcK99y1yf7kTyvA+0vST87r8?=
 =?us-ascii?Q?nBL9YXnjxBaQP7AgrwX/xVCneEwFDp/gNDaWE+fzwtUAm0xIhEdy4f8Tqnh7?=
 =?us-ascii?Q?LjtUDBTQT7kO/0Khv9f9Zfcwu0fy7dXE1ZxMg97bdRWr6ydj9+kPkcfZ5TDn?=
 =?us-ascii?Q?W1Fxdj+OLaOUXMIEMwtxUI233TE/KuiTQo7G4hFAmRGK4Hnh3PRgXlYQEWbq?=
 =?us-ascii?Q?4Obmo3x5Pq4sDmEO7/9h8LiP1HodxKp3FlYpEFBGDc5twqNzzAv1jccWgn18?=
 =?us-ascii?Q?PdVtDGiBY0BZozHmhoEA4uIk2Z/z7E9VTgXxxq2CxQSwqFfkReKjZUklfLjv?=
 =?us-ascii?Q?eARZbMvyXt31cuvQ1SmXcBOrfmxnccz8AGPQfhKu3yYKpoO132Uy/BCj2pSI?=
 =?us-ascii?Q?PwJQiuQFMPsuSPGWhXDBMf/5I8uxoD0LD93cfPxCMu+fUEvp7JqlwKkuX5fZ?=
 =?us-ascii?Q?dbWnA1QIH07qh2uT3comElsSvAc7a0aFnoBiwFzmjz/SYBlutgey7NYuvsVz?=
 =?us-ascii?Q?JePq8M+l9qexLn33ojJmg87x1kweto8z4kxgQNgOm+LRk2E/IH4szOz4lPOW?=
 =?us-ascii?Q?t7T5KPZd8bhgYR2UiPaNZAzN46+4V9jmJk5Gu3WzEYkEXvST046O2Z9UzzdE?=
 =?us-ascii?Q?kul/Qh9q/iPWot+weBppDDoV7RwCiHaG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lNHJeDlghlRaFymI7moP68RYeP0d2Wb0ScxFEgqVSr7s3MOMFUF7fLot6gPl?=
 =?us-ascii?Q?zASEMjR/xQUJd4yuz/Dvp2dptjjNOg2CYW6314ov2N1Wchl2Q5Bi2GdZZ7WX?=
 =?us-ascii?Q?fAabqmj7AFCvpMPG70gBaeEfoWi2pMwKu78DHW9ZrbU8S7+mBVXAvhLBi0yK?=
 =?us-ascii?Q?vQ/5jnVp2TkCWhlA2MoPfZzgePHCcGygX9QaRk5ndCLMOCfAAF86PwTCS3Xo?=
 =?us-ascii?Q?MqRWvMwkFRncyhIb8NIHCbOdoNazJhjy7cI+H1iJAACOy7GQ0vNnW/00sj7+?=
 =?us-ascii?Q?inDOVPE+73xQdaM3Jv1SDAyPQejjvaEyyOWOpQpzzj7np8cvDtHyAjNOJd6a?=
 =?us-ascii?Q?92vO/AZwif54cYVl+DpGtGpFyDpejl1lOJseR2ysWdC/3Ngh7EfWHj+tZ2ZC?=
 =?us-ascii?Q?qpkSAjQgIUN3HMdOhIAikBpax0lWe5B7TtdVryg9+MMuZnJQBlrv/iGbzxPT?=
 =?us-ascii?Q?ZxHtxMHOVknyFlOr2QhOXSgdAUdYn7hADiY9mdQvqSHCAKk4G69j7JlI2JiH?=
 =?us-ascii?Q?RhnDH6i+bvI8BGE8gXrZInsD3d7ZFswsLf46g73xqDKalam5Zr8rPmxG0Fxg?=
 =?us-ascii?Q?ig/efXpWLEO5Z8unhEpQ+C4oLDwEXwCuBUSiXBl5k1VgbwX29r2Qxoy/+br5?=
 =?us-ascii?Q?f3efBXz/Z4G6+qNH4gk1ws1u0fdsdwkRd8tBT6dx1467fhrgf3gmH83iIhlD?=
 =?us-ascii?Q?7WY9mJCLSY0FukvbDtJ0D1d7alHbt39uQXEi/ktdzYL6YH7IUQoTGa0kuMdJ?=
 =?us-ascii?Q?3t8CsVI1gXZU2nrhtyoEGFAPiqOG1AbKiQnLZ28AJ6YP5JQTfSIWzLhrywJP?=
 =?us-ascii?Q?g022RGJkDWfxmqfRvqsBTeUD4Zn2lhOXUHMLWjogDeBJEaN+HGwhwJVRoyLf?=
 =?us-ascii?Q?rD1gm4PPAyxha18q54Y/c+FWvyhgmeX5s+kz4sqi3C2iQZ8P3QIXdPkuvIXI?=
 =?us-ascii?Q?Eaq9ju99TOqiOKkBpVHtUl8XfllvlE/ap8eYekX2RIITQS0lMvMumvm2yIZb?=
 =?us-ascii?Q?lQV7Xc5B1JcuQgF9iY8M/DBPiDG4Xnua+ZdmwAdbYOItpphEY8BLSkNLzw5B?=
 =?us-ascii?Q?6teSJ9aRWnDiy9gEewYywuNK/kM/msOV+j71YL0b7KSkYIXf4pMue+/dRu88?=
 =?us-ascii?Q?97TYK2n0AmKu96zoZMCafrpLGhYmbM1kSodpL8mJjIpFink5K44FKOjT7oFr?=
 =?us-ascii?Q?srirJLJWOujVsjBO1hKsoDmiSXoZRBqF0vfPzBvhqYbsvb118267nL7RW3MN?=
 =?us-ascii?Q?fxPykn/FHkLwrdQPaUTZSn7ShDgfc8Hkwivp70la/PQhrJzO17SIAW90XOxz?=
 =?us-ascii?Q?1Zrgj7pjSO1qGk9EnWEGXAn0cds/fk7ht6zYZMD4Y0F7b7HVEzYONy90mxZ8?=
 =?us-ascii?Q?KaK6Jy2VUECdwXcTbWoYHXzZH5eWDWas8d2olwuohdp/F8Dod+fI6wVymQp0?=
 =?us-ascii?Q?ZA+8tbh1ZNe7ipDFHE1BxawCeGavXb/VzzyA+wQxU8kIQEDhPUr83g2YqGd+?=
 =?us-ascii?Q?hZbqbjwi4j1mJ/4P0nNVLrdUFwh1my8TAgjd8axVpZ6JVZf4r/+six6zRGUX?=
 =?us-ascii?Q?xHJo39wojatqejUuY8Vhx87eKGQWWmqALzuqO+Gq5lVtTFsUFOUfTkWeLtR9?=
 =?us-ascii?Q?PhQZhmGrbx6WSWDPerZJ7qk=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: df1e2c8f-8801-4d66-cec2-08de15bf47a6
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 01:14:02.0250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Co+S60ZriEFzWRWcSRhRMAHH+hrTpJIg6JGNv1D7HSfx2uoCcPAEBZhmS3EWCc74UWclFTE3EVPKTkoj9qD+Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB3029

On Mon, Oct 27, 2025 at 10:30:52AM -0600, Logan Gunthorpe wrote:
> 
> 
> On 2025-10-26 18:43, Koichiro Den wrote:
> > The RX buffer virtual address may reside in vmalloc space depending on
> > the allocation path, where virt_to_page() is invalid.
> > 
> > Use a helper that chooses vmalloc_to_page() or virt_to_page() as
> > appropriate. This is safe since the buffer is guaranteed to be
> > physically contiguous.
> 
> I think this statement needs some explanation.
> 
> vmalloc memory is generally not contiguous and using vmalloc_to_page()
> like this seems very questionable.

Yes generally it is, which is why I wrote the last sentence "... since the
buffer is guaranteed to be physically contiguous."

> 
> I did a very quick look and found that "offset" may come from
> dma_alloc_attrs() which can also return coherent memory that would be in
> vmalloc space and would be contiguous.
> 
> However, in my cursory look, it appears that the kernel address returned
> by dma_alloc_attrs() is eventually passed to dma_map_page() in order to
> obtain the dma address a second time. This is really ugly, and almost
> certainly not expected by the dma layer.
> 
> This requires a bit of a change, but it seems to me that if
> dma_alloc_attrs() is used, the dma address it returns should be used
> directly and a second map should be avoided completely. Then we wouldn't
> need the unusual use of vmalloc_to_page().

I agree there's room for improvement around this "double" mapping.
I'll think about a follow-up patch to clean this up.

> 
> At the very least, I think these issues need to be mentioned in the
> commit message.

As for the commit message, I think adding one more line like:
"See relevant commit 061a785a114f ("ntb: Force physically contiguous allocation of rx ring buffers")"
should be sufficient. What do you think?

Thanks for reviewing.

-Koichiro

> 
> Logan
