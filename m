Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF29200BC
	for <ntb@lists.linux.dev>; Thu, 10 Aug 2023 15:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691682185; x=1723218185;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=2kUPQYFxho9DeIUkzTMwQgMrHStHjCurnocl8k9KtqU=;
  b=Osigc13ylJDOfL0q2N3OkUrelNVrwHinK9GpuPmQa8a+RDuEQMOiLuan
   mpIaIFL0C13tQZRAiUCbFt4PcbgV78Qc6R8OhVuGhUQFU2fMXib4f2pyF
   dgALF5awuv4Ocqpj/8RFG6DxAyIuaFhd5CdqZ+uOjRp7UqTYp4bKpLElR
   8iWUgdl4UNV2tO3ykDk2L5MniVslj5Fsk+rOKquiHpg6Gk36IsUaS5NZU
   kS+JFKCNxoGaO66V4h4qp4Bzo1oH5uu4W5mM7OThOkNRWzwzjlOkQElqI
   Diypg2SjC50rL+VCim054i/s3Vtl1jF82KThSXaDz03nlCFxONTJu3uiR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="375151359"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="375151359"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 08:43:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="846442647"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="846442647"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP; 10 Aug 2023 08:43:03 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 08:43:03 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 10 Aug 2023 08:43:03 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 10 Aug 2023 08:42:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OzxupRyM2+8VH2xIMAjYkRzAAUpJNDEgZzAlia4qo8ZQo15lUhgMlovdTFi++W0K9+q1AxOotdj6BR8ErjlzF7wz4wn3MxVAPZxui9Txm50U89vHZE56ZPezPkVFDz6dLChxQC6QEfCr4VENpldkcQjhkCYF2BU8tEgkGvKp+xWxgQtnkgAa3xkLOp34k0mJZ3vXe0VZv7oK+YH6nQElyx+lKAd2mECifECOfNHRd7euMHO8H7Qr7iQQ3Gljwa3zQLkApVUlkIdUvl5qk4+E0VzXZaa2FCBxoT0SJ8cIOSr1FrYTLBe/9GvWgPAqJkgfjny89GPG+52mKtetbEHSWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m3Ja1vrza6Q1gMN5VMKDRAUJwn8KEO/TIQcldNjaalo=;
 b=S6p0tgOJFyW7CByljSXv50X8ZU3UD9M7n+JJUrLxYPNhV6aIfpBWmgnh6fMXS4+LSQFm1/pbePjMVmBWtSQlURkMKtXOqprx1fhemW3NcTNI48V0AXuo/dUo1G6Lq2NLP1t+ojbJxFfNpsRqSUTzQar0yZT+yClJBMODe1sGlaYF8K8QTaYoEzfz/PbVRKid/1zM5ke/P9S0kc/hxNmXmsIvS/ULInffp5c7CoPlN8FAdQmVHZUAFMZmblGbIjtQ2lyv34/Y+OUsFljGGntMJshwY3hEF6fI3TKe4cBok9/pImGVJDhgedphlNhuHKYnJmfD8+7t6QxZynnQg9nxFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by PH0PR11MB5093.namprd11.prod.outlook.com (2603:10b6:510:3e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Thu, 10 Aug
 2023 15:42:55 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::406a:8bd7:8d67:7efb]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::406a:8bd7:8d67:7efb%6]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 15:42:55 +0000
Message-ID: <24d39d91-fba2-d740-d462-5059416a4ab5@intel.com>
Date: Thu, 10 Aug 2023 08:42:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH -next] NTB: ntb_tool: Switch to memdup_user_nul() helper
To: Ruan Jinjie <ruanjinjie@huawei.com>, <jdmason@kudzu.us>,
	<allenbh@gmail.com>, <dan.carpenter@linaro.org>, <fancer.lancer@gmail.com>,
	<machel@vivo.com>, <jiasheng@iscas.ac.cn>, <ntb@lists.linux.dev>
References: <20230810111402.1923113-1-ruanjinjie@huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230810111402.1923113-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0251.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::16) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|PH0PR11MB5093:EE_
X-MS-Office365-Filtering-Correlation-Id: ec5e355d-6537-4070-3d06-08db99b876e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ug/HEYAkR8MTUmT4G+YvAGEpbCzjp/qMDn+ib4UTMP9CUXAYM8iKVq9o0YhkCaCo3bOHQEd+p1f1McPS0pon/YgUBlrw/u7bovzCLjBe44TNpibOTaUR7XotQao9MZPvhD+vYmpW78tFSoMSCsub9hO4XWQ3pIDmem3Azn3NlvYbae1BcSFr3jeeIS3rEeS1DjgH6TO35ffdwx8OdVg3lxPUH6Y9430Eofxv1Aas7Q4CDRcRCYiIqHD+WVFXHnlV2gf0nciBO36yU5XoFuENeuEYmwY7d/At54xRN4/tyRAn3twDVXiZvSCFl2PqFX7HB27UwIJEz9mEHdAGsaPu7el4wcBkIyxb1pwJpVxeLJmPohtcjO+WVS4HXFzpyL4oxQKrL9G1m4TGWKGTUrO2oWDHsptlnAFbikyhaKArBq48eD5Zvcrd43b+BGmA4QMWEflNNQzhigXXPUpEv1oMDNpzJhiXYe6Way7WQi3Rzro1b6pdwBYhISvMLTVMX0BCJhBzZLxRExEadiSWKL4Xz1P3cBX7xkLJzTu2gbCysYc5L8HfFws2BCemfwtI1cQmJK3sx6fkGztHdesYrcQMgZfB72yiuxL+mOxixc04+UVYvs/hhqino75kmghcEqVlqh1mkwkYQGHaKA9EgSneiA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(396003)(366004)(136003)(346002)(1800799006)(451199021)(186006)(6512007)(6506007)(26005)(53546011)(36756003)(38100700002)(86362001)(5660300002)(44832011)(8676002)(4744005)(2906002)(316002)(41300700001)(31696002)(66556008)(66946007)(6666004)(8936002)(6486002)(66476007)(478600001)(82960400001)(2616005)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFVuWGxFVDd6bHVBUWg2bGV3ZTM0U3N1VmZaVXZaalFWN0lnVERraUtkdCtO?=
 =?utf-8?B?R0hsaFU2RjY4QU9wWk1aQjIxeEVSRFEzNVlMTUNabzF5dXo1cVdNak0zQzJQ?=
 =?utf-8?B?UkdYbTg1eE5ObVZFSUk0NXVjcEN6eVdyRngzQm5DdURBMVhhOWlGdmhNdldK?=
 =?utf-8?B?VllscDNVOTQ2d055K3gvUHhEUGtVeEVZTDVKTGRTUS90VGkvSjg3bEZMcTI4?=
 =?utf-8?B?cXRmZU14Y2RtbnRCZTN6dEpIOFpqdUI5MktKcE91VDNjL05CMllqdW9YUkVk?=
 =?utf-8?B?S0lxb0N5MWpCZVdMRVR4Wmg4RFZBN1A4OVVFb09DOEdlVHh1cDhDTG43c3l6?=
 =?utf-8?B?K1gwSEQ0bWp5MTZmZ2JXcFhFUlVzaEc3MzlrbnlPa3pEVlZZZmsybHVWWm00?=
 =?utf-8?B?SkZpd3BUWTNZTmRVWmEwaHdTbkJ6TXFkSnFOU0d2Z3VveWM4cjJUVW5ISXdG?=
 =?utf-8?B?Q3crSzhRWjc4SVdWTU9EcUVyaG9RQ29ZQ05sQUEyUG93L2pVbUlBQTZlc2pr?=
 =?utf-8?B?UUNCS21lN25tWURiN284dTg1c0VYbmpTakVXY2dVQXMycU1YOHlzU1BiMUV1?=
 =?utf-8?B?UXBFS3lSMU5CRnlGTWJFcUswdk1BOXg4RXQ1SUIzSkRjUzQxZk5MVE1HRGVx?=
 =?utf-8?B?UGVJUnFDWDVWSzgvYWtPZVFhcVJ0eDU5R1p0cDV6S29ITkpJTFVkbUZJdU9x?=
 =?utf-8?B?QUVYYnU2YSsvZldUM1lva0RjRC95TCtsTWM2eDBRS3prLzRCUWtFNVkwbGZQ?=
 =?utf-8?B?UURUakFEKzh0d0tBY0QyOVd4U1NrcS85Qm1BN2JTaEh1Y0RWcGlrYkozZzlv?=
 =?utf-8?B?aDJsT09vZ1U5ODUwN0w4QkxTb1ZZWW9pNElqTnVIeXc1RENITjJMNHBLK1Zy?=
 =?utf-8?B?bXZGM3V3dWVJSWlMdFdDT0ZoZUlRTGZjaThQcWcwZDJoR0J2bVRqeVZEM1dN?=
 =?utf-8?B?WkIxVGh3UktRSGVNb3hlT2xrWmxST3hjbW13cGZXNFJUUzdhdXNFNjVFd2Rn?=
 =?utf-8?B?TGdRa1ZYcUxLVzl4RC9Zb3RiL0NSaVhxdjBIS0RMVng5ZWpYQXpIWThra3dT?=
 =?utf-8?B?Um01NGNZbi9CQnVVRkI2OTJmYVVid01uS1E5aU9LbDIxU3hlektURkJWSGd5?=
 =?utf-8?B?NTBFMVhDRlRLK09SNm9BR2laSVNOYWhPbFBBVEkwWGZBdEdmd0hVUjBlelJC?=
 =?utf-8?B?bUpTZEM5N09hYVA4SVMwQ2luYU8wYWoyN1BEWnNVQ25sOUFPMTlGZ1VKalRy?=
 =?utf-8?B?eEdaQ05hNndjRXVFSE9oanZ3TjB1Q0h2bXFyV2dSYitlOUcyMnhYT2VpbVFM?=
 =?utf-8?B?Wm5FdW9rVU9wbndtWW5OS0NlaDBSQ25rV3FNWGU4eUV4NjgwVGRTcE4rYXU5?=
 =?utf-8?B?UVpxWVJzU2ZHNE5RaHJlektGTVNhNEdQNDRkSEZFRkgrT0dYTWRnUEtVdEpD?=
 =?utf-8?B?ZmNYYkYwaXlHdW5zOFdhZ0ZkZndKc0wraTVjL0FtVzgySXlVdFpockNHN0gy?=
 =?utf-8?B?aWJRSTF4QUdRdERvSjRVUC9oeDF1ZktBOTlTNlQvdnNnbmx6ZVAyOXlKK0Vn?=
 =?utf-8?B?T3oyajI5QVpXbXU5VW9kVmxZc1lIWG5QTXR0NWxCK1h2cWoyd3FzemY3Vkor?=
 =?utf-8?B?aEhwYUg5d1ZNK0pXbERwUkc0OWY0REhsU0VKZll4RC9hWUl4elg0a0JHdkx3?=
 =?utf-8?B?bDRxS1hiSVczSWs0blRtMnZOMzlWbExJY2VDdGVUYVI1TWdac2FRUFJUVWd4?=
 =?utf-8?B?dXE3dU5rcWxUa3g3bFdoTm9wejE4ZlRkRnZIbENPOUhhRCtDOVJ5bXhNalFp?=
 =?utf-8?B?THFYSlZ2VzY1WHRTWkZvQVFxckkvckczNU4ra2xCaVhUaEpqUFNLSkdPemxT?=
 =?utf-8?B?SXAxZkVsKzVSOFBPbm91SHZNcUFndGNXYzlwUVpqbHh6MHY0bGdUQ05oK3ZW?=
 =?utf-8?B?bmN6b1BHOFQxdk10TWpZcDFNTU5TcFoyMFlFbW1zYy90OXBGMDBKWjBDQmVm?=
 =?utf-8?B?cFp3bVVGblhkcGJoYmVseFltM3AxSFEvSEFtalVLbHRCczl4UTVGTngrajlH?=
 =?utf-8?B?TE41SU9EL1dzZXVsT1NhMGo1SlZIdnNjcFprNFM4SUZkckVsYmtDb0tvcTJQ?=
 =?utf-8?B?TTFiRXo2NWlBbmcvejFodVF3NERpbGVabzA0clhXeCthT0tJR1BkVjduVHM0?=
 =?utf-8?B?N1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ec5e355d-6537-4070-3d06-08db99b876e2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 15:42:55.2730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P1/hp3rQxNAbl7BxANTO5guahrhW1saJNSB0J/tZriHjgwKKZCyT31ZFz5l1mgayS+b9oJQOSnHkn4rV+6uS6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5093
X-OriginatorOrg: intel.com



On 8/10/23 04:14, Ruan Jinjie wrote:
> Use memdup_user_nul() helper instead of open-coding to simplify the code.
> 
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   drivers/ntb/test/ntb_tool.c | 13 +++----------
>   1 file changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c
> index e0acc11d29ba..641cb7e05a47 100644
> --- a/drivers/ntb/test/ntb_tool.c
> +++ b/drivers/ntb/test/ntb_tool.c
> @@ -370,16 +370,9 @@ static ssize_t tool_fn_write(struct tool_ctx *tc,
>   	if (*offp)
>   		return 0;
>   
> -	buf = kmalloc(size + 1, GFP_KERNEL);
> -	if (!buf)
> -		return -ENOMEM;
> -
> -	if (copy_from_user(buf, ubuf, size)) {
> -		kfree(buf);
> -		return -EFAULT;
> -	}
> -
> -	buf[size] = 0;
> +	buf = memdup_user_nul(ubuf, size);
> +	if (IS_ERR(buf))
> +		return PTR_ERR(buf);
>   
>   	n = sscanf(buf, "%c %lli", &cmd, &bits);
>   
