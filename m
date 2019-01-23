Return-Path: <dave.jiang@intel.com>
Received: from mga18.intel.com (mga18.intel.com. [134.134.136.126])
        by gmr-mx.google.com with ESMTPS id y133si6105536qka.3.2019.01.23.09.40.10
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 09:40:10 -0800 (PST)
Subject: Re: [PATCH] Missing functionality of ntb_peer_db_addr() API
References: <8e9bb3cc-b238-47e7-b206-ccaf673a8fb6@googlegroups.com>
 <56554767-0ed2-cda0-716b-c4050717a45a@deltatee.com>
From: Dave Jiang <dave.jiang@intel.com>
Message-ID: <608d408b-3150-455a-f7b7-df7838650a94@intel.com>
Date: Wed, 23 Jan 2019 10:40:08 -0700
MIME-Version: 1.0
In-Reply-To: <56554767-0ed2-cda0-716b-c4050717a45a@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Logan Gunthorpe <logang@deltatee.com>, lravich@gmail.com, linux-ntb <linux-ntb@googlegroups.com>, "Hubbe, Allen" <allenbh@gmail.com>
List-ID: <linux-ntb.googlegroups.com>



On 1/23/19 10:30 AM, Logan Gunthorpe wrote:
> 
> 
> On 2019-01-23 2:28 a.m., lravich@gmail.com wrote:
>>         .spad_count             = intel_ntb_spad_count,
>> diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c 
>> b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
>> index 5ee5f40..af01222 100644
>> --- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
>> +++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
>> @@ -707,7 +707,9 @@ static u64 switchtec_ntb_db_read_mask(struct ntb_dev 
>> *ntb)
>>  
>>  static int switchtec_ntb_peer_db_addr(struct ntb_dev *ntb,
>>                                       phys_addr_t *db_addr,
>> -                                     resource_size_t *db_size)
>> +                                     resource_size_t *db_size,
>> +                                     u64 *db_data,
>> +                                     int db_bit)
>>  {
> 
> 
> The semantics of this interface are not clear because there are no users
> in the kernel. But doesn't a correct implementation require you to set
> db_data here?

Cc Allen

Side comment. The only user of this function I am aware of is the out of
tree NTRDMA code.

> 
> Logan
> 
