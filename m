Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011017.outbound.protection.outlook.com [40.107.74.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D60D1BC4E
	for <ntb@lists.linux.dev>; Mon, 27 Oct 2025 00:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761525821; cv=fail; b=OznLfx+FFSq41d0nG+nkcKTva8QTiv8FFbsaVWHsQbzdXK5VXzZ26wugknkAPM2mcnK9FmwEEftmvnIphUTcrxuoQHLTOxWKHcsQ9qZ1dq2tZVS/J2J6XxHxeSHKJBmQNvMatOQaLj9o24GIxxwyEVvR+zHcxQDwnB29jNMBRFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761525821; c=relaxed/simple;
	bh=dueUf6F4VcAB+TK4NkUqZsOlIOYUWuIVwfG3caIYpTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=M+5R3i85K6NeH9JIZGi0apQnMovwiH0pS4GkVhmDo21/XC6EIHX7MguD+SFWZBFdggekWWqO7QMtt2kda3jgJc3aa2kKKVKEF7M7jMzAz3+/CZjA8r8+vfw90EtOI9ol2XdHkDNddxAbXpGRDTPzex6JcRPEcGEODC/aEBZHTJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=ESA7vkyw; arc=fail smtp.client-ip=40.107.74.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="ESA7vkyw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WV007qOQcapNvwINU0vwPGBnYwNWnixeBKquKsKSXsOI1WdwYWzK8enWvk/KhT1JALrF7YS/alVNOD11i0mpe3ZOg+70mkcphBkWrApmdxZ/nv54L0eBkA+4blomnEKeQqpGwmiiTYXU4+hHhw/TJMtPOHOrsLIIkNRV2GpolaX0refjcVlF3wTQgpaAwbxSeAa5S1ljKnrINNqEeqmEeE0Sp8zbZg5jTwYDwOa5rxU48mAlVyFERQa9xgWEef1b9G8y9dxsXevfSeFW8a/oWLDjuUeuVAj1c5O+xH6tGx3Z+3LnbDRea0s+5BusuAVgxilklTpRYI6i4RekHEbihg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=31mvM3pteisCfaZ+gMDefREEq6+9T41+fqya7LoDT3o=;
 b=bB2OlDwctBmETeC4ZjYGa8Ef3l8AGOpW342CSFC0qvW9lIPT/leQtzbCMW/XeNPO2aq8ZzaVbY72ojHKoCzDWgvIgTCcdcABrRAZnNqKqeBkekRLpyzf1uLJyB8zogXkWJNTotl+G+pxI8AIqKAPynTd/sjqmDsUnOj3gTBOga3NgHP+XIW0EK329DACea1uv1MVEUPyIvj/oFIzYnLGdYylM9YYd8immNpLLbBgOgoanBuXbxuGNVXMuNXG5qWrJGUQTowZV2CK6cCrN/kgJyGRsjBDBPV1pKNgW66aWqIwJvVxOtYuP8TytnV1rd4sPGqb333OGLvWaTFhlJhrIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31mvM3pteisCfaZ+gMDefREEq6+9T41+fqya7LoDT3o=;
 b=ESA7vkywuYt++3m5bBbHqazzrAj2diiN6KBtaHd9FaZhDH/e4XJs0KFBMFIS0OarJmV2nkp4FjHjPDw77lfgP9v48JbrWuN7MMLQg0qvg2L9QpH4WEUJUo62K5lx2T1UkXvQUd+zH4QzDF77ggwj9efsTSKS+WS6kCNhIX7c3Qg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:10d::7)
 by TYCP286MB1588.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:185::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.17; Mon, 27 Oct
 2025 00:43:35 +0000
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a]) by OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a%5]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 00:43:35 +0000
From: Koichiro Den <den@valinux.co.jp>
To: ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com
Subject: [PATCH 0/4] NTB: ntb_transport: DMA fixes and scalability improvements
Date: Mon, 27 Oct 2025 09:43:27 +0900
Message-ID: <20251027004331.562345-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0085.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:369::7) To OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:10d::7)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB0979:EE_|TYCP286MB1588:EE_
X-MS-Office365-Filtering-Correlation-Id: e9bd204a-9f8b-47a6-5636-08de14f1dc2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?87R9Kmp401cMs34lUocEQUWk6dC8eRzVZ9hA3yv8s69wvnmUvJsThHpo4VB1?=
 =?us-ascii?Q?Zf/4ZHd/VbNE3Qy3JRl0yNsdJO8wGqi8gistb1c9zcJ/LIeEFyLGc90tCu8N?=
 =?us-ascii?Q?0o0PaFqTSbn9EnEZENB8nWPLOubwhEqWvCnfDwvMIdc3SLRUsCU9I04MwOCg?=
 =?us-ascii?Q?Jq9xK/PTZQcC9bb5OCkDlueIoiEBmJfdHecR7W8AQ7E3psMxwsTNOH5iihjh?=
 =?us-ascii?Q?t/C77W9ZI0lNWPDQKqYiGkHGky4j0CTMdtTs7Fh1ta7JcCSzrVsWPF4YYNw7?=
 =?us-ascii?Q?8rwZ9h0LjWBlXMi9idFOFubcpcydW08CFYbSG+fnJ1W8ih7y4ed/ni4qnCBN?=
 =?us-ascii?Q?X6WIXGkpWPRZZtRS/X0ItyhrfW3fBhHWx40Dl9Ag5Cwfz/b/Hmj994Lra9rr?=
 =?us-ascii?Q?t+MFHOk4QNJtCX/q8r722XLPHpMdXlb6XlFAuoSdCG4q0zAGKEmUFa57y+wZ?=
 =?us-ascii?Q?NLgXbNwhX7J9Ya5TUXL3sp+/zn6gXs5aYYuniWOb30BGDYeTw8VZ32P2PgiO?=
 =?us-ascii?Q?PRud2piRkfSzrOKgeTX0ituARYIt4ji6N4sS06Jke/OR7PPT5Vhn/v2Mc2HO?=
 =?us-ascii?Q?TmHqn9ef32A4BOPoMF1Xdm5I+Ptv/+deZeCgogiRzN8x0u9FE/9a4JVjfy/F?=
 =?us-ascii?Q?V60PTjjQcrTpZxFy4WgaTp+QxE+gRq37e1QXTSDK93hfsxyXQ1O3DCpodTdz?=
 =?us-ascii?Q?Copp1JAga6fsKcubZH+/JivzSyUM4qxh9nASmqz+pcFlIMI78DBZua4jdg4n?=
 =?us-ascii?Q?1svVEDjv+P+f5mDdE64lyLNNt46qbY8umE2wiWaErALzaR2CHcP81Rbq3elk?=
 =?us-ascii?Q?9SXem+ORBBEMabbSELrxkL8HKhz69F5/5TyZYiW1EJjwpXXxo/LMwPmm+XM1?=
 =?us-ascii?Q?wK/Y60z26FJWMaREx1fIIRR222twt38daCMHqMCIDq6C8zd8M0Aewbez06f5?=
 =?us-ascii?Q?U0ZViBc+xAiyqIInBPVo2UaT/u1SEyz2WmWGd5WU1Fd2mgovtLxviwUd0U7r?=
 =?us-ascii?Q?/x/z4VX2FtZLE2XW05QdbwAolUsQSt99zJWk4rYlCsXTf/vcQzu3yOSBgBqz?=
 =?us-ascii?Q?y0PZmdO0Mh1jPkxa4hqpDHkoaI3wgUURoHTTV59LhLiUAhYZU3dD4pK9Fggx?=
 =?us-ascii?Q?B/vSNUKp9X+tpNPyGrv81OMvunyZaE/q8KUevAVzLKugINCKOxEAaF/7Tg9g?=
 =?us-ascii?Q?fhnxEBYS+IybqzcEVTQeT8ecKWCCfJ5TYhXeyngVmfn4ps7eFP40YK37T7JI?=
 =?us-ascii?Q?CfQCm5ukOXD3+npr7KwBDNAx9zVJWDzTxeCKocCjOO1qAI1ScuC5cWP2sE/4?=
 =?us-ascii?Q?dkpW4gWXdDcaHchhsbRZ2A3ru9C5h4ZwjyfZNUj7/DDFebPfWYoMxXuRBnfb?=
 =?us-ascii?Q?kveHgC8AIQkTi09ikILyXGg+B+WaxGGL/DAvfEUQNW4tXXe00f5abZQoL2fr?=
 =?us-ascii?Q?CrHymrRmBVqGWjWqIsScl4LULp3E7J+h?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sM+s5P15SZAxDhk1HR1xU2H2noUZx8e8bV2ckdkxz0QE5Nkb4dBlZRkUZEZV?=
 =?us-ascii?Q?uz+TzJuprOLs/kqy3Ec7WOFMAApMQfLCBSzE29n5BKew9va3WtUz3uTN/w75?=
 =?us-ascii?Q?HWHxN/mEb6UlAkn9+FvlWtk8XwcPKW5zmbl2vOaiXFh4W8LoQPt5XXoL6A+Y?=
 =?us-ascii?Q?4p7xNVkdSv/H2nE0jW0kiazUZrvIHwlJjk1W0OyRBWromm/KKMpaxhhpieDW?=
 =?us-ascii?Q?FVzZv2FBkDVFsqfA6x+w+Ov3rMAJztxjlZOqC4N33V69pQzFCw43LSTPwE/a?=
 =?us-ascii?Q?SXG5vzQik4aU3gbqSjTY5K9oN/bEA2B3+dtUsk3nN5Ro1cqZA3pa/85Y6UKJ?=
 =?us-ascii?Q?JF/oi2AgDnJUgG7Zz5BPwm7LjscPgR2mHlJm8PZ5ufR8ZHDVDFIwZbVrn6Za?=
 =?us-ascii?Q?zmt5o+W2dvmhoBsZej730Dr58YJhcB2kT4sq2ZL/Q6k1H+I+FfDeXTHw4cCY?=
 =?us-ascii?Q?YxFzI/fOhz43t2y7Zj/z6Z+wIrMNfDMg8FP4sZfZTnWp19KFaKYJOOASL2Wp?=
 =?us-ascii?Q?e58UizDcIXpt44mS5l5CVoqZhRq3rEuFmW0b3iQVuTtE639/tjKtVVCeoaq5?=
 =?us-ascii?Q?9PpVDhVGBecRAbusyY8qNx9gP0UYr//RGbSepxPpjAFj0F+J6NGiRr0RUbfU?=
 =?us-ascii?Q?DXOr6zD/KoX/fUs3oLKaLCp5jqcVYqTMH+Gz+oR+CSNPr8dbyevQKQ27P+Lk?=
 =?us-ascii?Q?tRIHjh5btOuMi+2mNE88JXDU+4lpXkWrnxlyX1tHM4ecMRgiPwRGxHj/3S4S?=
 =?us-ascii?Q?2Gqnqd6rHosFdjxzW9a7rtVssKDjux0rim98BgytuFlhRqvqRGONWXyYpEH+?=
 =?us-ascii?Q?6Csjvh81il/cMHVjisg+MIMzeQ4mH3GxGr04d4vsEB03yR8d3k4pLrQUemtB?=
 =?us-ascii?Q?qRU5MSgJM7wQu2ELk2U634k8NyH2WyQZr8P3AzllBA9/dTdqX5Nqga/Vtlki?=
 =?us-ascii?Q?kY6cZbP0Cd6dmbo3DPQicDbRPyPtOMK45LC2ZPuL1VtRdPvRRMbBuFMcK+nK?=
 =?us-ascii?Q?98T8QsZIRC2SfX4OxQ7RwlA/XyesndzpSWoD2oro2+9xytrjpExjNvvx53wY?=
 =?us-ascii?Q?EpvVwi0hnHH5yhkWmk1lgceobaF0hJu1CEqJh4DhK76qQDYKspFMeRE0FEtY?=
 =?us-ascii?Q?DMo3ZPcY4k8+inlmwI2Ach1dlftPm/xu2IaMv4H0fJMbiP18CxAHinxc2/Vb?=
 =?us-ascii?Q?Va36sQpwMo3jrNtt+G+poJWg9wuy4pXVZsoIpwrnA+AXRVCfcfWOHKBJTEOa?=
 =?us-ascii?Q?erMzfcyTixm+7fh4KAR7lYKokEYliRl3Y9awAlwX/G5bUHjOUjuJT6RlDypu?=
 =?us-ascii?Q?xuFpT3fzQuAjmxfkNPDDE0bE6dC/5odZpjX1II+VNB8ShrQKmwCfujKlp3IZ?=
 =?us-ascii?Q?20eHnm7bFj3cMJ6661RyKdDMJt9kZDznCuHROAp1dqQwauNQZB6bXsWH2y7W?=
 =?us-ascii?Q?Tt/IfDTn1aa8uIcjbasl8gA5sdDY4K8pZ7f8R+dpNwcMf2VIav2YFmzmATDm?=
 =?us-ascii?Q?WCmNh7tuwWpt8vAUvJA0U9wA/U/0lqOWIF633hMwx+mAxpfUH3NAUsCrobAX?=
 =?us-ascii?Q?2tI9I0lGEYorEuAbR11iRTr1vM+Nc8gb1x1YDouqvMgMK7UYeoLnjjre8Ck/?=
 =?us-ascii?Q?dzjBkADVeOd4n4Jwhw9cBjY=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: e9bd204a-9f8b-47a6-5636-08de14f1dc2e
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 00:43:35.0832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /fGOgh4V7yxeIBUBSZoPpx4gBzCXSJgIBRxF59dNB8hWLi8tM/cw+vlbvDtsSCHMjXJJEBw5DezCiuPsQvs4Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB1588

This series contains two DMA-related fixes (Patch #1-2) and two scalability
improvements (Patch #3-4) for ntb_transport. Behavior remains unchanged
unless new module parameters are explicitly set.

New module parameters
=====================

  - use_tx_dma : Enable TX DMA independently (default: 0)
  - use_rx_dma : Enable RX DMA independently (default: 0)
  - num_tx_dma_chan : # of TX DMA channels per queue (default: 1)
  - num_rx_dma_chan : # of RX DMA channels per queue (default: 1)

  Note: legacy 'use_dma' switch is kept and prioritized higher.
        Enabling it always implies use_tx_dma=1 and use_rx_dma=1
	regardless of whether use_(tx|rx)_dma=0 is appended.

Performance measurement
=======================

Tested on R-Car S4. With the following patchsets applied [1]:

  - [RFC PATCH 00/25] NTB/PCI: Add DW eDMA intr fallback and BAR MW offsets
    (https://lore.kernel.org/all/20251023071916.901355-1-den@valinux.co.jp/)
  - [PATCH 0/2] Add 'tx_memcpy_offload' option to ntb_transport
    (https://lore.kernel.org/all/20251023072105.901707-1-den@valinux.co.jp/)

throughput became bound by RX DMA service rate. Increasing the number of
RX DMA channels (>1) improved throughput substantially:

  - use_rx_dma=1 num_rx_dma_chan=1
                 ^^^^^^^^^^^^^^^^^
    (full command: $ sudo modprobe ntb_transport tx_memcpy_offload=1 use_rx_dma=1 num_rx_dma_chan=1 use_intr=1)

    $ sudo sockperf tp -i $SERVER_IP -m 65400 -t 10 # RX DMA n_chan=1
    sockperf: == version #3.10-no.git == 
    [...]
    sockperf: Summary: Message Rate is 8636 [msg/sec], Packet Rate is about 388620 [pkt/sec] (45 ip frags / msg)
    sockperf: Summary: BandWidth is 538.630 MBps (4309.039 Mbps)
                                                  ^^^^^^^^^^^^^

  - use_rx_dma=1 num_rx_dma_chan=2
                 ^^^^^^^^^^^^^^^^^
    (full command: $ sudo modprobe ntb_transport tx_memcpy_offload=1 use_rx_dma=1 num_rx_dma_chan=1 use_intr=1)

    $ sudo sockperf tp -i $SERVER_IP -m 65400 -t 10 # RX DMA n_chan=2
    sockperf: == version #3.10-no.git == 
    [...]
    sockperf: Summary: Message Rate is 14283 [msg/sec], Packet Rate is about 642735 [pkt/sec] (45 ip frags / msg)
    sockperf: Summary: BandWidth is 890.835 MBps (7126.680 Mbps)
                                                  ^^^^^^^^^^^^^

[1] Additional changes are required to use DMA on R-Car S4. Those will be
    posted separately.


Koichiro Den (4):
  NTB: ntb_transport: Handle remapped contiguous region in vmalloc space
  NTB: ntb_transport: Ack DMA memcpy descriptors to avoid wait-list
    growth
  NTB: ntb_transport: Add module parameters use_tx_dma/use_rx_dma
  NTB: ntb_transport: Support multi-channel DMA via module parameters

 drivers/ntb/ntb_transport.c | 386 +++++++++++++++++++++++++-----------
 1 file changed, 270 insertions(+), 116 deletions(-)

-- 
2.48.1

