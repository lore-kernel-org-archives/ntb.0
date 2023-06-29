Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6126AFBF6
	for <ntb@lists.linux.dev>; Thu, 29 Jun 2023 21:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688074319; x=1719610319;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=c6EfGjrPx3rT44GSkFPdNYp9oMQcG75Zj+GMaU9QHMo=;
  b=iwey6mbRZAaMQAN++iqFt8CsHEhN0T52XIC5ZdmD5Pm99eyoG6XwF4Dt
   nHCqOBpStGl+2AlvKxYBkNFM1/OCmFN06tKps/LUAqHBtqaejHv/KleIs
   316vveuIY4B36i9ckR9Xey2oZNEXL2SHjjYNTh8484lctcHun4ArKOjOw
   jTaqIScCjE5hmxOlSroEimvngsSGJR5TOlhvaFDWDxbdrMemEGpTJ+ApH
   CiYzPGE/4nBrsiby1umJXDvf9i4ZjMY+UF6Mv4aFT94zECZrdAl4lQk3n
   bjNbbiEFcjwSHP5piTS9b7wCeR2TFu1mgwnlnISnkAk7L6twrKvazc2l3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="361080515"
X-IronPort-AV: E=Sophos;i="6.01,169,1684825200"; 
   d="scan'208";a="361080515"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 14:31:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="807494896"
X-IronPort-AV: E=Sophos;i="6.01,169,1684825200"; 
   d="scan'208";a="807494896"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Jun 2023 14:31:55 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 29 Jun 2023 14:31:54 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 29 Jun 2023 14:31:53 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 29 Jun 2023 14:31:53 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 29 Jun 2023 14:31:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CJW68MAtEKOX8TeK671321d+ppzv7PNOXxFNTo+HqMQq8sff1JOpiP0v83UTZiBd6/iuyddGcBig8479NKJh5lg8T9u0Rmy/81vewuzrmBvMdcT33JIWxL8N0eWwBQv5/+sc521FpRm9kl1WPdd2rnp3blO744b6cKEATrTpfy2ZQzLLorNFFbYjYjf3UdAy/Gr6QWucweHVy4P79lT+SZuKERgaiTLPoxiUDWZHOvKnXO46iBd4/W3s+aOXXI9BGs+58v9n9vcQKDjLkfWe4bgy8SD10fLtqZ9L/zHlpcWUq8N6/sTPhZZRXTy+7MgWT98js3Wf8MhjlWlSfs9PWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fL6WbmlKCC3A9AX50/7k97ldMyi01pNLxhLNmS7AYF0=;
 b=MXS5UvDw1DgAjx1vfUm2mYSgIQ43EHxNbfj5tSGdN7E8KKEtKzfHQWmoESOFMkk+IzxMIIqtS1Fkd0c6RqhK3s4Fbks4sXkpGiH500zOebHmO7l0QVz7YJTOzLPZnRLd9Y7+mZCquyyV9iY8PtPUvU7twZmzqnySTY4K1adrYpTM4Yx9RFuA4UilOBtJr7aKMTwhcOCMkSD9IA2tTK5qs5whhL4cbb7jYRTkd1Q5D8At8nEcpOi55a6nRsnIkn7Nod+hfjoVYQhLz3UJBLjKV0vK9UB3ySStc3p6UWRi2dAib5CXwp9kvK/rPRftnFLUdGRr76R+eTRge9AraUmbqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by BY1PR11MB8030.namprd11.prod.outlook.com (2603:10b6:a03:522::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Thu, 29 Jun
 2023 21:31:51 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6521.024; Thu, 29 Jun 2023
 21:31:51 +0000
Message-ID: <fac6d97b-d35a-8dc1-3412-0249fee3d2a7@intel.com>
Date: Thu, 29 Jun 2023 14:31:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.1
Subject: Re: [PATCH v1 1/1] ntb.rst: Fix copy and paste error
To: Geoff Levand <geoff@infradead.org>, <ntb@lists.linux.dev>, Jon Mason
	<jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>
References: <3102d6f5287c58ca417c616b5631a343b62dfe74.1688071716.git.geoff@infradead.org>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <3102d6f5287c58ca417c616b5631a343b62dfe74.1688071716.git.geoff@infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0046.prod.exchangelabs.com (2603:10b6:a03:94::23)
 To PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|BY1PR11MB8030:EE_
X-MS-Office365-Filtering-Correlation-Id: fe4c1441-a744-4899-8ab8-08db78e84017
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YZ8TTsY7rHFAO+Tl+GCkEyx8RqVu0PglNf7/6HcQtVyPuZSOHtn5EK3gvXhUp+VfDsLhHEOqwQBs2vu+DTGig+0G/qVjLhRAwwU7+HJ2lC/0RXEVA3Ang9PdgM7+O/grjBKpEEgxHASXqs4TJ0dtoUh5SYoqqi5GU5ubuh8x+NpgtrL0cWXTMxcWjmRPSWB4nTMG3tIHy8k2amUEbOhcUOEhT5bUPi/T9UgcBaJBEi03EEf+sTqyxbJd2FRa0VIwNyD62Em2qCMqQ1VYyoNSD4J6BYu9FRvyM5lVHbOZCHlkVGQGmO05YzLifBa4b8WjpbiUlPyeWOIkZb1ok5s6XKUKcM148upNUO/gfVqvprvSn8H93vb9HovDHNjhGFf7sCpRxO6aR1WYU8T0Io12lzEJNUVyHlMR0TbrBShO+4pkqu5BAt14ktCV/hnRWf/qpl3S1F0BFXhvDUg6V28Hn4RmhLZR87R5WQVV0Zk0btGV1E4cgY1iCjWvLZUYeEamAm3ygJJKNa+64+8+9xiYdtieDhvT2zzkSVazL2PFrhwxBkdGoPp3zCKIbQsS0QbZ5pH/zglFb/dtv4q4moKkALuKJ+mTmc44Ni5EYre5AIxu/cwNudQTK2iTQ4qizp0euf5u73V5ZpsEmjeMJBVMGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(39860400002)(376002)(136003)(366004)(451199021)(316002)(38100700002)(66946007)(82960400001)(6486002)(83380400001)(6666004)(66556008)(66476007)(41300700001)(31686004)(8676002)(26005)(8936002)(31696002)(86362001)(6506007)(5660300002)(6512007)(36756003)(2616005)(186003)(53546011)(110136005)(44832011)(478600001)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlcycGN2bnhxTmZnS09JWDJweDVsdDRlZnBUZ0xkanBDZXNWT2laeGFqWWN3?=
 =?utf-8?B?WENCTGhONVI5Q3VrQ2xyRy9kTGxWYXJqZmZjckNMTFA0cDliditKeFBCcWVQ?=
 =?utf-8?B?OW9LSVlIcS9GajRmd093R1BzSk02UzFGZjhWdXh1NUZhUzBKZFovaWZjR0U0?=
 =?utf-8?B?bjd1UU5qUEVpSG5ZYVhzcEdabFd1RXd1UktFVmFITWNuamxVeWd1ODA1cUJH?=
 =?utf-8?B?am9ROWluWXRvb2RVWmhjM3prZ1kyS2s4dUE5cTFHbzg4ZmJpUmxZOUFuc1hF?=
 =?utf-8?B?dSsxMTRqUVBtbE05Ry83aGxMcVEyWTdYc21hSW52QldDYkhGbXlod1VHanlv?=
 =?utf-8?B?aGxrby9ieUZ0alNtdTdXUjN0Q3R0TWlPRm1NdlMwRHBjeDliaENhcmUxeW9T?=
 =?utf-8?B?bHFUS1hUanFlUXdxWlhvVGdsSkgwUFhiWWhzZnpXKzFadVMyYWFySC9hUkY1?=
 =?utf-8?B?SzViakVYa05TQnNNNzFPRzJ0bjRCZXk2VDJYU3lDOS8zbXNWdkZuanFHQW04?=
 =?utf-8?B?MjZYZkRWc1JYRkJRN1M2Uk5vdGFDVXJMb2tKOGxVN2QrVC9KbHVGa0ltTWhU?=
 =?utf-8?B?NEtjQ2o5KzFkejcwWGs0US9aVlE0M2RHVWNUaFpudWZZdGVTMWVJVjJPUFE1?=
 =?utf-8?B?eTJLYVRZSHVtOVBNa2EweVFMbkNKYkVtNnZGcG50enIvLzBHZTBTTzNZNk1F?=
 =?utf-8?B?RWxoSXhCUG1tVzFLNk4vc2JxMzBDZHJGM0ZaL05Uc24wQ1VNKzYwMWJ6a3gw?=
 =?utf-8?B?OVBJL2NjZG5iZWxwTzYrT0FZdFlyMVhRQWpuWUlzKzN1OWRqMjBVS0FXbG9Y?=
 =?utf-8?B?MW5abERWRlBYQUdFMGRrdWV6UFVpdmkzR0JpWTA3cWJvVURtL2ZqVE5VYlk1?=
 =?utf-8?B?d2JCWDlzZE1ocThrZXg1QTJRRHV2dHNocythVWQ0NHVub3RpNVQweTdkNThK?=
 =?utf-8?B?K2hkSys5djRrbVZQUFBSWWFUdnBEQjZNZU5sVWZZL2xyOFRDVnVmNEtrRmxM?=
 =?utf-8?B?R0tKNENqZk5zc3BzWWp6enhLWWRyZnV6R1JhWGtTL25MTXFiN1R6Uzd4WFBv?=
 =?utf-8?B?MmxaVjZnMFRjb3hLMUVGUmRhMDNWWEgrUWgwekxIZkh5elE3THZFeWRoVGdr?=
 =?utf-8?B?dVNNcW5kSW9LSVRYYXNRbUtsdW5oMjRueFF2NjljelgwVEZOVUJNUG5rcHRp?=
 =?utf-8?B?UGFOeXhJZDA5TUZiaEhyQTFuelV1R2dVOG5CQWtNQWhXalUxczBvaDA4ZFZa?=
 =?utf-8?B?cjd3L0g5aEt1dUtTMG5RQ2wwbG5CQ1kwUDM1KzJFZjBRWTFUOXZlMytmNk56?=
 =?utf-8?B?aDIxY3BSQm1CMS85R0FIKzQwN0t0K2dRUkVjWC8ydHVSallyL2NDaUp4UTBE?=
 =?utf-8?B?bE81NkhTUFJsQi96Z2ZRak1iQ3ZHeFkvZ3ZyR1BYOUt6YUwwY1JPUGlrZ2ZY?=
 =?utf-8?B?WmZKVzhkOWRKVnhJS1paMXhxaTBwOXpyOHJNYjVPc3pVMFRVcmtGNlpNSERT?=
 =?utf-8?B?c0FRMzFkaGpnNVE2aC9KbGpJbnlLZWV6TjlmcFBxdEtCWEpkZWg1aGRIaDBv?=
 =?utf-8?B?QjQ1YlAyZXJVMkY3cjhPU1o1OTNtdThHZEtQS2VRam53QkNIVmF3RnJDd21K?=
 =?utf-8?B?WlQ4enN2NGhJL1BOY0s5OXRGcHE4alhadjhPRlN4c2NUSkJmNVphSHRPcmtz?=
 =?utf-8?B?Y3h0WEppRVFkNSt4TE5ILzJEU2hQVVpwdXhaNHFzVVJ3MlBjUjMrZmNuRElC?=
 =?utf-8?B?OVBYdWl3akNWTTJDcFJqSkg1by9sVk5Na1dpZ3B3NFdKaTNpbjczaVVLdFMy?=
 =?utf-8?B?aWpkVFc4VnVnNElRdTBSaStrODRlN1Nqa1VkZDF3Skc4NERZRlM5MzEwQ1Uv?=
 =?utf-8?B?bmNxejM2YkNQc1RWM3NiTC9sZElpclNYWE1BQkVHN1BHL0Rnd2tQb0FVRkxM?=
 =?utf-8?B?OHkxQ0ZWalNhYlRPVGhIT2p0WDRFeFM3WENOTFBucXBiUGVZZ2hCeWw0T05N?=
 =?utf-8?B?NWd3OUk4cjR5VmJ4MUlqRFJDYzNYdHpRL1N0WDlXTWE1dDVjeTZQWmRoYzhH?=
 =?utf-8?B?V01sZFF1dFB3c2MxbERpVlc0UGtDS0t5bnFGWS9xMU0yM3did1NIWHJFS0R1?=
 =?utf-8?Q?x2KXwR4PpDQiV7wRUUPFxu5Es?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fe4c1441-a744-4899-8ab8-08db78e84017
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 21:31:50.8087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BQ0NiP8GEgz36lpjgQnGZJNc4NdpTfMdHLx/R7hlwPRvUwB71iThn7doyRd36BO4uUjlrOYDJ14M/r4qL06Osw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8030
X-OriginatorOrg: intel.com



On 6/29/23 13:51, Geoff Levand wrote:
> It seems the text for the NTB MSI Test Client section was copied from the
> NTB Tool Test Client, but was not updated for the new section.  Corrects
> the NTB MSI Test Client section text.
> 
> Fixes: bec5545edef6 ("Merge tag 'ntb-5.3' of git://github.com/jonmason/ntb")

No need for fixes tag to be back ported with text corrections. Also, 
this is the wrong tag and not the original commit.

> Signed-off-by: Geoff Levand <geoff@infradead.org> for Sony Interactive Entertainment

Reviewed-by: Dave Jiang <dave.jiang@intel.com> with removal of fixes tag.

> ---
>   Documentation/driver-api/ntb.rst | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/driver-api/ntb.rst b/Documentation/driver-api/ntb.rst
> index 11577c2105c5..e991d92b8b1d 100644
> --- a/Documentation/driver-api/ntb.rst
> +++ b/Documentation/driver-api/ntb.rst
> @@ -207,9 +207,9 @@ The MSI test client serves to test and debug the MSI library which
>   allows for passing MSI interrupts across NTB memory windows. The
>   test client is interacted with through the debugfs filesystem:
>   
> -* *debugfs*/ntb\_tool/*hw*/
> +* *debugfs*/ntb\_msi\_test/*hw*/
>   	A directory in debugfs will be created for each
> -	NTB device probed by the tool.  This directory is shortened to *hw*
> +	NTB device probed by the msi test.  This directory is shortened to *hw*
>   	below.
>   * *hw*/port
>   	This file describes the local port number
