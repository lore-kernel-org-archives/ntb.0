Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010042.outbound.protection.outlook.com [52.101.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA5F1EB19B
	for <ntb@lists.linux.dev>; Mon,  1 Dec 2025 04:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764565090; cv=fail; b=AMikTKN+BlPWnPw7A68IlhiKXBQvDROxwkdg9pXK57DnbLaxt1qB5v0hmEoUvYWVg8ebuip8hX0lQxYhiArpUkV8oqg73UR7piso4t19Ji2RgxnrT3JUluSvLTA1NWcpiP5ePl5uB+mkWyd8r7xRkvawvkVRdF2q7wh8g6Hi5nA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764565090; c=relaxed/simple;
	bh=qyI6cpPjQPyHRp2JfJx2yKT+Nuv/F45cInRNMusWREM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VeOBDAUil+GOWNj+zBxGNPzGDakamfyyYV2s+jQWvlVP4eQ4qHO99v0RW78A0Fjyy1s5Po1Z7vHy9CJ5M2vdqy3HNuWdZiAAxN6L+dZ9BZtERTkhJSF0F3xl4mK7AGR31iAxvfZ22SsQhYSEDVDJAFc/UZ4PkZG5SAdeaj7rJeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=T/MNIvUD; arc=fail smtp.client-ip=52.101.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="T/MNIvUD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iaAQCtWwQnjmYdVDma9urmKasble/DAFce3iE5kMF/3N2Ra9qX2OzV2b57cqzx/lnDbNdUWK7TSpX/Q9KetPf/LRfZnM2VT28J+wrjzRlHQgUQJmEmyvaSs5PT+Xtl4y1ooE8w0A5TaLZKjRE3Y4G71XyzF4iXIYhnojR0Cp70v75jko+FYGh6u48yPa/zn5YMzvapS7xXWoVntHa4YsJJO6xuBk0kdUmKpGZ9hPZiaAHAyPrSgFxLOw5g6dp9qC3nL1g2DD2WN/sj33jml16Rz5OEiW7ap6SQ04iq5Oebm4/usp+0/EI7rG+KR01KoJvV8JrMvF/LTn7tQBA4TLdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ltBRTR2l97PWH5W+vQ6B4ROEI7ndnZMLvkS1GisT3RM=;
 b=Zji3XklTplFE0QK3WUWuy+LEdj1V4Y5DTCpoY6Df+mYPaLfDXov2IEHtBnTs9v+/COlx1XM/3i4lrUwlyqnospL7uKHsFVg+E6c+tw3cK/KBM4JE1Nl+gz0LfVq7LTMabevPUZMHWh4anCIUU1dnogxUIUFjmvw2x02i8Wlsvj2swKDzMbjcx4kizMcMHpCKYJij+QVbUkHBHNvbFzjfyrSzISuN6DzAN12r0VQHMA1Hm0BO/RhKvBj2yH8yCMtc4BmA43fgNNfYaUlLJuFLxLXtdQ0t3d3ObwbW28sBKpFmbCytZUs0gR1fWVd2NIlOKp2V0WMkVJOFYgcYiAVCMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ltBRTR2l97PWH5W+vQ6B4ROEI7ndnZMLvkS1GisT3RM=;
 b=T/MNIvUDL37WwaUqp7bxMiAxIWwYMTSp/cCtMHxA0HZq7CWD6pjl3hWSibTnaVU1iv5ZzFRIUnU192Guda2yvRcPGUKHKvv99LItLj0HnjFDCyD3pFAGF15uqr8a/7CtlxZEVDOFSFTGN+qBLNVVvdocGHFw+QAvatPenux71H4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by TYCP286MB1489.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:17a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 04:58:04 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 04:58:04 +0000
Date: Mon, 1 Dec 2025 13:58:02 +0900
From: Koichiro Den <den@valinux.co.jp>
To: dave.jiang@intel.com, ntb@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Cc: jdmason@kudzu.us, allenbh@gmail.com
Subject: Re: [PATCH 0/4] NTB: ntb_transport: DMA fixes and scalability
 improvements
Message-ID: <uw7plhwaat2mpwydjle57ppzubwgvhiq7bvtsort7fic5jpgls@ba4hze2gtfqp>
References: <20251027004331.562345-1-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027004331.562345-1-den@valinux.co.jp>
X-ClientProxiedBy: TY4P301CA0089.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37a::10) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|TYCP286MB1489:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f15706d-a979-4059-0626-08de309635e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x20Unbs2v0WfcDCEzMklsN11Hox55jpYwK28O2RlzZpeee3TIMmu1WYQeCqx?=
 =?us-ascii?Q?4/B/+58NYQ6PObbUy7YvzOJ83l4VacpeyFmeoLlIw2lX8bZ1zIdmErTY8bMr?=
 =?us-ascii?Q?HvBrwEQdqvh8NonSOJtXBfvNOwdl5nR1c1UZMPfoYARO1Qg8b0oQy1VVQSO2?=
 =?us-ascii?Q?Wx8XiDXRcbOY0ov5Y+qXJhtCQo3Mmbmsx5uuGJ465Eb3UYqjrMWfdhm7TIjJ?=
 =?us-ascii?Q?1Z+aKbLgKFsGyGORIPslE2eP/gFG8wsZ90OiS1nUI9UhnY+xW3qrMYgbTVDQ?=
 =?us-ascii?Q?qyv/wtnwSPv6fZwizsenlWYXu86ZasgflaRCWd/C1ahG6tAklEgGw5QaKno9?=
 =?us-ascii?Q?uCSJC4OoE/rPxoC3S6bKFpn3oSRuoajDfVunASfF06xVZefSGi86gGHxhnEa?=
 =?us-ascii?Q?abgowcetQkDHnpFbLIgS+RaJYNZRQVnB2Bnu73+6l/D1imV5TnCGIgKzNJ+F?=
 =?us-ascii?Q?UQH6NXLcFv3yiTJNw4kpXJMEDzGcncwQiEfLCxG41WMFklrgupZiVc57Wqyp?=
 =?us-ascii?Q?hOPaRy6smPGiJNBevw+3BPtyRyYGavrXeytRS6N97jXpKhXe/WG/45UxkBcz?=
 =?us-ascii?Q?MVP2eWYpE92icC2GS/IBx4oWn/+vEOU0t0zCCtjNechbWr3hdRWgjJJe1PeA?=
 =?us-ascii?Q?sgduMlb3DxvzzPaTJCavx1pCLrwx6O8ut3gWAPqqqOOcIq72xCFk96dARPOk?=
 =?us-ascii?Q?P7BLvKe5EcdYCMeAQ/hJ8BXtnZR4bIspX2vwnkV51KOkWmXDLXAIGaE1Pd2j?=
 =?us-ascii?Q?YJzFiZniM0bCPcIW/pKjMXhbT0gOrnRO++/gR3J1a5R9JYAdCFhHSKMY4P8A?=
 =?us-ascii?Q?GUrAWbDsnPW7SGXOkW2a+O+mCeirYNUIOnjJ52OLRdbdcDperPrFWNnTrBWf?=
 =?us-ascii?Q?NALBl3HZpCQ/q8FBRQcLQUW0dQnvoLMiwFqpFVUs0FG2q7p5NX0HggNWCEBH?=
 =?us-ascii?Q?xjNu8joYWFMOaovl2r0orLpwl01JMFnGRZtHEH4aJegmRO3zPtQXiRJOn6FQ?=
 =?us-ascii?Q?0aDw3Wvo3Y4mVbgsDYRy3wtFvYlCSemiITD/rH68q/W/o0TuOD/sgVrsVHJa?=
 =?us-ascii?Q?PSXsBV6C8/1Ca7dgFpEl3zHd9ouSMhf6FR9DOm5S6FeyzC/qUwjpbvvqisy6?=
 =?us-ascii?Q?8mTfzieQS859yC/XP/jgHIRbGbgxYdzMl16Gk3sLCW8oQBjmNHFXt6AHAViv?=
 =?us-ascii?Q?T3zp2/GG6aZLR/tM86O6KLpmpFTGFxWwmey4J08+alMHBmaN5M0kmoWNj3Bj?=
 =?us-ascii?Q?1XqmwMAtJfnrbgSgybfnsu0/um3TUfh3I1xnV8kLMrM3q9NycraFoyinRfai?=
 =?us-ascii?Q?C0Z8rtzsqGR7yiaKdTCiojC4ArR+52KFVUyKDbmiwQrzDWeJfyhfzXjWc1a0?=
 =?us-ascii?Q?Td3C7pbW8cBZku7AvWyIDEqGhddDs8wlZ3AXIC2/4774qytV7cmWPaQP1XX1?=
 =?us-ascii?Q?piVzhyJVjHyBW/bGuqS436qxT8fgoTIe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GQRTR+jyA8OYk7GNSVmdSOOBAekBTGhEBFAgPnfNOFtWKpLklCumw9pF2l40?=
 =?us-ascii?Q?0PM60Z8v9+lJZZQf9+tByXWr8Ztk9gCzytNnUUK5xcM2eA4VhDpgdjhG1ac3?=
 =?us-ascii?Q?Shwb8NvnYbU0OERQPbgNZvfmdJdGPkJEv7MdPPrHMI9nsj4/me3xIewj4OLN?=
 =?us-ascii?Q?dgPVUEoDZUFXtgFELhwvXONQxHfJwHUP2OInML4T4QtjemmZDSes/okj2xdw?=
 =?us-ascii?Q?fD5tak3VklY+IRwZrsW/3nNb2UDrCg3sI88pVrmcGGJLzBzQt4Y8XID/b1Pu?=
 =?us-ascii?Q?EnVQXGgmeHCDKss/Ci65GIa5bCkyeMCEbuHc7ySGG7pBzABfDZyb62ClopOr?=
 =?us-ascii?Q?amrBtTGq6EzQqxaYBQRVQw/4QwiqhSyx7SWszdTZ7Z/mDw8v+siPj8YSJCMy?=
 =?us-ascii?Q?9YiKsGDNdPstkG9CnGdvav7RSjx6CwVcvK58sum0kygqGXozzokkfAF6zaVA?=
 =?us-ascii?Q?g0DVpWD9IVKC3WGjgHrL+rNf4Zre2TCiSdCeUmP1gmhvLIwfn1+wYMYJR5/g?=
 =?us-ascii?Q?w7DCF3RY8oOlrpIosIcsYVmWs0f2Of/99OnblHLmVthu95VM3QoU4dKPcW1T?=
 =?us-ascii?Q?I/qBw0AbrOQG3sqKH0VMGMUna3sB2DnjGiw5T7slcMerfXPAWcgeByIymufv?=
 =?us-ascii?Q?RTpeEadzKsg9QZrYY79ChC5NdnvcH1w15JZFUkFRRGReBOSSXWdCKVaB/F7X?=
 =?us-ascii?Q?cZ0pjeH44ciVtJ5Iawe8jQyiwztdq4YFtCx4LtLkO2Cl1xmRBdsF8TCUjVj6?=
 =?us-ascii?Q?FUMZhaewbg2qm19sTdZUynDyuGC8C+v5AeifL2o2YJpGWzjRbz8X5NCi5B9/?=
 =?us-ascii?Q?RpiOg+lCFuhJGpKYISiTE1tCUWxxxIk76dFciUNLom7I+LCECnAWROIi8q9Y?=
 =?us-ascii?Q?vtd8Gh94gVaalOtk/XNq2XIbLMzbmm7yKuRJe3xwJTaqGjnf17nGZkUYN0t3?=
 =?us-ascii?Q?p2DqQ/Ayqt93NESe8X/ukrtL18lGKCZfW5SC6JbCwc4AB9bECjl9TwqQrN+s?=
 =?us-ascii?Q?oC4wW3B8kxQuVlL86QB65xEARsOBmG5cGBkUqKWBDcPj7NOnasgfdONaCQP/?=
 =?us-ascii?Q?mAWZaHZayOwDCDRC++pVpdtrTc7FH+PS/P+S/BlDu+8jMR+q6Gi5qL7wK6zv?=
 =?us-ascii?Q?IGiqHACj46Nfv0VZewjKDdOMXF/M82wpJVB7EIoObhP1jmUMOlPS4uwrkM6H?=
 =?us-ascii?Q?v0L5OtVj3BIXOeOyT3nKYpb3mbsrhvxGVDjGgu77Spdp+4WC5AJ7dpImZfUY?=
 =?us-ascii?Q?jAI74LlarTKrqwRftfYv2askAEtK6tzdlNXNm1+E1DNMlhihE65ZrCz/WE7j?=
 =?us-ascii?Q?vmj6VszzEWpp5bfgoNovJu+MmdNnTKW2xz2Y3Dgv5JgGnoG0HsQ/BdGzfbpf?=
 =?us-ascii?Q?hIFkiU2TQy8NDo8AkMnIYimDiUXLoTlLhmmkp5JeGlKB6u3x4+tHIQXlNOgw?=
 =?us-ascii?Q?oxmliHAshCoiAAYgUDve/D9CtB4+2X9slsYHkf/aM054/fS8t4tTl0claG75?=
 =?us-ascii?Q?FFydUHiJzxzMY03Zj8e8ofn3Gln4LtUGXfs8EgKlGwPHiAdFSF3LTF0jFbdD?=
 =?us-ascii?Q?EPOxmFHi1WdCujKXvWlq7f6t5mlAdH+gKTtgygD35CARR+3j4zlJEZ8Vdc40?=
 =?us-ascii?Q?Y6YwgDZABQVFGMmjlC7Z24o=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f15706d-a979-4059-0626-08de309635e5
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 04:58:04.2149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fWil0UKQt+AsiyqlvtrlVrlnXGCTBStoHWatbh2mIfe8vO68wCa716YCyqqL1S64hf3u8f3BOAE6GlKJagZ2qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB1489

On Mon, Oct 27, 2025 at 09:43:27AM +0900, Koichiro Den wrote:
> This series contains two DMA-related fixes (Patch #1-2) and two scalability
> improvements (Patch #3-4) for ntb_transport. Behavior remains unchanged
> unless new module parameters are explicitly set.
> 
> New module parameters
> =====================
> 
>   - use_tx_dma : Enable TX DMA independently (default: 0)
>   - use_rx_dma : Enable RX DMA independently (default: 0)
>   - num_tx_dma_chan : # of TX DMA channels per queue (default: 1)
>   - num_rx_dma_chan : # of RX DMA channels per queue (default: 1)
> 
>   Note: legacy 'use_dma' switch is kept and prioritized higher.
>         Enabling it always implies use_tx_dma=1 and use_rx_dma=1
> 	regardless of whether use_(tx|rx)_dma=0 is appended.
> 
> Performance measurement
> =======================
> 
> Tested on R-Car S4. With the following patchsets applied [1]:
> 
>   - [RFC PATCH 00/25] NTB/PCI: Add DW eDMA intr fallback and BAR MW offsets
>     (https://lore.kernel.org/all/20251023071916.901355-1-den@valinux.co.jp/)
>   - [PATCH 0/2] Add 'tx_memcpy_offload' option to ntb_transport
>     (https://lore.kernel.org/all/20251023072105.901707-1-den@valinux.co.jp/)
> 
> throughput became bound by RX DMA service rate. Increasing the number of
> RX DMA channels (>1) improved throughput substantially:
> 
>   - use_rx_dma=1 num_rx_dma_chan=1
>                  ^^^^^^^^^^^^^^^^^
>     (full command: $ sudo modprobe ntb_transport tx_memcpy_offload=1 use_rx_dma=1 num_rx_dma_chan=1 use_intr=1)
> 
>     $ sudo sockperf tp -i $SERVER_IP -m 65400 -t 10 # RX DMA n_chan=1
>     sockperf: == version #3.10-no.git == 
>     [...]
>     sockperf: Summary: Message Rate is 8636 [msg/sec], Packet Rate is about 388620 [pkt/sec] (45 ip frags / msg)
>     sockperf: Summary: BandWidth is 538.630 MBps (4309.039 Mbps)
>                                                   ^^^^^^^^^^^^^
> 
>   - use_rx_dma=1 num_rx_dma_chan=2
>                  ^^^^^^^^^^^^^^^^^
>     (full command: $ sudo modprobe ntb_transport tx_memcpy_offload=1 use_rx_dma=1 num_rx_dma_chan=1 use_intr=1)
> 
>     $ sudo sockperf tp -i $SERVER_IP -m 65400 -t 10 # RX DMA n_chan=2
>     sockperf: == version #3.10-no.git == 
>     [...]
>     sockperf: Summary: Message Rate is 14283 [msg/sec], Packet Rate is about 642735 [pkt/sec] (45 ip frags / msg)
>     sockperf: Summary: BandWidth is 890.835 MBps (7126.680 Mbps)
>                                                   ^^^^^^^^^^^^^
> 
> [1] Additional changes are required to use DMA on R-Car S4. Those will be
>     posted separately.
> 
> 
> Koichiro Den (4):
>   NTB: ntb_transport: Handle remapped contiguous region in vmalloc space
>   NTB: ntb_transport: Ack DMA memcpy descriptors to avoid wait-list
>     growth
>   NTB: ntb_transport: Add module parameters use_tx_dma/use_rx_dma
>   NTB: ntb_transport: Support multi-channel DMA via module parameters
> 
>  drivers/ntb/ntb_transport.c | 386 +++++++++++++++++++++++++-----------
>  1 file changed, 270 insertions(+), 116 deletions(-)
> 
> -- 
> 2.48.1
> 

Hi Dave,

As a quick update, this series is likely to be superseded by another work
on the "NTB transport backed by remote DW eDMA" series:
https://lore.kernel.org/all/20251129160405.2568284-1-den@valinux.co.jp/
On R-Car S4, the remote eDMA-based approach clearly outperforms the
existing architecture that relied on DMA_MEMCPY engine.

Do you think it would be worth moving this older series forward?
(I'm not sure whether there is an interest from others on this series,
perhaps using some other platforms other than R-Car S4.)

Thank you in advance,

Koichiro
