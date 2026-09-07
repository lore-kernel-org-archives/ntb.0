Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021112.outbound.protection.outlook.com [40.107.74.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460DF36A004
	for <ntb@lists.linux.dev>; Mon,  7 Sep 2026 14:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788791087; cv=fail; b=oesuFJSPiOnLo+H3AxsJiMPBTwrcFBYWD2OTtk45LdF1kEBJilXNLT9Ae8H1JERLP2RrQXWYJXhzpa6KY8YUl2H+o6+cUxQdu967/cPcrfdStAQ4VQHk4u4Y3tysLMVhzrZYr5ovjGl5iY920Ej3aBxEIMmL8/OQF/NDpRE8Y1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788791087; c=relaxed/simple;
	bh=aHg2EqpS2PX3p2Sb1vqaBeDbRTz9yKem8vvZ2g7bExQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=OipKAbm15Aqcf5vjVyY/zib1GrKV3D6Lg6IhfchkW7ytV45s8ZQk7mXPXWp4STcpKgbhqEyVsaagbJFyqR4xnfllRHM/wbT2+1nfbtemIHvv2Z8d8nVETeWT8dmIT8iW0ZePVjko/jSmBkhbqyVzLWtNCt1/DixFvbx38j3JEFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=nmyY3m4z; arc=fail smtp.client-ip=40.107.74.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="nmyY3m4z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YCofB8ZEwEeKwb315FKRRUvPfE6Ydsegzn0Jv0hBDQXlRHuWp419rKLIflmYdgG/q/UokfR2nYnkBqouuOqLthM3pGjE9qhMWS0b6uEkIpzHKuDlgQ6vIpVfmTbogocIoRf1Tz7T/k5JF8/UNpXpmxabHnlmvKTINe0Er+w6qSD8aFv+pd/8wRS7yn7fS/ARzGlPJXp8ArSoBVPsBj5OLHXxLYjrSg5D3s/YiyisyrBUhcgIfLABx38T2yVUt1M1NqOeUwZXYyfQ3ZURnEyy3i8yodPAOhs45P74pnvUqSVUzilH+XMr9dBcP6PVUX+lW38WgxCWuzzy6QdIyQZZbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u48ifcAFX7r1IhHbQVtkE2ZAEQgig2K2aCLc7LWFc0g=;
 b=JD068S5JLH1Mn4pb3MT24khz/EC1L2euniPLTk+Ggd+n4xKTpmCoFo4Fd8NlFA4mB+9TimZQrYnxBmsWg9huWgraEIrCLoylHzUUZgX7AX4nDVmu0bAnqJdyZpmhwJBcKqZjpzQpTbmcMtU9JoVDbDi9boyHPPoG6xkZCJJB5aqmlxb+kn9xMxEJeL6izhHT3dtk0CMNrOtymMsqns2WiIK2laGlK9GZFOyQMj0kqIczYGrpCm3AIFkd/fs1QhihP0U+hq0Dt8nJae+OZcs7NAknZyAUsX+f+c4skSzSSMNHRJ5C86qA+GB3QTt+inCVK8QEBEte34m3Jz5envE8bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u48ifcAFX7r1IhHbQVtkE2ZAEQgig2K2aCLc7LWFc0g=;
 b=nmyY3m4z/Mb+5uOjNriArFVjuRY6qSzN4RTobKVQUNgH6f4ZNNuCH7CnhhuIoFrNo6jiHYesWZrCh+Ny2GbG7wW+Ma/YluZY5Z8NLmEj/FDHmXpnQ9durI5j0EdxutbUu7cJhrN0NxovR9Ayaif46jorCPyVCS4fCYthEwiHOVQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY4P286MB7581.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:34e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 14:24:42 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 14:24:42 +0000
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
Subject: [PATCH 00/11] NTB: ntb_transport: Miscellaneous fixes
Date: Mon,  7 Sep 2026 23:24:18 +0900
Message-ID: <20260907142429.951930-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0262.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455::9) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY4P286MB7581:EE_
X-MS-Office365-Filtering-Correlation-Id: 27020510-32ad-4e1d-804f-08df0cebc21a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|10070799003|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	9gzFVYgH0NWAMjiNpWNm+aaLM6SodvV2QJY7escJi2UWy2ztQuCIRC9St9VpuAXxXzKHOth7n9WJ0uYS8sapkpJNWVgZ4dtA2Y07KoRgt2eQtKLTmr8D8gCaxfYz3LLzW3aQKTzUi3sBwq2roDsChAM8RfoVK4NGfuuBWUbzwTSpLHZnqsZ3KrJ4TUrA98Ximy8VKYmdn1aEmNqhwwyEHx6Tl1qy1f12LeUuxzaEiOCP2vEZoudXjCnJL5ebbe1QOKTQHzQRr2p3k5usQtpaC79RXLZyBONG2/J+3dxJt5mZIrTMNj+7U+tWjpRtencg7kq7SKkL2mwIB0Q4/rbRcZ5ZK00V1W1UdVQCiv/EDf7+QhFOcYK9INSs2lcNQoq4Hq4VnXIHhjN9PrCunIsrx5GMH1omorN3OL2xAEaOFaqvnxBCcj/oS101ugCKK4ck3ShZAzbkMSYIInEY+NeZTtBWJwpnboKwilt6Sa2DTZuTQo//IV7r8FCwC24aDRJLDxsrBx8KaZOt6QmG+RuAGXK+mePsi2+QBi2cKkW6stYUtd+qwjujZGW549ZYNPxzEv0g8I4YsGIbLO40VYXuQK95C7qr3zWbfXOhNJJhiP3h2G0dAe9QsitjIDd7XnO5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(10070799003)(10067099003)(56012099006)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XYFl5pZSTzeA6Ll7FhUzlDF4GyUihQ/UQCDnzwbHrjYzG9WmziOYIS1bWFPk?=
 =?us-ascii?Q?tgxvOxwkWng9zuS0zH3r1OLx3Y+RWCGC1Bmo+uE6PCk14QgCA5eE1WY79nfF?=
 =?us-ascii?Q?EQMnccKXSqBQ2a6ZnV8VEwO0jFYxQ5INddON/+ibqhl1fRl80NdWB1AP5yeh?=
 =?us-ascii?Q?nUuyEdzk+cv210RScLNXxk0H63xj+qkQay3bsz6uIjrS9fidbRdBD8kMsbZ+?=
 =?us-ascii?Q?lfsPtfM70c0TRyyZyL4KhjBrkEu1QZ1hTpmFQfAu74ABNcVlm+VVbqjWAl/B?=
 =?us-ascii?Q?Yg1YgwZ8N1UhaojWtbYJy113BOZlMOfLJP/t/ifiWw/ZusGB4Xeg+s9e20lU?=
 =?us-ascii?Q?wNsYaME1QoB1VXP3lR8HmSAn1cUErLS0OcAxgwjW4zExKo6wVG/uyzEUANMg?=
 =?us-ascii?Q?Ei9Y0SY4+hgFNz80c3BkU9ijA0YEA2eS3E04ytXAnaVTaEJ5yK9t1u0AwwIm?=
 =?us-ascii?Q?8JC91ft6H0/OxuSpZwW18MBK5tYXwXqpVR4IgxE5MIooGDdoGuyVnWP6sysH?=
 =?us-ascii?Q?yP+ZiL5c4pxZRsM1qNr1TcMVpiXQ4pDi+iHe+BrnvC1U3+nEfRRT3NFWj97a?=
 =?us-ascii?Q?qybch2GdzrOQQFl7REVB9v5MBWDYaDJwpWS+Ptqzny4TcXyhzMsToA0yMbh3?=
 =?us-ascii?Q?wGJUsu1QB3T+jwxGI1VoEydhjc21QSFpYlk7EXcB5N96Sj2CH4/z+vodJpdJ?=
 =?us-ascii?Q?wKp8r+SP50cmQcwFHn77oqLCXPhNQZdyXTEu6DNOMNq0iTaQBaeZAdMuMCyu?=
 =?us-ascii?Q?3o+mqZtKhFQ/KUSI3Kvdg1PU6F/rZ1RmsJl3hNFjqD1UkwBU+7oAuxO/armR?=
 =?us-ascii?Q?r4TctJVVbJIjDxRAJI8/429AkoRBc/YPcmfm/OvqAk2LdNsfHcm6L7bhYypd?=
 =?us-ascii?Q?D6pGGGR17fsFtT01MS0VDly2CRblrK+MZgLyk3DEA5+2tVfTdW/DngEecny7?=
 =?us-ascii?Q?GbGNjnBZlnwQ/27JctWPip5m7sywY0UjviJNDhQOEzHtRS/nncHf6zT7TU3P?=
 =?us-ascii?Q?SSHioVy61Mw1b1fJiKwCfxTlDkfKOfZsTtWze5Pv2QZ5krKJD6HwA8+6w1ge?=
 =?us-ascii?Q?E97/sUY06I5sXZrmn4k7L8ul+Ldrkypxd+57OOJI6heizaA80XAIi5WO/9+e?=
 =?us-ascii?Q?OrnnlgclIfxT2YbpqSziq5XxzexOAS5hOEXHr8znuqoVWbpPoD7YmgL+/uob?=
 =?us-ascii?Q?5xJS4kWtci1nEjqMyc2K8XJOK4P+x1ynS2awAwpJGNkI8O+fRUawlKCLq0UT?=
 =?us-ascii?Q?wrvtdzANXqFIp2bqDQ5LlQ8wNgSBKHlXuFn8cOY8VYft1BaTI4ZPqo6xWiUg?=
 =?us-ascii?Q?OdcEYCA9EHEkupHlJPHmsz7TXsAeKl144cmng9nTPNJvkAqnARMFEt4de5Ir?=
 =?us-ascii?Q?40OrUgMDfvon6XwzENE2jmmIES9ccXlpaP5P5o/mfWB2HWyt8PmfK4yoqAT5?=
 =?us-ascii?Q?NhPNwWEpiuSw/N+ZlDf4R0BBZLTxxD5gTnZFLVMjpHsRUKx7wEth8AX+xrJ7?=
 =?us-ascii?Q?oHVWJIAgbXaoolbklYS6vE0CsP5cfpCBBqAN2JoxJVF83gsdiFRX8YlN4w5p?=
 =?us-ascii?Q?cgIEPsDTyeUWaQxexjbl3fJiDoumrbPmTR1ZuhcXrRvqetOHhNcsnciy5G2c?=
 =?us-ascii?Q?9loGlAaPRgEkHMiqZUpJ/vB3Y9ccLRn7tUl4TMkdvsf2l8+cvHQh4qkjxmJv?=
 =?us-ascii?Q?348htrSd4uwNMooV8Zb3jlbjPB+iqAKEEuXMG/FO5Aw5zVV0nGFWUJbwmIlx?=
 =?us-ascii?Q?UQkwcE0Bg4nFA+7GzX1tQ+hzzsuw9HAEYnl/wuG9HQdawOpROhl5?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 27020510-32ad-4e1d-804f-08df0cebc21a
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 14:24:42.4224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2GeBkV+8NUREauZqGdS3bIW9t776KrWCj8E+NYCWk9e3s5zuD/I7SzkHjrlgLv/kGPFb50IcVnRb+oWD4D6kDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB7581

Hi,

This series attempts to fix miscellaneous issues in ntb_transport. Some
of these were split from the direct TX/RX series v1 [1], as they stand
on their own. Based on v7.3-rc1.

[1] https://lore.kernel.org/r/20260810165136.2292436-1-den@valinux.co.jp/
    (The v2 of [1] will be based off of this series to avoid conflicts.)

Best regards,
Koichiro


Koichiro Den (11):
  NTB: ntb_transport: Remove the device debugfs directory
  NTB: ntb_transport: Start TX offload thread after queue setup
  NTB: ntb_transport: Prepare remote RX info accesses for MW teardown
  NTB: ntb_transport: Clear QP pointers when freeing an MW
  NTB: ntb_transport: Avoid deadlock when cancelling link work
  NTB: ntb_transport: Publish link state after QP setup
  NTB: ntb_transport: Clear link state before QP cleanup
  NTB: ntb_transport: Abort link setup on QP MW allocation failure
  NTB: ntb_transport: Stop QP work before freeing a queue
  NTB: ntb_transport: Stop RX tasklet scheduling before freeing a queue
  NTB: ntb_transport: Drain RX tasklets during link cleanup

 drivers/ntb/ntb_transport.c | 190 ++++++++++++++++++++++++------------
 1 file changed, 128 insertions(+), 62 deletions(-)

base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
-- 
2.51.0

