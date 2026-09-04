Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021128.outbound.protection.outlook.com [40.107.74.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C393DAAC8
	for <ntb@lists.linux.dev>; Fri,  4 Sep 2026 05:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788499302; cv=fail; b=caZzFcXJ8d0GBevtGEmMOZpq1zHfrR/nWqFlEEm3TtHYmfYpNZ1Sew2Dp72PKiTmjc86m2AhhK+nR8xmPp38zWjGjxKfIU7PlXdFltOHNzaYmmiJdgf+0spK1OA5xdWAWGdSk70FZV8MxBLyK0QAIVbJjEmLCc13b8t6+HFnA7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788499302; c=relaxed/simple;
	bh=CAnnx0gQ8p1CCBqYR2VvnMJa1Qn4qOYRL6mvuiEbTX0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=mbIqO8OtmWRYkSVCcrzXe95H5UzoldSD/gtrYYgVLsmjYtatH76Qei+nv+jObjxRYaPfTvTT67bALFL+/tTCeeyFLADeu0ha9iaazFg/0HQPFCvpjROsa1tu/pLd9fMaiogDUv76gGCxrploR/CE8hZij+/M7q3CKPIH/BIX8ZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=NbmYvYau; arc=fail smtp.client-ip=40.107.74.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="NbmYvYau"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NlQMGODTjtDTvtu7MzYtf0jWWBOD5Gi4ngwtTGq2dXxEiDU6pmBGw8ieNhFzaYszewoYroVhRNlXqRorA/sT6DUR9UHdRyLMeLMtXwramJEsbOi5jQPpOoJhYZ7G4Qgb+s2dghlMBsJUhPa/XOCwM0gMSCCauEBhrH8tRMChaOVy1mtQCYGjD7FKfG1UekRkhmUiPx/o78t0kw3taQCwpDzN9QWIippAJxSAKZgXupYzc+u4wiMR0m3BN5PAyrR6UtbjalJ3dmDpudFm1eKW1vYvyl91NH1eINa7quEtEOoGqVfbleYUh6P6Z82ucs7MownDouF00EFtjdwZ9P4KpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DEOHyM7cwyH5okfUE8Ymyiwe1chmMDYnSNWil/EBg3A=;
 b=HOiwXDvAmyJsu/CLkG3qYlbI0JROKuHnJVJJuDHvoQykjezleYIILsQfSx5kvsNRJOkpBviNVSR/1Rm5ypUG0JI3cNz5UimTVbqIXHPK+2g7uxEb3EAzhQh3XfBk25nLnRpeYjsgXQxEczwd0z7cPNbF/9vullGn5N0OOe7oHXyIT+AX79tPU6J1umnGFOilJfLI87g9mqlICOp9JDlj6v5g85GJvzsuhnu8oE4dxEWfJC0AfpSqNpzOIk7ERvjkyjZwu+/zhHSYofN061Gf/vKdqCnDvgS79Yw4d+luAbQCamaRgn3Ph5s6XWwxEBAoyb7lklGew96n9LXPAgycOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DEOHyM7cwyH5okfUE8Ymyiwe1chmMDYnSNWil/EBg3A=;
 b=NbmYvYauywe0Lrk09/wwM4eAGIe3+jIqsFqcdYUSeZLasls/xUd40XJXuU9b7pyF1YgyIiRSLnstilMqaYhTRLyJV9O46nFMNRKWnMROAToDS/iKjW/WKhgVOeArteNoe7JxEhwYaVQru+G3iUepwUMJdutQFOl5XbqjNSyeus0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY4P286MB6378.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:339::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 05:21:36 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 05:21:36 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jakub Kicinski <kuba@kernel.org>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: ntb@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 0/4] net: ntb_netdev: Preserve checksum offload across NTB
Date: Fri,  4 Sep 2026 14:21:30 +0900
Message-ID: <20260904052134.2970111-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0110.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::17) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY4P286MB6378:EE_
X-MS-Office365-Filtering-Correlation-Id: 3be03561-0668-4779-1ba4-08df0a4463e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|10070799003|7416014|376014|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	y/Y1KubKH1xEbE62/H+SHYoR9sHhtAqtOuG+D21rXwpTEH0nDTySzaXn5I4RaYcgjJMDI1BjwY6xH85tsN/6yD7b6JRv9jYuVwvlefRpwnc8x9WlESGtqjlLOZMQBcMmbeA2zqJIhsvuQmnVUgvJ6WweOZM3iIZInACR7zuFaVV139HKOT84ZapvoyFEkGe95xZkaha3XQdlnRvTBxqK2byKRGRz36+Rh0R6mtjyDAemJ/EHowtKRT3wQ5tXwu8gzbe1u/jRFxlikpinv1nawPAucNTXWd3X67UAGpnaT/TBNbdcmDM9jMskca6Qdhnsglo0YK227TY6bi+e0e6+vZmboUWEoC2v4P2XDxBEd4mODqtBUVspge0q0tFa1T88hC1lMMUls6NNzxy1YadtG+OSa733uKshgzMiEFHiakvHOgUEnz4H22p7PuPmqw7jWX/F3Rol8hvcNBJXlg8WuYmPNF8gR0PuoNrDqJq96Jit27UxCsOVjd56OHebjNI2Fbdn2NlBBrmEgBWxF2vMRy6YdKwzMxK5KHqzT01uJhGnnNzvutVAfVKG+rPhs2olP7vMd10wUAxpFiEgGgHm7uZQGnnSrJP83B1gX1+2AkC3IeD3ztUJNVvDgZNJtDcx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(10070799003)(7416014)(376014)(10067099003)(56012099006)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rq/4iM/xcSyrKfSaYPfELwI6dNM85bg3w7tLJHYUL6Og2UoYaLfecWerHKpM?=
 =?us-ascii?Q?Sg/HewK2ho/0/C6Crv+mBKY0Yy6XyOvosdm90tJ8BYaM+rPsA352ajVtBFjZ?=
 =?us-ascii?Q?RdKt/xNAbpwFeSXg6xJV565Qp4NyBaKn2v/uV5mke44HhSDkmFsjM21uyR00?=
 =?us-ascii?Q?NDuAYGFFc1LwZTP/XOhO2lmQ4EJS1au+R3V4B7VGaVbJpUv6WqH9PlyNN9fX?=
 =?us-ascii?Q?mBaB5yg00nBKAbB/PjqeqELQHMJdugcm0ELZRnH2dIsyD2DXPpdN8lDNvpUz?=
 =?us-ascii?Q?unzBo6hRt5mhGDNrqgFyOFdSBA+jCIhiTUupCrf3NPbF+ihnOvrpbNGb2Ao7?=
 =?us-ascii?Q?7eRkzkqBDWojU3r4pf42m6++cLWJD4hc87+KF6bGQkJ+abBWnQzrrydqVxv1?=
 =?us-ascii?Q?EwodA1XRstKc3XhoZcPGI264aGjEWKkWdXTuDlZxxC5Aolg2c/zYAnYO/a0P?=
 =?us-ascii?Q?4fN7AX9BFFrlMZ81VW412E6SmxY/XzPqsicyWh9TnfUnKSMB2RW7+Tp0DZ72?=
 =?us-ascii?Q?YH1kRET8qmmyv4h08zUFiUf/sem8yzFVHiSARpKLg/G7/uZhce8sSagI9YVo?=
 =?us-ascii?Q?t5dHo6WHn/h9xvo0ELl53bf/DQi+3tiLRYpJGM71xR536hkxietcA8bGZqqs?=
 =?us-ascii?Q?bJt4xkpJgKaP62lzHIrW0Vrug0/tU4AKxhl/AAb/yIpALxSsH6MVvo3ttnI7?=
 =?us-ascii?Q?4zVTKBA/6yBurTrKCWuexTZZVPZGdZV81geLgRgTWxQRWb4fwNpxQGhIEGBM?=
 =?us-ascii?Q?64+5C4wEgV/e9k75qPagM6lszrIS7jhQn/rJtXVenFlHVqSQAC5Of/AkhIdZ?=
 =?us-ascii?Q?xRNgalf3xvYKbSSdR/JcuzD9oc7Lapg/KuBCv5zyoRfDIN8c/1SZacz8qHcM?=
 =?us-ascii?Q?nPTdhbhhwj0eeVPJXLxvfmCb91SL9t69JdFYSonG6KTMZ0iw9mXe8HJQsnf8?=
 =?us-ascii?Q?ibfFTsrMFDOHEdDjuXRch8r1Yl9e9n0JW+KiYtHnpZdO2qSrhNk7wWJWGulq?=
 =?us-ascii?Q?1o7i0TBXXjMQ0chjeuCEOu1FWyDUfxKtoTiYpsS04rWh/LaGVjd5Dv5QAPso?=
 =?us-ascii?Q?tYKZPvKwiuWAw2UD1sigJR3Jrk/Y0/uI/k1GLIqjT4ZNzLSXDPps1+Ulm1PX?=
 =?us-ascii?Q?SkBlQqrcp9sDVeWeWG3EF9SDNtjDJAOJy+eTYl2RgUaHQ03PukVSTZASGP+D?=
 =?us-ascii?Q?r9Wfufvw06gIuUiIgUORURhTX7IP+3F5ksb8Ql+sQZYLfaUMpvgPUOr30p5E?=
 =?us-ascii?Q?nSpsykt/zHGW7tpko/+BawQUydBZDL7wIrfAIouY3e3PEH/dyWOlhdExDVIN?=
 =?us-ascii?Q?8yEnC5FF5qMNiN6s9gkSwBJLEe+Tdt5AyuLsGfaNcfLMNm6/izXmdILL0az1?=
 =?us-ascii?Q?k5IlyhTeDgzL2xsCU+Y1tC6CR6lnu1G2/kCr8za1MnBlrPyndK3gmxMKbOPZ?=
 =?us-ascii?Q?H71BDRyOyTGVN/+ZM0uHCQ+DF0/gaHZRS7SdYjS/9qoELIH/qJv3HVaou95A?=
 =?us-ascii?Q?D4U4A+AuEpCq14T/IAQPCqMatmFD+tezVb+oIGlsDbbA0NShMvID+KQLV9xl?=
 =?us-ascii?Q?Sf5xuswqE5WztbWXgsAkpu7hr2uFootnQF8DJeSzPvFsp35lo9s52S883Pgg?=
 =?us-ascii?Q?/t6B4RzpEvD3J3KNd4YPkHNa+vFf+KNXRCh0YFtk871SDqRBDmD5Jfm6A8nE?=
 =?us-ascii?Q?gHdOv0poIr0j5K2Pp7go5HWgfisYBDhYpnaoTE+EwhzHH7WJrMem0qFpApPK?=
 =?us-ascii?Q?WW83mIFRm8KGd/eLvkAfdJ22m03X23B1cumuvhcFsSha1UIw/YqL?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 3be03561-0668-4779-1ba4-08df0a4463e7
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 05:21:36.1075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K3FSoEFh66lRx4XSpd7mWlRV4CNMyFKIU8wlFQR3jqaPDqpUPUseIoNj6g8UTJvjznUyCqQMxeg/XEvjSZLfTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB6378

Hi,

ntb_netdev may be used on embedded systems, where CPU resources are
often limited. L4 checksum calculation can therefore become a bottleneck
even when traffic stays within a trusted PCIe fabric.

This series carries CHECKSUM_PARTIAL across the NTB link using opaque
per-payload metadata in ntb_transport. Peers without metadata support
continue to use software checksumming. The feature remains disabled by
default and must be enabled explicitly on trusted links.

Note: the first two fixes came from Sashiko's review of v1. They touch
the same ntb_transport path as the metadata patch, so keeping them here
avoids a cross-tree dependency. With review from the NTB side, I hope
the whole series can go through net-next.

Best regards,
Koichiro
---
Changes in v3:
  - Rebase after the related ntb_netdev/ntb_transport fixes landed in
    net-next
  - Avoid counting RX checksum failures as both errors and drops (Jakub)
  - Reject csum_start below ETH_HLEN on RX and fall back to software on
    TX (Jakub)
  - Use READ_ONCE() for hdr->ver and hdr->len (Sashiko)

Changes in v2:
  - Reset peer checksum capability on every link event (Sashiko)
  - Add prerequisite fixes for RX ordering and shared field endianness
    (Sashiko)

v2: https://lore.kernel.org/r/20260817064916.13278-1-den@valinux.co.jp/
v1: https://lore.kernel.org/r/20260814032913.3558500-1-den@valinux.co.jp/


Koichiro Den (4):
  NTB: ntb_transport: Order RX descriptor reads after completion
  NTB: ntb_transport: Use little-endian shared fields
  NTB: ntb_transport: Add per-payload client metadata
  net: ntb_netdev: Preserve CHECKSUM_PARTIAL across NTB

 drivers/net/ntb_netdev.c      | 95 ++++++++++++++++++++++++++++++-----
 drivers/ntb/ntb_transport.c   | 73 +++++++++++++++++----------
 include/linux/ntb_transport.h |  6 ++-
 3 files changed, 133 insertions(+), 41 deletions(-)

base-commit: 6ebcf5074cff0402730c6981d2397139fee6322d
-- 
2.51.0

