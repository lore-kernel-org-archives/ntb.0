Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020093.outbound.protection.outlook.com [52.101.229.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE74139A803
	for <ntb@lists.linux.dev>; Mon, 14 Sep 2026 08:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789375729; cv=fail; b=rPe5h/Dku4dx+o33/wH0ZATagD+4lyp+zjNMW9wrAfRfwTkSIFhd6CJ7RENkv6+SSsfvZmIfdKqxyBJxfjF2TYbki7qXF8aHYAHHSQjGQQcBZ27ZZLHcFdo1bfiu/tgiw310ADPN1zHO3CYytFH9jvMnar4UyylF4aJp34iIJYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789375729; c=relaxed/simple;
	bh=PP/4L0sR/E5xjO0czPRqFDx4uW8GTNuBZf0KbkPYy9A=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WAYIY9cw7HpGPS9v85C8h3uKw6L10krvyPJOwaKvRwqLafsNg5XXB5ZeI3NCmhUHELuSUER/+0uomLyePEDJZat91yv8HR7sN/18GltFh/BhsNvItM4NDGqxH6w7j7GVfg0IvluEY/jfg5zJSw4IAylI5VWlJMX3blKaxvF/A5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=QUfndHON; arc=fail smtp.client-ip=52.101.229.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="QUfndHON"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZLs3LCepfNd+mQLMSjSgBKxjnQgxHVtngrKL0Cgqi9J5EMDIzbvNZ4d5CxXmZR5T6mkL0icVKb5Ktbi+FKQ6j/CE5cd4sBthlnPpHgufT0CatPk/z2Uj9RTSVKo/6C64zu8eXbIP/Vhgnk0KwOfG0se9ip77mDWC96B3sR02wc0lzkod2LZLBiB/OypQUtyx2uIVVszLdntkwqSCT2Khg+hARf/Es9/LcezdapHIHTdOghFokWIV40tkgOukyNlQlgFdbzkAfHwY5yc6gH3/UCPPhEpV/CnEQdRUN4heA7noSF43nmFfUx2CrSxzhCU9brhLR86iCTjRSh8bpbSQ3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6DNvdNPvtknE9V6rYazd7e9AkbVCZ1dHQ5VaS70f3BE=;
 b=XyBfHBvHRhEtLNmFEeJFGPLtwUgtmZPhwrfT5KtciNu4pT2+LQVvgiHc16mPIE7vj8Jc5+bpQDHgUfahUIXHrLQ7CWgQs4KCzdGuZjdTCwFOEDMmjktiep+t8aU32lOuyayvcdaMnyTD+T4xst16HPfJWUDXNvp4KCf40BO7IPNadRJz18OVN0+QUrIC1k5AEIRDxCWeM7n8vT4GL9RlqUCd9sj0PgJ0msNPf/3Zw0Vhi2Lx1ZykV2XqS+D7Hhcxt1wb3Eyvk4KdiAMHkML5ibfkPZ6USZsG3VYkfF5fRZ5ajU0ux72EvI+IXBApPwOOdBCGrcEGmpj1thExjS98BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6DNvdNPvtknE9V6rYazd7e9AkbVCZ1dHQ5VaS70f3BE=;
 b=QUfndHONZVG8QchMW39NYgevqM2PEpsyJUyzPVAsUJK+8ANJd2dEisP63q3oq9Y+kBpvkekPzGwnFQQSlPwUtKMML1MSfSgCPqKD8Z8XbZE9a6c3vMyBtuMAVgV5TqVgaNO2lyUTDhXstOWgP04RSlz+KnVsET56jZAzfj9Xyu0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TY7P286MB7153.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:326::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 08:48:41 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 08:48:40 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: ntb@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 00/10] net: ntb_netdev: Preserve checksum offload across NTB
Date: Mon, 14 Sep 2026 17:48:28 +0900
Message-ID: <20260914084838.2158249-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6P286CA0040.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b7::9) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TY7P286MB7153:EE_
X-MS-Office365-Filtering-Correlation-Id: ef22edf5-f5a2-4206-3522-08df123cf99c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|23010399003|1800799024|366016|6133799003|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	vyGm4bbBDcfVGqkAGxf/qb19BSVQgrfSNGeGElWSTqb9sBI+U2SvvlmdvhPm9qfhbTgM/XYElWgbMcEHwX055CmdW5NjH35hfUdMl9cCovoqxDNlSDoZ6oEExb4XiN7sLTJrAOgs2Wv2Ll41/vGahHFSEjmYw3H30JAM8rKzer0ihWEB8qcWRkZQtcUIQ87yxJFwXUsFVLdX/+aLdnz5cDC5mKbUQTCf0T0SpsR0me6rVrPBkNmjI7bf5VXAe6jiGhJiyxQWz7E98h0Sbnfy8sjzMK8NkDuYypmUqLQ3Wf8LifieRzzBUkmvedNQIWMxLUY/YmTDVy9wSb7psd4M6Zpm8js21ePgsF5V8NzHNxgVBJsDIsTpanc2QHEszcsmUI7SH/IMAGAqfKkP1SPis+8ruCJmXq0qaznGUGg2kWwd1bPFILdorrQBVP/QcH/f+gLFf1g5eW9sTHFbgWcgqkKUN3rJP4OuGCtIppp2JXVWToaBjj/IQAfa/7R9KxZQ5bFZ7uJOA6Wu8HOK3cblqaExGEkbwYY829QGTpcjOW+aDJbC9yQoJC5PqD3tx8h5lxj4DaRtDu1e7ZH9q/dW8vewdQ17v3U/txr79OIAX+JA9hVZwE4j2QDDv188a7jT
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(23010399003)(1800799024)(366016)(6133799003)(10067099003)(56012099006)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X7GSLIIMDez0p5pINku2RJs+YiPGBydGiqdIon54c9v79i5wfynJBcvldrm4?=
 =?us-ascii?Q?FSICavkeWlmaS1hWdf7eVtOWpGQk2WSeI906wSSX/l+m5PDa3jBWAuymQzE3?=
 =?us-ascii?Q?S95YRmmjt5HLQHqjLYEZONbix8+D7Mkwc3rZdLUOyMdWOqnGXe204Pcjo9SF?=
 =?us-ascii?Q?h48G8t4AVUG5T6logk+Ar6K22SrankDPfcNeFbDrzWFNSMjpYAm+DjXq+KNm?=
 =?us-ascii?Q?okPY5jv0zlKsd1UqZ2m3wmumZ7fiHFPQBF+XRW5yCi9mW9vCaPfPsHRExwbZ?=
 =?us-ascii?Q?Iuu2n0mzdT9XCJcqrAhW71GWJCIChr0uoZE6yXWyHV1C2QEjlNeiqyjDpxhk?=
 =?us-ascii?Q?EQOkPmgpfQXDUETtAM54eGPBy0fSjWcifWnHdpqqS5c95LECRyrBIB5Akds6?=
 =?us-ascii?Q?/GuwGk2FXKpAn/old77aBjWXK64w9wRLGpiac8AEvwqz2yk+QUZO2yTqvstx?=
 =?us-ascii?Q?BdIeD3bY/0Y3HNEb77NnjBKfeATUMogCGmC0OkxEH8KScdY418dRnVOWDWYo?=
 =?us-ascii?Q?f7/U3CmEUuquZ/qvqMyVZ7piknMdJEMXv1hxxCOUXOCpWHAoPkLYKH9jjqPy?=
 =?us-ascii?Q?ucga+YdAiLbmB13Fs1xe9Jpf8vEVfg/OEM/6D4T5YRXQ27DBjMiyw17mNRho?=
 =?us-ascii?Q?RMh0o7M5OBAuzEhMYh8I6KJej6eRFX+TJ2QB9BpeRi8JSyurdlgGj5HVrMRm?=
 =?us-ascii?Q?GU8sxg9/S/S3i9gOoXFV68czyXeE/gicfQpVBP5QPPt7relbXJh7Rx2F5N3m?=
 =?us-ascii?Q?Id/wg20BRKuFiB1T8JWarnkbPIGK98FmR8Ab34FcMa+qVTYROl98HXqdbhOg?=
 =?us-ascii?Q?SGZB6giRqcJezi4HLZOQkA5T9LeAe6JVf8n/0I8Oy5d8GbtKPQ8v/NU+1aI4?=
 =?us-ascii?Q?a5UfgsznAbEpDY/Cpjq7TpbaI25zOZstLHq9RnIzE9PM0OKZHKyoGU8Qhhcl?=
 =?us-ascii?Q?aWPYF8ZR0H+x5fhvoirrOQNS3i4QSTpJHpucDbivE5LMIBm52ffS5BNDih7M?=
 =?us-ascii?Q?BN6XxgJjrzzSa0g7ZkTKs9zuhlUfkLll20GGdAYeCjvt1PfQYGGSDK//BTJ/?=
 =?us-ascii?Q?rDLv2FAXu/U/r0uL1MzBCIg3xNDhDS+hqTWSGevV6G/GE2xS99/bgQKYgPoZ?=
 =?us-ascii?Q?uT/gXnHwqyifp/mEUoXJ48iEVc4T1Gb5t9UTi8z3zwMXL8UfG6lAAgS10o3l?=
 =?us-ascii?Q?adw8gIhj60drWEL5KOWQreCA+bHRqqIlvZEBnceDlcJRaxOebU+HrPTUp+u0?=
 =?us-ascii?Q?NG8nJpbCoiENdRknw+focNJfYOyUv/76yTJr+s+5GFG39J8+XCdeiDFqVPg9?=
 =?us-ascii?Q?HjQbErFB0CcEQk21hMfmQ8nPIXrLXwvr+uv6TmXxKmNcCG3pI0QvS7kDjF0G?=
 =?us-ascii?Q?a5gqCvN2H2yuyvQ1LTHTKwdwgOdCEB9Hc/evgYIGdgWvJ4Dp2eZQOhT49ydg?=
 =?us-ascii?Q?YJ1KyMDO46psYLHDIwiLOq2tlf8sdPqCZKu3sI9uUO8RoRMshyqi0o2c2JOD?=
 =?us-ascii?Q?WWKkpJRzq6/smPicI4O6/S9x8feK6c2WWk/n1Ac3Zaa6Atdg1aQb2lJ7BUim?=
 =?us-ascii?Q?djRTPyIkoPN6C/EQry6+T+1K1Xym9IurvmfnAWYfo3rVfNsAjSkwlHGFpBlH?=
 =?us-ascii?Q?PBGfoE/fd2x7Vf3cn3HZjX9eoa0qiuZcXSFT4wk/L6roJ2B6rDk9bflAzLht?=
 =?us-ascii?Q?GSPHOwf2ZtVAD8aNrv/01itcxEzuRrjS+0N8Jz8odmyQHX36II29MlbWzJUk?=
 =?us-ascii?Q?F0QHMDXF5Qn/fMA+TIgCqbU2UMNBQF5nLdv7oSu4O+WeYnLU3P6z?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: ef22edf5-f5a2-4206-3522-08df123cf99c
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 08:48:40.7709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2jgj2xEm6PSFJpI5/cBpBmDhNn376Db5aEp54I03Fy4PWL7lVfU/taIczshz36rU8zdmxUjrARysoVCeedW34Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB7153

Hi,

ntb_netdev may be used on embedded systems, where CPU resources are
often limited. L4 checksum calculation can therefore become a bottleneck
even when traffic stays within a trusted PCIe fabric.

This series carries CHECKSUM_PARTIAL across NTB in an ntb_netdev header.
A per-payload metadata bit in ntb_transport marks its presence. Receive
support is exchanged at QP link-up through scratchpads. Peers without
capability exchange continue to use software checksumming. The feature
remains disabled by default and must be enabled explicitly on trusted
links. RX checksum offload settings stay unchanged while the interface
is up.

Best regards,
Koichiro
---
Changes in v4:
  - Move offload metadata into an ntb_netdev header (Jakub)
  - Add an RX entry completion ordering fix (Sashiko)
  - Learn checksum support from link events, not RX callbacks, and keep
    it per QP (Sashiko)
    https://lore.kernel.org/r/xsaocp32a6siggahziu4jqbwgmdasmp6v64pd5aujfkoxhiqws@n5luestlntzc/
  - Advertise receive support only with RXCSUM enabled. Drop
    partial-checksum frames when it is disabled (Sashiko)
  - Keep local QP link requests separate from peer readiness
  - Reject short RX frames before parsing them
  - Factor out RX packet and byte accounting
  - Add a transport API to exchange client capabilities at QP link-up
  - Keep NETIF_F_RXCSUM unchanged while the interface is up

Changes in v3:
  - Rebase after the related ntb_netdev fixes landed in net-next
  - Avoid counting RX checksum failures as both errors and drops (Jakub)
  - Reject csum_start below ETH_HLEN on RX and fall back to software on
    TX (Jakub)
  - Use READ_ONCE() for hdr->ver and hdr->len (Sashiko)

Changes in v2:
  - Reset peer checksum capability on every link event (Sashiko)
  - Add prerequisite fixes for RX ordering and shared field endianness
    (Sashiko)

v3: https://lore.kernel.org/r/20260904052134.2970111-1-den@valinux.co.jp/
v2: https://lore.kernel.org/r/20260817064916.13278-1-den@valinux.co.jp/
v1: https://lore.kernel.org/r/20260814032913.3558500-1-den@valinux.co.jp/


Koichiro Den (10):
  NTB: ntb_transport: Order RX descriptor reads after completion
  NTB: ntb_transport: Use little-endian shared fields
  NTB: ntb_transport: Order RX entry completion
  NTB: ntb_transport: Keep local QP link requests separate
  NTB: ntb_transport: Exchange client capabilities at link-up
  NTB: ntb_transport: Add per-payload client metadata
  net: ntb_netdev: Reject short RX frames
  net: ntb_netdev: Factor out RX statistics update
  net: ntb_netdev: Introduce an optional packet header, ntb_netdev_hdr
  net: ntb_netdev: Preserve CHECKSUM_PARTIAL across NTB

 drivers/net/ntb_netdev.c      | 191 ++++++++++++++++++++++++++++------
 drivers/ntb/ntb_transport.c   | 177 +++++++++++++++++++++++--------
 include/linux/ntb_transport.h |  12 ++-
 3 files changed, 303 insertions(+), 77 deletions(-)


base-commit: 879e280b8486d4612ad1aa050d6fada2dd80cf1c
prerequisite-patch-id: 0000000000000000000000000000000000000000
-- 
2.51.0

