Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.86
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795584984;
	b=eDBdotolmOjDxVSc1VI7ATxLBGLr/NHmSDn6bIKLPqik21o81LvCPe6YU2OIb3VX8iSc
	 hplcCX0E3SNp0XQjP6A6ggVBHxcEjami/akt9VIDVLswoxIcdoN7FnD3+JDnw1PFu/SR/
	 CbKVQzYn4AAj3HklpmWPBFpeoGHv35dQa3wgBc1e9EpBM/FNYMeq+Ggdb2Tmueh39JBtk
	 7mLrpI4o8K4BY4svaVI7CiiX5TU12B5L6n0GNRJaf/ZrpfEghVvCKnwbVct0suVrY80M8
	 p3QOFSYsR8+BwQ2S0D9FQnlZLu1wSk4O91JzAjX9kum4S5CWd1noMCtlnnVRkzNUKWg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795584984;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=H66yj5a4FsHPSlTvmZkm29hDQuAhLg6o0jY2d5x868Y=;
	b=QAeiNmcY5RAKV7TkY8cAulR8qIbyjJyqW6JttDG2v62Y0hYTY/QjWEGCkFkw6ecSuSzo
	 zvHT7I274krFLZZSOrnGkJ4HkAjCpW/LvH/PvNxumkvUvOZ0rHZEY8CO9Lz34G8RTgH3M
	 2IOIxqMCvLRMFb/OFgT3e1LOUrCTv776w2M/9KbKCkxGza3sE8BJ8FMb7KydzfE9mevCJ
	 DACrf4fhrbF69dhjOLlIldKcUvaghxJ7Sg9zx2RgAmOt2ii9jHsnop2wO96QswtGNu6gr
	 mWZlCRPEpD6x0MsAVbR6Ii48gN9YBjL2LfQK14fB4VRgCZgGaCT7FUPwXjQ60lzUDGQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=aowB80y8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.86
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021086.outbound.protection.outlook.com [40.107.74.86])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73624606A323
	for <ntb@lists.linux.dev>; Wed, 25 Nov 2026 05:36:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73624606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=aowB80y8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YIRZYZOWlxmfeU1yjWDZZXq8x3WS+RHo+QZ7cZMKbi98ZR/co0EOqN7E/2tofVn0TUROHJsE8+TNUGI7uM18TRQv8kgjmr+00v+5jbTpZAEz0+I0UGnodyz2Uz1m5s8gSe37cn/wL/UpwmlwGL/jeZLgNMRxXltLjcLKF+dgdHVK4RaWaP1Jp69SooMmklWDhKkTEpfGr1lGpcRl4dK36SzaQ/8nTM8hP09qtr510Egw0u19vQNohAMI7dGI0RDz94f09a1YU9LpvVBUNNjqX6sGW0Jgart320fqa4/vv9zjpyNzxRAPDfbkCeaTSJrxZbrgWaEJwweTYk9hhoW7xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H66yj5a4FsHPSlTvmZkm29hDQuAhLg6o0jY2d5x868Y=;
 b=utF4+LQKVvwPyLGVO4Lsw9KP/ca/tMKHtrJK7hr4FAExgS7FTdiFPbzjCBboaVfxy5UV58EBeoRAy9q/hewCEoYEua/xFZUqNmhPorn6GBr/rVzFiyr0uCH3NJhiktNWMxZF6I2uIvtp9gP0DfUQLS3uPnZ+P9eGRyFk6FlkIhrjj0bsl7n+NgQ328pOBE+5j8t5Z8nMWSLnQjWW5smP/x4salQfLTRQgQ/F4g+lBtH1DkOzGE9UUExekKsOuftBt+1PRrfocFEW4XJCbzNlqv7orN+C6sTWyhMlMOyfFDR4LgrX/dt76Ir+I2egG09trVNMgMIBVtmpL88IvCe6wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H66yj5a4FsHPSlTvmZkm29hDQuAhLg6o0jY2d5x868Y=;
 b=aowB80y8WwXHBjMCJGJWTh5DM7oPUwI16qdROLM4VPHCKJv+mExTSr5xHQGPMfwXgAGdOnbqmAyztFIcxn8Ry7l8/q7e89GSY0rIYBb/FvvhAkE2B71SUo/ETHZIZ6LsmVF9eFgCLgcegfY6Z3U1yXkBdWlWRAX+g7TI6ztUyRw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS9P286MB5949.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:3f5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Wed, 25 Nov
 2026 05:36:20 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 05:36:20 +0000
Date: Wed, 25 Nov 2026 14:36:18 +0900
From: Koichiro Den <den@valinux.co.jp>
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
Cc: ntb@lists.linux.dev, linux@treblig.org, jdmason@kudzu.us, 
	linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: Re: [PATCH] NTB/msi: fix error cleanup mw index in
 ntb_msi_setup_mws()
Message-ID: <awZzH9bcH4SGYskT@z790sl>
References: <20261120084039.1954-1-zhangjiao2@cmss.chinamobile.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261120084039.1954-1-zhangjiao2@cmss.chinamobile.com>
X-ClientProxiedBy: TY4PR01CA0092.jpnprd01.prod.outlook.com
 (2603:1096:405:37d::17) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Post: <mailto:ntb@lists.linux.dev>
List-Help: <mailto:ntb+help@lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
List-Owner: <mailto:ntb+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OS9P286MB5949:EE_
X-MS-Office365-Filtering-Correlation-Id: 9812cefd-b2be-41d5-f66c-08df4ab608c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|23010399003|376014|366016|22082099003|18002099003|56012099006|261028144727099003|261022105027099003|261021121427099003|261102123227099003|261022075727099003|261021123027099003|261026121527099003|261026140227099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	B++xG8zQ3l40fBpiZ6ICDvu3SLOuuRqAmA3PiQv/Eqpp3VslS1EdL+bHB9PAFpHJuTzkrZAU5wqkPKT1SMhYxjcvzoBFDPgLUkHYHNTEzhSQNac853S6ov8s6mL8gEUJRGwiyxTHKzPuKuJhpxdhbHBjlTnMUCOibmARslkvgeZC7Dy8jFLKRyze908KM4ope9MWH0EAndicAx6v9EHIIDTTKrOiCJAEdXKgJfSbYGJ9mO+i201XLArH2TCLdf0mFRkOK0bYqB/FSYnpqS6iMrF5khug2TvFdIRfzF4+d0qdpSC8n8LNo/gn/kb1V/0JUpkGElehy9Zv22SHd4Nzh1WxeMRyni4BY0DMflLS3KpiDm8W+3U6/4gUsAN+uqNrKv9SQ6xdTEvEf7PO3YeLy7u1RFbNHKsdHMF9ebuM6QbP5UlrMsJtyM5i7bPFQVmkQXN/I3DyYy4tPvSZHvhbBeQ9U9k0xzUGs5jvqF10a6CjrTAuJtU5gWHzxFLJIP3bcaacEYG1cuVcKz9Jkmhe77qXWofVgiIS3hvYwDv2j5PJWbUtq9KW3vo3ww4UWudmfaZ2FEjBm6OWvOy+z2pi6x3MORUloU5jq6UTznvIgV2X6RXOxs12IySXtBK9mSJZZo1TU+CiSxyCWw0cVAYI9itIKpZhZmpBKfWILa4kO3U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(23010399003)(376014)(366016)(22082099003)(18002099003)(56012099006)(261028144727099003)(261022105027099003)(261021121427099003)(261102123227099003)(261022075727099003)(261021123027099003)(261026121527099003)(261026140227099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lHRxp3xLQtvoXvB3pbwcvGI57CUdr+Jpgh/1EQvG0c/e4EedrTRdQCLQcc18?=
 =?us-ascii?Q?C/3QP2sR2XKPYLEz70gIfiUzSxFgicjVJIGaKP9OuYpPx9WOeigKW+wD9kTL?=
 =?us-ascii?Q?KmtNAzKtGrHyWt5xVmBcDofM32MrzPDsZI10hFcrlBQ+XFV4v1YilYOa4V8/?=
 =?us-ascii?Q?S5f5X+M/3v0SE8mlzC4qwO14DNLh4Vh9M+1bBIzuxN2hGIuRRwIBhwCv6Njd?=
 =?us-ascii?Q?kyu2h6wFyMJhedd3jRHDnGWCjS9JhCIvDvLUQHuvQlf6DjWdZNDTd+fWbBQs?=
 =?us-ascii?Q?j8EvBwz9YaLDxCFpF8yXoTsM+x3vvIzLR9bRvtyvbPamRCNHPvUszAP/JTmD?=
 =?us-ascii?Q?cca/sKsjcbvajq3NaPrvvE2ELRNAgNGMfC5PhzMzPdM5UlRupwpvmGWOZ9We?=
 =?us-ascii?Q?IErD1hnkxmdS1TgZ9xRE4OeGAdEzTRwJZDa20jbsNZsf1ZsGXewCx3FvbC5/?=
 =?us-ascii?Q?YN9ZF3/qPfEjiB6rspeaoG1golSgFIUu5DxbHybdMEhE0TBpAS9HuKOsxOau?=
 =?us-ascii?Q?YFEnZl4VzxT2Ezf8gMr+2/lcCZUDB8+icLn5PAYzXC20Qqx0qsWrPb2KXJkg?=
 =?us-ascii?Q?ju6DVZY1ZmLLIasicWE33jREW+jPpP7ljMIX3dTiRP18RGQXDY9f51o/G2OL?=
 =?us-ascii?Q?3DDDuWZrGZbmlKwxOxdwlVEgrWMXiynWZtDYMKlZWC1YVDm/vHTqUYtT8SrL?=
 =?us-ascii?Q?IeOVTjnIluubA/8Doic2XA8y6EOMlSufxttnji7U/vnb+fMOz9U+V4fO/+n2?=
 =?us-ascii?Q?BYofgbOqYaqHXtsR1QFlyIRw62yj5Xvw4uxHyzxcgh29c5jnkVLAr7ICqFQf?=
 =?us-ascii?Q?uSBzpkwi0pEN0YldOZiWil760HmvlG0nyy9qA9LAY6xmmpWAFJyRhZmhKjBn?=
 =?us-ascii?Q?J4qvWkXelGjEK5ck/Fxuw4d0NhXJu33VdBThpXmsBVSlZA1e4oiKJSakQ3gv?=
 =?us-ascii?Q?sEDs12dwFnGppzGuqsWs5HajhIEUgVrxOjAlJwML111rq79xsACdRYBW13y7?=
 =?us-ascii?Q?XxqMlh9oEU3Hi4h9pZbvyAmhrAOBRvrB9D4CCN+KHbmMRK+z5FgzeNAENctK?=
 =?us-ascii?Q?xsA0OVfO2eFuzkjYlASwcRDgWizX78cb9v6cu+av1zm5i6sC3ZZZWbPygvHs?=
 =?us-ascii?Q?RPpa4JlVWaiCbqzn1Z4dDFPIRteAG6e6zHZ7eQpKQXrDCuY5Az+f8KeVQkfo?=
 =?us-ascii?Q?gDSbOkU2hXelevtwb4LKYu8XY30mr/N9Wo9MNEpJTWPFuNkQa1xD9+9oLPph?=
 =?us-ascii?Q?RnVuuYhnsJGU6/P9vG6Ht1FrqAM0e97C8W+GmoLxy0EV1c5gDEBGbk4V8ex1?=
 =?us-ascii?Q?1Cwqqvi8nzAL5Ko1GAHtyaNyEnwuDl6JfG84meHAxBj9aDetI1fWAPG7O62x?=
 =?us-ascii?Q?oQ7fBkOdr7xeUdrIyjAUWHdHhVGbWoKer5idNOZeg4eLQWGsAYDYAao33ieC?=
 =?us-ascii?Q?3FZqdPerEC2ECahdL+wtpMYdYTGTtnWxk6c6YUZdkVEXXdpzsVdYX15TofzJ?=
 =?us-ascii?Q?OEOvvZGenpcmNlHBbWQR+brL3FSBAXeL23upKJQ3AWb3XoQWlpJtg03wAskL?=
 =?us-ascii?Q?4X9MyMFw6uGc3RIm2iPEsqKVRMj5BWxeenp3wRu1BYJQB27UrvgwfEbT04dw?=
 =?us-ascii?Q?d9VOiJbAceMLNrw9Os8ikCToYNoDWOMbBMwhkz3u5GAq5pVPMIu+7AsRGySi?=
 =?us-ascii?Q?d6q24vkvOQIoy+FkM0qyUYLMXODNtqIlcBMLwymtHeBamQCuNDibCWvOGDBS?=
 =?us-ascii?Q?OQ8NujoxT7Jr/DSpgVokhqgY9Nf1uABcoSYkMGrE5DtIW1Hqf6ny?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 9812cefd-b2be-41d5-f66c-08df4ab608c4
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 05:36:20.3941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VZjHaGlhCvpp16Eh+E0ZCLGeBx40G55MMMESKrUhTgZEaNH2YmPguv5iTQm58COsM2l6uv8rlKOOd21sw3fwBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB5949

On Fri, Nov 20, 2026 at 04:40:39PM +0800, zhangjiao2 wrote:
> From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> 
> In the error_out cleanup path of ntb_msi_setup_mws(), the loop
> iterates over the peers configured so far using the loop variable
> 'i', but ntb_peer_highest_mw_idx() is incorrectly passed 'peer'
> (the index of the peer whose setup just failed) instead of 'i'.
> As a result every iteration looks up the highest memory window of
> the failing peer, so ntb_mw_clear_trans() clears the wrong window
> index for each configured peer and the intended translations are
> left enabled.
> 
> Fix it by passing the correct loop index 'i'.
> 
> Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>

I suppose the Fixes tag should be added, shouldn't it?

  Fixes: 26b3a37b9284 ("NTB: Introduce MSI library")

Otherwise, LGTM.

Reviewed-by: Koichiro Den <den@valinux.co.jp>

> ---
>  drivers/ntb/msi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ntb/msi.c b/drivers/ntb/msi.c
> index 6817d504c12a..13e9f52ec8cc 100644
> --- a/drivers/ntb/msi.c
> +++ b/drivers/ntb/msi.c
> @@ -154,7 +154,7 @@ int ntb_msi_setup_mws(struct ntb_dev *ntb)
>  
>  error_out:
>  	for (i = 0; i < peer; i++) {
> -		peer_widx = ntb_peer_highest_mw_idx(ntb, peer);
> +		peer_widx = ntb_peer_highest_mw_idx(ntb, i);
>  		if (peer_widx < 0)
>  			continue;
>  
> -- 
> 2.33.0
> 
> 
> 
