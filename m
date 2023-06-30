Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C56174F0
	for <ntb@lists.linux.dev>; Fri, 30 Jun 2023 22:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688162462; x=1719698462;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=cZb/8oRRW8KDmbYv7b3AlZ3a1Fw4UMqAcy4m06ZzIKc=;
  b=XOU5YsTkkntiGNmldVrZl58ALzsIHJP3OnHt9EI0RGk7FCmvjM4v+/E2
   KU09N9ZnEkRhXFDA41X9hFZFWWAoDGLtUa76drLm3wM0ioZURBEtUkKRE
   MKv1pn/g4Rf/X8vdRUHLQv/ODbRa3WZiCYSWkSjvNkyDTgxlOBmcy7uqG
   oZve37Nl4XlvMqYom16QkqMaaRJMbuark2gsEHK4W7GqnmGbFitJFdiDY
   vr1HA2zgBjKCb4yarVecv19e3DqwpQTcbAlg7zCQzqbhgUhddALbU7fgO
   1z73LeiyKnXfJvpfv5K1foDqFkoQrIP5VRU1ygYR3cdT0apj3VN9xWxqC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10757"; a="365080133"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="365080133"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2023 15:00:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10757"; a="842008631"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="842008631"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP; 30 Jun 2023 15:00:42 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 30 Jun 2023 15:00:42 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 30 Jun 2023 15:00:41 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 30 Jun 2023 15:00:41 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 30 Jun 2023 15:00:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZG0ebDEMramIylHaFdFQEXger11jVXx/5a25caITp7X6iG/eMl1+f8nU3Kv3IrPhPPfzaBrLy+EYZDXxt0j/a+e+dsQA4Q1FDw0yuroH1DzXJN/DpDgCWgHbbv0aRrQZG4Off9ZwBMsNSfAMVv7V4ZnhZA0aZycEQ4tY3Ir1BE/30ZRl0owokJVQwSGOSnHHOuIBHNxGAES/UrGKioHSBD9rIxtUTlFAbNV5FyCZnuyDXbVbMoWBAlqsbfEZR96V+4sj75NuOQVVIlTItxAg5h4tskQpzZikVXoh3hMBZ75/Pb4sfmxOlOtVx6KyQe0EA1u1wCGh8r0hjIH2aO0QYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G78cLeZQ3eIhovd0tggS2outkVp+R3ulkVAYdkmWE1M=;
 b=gKl74exhbzSXhYH5YwlfOAKViRTIvGyH3Y323yS7vQ+HmkbqJdbGZofKPIe0B16Gbsw2o2h8K14gmSM2pRBDhqeTHRiT/0Sy1rtgx04wvL4l3nx7a9plCDFXtsicTEWx2kHpN6cPCAa+O9+2tbxUbl6Ext7DPl5BSs+ljFjWSeGa3dmhkSzQBHCeVJ46KH0smK5Lg+u7fVqaVBFBqIEcyfumgu8VLhCUcZSbK77d6HDrASI4pEkkhy388A11sFu/AsMVTLWtidhCZzmmNFQ0M2PpJGcMlML1BqlV3qWJjX/XXC9MS2PV23N6r1fnv0VaTP9Flr2WMR39lV3EJ1XXvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by BN9PR11MB5260.namprd11.prod.outlook.com (2603:10b6:408:135::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Fri, 30 Jun
 2023 22:00:39 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6521.024; Fri, 30 Jun 2023
 22:00:38 +0000
Message-ID: <064504c8-12e6-00c2-eaee-06afda4fb5b3@intel.com>
Date: Fri, 30 Jun 2023 15:00:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.12.0
Subject: Re: [PATCH v1 1/1] ntb_netdev: Fix module_init problem
To: Geoff Levand <geoff@infradead.org>, <ntb@lists.linux.dev>, Jon Mason
	<jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>
References: <824a68d53214fa7a9e061176c05e9ce8ad5d850a.1688151221.git.geoff@infradead.org>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <824a68d53214fa7a9e061176c05e9ce8ad5d850a.1688151221.git.geoff@infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0068.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::45) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|BN9PR11MB5260:EE_
X-MS-Office365-Filtering-Correlation-Id: 322dd8a5-2ced-4c74-09ed-08db79b5702a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DALR2+c/KKPuuBt7DpAVjtScAPIPCslU8KK7+blVvNFS6t0nrL5w28JITLlBFFPfLlx2vCd21jyqCMlqz54A4Eo18vSvmcWg7rfb3Pu6u9ne69wqILp9oYyoC7j2Lp9M4Hh5iMXNxv8odo0GkTCPQn/cySV5yihEEuBy5NN30rZp8/NhdVi/BZ5ZbgDY+1dsoROFH2MjL3OZ1mddKnuH2dDxz7m64OD4CtTKGn1W6fUYSfgqTzrfZLQD25NjO7hVfhG0VgOJ/hGRaTA7CCOQhTOpRrgG8X6iQBPLvUbEuFuKjzbLfLe/3OSi1lYIdxjsjMXpF7kyBa7KdMBbZk4Jpo0BZgCTjsI/JXGr89kt88jsTfuYhHIo6SDeIEjRQ1GsXfNrETxt+5d/L6Gy+fAsZYF/5/CWioaTd6kzGLhKGJl1nQBM1uDm4PIqiR03CSHYbbKtN9HMa1rMb99VEmtT5KGOYasPKWiLP0+PMhA6GVUQezx2pm5D4o21d6iI06lDEQHna1Kd0m28wx0wwdE6B2RDEdv1pYWcuYRBFDP7Dl8S+0ISu4CGx6uf7wuHY4CjgsT+v94d5rFZ1VcDw7VP5R/WYDVGmhkaNFzTEZAaxOWG8NELifsflRUjvHT8LITtITCywS84Dcy867jnxLWPwA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(346002)(366004)(396003)(136003)(451199021)(53546011)(6666004)(6486002)(110136005)(83380400001)(2906002)(6506007)(6512007)(2616005)(26005)(186003)(478600001)(5660300002)(44832011)(36756003)(316002)(31696002)(38100700002)(82960400001)(66946007)(8936002)(66556008)(41300700001)(86362001)(66476007)(8676002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFRvTGlnbGtBRGprUmgyMCt5REN2M2lJYkYvVUpQQUVHcUhzOVFXcmZCNkpB?=
 =?utf-8?B?R1k2ME1MblphUnVPWDRGL09HS0hzMHpFejRXMDc4M2ZtY2luNlFCcHlvYURW?=
 =?utf-8?B?Zi83Rks1MTVmaU9uOUFRcTdRU1pIVmlPYWdQNmRHUWdSWllKc3diTld2emky?=
 =?utf-8?B?WkNDajlmOVBiYmE1UFZrMXRhRzhiSjVma1VJYTd6MlpCREtyT3pHTEZLZGgv?=
 =?utf-8?B?Y2I1dmpHaDRnZXkxdlFzMWVRN1NCL3Q2WUFTS3lmL3l0T1RlbjBLelJ2NlZt?=
 =?utf-8?B?VjdBZmxONlJzUDJrYUJWRWJTcE9xUFQ1OUZPY0dWdGp0MWJQWS9RUjNtYjI5?=
 =?utf-8?B?QXpDUHViby9vdjNsQzZ1WDYzZWVRRFhRVENWK3JSUzRJQXlGWTlqMDhta0sv?=
 =?utf-8?B?cDhOcnVUdEUxK0xQTlM2T2IxOWJySk8yWWp2WHpsYkE0U1hYS0FxU0ZnMHFY?=
 =?utf-8?B?RVRybjkwMlV2Mmc5VGVQdzRFc2tickFVRTVMTWhDVGlORjJRbTRDeU1vZ0pk?=
 =?utf-8?B?YWtMUXZNNTIyRlY5YkFrbFJ6ZWUvMHZJcS81bVF1aXNNK1R0YkdVb1hZay9E?=
 =?utf-8?B?WnkyUVZKTytUVmZaaDFiOWgwL3E3S0s2dUl4ck1vTlFUd0d5bklicVhjNDF5?=
 =?utf-8?B?WkUzRXRXQmNvcjBldjdXWEthZjFGWjIxK0txbTlVRDRQU3ptV3Q2djVFNW96?=
 =?utf-8?B?bmVqQUhHY1VLNm0xUkE4enN6NHdYZEE3NE1XdUJJU1UvM1JvYjh0QWNtWFdm?=
 =?utf-8?B?UmpsWnBDYWZaZmRBbkI1T2tpQzB0ZHg1VEVMNTlMQWUxK0FQTHgzUnEwQ0dP?=
 =?utf-8?B?WHV0SnloVWJBNWdJdFNUeC9YVEpZTmhGdkErR0cwZlFHbUZJM1Fxc3didloz?=
 =?utf-8?B?dGdHMElDYVdmQmdIWjR1WkpyaFlZZWpPUldZSzRLRy9OUEJZNCt2Skdhbmxw?=
 =?utf-8?B?NEkyTnBuQ3FEZEFxS25XN1NmcjhVdHhZRWE1TTRwVWp5bksyZ2h0RDk5TUtF?=
 =?utf-8?B?c0xlMEFCOGN1YUFiV2k0TVNDRmlQbWtrNk85Vm0xVXVCaEdPdWZOMHZiRytX?=
 =?utf-8?B?YUFlQWJUU21zN2lsMkVBL3FQT2VSR2UwaXVMNU56a1NvN1RJbVJhaWd4ZHpG?=
 =?utf-8?B?cEVYSFVBL0dEWmlkK2doYWtjYXBvNEMrSFQ3NkVLWTdWK29WNXRUUmpyb2hD?=
 =?utf-8?B?L0dxN21FMzZVam5BVytsK2RXSkJ0cVVqQVZ3cFRRaUpEMlFQd0FSTVFrZGtx?=
 =?utf-8?B?bHQ2U3FlbFZxcWY1TGJJaFRGdml4TENPL09FZC9vdUJUZ1BLVlFtektPNXNN?=
 =?utf-8?B?WXJCQUM5TTA4YUEvdlBTMkJOKzk5MEE0RDlEeXM0alppV0swLzV4aThuR3c2?=
 =?utf-8?B?QTZ1bzdRS3N4cEVYUGdUNUQ5WCs5Ym5jbWZ1UmRMSDgrK2l0algxdW5TeDJm?=
 =?utf-8?B?YUF1THRhbnVFU1ppMnE3cUluSEVUMGdmeHEvTldyclcvQ0IvYUNjYzhXRmFr?=
 =?utf-8?B?MUp0RnJyV3JUQkEyWXdsQ05IZS96UmxQNVNrRkNyTk9FZUJuYm52K2JHTVZD?=
 =?utf-8?B?VmRad2NQMnVpVkVqNkxNeUFPR04zN3JSTzRUV0tCU2dDaTQ3KzdkeXRjMkdN?=
 =?utf-8?B?Lzl3KzdlQXFaR01UUVJZR0dQOTZReUpGYW9WSUZuN2RRang4VVRTU0ZWZnY2?=
 =?utf-8?B?VlNQSlo4WmRsd3ZvZDBTN1NMc0x2RDVnRVdTVG1IbTE4bzdaZUtsbkRObGxm?=
 =?utf-8?B?aHhxc2VtYWpXWG9uaFJaMUdYRzdPYks4Q1NsR0d0dVZ6KzZSTU5aK2NqcERi?=
 =?utf-8?B?WEZUMGMwRkVLbGhFeGx4RVkwaEVHWXNuMldTQjhGaUZsNVBGL1dkVVpSN1dp?=
 =?utf-8?B?NXZyTEtRcXpLdUJGNG1IQjVjTlZ6WVJWVDl0a3lRdnpKeVd0WnRpU2tSVEtj?=
 =?utf-8?B?aUo1dDM0dXIra3l0RFoyUVZXeGJqZ0o2a1dMZFVmR0l1bTMrVzYxUzRTNzR5?=
 =?utf-8?B?aUVOaStCa1QvZEZNQjRYT0JoNjZ6cFNDM1Y3NzRaOTVlYWQxZjVGc3BaSm5Z?=
 =?utf-8?B?aWVXWjBSTkpPRTZ6S1B5dmdRNVFoYm5NMGRaQk56ZW4yM2tWU2kwaTNjVGNu?=
 =?utf-8?Q?X6VKA4CUKww+t4yf44YQVIStp?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 322dd8a5-2ced-4c74-09ed-08db79b5702a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 22:00:38.3355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SkcHtm5p9ehgah5x2enQ4bIHgOVufueq+SPuWse9Z+elZwMzEVWYezOGCUCUjQpJnzG/vxdPlapf6LwRxjQhAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5260
X-OriginatorOrg: intel.com



On 6/30/23 14:58, Geoff Levand wrote:
> With both the ntb_transport_init and the ntb_netdev_init_module routines in the
> module_init init group, the ntb_netdev_init_module routine can be called before
> the ntb_transport_init routine that it depends on is called.  To assure the
> proper initialization order put ntb_netdev_init_module in the late_initcall
> group.
> 
> Fixes runtime errors where the ntb_netdev_init_module call fails with ENODEV.
> 
> Signed-off-by: Geoff Levand <geoff@infradead.org> for Sony Interactive Entertainment

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/net/ntb_netdev.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
> index 85dbe7f73e31..536bd6564f8b 100644
> --- a/drivers/net/ntb_netdev.c
> +++ b/drivers/net/ntb_netdev.c
> @@ -493,7 +493,7 @@ static int __init ntb_netdev_init_module(void)
>   
>   	return 0;
>   }
> -module_init(ntb_netdev_init_module);
> +late_initcall(ntb_netdev_init_module);
>   
>   static void __exit ntb_netdev_exit_module(void)
>   {
