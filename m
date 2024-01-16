Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4781CA85
	for <ntb@lists.linux.dev>; Tue, 16 Jan 2024 16:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FFL8E4CD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705421638; x=1736957638;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RdfJeo55gqohYA1jfPsDJysxScqKyS6D3YcLxbXiJOQ=;
  b=FFL8E4CD8VSChE4fhfRbS0h6K/5u83Ot7uaUSp7kxYT5uxnT87OrHauH
   GhcstyH2yVo0WOqdPmRBlVGG661SsqLJXbMr+z0Cm8kbbxyYqKDUgRWEl
   rFQg54qq/z5WXqeD90JplaU6a8mVd0MM/W+0CFEudcFibHkpuheYI0gTP
   eB9NBgNhaUt2mCrQX/59Vd7tvcww9BA3Klq/9ug42KWcHOrgC6sdfUFa7
   i6ymDsTTCY4wG8gQvIz92dHepnhQEYB3dTJSujznzfWwJgql1rRsZcVjT
   bTIVVvMvkArFNF3vOJ4k70/xqQ814eRYtAoCKkwdCZKDqDVx3u99vIaV4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="431074029"
X-IronPort-AV: E=Sophos;i="6.05,199,1701158400"; 
   d="scan'208";a="431074029"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 08:13:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,199,1701158400"; 
   d="scan'208";a="25847602"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Jan 2024 08:13:44 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Jan 2024 08:13:43 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 16 Jan 2024 08:13:43 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Jan 2024 08:13:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DdjpmcG7DFpiws9gAXnCgmMT/whf/3xU7RfWyTd5ygSmc2g7w/LChhkvAIbiYA8RezlCJAoDLXaEiCXrm6DyobX09roSuYCL0v4CtYYAnHCp3heMiJRbnGaXZ5gKmR5Y1ZoUJj6kI8A+WTRDsi8lZfBlhaO+kxiYegPfqjepmau9a6Cj/by2AWv+vMTigxJoiIj5HKrrag5Ags16xpeM+UQHpaWWvVkiD3Y390lz0Lg8bV0icaDvEzhqJE/Di82ddzMPjG1sRNrz8Jv9HpTgbybh149dNwJNIEVrPAmWxA/dvz/82Qw0L4u6Fk486klCVcLhrC8iM+D/rKBm//4NbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D99qKoIfBYBxI/+CulmqoOt73IJN0q77ANvIQISOlSE=;
 b=ifvB0CX4Js0GtIHWE+fdx7NIEz4TqD52IBQ1lPgXp1xpAtp9bdsx7S/BG9dulurQNYxZVyCpAd5QfhfdnWUghRMrRAmng7J3BeNrbS7scvZ6s+tG7GWW4Mkxt5ZDjawJoNQqVhgqHq7QIPMoS5rmNgiyfvK0KzD2mZXV00409/9Ii1ND6e5L1dt3XSTlRW6sUPeHJ9vqKjqCydWfROMLfggQFFpCSmwDgfZGczsLalv27Wr3Be1LVL/Vv+X1IuUZ4BSTl/vBIMUIs2FTldsMs0CiPcb3o3ESgCff6Md5j/2Y9vGbGk17JfGEyvgTULFMdjBbXRv7Rhz6ef7LsvB/rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by DS0PR11MB6495.namprd11.prod.outlook.com (2603:10b6:8:c1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.30; Tue, 16 Jan
 2024 16:13:41 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::780:d536:ff24:3e4c]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::780:d536:ff24:3e4c%3]) with mapi id 15.20.7181.029; Tue, 16 Jan 2024
 16:13:41 +0000
Message-ID: <eb872f9f-03f8-4a25-a3b2-e338833a9966@intel.com>
Date: Tue, 16 Jan 2024 09:13:38 -0700
User-Agent: Betterbird (Linux)
Subject: Re: ntb_perf max chunk order
To: Raju Rangoju <Raju.Rangoju@amd.com>, <jdmason@kudzu.us>,
	<allenbh@gmail.com>, <ntb@lists.linux.dev>
CC: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
References: <7739c789-109b-2aa7-73d2-db833853470c@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <7739c789-109b-2aa7-73d2-db833853470c@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR01CA0047.prod.exchangelabs.com (2603:10b6:a03:94::24)
 To PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|DS0PR11MB6495:EE_
X-MS-Office365-Filtering-Correlation-Id: 348c741a-9943-4f87-f1d3-08dc16ae1aa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2cqQi7MAFYV9knYFhunnDzLT433aKFh8t3K3vcXoVl5UIt9njwmW8Ebn+oAIIyIPdRdM2vAVUJVEqeNyi0RNZSUKO6tGfoxh+Mvrkbf58PNghgdMxkABe/4HclPodL2u3eCMlYeWtw/thV9CITbRAfav3dpC8GGYrqaSYtGzjVveBtWiAuW9P0q92DmeYaWvEifZqD003FlVLWs062pCCV7AQu/oZs7Kv4JimBhqMvsmb4VT2g9I2+EzB7gP7XM11r8g5KrEox5yZwrrSbTZxqX4yRnH3hrWllCRnIa6ZGpA7if7tGTgiMgaptWKfOPsM7CLZpA+Aijm9L8oTx5+y/H0DGwnpVIvdiSq8QWSszqwo/OkAMxMj2f/JL1sELzft8JzxNPL/UTuwAnrq9xgPJ6lzk73PKNnmFyyuUthO7EhlYt7vGz5NRExM1KMghe+HdZQt9wTOvKH8fLuQTjvGJY7GGyFyMaM4t3DkYKpNp2qeI2O4Uq402X7onwS93QumEfX5SE3rb4K92vdF3r8WxD/lYCToq4M3BADelwLmWH59nVhg8sPcHoXTr4IMjA41kpOkKchjnOF+FegyCttJEPz47T0jtxZKEQlmT1v8eiy/2c/ebfc6KvFUdQhCthQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(396003)(136003)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(31686004)(2616005)(26005)(83380400001)(86362001)(31696002)(82960400001)(36756003)(41300700001)(66946007)(8676002)(5660300002)(66556008)(66476007)(44832011)(4326008)(6506007)(6512007)(6666004)(8936002)(38100700002)(316002)(6486002)(2906002)(4744005)(478600001)(53546011)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1Zuc3pWTGhSWXdPandub2tTb3I4ZnhXTy9LK0FYSFdKaW9SZXJ1NjdYajhK?=
 =?utf-8?B?aEFobnBaQXZuSG84YkhUVmlvMjVPUGduRUhjZ1Bxb0RTMTNvS1Vmd1hxeWtG?=
 =?utf-8?B?aWNlUTVQbGVwY1FJczlXZnp5cFVLUmpnVzQxbGRyTnNwQXJyQ0dhblQ0S0pX?=
 =?utf-8?B?WDJEclowUUFlRzNJUWFVU3RyckRpVXErN1RaTm5PUEFaRUNHRGdDT2hyWDQ1?=
 =?utf-8?B?QVVic2Y3UHNteXVVakI2Z2x4dFgzdGRmRHpmNkcxZnAwSUUvd2JUK0hQaW9J?=
 =?utf-8?B?Sk5POWhSL2xCZzc1R1ljMUpXaC84ckdPZ2I0NnE3bVJGaWZXZS9UbzA1Mjlr?=
 =?utf-8?B?d1NBOVlpQ1ZRSG9QS08way85Tk5DVHc0OVZ0SVh4Nkp2WWQwTG8vSVVvcXRC?=
 =?utf-8?B?dkpPUW5KUVRBTjJGbGRYblUvekRicHJkMHE2VVd4am9tUHBKOTJ3Zzd2NUFD?=
 =?utf-8?B?M3VQcUhOdFB1Nk9aQVpJUi9OTGFvem9CTzhxVEd6MmRVWXg2TmxYaytoWEo0?=
 =?utf-8?B?cFg0cVVmNWhhMzRldXk0UEhXem5VS0dQWTdNcUs3U3lhdm0yOHRPRldwdE52?=
 =?utf-8?B?cHhHdVNaQWZlQjJNUUZmMG1nMW1PVW5JbUI2dCtKMGozTEUxZEdqWDdNMFJQ?=
 =?utf-8?B?ejFxYmdBNk81YUkrdVFWV3lzMHFweHZ5MXczNWpTSTlORlJEYmZ4UktuczdE?=
 =?utf-8?B?NUhpQ1JXV01lQnVhaFRCeU91OVZGUWN3K1F6L1lGUk8zL1MvVW1zYVR0UXc0?=
 =?utf-8?B?dFZzVHNEcWVNaXJCM1dQUTlzRDVXQnpsejd6NlRRbi9qdllRK1AzRDRIamxi?=
 =?utf-8?B?YUtCTnBBbFFUWVlWbWV0b1F3UkFSUTREOGJmcjUyQ1ZTMjMydjExM1JPclcw?=
 =?utf-8?B?VTNDVWxMc0dyYlpkZDNBN2lrY3FZWU1zbnNXWU5CY1FVd1ZzSmpBRXhEYTY0?=
 =?utf-8?B?QXJaUGZ6a0lOV085Rjg5VVJoQlRDL0liZzgyUk9IclJ1aW5KamI1LzdnMXlv?=
 =?utf-8?B?dWFBVVJ1T3lxMmNOWmxkNmlnK0N0bGhpS1J4T2hZZlVUcEowc1VNTmkxVnhh?=
 =?utf-8?B?VG9LeXpHUExnQmM3cHdmTjFQUWtyb0xtWTBCMVFpaFdQUkpNc2ZNcGhFS2kr?=
 =?utf-8?B?dnVNNk9hMUZLdkVmYTVTaUNZSElMSlZXUjYrcXNxUk81V3hjYUxISFZkUGxT?=
 =?utf-8?B?M2EramJ0Z3lIYWdtNFBHQTNTZTkzVmQyT2djekRaOU5yQjVBS09idlMrN1hS?=
 =?utf-8?B?eTZ4YWJBMTA5SUptempaMUYvS1hFZlNIeGdxbjVYRU1iYmI0ZFQzYUdySmRa?=
 =?utf-8?B?ckJwRDMvSnRSd0pTYnF0MlY3VWp2Z29FSzVIV1dsaFBxbnZzM3MxbVVSQS9W?=
 =?utf-8?B?QnAzaWtMemtTN3M1S1ZRUUZlQVJUVFE0a1RlenRSY01XQ1R2WHo3ZnVOcTI4?=
 =?utf-8?B?c3YvelBFS2k0RDZIQUpFMTZZdDRONlJoSlJQakFwOGhJL3p2VExNdlFjNExv?=
 =?utf-8?B?bmRPWVVxMXRlRUdNMnBFTGlDNUxCc3l4bVUwUm9CS0NCcEd5ZDhFNUd4RndL?=
 =?utf-8?B?WlJFb0FJK1Q3TWx1WkZ5RWJEOW9yVlJFUVJwbmRsa2F6TWx2MWE1dWxlRVpB?=
 =?utf-8?B?NnJTWmIwUDVJREpiUlFEQ0E3RllXNTJtVDdPL2ZOd0tSclBXelloZDE2VU5r?=
 =?utf-8?B?NXkzbEtWN2V6blpueHpaTVhJM3FwQXJMalZIeTVYNXFrdTl2eHdFcDBJdWNi?=
 =?utf-8?B?VkE4M0wvaE9pY0tCOU0xaFhreFBZQ3MrT0FiWkNLVjBJdFJjVHp0WUJwM25u?=
 =?utf-8?B?SzU0TlVyNUIvbmV4TEdzZkg1VlRCVHpDeWxzNlRlcTNIOVJ4NUtBeU1NOXlv?=
 =?utf-8?B?ZHgxNlNJWm9wVFNteGZQcGVTN2JJVndTeTN1UTRYYml5cHF0UE9Ea1BYRjly?=
 =?utf-8?B?YlFZUno1TWtRRTRlSVovZGc5WHNJUytSenBkYngyVFRyNzF2R2dRUm9HOWl5?=
 =?utf-8?B?aWRhRVRQeFdYamhDZXRqNEk4TWM2MjB4aGdZRmxBa2JZQzhQdlF5Q0hrTnI3?=
 =?utf-8?B?Y01hV1RJYnNMWWJhdGROS0ZFR2lKR3A3RXgyOWpkeTU3R2djRU5xalNQWE9i?=
 =?utf-8?Q?FyxzkuWKcLMKtyD20Iz0JKCSS?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 348c741a-9943-4f87-f1d3-08dc16ae1aa7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 16:13:40.9593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q57GyEo1aBZvl7L3zhmNCGGziNqlTy572I3+EyKH2fNNW5EHavkQQwNlLRhjIsNuJiHAq9ejkfHKLid3bx97Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6495
X-OriginatorOrg: intel.com



On 1/16/24 00:10, Raju Rangoju wrote:
> Hi,
> 
> Could you please explain why net_perf does not support larger chunk sizes? Currently only  MAX_CHUNK_ORDER 20 is supported (1M and below)

It has to do with the limitation of Linux dma_alloc_coherent() call. Allocating physically (or IOVA) contiguous memory that's extremely large is difficult. In the past, you can do it with limited success up to 8MB with help from IOMMU as I recall. For experimental and testing purposes, you can try larger sizes. 
> 
> Thanks,
> Raju
> 
