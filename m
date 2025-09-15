Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010028.outbound.protection.outlook.com [52.101.85.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D89D30B52C
	for <ntb@lists.linux.dev>; Mon, 15 Sep 2025 12:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757939174; cv=fail; b=CRsMzQ3xIfk/Z+7SUHH49D9hVl1vrUQCeLXFYVwCzIPtgO+YgmlhxUja6HTHwpLVxANwMDIpwdc+gk5ZkTQ8x2ZuMEeEmw7gFRSvZyz4yHAaaEHNc2UbVw2Pru7bj5xYc2IFnZf2pklqltdmoupH+sLnQBOcJPEqLr9HAjbwHDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757939174; c=relaxed/simple;
	bh=pjbwjwQwSO+OIG9ZCpgIIrmyDkmk/uOdUnGua4tHlb8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WvGUFIh5/sgzN6OmGjf05Lsx+RednYPv2D1sQZYZcN/P6om0sdE5hXqytVM91SIKwILI2/EO696iX78EnPLiAspw10JMHXTgkAmDuQioLJu6wC944VJxhNKFcujW/YFCbvUmFx8DV4YnQqa/dpnoY/Kfxjqhl1cJFoFwUCMyq64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Kc0EXfWt; arc=fail smtp.client-ip=52.101.85.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Kc0EXfWt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NQG3aGaD2r4c1RLdSk+FiIO5EH+CbR4c1diEOZx7tLqIwVynA4aK4LfrsAoR0Ag92+4t/YtkLjt7fTyDP+E+r2WfelPMZYbnODfWuIqEfayTLAAhA42DH4fFnNC9W+HPOQhN2VrvH02wD5ayTndA71N5wLaaSSSw57vrAX/Y9RSHb5p7JaVeoJb/5mmeGtqkSBemc2BQ6Z69oRJFyBQ6kj0b2/ePNvP27IyzaSWsU4JVEgn5WZXuwXbnk2j1JpJK3+OLNacfOyR59nBkDjW4FTnKbSsPXVRzc2M3aDnTSYT12qSbsB37LDVgda/3tfeGYQHYZ8WATEh65evc9H0R3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKpQMNjY4ChB8SkuXzLivjjLe6DLxj90S23Thtn4me0=;
 b=yM6r1xzOc8XhdYoMWUJqaXYc+xoUDKpxe1HDB2BVpcecAzTk+HeHU4YNs9+GYPei68dGnxrqdzhltGUl92zXA9qysd8vY1eYUfhINN1r4ROyBvjLftxq1QHAAYgj9mhJ+xAU7yZad1GUJXlQkVCQb/eJ1iyGBwyehBUg/kgD4Vowpa8kuvFvXuXmxndTPzkpmm+ejXMQUo6FjD1qOxJVTlWX/9ltXfOcLPB/6xRJiJxlrJR8hqlh+tMvVkvMOsLhitGlv+tyaxuyHWm6Qg57ZloxbpJa87txn1BCJ3Rs5YgaMsqCE64/JF1D/xE0Vpl3WCPgy4+Q3tgYdSe0E1HRsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKpQMNjY4ChB8SkuXzLivjjLe6DLxj90S23Thtn4me0=;
 b=Kc0EXfWtdH0Lt+wqCIj7pUYqudHcmEHVvlw5TL3/zcPeGzjg3tu4FEfgT30QAAwvb3yH1nA7db1oKzwTHRuY8Xe8BijzuW/a/mOB4/fJpTotwQiS+1fW90U0PPuMK//s0+FQF50LtXxbhQYjGGCkrQaUnqdBHbX43lInsVzFQdo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by CYXPR12MB9277.namprd12.prod.outlook.com (2603:10b6:930:d8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Mon, 15 Sep
 2025 12:26:09 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::a3dc:7ea1:9cc7:ce0f]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::a3dc:7ea1:9cc7:ce0f%4]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 12:26:09 +0000
Message-ID: <4222e068-b5c6-4bdc-be3f-4d63900ff364@amd.com>
Date: Mon, 15 Sep 2025 17:56:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ntb_hw_amd: Update amd_ntb_get_link_status to support
 latest generation secondary topology
To: Dave Jiang <dave.jiang@intel.com>,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>, Shyam-sundar.S-k@amd.com,
 jdmason@kudzu.us, allenbh@gmail.com, ntb@lists.linux.dev
Cc: Sanath S <Sanath.S@amd.com>
References: <20250912102604.765444-1-Basavaraj.Natikar@amd.com>
 <20250912102604.765444-2-Basavaraj.Natikar@amd.com>
 <500ad0ff-a924-4323-b6ac-4be4ef695e36@intel.com>
Content-Language: en-US
From: Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <500ad0ff-a924-4323-b6ac-4be4ef695e36@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0117.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b0::11) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|CYXPR12MB9277:EE_
X-MS-Office365-Filtering-Correlation-Id: cd2b4a1f-3b8a-431a-63f1-08ddf4530bcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q2NJTEVNTTAyaHNiRE84M1I4WVNjcVNBMldlbVB0UUdmM2VaQzRZdVcrZlNF?=
 =?utf-8?B?MzRlQVo4a0JGdHpDaXZiRkV5cEJnTTA3ZEZnMXpPT1ErTXBVcEYxQmMyNkxW?=
 =?utf-8?B?Y0VzNDV0aDMwTDEzSi81UTIvbFlaY0I4Lzh6N3Q1SkpWNDRxNUR5d3hTR05P?=
 =?utf-8?B?NUV6NER4SHBVUFN4T2ZhL2R2aGs2TmRQY3AwY3pTa2ptMXFWMkNUN0pWdW5G?=
 =?utf-8?B?UWp6K1lKMDVFenlNcjlRTzNQbWREQit2T0hIenFzckhibGMwOEhxcW4zZUVK?=
 =?utf-8?B?V3VtNWc1TWJmWVIzUU9KVDlBVi85MXd2Q2Z5TVlJTTU3dWl3QStkVEQ0MGFz?=
 =?utf-8?B?QnhwSDlhanQ0cGFOVUJ3L1Bhay8rR0NkL1dMb2ZvRFg5Vzc1UFpONER5cDc2?=
 =?utf-8?B?eTNBOEtTajNEOHRPd2lqd3ZiMFlNcU8xdUJTeXE2VjNrR0orSGJyTzJRZjZj?=
 =?utf-8?B?eWhEUnFxbkJITnNLd3RCTnMxZWJWTDBMMnI4aGJNemVWblFVVUZuZzFIZUg1?=
 =?utf-8?B?c1JUbVFIakthdDQ5SDFTeHdMaTNqeEdja0FsMDJiWFVEMnFFdEZzWnJweU9W?=
 =?utf-8?B?YUJqMzloQzIzSGpHWUpiRGFqTlJ2aUVGZzRnUW14a3hvcm5ZN1N0VlR2MnRp?=
 =?utf-8?B?ZTc0WkZyTEs5UXpZSktqNUVjdHNkMXc4VjdkZmNiRDRDZFp5NEhzbGMzeFFt?=
 =?utf-8?B?bGtwT0VlY0ZwWnZUS1hOUzRveEJDaHN6OUpvczBNWjBhSlZvc04zZjNYV2d4?=
 =?utf-8?B?ak16cDRCcC9kK2JPcUl2NXRDc0NEc1MwcjFaWC9JS3RTS0NnbERzRm45QThp?=
 =?utf-8?B?eDJ5UHBteVFycURUWXhvUFVDNDIrcGo2UWVFZHVWK1JzN3FTczg1WG82d3hs?=
 =?utf-8?B?ZnBUWWQ5NGsvSkVUQ09lTG5ORE9yYjExaEdGUVdkVDR0SjR6YkZ5ZGdoZ3RO?=
 =?utf-8?B?eGxkdmovaGdRQndiYnJKejRTamtCaUtIRUt5V1IralMxQjVyVXFlL2Q1WnJJ?=
 =?utf-8?B?U3c5RFZYb29ENHJuOUlJd1p3c3p3NXJrYkxjQUVLbWN2ZW1UdVorbWMvTEtU?=
 =?utf-8?B?S1lzVExLQUxZT3JQeTdCWmlyc1VSbWRiMjdsR2hUWmVhTExhVmtYRE01MEpr?=
 =?utf-8?B?LzNVYXpGelhPY3NuVmFIOVhLeFcrbUozWTF4dlJNd2l6SlVEczJncnQvaFho?=
 =?utf-8?B?ZFBNeXViZE9Qdzh2NTNySlpWWjgrRE8vRk15eWxJMWhscWxvSlJUUlk4YU9a?=
 =?utf-8?B?TGg3OE00emgyVmgxL2M0Z2VENEVrN0V6OTNUVWJmak5xY0pLcUY0aFFnTlBr?=
 =?utf-8?B?M1VFZkVUTFkwRmt2MkdERFhxMGRXQy96TEdPRVM0ZGthWHpVdDJ1UlptVDUy?=
 =?utf-8?B?UFVCbDNoN2RGZEZHZzFBVnpOM1RCOEJ5cnJBZ2F5MHp3azd6MGlXOXFEWUFF?=
 =?utf-8?B?TGt6dzlBajMxSXB5Lyszclo3V0JRazd3UHlsZW9VbE9VNi9LZTdiN0liTFd4?=
 =?utf-8?B?WGFFblM1QlNTS1RCNW1nL3NLRlBtdTg3blpvekJEUDhVelRtemtvRU1uSE1W?=
 =?utf-8?B?aVgvaTVxZjNNOGE3QmVadW5rRTBvOTB3NXkxQUN0R1ZWKzIyVjMxVEwyN3Rr?=
 =?utf-8?B?TWJSbjVTdFg1R0UxY0lQMkFzTGZUY0VNR0l2U0lVMURYRC9qSFlkNEdwVHZ0?=
 =?utf-8?B?bk5zVGJzdHZUcEM3aHpjRUtITnAwQkZNZDNHbEVWS3lLdi92emJzS2JJR2Rv?=
 =?utf-8?B?VXVwWnhLMUpaWHZ1UXdiZWt1V0d4WWRSZUllVGhScjhSbUN2SisrWkxvd1VG?=
 =?utf-8?B?UXlZaGVmQTZWejJOOHlpY1ZtYWdSTGpibCtoVks3WFpCYXB6TFpTQWFtWEov?=
 =?utf-8?B?UFd3NzhJenpIZGUwV3VFRWZnT21jQmpIS0VYVkVNTlUvYzZRdU5xRUx6RjhM?=
 =?utf-8?Q?E85KI1Lqubg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NDd3N2N4eXg2ZVlJMmFyVWVpUWthSjhYbThSZlk3a2tVS1Q5MUo0VGlOeksr?=
 =?utf-8?B?WlFWYjJNQUZpWHRJVmsvZWNJSUM1TWVRUE5VSStFYWRRNE5EUWZaazh1VlBH?=
 =?utf-8?B?UDN3K3kwN2E1NWc4ekxSejdwYmZUdzRmUzlBL1FRNzhVR3NjYXp0QndyS1JW?=
 =?utf-8?B?NkxWZ0kxVVRkUWFOby9TK0ptYndxSlcxd204YmxjdFFlaitlVmNPeUVWM0tH?=
 =?utf-8?B?czRubW5wRmhpY0ZLaVVnVmhhUjlmYWNFczBLVVlmVEhCbEpiWEZsOElRejZ6?=
 =?utf-8?B?T1J1THRISm9iUGk2c3dNYTJQeWRmNGU3ZkN5MjRlMnR2Q1NPVm1VSTRTRDFJ?=
 =?utf-8?B?WjVwVTdhYU5BSUJTN21EQ1RwZUFqQUU5Q0FQbW5yUTZEOVRxWGxCdCtGR0pC?=
 =?utf-8?B?WjlkbUp6QkJQWGdxVVJDYS9TZWpXdDRxYWNMVEx0eVVsZ2gzcVNKL2lwdHd3?=
 =?utf-8?B?RHFOS0d4YTNlb0puejlGS2hQcWFhemdXQVdDdGhzbXBZaExnaDg0VDVUSDdW?=
 =?utf-8?B?UUdwK2RrY1paMTM4bmJmZ1Y5bCtEZVZoVDkrQmdoY2ZKanBidnlBemw3ZkE4?=
 =?utf-8?B?ZWFhM1ZNckg2OGx3MWtUR2V1NGdWMGgzYnhFdndwRzJSTnZveUtBZzc1UWdJ?=
 =?utf-8?B?d1A0Rzh5OWtMN0laY1FNZjRhQ2IyOGQ4NGR0NDF1MWZ0eXY5OEhtTTBKcVVD?=
 =?utf-8?B?aTUyTDZRcGhFdGZ2cExlaktmdWh4ZGx1Z0RjVnBwUDhxbXJFN2xiaXpPRE5Y?=
 =?utf-8?B?QmtZaUplbmNtdnhFaC9wVHo1UEpZUFhsN1huYUFzckFZcXdhNzV6RVFXRFJr?=
 =?utf-8?B?YjRkZGhzU0RUMGo0OGdMRG91eXFEcUsxWmZxeGFiUjFUTmlTUUxTSFlTNEoz?=
 =?utf-8?B?VVJ0SGora2pmbFNOTE1nTldMbkZoTHNMQ0FsUVFBZ25pREczUFBZYzVOeGox?=
 =?utf-8?B?YVlxMjZBcjRET1Y5Z1JYZ1FXUVlaS2M2TDFWSXQvVW9TaHNmenR0VTRxMkdZ?=
 =?utf-8?B?aFpqSXFwU2Z6L3F4eFpOc0o5ZzBYdFN1MGNmM05XZ0hrQ25ZeFJhOTFubUpp?=
 =?utf-8?B?UVJ1MEd1Q1VuYk1DU0hpeFYwVFlsYzlIZXg5cFRzTHdoL3RndVNubmRGYWdF?=
 =?utf-8?B?V2gxeTl3MWJ4YWpDU1Exbk5BVTRvbHZNek5STUJjQ2JRTWtmYkxQdFdZUzk1?=
 =?utf-8?B?SklZNFhlQUJVL09kQmxLRlBWa2d5a0JhRDB2aExHQmZXUkJlZ29sRE5STkww?=
 =?utf-8?B?Ri9pQjJzNTJ4SnJSa0h0WEZISG1HOFBiVDFrVlpjQ2pIOVBZRUlCK20zajBk?=
 =?utf-8?B?MVY0SkNSQ1FsY3d0VHpuMTZmVUs2UCttaDREOFUzU25VYUNwS293YjBmWU5S?=
 =?utf-8?B?Sk03L1laMkdFajB4NWgyRTluN3ZLQXRTczlmTmVnQUltQnFmMjFtRTYrcnla?=
 =?utf-8?B?ZWg5UGlMbk5qZ0lKUlUwaHI3UkFPb3pqSzRLNTl5MzlNajJmTGlQZXR5NU1u?=
 =?utf-8?B?dksrZkNiSVJ0MXJSSUxWR0J6NStEbUdlQXNGT01nMm03ZThYc2ZyNEg3bXBl?=
 =?utf-8?B?WnFSL2FCdTlqbFoxR0p0cW44Y1lqT3RLNTlpUGQxZmtVOElDeDJyL0xjNnNP?=
 =?utf-8?B?aEZYUzVDbTJJYUpGcThKMVd2UXphVlFhR2h6eFF1bGI0bTVoYTZ6Vnc0Qi9l?=
 =?utf-8?B?c3JtNXVBdHVOcEJSZ201UVhBQWN3bVRoNTkwZUlrckwwVXBLMVhnM3pVcGx0?=
 =?utf-8?B?WitraURaZWJLYTFkRURJVXM3MDJlYmI5ZkwrWkIvV1B5eVVYbTJ1ZjdJMm1M?=
 =?utf-8?B?Z3dlY2FLd3QzZnRaWFRXY21wc0tWbnpKV09TMkc0QjdqR2hUbkIvNmREN2d0?=
 =?utf-8?B?L0tDTVZCRzNaVHUwQVlJOC9EV0xvZXNyUjVkTDZScHFsNkEyZk04aXYzRi8v?=
 =?utf-8?B?Y0t2WCtVdFdleFVHSVdvOGVWRm85WUY0d0J6ak9nK0NnMVRISE1nUzZpV2tx?=
 =?utf-8?B?WjdSUm9LOVo5WCsycGNHcVh4a3YyRi94OGhLQ3BDelpoUE5Pak1IVE1vSCt5?=
 =?utf-8?B?YVBBT2N5VjQxdHoyRU9oeEJHWlBnM2lhZXl0VGpybU1Ld1oyQVVqRUhtRFRK?=
 =?utf-8?Q?UzPOo8lPtsD94+wJ6g5DDgeBM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd2b4a1f-3b8a-431a-63f1-08ddf4530bcc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 12:26:09.2690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pv/donufNmZ0ER4ZF7jr6g4liJek5F4ba7l86I02s3uwYkES0BbUWLqbS9S4VaBOnYtARBOuIF3+PTA759zNyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9277


On 9/12/2025 8:57 PM, Dave Jiang wrote:
>
> On 9/12/25 3:26 AM, Basavaraj Natikar wrote:
>> In the NTB secondary topology configuration of the latest generation,
>> the device behaves like an endpoint. Hence, add endpoint support and
>> update amd_ntb_get_link_status to accommodate endpoint devices.
>>
>> Co-developed-by: Sanath S <Sanath.S@amd.com>
>> Signed-off-by: Sanath S <Sanath.S@amd.com>
>> Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
>> ---
>>   drivers/ntb/hw/amd/ntb_hw_amd.c | 45 +++++++++++++++++++++------------
>>   drivers/ntb/hw/amd/ntb_hw_amd.h |  1 +
>>   2 files changed, 30 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
>> index 63ceed89b62e..39dfe089bf59 100644
>> --- a/drivers/ntb/hw/amd/ntb_hw_amd.c
>> +++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
>> @@ -197,32 +197,38 @@ static int amd_ntb_mw_set_trans(struct ntb_dev *ntb, int pidx, int idx,
>>   
>>   static int amd_ntb_get_link_status(struct amd_ntb_dev *ndev)
>>   {
>> -	struct pci_dev *pdev = NULL;
>> +	struct pci_dev *pdev = ndev->ntb.pdev;
>>   	struct pci_dev *pci_swds = NULL;
>>   	struct pci_dev *pci_swus = NULL;
>>   	u32 stat;
>>   	int rc;
>>   
>>   	if (ndev->ntb.topo == NTB_TOPO_SEC) {
>> -		/* Locate the pointer to Downstream Switch for this device */
>> -		pci_swds = pci_upstream_bridge(ndev->ntb.pdev);
>> -		if (pci_swds) {
>> -			/*
>> -			 * Locate the pointer to Upstream Switch for
>> -			 * the Downstream Switch.
>> -			 */
>> -			pci_swus = pci_upstream_bridge(pci_swds);
>> -			if (pci_swus) {
>> -				rc = pcie_capability_read_dword(pci_swus,
>> -								PCI_EXP_LNKCTL,
>> -								&stat);
>> -				if (rc)
>> +		if (ndev->dev_data->is_endpoint) {
>> +			rc = pcie_capability_read_dword(pdev, PCI_EXP_LNKCTL, &stat);
>> +			if (rc)
>> +				return 0;
>> +		} else {
>> +			/* Locate the pointer to Downstream Switch for this device */
>> +			pci_swds = pci_upstream_bridge(ndev->ntb.pdev);
>> +			if (pci_swds) {
>> +				/*
>> +				 * Locate the pointer to Upstream Switch for
>> +				 * the Downstream Switch.
>> +				 */
>> +				pci_swus = pci_upstream_bridge(pci_swds);
>> +				if (pci_swus) {
>> +					rc = pcie_capability_read_dword(pci_swus,
>> +									PCI_EXP_LNKCTL,
>> +									&stat);
>> +					if (rc)
>> +						return 0;
>> +				} else {
>>   					return 0;
>> +				}
>>   			} else {
>>   				return 0;
>>   			}
> I think you can reformat this entire block to reduce indenting by returning early
>
> 	if (!pci_swds)
> 		return 0;
>
> 	pci_swus = pci_upstream_bridge(..);
> 	if (!pci_swus)
> 		return 0;
>
> 	rc = pcie_capability_read_dword(...);
> 	if (rc)
> 		return 0;
>
> Also, why return 0 instead of errno on failure?

Sure DJ , I will update changes like below

+		if (ndev->dev_data->is_endpoint) {
+			rc = pcie_capability_read_dword(pdev, PCI_EXP_LNKCTL, &stat);
+			if (rc)
+				return rc;
+
+			ndev->lnk_sta = stat;
+			return 0;
+		}

Thanks,
--
Basavaraj

>
> DJ
>
>> -		} else {
>> -			return 0;
>>   		}
>>   	} else if (ndev->ntb.topo == NTB_TOPO_PRI) {>  		/*
>> @@ -1311,6 +1317,11 @@ static const struct ntb_dev_data dev_data[] = {
>>   		.mw_count = 2,
>>   		.mw_idx = 2,
>>   	},
>> +	{ /* for device 0x17d7 */
>> +		.mw_count = 2,
>> +		.mw_idx = 2,
>> +		.is_endpoint = true,
>> +	},
>>   };
>>   
>>   static const struct pci_device_id amd_ntb_pci_tbl[] = {
>> @@ -1319,6 +1330,8 @@ static const struct pci_device_id amd_ntb_pci_tbl[] = {
>>   	{ PCI_VDEVICE(AMD, 0x14c0), (kernel_ulong_t)&dev_data[1] },
>>   	{ PCI_VDEVICE(AMD, 0x14c3), (kernel_ulong_t)&dev_data[1] },
>>   	{ PCI_VDEVICE(AMD, 0x155a), (kernel_ulong_t)&dev_data[1] },
>> +	{ PCI_VDEVICE(AMD, 0x17d4), (kernel_ulong_t)&dev_data[1] },
>> +	{ PCI_VDEVICE(AMD, 0x17d7), (kernel_ulong_t)&dev_data[2] },
>>   	{ PCI_VDEVICE(HYGON, 0x145b), (kernel_ulong_t)&dev_data[0] },
>>   	{ 0, }
>>   };
>> diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.h b/drivers/ntb/hw/amd/ntb_hw_amd.h
>> index 5f337b1572a0..e8c3165fa38b 100644
>> --- a/drivers/ntb/hw/amd/ntb_hw_amd.h
>> +++ b/drivers/ntb/hw/amd/ntb_hw_amd.h
>> @@ -168,6 +168,7 @@ enum {
>>   struct ntb_dev_data {
>>   	const unsigned char mw_count;
>>   	const unsigned int mw_idx;
>> +	const bool is_endpoint;
>>   };
>>   
>>   struct amd_ntb_dev;

