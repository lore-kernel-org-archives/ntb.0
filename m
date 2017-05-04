Return-Path: <Gary.Hook@amd.com>
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (mail-by2nam01on0083.outbound.protection.outlook.com. [104.47.34.83])
        by gmr-mx.google.com with ESMTPS id q9si41649itc.1.2017.05.04.16.11.26
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 04 May 2017 16:11:26 -0700 (PDT)
Subject: Re: [PATCH V2 1/3] ntb: Add a module option to control affinity of
 DMA channels
References: <20170504201544.10113.13551.stgit@taos.amd.com>
 <20170504202114.10113.67981.stgit@taos.amd.com>
 <059845af-9724-271e-37b5-d518b5ca567a@intel.com>
 <87fd5f80-cf39-6928-fa82-2acf94a22259@amd.com>
 <3e79fa1f-c29b-0f8b-4a3d-9591d5a89a18@amd.com>
 <c209a641-040b-a216-23da-a34490a91f1d@intel.com>
From: Gary R Hook <ghook@amd.com>
Message-ID: <81fd88f1-4484-0537-c881-b70f76c18d58@amd.com>
Date: Thu, 4 May 2017 18:11:18 -0500
MIME-Version: 1.0
In-Reply-To: <c209a641-040b-a216-23da-a34490a91f1d@intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: ghook@amd.com
To: Dave Jiang <dave.jiang@intel.com>, Gary R Hook <gary.hook@amd.com>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On 05/04/2017 04:03 PM, Dave Jiang wrote:
>
<snip>

>>>>> @@ -781,7 +790,10 @@ static int perf_probe(struct ntb_client *client,
>>>>> struct ntb_dev *ntb)
>>>>>
>>>>>      node = dev_to_node(&pdev->dev);
>>>>>
>>>>> -    perf = kzalloc_node(sizeof(*perf), GFP_KERNEL, node);
>>>>> +    if (on_node)
>>>>> +        perf = kzalloc_node(sizeof(*perf), GFP_KERNEL, node);
>>>>> +    else
>>>>> +        perf = kzalloc(sizeof(*perf), GFP_KERNEL);
>>>>
>>>> Is this necessary when NUMA_NO_NODE is passed in?
>>>
>>> Excellent question. I traced kzalloc_node down to slab_alloc_node(), and
>>> it does
>>> indeed check (parameter) nodeid against NUMA_NO_NODE. So that would be
>>> an option
>>> for the node variable above.
>>>
>>> However, since the code above, as written, doesn't allow for
>>> NUMA_NO_NODE, some
>>> additional work will be required to properly handle the option. Look for
>>> a V3 of
>>> this series.
>>
>> Actually, I think this engenders some further consideration. The buffer
>> allocation code around line 390 also wants to be node-aware. Would it
>> make sense to have a switch the completely ignores any NUMA concerns for
>> threads and memory? A switch for threads, and a switch for memory? There
>> are a number of combinations that may be of interest here, but I'm not
>> sure how far I want to/should go at this point. Maybe just a single
>> comprehensive switch to turn node-sensitivity on/off (i.e. have on_node
>> cover all the bases)?
>
> That's probably ok if we want to just ignore all NUMA awareness for
> testing.
>

Which is where I was going, initially. I'll keep with that. Anything more
complex can probably wait for an actual need.

Thanks!

-- 
This is my day job. Follow me at:
IG/Twitter/Facebook: @grhookphoto
IG/Twitter/Facebook: @grhphotographer
