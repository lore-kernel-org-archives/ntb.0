Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E05810A1F
	for <ntb@lists.linux.dev>; Tue, 16 Jan 2024 07:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="K43hqWtp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oc92As44mOuGN1onh9Rv097AK6/pclZ0K+0OUrmQ+QFTJeAoikBJYixlKRAgGwcx+hKFue7FoJsKZcGxxKeaA4YHb9iPLoeFleXwIld2hMaH3jzK19UXIhLH9hUIcPwmm85vwElSslUa94QHAT0VfFIGrYbCOMDbPwJUZ/t6hMMxUOI9lVK1l3aaYzKp/KHy2gzXCrkQ+DrbcVj2TG2W6qUldJATUNtxH/4z9GXy7O2awJo3jfxuW4ToM2FTsOz6RXqRXgnzrBNZdb58TkCqMSR5QeV04urmHiMkmqgJl+M5brhNxO/qZAOUnluDDAafLKzfXw14lMQBUeQF0AoUWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PUx25JFJcyQTUSpjp8G223qvJVV8ur+xxoSGb9ajJ6E=;
 b=dvPPcft4huSgAXa6oo2fATZMYZ3E90oZXUzO95T+I9vXOZsaSKco/t1zAVtY/1SNTaAVYqBQ5AAozxKpKQSGCqx43pK4IiMMKxYNNPW4S825qdcfobT5vkvxcIVQb/HZBKnzqcenJ5sxB1nOECLGWZ85KXTwxRLBl2wRm/+WiUCJR3CQ3PzsIcQEXdifeJPjkGTOPNudgeti4xg1hMSuuo4EQ+Q+GzWoV/BYfAQPB3rwDsySA9e9X5UthjDdHiu5n358Z3IbsfalLc05PcBnDiVfNGtwNZKIGYx8LmPkP4KzQsQn9MUSpYZdvN2BLY930Nz8XdeMQDKw0TIL0OkfCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PUx25JFJcyQTUSpjp8G223qvJVV8ur+xxoSGb9ajJ6E=;
 b=K43hqWtpqrA026ya4f813neT8ZorVCZusZaCV1igjP7R7rW9iudMl/4wAJaPsvqTrKq2FjEmshVj05Nu/daBiWsJ4tGh+e8Dj+gMPNih9WrXKZuCgmuiveaX6ZQHHg7bAY8+IRx3y+/YsBn/16WXq6Z3XGZnmkDdkZ0VUYv/32s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6395.namprd12.prod.outlook.com (2603:10b6:510:1fd::14)
 by SA1PR12MB7320.namprd12.prod.outlook.com (2603:10b6:806:2b7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.30; Tue, 16 Jan
 2024 07:11:03 +0000
Received: from PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::8f61:7cb3:f051:f790]) by PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::8f61:7cb3:f051:f790%7]) with mapi id 15.20.7181.022; Tue, 16 Jan 2024
 07:11:03 +0000
Message-ID: <7739c789-109b-2aa7-73d2-db833853470c@amd.com>
Date: Tue, 16 Jan 2024 12:40:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To: jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
 ntb@lists.linux.dev
Cc: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
From: Raju Rangoju <Raju.Rangoju@amd.com>
Subject: ntb_perf max chunk order
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2P287CA0010.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::16) To PH7PR12MB6395.namprd12.prod.outlook.com
 (2603:10b6:510:1fd::14)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6395:EE_|SA1PR12MB7320:EE_
X-MS-Office365-Filtering-Correlation-Id: 26d754cb-4147-489a-2750-08dc16624ca0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	erIShVXKNbuif0VBBEU8Qa2+ozbAUajetnUUNxXIS5op/IKwcCPjPOcbExIj/i2xdUWfwQQQNKUqIpldAEoKm6hxLzHu6x7ZVDEz9fL94iPLRdt/uzzV7ooaAM9bUZCbSjG7j5NYdrkuqF5dQbUD2oYfqtuGlZBuGQyTJHK2z9W7A95Zl9kyANSICKB1NAsBOy0aDGhEAR2t/uaGMFzjxejn0tVrxQ//Stz2n98E1ZIJ4yH6VodBhB/5WFjtID32gHrEkfG5uieBy7M4ldXO0UOa7AXKmBK5G2DBrCJQQ4jOs8yecSIcgE0hM6W4bHA4KzhtbLhxEiMEk4Slw3k0Vu4Mryop6iWRVr/AONxUuiKC1RjnbWAr6rU/tLokxyxGtVFgbgRp2Di1K71Ws/RFJ58efY+6jbw2UPjcZDafndnHC4JPBPIKCw1sHv54ISc5Ok4H37ZO8xchpkhHhB60kasPdYIxVRsseWBicuV5oa4qcO+N3Dd4qJXEzB4Vwee3Al63+DPdnX32H4Pieg60Txt+dqhrF4XDpOJM1sZxgXebtXu5d2897sw9z25D78RoL3cifcPl9dZuKFl9mRmb+x3len8L60hbuyc3CejILAIFOEAtQ4ebTXvDQU/aMvl+WZ1vyB1mO4B7oi1TE6K1XQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6395.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(366004)(39860400002)(396003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(26005)(2616005)(6666004)(6506007)(6512007)(478600001)(83380400001)(5660300002)(2906002)(4326008)(41300700001)(6486002)(8676002)(8936002)(66476007)(66556008)(66946007)(316002)(558084003)(36756003)(86362001)(31696002)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ek1NbHh1RDkxVFAzNm92eFlKaUpCNngrWXVXSDRSVkdZbCtnVTAycFFXM3p5?=
 =?utf-8?B?K1RicFJpUjY5Y2JZSzVIblNFQjJBODh0RTgyRTJMWU1MaFFjMXNjMUdzckJX?=
 =?utf-8?B?ZHhHTVhaQkVtenNsRzFKblJzb3BDYzNhanB5TnJabnVLYlZ6K1h3UEI0Q0cw?=
 =?utf-8?B?MkYwTk1FekNiYkM3ZGRqaEdIeEwzQW53RXliVVJLWjAwWG51VVU0cGF4b1lC?=
 =?utf-8?B?S2FNdFh1T2xXcTRTdEVQa2ZUaTdZUnlQVWFWcVBSL0Fxc2lJT1dUaVo4MytQ?=
 =?utf-8?B?dERoMXVhNlpSSDh0WWVjeEF5dHNZcWJ5T011clVkUGg2ZVl2WWxNcnpHTk9T?=
 =?utf-8?B?RFVpc2NxSHZXMkJKMmFRNHBXL29uWUFwM3ZSdG8rYVQvSjlkM1lGQWZxUy9z?=
 =?utf-8?B?TnNHZDBNb1VXbjkyNTh2czZyN3VsQWJWVXNKb0JLc3Bta1VncFJrWjh4NDgr?=
 =?utf-8?B?c0tsc2kxdjBnamJ1WGt5UWJtOXJFOXhMU2dhQkJFbkxVekJ2Y2JHTkNhekNn?=
 =?utf-8?B?ZDhpWGptcENOVmNvQWs3RnE5T0lXNG9aTUxQZ2dXWWphSms5Wm9MWEdpa0hq?=
 =?utf-8?B?ejdGWVRmK2pJTFdQS2N5NS9oTVhxenExSUdRdHpRUGtrdjdFNTNJSkF0QWgv?=
 =?utf-8?B?Q2NtUE5GZFJOS3BIbDRQT2pxREhUSTJSeU92M3Zwb0JSY3ZNdXpWdUtMUTNF?=
 =?utf-8?B?TnJMdUU1Vy9WdlRMWUsvWWZoNUJsZkU5V0pQZnZUaHFBdGlRNzhPQytlblgr?=
 =?utf-8?B?T2J4SHBicEN6WTlzYzRGTyt6dW12ZlBRbVlmTkp6cUs4QUpxamh0dTJaa3BX?=
 =?utf-8?B?OXdTWS9hMTdFem91aDlzc0s0UkxHTExZU3E0S0t5cS9iZFB0dVpSVlp3Y0RE?=
 =?utf-8?B?NThMbUhraWJ4bGZaaVRBSGFpVEJ5MXhEU1Z3NzNTSTJaNFZtb3QzTHZqeks0?=
 =?utf-8?B?WjkzbHhSbjJlc21TSklsRitxRk5ZYk1ucHZqbUNGVDc1UmFhdzhOUHlwdSt3?=
 =?utf-8?B?cDUzVTVBbG1Da0t2NXAza29ueCtaRC9ReFlGZk5CK0UwcWtEY1NITXYwUU9W?=
 =?utf-8?B?bStvL2dxZVFuRFBFZ3BzOGxqTVc2a25JL3Z2LzgvUUxQQkVLS3FmQ1FDZERr?=
 =?utf-8?B?MlFsamJBSnVZczhpQktDOExsMC9SblJ6VWk3a2ZEZFlvbW1pamErVGFNdUhh?=
 =?utf-8?B?N1lTMUphU3U0bzVhWk0xUk9XV3NybzVZdkE2QytYUm1hejBUd1pjb2E4cGZU?=
 =?utf-8?B?WUJUOExpN3JiS2NMTDYxRXlKSU1XYkd3WGtwRHpIR2p3Tm1Jc1BGMElmUmZs?=
 =?utf-8?B?V1RwK1dSK0tFSDRFRENUby9qVW9UNmtVYXZWcThzM0ttTm03ZkloZU9TdGcr?=
 =?utf-8?B?ZWl0c0FDQzR3MGY4czNGeHV4Wm8vS0F3QkZTL1JlbWRDeFpxamJmdGNNWkxR?=
 =?utf-8?B?aFJ1YzhselRYNWpCS3ptaE84UCtOdUJGcDVvYUNKRUxTK2NuK08rWDY2NCtZ?=
 =?utf-8?B?Ry9nalRweVZ1SkJIY1EyT1lyL1JWSTcrVlZRWEloVk1WTnFCM2F1Z3hBK3RQ?=
 =?utf-8?B?NlRzR2hQaHBVdzBJMm53akErQkZlcGI0WXB2UGR4cmxYVVJJeWplVkNFVWM5?=
 =?utf-8?B?RFZsYy9ZMXhoZkFYM0VoNnpoOFppZ0FkSCs1Sk9JYmdFdDJtLzRpLzF3aUM3?=
 =?utf-8?B?S1JiTE1YWm5EMVdmaTMzTG56Qm8wVmc5WlE0dlQ3OEc4M0QvNWtPMFpreWx0?=
 =?utf-8?B?NitBTUhTYkVPbHFKeGRSbE9VWE1kMjdLNHNHWVZOWGVZQmZmM3B2eGkrL052?=
 =?utf-8?B?emtnbHl3THBkZ2NJdzRoVzhEZ3NpN2ZaMGZUb096TFBDUDMxbUVvMSsybzFn?=
 =?utf-8?B?Slp0NjI3OXZGZWpPL0pvUHUxUStzcXEveE5MSmphSHlXODcyWEFJc0NXRGJx?=
 =?utf-8?B?V0xmV2lZRHRoaGlnTVpyalBtNFI0czc5cDJyTWhyOHM5eVNjRnVIMVV3NmZv?=
 =?utf-8?B?Mit5YzdTcUJBSnN0TDBZeDRzRmFZZlFuSUVocUdVQzJ6QzFRWExCYUlreHJO?=
 =?utf-8?B?MUNyTnVlWEsrclJaK1JaQkVQMmlOSXBHQmVJS0ZOTDF6dGRUUmRYeStOWCtB?=
 =?utf-8?Q?r3wuA+O0FHfm2DD98oKTQ4G9f?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26d754cb-4147-489a-2750-08dc16624ca0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6395.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 07:11:03.1776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /veT0cK7KeuP2RUCccEvnBKFvlFuoxOTPDF+dRXYSXWhilduey/w5quu3IQMr6lR9ZS8qqOoaToE50OOSLyt+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7320

Hi,

Could you please explain why net_perf does not support larger chunk 
sizes? Currently only  MAX_CHUNK_ORDER 20 is supported (1M and below)

Thanks,
Raju
