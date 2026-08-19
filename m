Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020072.outbound.protection.outlook.com [52.101.229.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F2D21C173
	for <ntb@lists.linux.dev>; Wed, 19 Aug 2026 02:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787104856; cv=fail; b=dgFAQd1xwRLvlpGIccqbesl0xzmFMSGyhyQHqVAHB55QgnObKLFQbpabRyvz7KB3uwR/1865SLqVDOgrw6yI7NWfQPJ8LTWJ8p7C02qXj9QE2CBr9eMuQ8EDE+dAnk987qIVdHKt1AyB4/qPUl35jmBtTc3bdp3jvKnD5N9drjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787104856; c=relaxed/simple;
	bh=eouFC8+O5f9WOltM3ivjHJPgXS16E12ntHtOAMcg4rM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bVYJX0nWHpf4QePRsAThRTIrmvsDwOpuGblyVHFSeDRDRZm1d0vGeJ6k4BHtyzgfSI5+Acu1JuYStbA0l9LzMukcmZxV3aI4isUf8AsnV4b/1DN1KZcYKLOiDYp1mQUJNTFEvwZ/1VChtS+yu7lswM51TprdejnzJXNlO6bbloM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=lLJ+3Crc; arc=fail smtp.client-ip=52.101.229.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="lLJ+3Crc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V3wF6HI0P0BRmWl8RxCnQgr6GVP5Zcb/buJgeUDeZDRc3hLg0etxVlBImbC6HIwBMqQtn/xeqXlnyj3Yo7DV7aXzEdJeJcdgm7nl2FSHT6z2IoKVJHKWvfb3WtHgZ/6NDTEcgBTSORasnF9ku/0N/irQUQhN7UfSJCJBZpH0YlzL4ryfeDb9hcq1YnVfmtXbMxTmAZMj48bskuzZyOpAKD/V2Cz9Y8BKghRyXxMEfe6dvfnyj7ePv+nHAHHkvwjwU6z7AWdBJrYwBWFjXv8yZz+auUNpb/piPsXgmVLGm3d9TCxvfCXMzyQOmsFcjwcoiqjmNPA6Glxutsn97cWJow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=owxsTs8PscSPTz7ieYRlwLM7Z+cgHuIsWZ66NyZws84=;
 b=y/tlT04RDFH9OXoKJE3cDlUG2Ffl2Es8g2Nn8h3ESTw+8wvSmvLygpsUv3xHTuj8o2HmBMbhNO6uwR1fGN9xHlkmyY6ojFh/2RyU5XuzGWTLbStE+pe/l6jQGxNrZ2s8JWnKDYct/S8ozF6LO7eI1g9bJQmlUya62qTQYdvp9QG6t0xxPdmwqU69pWfKjwrSIalHg7/m8I7QpqmvyBLrOi26eyghO1LA93gvV48IlYtxlr/o1bb99SH5v84+WD+bwy1n6nOxZKCL1IsGx81tRA4jn6ripzvhn56Di1piQokZ0BmmLElIbW+UyAzpv9HOxXEonvXdcDb/1D4wrc45Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=owxsTs8PscSPTz7ieYRlwLM7Z+cgHuIsWZ66NyZws84=;
 b=lLJ+3Crct0cY6DtUxJ73VeZQjZFbTXdLZv93g7ByXxRKDpQUuiQzZ7Q84o6eSpL/Efu1D/1jsFU88cXHDmuWQuPinzD1/ZWKuGDk1LL7w8CtaXTd2OsnWq9MR5PyMqLuYf4fB85XE9JvuzvHxXnqwQWrXpCUpynxBKQHjay/+Eg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYCP286MB1900.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:101::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 02:00:50 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0315.016; Wed, 19 Aug 2026
 02:00:50 +0000
Date: Wed, 19 Aug 2026 11:00:48 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, ntb@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/4] net: ntb_netdev: Preserve checksum
 offload across NTB
Message-ID: <cndgdmowjiajkwafchxes56fifwtxfxd5bfn5crns73tfm53k3@d4iww3kd5osb>
References: <20260817064916.13278-1-den@valinux.co.jp>
 <20260817083925.045c7439@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817083925.045c7439@kernel.org>
X-ClientProxiedBy: TYCP286CA0140.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::14) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYCP286MB1900:EE_
X-MS-Office365-Filtering-Correlation-Id: 76ae3211-be47-4b8f-6410-08defd95b1a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|23010399003|1800799024|366016|56012099006|10067099003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	CD2uAW8pOzFGyoceaKaNtiDoazZh3ke0fBWehn8h4d1Z42gN0LCdFDLNuLUfKvixaR3MkgUAcYXLpwNylV7EMPrWDwIkthXhKfXV/GaSV8437mltW/n6osn6kLfiItJExBBrAUTYZ0+ZUw2yeyBa2dM5sPwzELE+EbDMP9XcErw+bd8h4PKJt+0hH88dRbxxDXUsteEck9PsEXf7jmTf7HTno3sYny5a9+vNfCNaKmX7Ll9/92m2stjIlKLCF24vJJ7/4ErWJOoLzP2sQP3bRDr4owc90GM+A99ieQWW7mhljwQFKhCixbrUV3XuTLkZhMdM3HMjXRcbr2szGKePtk8IP7xGSinvkbJxvkutuNJzVrXaC99RQgykYXhjSfvlpK03c7NBJq5eWqPjxCwfqr/ODvwmg2vxlukLfMH0YKJfyQO1ygrrH/lxrk3OjeHYyUzKsa/lMxYwdrzsIsMkp3fk8n7lQbUkO2e2dHd80B3/TPNRUlZfBx1Brzfv1T2m1eKysqklzPsfwLmSQ357Z8Ewr+sg71tC8RBAqsBMpwTadZWN8In7ZrG9gRK+1UJjwR1Dc1tL8lKGzuNovRU/t9rrL4zQ8LzGOYW+Z9+8Q0yqvFzZWUhBtQ9eDef2NTEK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(23010399003)(1800799024)(366016)(56012099006)(10067099003)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/sLrpRLJ8MdOTC5Eu+k+vcgGc3mS2Mo5orbcXuBvgwaqr2h5ogZDPBBWYFm2?=
 =?us-ascii?Q?VPBdZuXh+K/eU8UdlZ8XW0TVeDhL8HcMAINRQHRblWoTp7PooaVrBbjwUZxF?=
 =?us-ascii?Q?6leAjbfuCAhSa6sKgFCcCyTkFxl3NLLj6YXqEh9KMm3/iMMfmRf6E1Kcelt4?=
 =?us-ascii?Q?MTdh4QbazmSBOnTYpoUF/luGVOqx2U/GCOY+Eg2BHzVBKLN3gsI9cl6cmiQy?=
 =?us-ascii?Q?Tc8uu1ONHpEI8YB9a6ujgABMD3KKLRnZo0FSu3tRLqLycv4OyDFS4s91+G3B?=
 =?us-ascii?Q?eAwKiSzkk4iZnASzaJvGnYbI87xa6H9UDVGkzMbgV3gi0dalOkI2rymqSEDd?=
 =?us-ascii?Q?E7pTbHfB0756GzbYPTDz0fFJWR7jiJlQAJss8sj08zZDoUolGN05sZTWs5XE?=
 =?us-ascii?Q?EVqdfVBvTOEfe7Vi1h9pA3k0QNDB5rwzYrxbKL1SDcuSPYRhWJA5jfwW6VZc?=
 =?us-ascii?Q?qzfb3dQSiaEzQ4IMsoLSKZ3mDzXEFk7nzB+UUs/bNEIJBn8S/ddsFsZBipYu?=
 =?us-ascii?Q?OQmBXvbMndxyMAMtz2P6bosvs4LelKXZrJ2YrdeR0FN8p+1jJD+DtXUh3lrl?=
 =?us-ascii?Q?O5h+aecem+uFf/ubpL17WOEkVWEbMCTRSlwmmRT6vRaGxO0UlatdpcLxhZnj?=
 =?us-ascii?Q?k0LbChOOPSo9A1rm8tleUpk45lusCJan15xtpDWcttKKLDg9/7j9Pk1hCdk9?=
 =?us-ascii?Q?J2GrCjzZgLEyZA8dL89cReB0MbJ/SMelZIxJuLpzsQjuNdQSKjFdOQEXMDFE?=
 =?us-ascii?Q?9ZwsGAcVtcVR48Xp+2cDH2RpvpK76yO2DbQJMITSaD8DtkRKzIcyWzot7zWl?=
 =?us-ascii?Q?5c2XqrYCCRhy7LS9qIFvk0ZTgcQz0Da1/xin3m/sDFsdFL+96fDIQRtTf/20?=
 =?us-ascii?Q?oLJTwCZkayqosui0AJ8coPEdckxvdroigdBJhyqtNnre5eAHv/wsw26QeNm+?=
 =?us-ascii?Q?yw0z8B9n34L+ThU98N3NR0PEIboQZyBugUbAUWL4ACI4JCwRkKBt2xsYaCdL?=
 =?us-ascii?Q?o4RlKUF194UOgPjttqsrebycIv4J/LwV1ezpD7EiCBfNxf87pBVT8ezmwtJn?=
 =?us-ascii?Q?k1GCn1vV87upIMTEZGIFPMUZEAHyOEs+NgSAgSUJHhKlQDs7TXu9K4rOsU8W?=
 =?us-ascii?Q?Gld5ZubpeDf/YpcI4E2pL2h4fI1cplf68SAjyGBJXPX/us/30EsgnpZwqei+?=
 =?us-ascii?Q?3usRkzT2R8aV+2pZdUhZ0RF1REmdAjwaLAUnEusufuf4W1D/7PYAFNITXi78?=
 =?us-ascii?Q?0BSG/o+J40/tnPArc5lpfBMY6YDA126TxxLTMiyAAnOhFGw7I3LwMzEuXDrh?=
 =?us-ascii?Q?BJU+fCuV+QdgNLmzbfwIdXKjKe1nUFuKyPIl8GoJKU0QRm5lkJ+o/ccm9yLh?=
 =?us-ascii?Q?1ttWa/I9LNFnzXb1osC1lURJoFQnmZqbiGegGgIuld5snz6GBEjxDRBfaYHY?=
 =?us-ascii?Q?HxDbobsVsPdGdyHraP+fef2tZhGqO6HJgSH2Wn2HwoYNFFLU+Y6JiZfGoag8?=
 =?us-ascii?Q?Kw83PE9BydM6tSvRvU8dOgJ9tWHPNFupwEs68HvL6Q0Um1i424E7Fzf4ZGZQ?=
 =?us-ascii?Q?SvB/T0yUJuVGPCvDWyj61kASoQxaNlpr0CljzMNfWeSzJ38/4VD0+GtvU8Xa?=
 =?us-ascii?Q?ofEmd9w5j6ZymATR5n0/rv38mZvKaD0AB5BnXqUxOjMfB7BQnIU+EbahnIWd?=
 =?us-ascii?Q?YkTQAZXlEwbCsUksGe2Zkk1HvXO8y3Roc4BdWXhMbzSjZnzAK48pwOPiGRH0?=
 =?us-ascii?Q?jP2h12gEDbT5ITaWBK/X7SpD1igEEEEyjDqr2eTffQ9kS4Fbqe9w?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 76ae3211-be47-4b8f-6410-08defd95b1a1
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 02:00:50.6499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fq8N417Hdc3aWb743d+7CizisdOe/CI/O+2EAM+IaOGBImhUdRYDAL995zROdoT72Gwu5JOrsYTT5NtmV+p22A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB1900

On Mon, Aug 17, 2026 at 08:39:25AM -0700, Jakub Kicinski wrote:
> On Mon, 17 Aug 2026 15:49:12 +0900 Koichiro Den wrote:
> > Subject: [PATCH net-next v2 0/4] net: ntb_netdev: Preserve checksum offload across NTB
> 
> ## Form letter - net-next-closed
> 
> The merge window for v7.3 has started, and therefore net-next is closed
> for new drivers, features, code refactoring and optimizations.
> We will only consider applying net-next patches which were posted
> before the announcement:
> 
> https://lore.kernel.org/20260816155953.072d73da@kernel.org
> 
> Fixes are obviously welcome at any time. net-next patches may be sent
> for review and discussion only with an RFC tag.
> 
> Please repost when net-next reopens.
> 
> See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle

Apologies for the noise. I'll be more careful next time.

Best regards,
Koichiro

> -- 
> pw-bot: defer
> pv-bot: closed
> 
