Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.94
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793548576;
	b=uK4ej3u3x/djWIO6+dOlPYAdfKM7KdQht57lFSuM0VkHIQgjbZ+BN8Pt2P6eC/51OE05
	 rTihPPpFzpd9bOjzUkNsD18cCn4Y5YN3EHM3RMP/lcv1nt+wlRkxcS+5x7nVkfR0dWKn4
	 bYNlEhG51g8xiNhPLo7vML02uLwe4iQLZEiY4dGddNNvOeV10I4OXoHblJtAL8ZurLZ10
	 wZhXRjPCUTvCRVQSQdxPfdc9apzYut0UdPxGFEfSs9qkA7rl2PnIOm9WPf/k+e2m2eu9P
	 SSND0IaqyDtQrkxAJyBR+P1NEKvfwmi+jc+/VG3/MOxXdrS5lLZyd8zqELovHV+vtDw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793548576;
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
	bh=wtkzzd4QEqE21i/ZUBPYFwY9Y1y2p+vZzIyms7oO+xQ=;
	b=0mFuOH4RCNCMcMJNDHMJPh392OfPVKqapCMfZij8l3vvyfuZ3829ng6IIjiOLQxPf7eF
	 l/iFly9TUEY+MlNazAgHQQD87MIDJKFKpysvgKjU2azYq1GwcX/4p3ZBtveyyNEIIAx80
	 78fsCBBvD/1gtup+GE4jvUUiP1JyxqSAhjArkcgA5xO+BGkqcvfS0FuNlJtXnsqnJkygR
	 KiDgAc7b7+6dDIu5LNXzC/tayYQQ47vK4DTsVBAoWY5T7AYcTVRWS17XnyV1qD07Gqeue
	 h9jxgwfzHE5su8XgnaXvySmH45J6uPPxDZQLY5aOppc4oytsbM1JXftEc5oC94BsrUQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=TnGenXqW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.94
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021094.outbound.protection.outlook.com [40.107.74.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919FD606A329
	for <ntb@lists.linux.dev>; Sun,  1 Nov 2026 15:56:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 919FD606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=TnGenXqW
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NIfacPdfQrwOp/rFX0taxkpr11SpYpANJZOA+w1S+NyZycIfX2euen79nhvIQCUPltIEsplfqC7MCEn8f4wCb3IbWLlyvk0zZvrNDRlZqxUH8EgafgCgMz/OrViHcrcMLt7jcV3uGlt+Vq0rR8kYydDmipBvkhME6bdBkYovLPBS+Cvpffp26UQpgQpWKPizDooY8iOa8UVNsW8Uwy0HdREEFyOFo/6zz8OOAzzD5vqz9Pki41jLCFpU8xtFWAHLJmjn7Lu9AuOHsI44kDv9cPqz1/F7G4fZyQadeK6nnFjCWC5ZPPCJ2yTZMT3Jiz+lWFSMYKHD34XO370njjN4Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wtkzzd4QEqE21i/ZUBPYFwY9Y1y2p+vZzIyms7oO+xQ=;
 b=aJKuKjraEXMntwnfJa5AgYk97l4DQhvfH/XdZZb2vn6yDx6bExe+2wUKi6aUWpagaiQpULzOrRHijFETUVPWtErxiZJAAT/8BaDkv0V40NsAQj6FLJW4DIal+rp/JewyFi+XCqMMUDvllfxxK5g7mchWR+d+ikPQ4wcsPx77fNPPKU9Q0E8czuDra73x5gX+trKAwN+H+ip4HCM9xHcyKL8PBk0wXL4UXEIu6jUcSKyJh1Iq/lNz11P22xUHfSLDuiad6Xf9kR5urjfBwxEvDBnO83N8vA28Gv4Io6tJyHRrlyaX+xlPIYaX7pCrVZ5kAZeTtbvUq3gCx7Touj8cPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wtkzzd4QEqE21i/ZUBPYFwY9Y1y2p+vZzIyms7oO+xQ=;
 b=TnGenXqWmtgY5lKMe+ZRptDNZ6s9mJ+ry9Keu4X0JgmsCnBhAGIhRui5e3uJG0Ut9BQ2nb9K6WIXdOfFh8LwRX63M7JhGikI/zP9vFLj3PRIES7+6UCKMdgPmFvVTKUgrzaMzl1V1xqWij8vdvaA1YfXS02+XuT1k3AzT2l6dWQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS7P286MB6586.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:42d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Sun, 1 Nov
 2026 15:56:12 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0569.011; Sun, 1 Nov 2026
 15:56:12 +0000
Date: Mon, 2 Nov 2026 00:56:11 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Avi Weiss <thnkslprpt@gmail.com>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, Frank Li <Frank.Li@nxp.com>, ntb@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] NTB: epf: propagate MW command errors while
 status is reliable
Message-ID: <mcaijcbotkzgqgl3igqvqkkirjr4gczh2crfaban43vqsdestq@54uaohytdycw>
References: <cover.1793540847.git.thnkslprpt@gmail.com>
 <62334fd3b8d69fdfdeed268d71f473df45f34556.1793540847.git.thnkslprpt@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62334fd3b8d69fdfdeed268d71f473df45f34556.1793540847.git.thnkslprpt@gmail.com>
X-ClientProxiedBy: TYCPR01CA0186.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::9) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OS7P286MB6586:EE_
X-MS-Office365-Filtering-Correlation-Id: d1f9cb40-56b5-4aa9-3d40-08df3830a749
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|10070799003|366016|4143699003|56012099006|261009223027099003|261028144727099003|261021121427099003|261021123027099003|261021135927099003|261026121527099003|261026140227099003|261022075727099003|261022105027099003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	h0MdAs9Qmdjt87DJ6mE7KfV8+5Ad1+ErrPs7dJeqhGnXFW/ibIhvQnSoMCqad6B4Hrg7kLODDDJBL3d0kA+y/GxtXkiNlZTuV8x/yUrwOPUXGTiapNiVD0xmLlyiuTK9c93vnq4wRPMIRtC8kakEFuJJALHLQk+inmaM7rs6dfrDg5BtHSUH2TAVwhlQxudRQvMeyTh79l2TbKU4UZMawKBXcaDv+G7sk+hzvdWlREmK2f0WwlOVSDla6zNMLiwO049SvfiiChA1ZwPPuk4jaEDhrjWmDNao6DywGyQPKkUpqvAXldCWlKRgVXwXGQ5oKerajhVQy+eEB51qHapjxETwtBfVzNZEivqM0j9Pps8t4oLqUTTzObc6iqMawJnKrgHpP5rJWP++C5sgofAsKw4eSX08D1lxI0UWW2gL+N/gKvCtoFyxEEu43mOtXMlSOIP8y89sICFk2XkQEmPogB+sIboe9iVFPvOTMM8C/NDOC/oSmsskzSKnblPe0qtDwUjKBLKdDF2EXHSXrnrdG/8WFj0lsHjwwa1qgwY6jgzucvNqL/Gq6pwzFk4Vmd2gDM8WJqSpuHeSDRG59L5bclmwf0eZwSGuGaaUfWyPHY+l1SGDukQsmRUG5KImZyLDfpI9TRAamRWDPpPxguIuRGsZT5a3t68EWtN3i7AxxV0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(10070799003)(366016)(4143699003)(56012099006)(261009223027099003)(261028144727099003)(261021121427099003)(261021123027099003)(261021135927099003)(261026121527099003)(261026140227099003)(261022075727099003)(261022105027099003)(10067099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I4I7dqucd7OU9tdNL6V5XcYDok+lOzeX/odJi8CSiB/KUH16FoQucyMcHof5?=
 =?us-ascii?Q?iOp6cekXpYGEY4SUzVIba7fKcPUrI2MzEoxiEBJYo4+xHchU74TZ/6K9o4xK?=
 =?us-ascii?Q?r4hDY8mXy9wUTN+VNd9mfiOIltWephlkELBN6TrqQOvdrR44p5SIai4dP6O+?=
 =?us-ascii?Q?QFa/Us3i8CG66qlKlwPGSCFOgUDwAlRFgXrf12gmVaol3DULsY+ezYV/Cnqu?=
 =?us-ascii?Q?qV47t1i3/QHlcNWScAWBq/mOp1GUUCK8em/FRZ9l1kffL76Jz9tiL4VcAle2?=
 =?us-ascii?Q?ZcPfQOqyrLZcyqs/Ed0mqF0J244turjuIueAedtrdcC83p+RCyRe6jv9Rpqq?=
 =?us-ascii?Q?vajaQjj8hGG78qkyL7lIphwn+oLIcFZLu6Qm5nZQXZ6JbG0j2Gw9w0lGJaXb?=
 =?us-ascii?Q?wRwJGuIRK7H/IlHuR/yKTr54QrFzhG8/jIjwAuRzjR+bGTSP5niOgOWDWMnC?=
 =?us-ascii?Q?cKEKhPN9bFRMFpjzsbY1LsKJLDD9uGVPEBAyBbMd7dLQQazS00+JN0rwRxO0?=
 =?us-ascii?Q?FIc8DmfjDAzBVRzWP0bNy36QfxXSgM5YTWj064CzWJtO4NAwGzZlhCFGswIr?=
 =?us-ascii?Q?MV5zPXqrYY1U9Dvay+qcPZw8cfjFHp+ysRnPA5EVtvMy9XvghBamEZpWHuDe?=
 =?us-ascii?Q?G0sMDgFL64X4ruRcpOLvtL9cIYGtevTMi2kWq9DxAeV79NRJfgflYI2sDzEC?=
 =?us-ascii?Q?gXnFEzN+r/KplzYxfxaQ2NhqHFtI1lzYYgYi5e0bJ+9r64i9q9HJcSFBxvPh?=
 =?us-ascii?Q?xVCAL53gsX3Cu3w/gbrigrTMPREUKB9hyw5R3W4vSzLH6GTbUm8Ndrv640AN?=
 =?us-ascii?Q?2DhkP1AgiEqVAvE9txXtPIR1JsjBd1F/5KcEpLBxJFLUBZyt9tYyf+P8SAYR?=
 =?us-ascii?Q?nY0BU9V+QwmvL2HrTU/5GM8nMRbcUrLo6yzRHAd0/QoXYWywTHXsJFmBgPdG?=
 =?us-ascii?Q?JRvFFpgawF6GMSlaYsLFBQTVC7IH2NfG7kJ590UBW3WljRMPmbr4T0WbKqeb?=
 =?us-ascii?Q?XV0wug2gHUutt3XLU+QBjWcfIwXbzKAoH10yFD0jY3CNXGLDRaiHEOv47Ym4?=
 =?us-ascii?Q?fC9KqMN0cN5tItOZzGMez9LsAZEHw/6D42msaIilNW+mJmlBFyD+Yc+AjvEl?=
 =?us-ascii?Q?hxZ7zD1ybkGFbO7FS8PqnXS2xwK/OI2w9I8dDLnG9AaM5PlAPcpOBJQePH7u?=
 =?us-ascii?Q?WHyahaxj80jmh+fS9ldznCY3Zq71b1ZRcdjGYHzNKaxNaplDzLXemFdOXWBg?=
 =?us-ascii?Q?RoDBqZSWWAVUbCvQ78Q0ifguM20EanCPTuqhfoX7Nmj9WWbeCudGW5d06uBZ?=
 =?us-ascii?Q?RD/lWVFu9/brMeTBlwDsPDd7YW+q6FLfjzio7AYwJix1uNL8PzUNMc6LoGM1?=
 =?us-ascii?Q?UNiYL6l7Fda4jUqvvD7bd5t+8UgJHvnIjan6YNQ7VTDxzQaigSQPRME1TsVk?=
 =?us-ascii?Q?nbNlSPhQDBUsoJg+qVXWiNQJZuw22LF/UfqNk0kPux9l9hx9QT24oerDwQoE?=
 =?us-ascii?Q?HCL+uyKPFvYfUYiNHj/iQcGyKIvCJikwDzpiioBzXf8wLx90V8Gh2o86IG/m?=
 =?us-ascii?Q?ZI7qqRlEOuU7zZwpIHfURCn73Q2eWhwZs25kBb/sdvSpMEf8UlqHkGc7kfOm?=
 =?us-ascii?Q?DdDWLcaa3csbamuWmiUOg57Dvz2/r0LkLpLLX8dKRJXScPlm9zUIxK30a5IO?=
 =?us-ascii?Q?42KQKGF99WslLJH96mHoMp1LErXSBKJ6ZQSqZbkEff63gBRmZ4vv7wH45Hw8?=
 =?us-ascii?Q?vSjwlVqAQIDsYijKBllrk5JHrQJOk6d98RUdEwEixmse7oQ0iff/?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: d1f9cb40-56b5-4aa9-3d40-08df3830a749
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2026 15:56:12.6755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ahgSE2ym1+NMF9eDegk8KRYW6AxVurF4HOs9CrzcR/gu9OXH9iSKOv0I06IbqN63rtDQnikcwPQRRzJb+yi+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB6586

On Sun, Nov 01, 2026 at 03:57:06PM +0200, Avi Weiss wrote:
> ntb_epf_mw_set_trans() and ntb_epf_mw_clear_trans() discard command
> errors even when the endpoint explicitly rejects a request.
> 
> A timed-out command may still complete on the endpoint. Propagating
> that timeout can cause callers to free DMA buffers before the mapping
> completes. A late completion may also be mistaken for the result of a
> subsequent command.
> 
> Record the first command timeout and propagate MW command errors only
> while completion status remains reliable. Preserve the original MW
> success-return behavior after a timeout to avoid releasing buffers
> based on ambiguous results.
> 
> Fixes: 812ce2f8d14e ("NTB: Add support for EPF PCI Non-Transparent Bridge")
> Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>

LGTM. I think this is a nice improvement, and the points flagged by Sashiko seem
to be pre-existing issues.

Reviewed-by: Koichiro Den <den@valinux.co.jp>

Thanks,
Koichiro

> ---
>  drivers/ntb/hw/epf/ntb_hw_epf.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
> index da7fbe1800656..455bcefc7c13e 100644
> --- a/drivers/ntb/hw/epf/ntb_hw_epf.c
> +++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
> @@ -102,6 +102,7 @@ struct ntb_epf_dev {
>  	struct device *dev;
>  	/* Mutex to protect providing commands to NTB EPF */
>  	struct mutex cmd_lock;
> +	bool cmd_status_unreliable;
>  
>  	const enum pci_barno *barno_map;
>  
> @@ -148,6 +149,7 @@ static int ntb_epf_send_command_locked(struct ntb_epf_dev *ndev, u32 command,
>  			break;
>  
>  		if (WARN_ON(timedout)) {
> +			ndev->cmd_status_unreliable = true;
>  			ret = -ETIMEDOUT;
>  			break;
>  		}
> @@ -156,6 +158,13 @@ static int ntb_epf_send_command_locked(struct ntb_epf_dev *ndev, u32 command,
>  	}
>  
>  	writew(0, ndev->ctrl_reg + NTB_EPF_CMD_STATUS);
> +	/*
> +	 * After a timeout, a status may refer to an earlier command.
> +	 * MW callers may free buffers on error, so retain old semantics.
> +	 */
> +	if (ndev->cmd_status_unreliable &&
> +	    (command == CMD_CONFIGURE_MW || command == CMD_TEARDOWN_MW))
> +		ret = 0;
>  
>  	return ret;
>  }
> @@ -485,7 +494,7 @@ static int ntb_epf_mw_set_trans(struct ntb_dev *ntb, int pidx, int idx,
>  	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
>  	struct device *dev = ndev->dev;
>  	resource_size_t mw_size;
> -	int bar;
> +	int bar, ret;
>  
>  	if (pidx != NTB_DEF_PEER_IDX) {
>  		dev_err(dev, "Unsupported Peer ID %d\n", pidx);
> @@ -509,19 +518,19 @@ static int ntb_epf_mw_set_trans(struct ntb_dev *ntb, int pidx, int idx,
>  	writel(upper_32_bits(addr), ndev->ctrl_reg + NTB_EPF_UPPER_ADDR);
>  	writel(lower_32_bits(size), ndev->ctrl_reg + NTB_EPF_LOWER_SIZE);
>  	writel(upper_32_bits(size), ndev->ctrl_reg + NTB_EPF_UPPER_SIZE);
> -	ntb_epf_send_command_locked(ndev, CMD_CONFIGURE_MW, idx);
> +	ret = ntb_epf_send_command_locked(ndev, CMD_CONFIGURE_MW, idx);
>  	mutex_unlock(&ndev->cmd_lock);
>  
> -	return 0;
> +	return ret;
>  }
>  
>  static int ntb_epf_mw_clear_trans(struct ntb_dev *ntb, int pidx, int idx)
>  {
>  	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
>  	struct device *dev = ndev->dev;
> -	int ret = 0;
> +	int ret;
>  
> -	ntb_epf_send_command(ndev, CMD_TEARDOWN_MW, idx);
> +	ret = ntb_epf_send_command(ndev, CMD_TEARDOWN_MW, idx);
>  	if (ret)
>  		dev_err(dev, "Failed to teardown memory window\n");
>  
> -- 
> 2.43.0
> 
