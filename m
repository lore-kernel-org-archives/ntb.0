Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021084.outbound.protection.outlook.com [52.101.125.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174AE3AE19D
	for <ntb@lists.linux.dev>; Mon,  7 Sep 2026 14:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788791097; cv=fail; b=eePihGg/6xImr8Ho7MhbR6OoiNieezNz4qJKfBa5gFDS/0doNGFhOF35zjRNwAAqWqKGoqwKaU4wI1/3ewAI/1NMaMkvgIborsXUkqq6efRBKtWxasWJSJ81tjLlUFtglLrtywgrIrJf9T7xMoAx+XU1P6NINKGm5x2H+3N8R0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788791097; c=relaxed/simple;
	bh=rteN69/na48gvobvYR6JG4JP/cfsAZ5vsGfEFp4BIhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FOwjKJ6vvlXz5WnmwtWVVXnXIzqI04ayZNkJUgvttAvwza0yNvh2AP4H8leA25jNpb3IF9Lptb5SpqW8Up+Fv0Pdcay+7NkhBuslOYao+0Nseqjg4P59ADqElX52S3BpmIgau2Ib7jEnQj0Gn2ENQqHepmrFNE0b3reaNihrg1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=uCQZ1GRL; arc=fail smtp.client-ip=52.101.125.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="uCQZ1GRL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vXjl+GVQHHxPv3DvrZePywQFwyCcKRYrXJrGz+0vNgNAs4FPEgxdJ0Ycvo+RuFzAL60VAV7JwhkJeaOrEs5PS8Pb/js7oixyawqOU8pyYWvQQi6ejyFcJE42rHt2hVQnl4jkLyQTbBJ/Jb6ycRDd96VhQQfGR1Wp2IpVeUV92g5En0n3OZHtULqSGt5o+y+uH+n/DAAfQpJx/UweBXZlGD9CTY30v4TS7RKYRYetKJ7UI5hiQgXQ4w25a6lwow/aMglV9PK+PHUmiya+esLrEGYEIxSzMiJq3yRnF/BIYF6+1/aHK0Z5qO++KEN8A9ZfCbIX6nDSgQ58axchq/r2SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bFCbc37vkSo9XzsBc9milbmcHC/JFoSvmB8DYekM9lQ=;
 b=Qoy07HC/lHWoZwnDBGdc7g9Oa0CMmTcpGmFxl/zV78FXZtaozabvtmat7Otmfi8QlT6zcTfxJEcNyFXTv6wmv+H9ZpT88xgHeaUCo+VNMZAsEIKrBJL+wnfEdUwqD+t8laz6RCYkg7e3i+j5sZV/2L7/cgxYR9K5/LxNMS+e1stFjkrB/LkJr+dQSUVuQwwnzE8JNI83OFEcOU7gtQ+6Ro7ZobE5uf7eBJeUescydwQnwjrlaNo5cx2e16wCx5rXWmnsRioFgLDWTz78o/oWeOtcGYVg5KioasCEDf3JUkE5uQFG+49WKW+uDfqAlPQwRSze1w5l7v4DXwcKqnNVcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bFCbc37vkSo9XzsBc9milbmcHC/JFoSvmB8DYekM9lQ=;
 b=uCQZ1GRLMdfsQ7beoLFT2EIBpwygHEV9AUtRK1T90ssfo0tXp0x4xy9H3lsYl8jrAMUHpLtjsGFJHR5ib3h1fx3IiJqQ2MpUj0oxsqKva6EsiSRP4Z7BGPYFORCQgBokJGIWdr1UO3UCMGtAjazPtTlADMBa9K/vpKqR7Oh4sas=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY4P286MB7581.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:34e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 14:24:49 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 14:24:49 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>
Cc: Frank Li <Frank.Li@kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>,
	fuyuanli <fuyuanli0722@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nicholas Bellinger <nab@linux-iscsi.org>,
	Joey Zhang <joey.zhang@microchip.com>,
	ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/11] NTB: ntb_transport: Abort link setup on QP MW allocation failure
Date: Mon,  7 Sep 2026 23:24:26 +0900
Message-ID: <20260907142429.951930-9-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260907142429.951930-1-den@valinux.co.jp>
References: <20260907142429.951930-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0312.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38b::19) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY4P286MB7581:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d46f959-fcf0-4058-8f17-08df0cebc628
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|10070799003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	QAZJvvfWORawlOdDob2nt/eixrfhWAWYAdKvcuoVHLQIT+1xVu2v1+qZDvxCaMY+pC/aIP+zZbnbe0w6U6tlIqktzABEqyFGnEOas8kHUO0yPGHbg7X5ZX85tMJrx7vyQ6CJ04dmRMbUeipPX9uXSqXAYQUYnk9FpACSFUDBKli8ycrohbDsb9xQebQDh7bzcc99mGoVXC6BGZ9RxMRIhCTHFmyfoS+Hlwm5XrzkjSw0q7Z6yJJrOVE9V6eFQicgQ3Dw3tZbZv11sictA6U9ffgMoUjgkYXALR/CpLobJGzchvp2b0kZqEjfGeOw/J534YmASyFRwcEJsf174EeVA9jLAA4xoN08WZYp2BOwXbVLoXedjQnflcqoleEr9YfwgzCjGuOWwZLE6vy52OY9MJ6xNfTpjPGv7XuTA3YLXbfdnYoUO2yLodRw3QnWjcFjzNL80q+hA0n/hgYcbXi6FnPEjEO1zx4TcPL6HC6NR7wtqbgKcZsGbsNqVsee8JjhQDfb8knFZHX0WpuZD4CsYolfJ1VUZqNduBP/Hixo0l5ph9qYZxk4Xqx8dWnKqw/JSDNHe5pXetGWcJ1Mb23LULjQhWBbHDP/hKLI4/iZrROFgxdU0lwY5eLgS4MEypSV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(10070799003)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Hzbkl3RVsfiNxeZpeHDzORr1Rjtt1NdZx87GirN/XPHV0TFhpM9lF/raYqVe?=
 =?us-ascii?Q?C9L54qjobzblK0RoVOFbK4BU2yrBOyl+P2jHNqw7rO+xD3lMI12HRHEK3OKJ?=
 =?us-ascii?Q?rnKUZiCjzwRnBhIefn4TamjKoVDt/j3p8HocCDmk5aRzbb18TL0HL83sPNpU?=
 =?us-ascii?Q?hgai5kijH3aUzdNsOtqmrEbRvYWvM7juc94zukko+JVkom00Qdp5Y6VyQlGS?=
 =?us-ascii?Q?Zcm1n1VnrWZh6FRcrSYk/7bZr20iUbOh31XPIgm8DHznPiVKJFix4HiRUskK?=
 =?us-ascii?Q?69K2e54la5qVnG+re6VoWctlJ9OuDTrPy0WivibyUaAqNLvRLiuzrZkwOKb5?=
 =?us-ascii?Q?suVNa+6X+ZJ5NjVkb21oEra3Q2VMUKUhL9WNQDfdy5aB4GiZ5pU6LmwEreY8?=
 =?us-ascii?Q?x/ABlUNNKP2MMvB0N7xLjA04ccIJYq7UVXrIcDQhp8mGvVh+FJc5JpzYu5Ma?=
 =?us-ascii?Q?ybnNZK31wNg9Wz9+x6mnVFoGlBh02+y3xUL/NzK3Aodbu6HHh4VsIAqrtYAo?=
 =?us-ascii?Q?vVU2DWKjyIYQAHQk2Pvuzb1OCZbYym3NJxExexdFGAU6mzbyERBM1Wio+p69?=
 =?us-ascii?Q?eeTU+HzUxolVTpUyFZvDrhOo8KooZI2SHeYMVAMPAvdGjTyGCM2R2A4vM32/?=
 =?us-ascii?Q?4tE15aSCSRCKpNb+RDXXoZognm82qfVx7ZUXxaYSfDr0sc1qjfTnAsovxLxO?=
 =?us-ascii?Q?3q5wodGaQRuU3a7+uQUZCF/j4EEPqWOjAqJ9hY7TLCsOAkYJKsrLpqrIbn1R?=
 =?us-ascii?Q?Eh3DJnCP5ioHqGyKbEt7jmrDNa0fYXy1K1+R0HrVXnbX4nlnjufIgXSlvaB9?=
 =?us-ascii?Q?eLH748Le28pFP7+FCgfQ44Zidv0iFBg3ZJfYIi91AaQf7biElvfenTWLyC5r?=
 =?us-ascii?Q?SyRXXbPsfh63zFMsz7bZYe4IhbimTJZ7HbssKUK7EByDctrc5CYM+5goLRVc?=
 =?us-ascii?Q?9OhFLpCYlNQ+LXw9xTPvBx6k8g5ifou5i38+r9axh4LIlqegHoDtD+kuir4b?=
 =?us-ascii?Q?MvFVV+e7421bz6AeF7Xpq1F2AhZjOC6OvNNNNjQl6sbEbcaQeafAXSnLQq9I?=
 =?us-ascii?Q?rQkL8jBpBCVW3QJcPyPRJ61LKR+ZbGsR+4A/PDW09V30SOZ2uaC9YX7tW+K3?=
 =?us-ascii?Q?v5s1rZ1N52TLjeAdDuMARhJ50zoKOXOOu5nqxZN/nGTfZyvvfR0rrUbUMK/D?=
 =?us-ascii?Q?IB03VEu7EkvY2XhC8FRStr+Dp6kU5sehsRdZRzWC9hY6sHam8q4CIvEN33he?=
 =?us-ascii?Q?uc65UN3cCVtKtskZ3/QXKkf2L7+1qR7XAOtcnsf/ktMr3eDBFHneD5K+yIRG?=
 =?us-ascii?Q?57aosqn0wnboN3PZVuO/c9dUuuCzRHy/i3M4aRtYWVTcPWY5KAUOBPGXord6?=
 =?us-ascii?Q?N5sTWnLHEG74ctvcbpkUYVL7qYIntATxjjg5XU6JTAxFWapI3MlNfcqns1Yo?=
 =?us-ascii?Q?IV9oRTi9h6Yg9a6dRCxHVWYQbqJdgr1uega/EnFUb9iKRKgkgvgFZQm6CJIw?=
 =?us-ascii?Q?+GhboEUHu/GUaKaypdJ+yoMDwkm8O23MpHIZJVk2eOEVHN+iq8ODEzg5PjqF?=
 =?us-ascii?Q?oDYgeFdjwknr2W7kxPLQ65EX9ltga0xFjJJXZuqkdntYtBDVIGmV7/gJ24aX?=
 =?us-ascii?Q?9275YZvYoYsoywp7XPguhM5tGIKYHmfLfrcnWvuVsuxxJaN4ginaEDkWLlem?=
 =?us-ascii?Q?ZYo5VyTkT64ffAfJpRPpIsy5aRgAroc8YKDNpAWiCpzo/n/YzKq3B3jgjKgF?=
 =?us-ascii?Q?lYinM6BQ4xB18E5qvi7LRJbUDxZ7mk1sTVc2HRScRHqNog/nihvy?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d46f959-fcf0-4058-8f17-08df0cebc628
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 14:24:49.1798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FaYzqLrQKfsY9UyXKR3+olnXt0HcOvVlwuqUdXTMomjdK1Mf+180Mu0B9OsBAM2RB/GtxCBr897NpBtR8xyd1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB7581

ntb_transport_setup_qp_mw() can fail while growing a QP's RX entry pool,
but the link worker ignores that error. The worker can consequently
publish a QP whose memory-window state is only partly initialized.

Abort on the first QP setup error and release the MWs through the
existing error path instead of publishing the transport link.

Fixes: a754a8fcaf38 ("NTB: allocate number transport entries depending on size of ring size")
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Originally submitted as part of the direct TX/RX series v1:
https://lore.kernel.org/r/20260810165136.2292436-2-den@valinux.co.jp/

 drivers/ntb/ntb_transport.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 4c0a29693ac2..a902fce4ba60 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -1112,7 +1112,9 @@ static void ntb_transport_link_work(struct work_struct *work)
 	}
 
 	for (i = 0; i < nt->qp_count; i++) {
-		ntb_transport_setup_qp_mw(nt, i);
+		rc = ntb_transport_setup_qp_mw(nt, i);
+		if (rc)
+			goto out1;
 		ntb_transport_setup_qp_peer_msi(nt, i);
 	}
 
-- 
2.51.0

