Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020075.outbound.protection.outlook.com [52.101.228.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F2038644D
	for <ntb@lists.linux.dev>; Mon, 10 Aug 2026 17:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786381492; cv=fail; b=cZjEFSlBO2BGFC15TjA/oFHaePEm0JHjH7RGkIU09GgyxnbTIz05YZeA8U3bw/enD21tNJuHZga1jz5vfStDFMX7RtZA3L+WoTHXiYafuom9Kbh7ST/iuWOum4F7EqKB44YBHejLexUlD2m3lFXlFxb3bEGhj8QzIUF78OWkTJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786381492; c=relaxed/simple;
	bh=pMRGpKLJxhVL0/8jIG0Fs3EC83KUVzYuHVVh2ykosYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=k1a/T8hlHi3eTQUx9PGPuoJtGt8O2J7FQ9AA1LpUvcUNDrZxGSePnOvBjpsvnBSCaizZp6bWZWaBKsxSuEPiH4RIl37X2SXkciqAz6f47Jo2jJCrZQlw6P8JTFKIPJfJtJfzBb6GM851I/gAbiWayl74+zlY8lWgeTPmOc5DBY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Io4TFpCd; arc=fail smtp.client-ip=52.101.228.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Io4TFpCd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XWv7oOzPG15og0b9ybzITn1crXPUtdw2FbbKtYjb6lWkJIDMwjYYky85DAAT0SARTgI7MUIQiq3EOTPKVL22OpJrO9+1kItkL7V0gJ27XsRATyjE+5YbCuY5N2SXO29lzGPBp2eV3iLUwzo/Dl9Cbfg+I8Y9ZLZyC+fi4NA9Xz+yUX61tHGtH+zRpTTwveCogfXz6jKZZtqxl9IujvdRV9M23DnrEn/mbh+i4ylW5p7a/uku2Z9bcYV+6ZWk8ly8uDPEpFmpw2yu8M+R10PJIaWxWJqCpYE7CbvuBP1yEQTA/qjbdBS6jbVF0j6v/4117J/Qp3wqkyyfUmULPyf5CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IqMEXExhIMHWzWuHoXyB2TPuLW2S0OFOmmoVMFZ/L9I=;
 b=sm6c7o45dYV3HD/mHac+7GXcll737jL7ry/xtkM67OD0pcuT8bgfhuC2BstWMZHzy3gxF7k/SUMmR0+EZZSk0a5p+aIiN4frqjIPjgvgCZYyH2hCofGCadSoWBm91N6oLTy0vT9A+8EPttVSdEByYQqPFWRSLp5ZsG0wW8PwKMSuv1R2u5ieAJVZNJqpYZMWE/sSgMc/uPfZHybxDABQ7oYpf3TUqUb5iD640rx+kgk1XmRQEZx0hoz9PGNBH7c1Q9frXsXZCDMOnTgCYcutZyibiyFv0cGVJVa1wa+rkQ6+D/G0acCEzVzGhkO8DmXoLWHS6Toi8j/iU9uOOK73WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IqMEXExhIMHWzWuHoXyB2TPuLW2S0OFOmmoVMFZ/L9I=;
 b=Io4TFpCd4ME6Z/AEvdiZ5ulQbKj8LWDQjnf+YKnJjEfa7w4gcoff+30kVTn3P3sltu1Gd1h/hFiWh2n5PYDpqy6Zx9qNLLZu4iUQ6Q8ic9ytZ4hOzQs6wuuAJhcNY3qSjgKgQvq9vsyO9JpMn0dtu7XJUqSUwrylaoTD4+Y12CM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYCP286MB2861.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:304::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 17:04:45 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 17:04:45 +0000
Date: Tue, 11 Aug 2026 02:04:45 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Frank Li <Frank.Li@kernel.org>, Allen Hubbe <allenbh@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Niklas Cassel <cassel@kernel.org>, 
	Nicholas Bellinger <nab@linux-iscsi.org>
Cc: ntb@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/16] NTB: ntb_transport: Enable direct-DMA queues
Message-ID: <2xmt6d5bvo55odqgyatzxjft7fmqa2koq4cojekzjmubbktd5j@b2fprbbrsxwt>
References: <20260810165136.2292436-1-den@valinux.co.jp>
 <20260810165136.2292436-15-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810165136.2292436-15-den@valinux.co.jp>
X-ClientProxiedBy: TY4P286CA0081.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36d::13) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYCP286MB2861:EE_
X-MS-Office365-Filtering-Correlation-Id: ca10ccc1-2a7f-4ddf-31cf-08def7017a8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|376014|7416014|1800799024|23010399003|10067099003|4143699003|56012099006|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	lnMQHEdIbcQjfKOpDTqLpHQ+JWKq++7A+UpmkYUeLQ3MwiSHYbEetsufMAfx6MslU4xXgHEifs0XeMYMgr6hoYcf5KIImOEbF0thIjqapYwE0rfxmaKESgjUMTZ+NfrVQBD7hGP1YsG0fF/j6RE0359QEr4ZcRCellpyiHSRoj7fG6BCgrcufYKJdq5Q2WC7gpoaZ3sDm85DUId+RpYvd5HAwI3K0TcwbcawDS50Klpq7I1f+GxONXANzBsB35w/X/suhBx/tBkvmDNlqMnYOlykB+Jk9eFkvM1bzj+cL5+zyGARqW5U/1L4w5h3ZBn3mklX9eHGHvwtdNsCoA5e0T/dFE6rswaTJtM/bZSjn87GpYw29rXsq5ks9xt2J2/3ED66MzK3/1xlsT6e70Sfk0Nzx47q2aUuBcwgyAp/9847XJi6VCMtyHLIxEx5LaBqqfCED6xxaxGJ1ZQGV5ZVHs2PA9P46R02YfEBaPSWS3oniaJqjafEtQS3KIC7w0UygERfYu9jeJ422IXVM9cStUPS6mZ7bZOLd3BfbH/jZwpvInp/QnNLR2TwtXc2i5ujTInFFxNPgEEnG708vP1KdyELeNwzWoJ5xTZ7DHGUoRhBNFwljRN3Ygi0H+//kcOTdl8DdIU6AZ7yCBOGdTnSTmv1DPgMVau9omGaHfqfjwI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(7416014)(1800799024)(23010399003)(10067099003)(4143699003)(56012099006)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Fn1k3p61IGqMNHnOgFy2RbK8TYcQtJJNEX90uBJNgjbnuoGZe0yaSVLxVb5m?=
 =?us-ascii?Q?xs3d487S/NB8bhyAKTMBAdMIwqSXSnlosKCfx6OhXMXJGQHFMdRDGNHNVHpe?=
 =?us-ascii?Q?b6Xv2fkmkAo6bwhg828CrjIiX/wvaJoFWyqe/0NDZidu0ddfcG4nFT+/9n66?=
 =?us-ascii?Q?g2vAUVUzvr/hhekOfiaA9KY7l31wSHtCJ2aHmA7HzVAOey/r2JpwvHOs4cY+?=
 =?us-ascii?Q?uSObryAu6f/UvfpIFeqhTCmXL3vV4IWH+k5bBw7Ow+ZXUAhRh/NXzCAXykTL?=
 =?us-ascii?Q?yncf0cei1TO8MzcRPvWMt9G1QsYvWA1QtjnAKoiGJBwU5TV7WAriNrKGuQND?=
 =?us-ascii?Q?522tC9L9q0CAinDPl0Efk/RMTOEptJgP6ShxJ1LmuLtU/jeu+ke3Fq/eRnKa?=
 =?us-ascii?Q?EM4ltrN1ATjbcZhx7cT6He6IWRcbA5MMX1MWEDBra/iFF5JdxP4X4Cft8mhk?=
 =?us-ascii?Q?i2LXBUOlCNbenX6O0aHzHMmQKufsUgFFLH/UmOsOPY4pLUbGG+e00xnuGHIa?=
 =?us-ascii?Q?1HJlEn75d9wV7IFyuxEXD9WWT9Kg66q+6MhajBWUl3An+IyF24kkwl9cM4kp?=
 =?us-ascii?Q?r4zhBFGcskof7WwcdhfRFi4oyZ/mMb/CIjVz3aqD0vQt3nAtAKxvAjU+L0zE?=
 =?us-ascii?Q?obzv1dnY7xvizD0wi5smjGHOHdccwFwqgYCZJdmneNbCTLHGWGjquR1rXM7J?=
 =?us-ascii?Q?MiPtZp15NZ7eJ+EEKri+IeJEe5j9IvAezNRoIbBZA9zDDNyPckNYSpCYYkNR?=
 =?us-ascii?Q?8hOiuZseKu+2yzdL2gOxEC3/K8iIk6vwyWjbQ3DBFFiEESDEapQyNK2Jxo87?=
 =?us-ascii?Q?77XLsHi10VM3NFOFj5w/GsDHjXqygB5X7pnPPxD9wN9cy9O6+t060jFOSGhu?=
 =?us-ascii?Q?+FTw62A4rG9QRzGlzfEraC+pipVt/9b4Vn/9ZZktDk23LN1qFlOplB+MK08L?=
 =?us-ascii?Q?ELV5Vpn0wgfkv1npHEu6zI+9KEbfYxA8WSs7FS/UijdyRUmBTVlm872rMBsc?=
 =?us-ascii?Q?6HfOZ8xnMvEu8W4tJPutbU4pcl3sjAn8u0EZGwwCbo1sIPp/WwCPZbU2R+Y6?=
 =?us-ascii?Q?/UmMun09l2ctSIXYneB4YUVBOsYSLpgwx6Pp9KJMsmyWaGlHJxQ1KP24rixa?=
 =?us-ascii?Q?NYvx7CPsw4oKFmnvXVLKtjsxcaMc6OPD3l8ijJj9vf7r6006BkJ5zgHMjl2W?=
 =?us-ascii?Q?5PywFEy01yX1I6Gz2hVB0lXLTwW4YfB3GIxbIg6EzXMp+8wUZ4MsZhlTCOUS?=
 =?us-ascii?Q?uiusHCGpEw3AiQiOPaIS+WoRJnysFC3xDzU+srO6z0U/fkui4hvWRvZB4/S5?=
 =?us-ascii?Q?rFRpLGvbRDKVl64VKS7GTzeT0FOkKdA6Uy3qBxIAykdPI7Cl8nYPnAl5HXBr?=
 =?us-ascii?Q?gxK4lMCMkA2RE+pvatL/ZxUZ+vxcM+Qy5yIfiGBdYfUN7wZOpZXYWhjSOT6Q?=
 =?us-ascii?Q?dv8NFbo7bmQ4c4LQokWv0gwcBmxpqcH+9Ip6rLBn6qiANwz6ksKrpQe+l9a1?=
 =?us-ascii?Q?ufmC10OmuZ4Z2u6S4cdQ7Fs1ga16rPSVpxUppLKW3B65qlQuC7HjlEiLehGL?=
 =?us-ascii?Q?qszZURFUMaXWH6rc12lWd1DVwjNloi5pAHi5Hcmu1IhmTfbM8meqrACyzn+7?=
 =?us-ascii?Q?Zlub1pSWzbJCFmuCBl4KgxuLmmMLGpXqGt2T6ig5GQDTgkLw7gOA6CM/3mbp?=
 =?us-ascii?Q?cXyOO9EHH+QYFelGabp6QxKNeb2aaWcoGRIOh2X4EYyFiAoto33WPyOF8cBm?=
 =?us-ascii?Q?Sy4ALjg2RyVY9k7JYlpdrVXJqaf5HQlFSS41eQKcri3m+E+CSYdE?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: ca10ccc1-2a7f-4ddf-31cf-08def7017a8b
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 17:04:45.6599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PT7XfeL1HhRJeDD1SPSjMSbkBl9GKgMrSRenpiJmcCoywo6EUxBkg4X1NbTDfV0VdwTbXMrl2VE13JrPWUWmlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2861

On Tue, Aug 11, 2026 at 01:51:33AM +0900, Koichiro Den wrote:
> Advertise direct RX when a DMA mapping device is available, and direct
> TX only when every QP has a suitable channel. Negotiation can then
> enable either direction independently.
> 
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  drivers/ntb/ntb_transport.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index f2fa145994b9..9f5d6a407be7 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -554,7 +554,7 @@ static bool ntb_direct_tx_mode(struct ntb_transport_qp *qp)
>  
>  static bool ntb_direct_link_capable(struct ntb_transport_qp *qp)
>  {
> -	return ntb_direct_rx_mode(qp) || ntb_direct_tx_mode(qp);
> +	return ntb_direct_layout(qp->transport);
>  }

Sorry, I got distracted while rearranging and polishing the series at the last
minute, leaving this meaningless intermediate diff here. :(

I'll properly fold it into the earlier commit in the next revision, so please
disregard this hunk for now. Sorry for the noise.

Best regards,
Koichiro

>  
>  static void ntb_transport_notify_peer(struct ntb_transport_qp *qp)
> @@ -2058,6 +2058,11 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
>  	else if (use_direct_dma)
>  		dev_info(&ndev->dev,
>  			 "not enough scratchpads for direct DMA negotiation\n");
> +	if (nt->direct_dma_dev) {
> +		nt->direct_features = NTB_DIRECT_FEAT_RX;
> +		if (nt->qp_count && nt->qp_vec[0].direct_dma_chan)
> +			nt->direct_features |= NTB_DIRECT_FEAT_TX;
> +	}
>  
>  	mutex_init(&nt->link_event_lock);
>  	INIT_DELAYED_WORK(&nt->link_work, ntb_transport_link_work);
> -- 
> 2.51.0
> 
