Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021129.outbound.protection.outlook.com [40.107.74.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8B11D0DEE
	for <ntb@lists.linux.dev>; Mon,  2 Mar 2026 14:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772462740; cv=fail; b=n0ntMrgEw3RA1nKoymXoq3hfq3jKq7jMAlBzau74dP79Dz55hm1PqQwM3F4ROLTE6IVbbiNc2dITXA6/SdvgcJXAuQqQ3BNG4IzEpionxtl/u7S01gEqfNt3+G7EfrwKtip93Rv3+26HMMOAYGKrvy/KpbDRBikKA7cOe4M0DAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772462740; c=relaxed/simple;
	bh=e1puYdwIW/fzthIG6HzMDcIBVF7E69UFW5SiuPFep0E=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=T2VmHnaNz+uZkgUcXYsfdHdK1Nc/xVHsgPvBLCTITfrmlB9tE9Fqe9QLhM9OLhxb32Ys3GM/v1SI9C05rpMB1YsXmpv5yP8FvsoFusxrXNYVPzDUdaD7ivhmVQiXfzzDPXLk5BldaayrX9p+BqRoyFyusHanvjN0FGncWzHHWos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=aFWc1AwZ; arc=fail smtp.client-ip=40.107.74.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="aFWc1AwZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K+zFRPAPI05YlVZwsTZIXehQ04Yy39NNqwtHtNofosDZBIgmfFSnw/AfmJFkqSyQ04l2g90fFR9RGN15VtkT1iDL3iT9BACg9My4eTd4hAYLOB1T94FWyLEV3hwXv2cGaPi+YnIak+ikXupbR04Q/u2g4rhY3uTa7pnYcxz3Baoyg4iFC5dRtR6evZaFeJHIdZvkSx5eDuui6Iqq1GqUJCJ6SLM8QZOYiD/NoHOzV/V8ONH3n8FMpntQxYS3gPdO2ZjdEky8El2w2IifrPe/5tv6xWCLOPvG2SNW7oAVn9KmW5hk62ff5X2vZM8ZyJqzHA5B0q7hdqw5nAj6B7iRpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ph8XTGz4ELawyVovV+4LKgzxdNRqmCogJ7L2KW6ojfo=;
 b=Prf/HHj+Z2QkDtyovP50XP0pVVZ4EXYWcX8G6E5PcED61yEKE2KNBDVTdupP5QWUlwUWqiUGYEq5XITWnWxfnxKhpv/X0BUoz09GgQ9Terg1WfGcYURBt91uIRidQKRV2ZSV3kIOXHoa5fuouwEuRGZvKMGnxwaobuYliEfMe7Z/MX1C9prYoIvN0Nm6VYyjb1va9krD4slrGtOpfXrvjp+XzLLgygu6ucRwJapeXUI5NyEtldxrmzQ2ZH1Ygq3iJDJatGHWuv23wMFzbW6G4JAnWEeHH7a3kO8/UAGhsyr0FUGDGvHeuEFTpbOYohp8Fij8y9n8eYstdZf2v6OQZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ph8XTGz4ELawyVovV+4LKgzxdNRqmCogJ7L2KW6ojfo=;
 b=aFWc1AwZzbUUAUZyz4sY4ZShvFa9NzSWEL9KKx5jTxWlTcBGus+g55ZUBmZytizKBtof/D4m/zLuutWpLMKPm1+rg3/cRcQ8Ifk/5bENz+BgcXb7aV5lzfOxsKneJ5l9jM9cB5LHW3HvyCucloiMKHjBhMWLsLTwt2RJ4EJvKOY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB4192.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 14:45:36 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9654.015; Mon, 2 Mar 2026
 14:45:35 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Frank Li <Frank.Li@nxp.com>
Cc: Niklas Cassel <cassel@kernel.org>,
	ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] NTB: Allow drivers to provide DMA mapping device
Date: Mon,  2 Mar 2026 23:45:20 +0900
Message-ID: <20260302144522.750620-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0001.jpnprd01.prod.outlook.com (2603:1096:405::13)
 To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB4192:EE_
X-MS-Office365-Filtering-Correlation-Id: 7708785a-37e3-45e6-0943-08de786a5ca0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	4N1p9XJZPZgiPG7MeNfaxtysQQRqu2iopl3kJK5jXZJcQJnBq72oTx7QLzF3ifbgzycpFJV2QvPI6UDUpyBauXhxXKsz91PYnvIvYDyMOdpvKVfoSDaGQZxiON8CKaX9nlraiOHI25Bb53/0uPVl6zuWpEh/wSuWgAal65qjS8b3CAZMoHgv+KzVVdMk2eY1kzYIEshvWTnqgqIlUTGX0OST4Rey/lb0a7CC1n1SfADVsRoJIsIMB+KP6zjULFYGxvLjZWn5HcerF9GK3sll3vhd2CDY4PC0W5+6jFKHzH0VOiLvPUFr+L3BUNj5lc/g0B5IT58cAmTqrVh0Z9/WSTlso3YMVv73ezKLSux6cal2oX8GL2tFtbfn47G6TKnc2t+krYJZ/6ovT/LzJ/pIaX4btSLv9m6HGJVz/sPwmDfDWInuUQdd5aSDSPlDnh65bXr9+61tPwsbAOwUNi/1Dnh/tjB/DjGB7POhaG4DJhCKZu423e4LnKhjObSwY3chOIoF4l27E0HaU1pWPYoCsVsF3laxH6zL0Zxduj3StWxwmQxCOGgQZfdcrhdDHdkLWFBHehNVcdIvhBkR/jzoT15Rc/bizZOhoDh8lJi5udSt9JNzxdlKPBEobYzR+It2aI+2ktYnVzwZanC+EjMp+fZ5A+uy0jsTcMDi7fp8ZHZuKNrAsMcLohUOMxi+8RTj1aHJN3C1a6POeZPTrQKRhVisoznIWdKfqfLrViKB49I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AVW7soFGyx9gzxQyLVQEMBDAxhlGBtCfQQOHTYyvba9+JJPdgMZ3O2bJ6N8l?=
 =?us-ascii?Q?8ijFOSjStQEaxt1u3pHXr8RRfBtCwGaSRW3LQZGmZVZthMAUk6axMlpNpGwf?=
 =?us-ascii?Q?nbgC4nhFbg7pdFTDJcmdHxFsrDGQEI6LmNnfel+a7isVO/LtId5MKtYkl0Pr?=
 =?us-ascii?Q?ymNjcls1pyZIABf97OK5Q/1FuSNAUjl/6zJDP126jJ0cGVVmNTQVGwTqQ7Qa?=
 =?us-ascii?Q?OnQ+Py+uvNAMnBrrqrMKzOhqgOkCiOmhFEIAUtLwXbJbGHxGIbTyad/i0dmW?=
 =?us-ascii?Q?zCvh6bBoP8FlzDPZxuTzbKplELeZ/uX8mje2cVR3y9Mykr5IexGMJgEBiHmd?=
 =?us-ascii?Q?lUsibhWjhPPtlJDU+iA5o4TnmQ/mHiJji2DX3rlyWDMLECYJrm1QGTtBF4UL?=
 =?us-ascii?Q?+EC46F5vWpS33E/ijNb66DtaKA4X5WgmS7x3j3MLcGSvHKUJyWIo9B52RzbZ?=
 =?us-ascii?Q?ew84pgzvq0/PIZZruV8waq/ZZhSpTce19NGe77pD1QkwpjyjzHHY/ptDAd7g?=
 =?us-ascii?Q?aXx9gsX3/kU/Hg/Pj1r3A9JxLutguLggCY5z99TK+/21o/J0oodcQ35TUytO?=
 =?us-ascii?Q?kEg0LOGkFJh8IjVR6qbGMVJFLcczLDiS095t6dXIT3je9aezuru/6kEGl5gp?=
 =?us-ascii?Q?PTqNFheushYt1Ge8Ndb5jYrJJMKqxwAxwsdYX84sUPc49lzH6I1bb1qm1YUw?=
 =?us-ascii?Q?+0tjnKM0So1/O4aXWacxicNS/wUtz/pnpgVs02K2CUZ2yNr29EfCDyOW0rAj?=
 =?us-ascii?Q?mIbEMgH3sL2urnRIeEbi1WFYP6nw13b0jOTzlifGkv5H4dMxDdf7mw+VP4JC?=
 =?us-ascii?Q?aLP+5EhZxdk6sxjsxSW9pt2SoAUGR9XKqoAV6PNz15dIcRsRYTQ1ztT2ELef?=
 =?us-ascii?Q?eA/SzcZ6ucwdRr65F5VJHIqhrA57z/3MLlv5hTikWBgb1jlRHxcogZF+0mjd?=
 =?us-ascii?Q?NOawpwYq5JSgv54GRPC/nm3pMGsIGqjbb2yudhbxjglLrelVOHusB7NKgDnB?=
 =?us-ascii?Q?SIyziqxYhP89xpK0TbDt4+oWPNH7df7D8/PvHBO/b+8abcAxPy+AkhQAcBQ9?=
 =?us-ascii?Q?Y+coWiuW0DWX9riLUbsJfHhk0xZip1QCdlDGCWFG1dqTrCkDxKf5H6GQq9+a?=
 =?us-ascii?Q?iUdHnjzRdS14s8nTDz3Op739nLMf5oXCTTR/lvBNdBOhUoNUT1D2ZUIWPjLI?=
 =?us-ascii?Q?HQe5Ez+UoH59XmUv125twDlrF1oPd0rPRZfapEy1B7QaubBJJdgdWohrpZJT?=
 =?us-ascii?Q?jEAQsN5QXtX95YlaPH2V8JQ94bfalnRyBHZFQF/OpPMfH6P7ZIPgT/itdQaV?=
 =?us-ascii?Q?ow+OXVz8V1TMVlSzyjVZWk961ACQ1c7V+iF4g6tr1JyNMFLf/1YMs5g+KYN9?=
 =?us-ascii?Q?wUz0ezTIK/APZyR4/fS0xqkpJ7O2MMc0aMABAMQHeNg15Qz85MaN52dkyCwn?=
 =?us-ascii?Q?8nhr76VM9+zTFxHm0rI60x3esVvGavZgu+AL7whuD5mwsCvspDX973qvHzL+?=
 =?us-ascii?Q?XyOLHdp9n/08tfcgmj/OCo/zVqrrhFJnB7To+PbSAzXx95zf+g+DWJf7ZAkp?=
 =?us-ascii?Q?2kTS1wkNi3L0YxGdhro6pwN9k/Irjwb9XZl/XKrQAvoJz1eAHzml4DYAep9r?=
 =?us-ascii?Q?oV4ci1yVJCt+SyxlvEKsMzYU2z1VFkhH63oUY7xW/3PfroVV7Xxhrq8uIr0A?=
 =?us-ascii?Q?FZ9tWAfoKNsG6xf5Y94zK19FHETgDdMaBAx9jEGwOuGEennvhL7qCzdELFSV?=
 =?us-ascii?Q?0iQlRr9l5akMNIK2/PAxc65Wgus5GjO2KGIgD6UaMPxGqWbI/moL?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 7708785a-37e3-45e6-0943-08de786a5ca0
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 14:45:34.9736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZzQgHB1iyKrV+Rw1SgKdbgOSJbhwbK1eSM1S/jP9q4VuUDA8ZeCjT/m8f7qYkp1Hnynjsl0YgDNoRQ7ex2bC+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB4192

Some NTB implementations are backed by a "virtual" PCI device, while the
actual DMA mapping context (IOMMU domain) belongs to a different device.

One example is vNTB, where the NTB device is represented as a virtual
PCI endpoint function, but DMA operations must be performed against the
EPC parent device, which owns the IOMMU context.

Today, ntb_transport implicitly relies on the NTB device's parent device
as the DMA mapping device. This works for most PCIe NTB hardware, but
breaks implementations where the NTB PCI function is not the correct
device to use for DMA API operations.

This small series introduces an optional .get_dma_dev() callback in
struct ntb_dev_ops, together with a helper ntb_get_dma_dev(). If the
callback is not implemented, the helper falls back to the existing
default behavior. Drivers that implement .get_dma_dev() must return a
non-NULL struct device.

- Patch 1/2: Add .get_dma_dev() to struct ntb_dev_ops and provide
             ntb_get_dma_dev().

- Patch 2/2: Switch ntb_transport coherent allocations and frees to use
             ntb_get_dma_dev().

No functional changes are intended by this series itself.

A follow-up patch implementing .get_dma_dev() for the vNTB EPF driver
(drivers/pci/endpoint/functions/pci-epf-vntb.c) will be submitted
separately to the PCI Endpoint subsystem tree. That will enable
ntb_transport to work correctly in IOMMU-backed EPC setups.

Best regards,
Koichiro


Koichiro Den (2):
  NTB: core: Add .get_dma_dev() callback to ntb_dev_ops
  NTB: ntb_transport: Use ntb_get_dma_dev() for DMA buffers

 drivers/ntb/ntb_transport.c | 14 +++++++-------
 include/linux/ntb.h         | 23 +++++++++++++++++++++++
 2 files changed, 30 insertions(+), 7 deletions(-)

-- 
2.51.0

