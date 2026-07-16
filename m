Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013049.outbound.protection.outlook.com [40.107.44.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1682C0274
	for <ntb@lists.linux.dev>; Thu, 16 Jul 2026 03:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784172432; cv=fail; b=n5t9mQFB2xyoMo8chNL1r5z/R7z5bNiyBAknnVuWpLvJNAFnl5t1mp6Zxf6QKgFQy74eKKSUBkgEAwUTXvgOreu/q2yj2paDwhrKbt1U4njwUDglJ0hoZO8Rcbr3SBIgZ0uwYg+rhWuUW3I0WwNbHnvyMduQl2lrClPTL/a7AiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784172432; c=relaxed/simple;
	bh=Z5ICdKAj8hJHIydHqkdA1+d8SEeFa5+yTOxUTywv7tc=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ERnXvEKqipsPnOL3c//kPP3hT4ICvv9QSt5c4gXiyFhx+DdFGDRyf+GDQhzvcPpeXKWlJ2KmVemEWf44cQ5GhOQ8BaDEfhRM2gWTB2CYnjgJY7ZDv3gcTeTjvVCsMjGO7NHmrcvAkURNcOuKHG1eM4TTCYnR4e4ZZEabf39fkPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=feKooUta; arc=fail smtp.client-ip=40.107.44.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="feKooUta"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=shEejCQ4+Hbnkf47UKiAY/M+Xkjg5qB9WckPInVLEcmVLKAlLskvL0vyxblOk2WeD2YwbACWjtcbzShYmwQJvvWeYUo56SH+P3oJLGKPXOwygyIRQa3CB1mXV13yTkh/AzFTgzqpZEZOe22vxxpfOHWO9fRc5kT2Ur03MoZmFx2XmeZQHSG/0orit4aYBRXcvBImH3T6+6eosIibiKk6DBrHaphf9NRZYak5XvWuj2inwK9Hiif3+BkDFTB9KROvLhXoHeJin21x7nr+rhbpjgX9dVbPckIARTzD6WDabvmzJXX71Zj9HQDZVpcEZ53YShqAhG3cpPz4Hl6YJncPzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dMFh03yWEQD3k7tWQ0lCdf3sjEgKWNOctD7LpoSjFWI=;
 b=HH4awWpM/A05M86MB97+YKkGUgjloXvs0a3W5rOFrug7WmrCOTdkxofyQlFVgOAV3iAVT1tWqGgjI37Q733DeSL7AVgE1B/o9bMDB5E3xJBiAZPas8yJ2KFG+YIEZzf6AmfdAgV5tA9I9fJLWX9Qh/qH54b6QGey4AeJ3M1dft5v7Ic3Nuo8Xb9i2W3siuMUAidkFPdZoNeMxIejh90oBMvrmaQr4fmSkCrvwsWcgCXNbhxDE9lBJgciZhiBcVziTVhdjx2/C81UeLAVU9E5CX7yDi8t8GHArmkaZQ2QfWCkAA4A1ewmx9soq+7eiXr59nEFy9WV/qzlaKTY8dYUkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dMFh03yWEQD3k7tWQ0lCdf3sjEgKWNOctD7LpoSjFWI=;
 b=feKooUtaKML1I8j7QhfXJhivUgA5dp1pCIN4HSiFAJ9QgnTEhf/u4nxTTCh66MzC6wAsyqolPge0+G6XnkVlzec5v3N/LazSudCkIev6AebHnV0eECSjTEfidRlR5bc0ssVc7MkwVcyLmaf4gJmxD5xJ5tQ7gPWVJDRIvbBObH5LLZ53/ZRvzT2hfiEl+4Mtp9cvixssSwtizpcVkXMLSSqTcoZrL11+9xNJtCsYarzIguXoWhY6zmY/WS42i1Oo/dacpvjVpxbVKmw2+QrIdvcJX2NBZspi6fTcy1U2/SW4dOLtg60uECzzdTCsqQzWbgB6XI+W9FTbR+EMDw3YTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by SEYPR06MB6033.apcprd06.prod.outlook.com (2603:1096:101:d7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.20; Thu, 16 Jul
 2026 03:27:03 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0223.011; Thu, 16 Jul 2026
 03:27:03 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Pan Chuang <panchuang@vivo.com>,
	ntb@lists.linux.dev (open list:NTB DRIVER CORE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ntb: idt: Remove redundant dev_err()
Date: Thu, 16 Jul 2026 11:25:44 +0800
Message-Id: <20260716032547.181804-1-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0022.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:5::18) To SEZPR06MB5832.apcprd06.prod.outlook.com
 (2603:1096:101:c8::12)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|SEYPR06MB6033:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ca99082-35ac-4e58-29a9-08dee2ea1aa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|23010399003|1800799024|366016|56012099006|11063799006|6133799003|18002099003|10067099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	On/ZbhOF3S7vsNZ8+OqDHPY73c52O74JavBpFOT4aA9kLyh2m1mmBkyJ2P3hBQuYPEar5pV/D859sAhOOVjA2Ns6Q73gNfbDpj1GqTeBUrS5NuadW1HNV/klKY9aw+6pKrmhBuN8Ukya8T2ZidpDUxlbUPybBePxmE/717Gdfek3KSMCF5BGw1wRxnZNojnvC5cG9yHuJ4MEmTLKoQX/SpWRCdW/AdLu10sIIdSeXcz3Z3oUPYy5z7pdGz9FtymiDq3QwX/+IL7uT2Tf8vOGZPVosGbJFSLv4g/XFUVTMffvMQejkk5rhGo9Y1hUpqMtfPCZreBR3eBOhserdxbvEzkKdo/mhZkaPMHjbgMc0xhSDCLRITtxiuWF65fdwJpFxuXwptvJoJzxB4GoWFSxVbsNqsQ1R0CHJl6fxz7IAoUENVw0kViBXCwOZSmkIlGdZEUU2EvVyuRoXa4WDy0snbndUk79F/O6ISyQRz/B+gBIgDI5dlWhD3IqEgzLoJyFhByw0KXlzP3HAHkHe9IsYtECa1qtSl0FdnIDsA+EdbpY3x44562fehRlVduqC2llcMoGq5pxw2vmQI98fB78+aqF7RfPQxDFDNI5D1E/cS9Ayih+yyneNtkKOwrk4mlcOo11hut0WszkJNd983kY6uzB3Rlhy0tw6N927UsHsbJ3znT2YZYT7O1XZ+kYpVAs1jufl3iEfKNrdaSSTN0cY+TMooPxgrzydmiBsc25UkA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(23010399003)(1800799024)(366016)(56012099006)(11063799006)(6133799003)(18002099003)(10067099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X70SpW0+H85YQ0gABZh9X+SZ3xPw7LJbzoaL18tGjyw0jnWQ14ioPmFyWyOq?=
 =?us-ascii?Q?nSp4mQdPMZJXqdfAbT75I1biJSgsiRn2SRHm7o1sllib8lzyXMbU7I0yhORz?=
 =?us-ascii?Q?1jJvst6emDIG1L3sGo79CQkSP8SiP1OfGR+2xA82FVzz4tBE7gBpLz8NDwgU?=
 =?us-ascii?Q?IhsFhQYYASBzc3lbWnfdh9jJWGJqd0yvO7GhNNnzOdDvT2x3ZcykSus/2VcT?=
 =?us-ascii?Q?ZtGLzAx5ud+9A13y3Z63mbH0K8goAP/u266guT/9WpTHouFhHOgiJ2jJLfPS?=
 =?us-ascii?Q?DeRBWFSDWUl6iow0TCfZwMPTydyDstmibld0R4qW8kyY7p9nmTsQdKKJoUtR?=
 =?us-ascii?Q?WMr0NTtJ6QcWjyIhEQtyUYtDNyqPKUW0/MZ86Wa68vCq1NUh2JCPptwGKarR?=
 =?us-ascii?Q?eRuPniVL2YXRKP1y1FesJjYHjl08qQd45djOKQ2myGLLlqyleN4FZjNC8ez6?=
 =?us-ascii?Q?6ItHNXWSOYXRFndRj4n7Hf+kYhc1Y3bIJrqZw9qF5jLgoZFxESWFrmkI33t/?=
 =?us-ascii?Q?z9Qv07MscyxNb8BNWAVCB7his2xAfB1Zzz4yBy4w7ARD5qsMwRDKGk1t5Jdj?=
 =?us-ascii?Q?NagCGwshH7RxaVyNGlE3mxRlSbhMqLwQqo7BANC9jKjA+wn/Jzr5XAxcMVks?=
 =?us-ascii?Q?XOvb99ECFrB8cNo9px/XF/uR83cAoyotZTQHFyFPs+Xk2dC+COsZQOm6LinD?=
 =?us-ascii?Q?8LdIHqbVzzbkjD0p6DZAskzN9fFhZ/bCg+5QPKdiT2AIoBquElDuMYP40vL1?=
 =?us-ascii?Q?BFzapQED0ITbEHJpwa5T40CNnDZE9T1EhTkn8UOk0p1IY48Ow439W/+8Qyqi?=
 =?us-ascii?Q?3yBu3FgbshXEQvmWxpfYHxceshk73rrDjqjfNTc5poRN3+3EFsTjH7oz/Te4?=
 =?us-ascii?Q?fwF8Vjh4DEHDwSGiv68e4zFTE2RgaIUHc6bFXiMkfDDDdOQX7/KIp1GR34x2?=
 =?us-ascii?Q?ACp1oyh58I1Is8Jirpm5eVXekIT86d+2vfBluP/Yt3718Nt/8b4eQUrPtASi?=
 =?us-ascii?Q?3+vOkYOfPZmRW7fszlbVSSMcULtxuHL5xzR+GMEyka1JtzCHJ7VralGKpTUX?=
 =?us-ascii?Q?vvThqaTMDQrxJioEitp2bjOfl5w/q5xaUM1PhLmLyzbK3ad61/Mlu9tnxrVH?=
 =?us-ascii?Q?dsnK3c+d1dM4T61POXp1rZxfNnQoVEUhlo2fkx2JpOWnEkSjcICHwCnI/jUZ?=
 =?us-ascii?Q?mZcI6uoTJvYa83fURCYtYqA9eLE/lb33q8s8pyYGrufkmFSfiv0gqT/4T0M7?=
 =?us-ascii?Q?u16LXWDyMGCc11ETHEMbAlzygal3lmGQ7JWE82Hg+U8VVmhm+PBf1nHn+Iay?=
 =?us-ascii?Q?CEDgVH3WiTVdOpu2FwIwKLBl7/wLNJuKyQAH+6G8RavN1VFKvN0JIc321eOK?=
 =?us-ascii?Q?dHR6g2q6LLeFthwwWMCUfUjECzm98Z7wJZeIlX0fyWStrk8w3YIIPfhkw33a?=
 =?us-ascii?Q?uLGKOYzXL4rqV/wQxTBfi9o8pwhDOEcfKttjp8qq2+YRcCw95n3VMpUiO9X3?=
 =?us-ascii?Q?IQlU0e0sbD9EEr9POn51s+nEH+omry05q2yS3V7hI16Zx7nj3pUf4bnsnnOe?=
 =?us-ascii?Q?XkLO0+OaNx78Cyp1p2aMsFyXaZrR9qxXvmjWhuGVCgeoLJ8jhNLua/vSPXIX?=
 =?us-ascii?Q?tVkeatYJZc2OrLFg14bv76tSTsCkXHJt4PnMzOHnktVjHVjT7arjuW9FPNg7?=
 =?us-ascii?Q?VHsWuKsN3gPUnluKaaZRVluaY9zPAALD0ynoyRsu8GLuXk7cQ0FAWFGnMzVI?=
 =?us-ascii?Q?JkfJeWgzpg=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ca99082-35ac-4e58-29a9-08dee2ea1aa7
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 03:27:03.2885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G82iqr16XJA8aGfApVJNAiB7DObnci92DgNdTuXAX6XBxZKp+01pn9ZAb5QkEm6MlKWi6dR9DTRlifMZwxmf/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6033

Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
devm_request_*_irq()"), devm_request_threaded_irq() automatically logs
detailed error messages on failure. Remove the now-redundant
driver-specific dev_err() calls.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/ntb/hw/idt/ntb_hw_idt.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
index f27df8d7f3b9..6793f7d4fc62 100644
--- a/drivers/ntb/hw/idt/ntb_hw_idt.c
+++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
@@ -2141,10 +2141,8 @@ static int idt_init_isr(struct idt_ntb_dev *ndev)
 	/* Set the IRQ handler */
 	ret = devm_request_threaded_irq(&pdev->dev, ret, NULL, idt_thread_isr,
 					IRQF_ONESHOT, NTB_IRQNAME, ndev);
-	if (ret != 0) {
-		dev_err(&pdev->dev, "Failed to set MSI IRQ handler, %d", ret);
+	if (ret != 0)
 		goto err_free_vectors;
-	}
 
 	/* Unmask Message/Doorbell/SE interrupts */
 	ntint_mask = idt_nt_read(ndev, IDT_NT_NTINTMSK) & ~IDT_NTINTMSK_ALL;
-- 
2.34.1

