Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020141.outbound.protection.outlook.com [52.101.229.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1100347523
	for <ntb@lists.linux.dev>; Wed,  4 Mar 2026 08:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772613041; cv=fail; b=TcUWDMaWy6SWb8tnmw/7z6BttoXPMxMbVhcmdxVQx+Tg0xKpA3M8HDi1v7TTpYmIG3qt1fTeUoCsEDohWZQQ+PG3pdAs6BdTfQeGhmcdQT0bigfqYsb8w7f6Ug8cRAWuIMX8ERDkRPZowJCObX004hKYWvLq3mu9yQFOv5Pi+9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772613041; c=relaxed/simple;
	bh=2NtptP41+TCMG55ct5znd7Gf7yojCMs0tgfZc3oKqoE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hpw8/4yJoLDAHgOVVFOmbIK9NWAQWbLhoytv0AuvqtEGL+IrG8LcimZUwpv++Xf4GI9AvAtg5GMRAqdhIVy9pGfUlzR1Ii5JFmB9M2Ou6HlLg035DwhswIMiw3G+pwObw3dVErYJ8hkLpXxXsO7vvTEGq+zOni2g3VcFx6gsBfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=GjaJmyMk; arc=fail smtp.client-ip=52.101.229.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="GjaJmyMk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LbSMrhC9IKCgGbzZncNt/PCaYkdrgWVq4i1xkntNitdLwdQBZpW2x0Su9GT1tStlIqq5L/F+l+eYpkG6DVXSYC5cPseXUfMHN81U+/BMPZAsrIDcTTKMdGHj5TMihyw7t7gn40tHEtWRn4SSVEKMXzuJrNN5C+Kb+o8EMYBLxbUnzmG9zhDwD+7JEfkwD0YCv4q6h7c5TjE9y4SMmBKRrE7g1ImYhcsNg8r1G/Ja85wZ/4BhZO5WelEqBV1KiDlVz2cZ2b9uNYTgii2UlXm+F/7J70HK1Ykgbsl5JgWONhtzYnAx+/93rNiUSwOBiS7QEqXnk59SaeFi862UWdTmDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e+t2eTWBiwUcLGgLasMD5iboNDKA+ANbL9uNFmU89R8=;
 b=Fq/hZSfeG+hECroPGUdn0Q/rWUK06KYHlOGWQ63jNMHPfmoVBRl0PdF0St0s+6gs2LFNROLOmSrEDdnXvor7fYEH38az/PH8oDviVqNeY8QwCva0qXi1RXBEGDrIcx/CtCAXB/BrMSyW2lqnr9IK4go4Ajc2+LGiTsOMVzuqc4b0O/wxVLN91j/lfFkkOw/u52BFEhz8K0sfC6Cfku4PExgRsH/YmXOga4hrolR13XamxAe5E2n3WvEQbKwAhHFGd5Q3+0k640sOMYP77NLzOegrKDXNhO7x3bW8TkhCu1KtfNViQyPR+Gx6JH391/hF3Mlz/9Uvi7LDBKjfuHyWcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e+t2eTWBiwUcLGgLasMD5iboNDKA+ANbL9uNFmU89R8=;
 b=GjaJmyMklRHaIHFvcDvKcXI3ck/zG3UXhbJpMuYzYvwDVKzhWuumsQZjv4ZgEtNrKNraLKrBbZ9zRIfyiYrszzjlMQFdkdBz1vfigIbT07VBRMnqPdpkjCMMcP5X5RXi5Gq32q79ErDJu1dwESAqgr+H/JjKR67e9D2qcMULONc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYRP286MB5686.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:2d8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 08:30:33 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9678.016; Wed, 4 Mar 2026
 08:30:33 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Frank Li <Frank.Li@nxp.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] NTB: epf: Fix ntb_hw_epf ISR issues
Date: Wed,  4 Mar 2026 17:30:26 +0900
Message-ID: <20260304083028.1391068-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0109.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:380::15) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYRP286MB5686:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ea2ab87-ac1c-4ba4-0e3c-08de79c84d69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	zG+ZqmgaBqnnFNwNnd5DVPif3ZDy/bPs6oIJBC9blS8g12rkwzMksjouzylHilWFBw3WfjdhoY3ps+CTCRmjlzLRMPWNUsNv0kDsZZ0IrvY7URWeS5wxPLTHEgYuz2lYQluaqfKfIemYXX4M8FmVUo1DrbmgB0X50bB981VT+L0LK8b+9kU8dCplK07x2RGQmbKgqZ2v/l6Pws+BWFsS1Mol5XNIiOg9Ig+k3e7lXFNsqhkPlphQoTEgrIHSH9b3iB3O3QfNzL1vU703O5H9H13jnfxq3CytUk5wEIcqZnw04GPS3Usfsz884UOgWAlwGL5vECHxTsM+in09c+z0S2mn6sSAATo7MuZ5gsA8hTe095jZer3kC2StyG5aWE3pYvWQlEv2N83AicR8j73iscLH4CE1v55E72gdPCVlbNru3rTxdc7VO8dyhHSRBGj7Jn5QDQl7fW2Hru/ZaHSAer+j2qML3qr4rDHLPCMOSyIpD+zy32JZyeV2RFRVLef7qL0JlTqkSodRbSnRtmeBJzi/8IfBdf9/TzTIy6UODq5ym3/4Gi42c5hJnJug75PmGvTsmgx0QJ0TCVHbqRDv+VVvUDoFHxna57+r7ItZGNKtOxhljPASgD1xOu8JfCAfO/bSFUsO5D0l15RgBsp0CFYc2XwZkWwldUc1MBnem3w24LWtSGK7X19WSRyD84hwesW2K51VlRohiCRtbwxDRSiBmgMV7Cwjsb1kBHgkBA0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rVRrVn9EW1ymLKfg14YprhSMo+HQVOFXC/mqDD2/ZMNgXUYKGjnLQrwVC+yv?=
 =?us-ascii?Q?iSwdQC2Y27Orn0w0pwFSKJ5LFnjBtkZwPbrGL4nR5dwQT5msRGBYrbGF+Wzx?=
 =?us-ascii?Q?03hfCMpWURXy1bhawgB9E6Fpyzh6zRYXdIHgHWJB8qyiwco5VH8ZNESuAzCX?=
 =?us-ascii?Q?aMcCCsrHV2RBgINIi3DJoR88DUhogqbDukxdM/A6z7EpWQz4/fb6bkhMnxI+?=
 =?us-ascii?Q?LY22NYglF+3LV0WBFM4rvytm4LdgcJ+p54epggA9/eOGEVvEigPuGhXyvJOo?=
 =?us-ascii?Q?tgxYnNV4zzu6PXVqVlDQ67Cq7V35b5460pGU/3nxf+KUnuc7NBZEkNcwpJh/?=
 =?us-ascii?Q?3XEVVH2wZFDunpI9PMwN8PHsdYdmZppPK5EonSHqVXrcPIN7Exh3Mqnke7U4?=
 =?us-ascii?Q?rQmR9BVWvA5lr8SyWONkzRBRajx1pyQSOly4rgQ03rKPbsS4AfDW36/fY4Df?=
 =?us-ascii?Q?nq0wMNTmv+YjwU67mpahyEg3EJbpLR1sevYR7AOz/vpFxfdMv3ujr4bz5UI9?=
 =?us-ascii?Q?r3W1R5PlX63aDwfkYsr+5YOxRdRMW/nivT846WOs6ZkQdSP8kmV2hWg8xMUM?=
 =?us-ascii?Q?57lQzN/47pberFP7LLIoz4fJWcWrCfCp5fcoi3U1tceKS3gpzhFXBDxYhjGR?=
 =?us-ascii?Q?+ALUN2k4UENyxrWmh1lF3Aju+MeME9ysvMIPC79GcN92PHDb03e5jD8n41se?=
 =?us-ascii?Q?1sTXuQrj+yMr1GBeDjZkd0FkqfUfJpifX9z594LVfUh6gY/HIb9YqkxjHVTA?=
 =?us-ascii?Q?0GMUb8eSz9m9yI9GRPkKTIcbm6vdnpQCcE6nT8Cm+STMfgODdUPelNEgsxg3?=
 =?us-ascii?Q?3yttcwK+dQXXa9jmOxN7PMiP2ELJfX5vZ7J8VtBxXZIS6n1ihqDuc/hadd/y?=
 =?us-ascii?Q?OrPV17LFpOBcaf7fEoMbimNWsQ87lCjCdMxEMFp968NkjHxiduFbX3/lVxvr?=
 =?us-ascii?Q?VF3rBHnhvx34iC7dRNvDO69Kh0X+3GiNqMh53l0Hak7h1PZ0mHSpnakbiBal?=
 =?us-ascii?Q?/xhRBXYzaMYE//pOSUG8YgNiPT8kRYTTcTrP0egllp7OV0vny0ZB/cLU5nCg?=
 =?us-ascii?Q?QUV5YhCInNvO6SLpGoL5JTwrUqJg/I32rPAuHuV3gCl5/YCH/1Rlm3Uc3TAM?=
 =?us-ascii?Q?3bqPmzMgA3diIiowoxdaHcU62LcG0/fZan4XUJ5X322sowFDNlnmpW/tuw1r?=
 =?us-ascii?Q?2iufv3hd0XI/YSbDKCIh6K2ZIKlFTSMilOqm32+xuDKi9WPlgdrIDxdbF6lT?=
 =?us-ascii?Q?sr4oLRpBKKCmZXDNaiTHLNJTm3CX9PURx9J3DUyejThokfkDPHKAKVoiWA+T?=
 =?us-ascii?Q?bE6w/dSreIAuBJM9oFOYzVvw5dwSK+m+qjRf8KIBqEmd7ifpXMYUGX62PNuS?=
 =?us-ascii?Q?bisUDXpNkO5C9RFSsr0lUx7FxYMxmqQxWGQ3av2bUBxaHpdn0HOWQuh/yVib?=
 =?us-ascii?Q?3w2ONDtQqvQJi4Rz76LYpi/6yUkWk3AJWyQ6SoEWRQnrC6peg+fd2/XdEtS/?=
 =?us-ascii?Q?RJeGR4HtRYsujLCqnbGu3brMoae1/FPLPcHJJmtk4+rFsp2fcofyWyLHQ/mb?=
 =?us-ascii?Q?PBPqleB8LfUj+eRgEBF0p4uFyaldcdRAStMWaLbxhXpENl6WT1C5ndaPIq0E?=
 =?us-ascii?Q?BY0w0/Q4A89/TN6weV/Wm6yXMD4RSedzKp8AqQGExtIwxWyapsh4NoZvwY7k?=
 =?us-ascii?Q?iCv6ML3J+EPs2xB5wetVqIgiCrG0mUNTPVqXAa9YjHTP7iCStyIXCSgkesxF?=
 =?us-ascii?Q?oW8KIDQd0iodV+NH2AW8bPXClmq7LkWMsUek3lzc2sRfU/k7Ajje?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ea2ab87-ac1c-4ba4-0e3c-08de79c84d69
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 08:30:33.3069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DjHkXuDLm5y0CYRGi8boSa4tBCVdQCfSHtBvMznscNeuDIuMcZRXbQjJB/0pW7RRRnmlpuXV4UlsQO2I98FgeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB5686

ntb_hw_epf handles doorbell interrupts using multiple MSI/MSI-X vectors.
This small patch series is to address two issues in the interrupt
setup/handler path:

 1) ntb_epf_init_isr() does not unwind already requested IRQs when
    request_irq() fails part-way through the vector loop.

 2) ntb_epf_vec_isr() calls pci_irq_vector() in hardirq context to
    derive the vector number. pci_irq_vector() performs an MSI domain
    lookup (msi_get_virq()) that takes a mutex, which can trigger
    "scheduling while atomic" splats.

Patch 1 fixes the request_irq() unwind path.
Patch 2 caches the Linux IRQ number for vector 0 and uses it as a base in
the ISR, avoiding pci_irq_vector() from hardirq context.

Both patches are Cc'd to stable (v5.12+).

Best regards,
Koichiro

Koichiro Den (2):
  NTB: epf: Fix request_irq() unwind in ntb_epf_init_isr()
  NTB: epf: Avoid pci_irq_vector() from hardirq context

 drivers/ntb/hw/epf/ntb_hw_epf.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

-- 
2.51.0

