Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020121.outbound.protection.outlook.com [52.101.228.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC77C44BC89
	for <ntb@lists.linux.dev>; Sat, 28 Feb 2026 14:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772290550; cv=fail; b=ZojL6TkD0dzbJI4VdHyNu/nFRkRiP2b6Egm50vUxlKsWzZpIjfJvnHpOyHIj5lJ+D7NxhcQrQssQfB3LsmbUETXhlyA+hxke6fPHUHCVC3MHrNnB1f91OpEX+t+b6Eag1TTeBpHtoBfgUJUWyPooGrOjozLbcnyCedC/da/hgRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772290550; c=relaxed/simple;
	bh=uAo6CuMiFop/duelu7uqnqHnb74iDGSJwVQL3vpsHPM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=t7RVaHWhfOaMOuAPbLb1wwHeZvWix+ZDd+Qi+LZIkBhnzLbZt6FL2Zwn6g7m5IXK/QmvOHoiisKv+oFZlBX1UvqZltJnj77YzRda4p3zPuE/mtjyr/BE+4HbOthoDG/4oPwM88RK79ehZG/SVg3sK+6zCqLOX86Yh/bXOEh4IS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=rVo15qs5; arc=fail smtp.client-ip=52.101.228.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="rVo15qs5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hzakMDc4ONNgx1DHn4Yodt33bHTcD1Rx4veSTI6IfLRLFuGj1gaGykNQ7cl4yyAPaC5pgkjC+EVFDYXYZYMGOHs3N063mSp8pl6UsVLkSz/L6kZBCj5zNkkJlaUo2bQ3BRYEayUCvLe12MFXYERmOe6zqDrwNSY8GmSLwkymaBaLoLiBj3gscQ+91AXUWT4xpK69Af4L40vtvNcpCHvm+Huqlj+Px6uOOrg0pn/wlIjWGnfANg/Q9FjF9ckzNGWnrzT6C40ZMUk8DwrfrDMbMEyW4YXIxxoAz27+kBt/N8khKd5OLj0E6eCC2xwCo/BwBurpn2VM3kzgbH9CgLaxeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+QifW0uhC/k1PZfMNuDmrOX14aZwhIzim9HDbaQ2R1M=;
 b=gSu0vgMk1/WAyedop5vDqYclPu/hoL5/nMMksGjheqrrLlqTDb0dJip917rvda42OqRN+mFjb4LZ93ufAtF3U7x9NxNOqiUn1G0NS3bZJtb7DtF67mdnUVi1qvGhwXr6dT6RRG/ecMCGyuXhLURiVXSPvpO5Zh+iP50cW5vvCKKErcmjPELBa0v0fjjlu4D5r9f3CsSENnSC9lledxdfd2ibj/Qs/TrHYpBaVwO1NgzxQZ3/kCJ84SMIVVHmy2nh/xNsfz+AMSzKgFkHF9ZGrF4uy/ijpA4WFnt7fnbAU9m4SunYxJ6foiDBDy1B7+W2j3cJxA02cqw29QjsBaOxiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+QifW0uhC/k1PZfMNuDmrOX14aZwhIzim9HDbaQ2R1M=;
 b=rVo15qs5sKly2GwSzUO3+v/4Wfj9SxAqEpsPHlEmAMAx8JE5AsjJKUt/9xAE7tWp9/DGLiGCwYNQP42l5xTga78OTtBtXqdeqJhrPc9MOmhSjLPrU+mYCTKhKrOnWAT3ie4M8Kxb9l/ZhxpVUAXv+fVRzZa4RHdzYlywO3cVpX4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYYP286MB5182.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:164::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Sat, 28 Feb
 2026 14:55:45 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9654.013; Sat, 28 Feb 2026
 14:55:45 +0000
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
Subject: [PATCH v2 0/4] net: ntb_netdev: Add Multi-queue support
Date: Sat, 28 Feb 2026 23:55:34 +0900
Message-ID: <20260228145538.3955864-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0133.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::14) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYYP286MB5182:EE_
X-MS-Office365-Filtering-Correlation-Id: 18cc0ac0-8669-4422-c88b-08de76d9736e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	u5HIWqqntKOjXeEzNSBvtAf20fCcJMoInIU325mZRPJjzV1lbZJzTlP8kH3IX5aKwM2xLz8Jkk2DDJRVJXSpnUsbsMEiRRDIncR1HSsYZVZDjz+jhH0TELzOd7KlpI97UAjabCb6zykWtRqowFIHVmuQefKzNloZUc/t+dYYVAqNp4IVMQJaO22jlb3ox3AFtQjRLOCT89LLEkZgngqmUfu0tZacVBNUoYf6ThgQgZKSQTb+4FV7gw655a5y7tZ0mMt4BzQDsK9oz63B1rw57AUWM14XOwwIZHMerUsv1cjSpMn7ADxnChNA1DpqyHZCKJIrpvzWdxfoLcpPztipav+NJw9fbQRtVLutt+qENAso0xgbeBwB+0X6esMPYZnRFPofVcNuaMq1yiFHYXZph1Fd6Qc+2xjOOPyy4+n5dwA6u7A+y5G3I2hzqNovyIIEw0nv7k2mP4Xg5DjB5nnthr+PIzsjzY4eWnUTvYzvRDhc5zmnSF/aWl6GRAlN1g8+enh1Po9dcryDaQmhpL8HRcYxs9v9mStImBnVz2AeE9pVqc/BwFTOoxaA6WjkUf3YWu6jEl/xoY1Ng5Lxn/pmocf6E7BCP6Fjki8dHZ4zrer894SR+V16NR5t5akCF4Wvjt4O/VUVwcBpPsXBxaUFBZ5eO4Yi8fAXO6Yt0uGfPrihrQR32zUDO2NZa+pCaFoD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2yqqzOPml8Kogjc2F+6pzFI1JdzyJ8N/wI5EcnJbgdmLN1nN+Vw5iaW4aMS9?=
 =?us-ascii?Q?9JmKq8+ir2z5IF3hvrborgrALA3M8Ks13Pu8wy83dGkvSoZPs/S1v4jccJD5?=
 =?us-ascii?Q?ixvM9YQ8apljx/jJXjivlcyM8A+j18GOL0vA+bi5vPonPfZg5LRMirKYhtoP?=
 =?us-ascii?Q?6xUzKq/LvwuhUG+gpOSUjhTr9P5S1e5BnziZPtwIcJJLM2WpOizk2TE4JqKQ?=
 =?us-ascii?Q?RXH+IlSnVa0huATDmFCn9IDo02ugHB1eSUVa58deghxp4REkLxBA/DMXuJ20?=
 =?us-ascii?Q?6FdGwmO8JvfbXdp1LBAEn+2IvuY4J9PUDuAcSW25Y5JTZKMXMeHG6l1LSCSU?=
 =?us-ascii?Q?ngNyUhBL10aF1K9uAvduoAGNGWpm1h95h4nZ9iLL3eLNZ+fH9lW5xBSjSVYr?=
 =?us-ascii?Q?nw4FcREqwIvIlJf/mJgfK6v7cfFDRUIjDk+sUfgw4XK6wUkuImi9VJR6QNPP?=
 =?us-ascii?Q?iOXWPQ0kuBPkGswhPS07RhP/SuFPxmk4DHi97vb5h27NXpG2MuGSlwyQFutu?=
 =?us-ascii?Q?QNee8tyAVSlRBHbNJ/809iuv6TMPAUc2y2gg6WpeT21lA2tLvZmZ4+tHa46H?=
 =?us-ascii?Q?Koib+v7nYRnHJlaUdQaKmwyEL67VTP0scCItMKMCbc25Osec0sttIiMgUWa3?=
 =?us-ascii?Q?tqbJP8/fIBHeDviUvtaPPchypeloBHomdPp6TVxxNc/m7zz4mmqa6C3omYQY?=
 =?us-ascii?Q?JJjpumE2plugXO9YhEP2rjU7314KRGOnUGaUwQFXbpPlBv90WRBoifZe6izH?=
 =?us-ascii?Q?Yp2pFB2Xty3Td2gTzzZfgnT4L3rg0jNvqapmzGcy+2oEvaiWarpUuOHH/dX0?=
 =?us-ascii?Q?1NXlqvt64Zh9MT5PPxIllUCpEOzZ3fJo+J/V+/I/zH9kMQ0FV+popjt3Wyvh?=
 =?us-ascii?Q?PN9aN9+gduho9igm8EP+spnrNktRtsVIlJkHJD0dNOpTqmP5REkfc4EuBqy9?=
 =?us-ascii?Q?tAjdHt3hgO79CLr3FdUuIc+6/DzDxNcVgJUR3HbyVuX2Nsv7yQzO/5phakSF?=
 =?us-ascii?Q?n/y6/ymwRmoJbtjoCkA2kK5a9UVY2/yNbjewZypYXxxJNG5qYPb1SXiYlJOq?=
 =?us-ascii?Q?K2d6+KFBVK9Gw7xEegfNrbRkjqZ782A8ry2QoTJKRY5pWF3OKFOfRsoUnOPY?=
 =?us-ascii?Q?iHlXCBhcIFIDEWCCUIZ6BDKsUizQBL55iyDO4L3Jt53Ulp0V7feyFTdzgI/j?=
 =?us-ascii?Q?HtaO7P3ugOvfiqKYW9fG8qMbu6dzyFp5HGqssr4DIArMllSa6hr8M3cQdVgy?=
 =?us-ascii?Q?YLur2Lr29WXlFjuWpMRbpR2BQaHOoBlmNZLbZpP1yK9YCcH2DefKU1PuDpr1?=
 =?us-ascii?Q?sZX8bAgW8Saef5A7ZXp4QoMSsWpsy0TvF1CdOW1OUy/bGBzLIo4vJCQ5sy2e?=
 =?us-ascii?Q?YPxrRg0x9wOFEwc++CRczRhyeLeHruoOEsWnTfJzkBbHLoNaONcJGOo6oRXx?=
 =?us-ascii?Q?y8SzhQ2WZ++jqsPnlM61XNndVqO2gz63p6EZzW45nuCmrZj1U8u5P6PBaDks?=
 =?us-ascii?Q?vasza7A0a2fYa4LnTr5n5Rn3t/N6pCy3ymL0lfw/lDT8iKNTLn0QChyEA3hW?=
 =?us-ascii?Q?BTcDVL7Cj/OyJfeEB/DjboogMHqvHZG7HNtLtIaOiVA0bVElYv6SnTFxHHl1?=
 =?us-ascii?Q?sZ6BL+S84pL3QsigCUJYYIO67Pp9aZ4FClLUztHmKMf6bQqKBaxsB/23EX9d?=
 =?us-ascii?Q?skVSKUTweAgx3ft4dW61a4b3WayYJ63mfMkKJbVGmxaURems0rt0Vq6f5CDL?=
 =?us-ascii?Q?yAi0B1CG4XZ0SUq7eYJm4HhPvyvJxOuT5KK9kUKoH4ma2ZZk1jPc?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 18cc0ac0-8669-4422-c88b-08de76d9736e
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2026 14:55:45.0315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LTRue9agc65ZtpD0zJzRRqpBF+TcupmRRXnmzpwDxLYUVOX/KmCc9RdZ/rymkuLI6HE8u+SPy6Bpy9nHtAlifg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB5182

Hi,

ntb_netdev currently hard-codes a single NTB transport queue pair, which
means the datapath effectively runs as a single-queue netdev regardless
of available CPUs / parallel flows.

The longer-term motivation here is throughput scale-out: allow
ntb_netdev to grow beyond the single-QP bottleneck and make it possible
to spread TX/RX work across multiple queue pairs as link speeds and core
counts keep increasing.

Multi-queue also unlocks the standard networking knobs on top of it. In
particular, once the device exposes multiple TX queues, qdisc/tc can
steer flows/traffic classes into different queues (via
skb->queue_mapping), enabling per-flow/per-class scheduling and QoS in a
familiar way.


Usage
=====

  1. Ensure the NTB device you want to use has multiple Memory Windows.
  2. modprobe ntb_transport on both sides, if it's not built-in.
  3. modprobe ntb_netdev on both sides, if it's not built-in.
  4. Use ethtool -L to configure the desired number of queues.
     The default number of real (combined) queues is 1.

     e.g. ethtool -L eth0 combined 2 # to increase
          ethtool -L eth0 combined 1 # to reduce back to 1

  Note:
    * If the NTB device has only a single Memory Window, ethtool -L eth0
      combined N (N > 1) fails with:
      "netlink error: No space left on device".
    * ethtool -L can be executed while the net_device is up.


Compatibility
=============

  The default remains a single queue, so behavior is unchanged unless
  the user explicitly increases the number of queues.


Kernel base
===========

  ntb-next (latest as of 2026-02-28):
  commit 7b3302c687ca ("ntb_hw_amd: Fix incorrect debug message in link
                        disable path")


Testing / Results
=================

  Environment / command line:
    - 2x R-Car S4 Spider boards
      "Kernel base" (see above) + this series

  TCP:
    [RC] $ sudo iperf3 -s
    [EP] $ sudo iperf3 -Z -c ${SERVER_IP} -l 65480 -w 512M -P 4
  UDP:
    [RC] $ sudo iperf3 -s
    [EP] $ sudo iperf3 -ub0 -c ${SERVER_IP} -l 65480 -w 512M -P 4

  Without this series:
      TCP / UDP : 589 Mbps / 580 Mbps

  With this series (default single queue):
      TCP / UDP : 583 Mbps / 583 Mbps

  With this series + `ethtool -L eth0 combined 2`:
      TCP / UDP : 576 Mbps / 584 Mbps

  With this series + `ethtool -L eth0 combined 2` + [1], where flows are
  properly distributed across queues:
      TCP / UDP : 1.12 Gbps / 1.17 Gbps


  The 575~590 Mbps variation is run-to-run variance i.e. no measurable
  regression or improvement is observed with a single queue. The key
  point is scaling from ~600 Mbps to ~1.20 Gbps once flows are
  distributed across multiple queues.

  Note: On R-Car S4 Spider, only BAR2 is usable for ntb_transport MW.
  For testing, BAR2 was expanded from 1 MiB to 2 MiB and split into two
  Memory Windows. A follow-up series is planned to add split BAR support
  for vNTB. On platforms where multiple BARs can be used for the
  datapath, this series should allow >=2 queues without additional
  changes.

  [1] [PATCH v2 00/10] NTB: epf: Enable per-doorbell bit handling while keeping legacy offset
      https://lore.kernel.org/linux-pci/20260227084955.3184017-1-den@valinux.co.jp/
      (subject was accidentally incorrect in the original posting)


Changelog
=========

Changes in v2:
  - Drop the ntb_num_queues module parameter and implement ethtool
    .set_channels().
    v1 Patch 2-3 are dropped; v2 Patch 2-3 become preparatory changes
    for the new Patch 4 implementing .set_channels().
  - Drop unrelated changes from Patch 1 to keep it focused and easier to
    review.


Best regards,
Koichiro


Koichiro Den (4):
  net: ntb_netdev: Introduce per-queue context
  net: ntb_netdev: Gate subqueue stop/wake by transport link
  net: ntb_netdev: Factor out multi-queue helpers
  net: ntb_netdev: Support ethtool channels for multi-queue

 drivers/net/ntb_netdev.c | 483 +++++++++++++++++++++++++++++++--------
 1 file changed, 386 insertions(+), 97 deletions(-)

-- 
2.51.0

