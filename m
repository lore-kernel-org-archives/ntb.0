Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010046.outbound.protection.outlook.com [52.101.69.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5E75867F3
	for <ntb@lists.linux.dev>; Thu, 10 Sep 2026 18:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789065694; cv=fail; b=koLb5BPPJZXjiYI63wWn3LDFSnN96m7TeBVxiXOpcQEKvoF+mXgMfcSLYQqpnew0EMGMttYKS15kLJ2dhIz7D84ZegqbD+SrvOIsZmQzpgvrifHJfVMBT7w3Tr02tAZOPWbs/MF3cEA2cIhJDjrVANTDszvnUx0Q4Nnn9ZmuKyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789065694; c=relaxed/simple;
	bh=sMSr0foikNAt6CdKCO0yPdIGjhXIbCnJC52+0yaPVHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WmlnEAL3ydXNPygaCxTxVrI4FMWmZ9P4bKYJeAa3ouB68qkPB4l0Hc+MRzWP/h5wp1R80vesw2bakhRySBvihvazD2V3o8WMQ6+/lejT23zHf+k4g2eWkpTZ0mHK6++T1aJjV0VxrKJoP/WUvw4stexHS8VWOU4cfxtYNugpLKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=OQiGxL2Q; arc=fail smtp.client-ip=52.101.69.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="OQiGxL2Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sQAmBBXSwdDaZH4rFRhnejVnwZ8pAWDsUit3L/CaEv9jX2hOoyl3HIaSiwoolyadj+flV6xVBbBh8EWikNK45rO/i6R0pkKZIXZpHwkqOTB8NYkYBWHzH1JBO+Qqm7ulLKg25dG5Q61nFOEWYcNq5+pP/lGsS0T9YuNIAh5xfqygyy07s39mVyhPFlCdOVfwTYowaDd+Q1lCdxirMVRxBN07bpnzPfvJ7f2Pw4cfM8uPxxdna1HJFZDMiVdWWWEbjfQNAWzK0y1y6yK2OMqTVL/T9M2hFlbE1CyrraBXldfwAiBhD3PljVIJke6BgNupUS4jyWXj9YtXbmKrrZltMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qJzl3CvZDqyCw/7KISjlnvCCBqKAWGowlCp3sy7nEk8=;
 b=vahj3FJhZERW6g+Ii9C3sVOyRn8+GKlbntS4ZnsfjLM76+LNMEKRiyLLpPY+2TN3U+Sg8XxUV4Rcd315fV4z6emQlnTb/9FDHdjxg6rs4IUJEAStml2j0S8QR+JXmJQLHhqLgfvh17gp+QkETPKrcy8c6dx0/bxhKxi8bIVJSYKbOLdqx4NRzcvIynED8BBcu9KQGF9hH9MClirrb1dzkH0ZnruXH6bw134f+NHf9LsBpdRN6qoGMsyCVibBd+JYm3UpM0gh9A/4JNmANWMwBw9pzu7pPICr5+v76WZZ8ANttJaMpN2nD6bGV8EUNuuGMpS38zTyqg4mG6+RLyksDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJzl3CvZDqyCw/7KISjlnvCCBqKAWGowlCp3sy7nEk8=;
 b=OQiGxL2QF7kP3t1cOB6NGiw0zw/QyohR/zFiFB7ZvjMjwOL8yDpru2eCo1ZANH7kLn5l6TK+li4+S/Gz6FMo6hJT4RjA84P4gpLugr/TJ9OaQaGMfYyRWqbilAQshj34bFeolVtjEGuFctjQfbTWqywoDxaqrGK0XOee5MOWoabBykbbF8U0APiWUqu6PQoVhJRcOhAcbl6PEdr8OmQ9qQxfn83rXMNBC8Xre/SpgWPFPr6iRSUBmx1D/owE/meV4UGxOV0wqLMNPfDAIOdUkVT77bCAEIibeVTgcoLlT4U69ydyBrJS7wFZtXah9l1vIFcpJ/4lx/LEBB3+nY1LXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AS8PR04MB8948.eurprd04.prod.outlook.com (2603:10a6:20b:42f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 18:41:25 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0406.005; Thu, 10 Sep 2026
 18:41:24 +0000
Date: Thu, 10 Sep 2026 13:41:13 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>, Frank Li <Frank.Li@kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>,
	fuyuanli <fuyuanli0722@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nicholas Bellinger <nab@linux-iscsi.org>,
	Joey Zhang <joey.zhang@microchip.com>, ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/14] NTB: ntb_transport: Remove the device debugfs
 directory
Message-ID: <aqL5yc6Wz3iMCS1P@SMW015318>
References: <20260910040836.3792333-1-den@valinux.co.jp>
 <20260910040836.3792333-2-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910040836.3792333-2-den@valinux.co.jp>
X-ClientProxiedBy: CY8PR10CA0016.namprd10.prod.outlook.com
 (2603:10b6:930:4f::27) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AS8PR04MB8948:EE_
X-MS-Office365-Filtering-Correlation-Id: fdbd1c2b-5e46-430d-c8f9-08df0f6b1dcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|19092799006|366016|10067099003|4143699003|11063799006|56012099006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	E9FDBqZzZQPg2oelOsHDiWh6hpcYGE8+b89HhBYHPBkpy7Dt4WSc3pl6/iIpFgYQXm7q7nQDi4zGE+RC0mIA0XiidcuxH7sQGmUps8z6xjIwF8sk6IVzK92+XkZiNQLRTkq9bRCxal82yviaJj8kuFGOERt4ImjbPmPQAq2orrHn0ARpPtrEYJzEkD7x5NtSatURkQHvCo1lW4gtjV4OcanzxnCfWSfG4bsWcJmRLPuwU3T+PUSi1MKgseobSSeTjI3J6xZMB7mI2lf9VikssjJS+6q0jHgN74eFPFUHqZUQtUyGtycokNCNGP2Zxo6BE/dtnLGDjDzoVh2Qu7+Z9/oKLNqMZtDQurhu5SiQX9Fmu98rcIZruAcDF794FjzmV7HF7w/ISaOnF7uELcuywib9B8HgrKl/3FKLcTOFWq18mxg1SzPITadXxMiUW9eg2TCGlvaRm+0eXemgFSRBWC+O65IVQSAnU0gB79OnzDf9Ik/y/P8NcWugVUwUVOqhkvetNo+DuFtLh8sKdYfRfQJ09vT3Fxcgqsdpd7pvFouKj+SdYJbwzl9cFa9ueX7GyqTC/6Osl4siGTiAD9L3yVXM/9MfcmyYprxQN+FyWatQuRj4lupgCVnSzvE+qkNC4q+b41brhoyTydztmUwwZrCJD69nK68ukiQdmvZxCK8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(19092799006)(366016)(10067099003)(4143699003)(11063799006)(56012099006)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eYrNXCQvqENXRkTsfbEyK4UzlVifeoRH5noMoG3Rwl1KfDH+GX44XhjHEI+Q?=
 =?us-ascii?Q?lNCL/AYoQE7/JHD24yb0cT/4HOlheOrrbSlqE6GsbMnhCMG7wcaMrgtqyB+u?=
 =?us-ascii?Q?XlXfGiteMKUoXTjM1GwvkHqwgTT8OoT6JNhLHKUPV+TB+FeQZtNkP8lNVEED?=
 =?us-ascii?Q?fLBxu76fxebCUAWYlEUVa7xIc6r02I0HcSsgBryTomajKBq+3Nhgk5gkk3JW?=
 =?us-ascii?Q?qIgMMTpOyQL36U78q0TxAd3Eof9BrIUJ9ZakflGBT6+2l2m2Ya9MUS5Hp/aW?=
 =?us-ascii?Q?FitrF+GhfNmMQ+7po8kECjEHUYtrLDEZ7df3Fh7mdQ79US/Ymmnhfn0kI4NF?=
 =?us-ascii?Q?oPaAp0hfhXFJJ8rRIb4De394x8VnqwuSeX8ciFwMYhNhaQiL7csYWa7zTlvx?=
 =?us-ascii?Q?BbXK2LRHZrJjmw9Hx00QEhACXIvMymgyJuRI+RNBOA/ThDT8Z7GHqEfrJS2/?=
 =?us-ascii?Q?adfeZiWpu2bkiGGeffpz6qty/iWIKX/5i8k6SYnmfvVBI4VqJ95JylY/3YHp?=
 =?us-ascii?Q?9scp1ZUNmyRu2qXv0buLZL4dEBP4w5GwWnLygvcYk/dl8Q9uh1fjXrN5cxL9?=
 =?us-ascii?Q?WZKqrqmDOc3mbi8D7RijXvZhMXRa8oamXVW5eXHbXXxymyPUBAWZlqDnlBhI?=
 =?us-ascii?Q?B44JiuDfBRF8CP+uzTlN3m+2WS+QhlgAIVkPG9QqvRKHS8bze10wOZe+0oZu?=
 =?us-ascii?Q?idhmH0jsO09uzt7tfh1xEXT7qFUBMZwHBNG9h6BCrZ73pfkL7JPJgoHfa8RJ?=
 =?us-ascii?Q?r3sOJgg0qqY7yS/FzzDgAnGhx79b0zbOD3fk5qGIIKC7yfPMyIg5DkowOME0?=
 =?us-ascii?Q?faopzXMSjOEZ6NsrdfkBA8yMZR85GVSYcZ/yqINjhYxll26lvhi5vJlooXeH?=
 =?us-ascii?Q?MAfPTFyC1zhBGUfd3T1EiH/Z3gltQw51LkDTDJpe6nODRtnZFsM1Wl5oUP4L?=
 =?us-ascii?Q?KKCPO4G/2cjXpa7qWIcq22ncsqRoEhfvk6R7jKZwd/LibXg6ohy81KO0Y45O?=
 =?us-ascii?Q?jvaO0dLtoEGWDDg+AadNTvh4Z07iql4/0PZo6LntAhy25JFZ2TDXbGGA0NVD?=
 =?us-ascii?Q?6quC1utmK5F6ztZY4FUpUwUkzJVpaLyZdy+Pij7QVkQCAaEuT37qjPGftLN2?=
 =?us-ascii?Q?FZhROnSQYbxBXi3DmXPnpDg4Wx3eb+ToGRvVoqOk8KFZQx3wL19/ubiFZ1wU?=
 =?us-ascii?Q?SdeEskW2fkpx3tjI5uKSqFcLlqUtMSUeKix5qBKEHeWUsunsZg9qTRA1JvAu?=
 =?us-ascii?Q?G1ipMsYYwGlZ74TulAaCNWXKMXXDMpfT5xhypYMdSOqzavP19sHNGyew3cJb?=
 =?us-ascii?Q?xYdyhL5EP/AIGDKdicDEnld1FrrgajIrMS3Hrt39Xb7uSrnQrapZ/16Zagjr?=
 =?us-ascii?Q?HUE678xjnHhjiK+ODjNGrTDgKt+IygaGdHkHgAb/4K5G1CqVlNz13fKfVe4D?=
 =?us-ascii?Q?96jlVO7aSgHK2h7ifN8wogaBrpv5UydWAUPadsEN8ucC3//XalSwag/WvGzc?=
 =?us-ascii?Q?0PXp4VkFoDMDkbxCqzCMnLhS/J6rTNjQ7SJG3uiPn6ab5yq25UeCGZgdyLcf?=
 =?us-ascii?Q?Pio6sfqGTKihm08T53hdBhv5Od52EYPpfR2qu2QsEvqPrPsDJyFbNivXhpbR?=
 =?us-ascii?Q?cA03Qw0f4uJbcx36EBHtxhCxN3kt3oTX3nKoUCESKkRTbwcHzx88HCb8o8K9?=
 =?us-ascii?Q?BByoJ9KOPWfmW15vSVTXgX361O/0NLQ0yxpeyJJzXCQvQ5a2xh39Mk5Sxl/R?=
 =?us-ascii?Q?Ep39QmJYCGbkrNqAFM9xbQUfGf8jdfW/3e59hS7clI1fWIBmiF8I?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdbd1c2b-5e46-430d-c8f9-08df0f6b1dcd
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 18:41:24.8787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Le7ygBUIfeT9wbr0COyj/+L4H4myhdXUPNLE6o/Q/HH28mD8BzEP+j4EHdAky6og3mMFowhHFD8maRcrfqjrn1NQZfGmTXswxFU5CCHwXSpckZN10lgXqvj6aTHChyvx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8948

On Thu, Sep 10, 2026 at 01:08:23PM +0900, Koichiro Den wrote:
> ntb_transport_free() removes QP debugfs directories but leaves the
> device directory. On rebind, debugfs_create_dir() fails with -EEXIST
> and QP statistics files are not recreated. Module unload masks this
> by removing the entire debugfs tree.
>
> To reproduce:
>
>   # ls /sys/kernel/debug/ntb_transport/0001:10:00.0/
>   qp0
>   # echo 0001:10:00.0 > /sys/bus/ntb/drivers/ntb_transport/unbind
>   # ls /sys/kernel/debug/ntb_transport/
>   0001:10:00.0   <-- should not remain
>   # echo 0001:10:00.0 > /sys/bus/ntb/drivers/ntb_transport/bind
>
>   .. and then dmesg shows:
>   debugfs: '0001:10:00.0' already exists in 'ntb_transport'
>
>   # ls /sys/kernel/debug/ntb_transport/0001:10:00.0/
>   (nothing)      <-- should be 'qp0'
>
> Remove the device debugfs tree on teardown and probe failure.
>
> Verified that unbind removes the directory and rebind recreates qp0.
>
> Fixes: c8650fd03d32 ("NTB: Fix transport stats for multiple devices")
> Cc: stable@vger.kernel.org
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes in v2:
>   - No changes.
>
>  drivers/ntb/ntb_transport.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index f9caa1a653c5..3389d6ca9ebd 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -1382,6 +1382,7 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
>  err3:
>  	ntb_clear_ctx(ndev);
>  err2:
> +	debugfs_remove_recursive(nt->debugfs_node_dir);
>  	kfree(nt->qp_vec);
>  err1:
>  	while (i--) {
> @@ -1401,6 +1402,8 @@ static void ntb_transport_free(struct ntb_client *self, struct ntb_dev *ndev)
>  	u64 qp_bitmap_alloc;
>  	int i;
>
> +	debugfs_remove_recursive(nt->debugfs_node_dir);
> +
>  	ntb_transport_link_cleanup(nt);
>  	cancel_work_sync(&nt->link_cleanup);
>  	cancel_delayed_work_sync(&nt->link_work);
> @@ -1412,7 +1415,6 @@ static void ntb_transport_free(struct ntb_client *self, struct ntb_dev *ndev)
>  		qp = &nt->qp_vec[i];
>  		if (qp_bitmap_alloc & BIT_ULL(i))
>  			ntb_transport_free_queue(qp);
> -		debugfs_remove_recursive(qp->debugfs_dir);
>  	}
>
>  	ntb_link_disable(ndev);
> --
> 2.51.0
>
