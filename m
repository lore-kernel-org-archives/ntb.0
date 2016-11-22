Return-Path: <Shyam-sundar.S-k@amd.com>
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (mail-cys01nam02on0060.outbound.protection.outlook.com. [104.47.37.60])
        by gmr-mx.google.com with ESMTPS id c68si19146ith.1.2016.11.21.17.45.39
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Nov 2016 17:45:39 -0800 (PST)
Subject: Re: [PATCH] NTB: Register and offset values fix for memory window
References: <c44465a3-780b-3dbd-22dc-4be241009e3c@amd.com>
 <000001d23e84$5720d3a0$05627ae0$@emc.com>
 <ca26d2ef-f3ab-3713-eacb-cb2d05d61547@amd.com>
 <CAPoiz9xo8TJeLpS6Ft77CHhM=6Yi+ukSek7qfQTxBORnyZDupQ@mail.gmail.com>
From: Shyam Sundar S K <ssundark@amd.com>
Message-ID: <550c9e3a-c499-ecee-310f-1bd53f381650@amd.com>
Date: Tue, 22 Nov 2016 07:15:03 +0530
MIME-Version: 1.0
In-Reply-To: <CAPoiz9xo8TJeLpS6Ft77CHhM=6Yi+ukSek7qfQTxBORnyZDupQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-Path: ssundark@amd.com
To: Jon Mason <jdmason@kudzu.us>
Cc: Allen Hubbe <Allen.Hubbe@dell.com>, "Yu, Xiangliang" <Xiangliang.Yu@amd.com>, Dave Jiang <dave.jiang@intel.com>, linux-ntb@googlegroups.com, "Sen, Pankaj" <Pankaj.Sen@amd.com>, "Shah,
 Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>, "Agrawal,
 Nitesh-kumar" <Nitesh-kumar.Agrawal@amd.com>, "Subramaniyan, Ramkumar" <ramkumar.ks@amd.com>, Richard1.Su@amd.com
List-ID: <linux-ntb.googlegroups.com>



On 11/17/2016 9:09 PM, Jon Mason wrote:
> On Tue, Nov 15, 2016 at 2:04 AM, Shyam Sundar S K <ssundark@amd.com> wrote:
>>
>>
>> On 11/14/2016 8:05 PM, Allen Hubbe wrote:
>>> From: Shyam Sundar S K
>>>> Due to incorrect limit and translation register values, NTB link was
>>>> going down when the memory window translation was setup. Made appropriate
>>>> changes as per spec.
>>>>
>>>> Also, fixed the limit register values for BAR1, which was overlapping
>>>> with the BAR23 address.
>>>>
>>>> Reviewed-by: Sen, Pankaj <Pankaj.Sen@amd.com>
>>>> Reviewed-by: Shah, Nehal-bakulchandra <Nehal-bakulchandra.Shah@amd.com>
>>>> Acked-by: Xiangliang Yu <Xiangliang.Yu@amd.com>
>>>> Signed-off-by: S-k, Shyam-sundar <Shyam-sundar.S-k@amd.com>
>>>> ---
>>>
>>>> @@ -376,13 +371,11 @@ static u32 amd_ntb_spad_read(struct ntb_dev *ntb, int idx)
>>>>  {
>>>>      struct amd_ntb_dev *ndev = ntb_ndev(ntb);
>>>>      void __iomem *mmio = ndev->self_mmio;
>>>> -    u32 offset;
>>>>
>>>> -    if (idx < 0 || idx >= ndev->spad_count)
>>>> +    if (idx < 0 || idx >= (ndev->spad_count + 4))
>>>
>>> Why does this change add four to the upper end of the range check?  Does spad_count have the wrong number of spads?
>>>
>>>>              return 0;
>>>>
>>>> -    offset = ndev->self_spad + (idx << 2);
>>>> -    return readl(mmio + AMD_SPAD_OFFSET + offset);
>>>> +    return readl(mmio + AMD_SPAD_OFFSET + (idx << 2));
>>>
>>> The self_spad is used for sharing the spads of a single ntb.  It is the offset of the first or second half of the spads, and the peer self_spad is the other half.  From this change, can we assume that a single-ntb topology will not be supported?
>>>
>> This patch has more to with the NTB driver becoming functional on AMD platforms.
>> We were reading from the incorrect offsets than the one mentioned in the AMD NTB HW spec. So changed it accordingly.
> 
> I believe the point Alan was making was that if the SPAD count is +4,
> then perhaps the value in spad_count should be +4.  Are there 16 or 20
> SPADs?
> 

There are 16 SPAD in our case, if I don't add that hack here eth link does not become ready.

meaning, in ntb_transport: this never gets set "nt->link_is_up = true;" reason being ntb_spad_read(ndev, MW0_SZ_HIGH + (i * 2)); and ntb_spad_read(ndev, MW0_SZ_LOW + (i * 2));
so, calls to ntb_spad_read() will have idx more than the ndev->spad_count.

Any suggestions ?

Thanks,
Shyam

> 
>>
>> --
>> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
>> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
>> To post to this group, send email to linux-ntb@googlegroups.com.
>> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/ca26d2ef-f3ab-3713-eacb-cb2d05d61547%40amd.com.
>> For more options, visit https://groups.google.com/d/optout.
