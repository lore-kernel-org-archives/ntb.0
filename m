Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020106.outbound.protection.outlook.com [52.101.229.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44DE3A8FE9
	for <ntb@lists.linux.dev>; Mon, 17 Aug 2026 06:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786949370; cv=fail; b=o+9fFN/o7oj00c7lz6ADybXK2crp/OS91zh3xUua0fVP/CUrBdTAt6T2FYby4xCRG4O4q4ELKcMXm+fr1jpZxgLlDHhHLJW/joDroX1/BkC0/hO/OM2Zd7nP+N587m7xd4rl6OVjsUa0QXaeFYz8CxOVm2/HqK64mWpGwZlb0Ts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786949370; c=relaxed/simple;
	bh=bGt2WYDtPgfdjpnM3eBTRVfNl+bEecAP7R1NJJrKECM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Me63RqPW+bSBt3BCxxGGJyBRPVQmCJdMxrktIUIzjZdmwyyValqXvyWXzKgXpEIKypojs7ZIo1AHj5QRuH/MTRgGm4JnY+7p4tzYmGz9J7trozljkdcoVHAvfCyveG7rk5xD4uYo+frlvGP+c9KueXyC/LcQOqz55z57GAc7JhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=BZJJA0kH; arc=fail smtp.client-ip=52.101.229.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="BZJJA0kH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M/riy/EDiFr9kAkTN7sxJdJuaWP7q/deO46C1SEsTxpfki6ccm3WhX8N4ejW8CEK3vrlxu1qf3lAkN5oVRgycYFDqaECkFIqbZocm8eVZVmlwEy1LHCPyoSy9fkCZ4Az+rdChTql4DpEAq0fQ9bEGnp5y3D+QeIKTFp2BqJGgagZhOoZVWLYkkVdIcbE7shNOxxef5GhtA4VWaaaCjC4hxhoQCxlq4hzPr3kh6SRKkCgPYgubU2sEZCtrlqp9ia7P85RwixQsdPMdA6TwFVIiKViuqYTdB60PI0dDwuamVwgPPpvyYaAlI2wDiaci+e6fqxn1jd1CEK/PENFDeCMhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BHKcWWcQk/Bt3nR+ay2FTu4hKs3dY5sq23L5PT8unVY=;
 b=NS+39Als3v28/gDceWfc5cV2yCMXXivqNjM0W5AvijSKMyKNW6a3YSDjqZWiyXt7wVdSvSymtX5/YYct3c86Ys84OTNm77Ekl8OHZ9tk7WE0J/NAinXT0p5T5LGjLYj+SIFdVAA9Xlx2FP0YJBHsAN6tj8/+RWOoOwlc63JzEC9Dloudl/YkWZGb5wI7mW+r0Y/p5EB36+xjaHG6ODu8pESI5ITrCMzvsLZNe9a35V2sy9zOjvJUYY/ekSgj0HzvaxgmmKRCH7rZT/ASEYApWyiAZOKCBVavVHrmf0bmhD2B5ZQY18IuXw/aNBUBroWSoqawIVcmh66izfHLi2Vdaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BHKcWWcQk/Bt3nR+ay2FTu4hKs3dY5sq23L5PT8unVY=;
 b=BZJJA0kHep6KcKGEhQd94Ts+DjiA/g0y0WeHSuKOjv7SbnyeHgNQ2cVKlEeD26aWmgyAcoV5S4zpYwU+SG8E8kEqBSbxAZZeYS+6VVWcUWp4lxjw8T7f7WmnX32OPIECoBhb2FEORQnS9rdhwx/9hrB1Bs27hyHcZ8mtpuALYko=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB3805.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:243::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 06:49:24 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 06:49:24 +0000
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
Subject: [PATCH net-next v2 1/4] NTB: ntb_transport: Order RX descriptor reads after completion
Date: Mon, 17 Aug 2026 15:49:13 +0900
Message-ID: <20260817064916.13278-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260817064916.13278-1-den@valinux.co.jp>
References: <20260817064916.13278-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0206.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::14) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB3805:EE_
X-MS-Office365-Filtering-Correlation-Id: b183774c-ba69-456a-b6c1-08defc2bac16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|10070799003|18002099003|22082099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	o6zUTyJKNRSTyFHRFw5I70rTu4Z3bsjvuqaz5xPECWoBWIme8x/1m93BiWpCeAAOa1lHFlQqJ3253VtL5/wo3Q/LgMP6HegwliAW7V7ndhayfJZtnth9CkT7F8IgbKPEcoVkXrjY1uchLGmC9daLVrM4l6SB61aCTENB0aZezHiNwlCOSwH0ugFwvMf106cmdsQS+61uMuz6itiRwEk3BFZ70QeZtSgHMaiXR6DLi6wrlHaK4+SkSNNpJdVcSqqhhoWmwCnYbbJaK/VCDwoNi+/MjtnP0EKii8htG/eRS/PqQijBihMU3ySTn1Pgjfbgy17cLGkawFhZ8YDgj7EXutgaIS/alUmfKjM9KqYeX+2SG5VtSqJpTEqH/p24Ql1t27JT1n6xLaQkTpv+1HzH2Vj6OQQsJkVld5EZZpVFahwG+eCbTpbtvZwm8gvBBwLL5rA256dCrB5++QPPm9FZbaId85zh7FhwwO/PRrzcH7iiLVisD2yXSXr3vagnSW9Ib2eM+Dcj1T9NFA7fNCW6FtQPj8nWhXAzGOy2qsZqlJR9UniLcZEopO4XkZZIaqRJg0jW8Mo5xrpn3j93EqFGhNsOYyxJW63/BNGpONttyuj7+RhW6iEivqU3ZdwjqCMrFzTI+kejJ6NjN/KvMKwn/GXy8sjts8aLRhcAs2bzXtI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(10070799003)(18002099003)(22082099003)(56012099006)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OCEEQ1rvdl/sWnZUWp5Z47Z2AAZlLXjdmX6ImFoUneCfg6LrNhtxC+F+ZUhw?=
 =?us-ascii?Q?uIsbgOr4tMCu8RdEceiiJKj8BErm0yPhJhxqZZFppo9nrxMlcAe6jGOZ6yHO?=
 =?us-ascii?Q?eUejPdpa9YF2RUCeekcAZGzXURYfThaDOnCWg2nVsGFdM3RTLEXI+lajktMt?=
 =?us-ascii?Q?LzFYicnRta377K7qmn8y5pO0D/cS/LGvTdSJpbnu07Ctm2CNkHuTkDkZzGaF?=
 =?us-ascii?Q?4Jzh76H9NQHhgVAiem4uiNkSFoVlZwn2KWDZvgQLAhJ+90p0uG0bvQXE4szu?=
 =?us-ascii?Q?SJE3seLGenw7UuMlyKPZSOxcHuAYY6cmSKJQloSjY3pe116mf4mtQDOtxpnr?=
 =?us-ascii?Q?NGWzB0SIq6DDZv7ezXYmkcb3CGtfoI58Mu5QZ0iPpcLnSH31Yu7FLl4CsDcC?=
 =?us-ascii?Q?tRXQSZ0u+lx3jl0sV9xuDk7Kj+OLfuRpt7YQu6om9iv0Aj/XDk5Gb/DcNMjQ?=
 =?us-ascii?Q?uyhDRK8ysEzK/6awdhmgouCAdwAk06mPoH08E1QdNeYFkV5+ZCGcAlyy3M6K?=
 =?us-ascii?Q?xf5gQGrMo+civpwCTEPCBSSCTnVS0Bi63ejbZgsOiz1dXNAUAb46gb0UKxNp?=
 =?us-ascii?Q?FaD/26yXgFG4pBkmsKskReEUK3/p+jzialS952lAee1mdAgvOQaSaMFJKGb1?=
 =?us-ascii?Q?arXC25h8BgtNQbPNwKt/f94DGh40TV7sZXJoWYzWxKGm3DXUV0akcxyeGkdS?=
 =?us-ascii?Q?jbhGjPySogyVd0pNLnGBAlIU+0hzfLRlUHpkIPIh32UVyS3o93j/yMUBwJCM?=
 =?us-ascii?Q?N4sDyH6raaoZOIe+Ll8WBfQNwcg4s2YnKBq9Cj0A2h3izB2u2qGz0bYFE874?=
 =?us-ascii?Q?psiBNGhJ3yOP23sLrZgPegtiJgGMf4gis8F1ql3hPetJ0ghG3Hb5JWXO0CYL?=
 =?us-ascii?Q?EswyDbaQoaB3WZPnz+PCV64XUOjsrQqSxXKu5ykqi+MoyT/zluEbaTeCa5s3?=
 =?us-ascii?Q?17vE6NlSa+YzGj1AztzdMRffd5YEvvQHklKUeUivsAN6JOcIoCFdbvOmPQly?=
 =?us-ascii?Q?eDqIWiSAsGnW7/auY8OXXqZ84Ls8BV1d8Mx+vUNmFq0qY/FU/kYJGBq4Wf9a?=
 =?us-ascii?Q?Twg3hxsl7OoLBYFJuEdgpchpNXNwq+4FTdJECUIMFXmOyD2m9RwPtLMDpozn?=
 =?us-ascii?Q?F1V7ZXD94H8BCRpy8QMDNq2FxlkxnkjB7Q27/ouNq9bg94NhmT7uXlbc8J/P?=
 =?us-ascii?Q?ws/wpuNA5JRBYg806OE4TznJbGUz04Hmx8BUYViDq+QSCAQVpgOkyTiwypUi?=
 =?us-ascii?Q?GRi/b6rgTObkD0CdI1OHzskf/W2XyGwjD8nO9voSyLW1/iSwNJY/Zb8L08tk?=
 =?us-ascii?Q?K8YUIDmnhhH4i/WMqpLDd6XQmTxajR819vo9aYLVjMRDBdJjh0CbfZhOzeE6?=
 =?us-ascii?Q?wgk33M9P7W+/jDinSP6U0nVBcpI3qiH2LqOdc7iib3jQcRUlvafTJfdxZy7F?=
 =?us-ascii?Q?41qZx314yJQYWnxOLF3zw7Zax5vLozIaxeK4TSH/aIV02ramikzOGaWBk6Eh?=
 =?us-ascii?Q?mRFBXDUX9LHd0etAyBofci2VCbQn6WtToGTasmF8UQ0kg4ACzYpfTEAIEwz1?=
 =?us-ascii?Q?ND5e1H03ih9bHLyqtb5ghPGeFg6qGk6oL57VciUu53nHAizMkyGzyiI/Uamg?=
 =?us-ascii?Q?5ymRBD7vJj6skUrs0Ob15OyuTf4Zm0rr53KVSZTxSZH5M+/PJ4X0qtAGy5vB?=
 =?us-ascii?Q?Q3qlMSuS6DXuw7uiaO78ODPzy2gqpoIoCnpGBZr4BQNDlvtsN4cqR9zNCULX?=
 =?us-ascii?Q?8KbdA1/D0LnokBzKYnH0xQeQcLUVDHdJdORPXBPYPKC1kZGs/cFd?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: b183774c-ba69-456a-b6c1-08defc2bac16
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 06:49:23.4987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YxdCq/ybObGQ8GIgjTHqn9GJwVT3UIHA6+Avjk7s+msFNND+cKdg0pkKigf4iYPTNUpBJrG+RSExoMaCo2Seyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB3805

The peer writes payloads and descriptors into a DMA-coherent memory
window. ntb_process_rxc() checks DESC_DONE_FLAG before consuming the
descriptor and payload, but coherent memory alone does not order those
reads on weakly ordered CPUs.

Read the completion word once and issue dma_rmb() after DONE is observed.
Use the saved word for subsequent transport flag checks.

Fixes: fce8a7bb5b4b ("PCI-Express Non-Transparent Bridge Support")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/r/20260815032932.151F11F000E9@smtp.kernel.org/
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v2:
  - New patch. (Sashiko)

 drivers/ntb/ntb_transport.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index f59f926d4bfa..d458a8b1de11 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -1609,21 +1609,25 @@ static int ntb_process_rxc(struct ntb_transport_qp *qp)
 {
 	struct ntb_payload_header *hdr;
 	struct ntb_queue_entry *entry;
+	unsigned int flags;
 	void *offset;
 
 	offset = qp->rx_buff + qp->rx_max_frame * qp->rx_index;
 	hdr = offset + qp->rx_max_frame - sizeof(struct ntb_payload_header);
 
-	dev_dbg(&qp->ndev->pdev->dev, "qp %d: RX ver %u len %d flags %x\n",
-		qp->qp_num, hdr->ver, hdr->len, hdr->flags);
-
-	if (!(hdr->flags & DESC_DONE_FLAG)) {
+	flags = READ_ONCE(hdr->flags);
+	if (!(flags & DESC_DONE_FLAG)) {
 		dev_dbg(&qp->ndev->pdev->dev, "done flag not set\n");
 		qp->rx_ring_empty++;
 		return -EAGAIN;
 	}
 
-	if (hdr->flags & LINK_DOWN_FLAG) {
+	dma_rmb();
+
+	dev_dbg(&qp->ndev->pdev->dev, "qp %d: RX ver %u len %d flags %x\n",
+		qp->qp_num, hdr->ver, hdr->len, flags);
+
+	if (flags & LINK_DOWN_FLAG) {
 		dev_dbg(&qp->ndev->pdev->dev, "link down flag set\n");
 		ntb_qp_link_down(qp);
 		hdr->flags = 0;
-- 
2.51.0

