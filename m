Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2071.outbound.protection.outlook.com [40.107.95.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8267131E35
	for <ntb@lists.linux.dev>; Tue, 23 Jan 2024 18:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706035781; cv=fail; b=Bmrm60onSz7BGCnykrMH2Hv+pa9mMV6OrDODTHG7wvzRMy88aeCCHq2MmBWtwH6UDUXcp/i9HGke0W9DLI2gZIpdNSlD6rlcRhpn4KWCa813CyqZ+i5PNO/X7DQvGn71K5/DvVeo8JiAf7RrXBs8Cl8KTsKFdlTjM86uuXmxe/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706035781; c=relaxed/simple;
	bh=coYoIac++/P/YwdcYthN4oxhLBJqFneHNl/5gEM9bng=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qFcWmBv59dsbfXk07OxpIaeRSILMKpGUHJ2e2ABZPG2bDEz/yEBNHD4PETZe/TfI0PSLe2jN1e7oK6NG6WsJOuj0EudWYOq8qcHJut3meFjxSElvrMHL9RhQPtcHIsbcoikoMJ1hIzu4sYVNubInuSgnYHyvc7g4tJSZk35Fqfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aCnwC0CN; arc=fail smtp.client-ip=40.107.95.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aCnwC0CN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VMP7bvEMlbqTzKn7s7OS6EKCC9CdD064LI436w/op0CWXyT/nqGtql6yPx1PLEQGIaa10PQbqHruUBEObx+CCTZEvj1iFDlznAPEQABVtuMx3nW42ESHsnoZIcyWJOy/Er0e2iDn+o1NJU++NZV40XEpImlSClDwJRQ6SZCEPXWAYcq37xX7UUUVK88IJGeqU5pifbMfFtm8adbZrNAMF14O7wL4KIZKEMs0JR3c1+ySxA3j2r+aR+jLatZ47rstRyth/l6LPmJClkEjAvNImOY0EGlxsBO+j3fcnD3LgFeiPwJf+GxYhyTtpGVhLQYiWHBrzrD1wJMLRxFvogmgJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wpj8yYDC6pfCFT7Kt94TepgRRuKNnWeGNNUM3Ajqf1c=;
 b=AgD8l2r88NASNq9dFEmKP9uMQDYofbRvCDP/YYq+C7XpIxrrloW337MF+LcGSJmyNcXNYWVW145CzHU27fUlHalkBd/rns00ZoGV+CbQRIyo+blsRWuwmiZR4HabHSsXOLC7OUi3rwMIVkP1rQB2X8DNvE7pTu93/lgHhGXl4x+QMCBi9aR2kXUgpgnbfuv11CeKa2+qeZMxI603JDYoBjmvrZNl1BWQUFdNbfEe0Se64OyvdnMr8+/+uvZ8YtzlSc2Z0ksK8EZbXoM06og1i0Vuc5nv0cfMPuuzPNHid3H3h+Zr0M8RpphESo271owe0wu1TzySi0ki9JjZR+Tkvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wpj8yYDC6pfCFT7Kt94TepgRRuKNnWeGNNUM3Ajqf1c=;
 b=aCnwC0CNkZMactMdgeMkTj91Z4W+svn7Ld1qeT11JW0YOujhF+LzGmu5/Y/wva98abqRzuqm/XUyKF3LFf4jGZuPI8XTpSc/02TaHJ6NgYzhSIECNKccvUDZwilk47m4nb+AVJ6T4d6vl++6k31i0gJkBWeusgR4ArntaT6NlI0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6395.namprd12.prod.outlook.com (2603:10b6:510:1fd::14)
 by CY5PR12MB6600.namprd12.prod.outlook.com (2603:10b6:930:40::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Tue, 23 Jan
 2024 18:49:36 +0000
Received: from PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::8f61:7cb3:f051:f790]) by PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::8f61:7cb3:f051:f790%7]) with mapi id 15.20.7202.034; Tue, 23 Jan 2024
 18:49:36 +0000
Message-ID: <caa29dc8-2463-b727-3283-2889cbe210a1@amd.com>
Date: Wed, 24 Jan 2024 00:19:27 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: ntb_perf max chunk order
To: Dave Jiang <dave.jiang@intel.com>, jdmason@kudzu.us, allenbh@gmail.com,
 ntb@lists.linux.dev
Cc: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
References: <7739c789-109b-2aa7-73d2-db833853470c@amd.com>
 <eb872f9f-03f8-4a25-a3b2-e338833a9966@intel.com>
Content-Language: en-US
From: Raju Rangoju <Raju.Rangoju@amd.com>
In-Reply-To: <eb872f9f-03f8-4a25-a3b2-e338833a9966@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0228.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::16) To PH7PR12MB6395.namprd12.prod.outlook.com
 (2603:10b6:510:1fd::14)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6395:EE_|CY5PR12MB6600:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e5f7955-50c9-46db-e81e-08dc1c440b75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	czAzORW7UIbWC13MwKwyJDl4gk0iu+aBeQxO1l9p1TuC1hnDQZm6ozFObbwv/xSzgL+qIp0yYb+o3r0MiLq3uLuHEHNpdK2OOPE+mKWQvt2v75QF7TQdpsKZrs6DI7PnbpZLP1JbI5d3CItPm8M3r+dLWlFlhNYTl/Zl2K1ZGkCMDWKvOgwbQqynncoOBTMiuckwBotb810L0uLM4nRIPCkzuXkrX/CBuH3VC8Qe5ikhLVjAT5qB5T+r1YblbyqygELAYmKRWfRQsCqiNUzX3QkRG8iL1HYuUlNTWSOEjog75rbB+I9D1SfFn6xdrCyhBt5S/FnKoBFIr3YpC6bnScM0aK2aywNzpaLJQHciuggRwKv02MlXorut01WKsBQtwBzQQjUAGVXhUJyx222vDc+qXjZl5/BIbRx455qBUiPfe7BPugoUlqIx8vJ0ScEe0XMhrO9GZHvbs47wqCBJ87c9ITbRZjILb9k45PGIlx5kgNV25RQm49F8WA0giNCz7DSUul7aV0n2t88r1X9DBHmoeZuH6RVyNLXAiblY7BzD3zrR5NI1T2AvAHTF0jU+B0MbX2G5V3W0BFiMslWJERKGdt/gOCZV6wqSXjQpJXAKoIo0WDeH9UUKs2/0GjIa1LiXcmtEHLIlMlRHdLLVkw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6395.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(396003)(346002)(366004)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(6506007)(26005)(83380400001)(2616005)(41300700001)(6512007)(31696002)(8936002)(8676002)(4326008)(36756003)(316002)(2906002)(86362001)(5660300002)(66556008)(4744005)(66476007)(66946007)(53546011)(6486002)(478600001)(6666004)(31686004)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U2UvcnRnN0NUUThLL3BjczRQZHhuQzJKMk5ndVpBWTBaVmlJdm9JS1phcEpt?=
 =?utf-8?B?ZG5jOTdUQ2NzSFdweGgxaTJrcm9DWUYrRVM2aVFTUnR1SCtxUzEzeUoyRW5i?=
 =?utf-8?B?U0d5b204dnB3NXBINm0yN1dZUzR1U2NLeG5KMVgwaGFNZ0RQamw2MVgyRURL?=
 =?utf-8?B?ZW10ZUlucENOczVxSzdhbEdmRGt6Mkd5Q1lEa25rNmFqU1VlN29qZnZ1RkRP?=
 =?utf-8?B?YytzYzRGTzdkMmhwditGRW52NG1jN1pTQXdYaTJHbklxaGhuQ1RDRU52dEQ1?=
 =?utf-8?B?SGRZeUp3ZkpDb2x3VU4xdmI5MWlJam45bmdnZi9wNG1ZNWFYVE5FZVFxdjZI?=
 =?utf-8?B?TU1SNnpLU1ZFSGhBUUxuSy9pcmpiTnFEYUsrakJXd3RhVWdrTEtTV0J5VFQz?=
 =?utf-8?B?YUF5VHRiNTFuNVNRNHRIcEVDOVVKSC9QWlJaTThYUUJXNFJKc09LV2JJVHZC?=
 =?utf-8?B?TmJOWG9JeWh1UmRwZGR1czR5cyt4TkJsM0tlODlWdVRUdE54Z2RYUlFjR0lz?=
 =?utf-8?B?SjVqb1hTNTVkY3NNMHJYNFI2d0ZyZTBZQnhKcEoycG94UjNQQ1hJTUkvQ3Iy?=
 =?utf-8?B?SWpZVG9nYVVOeng1VFlGZWtuWEN6RnFRRmloQ3JLcTRRRTM1elRGQ3AvT3BJ?=
 =?utf-8?B?MUNTVXZlcmxiWkYvS0N4c3RHZ2E2NjNRV24rM01ETGlNTWdiQ1VLMGR5Qm1Z?=
 =?utf-8?B?S3N0MHNTcExxT1VjMksyYVV3WXVMQnZ4dVczYWw3WjRVRjFiSTh0bU1UYytB?=
 =?utf-8?B?Y2FhN3U5dXBFZENRNGRscFk5VUNnclptRTI0RDJwRlZCaVFHa1JsNHhmTEMy?=
 =?utf-8?B?Vk1INmszczk3NEVYREIwVXhuZ29ZMm54ZndQNG1hVm16MVV1RENsS2ZUeTdP?=
 =?utf-8?B?N2pad0EwQm1xc25mVkhkSU1hQWIvaWVPL1BtOG0yRXl3LzBvZExSS1pTVEsr?=
 =?utf-8?B?elRwUWQrczdCWTBCUHF6ekRIOVRyNVZhUEVSL1lGRGZYNVhKSndyYVVIb0dr?=
 =?utf-8?B?ZFdJOENxenBUTG9vWUtONGhEQnV2WlJkOGtSY09Gd0NwOGFJN0tRcXJWa2Ns?=
 =?utf-8?B?V2lTZStiSkFEdXEwaWhOeDVzQTZzTFlQZ09FREIwOThSbHRHaWN6RWVyM0to?=
 =?utf-8?B?OU1oSUJrdFljaHd4YnJ6RG1UYXZ6M2pCZzRrSmpDeVVjVU82aVg5N2w1MzA4?=
 =?utf-8?B?QTYwb0NpWk1MODhBQ2h5WW9xNjF1VEpyVEREU3lKaHM0U0psNW5yMjhYbXMx?=
 =?utf-8?B?M0IzM0RSWkxXanp4QlFURWhCUGx2WWR6cUNnaTdpblArQWxQVk4yT2Fvc1Zm?=
 =?utf-8?B?a0dJNi9RWFFMc1RsYXgyNHIyaGdzcWFLYkJZUTNqYXR3c1FsRlpiYnYzaE5L?=
 =?utf-8?B?U3NQeURiNEd4SjZUMUtOREM5RkdwYncxeUJzU3QrTUhXemY0akJxWEtlWEU5?=
 =?utf-8?B?SnVQSzlPdlkrZjZOQ2Y3bkdGQlF5SjY3a3FiYjcvMWpMRko1VVYyeit1bFNZ?=
 =?utf-8?B?Rm1RUnZWdk1iQXpLSWhOWXkvZXEzZWMvU2pWRXN2ZDY4Q2ZnZUlWaHhKa05I?=
 =?utf-8?B?aVpZZVM4MW5reC9ZR01nbHJZamxSRkxTUm5FWXFkL0ZDTmF3QVBJT2VkeElI?=
 =?utf-8?B?cFVxQmZJaW0za25URy9rR3ZaYUxKRTd1Uk05RzRneCtTb1BMR2tTR3FlM2Z6?=
 =?utf-8?B?NjM2SndHdHEyNEhNQ0dQNUhVQ3B1WnBYY01ka0xRZ2k1VGVMMjUybWEwMHFH?=
 =?utf-8?B?d25DdG1qRWZXUkNjeGFBaXUydExRS2Q0SXNCc1BaUlBuaTNNbkNiTk9Uc05Z?=
 =?utf-8?B?Vk44M0Z1YzgvSHZDbTBiVVVkdmpwNi9tRHdYbU9MQWlSU3EzTkw2dlhKeEo0?=
 =?utf-8?B?QTJwZFlSd3BocTliQ2JUc2M4ZCtpUFhqcDAvTWZnTFFoa29EYTZSRjZmNGVa?=
 =?utf-8?B?UUVSYzE1Vkc0L0JmQktKVUE3SS9PTkIxUGtlS1dvOUJvc2x1MjE2Ky9SYk9D?=
 =?utf-8?B?djAxeXJsYlkra1V4R2piMjZGb25FYkRvaHZBMU4xenRETkZWV2FlbFJsVW9u?=
 =?utf-8?B?TGIrREJUTGsxd1ZTT0NHV1Mvck5ZVWc0cnFkUEM2RHpCYWtsVXpJRCtrbkE3?=
 =?utf-8?Q?fK2ZlNPPfHaFwt3duj4SlsPkx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e5f7955-50c9-46db-e81e-08dc1c440b75
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6395.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 18:49:36.0765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5N7xASSuCsFiNQARF5APgI6h+k5GjG8VllegvFlmE5GJLdt6p8vzP1T09BvuM+jsfUJGE+fSpXshbdDE4Q7KuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6600



On 1/16/2024 9:43 PM, Dave Jiang wrote:
> 
> 
> On 1/16/24 00:10, Raju Rangoju wrote:
>> Hi,
>>
>> Could you please explain why net_perf does not support larger chunk sizes? Currently only  MAX_CHUNK_ORDER 20 is supported (1M and below)
> 
> It has to do with the limitation of Linux dma_alloc_coherent() call. Allocating physically (or IOVA) contiguous memory that's extremely large is difficult. In the past, you can do it with limited success up to 8MB with help from IOMMU as I recall. For experimental and testing purposes, you can try larger sizes.

Sure Dave, I'll explore that. Thank you.

>>
>> Thanks,
>> Raju
>>
