Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCDF125AA
	for <ntb@lists.linux.dev>; Thu, 31 Aug 2023 15:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693494076; x=1725030076;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=6Huz7w/uUxobFzpyfokDgZ4RMYy+XFh4GqjWX4Ovs44=;
  b=J32DkeWS6V/u8+kAKm3y3t7In/TMXlfHdL5GWxOsQTdF500angYYWeCv
   0CZ9DAcIO6nw668skbovjR5GYJHbIbmHC2l2rwl6/ZzZFqc4A4+S0SD1z
   uR4D9CWoy5jBVGbhKca80/ihJ6NLeKCDmkeYncwvYaEoFsft+JvnOqxSI
   3yFyD/SPKw5Yc8V36Z6YWuJ/9t1FHgm3GFp2UknT5SNd9E+3insy2Mgwh
   2Ln9dLZNvVV5MS2V9eznfbqiPqgd9RV4pK+VaFA7ywN9S4SLv7QzJB4TW
   a7RyPeY6a41wCMnfPOyAXsEWab8VPD74KxF8zR6l1SNdwerJ22ZXK7qbM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="373372099"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="373372099"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 08:00:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="829727501"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="829727501"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Aug 2023 08:00:21 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 31 Aug 2023 08:00:20 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 31 Aug 2023 08:00:20 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 31 Aug 2023 08:00:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HLpGH0WJHb8E6Z4vP/QYKOK2zgjVVY9TsS6Maep+3xJcNcx/vZta9PaRnT2IuSY21D5yWsydKEcgD+9ALXvHJFp/MO0vN4JeCRiuM8NvpEVlZd9ngRg8E2/xrZAzgeZXtFpFXbOP+nCmC37T3FgFsoIex3tPNLFhOLY/BeOXMXTHOoxl21RVBHpNvQrx+OxMtoVe7V5KYxchKIvWaGvSFAGQcY1PVuNKOBc/2NdjxamgqNq72zBHAPe+NdaXnS2BGUi5uK00x04d8/WBLdaKgdoIP9muqMokoheHYjMLRq+jbdVlG1LOp7XtIC5mVLtDe+SyQfEZCIY7dCd0EgGUyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4D6qhzey/ZJME3LKsNSeY1bvGBH1H1l5ia0JSPy9Gb4=;
 b=kpZ/OM/eOyBsPC6zMJht8YEM3HYrs21iG3PFn+xfxMflDnvYxv/7ZIpwaSbmGTHzfD7RuOmIEYzmVa9xhDN8rUYMkrsV3vRlyxEYHXu+VWYLCuOoCqje6Hgekpcr0pY8+RWIqRnB7QcbOEgSRsMpRMOYM82G9Sdi+RLTHbeu4yu8TMLQLX6umzgWaU0IOMo8W+0mDgfpe1zCN724SEaoYcVFJBakYrIz2QyLw30EM2vHFSUm9+ohEPIGaMIISW0ewQOpovvvB9HUFzoGuJQ01OH9M2JsOEolvLhArunYQGuejKpAJR6MTcuNBbQ3BhrNpfCHF5iIHuOrzV4P0GMmrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by DM4PR11MB6238.namprd11.prod.outlook.com (2603:10b6:8:a8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Thu, 31 Aug
 2023 15:00:18 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::9563:9642:bbde:293f]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::9563:9642:bbde:293f%7]) with mapi id 15.20.6745.022; Thu, 31 Aug 2023
 15:00:18 +0000
Message-ID: <9b3bdb3d-f1bf-4278-479c-20f78493ce7c@intel.com>
Date: Thu, 31 Aug 2023 08:00:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH] ntb: intel: Fix the NULL vs IS_ERR() bug for
 debugfs_create_dir()
To: Jinjie Ruan <ruanjinjie@huawei.com>, <ntb@lists.linux.dev>, Jon Mason
	<jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>
References: <20230831123927.3137364-1-ruanjinjie@huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230831123927.3137364-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0172.namprd05.prod.outlook.com
 (2603:10b6:a03:339::27) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|DM4PR11MB6238:EE_
X-MS-Office365-Filtering-Correlation-Id: cc02d265-bf89-475c-c0e5-08dbaa32fd5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fxRfQeFn6eZQh2HxwJidH+Q4BgHm1BpduC+XFVL+rNqjfHLjsZ6aN2ktdZ90pcYiAGUmtFwaFfDEouysXJjR+lK+i/1I3yQ62BuUvsfscPI8pY+dmsffVwy0/BPVKFMjevq+VEsPQWhsqad3rTWzNeRm8GEyCkF30S/zL3RJ0V0wIPuhZ5CfQpiDpiN8XpuQH04/DDnjTgvenT0RoWnKyw26dfQF/KYr8Q7h+8TuPIYVq/X+cjkSpUrdxZaauRCYu+YL9GLqv0QZ1CRTyWvLCmknvJB7++Vdo9VNkeZ024pYue1xWz7C5P5SlCTh+7ENAv5lkKX5ltPvO2GRIBMOaRjzM0Zb3aKKI4Y5D+0BtTN7rsZDyUHYJ96RNUK9Thrhp4ZXwa3iJ2RGz7nzjP34QLBz3uT9YCOmZtauE6sAaxRIxHBtvpYX7XgIxwc1pxysmy3H6/4Sydw6E6ehlIkKVIKcr2QDTiSMkD3n/a5kdThzgHyFO04KaCZmQ7e7gPQCvAbiDmwTFrIEuOV/us6Fq17Nauuih8NncN0oRclKAxtDsRD9SOS7+9kqJxDcp14aYfnNYTRlIYGcb/1+iXKFNfqMrTMArANOPhRoCA3gwqLcDrAKFNnyUR0BTd660U7rNJjNwSU4Kko3h/F49Buerg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(376002)(396003)(346002)(186009)(1800799009)(451199024)(83380400001)(66946007)(316002)(82960400001)(66476007)(478600001)(38100700002)(66556008)(2906002)(110136005)(4744005)(5660300002)(31696002)(8676002)(8936002)(53546011)(6506007)(86362001)(44832011)(6512007)(41300700001)(6666004)(6486002)(26005)(2616005)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFpUZXh5S2JWWkJKRTJQcUxaemV5eDRHUDdTM2Fic2c1SllMelBDRmprL3FG?=
 =?utf-8?B?TWFFNk1YdE1rY0l3SENTMmRvMnFMck9wc29iMngzelIzMzJ4dm5IVnVPYzlS?=
 =?utf-8?B?WXlVdmo5VEF0L3M5ekJpQko1YVdwc1ZNQmlmZEdDcUE4OVlSSC9WTFFaUVVF?=
 =?utf-8?B?Z2FQWTV2OUo4NWp3ZzdjTHdhQzQ2ck5iQXN2UFBMNFFzOHVPUUpKcFJSV2x0?=
 =?utf-8?B?WWViNk1ydmNGL0hQbThwZDdlYkhtRjRjTThranV4WGlhRm1JRm1NOW1WZHJa?=
 =?utf-8?B?SkNvdS93aEp4QWVsbStCMFJ6d3JqcEhQTkJCbFRRZTRLcWFjcUw2OURVS2Fn?=
 =?utf-8?B?eXJCblVSYmkzdDcxZWFpbjdHMGRDdHVnbEJEd3ZsSlNpbDVIeUxibGF6VG94?=
 =?utf-8?B?N3lRWDlsNG5BNjZkaFpvVVVCUk96SHR0eGN0cWV5TndDQnAyeFFndWhvN2pz?=
 =?utf-8?B?ZGw3WUdzRWEvOWp6YlRlQ20xUURCalRpUFJUS2ZKSnppTkE2emVjV3EyWmdM?=
 =?utf-8?B?V0pQMjZORFMxbWlXL2FlM2NTaU1MckNMVkdQMWIvcmJjQ2c0dVFvcUtmQ1BS?=
 =?utf-8?B?RWhHeTF3NXRobUJuZnBiVm1VNjdxLzVkVmFCN2lwY1ZVaDY2YjU3QlBLUTRS?=
 =?utf-8?B?Q1BFTGgxS3k4Q0hSVmJZc0JHeVUydzdhQXR0NjJ5RUJOa0hQd2U4Uk9rUyt0?=
 =?utf-8?B?ZUxkTllTcTQ1OENPbTZMZEFiVFlQdEtGTEdjeURBRzk2dXZZTS9CUzBUY1pz?=
 =?utf-8?B?c05GVms0dnpBVzZkeC9CdXAycFJ0UFI0Q3hRdTNWbEVETHVuSWMxMGRNd1gy?=
 =?utf-8?B?TFBEWFd6dXJxWHJibjRnWjFlSko3a28veWRnN2RUME1DeVBqRlFLTFJRSzRu?=
 =?utf-8?B?RFgyZWw2ek8rVkpzTFJhTm9HRDFUZjhFZUJCM0dvY3FuV1dibm9pT1VVdC90?=
 =?utf-8?B?cVVVTjhkZjAreE8xTkpqZm5ONlp3MEhFTzRnRk5oL0ltVGVnSE03NTdEbmJM?=
 =?utf-8?B?bVVPdDZmUXlZbmo2SGRTWk84TDNyaFk0VXQ0RXQyY0FmZU5ra01OSTV1L2Rr?=
 =?utf-8?B?WXA3WTlhNWw2WW5VK0ZQTFlCNXlzcSt5b2xsZTNCWUNUU0xnbytLaVNzckFs?=
 =?utf-8?B?aDRlWHJNTnVqczlNS21LSGhhUXF4VHVvNExaQzVueTBLWGlMY3dhc2VRR09E?=
 =?utf-8?B?RWQyRnl1dDJaR2hLRkxlQkcyT2oxRVFzeW4yOEUrRGJvVVUrdUFraytxeXJt?=
 =?utf-8?B?MTdKNkJwUHl6M0xUSFVHbUI1bUFHMDlMbG1ZQi9TQ2hMcjJ0a1B4Tmw1a1Bs?=
 =?utf-8?B?RDlsTldzYlM3UGFPelpWNjUzeW9jS0NYNGVOcE9rNWJhQy93RnNHSGZFeFRT?=
 =?utf-8?B?NkhuTENUblJOU3NWbUliQWt2bDFwTllyYWpqVTJKaWl1VW10cC9ZVmw1a08y?=
 =?utf-8?B?OFNJNEtROHk2N0oyYlRpRzVJRW9Cd3IwVlNmN3FMaGVidlpWc0o3VUZhelc5?=
 =?utf-8?B?SFI5VUgzTUNteW5uQ003eUp3Q3g5VUVpZVdyR202bE5tbTRsVFFZNW9pUlhX?=
 =?utf-8?B?TnBReVpUanZOMVRaL2NsbCtNMEZyY1FCdi9oSitEd3YwZU1TQ01jQWprTURi?=
 =?utf-8?B?OHR1QkdJdDFNZGJmZXo4a00wZWpWMDVHWU1ldmFsM3JTTnpoemo1U0JsSDli?=
 =?utf-8?B?TzJ3NkM0R3VSdkNIQVBvU3RTb3hGSnVkK2F4OVZSVUFZdWIyTk5pVkR2a0Nn?=
 =?utf-8?B?bmg2QTBnak1GS2VCSlBJTnFKZWdzZWN2UEFqWm9aNlhTNUlETUpsWlR0dk03?=
 =?utf-8?B?Vm1acWVOMUdNdVFCdEM1ZU9kZjlxTEpWQVVnSXd6cjVoWlE4dC9zS09GclRm?=
 =?utf-8?B?UzVmbUZrZ1p5bzRUVmlDdXZ3cFVpdWpBaDM3aGhYeUlyOGpJdWJHNHVudVBV?=
 =?utf-8?B?NnRqRVowVnFlUzNKcHd1TU9icnVya3pSQ1p3UkNZdzdlcWtFQ2h3UmpWTmFD?=
 =?utf-8?B?algyMU9FMGEwVVVGTkNHaVdVeU96bURIbWc5bDJFa2lUS0J4Q09pUUJ0QWxF?=
 =?utf-8?B?NnM1Qk9qTzdWN09PU1lodHhsUUdKZ0pFOGtpbyt4ODhBVzk3OS9VT05wbFBM?=
 =?utf-8?Q?Ere3BdyyCgX/cY0icWTXGheKa?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cc02d265-bf89-475c-c0e5-08dbaa32fd5a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 15:00:18.1538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PixKcghMy4AaGq7PoIvVoWlTJq3vlaNLTegmssONFlhtmEIBH0ArTfIlFjDUL+E3qRTxreS2gxnxlQOtxpC+zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6238
X-OriginatorOrg: intel.com



On 8/31/23 05:39, Jinjie Ruan wrote:
> The debugfs_create_dir() function returns error pointers.
> It never returns NULL. So use IS_ERR() to check it.
> 
> Fixes: e26a5843f7f5 ("NTB: Split ntb_hw_intel and ntb_transport drivers")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Thank you!

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   drivers/ntb/hw/intel/ntb_hw_gen1.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ntb/hw/intel/ntb_hw_gen1.c b/drivers/ntb/hw/intel/ntb_hw_gen1.c
> index 9ab836d0d4f1..079b8cd79785 100644
> --- a/drivers/ntb/hw/intel/ntb_hw_gen1.c
> +++ b/drivers/ntb/hw/intel/ntb_hw_gen1.c
> @@ -778,7 +778,7 @@ static void ndev_init_debugfs(struct intel_ntb_dev *ndev)
>   		ndev->debugfs_dir =
>   			debugfs_create_dir(pci_name(ndev->ntb.pdev),
>   					   debugfs_dir);
> -		if (!ndev->debugfs_dir)
> +		if (IS_ERR(ndev->debugfs_dir))
>   			ndev->debugfs_info = NULL;
>   		else
>   			ndev->debugfs_info =
