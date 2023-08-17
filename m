Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC5B7F9
	for <ntb@lists.linux.dev>; Thu, 17 Aug 2023 06:38:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UfR7wjaBfs/5mKNf0HjlDVhvxWJgbtrxLkSw+Aa+6mwjtgd2rlwEI92I+qMN4UD6w6f+s0UTrfSbZMqcLSY7WZ6dxePx0ypGFEx+zrBPNHEj/7jc5+YBa+64jIw7shyV7eNCuEKnCvRaIkYcZrT+LAmkt6kc5oMF0kX2peFZSHsGtWSaYyhax/bo2cNNEdJkee4tvQZo19AT/IVP5eNJ8aN2TkZ+CXM7g2UT38iTyEYxRZ9RKanS4iuO6PW8rdvq1/Ka4dm0FVMRhN2sT3KaYy8cv4nWKK3DSviOCpnnK1e0mIgBYEyPFSwpZR/v5ddP39OI1V1OhYcS5+kdoBL40A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y8cw50qIhfDV8cVU28xx0rY+YanT6FFC1cl5jKeSNd8=;
 b=IkWce4y1EcNSITP1IWnEnh5FMsC0BNOCzPp49uPHIVGatjuZES8rUnX3cUVG4xyb/0kLI14QvqSAQTvsmhlPfxR58cypV6jdjE77MVvNEf7AEGoeNoBmKYyoQL29FWTju0PlogyDgiZYLDNCL4ospecdNyv4WGpYg5Fmge3l0DrUVB0okNucpFCBpb9pxGvp6auvJdZTeU0IT28GZ/2anu4dLnZlMTeqgBouYBA40xePkULDClrMoskxkatzo0kx/Jqg4G4+3Mur3F9B7VkUS3Xx4QbV4+iEoA4Gt0NpdIAyW4wfKYZlboHkZJjgdJ821o3mlIDpq1DxBTkIrZjr0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y8cw50qIhfDV8cVU28xx0rY+YanT6FFC1cl5jKeSNd8=;
 b=XUsn9xC2H2P0F3b//bsBBNNf+yJkVl/ZbpBiZZvZyNnPun8CRFu5MOcpnGrdc3vMdTawJ5kju2wHCjQSSXsiKwMMtY36oyoK7D/8rM/WFv532aIEg6FtvYKKYIOXfRTh/g7tdL/MeVfuKz3HcCHtyDGqNRf/Kn/zmYtw029y85g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6326.namprd12.prod.outlook.com (2603:10b6:8:a3::15) by
 DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.31; Thu, 17 Aug 2023 06:38:22 +0000
Received: from DM4PR12MB6326.namprd12.prod.outlook.com
 ([fe80::56a2:c9a6:ab3a:36f1]) by DM4PR12MB6326.namprd12.prod.outlook.com
 ([fe80::56a2:c9a6:ab3a:36f1%4]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 06:38:22 +0000
Message-ID: <b973e79d-916f-5487-e9e0-ef870d009925@amd.com>
Date: Thu, 17 Aug 2023 12:08:09 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH -next] ntb: amd: Drop unnecessary error check for
 debugfs_create_dir
Content-Language: en-US
To: Ruan Jinjie <ruanjinjie@huawei.com>, ntb@lists.linux.dev,
 Sanjay R Mehta <sanju.mehta@amd.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Jon Mason <jdmason@kudzu.us>,
 Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>
References: <20230817063219.279315-1-ruanjinjie@huawei.com>
From: Sanjay R Mehta <sanmehta@amd.com>
In-Reply-To: <20230817063219.279315-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0149.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::22) To DM4PR12MB6326.namprd12.prod.outlook.com
 (2603:10b6:8:a3::15)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6326:EE_|DM4PR12MB5136:EE_
X-MS-Office365-Filtering-Correlation-Id: 72bcc738-cfee-4e48-c390-08db9eec8d5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PU2SZf5StWxZjODv0OhZNG5COHTWHSP81VltiyfjIYszZjGhPu1ZA5ElDvd9HN+tcB9sqnVMRDFGnuObxnoFNwejfUar4AQbJ2PS1LPkxd5JmTD9UacJOtuViWm09rU8vqTA1qxlKY0jEQNi4upYhGa3IsGgzVd5369ByYT2bxH8oDkAKrM4nY1AvwRp3uE9fpiniVLhm5TU7IRV/BKJ1Wq1qEVlZHhddxBchAkRUfvluI9VBnn0Xtv/PqrgViwUs6yKTjTTacRqmCiHZverjGbH2NXKtGZAYgI9El+ghNam2EMI18w64rc/TwDOlBsz889O0dGxjS0tlvQDzaDuJjViFO1MoeFDcsd0vga3ZxNTzTmftNbs2S7f/va1Feu3HsBOvFWP83jJPSjFRFZhq/iH9p3Mb/G8s4Sgc6raYEX5LuJg4nbcCASimC6U7nnbNa/uheWPMI7IWwN6udliYy4Is3Br2vFCtE5ynmCX05bwfleWbSKEOEWtqMjRkVvF3g2hUENJUCdauf52+cDQnS6qQPXlZfZKPnhCuXTyI5kFUW13F9wTrrnlThBT+Lfy9ykCqtxqIejL+/Qg7Ue4mw18wSkzTs/t8KvhS8Ht/+5483O/IA+QcjOX6vEk6JK2K+O165phJtLrhJdehyih7Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6326.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(346002)(396003)(376002)(451199024)(186009)(1800799009)(110136005)(66556008)(66476007)(66946007)(5660300002)(2616005)(41300700001)(2906002)(316002)(478600001)(8936002)(8676002)(31686004)(6512007)(6666004)(6486002)(6506007)(53546011)(36756003)(83380400001)(26005)(31696002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cjM4K2NJR1p2a3JjMWhGcjZvSzh6L1FEVzlJRVhzZk1nK3F5cDNya2FHYjY2?=
 =?utf-8?B?TE1rQXhvV2JTVjFsV1JPM2c0S2VvSU05TElXS2F5NzZLdFdsbXFoK0g3cW04?=
 =?utf-8?B?NjRzVlZ0NGJwS3Z0RzRja3A5V0ZBc2JDY2hHUXExL2RlTElaQWR6dlpKbmNl?=
 =?utf-8?B?TVhkK3hsNmVrSmpDZGVUV3hHNFpJL01iVGxxejVDNzVFRms2YnNQSFJSTWR0?=
 =?utf-8?B?UGJVeEMxcG15MEpZQW1tYXJqaUNoZENpdzZmamFLaXFvYWx1WVFNTUlhU1ZP?=
 =?utf-8?B?NENrc3FFaENlODhCU3MzVldVN2FtaU90eGJxTEpQVnhsS3BKSW0vR2ZDbU1F?=
 =?utf-8?B?NGsvWno5SlhTZXZNWUR5azlNR2pyQkZmdnM4akkrck9taXhnZjJVaXpvZm9W?=
 =?utf-8?B?akNTd3ovaitnSjVnUFJUK3VkUWRaQVZtajRiY1FYS0o5VzRYbmhTSlorWXcr?=
 =?utf-8?B?elArN0k0UTBGb3RmVXh6L3JPeWhEN0VBcmNyaGZYbjA2NHdabDJ1VCswaTNn?=
 =?utf-8?B?YXZVam5rZkhmeVRVYjJ1THRoOHYvaGFaeW9yNC9zWW11TmVtTUgxdG90SjRD?=
 =?utf-8?B?WHlQL3BKWXU3YzZxUXh6RTY2RUdpbDVLWHVSbVdkcUtZd1E1a0Npemp3L1JL?=
 =?utf-8?B?QnlHTU1LaEU2NThOaWZjTStRQUdOQmFhL0w3THJVNDB0UmR6VFlCUjFuWkZi?=
 =?utf-8?B?ZjJ2cUlyRWhGT3pkZHVCc2U3ZjMzcGR1THpnTzZReE0ySnJkWkdaakcwdmxn?=
 =?utf-8?B?bG5Obk9UVU0rekpnZWpKVzZGbWVRRlo3eUtkc3N2L0lxN0YwVlJjNmpIMm15?=
 =?utf-8?B?R2hKUUJKK2syZ05PczdnZ1BaOXNoZWM3OVA1cHVEQVc5T25ZTGZ1ZUloaXlN?=
 =?utf-8?B?U0hqb21GQ3p4SjZVczJHOTB2QzdZTTUwaGU0YXdPYkNuKzdVNXRaOW9RRmUv?=
 =?utf-8?B?R1F1dHhBR3FqdWVkckNXdmhqZmI2YVlzQXJ6WVE4TTVMaDRZYlJjbTdBdE1C?=
 =?utf-8?B?UjJFb3o0N201MmhLWVNhcnI0TE0yTkFrYVVsUVR3QUxCYS9Zd1Z0TExxSExZ?=
 =?utf-8?B?ZTdrbEZXZFAvWTJHNGxDODZLTllYdDFiU2VQOFdGUEdHVGdLcFdiOW9rMUo0?=
 =?utf-8?B?RmNNelRyOE5nYzRDVHh2RVp3YmNtaWd2M1ZVWE41QVVBckgwSnNZMndrakto?=
 =?utf-8?B?eHliZngrdDZYc2l0Zi9DcXl0RzBvVENMaDJ2V3RzbURPS2g3eEFiTXQrejFn?=
 =?utf-8?B?RXhxZG1mamJZRUpmU2Q3bkl3U2g5MFh4N28rZDhKLy9Nc0U5eHMxV3ZvdTRl?=
 =?utf-8?B?ZS9ETi95OXVIVkpBYWtKS24vWVZjcTNKcUVLN0hRRE9nVXpkamNZWFBUV3Bt?=
 =?utf-8?B?OHFLS3pFd0FkZStjQUo4cm9aQ1NWajVKV1c0anhvOGxScERCRjFsTFBIbUdG?=
 =?utf-8?B?YkZ2QitzVmJjLzhVVkhwbWpXd2xvZFJnMHJjY2xzajdNUkJtdFF5SjZQdXlp?=
 =?utf-8?B?ZE5BWkNOMmV6TEJWTDRUUVJlQlRUOUUrRnJnNXV0eHZDUUMrMklMYVhGSGlE?=
 =?utf-8?B?OHFxZDdaaktKa2U4d2tEOTloRENNbWJzaXV3RnBoOER1cTdjS3RLNDBKZXpm?=
 =?utf-8?B?bkRqZzJsdXZzUzJxc01pMDJMcGlLZE1YZURqQlBzeEMrVDl6Q2hheVVjT3Rq?=
 =?utf-8?B?OHFDanlONkFCbmw0QXJ1dDJ6TFNJVHBvNHNEa0JWNllSN2l2eTgwR3VJdnhC?=
 =?utf-8?B?OVNsUnNZOS9vbFZZOGRtMFB5Smtpd1lYZ1dqdG9CcmpaV2Z0UW4yWmc4NlBG?=
 =?utf-8?B?VHl4SDY0WDBkcDc1aUtiYzFQekRvSWh3dTQ5MnZ1Z1VTNmREUXMzR3lpNnNl?=
 =?utf-8?B?LzJ0UStjUnJuUjJLWDZPbVFLZTJ3R1NFZnRnbE9HSVAxeFE0Y3hiVlM5aWFk?=
 =?utf-8?B?RGMrcWdyK2FURkVnQjZXQnhDMWdlQkExVVZjSWFlZ0p5UnQrL0dsMDJBWFM3?=
 =?utf-8?B?ZXh4eVA0bVBWTTZoUVRJMUpxVUU1OGlXT2lzdEp3dTNOa1pwTC95UStISWtJ?=
 =?utf-8?B?WWhqVzF3clFhaXlhc3ZZTjMrLzBhcFRrT2N2MFdXUjBWSUVxbUlHaGNFRUFV?=
 =?utf-8?Q?FFxxaxfyKOBDxNXBNuBWTKdOA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72bcc738-cfee-4e48-c390-08db9eec8d5b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6326.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 06:38:22.7609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 335jAUswkqgfntuKK9H3FXk3D6N83W+B1kxTDOX/VDcPGZRNbzkYs3bMVgp/jqXauTmVI8pgCyXZAGioIheD6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5136



On 8/17/2023 12:02 PM, Ruan Jinjie wrote:
> This patch removes the error checking for debugfs_create_dir in
> ntb_hw_amd.c. This is because the DebugFS kernel API is developed
> in a way that the caller can safely ignore the errors that
> occur during the creation of DebugFS nodes. The debugfs APIs have
> a IS_ERR() judge in start_creating() which can handle it
> gracefully. so these checks are unnecessary.
> 

Acked-by: Sanjay R Mehta <sanju.mehta@amd.com>

> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
> ---
>  drivers/ntb/hw/amd/ntb_hw_amd.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
> index 4940b6301d83..d687e8c2cc78 100644
> --- a/drivers/ntb/hw/amd/ntb_hw_amd.c
> +++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
> @@ -941,13 +941,10 @@ static void ndev_init_debugfs(struct amd_ntb_dev *ndev)
>  		ndev->debugfs_dir =
>  			debugfs_create_dir(pci_name(ndev->ntb.pdev),
>  					   debugfs_dir);
> -		if (IS_ERR(ndev->debugfs_dir))
> -			ndev->debugfs_info = NULL;
> -		else
> -			ndev->debugfs_info =
> -				debugfs_create_file("info", S_IRUSR,
> -						    ndev->debugfs_dir, ndev,
> -						    &amd_ntb_debugfs_info);
> +		ndev->debugfs_info =
> +			debugfs_create_file("info", S_IRUSR,
> +					    ndev->debugfs_dir, ndev,
> +					    &amd_ntb_debugfs_info);
>  	}
>  }
>  
