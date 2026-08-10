Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020079.outbound.protection.outlook.com [52.101.229.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE3542CB12
	for <ntb@lists.linux.dev>; Mon, 10 Aug 2026 16:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786380710; cv=fail; b=mZPuax/ARJl90AF3epAoX5S6xsWvjok+QlJE+lpcSm0rCU96JzQJLazoH/jnDCzNQZpJLuT/hle17YHGKQScri1nmgkDqrLaKFEubiEzSKHyqJy9Bgvl1NYTcdtVSVRnarij2lzblDL+eZ88U7yTUu6GfXE15FMWhwdRkWaZZ/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786380710; c=relaxed/simple;
	bh=HlXcuUGEJ478lRxvAmyTxmGhcKF4Gi8SgT90jbnSs3E=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=PohRJFQKive8cU76t6Z3TLFkJdEsNPRdIoWjXtOZPU1u9r0lOw6gxKISL+s5SQyV0qnDGkJgjboF0fod6L9V12CmZTASywMk+jpT/AxIy5ATWIUqal2wF9Jj+QrjJW+GqFiIhBN6bHSbba2Fjxo2sV1vyjFd+jw0c0wwZj+3/DQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=g5UK5kMg; arc=fail smtp.client-ip=52.101.229.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="g5UK5kMg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cx4/IxzsM+ej+pYJ0J7UCEfBl3eU+/l5dZL4FxfsIJUgk35ycZ3S4KCchcMXjhIrYBsjX9oy5RQYXTt8zFouwgFWkxLO+UF6YaX1UiCvHZgObdeIYUTIGQ10Bh9qkY5OIWED6hunuCz+k7RQrRomuklWmFTkcpJ+GV4WEGReXDV+z5bqn0R5ciR1stmCJV8JBTedcFHVQLpB5ITmBWsdihV3zVkzgYqMWEO3Z7i/uZK0OhHxh67j4iWBoP5LeKvzeVJEarXxA1xS4hMedzLfuctv4BdNIUP3mD5hc32a6M+02i7JLamChYOtliWZp/mTYU7psguHczpMLThWEKgsYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ymARv5I12rgiqXW+nuFZDbTjjU4TsyqOISrRMde+C4=;
 b=kmWbMFqfCli/DRkptFQ0cCVBWGBEqW4n10nyuOBiNGvWHHpYb2MKc/2wYiHqlbnUyHM857Yk4nLbJwT/65PT5cqy529eHBcNqY+iGXFEDZMRfXb/Aji09GrOAvw3LH5HUGeAiRbdindOmhZ3Tsc7ZHNHRDPA/pkWgC1AawhNEZ+M4h/TNrzzPMPEXKqTvnH7EXhEnIsJsAZMo5/xu6J9CpocxA7NTC378BKSHXWS601p6JX1i4vjnY/ouvfoySNCRfav5hTj16jWGKkUBFGkfRb7xVmgsY5wdAiSk8OeC7PfY5q8/phMckj7HbxL0TISH4+xqMbQHeCzixXIyZRAxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ymARv5I12rgiqXW+nuFZDbTjjU4TsyqOISrRMde+C4=;
 b=g5UK5kMgXpRmUfTY6bwo9bmF3e07AlHnevOxUsQylZRPeiquADv081sUrPzUIpBGhbJjppHv6MTJ2QF/FtmhdtR5XRMEVLSbZ6uEPDpuffzwoCkjJN3KP1ee9a6nAxlVWD9asHABLf3IlTYI0fwHV/r/IiFVQAY1MwFV3Wr4XPs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB6729.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:42d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 16:51:43 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 16:51:43 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Frank Li <Frank.Li@kernel.org>,
	Allen Hubbe <allenbh@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Niklas Cassel <cassel@kernel.org>,
	Nicholas Bellinger <nab@linux-iscsi.org>
Cc: ntb@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 00/16] NTB: Add direct TX/RX using PCI endpoint DMA
Date: Tue, 11 Aug 2026 01:51:19 +0900
Message-ID: <20260810165136.2292436-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0092.jpnprd01.prod.outlook.com
 (2603:1096:405:37d::17) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB6729:EE_
X-MS-Office365-Filtering-Correlation-Id: a74ff241-54ca-4434-c7d0-08def6ffa86a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|23010399003|376014|1800799024|366016|6133799003|3023799007|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	pjyDFEj8dKAMxgQJZc7sQVv608svxP5zGSe69aIdtw3Z1asbJGeNfxzdI92+KGThXpEgg5mCRwcUMxzeDvOAWtw7+QY5aQpEPMdBceBXZeuE3i53CcBXnDJ+ltoTTRL26OKaZ2tSLXPWmzCkn6Wp2AlNr0GwbemMLz7X/u+LUBpoI8QycEFrTA4BnFc03jLpGra4B0BCqcadPwukPPPSAsrTYZls4aBJm8CJMH4BKIPrUGzgDKvlBWLP3xrepHJlQX2uzuwYRvhpRb4SeYz+WhYmGhp9LeDkLtCi151DFyDBv6vo0yWyzsmOp2a6zckBCXqYBxqn5PK5waoJ33jSFXXy1woOrVGgCRh+fIk2pGlMRuGn/WC7gEDSKgN6bdBJcyN5C5zDwatrJOWtcKRP8rY9jDLkA6cclOyPKKWKTNCCIARCeHvsbCEc5VPJkEs0xAY1MOHY85hCEknFFs4xGIsERjhWsOjyeHJ6UuDEKo7RNKqXva6Z6bYcV9cqyCqfdkINoMF+SJB/J4xeULDdKoietXzet80hUsKDUblc3fmflo8RUCsyc1+FvwK0eT8u+byWSYUQJ1SP3rdePkY3hvYIHJNwgG7b6jQT/r6fI2RzZCdCHxfU+UdWj2N4c5uV5mf7zXEnXoYrib5p5shPU5TAwptGJPdTyyBzf3D7tZM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(23010399003)(376014)(1800799024)(366016)(6133799003)(3023799007)(56012099006)(10067099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GzDD1cTnTQUhDG3WLzfe/Um06MgfiWTf0hTQ/wpEa0EZuDdPaLrSkNc2ang5?=
 =?us-ascii?Q?NvIDwlBj1BcKwipnKgThXBG4ijCYa5bCT/+6JIU5MWldYYx6RkN6GGzxDHk8?=
 =?us-ascii?Q?Jb/sZqEEjKgDStcWduwwejSBbpdkrxIGxvjB6timpHsWoDDmP17WMVv6n4g7?=
 =?us-ascii?Q?Yb/hnGJr5i/HihsHiDX/0q11JgU64L48auysth9FpdFibvAGsv0r0VrWv52m?=
 =?us-ascii?Q?fdyCeysQFxHvRV56xisjEhSz+S26I0x/LZFXft7UHjWp+UV0v+Wj2QkHMLc4?=
 =?us-ascii?Q?WtGMmrgwJGzEW1AwApdpFiG5H+lB6jAUxnR7ZfbNF5bWp3dluFZkeobNl/Bc?=
 =?us-ascii?Q?6+/1vHXOpZLbiwfJ0ay9qruMCqDDQfBrWiYSut+pkS+xAP9I0HsPJSjxY8pM?=
 =?us-ascii?Q?ftcThDgoszHvUCecx2BNBL3h1NizPtQa0XgVfw85TOcjxiFNC/1nWwkTWyNJ?=
 =?us-ascii?Q?e5GPxnMKIz9UyT8RoZVVWcMK2cmuo4T0pyzL5tzylgPfIkjidJCop5OgLAm+?=
 =?us-ascii?Q?3BeJh1hS1Z6Wdi6CTaixHsrDKvVy+m/DPizYCJ+dSW2nqzU0j75x1D1xdA7X?=
 =?us-ascii?Q?OuOQu9Pivedviu+Fe30Ua6u92WpTF3GlaRjWzbYrwu82UtfOEl1DZ12Occi2?=
 =?us-ascii?Q?kmhPRIuczZZxAI3BY6XrsrM//3EFl6PKY38LidHM+WXc9NRK0FyV/Y1WC3uF?=
 =?us-ascii?Q?w2vcB5gLhArJ0LqYg4p97pVjv2wOKoNI4kfsZ3jcqP92cK3O0S6tQAg4GTtf?=
 =?us-ascii?Q?16+22fhjaasFW6sd66mxI/mBY6QCdMR9jDOjOMXKjTMCi5b60jqLF6lCABV/?=
 =?us-ascii?Q?scGmDZqQduoHWKF1HE6i7b7QHoEPCJgX/k8UM+jzHwSEAlZW+ATfsN8DYY9r?=
 =?us-ascii?Q?un6VP5VYgC5Yc6YEJtOXUeBiQdTsQwjsX4rjzuD/4twSettiOM/9Qiz/Fghj?=
 =?us-ascii?Q?PBnDXuUReacYtkb34jqXhLauymTqRgBIemgi1+wWEY898jgWEk6llUike/1l?=
 =?us-ascii?Q?shPnyy7j+qO3mLVpRagM3kMknHi3eVf1DTBZQK8cgq+CZPOZtVf30HcEB7+J?=
 =?us-ascii?Q?iXDjkSdmRM9o0NmYA8wPmpMf/5BWUsQnaH+hbp4O3PBUcPohsjXW9iYtTV96?=
 =?us-ascii?Q?oUUpVgAuEQA65ioLAzhjo1Hgvr5CNfIZemAoA/kLPuACex42nzEXhHDV9Twq?=
 =?us-ascii?Q?RX5kWz4k0Gf1XPbjH3sBbzgAFmiwzIqOO1GgdUZYETnnH2DWxymWIezXlTSN?=
 =?us-ascii?Q?tQ8NkGwIS+/zXhpiuMNDlLyq+z71AanoqtQeJ29iS734/TTO7MxKxJggEDZ5?=
 =?us-ascii?Q?V6eriEMHLpaLc1Stvw0ciHZWmz2FLUyqxHiVuh08AOj+oa2kQEcgAE1P5ZmN?=
 =?us-ascii?Q?OqG261v6AswOZEjFBs9FshSSqvk3P4Gw1Qlx98ViHbuVUKEWqNQgdjlnOZi4?=
 =?us-ascii?Q?Nd8n8SPKV87jsA8XquO3DNuL8P3k+RLCItFQzTkNOU64Y+LlKevbsDUBan9z?=
 =?us-ascii?Q?c+M9fEofc7J2LereogbqCwQmP4pkOU685pHO1Fb8Vc0W326aBoNBIjNRcsi3?=
 =?us-ascii?Q?rk4fngc93GhNNJYeQEnHXoaihTXGoCWqVJjBrxRmrA0601KxX2J+/lqZ8JrI?=
 =?us-ascii?Q?ZugFT+kh2JEo79RPbXEw10fda5bsfHoJJqqmne7atTazl/D68sAaiZ4f355L?=
 =?us-ascii?Q?fI1zr7lHHuENVnD+EU/Z+WX5b8pknQbQpc56cImVimauS3pza9nUTBy1F9lW?=
 =?us-ascii?Q?+nGvtuHaLOnsEBpwWQWjK9GPtoEUH7LIrBrAWwVGq05L33FcUqW6?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: a74ff241-54ca-4434-c7d0-08def6ffa86a
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 16:51:43.6599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AuOBY9LkR/UkT/whjNv9x0HSocjDe/yBLwQWwHdJ9+iLLKPuhOodCDdmy9LzcbhpKlbdhYaxYaHkQvQIw6eqTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB6729

Hi,

This series lets ntb_transport transfer packets directly from client TX
buffers to peer RX buffers using PCI endpoint DMA, avoiding the
memory-window copy path. It raises throughput significantly.

My previous attempt at the same goal was:

  [RFC PATCH v4 00/38] NTB transport backed by PCI EP embedded DMA
  https://lore.kernel.org/r/20260118135440.1958279-1-den@valinux.co.jp/

Since that RFC, prerequisite work has entered mainline in a different
form. Unlike that RFC, this series extends ntb_transport itself and can
fall back to the existing memory-window copy path at runtime.

Some work needed to run this series on my R-Car S4 testbed is still under
review; see Dependencies below.

The series contains:

  * Patches 1-5   : small fixes and prerequisites
  * Patches 6-14  : the main implementation for direct TX/RX
  * Patches 15-16 : optional features


Summary
=======

ntb_transport currently copies each packet through a fixed slot in a
memory window. This series adds an optional path where the receiver
publishes client-buffer DMA addresses and the sender's DMA writes
packets directly to them. The existing copy path remains available, and
direct RX and TX are negotiated independently.

Bidirectional direct TX/RX requires a multi-function PCI endpoint. vNTB
uses one function, while the PCI DMA EPF on another exposes the endpoint
DMA controller to the host. Each sender needs an ordered channel that can
transfer from mapped system memory to peer-published DMA addresses. The
tested setup used dw-edma with the PCI DMA EPF on PF0 and vNTB on PF1.


Design
======

Session
-------

ntb_transport automatically reconnects a logical QP while the physical
NTB link and its shared MW remain up. One peer may therefore start the
next direct-DMA "session" while the other is still finishing the
previous teardown. A fresh session ID distinguishes the two instances,
and direct DMA remains disabled until both peers have acknowledged it.
Otherwise, stale RX addresses from the previous instance could be reused
after their mappings have been released.

Resetting the physical NTB link on every QP close would avoid this
overlap, but would also tear down all QPs for ordinary operations such
as ntb_netdev close/open, MTU changes, or queue reconfiguration. This
series keeps the existing automatic QP reconnect behavior instead.

Quiesce
-------

A published RX address must stay mapped until the sender can no longer
write to it. Closing the local QP alone does not prove this. During
teardown, each QP publishes its final issued TX boundary, then writes a
quiesce marker to tell the peer that this boundary is final and no more
TX will be issued for the session. The CPU-written marker can arrive
before earlier DMA writes when the two paths use different PCIe ordering
domains. The peer therefore waits until it has consumed completion words
through that boundary before acknowledging quiesce and releasing the RX
mappings. Local TX mappings remain owned until DMA completes or the
channel has been stopped and synchronized.

Completion ordering
-------------------

The payload and its completion word are submitted to the same ordered
DMA channel. A separate CPU MMIO completion would not provide that
ordering: its posted write could pass an earlier DMA write. The MSI or
doorbell sent after the DMA callback can still reach the peer before the
completion word is visible. A read-back from the completion destination
would close that window, but would add a non-posted PCIe round trip to
every packet. It hurt throughput in testing. Notifications are therefore
hints, while the completion word decides when an RX buffer can be
reused. Optional polling lets the receiver find a completion that
arrives after its notification.

Per-direction negotiation
-------------------------

A side may be able to map direct RX buffers even when it cannot reserve
all TX DMA channels. RX and TX are therefore negotiated separately,
allowing direct DMA in one direction while the other keeps using the
copy path.

Protocol compatibility
----------------------

The extension keeps protocol version 4 and the original QP layout for
peers that do not advertise direct DMA. Version 4 has been in use for
about 11 years.


Dependencies
============

The multi-function endpoint setup described above requires:

  1. [PATCH v6 0/6] PCI: endpoint: Expose endpoint DMA resources (part 2/3)
     (https://lore.kernel.org/r/20260804033855.2115817-1-den@valinux.co.jp/)

  2. [PATCH v5 0/3] PCI: endpoint: Add PCI DMA endpoint function (part 3/3)
     (https://lore.kernel.org/r/20260717050953.2145851-1-den@valinux.co.jp/)

  3. [PATCH 0/3] PCI: endpoint: Support vNTB as a non-first EPF
     (https://lore.kernel.org/r/20260728172306.2751813-1-den@valinux.co.jp/)

Series 1 and 2 will be combined in the next revision after the part 2
review settles, per Frank's feedback.


Performance improvement
=======================

The test used two R-Car S4 Spider boards connected with an OCuLink cable,
one as EP and the other as RC. The link was PCIe Gen4 x2 with DWC PCIe
controller IP v5.20 and eDMA (not HDMA). The workloads were:

- UDP: sudo iperf3 -ub0 -c $peer -l 65507 -w 512M -P 4 -t 10
- TCP: sudo iperf3 -Z -c $peer -l 65507 -P 8 -t 10

The results were:

  (unit: Gbps) (UL=EP->RC, DL=RC->EP)

          UL UDP  DL UDP   UL TCP  DL TCP
  ------- ------  -------  ------  ------
  Before  ~0.6     ~0.6     ~0.6     ~0.6
  After   ~19.5    ~17.3    ~12.3    ~10.8

Reaching the above throughput on R-Car S4 also requires:

- [PATCH 00/11] PCI/NTB: endpoint: packed vNTB memory windows
  (https://lore.kernel.org/r/20260803180439.1963864-1-den@valinux.co.jp/)
- [PATCH v4 00/24] dmaengine: dw-edma: Support dynamic LL appends
  (https://lore.kernel.org/r/20260729143036.3087722-1-den@valinux.co.jp/)

The test setup also used two unsubmitted platform changes: adding the PCIe
controller to the IPMMU allowlist and capping the EP DMA MRRS at 128 bytes.

The "After" result used:
- packed_mws=4 and `ethtool -L eth0 combined 4`
- `modprobe ntb_transport use_direct_dma=1 direct_dma_func=0 \
    direct_dma_ring_entries=256 direct_dma_poll=1`

Best regards,
Koichiro


Koichiro Den (16):
  NTB: ntb_transport: Abort link setup on QP MW allocation failure
  NTB: ntb_transport: Reject oversized TX buffers
  NTB: ntb_transport: Start TX offload thread after queue setup
  NTB: ntb_transport: Stop QP work before freeing a queue
  NTB: ntb_transport: Run RX processing on system workqueue
  NTB: ntb_transport: Define direct-DMA shared state
  NTB: ntb_transport: Negotiate direct-DMA queue layout
  NTB: ntb_transport: Add opt-in direct-DMA channel reservation
  NTB: ntb_transport: Allocate direct-DMA queue state
  NTB: ntb_transport: Implement direct-DMA QP session handshake
  NTB: ntb_transport: Implement direct-DMA RX buffer publication
  NTB: ntb_transport: Implement direct-DMA TX submission
  NTB: ntb_transport: Implement safe direct-DMA teardown
  NTB: ntb_transport: Enable direct-DMA queues
  NTB: ntb_transport: Report the direct-DMA payload limit
  NTB: ntb_transport: Add optional polling for direct-DMA RX

 drivers/net/ntb_netdev.c      |    4 +-
 drivers/ntb/ntb_transport.c   | 1523 +++++++++++++++++++++++++++++++--
 include/linux/ntb_transport.h |    1 +
 3 files changed, 1456 insertions(+), 72 deletions(-)

-- 
2.51.0

