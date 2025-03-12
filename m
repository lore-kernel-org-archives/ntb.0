Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C295A1F949
	for <ntb@lists.linux.dev>; Wed, 12 Mar 2025 14:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741789975; cv=fail; b=g7X0Pu8sAvMkAU3aZ2u+tkHpDhNOG9wLZ16qQ9u6HT+xS6cCWA8ZFoQXEptHpzUArGek8y/97YU7tnaG4DJDHbgA+LxEZsFHIfJc5KifnFlpVDlAfQsXbcrstWRY57h5FvUqwJX3Kn2FwPGWcx+vAueRSsMy2VG1JoYi7hBQHdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741789975; c=relaxed/simple;
	bh=fHQCapJJRiSB+I75VjYmIfCqUDipgbvAUIZY7H5OKlE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j757hZsRUkKcF180SXhLJrlqnMAfWKb5ETyoA4n34ARYXZyzvBVW7w9k6QG8va3VF9PPsrewtA9a3Om5hyPAEIihZVRMVP34njCW9yqXZtOTz0oGQy/i7K1RYqubbob4FV92ePcE4iManZwUSG1ZT5NEHO8JbG51Uuwr7GspwgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MICdxOOw; arc=fail smtp.client-ip=40.107.236.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MICdxOOw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UELDW/cWaOKRQ2slMK6QEzfSXEXQZdQaZq0qXLKY5+CaPNeb/gJPOz0CbxhVBUwMAWHFt9pURESgWTY7ZIQVRopY1G84i9SaNppO8bkYedIkO8DDEUD3LtWdHe0aVMMzpURyOfHr7hzU20C/aCcFT9XsMqZrSRdGo+kaFyeXXvwAqcUrt+vidQvd64C6NgKPKSpPBV+LjeyuHcgse6c1s/JzNW1H2uPxP1pwDFSNqOtX7pCxluUBZYVEJh9fWCqc8ueRmDXp4swKYJ+lPlWfQkYKeB0HprBJBlQ1o92Cgi05mvlTBAj5rkf8vKAukMFk4QW4VuN3/lshq7VkDyazGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/kCcoxrk91T9AYJ4HGe3YYnrBIkA0v+2fThSjtWq4Dc=;
 b=Mb+DYqi0DaWZWPQ3l9AFfriVOWJiOjVnVxIlGxV2TBtG1uNbtPYXoDolJ1pcyGQCU4tlorf8h99wzytYrjPVLXxC4+i4r+jWduSGYPidtw8PhEkpqjO2dvY9FTHy0kS26RTDzj/G1SLNAW7N7j7yS+yro7IJGh3aV7Ih6IRke5y7/6PtROekwhLgSu0qnv8eGhX4DQlt6InYHW1BJ8ppxslIKe049qQeIMR8gaq6kbemBvj6pmdFyqxzoqoga8hmuM1MLt8RLYBFVXrmOqGNnGsZm6y6DDxWsHu+nnpgDc625JkcHs2XH6iuf0ZSzDN5PfVyztvUCBMW+DkbZ3QB5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17) smtp.rcpttodomain=kudzu.us smtp.mailfrom=amd.com;
 dmarc=temperror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/kCcoxrk91T9AYJ4HGe3YYnrBIkA0v+2fThSjtWq4Dc=;
 b=MICdxOOwTiDVCrny/rN1dhCvgCDKswLYFoaDPvLJLxk45MGKdoM58aI07oAhvC3IwEwfvtfDle8Ukayx+iLicm1SOfSRfBhQru+LqWIWYygE3gM2WK0Wfss1Yp5GpRTbhASPTcEtvY7Tg+PDGrquujDFsYCR0eK1i1Mbjc9qdz8=
Received: from MW4PR04CA0127.namprd04.prod.outlook.com (2603:10b6:303:84::12)
 by SN7PR12MB8131.namprd12.prod.outlook.com (2603:10b6:806:32d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 14:32:50 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:303:84:cafe::f1) by MW4PR04CA0127.outlook.office365.com
 (2603:10b6:303:84::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.25 via Frontend Transport; Wed,
 12 Mar 2025 14:32:49 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 12 Mar 2025 14:32:47 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Mar
 2025 09:32:45 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <Shyam-sundar.S-k@amd.com>, <jdmason@kudzu.us>, <dave.jiang@intel.com>,
	<allenbh@gmail.com>, <ntb@lists.linux.dev>
CC: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH 0/2] Updates to AMD NTB driver
Date: Wed, 12 Mar 2025 20:02:14 +0530
Message-ID: <20250312143216.311011-1-Basavaraj.Natikar@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|SN7PR12MB8131:EE_
X-MS-Office365-Filtering-Correlation-Id: d7d4448d-f207-4229-8c31-08dd6172c2da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9QzKCqpHymvpnzm2go5nehn7PC242yLXwhbPZVfSbBKKeSe6+zPZukvVd8Yl?=
 =?us-ascii?Q?sqdlmp1d/vTKTnCkhjC7Stz8u1UjSUY0YsNKEYIo6axg3QRN0IIcZIARiAnh?=
 =?us-ascii?Q?qLBT2u4oeKQrvjKW5hWF6JpfGUab2rOjq3HbbkCdtZlmBacTCm8UkqTrWn6o?=
 =?us-ascii?Q?P6uw3t8FlArKd9Ng2JhxD5UDLv4V5IFmFudXOHBQfamT+R2gEwfhQWxMT4Zi?=
 =?us-ascii?Q?AlnsRr6SE0KSdTcS+5co2sHe6YabfLPkK4GhoP3+Qfb9K3vZHeG4IzBHihSQ?=
 =?us-ascii?Q?vHETVK/6LlubhRwOEu9u52L0RSe0zqPT/gEU7EU9JgtjwTEmt4N5WNjI9w6f?=
 =?us-ascii?Q?j+NldBniQT5XjkX1cg2xede+kXb7qjjzbuTKzuBHaahATCJTsQSXkzsOSvjJ?=
 =?us-ascii?Q?26KMgLPzIFzYCGI1ezBiTqIecA5UTM06/BMJm0ozwJsYGZvKKcunwXiLGeRe?=
 =?us-ascii?Q?PapJ5cqzf6Nmlh44KfLqdCiSjxvKO4ybpfUGHORXkYINms1gtKXhYRGKqHt5?=
 =?us-ascii?Q?SSmn/PR/xESjL8UPkFHRnVX4DXZmq+33qUkX+mrx+dBYMKKkhTicXXqCd4Ad?=
 =?us-ascii?Q?VVq2xGjBuCcVpUloioNQ/jyl317ZHwsUv5Gef5rpCxzYjeSsS+5lXsaZTlIz?=
 =?us-ascii?Q?G/wALiN4sXQ9Cl2/dk8F+6jbsP7k/xzDiyzridXLX6Gkvyor4OyMVSsqJPSt?=
 =?us-ascii?Q?bc6kCLgaRUSHUPvFtH8QVjF0iLsoAhdB0Jxl56xZP2O8sH2fsIHte2s4H5hw?=
 =?us-ascii?Q?q4c5tyeVZNN7cNYFvMqIc+TxXFksAGJnYbJI6EFGjMXsslt3M4Otcvm+Sgv1?=
 =?us-ascii?Q?4mlB3/59uoTctimh156xLUSUC/qB0xuCIwN6lSQ+Sj702wBqGHUX2LsCD24j?=
 =?us-ascii?Q?eW61eu0k2PtYYxB8UsPjNLZgCijl/1RBr/Q160wdi8lkg1NWKs7AYVwOx28r?=
 =?us-ascii?Q?OalMgjth3qLKq6qMtX4cNjrWtUQ3KQUrgiKk+/nL/tQz+4IwNibo6EUR8kZo?=
 =?us-ascii?Q?ZqOMtn3lWcalNWnQ9bIC2bmbt2xxpxxzmIOGytAJmqeQGtLhL32Xrbb35AfD?=
 =?us-ascii?Q?6Xq6JtLht3z1idBUNDNK1ek8BA5Yi9+GQMZOkCRjLjYLZI78mqW/rDZxiKqv?=
 =?us-ascii?Q?Q2ulw3fArTkHLTw8QBXczRVaQJ/tPSas7PZzAd9mUxJXvYSp9EnP3KRYIWF3?=
 =?us-ascii?Q?qHyaXZodlu4QOVgt53N31bU9r7mtYSu/zD7BEHJP/z1ejYzcCaSaxtYP67nj?=
 =?us-ascii?Q?qepqX6BwQmal4K4MZr3OAxMIB33dXJv0LJtu0ywAnoHyHJ6Wf2e1NwRcFdIR?=
 =?us-ascii?Q?G+OuRk2B0Xtl4fFApQ7Q3BxffvCOIlSuEx8iCLb1LLT+TrG0dLZ74DMTDxXg?=
 =?us-ascii?Q?jQRdEyPRDLUqGwUejKUBLZ8fKz43c+DAJj7tVe4LKwpgX+H45ss8+P6Rvn5F?=
 =?us-ascii?Q?8CR0XpUtjGK+gOtTEYHNXeQivVc8UjDwBliWGDb6deuEa5svhut4C/U6SGDN?=
 =?us-ascii?Q?MwmMSEJlrBMdoYE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 14:32:47.7090
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7d4448d-f207-4229-8c31-08dd6172c2da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8131

This patch series include changes for:
 - Change in NTB AMD DRIVER maintainer.
 - Adding a new NTB PCI ID for new gen CPU.

Basavaraj Natikar (2):
  MAINTAINERS: Change in NTB AMD DRIVER maintainer
  ntb_hw_amd: Add NTB PCI ID for new gen CPU

 MAINTAINERS                     | 2 +-
 drivers/ntb/hw/amd/ntb_hw_amd.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
2.25.1

